<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String gipno=request.getParameter("gipno")==null?"":request.getParameter("gipno");
Connection conn=null;
String gatedocno="",gatevocno="",gateuserdetails="",gatevehicledetails="",labdiscount="",sparemarkup="";
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	String sqltest=" and gate.doc_no="+gipno;
	String strsql="select round(coalesce(prv.sparemarkup,0),2) sparemarkup,round(coalesce(prv.labdiscount,0),2) labdiscount,convert(concat(coalesce(brd.brand_name,''),' ',coalesce(model.vtype,''),' Reg No: ',coalesce(gate.regno,''),' Plate Code: ',"+
			" coalesce(gate.pltid,''),' YoM: ',coalesce(yom.yom,''),' Others: ',coalesce(gate.vehother,'')),char(200)) vehicledetails,gate.doc_no,gate.voc_no,"+
			" gate.date,gate.cldocno,gate.regno,ac.refname,concat(coalesce(ac.refname,''),' , Address: ',coalesce(ac.address,''),' , Telephone: ',coalesce(ac.per_tel,''),' , Mobile: ',"+
			" coalesce(ac.per_mob,''),' , Mail: ',coalesce(ac.mail1,''),' , Contact Person ',coalesce(ac.contactperson,'')) userdetails from ws_gateinpass gate left join my_acbook "+
			" ac on (gate.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_vehplate plate on gate.pltid=plate.doc_no left join gl_vehbrand "+
			" brd on gate.brdid=brd.doc_no left join gl_vehmodel model on gate.modid=model.doc_no left join gl_yom yom on "+
			" gate.yom=yom.doc_no left join my_clprivilage prv on ac.privillege=prv.doc_no where gate.status=3 and gate.processstatus=1 and approvalreq=1"+sqltest;
	System.out.println("GIP Search query:"+strsql);
	ResultSet rs=stmt.executeQuery(strsql);
	while(rs.next()){
		gatedocno=rs.getString("doc_no");
		gatevocno=rs.getString("voc_no");
		gateuserdetails=rs.getString("userdetails");
		gatevehicledetails=rs.getString("vehicledetails");
		sparemarkup=rs.getString("sparemarkup");
		labdiscount=rs.getString("labdiscount");
	}
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
finally{
	conn.close();
}
response.getWriter().write(gatedocno+"::"+gatevocno+"::"+gateuserdetails+"::"+gatevehicledetails+"::"+sparemarkup+"::"+labdiscount);
%>