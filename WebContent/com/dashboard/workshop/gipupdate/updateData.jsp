<%@page import="com.common.ClsCommon"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String gipdocno=request.getParameter("gipdocno")==null?"":request.getParameter("gipdocno");
String estdate=request.getParameter("estdate")==null?"":request.getParameter("estdate");
String esttime=request.getParameter("esttime")==null?"":request.getParameter("esttime");
String estkm=request.getParameter("estkm")==null?"":request.getParameter("estkm");
int errorstatus=0;
Connection conn=null;
try{
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	conn=objconn.getMyConnection();
	conn.setAutoCommit(false);
	java.sql.Date sqldate=null;
	if(!estdate.equalsIgnoreCase("")){
		sqldate=objcommon.changeStringtoSqlDate(estdate);
	}
	Statement stmt=conn.createStatement();
	String strsql="update ws_gateinpass set kmin="+estkm+",estdeldate='"+sqldate+"',estdeltime='"+esttime+"' where doc_no="+gipdocno;
	System.out.println(strsql);
	int update=stmt.executeUpdate(strsql);
	if(update<=0){
		errorstatus=1;
	}
	String strgetmisc="select brhid from ws_gateinpass where doc_no="+gipdocno;
	ResultSet rs=stmt.executeQuery(strgetmisc);
	int brhid=0;
	while(rs.next()){
		brhid=rs.getInt("brhid");
	}
	String userid=session.getAttribute("USERID").toString();
	PreparedStatement stmtlog=conn.prepareStatement("insert into gl_biblog(doc_no, brhId, dtype, edate, userId, userNo, activity, ENTRY) values (?,?,?,now(),?,?,?,?)");
	stmtlog.setInt(1,Integer.parseInt(gipdocno));
	stmtlog.setInt(2,brhid);
	stmtlog.setString(3,"BWGU");
	stmtlog.setInt(4, Integer.parseInt(userid));
	stmtlog.setInt(5, 0);
	stmtlog.setInt(6, 0);
	stmtlog.setString(7, "A");
	int log=stmtlog.executeUpdate();
	if(log<=0){
		errorstatus=1;
	}
	if(errorstatus!=1){
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