<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
	String gatedocno=request.getParameter("gatedocno")==null?"":request.getParameter("gatedocno");
	System.out.println("Gate Doc:"+gatedocno);	
Connection conn=null;
	ClsConnection objconn=new ClsConnection();
	int errorstatus=0;
	try{
		conn=objconn.getMyConnection();
		conn.setAutoCommit(false);
		Statement stmt=conn.createStatement();
		int brhid=0,oldstatus=0;
		int maxdoc=0;
		int jobcarddocno=0;
		String userid=session.getAttribute("USERID").toString();
		int floormgmtconfig=0;
		String strfloormgmtconfig="select method from gl_config where field_nme='floorMgmt'";
		ResultSet rsfloorconfig=stmt.executeQuery(strfloormgmtconfig);
		while(rsfloorconfig.next()){
			floormgmtconfig=rsfloorconfig.getInt("method");
		}
		String stroldstatus="select job.brhid,gate.processstatus,job.doc_no jobcarddocno from ws_jobcard job left join ws_estm est on"+
		" (job.reftype='EST' and job.refno=est.doc_no) left join ws_gateinpass gate on (est.gipno=gate.doc_no) where gate.doc_no="+gatedocno;
		System.out.println(stroldstatus);
		ResultSet rsoldstatus=stmt.executeQuery(stroldstatus);
		while(rsoldstatus.next()){
			brhid=rsoldstatus.getInt("brhid");
			oldstatus=rsoldstatus.getInt("processstatus");
			jobcarddocno=rsoldstatus.getInt("jobcarddocno");
		}
		String strupdategate="update ws_gateinpass set processstatus=10 where doc_no="+gatedocno;
		System.out.println(strupdategate);
		int updategate=stmt.executeUpdate(strupdategate);
		if(updategate<=0){
			System.out.println("GIP update error");
			errorstatus=1;
		}
		
		String strmaxdoc="select coalesce(max(doc_no)+1,1) maxdoc from ws_vehrelease";
		ResultSet rsmaxdoc=stmt.executeQuery(strmaxdoc);
		while(rsmaxdoc.next()){
			maxdoc=rsmaxdoc.getInt("maxdoc");
		}
		String strinsertmaster="insert into ws_vehrelease(doc_no, jobcarddocno, gatedocno, oldstatus, clstatus, brhid, userid,releasedate,releasetime,remarks)values("+
		""+maxdoc+","+jobcarddocno+","+gatedocno+","+oldstatus+",0,"+brhid+","+userid+",CURDATE(),date_format(now(),'%h:%i'),1)";
		int insertmaster=stmt.executeUpdate(strinsertmaster);
		
		System.out.println("release vehicle insertion======="+strinsertmaster);
		
		
		if(insertmaster<=0){
			System.out.println("Release Insert error");
			errorstatus=1;
		}
		PreparedStatement stmtlog=conn.prepareStatement("insert into gl_biblog(doc_no, brhId, dtype, edate, userId, userNo, activity, ENTRY) values (?,?,?,now(),?,?,?,?)");
		 stmtlog.setInt(1,maxdoc);
		 stmtlog.setInt(2,brhid);
		 stmtlog.setString(3,"BWRV");
		 stmtlog.setString(4, userid);
		 stmtlog.setInt(5, 0);
		 stmtlog.setInt(6, 0);
		 stmtlog.setString(7, "A");
		 int log=stmtlog.executeUpdate();
		 if(log<=0){
			 System.out.println("Log Insert error");
			 errorstatus=1;
		 }	
		if(floormgmtconfig>0){
			String strupdatefloormgmt="update ws_floormgmtdata set completestatus=1 where jobdocno="+jobcarddocno;
			int updatefloormgmt=stmt.executeUpdate(strupdatefloormgmt);
			if(updatefloormgmt<=0){
				System.out.println("Floor Mgmt update error");
				errorstatus=1;
			}
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