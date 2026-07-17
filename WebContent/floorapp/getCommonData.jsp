<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
	String jobdocno=request.getParameter("jobdocno")==null?"":request.getParameter("jobdocno").toString();
	Connection conn=null;
	JSONObject objdata=new JSONObject();
	try{
		ClsConnection objconn=new ClsConnection();
		conn=objconn.getMyConnection();
		Statement stmt=conn.createStatement();
		String strgetbaystatus="select base.*,case when base.fullstatus like '%C%' then 'Completed' when base.fullstatus like '%S%' then 'Started' when base.fullstatus like '%N%' then 'Not Attended' else '' end baystatus from ("+
		" select bay.doc_no baydocno,bay.name bayname,concat(date_format(mov.indate,'%d.%m.%Y'),' ',mov.intime) indetails,concat(date_format(mov.outdate,'%d.%m.%Y'),' ',"+
		" mov.outtime) outdetails,case when bay.doc_no=1 then flr.z1 when bay.doc_no=2 then flr.z2 when bay.doc_no=3 then flr.z3 when bay.doc_no=4 then flr.z4 when bay.doc_no=5 then flr.z5 when bay.doc_no=6 then flr.z6 when bay.doc_no=7 then flr.z7 when bay.doc_no=8 then flr.z8 when bay.doc_no=9 then flr.z9 when bay.doc_no=10 then flr.z10 when bay.doc_no=11 then flr.z11 when bay.doc_no=12 then flr.z12 when bay.doc_no=13 then flr.z13 when bay.doc_no=14 then flr.z14 else '' end fullstatus from ws_baymove mov left join ws_bay bay on mov.bayid=bay.doc_no left join ws_floormgmtdata flr on flr.jobdocno=mov.jobcarddocno where mov.jobcarddocno="+jobdocno+") base" ;
		JSONArray bayarray=new JSONArray();
		ResultSet rsgetbaystatus=stmt.executeQuery(strgetbaystatus);
		while(rsgetbaystatus.next()){
			JSONObject objtemp=new JSONObject();
			objtemp.put("bayname",rsgetbaystatus.getString("bayname"));
			objtemp.put("indetails",rsgetbaystatus.getString("indetails"));
			objtemp.put("outdetails",rsgetbaystatus.getString("outdetails"));
			objtemp.put("baystatus",rsgetbaystatus.getString("baystatus"));
			bayarray.add(objtemp);
		}
		objdata.put("baydetails",bayarray);
	}
	catch(Exception e){
		e.printStackTrace();
	}
	finally{
		conn.close();
	}
	response.getWriter().write(objdata+"");
%>