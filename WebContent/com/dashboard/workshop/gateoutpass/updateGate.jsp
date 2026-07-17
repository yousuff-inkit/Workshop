<%@page import="java.sql.*"%>
<%@page import="com.common.ClsCommon"%>
<%@page import="com.connection.ClsConnection"%>
<% 

ClsConnection connDAO = new ClsConnection();
ClsCommon commonDAO= new ClsCommon();
Connection conn=null;
java.sql.Date sqldate=null;
String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
String kilometer=request.getParameter("kilometer")==null||request.getParameter("kilometer").equalsIgnoreCase("")?"0":request.getParameter("kilometer");
String fuel=request.getParameter("fuel")==null||request.getParameter("fuel").equalsIgnoreCase("")?"0":request.getParameter("fuel");
String date=request.getParameter("date")==null||request.getParameter("date").equalsIgnoreCase("")?"0":request.getParameter("date");
String time=request.getParameter("time")==null||request.getParameter("time").equalsIgnoreCase("")?"0":request.getParameter("time");
String driver=request.getParameter("driver")==null?"":request.getParameter("driver");    
sqldate=commonDAO.changeStringtoSqlDate(date);
Integer userid=(Integer) session.getAttribute("USERID");
int errorstatus=0; 
int x=0;
try{
	 conn=connDAO.getMyConnection();
	 conn.setAutoCommit(false);
	 	
		Statement stmt = conn.createStatement ();
		
		String strSql1 = "update ws_gateinpass set outkm=?,outfuel=?,outtime=?,outdate=?,processstatus=8,driver=? where doc_no=?";
		
		PreparedStatement ps=conn.prepareStatement(strSql1);	
		ps.setString(1, kilometer);
		ps.setString(2, fuel);
		ps.setString(3, time);
		ps.setDate(4, sqldate);
		ps.setString(5, driver);
		ps.setString(6, docno);  
	    x=ps.executeUpdate();

		if(x<=0){
			errorstatus=1;
		}
		int floormgmtconfig=0;
		String strfloormgmtconfig="select method from gl_config where field_nme='floorMgmt'";
		ResultSet rsfloorconfig=stmt.executeQuery(strfloormgmtconfig);
		while(rsfloorconfig.next()){
			floormgmtconfig=rsfloorconfig.getInt("method");
		}
		
		if(floormgmtconfig>0){
			String strgetjobdocno="select jc.doc_no from ws_jobcard jc left join ws_estm es on (jc.refno=es.doc_no and jc.reftype='EST')"+
			" left join ws_gateinpass gp on((jc.refno=gp.doc_no and jc.reftype='GIP') or (es.gipno=gp.doc_no and jc.reftype='EST'))"+
			" where gp.doc_no="+docno;
			int jobdocno=0;
			ResultSet rsjobdocno=stmt.executeQuery(strgetjobdocno);
			while(rsjobdocno.next()){
				jobdocno=rsjobdocno.getInt("doc_no");
			}
			String strupdatefloormgmt="update ws_floormgmtdata set completestatus=1 where jobdocno="+jobdocno;
			int updatefloormgmt=stmt.executeUpdate(strupdatefloormgmt);
			if(updatefloormgmt<=0){
				errorstatus=1;
			}
		}
		if(errorstatus==0){
			conn.commit();
		}
}catch(Exception e){
	e.printStackTrace();
	conn.close();
}
finally{
	conn.close();
}
response.getWriter().write(errorstatus+"");
%>