<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
Connection conn=null;
JSONObject objconfig=new JSONObject();
int status=0;   
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	String str="select 1 srno,field_nme,method,coalesce(value,0) value from gl_config where field_nme='PAGEstimationPrint' union all"+
		" select 2 srno,field_nme,method,coalesce(value,0) value from gl_config where field_nme='serviceConsumables' union all"+
		" select 3 srno,field_nme,method,coalesce(value,0) value from gl_config where field_nme='printEstDropdownOrder' union all"+
		" select 4 srno,field_nme,method,coalesce(value,0) value from gl_config where field_nme='estSpareDiscount' union all"+
		" select 5 srno,field_nme,method,coalesce(value,0) value from gl_config where field_nme='estJobtypeGridSearch' union all"+
		" select 6 srno,field_nme,method,coalesce(value,0) value from gl_config where field_nme='estLumSum' union all"+
		" select 7 srno,field_nme,method,coalesce(value,0) value from gl_config where field_nme='WSPackage'";
	ResultSet rs=stmt.executeQuery(str);
	int srno1=1,method1=0,value1=0;
	int srno2=2,method2=0,value2=0;
	int srno3=3,method3=0,value3=0;
	int srno4=4,method4=0,value4=0;
	int srno5=5,method5=0,value5=0;
	int srno6=6,method6=0,value6=0;
	int srno7=7,method7=0,value7=0;
	while(rs.next()){
		JSONObject objtemp=new JSONObject();
		int srno=rs.getInt("srno");
		objtemp.put("srno",rs.getInt("srno"));
		objtemp.put("method",rs.getInt("method"));
		objtemp.put("value",rs.getInt("value"));
		if(srno==1){
			srno1=rs.getInt("srno");
			method1=rs.getInt("method");
			value1=rs.getInt("value");
			//objconfig.put("estPagePrint",objtemp);
		}
		if(srno==2){
			srno2=rs.getInt("srno");
			method2=rs.getInt("method");
			value2=rs.getInt("value");
			//objconfig.put("serviceConsumables",objtemp);
		}
		else if(srno==3){
			srno3=rs.getInt("srno");
			method3=rs.getInt("method");
			value3=rs.getInt("value");
			//objconfig.put("estPrintDropdown",objtemp);
		}
		else if(srno==4){
			srno4=rs.getInt("srno");
			method4=rs.getInt("method");
			value4=rs.getInt("value");
			//objconfig.put("estSpareDiscount",objtemp);
		}
		else if(srno==5){
			srno5=rs.getInt("srno");
			method5=rs.getInt("method");
			value5=rs.getInt("value");
			//objconfig.put("estJobtypeGridSearch",objtemp);
		}
		else if(srno==6){
			srno6=rs.getInt("srno");
			method6=rs.getInt("method");
			value6=rs.getInt("value");
			//objconfig.put("estLumSum",objtemp);
		}
		else if(srno==7){
			srno7=rs.getInt("srno");
			method7=rs.getInt("method");
			value7=rs.getInt("value");
			//objconfig.put("estLumSum",objtemp);
		}
	}
	JSONObject objtemp=new JSONObject();
	objtemp.put("srno",srno1);
	objtemp.put("method",method1);
	objtemp.put("value",value1);
	objconfig.put("estPagePrint",objtemp);
	
	objtemp=new JSONObject();
	objtemp.put("srno",srno2);
	objtemp.put("method",method2);
	objtemp.put("value",value2);
	objconfig.put("serviceConsumables",objtemp);
	
	objtemp=new JSONObject();
	objtemp.put("srno",srno3);
	objtemp.put("method",method3);
	objtemp.put("value",value3);
	objconfig.put("estPrintDropdown",objtemp);
	
	objtemp=new JSONObject();
	objtemp.put("srno",srno4);
	objtemp.put("method",method4);
	objtemp.put("value",value4);
	objconfig.put("estSpareDiscount",objtemp);
	
	objtemp=new JSONObject();
	objtemp.put("srno",srno5);
	objtemp.put("method",method5);
	objtemp.put("value",value5);
	objconfig.put("estJobtypeGridSearch",objtemp);
	
	objtemp=new JSONObject();
	objtemp.put("srno",srno6);
	objtemp.put("method",method6);
	objtemp.put("value",value6);
	objconfig.put("estLumSum",objtemp);
	
	objtemp=new JSONObject();
	objtemp.put("srno",srno7);
	objtemp.put("method",method7);
	objtemp.put("value",value7);
	objconfig.put("WSPackage",objtemp);
	
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
finally{
	conn.close();
}
System.out.println(objconfig);
response.getWriter().print(objconfig+"");
%>