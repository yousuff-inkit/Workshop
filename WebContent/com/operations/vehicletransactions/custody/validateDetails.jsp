<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="javax.servlet.http.HttpSession.*"%>
 <%@page import="com.operations.vehicletransactions.custody.ClsCustodyDAO" %>
 <%
 ClsCustodyDAO viewDAO= new ClsCustodyDAO();
 
Connection conn=null;
ClsConnection connDAO= new ClsConnection();
try{
	conn=connDAO.getMyConnection();
	String fleetno=request.getParameter("fleetno");
      	Statement stmt1 = conn.createStatement ();
      	String strSql1 = "select  Status from gl_vmove where doc_no=(select max(doc_no) from gl_vmove where fleet_no='"+fleetno+"')";
    	ResultSet rs1 = stmt1.executeQuery(strSql1); 	
      	String Status="";
    	if(rs1.next()) {
    	 
    		Status=rs1.getString("Status");;
      		}
if(Status.equalsIgnoreCase("OUT")){
	stmt1.close();
	conn.close();
	response.getWriter().write("OUT");
	
}
else
{
	

 	
	Statement stmt = conn.createStatement ();
	String strSql = "select  din,tin,round(kmin) kmin from gl_vmove where doc_no=(select max(doc_no) from gl_vmove where fleet_no='"+fleetno+"' and status='IN')";
	ResultSet rs = stmt.executeQuery(strSql);
	String tempval="";

	if(rs.next()) {
		tempval=rs.getString("din")+","+rs.getString("tin")+","+rs.getString("kmin");		
		
  		} 
	// loc=loc.substring(0, loc.length()-1);
	stmt.close();
	conn.close();
	response.getWriter().write(tempval);
	//System.out.println("Location:"+loc+"***"+id);
}
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
  %>