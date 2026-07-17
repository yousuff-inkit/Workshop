<%@page import="java.util.ArrayList"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.common.ClsCommon"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.connection.ClsConnection"%>
<%@page import="java.sql.Connection"%>
<%
String contractdocno=request.getParameter("contractdocno")==null?"":request.getParameter("contractdocno");
String mode=request.getParameter("mode")==null?"":request.getParameter("mode");

Connection conn=null;
JSONObject objdata=new JSONObject();
JSONArray gridarray=new JSONArray();
int errorstatus=0;
String errormsg="";

try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	
	if(mode.equalsIgnoreCase("1")){
		//Getting DataFields
		JSONArray fieldarray=new JSONArray();
		String strest="select * from ws_estm where pkgcontractdocno="+contractdocno+" and status=3";
		System.out.println(strest);
		ResultSet rsest=stmt.executeQuery(strest);
		JSONArray estarray=new JSONArray();
		while(rsest.next()){
			JSONObject objtemp=new JSONObject();
			objtemp.put("estdocno",rsest.getString("doc_no"));
			objtemp.put("estvocno",rsest.getString("voc_no"));
			estarray.add(objtemp);
			
		}
		objdata.put("fieldarray",estarray);
	}
	else if(mode.equalsIgnoreCase("2")){
		ArrayList<String> estdocarray=new ArrayList();
		String strestdoc="select * from ws_estm where pkgcontractdocno="+contractdocno+" and status=3";
		ResultSet rsestdoc=stmt.executeQuery(strestdoc);
		while(rsestdoc.next()){
			estdocarray.add(rsestdoc.getString("doc_no"));
		}
		
		String sqlfilters="",sqlselect="";
		for(int i=0;i<estdocarray.size();i++){
			String estdocno=estdocarray.get(i);
			String lab="lab"+i;
			String sp="sp"+i;
			sqlselect+=",convert(if(cntdet.detcode='L',"+lab+".qty,"+sp+".qty),char(15)) est"+i;
			sqlfilters+=" left join (select pkgcontractdocno contractdocno,"+lab+".contractdetdocno,"+lab+".hrs qty from ws_estm est left join ws_estlabour "+lab+" on"+
			" est.doc_no="+lab+".rdocno where est.status=3 and doc_no="+estdocno+") "+lab+" on ("+lab+".contractdocno=cnt.doc_no and "+lab+".contractdetdocno=cntdet.detdocno)"+
			" left join (select pkgcontractdocno contractdocno,"+sp+".contractdetdocno,"+sp+".qty from ws_estm est left join ws_estspare "+sp+" on"+
			" est.doc_no="+sp+".rdocno where est.status=3 and doc_no="+estdocno+") "+sp+" on ("+sp+".contractdocno=cnt.doc_no and "+sp+".contractdetdocno=cntdet.detdocno)";		
		}
		
		String strsql="select cntdet.detcode,cnt.doc_no contractdocno,cntdet.itemdesc,cntdet.pkgorgqty,cntdet.pkgqty"+sqlselect+" from ws_packagecontract cnt"+
		" left join (select doc_no detdocno,concat(strjobtype,' - ',jobdesc) itemdesc,'L' detcode,pkgorgqty,contractdocno,pkgqty from ws_pkgcontractlabour union all"+
		" select doc_no detdocno,spdesc itemdesc,'S' detcode,pkgorgqty,contractdocno,pkgqty from ws_pkgcontractspare) cntdet on cnt.doc_no=cntdet.contractdocno"+
		" "+sqlfilters+" where cnt.doc_no="+contractdocno;
		System.out.println(strsql);
		ResultSet rs=stmt.executeQuery(strsql);
		ClsCommon objcommon=new ClsCommon();
		gridarray=objcommon.convertToJSON(rs);
	}
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
if(mode.equalsIgnoreCase("1")){
	response.getWriter().write(objdata+"");	
}
else if(mode.equalsIgnoreCase("2")){
	response.getWriter().write(gridarray+"");
}

%>