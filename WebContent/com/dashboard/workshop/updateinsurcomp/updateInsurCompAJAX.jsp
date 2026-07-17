<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String gatedocno=request.getParameter("gatedocno")==null?"":request.getParameter("gatedocno");
String insurcompdocno=request.getParameter("insurcompdocno")==null?"":request.getParameter("insurcompdocno");

Connection conn=null;
int errorstatus=0;
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	conn.setAutoCommit(false);
	String branchid=session.getAttribute("BRANCHID").toString();
	String userid=session.getAttribute("USERID").toString();
	Statement stmt=conn.createStatement();
	String strupdategate="update ws_gateinpass set insurancecomp=1,insurcldocno="+insurcompdocno+" where doc_no="+gatedocno;
	System.out.println(strupdategate);
	int updategate=stmt.executeUpdate(strupdategate);
	if(updategate<=0){
		errorstatus=1;
	}
	String strgetinsurcomp="select refname from my_acbook where cldocno="+insurcompdocno+" and dtype='CRM' and status=3";
	System.out.println(strgetinsurcomp);
	ResultSet rsgetinsurcomp=stmt.executeQuery(strgetinsurcomp);
	String insurcompany="";
	while(rsgetinsurcomp.next()){
		insurcompany=rsgetinsurcomp.getString("refname");
	}
	String strgetjobcard="select coalesce(job.doc_no,0) jobdocno from ws_jobcard job left join ws_estm est on job.reftype='EST' and "+
	" job.refno=est.doc_no left join ws_gateinpass gate on est.gipno=gate.doc_no where gate.doc_no="+gatedocno;
	System.out.println(strgetjobcard);
	int jobdocno=0;
	ResultSet rsgetjobdocno=stmt.executeQuery(strgetjobcard);
	while(rsgetjobdocno.next()){
		jobdocno=rsgetjobdocno.getInt("jobdocno");
	}
	if(jobdocno>0){
		String strupdatefloormgmt="update ws_floormgmtdata set billto='"+insurcompany+"' where jobdocno="+jobdocno;
		System.out.println(strupdatefloormgmt);
		int updatefloormgmt=stmt.executeUpdate(strupdatefloormgmt);
		if(updatefloormgmt<=0){
			errorstatus=1;
		}
	}
	String strloginsert="insert into gl_biblog(doc_no, brhId, dtype, edate, userId,ENTRY)values("+gatedocno+","+branchid+",'BWUI',now(),"+userid+",'A')";
	System.out.println(strloginsert);
	int loginsert=stmt.executeUpdate(strloginsert);
	if(loginsert<=0){
		errorstatus=1;
	}
	if(errorstatus==0){
		conn.commit();
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