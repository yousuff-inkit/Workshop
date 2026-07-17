<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.*"%>
<%@page import="java.sql.CallableStatement"%>
<%	

    ClsConnection ClsConnection=new ClsConnection();
    ClsCommon ClsCommon=new ClsCommon();

	Connection conn = null;

	try{
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();

		String cldocno=request.getParameter("cldocno");
		String drivername=request.getParameter("drivername");
		String dob=request.getParameter("dob");
		String nation=request.getParameter("nation");
		String mobno=request.getParameter("mobno");
		String passportno=request.getParameter("passportno");
		String passexp=request.getParameter("passexp");
		String dlno=request.getParameter("dlno");
		String issdate=request.getParameter("issdate");
		String issfrm=request.getParameter("issfrm");
		String led=request.getParameter("led");
		String ltype=request.getParameter("ltype");
		String visano=request.getParameter("visano");
		String visaexp=request.getParameter("visaexp");
		String drid=request.getParameter("drid");
		String hcdlno=request.getParameter("hcdlno");
		String hcissdate=request.getParameter("hcissdate");
		String hcled=request.getParameter("hcled");
		String branch=request.getParameter("branch");
		String index=request.getParameter("index");
		
		java.sql.Date sqlDob=(dob.trim().equalsIgnoreCase("undefined") || dob.trim().equalsIgnoreCase("NaN") || dob.trim().equalsIgnoreCase("") ||  dob.trim().isEmpty()?null:ClsCommon.changeStringtoSqlDate(dob.trim()));
		java.sql.Date sqlPassExp=(passexp.trim().equalsIgnoreCase("undefined") || passexp.trim().equalsIgnoreCase("NaN") || passexp.trim().equalsIgnoreCase("") ||  passexp.trim().isEmpty()?null:ClsCommon.changeStringtoSqlDate(passexp.trim()));
		java.sql.Date sqlIssDate=(issdate.trim().equalsIgnoreCase("undefined") || issdate.trim().equalsIgnoreCase("NaN") || issdate.trim().equalsIgnoreCase("") ||  issdate.trim().isEmpty()?null:ClsCommon.changeStringtoSqlDate(issdate.trim()));
		java.sql.Date sqlLed=(led.trim().equalsIgnoreCase("undefined") || led.trim().equalsIgnoreCase("NaN") || led.trim().equalsIgnoreCase("") ||  led.trim().isEmpty()?null:ClsCommon.changeStringtoSqlDate(led.trim()));
		java.sql.Date sqlVisaExp=(visaexp.trim().equalsIgnoreCase("undefined") || visaexp.trim().equalsIgnoreCase("NaN") || visaexp.trim().equalsIgnoreCase("") ||  visaexp.trim().isEmpty()?null:ClsCommon.changeStringtoSqlDate(visaexp.trim()));
		java.sql.Date sqlHcIssDate=(hcissdate.trim().equalsIgnoreCase("undefined") || hcissdate.trim().equalsIgnoreCase("NaN") || hcissdate.trim().equalsIgnoreCase("") ||  hcissdate.trim().isEmpty()?null:ClsCommon.changeStringtoSqlDate(hcissdate.trim()));
		java.sql.Date sqlHcLed=(hcled.trim().equalsIgnoreCase("undefined") || hcled.trim().equalsIgnoreCase("NaN") || hcled.trim().equalsIgnoreCase("") ||  hcled.trim().isEmpty()?null:ClsCommon.changeStringtoSqlDate(hcled.trim()));
		
		CallableStatement stmtCRM=null;

		stmtCRM = conn.prepareCall("INSERT INTO gl_drdetails(name,dob,nation,mobno,passport_no,pass_exp,dlno,issdate,issfrm,led,ltype,visano,visa_exp,hcdlno,hcissdate,hcled,sr_no,dtype,branch,cldocno,doc_no) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
		
		stmtCRM.setString(1,(drivername.trim().equalsIgnoreCase("undefined") || drivername.trim().equalsIgnoreCase("NaN") || drivername.trim().equalsIgnoreCase("") ||drivername.trim().isEmpty()?0:drivername.trim()).toString());
		stmtCRM.setDate(2,sqlDob);
		stmtCRM.setString(3,(nation.trim().equalsIgnoreCase("undefined") || nation.trim().equalsIgnoreCase("NaN") || nation.trim().equalsIgnoreCase("") ||nation.trim().isEmpty()?0:nation.trim()).toString());
		stmtCRM.setString(4,(mobno.trim().equalsIgnoreCase("undefined") || mobno.trim().equalsIgnoreCase("NaN") || mobno.trim().equalsIgnoreCase("") ||mobno.trim().isEmpty()?0:mobno.trim()).toString());
		stmtCRM.setString(5,(passportno.trim().equalsIgnoreCase("undefined") || passportno.trim().equalsIgnoreCase("NaN") || passportno.trim().equalsIgnoreCase("") ||passportno.trim().isEmpty()?0:passportno.trim()).toString());
		stmtCRM.setDate(6,sqlPassExp);
		stmtCRM.setString(7,(dlno.trim().equalsIgnoreCase("undefined") || dlno.trim().equalsIgnoreCase("NaN") || dlno.trim().equalsIgnoreCase("") ||dlno.trim().isEmpty()?0:dlno.trim()).toString());
		stmtCRM.setDate(8,sqlIssDate);
		stmtCRM.setString(9,(issfrm.trim().equalsIgnoreCase("undefined") || issfrm.trim().equalsIgnoreCase("NaN") || issfrm.trim().equalsIgnoreCase("") ||issfrm.trim().isEmpty()?0:issfrm.trim()).toString());
		stmtCRM.setDate(10,sqlLed);
		stmtCRM.setString(11,(ltype.trim().equalsIgnoreCase("undefined") || ltype.trim().equalsIgnoreCase("NaN") || ltype.trim().equalsIgnoreCase("") ||ltype.trim().isEmpty()?0:ltype.trim()).toString());
		stmtCRM.setString(12,(visano.trim().equalsIgnoreCase("undefined") || visano.trim().equalsIgnoreCase("NaN") || visano.trim().equalsIgnoreCase("") ||visano.trim().isEmpty()?0:visano.trim()).toString());
		stmtCRM.setDate(13,sqlVisaExp);
		stmtCRM.setString(14,(hcdlno.trim().equalsIgnoreCase("undefined") || hcdlno.trim().equalsIgnoreCase("NaN") || hcdlno.trim().equalsIgnoreCase("") ||hcdlno.trim().isEmpty()?0:hcdlno.trim()).toString());
		stmtCRM.setDate(15,sqlHcIssDate);
		stmtCRM.setDate(16,sqlHcLed);
		stmtCRM.setInt(17,(Integer.parseInt(index)+1));
		stmtCRM.setString(18,"CRM");
		stmtCRM.setString(19,branch);
		stmtCRM.setInt(20,Integer.parseInt(cldocno));
		stmtCRM.setInt(21,Integer.parseInt(cldocno));
	    int val = stmtCRM.executeUpdate();
		
		response.getWriter().write(index);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
%>