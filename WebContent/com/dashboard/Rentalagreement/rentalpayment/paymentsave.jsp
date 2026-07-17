
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

<%	
ClsConnection ClsConnection=new ClsConnection();

ClsCommon ClsCommon=new ClsCommon();

Connection conn=null;

try{

	
    String payment=request.getParameter("payment");
	String mode=request.getParameter("mode");
	String amount=request.getParameter("amount");
	String acode=request.getParameter("acode");
	String cardno=request.getParameter("cardno"); 
	String instype=request.getParameter("invtype");
	String card=request.getParameter("card");
    String cardtype=request.getParameter("cardtype");
    String paytype=request.getParameter("paytype");

    String expdate=request.getParameter("hidexpdate");
    
    String rano=request.getParameter("rano");
    String odate=request.getParameter("odate");
    String brhid=request.getParameter("brhid");
    
	java.sql.Date sqloutDate=null;
			
			
//System.out.println("----rano----"+rano);

	if(!(odate.equalsIgnoreCase("undefined"))&&!(odate.equalsIgnoreCase(""))&&!(odate.equalsIgnoreCase("0")))
		{
		
		sqloutDate=ClsCommon.changeStringtoSqlDate(odate);
		
			
		}
		
    
   //  odate,brhid
	
	 String upsql=null;

	 int val=10;
	 int docval=0;
		String plusval="";
		
 	 conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	
	

	 String dateval="select round(value) plusval from gl_config where field_nme='ccrelDate'";
	// System.out.println("--------1------------"+dateval);
     
			 ResultSet resSet = stmt.executeQuery(dateval);
			     if (resSet.next()) {
			    	 plusval = resSet.getString("plusval").trim();
			               }
			     
	   String upsql1="select DATE_ADD('"+sqloutDate+"', interval '"+plusval+"' day )  dates  ";
	   //System.out.println("--------2-----------"+upsql1);
	   ResultSet resSet1 = stmt.executeQuery(upsql1);
	     if (resSet1.next()) {
	    	 sqloutDate = resSet1.getDate("dates");
	               }
					   
	

	
	int type=0;// chk rpyt table value
	int update=0; // if payment auth already in payid then update else insert 
	
	  upsql="select rdocno from gl_rpyt where rdocno='"+rano+"' ";
	  //System.out.println("--------3-----------"+upsql);
	   ResultSet resultSet = stmt.executeQuery(upsql);
	   
	    if (resultSet.next()) {
	    	
	    	type=10;
	    	
	         }	
	    if(type==10)
	    
	    {
	    upsql="select rdocno from gl_rpyt where rdocno='"+rano+"' and  payid=3";
	    
	   // System.out.println("--------4----------"+upsql);
		   ResultSet resultSet1 = stmt.executeQuery(upsql);
		   
		    if (resultSet1.next()) {
		    	
		    	update=15;
		    	
		    }	
		    
	    }
	
	    if(update==15)
	    	
	    { // rdocno, payment, mode, amount, acode, cardno, expdate, recieptno, brhid, payid, doc_no, card, paytype, cardtype, reldate, relstatus
	    	
	    	 upsql="update gl_rpyt set payment='"+payment+"',mode='"+mode+"',amount='"+amount+"',acode='"+acode+"' ,cardno='"+cardno+"',expdate='"+expdate+"',recieptno=0,brhid='"+brhid+"',payid=3,card='"+card+"',paytype='"+paytype+"',cardtype='"+cardtype+"',reldate='"+sqloutDate+"'  where rdocno='"+rano+"' and  payid=3 ";
		
	    	// System.out.println("--------5---------"+upsql);
	    int temp=   stmt.executeUpdate(upsql);
		     
		     if(temp<=0)
		     {
		    	 conn.close();
		    	 
		     }
	    	
	    }
	    else
	    {
	    	
	    	 String sql="INSERT INTO gl_rpyt(payment,mode,amount,acode,cardno,expdate,card,cardtype,paytype,payid,brhid,rdocno,recieptno,reldate)VALUES"
				       + " ('"+payment+"',"
				       + "'"+mode+"',"
				       + "'"+amount+"',"
				       + "'"+acode+"',"
				       + "'"+cardno+"',"
				       + "'"+expdate+"',"
				        + "'"+card+"',"
				         + "'"+cardtype+"',"
				        + "'"+paytype+"',"
				       + "'3',"
				       +"'"+brhid+"','"+rano+"','"+0+"','"+sqloutDate+"')";
	    	 //System.out.println("--------6---------"+sql);
				     int resultSet2 = stmt.executeUpdate(sql);
		     if(resultSet2<=0)
		     {
		    	 conn.close();
		    	 
		     }
	    	
	    }
	    
	
		 response.getWriter().print(val);
	 
	 	//System.out.println("aaaaaa"+accode);
	 	stmt.close();
	 	conn.close();
	 	}
		 catch(Exception e){

	 			conn.close();
	 			e.printStackTrace();
	 		               }
	    
	
	%>
