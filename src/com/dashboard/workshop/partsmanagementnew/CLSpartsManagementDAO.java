package com.dashboard.workshop.partsmanagementnew;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.dashboard.workshop.partscosting.ClsPartsCostingBean;
import com.workshop.wsjobcard.ClsWSJobCardBean;

public class CLSpartsManagementDAO {

	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	
	public JSONArray getPartsMgmtData(String id,String brhid) throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String sqltest="";
			if(!brhid.trim().equalsIgnoreCase("") && !brhid.trim().equalsIgnoreCase("a")){
				sqltest+=" and jc.brhid="+brhid;
			}
			/*String strsql="select jc.date jobdate,jobdocno, fl.rowno,partremarks,jobvocno, vehicledetails, billto, client refname, service, age,fl.priority, partsstatus, partsexpdate, promiseddate, extdate, esthrs, actualhrs, hrsdiff, grpname, estimator, srvcadvisor, salesman, insursurvivor, referredby,jc.refno from ws_floormgmtdata fl left join ws_jobcard jc on fl.jobdocno=jc.doc_no left join ws_estm estn on (jc.reftype='EST' and jc.refno=estn.doc_no) left join ws_gateinpass dc on estn.gipno=dc.doc_no left join ws_estspare we on estn.doc_no=we.rdocno where dc.processstatus<6 and jc.status=3 and we.qty!=0 group by fl.rowno";*/
			String strsql="select refno,branchname,brhid,jobdocno,jobdate,rowno,partremarks,jobvocno,vehicledetails,billto,refname,service,age,priority,partsstatus,partsexpdate,promiseddate,extdate,esthrs, actualhrs, hrsdiff, grpname, estimator, srvcadvisor, salesman, insursurvivor, referredby,if(sum(a.fstcond)!=0 ,1,if(sum(a.seccond)!=0,2,if(sum(a.thirdcond)!=0,3,0))) yellow,sum(a.fstcond) fstcond,sum(a.seccond)seccond,sum(thirdcond)thirdcond,sum(testcond)testcond from(select br.doc_no brhid,br.branchname,jc.date jobdate,we.status,we.availability,if (we.status is null,1,0)fstcond,if (we.status is not null and we.availability='pending',1,0)seccond,if(we.status is not null and we.availability='available',1,0)thirdcond,1 testcond,jobdocno,fl.rowno,partremarks,jobvocno, vehicledetails, billto, client refname, service, age,fl.priority, partsstatus, partsexpdate, promiseddate, extdate, esthrs, actualhrs, hrsdiff, grpname, estimator, srvcadvisor, salesman, insursurvivor, referredby,jc.refno from ws_floormgmtdata fl left join ws_jobcard jc on fl.jobdocno=jc.doc_no left join ws_estm estn on (jc.reftype='EST' and jc.refno=estn.doc_no) left join ws_gateinpass dc on estn.gipno=dc.doc_no left join ws_estspare we on estn.doc_no=we.rdocno left join my_brch br on jc.brhid=br.doc_no where dc.processstatus<6 and jc.status=3 and we.qty!=0 "+sqltest+")a group by a.jobdocno";
			System.out.println("strsql--->>>"+strsql);  
			ResultSet rs=stmt.executeQuery(strsql);
			data=objcommon.convertToJSON(rs);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return data;
	}

	
	public JSONArray getPartsMgmtDataexcel(String id) throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsqlexcel="select jc.date 'Job Date',jobvocno 'Job No',vehicledetails 'Vehicle details',billto 'Bill To', "
					+ "client 'Refname',service 'Service',age 'Age',fl.priority 'Priority',partsstatus 'Parts Status', "
					+ "partsexpdate 'Parts Exp. Date',promiseddate 'Promised Date',extdate 'Extended Date',esthrs 'Est. Hrs.', "
					+ "actualhrs 'Actual Hrs.',hrsdiff 'Hrs. Diff', grpname 'Group',estimator 'Estimator', "
					+ "srvcadvisor 'Service Advisor',salesman 'Salesman',partremarks 'Part Remarks', "
					+ "insursurvivor 'Insurance Survivor',referredby 'Referred By',jc.refno 'Refno' from ws_floormgmtdata fl "
					+ "left join ws_jobcard jc on fl.jobdocno=jc.doc_no left join ws_estm estn on (jc.reftype='EST' and "
					+ "jc.refno=estn.doc_no) left join ws_gateinpass dc on estn.gipno=dc.doc_no left join ws_estspare we  "
					+ "on estn.doc_no=we.rdocno where dc.processstatus<6 and jc.status=3 and we.qty!=0 group by fl.rowno";
			System.out.println("strsql excel--->>>"+strsqlexcel);  
			ResultSet rs=stmt.executeQuery(strsqlexcel);
			data=objcommon.convertToEXCEL(rs);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return data;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	public JSONArray getSparePartData(String rowno,String id)throws SQLException
	{
		JSONArray jcdata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return jcdata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
/*"select (select acno from my_account where codeno='WORKSHOPPARTPURCH') accno,(select  acno from my_account where codeno='ROUND OF ACCOUNT') raccno,m.productname partname,m.part_no partno,m.psrno,m.munit unitdocno,p.mspecno specid,spr.rowno,spr.genuinerate total,spr.outqty,spr.description,spr.remarks , spr.qty , jc.qty requested,(spr.qty - jc.qty) balance,coalesce(ord.qty,0) ordqty,coalesce(piv.qty,0) pivqty"
						+" from ws_estm em inner JOIN  (select description, remarks,rdocno ,genuinerate,rowno,sum(outqty) outqty,psrno, sum(qty) qty from ws_estspare group by rdocno,psrno ) spr on spr.rdocno=em.doc_no inner JOIN ws_jobcard jb on (jb.refno=em.gipno and jb.reftype='gip') or (jb.refno=em.doc_no and jb.reftype='est') left join"
						+" (SELECT COSTDOCNO,PSRNO,SUM(QTY) qty FROM MY_MREQM M LEFT JOIN MY_MREQD D ON M.DOC_NO=D.RDOCNO WHERE M.STATUS=3 and costtype=9 GROUP BY COSTDOCNO,PSRNO) jc on jc.costdocno=jb.doc_no and jc.psrno=spr.psrno left join my_main m on spr.psrno=m.psrno left join my_prodattrib p on m.psrno=p.mpsrno"
						+" left join (select sum(qty-out_qty) qty,psrno,costtype,costcode from my_ordm m inner join my_ordd d on m.tr_no=d.tr_no where m.status<=3 and costcode!=0 and qty-out_qty!=0 group by psrno,costtype,costcode) ord ON ord.costtype=9 and ord.costcode = jb.doc_no and ord.psrno=spr.psrno"
						+" left join (select sum(qty-out_qty) qty,psrno,costtype,costcode from my_srvm m inner join my_srvd d on m.tr_no=d.tr_no where m.status<=3 and costcode!=0 and qty-out_qty!=0 group by psrno,costtype,costcode) piv ON piv.costtype=9 and piv.costcode = jb.doc_no and piv.psrno=spr.psrno"
						+" where spr.psrno!=0 and m.doc_no='"+rowno+"'";*/
			/*m.productname partname,m.part_no partno,*/

String strsql="select spr.contrastatus,(select acno from my_account where codeno='WORKSHOPPARTPURCH') accno,(select acno from my_account where codeno='ROUND OF ACCOUNT') raccno,spr.rowno,spr.approvedvalue total,spr.outqty,spr.description,spr.remarks ,spr.status,spr.availability,spr.qty"
                           +" from ws_estm em inner JOIN  ws_estspare spr on spr.rdocno=em.doc_no inner JOIN ws_jobcard jb on (jb.refno=em.gipno and jb.reftype='gip') or (jb.refno=em.doc_no and jb.reftype='est')  where spr.approved=1 and spr.confirmed=1 and spr.qty!=0 and jb.doc_no='"+rowno+"'";
			System.out.println("strsql---->>>"+strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			jcdata=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return jcdata;
	}
	
	public JSONArray getPurchaseOrderData(String docno,String invdate,String vendorid,String invno,String id)throws SQLException{
		JSONArray RESULTDATA=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return RESULTDATA;
		}
		Connection conn=null; 
		try{
			conn = objconn.getMyConnection();
			Statement stmt= conn.createStatement();
			
			String sqltest="";
			String docno11=docno+"0";  
			java.sql.Date sqlfromdate=null,sqltodate=null;
			/*if(!fromdate.equalsIgnoreCase("") && fromdate!=null){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
			}*/
			if(!invdate.equalsIgnoreCase("") && invdate!=null){
				sqltodate=objcommon.changeStringtoSqlDate(invdate);
			}
			if(!vendorid.equalsIgnoreCase("") && vendorid!=null){
				sqltest+=" and ac.cldocno="+vendorid;
			}
			if(!invno.equalsIgnoreCase("") && invno!=null){
				sqltest+=" and pm.doc_no="+invno;
			}
			
			/*String sqlqry="select (select acno from my_account where codeno='MAINTSP') accdocno,curdate() crdate,pm.date,pm.doc_no,pm.orderdocno,pm.voc_no,ac.refname,pm.refno,pm.desc1 description,sum(pd.nettaxamount) amount,"
						+" h.atype,h.doc_no acno,h.description acname,h.curid,h.rate "
						+" from my_srvlpom pm left join my_srvlpod pd on pm.doc_no=pd.rdocno"
						+" left join my_acbook ac on (pm.acno=ac.acno and ac.dtype='VND') "
						+" left join my_head h on pm.acno=h.doc_no"
						+" left join my_srvpurm sm on pm.doc_no=sm.refno"
						+" where pm.date between '"+sqlfromdate+"' and '"+sqltodate+"' and pm.status=3 and sm.doc_no is null"+sqltest+" group by pd.rdocno";*/
			
			String sqlqry="select sp.description,sp.rate,sp.total,ac.tax,sp.outqty from ws_estspare sp left join my_acbook ac on (pm.acno=ac.acno and ac.dtype='VND') where sp.rowno in ("+docno11+")";
			System.out.println("sqlqry----->>>"+sqlqry);
			ResultSet resultSet = stmt.executeQuery (sqlqry); 
			
			RESULTDATA=objcommon.convertToJSON(resultSet);
			stmt.close();
			
		}catch(Exception e){
			conn.close();
			e.printStackTrace();
		}finally{
			conn.close();
		}
	return RESULTDATA;
	}
	
	public   JSONArray reloadnipurchase(String nidoc) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();
	   
	    String nidoc11=nidoc+"0";  
	   
	   
	    Connection conn = null;
		try {
				 conn = objconn.getMyConnection();
				Statement stmtVeh1 = conn.createStatement ();
	        	String pySql=(" select d.refrow,d.srno,d.desc1 description,d.unitprice,d.qty,if(reftype='DIR',d.qty,(dd.qty-dd.out_qty)+d.qty) qutval,d.total,d.discount,d.nettotal,d.taxper,d.taxamount taxperamt,d.nettaxamount taxamount,d.nuprice,d.acno headdoc,h.gr_type grtype ,"
	        			+ "d.costtype,d.costcode, d.remarks,h.account account,h.description accname,h.atype type,coalesce(u.CostGroup,'') CostGroup "
	        			+ " from my_srvpurd d left join my_srvpurm m on m.doc_no=d.rdocno  left join my_head h on h.doc_no=d.acno  left join my_costunit u on u.costtype=d.costtype "
	        			+ " left join my_srvlpod dd on dd.rowno=d.refrow  where d.rdocno in ("+nidoc11+")  ");
	        System.out.println("========"+pySql);
				ResultSet resultSet = stmtVeh1.executeQuery(pySql);

				RESULTDATA=objcommon.convertToJSON(resultSet); 
				stmtVeh1.close();
				conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
	//	System.out.println(RESULTDATA);
	    return RESULTDATA;
	}
	
	public  JSONArray loadfollowupGridData(String trdocno) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();


		Connection conn = null;
		Statement stmt =null;
		ResultSet resultSet=null;
		try {

			//System.out.println("=====loadTrafficdaily");
			conn = objconn.getMyConnection();
			stmt = conn.createStatement ();   
		 	
		
				
			/*String sqldata = "select m.date detdate,u.user_id user,m.fdate fdate,remarks remk from "
					+ " gl_blmf m left join  my_user u on u.doc_no=m.userid where m.trdocno="+trdocno+" and m.status=3;";*/
		
			
			String sqldata="select date,remarks,status from gl_bwpm where jobno="+trdocno+"";
		System.out.println("Followup========"+sqldata);
				resultSet= stmt.executeQuery (sqldata);
			RESULTDATA=objcommon.convertToJSON(resultSet);
			//			System.out.println("=====RESULTDATA"+RESULTDATA);

		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			stmt.close();
			conn.close();
		}
		return RESULTDATA;
	}
	
	public JSONArray getVendorDeatils(String vendorname,String chk)throws SQLException{
		JSONArray RESULTDATA=new JSONArray();
		if(!chk.equalsIgnoreCase("1")){
			return RESULTDATA;
		}
		Connection conn=null; 
		try{
			conn = objconn.getMyConnection();
			Statement stmt= conn.createStatement();
			String sqltest="";
			if(!vendorname.equalsIgnoreCase("")){
				//System.out.println("sqltest");
				 sqltest+=" and RefName like'%"+vendorname+"%'";
			}
			String sqlqry="SELECT RefName vndname,tax,acno,cldocno vndocno FROM my_acbook where dtype='VND' and status<>7"+sqltest;
			ResultSet resultSet = stmt.executeQuery (sqlqry);
			
			RESULTDATA=objcommon.convertToJSON(resultSet);
			stmt.close();
			
		}catch(Exception e){
			conn.close();
			e.printStackTrace();
		}finally{
			conn.close();
		}
	return RESULTDATA;
	}
	
	ArrayList<String> getPartsPrint(String temparray) {
		ArrayList<String> data=new ArrayList<>();
		Connection conn=null;
		try{
				conn=objconn.getMyConnection();
				Statement stmt=conn.createStatement();
				String temparray1=temparray+"0";
				String strsql="select description,round(qty,2) qty from ws_estspare  where rowno in("+temparray1+")";
				System.out.println(strsql);				
				ResultSet rs=stmt.executeQuery(strsql);
				int i=1;
				
				while(rs.next()){
					data.add(i+"::"+rs.getString("description")+"::"+rs.getString("qty"));
					i++;
				}
			}
			catch(Exception e){
				e.printStackTrace();
			}
			finally{
			}
		return data;

	}
	/*public ClsWSJobCardBean printDetails(String[] temparray, HttpServletRequest request) throws SQLException {
		// TODO Auto-generated method stub
		ClsWSJobCardBean bean=new ClsWSJobCardBean();
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			
			
			ArrayList<String> partsarray=new ArrayList<>();
			partsarray=getPartsPrint(conn,temparray);
			
			request.setAttribute("PARTPRINT", partsarray);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return bean;
	}*/

	public ClsPartsMgmtBean getPartsPrintMaster(String jobdocno) throws SQLException{
		// TODO Auto-generated method stub
		ClsPartsMgmtBean bean=new ClsPartsMgmtBean();
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select if(gp.backjob=1,'YES','NO') backjob,coalesce(br.address,'') address,coalesce(comp.company,'') company,coalesce(br.branchname,'') branchname,coalesce(br.tel,'') tel,coalesce(br.fax,'') fax,coalesce(loc.loc_name,'') location,coalesce(br.tinno,'') comptrno,coalesce(gp.regno,'') regno,' ',"+
			" coalesce(gp.pltid,'') pltid,' ',coalesce(brd.brand_name,'') brand,' ',coalesce(model.vtype,'') model,' ',coalesce(yom.yom,'') yom,' ',"+
			" coalesce(gp.vehother,'') veh,coalesce(clr.color,'') color,coalesce(gp.other,'') chasis from ws_jobcard job left join my_brch br on job.brhid=br.doc_no "+
			" left join my_comp comp on br.cmpid=comp.doc_no left join (select min(doc_no) minloc,brhid from my_locm loc group by doc_no) l "+
			" on br.doc_no=l.brhid left join my_locm loc on l.minloc=loc.doc_no left join ws_estm es on (job.refno=es.doc_no and job.reftype='EST')"+
			" left join ws_gateinpass gp on((job.refno=gp.doc_no and job.reftype='GIP') or (es.gipno=gp.doc_no and job.reftype='EST'))"+
			" left join gl_vehplate plate on gp.pltid=plate.doc_no"+
			" left join gl_vehbrand brd on(gp.brdid=brd.doc_no) left join gl_vehmodel model on gp.modid=model.doc_no"+
			" left join gl_yom yom on gp.yom=yom.doc_no left join my_color clr on gp.colorid=clr.doc_no where job.doc_no="+jobdocno;
			ResultSet rs=stmt.executeQuery(strsql);
			while(rs.next()){
				bean.setLblbranch(rs.getString("branchname"));
				bean.setLblcompaddress(rs.getString("address"));
				bean.setLblcompfax(rs.getString("fax"));
				bean.setLblcompname(rs.getString("company"));
				bean.setLblcomptel(rs.getString("tel"));
				bean.setLblcomptrn(rs.getString("comptrno"));
				bean.setLbllocation(rs.getString("location"));
				bean.setLblregno(rs.getString("regno"));
				bean.setLblbrand(rs.getString("brand"));
				bean.setLblmodel(rs.getString("model"));
				bean.setLblyom(rs.getString("yom"));
				bean.setLblcolor(rs.getString("color"));
				bean.setLblchasis(rs.getString("chasis"));
				bean.setLblbackjob(rs.getString("backjob"));
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

	
	
}
