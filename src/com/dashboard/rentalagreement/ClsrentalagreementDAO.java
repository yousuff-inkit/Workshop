package com.dashboard.rentalagreement;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;


import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;




public class ClsrentalagreementDAO 
{
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();
	
	public JSONArray exchange(String brnchval) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        Connection conn=null;
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
				//String sql="";
				//ResultSet resultSet ;
				//System.out.println("========="+brnchval);
            	if(brnchval.equalsIgnoreCase("a"))
            	{
             		 
            		String sql="select 'RAG' chktype,r.voc_no,convert(r.brhid,char(20)) brhid, r.doc_no,r.date,r.fleet_no,r.cldocno,r.odate,r.otime,\r\n" + 
            				"r.okm, CASE WHEN r.ofuel='0.000' THEN 'Level 0/8' WHEN r.ofuel='0.125' THEN 'Level 1/8' WHEN r.ofuel='0.250' THEN 'Level 2/8' WHEN\r\n" + 
            				" 	r.ofuel='0.375'	THEN 'Level 3/8'	WHEN r.ofuel='0.500' THEN 'Level 4/8' WHEN r.ofuel='0.625' THEN 'Level 5/8'\r\n" + 
            				" 	WHEN r.ofuel='0.750' THEN 'Level 6/8' WHEN r.ofuel='0.875' THEN 'Level 7/8' WHEN r.ofuel='1.000' THEN 'Level 8/8'\r\n" + 
            				"   END as 'ofuel',r.ofuel hidfuel,convert(r.drid,char(20)) drid,v.reg_no,v.flname,a.refname,s.sal_name,v.a_loc,g.doc_no gid,g.gname\r\n" + 
            				"from gl_ragmt r\r\n" + 
            				" left join gl_vehmaster v on r.fleet_no=v.fleet_no left join my_acbook a on a.cldocno=r.cldocno and a.dtype='CRM'\r\n" + 
            				" left join my_salesman s on s.doc_no=r.drid and s.sal_type='DRV' left join gl_vehgroup g on g.doc_no=v.vgrpid\r\n" + 
            				"  where r.clstatus=0 and r.delstatus=0 and r.delivery=1 ";
            	//System.out.println("----"+sql);
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
     				stmtVeh.close();
     				
            	}
            	else{		
            		
            		
               		String sql="select 'RAG' chktype,r.voc_no,convert(r.brhid,char(20)) brhid, r.doc_no,r.date,r.fleet_no,r.cldocno,r.odate,r.otime,\r\n" + 
            				"r.okm,CASE WHEN r.ofuel='0.000' THEN 'Level 0/8' WHEN r.ofuel='0.125' THEN 'Level 1/8' WHEN r.ofuel='0.250' THEN 'Level 2/8' WHEN  \r\n" + 
            				"	r.ofuel='0.375'	THEN 'Level 3/8'	WHEN r.ofuel='0.500' THEN 'Level 4/8' WHEN r.ofuel='0.625' THEN 'Level 5/8' \r\n" + 
            				" 	WHEN r.ofuel='0.750' THEN 'Level 6/8' WHEN r.ofuel='0.875' THEN 'Level 7/8' WHEN r.ofuel='1.000' THEN 'Level 8/8'  \r\n" + 
            				"    END as 'ofuel',r.ofuel hidfuel,convert(r.drid,char(20)) drid,v.reg_no,v.flname,a.refname,s.sal_name,v.a_loc,g.doc_no gid,g.gname\r\n" + 
            				"from gl_ragmt r\r\n" + 
            				" left join gl_vehmaster v on r.fleet_no=v.fleet_no left join my_acbook a on a.cldocno=r.cldocno and a.dtype='CRM'\r\n" + 
            				" left join my_salesman s on s.doc_no=r.drid and s.sal_type='DRV' left join gl_vehgroup g on g.doc_no=v.vgrpid\r\n" + 
            				"  where r.clstatus=0 and r.delstatus=0 and r.delivery=1   and  r.brhid='"+brnchval+"' ";
            		
            		//System.out.println("------sql----"+sql);
            		
 
           		ResultSet resultSet = stmtVeh.executeQuery(sql);
            	 RESULTDATA=ClsCommon.convertToJSON(resultSet);
 				stmtVeh.close();
 				
            	}
            	conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
	
	
	
	
	
	
	
	
	
	
	public JSONArray delupdate(String brnchval) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn=null;
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
				//String sql="";
				//ResultSet resultSet ;
				//System.out.println("========="+brnchval);
            	if(brnchval.equalsIgnoreCase("a"))
            	{
/*            		String sql="select r.voc_no,r.brhid, r.doc_no,r.date,r.fleet_no,r.cldocno,r.odate,r.otime,r.okm,CASE WHEN r.ofuel='0.000' THEN 'Level 0/8' WHEN r.ofuel='0.125' THEN 'Level 1/8' WHEN r.ofuel='0.250' THEN 'Level 2/8' WHEN r.ofuel='0.375'"
					+ "	THEN 'Level 3/8'	WHEN r.ofuel='0.500' THEN 'Level 4/8' WHEN r.ofuel='0.625' THEN 'Level 5/8' "
					+ "	WHEN r.ofuel='0.750' THEN 'Level 6/8' WHEN r.ofuel='0.875' THEN 'Level 7/8' WHEN r.ofuel='1.000' THEN 'Level 8/8' "
					+ "  END as 'ofuel',r.ofuel hidfuel,r.drid,v.reg_no,v.flname,a.refname,s.sal_name,v.a_loc,g.doc_no gid,g.gname from gl_ragmt r "
            				+ "left join gl_vehmaster v on r.fleet_no=v.fleet_no left join my_acbook a on a.cldocno=r.cldocno and a.dtype='CRM' "
            				+ "left join my_salesman s on s.doc_no=r.drid and s.sal_type='DRV' left join gl_vehgroup g on g.doc_no=v.vgrpid  where r.clstatus=0 and r.delstatus=0 and r.delivery=1  ";*/
            	
            		String sql="select aa.*, CASE WHEN ofuel='0.000' THEN 'Level 0/8' WHEN ofuel='0.125' THEN 'Level 1/8' WHEN ofuel='0.250' THEN 'Level 2/8' WHEN "
            				+ "	ofuel='0.375'	THEN 'Level 3/8'	WHEN ofuel='0.500' THEN 'Level 4/8' WHEN ofuel='0.625' THEN 'Level 5/8' "
            				+ "	WHEN ofuel='0.750' THEN 'Level 6/8' WHEN ofuel='0.875' THEN 'Level 7/8' WHEN ofuel='1.000' THEN 'Level 8/8' "
            				 + "	 END as 'ofuel' from "
            				+ "	(select 'RAG' chktype,r.voc_no,convert(r.brhid,char(20)) brhid, r.doc_no,r.date,r.fleet_no,r.cldocno,r.odate,r.otime,r.okm,r.ofuel,r.ofuel hidfuel,convert(r.drid,char(20)) drid,v.reg_no,v.flname,a.refname,s.sal_name,v.a_loc,g.doc_no gid,g.gname from gl_ragmt r "
            				 + "	 left join gl_vehmaster v on r.fleet_no=v.fleet_no left join my_acbook a on a.cldocno=r.cldocno and a.dtype='CRM' "
            				  + "	left join my_salesman s on s.doc_no=r.drid and s.sal_type='DRV' left join gl_vehgroup g on g.doc_no=v.vgrpid "
            				 + "	 where r.clstatus=0 and r.delstatus=0 and r.delivery=1 "
            				+ "	 union all "
            				+ "	 select 'VCU' chktype,c.doc_no voc_no,convert(veh.a_br,char(20)) a_br,c.doc_no,c.date,c.fleet_no,c.cldocno,c.odate,c.otime,c.okm,c.ofuel,c.ofuel hidfuel,'',veh.reg_no,veh.flname, "
            				 + "	a.refname,'',veh.a_loc,g.doc_no gid,g.gname from gl_vehcustody c left join gl_ragmt ra on ra.doc_no=c.rdocno and c.rtype='RAG' "
            				  + "	left join gl_vehmaster veh on c.fleet_no=veh.fleet_no left join my_acbook a on a.cldocno=c.cldocno and a.dtype='CRM' "
            				  + "	 left join gl_vehgroup g on g.doc_no=veh.vgrpid where c.rtype='RAG' and c.delivery=1 and c.delstatus is null) aa ";
            	//System.out.println("----"+sql);
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
     				stmtVeh.close();
     				
            	}
            	else{		
            		
            		
            		String sql="select aa.*, CASE WHEN ofuel='0.000' THEN 'Level 0/8' WHEN ofuel='0.125' THEN 'Level 1/8' WHEN ofuel='0.250' THEN 'Level 2/8' WHEN "
            				+ "	ofuel='0.375'	THEN 'Level 3/8'	WHEN ofuel='0.500' THEN 'Level 4/8' WHEN ofuel='0.625' THEN 'Level 5/8' "
            				+ "	WHEN ofuel='0.750' THEN 'Level 6/8' WHEN ofuel='0.875' THEN 'Level 7/8' WHEN ofuel='1.000' THEN 'Level 8/8' "
            				 + "	 END as 'ofuel' from "
            				+ "	(select 'RAG' chktype,r.voc_no,convert(r.brhid,char(20)) brhid, r.doc_no,r.date,r.fleet_no,r.cldocno,r.odate,r.otime,r.okm,r.ofuel,r.ofuel hidfuel,convert(r.drid,char(20)) drid,v.reg_no,v.flname,a.refname,s.sal_name,v.a_loc,g.doc_no gid,g.gname from gl_ragmt r "
            				 + "	 left join gl_vehmaster v on r.fleet_no=v.fleet_no left join my_acbook a on a.cldocno=r.cldocno and a.dtype='CRM' "
            				  + "	left join my_salesman s on s.doc_no=r.drid and s.sal_type='DRV' left join gl_vehgroup g on g.doc_no=v.vgrpid "
            				 + "	 where r.clstatus=0 and r.delstatus=0 and r.delivery=1 "
            				+ "	 union all "
            				+ "	 select 'VCU' chktype,c.doc_no voc_no,convert(veh.a_br,char(20)) a_br,c.doc_no,c.date,c.fleet_no,c.cldocno,c.odate,c.otime,c.okm,c.ofuel,c.ofuel hidfuel,'',veh.reg_no,veh.flname, "
            				 + "	a.refname,'',veh.a_loc,g.doc_no gid,g.gname from gl_vehcustody c left join gl_ragmt ra on ra.doc_no=c.rdocno and c.rtype='RAG' "
            				  + "	left join gl_vehmaster veh on c.fleet_no=veh.fleet_no left join my_acbook a on a.cldocno=c.cldocno and a.dtype='CRM' "
            				  + "	 left join gl_vehgroup g on g.doc_no=veh.vgrpid where c.rtype='RAG' and c.delivery=1 and c.delstatus is null) aa   where aa.brhid='"+brnchval+"' ";
            		
            		//System.out.println("------sql----"+sql);
            		
            	/*	
            		String sql="select r.voc_no,r.brhid,r.doc_no,r.date,r.fleet_no,r.cldocno,r.odate,r.otime,r.okm,CASE WHEN r.ofuel='0.000' THEN 'Level 0/8' WHEN r.ofuel='0.125' THEN 'Level 1/8' WHEN r.ofuel='0.250' THEN 'Level 2/8' WHEN r.ofuel='0.375'"
        					+ "	THEN 'Level 3/8'	WHEN r.ofuel='0.500' THEN 'Level 4/8' WHEN r.ofuel='0.625' THEN 'Level 5/8' "
        					+ "	WHEN r.ofuel='0.750' THEN 'Level 6/8' WHEN r.ofuel='0.875' THEN 'Level 7/8' WHEN r.ofuel='1.000' THEN 'Level 8/8' "
        					+ "  END as 'ofuel',r.ofuel hidfuel,r.drid,v.reg_no,v.flname,a.refname,s.sal_name,v.a_loc,g.doc_no gid,g.gname from gl_ragmt r "
                    				+ "left join gl_vehmaster v on r.fleet_no=v.fleet_no left join my_acbook a on a.cldocno=r.cldocno and a.dtype='CRM' "
                    				+ "left join my_salesman s on s.doc_no=r.drid and s.sal_type='DRV' left join gl_vehgroup g on g.doc_no=v.vgrpid where  r.clstatus=0 and r.brhid='"+brnchval+"' and  r.delstatus=0 and r.delivery=1 ";  
            	 //	System.out.println("----"+sql);
*/            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            	 RESULTDATA=ClsCommon.convertToJSON(resultSet);
 				stmtVeh.close();
 				
            	}
            	conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
	public JSONArray cancellist(String brnchval) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn=null;
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
				//String sql="";
				//ResultSet resultSet ;
				//System.out.println("========="+brnchval);
            	if(brnchval.equalsIgnoreCase("a"))
            	{
            		String sql="select r.voc_no,r.brhid, r.doc_no,r.date,r.fleet_no,r.cldocno,r.odate,r.otime,r.okm,CASE WHEN r.ofuel='0.000' THEN 'Level 0/8' WHEN r.ofuel='0.125' THEN 'Level 1/8' WHEN r.ofuel='0.250' THEN 'Level 2/8' WHEN r.ofuel='0.375'"
					+ "	THEN 'Level 3/8'	WHEN r.ofuel='0.500' THEN 'Level 4/8' WHEN r.ofuel='0.625' THEN 'Level 5/8' "
					+ "	WHEN r.ofuel='0.750' THEN 'Level 6/8' WHEN r.ofuel='0.875' THEN 'Level 7/8' WHEN r.ofuel='1.000' THEN 'Level 8/8' "
					+ "  END as 'ofuel',r.ofuel hidfuel,r.drid,v.reg_no,v.flname,a.refname,s.sal_name,v.a_loc,g.doc_no gid,g.gname from gl_ragmt r "
            				+ "left join gl_vehmaster v on r.fleet_no=v.fleet_no left join my_acbook a on a.cldocno=r.cldocno and a.dtype='CRM' "
            				+ "left join my_salesman s on s.doc_no=r.drid and s.sal_type='DRV' left join gl_vehgroup g on g.doc_no=v.vgrpid  where r.clstatus=2 and r.status=3 ";
            	//System.out.println("----"+sql);
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
     				stmtVeh.close();
     				
            	}
            	else{				 
            		String sql="select r.voc_no,r.brhid,r.doc_no,r.date,r.fleet_no,r.cldocno,r.odate,r.otime,r.okm,CASE WHEN r.ofuel='0.000' THEN 'Level 0/8' WHEN r.ofuel='0.125' THEN 'Level 1/8' WHEN r.ofuel='0.250' THEN 'Level 2/8' WHEN r.ofuel='0.375'"
        					+ "	THEN 'Level 3/8'	WHEN r.ofuel='0.500' THEN 'Level 4/8' WHEN r.ofuel='0.625' THEN 'Level 5/8' "
        					+ "	WHEN r.ofuel='0.750' THEN 'Level 6/8' WHEN r.ofuel='0.875' THEN 'Level 7/8' WHEN r.ofuel='1.000' THEN 'Level 8/8' "
        					+ "  END as 'ofuel',r.ofuel hidfuel,r.drid,v.reg_no,v.flname,a.refname,s.sal_name,v.a_loc,g.doc_no gid,g.gname from gl_ragmt r "
                    				+ "left join gl_vehmaster v on r.fleet_no=v.fleet_no left join my_acbook a on a.cldocno=r.cldocno and a.dtype='CRM' "
                    				+ "left join my_salesman s on s.doc_no=r.drid and s.sal_type='DRV' left join gl_vehgroup g on g.doc_no=v.vgrpid where  r.status=3 and r.clstatus=2 and r.brhid='"+brnchval+"'  ";  
            	 //	System.out.println("----"+sql);
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            	 RESULTDATA=ClsCommon.convertToJSON(resultSet);
 				stmtVeh.close();
 				
            	}
            	conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
	
	
    public JSONArray vehSearchexchang(String brid,String group) throws SQLException {
  	  JSONArray RESULTDATA=new JSONArray();

	    	 Connection conn=null;
			try {
				 conn = ClsConnection.getMyConnection();
				
				
					
					Statement stmtVeh8 = conn.createStatement ();
	            	
					String vehsql="select v.doc_no vdocno,v.reg_no,v.fleet_no,v.FLNAME,v.a_loc, "
							+ " m.FIN,m.fleet_no ,round(m.kmin) kmin,c.doc_no,c.color,g.gname,g.doc_no gid from gl_vehmaster v "
							+ "	left join gl_vmove m on v.fleet_no=m.fleet_no  left join my_color c "
							+ " on v.clrid=c.doc_no left join gl_vehgroup g on g.doc_no=v.vgrpid "
							+ "	where v.a_br="+brid+" and ins_exp >=current_date and v.statu <> 7 and   "
							+ "	m.doc_no=(select (max(doc_no)) from gl_vmove where fleet_no=v.fleet_no) and "
							+ " fstatus in ('L','N') and v.status='IN' and v.tran_code='RR' and v.renttype in ('A','R') and v.vgrpid='"+group+"' " ;
			//System.out.println("---------------"+vehsql);
					ResultSet resultSet = stmtVeh8.executeQuery(vehsql);
					
					RESULTDATA=ClsCommon.convertToJSON(resultSet);
					stmtVeh8.close();
			
				conn.close();
				 return RESULTDATA;
			}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
			
			//System.out.println(RESULTDATA);
	        return RESULTDATA;
	    }
	    
	public JSONArray getDriverData() throws SQLException {
	  
	  String strSql="";
	    JSONArray RESULTDATA=new JSONArray();
	    Connection conn =null;
	    try {
	    	conn = ClsConnection.getMyConnection();
			Statement stmtmanual = conn.createStatement ();
		
			strSql="select sal_name name,doc_no dr_id,lic_exp_dt led from my_salesman where status<>7 and sal_type='DRV'";

			ResultSet resultSet = stmtmanual.executeQuery (strSql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
			stmtmanual.close();
			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
	    
	    return RESULTDATA;
	}
	public JSONArray rtaupdate(String brnchval) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn =null;
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
				//String sql="";
				//ResultSet resultSet ;
				//System.out.println("========="+brnchval);
            	if(brnchval.equalsIgnoreCase("a"))
            	{
            		String sql="select r.voc_no,'Attach' btnattach,'Edit' btnsave,r.brhid, r.doc_no,r.date,r.fleet_no,r.cldocno,r.odate,r.otime,r.okm,CASE WHEN r.ofuel='0.000' THEN 'Level 0/8' WHEN r.ofuel='0.125' THEN 'Level 1/8' WHEN r.ofuel='0.250' THEN 'Level 2/8' WHEN r.ofuel='0.375' "
            				+ "THEN 'Level 3/8'  WHEN r.ofuel='0.500' THEN 'Level 4/8' WHEN r.ofuel='0.625' THEN 'Level 5/8' "
            				+ "WHEN r.ofuel='0.750' THEN 'Level 6/8' WHEN r.ofuel='0.875' THEN 'Level 7/8' WHEN r.ofuel='1.000' THEN 'Level 8/8' "
            				+ "END as 'ofuel',r.ofuel hidfuel,r.drid,v.reg_no,v.flname,a.refname from gl_ragmt r "
            				+ "left join gl_vehmaster v on r.fleet_no=v.fleet_no left join my_acbook a on a.cldocno=r.cldocno and a.dtype='CRM'   where  r.clstatus=0 and r.rtaupdate=0  ";
            	//System.out.println("----"+sql);
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
     				stmtVeh.close();
     				
            	}
            	else{				 
            		String sql="select  r.voc_no,'Attach' btnattach,'Edit' btnsave,r.brhid, r.doc_no,r.date,r.fleet_no,r.cldocno,r.odate,r.otime,r.okm,CASE WHEN r.ofuel='0.000' THEN 'Level 0/8' WHEN r.ofuel='0.125' THEN 'Level 1/8' WHEN r.ofuel='0.250' THEN 'Level 2/8' WHEN r.ofuel='0.375' "
            				+ "THEN 'Level 3/8'  WHEN r.ofuel='0.500' THEN 'Level 4/8' WHEN r.ofuel='0.625' THEN 'Level 5/8' "
            				+ "WHEN r.ofuel='0.750' THEN 'Level 6/8' WHEN r.ofuel='0.875' THEN 'Level 7/8' WHEN r.ofuel='1.000' THEN 'Level 8/8' "
            				+ "END as 'ofuel',r.ofuel hidfuel,r.drid,v.reg_no,v.flname,a.refname from gl_ragmt r "
            				+ "left join gl_vehmaster v on r.fleet_no=v.fleet_no left join my_acbook a on a.cldocno=r.cldocno and a.dtype='CRM'  "
            				+ "  where  r.clstatus=0 and r.rtaupdate=0  and  r.brhid='"+brnchval+"' ";
            	 //	System.out.println("----"+sql);
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            	 RESULTDATA=ClsCommon.convertToJSON(resultSet);
 				stmtVeh.close();
 				
            	}
            	conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
	public JSONArray duedate(String brnchval) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
				//String sql="";
				//ResultSet resultSet ;
				//System.out.println("========="+brnchval);
            	if(brnchval.equalsIgnoreCase("a"))
            	{
            		
            		
            		
            		String sql ="select r.voc_no,bv.fdate,r.brhid, r.doc_no,r.fleet_no,r.cldocno,r.odate,r.otime,r.okm,r.ddate,r.dtime,  ms.sal_name ,"
            				+ "v.reg_no,v.FLNAME vehdetails,a.refname,a.per_mob,a.contactperson,t.rentaltype from gl_ragmt r "
            				+ "left join gl_vehmaster v on r.fleet_no=v.fleet_no left join my_acbook a on a.cldocno=r.cldocno and a.dtype='CRM' "
            				+ " left join gl_vehgroup g on g.doc_no=v.vgrpid left join gl_rtarif t on t.rdocno=r.doc_no and t.rstatus=5 left join "
            				+ "(select max(b.doc_no) doc_no,rdocno from gl_bvdd b group by  rdocno) b on(b.rdocno=r.doc_no) left join "
            				+ "gl_bvdd bv on b.doc_no=bv.doc_no   left join my_salm ms on ms.doc_no=r.salid     where   r.clstatus=0 and r.dispute=0 and r.ddate< (select curdate()+10)  order by ddate ";
        
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
     				stmtVeh.close();
     				
            	}
            	else{	
            		
            		
            		

            		String sql ="select r.voc_no,bv.fdate,r.brhid, r.doc_no,r.fleet_no,r.cldocno,r.odate,r.otime,r.okm,r.ddate,r.dtime,  ms.sal_name ,"
            				+ "v.reg_no,v.FLNAME vehdetails,a.refname,a.per_mob,a.contactperson,t.rentaltype from gl_ragmt r "
            				+ "left join gl_vehmaster v on r.fleet_no=v.fleet_no left join my_acbook a on a.cldocno=r.cldocno and a.dtype='CRM' "
            				+ " left join gl_vehgroup g on g.doc_no=v.vgrpid left join gl_rtarif t on t.rdocno=r.doc_no and t.rstatus=5 left join "
            				+ "(select max(b.doc_no) doc_no,rdocno from gl_bvdd b group by  rdocno) b on(b.rdocno=r.doc_no) left join "
            				+ "gl_bvdd bv on b.doc_no=bv.doc_no    left join my_salm ms on ms.doc_no=r.salid      where   r.clstatus=0 and r.dispute=0 and r.ddate< (select curdate()+10) and r.brhid='"+brnchval+"' ";
            	//	System.out.println("========"+sql);
    
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            	 RESULTDATA=ClsCommon.convertToJSON(resultSet);
 				stmtVeh.close();
 				
            	}
            	conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }


//mm
	
	public JSONArray duedateexc(String brnchval) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        		 Connection conn = null;
				try {
						 conn = ClsConnection.getMyConnection();
						Statement stmtVeh = conn.createStatement ();	
            		
						if(brnchval.equalsIgnoreCase("a"))
		            	{
		            		
		            		
		            		
		            		String sql ="select r.voc_no 'RA No',r.fleet_no 'Fleet',v.FLNAME 'Fleet Name',v.reg_no 'Reg No',a.refname 'Client Name',a.contactperson 'Contact Person',a.per_mob 'Mob No',t.rentaltype \r\n" + 
		        		   	"'Rental type',r.odate 'Out Date',r.otime 'Out time',r.ddate 'Due Date',r.dtime 'Due Time',bv.fdate 'Followup Date', ms.sal_name 'Sales Man' from gl_ragmt r "
		            				+ "left join gl_vehmaster v on r.fleet_no=v.fleet_no left join my_acbook a on a.cldocno=r.cldocno and a.dtype='CRM' "
		            				+ " left join gl_vehgroup g on g.doc_no=v.vgrpid left join gl_rtarif t on t.rdocno=r.doc_no and t.rstatus=5 left join "
		            				+ "(select max(b.doc_no) doc_no,rdocno from gl_bvdd b group by  rdocno) b on(b.rdocno=r.doc_no) left join "
		            				+ "gl_bvdd bv on b.doc_no=bv.doc_no  left join my_salm ms on ms.doc_no=r.salid  where   r.clstatus=0 and r.dispute=0 and r.ddate< (select curdate()+10)   ";
		        
		            		ResultSet resultSet = stmtVeh.executeQuery(sql);
		            		 RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
		     				stmtVeh.close();
		     				
		            	}
		            	else{	
		            		
		            		
		            		

		            		String sql ="select r.voc_no 'RA No',r.fleet_no 'Fleet',v.FLNAME 'Fleet Name',v.reg_no 'Reg No',a.refname 'Client Name',a.contactperson 'Contact Person',a.per_mob 'Mob No',t.rentaltype \r\n" + 
		            				"'Rental type',r.odate 'Out Date',r.otime 'Out time',r.ddate 'Due Date',r.dtime 'Due Time',bv.fdate 'Followup Date', ms.sal_name 'Sales Man' from gl_ragmt r "
		            				+ "left join gl_vehmaster v on r.fleet_no=v.fleet_no left join my_acbook a on a.cldocno=r.cldocno and a.dtype='CRM' "
		            				+ " left join gl_vehgroup g on g.doc_no=v.vgrpid left join gl_rtarif t on t.rdocno=r.doc_no and t.rstatus=5 left join "
		            				+ "(select max(b.doc_no) doc_no,rdocno from gl_bvdd b group by  rdocno) b on(b.rdocno=r.doc_no) left join "
		            				+ "gl_bvdd bv on b.doc_no=bv.doc_no    left join my_salm ms on ms.doc_no=r.salid   where   r.clstatus=0 and r.dispute=0 and r.ddate< (select curdate()+10) and r.brhid='"+brnchval+"' ";
		            	//	System.out.println("========"+sql);
		    
		            		ResultSet resultSet = stmtVeh.executeQuery(sql);
		            	 RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
		 				stmtVeh.close();
		 				
		            	}
            	
            	conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
//..





	public JSONArray duedateDetails(String rdocno) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        Connection conn = null;
       
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
			
            		String sql=" select Date_FORMAT(m.date, '%Y-%m-%d') as  detdate,m.remarks remk,m.fdate,u.user_name user from gl_bvdd m "
            				+ " inner join my_user u on u.doc_no=m.userid where m.rdocno='"+rdocno+"'  and m.bibpid=1 group by m.doc_no ";
 
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
     				stmtVeh.close();
     				conn.close();
            
            	
          

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
	public JSONArray dispute(String brnchval) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        Connection conn =null;
       
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
				//String sql="";
				//ResultSet resultSet ;
				//System.out.println("========="+brnchval);
            	if(brnchval.equalsIgnoreCase("a"))
            	{
            		String sql="select r.voc_no,bv.fdate, if(r.clstatus=0,'Open','Closed') clstatus, r.brhid, r.doc_no,r.fleet_no,r.cldocno,r.odate,r.otime,"
            				+ "r.okm,r.ddate,r.dtime,v.reg_no,v.FLNAME vehdetails,a.refname,a.per_mob,a.contactperson,t.rentaltype from gl_ragmt r "
            				+ " left join gl_vehmaster v on r.fleet_no=v.fleet_no left join my_acbook a on a.cldocno=r.cldocno and a.dtype='CRM'   "
            				+ " left join gl_vehgroup g on g.doc_no=v.vgrpid left join gl_rtarif t on t.rdocno=r.doc_no and t.rstatus=5  "
            				+ "left join (select max(b.doc_no) doc_no,rdocno from gl_bdis b group by  rdocno) b on(b.rdocno=r.doc_no)  "
            				+ "left join gl_bdis bv on b.doc_no=bv.doc_no  where  r.status=3 and  r.dispute=1 ";
         
            	   	ResultSet resultSet = stmtVeh.executeQuery(sql);
            		RESULTDATA=ClsCommon.convertToJSON(resultSet);
     				stmtVeh.close();
     				
            	}
            	else{	
            		
            		String sql="select  r.voc_no,bv.fdate, if(r.clstatus=0,'Open','Closed') clstatus, r.brhid, r.doc_no,r.fleet_no,r.cldocno,r.odate,r.otime,"
            				+ "r.okm,r.ddate,r.dtime,v.reg_no,v.FLNAME vehdetails,a.refname,a.per_mob,a.contactperson,t.rentaltype from gl_ragmt r "
            				+ " left join gl_vehmaster v on r.fleet_no=v.fleet_no left join my_acbook a on a.cldocno=r.cldocno and a.dtype='CRM'   "
            				+ " left join gl_vehgroup g on g.doc_no=v.vgrpid left join gl_rtarif t on t.rdocno=r.doc_no and t.rstatus=5  "
            				+ "left join (select max(b.doc_no) doc_no,rdocno from gl_bdis b group by  rdocno) b on(b.rdocno=r.doc_no)  "
            				+ "left join gl_bdis bv on b.doc_no=bv.doc_no  where  r.status=3 and r.dispute=1  and  r.brhid='"+brnchval+"' ";
         
            
            	 //	System.out.println("----"+sql);
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            	 RESULTDATA=ClsCommon.convertToJSON(resultSet);
 				stmtVeh.close();
 				
            	}
            	conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
	public JSONArray disputeDetails(String rdocno) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn =null;
        try {
			 conn = ClsConnection.getMyConnection();
			Statement stmtVeh = conn.createStatement ();
			
			String sql=" select m.date detdate,m.remarks remk,m.fdate,u.user_name user from gl_bdis m "
    				+ " inner join my_user u on u.doc_no=m.userid where m.rdocno='"+rdocno+"'  and m.bibpid=4 group by m.doc_no ";
			

        	
        		ResultSet resultSet = stmtVeh.executeQuery(sql);
        		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
 				stmtVeh.close();
 				conn.close();
        
        	
      

	}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }


    public JSONArray clentdetails() throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn =null;
        try {
			 conn = ClsConnection.getMyConnection();
			Statement stmtVeh = conn.createStatement ();
			
			String sql="select cldocno,refname from my_acbook where status=3 and dtype='CRM'  ";
		 		ResultSet resultSet = stmtVeh.executeQuery(sql);
        		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
 				stmtVeh.close();
 				conn.close();
       
	}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }

    public JSONArray fleetdetails() throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn =null;
        try {
			 conn = ClsConnection.getMyConnection();
			Statement stmtVeh = conn.createStatement ();
			
			String sql="select fleet_no,flname,reg_no from gl_vehmaster where statu=3";
		 		ResultSet resultSet = stmtVeh.executeQuery(sql);
        		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
 				stmtVeh.close();
 				conn.close();
       
	}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
    public JSONArray groupdetails() throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        Connection conn = null;
       
        try {
			 conn = ClsConnection.getMyConnection();
			Statement stmtVeh = conn.createStatement ();
			
			String sql="select gname,doc_no from gl_vehgroup where status=3";
		 		ResultSet resultSet = stmtVeh.executeQuery(sql);
        		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
 				stmtVeh.close();
 				conn.close();
       
	}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
    public JSONArray modeldetails() throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        Connection conn =null;
       
        try {
			 conn = ClsConnection.getMyConnection();
			Statement stmtVeh = conn.createStatement ();
			
			String sql="select vtype,doc_no from gl_vehmodel where status=3";
		 		ResultSet resultSet = stmtVeh.executeQuery(sql);
        		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
 				stmtVeh.close();
 				conn.close();
       
	}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
    public JSONArray branddetails() throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        try {
			 conn = ClsConnection.getMyConnection();
			Statement stmtVeh = conn.createStatement ();
			
			String sql="select brand_name,doc_no from gl_vehbrand where status=3";
		 		ResultSet resultSet = stmtVeh.executeQuery(sql);
        		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
 				stmtVeh.close();
 				conn.close();
       
	}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
    
    public JSONArray detailsgrid(String brnchval,String fromdate,String todate,String cldocno,String status,String fleet, 
    		String group,String brand,String model,String type,String outchk,String inchk,String catid,String salesman) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        java.sql.Date sqlfromdate = null;
        if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
     	{
     		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
     		
     	}
     	else{
     
     	}

        java.sql.Date sqltodate = null;
     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
     	{
     		sqltodate=ClsCommon.changeStringtoSqlDate(todate);
     		
     	}
     	else{
     
     	}
     	
      	
    	String sqltest="";
    	if(!(status.equalsIgnoreCase("")|| status.equalsIgnoreCase("NA"))){
    		sqltest=sqltest+" and r.clstatus='"+status+"'";
    	}
    	if(!(cldocno.equalsIgnoreCase("") || cldocno.equalsIgnoreCase("NA"))){
    		sqltest=sqltest+" and a.cldocno='"+cldocno+"'";
    	}
    	if(!(fleet.equalsIgnoreCase("")|| fleet.equalsIgnoreCase("NA"))){
    		sqltest=sqltest+" and r.fleet_no='"+fleet+"'";
    	}
    	if(!(group.equalsIgnoreCase("") || group.equalsIgnoreCase("NA"))){
    		sqltest=sqltest+" and g.doc_no='"+group+"'";
    	}
    	if(!(model.equalsIgnoreCase("") || model.equalsIgnoreCase("NA"))){
    		sqltest=sqltest+" and mo.doc_no='"+model+"'";
    	}
    	if(!(brand.equalsIgnoreCase("")|| brand.equalsIgnoreCase("NA"))){
    		sqltest=sqltest+" and br.doc_no='"+brand+"'";
    	}
    	if(!(type.equalsIgnoreCase("") || type.equalsIgnoreCase("NA"))){
    		sqltest=sqltest+" and t.rentaltype='"+type+"' ";
    	}
    	if(!(catid.equalsIgnoreCase("") || catid.equalsIgnoreCase("NA"))){
    		sqltest=sqltest+" and a.catid='"+catid+"' ";
    	}
    	
    	
    	
    	if(!((brnchval.equalsIgnoreCase("a")) || (brnchval.equalsIgnoreCase("NA")))){
 			sqltest+=" and r.brhid="+brnchval+"";
 		}
    	
    	
    	if(inchk.equalsIgnoreCase("IN"))
    	{
    		sqltest+="	and  cs.indate between '"+sqlfromdate+"' and  '"+sqltodate+"' ";
    		
    	}
    	else
    	{
    		
    		sqltest+="	and  r.odate between '"+sqlfromdate+"' and  '"+sqltodate+"' ";
    	}
    	
    	
    	if(!salesman.equalsIgnoreCase("")){
    		sqltest+=" and ms.doc_no="+salesman;
    	}
    	
    	Connection conn =  null;
    	try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement (); 
			

            		
            		String sql ="select r.ofleet_no,v1.reg_no oreg_no,convert(coalesce(cs.indate,''),char(30)) indate,coalesce(cs.intime,'') intime,ur.user_name,clur.user_name closeuser, ms.sal_name ,"
            				+ " convert(if(r.invdate=r.odate,r.invdate,DATE_add(r.invdate,INTERVAL 1 DAY)),char(30)) AS invdate, cdr.name drname,convert(coalesce(r.refno,''),char(30)) refnos,r.mrano mrno,r.brhid, r.voc_no doc_no,r.fleet_no,r.cldocno,r.odate,r.otime,r.okm,r.ddate,r.dtime, "
            				+ " v.reg_no,v.FLNAME vehdetails,a.refname,a.cldocno,a.per_mob,a.contactperson,t.rentaltype,tc.rate rent,tc.cdw, "
            				+ " coalesce((select invoiced from gl_rcalc where rdocno=r.doc_no and invno >0 and idno=1 and rowno=(select max(rowno) from gl_rcalc where rdocno=r.doc_no and invno >0 and idno=1)),0) invRental, "
            				+ "coalesce((select invoiced from gl_rcalc where rdocno=r.doc_no and invno >0 and idno=17 and rowno=(select max(rowno) from gl_rcalc where rdocno=r.doc_no and invno >0 and idno=17)),0) invcdw "
            				+ " from gl_ragmt r	left join gl_vehmaster v on r.fleet_no=v.fleet_no left join my_acbook a on a.cldocno=r.cldocno   and a.dtype='CRM' "
            				+ "   left join gl_vehgroup g on g.doc_no=v.vgrpid    left join gl_vehmaster v1 on r.ofleet_no=v1.fleet_no  left join  gl_rtarif t on t.rdocno=r.doc_no and t.rstatus=5 "
            				+ " left join  gl_rtarif tc on tc.rdocno=r.doc_no and tc.rstatus=7 left join gl_vehbrand br   on br.doc_no=v.brdid "
            				+ " left join gl_vehmodel mo on  mo.doc_no=v.vmodid  left join gl_rdriver dr on dr.rdocno=r.doc_no and dr.status=3   "
            				+ " left join gl_drdetails cdr on cdr.dr_id=dr.drid  "
            				
            				+ " left join my_user ur on ur.doc_no=r.userid "
            				+ " left join gl_ragmtclosem cs on cs.agmtno=r.doc_no AND CS.STATUS=3 "
            				+ " left join my_user clur on clur.doc_no=cs.userid "
            				+ "left join my_salm ms on ms.doc_no=r.salid "
							
            				+ " where r.status=3   "+sqltest+ " group by r.doc_no";
            		
            	
             System.out.println("---123-----"+sql);
                
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
            		// System.out.println("--------"+RESULTDATA);
     				stmtVeh.close();
     				
            	
            	
            	conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
    
    
    public JSONArray detailsgrids(String brnchval,String fromdate,String todate,String cldocno,String status,String fleet, 
    		String group,String brand,String model,String type,String outchk,String inchk,String catid,String salesman) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        java.sql.Date sqlfromdate = null;
        if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
     	{
     		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
     		
     	}
     	else{
     
     	}

        java.sql.Date sqltodate = null;
     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
     	{
     		sqltodate=ClsCommon.changeStringtoSqlDate(todate);
     		
     	}
     	else{
     
     	}
     	
      	
    	String sqltest="";
    	if(!(status.equalsIgnoreCase("")|| status.equalsIgnoreCase("NA"))){
    		sqltest=sqltest+" and r.clstatus='"+status+"'";
    	}
    	if(!(cldocno.equalsIgnoreCase("") || cldocno.equalsIgnoreCase("NA"))){
    		sqltest=sqltest+" and a.cldocno='"+cldocno+"'";
    	}
    	if(!(fleet.equalsIgnoreCase("")|| fleet.equalsIgnoreCase("NA"))){
    		sqltest=sqltest+" and r.fleet_no='"+fleet+"'";
    	}
    	if(!(group.equalsIgnoreCase("") || group.equalsIgnoreCase("NA"))){
    		sqltest=sqltest+" and g.doc_no='"+group+"'";
    	}
    	if(!(model.equalsIgnoreCase("") || model.equalsIgnoreCase("NA"))){
    		sqltest=sqltest+" and mo.doc_no='"+model+"'";
    	}
    	if(!(brand.equalsIgnoreCase("")|| brand.equalsIgnoreCase("NA"))){
    		sqltest=sqltest+" and br.doc_no='"+brand+"'";
    	}
    	if(!(type.equalsIgnoreCase("") || type.equalsIgnoreCase("NA"))){
    		sqltest=sqltest+" and t.rentaltype='"+type+"' ";
    	}
    	if(!(catid.equalsIgnoreCase("") || catid.equalsIgnoreCase("NA"))){
    		sqltest=sqltest+" and a.catid='"+catid+"' ";
    	}
    	
    	
    	
    	if(!((brnchval.equalsIgnoreCase("a")) || (brnchval.equalsIgnoreCase("NA")))){
 			sqltest+=" and r.brhid="+brnchval+"";
 		}
    	
    	
    	if(inchk.equalsIgnoreCase("IN"))
    	{
    		sqltest+="	and  cs.indate between '"+sqlfromdate+"' and  '"+sqltodate+"' ";
    		
    	}
    	else
    	{
    		
    		sqltest+="	and  r.odate between '"+sqlfromdate+"' and  '"+sqltodate+"' ";
    	}
    	
    	if(!salesman.equalsIgnoreCase("")){
    		sqltest+=" and ms.doc_no="+salesman;
    	}
    	

    	
    	Connection conn =  null;
    	try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
			

            		
            		String sql =" select  @s:=@s+1 'SL No',a.* from (select r.voc_no 'RA NO',r.fleet_no Fleet,v.FLNAME 'Fleet Name',v.reg_no 'Reg NO',r.ofleet_no 'Contract Fleet',v1.reg_no 'Contract Reg No',a.refname 'Client Name',a.cldocno 'Client Id', " + 
            				" a.contactperson 'Contact Person', cdr.name 'Driver',a.per_mob 'Mob NO',t.rentaltype 'Rental Type', " + 
            				" r.odate 'Out Date',r.otime 'Out Time',r.ddate 'Due Date',r.dtime 'DueTime', " + 
            				" convert(coalesce(r.refno,''),char(30)) 'Ref No',r.mrano 'Manual RA', " + 
            				" convert(coalesce(cs.indate,''),char(30)) 'In Date',coalesce(cs.intime,'') 'In Time',ur.user_name 'Open User',clur.user_name 'Close User', ms.sal_name 'Salesman' ," + 
            				" convert(if(r.invdate=r.odate,r.invdate,DATE_add(r.invdate,INTERVAL 1 DAY)),char(30)) AS 'Inv Date', " + 
            				" tc.rate Rent,tc.cdw CDW, " + 
            				" coalesce((select invoiced from gl_rcalc where rdocno=r.doc_no and invno >0 and idno=1 and " + 
            				" rowno=(select max(rowno) from gl_rcalc where rdocno=r.doc_no and invno >0 and idno=1)),0) 'Inv Rent', " + 
            				" coalesce((select invoiced from gl_rcalc where rdocno=r.doc_no and invno >0 and idno=17 and " + 
            				" rowno=(select max(rowno) from gl_rcalc where rdocno=r.doc_no and invno >0 and idno=17)),0) 'Inv CDW' " + 
            				" from gl_ragmt r	left join gl_vehmaster v on r.fleet_no=v.fleet_no " + 
            				" left join my_acbook a on a.cldocno=r.cldocno   and a.dtype='CRM' " + 
            				" left join gl_vehgroup g on g.doc_no=v.vgrpid left join " + 
            				" gl_rtarif t on t.rdocno=r.doc_no and t.rstatus=5 " + 
            				" left join  gl_rtarif tc on tc.rdocno=r.doc_no and tc.rstatus=7 left join gl_vehbrand br " + 
            				" on br.doc_no=v.brdid  left join gl_vehmodel mo on  mo.doc_no=v.vmodid left join gl_vehmaster v1 on r.ofleet_no=v1.fleet_no  " + 
            				" left join gl_rdriver dr on dr.rdocno=r.doc_no and dr.status=3 " + 
            				" left join gl_drdetails cdr on cdr.dr_id=dr.drid " + 
            				 
            				" left join my_user ur on ur.doc_no=r.userid  left join gl_ragmtclosem cs on cs.agmtno=r.doc_no  AND CS.STATUS=3 "
            				+" left join my_user clur on clur.doc_no=cs.userid "
            				+ "left join my_salm ms on ms.doc_no=r.salid " + 
            				
            				" where r.status=3     "+sqltest+ " group by r.doc_no)a,(SELECT @s:= 0) s";
            		
            	
//            System.out.println("--------"+sql);
                
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
            		// System.out.println("--------"+RESULTDATA);
     				stmtVeh.close();
     				
            	
            	
            	conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
    public JSONArray complimentary(String brnchval,String fromdate,String todate,String cldocno,String status,String fleet,String group,String brand,String model,String type) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        java.sql.Date sqlfromdate = null;
        if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
     	{
     		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
     		
     	}
     	else{
     
     	}

        java.sql.Date sqltodate = null;
     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
     	{
     		sqltodate=ClsCommon.changeStringtoSqlDate(todate);
     		
     	}
     	else{
     
     	}
     	
      	
    	String sqltest="";
    	/*if(!(status.equalsIgnoreCase("")|| status.equalsIgnoreCase("NA"))){
    		sqltest=sqltest+" and r.clstatus='"+status+"'";
    	}*/
    	if(!(cldocno.equalsIgnoreCase("") || cldocno.equalsIgnoreCase("NA"))){
    		sqltest=sqltest+" and a.cldocno='"+cldocno+"'";
    	}
    	if(!(fleet.equalsIgnoreCase("")|| fleet.equalsIgnoreCase("NA"))){
    		sqltest=sqltest+" and r.fleet_no='"+fleet+"'";
    	}
    	if(!(group.equalsIgnoreCase("") || group.equalsIgnoreCase("NA"))){
    		sqltest=sqltest+" and g.doc_no='"+group+"'";
    	}
    	if(!(model.equalsIgnoreCase("") || model.equalsIgnoreCase("NA"))){
    		sqltest=sqltest+" and mo.doc_no='"+model+"'";
    	}
    	if(!(brand.equalsIgnoreCase("")|| brand.equalsIgnoreCase("NA"))){
    		sqltest=sqltest+" and br.doc_no='"+brand+"'";
    	}
    	if(!(type.equalsIgnoreCase("") || type.equalsIgnoreCase("NA"))){
    		sqltest=sqltest+" and t.rentaltype='"+type+"'";
    	}
    	Connection conn =  null;
    	try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
			
            	if(brnchval.equalsIgnoreCase("a"))
            	{
  
            		
            		String sql ="select r.voc_no,convert(if(r.invdate=r.odate,r.invdate,DATE_SUB(r.invdate,INTERVAL 1 DAY)),char(30)) AS invdate, cdr.name drname,r.refno refnos,r.mrano mrno,r.brhid, r.doc_no,r.fleet_no,r.cldocno,r.odate,r.otime,r.okm,r.ddate,r.dtime, "
            				+ " v.reg_no,v.FLNAME vehdetails,a.refname,a.per_mob,a.contactperson,t.rentaltype,tc.rate rent,tc.cdw, "
            				+ " coalesce((select invoiced from gl_rcalc where rdocno=r.doc_no and invno >0 and idno=1 and rowno=(select max(rowno) from gl_rcalc where rdocno=r.doc_no and invno >0 and idno=1)),0) invRental, "
            				+ "coalesce((select invoiced from gl_rcalc where rdocno=r.doc_no and invno >0 and idno=17 and rowno=(select max(rowno) from gl_rcalc where rdocno=r.doc_no and invno >0 and idno=17)),0) invcdw "
            				+ " from gl_ragmt r	left join gl_vehmaster v on r.fleet_no=v.fleet_no left join my_acbook a on a.cldocno=r.cldocno   and a.dtype='CRM' "
            				+ "   left join gl_vehgroup g on g.doc_no=v.vgrpid left join  gl_rtarif t on t.rdocno=r.doc_no and t.rstatus=5 "
            				+ " left join  gl_rtarif tc on tc.rdocno=r.doc_no and tc.rstatus=7 left join gl_vehbrand br   on br.doc_no=v.brdid "
            				+ " left join gl_vehmodel mo on  mo.doc_no=v.vmodid  left join gl_rdriver dr on dr.rdocno=r.doc_no and dr.status=3 left join gl_drdetails cdr on cdr.dr_id=dr.drid "
            				+ " where r.invtype<>3 and r.clstatus=0 and r.odate between '"+sqlfromdate+"' and  '"+sqltodate+"' "+sqltest+ " group by r.doc_no";
            		
            	//System.out.println(""+sql);
            	
                
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
            		// System.out.println("--------"+RESULTDATA);
     				stmtVeh.close();
     				
            	}
            	else{	
            		
            		String sql ="select  r.voc_no,convert(if(r.invdate=r.odate,r.invdate,DATE_SUB(r.invdate,INTERVAL 1 DAY)),char(30)) AS invdate, cdr.name drname,r.refno refnos,r.mrano mrno,r.brhid, r.doc_no,r.fleet_no,r.cldocno,r.odate,r.otime,r.okm,r.ddate,r.dtime, "
            				+ " v.reg_no,v.FLNAME vehdetails,a.refname,a.per_mob,a.contactperson,t.rentaltype,tc.rate rent,tc.cdw, "
            				+ " coalesce((select invoiced from gl_rcalc where rdocno=r.doc_no and invno >0 and idno=1 and rowno=(select max(rowno) from gl_rcalc where rdocno=r.doc_no and invno >0 and idno=1)),0) invRental, "
            				+ "coalesce((select invoiced from gl_rcalc where rdocno=r.doc_no and invno >0 and idno=17 and rowno=(select max(rowno) from gl_rcalc where rdocno=r.doc_no and invno >0 and idno=17)),0) invcdw "
            				+ " from gl_ragmt r	left join gl_vehmaster v on r.fleet_no=v.fleet_no left join my_acbook a on a.cldocno=r.cldocno   and a.dtype='CRM' "
            				+ "   left join gl_vehgroup g on g.doc_no=v.vgrpid left join  gl_rtarif t on t.rdocno=r.doc_no and t.rstatus=5 "
            				+ " left join  gl_rtarif tc on tc.rdocno=r.doc_no and tc.rstatus=7 left join gl_vehbrand br   on br.doc_no=v.brdid "
            				+ " left join gl_vehmodel mo on  mo.doc_no=v.vmodid  left join gl_rdriver dr on dr.rdocno=r.doc_no and dr.status=3  left join gl_drdetails cdr on cdr.dr_id=dr.drid "
            				+ " where  r.invtype<>3 and r.clstatus=0 and r.odate between '"+sqlfromdate+"' and  '"+sqltodate+"' and r.brhid='"+brnchval+"' "+sqltest+ " group by r.doc_no";
            
            	//	System.out.println("sss"+sql);
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            	 RESULTDATA=ClsCommon.convertToJSON(resultSet);
 				stmtVeh.close();
 				
            	}
            	conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
    public JSONArray complimentarylist(String brnchval,String fromdate,String todate) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        java.sql.Date sqlfromdate = null;
        if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
     	{
     		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
     		
     	}
     	else{
     
     	}

        java.sql.Date sqltodate = null;
     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
     	{
     		sqltodate=ClsCommon.changeStringtoSqlDate(todate);
     		
     	}
     	else{
     
     	}
     	

    	
    	Connection conn =  null;
    	try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
			
            	if(brnchval.equalsIgnoreCase("a"))
            	{
          
            		
            		String sql ="select  r.voc_no,r.brhid, r.doc_no,r.fleet_no,r.cldocno,r.odate,r.otime,r.okm,r.ddate,r.dtime, "
            				+ " v.reg_no,v.FLNAME vehdetails,a.refname,a.per_mob,a.contactperson,t.rentaltype  from gl_ragmt r "
            				+ "left join gl_vehmaster v on r.fleet_no=v.fleet_no left join my_acbook a on a.cldocno=r.cldocno   and a.dtype='CRM' "
            				+ "  left join  gl_rtarif t on t.rdocno=r.doc_no and t.rstatus=5 where  r.invtype=3  and r.status=3 "
            				+ " and r.odate between '"+sqlfromdate+"' and  '"+sqltodate+"'  group by r.doc_no";
            		
            
                //System.out.println("---sql-"+sql);
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		RESULTDATA=ClsCommon.convertToJSON(resultSet);
            		
     				stmtVeh.close();
     				
            	}
            	else{	
            		
            	String sql ="select r.voc_no,r.brhid, r.doc_no,r.fleet_no,r.cldocno,r.odate,r.otime,r.okm,r.ddate,r.dtime, "
            				+ " v.reg_no,v.FLNAME vehdetails,a.refname,a.per_mob,a.contactperson,t.rentaltype  from gl_ragmt r "
            				+ " left join gl_vehmaster v on r.fleet_no=v.fleet_no left join my_acbook a on a.cldocno=r.cldocno   and a.dtype='CRM' "
            				+ "  left join  gl_rtarif t on t.rdocno=r.doc_no and t.rstatus=5 where  r.invtype=3 and r.status=3  "
            				+ " and r.brhid='"+brnchval+"' and  r.odate between '"+sqlfromdate+"' and  '"+sqltodate+"'  group by r.doc_no";
            	
     
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            	 RESULTDATA=ClsCommon.convertToJSON(resultSet);
 				stmtVeh.close();
 				
            	}
            	conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
    
    
 
    
    public  JSONArray userdiscount(String brnchval) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        
     	
      	
    
    	Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
			
            	if(brnchval.equalsIgnoreCase("a"))
            	{
         
            		
            		String sql ="select r.date,r.voc_no ,r.doc_no,n.user_name newuser,o.user_name ousername,a.refname from gl_ragmt r inner join gl_rdisclevel l on l.rdocno=r.doc_no\r\n" + 
            				"left join my_acbook a on a.cldocno=r.cldocno and a.dtype='CRM'\r\n" + 
            				"left join my_user n on n.doc_no=l.nuserid\r\n" + 
            				"left join my_user o on o.doc_no=l.ouserid\r\n" + 
            				"left join gl_rtarif t on t.rdocno=r.doc_no and rstatus=6\r\n" + 
            				" where r.status=3 and (t.rate<>0 or t.cdw<>0 or t.pai<>0 or t.cdw1<>0 or t.pai1<>0 or t.gps<>0 or t.babyseater<>0 or\r\n" + 
            				" t.cooler<>0 or t.kmrest<>0 or t.exkmrte<>0 or t.oinschg<>0 or t.exhrchg<>0 or t.chaufchg<>0 or t.chaufexchg<>0 )  group by r.doc_no";


            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
     				stmtVeh.close();
     				
            	}
            	else{	
            		
 
            		String sql ="  select r.date, r.voc_no ,r.doc_no,n.user_name newuser,o.user_name ousername,a.refname from gl_ragmt r inner join gl_rdisclevel l on l.rdocno=r.doc_no\r\n" + 
            				"left join my_acbook a on a.cldocno=r.cldocno and a.dtype='CRM'\r\n" + 
            				"left join my_user n on n.doc_no=l.nuserid\r\n" + 
            				"left join my_user o on o.doc_no=l.ouserid\r\n" + 
            				"left join gl_rtarif t on t.rdocno=r.doc_no and rstatus=6\r\n" + 
            				" where r.status=3 and (t.rate<>0 or t.cdw<>0 or t.pai<>0 or t.cdw1<>0 or t.pai1<>0 or t.gps<>0 or t.babyseater<>0 or\r\n" + 
            				" t.cooler<>0 or t.kmrest<>0 or t.exkmrte<>0 or t.oinschg<>0 or t.exhrchg<>0 or t.chaufchg<>0 or t.chaufexchg<>0 ) and r.brhid='"+brnchval+"' group by r.doc_no"; 
            	 //System.out.println(sql);
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            	 RESULTDATA=ClsCommon.convertToJSON(resultSet);
 				stmtVeh.close();
 				
            	}
            	conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
    
    
    public JSONArray termdetailsgrid(String brnchval,String fromdate,String todate,String cldocno,String status,String fleet,String group,String brand,String model,String type) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        java.sql.Date sqlfromdate = null;
        if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
     	{
     		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
     		
     	}
     	else{
     
     	}

        java.sql.Date sqltodate = null;
     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
     	{
     		sqltodate=ClsCommon.changeStringtoSqlDate(todate);
     		
     	}
     	else{
     
     	}
     	
      	
    	String sqltest="";
    	if(!(status.equalsIgnoreCase("")|| status.equalsIgnoreCase("NA"))){
    		sqltest=sqltest+" and r.clstatus='"+status+"'";
    	}
    	if(!(cldocno.equalsIgnoreCase("") || cldocno.equalsIgnoreCase("NA"))){
    		sqltest=sqltest+" and a.cldocno='"+cldocno+"'";
    	}
    	if(!(fleet.equalsIgnoreCase("")|| fleet.equalsIgnoreCase("NA"))){
    		sqltest=sqltest+" and r.fleet_no='"+fleet+"'";
    	}
    	if(!(group.equalsIgnoreCase("") || group.equalsIgnoreCase("NA"))){
    		sqltest=sqltest+" and g.doc_no='"+group+"'";
    	}
    	if(!(model.equalsIgnoreCase("") || model.equalsIgnoreCase("NA"))){
    		sqltest=sqltest+" and mo.doc_no='"+model+"'";
    	}
    	if(!(brand.equalsIgnoreCase("")|| brand.equalsIgnoreCase("NA"))){
    		sqltest=sqltest+" and br.doc_no='"+brand+"'";
    	}
    	if(!(type.equalsIgnoreCase("") || type.equalsIgnoreCase("NA"))){
    		sqltest=sqltest+" and t.rentaltype='"+type+"'";
    	}
    	Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
			
            	if(brnchval.equalsIgnoreCase("a"))
            	{
            	/*	String sql ="select r.brhid, r.doc_no,r.fleet_no,r.cldocno,r.odate,r.otime,r.okm,r.ddate,r.dtime,t.gid,t.brhid branchname,r.tdocno, "
            				+ "v.reg_no,v.FLNAME vehdetails,a.refname,a.per_mob,a.contactperson,t.rentaltype from gl_ragmt r "
            				+ "left join gl_vehmaster v on r.fleet_no=v.fleet_no left join my_acbook a on a.cldocno=r.cldocno and a.dtype='CRM' "
            				+ " left join gl_vehgroup g on g.doc_no=v.vgrpid left join gl_rtarif t on t.rdocno=r.doc_no and t.rstatus=5  "
            				+ "left join gl_vehbrand br on br.doc_no=v.brdid left join gl_vehmodel mo on  mo.doc_no=v.vmodid "
            				+ " where  r.odate between '"+sqlfromdate+"' and  '"+sqltodate+"' "+sqltest;*/
            		
            		//select * from gl_vmove where trancode='DL' and status ='IN' and rdtype='RAG' and repno=0 and custno=0;
            		
            		String sql ="select r.voc_no,r.advchk radvc,r.invtype rinvtype,  a.advance clientadvc,a.invc_method clientinvtype,\r\n" 
            				 +	"( select method from gl_config where field_nme='Clientinvchk') method, "
            				 + "(select DATEDIFF(r.invdate,if(r.delstatus=1,mm.din,r.odate))) AS caludays, "
            				+ " r.insex,coalesce(insurexcess,0) insurexcess, coalesce(cdwexcess,0) cdwexcess,coalesce(scdwexcess,0) scdwexcess, "
            				+ "r.brhid, r.doc_no,r.fleet_no,r.cldocno,r.odate,r.otime,r.okm,r.ddate,r.dtime,t.gid,t.brhid branchname,r.tdocno, "
            				+ "v.reg_no,v.FLNAME vehdetails,a.refname,a.per_mob,a.contactperson,t.rentaltype from gl_ragmt r "
            				+ "left join gl_vehmaster v on r.fleet_no=v.fleet_no left join my_acbook a on a.cldocno=r.cldocno and a.dtype='CRM' "
            				+ "left join gl_vehgroup g on g.doc_no=v.vgrpid left join gl_rtarif t on t.rdocno=r.doc_no and t.rstatus=5  "
            				+ "left join gl_vehbrand br on br.doc_no=v.brdid left join gl_vehmodel mo on  mo.doc_no=v.vmodid  "
            				+ "left join gl_tarifexcess insu on insu.rdocno=r.tdocno and insu.gid=t.gid "
            				+ "  left join gl_vmove mm on mm.rdocno=r.doc_no and mm.rdtype='RAG' and mm.status='IN' and mm.trancode='DL' and mm.repno=0 and mm.custno=0  "
            				+ " where r.status=3 and r.odate between '"+sqlfromdate+"' and  '"+sqltodate+"' "+sqltest +" group by r.doc_no";
            		
            		
          //  	System.out.println(sql);
        
              
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
     				stmtVeh.close();
     				
            	}
            	else{	
            		
            /*		String sql ="select r.brhid, r.doc_no,r.fleet_no,r.cldocno,r.odate,r.otime,r.okm,r.ddate,r.dtime,t.gid,t.brhid branchname,r.tdocno, "
            				+ "v.reg_no,v.FLNAME vehdetails,a.refname,a.per_mob,a.contactperson,t.rentaltype from gl_ragmt r "
            				+ "left join gl_vehmaster v on r.fleet_no=v.fleet_no left join my_acbook a on a.cldocno=r.cldocno and a.dtype='CRM' "
            				+ " left join gl_vehgroup g on g.doc_no=v.vgrpid left join gl_rtarif t on t.rdocno=r.doc_no and t.rstatus=5  "
            				+ "left join gl_vehbrand br on br.doc_no=v.brdid left join gl_vehmodel mo on  mo.doc_no=v.vmodid "
            				+ " where  r.odate between '"+sqlfromdate+"' and  '"+sqltodate+"' and r.brhid='"+brnchval+"' "+sqltest;*/
            		String sql ="select r.voc_no,r.advchk radvc,r.invtype rinvtype,  a.advance clientadvc,a.invc_method clientinvtype,\r\n" 
           				 +	"( select method from gl_config where field_nme='Clientinvchk') method,  "
           				 + "(select DATEDIFF(r.invdate,if(r.delstatus=1,mm.dout,r.odate))) AS caludays, "
            				+ "  r.insex, coalesce(insurexcess,0) insurexcess, coalesce(cdwexcess,0) cdwexcess,coalesce(scdwexcess,0) scdwexcess, "
            				+"r.brhid, r.doc_no,r.fleet_no,r.cldocno,r.odate,r.otime,r.okm,r.ddate,r.dtime,t.gid,t.brhid branchname,r.tdocno, "
            				+ "v.reg_no,v.FLNAME vehdetails,a.refname,a.per_mob,a.contactperson,t.rentaltype from gl_ragmt r "
            				+ "left join gl_vehmaster v on r.fleet_no=v.fleet_no left join my_acbook a on a.cldocno=r.cldocno and a.dtype='CRM' "
            				+ " left join gl_vehgroup g on g.doc_no=v.vgrpid left join gl_rtarif t on t.rdocno=r.doc_no and t.rstatus=5  "
            				+ "left join gl_vehbrand br on br.doc_no=v.brdid left join gl_vehmodel mo on  mo.doc_no=v.vmodid "
            				+ " left join gl_tarifexcess insu on insu.rdocno=r.tdocno and insu.gid=t.gid "
            				+ "  left join gl_vmove mm on mm.rdocno=r.doc_no and mm.rdtype='RAG' and mm.status='IN' and mm.trancode='DL' and mm.repno=0 and mm.custno=0  "
            				+ " where  r.status=3 and r.odate between '"+sqlfromdate+"' and  '"+sqltodate+"' and r.brhid='"+brnchval+"' "+sqltest+" group by r.doc_no";
            	 //	System.out.println(sql);
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            	 RESULTDATA=ClsCommon.convertToJSON(resultSet);
 				stmtVeh.close();
 				
            	}
            	conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
    
    public JSONArray relodeterm(HttpSession session,String brnch,String tdocno,String group) throws SQLException {

    	  JSONArray RESULTDATA=new JSONArray();

        Connection conn=null;
		try {
				  conn = ClsConnection.getMyConnection();
				Statement stmtVeh5 = conn.createStatement ();
			       String userid=session.getAttribute("USERID")==null?"":session.getAttribute("USERID").toString();
				/*String  tarifsql=("select rdocno,gid,rentaltype,rate,cdw,pai,cdw1,pai1,gps,babyseater,cooler,kmrest,exkmrte,oinschg,exhrchg,chaufchg,chaufexchg "
						+ " from gl_rtarif where rdocno='"+txtrentaldocno+"' and gid='"+group+"' and brhid="+brnch+"  order by rstatus");
				*/
				
				String  tarifsql=("select m1.renttype rentaltype,m1.doc_no,m1.cdw,m1.pai,m1.kmrest,m1.exkmrte,m1.rate,m1.cdw1,m1.pai1,m1.gps,m1.babyseater,m1.cooler,m1.oinschg,m1.chaufchg,  "
						+ "	m1.chaufexchg,m1.exhrchg,m1.gid,case when u.ulevel=1 then m1.disclevel1 when u.ulevel=2 then m1.disclevel2 when u.ulevel=3 then m1.disclevel3 else 0  "
						+ "	end as 'disclevel'  from gl_tarifm M inner join gl_tarifd m1 on m.doc_no=m1.doc_no 	left join my_user u on u.doc_no='"+userid+"' where m1.gid='"+group+"'  and  "
						+ "	m.doc_no='"+tdocno+"'   and m1.renttype='Monthly ' ");
				
				//System.out.println("------------------------------"+tarifsql);
				ResultSet resultSet = stmtVeh5.executeQuery (tarifsql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				stmtVeh5.close();
				conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
    
    
    public JSONArray paymentpreauth(String brnchval,String fromdate,String todate,String cldocno,String status,String fleet,String group,String brand,String model,String type) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        java.sql.Date sqlfromdate = null;
        if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
     	{
     		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
     		
     	}
     	else{
     
     	}

        java.sql.Date sqltodate = null;
     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
     	{
     		sqltodate=ClsCommon.changeStringtoSqlDate(todate);
     		
     	}
     	else{
     
     	}
     	
      	
    	String sqltest="";
    	if(!(status.equalsIgnoreCase("")|| status.equalsIgnoreCase("NA"))){
    		sqltest=sqltest+" and r.clstatus='"+status+"'";
    	}
    	if(!(cldocno.equalsIgnoreCase("") || cldocno.equalsIgnoreCase("NA"))){
    		sqltest=sqltest+" and a.cldocno='"+cldocno+"'";
    	}
    	if(!(fleet.equalsIgnoreCase("")|| fleet.equalsIgnoreCase("NA"))){
    		sqltest=sqltest+" and r.fleet_no='"+fleet+"'";
    	}
    	if(!(group.equalsIgnoreCase("") || group.equalsIgnoreCase("NA"))){
    		sqltest=sqltest+" and g.doc_no='"+group+"'";
    	}
    	if(!(model.equalsIgnoreCase("") || model.equalsIgnoreCase("NA"))){
    		sqltest=sqltest+" and mo.doc_no='"+model+"'";
    	}
    	if(!(brand.equalsIgnoreCase("")|| brand.equalsIgnoreCase("NA"))){
    		sqltest=sqltest+" and br.doc_no='"+brand+"'";
    	}
  /*  	if(!(type.equalsIgnoreCase("") || type.equalsIgnoreCase("NA"))){
    		sqltest=sqltest+" and t.rentaltype='"+type+"'";
    	}*/
    	Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();

				
            	if(brnchval.equalsIgnoreCase("a"))
            	{
          
            		String sql ="select  r.voc_no,r.insex,coalesce(insurexcess,0) insurexcess, coalesce(cdwexcess,0) cdwexcess,coalesce(scdwexcess,0) scdwexcess, "
            				+ "r.brhid, r.doc_no,r.fleet_no,r.cldocno,r.odate,r.otime,r.okm,r.ddate,r.dtime,t.gid,t.brhid branchname,r.tdocno, "
            				+ "v.reg_no,v.FLNAME vehdetails,a.refname,a.per_mob,a.contactperson,t.rentaltype from gl_ragmt r "
            				+ "left join gl_vehmaster v on r.fleet_no=v.fleet_no left join my_acbook a on a.cldocno=r.cldocno and a.dtype='CRM' "
            				+ " left join gl_vehgroup g on g.doc_no=v.vgrpid left join gl_rtarif t on t.rdocno=r.doc_no and t.rstatus=5  "
            				+ "left join gl_vehbrand br on br.doc_no=v.brdid left join gl_vehmodel mo on  mo.doc_no=v.vmodid  "
            				+ "left join gl_tarifexcess insu on insu.rdocno=r.tdocno and insu.gid=t.gid "
            				+ " where r.status=3 and r.odate between '"+sqlfromdate+"' and  '"+sqltodate+"' "+sqltest +" group by r.doc_no";
            		
            		
            //	System.out.println("-------------------"+sql);
        
              
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
     				stmtVeh.close();
     				
            	}
            	else{	
            		
 
            		String sql ="select  r.voc_no,r.insex,coalesce(insurexcess,0) insurexcess, coalesce(cdwexcess,0) cdwexcess,coalesce(scdwexcess,0) scdwexcess, "
            				+"r.brhid, r.doc_no,r.fleet_no,r.cldocno,r.odate,r.otime,r.okm,r.ddate,r.dtime,t.gid,t.brhid branchname,r.tdocno, "
            				+ "v.reg_no,v.FLNAME vehdetails,a.refname,a.per_mob,a.contactperson,t.rentaltype from gl_ragmt r "
            				+ "left join gl_vehmaster v on r.fleet_no=v.fleet_no left join my_acbook a on a.cldocno=r.cldocno and a.dtype='CRM' "
            				+ " left join gl_vehgroup g on g.doc_no=v.vgrpid left join gl_rtarif t on t.rdocno=r.doc_no and t.rstatus=5  "
            				+ "left join gl_vehbrand br on br.doc_no=v.brdid left join gl_vehmodel mo on  mo.doc_no=v.vmodid "
            				+ " left join gl_tarifexcess insu on insu.rdocno=r.tdocno and insu.gid=t.gid "
            				+ " where  r.status=3 and  r.odate between '"+sqlfromdate+"' and  '"+sqltodate+"' and r.brhid='"+brnchval+"' "+sqltest+" group by r.doc_no";
     
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            	 RESULTDATA=ClsCommon.convertToJSON(resultSet);
 				stmtVeh.close();
 				
            	}
            	conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
    
    
    public JSONArray rataiffgrid(String rdocno) throws SQLException {

  	  JSONArray RESULTDATA=new JSONArray();

      Connection conn=null;
		try {
				  conn = ClsConnection.getMyConnection();
				Statement stmtVeh5 = conn.createStatement ();
          	
				String  tarifsql=("select  rentaltype, rate, cdw, pai, cdw1, pai1, gps, babyseater, cooler, kmrest, exkmrte, oinschg, exhrchg, chaufchg,"
						+ " chaufexchg from gl_rtarif where rdocno='"+rdocno+"' and rstatus>=5 order by rstatus;");
			 //System.out.println("------------------------------"+tarifsql);
				
				ResultSet resultSet = stmtVeh5.executeQuery (tarifsql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				stmtVeh5.close();
				conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
      return RESULTDATA;
  }
    
    public JSONArray catnamesearchdetails() throws SQLException {

    	  JSONArray RESULTDATA=new JSONArray();

        Connection conn=null;
  		try {
  				  conn = ClsConnection.getMyConnection();
  				Statement stmtVeh5 = conn.createStatement ();
            	
  				String  tarifsql=("select cat_name,doc_no from my_clcatm where dtype='CRM' and status=3;");
  			//	System.out.println("------------------------------"+tarifsql);
  				
  				ResultSet resultSet = stmtVeh5.executeQuery (tarifsql);
  				RESULTDATA=ClsCommon.convertToJSON(resultSet);
  				stmtVeh5.close();
  				conn.close();
  		}
  		catch(Exception e){
  			e.printStackTrace();
  			conn.close();
  		}
  		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
      
     public JSONArray tariffchangedetailsgrid(String brnchval,String fromdate,String todate,String cldocno,String status,String fleet,String group,String brand,String model,String type) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        java.sql.Date sqlfromdate = null;
        if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
     	{
     		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
     		
     	}
     	else{
     
     	}

        java.sql.Date sqltodate = null;
     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
     	{
     		sqltodate=ClsCommon.changeStringtoSqlDate(todate);
     		
     	}
     	else{
     
     	}
     	
      	
    	String sqltest="";
    	if(!(status.equalsIgnoreCase("")|| status.equalsIgnoreCase("NA"))){
    		sqltest=sqltest+" and r.clstatus='"+status+"'";
    	}
    	if(!(cldocno.equalsIgnoreCase("") || cldocno.equalsIgnoreCase("NA"))){
    		sqltest=sqltest+" and a.cldocno='"+cldocno+"'";
    	}
    	if(!(fleet.equalsIgnoreCase("")|| fleet.equalsIgnoreCase("NA"))){
    		sqltest=sqltest+" and r.fleet_no='"+fleet+"'";
    	}
    	if(!(group.equalsIgnoreCase("") || group.equalsIgnoreCase("NA"))){
    		sqltest=sqltest+" and g.doc_no='"+group+"'";
    	}
    	if(!(model.equalsIgnoreCase("") || model.equalsIgnoreCase("NA"))){
    		sqltest=sqltest+" and mo.doc_no='"+model+"'";
    	}
    	if(!(brand.equalsIgnoreCase("")|| brand.equalsIgnoreCase("NA"))){
    		sqltest=sqltest+" and br.doc_no='"+brand+"'";
    	}
    	if(!(type.equalsIgnoreCase("") || type.equalsIgnoreCase("NA"))){
    		sqltest=sqltest+" and t.rentaltype='"+type+"'";
    	}
    	Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
			
            	if(brnchval.equalsIgnoreCase("a"))
            	{
            	/*	String sql ="select r.brhid, r.doc_no,r.fleet_no,r.cldocno,r.odate,r.otime,r.okm,r.ddate,r.dtime,t.gid,t.brhid branchname,r.tdocno, "
            				+ "v.reg_no,v.FLNAME vehdetails,a.refname,a.per_mob,a.contactperson,t.rentaltype from gl_ragmt r "
            				+ "left join gl_vehmaster v on r.fleet_no=v.fleet_no left join my_acbook a on a.cldocno=r.cldocno and a.dtype='CRM' "
            				+ " left join gl_vehgroup g on g.doc_no=v.vgrpid left join gl_rtarif t on t.rdocno=r.doc_no and t.rstatus=5  "
            				+ "left join gl_vehbrand br on br.doc_no=v.brdid left join gl_vehmodel mo on  mo.doc_no=v.vmodid "
            				+ " where  r.odate between '"+sqlfromdate+"' and  '"+sqltodate+"' "+sqltest;*/
            		
            		//select * from gl_vmove where trancode='DL' and status ='IN' and rdtype='RAG' and repno=0 and custno=0;
            		
            		String sql ="select r.voc_no,r.advchk radvc,r.invtype rinvtype,DATE_FORMAT(r.invdate,'%d-%m-%Y') rinvdate, a.advance clientadvc,a.invc_method clientinvtype,\r\n" 
            				 +	"( select method from gl_config where field_nme='Clientinvchk') method, "
            				 + "(select 0) AS caludays, "
            				+ " r.insex,coalesce(insurexcess,0) insurexcess, coalesce(cdwexcess,0) cdwexcess,coalesce(scdwexcess,0) scdwexcess, "
            				+ "r.brhid, r.doc_no,r.fleet_no,r.cldocno,r.odate,r.otime,r.okm,r.ddate,r.dtime,t.gid,t.brhid branchname,r.tdocno, "
            				+ "v.reg_no,v.FLNAME vehdetails,a.refname,a.per_mob,a.contactperson,t.rentaltype from gl_ragmt r "
            				+ "left join gl_vehmaster v on r.fleet_no=v.fleet_no left join my_acbook a on a.cldocno=r.cldocno and a.dtype='CRM' "
            				+ " left join gl_vehgroup g on g.doc_no=v.vgrpid left join gl_rtarif t on t.rdocno=r.doc_no and t.rstatus=5  "
            				+ "left join gl_vehbrand br on br.doc_no=v.brdid left join gl_vehmodel mo on  mo.doc_no=v.vmodid  "
            				+ "left join gl_tarifexcess insu on insu.rdocno=r.tdocno and insu.gid=t.gid "
            				+ "  left join gl_vmove mm on mm.rdocno=r.doc_no and mm.rdtype='RAG' and mm.status='IN' and mm.trancode='DL' and mm.repno=0 and mm.custno=0  "
            				+ " where r.status=3  and r.odate between '"+sqlfromdate+"' and  '"+sqltodate+"' "+sqltest +" group by r.doc_no";
            		
            		
            	System.out.println(sql);
        
              
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
     				stmtVeh.close();
     				
            	}
            	else{	
            		
            /*		String sql ="select r.brhid, r.doc_no,r.fleet_no,r.cldocno,r.odate,r.otime,r.okm,r.ddate,r.dtime,t.gid,t.brhid branchname,r.tdocno, "
            				+ "v.reg_no,v.FLNAME vehdetails,a.refname,a.per_mob,a.contactperson,t.rentaltype from gl_ragmt r "
            				+ "left join gl_vehmaster v on r.fleet_no=v.fleet_no left join my_acbook a on a.cldocno=r.cldocno and a.dtype='CRM' "
            				+ " left join gl_vehgroup g on g.doc_no=v.vgrpid left join gl_rtarif t on t.rdocno=r.doc_no and t.rstatus=5  "
            				+ "left join gl_vehbrand br on br.doc_no=v.brdid left join gl_vehmodel mo on  mo.doc_no=v.vmodid "
            				+ " where  r.odate between '"+sqlfromdate+"' and  '"+sqltodate+"' and r.brhid='"+brnchval+"' "+sqltest;*/
            		String sql ="select r.voc_no,r.advchk radvc,r.invtype rinvtype, DATE_FORMAT(r.invdate,'%d-%m-%Y') rinvdate, a.advance clientadvc,a.invc_method clientinvtype,\r\n" 
           				 +	"( select method from gl_config where field_nme='Clientinvchk') method,  "
           				 + "(select 0) AS caludays, "
            				+ "  r.insex, coalesce(insurexcess,0) insurexcess, coalesce(cdwexcess,0) cdwexcess,coalesce(scdwexcess,0) scdwexcess, "
            				+"r.brhid, r.doc_no,r.fleet_no,r.cldocno,r.odate,r.otime,r.okm,r.ddate,r.dtime,t.gid,t.brhid branchname,r.tdocno, "
            				+ "v.reg_no,v.FLNAME vehdetails,a.refname,a.per_mob,a.contactperson,t.rentaltype from gl_ragmt r "
            				+ "left join gl_vehmaster v on r.fleet_no=v.fleet_no left join my_acbook a on a.cldocno=r.cldocno and a.dtype='CRM' "
            				+ " left join gl_vehgroup g on g.doc_no=v.vgrpid left join gl_rtarif t on t.rdocno=r.doc_no and t.rstatus=5  "
            				+ "left join gl_vehbrand br on br.doc_no=v.brdid left join gl_vehmodel mo on  mo.doc_no=v.vmodid "
            				+ " left join gl_tarifexcess insu on insu.rdocno=r.tdocno and insu.gid=t.gid "
            				+ "  left join gl_vmove mm on mm.rdocno=r.doc_no and mm.rdtype='RAG' and mm.status='IN' and mm.trancode='DL' and mm.repno=0 and mm.custno=0  "
            				+ " where  r.status=3 and r.odate between '"+sqlfromdate+"' and  '"+sqltodate+"' and r.brhid='"+brnchval+"' "+sqltest+" group by r.doc_no";
            	 //	System.out.println(sql);
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            	 RESULTDATA=ClsCommon.convertToJSON(resultSet);
 				stmtVeh.close();
 				
            	}
            	conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
    
    
    
    public JSONArray tariffapprovedetailsgrid(String brnchval,String fromdate,String todate,String cldocno,String type,String rano) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        java.sql.Date sqlfromdate = null;
        if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
     	{
     		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
     		
     	}
     	else{
     
     	}

        java.sql.Date sqltodate = null;
     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
     	{
     		sqltodate=ClsCommon.changeStringtoSqlDate(todate);
     		
     	}
     	else{
     
     	}
     	
      	
    	String sqltest="";
    
    	if(!(cldocno.equalsIgnoreCase("") || cldocno.equalsIgnoreCase("NA"))){
    		sqltest=sqltest+" and b.cldocno='"+cldocno+"'";
    	}
    	if(!(rano.equalsIgnoreCase("") || rano.equalsIgnoreCase("NA"))){
    		sqltest=sqltest+" and b.rano='"+rano+"'";
    	}
    	if(!(type.equalsIgnoreCase("") || type.equalsIgnoreCase("NA"))){
    		sqltest=sqltest+" and b.nrenttype='"+type+"'";
    	}
    	if(!(brnchval.equalsIgnoreCase("a"))){
    		sqltest=sqltest+" and b.brchid='"+brnchval+"'";
    	}
    	Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
			
            		
            		String sql="select b.rvocno,br.branchname branch,a.refname,b.orenttype,b.nrenttype,gr.invdate,if(b.oadvchk=1,'YES','NO') oadvchk ,if(b.nadvchk=1,'YES','NO') nadvchk,if(b.oinvtype=1,'Month End','Period') oinvtype,if(b.ninvtype=1,'Month End','Period') ninvtype,b.date,"
            				 +	"a.advance clientadvc,a.invc_method clientinvtype,( select method from gl_config where field_nme='Clientinvchk') method, "
            				+ "b.brchid,b.idgl_brex brexid,b.rano from gl_brex b left join my_acbook a on a.cldocno=b.cldocno and a.dtype='CRM' "
            				+ "left join my_brch br on br.doc_no=b.brchid left join gl_ragmt gr on gr.doc_no=b.rano where b.approvestatus=0 and b.date between '"+sqlfromdate+"' and  '"+sqltodate+"' "+sqltest+" ";
          //  	System.out.println("============="+sql);
        
              
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
     				stmtVeh.close();
     			
            	conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }


   public JSONArray ratariffchangegrid(String rdocno) throws SQLException {

    	  JSONArray RESULTDATA=new JSONArray();

        Connection conn=null;
  		try {
  				  conn = ClsConnection.getMyConnection();
  				Statement stmtVeh5 = conn.createStatement ();
            	
  				String  tarifsql=("select  rentaltype, rate, cdw, pai, cdw1, pai1, gps, babyseater, cooler, kmrest, exkmrte, oinschg, exhrchg, chaufchg,"
  						+ " chaufexchg from gl_rtarif where rdocno='"+rdocno+"' and rstatus<5 order by rstatus;");
  			 //System.out.println("------------------------------"+tarifsql);
  				
  				ResultSet resultSet = stmtVeh5.executeQuery (tarifsql);
  				RESULTDATA=ClsCommon.convertToJSON(resultSet);
  				stmtVeh5.close();
  				conn.close();
  		}
  		catch(Exception e){
  			e.printStackTrace();
  			conn.close();
  		}
  		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
    
    public JSONArray ratariffapprovegrid(String rdocno,String brexid) throws SQLException {

    	  JSONArray RESULTDATA=new JSONArray();

        Connection conn=null;
  		try {
  				  conn = ClsConnection.getMyConnection();
  				Statement stmtVeh5 = conn.createStatement ();
            	
  				String  tarifsql=("select  rentaltype, rate, cdw, pai, cdw1, pai1, gps, babyseater, cooler, kmrest, exkmrte, oinschg, exhrchg, chaufchg,"
  						+ " chaufexchg from gl_brexd where rdocno='"+rdocno+"' and refno='"+brexid+"' order by rstatus;");
  				
  				ResultSet resultSet = stmtVeh5.executeQuery (tarifsql);
  				RESULTDATA=ClsCommon.convertToJSON(resultSet);
  				stmtVeh5.close();
  				conn.close();
  		}
  		catch(Exception e){
  			e.printStackTrace();
  			conn.close();
  		}
  		//System.out.println(RESULTDATA);
        return RESULTDATA;
    } 

 public JSONArray ranodetails() throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn =null;
        try {
			 conn = ClsConnection.getMyConnection();
			Statement stmtVeh = conn.createStatement ();
			
			String sql="select rvocno,nrenttype newtype,rano  from gl_brex where approvestatus=0 group by rvocno";
		 		ResultSet resultSet = stmtVeh.executeQuery(sql);
        		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
 				stmtVeh.close();
 				conn.close();
       
	}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
 
 
 public JSONArray getSalesmanData() throws SQLException {

     JSONArray RESULTDATA=new JSONArray();
     
     Connection conn =null;
     try {
			 conn = ClsConnection.getMyConnection();
			Statement stmtVeh = conn.createStatement ();
			String sql="select doc_no,sal_name from my_salm where status=3";
		 		ResultSet resultSet = stmtVeh.executeQuery(sql);
     		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
				stmtVeh.close();
				conn.close();
    
	}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
     return RESULTDATA;
 }
    
}
