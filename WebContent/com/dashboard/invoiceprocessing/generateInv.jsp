<%@page import="java.util.ArrayList"%>
<%@page import="com.workshop.wsinvoice.ClsWSInvoiceDAO"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.common.*"%>
<%
Connection conn=null;
String jobdocno=request.getParameter("jobdocno")==null?"":request.getParameter("jobdocno");
int errorstatus=0;
try{
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	ClsWSInvoiceDAO invoicedao=new ClsWSInvoiceDAO();
	ArrayList<String>invarray=new ArrayList();
	ArrayList<String>invoicearray=new ArrayList();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	for(int i=0;i<invarray.size();i++){
		java.sql.Date sqldate=null;
		String remarks=invarray.get(i).split("::")[2];
		int cldocno=0;
		String strsql="select curdate() curdate,gate.cldocno, from ws_jobcard job left join ws_estm est on (job.reftype='EST' and job.refno=est.doc_no) "+
		" left join ws_gateinpass gate on est.gipno=gate.doc_no where job.doc_no="+jobdocno;
		ResultSet rsgetvalues=stmt.executeQuery(strsql);
		while(rsgetvalues.next()){
			sqldate=rsgetvalues.getDate("curdate");
			cldocno=rsgetvalues.getInt("cldocno");
		}
		
		/* 
		int insertval = invoicedao.insert(sqldate, "JC",jobdocno,cldocno+"", getInvoicetoacno(),getExcessamountacno(), getTotal(),
		getDiscount(),getExcessamount(), getNettotal(), getRemarks(),session, request, getMode(), getFormdetailcode(),getBrchName(), invoicearray, 
		conn, getTaxpercent(),getTaxamount(), getTaxtotal(),getHidchksaperateinvoice(), getTempinvoicetoacno());
		if (insertval > 0) {
			int billtoinsur = invoicedao.checkBillToInsurance(getHidrefno(), conn);
			if (getHidchksaperateinvoice().equalsIgnoreCase("1") && billtoinsur == 1) {
				ArrayList<String> excessinvarray = new ArrayList<>();
				excessinvarray = invoicedao.getExcessInvDetails(conn, getHidrefno(), getExcessamount());
				int saperateInvInsert = invoicedao.saperateInvInsert(sqldate,getCmbreftype(), getHidrefno(),getCldocno(), getInvoicetoacno(),
				getExcessamountacno(), getTotal(),getDiscount(), getExcessamount(),getNettotal(), getRemarks(),session, request, getMode(),
				getFormdetailcode(), getBrchName(),excessinvarray, conn, "0", "0",getTaxtotal(), insertval,getInvoicetoacno());
			}
		} */
		
	}

	
}
catch(Exception e){
	e.printStackTrace();
	errorstatus=1;
}
finally{
	conn.close();
}
response.getWriter().write(errorstatus);
%>