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
	
	//System.out.println("docno=="+docno);
	
	Statement stmt = conn.createStatement();
	
	String sqllabour="update ws_estlabour set confirmed=1 where rdocno="+docno;
	String sqlspare="update ws_estspare set confirmed=1 where rdocno="+docno;
	
	int l=stmt.executeUpdate(sqllabour);
	int s=stmt.executeUpdate(sqlspare);
	
	Integer userid= (Integer) session.getAttribute("USERID");
	String brhid = request.getParameter("brhid");
	
	String sqlconfirm = "insert into ws_estconfirm(estno, userid, brhid, date) values (?,?,?,date(now()))";
	PreparedStatement prestmt = conn.prepareStatement(sqlconfirm);
	prestmt.setInt(1, Integer.parseInt(docno));
	prestmt.setInt(2, userid);
	prestmt.setInt(3, Integer.parseInt(brhid));
	
	int c=prestmt.executeUpdate();
	Statement stmtgate=conn.createStatement();
	int g = stmtgate.executeUpdate("update ws_gateinpass gip inner join ws_estm est on  est.gipno=gip.doc_no set gip.processstatus=3 where est.doc_no="+docno);
	
	if((l<=0) ||(c<=0)||g<=0){
		errorstatus = 1;
	}
	
	
	
	String labaddition = request.getParameter("labaddition");
	
	System.out.println("labaddition=="+labaddition);
	
	String insuretype = request.getParameter("insuretype");
	
	System.out.println("insuretype=="+insuretype);
	
	
	if(labaddition.equalsIgnoreCase("0")){
		
		String sqlinsuretype1="update ws_estm set insurtype="+insuretype+" where doc_no="+docno;
		
		int instype1=stmt.executeUpdate(sqlinsuretype1);
		
		if(instype1<=0){
			errorstatus=1;
		}
	}
	
	else {
		
		String sqlinsuretype2="update ws_estmadd set insurtype="+insuretype+" where doc_no="+docno;
		
		int instype2=stmt.executeUpdate(sqlinsuretype2);
		
		if(instype2<=0){
			errorstatus=1;
		}
	}
	
	
	
	
	
	
	
	
	
	
	
	
	

	
	
	 if(errorstatus==0){
		 
		 ResultSet resultSet = stmt.executeQuery("select max(rowno) from ws_estconfirm");
		 int logdocno=0;
		 while(resultSet.next()){
			 logdocno=resultSet.getInt(1);
		 }
		 
		
		 
		 
		 PreparedStatement stmtlog=conn.prepareStatement("insert into gl_biblog(doc_no, brhId, dtype, edate, userId, userNo, activity, ENTRY) values (?,?,?,now(),?,?,?,?)");
		 stmtlog.setInt(1,logdocno);
		 stmtlog.setInt(2,Integer.parseInt(brhid));
		 stmtlog.setString(3,"BWEC");
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