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
		
		String licenceno=request.getParameter("licenceno");
		String docno=request.getParameter("docno");
		String mode=request.getParameter("mode");
	    
		if(mode.equalsIgnoreCase("A") && docno.equalsIgnoreCase("")){
			sql = "select * from gl_drdetails where dtype='CRM' and dlno<>'0' and dlno='"+licenceno+"'";
		}else if(mode.equalsIgnoreCase("E") && !(docno.equalsIgnoreCase(""))){
			sql = "select * from gl_drdetails where dtype='CRM' and dlno<>'0' and dlno='"+licenceno+"' and doc_no!="+docno+"";
		}
		
		ResultSet rs = stmt.executeQuery(sql);
		
		while(rs.next()) {
			AlreadyExists=1;
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
  