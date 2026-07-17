<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String reqsrno=request.getParameter("reqsrno")==null?"":request.getParameter("reqsrno");
String calcdocno=request.getParameter("calcdocno")==null?"":request.getParameter("calcdocno");
String reqdocno=request.getParameter("reqdocno")==null?"":request.getParameter("reqdocno");
String total=request.getParameter("total")==null?"":request.getParameter("total");
String residalvalue=request.getParameter("residalvalue")==null?"":request.getParameter("residalvalue");
String vehiclecost=request.getParameter("vehiclecost")==null?"":request.getParameter("vehiclecost");
String excesskmrate=request.getParameter("excesskmrate")==null?"":request.getParameter("excesskmrate");
String landedcost=request.getParameter("landedcost")==null?"":request.getParameter("landedcost");
String margincost=request.getParameter("margincost")==null?"":request.getParameter("margincost");
String daimler=request.getParameter("daimler")==null?"":request.getParameter("daimler");

Connection conn=null;
int status=0;
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	conn.setAutoCommit(false);
	Statement stmt=conn.createStatement();
	String strsql="update gl_leasecalcreq set totalvalue="+total+",savestatus=1,residalvalue="+residalvalue+",prchcost="+vehiclecost+",excesskmrate="+excesskmrate+",landedcost="+landedcost+",margin="+margincost+",daimlersupport="+daimler+" where rdocno="+calcdocno+" and leasereqdocno="+reqdocno+" and"+
			" reqsrno="+reqsrno;
	System.out.println(strsql);
	int updateval=stmt.executeUpdate(strsql);
	if(updateval>0){
		String strupdate="update gl_lprd set masterstatus=2 where rdocno="+reqdocno+" and sr_no="+reqsrno;
		int lprdupdate=stmt.executeUpdate(strupdate);
		if(lprdupdate>0){
			status=1; 			
			conn.commit();
		}
	}
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(status+"");
%>