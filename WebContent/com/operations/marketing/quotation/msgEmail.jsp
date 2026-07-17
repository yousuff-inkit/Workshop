
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.connection.*" %>


<%	
ClsConnection connDAO=new ClsConnection();
Connection conn = null;

      try
      {
String formcode=request.getParameter("formcode");
 	  conn = connDAO.getMyConnection();
	Statement stmt = conn.createStatement ();
	String strSql = "select msg,subject FROM gl_emailmsg where dtype='"+formcode+"' ";
	ResultSet rs = stmt.executeQuery(strSql);
	//System.out.println("=strSql=strSql==strSql=="+strSql);
	String msg="",subject="";
	while(rs.next()) {
		msg=rs.getString("msg").trim();
		subject=rs.getString("subject").trim();
	
			
  		} 
//	System.out.println("signature=="+signature);
	/* //System.out.println("branch"+brnchId);
	//System.out.println("curr"+currId);
	String Server[]=smtpServer.split(",");
	String HostPort[]=smtpHostPort.split(",");
	 */
	
	response.getWriter().write(msg+"####"+subject);
	
	stmt.close();
	conn.close();
      }
      catch (Exception e)
      {
    	  conn.close();
      }
  %>
  
