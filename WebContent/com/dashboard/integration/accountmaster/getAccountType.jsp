<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	

	Connection conn = null;
	ClsConnection ClsConnection=new ClsConnection();

	try{
	 	conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		
		String strSql = "select distinct gr_type,grno from my_agrp order by grno";
		ResultSet rs = stmt.executeQuery(strSql);
		
		String accounttype="";
		String accounttypeid="";
		while(rs.next()) {
			accounttype+=rs.getString("gr_type")+",";		
			accounttypeid+=rs.getString("grno")+",";
	  		} 
		
		accounttype=accounttype.substring(0, accounttype.length()>0?accounttype.length()-1:0);
		
		response.getWriter().write(accounttype+"####"+accounttypeid);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  
