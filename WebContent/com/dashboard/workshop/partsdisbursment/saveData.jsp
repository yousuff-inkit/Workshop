<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="java.util.*"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>  
<%@page import="com.common.*"%>
<%	    
ClsConnection ClsConnection=new ClsConnection();
ClsCommon ClsCommon=new ClsCommon();
	Connection conn = null;
    
	try{
	 	conn = ClsConnection.getMyConnection();   
		Statement stmt = conn.createStatement();            
		String date=request.getParameter("date");
		System.out.println("date====="+date); 
		String rowsno=request.getParameter("rowno")==null?"0":request.getParameter("rowno");
		String statusid=request.getParameter("statusid")==null?"0":request.getParameter("statusid");
		String remarks=request.getParameter("remarks")==null?"0":request.getParameter("remarks");
		String jobdocno=request.getParameter("jobno")==null?"0":request.getParameter("jobno");
		int val=0;    
		java.sql.Date sqlDate=null;
		
		
		 if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0"))){
		     sqlDate=ClsCommon.changeStringtoSqlDate(date);
		}
		 String sql1="insert into gl_bwpm( date,remarks,user,jobno,crdate,status) values ('"+sqlDate+"','"+remarks+"','"+session.getAttribute("USERNAME").toString()+"','"+jobdocno+"',now(),'"+statusid+"');";
		 System.out.println("folwup=="+sql1);
		 val= stmt.executeUpdate(sql1);
		 String sql="update ws_floormgmtdata  set partsstatus='"+statusid+"',partsexpdate='"+sqlDate+"',partremarks='"+remarks+"'where rowno='"+rowsno+"'";     
		 System.out.println("sql====="+sql);        
		 val=stmt.executeUpdate (sql);
								   
		 /*  String sql111="insert into in_processlog(statusid, date, inuserid, enqno, cldocno) values (2,now(),"+session.getAttribute("USERID").toString()+",'"+(contrtypedet[1].trim().equalsIgnoreCase("undefined") || contrtypedet[1].trim().equalsIgnoreCase("NaN")|| contrtypedet[1].trim().equalsIgnoreCase("")|| contrtypedet[1].isEmpty()?"0":contrtypedet[1].trim())+"' ,'"+(contrtypedet[2].trim().equalsIgnoreCase("undefined") || contrtypedet[2].trim().equalsIgnoreCase("NaN")|| contrtypedet[2].trim().equalsIgnoreCase("")|| contrtypedet[2].isEmpty()?"0":contrtypedet[2].trim())+"')";
								
		int dat2= stmt.executeUpdate(sql111);
		System.out.println("sql112------"+sql111); */  
					   
					   
			 
	     
		 System.out.println("val=="+val);   
		  response.getWriter().print(val);
   		  stmt.close();
 		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
   }finally{
	   conn.close();
   }
%>
