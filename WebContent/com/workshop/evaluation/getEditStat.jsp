<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%
    String masterdoc=request.getParameter("masterdoc")==null?"0":request.getParameter("masterdoc");
    Connection conn = null;  
	ResultSet rs =null;
	Statement stmt =null;
try{	
	ClsConnection ClsConnection=new ClsConnection();    
	conn= ClsConnection.getMyConnection();  
	 stmt = conn.createStatement ();  
	int val=0,invtrno=0;
	 String strSql = "select coalesce(invtrno,0) invtrno from ws_evalm where status=3 and doc_no='"+masterdoc+"'";        
	//System.out.println("strsql--->>>"+strSql);
	 rs = stmt.executeQuery(strSql);         
	while(rs.next()) {         
		invtrno=rs.getInt("invtrno");
  		}       
	if(invtrno>0){     
		val=1;
	}
	stmt.close();
	conn.close();  

	response.getWriter().print(val);        
}
catch(Exception e){
	e.printStackTrace();    
	conn.close();
}finally {
    if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
    if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}  // added by sud  
    if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
}
	%>