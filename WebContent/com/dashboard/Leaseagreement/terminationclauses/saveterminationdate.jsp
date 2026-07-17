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
<%@ page import="java.sql.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
ClsConnection ClsConnection=new ClsConnection();

ClsCommon ClsCommon=new ClsCommon();

String m1=request.getParameter("m1")==null?"0":request.getParameter("m1");
String m2=request.getParameter("m2")==null?"0":request.getParameter("m2");
String amt1=request.getParameter("amt1")==null?"0":request.getParameter("amt1");

String m3=request.getParameter("m3")==null?"0":request.getParameter("m3");
String m4=request.getParameter("m4")==null?"0":request.getParameter("m4");
String amt2=request.getParameter("amt2")==null?"0":request.getParameter("amt2");

String m5=request.getParameter("m5")==null?"0":request.getParameter("m5");
String m6=request.getParameter("m6")==null?"0":request.getParameter("m6");
String amt3=request.getParameter("amt3")==null?"0":request.getParameter("amt3");

String m7=request.getParameter("m7")==null?"0":request.getParameter("m7");
String m8=request.getParameter("m8")==null?"0":request.getParameter("m8");
String amt4=request.getParameter("amt4")==null?"0":request.getParameter("amt4");

String m9=request.getParameter("m9")==null?"0":request.getParameter("m9");
String m10=request.getParameter("m10")==null?"0":request.getParameter("m10");
String amt5=request.getParameter("amt5")==null?"0":request.getParameter("amt5");

 

String doc=request.getParameter("doc")==null?"0":request.getParameter("doc");
 
	
 
 	ArrayList<String> tercllist= new ArrayList<String>();
	
	  
	  
	  tercllist.add((m1.trim().equalsIgnoreCase("")?"0":m1)+"::"+(m2.trim().equalsIgnoreCase("")?"0":m2)+"::"+(amt1.trim().equalsIgnoreCase("")?"0":amt1));
	  tercllist.add((m3.trim().equalsIgnoreCase("")?"0":m3)+"::"+(m4.trim().equalsIgnoreCase("")?"0":m4)+"::"+(amt2.trim().equalsIgnoreCase("")?"0":amt2));
	  tercllist.add((m5.trim().equalsIgnoreCase("")?"0":m5)+"::"+(m6.trim().equalsIgnoreCase("")?"0":m6)+"::"+(amt3.trim().equalsIgnoreCase("")?"0":amt3));
	  tercllist.add((m7.trim().equalsIgnoreCase("")?"0":m7)+"::"+(m8.trim().equalsIgnoreCase("")?"0":m8)+"::"+(amt4.trim().equalsIgnoreCase("")?"0":amt4));
	  tercllist.add((m9.trim().equalsIgnoreCase("")?"0":m9)+"::"+(m10.trim().equalsIgnoreCase("")?"0":m10)+"::"+(amt5.trim().equalsIgnoreCase("")?"0":amt5));
 
    Connection conn=null;
    String sql="";
    try
    {
   	
    conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement();
	
	String delsql="delete from gl_ltermcl where rdocno='"+doc+"'";
	
 
	stmt.executeUpdate(delsql);

	for(int k=0;k<tercllist.size();k++)
	{
	
		

	
	  String[] terclarray=tercllist.get(k).split("::");  
	  
 
	  
	  if(!(terclarray[2].trim().equalsIgnoreCase("undefined")||terclarray[2].trim().equalsIgnoreCase("")|| terclarray[2].isEmpty() ||  terclarray[2].trim().equalsIgnoreCase("NaN") ||  terclarray[2].trim().equalsIgnoreCase("0") ))
	     {
	  
				
				   String tclsql="";
				   tclsql="INSERT INTO gl_ltermcl(rdocno,mnthfrm,mnthto,amt) values('"+doc+"',"
				  +"'"+(terclarray[0].equalsIgnoreCase("undefined")||terclarray[0]==null || terclarray[0].equalsIgnoreCase("") || terclarray[0].trim().equalsIgnoreCase("NaN")|| terclarray[0].isEmpty()?0:terclarray[0].trim())+"',"
				  + "'"+(terclarray[1].trim().equalsIgnoreCase("undefined")||terclarray[1]==null  || terclarray[1].trim().equalsIgnoreCase("") || terclarray[1].trim().equalsIgnoreCase("NaN")|| terclarray[1].isEmpty()?0:terclarray[1].trim())+"',"
				  +"'"+(terclarray[2].equalsIgnoreCase("undefined")||terclarray[2]==null || terclarray[2].equalsIgnoreCase("") || terclarray[2].trim().equalsIgnoreCase("NaN")|| terclarray[2].isEmpty()?0:terclarray[2].trim())+"')";
			// System.out.println("==tclsql===+"+tclsql);
				  
				int resultSettcl = stmt.executeUpdate(tclsql);
				 if(resultSettcl<=0)
			     {
				  conn.close();
			    	 
			     }
	     }	 
	  
	  
	  
	 
    	
    }
	     stmt.close();
	 
		conn.close();
		response.getWriter().print(1);
    }
    catch(Exception e)
    {
    	e.printStackTrace();
    	conn.close();
    }
	 	
	 	
	 	
%>



