<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%
System.out.println("Here In Tconv"); 	
Connection conn = null;
ClsConnection objconn=new ClsConnection();
	try{
		conn=objconn.getMyConnection();
	Statement stmt = conn.createStatement ();
	String strSql = "select method from gl_config where field_nme='tconv'";
	ResultSet rs = stmt.executeQuery(strSql);
int id=0;
	if(rs.next()) {
		id=rs.getInt("method");
  		} 
	//id=rental.substring(0, rental.length()-1);
	String conv="";
	if(id==1){
		conv="convert";
	}
	else{
		conv="noconvert";
	}
	System.out.println("Id"+id+conv);
	stmt.close();
	conn.close();

	response.getWriter().write(conv);
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
	%>