<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.Statement"%>
<%@page import="com.connection.ClsConnection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.sql.Connection"%>
<%
Connection conn=null;
JSONObject data =new JSONObject();
String matreqdocno=request.getParameter("matreqdocno")==null?"":request.getParameter("matreqdocno");
String apprmode=request.getParameter("apprmode")==null?"":request.getParameter("apprmode");
String desc=request.getParameter("desc")==null?"":request.getParameter("desc");

int errorstatus=0;
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	conn.setAutoCommit(false);
	Statement stmt=conn.createStatement();
	String errormsg="";
	String userid=session.getAttribute("USERID")==null?"":session.getAttribute("USERID").toString();
	if(apprmode.equalsIgnoreCase("T")){
		String strupdate="update ws_gipmatreqm set techapproval=1,techdate=now(),techdesc='"+desc+"',techuserid="+userid+" where doc_no="+matreqdocno;
		System.out.println(strupdate);
		int update=stmt.executeUpdate(strupdate);
		if(update<=0){
			errorstatus=1;
			System.out.println("Tech Approval Update Error");
		}
		else{
			errormsg="Document Technical Approved";
		}
		
	}
	if(apprmode.equalsIgnoreCase("F")){
		String strupdate="update ws_gipmatreqm set finapproval=1,findate=now(),findesc='"+desc+"',finuserid="+userid+" where doc_no="+matreqdocno;
		System.out.println(strupdate);
		int update=stmt.executeUpdate(strupdate);
		if(update<=0){
			errorstatus=1;
			System.out.println("Fin Approval Update Error");
		}
		else{
			errormsg="Document Financial Approved";
		}
	}
	if(errorstatus==0){
		conn.commit();
	}
	data.put("errorstatus",errorstatus);
	data.put("errormsg",errormsg);
	System.out.println(errormsg);
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(data+"");
%>