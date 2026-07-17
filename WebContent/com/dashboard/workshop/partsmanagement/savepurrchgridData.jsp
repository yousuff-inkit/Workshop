<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="java.util.*"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>  
<%@page import="com.common.*"%>
<%@page import="com.finance.nipurchase.nipurchase.ClsnipurchaseDAO" %>
<%	    
ClsConnection ClsConnection=new ClsConnection();
ClsCommon ClsCommon=new ClsCommon();
	Connection conn = null;
	ClsnipurchaseDAO viewDAO=new ClsnipurchaseDAO();
    
	try{
	 	conn = ClsConnection.getMyConnection();   
		Statement stmt = conn.createStatement();            
		String invdate=request.getParameter("idate"); 
		String gridarray=request.getParameter("gridarray")==null?"":request.getParameter("gridarray");
		String invno=request.getParameter("ino")==null?"0":request.getParameter("ino");
		System.out.println("the invno is ===================>>>>>>>>>>>>>>>>"+invno);
		String vndacno=request.getParameter("acno")==null?"0":request.getParameter("acno");
		String jobdocno=request.getParameter("jobno")==null?"0":request.getParameter("jobno");
		String nettotal=request.getParameter("ntotal")==null?"0":request.getParameter("ntotal");
		String vndtax=request.getParameter("vtax")==null?"0":request.getParameter("vtax");
		String rval=request.getParameter("roundval")==null?"0":request.getParameter("roundval");
		
		//System.out.println("the raccno is ===================>>>>>>>>>>>>>>>>"+raccno);
		int val=0;  
		int vdtax=Integer.parseInt(vndtax);
		Double nttotal=Double.parseDouble(nettotal);
		Double rnval=Double.parseDouble(rval);
		System.out.println("the net total is ===================>>>>>>>>>>>>>>>>"+nettotal);
		System.out.println("the net total is ===================>>>>>>>>>>>>>>>>"+nttotal);
		java.sql.Date sqlDate=null;
		ArrayList<String> griddataarray=new ArrayList<String>();
		String[] temparray=gridarray.split(",");
		for(int i=0;i<temparray.length;i++){
			griddataarray.add(temparray[i]);    
			
		} 
		
		 if(!(invdate.equalsIgnoreCase("undefined"))&&!(invdate.equalsIgnoreCase(""))&&!(invdate.equalsIgnoreCase("0"))){
		     sqlDate=ClsCommon.changeStringtoSqlDate(invdate);
		}
		 val=0;
				 /* viewDAO.insert(sqlDate,sqlDate,"dir",0,"ap",vndacno,"","1","1","","","purchase invoice for jobcardno"+jobdocno,session,"A",nttotal,griddataarray,"CPU",request,sqlDate,invno,invdate,vdtax,rnval,nttotal,1); */
					   
			 
	     
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
