<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String employee=request.getParameter("employee")==null?"":request.getParameter("employee");
String jobcard=request.getParameter("jobcard")==null?"":request.getParameter("jobcard");
String activedetails="";
ClsConnection objconn=new ClsConnection();
Connection conn=null;
try{
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	
	String strsql="";
	if(!employee.equalsIgnoreCase("")){
		String strgetjobno="select voc_no,doc_no from ws_jobcard where voc_no="+jobcard;
		ResultSet rsgetjobno=stmt.executeQuery(strgetjobno);
		int jobdocno=0,jobvocno=0;
		while(rsgetjobno.next()){
			jobdocno=rsgetjobno.getInt("doc_no");
			jobvocno=rsgetjobno.getInt("voc_no");
		}
		strsql="select date_format(startdate,'%d.%m.%Y') startdate,starttime from ws_clockin where closedate is null and jcno="+jobdocno+" and technicianid="+employee;
		ResultSet rs=stmt.executeQuery(strsql);
		while(rs.next()){
			activedetails="Started on "+rs.getString("startdate")+" "+rs.getString("starttime");
		}		
	}
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(activedetails);
%>