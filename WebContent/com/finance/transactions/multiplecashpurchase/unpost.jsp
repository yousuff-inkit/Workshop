<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.ClsApplyDelete"%>
<%	
	Connection conn = null; 
	try{
		ClsConnection connDAO = new ClsConnection();
		ClsApplyDelete  apply = new ClsApplyDelete();    
	 	conn = connDAO.getMyConnection();
		Statement stmt = conn.createStatement();
		Statement stmt2 = conn.createStatement();
		int val = 0, postdocno = 0;
		String trno=request.getParameter("trno")==null || request.getParameter("trno")==""?"0":request.getParameter("trno");  
		
		apply.getFinanceApplyDelete(conn, Integer.parseInt(trno));             
 
		String sql8="update my_srvpurm set status=7 where doc_no in (select postdocno from my_mcpbd where tr_no="+trno+")";    
	    //System.out.println("sql8========="+sql8);  
	    val=stmt.executeUpdate(sql8); 	  		      
			
	    String sql4="select coalesce(postdocno,0) postdocno from my_mcpbd where tr_no="+trno+"";     
	    //System.out.println("sql4========="+sql4); 
	    ResultSet rs = stmt2.executeQuery(sql4);    
	    while(rs.next()){
	    	postdocno = rs.getInt("postdocno"); 
	    	
	    	String sql6="update my_jvtran set status=7 where tr_no in (select tr_no from my_srvpurm where doc_no = "+postdocno+")" ;
		    //System.out.println("sql6========="+sql6); 
		    val=stmt.executeUpdate(sql6);  
	    }   
	    
		String sql1 = "update my_jvtran set status=0, out_amount=0 where tr_no="+trno+"";      
		//System.out.println("sql1========="+sql1);	
	    val= stmt.executeUpdate(sql1);
	    
	    String sql5="delete d.* from my_jvtran j inner join my_outd d on j.tranid=d.tranid where tr_no="+trno+"";  
	    //System.out.println("sql5========="+sql5);
	    val=stmt.executeUpdate(sql5);	
						 
        String sql3 = "update my_mcpbd set postdocno=0 where tr_no="+trno+"";  
        //System.out.println("sql3========="+sql3);	
        val= stmt.executeUpdate(sql3); 
        
        String sql2 = "update my_mcpbm set posted=0 where tr_no="+trno+"";  
		//System.out.println("sql2========="+sql2);	
        val= stmt.executeUpdate(sql2);	  
	     
	    stmt.close();  
	    stmt2.close();    
		response.getWriter().print(val);  
	}catch(Exception e){
	 	e.printStackTrace();
	}finally{
		conn.close();
	}
  %>
  