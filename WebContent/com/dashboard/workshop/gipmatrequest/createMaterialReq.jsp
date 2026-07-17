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
String matreqdesc=request.getParameter("desc")==null?"":request.getParameter("desc");
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
		String strgetmasterdocno="select coalesce(max(doc_no),0)+1 maxdocno from ws_gipmatreqm";
		ResultSet rsmasterdocno=stmt.executeQuery(strgetmasterdocno);
		while(rsmasterdocno.next()){
			docno=rsmasterdocno.getInt("maxdocno");
		}
		String userid=session.getAttribute("USERID").toString();
		String brhid=session.getAttribute("BRANCHID").toString();
		
		//Inserting Master Data
		String strinsertmaster="insert into ws_gipmatreqm(doc_no,date,gipdocno,userid,brhid,status,createdate,matreqdesc)values("+docno+",CURDATE(),"+gatedocno+","+userid+","+brhid+",3,now(),'"+matreqdesc+"')";
		int insertmaster=stmt.executeUpdate(strinsertmaster);
		if(insertmaster<=0){
			errorstatus=1;
			System.out.println("Material Request Master Insert Error");
		}
		
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