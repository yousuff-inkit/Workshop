<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
ClsConnection objconn=new ClsConnection();
Connection conn=null;
String msg="";
try{
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	String strgetmsg="select usr.user_name,job.msg,date_format(job.msgdate,'%d.%m.%Y %H:%i') msgdate from ws_comments job left join my_user usr on job.userid=usr.doc_no where job.status=3 and job.gipdocno="+docno+" order by rowno desc";
	ResultSet rs=stmt.executeQuery(strgetmsg);
	int i=0;
	while(rs.next()){
		if(i==0){
			msg=rs.getString("msg")+"::"+rs.getString("msgdate")+"::"+rs.getString("user_name");
		}
		else{
			msg+=","+rs.getString("msg")+"::"+rs.getString("msgdate")+"::"+rs.getString("user_name");
		}
		i++;
	}
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(msg);
%>