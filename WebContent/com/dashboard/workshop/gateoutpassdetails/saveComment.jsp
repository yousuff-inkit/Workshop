<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String comment=request.getParameter("comment")==null?"":request.getParameter("comment");
String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
ClsConnection objconn=new ClsConnection();
Connection conn=null;
String msg="";
try{
	conn=objconn.getMyConnection();
	conn.setAutoCommit(false);
	String userid=session.getAttribute("USERID").toString();
	Statement stmt=conn.createStatement();
	String strsql="insert into ws_comments(gipdocno,userid,msgdate,msg)values("+docno+","+userid+",now(),'"+comment+"')";
	int insertval=stmt.executeUpdate(strsql);
	
	if(insertval>0){
		conn.commit();
	}
	/* String strgetmsg="select usr.user_name,job.msg,date_format(job.msgdate,'%d.%m.%Y %H:%i') msgdate from ws_jobcardcomments job left join my_user usr on job.userid=usr.doc_no where job.status=3 and job.jobcarddocno="+jobcarddocno;
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
	} */
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(msg);
%>