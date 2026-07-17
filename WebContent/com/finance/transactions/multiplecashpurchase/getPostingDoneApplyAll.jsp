<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.*"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.finance.nipurchase.nipurchase.ClsnipurchaseDAO" %>
<%@page import="java.text.SimpleDateFormat" %>     
<%

ClsnipurchaseDAO viewDAO=new ClsnipurchaseDAO();

%>
<%	
	Connection conn = null;

	try{
		ClsConnection connDAO = new ClsConnection();
		ClsCommon commonDAO=new ClsCommon();
	 	conn = connDAO.getMyConnection();
		Statement stmt = conn.createStatement();
		Statement stmt1 = conn.createStatement();
		Statement stmt2 = conn.createStatement();
		int AlreadyExists=0,mcptran=0,nipurchtran=0,nipurchtranoth=0;
		String sql8="",sql6="",sql5="",sql4="",sql ="",sql1="",invno="",invdate="",description="",prodtype="",sql2="",cldocno="",refname="",clacno="",taxamt="",sql3="",outacno="",sql7="";
		int val=0,billtype=0,tax=0,costtype=0,costcode=0,value=0;
		double amount=0.0,mcpamount=0.0,vndtotal=0.0;
		ResultSet rs =null;
		ResultSet rd =null;
		ResultSet rg =null;
		ResultSet rf =null;
		ResultSet rq =null;
		java.sql.Date fdate=null;
		SimpleDateFormat formatter = new SimpleDateFormat("dd.MM.yyyy");  
		java.util.Date curDate=new java.util.Date();
		java.sql.Date cdate=commonDAO.changeStringtoSqlDate(formatter.format(curDate));
		java.sql.Date docdate=null;
		String docno="0";
		String newdesc="";      
		String vndrtotal="0";
		String trno="0";
		String brhid="1";
		// session.setAttribute("BRANCHID", brhid);      
		ArrayList<String> mcparray=new ArrayList<String>();
		
		sql2="select distinct d.vendid,m.doc_no,d.postdocno,d.invno from my_mcpbd d inner join  my_mcpbm m on m.tr_no= d.tr_no inner join  my_jvtran j on j.tr_no= d.tr_no and j.ref_row=d.rowno " 
			+" where  postdocno!=0 and vendid!=0 and m.status=3 and m.posted=1;";
		//System.out.println("sql2vendor fetch========"+sql2);
		 rd= stmt1.executeQuery(sql2);
		 while(rd.next()) {
			 mcparray.add(rd.getString("vendid")+"::"+rd.getString("doc_no")+"::"+rd.getString("postdocno")+"::"+rd.getString("invno"));    
		 }
		 for(int main=0;main<mcparray.size();main++){
			 
		ArrayList<String> gridarray=new ArrayList<String>();
		ArrayList<String> temparray=new ArrayList<String>();
		String[] trnarray=mcparray.get(main).split("::");          
		
			
			     
      	sql3="select jv.tranid,round(jv.dramount,2) dramount from my_jvtran jv inner join my_mcpbd d on jv.ref_row=d.rowno where jv.acno=(SELECT ACNO  accDocNo FROM MY_ACBOOK WHERE CLDOCNO="+trnarray[0]+" AND DTYPE='VND') and jv.doc_no="+trnarray[1]+" and jv.dtype='MCP'  and d.invno='"+trnarray[3]+"' "; 
     	rg=stmt2.executeQuery(sql3);
			     
		     while(rg.next()){
				    	 //mcptran=rg.getInt("tranid");
				    	 //mcpamount=rg.getDouble("dramount");
				    	 temparray.add(rg.getString("tranid")+" :: "+rg.getString("dramount"));    
				     }
			    
			     sql4="select jv.tranid from my_jvtran jv where jv.acno=(SELECT ACNO  accDocNo FROM MY_ACBOOK WHERE CLDOCNO="+trnarray[0]+" AND DTYPE='VND') and jv.doc_no="+trnarray[2]+" and jv.dtype='CPU'"; 
			     //System.out.println("sql4========="+sql4);
			     rf=stmt2.executeQuery(sql4);
			     
			     if(rf.next()){
			    	 nipurchtran=rf.getInt("tranid");
			    	 //System.out.println("nipurchtran========="+nipurchtran);
			     }
			     
			     /* sql7="select jv.tranid from my_jvtran jv where jv.acno="+outacno+" and jv.doc_no="+value+" and jv.dtype='CPU'"; 
			     //System.out.println("sql7========="+sql7);
			     rq=stmt2.executeQuery(sql7);
			     
			     if(rq.next()){
			    	 nipurchtranoth=rq.getInt("tranid");
			    	 //System.out.println("nipurchtranoth========="+nipurchtranoth);
			     } */
			      for(int k=0;k<temparray.size();k++){        
			    	  System.out.println("===="+temparray.get(k));
				    	 String[] temporaryarray=temparray.get(k).split("::");  
				    	 mcptran=Integer.parseInt(temporaryarray[0].trim());
				    	 mcpamount=Double.parseDouble(temporaryarray[1].trim());       
					     sql5="insert into my_outd (tranid,amount,ap_trno,rate,ap_trid,curid) values("+mcptran+","+mcpamount+",0,0,"+nipurchtran+",1)";
					     //System.out.println("sql5========="+sql5);
					     val=stmt2.executeUpdate(sql5);
					     
					     sql8="update my_jvtran set out_amount=dramount where tranid="+mcptran+"" ;  
					     //System.out.println("sql8========="+sql8);
					     val=stmt2.executeUpdate(sql8);  
				     }
				     temparray= new ArrayList();  
				     sql6="update my_jvtran set out_amount=dramount where tranid="+nipurchtran+"" ;
				     //System.out.println("sql6========="+sql6); 
				     val=stmt2.executeUpdate(sql6);
				     
					}
				
		 

		 
		response.getWriter().print(value);
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  