<%@page import="java.util.ArrayList"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<% 
Connection conn=null;
ClsConnection objconn=new ClsConnection();
String strlabourarray=request.getParameter("labourarray")==null?"":request.getParameter("labourarray");
String strsparearray=request.getParameter("sparearray")==null?"":request.getParameter("sparearray");
String seccldocno=request.getParameter("seccldocno")==null?"":request.getParameter("seccldocno");
int errorstatus=0;
try{
	conn=objconn.getMyConnection();
	conn.setAutoCommit(false);
	System.out.println(strlabourarray+"::"+strsparearray+"::"+seccldocno);
	ArrayList<String> labourarray=new ArrayList();
	ArrayList<String> sparearray=new ArrayList();
	for(int i=0;i<strlabourarray.split(",").length;i++){
		labourarray.add(strlabourarray.split(",")[i]);
		if(!labourarray.get(i).trim().equalsIgnoreCase("")){
			String strupdaterows="update ws_estlabour set seccldocno="+seccldocno+" where rowno="+labourarray.get(i);
			System.out.println(strupdaterows);
			int updaterows=conn.createStatement().executeUpdate(strupdaterows);
			if(updaterows<=0){
				errorstatus=1;
			}	
		}
		
	}
	for(int i=0;i<strsparearray.split(",").length;i++){
		sparearray.add(strsparearray.split(",")[i]);
		if(!sparearray.get(i).trim().equalsIgnoreCase("")){
			String strupdaterows="update ws_estspare set seccldocno="+seccldocno+" where rowno="+sparearray.get(i);
			System.out.println(strupdaterows);
			int updaterows=conn.createStatement().executeUpdate(strupdaterows);
			if(updaterows<=0){
				errorstatus=1;
			}			
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
response.getWriter().write(errorstatus+"");
%>
