<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.ClsCommon"%>

<%	
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();

	Connection conn = null;
	
	try{
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		
		String docNo = request.getParameter("masterdoc_no")==null?"0":request.getParameter("masterdoc_no");
		
		String strSql = "select doc_no,cldocno,refname,address,if(per_mob is null,com_mob,per_mob) mobile,mail1 email from my_acbook where status=3 and dtype='CRM' and doc_no='"+docNo+"' ";
		ResultSet rs = stmt.executeQuery(strSql);
		
		String docno="",cldocno="",name="",address="",mobile="",email="";
		while(rs.next()) {
					docno=rs.getString("doc_no");
					cldocno=rs.getString("cldocno");
					name=rs.getString("refname");
					address=rs.getString("address");
					mobile=rs.getString("mobile");
					email=rs.getString("email");
				} 
		
		response.getWriter().write(docno+"####"+cldocno+"####"+name+"####"+address+"####"+mobile+"####"+email);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  