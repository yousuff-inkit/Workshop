<%@page import="com.common.ClsCommon"%>
<%@page import="java.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="javax.servlet.http.HttpSession"%>


<%	
ClsConnection ClsConnection=new ClsConnection();

ClsCommon ClsCommon=new ClsCommon();

Connection conn=null;
String process=request.getParameter("process")==null?"":request.getParameter("process");
String followupdate=request.getParameter("followupdate")==null?"":request.getParameter("followupdate");
String remarks=request.getParameter("remarks")==null?"":request.getParameter("remarks");
String bookdocno=request.getParameter("bookdocno")==null?"":request.getParameter("bookdocno");
String userid=session.getAttribute("USERID").toString();
try{
	conn=ClsConnection.getMyConnection();
	conn.setAutoCommit(false);
	Statement stmt=conn.createStatement();
	java.sql.Date sqldate=null;
	if(!followupdate.equalsIgnoreCase("")){
		sqldate=ClsCommon.changeStringtoSqlDate(followupdate);
	}
	int status=-1;
	if(process.equalsIgnoreCase("1")){
		//Follow-Up Status
		int val=stmt.executeUpdate("insert into gl_limobookfollowup(date,bookdocno,userid,followupdate,remarks)values(CURDATE(),"+bookdocno+","+userid+",'"+sqldate+"','"+remarks+"')");
		if(val<=0){
			/* response.getWriter().write("0"); */
			status=0;
			
		}
		else{
			int updateval=stmt.executeUpdate("update gl_limobookm set detailstatus=1 where doc_no="+bookdocno);
			if(updateval<=0){
				/* response.getWriter().write("0"); */
				status=0;
			}
		}
	}
	else if(process.equalsIgnoreCase("2")){
		//Confirmed Status
		int updateval=stmt.executeUpdate("update gl_limobookm set detailstatus=2 where doc_no="+bookdocno);
		if(updateval<=0){
			
			/* response.getWriter().write("0"); */
			status=0;
		}
		else{
			int updatetransferval=stmt.executeUpdate("update gl_limobooktransfer set masterstatus=2 where bookdocno="+bookdocno);
			int updatehoursval=stmt.executeUpdate("update gl_limobookhours set masterstatus=2 where bookdocno="+bookdocno);
		}
	}
	else if(process.equalsIgnoreCase("3")){
		//Dropped Status
		int updateval=stmt.executeUpdate("update gl_limobookm set detailstatus=3 where doc_no="+bookdocno);
		if(updateval<=0){
			/* response.getWriter().write("0"); */
			status=0;
		}
		else{
			int updatetransferval=stmt.executeUpdate("update gl_limobooktransfer set masterstatus=4 where bookdocno="+bookdocno);
			int updatehoursval=stmt.executeUpdate("update gl_limobookhours set masterstatus=4 where bookdocno="+bookdocno);
		}
	}
	if(status==0){
		response.getWriter().write("0");	
	}
	else{
		conn.commit();
		response.getWriter().write("1");
	}
	
	
}
catch(Exception e){
e.printStackTrace();
}
finally{
	conn.close();
}
%>