<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
Connection conn=null;
String gatedocno=request.getParameter("gatedocno")==null?"":request.getParameter("gatedocno");
JSONObject objdata=new JSONObject();
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	//Getting config
	int estimaterestrictconfig=0;
	String strconfig="select method from gl_config where field_nme='gipattachrestrict'";
	ResultSet rsconfig=stmt.executeQuery(strconfig);
	while(rsconfig.next()){
		estimaterestrictconfig=rsconfig.getInt("method");
	}
	
	//checking if repairtype is Accidental
	
	String strgarrage="select count(*) itemcount from ws_giprepairtype g left join ws_gartype g1 on g.repairdocno=g1.row_no where gipdocno="+gatedocno+" and accident=1";
	System.out.println(strgarrage);
	ResultSet rsgarrage=stmt.executeQuery(strgarrage);
	int acc_count=0;
	while(rsgarrage.next()){
		acc_count=rsgarrage.getInt("itemcount");
	}
	if(acc_count==0){
		estimaterestrictconfig=0;
	}
	objdata.put("estimaterestrictconfig",estimaterestrictconfig);
	System.out.println(acc_count+"::"+estimaterestrictconfig);
	if(estimaterestrictconfig==1){
		String strgetattach="select f.ref_id  from my_fileattach f where f.doc_no="+gatedocno+" and status<>7";
		ResultSet rsgetattach=stmt.executeQuery(strgetattach);
		int policereport=0,regcard=0,drvlicense=0,emiratesid=0;
		while(rsgetattach.next()){
			if(rsgetattach.getInt("ref_id")==18){
				policereport=rsgetattach.getInt("ref_id");
			}
			else if(rsgetattach.getInt("ref_id")==19){
				regcard=rsgetattach.getInt("ref_id");
			}
			else if(rsgetattach.getInt("ref_id")==20){
				drvlicense=rsgetattach.getInt("ref_id");
			}
			else if(rsgetattach.getInt("ref_id")==21){
				emiratesid=rsgetattach.getInt("ref_id");
			}
		}
		
		int errorstatus=0;
		String errortype="";
		if(policereport==0){
			errorstatus=1;
			errortype="Police Report";
		}
		else if(regcard==0){
			errorstatus=1;
			errortype="Registration Card";
		}
		else if(drvlicense==0){
			errorstatus=1;
			errortype="Driving License";
		}
		else if(emiratesid==0){
			errorstatus=1;
			errortype="Emirates ID";
		}
		System.out.println(errortype+"::"+errorstatus);
		objdata.put("errorstatus",errorstatus);
		objdata.put("errortype",errortype);
	}
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(objdata+"");
%>