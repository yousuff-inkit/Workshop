
<%@page import="java.sql.*"%>
<%@page import="com.common.ClsCommon"%>
<%@page import="com.connection.ClsConnection"%>
<% 

ClsConnection connDAO = new ClsConnection();
ClsCommon commonDAO= new ClsCommon();
Connection conn=null;
String clockDocno=request.getParameter("clockDocno")==null?"":request.getParameter("clockDocno");
String closedate=request.getParameter("closedate")==null?"":request.getParameter("closedate");

java.sql.Date sqlclosedate=null;
if(!closedate.equalsIgnoreCase("") && closedate!=null){
	sqlclosedate=commonDAO.changeStringtoSqlDate(closedate);
}

String closetime=request.getParameter("closetime")==null?"":request.getParameter("closetime");

//String excessamt=request.getParameter("excessamt")==null || request.getParameter("excessamt").equalsIgnoreCase("")?"0":request.getParameter("excessamt");


int errorstatus=0;
int x=0;
try{
	 conn=connDAO.getMyConnection();
	 conn.setAutoCommit(false);
	 	
		Statement stmt = conn.createStatement ();
		
		
		
		String strSql1 = "update ws_clockin set closedate=?,closetime=? where doc_no="+clockDocno;
		
		PreparedStatement ps=conn.prepareStatement(strSql1);	
		ps.setDate(1, sqlclosedate);
		ps.setString(2, closetime);	
		x=ps.executeUpdate();
		

		

		if(x<=0){
			errorstatus=1;
		}
		int jobcard=0;
		String strgetjobcard="select jcno from ws_clockin where doc_no="+clockDocno;
		ResultSet rsgetjobcard=stmt.executeQuery(strgetjobcard);
		while(rsgetjobcard.next()){
			jobcard=rsgetjobcard.getInt("jcno");
		}
		String strgetlabhrs="select sum(lab.hrs) labhrs from ws_jobcard jc left join ws_estm es on (jc.refno=es.doc_no and jc.reftype='EST') left "+
		" join ws_estlabour lab on es.doc_no=lab.rdocno where jc.doc_no="+jobcard+" group by jc.doc_no";
		ResultSet rsgetlabhrs=stmt.executeQuery(strgetlabhrs);
		double labhrs=0.0;
		while(rsgetlabhrs.next()){
			labhrs=rsgetlabhrs.getDouble("labhrs");
		}
		String strgetsumclock="select sum((TIMESTAMPDIFF(minute,cast(concat(clk.startdate,' ',clk.starttime)as datetime),cast(concat(clk.closedate,' ',clk.closetime)as"+
				" datetime))/60)) actualhrs,sum((TIMESTAMPDIFF(minute,cast(concat(clk.startdate,' ',clk.starttime)as datetime),"+
						" cast(concat(clk.closedate,' ',clk.closetime)as datetime))/60))-"+labhrs+" hrsdiff from ws_clockin where jcno="+jobcard;
		ResultSet rsgetsumclock=stmt.executeQuery(strgetsumclock);
		double actualhrs=0.0,hrsdiff=0.0;
		while(rsgetsumclock.next()){
			actualhrs=rsgetsumclock.getDouble("actualhrs");
			hrsdiff=rsgetsumclock.getDouble("hrsdiff");
		}
		String strupdatefloor="update ws_floormgmtdata set actualhrs="+actualhrs+",hrsdiff="+hrsdiff+" where jobdocno="+jobcard;
		int updatefloor=stmt.executeUpdate(strupdatefloor);
		if(updatefloor<=0){
			errorstatus=1;
			System.out.println("Update Floor Mgmt Error");
		}
		
		if(errorstatus==0){
			conn.commit();
		}
}catch(Exception e){
	e.printStackTrace();
	conn.close();
}
finally{
	conn.close();
}
response.getWriter().write(errorstatus+"");
%>