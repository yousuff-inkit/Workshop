<%@page import="java.util.ArrayList"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.sql.*"%>
<%@page import="com.common.ClsCommon"%>
<%@page import="com.connection.ClsConnection"%>
<% 

ClsConnection connDAO = new ClsConnection();
ClsCommon commonDAO= new ClsCommon();
Connection conn=null;
java.sql.Date sqldate=null;
String estdocno=request.getParameter("estdocno")==null?"":request.getParameter("estdocno");
String brhid=request.getParameter("brhid")==null||request.getParameter("brhid").equalsIgnoreCase("")?"":request.getParameter("brhid");
JSONObject objdata=new JSONObject();
try{
	conn=connDAO.getMyConnection();
	Statement stmt = conn.createStatement ();
	ArrayList<String> estcountarray=new ArrayList();
	String strest="select count(*) from ws_estm where doc_no="+estdocno+" and brhid="+brhid;
	ResultSet rsest=stmt.executeQuery(strest);
	while(rsest.next()){
		estcountarray.add("0");
	}
	String strestadd="select addition from ws_estmadd where estdocno="+estdocno+" and brhid="+brhid;
	ResultSet rsestadd=stmt.executeQuery(strestadd);
	while(rsestadd.next()){
		estcountarray.add(rsestadd.getString("addition"));
	}
	
	objdata.put("estcountdata",estcountarray);
}catch(Exception e){
	e.printStackTrace();
	conn.close();
}
finally{
	conn.close();
}
response.getWriter().write(objdata+"");
%>