<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String jobdocno=request.getParameter("jobdocno")==null?"":request.getParameter("jobdocno");
String baydata="";
ClsConnection objconn=new ClsConnection();
Connection conn=null;
try{
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	String strgetbays="select baydocno from ws_jobplanbay where jobdocno="+jobdocno;
	ResultSet rsgetbays=stmt.executeQuery(strgetbays);
	String bays="";
	int j=0;
	while(rsgetbays.next()){
		if(j==0){
			bays+=rsgetbays.getString("baydocno");
		}
		else{
			bays+=","+rsgetbays.getString("baydocno");
		}
		j++;
	}
	
	String strsql="";
	if(!bays.equalsIgnoreCase("")){
		strsql="select doc_no,name from ws_bay where status=3 and doc_no in ("+bays+")";
		ResultSet rs=stmt.executeQuery(strsql);
		int i=0;
		while(rs.next()){
			if(i==0){
				baydata=rs.getString("doc_no")+"::"+rs.getString("name");
			}
			else{
				baydata+=","+rs.getString("doc_no")+"::"+rs.getString("name");
			}
			i++;
		}
	}
	
	
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(baydata);
%>