<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String gatedocno=request.getParameter("gatedocno")==null?"":request.getParameter("gatedocno");
String assessmentno=request.getParameter("assessmentno")==null?"":request.getParameter("assessmentno");
Connection conn=null;
ClsConnection objconn=new ClsConnection();
int errorstatus=0;
try{
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	String strupdate="update ws_gateinpass set assessmentno='"+assessmentno+"' where doc_no="+gatedocno; 
	System.out.println("Update Query:"+strupdate);
	int updateval=stmt.executeUpdate(strupdate);
	if(updateval<0){
		errorstatus=1;
	}
	else{
		errorstatus=0;
	}
	
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(errorstatus+"");
%>