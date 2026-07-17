<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.util.*"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.common.*"%>
<%@page import="com.finance.nipurchase.nipurchase.ClsnipurchaseDAO" %>
<%	  
String srvdetmtrno=request.getParameter("srvdetmtrno");
//System.out.println("the rows are-----------"+srvdetmtrno);
String chngntb=request.getParameter("chngsntb");
//System.out.println("the req value is-----------"+chngntb);
String addval=request.getParameter("addval");  
//System.out.println("the out qty is-----------"+addval);
String invdate=request.getParameter("idate"); 
String gridarray=request.getParameter("gridarray")==null?"":request.getParameter("gridarray");
String invno=request.getParameter("ino")==null?"0":request.getParameter("ino");
String vndacno=request.getParameter("acno")==null?"0":request.getParameter("acno");
String jobdocno=request.getParameter("jobno")==null?"0":request.getParameter("jobno");
String tests=request.getParameter("ntotal");
//System.out.println("the nettotal is-----------"+tests);
Double nettotal=request.getParameter("ntotal")==null?0.0:Double.parseDouble(request.getParameter("ntotal"));
String vndtax=request.getParameter("vtax")==null?"0":request.getParameter("vtax");
//System.out.println("the vndtax of is-----------"+vndtax);
String test=request.getParameter("roundval");
//System.out.println("the round of is-----------"+test);
String remarks=request.getParameter("remarks");
//System.out.println("the round of is-----------"+test);
double rval=request.getParameter("roundval")==null?0.0:Double.parseDouble(request.getParameter("roundval"));
Connection conn=null;
ClsnipurchaseDAO viewDAO=new ClsnipurchaseDAO();
String nipurchasevocno="0";
try{
ClsConnection ClsConnection =new ClsConnection();
ClsCommon ClsCommon=new ClsCommon();

conn = ClsConnection.getMyConnection();
Statement stmt = conn.createStatement ();
String reset=remarks;
String[] tranarray = srvdetmtrno.split(",");
String[] tramarray = chngntb.split(",");
String[] trasarray = addval.split(",");
int aaa= 0,bbb=0,ccc=0,ddd=0;
int vdtax=Integer.parseInt(vndtax);
java.sql.Date sqlDate=null;
ArrayList<String> griddataarray=new ArrayList<String>();
String[] temparray=gridarray.split(",");
for(int i=0;i<temparray.length;i++){
	griddataarray.add(temparray[i]);    
	
} 

 if(!(invdate.equalsIgnoreCase("undefined"))&&!(invdate.equalsIgnoreCase(""))&&!(invdate.equalsIgnoreCase("0"))){
     sqlDate=ClsCommon.changeStringtoSqlDate(invdate);
}
String strgetjobvocno="select voc_no,brhid from ws_jobcard where status=3 and doc_no="+jobdocno; 
ResultSet rsgetjobvocno=stmt.executeQuery(strgetjobvocno);
String jobvocno="";
String brhid="";
while(rsgetjobvocno.next()){
	jobvocno=rsgetjobvocno.getString("voc_no");
	brhid=rsgetjobvocno.getString("brhid");
	session.setAttribute("BRANCHID",brhid);
}
if(remarks.equalsIgnoreCase("")){
	//reset="purchase invoice for jobcardno";
	reset="NI Purchase for Jobcard #"+jobvocno;
}
else{
	reset+=" with Jobcard #"+jobvocno;
}
for (int i = 0; i < tranarray.length; i++) {
String tranno=tranarray[i];	
//System.out.println("the tranno is-----"+tranno);
String tramno=tramarray[i];
//System.out.println("the tramno is-----"+tramno);
String trasno=trasarray[i];
bbb=Integer.parseInt(tramno);
ccc=Integer.parseInt(trasno);
//System.out.println("added value is========="+bbb+ccc);
ddd=bbb+ccc;
//System.out.println("added value is========="+ddd); 
if(!(tranno.equalsIgnoreCase(""))){
String sql="update ws_estspare m set m.outqty="+ddd+" where rowno="+tranno+"";
aaa= stmt.executeUpdate(sql);
} 
}
aaa=viewDAO.insert(sqlDate,sqlDate,"DIR",0,"ap",vndacno,"","1","1","","",reset,session,"A",nettotal,griddataarray,"CPU",request,sqlDate,invno,invdate,vdtax,rval,nettotal,1);
nipurchasevocno=request.getAttribute("vocno").toString();			   

response.getWriter().print(aaa+"::"+nipurchasevocno);

stmt.close();
conn.close();
}
catch(Exception e){
response.getWriter().print(0);
conn.close();
e.printStackTrace();
}
%>