<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.*"%>
<%	
ClsConnection ClsConnection=new ClsConnection();

ClsCommon ClsCommon=new ClsCommon();

	Connection conn = null;

	try{
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		
		String dayDiff="0",monthDiff="0";
		int difference=0,columns=0;
		
		java.sql.Date sqlFromDate=null;
		java.sql.Date sqlToDate=null;
		
		String fromdate=request.getParameter("fromdate");
		String todate=request.getParameter("todate");
		
	    if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0"))){
	    	sqlFromDate=ClsCommon.changeStringtoSqlDate(fromdate);
		}
	    
	    if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0"))){
	    	sqlToDate=ClsCommon.changeStringtoSqlDate(todate);
		}
	    
		String sql = "select TIMESTAMPDIFF(MONTH, '"+sqlFromDate+"', '"+sqlToDate+"') monthdiff";
		ResultSet rs1 = stmt.executeQuery(sql);
			
		while(rs1.next()) {
			difference=rs1.getInt("monthdiff");
		} 
	    
	    if(difference>30){
				columns = 1;
		}
		
		response.getWriter().write(difference+"***"+columns);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  