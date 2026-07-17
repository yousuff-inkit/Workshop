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
	Connection conn = null;
	try{
		ClsnipurchaseDAO viewDAO=new ClsnipurchaseDAO();
		ClsConnection connDAO = new ClsConnection();
		ClsCommon commonDAO=new ClsCommon();
		ClsApplyDelete  apply = new ClsApplyDelete();    
	 	conn = connDAO.getMyConnection();
		Statement stmt = conn.createStatement();
		Statement stmt1 = conn.createStatement();
		Statement stmt2 = conn.createStatement();
		int AlreadyExists=0,mcptran=0,nipurchtran=0,nipurchtranoth=0;
		String sql8="",sql6="",sql5="",sql4="",invno="",invdate="",description="",prodtype="",cldocno="",refname="",clacno="",taxamt="",outacno="",sql7="";
		int val=0,billtype=0,tax=0,costtype=0,costcode=0,value=0;
		double amount=0.0,vndtotal=0.0,mcpamount=0.0;
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
		String docno=request.getParameter("docno")==null || request.getParameter("docno")==""?"":request.getParameter("docno").toString();
		String mode=request.getParameter("mode"); 
		String vendorid=request.getParameter("vendorid");
		String vendor=request.getParameter("vendor");
		String vndrtotal=request.getParameter("vndrtotal");
		String trno=request.getParameter("trno");
		String brhid=request.getParameter("brhid");
		session.setAttribute("BRANCHID", brhid);    
		String newdesc="MCP -"+docno;    
		ArrayList<String> gridarray=new ArrayList<String>();
		ArrayList<String> vndarray=new ArrayList<String>();
		ArrayList<String> temparray=new ArrayList<String>();  
		
		apply.getFinanceApplyDelete(conn, Integer.parseInt(trno));           
		
		String selectsql="select vendid,invno from my_mcpbd where tr_no="+trno+" and vendid!=0 group by vendid,invno";  
		System.out.println("selectsql========"+selectsql);  
		rd= stmt1.executeQuery(selectsql);
		while(rd.next()) {
			 vndarray.add(rd.getString("vendid")+"::"+rd.getString("invno"));  
	    }
		System.out.println("vndarray========"+vndarray);   
		for(int j=0;j<vndarray.size();j++){    
			 vndtotal=0;
			 String[] vnd=vndarray.get(j).split("::");   
			 gridarray= new ArrayList();
			 String sql="select d.qty,d.unitprice,coalesce(ac.cldocno,0) cldocno,coalesce(ac.refname,0) refname,coalesce(ac.acno,0) acno,d.costtype,d.acno glacno,d.costcode,d.tax,d.taxamt,d.description,d.total,d.amount,d.invno,m.date invdate from my_mcpbd d left join my_mcpbm m on m.tr_no=d.tr_no left join my_acbook ac on d.vendid=ac.cldocno and ac.dtype='VND' where d.tr_no="+trno+" and d.vendid="+vnd[0]+" and d.invno='"+vnd[1]+"'";
			 System.out.println("sql========"+sql);  
			 rs= stmt.executeQuery(sql);  
			 while(rs.next()) {
					invno=rs.getString("invno");
					invdate=rs.getString("invdate");
					fdate=rs.getDate("invdate");
					amount=rs.getDouble("amount");
					description=rs.getString("description");
					tax=rs.getInt("tax");
					costtype=rs.getInt("costtype");
					costcode=rs.getInt("costcode");
					cldocno=rs.getString("cldocno");
					refname=rs.getString("refname");
					clacno=rs.getString("acno");
					taxamt=rs.getString("taxamt");
					outacno=rs.getString("glacno");
					gridarray.add(1+"::"+rs.getString("qty")+" :: "+description+" :: "+rs.getString("unitprice")+" :: "+amount+" :: "+0+" :: "+amount+" :: "+taxamt+" :: "+costtype+" :: "+costcode+" :: "+description+" :: "+rs.getString("glacno")+" :: 0 :: "+tax+" :: "+taxamt+" :: "+rs.getDouble("total")+" :: ");
					vndtotal=vndtotal+rs.getDouble("total");
					   //System.out.println("billtype====="+vndtotal+"======"+gridarray);
				} 
			   if(tax>0){
					prodtype="1";
					billtype=1;
					//System.out.println("billtype====="+billtype);
				}
			    //System.out.println("billtype====="+billtype);
				if(!(docno.equalsIgnoreCase(""))){
				value=viewDAO.insert(fdate, fdate, "DIR", 0, "AP", clacno, refname, "1", "1", "", "", newdesc, session, 
						"A", vndtotal, gridarray, "CPU", request, fdate, invno,invdate, 1,  0.0, vndtotal, 1);
				//System.out.println("value========="+value);	
				if (value>0){
						 String sql1 = "update my_jvtran set status=3 where tr_no="+trno+"";
						 //System.out.println("sql1========="+sql1);	
					     val= stmt.executeUpdate(sql1);
					     
					     String sql2 = "update my_mcpbm set posted=1 where doc_no="+docno+"";
						 //System.out.println("sql2========="+sql2);	
				         val= stmt.executeUpdate(sql2);
				     
				         String sql3 = "update my_mcpbd set postdocno="+value+" where tr_no="+trno+" and vendid="+vnd[0]+" and invno='"+vnd[1]+"'";  
				         //System.out.println("sql3========="+sql3);	
				         val= stmt.executeUpdate(sql3);     
				     
					     sql3="select jv.tranid,round(jv.dramount,2) dramount from my_jvtran jv  inner join my_mcpbd d on jv.ref_row=d.rowno where jv.acno=(SELECT ACNO  accDocNo FROM MY_ACBOOK WHERE CLDOCNO="+vnd[0]+" AND DTYPE='VND') and jv.doc_no="+docno+" and jv.dtype='MCP'  and d.invno='"+vnd[1]+"'"; 
					    //System.out.println("sql3========="+sql3);  
					     rg=stmt2.executeQuery(sql3);
					     while(rg.next()){
					    	 //mcptran=rg.getInt("tranid");
					    	 //mcpamount=rg.getDouble("dramount");
					    	 temparray.add(rg.getString("tranid")+" :: "+rg.getString("dramount"));    
					     }
				      
					     sql4="select jv.tranid from my_jvtran jv where jv.acno=(SELECT ACNO  accDocNo FROM MY_ACBOOK WHERE CLDOCNO="+vnd[0]+" AND DTYPE='VND') and jv.doc_no="+value+" and jv.dtype='CPU'"; 
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
					     //System.out.println("temparray========="+temparray);
				       for(int k=0;k<temparray.size();k++){        
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
				}  	 
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
  