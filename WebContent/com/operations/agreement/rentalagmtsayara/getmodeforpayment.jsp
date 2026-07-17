<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	 ClsConnection connDAO=new ClsConnection();
	String modeval=request.getParameter("modeval");
 	Connection conn = null;
 	try{
 		conn = connDAO.getMyConnection();
	Statement stmt = conn.createStatement ();
	String strSql = "select doc_no from my_cardm where mode='"+modeval+"' ";
	//System.out.println("----------"+strSql);
	ResultSet rs = stmt.executeQuery(strSql);

	int  docno=0;
	//String id="";
	if(rs.next()) {
		docno=rs.getInt("doc_no");
					
  		} 
	response.getWriter().print(docno);

	stmt.close();
	conn.close();
 	}
	catch(Exception e){
		
			conn.close();
			
		} 
  
  %>
  
