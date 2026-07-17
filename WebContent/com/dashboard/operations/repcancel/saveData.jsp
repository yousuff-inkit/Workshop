<%@page import="com.common.ClsCommon"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%
ClsConnection ClsConnection=new ClsConnection();

ClsCommon ClsCommon=new ClsCommon();

	String repno=request.getParameter("repno")==null?"":request.getParameter("repno");
	String cancelbranch=request.getParameter("cancelbranch")==null?"":request.getParameter("cancelbranch");
	String cancelloc=request.getParameter("cancelloc")==null?"":request.getParameter("cancelloc");
	String canceldate=request.getParameter("canceldate")==null?"":request.getParameter("canceldate");
	String canceltime=request.getParameter("canceltime")==null?"":request.getParameter("canceltime");
	String cancelkm=request.getParameter("cancelkm")==null?"":request.getParameter("cancelkm");
	String cancelfuel=request.getParameter("cancelfuel")==null?"":request.getParameter("cancelfuel");
	String fleetno=request.getParameter("fleet_no")==null?"":request.getParameter("fleet_no");
 	Connection conn = null;
 	try{
 		java.sql.Date sqlcanceldate=null;
 		if(!canceldate.equalsIgnoreCase("")){
 			sqlcanceldate=ClsCommon.changeStringtoSqlDate(canceldate);
 		}
 		conn=ClsConnection.getMyConnection();
 		conn.setAutoCommit(false);
		Statement stmt=conn.createStatement();
		String strSql = "update gl_vehreplace set indate='"+sqlcanceldate+"',intime='"+canceltime+"',inkm="+cancelkm+",infuel="+cancelfuel+",inbrhid="+cancelbranch+""+
						" ,inloc="+cancelloc+",closestatus=1,cancelstatus=1 where doc_no="+repno;
		int val=stmt.executeUpdate(strSql);
		
		Statement stmt1=conn.createStatement();
		String rfleetno="",rdocno="",rtype=""; 
		String strSql1 = "select  rdocno,rtype,rfleetno from gl_vehreplace where doc_no="+repno;
		ResultSet rs= stmt1.executeQuery(strSql1);
		while(rs.next()){
			rfleetno=rs.getString("rfleetno");
			rtype=rs.getString("rtype");
			rdocno=rs.getString("rdocno");
		}
		
		Statement stmt2=conn.createStatement();
		if(rtype.equalsIgnoreCase("RAG")){
			String strSql2 = "update gl_ragmt set fleet_no='"+rfleetno+"' where doc_no="+rdocno;
		}else {
				String strSql2 = "update gl_lagmt set tmpfleet='"+rfleetno+"' where doc_no="+rdocno;
			}
		int val2=stmt.executeUpdate(strSql);
		
		
		int vehval=0;
		if(val>0){
			String strupdateveh="update gl_vehmaster set tran_code='RR',status='IN' where fleet_no="+fleetno;
			vehval=stmt.executeUpdate(strupdateveh);
			if(vehval>0){
				conn.commit();
			}
			
		}
		else{
			stmt.close();		
		}

		response.getWriter().print(vehval);
 	}
 	catch(Exception e){
 		e.printStackTrace();
 	}
 	finally{
 		conn.close();
 	}
	%>
