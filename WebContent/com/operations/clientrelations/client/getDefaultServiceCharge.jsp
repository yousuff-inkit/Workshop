<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%	
	Connection conn = null;
	
	try{
		ClsConnection connDAO = new ClsConnection();
	 	conn = connDAO.getMyConnection();
		Statement stmt = conn.createStatement();
		
		String strSql = "select field_nme,round(value,2) value from gl_config where method=1 and field_nme in ('saliksrv','trafficsrv')";
		ResultSet rs = stmt.executeQuery(strSql);
		
		String fieldname="";
		String value="";
		while(rs.next()) {
			fieldname+=rs.getString("field_nme")+",";		
			value+=rs.getString("value")+",";
	  		} 
		
		fieldname=fieldname.substring(0, fieldname.length()>0?fieldname.length()-1:0);
		
		response.getWriter().write(fieldname+"####"+value);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  
