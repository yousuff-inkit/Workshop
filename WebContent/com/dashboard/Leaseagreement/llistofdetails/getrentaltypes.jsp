<%-- <%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	
	Connection conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	String strSql = "select rentaltype from gl_tlistm where status=1;";
	ResultSet rs = stmt.executeQuery(strSql);
	String rentaltype="";
	while(rs.next()) {
		rentaltype+=rs.getString("rentaltype")+",";
			} 
	String rentaltypes[]=rentaltype.split(",");
	rentaltype=rentaltype.substring(0, rentaltype.length()-1);
	response.getWriter().write(rentaltype);
	stmt.close();
	conn.close();
  %>
   --%>