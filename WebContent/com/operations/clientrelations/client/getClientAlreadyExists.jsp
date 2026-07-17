<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.*"%>
<%	
	Connection conn = null;

	try{
		ClsConnection connDAO = new ClsConnection();
	 	conn = connDAO.getMyConnection();
		Statement stmt = conn.createStatement();
		int AlreadyExists=0;
		String sql ="";
		
		String clientname=request.getParameter("clientname");
		String salutation=request.getParameter("salutation");
		String docno=request.getParameter("docno");
		String mode=request.getParameter("mode");
	    
		String strSql = "select method from gl_config where field_nme='crmAlreadyExists'";
		ResultSet rs = stmt.executeQuery(strSql);
		
		String method="";
		while(rs.next()) {
			method=rs.getString("method");
		} 
	    
		if(method.equalsIgnoreCase("1")){
			if(mode.equalsIgnoreCase("A") && docno.equalsIgnoreCase("")){
				sql = "select * from my_acbook where status<>7 and dtype='CRM' and refname=trim('"+salutation+" "+clientname+"')";
			}else if(mode.equalsIgnoreCase("E") && !(docno.equalsIgnoreCase(""))){
				sql = "select * from my_acbook where status<>7 and dtype='CRM' and refname=trim('"+salutation+" "+clientname+"') and doc_no!="+docno+"";
			}
			
			ResultSet rs1 = stmt.executeQuery(sql);
			
			while(rs1.next()) {
				AlreadyExists=1;
			} 
		}
		response.getWriter().print(AlreadyExists);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  