<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.connection.ClsConnection"%>
<%@page import="com.operations.clientrelations.client.ClsClientDAO"%>
<%
String clientcldocno=request.getParameter("clientcldocno")==null?"":request.getParameter("clientcldocno");
String insurcldocno=request.getParameter("insurcldocno")==null?"":request.getParameter("insurcldocno");
String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
int errorstatus=0;
ClsConnection objconn=new ClsConnection();
Connection conn=null;
try{
	conn=objconn.getMyConnection();
	String sqltest="";
	if(!clientcldocno.equalsIgnoreCase("") && !clientcldocno.equalsIgnoreCase("undefined") && !clientcldocno.equalsIgnoreCase("null")){
		sqltest+="cldocno="+clientcldocno;
	}	
	if(!insurcldocno.equalsIgnoreCase("undefined") && !insurcldocno.equalsIgnoreCase("null")){
		int insurcomp=0;
		if(insurcldocno.trim().equalsIgnoreCase("")){
			insurcomp=0;
			insurcldocno="0";
		}
		else{
			insurcomp=1;
		}
		if(sqltest.equalsIgnoreCase("")){
			sqltest+="insurancecomp="+insurcomp+",insurcldocno="+insurcldocno;
		}
		else{
			sqltest+=",insurancecomp="+insurcomp+",insurcldocno="+insurcldocno;
		}
		
	}
	String strupdategip="update ws_gateinpass set "+sqltest+" where doc_no="+docno;
	System.out.println(strupdategip);
	conn=objconn.getMyConnection();
	int gipupdate=conn.createStatement().executeUpdate(strupdategip);
	if(gipupdate<=0){
		errorstatus=1;
	}
	conn.close();
}
catch(Exception e){
	e.printStackTrace();
	errorstatus=1;
	conn.close();
}
finally{
	conn.close();
}
response.getWriter().write(errorstatus+"");
%>