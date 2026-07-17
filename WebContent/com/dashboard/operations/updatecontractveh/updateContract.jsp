<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%
ClsConnection ClsConnection=new ClsConnection();

 	Connection conn = null;
	String agmttype=request.getParameter("agmttype")==null?"":request.getParameter("agmttype");
	String agmtno=request.getParameter("agmtno")==null?"":request.getParameter("agmtno");
	String fleet=request.getParameter("fleet")==null?"":request.getParameter("fleet");
try{
	conn=ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement();
	String str="";
	String msg="";
	conn.setAutoCommit(false);
	if(agmttype.equalsIgnoreCase("RAG")){
		str="update gl_ragmt set ofleet_no="+fleet+" where doc_no="+agmtno;
	}
	else if(agmttype.equalsIgnoreCase("LAG")){
		str="update gl_lagmt set perfleet="+fleet+" where doc_no="+agmtno;
	}
	System.out.println("Query: "+str);
	if(!str.equalsIgnoreCase("")){
		int update=stmt.executeUpdate(str);
		if(update>0){
			
			conn.commit();
			msg="Successfully  Updated";
			stmt.close();
			conn.close();
			
		}
		else{
			msg="Not Updated";
			stmt.close();
			conn.close();
		}
	}
	stmt.close();
	conn.close();
	response.getWriter().write(msg);
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
	%>