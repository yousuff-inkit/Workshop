<%@page import="com.connection.*"%>
<%@page import="com.common.*"%>
<%@page import="java.sql.*"%>
<%
String jobcarddocno=request.getParameter("jobcarddocno")==null?"":request.getParameter("jobcarddocno");
ClsConnection objconn=new ClsConnection();
ClsCommon objcommon=new ClsCommon();
Connection conn=null;
String pendingreq="";
try{
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	
	String strsql="select m.voc_no,costdocno from my_mreqm m left join my_mreqd d on m.doc_no=d.rdocno where status=3 and costtype=9 and "+
			" d.qty-out_qty!=0  and costdocno="+jobcarddocno+" group by m.doc_no";
	ResultSet rs=stmt.executeQuery(strsql);
	int i=0;
	while(rs.next()){
		if(i==0){
			pendingreq=rs.getString("voc_no");	
		}
		else{
			pendingreq+=","+rs.getString("voc_no");
		}
		i++;
	}
	
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
finally{
	conn.close();
}
response.getWriter().write(pendingreq);
%>