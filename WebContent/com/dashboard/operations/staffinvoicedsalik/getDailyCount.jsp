<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.ClsCommon" %>

<% String fromdate =request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").toString();%>
 <% String todate =request.getParameter("todate")==null?"0":request.getParameter("todate").toString();%>
 <% String satcateg =request.getParameter("satcateg")==null?"0":request.getParameter("satcateg").toString();%>
<%	
	Connection conn = null;
ClsConnection ClsConnection=new ClsConnection();

ClsCommon ClsCommon=new ClsCommon();

	try{
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement ();
		String datecount="";
		String strSql ="";
		java.sql.Date sdate=null;
		java.sql.Date edate=null;
		
		if(!(fromdate.equalsIgnoreCase("0") || todate.equalsIgnoreCase("0") )){
			 sdate=ClsCommon.changeStringtoSqlDate(fromdate);
			 edate=ClsCommon.changeStringtoSqlDate(todate);
		}
		
		
		
		if(satcateg.equalsIgnoreCase("traffic")){
			
			datecount="Date wise Traffic Count"+"\n";
			datecount=datecount+"-------------------------------"+"\n";
			
		 strSql = "select concat(DATE_FORMAT(date,'%d-%m-%Y'),'  :  ',count(*)) as datecount from gl_traffic where date<='"+edate+"' and date>='"+sdate+"' group by date";      
		}
		if(satcateg.equalsIgnoreCase("salik")){
			
			datecount="Date wise Salik Count"+"\n";
			datecount=datecount+"-------------------------------"+"\n";
			
			 strSql = "select concat(DATE_FORMAT(date,'%d-%m-%Y'),'  :  ',count(*)) as datecount from gl_salik where date<='"+edate+"' and date>='"+sdate+"' group by date";      
		}
		//System.out.println("=strSql=="+strSql);
		ResultSet rs = stmt.executeQuery(strSql);
		while(rs.next()) {
			datecount=datecount+rs.getString("datecount")+"\n";
			//System.out.println("=datecount=="+datecount);
				} 
		
	
		response.getWriter().write(datecount);

		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  