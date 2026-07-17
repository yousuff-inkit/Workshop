<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	
ClsConnection ClsConnection=new ClsConnection();
Connection conn = ClsConnection.getMyConnection();
String part=request.getParameter("partno");
System.out.println("===partno===="+part);
 	try{
	Statement stmt = conn.createStatement ();
	String strSql = "select *  from my_main where status <>7 and part_no='"+part+"'";
	System.out.println("===strSql===="+strSql);
	ResultSet rs = stmt.executeQuery(strSql);
	String scategory="";
	String scategoryid="";
	if(rs.next()) {
		scategory="1";		
		//scategoryid+=rs.getString("doc_no")+",";
  		} 
	//model=model.substring(0, model.length()-1);
	//scategory=scategory.substring(0, scategory.length()>0?scategory.length()-1:0);
	response.getWriter().write(scategory);
	
 	}
 	catch(Exception e){
 		e.printStackTrace();
 		
 	}
 	finally{
 		conn.close();
 	}
  %>
  
