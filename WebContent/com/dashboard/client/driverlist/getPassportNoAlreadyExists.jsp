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
		int AlreadyExists=0;
		String sql ="";
		
		String passportno=request.getParameter("passportno");
		String docno=request.getParameter("docno");
		String mode=request.getParameter("mode");
	    
		if(mode.equalsIgnoreCase("A") && docno.equalsIgnoreCase("")){
			sql = "select * from gl_drdetails where dtype='CRM' and passport_no<>'0' and passport_no='"+passportno+"'";
		}else if(mode.equalsIgnoreCase("E") && !(docno.equalsIgnoreCase(""))){
			sql = "select * from gl_drdetails where dtype='CRM' and passport_no<>'0' and passport_no='"+passportno+"' and doc_no!="+docno+"";
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
  