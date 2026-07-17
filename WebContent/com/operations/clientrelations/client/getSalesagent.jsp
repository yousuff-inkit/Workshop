<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%	
	Connection conn = null;
	
	try{
		ClsConnection connDAO = new ClsConnection();
	 	conn = connDAO.getMyConnection();
		Statement stmt = conn.createStatement();
		int val = 0;
		
		String salesagent="";
		String salesagentid="";
		String strSql = "SELECT sal_name,doc_no from my_salm where status<>7 and salesuserlink='"+session.getAttribute("USERID").toString()+"'"; 
		ResultSet rs = stmt.executeQuery(strSql);
		
		while(rs.next()) {
			salesagent+=rs.getString("sal_name")+",";		
			salesagentid+=rs.getString("doc_no")+",";
			val = 1;
		}
		
		
		if(val==0) {
			String strSql1 = "SELECT sal_name,doc_no from my_salm where status<>7";
			ResultSet rs1 = stmt.executeQuery(strSql1);
			
			
			while(rs1.next()) {
				salesagent+=rs1.getString("sal_name")+",";		
				salesagentid+=rs1.getString("doc_no")+",";
		  		} 
		}
		
		salesagent=salesagent.substring(0, salesagent.length()>0?salesagent.length()-1:0);
		
		response.getWriter().write(salesagent+"####"+salesagentid+"####"+val);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  
