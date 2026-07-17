
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

 Connection conn=null;

try{ 

	String docno=request.getParameter("docno");
	String srno=request.getParameter("srno");
	String qty=request.getParameter("qty");
	String tempval=request.getParameter("tempval");
	int qtyval=Integer.parseInt(qty);
	int tempvalue=Integer.parseInt(tempval);
	//System.out.println("---1-tempvalue------"+tempvalue);
//	System.out.println("---1-qtyval------"+qtyval);
	 
	
	int diff=0;
	
	  String upsql=null;

	 int val=0;
	 int docval=0;
	 int qtys=0;
	
 	 conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	
	
	
    upsql="select qty from  gl_vpod  where rdocno='"+docno+"' and srno='"+srno+"' ";
    
	//System.out.println("---upsql------"+upsql);
      ResultSet rs=  stmt.executeQuery(upsql);
       if(rs.next())
       {
    	   qtys= rs.getInt("qty");
       }
        
       if(tempvalue==0)
   	{
    	   tempvalue=1;
    	   qtys=qtys-1;
   	}
   	 
   	 else
   	 {
   		//System.out.println("---2-tempvalue------"+tempvalue);
   		//System.out.println("---2-qtyval------"+qtyval);
   		tempvalue=tempvalue+1;
   		qtys= qtys-tempvalue;
   		tempvalue=1;
   		
   		 
   	 }

  //  qtys=qtys-qtyval;
    

    response.getWriter().print(tempvalue+"::"+qtys);

	 
	 	//System.out.println("aaaaaa"+accode);
	 	stmt.close();
	 	conn.close();
	 	}
		 catch(Exception e){

	 			conn.close();
	 			e.printStackTrace();
	 		}
	     
	
	%>