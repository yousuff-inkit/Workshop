<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String modelid=request.getParameter("modelid")==null?"":request.getParameter("modelid");
Connection conn=null;
ClsConnection objconn=new ClsConnection();
String group="";
try{
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	String strsql="select coalesce(grp.gname,'') gname from gl_vehmodel model left join gl_vehgroup grp on model.groupid=grp.doc_no where model.doc_no="+modelid;
	ResultSet rs=stmt.executeQuery(strsql);
	while(rs.next()){
		group=rs.getString("gname");
	}
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(group);
%>