<%@page import="java.sql.*"%>
<%@page import="com.common.ClsCommon"%>
<%@page import="com.connection.ClsConnection"%>
<% 

ClsConnection connDAO = new ClsConnection();
ClsCommon commonDAO= new ClsCommon();
Connection conn=null;
java.sql.Date sqldate=null;
String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
String kilometer=request.getParameter("gopkm")==null||request.getParameter("gopkm").equalsIgnoreCase("")?"0":request.getParameter("gopkm");
String fuel=request.getParameter("gopfuel")==null||request.getParameter("gopfuel").equalsIgnoreCase("")?"0":request.getParameter("gopfuel");
String date=request.getParameter("gopdate")==null||request.getParameter("gopdate").equalsIgnoreCase("")?"0":request.getParameter("gopdate");
String time=request.getParameter("goptime")==null||request.getParameter("goptime").equalsIgnoreCase("")?"0":request.getParameter("goptime");
String brhid=request.getParameter("brhid")==null||request.getParameter("brhid").equalsIgnoreCase("")?"0":request.getParameter("brhid");
sqldate=commonDAO.changeStringtoSqlDate(date);
Integer userid=(Integer) session.getAttribute("USERID");
int errorstatus=0; 
int x=0;
try{
	System.out.println("Inside GOP");
	 conn=connDAO.getMyConnection();
	 conn.setAutoCommit(false);
	 	
		Statement stmt = conn.createStatement ();
		
		String strSql1 = "update ws_gateinpass set outkm=?,outfuel=?,outtime=?,outdate=?,processstatus=8 where doc_no=?";
		
		PreparedStatement ps=conn.prepareStatement(strSql1);	
		ps.setString(1, kilometer);
		ps.setString(2, fuel);
		ps.setString(3, time);
		ps.setDate(4, sqldate);
		ps.setString(5, docno);
		
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