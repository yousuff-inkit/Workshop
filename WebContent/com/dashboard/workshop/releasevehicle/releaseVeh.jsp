<%@page import="com.connection.*"%>
<%@page import="com.common.*"%>
<%@page import="java.sql.*"%>
<%
String jobcarddocno=request.getParameter("jobcarddocno")==null?"0":request.getParameter("jobcarddocno");
String gatedocno=request.getParameter("gatedocno")==null?"0":request.getParameter("gatedocno");
String releasestatus=request.getParameter("releasestatus")==null?"0":request.getParameter("releasestatus");
String reltype=request.getParameter("reltype")==null?"0":request.getParameter("reltype");
int errorstatus=0;
Connection conn=null;
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	conn.setAutoCommit(false);
	Statement stmt=conn.createStatement();
	int brhid=0,oldstatus=0;
	int maxdoc=0;
	String userid=session.getAttribute("USERID").toString();
	int floormgmtconfig=0;
	String strfloormgmtconfig="select method from gl_config where field_nme='floorMgmt'";
	ResultSet rsfloorconfig=stmt.executeQuery(strfloormgmtconfig);
	while(rsfloorconfig.next()){
		floormgmtconfig=rsfloorconfig.getInt("method");
	}
	
	if(releasestatus.equalsIgnoreCase("0")){
		String stroldstatus="select job.brhid,gate.processstatus from ws_jobcard job left join ws_estm est on"+
				" (job.reftype='EST' and job.refno=est.doc_no) left join ws_gateinpass gate on (est.gipno=gate.doc_no) where job.doc_no="+jobcarddocno;
				ResultSet rsoldstatus=stmt.executeQuery(stroldstatus);
				while(rsoldstatus.next()){
					brhid=rsoldstatus.getInt("brhid");
					oldstatus=rsoldstatus.getInt("processstatus");
				}
				String strupdategate="update ws_gateinpass set processstatus=10 where doc_no="+gatedocno;
				int updategate=stmt.executeUpdate(strupdategate);
				if(updategate<=0){
					errorstatus=1;
				}
				
				String strmaxdoc="select coalesce(max(doc_no)+1,1) maxdoc from ws_vehrelease";
				ResultSet rsmaxdoc=stmt.executeQuery(strmaxdoc);
				while(rsmaxdoc.next()){
					maxdoc=rsmaxdoc.getInt("maxdoc");
				}
				String strinsertmaster="insert into ws_vehrelease(doc_no, jobcarddocno, gatedocno, oldstatus, clstatus, brhid, userid,releasedate,releasetime,remarks)values("+
				""+maxdoc+","+jobcarddocno+","+gatedocno+","+oldstatus+",0,"+brhid+","+userid+",CURDATE(),date_format(now(),'%h:%i'),"+reltype+")";
				int insertmaster=stmt.executeUpdate(strinsertmaster);
				
				System.out.println("release vehicle insertion======="+strinsertmaster);
				
				
				if(insertmaster<=0){
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
					 errorstatus=1;
				 }	
				if(floormgmtconfig>0){
					String strupdatefloormgmt="update ws_floormgmtdata set completestatus=1 where jobdocno="+jobcarddocno;
					int updatefloormgmt=stmt.executeUpdate(strupdatefloormgmt);
					if(updatefloormgmt<=0){
						errorstatus=1;
					}
				}
	}
	else if(releasestatus.equalsIgnoreCase("1")){
		String stroldstatus="select oldstatus,brhid from ws_vehrelease where jobcarddocno="+jobcarddocno;
		ResultSet rsoldstatus=stmt.executeQuery(stroldstatus);
		while(rsoldstatus.next()){
			brhid=rsoldstatus.getInt("brhid");
			oldstatus=rsoldstatus.getInt("oldstatus");
		}
		String strupdategate="update ws_gateinpass set processstatus="+oldstatus+" where doc_no="+gatedocno;
		int updategate=stmt.executeUpdate(strupdategate);
		// System.out.println(updategate+"strupdategate ====== "+strupdategate);
		if(updategate<=0){
			errorstatus=1;
		}
		String strmaxdoc="select doc_no maxdoc from ws_vehrelease where jobcarddocno="+jobcarddocno;
		ResultSet rsmaxdoc=stmt.executeQuery(strmaxdoc);
		while(rsmaxdoc.next()){
			maxdoc=rsmaxdoc.getInt("maxdoc");
		}
		String strupdaterelease="update ws_vehrelease set clstatus=1 where gatedocno="+gatedocno;
		int updaterelease=stmt.executeUpdate(strupdaterelease);
		// System.out.println(updaterelease+" strupdategate ====== "+strupdaterelease );
		if(updaterelease<=0){
			errorstatus=1;
		}
		PreparedStatement stmtlog=conn.prepareStatement("insert into gl_biblog(doc_no, brhId, dtype, edate, userId, userNo, activity, ENTRY) values (?,?,?,now(),?,?,?,?)");
		 stmtlog.setInt(1,maxdoc);
		 stmtlog.setInt(2,brhid);
		 stmtlog.setString(3,"BWRV");
		 stmtlog.setString(4, userid);
		 stmtlog.setInt(5, 0);
		 stmtlog.setInt(6, 0);
		 stmtlog.setString(7, "E");
		 int log=stmtlog.executeUpdate();
		 if(log<=0){
			 errorstatus=1;
		 }
		 if(floormgmtconfig>0){
			String strupdatefloormgmt="update ws_floormgmtdata set completestatus=0 where jobdocno="+jobcarddocno;
			int updatefloormgmt=stmt.executeUpdate(strupdatefloormgmt);
			if(updatefloormgmt<=0){
				errorstatus=1;
			}
		}
	}
	
	 if(errorstatus==0){
		 conn.commit();
	 }
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
finally{
	conn.close();
}
response.getWriter().write(errorstatus+"");
%>