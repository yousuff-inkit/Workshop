package com.dashboard.leaseagreement;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;




import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.operations.agreement.leaseagmt_alfahim.ClsLeaseAgmtAlFahimBean;


public class ClsleaseagreementDAO {
	
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	
	
	public JSONArray delupdate(String brnchval) throws SQLException {

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
            		
            	/*	String sql="select if(perfleet=0,tmpfleet, perfleet)  fleet_no,r.voc_no,r.brhid, r.doc_no,r.date,r.cldocno, "
            				+ "r.outdate odate,r.outtime otime,r.outkm okm,CASE WHEN r.outfuel='0.000' "
            				+ "THEN 'Level 0/8' WHEN r.outfuel='0.125' THEN 'Level 1/8' WHEN r.outfuel='0.250' "
            				+ "THEN 'Level 2/8' WHEN r.outfuel='0.375' THEN 'Level 3/8' WHEN r.outfuel='0.500' "
            				+ "THEN 'Level 4/8'  WHEN r.outfuel='0.625' THEN 'Level 5/8'  WHEN r.outfuel='0.750' "
            				+ "THEN 'Level 6/8' WHEN r.outfuel='0.875'  THEN 'Level 7/8' WHEN r.outfuel='1.000' THEN 'Level 8/8' "
            				+ "  END as 'ofuel',r.outfuel hidfuel,r.drid,coalesce(v.reg_no,v1.reg_no) reg_no,coalesce(v.flname,v1.flname) flname, "
            				+ "coalesce(v.a_loc,v1.a_loc) a_loc, a.refname,coalesce(g.doc_no,g1.doc_no) gid,coalesce(g.gname,g1.gname) gname "
            				+ "  from gl_lagmt r left join gl_vehmaster v on  v.fleet_no=r.perfleet "
            				+ "left join gl_vehmaster v1 on  v1.fleet_no=r.tmpfleet  left join my_acbook a on a.cldocno=r.cldocno and a.dtype='CRM' "
            				+ "   left join gl_vehgroup g on g.doc_no=v.vgrpid   left join gl_vehgroup g1 on g1.doc_no=v1.vgrpid   "
            				+ " where r.clstatus=0 and r.delstatus=0 and r.delivery=1 and  r.vehupdate=1 group by r.doc_no";*/
            		
            		
            		String sql="select aa.*, CASE WHEN outfuel='0.000' THEN 'Level 0/8' WHEN outfuel='0.125' THEN 'Level 1/8' WHEN outfuel='0.250' THEN 'Level 2/8'   "
            				+ " WHEN 	outfuel='0.375'	THEN 'Level 3/8'	WHEN outfuel='0.500' THEN 'Level 4/8' WHEN outfuel='0.625' THEN 'Level 5/8'"
            				+ " WHEN outfuel='0.750' THEN 'Level 6/8' WHEN outfuel='0.875' THEN 'Level 7/8' WHEN outfuel='1.000' THEN 'Level 8/8' "
            				+ "   END as 'ofuel' from 	(select 'LAG' chktype,if(perfleet=0,tmpfleet, perfleet)  fleet_no,r.voc_no,convert(r.brhid,char(20)) brhid,"
            				+ "      r.doc_no,r.date,r.cldocno,  r.outdate odate,r.outtime otime,r.outkm okm,r.outfuel,r.outfuel hidfuel,convert(r.drid,char(20)) drid, "
            				+ " coalesce(v.reg_no,v1.reg_no) reg_no,coalesce(v.flname,v1.flname) flname,  a.refname,coalesce(v.a_loc,v1.a_loc) a_loc, "
            				+ "  coalesce(g.doc_no,g1.doc_no) gid,coalesce(g.gname,g1.gname) gname,s.sal_name from gl_lagmt r left join gl_vehmaster v on "
            				+ "  v.fleet_no=r.perfleet  left join gl_vehmaster v1 on  v1.fleet_no=r.tmpfleet  left join my_acbook a on a.cldocno=r.cldocno and a.dtype='CRM' "
            				+ "	left join my_salesman s on s.doc_no=r.drid and s.sal_type='DRV'  left join gl_vehgroup g on g.doc_no=v.vgrpid   "
            				+ " left join gl_vehgroup g1 on g1.doc_no=v1.vgrpid where r.clstatus=0 and r.delstatus=0 and r.delivery=1 and  r.vehupdate=1 group by r.doc_no "
            				+ " union all select 'VCU' chktype,c.fleet_no,c.doc_no voc_no,convert(veh.a_br,char(20)) a_br,c.doc_no,c.date, "
            				+ "  c.cldocno,c.odate,c.otime,c.okm,c.ofuel,c.ofuel hidfuel,'',veh.reg_no,veh.flname,      "
            				+ " 	a.refname,veh.a_loc,g.doc_no gid,g.gname,'' from gl_vehcustody c left join gl_ragmt ra on "
            				+ "   ra.doc_no=c.rdocno and c.rtype='LAG' 	left join gl_vehmaster veh on c.fleet_no=veh.fleet_no "
            				+ "  left join my_acbook a on a.cldocno=c.cldocno and a.dtype='CRM'   left join gl_vehgroup g on g.doc_no=veh.vgrpid where c.rtype='LAG' and c.delivery=1 and c.delstatus is null) aa ";
            		
            		
            	//	System.out.println("------sql----"+sql);
            
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
     				stmtVeh.close();
     				
            	}
            	else{		
            		
            		
            		
            		String sql="select aa.*, CASE WHEN outfuel='0.000' THEN 'Level 0/8' WHEN outfuel='0.125' THEN 'Level 1/8' WHEN outfuel='0.250' THEN 'Level 2/8'   "
            				+ " WHEN 	outfuel='0.375'	THEN 'Level 3/8'	WHEN outfuel='0.500' THEN 'Level 4/8' WHEN outfuel='0.625' THEN 'Level 5/8'"
            				+ " WHEN outfuel='0.750' THEN 'Level 6/8' WHEN outfuel='0.875' THEN 'Level 7/8' WHEN outfuel='1.000' THEN 'Level 8/8' "
            				+ "   END as 'ofuel' from 	(select 'LAG' chktype,if(perfleet=0,tmpfleet, perfleet)  fleet_no,r.voc_no,convert(r.brhid,char(20)) brhid,"
            				+ "      r.doc_no,r.date,r.cldocno,  r.outdate odate,r.outtime otime,r.outkm okm,r.outfuel,r.outfuel hidfuel,r.drid,"
            				+ " coalesce(v.reg_no,v1.reg_no) reg_no,coalesce(v.flname,v1.flname) flname,  a.refname,coalesce(v.a_loc,v1.a_loc) a_loc, "
            				+ "  coalesce(g.doc_no,g1.doc_no) gid,coalesce(g.gname,g1.gname) gname,s.sal_name from gl_lagmt r left join gl_vehmaster v on "
            				+ "  v.fleet_no=r.perfleet  left join gl_vehmaster v1 on  v1.fleet_no=r.tmpfleet  left join my_acbook a on a.cldocno=r.cldocno and a.dtype='CRM' "
            				+ "	left join my_salesman s on s.doc_no=r.drid and s.sal_type='DRV'  left join gl_vehgroup g on g.doc_no=v.vgrpid   "
            				+ " left join gl_vehgroup g1 on g1.doc_no=v1.vgrpid where r.clstatus=0 and r.delstatus=0 and r.delivery=1 and  r.vehupdate=1 group by r.doc_no "
            				+ " union all select 'VCU' chktype,c.fleet_no,c.doc_no voc_no,convert(veh.a_br,char(20)) a_br,c.doc_no,c.date, "
            				+ "  c.cldocno,c.odate,c.otime,c.okm,c.ofuel,c.ofuel hidfuel,'',veh.reg_no,veh.flname,      "
            				+ " 	a.refname,veh.a_loc,g.doc_no gid,g.gname,'' from gl_vehcustody c left join gl_ragmt ra on "
            				+ "   ra.doc_no=c.rdocno and c.rtype='LAG' 	left join gl_vehmaster veh on c.fleet_no=veh.fleet_no "
            				+ "  left join my_acbook a on a.cldocno=c.cldocno and a.dtype='CRM'   left join gl_vehgroup g on g.doc_no=veh.vgrpid where c.rtype='LAG' and c.delivery=1 and c.delstatus is null) aa  where aa.brhid='"+brnchval+"'";
            		
            		
            	//	System.out.println("------sql----"+sql);

            		
           
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
	
	
	public JSONArray rtaupdate(String brnchval) throws SQLException {

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
            		String sql="select r.voc_no, 'Attach' btnattach,'Edit' btnsave,r.brhid, r.doc_no,r.date,if(perfleet=0,tmpfleet, perfleet) fleet_no,r.cldocno,r.outdate "
            				+ " odate,r.outtime otime,r.outkm okm,CASE WHEN r.outfuel='0.000' THEN 'Level 0/8' WHEN r.outfuel='0.125' THEN 'Level 1/8'  "
            				+ "WHEN r.outfuel='0.250' THEN 'Level 2/8' WHEN r.outfuel='0.375'	THEN 'Level 3/8' "
            				+ "	WHEN r.outfuel='0.500' THEN 'Level 4/8'  WHEN r.outfuel='0.625' THEN 'Level 5/8' "
            				+ "  	WHEN r.outfuel='0.750' THEN 'Level 6/8' WHEN  r.outfuel='0.875'  THEN 'Level 7/8' WHEN r.outfuel='1.000' THEN 'Level 8/8' "
            				+ "    END as 'ofuel',r.outfuel  hidfuel,r.drid,coalesce(v.reg_no,v1.reg_no) reg_no,coalesce(v.flname,v1.flname) flname,a.refname from  "
            				+ "gl_lagmt r left join gl_vehmaster v on  v.fleet_no=r.perfleet "
            				+ "left join gl_vehmaster v1 on  v1.fleet_no=r.tmpfleet  left join my_acbook a on a.cldocno=r.cldocno and a.dtype='CRM'  "
            				+ "  where  r.clstatus=0 and r.rtaupdate=0 and r.vehupdate=1 ";
            	
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
     				stmtVeh.close();
     				
            	}
            	else{	
            		String sql="select r.voc_no,'Attach' btnattach,'Edit' btnsave,r.brhid, r.doc_no,r.date,if(perfleet=0,tmpfleet, perfleet) fleet_no,r.cldocno,r.outdate "
            				+ " odate,r.outtime otime,r.outkm okm,CASE WHEN r.outfuel='0.000' THEN 'Level 0/8' WHEN r.outfuel='0.125' THEN 'Level 1/8'  "
            				+ "WHEN r.outfuel='0.250' THEN 'Level 2/8' WHEN r.outfuel='0.375'	THEN 'Level 3/8' "
            				+ "	WHEN r.outfuel='0.500' THEN 'Level 4/8'  WHEN r.outfuel='0.625' THEN 'Level 5/8' "
            				+ "  	WHEN r.outfuel='0.750' THEN 'Level 6/8' WHEN  r.outfuel='0.875'  THEN 'Level 7/8' WHEN r.outfuel='1.000' THEN 'Level 8/8' "
            				+ "    END as 'ofuel',r.outfuel  hidfuel,r.drid,coalesce(v.reg_no,v1.reg_no) reg_no,coalesce(v.flname,v1.flname) flname,a.refname from  "
            				+ "gl_lagmt r left join gl_vehmaster v on  v.fleet_no=r.perfleet "
            				+ "left join gl_vehmaster v1 on  v1.fleet_no=r.tmpfleet  left join my_acbook a on a.cldocno=r.cldocno and a.dtype='CRM'  "
            				+ "  where  r.clstatus=0 and r.rtaupdate=0 and  r.vehupdate=1 and r.brhid='"+brnchval+"' ";
            	
            
            	 	
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
	public JSONArray openstatus(String brnchval) throws SQLException {

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
            		String sql="select r.voc_no,r.brhid, r.doc_no,r.date,if(perfleet=0,tmpfleet, perfleet) fleet_no,r.cldocno,r.outdate "
            				+ " odate,r.outtime otime,r.outkm okm,CASE WHEN r.outfuel='0.000' THEN 'Level 0/8' WHEN r.outfuel='0.125' THEN 'Level 1/8'  "
            				+ "WHEN r.outfuel='0.250' THEN 'Level 2/8' WHEN r.outfuel='0.375'	THEN 'Level 3/8' "
            				+ "	WHEN r.outfuel='0.500' THEN 'Level 4/8'  WHEN r.outfuel='0.625' THEN 'Level 5/8' "
            				+ "WHEN r.outfuel='0.750' THEN 'Level 6/8' WHEN  r.outfuel='0.875'  THEN 'Level 7/8' WHEN r.outfuel='1.000' THEN 'Level 8/8' "
            				+ "END as 'ofuel',r.outfuel  hidfuel,r.drid,coalesce(v.reg_no,v1.reg_no) reg_no,coalesce(v.flname,v1.flname) flname,a.refname from  "
            				+ "gl_lagmt r left join gl_vehmaster v on  v.fleet_no=r.perfleet "
            				+ "left join gl_vehmaster v1 on  v1.fleet_no=r.tmpfleet  left join my_acbook a on a.cldocno=r.cldocno and a.dtype='CRM'  "
            				+ "  where  r.clstatus=0 and  r.vehupdate=1 ";

            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
     				stmtVeh.close();
     				
            	}
            	else{	
            		String sql="select  r.voc_no,r.brhid, r.doc_no,r.date,if(perfleet=0,tmpfleet, perfleet) fleet_no,r.cldocno,r.outdate "
            				+ " odate,r.outtime otime,r.outkm okm,CASE WHEN r.outfuel='0.000' THEN 'Level 0/8' WHEN r.outfuel='0.125' THEN 'Level 1/8'  "
            				+ "WHEN r.outfuel='0.250' THEN 'Level 2/8' WHEN r.outfuel='0.375'	THEN 'Level 3/8' "
            				+ "	WHEN r.outfuel='0.500' THEN 'Level 4/8'  WHEN r.outfuel='0.625' THEN 'Level 5/8' "
            				+ "  	WHEN r.outfuel='0.750' THEN 'Level 6/8' WHEN  r.outfuel='0.875'  THEN 'Level 7/8' WHEN r.outfuel='1.000' THEN 'Level 8/8' "
            				+ "    END as 'ofuel',r.outfuel  hidfuel,r.drid,coalesce(v.reg_no,v1.reg_no) reg_no,coalesce(v.flname,v1.flname) flname,a.refname from  "
            				+ "gl_lagmt r left join gl_vehmaster v on  v.fleet_no=r.perfleet "
            				+ "left join gl_vehmaster v1 on  v1.fleet_no=r.tmpfleet  left join my_acbook a on a.cldocno=r.cldocno and a.dtype='CRM'  "
            				+ "  where  r.clstatus=0  and  r.vehupdate=1 and  r.brhid='"+brnchval+"' ";
            	
            
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
	public JSONArray temperoryVehicle(String brnchval) throws SQLException {

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
            		String sql="select r.voc_no,'Edit' btnsave,r.brhid, r.doc_no,r.date,r.tmpfleet fleet_no,r.cldocno,r.outdate odate,r.outtime otime,v.reg_no,v.flname,a.refname from gl_lagmt  r  "
            				+ "left join   gl_vehmaster v on r.tmpfleet=v.fleet_no left join my_acbook a on a.cldocno=r.cldocno and a.dtype='CRM'   where  "
            				+ " r.perfleet <> r.tmpfleet and r.tmpfleet<>0 and  r.clstatus=0  " ;

          //  	System.out.println("----"+sql);
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
     				stmtVeh.close();
     				
            	}
            	else{	
            		String sql="select  r.voc_no,'Edit' btnsave,r.brhid, r.doc_no,r.date,r.tmpfleet fleet_no,r.cldocno,r.outdate odate,r.outtime otime,v.reg_no,v.flname,a.refname from gl_lagmt  r  "
            				+ "left join   gl_vehmaster v on r.tmpfleet=v.fleet_no left join my_acbook a on a.cldocno=r.cldocno and a.dtype='CRM'   where  "
            				+ " r.perfleet <> r.tmpfleet and r.tmpfleet<>0 and r.clstatus=0  and   r.brhid='"+brnchval+"' ";
            
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
	
	public JSONArray searchperfleet(String doc_no) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
		
            	/*	String sql="select fleet_no,FLNAME from gl_vehmaster  where  ins_exp >=current_date and statu <> 7 and  "
            				+ " fstatus in ('L','N') and status='IN' and tran_code='RR' and renttype in ('A','L') and a_br='"+bnchval+"' " ;*/
String sql="select DISTINCT  vm.fleet_no,v.flname,v.reg_no from gl_vmove vm left join gl_vehmaster v\r\n" + 
		"on v.fleet_no=vm.fleet_no where vm.rdocno='"+doc_no+"'  and vm.rdtype='LAG' and   vm.repno!=0 ";
		
            		
          // System.out.println("========"+sql);
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
	        
	        Connection conn = null;
	        try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
				
				String sql="select cldocno,refname from my_acbook where status=3 and dtype='CRM' ";
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
	        Connection conn = null;
	       
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
	        
	        Connection conn = null;
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

	    public JSONArray alfahimdetailsgrid(String brnchval,String fromdate,String todate,String cldocno,String status,String fleet,String group,String brand,String model,String outchk,String inchk) throws SQLException {

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
	    		sqltest=sqltest+" and l.clstatus='"+status+"'";
	    	}
	    	if(!(cldocno.equalsIgnoreCase("") || cldocno.equalsIgnoreCase("NA"))){
	    		sqltest=sqltest+" and a.cldocno='"+cldocno+"'";
	    	}
	    	if(!(fleet.equalsIgnoreCase("")|| fleet.equalsIgnoreCase("NA"))){
	    		sqltest=sqltest+" and if(l.perfleet=0,l.tmpfleet,l.perfleet)='"+fleet+"'";
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
	    	if(!((brnchval.equalsIgnoreCase("a")) || (brnchval.equalsIgnoreCase("NA")))){
	 			sqltest+=" and l.brhid='"+brnchval+"'";
	 		}

	    
	    	if(inchk.equalsIgnoreCase("IN"))
	    	{
	    		sqltest+="	and  cs.indate between '"+sqlfromdate+"' and  '"+sqltodate+"' ";
	    		
	    	}
	    	else
	    	{
	    		
	    		sqltest+="	and  l.outdate between '"+sqlfromdate+"' and  '"+sqltodate+"' ";
	    	}
	    	
	    	Connection conn = null;
			try {
					 conn = ClsConnection.getMyConnection();
					Statement stmtVeh = conn.createStatement ();
				
	            				String sql ="select orgveh.residual_val residualval,'Print' btnprint,orgveh.insur_member vin,tr.kmrest,convert(coalesce(orgveh.fleet_no,''),char(25)) originalfleet,coalesce(orgveh.ch_no,'') originalchase,convert(coalesce(repveh.fleet_no,''),char(25)) replacefleet,convert(coalesce(repveh.reg_no,''),char(25)) replaceregno,"
	            				+ "coalesce(repveh.ch_no,'') replacechase,coalesce(prj.project_name,'') project,ms.sal_name,l.voc_no,convert(if(l.invdate=l.outdate,l.invdate,"
	            				+ "DATE_sub(l.invdate,INTERVAL 1 DAY)),char(30)) AS invdate,l.brhid,convert(concat(l.per_value,' ',if(l.per_name=1,'Year','Month')),char(30)) AS duration,d.name drname,coalesce(l.refno,'') refnos,coalesce(manualra,'') mrno,l.doc_no,ur.user_name,clur.user_name closeuser, "
	            				+ "if(l.tmpfleet=0,l.perfleet,l.tmpfleet) fleet_no,l.cldocno,l.outdate,mh.account,l.outtime,l.outkm,v.reg_no,v.FLNAME vehdetails,a.refname,a.per_mob,if(l.clstatus=0,'Open','Close') AS clstatus,a.contactperson,tr.rate rent,tr.cdw, "
	            				+ "  coalesce((select invoiced from gl_lcalc where rdocno=l.doc_no and invno >0 and idno=1 and rowno=(select max(rowno) from gl_lcalc where rdocno=l.doc_no and invno >0 and idno=1)),0) invRental, "
	            				+ "coalesce((select invoiced from gl_lcalc where rdocno=l.doc_no and invno >0 and idno=17 and rowno=(select max(rowno) from gl_lcalc where rdocno=l.doc_no and invno >0 and idno=17)),0) invcdw "
	            				+ " ,if(l.per_name=1,DATE_ADD(l.outdate,INTERVAL l.per_value YEAR),DATE_ADD(l.outdate,INTERVAL l.per_value MONTH)) AS duedate,convert(coalesce(cs.indate,''),char(30)) indate,coalesce(cs.intime,'') intime  from gl_lagmt l left join gl_project prj on l.projectno=prj.doc_no left join gl_vehmaster v on if(l.perfleet=0,l.tmpfleet,l.perfleet)=v.fleet_no  "
	            				+ " left join gl_vehmaster orgveh on l.perfleet=orgveh.fleet_no left join gl_vehmaster repveh on l.tmpfleet=repveh.fleet_no"
	            				+ "  left join my_acbook a on a.cldocno=l.cldocno and a.dtype='CRM' left join gl_vehgroup g on g.doc_no=v.vgrpid "
	            				+ " left join gl_vehbrand br on br.doc_no=v.brdid  left join gl_vehmodel mo on  mo.doc_no=v.vmodid left join gl_ltarif tr on tr.rdocno=l.doc_no  "
	            				+ " left join my_user ur on ur.doc_no=l.userid "
                                                + " left join my_head mh on a.acno=mh.doc_no "
	            				+ " left join gl_ldriver dr on dr.rdocno=l.doc_no left join  gl_drdetails d on (d.dr_id=dr.drid ) left join gl_lagmtclosem cs on cs.agmtno=l.doc_no"
	            				+ " left join my_user clur on clur.doc_no=cs.userid "
	            				+ " left join my_salm ms on ms.doc_no=l.salid"
	            				
	            				+ " where l.status=3  "+sqltest+" group by l.doc_no";
	        
	           	      //System.out.println("----------"+sql);
	          
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
	    
 public  ClsleaseagreementBean getmainPrint1(int docno,String branch) throws SQLException {
	    	
	 ClsleaseagreementBean mainbean = new ClsleaseagreementBean();	
	 HttpServletRequest request=ServletActionContext.getRequest();
	    	
	    	 Connection conn=null;
	    	 try {
	    		 System.out.println(docno);
	    		 System.out.println(branch);
		    	  conn = ClsConnection.getMyConnection();
		       Statement stmtmainprint = conn.createStatement();
		       String mainprintsql="";
		   
		       mainprintsql=("select coalesce(l.chkleaseown,0) chkleaseown,c.company,a.refname,a.address,a.per_mob,v.flname,Concat(if(l.per_name=1,l.per_value*12,l.per_value),' ','Months') duration, "
		       		+ "(select round((rate+cdw+pai+cdw1+pai1+gps+babyseater+cooler),2)  from gl_ltarif where rdocno="+docno+") as cost, "
		       		+ "(select if(round(kmrest)>0,concat(' , ',round(kmrest),' KM PM Restricted'),'') from gl_ltarif where rdocno="+docno+") as kmrest "
		       		+ "from gl_lagmt l left join my_acbook a on a.cldocno=l.cldocno and a.dtype='CRM' "
		       		+ "left join gl_vehmaster v on v.fleet_no=if(l.perfleet=0,l.tmpfleet,l.perfleet) left join gl_ltarif t on t.rdocno=l.doc_no "
		       		+ "left join my_brch b on l.brhid=b.doc_no left join my_comp c on b.cmpid=c.doc_no  where l.doc_no="+docno+" ");
		       
		       System.out.println(mainprintsql);
		      
		       
		       ResultSet resultmainprint = stmtmainprint.executeQuery(mainprintsql); 
		       while(resultmainprint.next()){
		    	   mainbean.setLblchkleaseown(resultmainprint.getString("chkleaseown"));
		    	   mainbean.setTxtcustomersname(resultmainprint.getString("refname"));
			    	  
		    	   mainbean.setTxtaddress(resultmainprint.getString("address"));
		    	 
		    	   mainbean.setTxtcontact(resultmainprint.getString("per_mob"));
		    	  
		    	   mainbean.setVehicledetails(resultmainprint.getString("flname"));
			    	  
		    	   mainbean.setVehduration(resultmainprint.getString("duration"));
		    	 
		    	   mainbean.setVehcostpermonth(resultmainprint.getString("cost"));  
		    	   mainbean.setKmrest(resultmainprint.getString("kmrest"));  
		    	   
		    	   
		     	   mainbean.setLbllessorcompany(resultmainprint.getString("company"));  
		    	   mainbean.setClientnames(resultmainprint.getString("refname"));  
		    	   
		    		 
		    		 
		    		  
		       }
		      
		       String strdrvemirates="select coalesce(drv.visano,'') visano from gl_ldriver ldrv left join gl_drdetails drv on ldrv.drid=drv.dr_id where ldrv.rdocno="+docno+" limit 1";
		       ResultSet rsdrvemirates=stmtmainprint.executeQuery(strdrvemirates);
		       while(rsdrvemirates.next()){
		    	   mainbean.setDrvemiratesid(rsdrvemirates.getString("visano"));
		       }
		      
		      
		    	/*   if(branch.equalsIgnoreCase("a")){
		       String approvaldtls="select u.user_name,e.apprdate,e.remarks  from my_exdet e inner join my_user u on e.userid=u.doc_no where e.doc_no=(select larefdocno from gl_lagmt where doc_no="+docno+") and e.dtype='LQT' ";
		      // System.out.println(approvaldtls);
		       ArrayList<String> printapprovaldetails=new ArrayList<>();
		       ResultSet approval=stmtmainprint.executeQuery(approvaldtls);
		       int i=0;
		       while(approval.next()){
		    	   printapprovaldetails.add(approval.getString("user_name")+"::"+approval.getString("apprdate")+"::"+approval.getString("remarks"));
		    	   mainbean.setLbluser(approval.getString("user_name"));
		    	   mainbean.setLblsubmit(approval.getString("apprdate"));
		    	   mainbean.setLblremarks(approval.getString("remarks"));
		       }
		       }
		       else if(!branch.equalsIgnoreCase("a")){
		    	 */
		       String approvaldtls="select u.user_name,e.apprdate,e.remarks  from my_exdet e inner join my_user u on e.userid=u.doc_no where e.doc_no=(select larefdocno from gl_lagmt where doc_no="+docno+") and e.dtype='LQT' and e.brhid="+branch+"";
			      // System.out.println(approvaldtls);
		    	   ArrayList<String> printapprovaldetails=new ArrayList<>();
			       ResultSet approval=stmtmainprint.executeQuery(approvaldtls);
			       int i=0;
			       while(approval.next()){
			    	   printapprovaldetails.add(approval.getString("user_name")+"::"+approval.getString("apprdate")+"::"+approval.getString("remarks"));
			    	/*   mainbean.setLbluser(approval.getString("user_name"));
			    	   mainbean.setLblsubmit(approval.getString("apprdate"));
			    	   mainbean.setLblremarks(approval.getString("remarks"));*/
			       }
		       // }
			       request.setAttribute("PRINT", printapprovaldetails);
		       
		       stmtmainprint.close();
		       conn.close();
		      }
		      catch(Exception e){
		       e.printStackTrace();
		       conn.close();
		      
		      }
		      return mainbean;
		     }
	    
	    
	    public JSONArray alfahimdetailsgrids(String brnchval,String fromdate,String todate,String cldocno,String status,String fleet,String group,String brand,String model,String outchk,String inchk) throws SQLException {

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
	    		sqltest=sqltest+" and l.clstatus='"+status+"'";
	    	}
	    	if(!(cldocno.equalsIgnoreCase("") || cldocno.equalsIgnoreCase("NA"))){
	    		sqltest=sqltest+" and a.cldocno='"+cldocno+"'";
	    	}
	    	if(!(fleet.equalsIgnoreCase("")|| fleet.equalsIgnoreCase("NA"))){
	    		sqltest=sqltest+" and if(l.perfleet=0,l.tmpfleet,l.perfleet)='"+fleet+"'";
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
	    	if(!((brnchval.equalsIgnoreCase("a")) || (brnchval.equalsIgnoreCase("NA")))){
	 			sqltest+=" and l.brhid='"+brnchval+"'";
	 		}

	    
	    	if(inchk.equalsIgnoreCase("IN"))
	    	{
	    		sqltest+="	and  cs.indate between '"+sqlfromdate+"' and  '"+sqltodate+"' ";
	    		
	    	}
	    	else
	    	{
	    		
	    		sqltest+="	and  l.outdate between '"+sqlfromdate+"' and  '"+sqltodate+"' ";
	    	}
	    	
	    	Connection conn = null;
			try {
					 conn = ClsConnection.getMyConnection();
					Statement stmtVeh = conn.createStatement();
				
            	   		String sql =" select @id:=@id+1 SLNO,'Print' btnprint,a.* from (select l.voc_no 'LA NO', if(l.perfleet=0,l.tmpfleet,l.perfleet) " + 
	            				"	 'Fleet',v.FLNAME 'Fleet Name',v.reg_no 'Reg No',mh.account 'Account',a.refname 'Client Name',a.per_mob 'Mob NO',a.contactperson 'Contact Person',l.outdate 'Out Date',if(l.clstatus=0,'Open','Close') AS Clstatus,l.outtime 'Out Time',convert(if(l.invdate=l.outdate,l.invdate,DATE_SUB(l.invdate,INTERVAL 1 DAY)),char(30)) AS  'Inv Date', " + 
	            				"	 d.name 'Driver',coalesce(l.refno,'') 'Ref No',coalesce(manualra,'') 'Manual LA',convert(concat(l.per_value,' ',if(l.per_name=1,'Year','Month')),char(30)) AS Duration,convert(coalesce(cs.indate,''),char(30)) 'In Date',coalesce(cs.intime,'') 'In Time' ," + 
	            				"	 tr.rate 'Rent',tr.cdw 'CDW',   coalesce((select invoiced from gl_lcalc where rdocno=l.doc_no and invno >0 and idno=1 " + 
	            				"	 and rowno=(select max(rowno) from gl_lcalc where rdocno=l.doc_no and invno >0 and idno=1)),0) 'Inv Rent', " + 
	            				"	 coalesce((select invoiced from gl_lcalc where rdocno=l.doc_no and invno >0 and idno=17 and " + 
	            				"	 rowno=(select max(rowno) from gl_lcalc where rdocno=l.doc_no and invno >0 and idno=17)),0) 'Inv CDW'," +
	            				"    convert(coalesce(orgveh.fleet_no,''),char(25)) originalfleet,coalesce(orgveh.ch_no,'') originalchase,"
	            				+ "  convert(coalesce(repveh.fleet_no,''),char(25)) replacefleet,coalesce(repveh.ch_no,'') replacechase ,ur.user_name 'Open User',clur.user_name 'Close User',  ms.sal_name 'Salesman' , if(l.per_name=1,DATE_ADD(l.outdate,INTERVAL l.per_value YEAR),DATE_ADD(l.outdate,INTERVAL l.per_value MONTH)) AS 'Due Date' , coalesce(prj.project_name,'') project,orgveh.insur_member 'VSB',orgveh.residual_val 'RV',tr.kmrest 'Contractual Mileage Allowance' "+
	            				"	 from gl_lagmt l left join gl_project prj on l.projectno=prj.doc_no left join gl_vehmaster v on if(l.perfleet=0,l.tmpfleet,l.perfleet)=v.fleet_no  " +
	            				"    left join gl_vehmaster orgveh on l.perfleet=orgveh.fleet_no left join gl_vehmaster repveh on l.tmpfleet=repveh.fleet_no"+
	            				"	 left join my_acbook a on a.cldocno=l.cldocno and a.dtype='CRM' left join gl_vehgroup g on g.doc_no=v.vgrpid " + 
	            				"	 left join gl_vehbrand br on br.doc_no=v.brdid  left join gl_vehmodel mo on  mo.doc_no=v.vmodid " + 
	            				"	 left join gl_ltarif tr on tr.rdocno=l.doc_no  left join gl_ldriver dr on dr.rdocno=l.doc_no " + 
	            				 " left join my_user ur on ur.doc_no=l.userid "+
	            				"	 left join my_head mh on a.acno=mh.doc_no left join  gl_drdetails d on (d.dr_id=dr.drid ) left join gl_lagmtclosem cs on cs.agmtno=l.doc_no"
	            				+ " left join my_user clur on clur.doc_no=cs.userid "
	            				+ " left join my_salm ms on ms.doc_no=l.salid" + 
	            				
	            				
	            				"	 where l.status=3  "+sqltest+" group by l.doc_no ) a,(select @id:=0) r"; 
					
 
 
	       //   System.out.println("=== jj == "+sql);
	            		ResultSet resultSet = stmtVeh.executeQuery(sql);
	            		 RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
	     				stmtVeh.close();
	     				
	        
	 			
	            	conn.close();
			}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
			//System.out.println( RESULTDATA);
	        return RESULTDATA;
	    }
	    
	    
	    
	    
	    
	    
	    
	    public  ClsleaseagreementBean getPrint(int docno) throws SQLException {
	    	ClsleaseagreementBean bean = new ClsleaseagreementBean();
	    	Connection conn=null;
	      try {
	    	 // System.out.println(docno);
	    	   conn = ClsConnection.getMyConnection();
	       Statement stmtinvoice = conn.createStatement();
	       String strSql="";
	       //AlFahim Print
	       int latype=0;
	       String temperory="",permanent="";
	      String strsqlalfahim="select coalesce(agmt.tmpfleet,'') temperory,coalesce(agmt.perfleet,'') permanent,agmt.latype,ac.contractno tradelicno,sp.sponsorname clientcompany,DATE_FORMAT(agmt.date,'%d-%M-%Y') date,(select count(srno) from gl_leasepytcalc where rdocno="+docno+" and bpvno>0) chequecount,coalesce(agmt.chkleaseown,0) chkleaseown,br.branchname,comp.company,comp.address,comp.tel,comp.fax,loc.loc_name,(select code from my_curr where doc_no=1) currency,round(agmt.servicelevelamt,2) leaseownamount,round(agmt.pytadvance,2) pytadvance,if(agmt.per_name=1,agmt.per_value*12,agmt.per_value) totalmonths,round(tarif.rate,2) rate,round(tarif.kmrest,0) kmrest,round(tarif.exkmrte,2) exkmrte,veh.flname,veh.reg_no,veh.ch_no,veh.vin,yom.yom,clr.color from gl_lagmt agmt left join gl_vehmaster veh on "+
	       " (if(agmt.perfleet=0,agmt.tmpfleet,agmt.perfleet)=veh.fleet_no) left join gl_yom yom on veh.yom=yom.doc_no left join my_color clr on "+
	    	" veh.clrid=clr.doc_no left join gl_ltarif tarif on agmt.doc_no=tarif.rdocno left join my_brch br on agmt.brhid=br.doc_no left join my_comp comp on "+
	       " br.cmpid=comp.doc_no left join  my_locm loc on br.doc_no=loc.brhid  left join my_acbook ac on agmt.cldocno=ac.cldocno left join gl_sponsor sp on"+
	       " agmt.cldocno=sp.doc_no where agmt.doc_no="+docno+" limit 1";
	      System.out.println(strsqlalfahim); 
	      ResultSet rs=stmtinvoice.executeQuery(strsqlalfahim);
	       while(rs.next()){
	    	   temperory=rs.getString("temperory");
	    	   permanent=rs.getString("permanent");
	    	   latype=rs.getInt("latype");
	    	   bean.setLblvehicle(rs.getString("flname"));
	    	   bean.setLblregno(rs.getString("reg_no"));
	    	   bean.setLblchassis(rs.getString("ch_no"));
	    	   bean.setLblyom(rs.getString("yom"));
	    	   bean.setLblcolor(rs.getString("color"));
	    	   bean.setLblrate(rs.getString("rate"));
	    	   bean.setLblcontractkm(rs.getString("kmrest"));
	    	   bean.setLblexcesskmrate(rs.getString("exkmrte"));
	    	   bean.setLbltotalmonths(rs.getString("totalmonths"));
	    	   bean.setLbladvance(rs.getString("pytadvance"));
	    	   bean.setLblleaseownamount(rs.getString("leaseownamount"));
	    	   bean.setLblcurrency(rs.getString("currency"));
	    	   bean.setLblcompname(rs.getString("company"));
	    	   bean.setLblcompaddress(rs.getString("address"));
	    	   bean.setLblcomptel(rs.getString("tel"));
	    	   bean.setLblcompfax(rs.getString("fax"));
	    	   bean.setLbllocation(rs.getString("loc_name"));
	    	   bean.setLblbranch(rs.getString("branchname"));
	    	   bean.setLblchkleaseown(rs.getString("chkleaseown"));
	    	   bean.setLblchequecount(rs.getString("chequecount"));
	    	   bean.setLbldate(rs.getString("date"));
	    	   bean.setLblclientcompany(rs.getString("clientcompany"));
	    	   bean.setLbltradelicno(rs.getString("tradelicno"));
	       }
	       
	       //Lease application print
	       String strlatype="";
	       if(latype==1){
	    	   strlatype="select coalesce(concat(brd.brand_name,'   ',model.vtype),'') vehicle,coalesce(yom.yom,'') yom,coalesce(clr.color,'') color,"+
	    	   " coalesce(veh.reg_no,'') regno,coalesce(veh.ch_no,'') chassisno,coalesce(veh.vin,'') vsb from gl_lagmt agmt left join gl_vehmaster"+
	    	   " veh on (agmt.tmpfleet=veh.fleet_no or agmt.perfleet=veh.fleet_no) left join gl_vehbrand brd on veh.brdid=brd.doc_no"+
	    	   " left join gl_vehmodel model on veh.vmodid=model.doc_no left join gl_yom yom on veh.yom=yom.doc_no left join my_color clr on"+
	    	   " veh.clrid=clr.doc_no where agmt.doc_no="+docno;
	       }
	       else if(latype==2){
	    	   String joinregno="",selectregno="";
	    	   if(temperory.equalsIgnoreCase("") && permanent.equalsIgnoreCase("")){
	    		   selectregno=",'' regno";
	    	   }
	    	   else{
	    		   joinregno=" left join gl_vehmaster veh on (agmt.tmpfleet=veh.fleet_no or agmt.perfleet=veh.fleet_no) ";
	    		   selectregno=",coalesce(veh.reg_no,'') regno";
	    	   }
	    	   strlatype="select coalesce(concat(brd.brand_name,'   ',model.vtype),'') vehicle,coalesce(yom.yom,'') yom,coalesce(req.allotno,'') vsb,"+
	    	   " coalesce(req.chasisno,'') chassisno,coalesce(clr.color,'') color "+selectregno+" from gl_lagmt agmt left join gl_blaf blaf on (agmt.blafsrno=blaf.srno) "+
	    	   " left join gl_leasecalcreq req on (blaf.rdocno=req.srno) left join gl_vehbrand brd on req.brdid=brd.doc_no left join "+
	    	   " gl_vehmodel model on req.modid=model.doc_no left join gl_yom yom on req.yomid=yom.doc_no left join my_color clr on req.clrid=clr.doc_no "+
	    	   " "+joinregno+" where agmt.doc_no="+docno;
	       }
	    //   System.out.println(strlatype);
	       Statement stmt=conn.createStatement();
	       ResultSet rslatype=stmt.executeQuery(strlatype);
	       while(rslatype.next()){
	    	   bean.setLblvehicle(rslatype.getString("vehicle"));
	    	   bean.setLblregno(rslatype.getString("regno"));
	    	   bean.setLblchassis(rslatype.getString("chassisno"));
	    	   bean.setLblyom(rslatype.getString("yom"));
	    	   bean.setLblcolor(rslatype.getString("color"));
	    	   bean.setLblvin(rslatype.getString("vsb"));
	       }
	       
	       String stradvance="select round(coalesce(appd.advance,agmt.pytadvance),2) advance,round(coalesce(appd.installments,agmt.pytmonthno),2) installments from gl_lagmt agmt "+
	    	       " left join gl_blaf blaf on (agmt.latype=2 and agmt.blafsrno=blaf.srno) left join gl_leasecalcreq calc on blaf.rdocno=calc.srno left join gl_leaseappm "+
	    	       " appm on calc.leasereqdocno=appm.reqdoc left join gl_leaseappd appd on appm.doc_no=appd.rdocno where agmt.doc_no="+docno;
	    	       ResultSet rsadvance=stmt.executeQuery(stradvance);
	    	       while(rsadvance.next()){
	    	    	   bean.setLbladvance(rsadvance.getString("advance"));
	    	    	   bean.setLblchequecount(rsadvance.getString("installments"));
	    	       }
	       //Cosmo Print
	       
	       String strsqlcosmo="select  if(l.per_name=1,l.per_value*12,per_value) totalmonths,if(per_name=1,l.per_value*12,per_value) duration,date_add(l.outdate,interval if(l.per_name=1,l.per_value*12,per_value) month) enddate,v.fleet_no,v.eng_no engine,v.ch_no chassis ,l.voc_no agmtno,DATE_FORMAT(l.outdate,'%d-%m-%Y') outdate,a.refname clientname,a.address clientaddress,a.per_mob, v.reg_no regno,co.color,"+
	       " yo.yom,brd.brand_name brand,mo.vtype model, (select round(rate,2) rate  from gl_ltarif where  rdocno="+docno+" ) as agreedrate from gl_lagmt l left join my_acbook a "+
	       " on a.cldocno=l.cldocno   and  a.dtype='CRM' left join gl_vehmaster  v on v.fleet_no=if(l.perfleet=0,l.tmpfleet,l.perfleet) left join gl_vehmodel mo on "+
	       " mo.doc_no=v.vmodid  left join gl_vehplate p on p.doc_no=v.pltid left join gl_ltarif t on t.rdocno=l.doc_no left join gl_yom yo on yo.doc_no=v.yom  left join "+
	       " my_color co on co.doc_no=v.clrid  left join gl_vehbrand brd on v.brdid=brd.doc_no where l.doc_no="+docno+" group by l.doc_no";
	       System.out.println(strsqlcosmo);
	       Statement stmtcosmo=conn.createStatement();
	       ResultSet rscosmo=stmtcosmo.executeQuery(strsqlcosmo);
	       int duration=0;
	       while(rscosmo.next()){
	    	   bean.setLblcosmoagmtno(rscosmo.getString("agmtno"));
	    	   bean.setLblcosmoagreedrate(rscosmo.getString("agreedrate"));
	    	   bean.setLblcosmoclientname(rscosmo.getString("clientname"));
	    	   bean.setLblcosmoclientaddress(rscosmo.getString("clientaddress"));
	    	   bean.setLblcosmoclientmobile(rscosmo.getString("per_mob"));
	    	   bean.setLblcosmoregno(rscosmo.getString("regno"));
	    	   bean.setLblcosmocolor(rscosmo.getString("color"));
	    	   bean.setLblcosmoyom(rscosmo.getString("yom"));
	    	   bean.setLblcosmobrand(rscosmo.getString("brand"));
	    	   bean.setLblcosmomodel(rscosmo.getString("model"));
	    	   bean.setLblcosmofleetno(rscosmo.getString("fleet_no"));
	    	   bean.setLblcosmoengine(rscosmo.getString("engine"));
	    	   bean.setLblcosmochassis(rscosmo.getString("chassis"));
	    	   bean.setLblcosmostartdate(rscosmo.getString("outdate"));
	    	   bean.setLblcosmoduration(rscosmo.getString("duration"));
	    	   bean.setLblcosmoenddate(rscosmo.getString("enddate"));
	       }
	       String  strcosmoterm="select mnthfrm,mnthto,round(amt,2) amt,rdocno from gl_ltermcl where rdocno="+docno+" and amt>0 ";
	       ResultSet rscosmoterm=stmtcosmo.executeQuery(strcosmoterm);
	       int cosmoi=0;
	       while(rscosmoterm.next()){
	    	   if(cosmoi==0){
	    		   bean.setLblcosmoterm1(rscosmoterm.getString("mnthfrm"));
	    		   bean.setLblcosmoterm2(rscosmoterm.getString("mnthto"));
	    		   bean.setLblcosmoamt1(rscosmoterm.getString("amt"));
	    	   }
	    	   if(cosmoi==1){
	    		   bean.setLblcosmoterm3(rscosmoterm.getString("mnthfrm"));
	    		   bean.setLblcosmoterm4(rscosmoterm.getString("mnthto"));
	    		   bean.setLblcosmoamt2(rscosmoterm.getString("amt"));
	    	   }
	    	   if(cosmoi==2){
	    		   bean.setLblcosmoterm5(rscosmoterm.getString("mnthfrm"));
	    		   bean.setLblcosmoterm6(rscosmoterm.getString("mnthto"));
	    		   bean.setLblcosmoamt3(rscosmoterm.getString("amt"));
	    	   }
	    	   if(cosmoi==3){
	    		   bean.setLblcosmoterm7(rscosmoterm.getString("mnthfrm"));
	    		   bean.setLblcosmoterm8(rscosmoterm.getString("mnthto"));
	    		   bean.setLblcosmoamt4(rscosmoterm.getString("amt"));
	    	   }
	    	   if(cosmoi==4){
	    		   bean.setLblcosmoterm9(rscosmoterm.getString("mnthfrm"));
	    		   bean.setLblcosmoterm10(rscosmoterm.getString("mnthto"));
	    		   bean.setLblcosmoamt5(rscosmoterm.getString("amt"));
	    	   }
	    	   cosmoi++;
	       }
	       
	       strSql=("select if(a.ser_default=1,if(g1.method=1,round(g1.value,2),0),round(per_salikrate,2)) salikcharge,  "
	       		+ "  if(a.ser_default=1,25,round(per_trafficharge,2)) trafficcharge,  round(l.insurexcess,2) insurexcess , "
	       		+ " l.voc_no,if(l.clstatus=0,'Open','Closed') clstatus, l.doc_no,round(l.addrchg,2) addrchg,l.outkm okm, "
	       		+ " CASE WHEN l.outfuel='0.000' THEN 'Level 0/8' WHEN l.outfuel='0.125' THEN 'Level 1/8' WHEN l.outfuel='0.250' "
	       		+ " THEN 'Level 2/8' WHEN l.outfuel='0.375' THEN 'Level 3/8' WHEN l.outfuel='0.500' THEN 'Level 4/8' WHEN "
	       		+ " l.outfuel='0.625' THEN 'Level 5/8'  WHEN l.outfuel='0.750' THEN 'Level 6/8' WHEN l.outfuel='0.875' THEN 'Level 7/8'  "
	       		+ " WHEN l.outfuel='1.000' THEN 'Level 8/8'  END as 'ofuel' ,DATE_FORMAT(l.outdate,'%d-%m-%Y') odate,l.outtime otime,a.refname,  "
	       		+ " a.address,a.per_mob,  sm.sal_name ,   a.mail1,br.branchname,concat(v.reg_no,' ',p.code_name) reg_no,concat(v.flname,' ',if(l.perfleet=0,'(Temp)','(Pr)')) flname,g.gname,mo.vtype, "
	       		+ " (select round(rate,2) rate  from gl_ltarif where  rdocno="+docno+" ) as rate, (select  round(cdw,2)+round(cdw1,2) "
	       		+ " from gl_ltarif where rdocno="+docno+"  ) as cdw , (select round(gps,2)+round(babyseater,2)+round(cooler,2)   from gl_ltarif where "
	       		+ " rdocno="+docno+"  ) as accessories,   (select round(kmrest)  from gl_ltarif where  rdocno="+docno+" ) "
	       		+ " as raextrakm, (select round(exkmrte,2)  from gl_ltarif where  rdocno="+docno+") as raexxtakmchg,  CASE WHEN rc.infuel='0.000' THEN 'Level 0/8' "
	       		+ " WHEN rc.infuel='0.125' THEN 'Level 1/8' WHEN rc.infuel='0.250'  THEN 'Level 2/8' WHEN rc.infuel='0.375' "
	       		+ " THEN 'Level 3/8' WHEN rc.infuel='0.500' THEN 'Level 4/8' WHEN rc.infuel='0.625' THEN 'Level 5/8' "
	       		+ " WHEN rc.infuel='0.750' THEN 'Level 6/8' WHEN rc.infuel='0.875' THEN 'Level 7/8' WHEN rc.infuel='1.000' "
	       		+ " THEN 'Level 8/8'   END as 'infuel',round(rc.inkm) inkm,DATE_FORMAT(rc.indate,'%d-%m-%Y') "
	       		+ " indate,rc.intime,co.color,yo.yom    from gl_lagmt l left join my_acbook a on a.cldocno=l.cldocno "
	       		+ "  and  a.dtype='CRM'   left join my_brch br      on br.branch=l.brhid left join gl_vehmaster  v on v.fleet_no=if(l.perfleet=0,l.tmpfleet,l.perfleet)  "
	       		+ " left join gl_vehgroup g on g.doc_no=v.vgrpid  left join gl_config g1 on g1.field_nme='saliksrv'  left join gl_config g2 on g2.field_nme='trafficsrvper'   "
	       		+ "  left join gl_vehmodel mo on mo.doc_no=v.vmodid "
	       		+ " left join gl_vehplate p on p.doc_no=v.pltid left join gl_ltarif t on t.rdocno=l.doc_no "
	       		+ " left join gl_lagmtclosem rc on rc.agmtno=l.doc_no left join gl_yom yo on yo.doc_no=v.yom "
	       		+ " left join my_color co on co.doc_no=v.clrid   left join my_salm sm on sm.doc_no=l.salid     where l.doc_no="+docno+" group by l.doc_no");
		       
//System.out.println("strSql============"+strSql);
	       
	       ResultSet resultSet = stmtinvoice.executeQuery(strSql); 
	       
	     
	       while(resultSet.next()){
	    	   // cldatails
	    	   
	    	   
	    	   bean.setSalikcharge(resultSet.getString("salikcharge"));
	    	   bean.setTrafficcharge(resultSet.getString("trafficcharge"));
	    	   
	    	   
	    	   if(resultSet.getString("cdw").equalsIgnoreCase("0.00"))
			   {
		        bean.setExcessinsu(resultSet.getString("insurexcess")); 
	 
			    }
				   else
				   {
					    
					   bean.setExcessinsu("0.00");   
				   }
				    	   
	    	   
	    	    bean.setClname(resultSet.getString("refname"));
	    	    bean.setCladdress(resultSet.getString("address"));
	    	    bean.setClemail(resultSet.getString("mail1"));
	    	    bean.setClmobno(resultSet.getString("per_mob"));
	    	    //upper
	    	  
	    	   /* bean.setMrano("1");*/
	    	    bean.setRentaldoc(resultSet.getString("voc_no"));
	    	    
	    	  // veh details
	    	    
	    	    bean.setRavehname(resultSet.getString("flname"));
	    	    bean.setRavehgroup(resultSet.getString("gname"));
	    	    bean.setRavehmodel(resultSet.getString("vtype"));
	    	    bean.setRavehregno(resultSet.getString("reg_no"));
	    	    bean.setRadateout(resultSet.getString("odate"));
	    	    bean.setRatimeout(resultSet.getString("otime"));
	    	    bean.setRaklmout(resultSet.getString("okm"));
	    	    
	    	    // rental type
	    	    
	    	 //   bean.setRadaily(resultSet.getString("daily"));
	    	   // bean.setRaweakly(resultSet.getString("weekly"));
	    	  //  bean.setRamonthly(resultSet.getString("monthly"));
	    	    bean.setTariff(resultSet.getString("rate"));
	    	    bean.setRacdwscdw(resultSet.getString("cdw"));
	    	    bean.setRaaccessory(resultSet.getString("accessories"));
	    	    bean.setRaadditionalcge(resultSet.getString("addrchg"));
	    	    
	    	// in details
	    	   
	    	    bean.setInkm(resultSet.getString("inkm"));
	    	    bean.setInfuel(resultSet.getString("infuel"));
	    	    bean.setIndate(resultSet.getString("indate"));
	    	    bean.setIntime(resultSet.getString("intime"));
	    	  
	    	    bean.setRastatus(resultSet.getString("clstatus"));
	    	    bean.setRafuelout(resultSet.getString("ofuel"));
	    	   //
	    	    
	    	   bean.setRayom(resultSet.getString("yom"));
	    	   bean.setRacolor(resultSet.getString("color")) ;
	    	   
	    	   
	    	   //setRaextrakm,setRaexxtakmchg
	    	   
	    	   bean.setRaextrakm(resultSet.getString("raextrakm"));
	    	   bean.setRaexxtakmchg(resultSet.getString("raexxtakmchg"));
	    /*	   bean.setRarenttypes("SS");*/
	    	   
	    	   
		//mm
				
		  bean.setSalname(resultSet.getString("sal_name"));
	    	 	   


	       }
	       
	       
	  
	       stmtinvoice.close();
	       
	       
	      // setTermi1 setTermi2 setTermi3
	       
           Statement trmi = conn.createStatement();
	       
	       String  trmisql="select mnthfrm,mnthto,round(amt,2) amt,rdocno from gl_ltermcl where rdocno="+docno+" and amt>0  limit 3 ";
	       
	       
	       
	       
	       ResultSet resulttermi = trmi.executeQuery(trmisql); 
	       
	       int j=0;
	       
	 	       while(resulttermi.next()){
	 	    	   if(j==0)
	 	    	   {
	 	    	    bean.setTermi1("Between "+resulttermi.getString("mnthfrm")+"    and    "+resulttermi.getString("mnthto")+" Months   -  "+resulttermi.getString("amt"));
	 	    	    
	 	    	    
	 	    	   }
	 	    	   
	 	    	   if(j==1)
	 	    	   {
	 	    		   
	 	    		bean.setTermi2("Between "+resulttermi.getString("mnthfrm")+"    and    "+resulttermi.getString("mnthto")+" Months  -  "+resulttermi.getString("amt"));
	 	  	    	 
	 		    	   
	 	    		   
	 	    	   }
	 	    	   
	 	    	   
	 	    	   if(j==2)
	 	    	   {
	 	    		   
	 	  	    	 
	 	    		bean.setTermi3("Between "+resulttermi.getString("mnthfrm")+"     and    "+resulttermi.getString("mnthto")+" Months  -   "+resulttermi.getString("amt"));
	 		    	  
	 		    	 
	 	    	   }
	 	    	   
	 	    	   j=j+1;
	 	    	   
	 	       }
	 	      trmi.close();
	 	        
	       
	       
	       
	       
	       
	       Statement stmtinvoice66 = conn.createStatement();
	       
	       String  maindr=" select dr.name drname,dr.dlno ,DATE_FORMAT(dr.dob,'%d-%m-%Y') dob,DATE_FORMAT(dr.led,'%d-%m-%Y') led, "
	       		+ " if(dr.PASSPORT_NO=0,'',dr.PASSPORT_NO) passport_no,DATE_FORMAT(dr.pass_exp,'%d-%m-%Y') pass_exp, "
	       		+ " rr.srno from gl_drdetails dr left join gl_ldriver rr on rr.drid=dr_id where rr.rdocno="+docno+" "
	       		+ " and rr.srno between(select min(srno) srno from gl_ldriver  where rdocno="+docno+") and (select max(srno) srno from gl_ldriver  where  rdocno="+docno+") limit 3 ";
	       
	       
      ResultSet resultmain = stmtinvoice66.executeQuery(maindr); 
	       
      int i=0;
      
	       while(resultmain.next()){
	    	   if(i==0)
	    	   {
	    	    bean.setRadrname(resultmain.getString("drname"));
	    	    bean.setRadlno(resultmain.getString("dlno"));
	    	    bean.setPassno(resultmain.getString("passport_no"));
	    	    bean.setLicexpdate(resultmain.getString("led"));
	    	    bean.setPassexpdate(resultmain.getString("pass_exp"));
	    	    bean.setDobdate(resultmain.getString("dob"));
	    	    
	    	   }
	    	   
	    	   if(i==1)
	    	   {
	    		   
	    		   bean.setAdddrname1(resultmain.getString("drname"));
	  	    	 
		    	   bean.setAddlicno1(resultmain.getString("dlno"));
		    	  
		    	   bean.setExpdate1(resultmain.getString("led"));
		    	
		    	   bean.setAdddob1(resultmain.getString("dob"));
	    		   
	    	   }
	    	   
	    	   
	    	   if(i==2)
	    	   {
	    		   
	  	    	 
		    	   bean.setAdddrname2(resultmain.getString("drname"));
		    	  
		    	   bean.setAddlicno2(resultmain.getString("dlno"));
		    	 
		    	   bean.setExpdate2(resultmain.getString("led"));
		    	  
		    	   bean.setAdddob2(resultmain.getString("dob"));
	    		   
	    	   }
	    	   
	    	   i=i+1;
	    	   
	       }
	       stmtinvoice66.close();
	        
	       
	       
	       
	       /*Statement stmtinvoice4 = conn.createStatement();
	       
	       
	 String  maindr=" select d.name drname,d.dlno,DATE_FORMAT(d.dob,'%d-%m-%Y') dob,DATE_FORMAT(d.led,'%d-%m-%Y') "
	 		+ "led,if(d.PASSPORT_NO=0,'',d.PASSPORT_NO) PASSPORT_NO,DATE_FORMAT(d.pass_exp,'%d-%m-%Y') pass_exp from gl_drdetails d left join gl_ldriver rr on rr.drid=d.dr_id where rr.rdocno="+docno+" and rr.srno=(select MIN(srno) from gl_ldriver where rdocno="+docno+") group by rr.rdocno ";
	 
	 ResultSet resultmain = stmtinvoice4.executeQuery(maindr); 
	       
	       while(resultmain.next()){
	    	   
	    	   bean.setRadrname(resultmain.getString("drname"));
	    	    bean.setRadlno(resultmain.getString("dlno"));
	    	    bean.setPassno(resultmain.getString("passport_no"));
	    	    bean.setLicexpdate(resultmain.getString("led"));
	    	    bean.setPassexpdate(resultmain.getString("pass_exp"));
	    	    bean.setDobdate(resultmain.getString("dob"));
	    	   
	       }
	       stmtinvoice4.close();
	        
	       
	      
	       
	       
	       Statement stmtinvoice1 = conn.createStatement();
	       
 
	 String  drone="select dr.name name1,dr.dlno licno1,DATE_FORMAT(dr.dob,'%d-%m-%Y') dob1,DATE_FORMAT(dr.led,'%d-%m-%Y') led1 from gl_drdetails dr left join gl_ldriver rr on rr.drid=dr_id where rr.rdocno="+docno+" and rr.srno=(select MIN(srno)+1 from gl_ldriver where rdocno="+docno+")";
	 
	 ResultSet resultone = stmtinvoice1.executeQuery(drone); 
	       
	       while(resultone.next()){
	    	   
	    	   bean.setAdddrname1(resultone.getString("name1"));
	    	 
	    	   bean.setAddlicno1(resultone.getString("licno1"));
	    	  
	    	   bean.setExpdate1(resultone.getString("led1"));
	    	
	    	   bean.setAdddob1(resultone.getString("dob1"));
	    	  
	    	   
	       }
	       stmtinvoice1.close();
	     
	   	
	    Statement stmtinvoice2 = conn.createStatement ();
	    String  drtwo="select dr.name name2,dr.dlno licno2,DATE_FORMAT(dr.dob,'%d-%m-%Y') dob2,DATE_FORMAT(dr.led,'%d-%m-%Y') led2 from gl_drdetails dr left join gl_ldriver rr on rr.drid=dr_id where rr.rdocno="+docno+" and rr.srno=(select MIN(srno)+2 from gl_ldriver where rdocno="+docno+")";
	 
         ResultSet resulttwo = stmtinvoice2.executeQuery(drtwo); 
	       
	       while(resulttwo.next()){
	    	   
	    	 
	    	   bean.setAdddrname2(resulttwo.getString("name2"));
	    	  
	    	   bean.setAddlicno2(resulttwo.getString("licno2"));
	    	 
	    	   bean.setExpdate2(resulttwo.getString("led2"));
	    	  
	    	   bean.setAdddob2(resulttwo.getString("dob2"));
	    	  
	    	   
	    	   
	       } 
	       stmtinvoice2.close();*/
	       
	       Statement stmtinvoice10 = conn.createStatement ();/*
		    String  companysql="select c.company,c.address,c.tel,c.fax,l.loc_name location from gl_lagmt r  "
		    		+ " left join my_brch b on r.brhid=b.doc_no left join my_locm l on l.brhid=b.doc_no "
		    		+ "left join my_comp c on b.cmpid=c.doc_no where r.doc_no="+docno+"  ";*/
	
		    String  companysql="select c.company,c.address,c.tel,c.fax,lc.loc_name location,b.branchname,b.pbno,b.stcno,b.cstno from gl_lagmt r inner join my_brch b on  "
		    		+ "r.brhid=b.doc_no inner join my_comp c on b.cmpid=c.doc_no inner join my_locm l on l.brhid=b.doc_no inner join (select min(lo.loc) loc,lo.loc_name, "
		    		+ " lo.brhid from my_locm lo group by brhid) as lc on(lc.loc=l.loc and lc.brhid=b.doc_no) where r.doc_no="+docno+" "; 
		    ResultSet resultsetcompany = stmtinvoice10.executeQuery(companysql); 
		       
		       while(resultsetcompany.next()){
		    	   
		    	   bean.setBarnchval(resultsetcompany.getString("branchname"));
		    	   bean.setCompanyname(resultsetcompany.getString("company"));
		    	  
		    	   bean.setAddress(resultsetcompany.getString("address"));
		    	 
		    	   bean.setMobileno(resultsetcompany.getString("tel"));
		    	  
		    	   bean.setFax(resultsetcompany.getString("fax"));
		    	   bean.setLocation(resultsetcompany.getString("location"));
		    	  
		    	   
		    	   
		       } 
		       stmtinvoice10.close();
	       
		       Statement stmttatal = conn.createStatement ();
			    String  totalsql="select if(bb.inv-aa.total=0,'',bb.inv-aa.total) balance,if(aa.total=0,'',aa.total) total,if(bb.inv=0,'',bb.inv) inv from ((select coalesce(round(sum(dramount),2),0) total from my_jvtran where rtype='LAG' and rdocno="+docno+"   and dtype='CRV' and id=1)  aa, "
			    		+ "(select coalesce(round(sum(dramount),2),0) inv from my_jvtran where rtype='LAG' and rdocno="+docno+"   and dtype='INV' and id=1) bb);  ";
				
		         ResultSet restotal = stmttatal.executeQuery(totalsql); 
		        
			       
			       while(restotal.next()){
			 
			    	   bean.setTotalpaids(restotal.getString("total"));
			    	   
			    	   bean.setInvamount(restotal.getString("inv"));
			    	   bean.setBalance(restotal.getString("balance"));
			    	   
			       } 
			       stmttatal.close();
			       
		
	       
	       conn.close();
	      }
	      catch(Exception e){
	       e.printStackTrace();
	       conn.close();
	      
	      }
	      return bean;
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
	  
	    	if(!(cldocno.equalsIgnoreCase("") || cldocno.equalsIgnoreCase("NA"))){
	    		sqltest=sqltest+" and a.cldocno='"+cldocno+"'";
	    	}
	    	if(!(fleet.equalsIgnoreCase("")|| fleet.equalsIgnoreCase("NA"))){
	    		sqltest=sqltest+" and if(r.perfleet=0,r.tmpfleet,r.perfleet)='"+fleet+"' ";
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

	    	Connection conn = null;
			try {
					 conn = ClsConnection.getMyConnection();
					Statement stmtVeh = conn.createStatement ();

					
	            	if(brnchval.equalsIgnoreCase("a"))
	            	{
	          
	 
	            		
	            		
	            		String sql ="select r.voc_no, r.brhid, r.doc_no,if(r.perfleet=0,r.tmpfleet,r.perfleet) fleet_no,r.cldocno, "
	            				+ " convert(coalesce(r.outdate,''),char(30)) outdate,coalesce(r.outtime,'') outtime,r.outkm, "
	            				+ " coalesce(v.reg_no,'') reg_no,coalesce(v.FLNAME,'') vehdetails ,a.refname,a.per_mob,a.contactperson from gl_lagmt r  "
	            				+ "left join gl_vehmaster v on if(r.perfleet=0,r.tmpfleet,r.perfleet)=v.fleet_no  "
	            				+ "	left join my_acbook a on a.cldocno=r.cldocno and a.dtype='CRM' left join gl_vehgroup g on g.doc_no=v.vgrpid "
	            				+ " where  r.clstatus=0	"+sqltest +"	 group by r.doc_no";
	            		
	            		
	            		
	            //	System.out.println("-------------------"+sql);
	        
	              
	            		ResultSet resultSet = stmtVeh.executeQuery(sql);
	            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
	     				stmtVeh.close();
	     				
	            	}
	            	else{	
	            		
	    
	            	  		String sql ="select r.voc_no,r.brhid, r.doc_no,if(r.perfleet=0,r.tmpfleet,r.perfleet) fleet_no,r.cldocno, "
	            				+ " convert(coalesce(r.outdate,''),char(30)) outdate,coalesce(r.outtime,'') outtime,r.outkm, "
	            				+ " coalesce(v.reg_no,'') reg_no,coalesce(v.FLNAME,'') vehdetails ,a.refname,a.per_mob,a.contactperson from gl_lagmt r  "
	            				+ "left join gl_vehmaster v on if(r.perfleet=0,r.tmpfleet,r.perfleet)=v.fleet_no  "
	            				+ "	left join my_acbook a on a.cldocno=r.cldocno and a.dtype='CRM' left join gl_vehgroup g on g.doc_no=v.vgrpid "
	            				+ " where  r.clstatus=0 and r.brhid='"+brnchval+"' "+sqltest +"	 group by r.doc_no";
	            		
	                	//System.out.println("-------------------"+sql);
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
	    
	    public JSONArray terminationgrid(String brnchval,String fromdate,String todate) throws SQLException {

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
	    
	    	if(!((brnchval.equalsIgnoreCase("a")) || (brnchval.equalsIgnoreCase("NA")))){
	 			sqltest+=" and r.brhid='"+brnchval+"'";
	 		}

	    
	    
	    	
	    	Connection conn = null;
			try {
					 conn = ClsConnection.getMyConnection();
					Statement stmtVeh = conn.createStatement ();
				
	            		String sql ="select r.voc_no,r.brhid, r.doc_no,r.date,if(perfleet=0,tmpfleet, perfleet) fleet_no,r.cldocno,r.outdate\r\n" + 
	            				"  odate,r.outtime otime,r.outkm okm,CASE WHEN r.outfuel='0.000' THEN 'Level 0/8' WHEN r.outfuel='0.125' THEN 'Level 1/8'\r\n" + 
	            				" WHEN r.outfuel='0.250' THEN 'Level 2/8' WHEN r.outfuel='0.375'	THEN 'Level 3/8'\r\n" + 
	            				"	WHEN r.outfuel='0.500' THEN 'Level 4/8'  WHEN r.outfuel='0.625' THEN 'Level 5/8'\r\n" + 
	            				" WHEN r.outfuel='0.750' THEN 'Level 6/8' WHEN  r.outfuel='0.875'  THEN 'Level 7/8' WHEN r.outfuel='1.000' THEN 'Level 8/8'\r\n" + 
	            				" END as 'ofuel',r.outfuel  hidfuel,r.drid,coalesce(v.reg_no,v1.reg_no) reg_no,coalesce(v.flname,v1.flname) flname,a.refname from\r\n" + 
	            				" gl_lagmt r left join gl_vehmaster v on  v.fleet_no=r.perfleet\r\n" + 
	            				" left join gl_vehmaster v1 on  v1.fleet_no=r.tmpfleet  left join my_acbook a on a.cldocno=r.cldocno and a.dtype='CRM'\r\n" + 
	            				"  where  r.clstatus=0 and  r.outdate between  '"+sqlfromdate+"' and  '"+sqltodate+"' "+sqltest;
	            		
	        
	           
	      // System.out.println("----sql------"+sql);
	          
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
	    
	  public JSONArray detailsgrid(String brnchval,String fromdate,String todate,String cldocno,String status,String fleet,String group,String brand,String model,String outchk,String inchk) throws SQLException {

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
	    		sqltest=sqltest+" and l.clstatus='"+status+"'";
	    	}
	    	if(!(cldocno.equalsIgnoreCase("") || cldocno.equalsIgnoreCase("NA"))){
	    		sqltest=sqltest+" and a.cldocno='"+cldocno+"'";
	    	}
	    	if(!(fleet.equalsIgnoreCase("")|| fleet.equalsIgnoreCase("NA"))){
	    		sqltest=sqltest+" and if(l.perfleet=0,l.tmpfleet,l.perfleet)='"+fleet+"'";
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
	    	if(!((brnchval.equalsIgnoreCase("a")) || (brnchval.equalsIgnoreCase("NA")))){
	 			sqltest+=" and l.brhid='"+brnchval+"'";
	 		}

	    
	    	if(inchk.equalsIgnoreCase("IN"))
	    	{
	    		sqltest+="	and  cs.indate between '"+sqlfromdate+"' and  '"+sqltodate+"' ";
	    		
	    	}
	    	else
	    	{
	    		
	    		sqltest+="	and  l.outdate between '"+sqlfromdate+"' and  '"+sqltodate+"' ";
	    	}
	    	
	    	Connection conn = null;
			try {
					 conn = ClsConnection.getMyConnection();
					Statement stmtVeh = conn.createStatement ();
				
	            				String sql ="select yom.yom,convert(coalesce(orgveh.reg_no,''),char(25)) originalregno,convert(coalesce(orgveh.fleet_no,''),char(25)) originalfleet,coalesce(orgveh.ch_no,'') originalchase,convert(coalesce(repveh.fleet_no,''),char(25)) replacefleet,convert(coalesce(repveh.reg_no,''),char(25)) replaceregno,"
	            				+ "coalesce(repveh.ch_no,'') replacechase,coalesce(prj.project_name,'') project,ms.sal_name,l.voc_no,convert(if(l.invdate=l.outdate,l.invdate,"
	            				+ "DATE_sub(l.invdate,INTERVAL 1 DAY)),char(30)) AS invdate,v.eng_no,l.brhid,convert(concat(l.per_value,' ',if(l.per_name=1,'Year','Month')),char(30)) AS duration,d.name drname,coalesce(l.refno,'') refnos,coalesce(manualra,'') mrno,l.doc_no,ur.user_name,clur.user_name closeuser, "
	            				+ "if(l.tmpfleet=0,l.perfleet,l.tmpfleet) fleet_no,l.cldocno,l.outdate,mh.account,l.outtime,l.outkm,v.reg_no,v.FLNAME vehdetails,a.refname,a.per_mob,if(l.clstatus=0,'Open','Close') AS clstatus,a.contactperson,tr.rate rent,tr.cdw, "
	            				+ "  coalesce((select invoiced from gl_lcalc where rdocno=l.doc_no and invno >0 and idno=1 and rowno=(select max(rowno) from gl_lcalc where rdocno=l.doc_no and invno >0 and idno=1)),0) invRental, "
	            				+ "coalesce((select invoiced from gl_lcalc where rdocno=l.doc_no and invno >0 and idno=17 and rowno=(select max(rowno) from gl_lcalc where rdocno=l.doc_no and invno >0 and idno=17)),0) invcdw "
	            				+ " ,if(l.per_name=1,DATE_ADD(l.outdate,INTERVAL l.per_value YEAR),DATE_ADD(l.outdate,INTERVAL l.per_value MONTH)) AS duedate,convert(coalesce(cs.indate,''),char(30)) indate,coalesce(cs.intime,'') intime  from gl_lagmt l left join gl_project prj on l.projectno=prj.doc_no left join gl_vehmaster v on if(l.tmpfleet=0,l.perfleet,l.tmpfleet)=v.fleet_no  "
	            				+ " left join gl_yom yom on v.yom=yom.doc_no left join gl_vehmaster orgveh on l.perfleet=orgveh.fleet_no left join gl_vehmaster repveh on l.tmpfleet=repveh.fleet_no"
	            				+ "  left join my_acbook a on a.cldocno=l.cldocno and a.dtype='CRM' left join gl_vehgroup g on g.doc_no=v.vgrpid "
	            				+ " left join gl_vehbrand br on br.doc_no=v.brdid  left join gl_vehmodel mo on  mo.doc_no=v.vmodid left join gl_ltarif tr on tr.rdocno=l.doc_no  "
	            				+ " left join my_user ur on ur.doc_no=l.userid "
                                                + " left join my_head mh on a.acno=mh.doc_no "
	            				+ " left join gl_ldriver dr on dr.rdocno=l.doc_no left join  gl_drdetails d on (d.dr_id=dr.drid ) left join gl_lagmtclosem cs on cs.agmtno=l.doc_no"
	            				+ " left join my_user clur on clur.doc_no=cs.userid "
	            				+ " left join my_salm ms on ms.doc_no=l.salid"
	            				
	            				+ " where l.status=3  "+sqltest+" group by l.doc_no";
	            		
	        
	           
	       System.out.println("----------"+sql);
	          
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
	    public JSONArray detailsgrids(String brnchval,String fromdate,String todate,String cldocno,String status,String fleet,String group,String brand,String model,String outchk,String inchk) throws SQLException {

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
	    		sqltest=sqltest+" and l.clstatus='"+status+"'";
	    	}
	    	if(!(cldocno.equalsIgnoreCase("") || cldocno.equalsIgnoreCase("NA"))){
	    		sqltest=sqltest+" and a.cldocno='"+cldocno+"'";
	    	}
	    	if(!(fleet.equalsIgnoreCase("")|| fleet.equalsIgnoreCase("NA"))){
	    		sqltest=sqltest+" and if(l.perfleet=0,l.tmpfleet,l.perfleet)='"+fleet+"'";
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
	    	if(!((brnchval.equalsIgnoreCase("a")) || (brnchval.equalsIgnoreCase("NA")))){
	 			sqltest+=" and l.brhid='"+brnchval+"'";
	 		}

	    
	    	if(inchk.equalsIgnoreCase("IN"))
	    	{
	    		sqltest+="	and  cs.indate between '"+sqlfromdate+"' and  '"+sqltodate+"' ";
	    		
	    	}
	    	else
	    	{
	    		
	    		sqltest+="	and  l.outdate between '"+sqlfromdate+"' and  '"+sqltodate+"' ";
	    	}
	    	
	    	Connection conn = null;
			try {
					 conn = ClsConnection.getMyConnection();
					Statement stmtVeh = conn.createStatement();
				
            	   		String sql =" select @id:=@id+1 SLNO,a.* from (select l.voc_no 'LA NO', if(l.perfleet=0,l.tmpfleet,l.perfleet) " + 
	            				"	 'Fleet',v.FLNAME 'Fleet Name',v.eng_no 'Engine_No',v.reg_no 'Reg No',yom.yom 'YoM' ,mh.account 'Account',a.refname 'Client Name',a.per_mob 'Mob NO',a.contactperson 'Contact Person',l.outdate 'Out Date',if(l.clstatus=0,'Open','Close') AS Clstatus,l.outtime 'Out Time',convert(if(l.invdate=l.outdate,l.invdate,DATE_SUB(l.invdate,INTERVAL 1 DAY)),char(30)) AS  'Inv Date', " + 
	            				"	 d.name 'Driver',coalesce(l.refno,'') 'Ref No',coalesce(manualra,'') 'Manual LA',convert(concat(l.per_value,' ',if(l.per_name=1,'Year','Month')),char(30)) AS Duration,convert(coalesce(cs.indate,''),char(30)) 'In Date',coalesce(cs.intime,'') 'In Time' ," + 
	            				"	 tr.rate 'Rent',tr.cdw 'CDW',   coalesce((select invoiced from gl_lcalc where rdocno=l.doc_no and invno >0 and idno=1 " + 
	            				"	 and rowno=(select max(rowno) from gl_lcalc where rdocno=l.doc_no and invno >0 and idno=1)),0) 'Inv Rent', " + 
	            				"	 coalesce((select invoiced from gl_lcalc where rdocno=l.doc_no and invno >0 and idno=17 and " + 
	            				"	 rowno=(select max(rowno) from gl_lcalc where rdocno=l.doc_no and invno >0 and idno=17)),0) 'Inv CDW'," +
	            				"    convert(coalesce(orgveh.fleet_no,''),char(25)) 'Original Fleet',convert(coalesce(orgveh.reg_no,''),char(25)) 'Original Reg No',coalesce(orgveh.ch_no,'') 'Original Chassis No',"
	            				+ "  convert(coalesce(repveh.fleet_no,''),char(25)) 'Replace Fleet',coalesce(repveh.ch_no,'') 'Replace Chassis No' ,ur.user_name 'Open User',clur.user_name 'Close User',  ms.sal_name 'Salesman' , if(l.per_name=1,DATE_ADD(l.outdate,INTERVAL l.per_value YEAR),DATE_ADD(l.outdate,INTERVAL l.per_value MONTH)) AS 'Due Date' , coalesce(prj.project_name,'') 'Project'"+
	            				"	 from gl_lagmt l left join gl_project prj on l.projectno=prj.doc_no left join gl_vehmaster v on if(l.tmpfleet=0,l.perfleet,l.tmpfleet)=v.fleet_no  " +
	            				"    left join gl_yom yom on v.yom=yom.doc_no left join gl_vehmaster orgveh on l.perfleet=orgveh.fleet_no left join gl_vehmaster repveh on l.tmpfleet=repveh.fleet_no"+
	            				"	 left join my_acbook a on a.cldocno=l.cldocno and a.dtype='CRM' left join gl_vehgroup g on g.doc_no=v.vgrpid " + 
	            				"	 left join gl_vehbrand br on br.doc_no=v.brdid  left join gl_vehmodel mo on  mo.doc_no=v.vmodid " + 
	            				"	 left join gl_ltarif tr on tr.rdocno=l.doc_no  left join gl_ldriver dr on dr.rdocno=l.doc_no " + 
	            				 " left join my_user ur on ur.doc_no=l.userid "+
	            				"	 left join my_head mh on a.acno=mh.doc_no left join  gl_drdetails d on (d.dr_id=dr.drid ) left join gl_lagmtclosem cs on cs.agmtno=l.doc_no"
	            				+ " left join my_user clur on clur.doc_no=cs.userid "
	            				+ " left join my_salm ms on ms.doc_no=l.salid" + 
	            				
	            				
	            				"	 where l.status=3  "+sqltest+" group by l.doc_no ) a,(select @id:=0) r"; 
					
 
 
	        System.out.println("======== "+sql);  
	            		ResultSet resultSet = stmtVeh.executeQuery(sql);
	            		 RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
	        //    		 System.out.println("resultdata === "+RESULTDATA);
	     				stmtVeh.close();
	     				
	        
	 			
	            	conn.close();
			}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
			//System.out.println( RESULTDATA);
	        return RESULTDATA;
	    }
	
	    public JSONArray getSummaryData(String brnchval,String fromdate,String todate,String cldocno,String status,String fleet,String group,String brand,String model,String outchk,String inchk,String id) throws SQLException {

	        JSONArray RESULTDATA=new JSONArray();
	        if(!id.equalsIgnoreCase("1")){
	        	return RESULTDATA;
	        }
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
	    		sqltest=sqltest+" and l.clstatus='"+status+"'";
	    	}
	    	if(!(cldocno.equalsIgnoreCase("") || cldocno.equalsIgnoreCase("NA"))){
	    		sqltest=sqltest+" and a.cldocno='"+cldocno+"'";
	    	}
	    	if(!(fleet.equalsIgnoreCase("")|| fleet.equalsIgnoreCase("NA"))){
	    		sqltest=sqltest+" and if(l.perfleet=0,l.tmpfleet,l.perfleet)='"+fleet+"'";
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
	    	if(!((brnchval.equalsIgnoreCase("a")) || (brnchval.equalsIgnoreCase("NA")))){
	 			sqltest+=" and l.brhid='"+brnchval+"'";
	 		}

	    
	    	if(inchk.equalsIgnoreCase("IN"))
	    	{
	    		sqltest+="	and  cs.indate between '"+sqlfromdate+"' and  '"+sqltodate+"' ";
	    		
	    	}
	    	else
	    	{
	    		
	    		sqltest+="	and  l.outdate between '"+sqlfromdate+"' and  '"+sqltodate+"' ";
	    	}
	    	
	    	Connection conn = null;
			try {
					 conn = ClsConnection.getMyConnection();
					Statement stmtVeh = conn.createStatement();
				
					String sql ="select count(l.doc_no) agmtcount, yom.yom,convert(coalesce(orgveh.reg_no,''),char(25)) originalregno,convert(coalesce(orgveh.fleet_no,''),char(25)) originalfleet,coalesce(orgveh.ch_no,'') originalchase,convert(coalesce(repveh.fleet_no,''),char(25)) replacefleet,convert(coalesce(repveh.reg_no,''),char(25)) replaceregno,"
            				+ "coalesce(repveh.ch_no,'') replacechase,coalesce(prj.project_name,'') project,ms.sal_name,l.voc_no,convert(if(l.invdate=l.outdate,l.invdate,"
            				+ "DATE_sub(l.invdate,INTERVAL 1 DAY)),char(30)) AS invdate,v.eng_no,l.brhid,convert(concat(l.per_value,' ',if(l.per_name=1,'Year','Month')),char(30)) AS duration,d.name drname,coalesce(l.refno,'') refnos,coalesce(manualra,'') mrno,l.doc_no,ur.user_name,clur.user_name closeuser, "
            				+ "if(l.tmpfleet=0,l.perfleet,l.tmpfleet) fleet_no,l.cldocno,l.outdate,mh.account,l.outtime,l.outkm,v.reg_no,v.FLNAME vehdetails,a.refname,a.per_mob,if(l.clstatus=0,'Open','Close') AS clstatus,a.contactperson,tr.rate rent,tr.cdw, "
            				+ "  coalesce((select invoiced from gl_lcalc where rdocno=l.doc_no and invno >0 and idno=1 and rowno=(select max(rowno) from gl_lcalc where rdocno=l.doc_no and invno >0 and idno=1)),0) invRental, "
            				+ "coalesce((select invoiced from gl_lcalc where rdocno=l.doc_no and invno >0 and idno=17 and rowno=(select max(rowno) from gl_lcalc where rdocno=l.doc_no and invno >0 and idno=17)),0) invcdw "
            				+ " ,if(l.per_name=1,DATE_ADD(l.outdate,INTERVAL l.per_value YEAR),DATE_ADD(l.outdate,INTERVAL l.per_value MONTH)) AS duedate,convert(coalesce(cs.indate,''),char(30)) indate,coalesce(cs.intime,'') intime  from gl_lagmt l left join gl_project prj on l.projectno=prj.doc_no left join gl_vehmaster v on if(l.tmpfleet=0,l.perfleet,l.tmpfleet)=v.fleet_no  "
            				+ " left join gl_yom yom on v.yom=yom.doc_no left join gl_vehmaster orgveh on l.perfleet=orgveh.fleet_no left join gl_vehmaster repveh on l.tmpfleet=repveh.fleet_no"
            				+ "  left join my_acbook a on a.cldocno=l.cldocno and a.dtype='CRM' left join gl_vehgroup g on g.doc_no=v.vgrpid "
            				+ " left join gl_vehbrand br on br.doc_no=v.brdid  left join gl_vehmodel mo on  mo.doc_no=v.vmodid left join gl_ltarif tr on tr.rdocno=l.doc_no  "
            				+ " left join my_user ur on ur.doc_no=l.userid "
                                            + " left join my_head mh on a.acno=mh.doc_no "
            				+ " left join gl_ldriver dr on dr.rdocno=l.doc_no left join  gl_drdetails d on (d.dr_id=dr.drid ) left join gl_lagmtclosem cs on cs.agmtno=l.doc_no"
            				+ " left join my_user clur on clur.doc_no=cs.userid "
            				+ " left join my_salm ms on ms.doc_no=l.salid"
            				
            				+ " where l.status=3  "+sqltest+" group by a.cldocno";
					
 
 
	        System.out.println("======== "+sql);  
	            		ResultSet resultSet = stmtVeh.executeQuery(sql);
	            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
	        //    		 System.out.println("resultdata === "+RESULTDATA);
	     				stmtVeh.close();
	     				
	        
	 			
	            	conn.close();
			}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
			//System.out.println( RESULTDATA);
	        return RESULTDATA;
	    }
	    
	    
	    public JSONArray getSummaryExcelData(String brnchval,String fromdate,String todate,String cldocno,String status,String fleet,String group,String brand,String model,String outchk,String inchk,String id) throws SQLException {

	        JSONArray RESULTDATA=new JSONArray();
	        if(!id.equalsIgnoreCase("1")){
	        	return RESULTDATA;
	        }
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
	    		sqltest=sqltest+" and l.clstatus='"+status+"'";
	    	}
	    	if(!(cldocno.equalsIgnoreCase("") || cldocno.equalsIgnoreCase("NA"))){
	    		sqltest=sqltest+" and a.cldocno='"+cldocno+"'";
	    	}
	    	if(!(fleet.equalsIgnoreCase("")|| fleet.equalsIgnoreCase("NA"))){
	    		sqltest=sqltest+" and if(l.perfleet=0,l.tmpfleet,l.perfleet)='"+fleet+"'";
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
	    	if(!((brnchval.equalsIgnoreCase("a")) || (brnchval.equalsIgnoreCase("NA")))){
	 			sqltest+=" and l.brhid='"+brnchval+"'";
	 		}

	    
	    	if(inchk.equalsIgnoreCase("IN"))
	    	{
	    		sqltest+="	and  cs.indate between '"+sqlfromdate+"' and  '"+sqltodate+"' ";
	    		
	    	}
	    	else
	    	{
	    		
	    		sqltest+="	and  l.outdate between '"+sqlfromdate+"' and  '"+sqltodate+"' ";
	    	}
	    	
	    	Connection conn = null;
			try {
					 conn = ClsConnection.getMyConnection();
					Statement stmtVeh = conn.createStatement();
					/*count(l.doc_no) agmtcount, yom.yom,convert(coalesce(orgveh.reg_no,''),char(25)) originalregno,convert(coalesce(orgveh.fleet_no,''),char(25)) originalfleet,coalesce(orgveh.ch_no,'') originalchase,convert(coalesce(repveh.fleet_no,''),char(25)) replacefleet,convert(coalesce(repveh.reg_no,''),char(25)) replaceregno,"
            				+ "coalesce(repveh.ch_no,'') replacechase,coalesce(prj.project_name,'') project,ms.sal_name,l.voc_no,convert(if(l.invdate=l.outdate,l.invdate,"
            				+ "DATE_sub(l.invdate,INTERVAL 1 DAY)),char(30)) AS invdate,v.eng_no,l.brhid,convert(concat(l.per_value,' ',if(l.per_name=1,'Year','Month')),char(30)) AS duration,d.name drname,coalesce(l.refno,'') refnos,coalesce(manualra,'') mrno,l.doc_no,ur.user_name,clur.user_name closeuser, "
            				+ "if(l.tmpfleet=0,l.perfleet,l.tmpfleet) fleet_no,l.cldocno,l.outdate,mh.account,l.outtime,l.outkm,v.reg_no,v.FLNAME vehdetails,a.refname,a.per_mob,if(l.clstatus=0,'Open','Close') AS clstatus,a.contactperson,tr.rate rent,tr.cdw, "
            				+ "  coalesce((select invoiced from gl_lcalc where rdocno=l.doc_no and invno >0 and idno=1 and rowno=(select max(rowno) from gl_lcalc where rdocno=l.doc_no and invno >0 and idno=1)),0) invRental, "
            				+ "coalesce((select invoiced from gl_lcalc where rdocno=l.doc_no and invno >0 and idno=17 and rowno=(select max(rowno) from gl_lcalc where rdocno=l.doc_no and invno >0 and idno=17)),0) invcdw "
            				+ " ,if(l.per_name=1,DATE_ADD(l.outdate,INTERVAL l.per_value YEAR),DATE_ADD(l.outdate,INTERVAL l.per_value MONTH)) AS duedate,convert(coalesce(cs.indate,''),char(30)) indate,coalesce(cs.intime,'') intime "
            				+ ""
            				+ "
*/					String sql ="select l.cldocno 'Code No',a.refname 'Client Name',mh.account 'Account',a.contactperson 'Contact Person',ms.sal_name 'Salesman',count(l.doc_no) 'No of LA' from gl_lagmt l left join gl_project prj on l.projectno=prj.doc_no left join gl_vehmaster v on if(l.tmpfleet=0,l.perfleet,l.tmpfleet)=v.fleet_no  "
            				+ " left join gl_yom yom on v.yom=yom.doc_no left join gl_vehmaster orgveh on l.perfleet=orgveh.fleet_no left join gl_vehmaster repveh on l.tmpfleet=repveh.fleet_no"
            				+ "  left join my_acbook a on a.cldocno=l.cldocno and a.dtype='CRM' left join gl_vehgroup g on g.doc_no=v.vgrpid "
            				+ " left join gl_vehbrand br on br.doc_no=v.brdid  left join gl_vehmodel mo on  mo.doc_no=v.vmodid left join gl_ltarif tr on tr.rdocno=l.doc_no  "
            				+ " left join my_user ur on ur.doc_no=l.userid "
                            + " left join my_head mh on a.acno=mh.doc_no "
            				+ " left join gl_ldriver dr on dr.rdocno=l.doc_no left join  gl_drdetails d on (d.dr_id=dr.drid ) left join gl_lagmtclosem cs on cs.agmtno=l.doc_no"
            				+ " left join my_user clur on clur.doc_no=cs.userid "
            				+ " left join my_salm ms on ms.doc_no=l.salid"
            				+ " where l.status=3  "+sqltest+" group by a.cldocno";
					
 
 
	        System.out.println("======== "+sql);  
	            		ResultSet resultSet = stmtVeh.executeQuery(sql);
	            		 RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
	        //    		 System.out.println("resultdata === "+RESULTDATA);
	     				stmtVeh.close();
	     				
	        
	 			
	            	conn.close();
			}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
			//System.out.println( RESULTDATA);
	        return RESULTDATA;
	    }
}
