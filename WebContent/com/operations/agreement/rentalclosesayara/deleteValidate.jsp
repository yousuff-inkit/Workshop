<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%
String fleet=request.getParameter("fleet")==null?"0":request.getParameter("fleet");
String agreementno=request.getParameter("agmtno")==null?"0":request.getParameter("agmtno");
System.out.println("Parameters:"+fleet+"////"+agreementno); 	
Connection conn = null;
ClsConnection objconn=new ClsConnection();
 	try{
 		
 		conn=objconn.getMyConnection();
		Statement stmtmov = conn.createStatement ();
		int temprdocno=0;
		String temptype="";
		int maxdoc=0;
		int status=-1;
		String strmov="select max(doc_no) maxdoc from gl_vmove where fleet_no="+fleet;
		ResultSet rsmov=stmtmov.executeQuery(strmov);
		while(rsmov.next()){
			maxdoc=rsmov.getInt("maxdoc");
		}
		
		ResultSet rsmax=stmtmov.executeQuery("select rdocno,rdtype from gl_vmove where doc_no="+maxdoc+"");
		while(rsmax.next()){
			temptype=rsmax.getString("rdtype");
			temprdocno=rsmax.getInt("rdocno");
		}
		if(temptype.equalsIgnoreCase("RAG") && temprdocno==(Integer.parseInt(agreementno))){
			status=1;
		}
		else{
			status=0;
		}
		stmtmov.close();
	response.getWriter().write(status);
 	}
 	catch(Exception e){
 		e.printStackTrace();
 		
 	}
 	finally{
 		conn.close();
 	}
	%>
  
