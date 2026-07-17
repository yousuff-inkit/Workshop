<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	
	String invno=request.getParameter("invno");

String masterdocno=request.getParameter("masterdocno")==null||request.getParameter("masterdocno")==""?"0":request.getParameter("masterdocno");
String list1=request.getParameter("chklist");
ClsConnection connDAO=new ClsConnection();
 	Connection conn = null;
 	try{
 		conn = connDAO.getMyConnection();
 		int status=0,chkinvno=0;
 		Statement stmt = conn.createStatement ();
 		ArrayList<String> griddataarray=new ArrayList<String>();
		String[] temparray=list1.split(",");
		for(int i=0;i<temparray.length;i++){
			griddataarray.add(temparray[i]);    
			
		} 
	String strSql = "select method from gl_config where field_nme='invnochk' ";
	//System.out.println("-----34-----"+strSql);
		ResultSet rs1 = stmt.executeQuery(strSql);

		int method=0;
		//String id="";
		if(rs1.next()) {
			method=rs1.getInt("method");
						
	  		} 
	//	System.out.println("-----method----"+method);
		if(method!=0)
		{
			 for(int j=0;j<griddataarray.size();j++){  
			
				 String[] vnd=griddataarray.get(j).split("::");   
			 
	             String strSql1 = "select invno from my_srvpurm where status<>7 and invno='"+vnd[1].trim()+"' and acno='"+vnd[0].trim()+"'";
                 System.out.println("-----my_srvpurmchk-----"+strSql1);       
	             ResultSet rs = stmt.executeQuery(strSql1);
					if(rs.next()) {
						status=1;
						chkinvno=rs.getInt("invno");
						break;			
				  		} 
					
					
						
						else
						{
							status=0;
						}
			  }
	    }
	


	//String id="";
	
	response.getWriter().print(status+"::"+chkinvno);
	//System.out.println("aaaaaa"+accode);
	stmt.close();
	conn.close();
 	}
	catch(Exception e){
		
			conn.close();
			
		} 
  
  %>
  
