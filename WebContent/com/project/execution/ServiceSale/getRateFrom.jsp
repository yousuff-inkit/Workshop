<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%		ClsConnection connDAO=new ClsConnection();
	Connection conn =null;

	String curr=request.getParameter("curr");
 	try
 	{
 	  conn = connDAO.getMyConnection();
	Statement stmt = conn.createStatement ();
	String strSql = "select c.doc_no,c.code,round(cb.rate,2) c_rate,cb.type from  my_curr c inner join my_curbook cb on (c.doc_no=cb.curid) where c.doc_no='"+curr+"'";
	//System.out.println("strSql---"+strSql);
	ResultSet rs = stmt.executeQuery(strSql); 
	Double rate=0.0;
	while(rs.next()) {
		rate=rs.getDouble("c_rate");
  		} 
	response.getWriter().write(rate.toString());
	stmt.close();
	conn.close();
 	}
 	catch(Exception e0)
 	{
 		 
 		conn.close();
 	}
 	
  %>
  
