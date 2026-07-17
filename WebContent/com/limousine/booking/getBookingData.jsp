<%@page import="com.connection.ClsConnection"%>
<%@page import="java.sql.*"%>
<%
String docno=request.getParameter("docno")==null?"0":request.getParameter("docno");

ClsConnection objconn=new ClsConnection();
Connection conn=null;
try{
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	String sqltest="";
	if(!docno.equalsIgnoreCase("")){
		sqltest+=" and book.doc_no="+docno;
	}
	String description="",guestno="",hidchknewguest="",client="",cldocno="",mobile="",licenseno="",guestname="",guestcontactno="";
	java.sql.Date sqldate=null;
	
	String str="select book.desc1 description,book.doc_no,book.date,book.guestno,book.newguest hidchknewguest,ac.refname,ac.cldocno,ac.per_mob,dr.dlno,guest.guest,guest.guestcontactno"+
			" from gl_limobookm book left join gl_limoguest guest on book.guestno=guest.doc_no left join my_acbook ac on (book.cldocno=ac.cldocno and ac.dtype='CRM') "+
			" left join gl_drdetails dr on (ac.cldocno=dr.cldocno and ac.dtype='CRM') where book.status=3 "+sqltest+" group by book.doc_no";
	ResultSet rs=stmt.executeQuery(str);
	while(rs.next()){
		description=rs.getString("description");
		sqldate=rs.getDate("date");
		guestno=rs.getString("guestno");
		hidchknewguest=rs.getString("hidchknewguest");
		client=rs.getString("refname");
		cldocno=rs.getString("cldocno");
		mobile=rs.getString("per_mob");
		licenseno=rs.getString("dlno");
		guestname=rs.getString("guest");
		guestcontactno=rs.getString("guestcontactno");
		
	}
	stmt.close();
	response.getWriter().write(description+"::"+docno+"::"+sqldate+"::"+guestno+"::"+hidchknewguest+"::"+client+"::"+cldocno+"::"+mobile+"::"+licenseno+"::"+guestname+"::"+guestcontactno);
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
%>