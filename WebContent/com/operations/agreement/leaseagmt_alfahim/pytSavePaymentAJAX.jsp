<%@page import="java.util.ArrayList"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.*" %>
<%@page import="java.sql.*" %>
<%
Connection conn=null;
ClsConnection objconn=new ClsConnection();
ClsCommon objcommon=new ClsCommon();
String masterdocno=request.getParameter("masterdocno")==null?"0":request.getParameter("masterdocno").toString();
String pyttotalrent=request.getParameter("pyttotalrent")==null?"0":request.getParameter("pyttotalrent");
String pytadvance=request.getParameter("pytadvance")==null?"0":request.getParameter("pytadvance");
String pytbalance=request.getParameter("pytbalance")==null?"0":request.getParameter("pytbalance");
String pytstartdate=request.getParameter("pytstartdate")==null?"0":request.getParameter("pytstartdate");
String pytmonthsno=request.getParameter("pytmonthsno")==null?"0":request.getParameter("pytmonthsno");
String pytbankacno=request.getParameter("pytbankacno")==null || request.getParameter("pytbankacno")==""?"0":request.getParameter("pytbankacno");
System.out.println("Inside Ajax");
String gridarray=request.getParameter("gridarray");
/* ==null?"":request.getParameter("gridarray"); */
System.out.println("Grid Array: "+gridarray);
int status=-1;
try{
	java.sql.Date sqlpytdate=null;
	if(!pytstartdate.equalsIgnoreCase("0")){
		sqlpytdate=objcommon.changeStringtoSqlDate(pytstartdate);
	}
	String temparray[]=gridarray.split(",");
	ArrayList<String> newarray=new ArrayList();
	for(int i=0;i<temparray.length;i++){
		newarray.add(temparray[i]);
	}
	conn=objconn.getMyConnection();
	conn.setAutoCommit(false);
	Statement stmt=conn.createStatement();
	if(!masterdocno.equalsIgnoreCase("0")){
		
		String strsql="update gl_lagmt set pyttotalrent="+pyttotalrent+",pytbalance="+pytbalance+",pytadvance="+pytadvance+",pytstartdate='"+sqlpytdate+"',pytmonthno="+pytmonthsno+",pytbankacno="+pytbankacno+" where doc_no="+masterdocno;
		System.out.println(strsql);
		int updateval=stmt.executeUpdate(strsql);
		if(updateval<0){
			status=0;
		}
		else{
			String strdelete="delete from gl_leasepytcalc where rdocno="+masterdocno+" and status=3";
			int deleteval=stmt.executeUpdate(strdelete);
			
			for(int i=0;i<newarray.size();i++){
				String temp[]=newarray.get(i).split("::");
				java.sql.Date sqldate=null;
				if(!temp[0].equalsIgnoreCase("") && temp[0]!=null){
					sqldate=objcommon.changeStringtoSqlDate(temp[0]);
				}
				String bpvno=temp[3].trim().equalsIgnoreCase("")?null:temp[3];
				String chequeno=temp[2].trim().equalsIgnoreCase("")?null:temp[2];
				Statement stmtcheque=conn.createStatement();
				String strinsert="insert into gl_leasepytcalc(date,amount,bpvno,chequeno,rdocno,status)values('"+sqldate+"',"+temp[1]+","+bpvno+","+chequeno+","+masterdocno+",3)";
				int val=stmtcheque.executeUpdate(strinsert);
				if(val<=0){
					status=0;
				}
				System.out.println("Status: "+status);
				System.out.println("Query: "+strinsert);
			}
			
		}
	}
if(status==0){
	
}
else{
	System.out.print("Success: "+status);
	status=1;
	conn.commit();
}
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(status+"");
%>