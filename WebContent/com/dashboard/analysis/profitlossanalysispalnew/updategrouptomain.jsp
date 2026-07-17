<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%
    Connection conn = null;      
try{	
	ClsConnection ClsConnection=new ClsConnection();
	conn= ClsConnection.getMyConnection();  
	Statement stmt = conn.createStatement ();    
	int rowslen=0,gpid=0,netid=0;
	
	String strSql = "update profitandlossanalysis set code='',head='',grphead='' where trim(description) in('NET PROFIT / (LOSS)','GROSS PROFIT')";
	rowslen=stmt.executeUpdate(strSql);   
	//System.out.println("strSql========"+rowslen);   
	String strSql1 = "update profitandlossanalysis set head='GROSS PROFIT',grphead='GROSS PROFIT',gphead='GROSS PROFIT' where trim(description) in('GROSS PROFIT')";
	rowslen=stmt.executeUpdate(strSql1);   
	//System.out.println("strSql1========"+rowslen);   
	String strSql2 = "update profitandlossanalysis set head='NET PROFIT / (LOSS)',grphead=' NET PROFIT / (LOSS) ',gphead='NET PROFIT / (LOSS)' where trim(description) in('NET PROFIT / (LOSS)')";  
	rowslen=stmt.executeUpdate(strSql2);       
	//System.out.println("strSql2========"+rowslen); 
	
	String strsql11="select id from profitandlossanalysis where trim(description)='GROSS PROFIT'";   
	//System.out.println("strsql11========"+strsql11); 
    ResultSet rs11=stmt.executeQuery(strsql11);          
    while(rs11.next()){         
   	  gpid=rs11.getInt("id");         
    }
  
      
	String strSql3 = "update profitandlossanalysis set gphead='GROSS PROFIT'  where id<"+gpid+"";  
	System.out.println("strSql3========"+strSql3);  
	rowslen=stmt.executeUpdate(strSql3);       
	String strSql4 = "update profitandlossanalysis set gphead=' NET PROFIT / (LOSS) '  where id>"+gpid+"";
	System.out.println("strSql4========"+strSql4);            
	rowslen=stmt.executeUpdate(strSql4);       
	stmt.close();
	conn.close();  

	response.getWriter().print(rowslen);        
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
%>