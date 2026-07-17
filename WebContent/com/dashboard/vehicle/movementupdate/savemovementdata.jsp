
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


	String fleetno=request.getParameter("fleetno");
	String vmdocno=request.getParameter("vmdocno");
	String status=request.getParameter("status");
	
	String dateout=request.getParameter("dateout");
	String timeout=request.getParameter("timeout");
	String outkm=request.getParameter("outkm");
	String outfuel=request.getParameter("outfuel");
	
	String datein=request.getParameter("datein");
	String timein=request.getParameter("timein");
	String inkm=request.getParameter("inkm");
	String infuel=request.getParameter("infuel");
	
 
	 

/* 	  dateout timeout outkm outfuel datein timein inkm infuel */

    
 	java.sql.Date sqloutdate=null;

	if(!(dateout.equalsIgnoreCase("undefined"))&&!(dateout.equalsIgnoreCase(""))&&!(dateout.equalsIgnoreCase("0")))
		{
		sqloutdate=ClsCommon.changeStringtoSqlDate(dateout);
			
		}
	java.sql.Date sqlindate=null;
	if(status.equalsIgnoreCase("IN"))
		
	{

	if(!(datein.equalsIgnoreCase("undefined"))&&!(datein.equalsIgnoreCase(""))&&!(datein.equalsIgnoreCase("0")))
		{
		sqlindate=ClsCommon.changeStringtoSqlDate(datein);
			
		}
		
	}
    
	String branchval="";
 

	 String upsql=null;
	 Connection conn=null;
	 int val=0;
	 
	 int res=0;

	 double  totatime=0;
	 
	 String  totkm="0";
	 String  totfuel="0";
	 
	 try{
		 
		 
		//  vmdocno status sqloutdate timeout outkm outfuel sqlindate timein inkm infuel
 
		 
		 
		 conn=ClsConnection.getMyConnection();
		 conn.setAutoCommit(false);
		 branchval=session.getAttribute("BRANCHID").toString();
		
		 CallableStatement	movement = conn.prepareCall("{CALL moveUpdateDML(?,?,?,?,?,?,?,?,?,?,?)}");
		 movement.setString(1,fleetno);
		 movement.setDate(2,sqloutdate);
		 movement.setString(3,timeout);
		 movement.setString(4,outkm);
		 movement.setString(5,outfuel);
		 movement.setDate(6,sqlindate);
		 movement.setString(7,timein);
		 movement.setString(8,inkm);
		 movement.setString(9,infuel);
		 movement.setString(10,status);
		 movement.setString(11,vmdocno);
	// System.out.println("----movement----"+movement);
		 res=movement.executeUpdate();    
 
	  	 
	 	// System.out.println("----res----"+res);
	  	 
/* 		 int masterdocno=0;
		 String masterrtype="";
		  */
		 
		 
		 
		 
/* 		 String	fristsql="select rdocno,rdtype from gl_vmove  where doc_no='"+vmdocno+"'";
		 
			ResultSet frist=stmt.executeQuery(fristsql);
			if(frist.next())
			{
				
 
				masterdocno=frist.getInt("rdocno");
				masterrtype=frist.getString("rdtype");
			}
			
		  */
		 
		 
		 
/* 		 
		 
			if(status.equalsIgnoreCase("IN"))
				
			{
				 
			String	sql="select TIMESTAMPDIFF(SECOND,ts_din,ts_dout)/60 totatime ,"+inkm+"-"+outkm+" as totkm,"+infuel+"-"+outfuel+" as totfuel  from ( select  cast(concat('"+sqlindate+"',' ','"+timein+"') as datetime) ts_dout, cast(concat('"+sqloutdate+"',' ','"+timeout+"') as datetime) ts_din) aa";
		 
			ResultSet rs=stmt.executeQuery(sql);
			if(rs.next())
			{
				
				totatime=rs.getDouble("totatime");
				totkm=rs.getString("totkm");
				totfuel=rs.getString("totfuel");
			}
			
			 
			//vmove update  	
		String vmovesql="update  gl_vmove set dout='"+sqloutdate+"', tout='"+timeout+"', kmout='"+outkm+"', fout='"+outfuel+"',din='"+sqlindate+"', tin='"+timein+"', kmin='"+inkm+"', fin='"+infuel+"',ttime='"+totatime+"', tkm='"+totkm+"', tfuel='"+totfuel+"' where doc_no='"+vmdocno+"'";
		  
		res=stmt.executeUpdate(vmovesql);	
		

		
		
		
		
		
		
		
		
			}
			else
			{
				
			String	vmovesql="update  gl_vmove set dout='"+sqloutdate+"', tout='"+timeout+"', kmout='"+outkm+"', fout='"+outfuel+"' where doc_no='"+vmdocno+"'";	
				 
				res=stmt.executeUpdate(vmovesql);	
			} 
		  */
		
	
 	 if(res>0)
	
	 {
		
		//Statement stmt1=conn.createStatement();
		String sqlsave="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ("+vmdocno+",1,'BVMU',now(),'"+session.getAttribute("USERID").toString()+"','A')";
		movement.executeUpdate(sqlsave);
		 
		   movement.close();
		   conn.commit();
		   response.getWriter().print(1);
		   conn.close();
			 
			 
			 
		
	
	}  
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
			if(session.getAttribute("BRANCHID")==null)
			{
				response.getWriter().print(10);	
				
			}
			else
			{
				response.getWriter().print(0);
			}
			
			
			
		}

	
		 
	 
	 	//System.out.println("aaaaaa"+accode);
	    
	 	  
	    
	
	%>
