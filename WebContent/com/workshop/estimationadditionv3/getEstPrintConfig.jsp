<%@page import="workshopapp.ClsWorkshopAppDAO"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
Connection conn=null;
JSONObject objdata=new JSONObject();
int status=0;   
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	ClsWorkshopAppDAO dao=new ClsWorkshopAppDAO();
	Statement stmt=conn.createStatement();
	String str="select method from gl_config where field_nme='PAGEstimationPrint'";   
	ResultSet rs=stmt.executeQuery(str);
	while(rs.next()){
		status=rs.getInt("method");    
	}  
	String strconfig="select 2 srno,field_nme,method,coalesce(value,0) value from gl_config where field_nme='serviceConsumables' union all"+
	" select 3 srno,field_nme,method,coalesce(value,0) value from gl_config where field_nme='printEstDropdownOrder' union all"+
	" select 4 srno,field_nme,method,coalesce(value,0) value from gl_config where field_nme='estSpareDiscount' union all"+
	" select 5 srno,field_nme,method,coalesce(value,0) value from gl_config where field_nme='estJobtypeGridSearch' union all"+
	" select 6 srno,field_nme,method,coalesce(value,0) value from gl_config where field_nme='estLumSum'";
	ResultSet rsconfig=stmt.executeQuery(strconfig);
	int srno2=2,method2=0,value2=0;
	int srno3=3,method3=0,value3=0;
	int srno4=4,method4=0,value4=0;
	int srno5=5,method5=0,value5=0;
	int srno6=2,method6=0,value6=0;
	while(rsconfig.next()){
		JSONObject objtemp=new JSONObject();
		int srno=rsconfig.getInt("srno");
		objtemp.put("srno",rsconfig.getInt("srno"));
		objtemp.put("method",rsconfig.getInt("method"));
		objtemp.put("value",rsconfig.getInt("value"));
		if(srno==2){
			srno2=rsconfig.getInt("srno");
			method2=rsconfig.getInt("method");
			value2=rsconfig.getInt("value");
			//objdata.put("serviceConsumables",objtemp);
		}
		else if(srno==3){
			srno3=rsconfig.getInt("srno");
			method3=rsconfig.getInt("method");
			value3=rsconfig.getInt("value");
			//objdata.put("estPrintDropdown",objtemp);
		}
		else if(srno==4){
			srno4=rsconfig.getInt("srno");
			method4=rsconfig.getInt("method");
			value4=rsconfig.getInt("value");
			//objdata.put("estSpareDiscount",objtemp);
		}
		else if(srno==5){
			srno5=rsconfig.getInt("srno");
			method5=rsconfig.getInt("method");
			value5=rsconfig.getInt("value");
			//objdata.put("estJobtypeGridSearch",objtemp);
		}
		else if(srno==6){
			srno6=rsconfig.getInt("srno");
			method6=rsconfig.getInt("method");
			value6=rsconfig.getInt("value");
			//objdata.put("estLumSum",objtemp);
		}
	}
	JSONObject objtemp=new JSONObject();
	objtemp.put("srno",srno2);
	objtemp.put("method",method2);
	objtemp.put("value",value2);
	objdata.put("serviceConsumables",objtemp);
	
	objtemp=new JSONObject();
	objtemp.put("srno",srno3);
	objtemp.put("method",method3);
	objtemp.put("value",value3);
	objdata.put("estPrintDropdown",objtemp);
	
	objtemp=new JSONObject();
	objtemp.put("srno",srno4);
	objtemp.put("method",method4);
	objtemp.put("value",value4);
	objdata.put("estSpareDiscount",objtemp);
	
	objtemp=new JSONObject();
	objtemp.put("srno",srno5);
	objtemp.put("method",method5);
	objtemp.put("value",value5);
	objdata.put("estJobtypeGridSearch",objtemp);
	
	objtemp=new JSONObject();
	objtemp.put("srno",srno6);
	objtemp.put("method",method6);
	objtemp.put("value",value6);
	objdata.put("estLumSum",objtemp);
	
	objdata.put("estprintconfig",status);
	objdata.put("serviceadvisordata",dao.getServiceAdvisorData(conn));
	
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
finally{
	conn.close();
}
response.getWriter().print(objdata+"");
%>