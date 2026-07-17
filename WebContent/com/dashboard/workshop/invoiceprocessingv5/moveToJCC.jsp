<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.connection.*"%>
<%@page import="com.common.*"%>
<%@page import="java.sql.*"%>
<%
String jobdocno=request.getParameter("jobdocno")==null?"":request.getParameter("jobdocno");
String brhid=request.getParameter("brhid")==null?"":request.getParameter("brhid");
Connection conn=null;
ClsConnection objconn=new ClsConnection();
JSONObject objtemp=new JSONObject();
int errorstatus=0;
try{
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	//Deleting Saved Estimation Data
	int deleteestdata=stmt.executeUpdate("delete from ws_investdata where jobdocno="+jobdocno);
	if(deleteestdata<0){
		System.out.println("Estimate Data Delete Error");
		errorstatus=1;
	}
	
	//Deleting Calculated Invoice Data
	int deleteinvcalc=stmt.executeUpdate("delete from ws_invcalctemp where jobdocno="+jobdocno);
	if(deleteinvcalc<0){
		System.out.println("Calculated Invoice Delete Error");
		errorstatus=1;
	}
	
	//Updating Job Card as not complete
	int updatejobcomp=stmt.executeUpdate("update ws_jobcard set complete=0 where doc_no="+jobdocno);
	if(updatejobcomp<0){
		System.out.println("JobCard Complete Update Error");
		errorstatus=1;
	}
	
	//Updating Status in GIP
	int updategipstatus=stmt.executeUpdate("update ws_jobcard job left join ws_estm est on job.reftype='EST' and job.refno=est.doc_no left join ws_gateinpass gate on est.gipno=gate.doc_no set gate.processstatus=5 where job.doc_no="+jobdocno);
	if(updategipstatus<0){
		System.out.println("GIP Status Update Error");
		errorstatus=1;
	}
	//Keeping track of moved Job cards
	String userid=session.getAttribute("USERID")==null?"0":session.getAttribute("USERID").toString();
	PreparedStatement stmtlog=conn.prepareStatement("insert into gl_biblog(doc_no, brhId, dtype, edate, userId, userNo, activity, ENTRY) values (?,?,?,now(),?,?,?,?)");
	stmtlog.setInt(1,Integer.parseInt(jobdocno));
	stmtlog.setInt(2,Integer.parseInt(brhid));
	stmtlog.setString(3,"MJCC");
	stmtlog.setInt(4, Integer.parseInt(userid));
	stmtlog.setInt(5, 0);
	stmtlog.setInt(6, 0);
	stmtlog.setString(7, "A");
	int log=stmtlog.executeUpdate();

}
catch(Exception e){
	e.printStackTrace();
	errorstatus=1;
}
finally{
	conn.close();
}
objtemp.put("errorstatus",errorstatus);
response.getWriter().write(objtemp+"");
%>