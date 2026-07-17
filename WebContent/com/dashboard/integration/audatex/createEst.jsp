<%@page import="java.util.ArrayList"%>
<%@page import="com.workshop.wsestimationfancy.*"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
Connection conn=null;
String vocno="0";
try{
String gatedocno=request.getParameter("gatedocno")==null?"":request.getParameter("gatedocno");
String strlabourarray=request.getParameter("labourarray")==null?"":request.getParameter("labourarray");
String strpartarray=request.getParameter("partarray")==null?"":request.getParameter("partarray");
ClsWSEstimationFancyDAO estdao=new ClsWSEstimationFancyDAO();
ClsConnection objconn=new ClsConnection();
conn=objconn.getMyConnection();
Statement stmt=conn.createStatement();
String strgetdata="select brhid,curdate() sqldate from ws_gateinpass where doc_no="+gatedocno;
ResultSet rsgetdata=stmt.executeQuery(strgetdata);
String brhid="";
java.sql.Date sqldate=null;
while(rsgetdata.next()){
	brhid=rsgetdata.getString("brhid");
	sqldate=rsgetdata.getDate("sqldate");
}
ArrayList<String> sparepartsarray=new ArrayList();
ArrayList<String> labourcostarray=new ArrayList();
double labourtotal=0.0;
for(int i=0;i<strlabourarray.split(",").length;i++){
	labourcostarray.add(strlabourarray.split(",")[i]);
	labourtotal+=Double.parseDouble(strlabourarray.split(",")[i].split("::")[4]);
}
double sparetotal=0.0;
for(int i=0;i<strpartarray.split(",").length;i++){
	sparepartsarray.add(strpartarray.split(",")[i]);
	sparetotal+=Double.parseDouble(strpartarray.split(",")[i].split("::")[5]);
}
String strprivilagedata="select prv.sparemarkup,prv.labdiscount from ws_gateinpass gate left join my_acbook ac on (gate.cldocno=ac.cldocno and "+
" ac.dtype='CRM') left join my_clprivilage prv on ac.privillege=prv.doc_no where gate.status=3 and gate.doc_no="+gatedocno;
ResultSet rsprivilage=stmt.executeQuery(strprivilagedata);
double sparemarkup=0.0,labdiscount=0.0;
while(rsprivilage.next()){
	sparemarkup=rsprivilage.getDouble("sparemarkup");
	labdiscount=rsprivilage.getDouble("labdiscount");
}
double labourdiscount=labourtotal*labdiscount;
double labournettotal=labourtotal-labourdiscount;
sparetotal=sparetotal+(sparetotal*sparemarkup);
/* String gatedocno, String sparepartstotal,
String labourtotal, String discount, String esttotal, Date sqldate,
ArrayList<String> sparepartsarray,
ArrayList<String> labourcostarray, HttpSession session,
HttpServletRequest request, String mode, String formdetailcode,
String brchName, String servicesdiscount, String servicestotal, String netservices, String hidchklumsum, String lumsumamount */
double esttotal=0.0;
esttotal=sparetotal+labournettotal;
/* int value=estdao.insert(gatedocno, sparetotal+"", labourtotal+"", "0.0", esttotal+"", sqldate, sparepartsarray, 
		labourcostarray, session, request, "A", "EST", brhid, labourdiscount+"", labourtotal+"", labournettotal+"", "0",
		"0.0"); */
int value=estdao.insert(gatedocno, sparetotal+"", labourtotal+"", "0.0", esttotal+"", sqldate, sparepartsarray, 
		labourcostarray, session, request, "A", "EST", brhid, labourdiscount+"", labourtotal+"", labournettotal+"", "0",
		"0.0" ,sparetotal+"", "0.0", sparetotal+"");

if(value>0){
	String strgetvocno="select voc_no from ws_estm where doc_no="+value;
	ResultSet rsgetvocno=stmt.executeQuery(strgetvocno);
	while(rsgetvocno.next()){
		vocno=rsgetvocno.getString("voc_no");
	}
}
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(vocno);
%>