<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	
Connection conn=null;
ClsConnection ClsConnection=new ClsConnection();


try{
    conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	String strSql = "select doc_no,user_name from my_user;";
	//System.out.println(strSql);
	ResultSet rs = stmt.executeQuery(strSql);
	String user_name="",doc_no="";
	while(rs.next()) {
		user_name+=rs.getString("user_name")+",";
		doc_no+=rs.getString("doc_no")+",";
			} 
	String user_names[]=user_name.split(",");
	String doc_nos[]=doc_no.split(",");
	
	user_name=user_name.substring(0, user_name.length()-1);
	doc_no=doc_no.substring(0,doc_no.length()-1);
	//System.out.println(doc_no);
	response.getWriter().write(user_name+"####"+doc_no);
	stmt.close();
	conn.close();
	
	
}
catch(Exception e){

		conn.close();
		e.printStackTrace();
	}
	
	
  %>
  