
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


<%	
ClsConnection ClsConnection=new ClsConnection();

ClsCommon ClsCommon=new ClsCommon();

Connection conn=null;

try{
	
 
	String doc_no=request.getParameter("doc_no");
	 
	String dy1=request.getParameter("dy1")==null||request.getParameter("dy1")==""?"0":request.getParameter("dy1");
	String dy2=request.getParameter("dy2")==null||request.getParameter("dy2")==""?"0":request.getParameter("dy2");
    String dy3=request.getParameter("dy3")==null||request.getParameter("dy3")==""?"0":request.getParameter("dy3");
    
   // System.out.println("-----4---"+request.getParameter("dy4"));
    
    String dy4=request.getParameter("dy4")==null||request.getParameter("dy4")==""?"0":request.getParameter("dy4");
    String dy5=request.getParameter("dy5")==null||request.getParameter("dy5")==""?"0":request.getParameter("dy5");
    String mininsur=request.getParameter("mininsur")==null||request.getParameter("mininsur")==""?"0":request.getParameter("mininsur");
    String extrainsurperyear=request.getParameter("extrainsurperyear")==null||request.getParameter("extrainsurperyear")==""?"0":request.getParameter("extrainsurperyear");
    String majorsrvckm=request.getParameter("majorsrvckm")==null||request.getParameter("majorsrvckm")==""?"0":request.getParameter("majorsrvckm");
    String majorsrvccost=request.getParameter("majorsrvccost")==null||request.getParameter("majorsrvccost")==""?"0":request.getParameter("majorsrvccost");
    String trackidexp=request.getParameter("trackidexp")==null||request.getParameter("trackidexp")==""?"0":request.getParameter("trackidexp");
	String ins_per=request.getParameter("ins_per")==null||request.getParameter("ins_per")==""?"0":request.getParameter("ins_per");
	String srv_km=request.getParameter("srv_km")==null||request.getParameter("srv_km")==""?"0":request.getParameter("srv_km");
	String tyrechg_km=request.getParameter("tyrechg_km")==null||request.getParameter("tyrechg_km")==""?"0":request.getParameter("tyrechg_km");
    String tyre_cost=request.getParameter("tyre_cost")==null||request.getParameter("tyre_cost")==""?"0":request.getParameter("tyre_cost");
    String maint_cost=request.getParameter("maint_cost")==null||request.getParameter("maint_cost")==""?"0":request.getParameter("maint_cost");
    String repl_cost=request.getParameter("repl_cost")==null||request.getParameter("repl_cost")==""?"0":request.getParameter("repl_cost");
	String carwash_cost=request.getParameter("carwash_cost")==null||request.getParameter("carwash_cost")==""?"0":request.getParameter("carwash_cost");
	
	String auh=request.getParameter("auh")==null||request.getParameter("auh")==""?"0":request.getParameter("auh");
	String dxb=request.getParameter("dxb")==null||request.getParameter("dxb")==""?"0":request.getParameter("dxb");
    String shj=request.getParameter("shj")==null||request.getParameter("shj")==""?"0":request.getParameter("shj");
    String fuj=request.getParameter("fuj")==null||request.getParameter("fuj")==""?"0":request.getParameter("fuj");
    String rak=request.getParameter("rak")==null||request.getParameter("rak")==""?"0":request.getParameter("rak");


 

	 
	 int val=0;
 
	
 	 conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
		  
	 String upsql="update    gl_leasecost set  dy1='"+dy1+"', dy2='"+dy2+"', dy3='"+dy3+"', dy4='"+dy4+"', dy5='"+dy5+"',ins_per='"+ins_per+"',mininsur="+mininsur+",srv_km='"+srv_km+"',"+
	 " tyrechg_km='"+tyrechg_km+"', tyre_cost='"+tyre_cost+"', maint_cost='"+maint_cost+"', repl_cost='"+repl_cost+"', carwash_cost='"+carwash_cost+"',"+
	" auh='"+auh+"', dxb='"+dxb+"', shj='"+shj+"', fuj='"+fuj+"', rak='"+rak+"',extrainsurperyear='"+extrainsurperyear+"',majorsrvckm='"+majorsrvckm+"',"+
	" majorsrvccost='"+majorsrvccost+"',trackidexp='"+trackidexp+"' where doc_no='"+doc_no+"'";

	// System.out.println("--upsql----"+upsql);
	 
		 val= stmt.executeUpdate(upsql);

		 response.getWriter().print(val);
	
	 	
	 	stmt.close();
	 	conn.close();
	 	  
	 }

	 catch(Exception e){

	 			conn.close();
	 			e.printStackTrace();
	 		}
	
	%>
