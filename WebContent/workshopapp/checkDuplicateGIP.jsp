
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
Connection conn=null;
JSONObject objdata=new JSONObject();
try{
	String regno=request.getParameter("regno")==null?"":request.getParameter("regno");
	String platecode=request.getParameter("platecode")==null?"":request.getParameter("platecode");
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	String strsql="select doc_no,voc_no from ws_gateinpass where regno='"+regno+"' and pltid='"+platecode+"' and processstatus<8";
	System.out.println(strsql);
	ResultSet rs=stmt.executeQuery(strsql);
	int gipexist=0;
	String gipvocno="";
	while(rs.next()){
		if(rs.getInt("doc_no")>0){
			gipexist=1;
			gipvocno=rs.getString("voc_no");
		}
	}
	objdata.put("gipexist",gipexist);
	objdata.put("gipvocno",gipvocno);
	response.getWriter().write(objdata+"");
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
%>