
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

//System.out.println("---tagno-------"+tagno);
//System.out.println("---regno-------"+regno);
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
		 
		 
 	String sql="select s.tagno,s.salik_date,s.trans,va.authid auth,veh.fleet_no from gl_salik s  left join gl_vehmaster veh on veh.salik_tag=s.tagno left join gl_vehauth va on va.doc_no=veh.authid  where  s.isallocated=0 and s.status in (0,3) "+sqltest; 
	
	
 	System.out.println("---sql-------"+sql);
	
	ResultSet rs = stmt.executeQuery(sql);
		
	
		   
		     while(rs.next()) {
		    	 rowValues.add(rs.getString("fleet_no")+" :: "+rs.getString("tagno")+" :: "+rs.getTimestamp("salik_date")+" :: "+rs.getString("trans"));
	
		} 
		     

		
	for(int i=0;i<rowValues.size();i++)
	{
		

		
		 String[] subarray=rowValues.get(i).split("::");	
		  
		 if(subarray[0].trim().equalsIgnoreCase("null"))
				 {
		
			 String sqlup="update gl_salik set reason='Fleet Not Recognize' where tagno='"+subarray[1].trim()+"' and trans='"+subarray[3].trim()+"'";
		 System.out.println("-----1--"+sqlup); 
			 stmt.executeUpdate(sqlup);
			 
				 }
				 else
				 {
					
					 
				Statement stmt1 = conn.createStatement ();
					String sqlup1="select v.fleet_no,trancode,rdocno,rdtype,emp_id,emp_type from gl_vmove m inner join gl_vehmaster v on (m.fleet_no=v.fleet_no) where  ('"+subarray[2].trim()+"' <=coalesce(cast(concat(din,' ',tin) as datetime),now())	and '"+subarray[2].trim()+"'>= cast(concat(dout,' ',tout) as datetime)) and rdtype!='VSC' and salik_tag='"+subarray[1].trim()+"' order by rdocno "; 

                   // System.out.println("-----2--"+sqlup1);  
					 ResultSet rs1 = stmt1.executeQuery(sqlup1);
				     while(rs1.next())
				     {
				    	
				    
				    	 
						    	 if(rs1.getString("rdtype").equalsIgnoreCase("RAG") || rs1.getString("rdtype").equalsIgnoreCase("MOV") || rs1.getString("rdtype").equalsIgnoreCase("LAG")  || rs1.getString("rdtype").equalsIgnoreCase("VCU") )
						    	 {
						    		 saveval="11";
						    		 Statement stmt2 = conn.createStatement ();
						    		 String sqlup2="update gl_salik set isallocated=1,reason='Allocated',ra_no='"+rs1.getString("rdocno")+"',rtype='"+rs1.getString("trancode")+"',emp_id='"+rs1.getString("emp_id")+"',emp_type='"+rs1.getString("emp_type")+"', fleetno='"+rs1.getString("fleet_no")+"' where tagno='"+subarray[1].trim()+"' and trans='"+subarray[3].trim()+"'";
						    	 	  //System.out.println("-----3--"+sqlup2);   
						    		 stmt2.executeUpdate(sqlup2);
						    		 stmt2.close();
						    		 
						    		 
						    	
						    		 
						    	 }

				      } 
				     stmt1.close();
					 
				 } // else close
		 
		 
		
	}// for close
	
	      stmt.close();
 	         conn.close();				
		 response.getWriter().print(saveval);
	 
	 
	 	
	 	
	 
 }catch(Exception e){
	 
		e.printStackTrace();
		conn.close();
		response.getWriter().print("12");
	}

	 	
	 	
	 	
%>





