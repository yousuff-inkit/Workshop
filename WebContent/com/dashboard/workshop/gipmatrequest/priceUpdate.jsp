<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.Statement"%>
<%@page import="com.connection.ClsConnection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.sql.Connection"%>
<%
Connection conn=null;
JSONObject data =new JSONObject();
String gatedocno=request.getParameter("gatedocno")==null?"":request.getParameter("gatedocno");
String strreqarray=request.getParameter("reqarray")==null?"":request.getParameter("reqarray");
String updatedesc=request.getParameter("desc")==null?"":request.getParameter("desc");
System.out.println("Req:"+strreqarray);
int errorstatus=0;
int docno=0;
try{
	ArrayList<String> reqarray=new ArrayList();
	
	if(!strreqarray.trim().equalsIgnoreCase("")){
		for(int i=0;i<strreqarray.split(",").length;i++){
			reqarray.add(strreqarray.split(",")[i]);
		}
	}
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	conn.setAutoCommit(false);
	Statement stmt=conn.createStatement();
	
	if(reqarray.size()>0){
		//getting docno
		String strgetmasterdocno="select doc_no from ws_gipmatreqm where gipdocno="+gatedocno;
		ResultSet rsmasterdocno=stmt.executeQuery(strgetmasterdocno);
		while(rsmasterdocno.next()){
			docno=rsmasterdocno.getInt("doc_no");
		}
		String userid=session.getAttribute("USERID").toString();
		String brhid=session.getAttribute("BRANCHID").toString();
		
		//Delete Existing Detail Data
		String strupdate="update ws_gipmatreqm set updatedate=now(),priceupdate=1,priceupdatedesc='"+updatedesc+"',priceupdateuserid="+userid+" where doc_no="+docno;
		int update=stmt.executeUpdate(strupdate);
		if(update<=0){
			errorstatus=1;
		}
		int delete=stmt.executeUpdate("delete from ws_gipmatreqd where rdocno="+docno);
		
		//Inserting Detail data
		for(int i=0;i<reqarray.size();i++){
			String temp[]=reqarray.get(i).split("::");
			String desc=temp[0].trim().equalsIgnoreCase("") || temp[0]==null || temp[0].trim().equalsIgnoreCase("undefined")?"":temp[0].trim();
			String qty=temp[1].trim().equalsIgnoreCase("") || temp[1]==null || temp[1].trim().equalsIgnoreCase("undefined")?"0":temp[1].trim();
			String price=temp[2].trim().equalsIgnoreCase("") || temp[2]==null || temp[2].trim().equalsIgnoreCase("undefined")?"0":temp[2].trim();
			
			String strinsertdet="insert into ws_gipmatreqd(rdocno,reqdesc,qty,price)values("+docno+",'"+desc+"',"+qty+","+price+")";
			int insertdet=stmt.executeUpdate(strinsertdet);
			if(insertdet<=0){
				errorstatus=1;
				System.out.println("Material Request Detail Insert Error");
			}
		}
	}
	if(errorstatus==0){
		conn.commit();
	}
	data.put("errorstatus",errorstatus);
	data.put("docno",docno);
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(data+"");
%>