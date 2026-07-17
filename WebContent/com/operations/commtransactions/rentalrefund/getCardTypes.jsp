<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	
	Connection conn = null;
ClsConnection ClsConnection=new ClsConnection();

	
	try{
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement ();
		
		String strSql = "select mode,doc_no  from my_cardm where id=1 and dtype='card'";
		ResultSet rs = stmt.executeQuery(strSql);
		
		String card="",cardId="";
		while(rs.next()) {
					card+=rs.getString("mode")+",";
					cardId+=rs.getString("doc_no")+",";
				} 
		
		String brn[]=card.split(",");
		String brnId[]=cardId.split(",");
		
		card=card.substring(0, card.length()-1);
		cardId=cardId.substring(0, cardId.length()-1);
		
		response.getWriter().write(cardId+"####"+card);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  