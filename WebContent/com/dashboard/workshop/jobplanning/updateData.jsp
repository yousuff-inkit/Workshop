<%@page import="java.util.ArrayList"%>
<%@page import="com.common.ClsCommon"%>
<%@page import="java.sql.*" %>
<%@page import="com.connection.*" %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%

ClsConnection objconn=new ClsConnection();
ClsCommon objcommon=new ClsCommon();
String jobdocno=request.getParameter("jobdocno")==null?"0":request.getParameter("jobdocno");
String strbayarray=request.getParameter("bayarray")==null?"":request.getParameter("bayarray");
String strteamarray=request.getParameter("teamarray")==null?"":request.getParameter("teamarray");
String baylength=request.getParameter("baylength")==null?"0":request.getParameter("baylength");
String teamlength=request.getParameter("teamlength")==null?"0":request.getParameter("teamlength");

Connection conn=null;
int errorstatus=0;
try{
	ArrayList<String> bayarray=new ArrayList();
	ArrayList<String> teamarray=new ArrayList();
	for(int i=0;i<Integer.parseInt(baylength);i++){
		bayarray.add(strbayarray.split(",")[i]);
	}
	for(int i=0;i<Integer.parseInt(teamlength);i++){
		teamarray.add(strteamarray.split(",")[i]);
	}
	conn=objconn.getMyConnection();
	conn.setAutoCommit(false);
	Statement stmt=conn.createStatement();
	String userid=session.getAttribute("USERID").toString();
	int deletebay=stmt.executeUpdate("delete from ws_jobplanbay where jobdocno="+jobdocno);
	int deleteteam=stmt.executeUpdate("delete from ws_jobplanteam where jobdocno="+jobdocno);
	int floormgmtconfig=0;
	String strfloormgmtconfig="select method from gl_config where field_nme='floorMgmt'";
	ResultSet rsfloormgmtconfig=stmt.executeQuery(strfloormgmtconfig);
	while(rsfloormgmtconfig.next()){
		floormgmtconfig=rsfloormgmtconfig.getInt("method");
	}
	for(int i=0;i<bayarray.size();i++){
		String strsql="insert into ws_jobplanbay(jobdocno,baydocno,seqno)values("+jobdocno+","+bayarray.get(i).split("::")[0]+","+bayarray.get(i).split("::")[1]+")";
		int insert=stmt.executeUpdate(strsql);
		if(insert<=0){
			errorstatus=1;
		}
		if(floormgmtconfig==1){
			String strupdatefloormgmt="update ws_floormgmtdata set z"+bayarray.get(i).split("::")[0]+"="+bayarray.get(i).split("::")[1]+" where jobdocno="+jobdocno;
			int updatefloormgmt=stmt.executeUpdate(strupdatefloormgmt);
			if(updatefloormgmt<=0){
				errorstatus=1;
			}			
		}
	}
	for(int i=0;i<teamarray.size();i++){
		String strsql="insert into ws_jobplanteam(jobdocno,teamdocno,userid)values("+jobdocno+","+teamarray.get(i)+","+userid+")";
		int insert=stmt.executeUpdate(strsql);
		if(insert<=0){
			errorstatus=1;
		}
	}
	
	String strupdate="update ws_jobcard set planstatus=1 where doc_no="+jobdocno;
	int updateval=stmt.executeUpdate(strupdate);
	if(updateval<=0){
		errorstatus=1;
	}
	String strlog="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+jobdocno+"','"+session.getAttribute("BRANCHID").toString()+"','BWJP',now(),'"+session.getAttribute("USERID").toString()+"','A')";
	int loginsert=stmt.executeUpdate(strlog);
	if(loginsert<=0){
		errorstatus=1;
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