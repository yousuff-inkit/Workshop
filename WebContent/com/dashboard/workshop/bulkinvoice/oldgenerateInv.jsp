<%@page import="com.dashboard.workshop.invoiceprocessing.ClsInvProcessingDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.common.*"%>
<%
Connection conn=null;
String cldocno=request.getParameter("cldocno")==null?"":request.getParameter("cldocno");
String invoicedate=request.getParameter("invoicedate")==null?"":request.getParameter("invoicedate");
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
String strinvoicearray=request.getParameter("invoicearray")==null?"":request.getParameter("invoicearray");
String invvoucher="";
int errorstatus=0;
try{
	
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	ClsInvProcessingDAO processdao=new ClsInvProcessingDAO();
	conn=objconn.getMyConnection();
	conn.setAutoCommit(false);
	Statement stmt=conn.createStatement();
	
	ArrayList ARinv=new ArrayList();
	String strgetacno="select doc_no from ws_invm where status=3";
	ResultSet rsgetacno=stmt.executeQuery(strgetacno);
	while(rsgetacno.next()){
		ARinv.add(rsgetacno.getInt("doc_no"));
	}
	for(int j=0;j<ARinv.size();j++){
		String strgetclaimdata="select coalesce(claimno,'') claimno,coalesce(pono,'') pono,addition,jobdocno from ws_invcalctemp where invno="+ARinv.get(j);
		String claimno="",lpono="";
		ArrayList ARjob=new ArrayList();
		ResultSet rsgetclaimdata=stmt.executeQuery(strgetclaimdata);
		while(rsgetclaimdata.next()){
			if(!claimno.equalsIgnoreCase("")){
				claimno=rsgetclaimdata.getString("claimno");	
			}
			else{
				claimno+=","+rsgetclaimdata.getString("claimno");
			}
			if(!lpono.equalsIgnoreCase("")){
				lpono=rsgetclaimdata.getString("pono");	
			}
			else{
				lpono=","+rsgetclaimdata.getString("pono");
			}
			ARjob.add(rsgetclaimdata.getString("jobdocno")+"::"+rsgetclaimdata.getString("addition"));
		}
		
		for(int i=0;i<ARjob.size();i++){
			String strins="select insurtypedocno, nettotal,round((nettotal/(select round(sum(nettotal),2) from ws_investdata where jobdocno="+ARjob.get(i).toString().split("::")[0]+" and addition in ("+ARjob.get(i).toString().split("::")[1]+")))* "
				+" (select sum(netamount) from ws_invcalctemp where invno="+ARinv.get(j)+" and jobdocno="+ARjob.get(i).toString().split("::")[0]+"),2) insamt from ws_investdata"+ 
				 " where jobdocno="+ARjob.get(i).toString().split("::")[0]+" and addition in ("+ARjob.get(i).toString().split("::")[1]+") ";
			System.out.println("Update Query: "+strins);
			ResultSet rsins=stmt.executeQuery(strins);
			String sqlins="insert into ws_invinsurtype( invno, insurtype, amount) values ";
			while(rsins.next()){
				sqlins+=" ("+ARinv.get(j)+","+rsins.getString("insurtypedocno")+","+rsins.getString("insamt")+ ") , ";
			}
			System.out.println("===="+sqlins.substring(0, sqlins.length()-2));
			stmt.execute(sqlins.substring(0, sqlins.length()-2));
			}
		
		
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
response.getWriter().write(errorstatus+"::"+invvoucher);
%>