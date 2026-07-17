<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String jobcard=request.getParameter("jobcard")==null?"":request.getParameter("jobcard");
String vehicledetails="";
ClsConnection objconn=new ClsConnection();
Connection conn=null;
try{
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	
	String strsql="";
	if(!jobcard.equalsIgnoreCase("")){
		strsql="select concat(coalesce(gate.regno,''),' ',coalesce(gate.pltid,''),' ',coalesce(brd.brand_name,''),' ',coalesce(model.vtype,''),' ',"+
		" coalesce(grp.gname,'')) vehicledetails from ws_jobcard job left join ws_estm est on (job.refno=est.doc_no and job.reftype='EST') left "+
		" join ws_gateinpass gate on est.gipno=gate.doc_no left join gl_vehbrand brd on gate.brdid=brd.doc_no left join gl_vehmodel model on "+
		" gate.modid=model.doc_no left join gl_vehgroup grp on model.groupid=grp.doc_no where job.doc_no="+jobcard;
		ResultSet rs=stmt.executeQuery(strsql);
		int i=0;
		while(rs.next()){
			vehicledetails=rs.getString("vehicledetails");
		}		
	}
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(vehicledetails);
%>