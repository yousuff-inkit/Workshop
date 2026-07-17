<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
Connection conn=null;
String jobdocno=request.getParameter("jobdocno")==null?"":request.getParameter("jobdocno");
JSONObject objdata=new JSONObject();
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	int invno=0,invbrhid=0;
	ResultSet rs=conn.createStatement().executeQuery("select inv.brhid invbrhid,calc.invno from ws_invcalctemp calc left join my_head head on calc.billtoacno=head.doc_no left join ws_invm inv on inv.doc_no=calc.invno where jobdocno="+jobdocno);
	while(rs.next()){
		invno=rs.getInt("invno");
		invbrhid=rs.getInt("invbrhid");
	}	
	objdata.put("invno",invno);
	objdata.put("invbrhid",invbrhid);
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(objdata+"");
%>
