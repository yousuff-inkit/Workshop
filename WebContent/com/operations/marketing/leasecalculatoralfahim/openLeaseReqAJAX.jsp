<%@page import="com.connection.ClsConnection"%>
<%@page import="com.common.ClsCommon"%>
<%@page import="com.operations.marketing.leasecalculatoralfahim.*" %>
<%@page import="java.sql.*" %>
<%ClsConnection objconn=new ClsConnection();
ClsCommon objcommon=new ClsCommon();

String masterdoc_no=request.getParameter("masterdoc_no")==null?"0":request.getParameter("masterdoc_no");
Connection conn=null;
String leasereqdoc="",hidleasereqdoc="",leasereqclient="",clientmob="";
try{
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	String strsql="select req.voc_no,req.doc_no,req.date,req.remarks,if(req.reqtype=1,ac.cldocno,req.cldocno) cldocno,coalesce(if(req.reqtype=1,ac.refname,req.name),'') "+
			" name,coalesce(if(req.reqtype=1,ac.address,req.com_add1),'') address,coalesce(if(req.reqtype=1,ac.com_mob,req.mob),'') mobile,coalesce(if(req.reqtype=1,ac.mail1,req.email),'') "+
			" email,req.reqtype from gl_lprm req left join my_acbook ac on (req.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_leasecalcm m on "+
			" (req.doc_no=m.reqdoc) where req.status=3  and m.reqdoc is null and req.doc_no="+masterdoc_no;
	ResultSet rs=stmt.executeQuery(strsql);
	while(rs.next()){
		leasereqdoc=rs.getString("voc_no");
		hidleasereqdoc=rs.getString("doc_no");
		leasereqclient=rs.getString("name");
		clientmob=rs.getString("mobile");
	}
	stmt.close();
	
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(leasereqdoc+"####"+hidleasereqdoc+"####"+leasereqclient+"####"+clientmob);
%>