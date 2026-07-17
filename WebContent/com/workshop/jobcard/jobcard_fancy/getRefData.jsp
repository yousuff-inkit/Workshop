<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String estdocno=request.getParameter("estdocno")==null?"":request.getParameter("estdocno");
Connection conn=null;
String refno="",hidrefno="",regno="",vehicledetails="",userdetails="",cldocno="";
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	String strsql="select ac.refname,gate.regno,gate.voc_no gatevocno,gate.doc_no gatedocno,est.doc_no estdocno,est.brhid,est.voc_no estvocno,est.date refdate,ac.cldocno,"+
			" concat(ac.refname,' , Address: ',ac.address,' , Telephone: ',ac.per_tel,' , Mobile: ',ac.per_mob,' , Mail: ',"+
			" ac.mail1,' , Contact Person ',ac.contactperson) userdetails,convert(concat(coalesce(brd.brand_name,''),' ',"+
			" coalesce(model.vtype,''),' Reg No: ',coalesce(gate.regno,''),' Plate Code: ',coalesce(gate.pltid,''),' YoM: ',"+
			" coalesce(yom.yom,''),' Others: ',coalesce(gate.vehother,'')),char(200)) vehicledetails "+
			" from ws_estm est left join ws_gateinpass gate on est.gipno=gate.doc_no left join my_acbook ac on "+
			" (gate.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_vehbrand brd on gate.brdid=brd.doc_no left join "+
			" gl_vehmodel model on gate.modid=model.doc_no left join gl_vehplate plate on gate.pltid=plate.doc_no left join "+
			" gl_yom yom on gate.yom=yom.doc_no where est.status=3 and est.doc_no="+estdocno+" group by est.doc_no ";
	
	ResultSet rs=stmt.executeQuery(strsql);
	while(rs.next()){
		refno=rs.getString("estvocno");
        hidrefno=rs.getString("estdocno");
    	regno=rs.getString("regno");
	    vehicledetails=rs.getString("vehicledetails");
	    userdetails=rs.getString("userdetails");
	    cldocno=rs.getString("refname");
	}
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
finally{
	conn.close();
}
response.getWriter().write(refno+"::"+hidrefno+"::"+regno+"::"+vehicledetails+"::"+userdetails+"::"+cldocno);
%>