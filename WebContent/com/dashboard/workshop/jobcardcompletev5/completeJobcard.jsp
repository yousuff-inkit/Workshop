<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.sms.*" %>
<%@page import="javax.servlet.http.HttpServletRequest.*" %>
<%@page import="javax.servlet.http.HttpSession.*" %>

<%	
Connection conn = null;
ClsConnection ClsConnection=new ClsConnection();
int errorstatus=0;

try{
	conn=ClsConnection.getMyConnection();
	conn.setAutoCommit(false);
	
	String docno = request.getParameter("docno");
	String skipinvoice=request.getParameter("skipinvoice")==null?"0":request.getParameter("skipinvoice");
	Statement stmt = conn.createStatement ();
	int savestatus=0;
	String strchecksavestatus="select savestatus from ws_jobcard where doc_no="+docno;
	ResultSet rschecksavestatus=stmt.executeQuery(strchecksavestatus);
	while(rschecksavestatus.next()){
		savestatus=rschecksavestatus.getInt("savestatus");
	}
	if(savestatus==0){
		errorstatus=2;
	}
	String strsql="select (select count(*) from ws_jobcard job left join ws_estm est on (job.reftype='EST' and job.refno=est.doc_no) left join ws_estlabour lab on est.doc_no=lab.rdocno where lab.confirmed=0 and job.doc_no="+docno+" group by lab.rdocno) pendingconfirm,"+
	" (select count(*) from ws_jobcard job left join ws_estm est on (job.reftype='EST' and job.refno=est.doc_no) left join ws_estlabour lab on est.doc_no=lab.rdocno where lab.approved=0 and job.doc_no="+docno+" group by lab.rdocno) pendingapproval";
	ResultSet rs=stmt.executeQuery(strsql);
	int pendingconfirm=0,pendingapproval=0;
	while(rs.next()){
		pendingconfirm=rs.getInt("pendingconfirm");
		pendingapproval=rs.getInt("pendingapproval");
	}
	/*
	pendingapproval>0 || 
	commented above clause from if condition for Autohub.
	They maay enter it without approving everything
	*/
	if(pendingconfirm>0){
		errorstatus=1;
	}
	if(savestatus==1){
		
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
		int processstatus=0;
		if(skipinvoice.equalsIgnoreCase("1")){
			processstatus=7;
		}
		else{
			processstatus=6;
		}
		int g = stmtgate.executeUpdate("update ws_jobcard jc left join ws_estm es on (jc.refno=es.doc_no and jc.reftype='EST')"+
				"left join ws_gateinpass gp on((jc.refno=gp.doc_no and jc.reftype='GIP') or (es.gipno=gp.doc_no and jc.reftype='EST'))"+
				"set gp.processstatus="+processstatus+" where jc.doc_no="+docno);

		
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
			 
			 if(log>0){
				SmsAction smsaction=new SmsAction();
				 String strgetsmsdetails="select ac.cldocno,date_format(CURDATE(),'%d.%m.%Y') smsdate,gp.brhid,ac.refname,ac.per_mob from ws_jobcard jc left join ws_estm es on (jc.refno=es.doc_no and "+
				 " jc.reftype='EST') left join ws_gateinpass gp on((jc.refno=gp.doc_no and jc.reftype='GIP') or (es.gipno=gp.doc_no and jc.reftype='EST'))"+
				 " left join my_acbook ac on ((gp.cldocno=ac.cldocno and ac.dtype='CRM') or (gp.insurcldocno=ac.cldocno and ac.dtype='VND'))"+
				 " where jc.doc_no="+docno;
				 ResultSet rssmsdetails=stmt.executeQuery(strgetsmsdetails);
				 String phone="",clname="",smsdate="",cldocno="";
				 
				 while(rssmsdetails.next()){
					 smsdate=rssmsdetails.getString("smsdate");
					 phone=rssmsdetails.getString("per_mob");
					 clname=rssmsdetails.getString("refname");
					 cldocno=rssmsdetails.getString("cldocno");
				 }
				 String status="0";
	// smsaction.doSendSms(session, phone, clname, cldocno, "0.0", docno, smsdate, "JCC", brhid, conn);
						 //(phone, clname, "0.0", docno, smsdate, "JCC", brhid, conn);
				conn.commit();
			 }
					 
			 else
			 {
				conn.rollback();
				errorstatus=1;
			 }
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