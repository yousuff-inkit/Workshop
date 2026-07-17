<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%
String regno=request.getParameter("regno")==null?"":request.getParameter("regno");
String platecode=request.getParameter("platecode")==null?"":request.getParameter("platecode");

ClsConnection ClsConnection=new ClsConnection();
Connection conn = null;
int count=0;
try{
	conn=ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	
	
	if(!(regno.equalsIgnoreCase("")) && !(platecode.equalsIgnoreCase(""))){
	String strSql = "select count(*) count,regno,pltid from ws_gateinpass where status=3 and regno='"+regno+"' and pltid='"+platecode+"' and outdate is null";
	System.out.println(strSql);
	ResultSet rs = stmt.executeQuery(strSql);
	

	while(rs.next()) {
		count=rs.getInt("count");	
		//System.out.println(rtype);
  		}
	}
	
	
	stmt.close();
	conn.close();
 
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
finally{
	conn.close();
}
response.getWriter().write(count+"");
	%>
  
