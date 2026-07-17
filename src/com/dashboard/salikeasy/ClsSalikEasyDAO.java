package com.dashboard.salikeasy;

import com.connection.*;
import com.common.*;

import java.sql.*;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.http.HttpRequest;

import net.sf.json.JSONArray;
public class ClsSalikEasyDAO {

	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	
	
	public JSONArray notInvoicedGridLoading(String branch,String fromDate, String toDate, String cldocno, String rentalType, String agmtNo,String type) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		    
		Connection conn = null;
        
		  try {
			  	conn = objconn.getMyConnection();
			    Statement stmtSailk = conn.createStatement();
			    
			    java.sql.Date sqlFromDate=null;
				java.sql.Date sqlToDate=null;
			        
				fromDate.trim();
		        if(!(fromDate.equalsIgnoreCase("undefined"))&&!(fromDate.equalsIgnoreCase(""))&&!(fromDate.equalsIgnoreCase("0")))
		        {
		        	sqlFromDate = objcommon.changeStringtoSqlDate(fromDate);
		        }
		        
		        toDate.trim();
		        if(!(toDate.equalsIgnoreCase("undefined"))&&!(toDate.equalsIgnoreCase(""))&&!(toDate.equalsIgnoreCase("0")))
		        {
		        	sqlToDate = objcommon.changeStringtoSqlDate(toDate);
		        }
		        
			    String sql = "";
			    
				
				
				if(!(sqlFromDate==null)){
		        	sql+=" and s.sal_date>='"+sqlFromDate+"'";
			     }
		        
		        if(!(sqlToDate==null)){
		        	sql+=" and s.sal_date<='"+sqlToDate+"'";
			     }
		        
		        if(!(cldocno.equalsIgnoreCase(""))){
		        	sql+=" and a.cldocno='"+cldocno+"'";
		        }
		        
		        if(!(rentalType.equalsIgnoreCase(""))){
		        	if(rentalType.equalsIgnoreCase("RAG")){
		        		sql+=" and s.rtype IN ('RM','RA', 'RD','RW','RF')";
		        	}
		        	else if(rentalType.equalsIgnoreCase("LAG")){
		        		sql+=" and s.rtype IN ('LA', 'LC')";
		        	}
		         }
		        
		       /* if(!(agmtNo.equalsIgnoreCase(""))){
		        	sql+=" and s.ra_no='"+agmtNo+"'";
		           }
				*/
		        if(type.equalsIgnoreCase("Daily")){
		        	sql+=" and s.rtype in ('RD')";
		        }
		        else if(type.equalsIgnoreCase("Weekly")){
		        	sql+=" and s.rtype in ('RW')";
		        }
		        else if(type.equalsIgnoreCase("Monthly")){
		        	sql+=" and s.rtype in ('RM')";
		        }
		        else if(type.equalsIgnoreCase("Lease")){
		        	sql+=" and s.rtype IN ('LA', 'LC')";
		        }
				/*sql = "select if(s.rtype in ('RM','RA', 'RD','RW','RF'),ragmt.voc_no,lagmt.voc_no) vocno,s.sr_no,s.regno,s.tagno,s.fleetno,s.location,s.direction,s.source,s.amount,s.ra_no,a.refname,s.rtype,s.sal_date"+
						" from gl_salik s left join gl_ragmt ragmt on (s.ra_no=ragmt.doc_no and s.rtype in ('RA','RD','RW','RF','RM')) left join gl_lagmt"+
						" lagmt on (s.ra_no=lagmt.doc_no and s.rtype in ('LA','LC')) left join my_acbook a on (s.emp_id=a.cldocno and s.emp_type=a.dtype) where inv_no=0 and isallocated=1 and"+
						" s.ra_no<>0 and s.amount>0 "+sql+" and if(s.rtype in ('RA','RD','RW','RF','RM'),ragmt.brhid="+branch+",lagmt.brhid="+branch+") order by s.rtype,s.ra_no";
*/				
		        String strsql="select sum(s.amount) amount,sum(if(coalesce(a.ser_default=0),a.per_salikrate,(select coalesce(value,0) from gl_config where"+
		        " field_nme='saliksrv' and method=1))) saliksrvc,count(*) salikcount,a.refname,a.cldocno from gl_salik s left join gl_lagmt lagmt on "+
		        " (s.ra_no=lagmt.doc_no and s.rtype in ('LA','LC')) left join my_acbook a on (s.emp_id=a.cldocno and s.emp_type=a.dtype) where inv_no=0 and "+
		        " isallocated=1 and s.ra_no<>0 and s.amount>0  "+sql+" and if(s.rtype in ('LA','LC'),lagmt.brhid="+branch+",0) group by a.cldocno";
		        System.out.println("not invoiced salik query: "+strsql);  
				ResultSet resultSet = stmtSailk.executeQuery(strsql);
			    RESULTDATA=objcommon.convertToJSON(resultSet);
			    
			    stmtSailk.close();
			    conn.close();
		
		  }catch(Exception e){
			  e.printStackTrace();
			  conn.close();
		  }finally{
			  conn.close();
		  }
		  return RESULTDATA;
		}
	
	public ArrayList<String> insert(String branch,Date sqlFromDate, Date sqlToDate, String cldocno, String rentalType, String agmtNo,HttpSession session,String cmbtype,HttpServletRequest request) throws SQLException {
		int invdocno=0;
		ArrayList<String> voucherarray=new ArrayList<>();
		Connection conn=null;
		try{
			conn = objconn.getMyConnection();
		    Statement stmtSailk = conn.createStatement();
		    conn.setAutoCommit(false);
	        
		    String sql = "";
		    
			
			
			if(!(sqlFromDate==null)){
	        	sql+=" and s.sal_date>='"+sqlFromDate+"'";
		     }
	        
	        if(!(sqlToDate==null)){
	        	sql+=" and s.sal_date<='"+sqlToDate+"'";
		     }
	        
	        if(!(cldocno.equalsIgnoreCase(""))){
	        	sql+=" and a.cldocno='"+cldocno+"'";
	        }
	        
	        if(!(rentalType.equalsIgnoreCase(""))){
	        	if(rentalType.equalsIgnoreCase("RAG")){
	        		sql+=" and s.rtype IN ('RM','RA', 'RD','RW','RF')";
	        	}
	        	else if(rentalType.equalsIgnoreCase("LAG")){
	        		sql+=" and s.rtype IN ('LA', 'LC')";
	        	}
	         }
	        
	       /* if(!(agmtNo.equalsIgnoreCase(""))){
	        	sql+=" and s.ra_no='"+agmtNo+"'";
	           }
			*/
	        if(cmbtype.equalsIgnoreCase("Daily")){
	        	sql+=" and s.rtype in ('RD')";
	        }
	        else if(cmbtype.equalsIgnoreCase("Weekly")){
	        	sql+=" and s.rtype in ('RW')";
	        }
	        else if(cmbtype.equalsIgnoreCase("Monthly")){
	        	sql+=" and s.rtype in ('RM')";
	        }
	        else if(cmbtype.equalsIgnoreCase("Lease")){
	        	sql+=" and s.rtype IN ('LA', 'LC')";
	        }
			/*sql = "select if(s.rtype in ('RM','RA', 'RD','RW','RF'),ragmt.voc_no,lagmt.voc_no) vocno,s.sr_no,s.regno,s.tagno,s.fleetno,s.location,s.direction,s.source,s.amount,s.ra_no,a.refname,s.rtype,s.sal_date"+
					" from gl_salik s left join gl_ragmt ragmt on (s.ra_no=ragmt.doc_no and s.rtype in ('RA','RD','RW','RF','RM')) left join gl_lagmt"+
					" lagmt on (s.ra_no=lagmt.doc_no and s.rtype in ('LA','LC')) left join my_acbook a on (s.emp_id=a.cldocno and s.emp_type=a.dtype) where inv_no=0 and isallocated=1 and"+
					" s.ra_no<>0 and s.amount>0 "+sql+" and if(s.rtype in ('RA','RD','RW','RF','RM'),ragmt.brhid="+branch+",lagmt.brhid="+branch+") order by s.rtype,s.ra_no";
*/			String strsalikacno="select (select acno from gl_invmode where idno=8)salikacno,(select acno from gl_invmode where idno=14)saliksrvcacno";
			//System.out.println("Acno Query : "+strsalikacno);
			ResultSet rsacno=stmtSailk.executeQuery(strsalikacno);
			int salikacno=0;
			int saliksrvcacno=0;
			double saliksrvcrate=0.0;
			while(rsacno.next()){
				salikacno=rsacno.getInt("salikacno");
				saliksrvcacno=rsacno.getInt("saliksrvcacno");
			}
			String tempvoucher="";
	        String strsql="select head.doc_no acno,head.curid,head.rate,lagmt.brhid,lagmt.doc_no agmtno,sum(s.amount) amount,sum(if(coalesce(a.ser_default,0)=0,a.per_salikrate,(select coalesce(value,0) from gl_config where"+
		        " field_nme='saliksrv' and method=1))) saliksrvc,count(*) salikcount,a.refname,a.cldocno from gl_salik s left join gl_lagmt lagmt on "+
	        " (s.ra_no=lagmt.doc_no and s.rtype in ('LA','LC')) left join my_acbook a on (s.emp_id=a.cldocno and s.emp_type=a.dtype) left join my_head head on (a.acno=head.doc_no) where inv_no=0 and "+
	        " isallocated=1 and s.ra_no<>0 and s.amount>0  "+sql+" and if(s.rtype in ('LA','LC'),lagmt.brhid="+branch+",0) group by a.cldocno";
	        System.out.println(strsql);
	        ResultSet rs=stmtSailk.executeQuery(strsql);
	        while (rs.next()) {
	        	String clientname=rs.getString("refname");
				int salikcount=rs.getInt("salikcount");
				double salikamt=rs.getDouble("amount");
				double saliksrvc=rs.getDouble("saliksrvc");
				int brhid=rs.getInt("brhid");
				int curid=rs.getInt("curid");
				double currate=rs.getDouble("rate");
				int agmtno=rs.getInt("agmtno");
				int clientdocno=rs.getInt("cldocno");
				int acno=rs.getInt("acno");
	        	ArrayList<String> invoicearray=new ArrayList<>();
				String note=objcommon.changeSqltoString(sqlFromDate) +" to "+objcommon.changeSqltoString(sqlToDate) +" Salik for "+clientname;
				//System.out.println("Salik Srvc: "+saliksrvc);
				invoicearray.add(8+"::"+salikacno+"::"+note+"::"+salikcount+"::"+salikamt+"::"+salikamt);
				invoicearray.add(14+"::"+saliksrvcacno+"::"+note+"::"+salikcount+"::"+saliksrvc+"::"+saliksrvc);
				invdocno=customInvoiceInsert(invoicearray,note,sqlFromDate,sqlToDate,conn,curid,currate,brhid,agmtno,clientdocno,acno,session,
						request,salikamt,saliksrvc,salikcount,sql);
				if(tempvoucher.equalsIgnoreCase("")){
					tempvoucher+=invdocno;
				}
				else{
					tempvoucher+=","+invdocno;
				}
	        }
	        
	        String strvocno="select voc_no from gl_invm where doc_no in ("+tempvoucher+")";
	        ResultSet rsvocno=stmtSailk.executeQuery(strvocno);
	        while(rsvocno.next()){
	        	voucherarray.add(rsvocno.getString("voc_no"));
	        }
	        if(voucherarray.size()>0){
		        conn.commit();
	        }
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		return voucherarray;
	}

	private int customInvoiceInsert(ArrayList<String> invoicearray,
			String note, Date sqlFromDate, Date sqlToDate, Connection conn, int currencyid, double currencyrate, int cmbbranch, int agmtno, int cldocno,
			int acno,HttpSession session,HttpServletRequest request,double salikamount,double saliksrvc,int salikcount,String sql) throws SQLException {
		// TODO Auto-generated method stub
		int invdocno=0;
		try{
			Statement stmt=conn.createStatement();
			java.sql.Date duedate=null;
			int saliksrvcacno=0;
			String stracperiod="select DATE_ADD(if('"+sqlToDate+"' is null,null,'"+sqlToDate+"'), INTERVAL (select period2 from my_acbook where cldocno="+cldocno+" and dtype='CRM') DAY) duedate";
			//System.out.println(stracperiod);
			ResultSet rsacperiod=stmt.executeQuery(stracperiod);
			while(rsacperiod.next()){
				duedate=rsacperiod.getDate("duedate");
			}
			//Inserting into Master Invoice Table
			CallableStatement stmtManual = conn.prepareCall("{call invoiceDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmtManual.registerOutParameter(14, java.sql.Types.INTEGER);
			stmtManual.registerOutParameter(15, java.sql.Types.INTEGER);
			stmtManual.registerOutParameter(17, java.sql.Types.INTEGER);
			stmtManual.setDate(1,sqlToDate);
			stmtManual.setString(2,"LAG");
			stmtManual.setString(3,cldocno+"");
			stmtManual.setInt(4, agmtno);
			stmtManual.setString(5,note);
			stmtManual.setString(6,note);
			stmtManual.setString(7,currencyid+"");
			stmtManual.setString(8,acno+"");
			stmtManual.setDate(9,sqlFromDate);
			stmtManual.setDate(10,sqlToDate);
			stmtManual.setString(11,"INV");
			stmtManual.setString(12,session.getAttribute("USERID").toString());
			stmtManual.setString(13,cmbbranch+"");
			stmtManual.setString(16,"A");
			//		System.out.println(stmtManual);
			stmtManual.executeQuery();
			invdocno=stmtManual.getInt("docNo");
			int invtrno=stmtManual.getInt("vtrNo");
			request.setAttribute("INVTRNO", invtrno);
			
			//Updating Manual of Invoice
			String strupdatemanual="update gl_invm set manual=12 where doc_no="+invdocno;
			int updatemanual=stmt.executeUpdate(strupdatemanual);
			if(updatemanual<0){
				return 0;
			}
			
			//Inserting Detail Data
			int tempno=1;
			for(int i=0;i<invoicearray.size();i++){
				System.out.println("Displaying Invoice Array Data "+invoicearray.get(i));
				String invoice[]=invoicearray.get(i).split("::");
				if(invoice[0].equalsIgnoreCase("14")){
					saliksrvcacno=Integer.parseInt(invoice[1]);
				}
				if(!invoice[5].equalsIgnoreCase("") && !invoice[5].equalsIgnoreCase("undefined") && invoice[5]!=null){
					
					double testldramt=currencyrate*Double.parseDouble((invoice[5].equalsIgnoreCase("undefined") || invoice[5].isEmpty()?0:invoice[5]).toString());
					double partydramt=Double.parseDouble((invoice[5].equalsIgnoreCase("undefined") || invoice[5].isEmpty()?0:invoice[5]).toString())*-1;
					double partyldramt=testldramt*-1;
					String strsql="insert into gl_invd(sr_no,brhid,rdocno,trno,chid,units,total,acno,amount)values('"+(i+1)+"','"+cmbbranch+"','"+invdocno+"'"+
							 ",'"+invtrno+"','"+(invoice[0].equalsIgnoreCase("undefined") || invoice[0].isEmpty()?0:invoice[0])+"','"+(invoice[3].equalsIgnoreCase("undefined") || invoice[3].isEmpty()?0:invoice[3])+"','"+(invoice[5].equalsIgnoreCase("undefined") || invoice[5].isEmpty()?0:invoice[5])+"','"+(invoice[1].equalsIgnoreCase("undefined") || invoice[1].isEmpty()?0:invoice[1])+"','"+(invoice[5].equalsIgnoreCase("undefined") || invoice[5].isEmpty()?0:invoice[5])+"')";
					int detailinsert=stmt.executeUpdate(strsql);
					if(detailinsert<0){
						return 0;
					}
					tempno++;
					//Inserting to Lcalc
					/*
					String strlcalc="insert into gl_lcalc(brhid,trno,rdocno,dtype,invoiced,invno,invdate,idno,qty,amount)values('"+cmbbranch+"','"+invtrno+"',"+
							 "'"+agmtno+"','LAG','"+(invoice[5].equalsIgnoreCase("undefined") || invoice[5].isEmpty()?0:invoice[5])+"','"+invdocno+"','"+sqlToDate+"','"+(invoice[0].equalsIgnoreCase("undefined") || invoice[0].isEmpty()?0:invoice[0])+"','"+(invoice[3].equalsIgnoreCase("undefined") || invoice[3].isEmpty()?0:invoice[3])+"','"+(invoice[5].equalsIgnoreCase("undefined") || invoice[5].isEmpty()?0:invoice[5])+"')";
					int lcalcinsert=stmt.executeUpdate(strlcalc);
					if(lcalcinsert<0){
						return 0;
					}
					*/
					
					String strjvcompany="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,dtype,ldramount,"+
							 "doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status,rdocno,rtype)values('"+invtrno+"','"+(invoice[1].equalsIgnoreCase("undefined") || invoice[1].isEmpty()?0:invoice[1])+"',"+
							 "'"+partydramt+"','"+currencyrate+"','"+currencyid+"',0,-1,'"+(i+1)+"',"+
							 "'"+cmbbranch+"','"+note+"',"+
							 "0,'"+sqlToDate+"','INV','"+partyldramt+"','"+invdocno+"','"+(invoice[3].equalsIgnoreCase("undefined") || invoice[3].isEmpty()?0:invoice[3])+"',"+
							 "'"+currencyid+"','5',1,0,3,'"+agmtno+"','LAG')";
					int sqljvcompany=stmt.executeUpdate(strjvcompany);
					if(sqljvcompany<0){
						return 0;
					}
					
				}
			}
			if(salikamount>0){
				String strupdatesalik="update gl_salik s left join gl_lagmt lagmt on (s.ra_no=lagmt.doc_no and s.rtype in ('LA','LC')) left join my_acbook a on (s.emp_id=a.cldocno and s.emp_type=a.dtype) "+
				" set s.inv_no="+invdocno+",s.inv_type='INV',s.status=1 where s.inv_no=0 and s.isallocated=1 and s.ra_no<>0 and s.amount>0  "+sql+" and "+
				" if(s.rtype in ('LA','LC'),lagmt.brhid="+cmbbranch+",0) and s.emp_id="+cldocno+" and s.emp_type='CRM'";
				int updatesalik=stmt.executeUpdate(strupdatesalik);
				if(updatesalik<=0){
					conn.close();
					return 0;
				}
				double salikamt=salikamount+saliksrvc;
				double salikamtldr=salikamt*currencyrate;
				String sqljv="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,dtype,ldramount,"+
				"doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status,rdocno,rtype,duedate)values('"+invtrno+"','"+acno+"',"+
				"'"+salikamt+"','"+currencyrate+"','"+currencyid+"',0,1,8,'"+cmbbranch+"','"+note+"',"+
				"0,'"+sqlToDate+"','INV','"+salikamtldr+"',"+invdocno+",'"+salikcount+" Saliks',"+
				"'"+currencyid+"','5',1,"+cldocno+",3,'"+agmtno+"','LAG','"+duedate+"')";
				
				int jvinsert=stmt.executeUpdate(sqljv);
				if(jvinsert<=0){
					conn.close();
					return 0;
				}
				int srno=0;
				String strgetsalik="select (select coalesce(tranid,0) from my_jvtran where acno="+saliksrvcacno+" and tr_no="+invtrno+") tranid ,count(*),s.fleetno,count(*)*if(ac.ser_default=0,per_salikrate,(select coalesce(value) from gl_config where "+
				" field_nme='saliksrv' and method=1)) saliksrv from gl_salik s left join gl_lagmt agmt on (s.ra_no=agmt.doc_no and s.rtype in ('LA','LC')) "+
				" left join my_acbook ac on (agmt.cldocno=ac.cldocno and ac.dtype='CRM')where s.inv_no="+invdocno+" and s.inv_type='INV' group by s.fleetno";
				ResultSet rsgetsalik=stmt.executeQuery(strgetsalik);
				while(rsgetsalik.next()){
					double saliksrv=(rsgetsalik.getDouble("saliksrv"))*-1;
					String fleetno=rsgetsalik.getString("fleetno");
					int tranid=rsgetsalik.getInt("tranid");
					srno++;
					int costtraninsert=costtranInsert(saliksrv,fleetno,conn,tranid,invtrno,saliksrvcacno,srno);
					if(costtraninsert<=0){
						conn.close();
						return 0;
					}
				}
			}

			
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		return invdocno;
	}

	private int costtranInsert(double saliksrv, String fleetno,
			Connection conn, int tranid, int invtrno, int saliksrvcacno,
			int srno) throws SQLException {
		// TODO Auto-generated method stub
		try{
			Statement stmt=conn.createStatement();
			String strsql="insert into my_costtran(acno,costtype,amount,sr_no,tranid,projectid,jobid,tr_no)values("+saliksrvcacno+",6,"+saliksrv+","+srno+","+tranid+",0,"+fleetno+","+invtrno+")";
			int costinsert=stmt.executeUpdate(strsql);
			if(costinsert<=0){
				return 0;
			}
			else{
				return srno;
			}
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		return 0;
	}
}
