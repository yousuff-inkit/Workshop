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
<%@ page import="java.sql.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.operations.vehicletransactions.maintenanceworkorder.ClsmaintWorkorderDAO" %>
<%ClsConnection connDAO=new ClsConnection(); %>


<%ClsCommon commonDAO=new ClsCommon(); %>
<%
	/* String hidrefdates=request.getParameter("hidrefdates")==null?"NA":request.getParameter("hidrefdates");

  String hidcldate=request.getParameter("hidcldate")==null?"0":request.getParameter("hidcldate");
   String hidcltime=request.getParameter("hidcltime")==null?"0":request.getParameter("hidcltime");
    String remarks=request.getParameter("remarks")==null?"0":request.getParameter("remarks");
    String refsrno=request.getParameter("refsrno")==null||request.getParameter("refsrno")==""?"0":request.getParameter("refsrno");
    String typedocno=request.getParameter("typedocno")==null?"0":request.getParameter("typedocno");
    String damageid=request.getParameter("damageid")==null?"0":request.getParameter("damageid");
     */
     String list=request.getParameter("list")==null?"0":request.getParameter("list");
     
    String doc=request.getParameter("doc");
   /*  String ivals=request.getParameter("ival");
  
    String rowval=request.getParameter("row");  
    int ival=Integer.parseInt(ivals);
    String clearss=request.getParameter("clearss");  
    String del=request.getParameter("del");
    
    int rowvall=Integer.parseInt(rowval);
    int dela=Integer.parseInt(del);
     */
   
     
     String aa[]=list.split(",");

 	ArrayList<String> mainarray= new ArrayList<String>();
 	 
 for(int i=0;i<aa.length;i++){
 	 
 	 String bb[]=aa[i].split("::");
 
 	 String temp="";
 	 for(int j=0;j<bb.length;j++){ 
 		 temp=temp+bb[j]+"::";
 		 
 	}
 	 mainarray.add(temp);
 	 
 } 
    Connection conn=null;
    String sql="";
    try
    {
   	
    conn = connDAO.getMyConnection();
	Statement stmt = conn.createStatement();
	for(int k=0;k<mainarray.size();k++)
	{
	
		
		
 
	
			 
			if(k==0)
			{
	 
		String sqls="delete from  gl_vmcostdet where rdocno='"+doc+"' ";
	 
   	    stmt.executeUpdate(sqls);
   	 
  
		
	            }         //      0                    1                  2                     3                     4                     5                      6
	 // listss.push(rows[i].hidrefdates+"::"+rows[i].rem+"::"+rows[i].refsrno+"::"+rows[i].typedocno+"::"+rows[i].damageid+"::"+rows[i].hidcldate+"::"+rows[i].hidcltime);  
	  String[] serarray=mainarray.get(k).split("::");  
			    /*  if(!(serarray[1].trim().equalsIgnoreCase("undefined")|| serarray[1].trim().equalsIgnoreCase("null")|| serarray[1].trim().equalsIgnoreCase("NaN")||serarray[1].trim().equalsIgnoreCase("")|| serarray[1].isEmpty()))
			     { */
	
	 if(serarray[0].trim().equalsIgnoreCase("undefined") ||serarray[0].trim()=="NA" || serarray[0].trim().equalsIgnoreCase("null")|| serarray[0].equalsIgnoreCase("NaN")||serarray[0].equalsIgnoreCase("")|| serarray[0].isEmpty())
		 
	 {
		 String sql1="INSERT INTO gl_vmcostdet(rowno,cleared,remarks,type,dmid,cldate,cltime,rdocno,formid)VALUES"
				  + " ("+(k+1)+","
						  + "1,"
			       + "'"+(serarray[1].trim().equalsIgnoreCase("undefined") || serarray[1].trim().equalsIgnoreCase("null") || serarray[1].trim().equalsIgnoreCase("NaN")||serarray[1].trim().equalsIgnoreCase("")|| serarray[1].isEmpty()?0:serarray[1].trim())+"',"
			       + "'"+(serarray[3].trim().equalsIgnoreCase("undefined") || serarray[3].trim().equalsIgnoreCase("null")|| serarray[3].trim().equalsIgnoreCase("NaN")||serarray[3].trim().equalsIgnoreCase("")|| serarray[3].isEmpty()?0:serarray[3].trim())+"',"
			       + "'"+(serarray[4].trim().equalsIgnoreCase("undefined") || serarray[4].trim().equalsIgnoreCase("null")|| serarray[4].trim().equalsIgnoreCase("NaN")||serarray[4].trim().equalsIgnoreCase("")|| serarray[4].isEmpty()?0:serarray[4].trim())+"',"
			       + "'"+(serarray[5].trim().equalsIgnoreCase("undefined") || serarray[5].trim().equalsIgnoreCase("null")|| serarray[5].trim().equalsIgnoreCase("NaN")||serarray[5].trim().equalsIgnoreCase("")|| serarray[5].isEmpty()?0:commonDAO.changeStringtoSqlDate(serarray[5].trim()))+"',"	
			       + "'"+(serarray[6].trim().equalsIgnoreCase("undefined") || serarray[6].trim().equalsIgnoreCase("null")|| serarray[6].trim().equalsIgnoreCase("NaN")||serarray[6].trim().equalsIgnoreCase("")|| serarray[6].isEmpty()?0:serarray[6].trim())+"',"
		  +"'"+doc+"',1)"; 
			       /* String sql1="INSERT INTO gl_vmcostdet(rowno,cleared,remarks,rdocno,type,cldate,cltime,dmid,formid)VALUES"
	    	        + " ("+(k+1)+","
			       + "1,"
			       + "'"+remarks+"',"
			     +"'"+doc+"',"
			        + "'"+typedocno+"',"
			        		   + "'"+ClsCommon.changeStringtoSqlDate(hidcldate.trim())+"',"
    						   + "'"+hidcltime+"',"
			          + "'"+damageid+"',1)";
	      */
	  
	     
	       stmt.executeUpdate(sql1);
			 
	    
		 
	 }
	 else
	 {
		                    //      0                    1                  2                     3                     4                     5                      6
		 // listss.push(rows[i].hidrefdates+"::"+rows[i].rem+"::"+rows[i].refsrno+"::"+rows[i].typedocno+"::"+rows[i].damageid+"::"+rows[i].hidcldate+"::"+rows[i].hidcltime);  
		 String sql1="INSERT INTO gl_vmcostdet(rowno,cleared,refdate,remarks,refno,type,dmid,cldate,cltime,rdocno,formid)VALUES"
				  + " ("+(k+1)+","
					 + "1,"
		          + "'"+(serarray[0].trim().equalsIgnoreCase("undefined") || serarray[0].trim().equalsIgnoreCase("null") || serarray[0].trim().equalsIgnoreCase("NaN")||serarray[0].trim().equalsIgnoreCase("")|| serarray[0].isEmpty()?0:commonDAO.changeStringtoSqlDate(serarray[0].trim()))+"',"
			       + "'"+(serarray[1].trim().equalsIgnoreCase("undefined") || serarray[1].trim().equalsIgnoreCase("null") || serarray[1].trim().equalsIgnoreCase("NaN")||serarray[1].trim().equalsIgnoreCase("")|| serarray[1].isEmpty()?0:serarray[1].trim())+"',"
			       + "'"+(serarray[2].trim().equalsIgnoreCase("undefined") || serarray[2].trim().equalsIgnoreCase("null")|| serarray[2].trim().equalsIgnoreCase("NaN")||serarray[2].trim().equalsIgnoreCase("")|| serarray[2].isEmpty()?0:serarray[2].trim())+"',"
			       + "'"+(serarray[3].trim().equalsIgnoreCase("undefined") || serarray[3].trim().equalsIgnoreCase("null")|| serarray[3].trim().equalsIgnoreCase("NaN")||serarray[3].trim().equalsIgnoreCase("")|| serarray[3].isEmpty()?0:serarray[3].trim())+"',"
			       + "'"+(serarray[4].trim().equalsIgnoreCase("undefined") || serarray[4].trim().equalsIgnoreCase("null")|| serarray[4].trim().equalsIgnoreCase("NaN")||serarray[4].trim().equalsIgnoreCase("")|| serarray[4].isEmpty()?0:serarray[4].trim())+"',"
			       + "'"+(serarray[5].trim().equalsIgnoreCase("undefined") || serarray[5].trim().equalsIgnoreCase("null")|| serarray[5].trim().equalsIgnoreCase("NaN")||serarray[5].trim().equalsIgnoreCase("")|| serarray[5].isEmpty()?0:commonDAO.changeStringtoSqlDate(serarray[5].trim()))+"',"	 
			      + "'"+(serarray[6].trim().equalsIgnoreCase("undefined") || serarray[6].trim().equalsIgnoreCase("null")|| serarray[6].trim().equalsIgnoreCase("NaN")||serarray[6].trim().equalsIgnoreCase("")|| serarray[6].isEmpty()?0:serarray[6].trim())+"',"
			     +"'"+doc+"',1)"; 
   /*   String sql1="INSERT INTO gl_vmcostdet(rowno,refdate,cleared,remarks,refno,rdocno,type,cldate,cltime,dmid,formid)VALUES"
    	        + " ("+(k+1)+","
		       + "'"+ClsCommon.changeStringtoSqlDate(hidrefdates.trim())+"',"
		    		   + "1,"
		    				   + "'"+remarks+"',"
		    						   +"'"+refsrno+"',"
		               +"'"+doc+"',"
		            		   + "'"+typedocno+"',"
		            				   + "'"+ClsCommon.changeStringtoSqlDate(hidrefdates.trim())+"',"
		            						   + "'"+hidcltime+"',"
		 			          + "'"+damageid+"',1)"; */
 
                   stmt.executeUpdate(sql1);
			 
              
	 }     
	// response.getWriter().print(ival);
		
			     }
	 stmt.close();
	 
		conn.close();
    	
    }
    catch(Exception e)
    {
    	e.printStackTrace();
    	conn.close();
    }
	 	
	 	
	 	
%>



