
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
<%@page import="com.common.OracleCon"%>
<%	
ClsConnection ClsConnection=new ClsConnection();

ClsCommon ClsCommon=new ClsCommon();


	String importfromdate=request.getParameter("importfromdate");
	String importtodate=request.getParameter("importtodate");
 	java.sql.Date sqlimpfromdate=null;
 	java.sql.Date sqlimptodate=null;
 	System.out.println("sqlimpfromdate="+sqlimpfromdate+"sqlimptodate="+sqlimptodate);
 	System.out.println("sqlimpfromdate="+importfromdate+"sqlimptodate="+importtodate);
 	if(!(importfromdate.equalsIgnoreCase("undefined"))&&!(importfromdate.equalsIgnoreCase(""))&&!(importfromdate.equalsIgnoreCase("0")))
	{
 		sqlimpfromdate=ClsCommon.changeStringtoSqlDate(importfromdate);
		
	}
	if(!(importtodate.equalsIgnoreCase("undefined"))&&!(importtodate.equalsIgnoreCase(""))&&!(importtodate.equalsIgnoreCase("0")))
		{
		sqlimptodate=ClsCommon.changeStringtoSqlDate(importtodate);
			
		}
	
     
	 Connection conn=null;
	 
	 try{
		 conn = ClsConnection.getMyConnection();
	
		 OracleCon OracleCon=new OracleCon();
			String status=OracleCon.oracleTest(sqlimpfromdate,sqlimptodate);
			if(status.equalsIgnoreCase("success")){
				response.getWriter().print(1);
			}
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
			if(session.getAttribute("BRANCHID")==null)
			{
				response.getWriter().print(10);	
				
			}
			else
			{
				response.getWriter().print(0);
			}
			
			
			
		}

	    
	%>
