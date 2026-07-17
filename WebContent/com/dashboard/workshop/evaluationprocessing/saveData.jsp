<%@page import="com.common.ClsCommon"%>
<%@page import="com.project.execution.ServiceSale.*"%>                 
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="javax.servlet.http.HttpServletRequest.*" %>
<%@page import="javax.servlet.http.HttpSession.*" %>
<%@page import="java.io.*" %>
<%@page import="org.apache.struts2.ServletActionContext" %>
<%
    int val=0;
	ClsConnection objconn=new ClsConnection();  
	ClsCommon ClsCommon=new ClsCommon();
	Connection conn=null;       
	java.sql.Date sqlStartDate=null;
	try{
		conn=objconn.getMyConnection();
	    Statement stmt=conn.createStatement(); 
	    ClsServiceSaleDAO DAO=new ClsServiceSaleDAO();  
		String docnoarray=request.getParameter("gridarray")==null?"":request.getParameter("gridarray");
		String date=request.getParameter("date")==null?"":request.getParameter("date");
		String desc=request.getParameter("desc")==null?"":request.getParameter("desc");      
		sqlStartDate = ClsCommon.changeStringtoSqlDate(date);     
		ArrayList<String> gridarray=new ArrayList<String>();
		Double txtamt=0.0,txttaxamt=0.0,nettot=0.0,taxtot=0.0;     
		int invvoc=0,invtrno=0,tax=0,acno=0,racno=0;
		String sql="select coalesce(ac.tax,0)tax,round(coalesce(sum(m.billingamt),0),2) amount,ac.acno,(select coalesce(acno,0) racno from my_account where codeno='REVENUE EVALUATION INCOME') racno from ws_evalm m left join my_acbook ac on ac.cldocno=m.cldocno and ac.dtype='CRM' where m.doc_no in("+docnoarray.substring(0, docnoarray.length()-1)+") and m.status<>7 group by m.cldocno";                    
		ResultSet rs=stmt.executeQuery(sql);          
		while(rs.next()){
			acno=rs.getInt("acno");
			racno=rs.getInt("racno");
			tax=rs.getInt("tax");
			txtamt=rs.getDouble("amount");    
		}
		 if(tax>0){
			 txttaxamt=5.0;    
			 taxtot=(txtamt*txttaxamt)/100;
			 nettot=txtamt+taxtot;     
		 }else{
			 txttaxamt=0.0;  
			 taxtot=(txtamt*txttaxamt)/100;
			 nettot=txtamt+taxtot;     
		 }
		 gridarray.add(1+"::"+1+" :: "+desc+" :: "+txtamt+" :: "+txtamt+" :: "+""+" :: "+txtamt+" :: "+txttaxamt+" :: "+taxtot+" :: "+nettot+" :: "+""+" :: "+""+" :: "+""+" :: "+""+" :: "+racno+" :: "+""+" :: ");
		 ClsServiceSaleAction masteraction=new ClsServiceSaleAction();
		 val=DAO.insert(sqlStartDate,sqlStartDate,"","","AR",acno+"","","1","1","","",desc,session,"A",nettot,gridarray,"SRS",request,sqlStartDate,"","",0,txttaxamt,masteraction);    
    	System.out.println("val--->>>"+val);    
    	if(val>0){    
	        invvoc=Integer.parseInt(request.getAttribute("vocno").toString()); 
	        invtrno=Integer.parseInt(request.getAttribute("trans").toString());
	        String sqlss="update ws_evalm set invtrno='"+invtrno+"' where doc_no in("+docnoarray.substring(0, docnoarray.length()-1)+")";           
	    	int val2=stmt.executeUpdate(sqlss);                              
    	}
		response.getWriter().write(invvoc+"::"+val);                 
	 
	}catch(Exception e){
	 	e.printStackTrace();	
   }
%>