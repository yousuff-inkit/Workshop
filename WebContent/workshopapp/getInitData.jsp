<%@page import="workshopapp.ClsWorkshopAppDAO"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
JSONObject objdata=new JSONObject();
Connection conn=null;
String userid=session.getAttribute("USERID")==null?"0":session.getAttribute("USERID").toString();
String chconfig="0";     
try{
	ClsConnection objconn=new ClsConnection();
	ClsWorkshopAppDAO dao=new ClsWorkshopAppDAO();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	String username=session.getAttribute("USERNAME")==null?"":session.getAttribute("USERNAME").toString();
	objdata.put("regnodata",dao.getRegNoData(conn,""));
	objdata.put("platedata",dao.getVehPlateData(conn));
	objdata.put("clientdata",dao.getClientData(conn));
	objdata.put("branddata",dao.getVehBrandData(conn));
	objdata.put("colordata",dao.getVehColorData(conn));
	objdata.put("branchdata",dao.getBranchData(conn,session));
	objdata.put("repairtypedata",dao.getRepairTypeData(conn));
	objdata.put("inventorydata",dao.getInventoryData(conn));
	objdata.put("username",username);
	objdata.put("yomdata",dao.getYomData(conn));
	objdata.put("serviceadvisordata",dao.getServiceAdvisorData(conn));
	JSONObject objsize=new JSONObject();
	
	String strsql="select coalesce(method,0) method from gl_config where field_nme='ChasisNoValidate'";
	ResultSet rs=stmt.executeQuery(strsql);
	while(rs.next()){
		chconfig=rs.getString("method");  
	}
	
	objsize.put("clientname",100);
	objsize.put("username",45);
	objsize.put("mobile",15);
	objsize.put("email",45);
	if(chconfig.equalsIgnoreCase("1")){   
		objsize.put("chassis",17);  
	}else{
		objsize.put("chassis",45);
	}   
	objsize.put("mainremarks",2000);
	objdata.put("fieldsizedata",objsize);
	int duplicategip=0;
	String strduplicategip="select coalesce(method,0) method from gl_config where field_nme='RestrictDuplicateGIP'";
	ResultSet rsduplicate=stmt.executeQuery(strduplicategip);
	while(rsduplicate.next()){
		duplicategip=rsduplicate.getInt("method");  
	}
	objdata.put("duplicateconfig",duplicategip);
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(objdata+"");
%>