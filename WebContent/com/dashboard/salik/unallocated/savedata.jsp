 <%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.util.*"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.common.*"%>
<%@ page import="java.sql.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	String saveval=request.getParameter("saveval");
	String tagno = request.getParameter("tagno")==null?"0":request.getParameter("tagno");
	String regno = request.getParameter("regno")==null?"0":request.getParameter("regno");

		String sqltest="";

		if(!(tagno.equalsIgnoreCase(""))){
			sqltest=sqltest+" and s.tagno='"+tagno+"'";
		}
		if(!(regno.equalsIgnoreCase(""))){
			sqltest=sqltest+" and s.regno='"+regno+"' ";
		}
	 		String upsql=null;

	 		int val=0;
 			Connection conn = null;

			ArrayList<String> rowValues= new ArrayList<String>();
	
	 try{
		 	conn = ClsConnection.getMyConnection();
		 	Statement stmt = conn.createStatement ();
		 	
 			/* String sql=" select s.tagno,min(s.salik_date) salik_date,s.trans,veh.fleet_no from gl_salik s "
 			 +" left join gl_vehmaster veh on veh.salik_tag=s.tagno "
 			+" where  s.isallocated=0 and s.status in (0,3)  and veh.fleet_no is not null "+sqltest+" group by regno ";  
			ResultSet rs = stmt.executeQuery(sql);
		     while(rs.next()) 
		     	{
		    	 rowValues.add(rs.getString("fleet_no")+" :: "+rs.getString("tagno")+" :: "+rs.getTimestamp("salik_date")+" :: "+rs.getString("trans"));
				} 
		     
			for(int i=0;i<rowValues.size();i++)
				{
		
		 			String[] subarray=rowValues.get(i).split("::");	
					 saveval="11";
					 
					 String sqlup1=" update  gl_vmove v left join gl_vehmaster v1 on v.fleet_no=v1.fleet_no "
						+" left join gl_salik s on v1.salik_tag=s.tagno and s.salik_date between v.dout and coalesce(v.din,now()) "
						+"  set isallocated=1,reason='Allocated',ra_no=v.rdocno,s.rtype=v.trancode,s.emp_id=v.emp_id,s.emp_type=v.emp_type, fleetno=v.fleet_no   "
						+"   where v.fleet_no='"+subarray[0].trim()+"' and s.salik_date is not null and s.isallocated=0 and s.status in (0,3) ";
				 	stmt.executeUpdate(sqlup1);
				 	
	            }// for close */
	            	saveval="11";
	            	String sqlup1=" update  gl_salik s left join gl_vehmaster v1 on v1.salik_tag=s.tagno "
	            		+" left join gl_vmove v  on v.fleet_no=v1.fleet_no and s.salik_date between v.dout and coalesce(v.din,now()) "
	            		+" set isallocated=1,reason='Allocated',ra_no=v.rdocno,s.rtype=v.trancode,s.emp_id=v.emp_id,s.emp_type=v.emp_type, fleetno=v.fleet_no "
	            		+"  where s.isallocated=0 and s.status in (0,3)  and v1.fleet_no is not null  "+sqltest+" ";
	        		stmt.executeUpdate(sqlup1);
	            
	 
				 	String sqlup="update gl_salik s  left join gl_vehmaster veh on veh.salik_tag=s.tagno "+
				 				" set reason='Fleet Not Recognize' where isallocated=0 and s.status in (0,3)  and veh.fleet_no is null ";
				 	stmt.executeUpdate(sqlup);
	       			stmt.close();
 	         		conn.close();				
		 			response.getWriter().print(saveval);
	 
 			}
	 	catch(Exception e)
	 		{
				e.printStackTrace();
				conn.close();
				response.getWriter().print("12");
			}

	 	
	 	
	 	
		%>
