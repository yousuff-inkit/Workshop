<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%	
    ClsConnection ClsConnection=new ClsConnection();
	Connection conn = null;
	try{
		
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement(); 
		String refdocno="",refcode="",refname="";
		
	    String strSql = "select doc_no, type_name, type_code from my_attach_type where status=3 and dtype='GIP'";
		ResultSet rs = stmt.executeQuery(strSql);
		while(rs.next()) {
			refdocno+=rs.getString("doc_no")+",";
			refcode+=rs.getString("type_code")+",";
			refname+=rs.getString("type_name")+",";
	  		} 
		if(!refdocno.equals("") && refdocno!=null){
			String refdoc[]=refdocno.split(",");
			String refcod[]=refcode.split(",");
			String refnam[]=refname.split(",");
			
			refdocno=refdocno.substring(0, refdocno.length()-1);
			refcode=refcode.substring(0, refcode.length()-1);
			refname=refname.substring(0, refname.length()-1);
		}
		
		response.getWriter().write(refname+"####"+refcode+"####"+refdocno);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>