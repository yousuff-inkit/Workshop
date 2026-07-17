package com.operations.saleofvehicle.vehicledisposal;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.common.ClsNumberToWord;
import com.common.ClsAmountToWords;
import com.connection.ClsConnection;

public class ClsVehicleDisposalDAO {
ClsVehicleDisposalBean disposalbean=new ClsVehicleDisposalBean();
ClsCommon objcommon=new ClsCommon();
ClsConnection objconn=new ClsConnection();

public   JSONArray fleetSearch(String branch) throws SQLException {
    Connection conn =null;
    JSONArray RESULTDATA=new JSONArray();
	try {
		conn=objconn.getMyConnection();
		
		Statement stmtmovement = conn.createStatement();
        	String strSql="select veh.fleet_no,veh.flname,veh.reg_no,plate.code_name platecode,veh.ch_no chassisno  from gl_vehmaster veh left join gl_vehplate plate on veh.pltid=plate.doc_no where tran_code='FS' and statu<>7 and fleet_no not in"+
        			"(select fleetno from gl_vsaled where salestatus=1)";
//        	System.out.println(strSql);
			ResultSet resultSet = stmtmovement.executeQuery (strSql);
			RESULTDATA=objcommon.convertToJSON(resultSet);
			stmtmovement.close();
			conn.close();
	}
	catch(Exception e){
		e.printStackTrace();
		conn.close();
	}
	finally{
		conn.close();
	}
//	System.out.println("RESULTDATA=========>"+RESULTDATA);
    return RESULTDATA;
}
public   JSONArray getSearchData(String docno,String date,String client,String cmbtype,String acno,String mobile,String branch) throws SQLException {
    Connection conn = null;
    JSONArray RESULTDATA=new JSONArray();
	try {
		conn=objconn.getMyConnection();
		java.sql.Date sqldate=null;
		String sqltest="";
		if(!(date.equalsIgnoreCase(""))){
			sqldate=objcommon.changeStringtoSqlDate(date);
		}
		if(!(docno.equalsIgnoreCase(""))){
			sqltest=sqltest+" and sale.doc_no like '%"+docno+"%'";
		}
		if(!(cmbtype.equalsIgnoreCase(""))){
			sqltest=sqltest+" and sale.type='"+cmbtype+"'";
		}
		if(!(acno.equalsIgnoreCase(""))){
			sqltest=sqltest+" and sale.acno like '%"+acno+"%'";
		}
		if(sqldate!=null){
			sqltest=sqltest+" and sale.date='"+sqldate+"'";
			
		}
		if(!(client.equalsIgnoreCase(""))){
			sqltest=sqltest+" and ac.refname like '%"+client+"%'";
		}
		if(!(mobile.equalsIgnoreCase(""))){
			sqltest=sqltest+" and ac.per_mob like '%"+mobile+"%'";
		}
		
			Statement stmtmovement = conn.createStatement();
			if(!(branch.equalsIgnoreCase("0"))){
        	String strSql="select sale.doc_no,sale.voc_no,sale.date,sale.acno,if(sale.type='S','Sale','Total Loss') typename,sale.type,sale.description,sale.trno,ac.refname,ac.address,ac.per_mob,ac.mail1,sale.cldocno,sale.brhid from gl_vsalem sale left join"+
	        				" my_head head on sale.acno=head.doc_no left join my_acbook ac on (sale.cldocno=ac.cldocno and ac.dtype='CRM') where sale.status<>7 and sale.brhid='"+branch+"'"+sqltest;
        	//System.out.println(strSql);
			ResultSet resultSet = stmtmovement.executeQuery (strSql);
			RESULTDATA=objcommon.convertToJSON(resultSet);
			
			stmtmovement.close();
			conn.close();
			return RESULTDATA;
			}
	}
	catch(Exception e){
		e.printStackTrace();
		conn.close();
	}
	finally{
		conn.close();
	}
//	System.out.println("RESULTDATA=========>"+RESULTDATA);
    return RESULTDATA;
}

public   JSONArray clientSearch(String searchdate,String name,String docno,String acno,String mobile) throws SQLException {
    Connection conn = null;
    JSONArray RESULTDATA=new JSONArray();
	try {
		conn=objconn.getMyConnection();
		java.sql.Date sqldate=null;
		String sqltest="";
		if(!(searchdate.equalsIgnoreCase(""))){
			sqldate=objcommon.changeStringtoSqlDate(searchdate);
		}
		if(!(docno.equalsIgnoreCase("") || docno.equalsIgnoreCase("0"))){
			sqltest=sqltest+" and cldocno like '%"+docno+"%'";
		}
		if(sqldate!=null){
			sqltest=sqltest+" and date='"+sqldate+"'";
			
		}
		if(!(name.equalsIgnoreCase("") || name.equalsIgnoreCase("0"))){
			sqltest=sqltest+" and refname like '%"+name+"%'";
		}
		if(!(acno.equalsIgnoreCase("") || acno.equalsIgnoreCase("0"))){
			sqltest=sqltest+" and acno like '%"+acno+"%'";
		}
		if(!(mobile.equalsIgnoreCase("") || mobile.equalsIgnoreCase("0"))){
			sqltest=sqltest+" and per_mob like '%"+mobile+"%'";
		}
			Statement stmtmovement = conn.createStatement();
        	String strSql="select cldocno,refname,address,per_mob,acno,mail1 from my_acbook where dtype='CRM' and status<>7"+sqltest;
//        	System.out.println(strSql);
			ResultSet resultSet = stmtmovement.executeQuery (strSql);
			RESULTDATA=objcommon.convertToJSON(resultSet);
			stmtmovement.close();
			conn.close();
	}
	catch(Exception e){
		e.printStackTrace();
		conn.close();
	}
	finally{
		conn.close();
	}
//	System.out.println("RESULTDATA=========>"+RESULTDATA);
    return RESULTDATA;
}



	public ClsVehicleDisposalBean insert(Date sqlStartDate,  String cmbtype,
			String description, HttpSession session, String mode,ArrayList<String> disposalarray,
			String formdetailcode,String clientacno,String client,String days,String branch,HttpServletRequest request,String mdoc) throws SQLException {
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			int docno1=0,trno=0,vocno=0;
//			System.out.println("Inside Dao");
			conn.setAutoCommit(false);	
			CallableStatement stmtDisposal = conn.prepareCall("{call disposalmDML(?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmtDisposal.registerOutParameter(7, java.sql.Types.INTEGER);
			stmtDisposal.registerOutParameter(8, java.sql.Types.INTEGER);
			stmtDisposal.registerOutParameter(12, java.sql.Types.INTEGER);
			stmtDisposal.setDate(1,sqlStartDate);
			stmtDisposal.setString(2,clientacno);
			stmtDisposal.setString(3, cmbtype);
			stmtDisposal.setString(4, description);
			stmtDisposal.setString(5,session.getAttribute("USERID").toString());
			stmtDisposal.setString(6,branch);
			stmtDisposal.setString(9,mode);
			stmtDisposal.setString(10,formdetailcode);
			stmtDisposal.setString(11,client);
			stmtDisposal.executeQuery();
			docno1=stmtDisposal.getInt("docNo");
			trno=stmtDisposal.getInt("trNo1");
			vocno=stmtDisposal.getInt("vocno");
			request.setAttribute("VOCNO", vocno);
//			System.out.println("Docno:"+docno1+"/////Trno:"+trno+"/////Vocno:"+vocno);
			if (docno1 > 0) {
				disposalbean.setTrno(trno);
//				System.out.println("no====="+docno1);
				disposalbean.setDocno(docno1);
//				System.out.println("Success"+disposalbean.getDocno());
//				System.out.println("Action Arrray length"+disposalarray.size());
				int j=insertdet(disposalarray,docno1,trno,conn,sqlStartDate,clientacno,mode,formdetailcode,session,client,days,branch);
				
					if(j>0){
						conn.commit();
						Statement stmt=conn.createStatement();
						
						stmtDisposal.close();
						conn.close();
						return disposalbean;
					}
					else{
						disposalbean.setDocno(0);
						stmtDisposal.close();
						conn.close();
						return disposalbean;
					}
						
					}
			stmtDisposal.close();
				conn.close();
				
			
		
		}catch(Exception e){	
		e.printStackTrace();	
		conn.close();
		}
		finally{
			conn.close();
		}
		return disposalbean;

}
	private  int insertdet(ArrayList<String> disposalarray,int docno,int trno,Connection conn,Date sqlStartDate,String clientacno,String mode,
			String formdetailcode,HttpSession session,String client,String days,String branch) throws SQLException {
		
		try {
//			System.out.println("Inside Insert Details");
			Statement stmtDisposal;
			int val=0;
			stmtDisposal = conn.createStatement ();
//			System.out.println(disposalarray.size());
			for(int i=0;i< disposalarray.size();i++){
				String[] disposal=disposalarray.get(i).split("::");
//				System.out.println("Here");
				String sql="insert into gl_vsaled(trno,rdocno,sr_no,fleetno,salesprice,dep_posted,pvalue,acdep,curdep,netval,salestatus,netbook)values('"+trno+"','"+docno+"','"+(i+1)+"',"+
				"'"+(disposal[0].equalsIgnoreCase("undefined") || disposal[0].isEmpty()?0:disposal[0])+"','"+(disposal[2].equalsIgnoreCase("undefined") || disposal[2].isEmpty()?0:disposal[2])+"',"+
				"'"+objcommon.changetstmptoSqlDate((disposal[3].equalsIgnoreCase("undefined") || disposal[3].isEmpty()?0:disposal[3]).toString())+"','"+(disposal[4].equalsIgnoreCase("undefined") || disposal[4].isEmpty()?0:disposal[4])+"',"+
				"'"+(disposal[5].equalsIgnoreCase("undefined") || disposal[5].isEmpty()?0:disposal[5])+"','"+(disposal[6].equalsIgnoreCase("undefined") || disposal[6].isEmpty()?0:disposal[6])+"',"+
				"'"+(disposal[7].equalsIgnoreCase("undefined") || disposal[7].isEmpty()?0:disposal[7])+"',1,'"+(disposal[8].equalsIgnoreCase("undefined") || disposal[8].isEmpty()?0:disposal[8])+"')";
				String strupdateveh="update gl_vehmaster set fstatus='Z' where fleet_no="+(disposal[0].equalsIgnoreCase("undefined") || disposal[0].isEmpty()?0:disposal[0]);
				Statement stmtvehupdate=conn.createStatement();					
				//System.out.println("Sql"+sql);
				 val = stmtDisposal.executeUpdate (sql);
				if(val<0){
					conn.close();
					return 0;
				}
				if(val>0){
					int updateval=stmtvehupdate.executeUpdate(strupdateveh);
					if(updateval>0){
						CallableStatement stmtDisposalJv = conn.prepareCall("{call disposalJvDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
						
						stmtDisposalJv.setString(1,(disposal[0].equalsIgnoreCase("undefined") || disposal[0].isEmpty()?0:disposal[0]).toString());
						stmtDisposalJv.setDate(2,sqlStartDate);
						stmtDisposalJv.setDate(3,objcommon.changetstmptoSqlDate((disposal[3].equalsIgnoreCase("undefined") || disposal[3].isEmpty()?0:disposal[3]).toString()));
						stmtDisposalJv.setString(4, (disposal[4].equalsIgnoreCase("undefined") || disposal[4].isEmpty()?0:disposal[4]).toString());
						stmtDisposalJv.setString(5,(disposal[5].equalsIgnoreCase("undefined") || disposal[5].isEmpty()?0:disposal[5]).toString());
						stmtDisposalJv.setString(6,(disposal[6].equalsIgnoreCase("undefined") || disposal[6].isEmpty()?0:disposal[6]).toString());
						stmtDisposalJv.setString(7,(disposal[2].equalsIgnoreCase("undefined") || disposal[2].isEmpty()?0:disposal[2]).toString());
						stmtDisposalJv.setString(8,(disposal[7].equalsIgnoreCase("undefined") || disposal[7].isEmpty()?0:disposal[7]).toString());
						stmtDisposalJv.setString(9,clientacno);
						stmtDisposalJv.setString(10,mode);
						stmtDisposalJv.setString(11,formdetailcode);
						stmtDisposalJv.setString(12,session.getAttribute("USERID").toString());
						stmtDisposalJv.setString(13,branch);
						stmtDisposalJv.setString(14,session.getAttribute("CURRENCYID").toString());
						stmtDisposalJv.setString(15,client);
						stmtDisposalJv.setInt(16,docno);
						stmtDisposalJv.setInt(17,trno);
						stmtDisposalJv.setString(18,null);
						stmtDisposalJv.setString(19,(disposal[8].equalsIgnoreCase("undefined") || disposal[8].isEmpty()?0:disposal[8]).toString());
//						System.out.println("Statement:"+stmtDisposalJv);
						int jvval=stmtDisposalJv.executeUpdate();
//						System.out.println("JV value"+jvval);
						if(jvval<0){
							stmtvehupdate.close();
							stmtDisposalJv.close();
							conn.close();
							return 0;
						}
					}
					else{

						stmtvehupdate.close();
						conn.close();
						return 0;
					}
				}
				
			}
			return val;
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		
		return 0;
		// TODO Auto-generated method stub
		
	}
	public boolean edit(Date sqlStartDate, String cmbtype,
			String description, HttpSession session, String mode, int docno,int trno,ArrayList<String> disposalarray,String formdetailcode,String clientacno,String client,String branch) throws SQLException {
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			conn.setAutoCommit(false);
//			System.out.println("ssssssss="+session.getAttribute("BRANCHNAME"));
			CallableStatement stmtDisposal = conn.prepareCall("{call disposalmDML(?,?,?,?,?,?,?,?,?,?,?,?)}");
//			System.out.println("checking");
//			System.out.println("{call vehbrandinsert(AA,"+brand+","+(Date)date_brand +")}");
//			CALL vehPlateCodeinsert( 'aaa','Demo','2014-10-20','dubai','fire 7 llc',1,@docNo);
			stmtDisposal.setInt(7,docno);
			stmtDisposal.setInt(8, trno);
			stmtDisposal.setInt(12, 0);
			stmtDisposal.setDate(1,sqlStartDate);
			stmtDisposal.setString(2,clientacno);
			stmtDisposal.setString(3, cmbtype);
			stmtDisposal.setString(4, description);
			stmtDisposal.setString(5,session.getAttribute("USERID").toString());
			stmtDisposal.setString(6,branch);
			stmtDisposal.setString(9,mode);
			stmtDisposal.setString(10,formdetailcode);
			stmtDisposal.setString(11,client);
			int aa = stmtDisposal.executeUpdate();
			
//			System.out.println("inside DAO1");
			if (aa>0) {
//				System.out.println("Success");
				Statement stmtDisp= conn.createStatement ();
				int i=stmtDisp.executeUpdate("delete from gl_vsaled where rdocno='"+docno+"' and trno='"+trno+"'");
				if(i>0){
					int j=insertdet(disposalarray, docno, trno, conn,sqlStartDate,clientacno,mode,formdetailcode,session,client,null,branch);
					if(j<=0){
						return false;
					}
				}
				conn.commit();
				stmtDisposal.close();
				conn.close();
				return true;
			}
			stmtDisposal.close();
			conn.close();
		}catch(Exception e){
		e.printStackTrace();	
		conn.close();
		}
		finally{
			conn.close();
		}
		
		return false;
	}
	public boolean delete(Date sqlStartDate, String cmbtype,
			String description, HttpSession session, String mode, int docno,int trno,String formdetailcode,String clientacno,String branch) throws SQLException {
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
//			System.out.println("ssssssss="+session.getAttribute("BRANCHNAME"));
			CallableStatement stmtDisposal = conn.prepareCall("{call disposalmDML(?,?,?,?,?,?,?,?,?,?,?)}");
//			System.out.println("checking");
//			System.out.println("{call vehbrandinsert(AA,"+brand+","+(Date)date_brand +")}");
//			CALL vehPlateCodeinsert( 'aaa','Demo','2014-10-20','dubai','fire 7 llc',1,@docNo);
			stmtDisposal.setInt(7,docno);
			stmtDisposal.setInt(8, trno);
			stmtDisposal.setInt(12, 0);
			stmtDisposal.setDate(1,sqlStartDate);
			stmtDisposal.setString(2,clientacno);
			stmtDisposal.setString(3, cmbtype);
			stmtDisposal.setString(4, description);
			stmtDisposal.setString(5,branch);
			stmtDisposal.setString(6,session.getAttribute("USERID").toString());
			stmtDisposal.setString(9,mode);
			stmtDisposal.setString(10,formdetailcode);
			stmtDisposal.setString(11,null);
			int aa = stmtDisposal.executeUpdate();
			
//			System.out.println("inside DAO1");
			if (aa>0) {
//				System.out.println("Success");
				return true;
			}
			stmtDisposal.close();
			conn.close();
		}catch(Exception e){
		e.printStackTrace();	
		conn.close();
		}
		finally{
			conn.close();
		}
		return false;
	}
	public   JSONArray disposalSearch(String branch) throws SQLException {
	    List<ClsVehicleDisposalBean> movementbean = new ArrayList<ClsVehicleDisposalBean>();
	  
	    JSONArray RESULTDATA=new JSONArray();
	    Connection conn =null;
		try {
				conn=objconn.getMyConnection();
				Statement stmtmovement = conn.createStatement ();
	        	String strSql="select sale.doc_no,sale.voc_no,sale.date,sale.acno,sale.type,sale.description,sale.trno,head.description accname from gl_vsalem sale left join"+
	        				" my_head head on sale.acno=head.doc_no where sale.status<>7 and sale.brhid='"+branch+"'";
//	        	System.out.println(strSql);
				ResultSet resultSet = stmtmovement.executeQuery (strSql);
				RESULTDATA=objcommon.convertToJSON(resultSet);
				stmtmovement.close();
				conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
//		System.out.println("RESULTDATA=========>"+RESULTDATA);
	    return RESULTDATA;
	}
	public   JSONArray disposalgridSearch(String branch,String docno) throws SQLException {
	    Connection conn =null;
	    JSONArray RESULTDATA=new JSONArray();
		try {
				conn=objconn.getMyConnection();
				Statement stmtmovement = conn.createStatement ();
				if(!(branch.equalsIgnoreCase(""))){
	        	String strSql="select saled.sr_no,saled.fleetno fleet_no ,saled.salesprice,saled.dep_posted,saled.pvalue pur_value,saled.acdep acc_dep,saled.curdep cur_dep,saled.netbook,saled.netval net_pl,veh.flname,veh.reg_no "+
	        			" from gl_vsaled saled left join gl_vehmaster veh on saled.fleetno=veh.fleet_no left join gl_vsalem sale on saled.rdocno=sale.doc_no"+
	        			" where saled.rdocno='"+docno+"' and sale.brhid="+branch;
//	        	System.out.println(strSql);
				ResultSet resultSet = stmtmovement.executeQuery (strSql);
				RESULTDATA=objcommon.convertToJSON(resultSet);
				}
				stmtmovement.close();
				conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
//		System.out.println("RESULTDATA=========>"+RESULTDATA);
	    return RESULTDATA;
	}
	
	
	
	public   JSONArray getTabularData(String fromdate,String todate) throws SQLException {
	    Connection conn =null;
	    JSONArray RESULTDATA=new JSONArray();
		try {
				conn=objconn.getMyConnection();
				Statement stmtmovement = conn.createStatement ();
				java.sql.Date sqlfromdate=null,sqltodate=null;
				if(!(fromdate.equalsIgnoreCase(""))){
					sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
				}
				if(!(todate.equalsIgnoreCase(""))){
					sqltodate=objcommon.changeStringtoSqlDate(todate);
				}
	        	String strSql="select aa.fleet_no,aa.flname,aa.reg_no,aa.code_name plate,(aa.asset_opn-aa.asset_add-aa.asset_del)asset_total,aa.prch_dte purdate,"+
	        			" sum(aa.asset_opn)asset_opn,sum(aa.asset_add)asset_add,sum(aa.asset_del)asset_del from("+
	        			" select asset.fleet_no,veh.flname,veh.reg_no,plate.code_name,veh.prch_dte,if(asset.date<'"+sqlfromdate+"',asset.dramount,'') as asset_opn,"+
	        			" if(asset.date>'"+sqlfromdate+"' and asset.date<'"+sqltodate+"',asset.dramount,'') as asset_add,if(asset.date>'"+sqltodate+"',asset.dramount,'') "+
	        			" as asset_del from gc_assettran asset left join gl_vehmaster veh on asset.fleet_no=veh.fleet_no left join gl_vehplate plate on"+
	        			" veh.pltid=plate.doc_no)aa group by fleet_no";
//	        	System.out.println(strSql);
				ResultSet resultSet = stmtmovement.executeQuery (strSql);
				RESULTDATA=objcommon.convertToJSON(resultSet);
				
				stmtmovement.close();
				conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
//		System.out.println("RESULTDATA=========>"+RESULTDATA);
	    return RESULTDATA;
	}

	
	public JSONArray getJvData(String trno,String id) throws SQLException {
	    
	    JSONArray RESULTDATA=new JSONArray();
	    if(!id.equalsIgnoreCase("1")){
	    	return RESULTDATA;
	    }
	    Connection conn =null;
	    try {
				conn=objconn.getMyConnection();
				Statement stmtjv=conn.createStatement ();
//				System.out.println("Jvreload");
	        	String strSql="select if(j.dramount>0,round(j.dramount*j.id,2),0)debit ,if(j.dramount<0,round(j.dramount*j.id,2),0) credit,"+
	        			" round(j.ldramount*j.id,2) baseamt,j.description desc1,h.account acno,	h.description acname,h.atype type from my_jvtran j left join my_head h on"+
	        			" j.acno=h.doc_no left join my_curr cr on cr.doc_no=j.curId where j.tr_no="+trno;
//	        	System.out.println(strSql);
				ResultSet resultSet = stmtjv.executeQuery (strSql);
				RESULTDATA=objcommon.convertToJSON(resultSet);
				stmtjv.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
	    return RESULTDATA;
	}
	
	public JSONArray getTempJvData(String mdoc,String id) throws SQLException {

	    JSONArray RESULTDATA=new JSONArray();
	    if(!id.equalsIgnoreCase("2")){
	    	return RESULTDATA;
	    }
	    Connection conn=null;
		try {
				conn=objconn.getMyConnection();
				Statement stmtjv=conn.createStatement ();
	        	String strSql="select if(j.dramount>0,round(j.dramount*j.id,2),0)debit ,if(j.dramount<0,round(j.dramount*j.id,2),0) credit,"+
	        			" round(j.ldramount*j.id,2) baseamt,j.desc1,h.account acno,	h.description acname,h.atype type from gl_vsaletempjv j left join my_head h on"+
	        			" j.acno=h.doc_no left join my_curr cr on cr.doc_no=j.curId where j.mdoc="+mdoc;
//	        	System.out.println(strSql);
				ResultSet resultSet = stmtjv.executeQuery(strSql);
				RESULTDATA=objcommon.convertToJSON(resultSet);
				stmtjv.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
	    return RESULTDATA;
	}
	public   ClsVehicleDisposalBean getPrint(String docno) throws SQLException {
		// TODO Auto-generated method stub
		ClsVehicleDisposalBean bean=new ClsVehicleDisposalBean();
		Connection conn=null;
		String currency="";
		try{
			conn=objconn.getMyConnection();
			ClsAmountToWords obj=new ClsAmountToWords();
			Statement stmt=conn.createStatement();
			String strsql="select br.branchname,lc.loc_name,br.address branchaddress,br.tel brtel,br.fax brfax,comp.company,sale.doc_no,sale.voc_no,DATE_FORMAT(sale.date,'%d/%m/%Y') "+
			" date,sale.cldocno,coalesce(ac.refname,'') refname,coalesce(ac.address,'') addr1,coalesce(ac.address2,'') addr2,coalesce(ac.com_mob,'') mob,coalesce(ac.per_mob,'') phone,"
			+ "if(sale.type='S','Sale','Loss') type,sale.description,cur.code cur,DATE_FORMAT(CURDATE(),'%d/%m/%Y') finaldate,ms.user_name from gl_vsalem sale left join my_acbook ac on "+
			" (sale.cldocno=ac.cldocno and ac.dtype='CRM') left join my_brch br on (sale.brhid=br.doc_no) left join my_comp comp on (br.cmpid=comp.doc_no) left join my_curr cur on comp.curid=cur.doc_no"
			+ " inner join my_locm l on l.brhid=br.doc_no inner join (select min(lo.loc) loc,lo.loc_name,lo.brhid from my_locm lo group by brhid) as lc on(lc.loc=l.loc and lc.brhid=br.doc_no) "
			+ "left join datalog dl on sale.doc_no=dl.doc_no and dl.dtype='VSI' left join my_user ms on ms.doc_no=dl.userid where  sale.doc_no="+docno;
			ResultSet rssale=stmt.executeQuery(strsql);
			while(rssale.next()){
				bean.setLbldocno(rssale.getString("voc_no"));
				bean.setLblclientcode(rssale.getString("cldocno"));
				bean.setLblclientname(rssale.getString("refname"));
				bean.setLbltype(rssale.getString("type"));
				bean.setLbldesc(rssale.getString("description"));
				bean.setLbldate(rssale.getString("date"));
				bean.setLblbranch(rssale.getString("branchname"));
				bean.setLblcompfax(rssale.getString("brfax"));
				bean.setLblcomptel(rssale.getString("brtel"));
				bean.setLblcompname(rssale.getString("company"));
				bean.setLblcompaddress(rssale.getString("branchaddress"));
				
				
				bean.setLbllocation(rssale.getString("loc_name"));
				bean.setLbladdress1(rssale.getString("addr1"));
				bean.setLbladdress2(rssale.getString("addr2"));
				bean.setLblmobile(rssale.getString("mob"));
				bean.setLblphone(rssale.getString("phone"));
				bean.setLblcheckedby(rssale.getString("user_name"));
				bean.setLblfinaldate(rssale.getString("finaldate"));
				currency=rssale.getString("cur");
			}
			
			

	//		ArrayList<Double> totalarray=new ArrayList<>();

			String strtotal="select round(sum(coalesce(saled.salesprice,0)),2) total from gl_vsaled saled where saled.rdocno="+docno;
			ResultSet rstotal=stmt.executeQuery(strtotal);

			while(rstotal.next()){
		//		totalarray.add(rstotal.getDouble("total"));
				
				bean.setLbltotal(rstotal.getString("total"));
			//	bean.setLblamountwords(currency+" "+obj.convertNumberToWords(Double.parseDouble(rstotal.getString("total")))+" only");
			String amountwords=obj.convertAmountToWords(rstotal.getString("total"));
				bean.setLblamountwords(currency+" "+amountwords+"");
			}
			
			
			
		}
		catch(Exception e){
			e.printStackTrace();
			
		}
		finally{
			conn.close();
		}
		return bean;
	}
	public   ArrayList<String> getSaleInvPrint(String docno) throws SQLException {
		// TODO Auto-generated method stub
		ArrayList<String> invprint=new ArrayList<>();
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select concat(veh.reg_no,'-',plt.code_name) reg,saled.sr_no,saled.fleetno fleet_no ,round(saled.salesprice,2) salesprice,DATE_FORMAT(saled.dep_posted,'%d/%m/%Y') dep_posted,round(saled.pvalue,2) pur_value,round(saled.acdep,2) acc_dep,round(saled.curdep,2) cur_dep,round(saled.netbook,2) netbook,round(saled.netval,2) net_pl,veh.flname"+
	        			" from gl_vsaled saled left join gl_vehmaster veh on saled.fleetno=veh.fleet_no left join gl_vsalem sale on saled.rdocno=sale.doc_no left join gl_vehplate plt on veh.pltid=plt.doc_no "+
	        			" where saled.rdocno="+docno;
			ResultSet rsprint=stmt.executeQuery(strsql);
			String temp="";
			int i=0;
			while(rsprint.next()){
				temp=rsprint.getString("sr_no")+"::"+rsprint.getString("reg")+"::"+rsprint.getString("flname")+"::"+rsprint.getString("dep_posted")+"::"+rsprint.getString("salesprice")+"::"+rsprint.getString("pur_value")+"::"+rsprint.getString("acc_dep")+"::"+rsprint.getString("cur_dep")+"::"+rsprint.getString("netbook")+"::"+rsprint.getString("net_pl");
				invprint.add(temp);
				i++;
			}
			
						
			return invprint;
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return invprint;
	}
	
	public   ArrayList<String> getSaleInvPrint2(String docno) throws SQLException {
		// TODO Auto-generated method stub
		ArrayList<String> invprint=new ArrayList<>();
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select concat(veh.reg_no,'-',plt.code_name) reg,veh.ch_no chassis,saled.sr_no,saled.fleetno fleet_no ,round(saled.salesprice,2) salesprice,DATE_FORMAT(saled.dep_posted,'%d/%m/%Y') dep_posted,round(saled.pvalue,2) pur_value,round(saled.acdep,2) acc_dep,round(saled.curdep,2) cur_dep,round(saled.netbook,2) netbook,round(saled.netval,2) net_pl,veh.flname"+
	        			" from gl_vsaled saled left join gl_vehmaster veh on saled.fleetno=veh.fleet_no left join gl_vsalem sale on saled.rdocno=sale.doc_no"+
	        			" left join gl_vehplate plt on veh.pltid=plt.doc_no where saled.rdocno="+docno;
			System.out.println(strsql);
			ResultSet rsprint=stmt.executeQuery(strsql);
			String temp="";
			int i=0;
			while(rsprint.next()){
				temp=rsprint.getString("sr_no")+"::"+rsprint.getString("fleet_no")+"::"+rsprint.getString("reg")+"::"+rsprint.getString("chassis")+"::"+rsprint.getString("flname")+"::"+rsprint.getString("salesprice")+"::"+rsprint.getString("dep_posted")+"::"+rsprint.getString("salesprice")+"::"+rsprint.getString("pur_value")+"::"+rsprint.getString("acc_dep")+"::"+rsprint.getString("cur_dep")+"::"+rsprint.getString("netbook")+"::"+rsprint.getString("net_pl");
				invprint.add(temp);
				i++;
			}
			
						
			return invprint;
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return invprint;
	}
	
	
	
	public   ArrayList<String> getJvPrint(String trno) throws SQLException {
		// TODO Auto-generated method stub
		ArrayList<String> jvprint=new ArrayList<>();
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
		
		Statement stmt=conn.createStatement();
		String strsql="select if(j.dramount>0,round(j.dramount*j.id,2),0)debit ,if(j.dramount<0,round(j.dramount*j.id,2),0) credit,"+
	        			" round(j.ldramount*j.id,2) baseamt,j.description desc1,h.account acno,	h.description acname,h.atype type from my_jvtran j left join my_head h on"+
	        			" j.acno=h.doc_no left join my_curr cr on cr.doc_no=j.curId where j.tr_no="+trno;
		ResultSet rsjv=stmt.executeQuery(strsql);
		String temp="";
		int i=1;
		while(rsjv.next()){
			
			temp=i+"::"+rsjv.getString("type")+"::"+rsjv.getString("acno")+"::"+rsjv.getString("acname")+"::"+rsjv.getString("debit")+"::"+rsjv.getString("credit")+"::"+rsjv.getString("baseamt")+"::"+rsjv.getString("desc1");
			jvprint.add(temp);
			i++;
		}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return jvprint;
	}
	
	
	public String getJvPrinttotal(String trno) throws SQLException {
		// TODO Auto-generated method stub
		String strjvtotal="";
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select sum(if(j.dramount>0,round(j.dramount*j.id,2),0)) debit ,sum(if(j.dramount<0,round(j.dramount*j.id,2),0)) credit"+
			" from my_jvtran j left join my_head h on j.acno=h.doc_no left join my_curr cr on cr.doc_no=j.curId where j.tr_no="+trno;
			ResultSet rsjv=stmt.executeQuery(strsql);
			while(rsjv.next()){
				strjvtotal=rsjv.getString("debit")+"::"+rsjv.getString("credit");
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return strjvtotal;
	}
	
	
	
	
	
}
