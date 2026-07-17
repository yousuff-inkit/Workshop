<%@page import="java.util.Date"%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.util.*"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.common.*"%>  
<%@page import="com.dashboard.workshop.jobexecution.*" %>
<%@page import="com.sales.InventoryTransfer.materialrequest.ClsMaterialrequestDAO"%>  
<%@page import="java.text.SimpleDateFormat" %>  
<%

ClsConnection ClsConnection=new ClsConnection();
ClsCommon ClsCommon=new ClsCommon();

	Connection conn = null;
	Statement stmt=null;
	ClsMaterialrequestDAO sdao= new ClsMaterialrequestDAO();
    String temp="0";

	try{
		String cldocno=request.getParameter("cldocno")==null?"0":request.getParameter("cldocno");
		String jobno=request.getParameter("jobno")==null?"0":request.getParameter("jobno");
		Date curdate1=new Date();
		java.sql.Date curdate;
		Calendar calendar = Calendar.getInstance();

		java.util.Date currentDate = calendar.getTime();

		java.sql.Date date = new java.sql.Date(currentDate.getTime());
	//	curdate=ClsCommon.changeStringtoSqlDate(curdate1);
		 
	 	/* conn = ClsConnection.getMyConnection();
	 	
		stmt = conn.createStatement(); */
		String purchaserequestarray=request.getParameter("purchaserequestarray")==null?"":request.getParameter("purchaserequestarray");
		ArrayList<String> descarray= new ArrayList<String>();
		System.out.println("==== "+purchaserequestarray);
		String spltpurreq[]=purchaserequestarray.split(","); 
		 for(int i=0;i<spltpurreq.length;i++)
		 {
		 
			 String temp21=spltpurreq[i];
			
				descarray.add(temp21);
		 }
		 System.out.println("==== "+date+"=="+jobno + "Material Request - JOB Card -"+jobno+"0.00,"+ session+", A, MR,"+ request +"=="+ descarray+"=======cldocno "+cldocno+"==jobno"+ jobno);
   	     int reqval=sdao.insert(date,jobno , "Material Request - JOB Card -"+jobno,0.00, session, "A", "MR", request, descarray,1,Integer.parseInt(cldocno)  ,0,1,9,Integer.parseInt(jobno));
		
			 if(reqval>0)
			 {
				 temp="1";
				 //conn.commit();
			 }
		 response.getWriter().print(temp);
 		
 	
	}catch(Exception e){
	 	e.printStackTrace();
	 	// conn.close();
   }finally{
	   // conn.close();
   }
%>
