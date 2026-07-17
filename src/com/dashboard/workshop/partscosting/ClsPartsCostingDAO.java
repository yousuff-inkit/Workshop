package com.dashboard.workshop.partscosting;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsPartsCostingDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon commonDAO = new ClsCommon();
	
	
	public JSONArray masterReload(String fromdate, String todate, String cldocno, String estno) throws SQLException{
		JSONArray RESULTDATA=new JSONArray();
				
				Connection conn =null;
		        
				try {
					conn=ClsConnection.getMyConnection();
		
					Statement stmt = conn.createStatement ();
					String sqltest="";
					
					java.sql.Date sqlfromdate=null;
					java.sql.Date sqltodate=null;
					
					if(!fromdate.equalsIgnoreCase("")){
						sqlfromdate=commonDAO.changeStringtoSqlDate(fromdate);
					}
					if(!fromdate.equalsIgnoreCase("")){
						sqltodate=commonDAO.changeStringtoSqlDate(todate);
						sqltest+=" and ws.date between '"+sqlfromdate+"' and '"+sqltodate+"'";
					}
					
					if(!cldocno.equalsIgnoreCase("")){
						sqltest+=" and ac.cldocno="+cldocno;
					}
					
					if(!estno.equalsIgnoreCase("")){
						sqltest+=" and e.doc_no="+estno;
					}
					
					String sqlqry="select  ws.date, ws.estdeltime time, gr.name reptype, ac.refname customer, ws.regno, ws.pltid pcode,"+
							" vb.brand_name brand, vm.vtype model,datediff( curdate(), ws.DATE) gipdate, ws.estdeldate expdelivery,"+
							" ws.estdeltime dtime,ws.desc1 description, ws.username useropen, ur.user_name estimatedby, e.doc_no estno, e.date estdate,"+
							" 'approved' approval, j.doc_no jobno from ws_gateinpass ws"+
							" left join ws_gartype gr on gr.row_no=ws.repairtype left join gl_vehbrand vb on vb.doc_no=ws.brdid"+
							" left join gl_vehmodel vm on vm.doc_no=ws.modid left join ws_estm e on e.gipno=ws.doc_no"+
							" left join ws_jobcard j on ((e.doc_no=j.refno and reftype='EST') or (ws.doc_no=j.refno and reftype='GIP'))"+
							" left join my_user ur on ur.doc_no=e.userid left join my_user us on us.doc_no=j.userid left join my_acbook ac on ac.cldocno=ws.cldocno and ac.dtype='crm'"+
							" where 1=1 and ws.processstatus=5 "+sqltest;
							
					
					System.out.println("====+++"+sqlqry);
					ResultSet resultSet = stmt.executeQuery(sqlqry);
					
					RESULTDATA=commonDAO.convertToJSON(resultSet);
					
					stmt.close();
					conn.close();
				}
				catch(Exception e){
					e.printStackTrace();
					conn.close();
				}
				finally{
					conn.close();
				}
				return RESULTDATA;
	}
	public JSONArray excelReload(String fromdate, String todate, String cldocno, String estno) throws SQLException{
		JSONArray RESULTDATA=new JSONArray();
				
				Connection conn =null;
		        
				try {
					conn=ClsConnection.getMyConnection();
		
					Statement stmt = conn.createStatement ();
					String sqltest="";
					java.sql.Date sqlfromdate=null;
					java.sql.Date sqltodate=null;
					
					if(!fromdate.equalsIgnoreCase("")){
						sqlfromdate=commonDAO.changeStringtoSqlDate(fromdate);
					}
					if(!fromdate.equalsIgnoreCase("")){
						sqltodate=commonDAO.changeStringtoSqlDate(todate);
						sqltest+=" and ws.date between '"+sqlfromdate+"' and '"+sqltodate+"'";
					}
					if(!cldocno.equalsIgnoreCase("")){
						sqltest+=" and ac.cldocno="+cldocno;
					}
					if(!estno.equalsIgnoreCase("")){
						sqltest+=" and e.doc_no="+estno;
					}
					String sqlqry="select @s:=@s+1 'Sr No.', ws.date 'Date', ws.estdeltime 'Time', gr.name 'Rep Type', ac.refname 'Customer', ws.regno 'Reg No', ws.pltid 'Plate Code',"+
							" vb.brand_name 'Brand', vm.vtype 'Model',datediff( curdate(), ws.DATE) 'GIP Date', ws.estdeldate 'Exp Delivery',"+
							" ws.estdeltime 'Del Time',ws.desc1 'Description', ws.username 'User Open', ur.user_name 'Estimated By', e.doc_no 'Est No', e.date 'Est Date',"+
							" 'approved' 'Approval', j.doc_no 'Job No' from (select @s:=0) s,ws_gateinpass ws"+
							" left join ws_gartype gr on gr.row_no=ws.repairtype left join gl_vehbrand vb on vb.doc_no=ws.brdid"+
							" left join gl_vehmodel vm on vm.doc_no=ws.modid left join ws_estm e on e.gipno=ws.doc_no"+
							" left join ws_jobcard j on ((e.doc_no=j.refno and reftype='EST') or (ws.doc_no=j.refno and reftype='GIP'))"+
							" left join my_user ur on ur.doc_no=e.userid left join my_user us on us.doc_no=j.userid left join my_acbook ac on ac.cldocno=ws.cldocno and ac.dtype='crm'"+
							" where 1=1 and ws.processstatus=5 "+sqltest;
							
					ResultSet resultSet = stmt.executeQuery(sqlqry);
					RESULTDATA=commonDAO.convertToEXCEL(resultSet);
					stmt.close();
					conn.close();
				}
				catch(Exception e){
					e.printStackTrace();
					conn.close();
				}
				finally{
					conn.close();
				}
				return RESULTDATA;
	}
	
	public JSONArray sparepartsdetails(String estno, String check) throws SQLException{
		JSONArray RESULTDATA=new JSONArray();
				
				Connection conn =null;
		        
				try {
					conn=ClsConnection.getMyConnection();
		
					Statement stmt = conn.createStatement ();
					String sqltest="";
					
					
					
					String sqlqry="select esp.rowno, esp.description, if(es.chklumsum>0,'Genuine',esp.approval) type, esp.qty,"
							+" round(CONVERT(if(es.chklumsum>0,esp.approvedvalue,(if(trim(esp.approval)='Genuine',esp.genuinerate,(if(trim(esp.approval)='Market',esp.marketrate,"
							+" if(trim(esp.approval)='Used',esp.usedrate,'0')))))),CHAR(100)),2) rate,"
							+" round(CONVERT(if(es.chklumsum=1,es.lumsumamount,approvedvalue),CHAR(100)),2) total, mn.ProductName product,"
							+" round(esp.stdprice,2) stdcost, ac.refname vendor,esp.vndno ,esp.psrno,j.voc_no, mn.doc_no prdid,mn.munit,esp.pono,pa.mspecno from ws_estspare esp left join ws_estm es"
							+"  on(esp.rdocno=es.doc_no) left join my_main mn on(esp.psrno=mn.psrno) left join my_acbook ac on (ac.acno=esp.vndno"
							+"  and ac.dtype='vnd') left join ws_jobcard j on j.refno=es.doc_no and j.reftype='est' left join my_prodattrib pa on pa.mpsrno=mn.psrno where esp.rdocno="+estno;
					System.out.println("~~~~~~"+sqlqry);
							
					
					if(check != "0"){
					ResultSet resultSet = stmt.executeQuery(sqlqry);
					
					
					RESULTDATA=commonDAO.convertToJSON(resultSet);
				
					return RESULTDATA;
					}
					
					
					stmt.close();
					conn.close();
				}
				catch(Exception e){
					e.printStackTrace();
					conn.close();
				}
				finally{
					conn.close();
				}
				return RESULTDATA;
	}
	
	public JSONArray getPartsData(String id,String partno,String prdctnme,String stock,String unit) throws SQLException{
		JSONArray partsdata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return partsdata;
		}
		Connection conn=null;
		try{
			conn=ClsConnection.getMyConnection();
			Statement stmt=conn.createStatement();
			String sqltest="";
			//System.out.println("++++++++++"+unit);
			if(!(partno.equalsIgnoreCase("undefined"))&&!(partno.equalsIgnoreCase(""))&&!(partno.equalsIgnoreCase("0"))) {
				sqltest+=sqltest+" and a.partno like '%"+partno+"%'";
	        }
			if(!(prdctnme.equalsIgnoreCase("undefined"))&&!(prdctnme.equalsIgnoreCase(""))&&!(prdctnme.equalsIgnoreCase("0"))) {
				sqltest+=sqltest+" and a.productname like '%"+prdctnme+"%'";
	        }
			/*if(!(stock.equalsIgnoreCase("undefined"))&&!(stock.equalsIgnoreCase(""))&&!(stock.equalsIgnoreCase("0"))) {
				sqltest+=sqltest+" and a.balqty like '%"+stock+"%'";
	        }*/
			if(!(unit.equalsIgnoreCase("undefined"))&&!(unit.equalsIgnoreCase(""))&&!(unit.equalsIgnoreCase("0"))) {
				sqltest+=sqltest+" and a.unit like '%"+unit+"%'";
	        }
			String strsql="select * from ( select bd.brandname,m.fixingprice,m.stdprice,m.psrno partdocno,m.part_no partno,m.productname,m.doc_no,u.unit,m.munit as unitdocno,m.psrno,'' qty"
					+ " from my_main m left join my_unitm u on m.munit=u.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd"+
			" on m.brandid=bd.doc_no where m.status=3 ) a where 1=1 " +sqltest+" ";
			
			System.out.println("~~"+strsql);
			
			ResultSet rs=stmt.executeQuery(strsql);
			partsdata=commonDAO.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return partsdata;
	}
	
	
	
	
	
public JSONArray clientDetails() throws SQLException{
		
		JSONArray RESULTDATA=new JSONArray();
		
		Connection conn =null;
        
		try {
			conn=ClsConnection.getMyConnection();

			Statement stmt = conn.createStatement ();
        	
			String sqlqry= "select refname,cldocno from my_acbook where dtype='CRM' and status='3'";
			ResultSet resultSet = stmt.executeQuery(sqlqry);
			
			RESULTDATA=commonDAO.convertToJSON(resultSet);
			
			stmt.close();
			conn.close();
	}
	catch(Exception e){
		e.printStackTrace();
		conn.close();
	}
		finally{
			conn.close();
		}
	
	return RESULTDATA;
	}

	public JSONArray vendorDetails() throws SQLException{
		
		JSONArray RESULTDATA=new JSONArray();
		
		Connection conn =null;
	    
		try {
			conn=ClsConnection.getMyConnection();
	
			Statement stmt = conn.createStatement ();
	    	
			String sqlqry= "select refname,acno cldocno from my_acbook where dtype='VND' and status='3'";
			ResultSet resultSet = stmt.executeQuery(sqlqry);
			
			RESULTDATA=commonDAO.convertToJSON(resultSet);
			
			stmt.close();
			conn.close();
	}
	catch(Exception e){
		e.printStackTrace();
		conn.close();
	}
		finally{
			conn.close();
		}
	
	return RESULTDATA;
	}


public JSONArray estDetails() throws SQLException{
	
	JSONArray RESULTDATA=new JSONArray();
	
	Connection conn =null;
    
	try {
		conn=ClsConnection.getMyConnection();

		Statement stmt = conn.createStatement ();
    	
		String sqlqry= "select es.doc_no, es.voc_no from ws_estm es left join ws_gateinpass gp on (es.gipno=gp.doc_no) "
				+ "where gp.processstatus='5' and es.status='3'";
		ResultSet resultSet = stmt.executeQuery(sqlqry);
		
		RESULTDATA=commonDAO.convertToJSON(resultSet);
		
		stmt.close();
		conn.close();
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
	finally{
		conn.close();
	}

return RESULTDATA;
}

public ClsPartsCostingBean getPrint(String jobno) throws SQLException {
	
	ClsPartsCostingBean bean = new ClsPartsCostingBean();	
	Connection conn = null;
	try{
	conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	
	String sql1="select 'Parts Costing' vouchername,'' vouchername1,c.company,c.address,c.tel,c.fax,lc.loc_name location,b.branchname,b.pbno,"
				+" b.stcno,b.cstno,b.tinno from ws_jobcard job left join my_brch b on job.brhid=b.doc_no inner join my_comp c on b.cmpid=c.doc_no inner join"
				+" my_locm l on l.brhid=b.doc_no inner join (select min(lo.loc) loc,lo.loc_name,lo.brhid from my_locm lo group by brhid) as lc"
				+" on(lc.loc=l.loc and lc.brhid=b.doc_no) where 1=1  group by job.brhid";
	
	System.out.println("!!!!!"+sql1);
		ResultSet resultSet1 = stmt.executeQuery(sql1);
		
		while(resultSet1.next()){
			bean.setLblcompname(resultSet1.getString("company"));
			bean.setLblcompaddress(resultSet1.getString("address"));
			bean.setLblprintname(resultSet1.getString("vouchername"));
			bean.setLblprintname1(resultSet1.getString("vouchername1"));
			bean.setLblcomptel(resultSet1.getString("tel"));
			bean.setLblcompfax(resultSet1.getString("fax"));
			bean.setLblbranch(resultSet1.getString("branchname"));
			bean.setLbllocation(resultSet1.getString("location"));
			bean.setLblcstno(resultSet1.getString("cstno"));
			bean.setLblpan(resultSet1.getString("pbno"));
			bean.setLblservicetax(resultSet1.getString("stcno"));
			bean.setLblcomptrn(resultSet1.getString("tinno"));
		}
	
	
	String sql="select a.*,round((total-stdprice),2) profit , round((((total-stdprice)/total)*100),2) profitperc"
			+" from (select j.voc_no,j.date, a.refname , a.trnnumber, concat(regno ,' - ', pltid) regno,vb.brand,vm.vtype,vy.yom ,"
			+" round(CONVERT(if(m.chklumsum=1,m.lumsumamount,sum(approvedvalue)),CHAR(100)),2) total , round(sum(stdprice),2) stdprice"
			+" from ws_jobcard j left join ws_estm m on j.refno=m.doc_no and j.reftype='est' left join ws_gateinpass g on m.gipno=g.doc_no"
			+" left join my_acbook a on a.cldocno=g.cldocno and a.dtype='crm' left join gl_vehbrand vb on vb.doc_no=g.brdid"
			+" left join gl_vehmodel vm on vm.doc_no=g.modid left join gl_yom vy on vm.doc_no=g.yom left join ws_estspare esp"
			+" on m.doc_no=esp.rdocno where j.doc_no="+jobno+") a";
	
	System.out.println("%%%%%"+sql);
	
	ResultSet resultSet = stmt.executeQuery(sql);
	
	while(resultSet.next()){
		
		bean.setLblbrand(resultSet.getString("brand"));
		bean.setLblcustomer(resultSet.getString("refname"));
		bean.setLblclienttrn(resultSet.getString("trnnumber"));
		bean.setLbldate(resultSet.getString("date"));
		bean.setLblestimationtotal(resultSet.getString("total"));
		bean.setLbljobno(resultSet.getString("voc_no"));
		bean.setLblmodel(resultSet.getString("vtype"));
		bean.setLblprofitamount(resultSet.getString("profit"));
		bean.setLblprofitperc(resultSet.getString("profitperc")+"%");
		bean.setLblpurchasetotal(resultSet.getString("stdprice"));
		bean.setLblregno(resultSet.getString("regno"));
		//bean.setLblvehicledetails(resultSet.getString("-"));
		bean.setLblyom(resultSet.getString("yom"));
		
	}
	}
	catch(Exception e){
		e.printStackTrace();
		conn.close();
	}
	finally{
		conn.close();
	}
	return bean;
}
public ArrayList<String> printsparepartsdetails(String estno) throws SQLException{
	// JSONArray RESULTDATA=new JSONArray();
	ArrayList<String> result= new ArrayList<>(); 		
			Connection conn =null;
	        
			try {
				conn=ClsConnection.getMyConnection();
	
				Statement stmt = conn.createStatement();
				String sqltest="";
				
				if(!estno.equalsIgnoreCase("")){
					sqltest+=" and j.doc_no="+estno;
				}
				
				String sqlqry="select esp.description, CONVERT(if(es.chklumsum>0,esp.approvedvalue,(if(trim(esp.approval)='Genuine',esp.genuinerate,(if(trim(esp.approval)='Market',esp.marketrate, if(trim(esp.approval)='Used',esp.usedrate,'0')))))),CHAR(100)) rate,  esp.qty, CONVERT(if(es.chklumsum=1,es.lumsumamount,approvedvalue),CHAR(100)) total, mn.ProductName product, esp.stdprice stdcost, ac.refname vendor  "
						+ " from ws_estspare esp left join ws_estm es"
						+"  on(esp.rdocno=es.doc_no) left join my_main mn on(esp.psrno=mn.psrno) left join my_acbook ac on (ac.acno=esp.vndno"
						+"  and ac.dtype='vnd') left join ws_jobcard j on j.refno=es.doc_no and j.reftype='est' where 1=1"+sqltest;
				System.out.println("~~~~~~"+sqlqry);
						
				
				
		//		if(check != "0"){
				ResultSet resultSet = stmt.executeQuery(sqlqry);
				int i=1;
				while(resultSet.next()){
				result.add((i++)+"::"+resultSet.getString("description")+"::"+resultSet.getString("rate")+"::"+resultSet.getString("qty")+"::"+resultSet.getString("total")+"::"+resultSet.getString("product")+"::"+resultSet.getString("stdcost")+"::"+resultSet.getString("vendor"));
				}
				// RESULTDATA=commonDAO.convertToJSON(resultSet);
			
				// return result;
				
				
				
				stmt.close();
				conn.close();
			}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
			finally{
				conn.close();
			}
			return result;
}

}


