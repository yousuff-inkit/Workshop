<%@page import="java.sql.Statement"%>
<%@page import="com.connection.ClsConnection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.sql.Connection"%>
<%
Connection conn=null;
JSONObject data =new JSONObject();
String brhid=request.getParameter("brhid")==null?"":request.getParameter("brhid").toString().trim();
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	String sqlfilters="";
	if(!brhid.equalsIgnoreCase("") && !brhid.equalsIgnoreCase("undefined") && !brhid.equalsIgnoreCase("a")){
		sqlfilters+=" and gate.brhid="+brhid;
	}
	String strgetcountdata="SELECT (SELECT COUNT(*)  FROM ws_gateinpass gate LEFT JOIN ws_gipmatreqm mat ON gate.doc_no=mat.gipdocno "+
	" WHERE gate.processstatus=1 AND COALESCE(mat.doc_no,0)=0 "+sqlfilters+") matreqpending,"+
	" (SELECT COUNT(*)  FROM ws_gateinpass gate LEFT JOIN ws_gipmatreqm mat ON gate.doc_no=mat.gipdocno"+ 
	" WHERE gate.processstatus=1 AND COALESCE(mat.techapproval,0)=0 "+sqlfilters+") techpending,"+
	" (SELECT COUNT(*)  FROM ws_gateinpass gate LEFT JOIN ws_gipmatreqm mat ON gate.doc_no=mat.gipdocno"+
	" WHERE gate.processstatus=1 AND COALESCE(mat.finapproval,0)=0 "+sqlfilters+") finpending";
	ResultSet rscountdata=stmt.executeQuery(strgetcountdata);
	int matreqpending=0,techpending=0,finpending=0;
	while(rscountdata.next()){
		matreqpending=rscountdata.getInt("matreqpending");
		techpending=rscountdata.getInt("techpending");
		finpending=rscountdata.getInt("finpending");
	}
	data.put("matreqpending",matreqpending);
	data.put("techpending",techpending);
	data.put("finpending",finpending);
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(data+"");
%>