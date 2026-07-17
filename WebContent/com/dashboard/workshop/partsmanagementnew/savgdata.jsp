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
System.out.println("the status is-----------"+chngntb);
String addval=request.getParameter("addval");  
System.out.println("the availability is-----------"+addval);
String costpr=request.getParameter("costpr");
System.out.println("the costpr is-----------"+costpr);
String remrk=request.getParameter("remarks");  
System.out.println("the remarks is-----------"+remrk);
Connection conn=null;

try{
ClsConnection ClsConnection =new ClsConnection();
ClsCommon ClsCommon=new ClsCommon();

conn = ClsConnection.getMyConnection();
Statement stmt = conn.createStatement ();

String[] tranarray = srvdetmtrno.split(",");
String[] tramarray = chngntb.split(",");
String[] trasarray = addval.split(",");
String[] costarray = costpr.split(",");
String[] remrarray = remrk.split(",");
int aaa= 0,bbb=0,ccc=0,ddd=0;
double costprice=0.0;     




for (int i = 0; i < tranarray.length; i++) {
String tranno=tranarray[i];	
//System.out.println("the tranno is-----"+tranno);

String status=tramarray[i];
//System.out.println("the tramno is-----"+tramno);
String avail=trasarray[i];
String cost=costarray[i];
costprice=Double.parseDouble(cost);
//System.out.println("the tramno is-----"+tramno);
String remr=remrarray[i];
if(!(tranno.equalsIgnoreCase(""))){
String sql="update ws_estspare m set m.costprice="+costprice+",m.approvedvalue="+costprice+",m.remarks='"+remr+"',m.status='"+status+ "',m.availability='"+avail+ "' where rowno="+tranno+"";
//System.out.println("the update query is-----"+sql);
aaa= stmt.executeUpdate(sql);
} 
}

			   

response.getWriter().print(aaa);

stmt.close();
conn.close();
}
catch(Exception e){
response.getWriter().print(0);
conn.close();
e.printStackTrace();
}
%>