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
	String list=request.getParameter("list")==null?"0":request.getParameter("list");
	String masterdocno=request.getParameter("masterdocno")==null?"0":request.getParameter("masterdocno");
	ArrayList<String> proday= new ArrayList<String>();
	String aa[]=list.split(",");
		for(int i=0;i<aa.length;i++){
			 String bb[]=aa[i].split("::");
			 String temp="";
			 for(int j=0;j<bb.length;j++){ 
				 temp=temp+bb[j]+"::";
			}
			 proday.add(temp);
		  } 
	  Connection conn=null;
	    String sql="";
	    try
	    {
	    	
	    	
	    	
	    conn = ClsConnection.getMyConnection();
	    conn.setAutoCommit(false);
		Statement stmt = conn.createStatement();
		

					
					for(int k=0;k<proday.size();k++)
					{
						String[] prod=((String) proday.get(k)).split("::"); 
						String rowno=""+(prod[0].trim().equalsIgnoreCase("undefined") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].trim().equalsIgnoreCase("")|| prod[0].isEmpty()?0:prod[0].trim())+"";
						String qty=""+(prod[1].trim().equalsIgnoreCase("undefined") || prod[1].trim().equalsIgnoreCase("NaN")|| prod[1].trim().equalsIgnoreCase("")|| prod[1].isEmpty()?0:prod[1].trim())+"";
						String updatesql="update my_mreqd set out_qty=out_qty+'"+qty+"',cqty=cqty+'"+qty+"' where rowno='"+rowno+"' ";
						stmt.executeUpdate(updatesql);
					    
						
						
					}
					
					
					 
					 conn.commit();
					stmt.close();
					conn.close();
					response.getWriter().print(1);
					
				
				 
				
				
				
				
				
	    }
	    catch(Exception e)
	    {
	    	e.printStackTrace();
	    	conn.close();
	    	response.getWriter().print(2);
	    }
	    finally{
	    	conn.close();
	    }
	 	
	 	
%>



 