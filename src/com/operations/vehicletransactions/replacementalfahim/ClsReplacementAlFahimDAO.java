package com.operations.vehicletransactions.replacementalfahim;

import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.operations.vehicletransactions.replacement.ClsReplacementBean;

public class ClsReplacementAlFahimDAO {
	ClsReplacementAlFahimBean replacementbean=new ClsReplacementAlFahimBean();
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	public  JSONArray getAgmtnoSearch(String docno,String fleet,String regno,String client,String agmttype,String date,String mobile,String agmtbranch) throws SQLException {
	    List<ClsReplacementAlFahimBean> replacementbean = new ArrayList<ClsReplacementAlFahimBean>();
	  String strSql="";
	    JSONArray RESULTDATA=new JSONArray();
	    Connection conn = null;
	    
		try {
		conn=objconn.getMyConnection();	
			Statement stmtmanual = conn.createStatement ();
			String sqltest="";
			String docno5="";
			
			//			System.out.println("checking   "+!((fleet.equalsIgnoreCase("0"))&&(fleet.trim().equalsIgnoreCase(""))&&(docno.isEmpty())));
			
			if(!((docno.equalsIgnoreCase("0"))||(docno.trim().equalsIgnoreCase(""))||(docno.isEmpty()))){
				sqltest=" and agmt.voc_no='"+docno+"'";
			}
			if(!(agmtbranch.equalsIgnoreCase(""))&& agmtbranch!=null){
				sqltest=sqltest+" and agmt.brhid='"+agmtbranch+"'";
			}
			if(!((fleet.equalsIgnoreCase("0"))||(fleet.trim().equalsIgnoreCase(""))||(fleet.isEmpty()))){
				if(agmttype.equalsIgnoreCase("RAG")){
					sqltest=sqltest+" and agmt.fleet_no like '%"+fleet+"%'";
				}
				else if(agmttype.equalsIgnoreCase("LAG")){
					sqltest=sqltest+" and agmt.perfleet like '%"+fleet+"%' or agmt.tmpfleet like '%"+fleet+"%'";
				}

			}
			if(!((regno.equalsIgnoreCase("0"))||(regno.trim().equalsIgnoreCase(""))||(regno.isEmpty()))){
				sqltest=sqltest+" and veh.reg_no like '%"+regno+"%'";
			}
			if(!((client.equalsIgnoreCase("0"))||(client.trim().equalsIgnoreCase(""))||(client.isEmpty()))){
				sqltest=sqltest+" and ac.refname like '%"+client+"%'";
			}
			if(!((mobile.equalsIgnoreCase("0"))||(mobile.trim().equalsIgnoreCase(""))||(mobile.isEmpty()))){
				sqltest=sqltest+" and ac.per_mob like '%"+mobile+"%'";
			}
			
			java.sql.Date sqlsearchdate=null;
			if(!(date.equalsIgnoreCase("0")||date.equalsIgnoreCase(null)||date.equalsIgnoreCase(""))){
				sqlsearchdate=objcommon.changeStringtoSqlDate(date);
			}
			if(!(sqlsearchdate==null)){
				sqltest=sqltest+" and agmt.date='"+sqlsearchdate+"'";
			}
			//System.out.println("DOCNO:"+docno+"FLEET:"+fleet+"REGNO:"+regno+"CLIENT:"+client+"DATE:"+date+"MOBILE:"+mobile);
			JSONArray jsonArray = new JSONArray();
//		System.out.println("AGMT"+agmttype);
		if(agmttype.equalsIgnoreCase("")){
			conn.close();
			return RESULTDATA;
		}
			if(agmttype.equalsIgnoreCase("RAG")){
				strSql="select agmt.doc_no,agmt.voc_no,agmt.date,mov.fleet_no,mov.dout,mov.tout,round(mov.kmout,2) kmout,mov.trancode infleettrancode,mov.fout,"+
" mov.obrhid,mov.olocid,veh.flname,veh.reg_no,ac.refname,br.branchname,loc.loc_name from gl_ragmt agmt inner join gl_vmove mov on"+
" (agmt.doc_no=mov.rdocno and mov.rdtype='RAG' and mov.status='OUT') left join gl_vehmaster veh on agmt.fleet_no=veh.fleet_no"+
"  left join my_acbook ac on (agmt.cldocno=ac.cldocno and ac.dtype='CRM') left join my_brch br on agmt.brhid=br.doc_no left join"+
"  my_locm loc on mov.olocid=loc.doc_no left join (select max(doc_no) maxdoc ,rdocno,rtype from gl_vehreplace where status<>7 group by rdocno,rtype)"+
"  aa on (aa.rdocno=agmt.doc_no and aa.rtype='RAG') left join gl_vehreplace rep on (rep.doc_no=aa.maxdoc) where mov.status='OUT' and"+
"  coalesce(rep.closestatus=1,1) "+sqltest+" and (agmt.delivery=0 or (agmt.delivery=1 and agmt.delstatus=1)) order by agmt.doc_no";
				
			}
			else if(agmttype.equalsIgnoreCase("LAG")){
			strSql="select agmt.doc_no,agmt.voc_no,agmt.date,mov.fleet_no,mov.dout,mov.tout,round(mov.kmout,2) kmout,mov.trancode infleettrancode,mov.fout,mov.obrhid,mov.olocid,"+
					" veh.flname,veh.reg_no,ac.refname,br.branchname,loc.loc_name from gl_lagmt agmt left join gl_vmove mov on"+
					" (agmt.doc_no=mov.rdocno and mov.rdtype='LAG') left join gl_vehmaster veh on mov.fleet_no=veh.fleet_no"+
					" left join my_acbook ac on (agmt.cldocno=ac.cldocno and ac.dtype='CRM') left join my_brch br on mov.obrhid=br.doc_no left join"+
					" my_locm loc on mov.olocid=loc.doc_no  left join (select max(doc_no) maxdoc ,rdocno,rtype from gl_vehreplace  where status<>7 group by rdocno,rtype)"+
"  aa on (aa.rdocno=agmt.doc_no and aa.rtype='LAG') left join gl_vehreplace rep on (rep.doc_no=aa.maxdoc) where mov.status='OUT' and"+
"  coalesce(rep.closestatus=1,1) "+sqltest+"  and (agmt.delivery=0 or (agmt.delivery=1 and agmt.delstatus=1)) order by agmt.doc_no";
			}
			System.out.println("Agmt  Search Query:"+strSql);
			if(!(strSql.equalsIgnoreCase(""))){
				ResultSet resultSet = stmtmanual.executeQuery (strSql);

				RESULTDATA=objcommon.convertToJSON(resultSet);
	
			}
						stmtmanual.close();
			conn.close();
			
//			System.out.println(strSql);
			
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		//System.out.println("RESULTDATA=========>"+RESULTDATA);
	    return RESULTDATA;
	}
	
	
	 public  JSONArray mainSearch(String client,String reftype,String searchdate,String agmtno,String fleetno,String docno) throws SQLException {

	        JSONArray RESULTDATA=new JSONArray();
	        Connection conn=null;
	        try {    	
	       // String brnchid=session.getAttribute("BRANCHID").toString();
	    	//System.out.println("name"+sclname);
	    	
	    	String sqltest="";
	    	java.sql.Date sqldate=null;
	    	if(!(searchdate.equalsIgnoreCase(""))){
	    		sqldate=objcommon.changeStringtoSqlDate(searchdate);	
	    	}
	    	
	    	if(!(client.equalsIgnoreCase(""))){
	    		sqltest=sqltest+" and ac.refname like '%"+client+"%'";
	    	}
	    	if(!(reftype.equalsIgnoreCase(""))){
	    		sqltest=sqltest+" and rep.rtype like '%"+reftype+"%'";
	    	}
	    	if(!(agmtno.equalsIgnoreCase(""))){
	    		if(reftype.equalsIgnoreCase("RAG")){
	    			sqltest=sqltest+" and ragmt.voc_no like '%"+agmtno+"%'";
	    		}
	    		else if(reftype.equalsIgnoreCase("LAG")){
	    			sqltest=sqltest+" and lagmt.voc_no like '%"+agmtno+"%'";
	    		}
	    		
	    	}
	    	if(!(fleetno.equalsIgnoreCase(""))){
	    		sqltest=sqltest+" and rep.rfleetno like '%"+fleetno+"%'";
	    	}
	    	if(!(docno.equalsIgnoreCase(""))){
	    		sqltest=sqltest+" and rep.doc_no='"+docno+"'";
	    	}
	    	
	    	 if(sqldate!=null){
	    		 sqltest=sqltest+" and rep.date='"+sqldate+"'";
	    	 }
	        
	    	 conn = objconn.getMyConnection();
			
					
					Statement stmtsearch = conn.createStatement ();
					String str1Sql="select rep.doc_no,rep.date,rep.rtype,rep.rdocno,if(rep.rtype='RAG',ragmt.voc_no,lagmt.voc_no) rdocvocno,rep.rfleetno,ac.refname from gl_vehreplace rep left join gl_ragmt ragmt on "+
							" (rep.rdocno=ragmt.doc_no and rep.rtype='RAG') left join gl_lagmt lagmt on (rep.rdocno=lagmt.doc_no and rtype='LAG') left join "+
							" my_acbook ac on(ragmt.cldocno=ac.cldocno or lagmt.cldocno=ac.cldocno) and dtype='crm' where 1=1 and rep.status=3 "+sqltest+" group by rep.doc_no";
					// System.out.println("=========="+str1Sql);
					ResultSet resultSet = stmtsearch.executeQuery (str1Sql);
					RESULTDATA=objcommon.convertToJSON(resultSet);
					stmtsearch.close();
					conn.close();
					return RESULTDATA;
			}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
	        finally{
				conn.close();
			}
	        //System.out.println(RESULTDATA);
			conn.close();
	        return RESULTDATA;
	    }
	public  JSONArray getOutFleetSearch(String branch,String searchdate,String fleetno,String docno,String regno,String color,String group) throws SQLException {
	    List<ClsReplacementAlFahimBean> invoicebean = new ArrayList<ClsReplacementAlFahimBean>();
	  String strSql="";
	  
	    JSONArray RESULTDATA=new JSONArray();
	    Connection conn =null;
	    try {
	    	conn = objconn.getMyConnection();
	    	String sqltest="";
	    	java.sql.Date sqldate=null;
	    	if(!(searchdate.equalsIgnoreCase(""))){
	    		sqldate=objcommon.changeStringtoSqlDate(searchdate);
	    	}
	    	if(sqldate!=null){
	    		sqltest=sqltest+" and veh.date='"+sqldate+"'";
	    	}
	    	if(!(docno.equalsIgnoreCase("") || docno.equalsIgnoreCase("0"))){
				sqltest=sqltest+" and veh.doc_no like '%"+docno+"%'";
			}
			if(!(fleetno.equalsIgnoreCase("") || fleetno.equalsIgnoreCase("0"))){
				sqltest=sqltest+" and veh.fleet_no like '%"+fleetno+"%'";
			}
			if(!(regno.equalsIgnoreCase("") || regno.equalsIgnoreCase("0"))){
				sqltest=sqltest+" and veh.reg_no like '%"+regno+"%'";
			}
			
			if(!(group.equalsIgnoreCase("") || group.equalsIgnoreCase("0"))){
				sqltest=sqltest+" and veh.vgrpid like '%"+group+"%'";
			}
			if(!(color.equalsIgnoreCase("") || color.equalsIgnoreCase("0"))){
				sqltest=sqltest+" and veh.clrid like '%"+color+"%'";
			}
	    	Statement stmtmanual = conn.createStatement ();
			JSONArray jsonArray = new JSONArray();
			System.out.println("Sqltest:"+sqltest);
			int insurexpiry=0,regexpiry=0;
			String strgetconfig="select (select method from gl_config where field_nme='InsurExpiry') insurexpiry,(select method from gl_config where field_nme='RegExpiry') regexpiry";
			ResultSet rsconfig=stmtmanual.executeQuery(strgetconfig);
			while(rsconfig.next()){
				insurexpiry=rsconfig.getInt("insurexpiry");
				regexpiry=rsconfig.getInt("regexpiry");
			}
			String sqlexpiry="";
			
			if(insurexpiry==1){
				sqlexpiry+=" and veh.ins_exp > CURDATE()";
			}
			if(regexpiry==1){
				sqlexpiry+=" and veh.reg_exp > CURDATE()";
			}
			strSql="select clr.color,grp.gid,veh.doc_no,veh.date,veh.fleet_no,veh.flname,veh.reg_no,mov.din,mov.tin,round(mov.kmin,0) kmin,round(mov.fin,3) fin,mov.ibrhid,mov.ilocid,"+
					" br.branchname,loc.loc_name from gl_vmove mov left join gl_vehmaster veh on mov.fleet_no=veh.fleet_no left join gl_vehgroup grp on "+
					" veh.vgrpid=grp.doc_no left join my_color clr on veh.clrid=clr.doc_no left join my_brch br on"+
					" mov.ibrhid=br.doc_no left join my_locm loc on mov.ilocid=loc.doc_no where veh.status='IN' and veh.tran_code='RR' and mov.doc_no=(select max(doc_no) from"+
					" gl_vmove where fleet_no=veh.fleet_no)and veh.statu<>7 "+sqlexpiry+" and veh.a_br="+branch+" "+sqltest;
			System.out.println("Out fleet Query:"+strSql);
			ResultSet resultSet = stmtmanual.executeQuery (strSql);

			RESULTDATA=objcommon.convertToJSON(resultSet);
			stmtmanual.close();
			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
	    finally{
			conn.close();
		}
		//System.out.println("RESULTDATA=========>"+RESULTDATA);
	    return RESULTDATA;
	}
	public   JSONArray getSearchData() throws SQLException {
	    List<ClsReplacementAlFahimBean> replacementbean = new ArrayList<ClsReplacementAlFahimBean>();
	  String strSql="";
	    JSONArray RESULTDATA=new JSONArray();
	    Connection conn = null;
	    try {
	    	conn = objconn.getMyConnection();
			Statement stmtmanual = conn.createStatement ();
			JSONArray jsonArray = new JSONArray();
			strSql="select doc_no,date,rfleetno from gl_vehreplace where status<>7";
			ResultSet resultSet = stmtmanual.executeQuery (strSql);
			RESULTDATA=objcommon.convertToJSON(resultSet);
			stmtmanual.close();
			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
	    finally{
			conn.close();
		}
		//System.out.println("RESULTDATA=========>"+RESULTDATA);
	    return RESULTDATA;
	}
	public   JSONArray getDriverData(HttpSession session) throws SQLException {
	    List<ClsReplacementAlFahimBean> replacementbean = new ArrayList<ClsReplacementAlFahimBean>();
	  String strSql="";
	    JSONArray RESULTDATA=new JSONArray();
	    Connection conn =null;
	    try {
	    	conn = objconn.getMyConnection();
			Statement stmtmanual = conn.createStatement ();
			JSONArray jsonArray = new JSONArray();
//			System.out.println("DAO SESSION"+session.getAttribute("BRANCHID").toString());
			/*strSql="select trim(name) name,dr_id,led from gl_drdetails where branch='"+session.getAttribute("BRANCHID").toString()+"' and dtype='DRV'";*/
			strSql="select trim(sal_name) name,doc_no dr_id,lic_exp_dt led from my_salesman where sal_type='DRV'";
//			System.out.println("Driver Search "+strSql);
			ResultSet resultSet = stmtmanual.executeQuery (strSql);
			RESULTDATA=objcommon.convertToJSON(resultSet);
			stmtmanual.close();
			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
	    finally{
			conn.close();
		}
		//System.out.println("RESULTDATA=========>"+RESULTDATA);
	    return RESULTDATA;
	}
	public int insert(Date date, String cmbrentaltype,String refno,String txtfleetno,Date dateout,String timeout,double kmout,String cmbfuel,String cmbtrreason,String cmbreplacetype,
			String mode,HttpSession session,String dtype,String hidtxtbranch,String hidtxtlocation,Date incollectdate,String incollecttime,String incollectkm,String cmbincollectfuel,
			String cmbinbranch,String cmbinlocation,String hidoutbranch,String txtoutfleetno,Date ondeliverydate,String ondeliverytime,String ondeliverykm,String cmbondeliveryfuel,
			int hidchkcollection,int hidchkdelivery,String hidoutlocation,String formdetailcode,Date deliveryoutdate,String deliveryouttime,String deliveryoutkm,
			String cmbdeliveryoutfuel,String infleettrancode,String hidcollectdriver,String description) throws SQLException {
		
		Connection conn=null;
		try{
//			System.out.println("Here in DAO");
			int aaa=0;
			int cldoc=0;
			//System.out.println(hidtxtbranch+"::"+hidtxtlocation+"::"+hidoutbranch+"::"+hidoutlocation);
//System.out.println("DAO Fuel:"+cmbfuel);
			conn = objconn.getMyConnection();
System.out.println("Session Check:"+session.getAttribute("BRANCHID").toString());
conn.setAutoCommit(false);
			Statement stmtcldoc=conn.createStatement();
			String strcldoc="";
			if(cmbrentaltype.equalsIgnoreCase("RAG")){
				strcldoc="select cldocno from gl_ragmt where doc_no="+refno;
			}
			else if(cmbrentaltype.equalsIgnoreCase("LAG")){
				strcldoc="select cldocno from gl_lagmt where doc_no="+refno;
			}
			ResultSet rscldoc=stmtcldoc.executeQuery(strcldoc);
			while(rscldoc.next()){
				cldoc=rscldoc.getInt("cldocno");
			}
			stmtcldoc.close();
if(deliveryoutkm.equalsIgnoreCase("")){
	deliveryoutkm="0";
}
String strSql="";
String strSql2="";
if(hidoutlocation.equalsIgnoreCase("")||(hidoutlocation.equalsIgnoreCase("NA"))){
	hidoutlocation="0";
}
if(ondeliverykm.equalsIgnoreCase("")){
	ondeliverykm="0";
}
Statement stmtReplacement = conn.createStatement ();
int testdoc=0;
ResultSet rsdoc=stmtReplacement.executeQuery("select max(doc_no)+1 docno from gl_vehreplace");
while(rsdoc.next()){
	testdoc=rsdoc.getInt("docno");
	if(testdoc==0){
		testdoc=1;
	}
}
if(testdoc<=0){
	conn.close();
	return 0;
	
}
//System.out.println("update gl_vehmaster set status='IN',tran_code='"+cmbtrreason+"' where fleet_no='"+txtfleetno+"'");
//(select if(dtype='VEH','UR','NR'))

	
	int movdoc=0;
	int movparent=0;
	ResultSet rsmovdoc=stmtReplacement.executeQuery("select max(doc_no)+1 docno from gl_vmove");
	while(rsmovdoc.next()){
		movdoc=rsmovdoc.getInt("docno");
	}
	ResultSet rsmovparent=stmtReplacement.executeQuery("select max(doc_no) maxparent from gl_vmove where fleet_no='"+txtfleetno+"'");
	while(rsmovparent.next()){
		movparent=rsmovparent.getInt("maxparent");
	}
			if(cmbreplacetype.equalsIgnoreCase("atbranch")){
//				System.out.println("Here"+cmbreplacetype);
				strSql="insert into gl_vehreplace(doc_no,date,rtype,rdocno,rfleetno,rdate,rtime,rkm,rfuel,rbrhid,rlocid,trancode,reptype,userid,indate,intime,"+
						"inkm,infuel,inbrhid,inloc,obrhid,olocid,ofleetno,odate,otime,okm,ofuel,outuserid,delstatus,clstatus,status,closestatus,infleettrancode,description)values('"+testdoc+"','"+date+"','"+cmbrentaltype+"','"+refno+"',"+
						"'"+txtfleetno+"','"+dateout+"','"+timeout+"','"+kmout+"','"+cmbfuel+"','"+hidtxtbranch+"','"+hidtxtlocation+"','"+cmbtrreason+"','"+cmbreplacetype+"',"+
						"'"+session.getAttribute("USERID").toString()+"','"+incollectdate+"','"+incollecttime+"','"+incollectkm+"','"+cmbincollectfuel+"','"+cmbinbranch+"','"+cmbinlocation+"',"+
						"'"+hidoutbranch+"','"+hidoutlocation+"','"+txtoutfleetno+"','"+ondeliverydate+"','"+ondeliverytime+"','"+ondeliverykm+"','"+cmbondeliveryfuel+"','"+session.getAttribute("USERID").toString()+"',"+
						"'"+hidchkdelivery+"','"+hidchkcollection+"',3,1,'"+infleettrancode+"','"+description+"')";
//				System.out.println("Atbranch Insert"+strSql);
				int rsinsert=stmtReplacement.executeUpdate(strSql);
				if(rsinsert>0){
					int vehupdate=stmtReplacement.executeUpdate("update gl_vehmaster set status='IN',tran_code='UR',a_br='"+cmbinbranch+"',a_loc='"+cmbinlocation+"' where fleet_no='"+txtfleetno+"'");

					if(vehupdate>0){
//						System.out.println("Vehicle Master Updation Success");
						String temptran="";
						if(cmbrentaltype.equalsIgnoreCase("RAG")){
							temptran="RA";
						}
						else if(cmbrentaltype.equalsIgnoreCase("LAG")){
							temptran="LA";
						}
						int vehoutupdate=stmtReplacement.executeUpdate("update gl_vehmaster set status='OUT',tran_code='"+temptran+"',a_br='"+hidoutbranch+"',a_loc='"+hidoutlocation+"' where fleet_no='"+txtoutfleetno+"'");
						if(vehoutupdate<=0){
							return 0;
						}
					}
					else{
//						System.out.println("Vehicle master Update Failed");
						conn.close();
						return 0;
					}
					aaa=testdoc;
				}
				else{
					conn.close();
					return 0;
				}
				int rsinsert1=stmtReplacement.executeUpdate("insert into datalog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+testdoc+"',"+
						"'"+session.getAttribute("BRANCHID").toString()+"','"+dtype+"',now(),'"+session.getAttribute("USERID").toString()+"','A')");
//						System.out.println("Atbranch Datalog"+rsinsert1);
				if(rsinsert1>0){
//					System.out.println("Vehicle replace successfull");
						}
						else{
//							System.out.println("Datalog error");
							conn.close();
							return 0;
						}
			
			double totalkm=0.0,totalfuel=0.0,totaltime=0.0;
			String strmovcalc="select  TIMESTAMPDIFF(SECOND,ts_dout,ts_din)/60 totalmin,("+incollectkm+"-kmout) totalkm,("+cmbincollectfuel+"-fout) totalfuel from (select"+
					" cast(concat('"+incollectdate+"',' ','"+incollecttime+"') as datetime) ts_din, cast(concat(dout,' ',tout)as datetime)ts_dout,kmout,fout"+
					" from gl_vmove where fleet_no="+txtfleetno+" and status='OUT')m";
			ResultSet rsmovcalc=stmtReplacement.executeQuery(strmovcalc);
			
			while(rsmovcalc.next()){
				totalkm=rsmovcalc.getDouble("totalkm");
				totalfuel=rsmovcalc.getDouble("totalfuel");
				totaltime=rsmovcalc.getDouble("totalmin");
			}
			String strmovup="update gl_vmove set status='IN',repno='"+testdoc+"',din='"+incollectdate+"',tin='"+incollecttime+"',"+
	"kmin='"+incollectkm+"',fin='"+cmbincollectfuel+"',ibrhid='"+cmbinbranch+"',ilocid='"+cmbinlocation+"',ttime='"+totaltime+"',tkm='"+totalkm+"',tfuel='"+totalfuel+"' where "+
					" fleet_no='"+txtfleetno+"' and status='OUT'";
//			System.out.println("Atbranch mov update query:"+strmovup);
			int movupdate=stmtReplacement.executeUpdate(strmovup);
//			System.out.println("1st Movement Query:"+movupdate);
			if(movupdate>0){
//				System.out.println("1st Movement Updation Success");
				Statement stmtragupdate=conn.createStatement();
				String strragupdate="";
				if(cmbrentaltype.equalsIgnoreCase("RAG")){
					strragupdate="update gl_ragmt set fleet_no="+txtoutfleetno+" where doc_no="+refno;
				}
				else if(cmbrentaltype.equalsIgnoreCase("LAG")){
					strragupdate="update gl_lagmt set tmpfleet="+txtoutfleetno+" where doc_no="+refno;
				}
				int ragupdateval=stmtragupdate.executeUpdate(strragupdate);
				stmtragupdate.close();
				if(ragupdateval<=0){
					conn.close();
					return 0;
				}
				
			}
			else{
//				System.out.println("1st Movement Updation Failed");
				
				conn.close();
				return 0;
			}
			
			String strmovinserttemp="";
			double tempidle=0.0;
			 strmovinserttemp="select  TIMESTAMPDIFF(SECOND,ts_din,ts_dout)/60 tmin from (select  cast(concat(din,' ',tin) as datetime) ts_din,"+
					 " cast(concat('"+ondeliverydate+"',' ','"+ondeliverytime+"')as datetime)ts_dout  from gl_vmove where doc_no=(select max(doc_no) from gl_vmove where"+
					 " fleet_no="+txtfleetno+" ))m";
//			System.out.println("IDLE QUERY "+strmovinserttemp);
			ResultSet rsmovtemp=stmtReplacement.executeQuery(strmovinserttemp);
			while(rsmovtemp.next()){
				tempidle=rsmovtemp.getDouble("tmin");
			}
			String strmovinsert="insert into gl_vmove(doc_no,date,rdocno,rdtype,fleet_no,trancode,status,parent,repno,dout,tout,kmout,fout,obrhid,olocid,tideal,emp_id,emp_type)values("+
						"'"+movdoc+"',curdate(),'"+refno+"','"+cmbrentaltype+"','"+txtoutfleetno+"','"+infleettrancode+"','OUT','"+movparent+"','"+testdoc+"','"+ondeliverydate+"','"+ondeliverytime+"',"+
						"'"+ondeliverykm+"','"+cmbondeliveryfuel+"','"+hidoutbranch+"','"+hidoutlocation+"','"+tempidle+"',"+cldoc+",'CRM')";
			int movinsert=stmtReplacement.executeUpdate(strmovinsert);
			if(movinsert>0){
//				System.out.println("MOV INSERT AT BRANCH SUCCESS");
			}
			else{
//				System.out.println("MOV INSERT AT BRANCH FAILED");
				conn.close();
				return 0;
				
			}
			
			}
			if(cmbreplacetype.equalsIgnoreCase("collection")){
				
				strSql2="insert into gl_vehreplace(doc_no,date,rtype,rdocno,rfleetno,rdate,rtime,rkm,rfuel,rbrhid,rlocid,trancode,reptype,userid,obrhid,olocid,ofleetno,"+
				"odate,otime,okm,ofuel,outuserid,delstatus,clstatus,status,infleettrancode,description)values('"+testdoc+"','"+date+"','"+cmbrentaltype+"','"+refno+"','"+txtfleetno+"','"+dateout+"','"+timeout+"','"+kmout+"',"+
				"'"+cmbfuel+"','"+hidtxtbranch+"','"+hidtxtlocation+"','"+cmbtrreason+"','"+cmbreplacetype+"','"+session.getAttribute("USERID").toString()+"',"+
				"'"+hidoutbranch+"','"+hidoutlocation+"','"+txtoutfleetno+"','"+ondeliverydate+"','"+ondeliverytime+"','"+ondeliverykm+"','"+cmbondeliveryfuel+"','"+session.getAttribute("USERID").toString()+"',"+
				"'"+hidchkdelivery+"','"+hidchkcollection+"',3,'"+infleettrancode+"','"+description+"')";
//				System.out.println("Collection insert"+strSql2);
				int rsinsert22=stmtReplacement.executeUpdate("insert into datalog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+testdoc+"',"+
						"'"+session.getAttribute("BRANCHID").toString()+"','"+formdetailcode+"',now(),'"+session.getAttribute("USERID").toString()+"','A')");
//				System.out.println("Collection Datalog"+rsinsert22);

				if(rsinsert22>0){
				
				}
				else{
//					System.out.println("Datalog error");
					conn.close();
					return 0;
				}
				int rsinsert2=stmtReplacement.executeUpdate(strSql2);
			if(rsinsert2>0){
				aaa=testdoc;;
			}
			else{
				conn.close();
				return 0;
			}
	
			}
			String temptran="";
			if(cmbrentaltype.equalsIgnoreCase("RAG")){
				temptran="RA";
			}
			else if(cmbrentaltype.equalsIgnoreCase("LAG")){
				temptran="LA";
			}
			String strsqlveh="update gl_vehmaster set status='OUT',tran_code='"+temptran+"',a_br="+hidoutbranch+",a_loc="+hidoutlocation+" where fleet_no="+txtoutfleetno;
			int vehoutupdate=stmtReplacement.executeUpdate(strsqlveh);
			if(vehoutupdate<=0){
//				System.out.println("Vehicle Out Update Error");
				conn.close();
				return 0;
			}
			replacementbean.setDocno(aaa);
			if (aaa > 0) {
				System.out.println("Success"+replacementbean.getDocno());
				conn.commit();
				stmtReplacement.close();
				conn.close();
				return aaa;
			}
			stmtReplacement.close();
			conn.close();
		}catch(Exception e){	
		e.printStackTrace();
		conn.close();
		return 0;
		}
		finally{
			conn.close();
		}
		return 0;
	}
	public   ClsReplacementAlFahimBean getViewDetails(int docno) throws SQLException {
		ClsReplacementAlFahimBean bean = new ClsReplacementAlFahimBean();
		Connection conn =null;
		try {
			conn = objconn.getMyConnection();
			Statement stmtRep = conn.createStatement ();
			int i=0;
//			System.out.println("here in dao view details");
        	String strSql="";
        	strSql="select if(rep.rtype='RAG',agmt.brhid,lgmt.brhid) agmtbranch,if(rep.rtype='RAG',agmt.voc_no,lgmt.voc_no) refvocno,coalesce(rep.description,'') description,rep.infleettrancode,rep.outuserid,outuser.user_name outusername,coalesce(agmt.date,lgmt.date) agmtdate,ac.refname,rep.date,"+
        			" rep.rtype,rep.rdocno,rep.rfleetno,rep.rdate,rep.rtime,round(rep.rkm,0) rkm,round(rep.rfuel,3)"+
        			" rfuel,rep.rbrhid,rep.rlocid,rep.trancode,rep.reptype,rep.userid,rep.obrhid,rep.olocid,rep.ofleetno,rep.odate,rep.otime,"+
        			" round(rep.okm,0) okm,round(rep.ofuel,3) ofuel,rep.delstatus,rep.deldrvid,rep.deltime,rep.deldate,round(rep.delkm,0) delkm,"+
        			" round(rep.delfuel,3) delfuel,rep.delat,rep.indate,rep.intime,round(rep.inkm,0) inkm,round(rep.infuel,3) infuel,rep.inbrhid,"+
        			" rep.inloc,rep.clstatus,rep.cldrvid,rep.cldate,rep.cltime,round(rep.clkm,0) clkm,round(rep.clfuel,3)"+
        			" clfuel,veh.reg_no,veh.flname,br.branchname,loc.loc_name,usr.user_name,br1.branchname obranchname,loc1.loc_name olocname,"+
        			" veh1.flname oflname,veh1.reg_no oregno,dr.sal_name name,cdr.sal_name cname,ibr.branchname inbranch,iloc.loc_name inlocname from"+
        			" gl_vehreplace rep left join gl_ragmt agmt on rep.rdocno=agmt.doc_no left join gl_lagmt lgmt on (rep.rdocno=lgmt.doc_no and rep.rtype='LAG')"+
        			" left join my_acbook ac on (((agmt.cldocno=ac.cldocno and rep.rtype='RAG' and ac.dtype='CRM') or (lgmt.cldocno=ac.cldocno and rep.rtype='LAG' and ac.dtype='CRM'))"+
        			" ) left join gl_vehmaster veh on rep.rfleetno=veh.fleet_no left join my_brch br on rep.rbrhid=br.doc_no"+
        			" left join my_locm loc on rep.rlocid=loc.doc_no left join my_user usr on rep.userid=usr.doc_no left join my_user outuser on rep.outuserid=outuser.doc_no"+
        			" left join my_brch br1 on rep.obrhid=br1.doc_no left join my_locm loc1 on rep.olocid=loc1.doc_no left join gl_vehmaster veh1 on rep.ofleetno=veh1.fleet_no"+
        			" left join my_salesman dr on (rep.deldrvid=dr.doc_no and dr.sal_type='DRV') left join my_salesman cdr on (rep.cldrvid=cdr.doc_no"+
        			" and cdr.sal_type='DRV') left join my_brch ibr on rep.inbrhid=ibr.doc_no left join my_locm iloc on rep.inloc=iloc.doc_no"+
        			" where rep.doc_no="+docno;
//        	System.out.println(strSql);
			ResultSet resultSet = stmtRep.executeQuery (strSql);
			while (resultSet.next()) {
				bean.setCmbagmtbranch(resultSet.getString("agmtbranch"));
				bean.setHidcmbagmtbranch(resultSet.getString("agmtbranch"));
				bean.setRefvocno(resultSet.getString("refvocno"));
				bean.setDescription(resultSet.getString("description"));
				bean.setInfleettrancode(resultSet.getString("infleettrancode"));
				bean.setDate(resultSet.getDate("date").toString());
				bean.setRefdate(resultSet.getDate("agmtdate").toString());
				bean.setHidcmbrentaltype(resultSet.getString("rtype"));
				bean.setRefno(resultSet.getString("rdocno"));
				bean.setTxtfleetno(resultSet.getString("rfleetno"));
				if(!(resultSet.getDate("rdate")==null)){
				bean.setHiddateout(resultSet.getDate("rdate").toString());
				}
				bean.setHidtimeout(resultSet.getString("rtime"));
				bean.setOutkm(resultSet.getDouble("rkm"));
				bean.setHidcmbfuel(resultSet.getString("rfuel"));
//					System.out.println("Bean RFUEL"+bean.getHidcmbfuel());
				bean.setHidtxtbranch(resultSet.getString("rbrhid"));
				bean.setHidtxtlocation(resultSet.getString("rlocid"));
				bean.setHidcmbtrreason(resultSet.getString("trancode"));
//					System.out.println("Bean reason"+bean.getHidcmbtrreason());
				bean.setHidcmbreplacetype(resultSet.getString("reptype"));
				bean.setHiduser(resultSet.getString("userid"));
				bean.setHidoutuser(resultSet.getString("outuserid"));
				bean.setOutuser(resultSet.getString("outusername"));
				bean.setHidoutbranch(resultSet.getString("obrhid"));
				bean.setHidoutlocation(resultSet.getString("olocid"));
				bean.setTxtoutfleetno(resultSet.getString("ofleetno"));
				if(!(resultSet.getDate("odate")==null)){
					bean.setHidondeliverydate(resultSet.getDate("odate").toString());	
				}
				
				bean.setHidondeliverytime(resultSet.getString("otime"));
				bean.setOndeliverykm(resultSet.getString("okm"));
//				System.out.println("Out KM:"+bean.getOndeliverykm());
				bean.setHidcmbondeliveryfuel(resultSet.getString("ofuel"));
				bean.setHidchkdelivery(resultSet.getInt("delstatus"));
				bean.setHiddeliverydriver(resultSet.getString("deldrvid"));
				if(!(resultSet.getDate("deldate")==null))
				bean.setHiddeliveryoutdate(resultSet.getDate("deldate").toString());
				bean.setHiddeliveryouttime(resultSet.getString("deltime"));
				bean.setDeliveryoutkm(resultSet.getString("delkm"));
				bean.setHidcmbdeliveryoutfuel(resultSet.getString("delfuel"));
				bean.setDeliveryto(resultSet.getString("delat"));
				if(!(resultSet.getDate("indate")==null)){
				bean.setHidincollectdate(resultSet.getDate("indate").toString());
				}
				bean.setHidincollecttime(resultSet.getString("intime"));
				bean.setIncollectkm(resultSet.getString("inkm"));
				bean.setHidcmbincollectfuel(resultSet.getString("infuel"));
//				System.out.println("In fuel in dao:"+bean.getHidcmbincollectfuel());
				bean.setHidcmbinbranch(resultSet.getString("inbrhid"));
//					System.out.println("BEAN INBRANCHID"+bean.getHidcmbinbranch());
				bean.setHidcmbinlocation(resultSet.getString("inloc"));
//					System.out.println("BEAN LOCATIONID"+bean.getHidcmbinlocation());
				bean.setHidchkcollection(resultSet.getInt("clstatus"));
				bean.setHidcollectdriver(resultSet.getString("cldrvid"));
				if(!((resultSet.getDate("cldate")==null)||(resultSet.getString("cldate").equalsIgnoreCase("")))){
				bean.setHidoncollectdate(resultSet.getDate("cldate").toString());
				}
				bean.setHidoncollecttime(resultSet.getString("cltime"));
				bean.setOncollectkm(resultSet.getString("clkm"));
				bean.setHidcmboncollectfuel(resultSet.getString("clfuel"));
				String tempmaster="";
				tempmaster=resultSet.getString("flname");
				tempmaster=tempmaster+"Reg No: "+resultSet.getString("reg_no");
				bean.setTxtfleetname(tempmaster);
				bean.setTxtbranch(resultSet.getString("branchname"));
				bean.setTxtlocation(resultSet.getString("loc_name"));
				bean.setUser(resultSet.getString("user_name"));
				bean.setOutbranch(resultSet.getString("obranchname"));
				bean.setOutlocation(resultSet.getString("olocname"));
				String outtemp="";
				outtemp=resultSet.getString("oflname");
				outtemp=outtemp+"Reg No: "+resultSet.getString("oregno");
				bean.setTxtoutfleetname(outtemp);
				bean.setDeliverydriver(resultSet.getString("name"));
				bean.setCollectdriver(resultSet.getString("cname"));
				bean.setRefname(resultSet.getString("refname"));
				bean.setDocno(docno);
			}
			stmtRep.close();
			conn.close();
	}
		catch(Exception e){
			e.printStackTrace();
			bean.setDocno(0);
			conn.close();
			return bean;
		}
		finally{
			conn.close();
		}
		
		return bean;
	}
	
	public int update(int docno, int hidchkdelivery, String hidcollectdriver,
			Date oncollectdate, String oncollecttime, String oncollectkm,
			String cmboncollectfuel, int hidchkcollection,
			String hiddeliverydriver, Date deliveryoutdate,
			String deliveryouttime, String deliveryoutkm,
			String cmbdeliveryoutfuel, String deliveryto,String refno,String txtfleetno,String cmbinbranch,String cmbinlocation,
			Date incollectdate,String incollecttime,String incollectkm,String cmbincollectfuel,Date ondeliverydate,String ondeliverytime,
			String ondeliverykm,String cmbondeliveryfuel,String txtoutfleetno,String hidoutbranch,String hidoutlocation,String cmbtrreason,Date date,
			Date dateout,Date refdate,String infleettrancode,String cmbrentaltype) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn =null;
		System.out.println(hidoutbranch+"::"+hidoutlocation);
		try {
			conn = objconn.getMyConnection();
		conn.setAutoCommit(false);
		int cldoc=0;
		Statement stmtcldoc=conn.createStatement();
		String strcldoc="";
		
		if(cmbrentaltype.equalsIgnoreCase("RAG")){
			strcldoc="select cldocno from gl_ragmt where doc_no="+refno;
		}
		else if(cmbrentaltype.equalsIgnoreCase("LAG")){
			strcldoc="select cldocno from gl_lagmt where doc_no="+refno;
		}
		ResultSet rscldoc=stmtcldoc.executeQuery(strcldoc);
		while(rscldoc.next()){
			cldoc=rscldoc.getInt("cldocno");
		}
		stmtcldoc.close();
		Statement stmtRep = conn.createStatement ();
		int finaldoc=0;
//		System.out.println("Collection: "+hidchkcollection+" Delivery: "+hidchkdelivery);
		Statement stmtReplacement=conn.createStatement();
		int vehupdate=stmtReplacement.executeUpdate("update gl_vehmaster set status='IN',tran_code='UR',a_br='"+cmbinbranch+"',a_loc='"+cmbinlocation+"' where fleet_no='"+txtfleetno+"'");

		if(vehupdate>0){
//			System.out.println("Vehicle Master Updation Success");
		}
		else{
			System.out.println("Vehicle master Update Failed");
			conn.close();
			return 0;
		}
		stmtReplacement.close();
		if(hidchkcollection==1){
			String strsql="update gl_vehreplace set clstatus=1,cldrvid='"+hidcollectdriver+"',cldate='"+oncollectdate+"',cltime='"+oncollecttime+"',"+
					"clkm='"+oncollectkm+"',clfuel='"+cmboncollectfuel+"',indate='"+incollectdate+"',intime='"+incollecttime+"',inkm='"+incollectkm+"',"+
					" infuel='"+cmbincollectfuel+"',inbrhid='"+cmbinbranch+"',inloc='"+cmbinlocation+"',closestatus=1 where doc_no='"+docno+"'";
//			System.out.println("Replace Query"+strsql);
			int rsupdate1=stmtRep.executeUpdate(strsql);
			if(rsupdate1>0){
//				System.out.println("Collection Update Success");
				finaldoc=rsupdate1;
			}
			else{
				System.out.println("Collection Update Error");
				conn.close();
				return 0;
			}
			int movdoc=0;
			ResultSet rsmovdoc=stmtRep.executeQuery("select max(doc_no)+1 mvdocno from gl_vmove");
			while(rsmovdoc.next()){
				movdoc=rsmovdoc.getInt("mvdocno");
			}
			int movparent=0;
			double movidle=0.0;
			ResultSet rsmovparent=stmtRep.executeQuery("select max(doc_no) mvparent from gl_vmove where fleet_no='"+txtfleetno+"'");
			while(rsmovparent.next()){
				movparent=rsmovparent.getInt("mvparent");
			}
			double totalkm=0.0,totalfuel=0.0,totaltime=0.0;
			/*String strcalctest="select  TIMESTAMPDIFF(SECOND,ts_din,ts_dout)/60"+
	" totalmin,(kmout-"+oncollectkm+") totalkm,(fout-"+cmboncollectfuel+") totalfuel from (select  cast(concat('"+oncollectdate+"',' ','"+oncollecttime+"') as datetime) "+
					" ts_din, cast(concat(dout,' ',tout)as datetime)ts_dout,kmout,fout from gl_vmove where doc_no='"+movparent+"')m";*/
			String strcalctest="select  TIMESTAMPDIFF(SECOND,ts_dout,ts_din)/60 totalmin,("+oncollectkm+"-kmout) totalkm,("+cmboncollectfuel+"-fout) totalfuel from"+
					" (select  cast(concat('"+oncollectdate+"',' ','"+oncollecttime+"') as datetime)"+
					" ts_din, cast(concat(dout,' ',tout)as datetime)ts_dout,kmout,fout from gl_vmove where doc_no="+movparent+")m";
//			System.out.println("gettotal collection update"+strcalctest);
			ResultSet rscalctest=stmtRep.executeQuery(strcalctest);
			while(rscalctest.next()){
				totalkm=rscalctest.getDouble("totalkm");
				totalfuel=rscalctest.getDouble("totalfuel");
				totaltime=rscalctest.getDouble("totalmin");
			}
			String strcolmovupdate="update gl_vmove set status='IN',din='"+oncollectdate+"',tin='"+oncollecttime+"',kmin='"+oncollectkm+"',fin='"+cmboncollectfuel+"',"+
			" ibrhid='"+cmbinbranch+"',ilocid='"+cmbinlocation+"',ttime='"+totaltime+"',tkm='"+totalkm+"',tfuel='"+totalfuel+"' where fleet_no='"+txtfleetno+"' and status='OUT'";
//			System.out.println("Mov Update with collection details"+strcolmovupdate);
			int colmovupdate=stmtRep.executeUpdate(strcolmovupdate);
			if(colmovupdate>0){
//				System.out.println("Mov Update with Collection:Sucess");
			}
			else{
				System.out.println("Mov Update with Collection:Fail");
				conn.close();
				return 0;
			}
		
		/*	ResultSet rscollectidle=stmtRep.executeQuery("select  TIMESTAMPDIFF(SECOND,ts_dout,ts_din)/60 tmin from (select  cast(concat(din,' ',tin) as datetime) ts_din,"+
		" cast(concat('"+oncollectdate+"',' ','"+oncollecttime+"')as datetime)ts_dout  from gl_vmove where doc_no='"+movparent+"')m");*/
			ResultSet rscollectidle=stmtRep.executeQuery("select  TIMESTAMPDIFF(SECOND,ts_din,ts_dout)/60 tmin from (select  cast(concat(din,' ',tin) as datetime) ts_din,"+
					" cast(concat('"+oncollectdate+"',' ','"+oncollecttime+"')as datetime)ts_dout  from gl_vmove where doc_no="+movparent+")m");
			while(rscollectidle.next()){
				movidle=rscollectidle.getDouble("tmin");
			}
			String strmovcollectinsert="insert into gl_vmove(doc_no,date,rdocno,rdtype,fleet_no,trancode,status,parent,repno,dout,tout,kmout,fout,obrhid,olocid,tideal,emp_id,emp_type)"+
					" values('"+movdoc+"',CURDATE(),'"+refno+"','"+cmbrentaltype+"','"+txtfleetno+"','DL','OUT','"+movparent+"','"+docno+"','"+oncollectdate+"','"+oncollecttime+"','"+oncollectkm+"',"+
					" '"+cmboncollectfuel+"','"+cmbinbranch+"','"+cmbinlocation+"','"+movidle+"',"+hidcollectdriver+",'DRV')";
//			System.out.println("Colletion Insert Vmove"+strmovcollectinsert);
			int movcollectinsert=stmtRep.executeUpdate(strmovcollectinsert);
			if(movcollectinsert>0){
//				System.out.println("collection movement Insert Success");
		}
		else{
			System.out.println("collection movement Insert Fail");
			conn.close();
			return 0;
		}
			double totalkm2=0.0,totalfuel2=0.0,totaltime2=0.0;
			String strcalctest2="select  TIMESTAMPDIFF(SECOND,ts_dout,ts_din)/60"+
	" totalmin,("+incollectkm+"-kmout) totalkm,("+cmbincollectfuel+"-fout) totalfuel from (select  cast(concat('"+incollectdate+"',' ','"+incollecttime+"') as datetime) "+
					" ts_din, cast(concat(dout,' ',tout)as datetime)ts_dout,kmout,fout from gl_vmove where doc_no='"+movparent+"')m";
			ResultSet rscalctest2=stmtRep.executeQuery(strcalctest2);
			while(rscalctest2.next()){
				totalkm2=rscalctest2.getDouble("totalkm");
				totalfuel2=rscalctest2.getDouble("totalfuel");
				totaltime2=rscalctest2.getDouble("totalmin");
			}
			String strmovcollectupdate="update gl_vmove set status='IN',din='"+incollectdate+"',tin='"+incollecttime+"',kmin='"+incollectkm+"',fin='"+cmbincollectfuel+"'"+
		" ,ibrhid='"+cmbinbranch+"',ilocid='"+cmbinlocation+"',ttime='"+totaltime+"',tkm='"+totalkm+"',tfuel='"+totalfuel+"' where fleet_no='"+txtfleetno+"' and status='OUT'";
//		System.out.println("Collect Mov Update"+strmovcollectupdate);
			int movcollectupdate=stmtRep.executeUpdate(strmovcollectupdate);
			if(movcollectupdate>0){
//				System.out.println("Movement Collect Update Success");
			}
			else{
				System.out.println("Movement Collect Update Fail");
				conn.close();
				return 0;
			}
		}
		if(hidchkcollection==1 && hidchkdelivery==0){
		/*	int movdoc=0;
			ResultSet rsmovdoc=stmtRep.executeQuery("select max(doc_no)+1 mvdocno from gl_vmove");
			while(rsmovdoc.next()){
				movdoc=rsmovdoc.getInt("mvdocno");
			}
			int movparent=0;
			double movidle=0.0;
			ResultSet rsmovparent=stmtRep.executeQuery("select max(doc_no) mvparent from gl_vmove where fleet_no='"+txtfleetno+"'");
			while(rsmovparent.next()){
				movparent=rsmovparent.getInt("mvparent");
			}
			double totalkm=0.0,totalfuel=0.0,totaltime=0.0;
			String strcalctest="select  TIMESTAMPDIFF(SECOND,ts_din,ts_dout)/60"+
	" totalmin,(kmout-"+oncollectkm+") totalkm,(fout-"+cmboncollectfuel+") totalfuel from (select  cast(concat('"+oncollectdate+"',' ','"+oncollecttime+"') as datetime) "+
					" ts_din, cast(concat(dout,' ',tout)as datetime)ts_dout,kmout,fout from gl_vmove where doc_no='"+movparent+"')m";
			String strcalctest="select  TIMESTAMPDIFF(SECOND,ts_dout,ts_din)/60 totalmin,("+incollectkm+"-kmout) totalkm,("+cmbincollectfuel+"-fout) totalfuel from"+
					" (select  cast(concat('"+incollectdate+"',' ','"+incollecttime+"') as datetime)"+
					" ts_din, cast(concat(dout,' ',tout)as datetime)ts_dout,kmout,fout from gl_vmove where doc_no="+movparent+")m";
//			System.out.println("gettotal collection update"+strcalctest);
			ResultSet rscalctest=stmtRep.executeQuery(strcalctest);
			while(rscalctest.next()){
				totalkm=rscalctest.getDouble("totalkm");
				totalfuel=rscalctest.getDouble("totalfuel");
				totaltime=rscalctest.getDouble("totalmin");
			}
			String strcolmovupdate="update gl_vmove set status='IN',din='"+incollectdate+"',tin='"+incollecttime+"',kmin='"+incollectkm+"',fin='"+cmbincollectfuel+"',"+
			" ibrhid='"+cmbinbranch+"',ilocid='"+cmbinlocation+"',ttime='"+totaltime+"',tkm='"+totalkm+"',tfuel='"+totalfuel+"' where fleet_no='"+txtfleetno+"' and status='OUT'";
//			System.out.println("Mov Update with collection details"+strcolmovupdate);
			int colmovupdate=stmtRep.executeUpdate(strcolmovupdate);
			if(colmovupdate>0){
//				System.out.println("Mov Update with Collection:Sucess");
			}
			else{
				System.out.println("Mov Update with Collection:Fail");
				return 0;
			}*/
			int movdoc2=0;
			ResultSet rsmovdoc2=stmtRep.executeQuery("select max(doc_no)+1 mvdocno from gl_vmove");
			while(rsmovdoc2.next()){
				movdoc2=rsmovdoc2.getInt("mvdocno");
			}
			int movparent2=0;
			double movidle2=0.0;
			ResultSet rsmovparent2=stmtRep.executeQuery("select max(doc_no) mvparent from gl_vmove where fleet_no='"+txtfleetno+"'");
			while(rsmovparent2.next()){
				movparent2=rsmovparent2.getInt("mvparent");
			}
			ResultSet rscollectidle2=stmtRep.executeQuery("select  TIMESTAMPDIFF(SECOND,ts_din,ts_dout)/60 tmin from (select  cast(concat(din,' ',tin) as datetime) ts_din,"+
					" cast(concat('"+ondeliverydate+"',' ','"+ondeliverytime+"')as datetime)ts_dout  from gl_vmove where doc_no='"+movparent2+"')m");
						while(rscollectidle2.next()){
							movidle2=rscollectidle2.getDouble("tmin");
						}
			String strdelmovinsert="insert into gl_vmove(doc_no,date,rdocno,rdtype,fleet_no,trancode,status,parent,repno,dout,tout,kmout,fout,obrhid,olocid,tideal,emp_id,emp_type)values("+
		"'"+movdoc2+"',curdate(),'"+refno+"','"+cmbrentaltype+"','"+txtoutfleetno+"','"+infleettrancode+"','OUT','"+movparent2+"','"+docno+"','"+ondeliverydate+"','"+ondeliverytime+"','"+ondeliverykm+"',"+
					"'"+cmbondeliveryfuel+"','"+hidoutbranch+"','"+hidoutlocation+"','"+movidle2+"',"+cldoc+",'CRM')";
//			System.out.println("Out Info Vmove"+strdelmovinsert);
			int delmovinsert=stmtRep.executeUpdate(strdelmovinsert);
			if(delmovinsert>0){
				Statement stmtagmtupdate=conn.createStatement();
				String stragmtupdate="";
				if(cmbrentaltype.equalsIgnoreCase("RAG")){
					stragmtupdate="update gl_ragmt set fleet_no="+txtoutfleetno+" where doc_no="+refno;
				}
				else if(cmbrentaltype.equalsIgnoreCase("LAG")){
					stragmtupdate="update gl_lagmt set tmpfleet="+txtoutfleetno+" where doc_no="+refno;
				}
				int ragupdateval=stmtagmtupdate.executeUpdate(stragmtupdate);
				stmtagmtupdate.close();
				if(ragupdateval<=0){
					System.out.println("Agreement Fleet Update Fail");
					conn.close();
					return 0;
				}
				finaldoc=delmovinsert;
//				System.out.println("Out insert Vmove Sucess");
			}
			else{
				System.out.println("Out insert Vmove Fail");
				conn.close();
				return 0;
			}	
		}
		if(hidchkcollection==0 && hidchkdelivery==1){
			int movdoc=0;
			ResultSet rsmovdoc=stmtRep.executeQuery("select max(doc_no)+1 mvdocno from gl_vmove");
			while(rsmovdoc.next()){
				movdoc=rsmovdoc.getInt("mvdocno");
			}
			int movparent=0;
			double movidle=0.0;
			ResultSet rsmovparent=stmtRep.executeQuery("select max(doc_no) mvparent from gl_vmove where fleet_no='"+txtfleetno+"'");
			while(rsmovparent.next()){
				movparent=rsmovparent.getInt("mvparent");
			}
			double totalkm=0.0,totalfuel=0.0,totaltime=0.0;
			String strcalctest="select  TIMESTAMPDIFF(SECOND,ts_din,ts_dout)/60"+
	" totalmin,(kmout-"+incollectkm+") totalkm,(fout-"+cmbincollectfuel+") totalfuel from (select  cast(concat('"+incollectdate+"',' ','"+incollecttime+"') as datetime) "+
					" ts_din, cast(concat(dout,' ',tout)as datetime)ts_dout,kmout,fout from gl_vmove where doc_no='"+movparent+"')m";
			/*String strcalctest="select  TIMESTAMPDIFF(SECOND,ts_dout,ts_din)/60 totalmin,("+incollectkm+"-kmout) totalkm,("+cmbincollectfuel+"-fout) totalfuel from"+
					" (select  cast(concat('"+incollectdate+"',' ','"+incollecttime+"') as datetime)"+
					" ts_din, cast(concat(dout,' ',tout)as datetime)ts_dout,kmout,fout from gl_vmove where doc_no="+movparent+")m";*/
//			System.out.println("gettotal collection update"+strcalctest);
			ResultSet rscalctest=stmtRep.executeQuery(strcalctest);
			while(rscalctest.next()){
				totalkm=rscalctest.getDouble("totalkm");
				totalfuel=rscalctest.getDouble("totalfuel");
				totaltime=rscalctest.getDouble("totalmin");
			}
			String strcolmovupdate="update gl_vmove set status='IN',din='"+incollectdate+"',tin='"+incollecttime+"',kmin='"+incollectkm+"',fin='"+cmbincollectfuel+"',"+
			" ibrhid='"+cmbinbranch+"',ilocid='"+cmbinlocation+"',ttime='"+totaltime+"',tkm='"+totalkm+"',tfuel='"+totalfuel+"' where fleet_no='"+txtfleetno+"' and status='OUT'";
			System.out.println("Mov Update with collection details"+strcolmovupdate);
			int colmovupdate=stmtRep.executeUpdate(strcolmovupdate);
			if(colmovupdate>0){
//				System.out.println("Mov Update with Collection:Sucess");
			}
			else{
				System.out.println("Mov Update with Collection:Fail");
				conn.close();
				return 0;
			}
			Statement stmtupdateindata=conn.createStatement();
			
			String strupdateindata="update gl_vehreplace set intime='"+incollecttime+"',indate='"+incollectdate+"',"+
								" inkm='"+incollectkm+"',infuel='"+cmbincollectfuel+"',inbrhid='"+cmbinbranch+"',inloc='"+cmbinlocation+"',closestatus=1 where doc_no='"+docno+"'";
			int val=stmtupdateindata.executeUpdate(strupdateindata);
			finaldoc=val;
			if(val<=0){
				System.out.println("In Data Update Error");
				conn.close();
				return 0;
			}
		}
		if(hidchkdelivery==1){
			int movdoc=0;
			ResultSet rsmovdoc=stmtRep.executeQuery("select max(doc_no)+1 mvdocno from gl_vmove");
			while(rsmovdoc.next()){
				movdoc=rsmovdoc.getInt("mvdocno");
			}
			int movparent=0;
			double movidle=0.0;
			ResultSet rsmovparent=stmtRep.executeQuery("select max(doc_no) mvparent from gl_vmove where fleet_no='"+txtfleetno+"'");
			while(rsmovparent.next()){
				movparent=rsmovparent.getInt("mvparent");
			}
			ResultSet rscollectidle=stmtRep.executeQuery("select  TIMESTAMPDIFF(SECOND,ts_din,ts_dout)/60 tmin from (select  cast(concat(din,' ',tin) as datetime) ts_din,"+
					" cast(concat('"+ondeliverydate+"',' ','"+ondeliverytime+"')as datetime)ts_dout  from gl_vmove where doc_no='"+movparent+"')m");
						while(rscollectidle.next()){
							movidle=rscollectidle.getDouble("tmin");
						}
			String strdelmovinsert="insert into gl_vmove(doc_no,date,rdocno,rdtype,fleet_no,trancode,status,parent,repno,dout,tout,kmout,fout,obrhid,olocid,tideal,emp_id,emp_type)values("+
		"'"+movdoc+"',curdate(),'"+refno+"','"+cmbrentaltype+"','"+txtoutfleetno+"','DL','OUT','"+movparent+"','"+docno+"','"+ondeliverydate+"','"+ondeliverytime+"','"+ondeliverykm+"',"+
					"'"+cmbondeliveryfuel+"','"+hidoutbranch+"','"+hidoutlocation+"','"+movidle+"',"+hiddeliverydriver+",'DRV')";
//			System.out.println("Out Info Vmove"+strdelmovinsert);
			int delmovinsert=stmtRep.executeUpdate(strdelmovinsert);
			if(delmovinsert>0){
//				System.out.println("Out insert Vmove Sucess");
			}
			else{
				System.out.println("Out insert Vmove Fail");
				conn.close();
				return 0;
			}
			double totalkm3=0.0,totalfuel3=0.0,totaltime3=0.0;
			String strcalctest3="select  TIMESTAMPDIFF(SECOND,ts_dout,ts_din)/60"+
	" totalmin,("+incollectkm+"-kmout) totalkm,("+cmbincollectfuel+"-fout) totalfuel from (select  cast(concat('"+deliveryoutdate+"',' ','"+deliveryouttime+"') as datetime) "+
					" ts_din, cast(concat(dout,' ',tout)as datetime)ts_dout,kmout,fout from gl_vmove where doc_no='"+movparent+"')m";
			ResultSet rscalctest3=stmtRep.executeQuery(strcalctest3);
			while(rscalctest3.next()){
				totalkm3=rscalctest3.getDouble("totalkm");
				totalfuel3=rscalctest3.getDouble("totalfuel");
				totaltime3=rscalctest3.getDouble("totalmin");
			}
			String strdelmovupdate="update gl_vmove set status='IN',din='"+deliveryoutdate+"',tin='"+deliveryouttime+"',kmin='"+deliveryoutkm+"',fin='"+cmbdeliveryoutfuel+"',"+
					"ibrhid='"+hidoutbranch+"',ilocid='"+hidoutlocation+"',ttime='"+totaltime3+"',tkm='"+totalkm3+"',tfuel='"+totalfuel3+"' where fleet_no='"+txtoutfleetno+"' and status='OUT'";
//			System.out.println("Delivery vmove Update1"+strdelmovupdate);
			int delmovupdate=stmtRep.executeUpdate(strdelmovupdate);
			if(delmovupdate>0){
//				System.out.println("Delivery Vmove Update1 Success");
			}
			else{
				System.out.println("Delivery Vmove Update1 Fail");
				conn.close();
				return 0;
			}
			int delmovdoc=0;
			ResultSet rsdelmovdoc=stmtRep.executeQuery("select max(doc_no)+1 mvdocno from gl_vmove");
			while(rsdelmovdoc.next()){
				delmovdoc=rsdelmovdoc.getInt("mvdocno");
			}
			int delmovparent=0;
			double delmovidle=0.0;
			ResultSet rsdelmovparent=stmtRep.executeQuery("select max(doc_no) mvparent from gl_vmove where fleet_no='"+txtoutfleetno+"'");
			while(rsdelmovparent.next()){
				delmovparent=rsdelmovparent.getInt("mvparent");
			}
			ResultSet rsdelmovidle=stmtRep.executeQuery("select  TIMESTAMPDIFF(SECOND,ts_din,ts_dout)/60 tmin from (select  cast(concat(din,' ',tin) as datetime) ts_din,"+
					" cast(concat('"+deliveryoutdate+"',' ','"+deliveryouttime+"')as datetime)ts_dout  from gl_vmove where doc_no='"+delmovparent+"')m");
						while(rsdelmovidle.next()){
							delmovidle=rsdelmovidle.getDouble("tmin");
						}
			String strdelmovinsert2="insert into gl_vmove(doc_no,date,rdocno,rdtype,fleet_no,trancode,status,parent,repno,dout,tout,kmout,fout,obrhid,olocid,tideal,emp_id,emp_type)values("+
			"'"+delmovdoc+"',curdate(),'"+refno+"','"+cmbrentaltype+"','"+txtoutfleetno+"','"+infleettrancode+"','OUT','"+delmovparent+"','"+docno+"','"+deliveryoutdate+"',"+
			"'"+deliveryouttime+"','"+deliveryoutkm+"','"+cmbdeliveryoutfuel+"','"+hidoutbranch+"','"+hidoutlocation+"','"+delmovidle+"',"+cldoc+",'CRM')";
//			System.out.println("Delivery Mov Insert2"+strdelmovinsert2);
			int delmovinsert2=stmtRep.executeUpdate(strdelmovinsert2);
			if(delmovinsert2>0){
//				System.out.println("Del vmove insert success");
				Statement stmtagmtupdate=conn.createStatement();
				String stragmtupdate="";
				if(cmbrentaltype.equalsIgnoreCase("RAG")){
					stragmtupdate="update gl_ragmt set fleet_no="+txtoutfleetno+" where doc_no="+refno;
				}
				else if(cmbrentaltype.equalsIgnoreCase("LAG")){
					stragmtupdate="update gl_lagmt set tmpfleet="+txtoutfleetno+" where doc_no="+refno;
				}
				int ragupdateval=stmtagmtupdate.executeUpdate(stragmtupdate);
				stmtagmtupdate.close();
				if(ragupdateval<=0){
					System.out.println("Agreement Fleet Update Fail 2");
					conn.close();
					return 0;
				}
				
				
			}
			else{
				System.out.println("Del vmove inser fail");
				conn.close();
				return 0;
			}
			String strsql="update gl_vehreplace set delstatus=1,deldrvid='"+hiddeliverydriver+"',deltime='"+deliveryouttime+"',deldate='"+deliveryoutdate+"',"+
							" delkm='"+deliveryoutkm+"',delfuel='"+cmbdeliveryoutfuel+"',delat='"+deliveryto+"' where doc_no='"+docno+"'";
			int rsupdate2=stmtRep.executeUpdate(strsql);
			if(rsupdate2>0){
				
//				System.out.println("Delivery Update Success");
			}
			else{
				System.out.println("Delivery Update Error");
				conn.close();
				return 0;
			}
		}
		
		
		if(finaldoc>0){
			conn.commit();
			stmtRep.close();
			return finaldoc;
		}
		stmtRep.close();
		conn.close();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return 0;
		}
		finally{
			conn.close();
		}
		return 0;
	}
	public int delete(int docno, String formdetailcode, String brchname,String agmttype,String agmtno,HttpSession session) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn=null;
		try{
			conn = objconn.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmtdelete=conn.createStatement();
			String strclosesql="";
			String strlastreplace="";
			String strlastrepmov="";
			String strreplace="";
			String strmovdelete="";
			String strnewupdate="";
			String stragmtupdate="";
			String strvehupdate="";
			String strdeletefleet="";
			int replacemaxdoc=0;
			int closestatus=0;
			int lastmovstatus=-1;
			int newmaxdoc=0;
			int  deletedfleet=0; 
			int mainfleet=0;
		//Checking Agreement is closed	
			if(agmttype.equalsIgnoreCase("RAG")){
				strclosesql="select clstatus from gl_ragmt where doc_no="+agmtno;
			}
			else if(agmttype.equalsIgnoreCase("LAG")){
				strclosesql="select clstatus from gl_lagmt where doc_no="+agmtno;
			}
			ResultSet rsclose=stmtdelete.executeQuery(strclosesql);
			while(rsclose.next()){
				closestatus=rsclose.getInt("clstatus");
			}
			if(closestatus==1){
				return -1;//Agreement is Closed
			}
			
		//Checking replacement is last
			strlastreplace="select max(doc_no) maxdoc from gl_vehreplace where rtype='"+agmttype+"' and rdocno="+agmtno;
			ResultSet rsrepmaxdoc=stmtdelete.executeQuery(strlastreplace);
			while(rsrepmaxdoc.next()){
				replacemaxdoc=rsrepmaxdoc.getInt("maxdoc");
			}
			if(docno!=replacemaxdoc){
				return -2;//Replacement is not last
			}
			
		//Checking Last Movement of Corresponding agreement
			
			ResultSet rsmainfleet=stmtdelete.executeQuery("select fleet_no from gl_vmove where doc_no=(select max(doc_no) from gl_vmove where rdocno="+agmtno+" and rdtype='"+agmttype+"')");
			
			while(rsmainfleet.next()){
				mainfleet=rsmainfleet.getInt("fleet_no");
			}
			strlastrepmov="select if(rdocno="+agmtno+" and rdtype='"+agmttype+"' and repno="+docno+",1,0) lastmov from gl_vmove where doc_no= "+
						" (select max(doc_no) from gl_vmove where rdtype='"+agmttype+"'and rdocno="+agmtno+" and fleet_no="+mainfleet+")";
			ResultSet rslastmov=stmtdelete.executeQuery(strlastrepmov);
			while(rslastmov.next()){
				lastmovstatus=rslastmov.getInt("lastmov");
			}
			if(lastmovstatus==0){
				return -3;//Found Another Movement Against corresponding  agreement
			}
			
		//Changing status in gl_vehreplace
			
			strreplace="update gl_vehreplace set status=7 where doc_no="+docno;
			int replaceval=stmtdelete.executeUpdate(strreplace);
			if(replaceval<=0){
				System.out.println("Failed to Update status in gl_vehreplace");
				return 0;
			}
			
		//Deleting entries corresponding to replacement from gl_vmove;
			
			strmovdelete="delete from gl_vmove where rdtype='"+agmttype+"' and rdocno='"+agmtno+"' and repno="+docno;
			int movdeleteval=stmtdelete.executeUpdate(strmovdelete);
			if(movdeleteval<=0){
				System.out.println("Failed to delete rows from gl_vmove");
				return 0;
			}
			
		//Getting max(doc_no) from gl_vmove after delete
			
			ResultSet rsnewmaxdoc=stmtdelete.executeQuery("select max(doc_no) maxdoc from gl_vmove where rdocno="+agmtno+" and rdtype='"+agmttype+"'");
			while(rsnewmaxdoc.next()){
				newmaxdoc=rsnewmaxdoc.getInt("maxdoc");
			}
			
		//Updating row Corressponding to old replacement/agreement
			
			strnewupdate="update gl_vmove set status='OUT',din=null,tin=null,kmin=null,fin=null,ibrhid=null,ilocid=null,ireason=null,ttime=null,tkm=null,"+
						" tfuel=null where doc_no="+newmaxdoc;
			int movupdateval=stmtdelete.executeUpdate(strnewupdate);
			if(movupdateval<=0){
				System.out.println("Failed to  Update vmove with out details");
				return 0;
			}
			
		//Updating Agreement Fleet_no
			
			if(agmttype.equalsIgnoreCase("RAG")){
				stragmtupdate="update gl_ragmt set fleet_no=(select fleet_no from gl_vmove where doc_no="+newmaxdoc+") where doc_no="+agmtno;
			}
			else if(agmttype.equalsIgnoreCase("LAG")){
				stragmtupdate="update gl_lagmt set tmpfleet=(select fleet_no from gl_vmove where doc_no="+newmaxdoc+") where doc_no="+agmtno;
			}
			
			int agmtupdateval=stmtdelete.executeUpdate(stragmtupdate);
			if(agmtupdateval<=0){
				System.out.println("Failed to update agreement table");
				return 0;
			}
			
			
		//Updating trancode,status in gl_vehmaster
			
			if(agmttype.equalsIgnoreCase("RAG")){
				strvehupdate="update gl_vehmaster set tran_code='RA',status='OUT' where fleet_no=(select fleet_no from gl_vmove where doc_no="+newmaxdoc+")";	
			}
			else if(agmttype.equalsIgnoreCase("LAG")){
				strvehupdate="update gl_vehmaster set tran_code='LA',status='OUT' where fleet_no=(select fleet_no from gl_vmove where doc_no="+newmaxdoc+")";
			}
			
			int vehupdateval=stmtdelete.executeUpdate(strvehupdate);
			if(vehupdateval<=0){
				System.out.println("Failed to update last fleet_no of agreement");
				return 0;
			}
		//Fetching fleet from deleted replacement
			
			strdeletefleet="select ofleetno from gl_vehreplace where doc_no="+docno;
			ResultSet rsdeletefleet=stmtdelete.executeQuery(strdeletefleet);
			while(rsdeletefleet.next()){
				deletedfleet=rsdeletefleet.getInt("ofleetno");
			}
			
		//Updating trancode,status of deleted fleet in gl_vehmaster
			
			int updatedeletefleet=stmtdelete.executeUpdate("update gl_vehmaster set tran_code='RR',status='IN' where fleet_no="+deletedfleet);
			if(updatedeletefleet<=0){
				System.out.println("Failed to update trancode,status of deleted replacement fleet");
				return 0;
			}
		//Inserting into datalog
			
			int logval=stmtdelete.executeUpdate("insert into datalog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docno+"',"+
					"'"+brchname+"','"+formdetailcode+"',now(),'"+session.getAttribute("USERID").toString()+"','D')");
			if(logval<=0){
				System.out.println("Failed to insert to datalog");
				return 0;
			}
			
			conn.commit();
			stmtdelete.close();
			
		}catch(Exception e){	
		e.printStackTrace();	
		}
		finally{
			conn.close();
		}
		return 1;
	}
	
	public   ClsReplacementAlFahimBean getPrint(int docno) throws SQLException {
		 ClsReplacementAlFahimBean printbean = new ClsReplacementAlFahimBean();
		 Connection conn = null; 
		 try {
			 conn = objconn.getMyConnection();
	       Statement stmtpaint = conn.createStatement();
	       String strSql="";
	   
	      strSql=("select coalesce(dr.name,dr1.name) drivenby,coalesce(r.description,'') description,deldrv.sal_name deldriver,coldrv.sal_name coldriver,"+
	    		  " outloc.loc_name outloc,inloc.loc_name inloc,v.flname infleetname,v1.flname outfleetname,loc.loc_name,r.delstatus delstatus1,r.clstatus,"+
	    		  " usr.user_name,opusr.user_name openuser,main.branchname mainbrch,inbr.branchname inandcolbrch,outbr.branchname outanddelbrch,st.st_desc,"+
	    		  " ac.acno,ac.refname,r.reptype,r.DOC_NO,DATE_FORMAT(r.DATE,'%d-%m-%Y') DATE,if(r.RTYPE='RAG','Rental','Lease') rtype,if(r.RTYPE='RAG',agmt.voc_no,lagmt.voc_no) agmtno,r.RDOCNO,r.RFLEETNO,"+
	    		  " DATE_FORMAT(r.RDATE,'%d-%m-%Y') RDATE,r.RTIME,round(r.RKM) rkm,r.RFUEL 'RFUEL',r.RLOCID,r.TRANCODE,r.REPTYPE,r.USERID,"+
	    		  " r.OBRHID,r.OLOCID,r.OFLEETNO,DATE_FORMAT(r.ODATE,'%d-%m-%Y') odate,r.OTIME,round(r.OKM) okm,r.ofuel 'ofuel',"+
	    		  " if(r.DELSTATUS=0,'NO','YES') delstatus ,r.DELDRVID,r.DELTIME,DATE_FORMAT(r.DELDATE,'%d-%m-%Y') DELDATE,round(r.DELKM) delkm,"+
	    		  " r.DELFUEL 'DELFUEL',r.DELAT,DATE_FORMAT(r.INDATE,'%d-%m-%Y') indate,r.INTIME,round(r.INKM) inkm,r.INFUEL 'infuel',r.INLOC,"+
	    		  " r.CLSTATUS,r.CLDRVID,DATE_FORMAT(r.CLDATE,'%d-%m-%Y') cldate,r.CLTIME,round(r.CLKM) clkm,r.CLFUEL 'CLFUEL', v.flname,"+
	    		  " concat(au.authid,'-',p.code_name,'-',v.reg_no) reg_no , concat(au1.authid,'-',p1.code_name,'-',v1.reg_no) reg_no2 from"+
	    		  " gl_vehreplace r left join gl_vehmaster v on v.fleet_no=r.rfleetno  left join gl_vehplate p on p.doc_no=v.pltid left join"+
	    		  " gl_vehauth au on au.doc_no=v.authid left join gl_vehmaster v1 on v1.fleet_no=r.OFLEETNO  left join gl_vehplate p1 on"+
	    		  " p1.doc_no=v1.pltid left join gl_vehauth au1 on au1.doc_no=v1.authid left join my_brch main on r.rbrhid=main.doc_no"+
	    		  " left join my_brch inbr on r.INBRHID=inbr.doc_no left join my_brch outbr on r.OBRHID=outbr.doc_no left join my_locm loc on"+
	    		  " r.rlocid=loc.doc_no left join gl_ragmt agmt on (r.rdocno=agmt.doc_no and r.rtype='RAG') left join gl_lagmt lagmt on"+
	    		  " (r.rdocno=lagmt.doc_no and r.rtype='LAG') left join my_acbook ac on (((agmt.cldocno=ac.cldocno and r.rtype='RAG' and ac.dtype='CRM') or (lagmt.cldocno=ac.cldocno and r.rtype='LAG'))"+
	    		  " and ac.dtype='CRM') left join gl_rdriver rdr on agmt.doc_no=rdr.rdocno left join gl_ldriver ldr on lagmt.doc_no=ldr.rdocno"+
	    		  " left join gl_drdetails dr on ((rdr.drid=dr.dr_id or ldr.drid=dr.dr_id) and dr.dtype='CRM')"+
	    		  " left join gl_drdetails dr1 on ((agmt.drid=dr1.doc_no or lagmt.drid=dr1.doc_no) and dr1.dtype='DRV')"+
	    		  " left join gl_status st on st.status=r.trancode  left join my_user usr on usr.doc_no=r.userid"+
	    		  " left join my_user opusr on opusr.doc_no=r.outuserid left join my_locm outloc on r.olocid=outloc.doc_no left join my_locm inloc"+
	    		  " on r.inloc=inloc.doc_no left join my_salesman deldrv on (r.deldrvid=deldrv.doc_no and deldrv.sal_type='DRV') left join my_salesman"+
	    		  " coldrv on (r.cldrvid=coldrv.doc_no and coldrv.sal_type='DRV' )where r.doc_no="+docno+" ");
		       
	      // concat('On',' ',DATE_FORMAT(edate, '%d-%m-%Y'),' ','at',' ',DATE_FORMAT(edate, '%H:%i')) opendate

	       ResultSet resultSet = stmtpaint.executeQuery(strSql); 
	       
	      ClsCommon common=new ClsCommon();
	       while(resultSet.next()){
	    	   
	    	   printbean.setLbldrivenby(resultSet.getString("drivenby"));
	    	   printbean.setLbldescription(resultSet.getString("description"));
	    	   printbean.setLblcoldriver(resultSet.getString("coldriver"));
	    	   printbean.setLbldeldriver(resultSet.getString("deldriver"));
	    	   printbean.setBrwithcompany(" "+resultSet.getString("mainbrch"));
	    	   printbean.setVrano(resultSet.getString("agmtno"));
	    	   printbean.setMtime(resultSet.getString("RTIME"));
	    	   printbean.setPfleetno(resultSet.getString("RFLEETNO"));
	    	   printbean.setPfuel(common.checkFuelName(conn,resultSet.getString("RFUEL")));
	    	   printbean.setPclient(resultSet.getString("refname"));
	    	   printbean.setClientacno(resultSet.getString("acno"));
	    	   printbean.setAgmt(" "+resultSet.getString("rtype"));
	    	   printbean.setPdocno(" "+resultSet.getString("doc_no"));
	    	   printbean.setPdate(resultSet.getString("date"));
	    	   printbean.setPregno(resultSet.getString("reg_no"));
	    	   printbean.setVradate(resultSet.getString("RDATE"));
	    	   printbean.setDtimes(resultSet.getString("rtime"));
	    	   
	    	   printbean.setPopened(resultSet.getString("openuser"));
	    	   printbean.setReplaced(resultSet.getString("user_name"));
	    	   printbean.setLbloutlocation(resultSet.getString("outloc"));
	    	   printbean.setLblinlocation(resultSet.getString("inloc"));
	    	   
	    	   if(resultSet.getString("reptype").equalsIgnoreCase("collection")){
	    		   printbean.setReptype("Collection");   
	    	   }
	    	   else{
	    		   printbean.setReptype("At Branch");
	    	   }

	    	   printbean.setPkm(resultSet.getString("rkm"));
	    	   printbean.setPoutdate(resultSet.getString("rdate")); 
	    	   printbean.setPdelivery(resultSet.getString("delstatus")); 
	    	   printbean.setLblrlocation(resultSet.getString("loc_name"));
	    	   
	    // in
	    	   printbean.setInbrwithcompany(resultSet.getString("inandcolbrch"));
	    	   printbean.setInvehdate(resultSet.getString("indate"));
	    	   printbean.setInvehtime(resultSet.getString("intime"));
	    	   printbean.setInvehkm(resultSet.getString("inkm"));
	    	   printbean.setInvehfuel(common.checkFuelName(conn,resultSet.getString("INFUEL")));
	    	   printbean.setInvehreason(resultSet.getString("st_desc"));
	    	   printbean.setLblinfleetname(resultSet.getString("infleetname"));
	    	   
// new out
	    	   printbean.setNewbrwithcompany(resultSet.getString("outanddelbrch"));
	    	   printbean.setNewvehoutdate(resultSet.getString("odate"));
	    	   printbean.setNewvehouttime(resultSet.getString("otime"));
	    	   printbean.setNewvehfleet(resultSet.getString("ofleetno"));
	    	   printbean.setNewvehregno(resultSet.getString("reg_no2"));
	    	   printbean.setLbloutfleetname(resultSet.getString("outfleetname"));
	    	   
	    	   printbean.setNewvehkm(resultSet.getString("okm"));
	    	   printbean.setNewvehfuel(common.checkFuelName(conn, resultSet.getString("oFUEL")));
	 // del
	    	   printbean.setDelbrwithcompany(resultSet.getString("outanddelbrch"));
	    	   printbean.setDeldate(resultSet.getString("deldate"));
	    	   printbean.setDeltime(resultSet.getString("deltime"));
	    	   printbean.setDelfleet(resultSet.getString("ofleetno"));
	    	   printbean.setDelregno(resultSet.getString("reg_no2"));
	    	   printbean.setDelkm(resultSet.getString("delkm"));
	    	   printbean.setDelfuel(common.checkFuelName(conn,resultSet.getString("delfuel")));
	    	   printbean.setLbldelivery(resultSet.getString("delstatus1"));
	    	   printbean.setLbldelfleetname(resultSet.getString("outfleetname"));
	  //col
	    	   printbean.setColbrwithcompany(resultSet.getString("inandcolbrch"));
	    	   printbean.setColdate(resultSet.getString("cldate"));
	    	   printbean.setColtime(resultSet.getString("cltime"));
	    	   printbean.setColfleet(resultSet.getString("rfleetno"));
	    	   printbean.setColregno(resultSet.getString("reg_no"));
	    	   printbean.setColkm(resultSet.getString("clkm"));
	    	   printbean.setColfuel(common.checkFuelName(conn,resultSet.getString("clfuel"))); 
	    	   printbean.setLblcollection(resultSet.getString("clstatus"));
	    	   printbean.setLblcolfleetname(resultSet.getString("infleetname"));
	    	   
	    	   
	    	   
	    	   
	       }
	       
	       stmtpaint.close();
	       
	       
	       Statement stmtinvoice10 = conn.createStatement ();
		    String  companysql="select c.company,c.address,c.tel,c.fax,l.loc_name location,b.branchname from gl_vehreplace r  "
		    		+ " left join my_brch b on r.rbrhid=b.doc_no left join my_locm l on l.brhid=b.doc_no "
		    		+ "left join my_comp c on b.cmpid=c.doc_no where r.doc_no="+docno+"  ";

		    
	         ResultSet resultsetcompany = stmtinvoice10.executeQuery(companysql); 
		       
		       while(resultsetcompany.next()){
		    	   
		  
		    	   printbean.setBarnchval(resultsetcompany.getString("branchname"));
		    	   printbean.setCompanyname(resultsetcompany.getString("company"));
		    	  
		    	   printbean.setAddress(resultsetcompany.getString("address"));
		    	 
		    	   printbean.setMobileno(resultsetcompany.getString("tel"));
		    	  
		    	   printbean.setFax(resultsetcompany.getString("fax"));
		    	   printbean.setLocation(resultsetcompany.getString("location"));
		    	  
		    	   
		    	   
		       } 
		       stmtinvoice10.close();
	       
	       
	       conn.close();
	      }
	      catch(Exception e){
	       e.printStackTrace();
	      conn.close();
	      }
		 finally{
				conn.close();
			}
	      return printbean;
	     }


}
