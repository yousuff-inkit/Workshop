<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.sql.*"%>
<%@page import="com.connection.*"%>
<%
Connection conn=null;
JSONObject objdata=new JSONObject();
String gatedocno=request.getParameter("gatedocno")==null?"":request.getParameter("gatedocno");
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	//Checking if Insur Company Exists
	
	String strgetinsur="select insurcldocno from ws_gateinpass where doc_no="+gatedocno+" and status=3";
	ResultSet rsgetinsur=stmt.executeQuery(strgetinsur);
	int insurcldocno=0;
	while(rsgetinsur.next()){
		insurcldocno=rsgetinsur.getInt("insurcldocno");
	}
	String strgettax="select set_per,vat_per,inv.idno,inv.acno,inv.description from gl_taxdetail tax left join gl_invmode inv on tax.acidno=inv.idno where tax.status<>7 and curdate() between tax.fromdate and tax.todate";
	ResultSet rs=stmt.executeQuery(strgettax);
	double vatpercent=0.0;
	while(rs.next()){
		vatpercent=rs.getDouble("vat_per");
	}
	objdata.put("vatpercent",vatpercent);
	objdata.put("insurcldocno",insurcldocno);
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(objdata+"");
%>