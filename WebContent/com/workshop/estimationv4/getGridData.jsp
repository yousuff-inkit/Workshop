<%@page import="com.workshop.estimationv4.ClsEstimationV4DAO"%>
<%@page import="net.sf.json.JSONArray"%>
<%
String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
String id=request.getParameter("id")==null?"":request.getParameter("id");
String contractdocno=request.getParameter("contractdocno")==null?"":request.getParameter("contractdocno");
String type=request.getParameter("type")==null?"":request.getParameter("type");
String gatevocno=request.getParameter("gatevocno")==null?"":request.getParameter("gatevocno");
String cldocno=request.getParameter("cldocno")==null?"":request.getParameter("cldocno");
String clientname=request.getParameter("clientname")==null?"":request.getParameter("clientname");
String date=request.getParameter("date")==null?"":request.getParameter("date");
String brhid=request.getParameter("brhid")==null?"":request.getParameter("brhid");
String regno=request.getParameter("regno")==null?"":request.getParameter("regno");
JSONArray gridarray=new JSONArray();
try{
	ClsEstimationV4DAO estdao=new ClsEstimationV4DAO();
	if(type.equalsIgnoreCase("LABOUR") && id.equalsIgnoreCase("1")){
		gridarray=estdao.getLabourcostData(docno, id);
	}
	else if(type.equalsIgnoreCase("LABOUR") && id.equalsIgnoreCase("2")){
		gridarray=estdao.getPackageLabourData(docno, id, contractdocno);
	}
	else if(type.equalsIgnoreCase("SPARE") && id.equalsIgnoreCase("1")){
		gridarray=estdao.getSparepartsData(docno, id);
	}
	else if(type.equalsIgnoreCase("SPARE") && id.equalsIgnoreCase("2")){
		gridarray=estdao.getPackageSpareData(docno, id, contractdocno);
	}
	else if(type.equalsIgnoreCase("SEARCH") && id.equalsIgnoreCase("1")){
		gridarray=estdao.getMasterSearch(gatevocno,cldocno,clientname,docno,date,id,brhid,regno);
	}
	System.out.println("labour   "+gridarray);
}
catch(Exception e){
	e.printStackTrace();
}
response.getWriter().write(gridarray+"");
%>