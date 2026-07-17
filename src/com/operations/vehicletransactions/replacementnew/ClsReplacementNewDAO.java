package com.operations.vehicletransactions.replacementnew;

import java.sql.CallableStatement;
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

public class ClsReplacementNewDAO {
	ClsCommon objcommon=new ClsCommon();
	ClsConnection objconn=new ClsConnection();
	public   JSONArray mainSearch(String client,String reftype,String searchdate,String agmtno,String fleetno,String docno) throws SQLException {

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
	    			sqltest=sqltest+" and agmt.voc_no like '%"+agmtno+"%'";	
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
					String str1Sql="select if(rep.rtype='RAG',ragmt.voc_no,lagmt.voc_no) refvocno,rep.doc_no,rep.date,rep.rtype,rep.rdocno,rep.rfleetno,ac.refname from gl_vehreplace rep left join gl_ragmt ragmt on "+
							" (rep.rdocno=ragmt.doc_no and rep.rtype='RAG') left join gl_lagmt lagmt on (rep.rdocno=lagmt.doc_no and rtype='LAG') left join "+
							" my_acbook ac on(ragmt.cldocno=ac.cldocno or lagmt.cldocno=ac.cldocno) where 1=1 and rep.status<>7 "+sqltest+" group by rep.doc_no";
//					System.out.println("=========="+str1Sql);
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
	 
	 
	 
	 
	 public   ClsReplacementNewBean getViewDetails(int docno) throws SQLException {
			ClsReplacementNewBean bean = new ClsReplacementNewBean();
			Connection conn =null;
			try {
				conn = objconn.getMyConnection();
				Statement stmtRep = conn.createStatement ();
				int i=0;
//				System.out.println("here in dao view details");
	        	String strSql="";
	        	strSql="select if(rep.rtype='RAG',agmt.brhid,lgmt.brhid) agmtbranch,if(rep.rtype='RAG',agmt.voc_no,lgmt.voc_no) refvocno,coalesce(rep.description,'') description,rep.outuserid,outuser.user_name outusername,coalesce(agmt.date,lgmt.date) agmtdate,ac.refname,rep.date,rep.rtype,rep.rdocno,"+ 
	        			" rep.rfleetno,rep.rdate,rep.rtime,round(rep.rkm,0) rkm,round(rep.rfuel,3)"+
	        			" rfuel,rep.rbrhid,rep.rlocid,rep.trancode,rep.reptype,rep.userid,rep.obrhid,rep.olocid,rep.ofleetno,rep.odate,rep.otime,"+
	        			" round(rep.okm,0) okm,round(rep.ofuel,3) ofuel,rep.delstatus,rep.deldrvid,rep.deltime,rep.deldate,round(rep.delkm,0) delkm,"+
	        			" round(rep.delfuel,3) delfuel,rep.delat,rep.indate,rep.intime,round(rep.inkm,0) inkm,round(rep.infuel,3) infuel,rep.inbrhid,"+
	        			" rep.inloc,rep.clstatus,rep.cldrvid,rep.cldate,rep.cltime,round(rep.clkm,0) clkm,round(rep.clfuel,3)"+
	        			" clfuel,veh.reg_no,veh.flname,br.branchname,loc.loc_name,usr.user_name,br1.branchname obranchname,loc1.loc_name olocname,"+
	        			" veh1.flname oflname,veh1.reg_no oregno,dr.sal_name name,cdr.sal_name cname,ibr.branchname inbranch,iloc.loc_name inlocname from"+
	        			" gl_vehreplace rep left join gl_ragmt agmt on rep.rdocno=agmt.doc_no left join gl_lagmt lgmt on (rep.rdocno=lgmt.doc_no and rep.rtype='lAG') "
	        			+ "left join my_acbook ac on ((agmt.cldocno=ac.cldocno or lgmt.cldocno=ac.cldocno) "+
	        			" and ac.dtype='CRM') left join gl_vehmaster veh on rep.rfleetno=veh.fleet_no left join my_brch br on rep.rbrhid=br.doc_no"+
	        			" left join my_locm loc on rep.rlocid=loc.doc_no left join my_user usr on rep.userid=usr.doc_no left join my_user outuser on rep.outuserid=outuser.doc_no "+
	        			" left join my_brch br1 on rep.obrhid=br1.doc_no left join my_locm loc1 on rep.olocid=loc1.doc_no left join gl_vehmaster veh1 on rep.ofleetno=veh1.fleet_no"+
	        			" left join my_salesman dr on (rep.deldrvid=dr.doc_no and dr.sal_type='DRV') left join my_salesman cdr on (rep.cldrvid=cdr.doc_no"+
	        			" and cdr.sal_type='DRV') left join my_brch ibr on rep.inbrhid=ibr.doc_no left join my_locm iloc on rep.inloc=iloc.doc_no"+
	        			" where rep.doc_no='"+docno+"'";
	        	System.out.println(strSql);
				ResultSet resultSet = stmtRep.executeQuery (strSql);
				while (resultSet.next()) {
					bean.setCmbagmtbranch(resultSet.getString("agmtbranch"));
					bean.setRefvocno(resultSet.getString("refvocno"));
					bean.setDescription(resultSet.getString("description"));
					bean.setCmbreplacetype(resultSet.getString("reptype"));
					if(Double.parseDouble(resultSet.getString("inkm")==null?"0":resultSet.getString("inkm"))>0){
						bean.setStatus("close");
					}
					else{
						bean.setStatus("open");
					}
					if(resultSet.getDate("date")!=null){
					bean.setDate(resultSet.getDate("date").toString());
					}
					if(resultSet.getDate("agmtdate")!=null){
						bean.setRefdate(resultSet.getDate("agmtdate").toString());
					}
					bean.setHidcmbrentaltype(resultSet.getString("rtype"));
					bean.setRefno(resultSet.getString("rdocno"));
					bean.setTxtfleetno(resultSet.getString("rfleetno"));
					if(resultSet.getDate("rdate")!=null){
					bean.setDateout(resultSet.getDate("rdate").toString());
					}
					bean.setHidtimeout(resultSet.getString("rtime"));
					bean.setOutkm(resultSet.getDouble("rkm"));
					bean.setHidcmbfuel(resultSet.getString("rfuel"));
//						System.out.println("Bean RFUEL"+bean.getHidcmbfuel());
					bean.setHidtxtbranch(resultSet.getString("rbrhid"));
					bean.setHidtxtlocation(resultSet.getString("rlocid"));
					bean.setHidcmbtrreason(resultSet.getString("trancode"));
					String tempmaster="";
					tempmaster=resultSet.getString("flname");
					tempmaster=tempmaster+"Reg No: "+resultSet.getString("reg_no");
					bean.setTxtfleetname(tempmaster);
					bean.setTxtbranch(resultSet.getString("branchname"));
					bean.setTxtlocation(resultSet.getString("loc_name"));
					bean.setUser(resultSet.getString("user_name"));

					bean.setRefname(resultSet.getString("refname"));
					bean.setDocno(docno);
					System.out.println("Bean reason"+bean.getHidcmbtrreason());
					bean.setHidcmbreplacetype(resultSet.getString("reptype"));
					System.out.println("Replace Type:"+resultSet.getString("reptype"));
					if(resultSet.getString("reptype").equalsIgnoreCase("atbranch")){
						bean.setHidcmbinbranch(resultSet.getString("inbrhid"));
						bean.setHidcmbinlocation(resultSet.getString("inloc"));
						if(resultSet.getDate("indate")!=null){
							bean.setAtbranchdatein(resultSet.getDate("indate").toString());
							}
						bean.setInuser(resultSet.getString("user_name"));
						bean.setHidinuser(resultSet.getString("userid"));
						bean.setHidatbranchtimein(resultSet.getString("intime"));
						bean.setAtbranchkmin(resultSet.getString("inkm"));
						bean.setHidcmbatbranchinfuel(resultSet.getString("infuel"));
						bean.setAtbranchoutfleetno(resultSet.getString("ofleetno"));
						bean.setHidatbranchoutuser(resultSet.getString("outuserid"));
						bean.setAtbranchoutuser(resultSet.getString("outusername"));
						String outtemp="";
						outtemp=resultSet.getString("oflname");
						outtemp=outtemp+"Reg No: "+resultSet.getString("oregno");
						bean.setAtbranchoutfleetname(outtemp);
						bean.setHidatbranchoutbranch(resultSet.getString("obrhid"));
						bean.setHidatbranchoutlocation(resultSet.getString("olocid"));
						bean.setAtbranchoutbranch(resultSet.getString("obranchname"));
						bean.setAtbranchoutlocation(resultSet.getString("olocname"));
						//bean.setTxtoutfleetno(resultSet.getString("ofleetno"));
						if(resultSet.getDate("odate")!=null){
							bean.setAtbranchoutdate(resultSet.getDate("odate").toString());	
						}
						
						bean.setHidatbranchouttime(resultSet.getString("otime"));
						bean.setAtbranchoutkm(resultSet.getString("okm"));
//						System.out.println("Out KM:"+bean.getOndeliverykm());
						bean.setHidcmbatbranchoutfuel(resultSet.getString("ofuel"));
						
					}
					else{
					//Collection Out Info	
					System.out.println("Here");
					bean.setHidcoloutuser(resultSet.getString("outuserid"));
					bean.setColoutuser(resultSet.getString("outusername"));
					bean.setHidcoloutbranch(resultSet.getString("obrhid"));
					bean.setHidcoloutlocation(resultSet.getString("olocid"));
					bean.setColoutbranch(resultSet.getString("obranchname"));
					bean.setColoutlocation(resultSet.getString("olocname"));
					bean.setColoutfleetno(resultSet.getString("ofleetno"));
					String outtemp="";
					outtemp=resultSet.getString("oflname");
					outtemp=outtemp+"Reg No: "+resultSet.getString("oregno");
					bean.setColoutfleetname(outtemp);
					if(!(resultSet.getDate("odate")==null)){
						bean.setColoutdate(resultSet.getDate("odate").toString());	
					}
					
					bean.setHidcolouttime(resultSet.getString("otime"));
					bean.setColoutkm(resultSet.getString("okm"));
//					System.out.println("Out KM:"+bean.getOndeliverykm());
					bean.setHidcmbcoloutfuel(resultSet.getString("ofuel"));
				
					
					//Collection Delivery Info
					bean.setHidchkdelivery(resultSet.getString("delstatus"));
					bean.setHidcoldeldriver(resultSet.getString("deldrvid"));
					bean.setColdeldriver(resultSet.getString("name"));
					
					if(!(resultSet.getDate("deldate")==null))
					bean.setColdeldate(resultSet.getDate("deldate").toString());
					bean.setHidcoldeltime(resultSet.getString("deltime"));
					bean.setColdelkm(resultSet.getString("delkm"));
					bean.setHidcmbcoldelfuel(resultSet.getString("delfuel"));
					bean.setColdeliveryto(resultSet.getString("delat"));
					
					//Collection In Info
					if(!(resultSet.getDate("indate")==null)){
					bean.setColindate(resultSet.getDate("indate").toString());
					}
					bean.setHidcolintime(resultSet.getString("intime"));
					bean.setColinkm(resultSet.getString("inkm"));
					bean.setHidcmbcolinfuel(resultSet.getString("infuel"));
//					System.out.println("In fuel in dao:"+bean.getHidcmbincollectfuel());
					bean.setHidcmbcolinbranch(resultSet.getString("inbrhid"));
//						System.out.println("BEAN INBRANCHID"+bean.getHidcmbinbranch());
					bean.setHidcmbcolinlocation(resultSet.getString("inloc"));
//						System.out.println("BEAN LOCATIONID"+bean.getHidcmbinlocation());
					
					//Collection Collect Info
					bean.setHidchkcollect(resultSet.getString("clstatus"));
					bean.setHidcolcollectdriver(resultSet.getString("cldrvid"));
					bean.setColcollectdriver(resultSet.getString("cname"));
					if(!((resultSet.getDate("cldate")==null)||(resultSet.getString("cldate").equalsIgnoreCase("")))){
					bean.setColcollectdate(resultSet.getDate("cldate").toString());
					}
					bean.setHidcolcollecttime(resultSet.getString("cltime"));
					bean.setColcollectkm(resultSet.getString("clkm"));
					bean.setHidcmbcolcollectfuel(resultSet.getString("clfuel"));
					
					
					}
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
	 
	 
	 
	 
	public   JSONArray getAgmtnoSearch(String docno,String fleet,String regno,String client,String agmttype,String date,String mobile,String agmtbranch) throws SQLException {
	    List<ClsReplacementBean> replacementbean = new ArrayList<ClsReplacementBean>();
	  String strSql="";
	    JSONArray RESULTDATA=new JSONArray();
	    Connection conn = null;
	    
		try {
		conn=objconn.getMyConnection();	
			Statement stmtmanual = conn.createStatement ();
//			System.out.println();
//			System.out.println("==========="+docno+fleet+regno);
			String sqltest="";
			String docno5="";
//			System.out.println("checking   "+!((fleet.equalsIgnoreCase("0"))&&(fleet.trim().equalsIgnoreCase(""))&&(docno.isEmpty())));
			
			if(!((docno.equalsIgnoreCase("0"))||(docno.trim().equalsIgnoreCase(""))||(docno.isEmpty()))){
				sqltest=" and agmt.voc_no='"+docno+"'";
			}
			if(!(agmtbranch.equalsIgnoreCase("")) && agmtbranch!=null){
				sqltest=sqltest+" and agmt.brhid="+agmtbranch;
			}
			if(!((fleet.equalsIgnoreCase("0"))||(fleet.trim().equalsIgnoreCase(""))||(fleet.isEmpty()))){
				sqltest=sqltest+" and mov.fleet_no like '%"+fleet+"%'";
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
			strSql="select agmt.voc_no,agmt.doc_no,agmt.date,mov.fleet_no,mov.dout,mov.tout,round(mov.kmout,2) kmout,mov.trancode infleettrancode,mov.fout,"+
" mov.obrhid,mov.olocid,veh.flname,veh.reg_no,ac.refname,br.branchname,loc.loc_name from gl_ragmt agmt inner join gl_vmove mov on"+
" (agmt.doc_no=mov.rdocno and mov.rdtype='RAG' and mov.status='OUT') left join gl_vehmaster veh on agmt.ofleet_no=veh.fleet_no"+
"  left join my_acbook ac on (agmt.cldocno=ac.cldocno and ac.dtype='CRM') left join my_brch br on agmt.brhid=br.doc_no left join"+
"  my_locm loc on mov.olocid=loc.doc_no left join (select max(doc_no) maxdoc ,rdocno,rtype from gl_vehreplace group by rdocno,rtype)"+
"  aa on (aa.rdocno=agmt.doc_no and aa.rtype='RAG') left join gl_vehreplace rep on (rep.doc_no=aa.maxdoc) where mov.status='OUT' and"+
"  coalesce(rep.closestatus=1,1) "+sqltest+" order by agmt.doc_no";
		}
		else if(agmttype.equalsIgnoreCase("LAG")){
		strSql="select agmt.voc_no,agmt.doc_no,agmt.date,mov.fleet_no,mov.dout,mov.tout,round(mov.kmout,2) kmout,mov.trancode infleettrancode,mov.fout,mov.obrhid,mov.olocid,"+
				" veh.flname,veh.reg_no,ac.refname,br.branchname,loc.loc_name from gl_lagmt agmt left join gl_vmove mov on"+
				" (agmt.doc_no=mov.rdocno and mov.rdtype='LAG') left join gl_vehmaster veh on mov.fleet_no=veh.fleet_no"+
				" left join my_acbook ac on (agmt.cldocno=ac.cldocno and ac.dtype='CRM') left join my_brch br on mov.obrhid=br.doc_no left join"+
				" my_locm loc on mov.olocid=loc.doc_no  left join (select max(doc_no) maxdoc ,rdocno,rtype from gl_vehreplace group by rdocno,rtype)"+
"  aa on (aa.rdocno=agmt.doc_no and aa.rtype='LAG') left join gl_vehreplace rep on (rep.doc_no=aa.maxdoc) where mov.status='OUT' and"+
"  coalesce(rep.closestatus=1,1) "+sqltest+" order by agmt.doc_no";
		}
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
	
	
	
	public   JSONArray getOutFleetSearch(String branch,String searchdate,String fleetno,String docno,String regno,String color,String group) throws SQLException {
	    List<ClsReplacementBean> invoicebean = new ArrayList<ClsReplacementBean>();
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
	
	
	public   JSONArray getDriverData() throws SQLException {
	    List<ClsReplacementBean> replacementbean = new ArrayList<ClsReplacementBean>();
	  String strSql="";
	    JSONArray RESULTDATA=new JSONArray();
	    Connection conn =null;
	    try {
	    	conn = objconn.getMyConnection();
			Statement stmtmanual = conn.createStatement ();
			JSONArray jsonArray = new JSONArray();
//			System.out.println("DAO SESSION"+session.getAttribute("BRANCHID").toString());
			/*strSql="select trim(name) name,dr_id,led from gl_drdetails where branch='"+session.getAttribute("BRANCHID").toString()+"' and dtype='DRV'";*/
			strSql="select sal_name name,doc_no dr_id,lic_exp_dt led from my_salesman where status<>7 and sal_type='DRV'";
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
	
	public int insert(Date date, String cmbrentaltype, String refno,
			String txtfleetno, Date dateout, String timeout, double outkm,
			String cmbfuel, String cmbtrreason, String cmbreplacetype,
			String mode, HttpSession session, String formdetailcode,
			String hidtxtbranch, String hidtxtlocation,
			String hidchkcollection, String hidchkatbranch, String cmbinbranch,
			String cmbinlocation, Date atbranchindate, String atbranchtimein,
			String atbranchkmin, String cmbatbranchinfuel,
			String hidatbranchoutbranch, String hidatbranchoutlocation,
			Date atbranchoutdate, String atbranchouttime, String atbranchoutkm,
			String cmbatbranchoutfuel, String coloutfleetno,
			String hidcoloutbranch, String hidcoloutlocation, Date coloutdate,
			String colouttime, String coloutkm, String cmbcoloutfuel,String infleettrancode,String atbranchoutfleetno,String description) throws SQLException {
		// TODO Auto-generated method stub
		System.out.println("Inside DAO");
		Connection conn=null;
		try{
			
			System.out.println(dateout+"::"+timeout+"::"+cmbfuel+"::"+cmbtrreason+"::"+atbranchoutkm+"::"+cmbatbranchoutfuel);
			
			conn=objconn.getMyConnection();
			
			conn.setAutoCommit(false);
			
			CallableStatement stmtreplace = conn.prepareCall("{call replacementNewDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			int val=0;
			stmtreplace.registerOutParameter(54, java.sql.Types.INTEGER);
			stmtreplace.setDate(1,date);
			stmtreplace.setString(2,cmbrentaltype);
			stmtreplace.setString(3,refno);
			stmtreplace.setString(4,txtfleetno);
			stmtreplace.setString(5, infleettrancode);
			stmtreplace.setString(6,cmbtrreason);
			stmtreplace.setDate(7,dateout);
			stmtreplace.setString(8,timeout);
			stmtreplace.setDouble(9,outkm);
			stmtreplace.setString(10,cmbfuel);
			stmtreplace.setString(11,hidtxtbranch);
			stmtreplace.setString(12,hidtxtlocation);
			stmtreplace.setString(13,cmbreplacetype);
			stmtreplace.setString(14,cmbinbranch);
			stmtreplace.setString(15,cmbinlocation);
			stmtreplace.setDate(16,atbranchindate);
			stmtreplace.setString(17, atbranchtimein);
			stmtreplace.setString(18, atbranchkmin);
			stmtreplace.setString(19, cmbatbranchinfuel);
			stmtreplace.setString(20, hidatbranchoutbranch);
			stmtreplace.setString(21,hidatbranchoutlocation);
			stmtreplace.setDate(22,atbranchoutdate);
			stmtreplace.setString(23,atbranchouttime);
			stmtreplace.setString(24,atbranchoutkm);
			stmtreplace.setString(25,cmbatbranchoutfuel);
			stmtreplace.setString(26,atbranchoutfleetno);
			stmtreplace.setString(27,coloutfleetno);
			stmtreplace.setString(28,hidcoloutbranch);
			stmtreplace.setString(29,hidcoloutlocation);
			stmtreplace.setDate(30,coloutdate);
			stmtreplace.setString(31,colouttime);
			stmtreplace.setString(32,coloutkm);
			stmtreplace.setString(33,cmbcoloutfuel);
			stmtreplace.setString(34,null);
			stmtreplace.setString(35,null);
			stmtreplace.setString(36,null);
			stmtreplace.setString(37,null);
			stmtreplace.setString(38,null);
			stmtreplace.setString(39,null);
			stmtreplace.setString(40,null);
			stmtreplace.setString(41,null);
			stmtreplace.setString(42,null);
			stmtreplace.setString(43,null);
			stmtreplace.setString(44,null);
			stmtreplace.setString(45,null);
			stmtreplace.setString(46,null);
			stmtreplace.setString(47,null);
			stmtreplace.setString(48,null);
			stmtreplace.setString(49,null);
			stmtreplace.setString(50,null);
			stmtreplace.setString(51,formdetailcode);
			stmtreplace.setString(52,session.getAttribute("USERID").toString());
			stmtreplace.setString(53,session.getAttribute("BRANCHID").toString());
			stmtreplace.setString(55,mode);
			stmtreplace.setString(56,null);
			stmtreplace.setString(57,null);
			stmtreplace.setString(58, description);
			stmtreplace.executeQuery();
			val=stmtreplace.getInt("docNo");
			if(val>0){
				conn.commit();
				stmtreplace.close();
				conn.close();
				return val;
			}
			else{
				stmtreplace.close();
				conn.close();
				return 0;
			}
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		
		
		
		
		
		
		
		
		return 0;
	}



	public boolean update(int docno, String hidchkdelivery,
			String hidcolcollectdriver, Date colcollectdate,
			String colcollecttime, String colcollectkm,
			String cmbcolcollectfuel, String hidchkcollect,
			String hidcoldeldriver, Date coldeldate, String coldeltime,
			String coldelkm, String cmbcoldelfuel, String coldeliveryto,
			String refno, String txtfleetno, String cmbinbranch,
			String cmbinlocation, Date colindate, String colintime,
			String colinkm, String cmbcolinfuel, Date coloutdate,
			String colouttime, String coloutkm, String cmbcoloutfuel,
			String coloutfleetno, String hidcoloutbranch,
			String hidcoloutlocation, String cmbtrreason, Date date,
			Date dateout, Date refdate, String infleettrancode,
			String cmbrentaltype,HttpSession session,String mode,String formdetailcode,String colinbranch,String colinlocation,String cmbreplacetype) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn=null;
		try{
			
			//System.out.println(dateout+"::"+timeout+"::"+cmbfuel+"::"+cmbtrreason+"::"+atbranchoutkm+"::"+cmbatbranchoutfuel);
			
			conn=objconn.getMyConnection();
			
			conn.setAutoCommit(false);
			/*if(cmbinbranch.equalsIgnoreCase("")){
				cmbinbranch="0";
			}
			if(cmbinlocation.equalsIgnoreCase("")){
				cmbinlocation="0";
			}*/
			
			
			System.out.println("Hidchkcollect:"+hidchkcollect+"::::::::Hidchkdelivery:"+hidchkdelivery);
			hidchkcollect=hidchkcollect==null?"0":hidchkcollect;
			hidchkdelivery=hidchkdelivery==null?"0":hidchkdelivery;
			if(hidcolcollectdriver.equalsIgnoreCase("")){
				hidcolcollectdriver="0";
			}
			hidcolcollectdriver=hidcolcollectdriver==null?"0":hidcolcollectdriver;
			hidcoldeldriver=hidcoldeldriver==null?"0":hidcoldeldriver;
			if(hidcoldeldriver.equalsIgnoreCase("")){
				hidcoldeldriver="0";
			}
			
			CallableStatement stmtreplace = conn.prepareCall("{call replacementNewDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmtreplace.setInt(54, docno);
			stmtreplace.setDate(1,date);
			
			stmtreplace.setString(2,cmbrentaltype);
			stmtreplace.setString(3,refno);
			stmtreplace.setString(4,txtfleetno);
			stmtreplace.setString(5, infleettrancode);
			stmtreplace.setString(6,cmbtrreason);
			stmtreplace.setDate(7,dateout);
			stmtreplace.setString(8,null);
			stmtreplace.setDouble(9,0.0);
			stmtreplace.setString(10,null);
			stmtreplace.setString(11,null);
			stmtreplace.setString(12,null);
			stmtreplace.setString(13,cmbreplacetype);
			stmtreplace.setString(14,null);
			stmtreplace.setString(15,null);
			stmtreplace.setDate(16,null);
			stmtreplace.setString(17, null);
			stmtreplace.setString(18, null);
			stmtreplace.setString(19, null);
			stmtreplace.setString(20, null);
			stmtreplace.setString(21,null);
			stmtreplace.setDate(22,null);
			stmtreplace.setString(23,null);
			stmtreplace.setString(24,null);
			stmtreplace.setString(25,null);
			stmtreplace.setString(26,null);
			stmtreplace.setString(27,coloutfleetno);
			stmtreplace.setString(28,hidcoloutbranch);
			stmtreplace.setString(29,hidcoloutlocation);
			stmtreplace.setDate(30,coloutdate);
			stmtreplace.setString(31,colouttime);
			stmtreplace.setString(32,coloutkm);
			stmtreplace.setString(33,cmbcoloutfuel);
			stmtreplace.setString(34,hidcolcollectdriver);
			stmtreplace.setDate(35,colcollectdate);
			stmtreplace.setString(36,colcollecttime);
			stmtreplace.setString(37,colcollectkm);
			stmtreplace.setString(38,cmbcolcollectfuel);
			stmtreplace.setString(39,hidcoldeldriver);
			stmtreplace.setString(40,coldeliveryto);
			stmtreplace.setDate(41,coldeldate);
			stmtreplace.setString(42,coldeltime);
			stmtreplace.setString(43,coldelkm);
			stmtreplace.setString(44,cmbcoldelfuel);
			stmtreplace.setString(45,colinbranch);
			stmtreplace.setString(46,colinlocation);
			stmtreplace.setDate(47,colindate);
			stmtreplace.setString(48,colintime);
			stmtreplace.setString(49,colinkm);
			stmtreplace.setString(50,cmbcolinfuel);
			stmtreplace.setString(51,formdetailcode);
			stmtreplace.setString(52,session.getAttribute("USERID").toString());
			stmtreplace.setString(53,session.getAttribute("BRANCHID").toString());
			stmtreplace.setString(55,mode);
			stmtreplace.setString(56,hidchkdelivery);
			stmtreplace.setString(57,hidchkcollect);
			stmtreplace.setString(58, "");
			System.out.println(stmtreplace);
			int val=stmtreplace.executeUpdate();
			//stmtreplace.executeQuery();
			//val=stmtreplace.getInt("docNo");
			if(val>0){
				conn.commit();
				stmtreplace.close();
				conn.close();
				return true;
			}
			else{
				stmtreplace.close();
				conn.close();
				return false;
			}
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}

		
		return false;
	}
	
	
	
	public   ClsReplacementNewBean getPrint(int docno) throws SQLException {
		 ClsReplacementNewBean printbean = new ClsReplacementNewBean();
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




	public int delete(int docno, String brchName, String agmtno,
			String agmttype, HttpSession session,String mode) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmtdelete=conn.createStatement();
			conn.setAutoCommit(false);
			String strclosesql="",strlastreplace="",strlastrepmov="";
			int closestatus=0,replacemaxdoc=0,mainfleet=0,lastmovstatus=0;
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
			System.out.println(docno+"////"+replacemaxdoc);
			if(!(docno==replacemaxdoc)){
				System.out.println("Before Return");
				return -2;//Replacement is not last
			}
			
		//Checking Last Movement of Corresponding agreement
			
			ResultSet rsmainfleet=stmtdelete.executeQuery("select fleet_no from gl_vmove where doc_no=(select max(doc_no) from gl_vmove where rdocno="+agmtno+" and rdtype='"+agmttype+"')");
			
			while(rsmainfleet.next()){
				mainfleet=rsmainfleet.getInt("fleet_no");
			}
			strlastrepmov="select if(rdocno="+agmtno+" and rdtype='"+agmttype+"' and repno="+docno+",1,0) lastmov from gl_vmove where doc_no= "+
						" (select max(doc_no) from gl_vmove where rdtype='"+agmttype+"'and rdocno="+agmtno+" and fleet_no="+mainfleet+")";
			System.out.println(strlastrepmov);
			ResultSet rslastmov=stmtdelete.executeQuery(strlastrepmov);
			while(rslastmov.next()){
				lastmovstatus=rslastmov.getInt("lastmov");
			}
			if(lastmovstatus==0){
				
				return -3;//Found Another Movement Against corresponding  agreement
			}

			CallableStatement stmtreplace = conn.prepareCall("{call replacementNewDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmtreplace.setInt(54, docno);
			stmtreplace.setDate(1,null);
			
			stmtreplace.setString(2,agmttype);
			stmtreplace.setString(3,agmtno);
			stmtreplace.setString(4,null);
			stmtreplace.setString(5, null);
			stmtreplace.setString(6,null);
			stmtreplace.setDate(7,null);
			stmtreplace.setString(8,null);
			stmtreplace.setDouble(9,0.0);
			stmtreplace.setString(10,null);
			stmtreplace.setString(11,null);
			stmtreplace.setString(12,null);
			stmtreplace.setString(13,null);
			stmtreplace.setString(14,null);
			stmtreplace.setString(15,null);
			stmtreplace.setDate(16,null);
			stmtreplace.setString(17, null);
			stmtreplace.setString(18, null);
			stmtreplace.setString(19, null);
			stmtreplace.setString(20, null);
			stmtreplace.setString(21,null);
			stmtreplace.setDate(22,null);
			stmtreplace.setString(23,null);
			stmtreplace.setString(24,null);
			stmtreplace.setString(25,null);
			stmtreplace.setString(26,null);
			stmtreplace.setString(27,null);
			stmtreplace.setString(28,null);
			stmtreplace.setString(29,null);
			stmtreplace.setDate(30,null);
			stmtreplace.setString(31,null);
			stmtreplace.setString(32,null);
			stmtreplace.setString(33,null);
			stmtreplace.setString(34,null);
			stmtreplace.setDate(35,null);
			stmtreplace.setString(36,null);
			stmtreplace.setString(37,null);
			stmtreplace.setString(38,null);
			stmtreplace.setString(39,null);
			stmtreplace.setString(40,null);
			stmtreplace.setDate(41,null);
			stmtreplace.setString(42,null);
			stmtreplace.setString(43,null);
			stmtreplace.setString(44,null);
			stmtreplace.setString(45,null);
			stmtreplace.setString(46,null);
			stmtreplace.setDate(47,null);
			stmtreplace.setString(48,null);
			stmtreplace.setString(49,null);
			stmtreplace.setString(50,null);
			stmtreplace.setString(51,null);
			stmtreplace.setString(52,session.getAttribute("USERID").toString());
			stmtreplace.setString(53,brchName);
			stmtreplace.setString(55,mode);
			stmtreplace.setString(56,null);
			stmtreplace.setString(57,null);
			stmtreplace.setString(58, "");
			System.out.println(stmtreplace);
			int val=stmtreplace.executeUpdate();
			//stmtreplace.executeQuery();
			//val=stmtreplace.getInt("docNo");
			if(val>0){
				conn.commit();
				stmtreplace.close();
				conn.close();
				return 1;
			}
			else{
				stmtreplace.close();
				conn.close();
				System.out.println("Else condition Error");
				return 0;
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		
		System.out.println("Last Error");
		return 0;
	}

}
