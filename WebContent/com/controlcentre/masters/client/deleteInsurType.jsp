<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
	String rowno=request.getParameter("rowno")==null?"":request.getParameter("rowno");
	Connection conn=null;
	int itemcount=0;
	try{
		ClsConnection objconn=new ClsConnection();
		conn=objconn.getMyConnection();
		if(rowno!=null && !rowno.equalsIgnoreCase("undefined") && !rowno.trim().equalsIgnoreCase("")){
			String strcheck="select count(*) itemcount from ws_jobcard where insurtypedocno="+rowno;
			ResultSet rscheck=conn.createStatement().executeQuery(strcheck);
			while(rscheck.next()){
				itemcount=rscheck.getInt("itemcount");
			}	
		}
		
	}
	catch(Exception e){
		e.printStackTrace();
	}
	finally{
		conn.close();
	}
	response.getWriter().write(itemcount+"");
%>