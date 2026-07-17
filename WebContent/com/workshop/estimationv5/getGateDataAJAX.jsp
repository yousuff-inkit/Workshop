<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String gipno=request.getParameter("gipno")==null?"":request.getParameter("gipno");
Connection conn=null;
JSONObject objdata=new JSONObject();
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	String gatedocno="",gatevocno="",gateuserdetails="",gatevehicledetails="",gipdatetime="",gipinsurcomp="",gipclaimno="";
	String sqltest=" and gate.doc_no="+gipno;
	int rateconfig=0;
	String strconfig="select method from gl_config where field_nme='WSESTClientRate'";
	ResultSet rsconfig=stmt.executeQuery(strconfig);
	while(rsconfig.next()){
		rateconfig=rsconfig.getInt("method");
	}
	String strsql="select coalesce(cat.wsserviceamt,0.0) wsserviceamt,coalesce(insur.refname,'') gipinsurcomp,coalesce(gate.claim,'') gipclaimno,date_format(dat.edate,'%d.%m.%Y %H:%i') gipdatetime,convert(concat(coalesce(brd.brand_name,''),' ',coalesce(model.vtype,''),' Reg No: ',coalesce(gate.regno,''),' Plate Code: ',"+
			" coalesce(gate.pltid,''),' YoM: ',coalesce(yom.yom,''),' Others: ',coalesce(gate.vehother,'')),char(200)) vehicledetails,gate.doc_no,gate.voc_no,"+
			" gate.date,gate.cldocno,gate.regno,ac.refname,concat(coalesce(ac.refname,''),' , Address: ',coalesce(ac.address,''),' , Telephone: ',coalesce(ac.per_tel,''),' , Mobile: ',"+
			" coalesce(ac.per_mob,''),' , Mail: ',coalesce(ac.mail1,''),' , Contact Person ',coalesce(ac.contactperson,'')) userdetails from ws_gateinpass gate left join my_acbook "+
			" ac on (gate.cldocno=ac.cldocno and ac.dtype='CRM') left join my_clcatm cat on (ac.catid=cat.doc_no) left join gl_vehplate plate on gate.pltid=plate.doc_no left join gl_vehbrand "+
			" brd on gate.brdid=brd.doc_no left join gl_vehmodel model on gate.modid=model.doc_no left join gl_yom yom on "+
			" gate.yom=yom.doc_no left join my_acbook insur on (gate.insurcldocno=insur.cldocno and insur.dtype='CRM') inner join datalog dat on (dat.brhid=gate.brhid and dat.doc_no=gate.doc_no and dat.dtype='GIP' and dat.entry='A') where gate.status=3 and gate.processstatus=1 and approvalreq=1 and backjob=0"+sqltest;
	System.out.println("GIP Search query:"+strsql);
	ResultSet rs=stmt.executeQuery(strsql);
	while(rs.next()){
		objdata.put("gatedocno", rs.getString("doc_no"));
		objdata.put("gatevocno", rs.getString("voc_no"));
		objdata.put("gateuserdetails", rs.getString("userdetails"));
		objdata.put("gatevehicledetails", rs.getString("vehicledetails"));
		objdata.put("gipdatetime", rs.getString("gipdatetime"));
		objdata.put("gipinsurcomp", rs.getString("gipinsurcomp"));
		objdata.put("gipclaimno", rs.getString("gipclaimno"));
		objdata.put("rateconfig", rateconfig);
		objdata.put("wsserviceamt",rs.getString("wsserviceamt"));
	}
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
finally{
	conn.close();
}
response.getWriter().write(objdata.toString());
%>