<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*" %>
<%@page import="java.sql.*" %>
<%
	Connection conn=null;
	ClsConnection objconn=new ClsConnection();
	JSONObject objdata=new JSONObject();
	int errorstatus=0;
	try{
		String jobdocno=request.getParameter("jobdocno")==null?"":request.getParameter("jobdocno").toString();
		String techdocno=request.getParameter("techdocno")==null?"":request.getParameter("techdocno").toString();
		String techhrs=request.getParameter("techhrs")==null?"":request.getParameter("techhrs").toString();
		String remarks=request.getParameter("remarks")==null?"":request.getParameter("remarks").toString();
		
		conn=objconn.getMyConnection();
		Statement stmt=conn.createStatement();
		conn.setAutoCommit(false);
		String userid=session.getAttribute("USERID")==null?"0":session.getAttribute("USERID").toString();
		int estmins=(Integer.parseInt(techhrs.split(":")[0])*60)+(Integer.parseInt(techhrs.split(":")[1]));
		
		String strsql="insert into ws_floortech(jobdocno,techdocno,remarks,esthrs,status,userid,date,estmins)values("+jobdocno+","+techdocno+",'"+remarks+"','"+techhrs+"',3,"+userid+",CURDATE(),"+estmins+")";
		int insert=stmt.executeUpdate(strsql);
		if(insert<=0){
			errorstatus=1;
		}
		//Getting total Est Mins
		long totalestmins=0;
		String strtotal="select sum(estmins) estmins from ws_floortech where jobdocno="+jobdocno;
		ResultSet rs=stmt.executeQuery(strtotal);
		while(rs.next()){
			totalestmins=rs.getLong("estmins");
		}
				
		//Updating Est Mins to Floor Mgmt
		
		String strupdate="update ws_floormgmtdata set esthrs=case when "+totalestmins+">0 then "+totalestmins+"/60 else 0 end where jobdocno="+jobdocno;
		int update=stmt.executeUpdate(strupdate);
		if(update<=0){
			errorstatus=1;
		}
		
		if(errorstatus==0){
			conn.commit();
		}
	}
	catch(Exception e){
		e.printStackTrace();
		errorstatus=1;
	}
	finally{
		conn.close();
	}
	objdata.put("errorstatus",errorstatus);
	response.getWriter().write(objdata+"");
%>