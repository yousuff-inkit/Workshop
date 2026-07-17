<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	
ClsConnection ClsConnection=new ClsConnection();
	Connection conn = null;
	
	try{
	 	conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		Statement stmt1 = conn.createStatement();
		String docno=request.getParameter("docno");
		String dtype=request.getParameter("dtype");
		String brch=request.getParameter("brch");
		String usrid=request.getParameter("usrid");
		String isfirstappr=request.getParameter("isfirstappr");
		String  strSql1="";
		if((Integer.parseInt(isfirstappr)==0)){
			//brhid="+brch+" and
		  strSql1="select * from my_Exdoc where  dtype='"+dtype+"' and userid="+usrid+"";
		}
		else{
			//brhid="+brch+" and
		  strSql1="select * from my_Exdoc where  dtype='"+dtype+"' and userid="+usrid+" and apprlevel in (select apprlevel from my_exeb where brhid="+brch+" and dtype='"+dtype+"' and userid="+usrid+" and approved=0 ) order by apprlevel desc ";
		}
		
		
		System.out.println("====strSql1======"+strSql1);
		
		System.out.println(strSql1);
		
	    ResultSet rs1 = stmt.executeQuery(strSql1);
		int apprlevel=0;
		int minapprl=0;
		while(rs1.next()) {
			
			apprlevel=rs1.getInt("apprlevel");
			minapprl=rs1.getInt("minapprls");
	  		}
		
		//and dt.brhId="+brch+"
String strSql3 = "select count(*) as count from  my_exdoc dt   where dt.dtype='"+dtype+"' and dt.apprlevel="+apprlevel+"  ";
		
		System.out.println("strSql3====="+strSql3);
		
		ResultSet rs3 = stmt.executeQuery(strSql3);
		
		int apprlist=0;
		while(rs3.next()) {
			apprlist=rs3.getInt("count");
			
	  		}
		
		
		
		
		response.getWriter().write(usrid+"####"+apprlevel+"####"+minapprl+"####"+apprlist);
	
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  
