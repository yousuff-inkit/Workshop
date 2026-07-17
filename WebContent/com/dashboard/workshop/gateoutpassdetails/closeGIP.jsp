<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.sql.*"%>
<%@page import="com.common.ClsCommon"%>
<%@page import="com.connection.ClsConnection"%>
<% 

ClsConnection connDAO = new ClsConnection();
ClsCommon commonDAO= new ClsCommon();
Connection conn=null;
java.sql.Date sqldate=null;
String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
String closegipreason=request.getParameter("closegipreason")==null||request.getParameter("closegipreason").equalsIgnoreCase("")?"":request.getParameter("closegipreason");
String brhid=request.getParameter("brhid")==null||request.getParameter("brhid").equalsIgnoreCase("")?"0":request.getParameter("brhid");
Integer userid=(Integer) session.getAttribute("USERID");
int errorstatus=0; 
int x=0;
JSONObject objdata=new JSONObject();
try{
	System.out.println("Inside GOP");
	conn=connDAO.getMyConnection();
	conn.setAutoCommit(false);
	Statement stmt = conn.createStatement ();
	String strmaxdocno="select coalesce(max(doc_no),0)+1 maxdocno from ws_closegip";
	ResultSet rsmaxdocno=stmt.executeQuery(strmaxdocno);
	int closedocno=0;
	while(rsmaxdocno.next()){
		closedocno=rsmaxdocno.getInt("maxdocno");
	}
	
	String strinsert="insert into ws_closegip(doc_no, gipdocno, closereason, brhid, userid, closedate, status) values("+
	""+closedocno+","+docno+",'"+closegipreason+"',"+brhid+","+userid+",now(),3)";
	int insert=stmt.executeUpdate(strinsert);
	if(insert<0){
		errorstatus=1;
	}
	String strSql1 = "update ws_gateinpass set closestatus="+closedocno+",processstatus=8 where doc_no="+docno;
	int updategip=stmt.executeUpdate(strSql1);
	if(updategip<=0){
		errorstatus=1;
	}
	
	if(errorstatus==0){
		conn.commit();
	}
	objdata.put("errorstatus",errorstatus);
}catch(Exception e){
	e.printStackTrace();
	conn.close();
}
finally{
	conn.close();
}
response.getWriter().write(objdata+"");
%>