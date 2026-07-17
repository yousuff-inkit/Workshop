<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String jobcard=request.getParameter("jobcard")==null?"":request.getParameter("jobcard");
String vehicledetails="";
String completestatus="";
ClsConnection objconn=new ClsConnection();
Connection conn=null;
String errormsg="";
try{
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	
	String strsql="";
	if(!jobcard.equalsIgnoreCase("")){
		strsql="select job.complete,concat(coalesce(gate.regno,''),' ',coalesce(gate.pltid,''),' ',coalesce(brd.brand_name,''),' ',coalesce(model.vtype,''),' ',"+
		" coalesce(grp.gname,'')) vehicledetails from ws_jobcard job left join ws_estm est on (job.refno=est.doc_no and job.reftype='EST') left "+
		" join ws_gateinpass gate on est.gipno=gate.doc_no left join gl_vehbrand brd on gate.brdid=brd.doc_no left join gl_vehmodel model on "+
		" gate.modid=model.doc_no left join gl_vehgroup grp on model.groupid=grp.doc_no where job.status=3 and job.voc_no="+jobcard;
		ResultSet rs=stmt.executeQuery(strsql);
		int i=0;
		while(rs.next()){
			vehicledetails=rs.getString("vehicledetails");
			completestatus=rs.getString("complete");
			i++;
		}
		if(i==0){
			errormsg="Couldn't find Job Card,Please Choose Another";
		}
		if(i>0){
			if(Integer.parseInt(completestatus)==1){
				errormsg="Job Already Completed,Please Choose Another";
			}			
		}
		
	}
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(completestatus+"::"+vehicledetails+"::"+errormsg);
%>