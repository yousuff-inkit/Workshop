<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	
Connection conn = null;
ClsConnection ClsConnection=new ClsConnection();
int errorstatus=0;

try{
	conn=ClsConnection.getMyConnection();
	conn.setAutoCommit(false);
	
	String docno = request.getParameter("docno");
	Statement stmt = conn.createStatement ();
	
	String sqljc="update ws_jobcard set complete=1 where doc_no="+docno;
	
	int jc=stmt.executeUpdate(sqljc);
	
	Integer userid= (Integer) session.getAttribute("USERID");
	String brhid = request.getParameter("brhid");
	
	String sqljcc = "insert into ws_jobcardcomp(jobcardno, userid, brhid, date) values (?,?,?,date(now()))";
	PreparedStatement prestmt = conn.prepareStatement(sqljcc);
	prestmt.setInt(1, Integer.parseInt(docno));
	prestmt.setInt(2, userid);
	prestmt.setInt(3, Integer.parseInt(brhid));
	
	int jcc=prestmt.executeUpdate();
	
	Statement stmtgate=conn.createStatement();
	int g = stmtgate.executeUpdate("update ws_jobcard jc left join ws_estm es on (jc.refno=es.doc_no and jc.reftype='EST')"+
			"left join ws_gateinpass gp on((jc.refno=gp.doc_no and jc.reftype='GIP') or (es.gipno=gp.doc_no and jc.reftype='EST'))"+
			"set gp.processstatus=6 where jc.doc_no="+docno);

	
	if((jc<=0)||(jcc<=0)||(g<=0)){
		errorstatus = 1;
	}
	 if(errorstatus==0){
		 
		 ResultSet resultSet = stmt.executeQuery("select max(srno) from ws_jobcardcomp");
		 int logdocno=0;
		 while(resultSet.next()){
			 logdocno=resultSet.getInt(1);
		 }
		 
		
		 
		 
		 PreparedStatement stmtlog=conn.prepareStatement("insert into gl_biblog(doc_no, brhId, dtype, edate, userId, userNo, activity, ENTRY) values (?,?,?,now(),?,?,?,?)");
		 stmtlog.setInt(1,logdocno);
		 stmtlog.setInt(2,Integer.parseInt(brhid));
		 stmtlog.setString(3,"BWJC");
		 stmtlog.setInt(4, userid);
		 stmtlog.setInt(5, 0);
		 stmtlog.setInt(6, 0);
		 stmtlog.setString(7, "A");
		 int log=stmtlog.executeUpdate();
		 
		 if(log>0)
		 		 conn.commit();
		 else
		 {
			conn.rollback();
		 	errorstatus=1;
		 }
	 }
	 conn.close();
// 	 System.out.println("%%%%%%%%%%%%%"+errorstatus+"%%%%%%%%%%%%%");

}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
finally{
	conn.close();
}
out.print(errorstatus);
// response.getWriter().write(errorstatus);
%>