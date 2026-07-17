<%@page import="com.connection.*" %>
<%@page import="com.common.*" %>
<%@page import="java.sql.*" %>
<%
	ClsConnection objconn=new ClsConnection();
	Connection conn=null;
	int srvcadvisorconfig=0;
	try{
		conn=objconn.getMyConnection();
		Statement stmt=conn.createStatement();
		
		String str="select method from gl_config where field_nme='srvcadvisorstockqty'";
		ResultSet rs=stmt.executeQuery(str);
		while(rs.next()){
			srvcadvisorconfig=rs.getInt("method");
		}
	}
	catch(Exception e){
		e.printStackTrace();
		conn.close();
	}
	finally{
		conn.close();
	}
	response.getWriter().write(srvcadvisorconfig+"");
%>