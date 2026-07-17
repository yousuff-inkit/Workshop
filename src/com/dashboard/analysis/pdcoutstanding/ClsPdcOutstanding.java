package com.dashboard.analysis.pdcoutstanding;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Enumeration;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsPdcOutstanding {
	
	ClsConnection connDAO=new ClsConnection();
	ClsCommon commonDAO=new ClsCommon();
	
	public JSONArray pdcOutStandingGridLoading(String branch,String reporttype,String upToDate,String code,String cmbacctype,String txtaccid,String check) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
		try {
				conn = connDAO.getMyConnection();
				Statement stmtPDCOutStanding = conn.createStatement();
				
				java.sql.Date sqlUpToDate=null;
				
				if(check.equalsIgnoreCase("1")){

				String xsql = "",sqls="",sql1 = "",sql2 = "",sql3="",sql4="",sql5="",sql6="";
		        
		        upToDate.trim();
		        if(!(upToDate.equalsIgnoreCase("undefined"))&&!(upToDate.equalsIgnoreCase(""))&&!(upToDate.equalsIgnoreCase("0"))){
		        	sqlUpToDate = commonDAO.changeStringtoSqlDate(upToDate);
		        }
		    
		        if(!(sqlUpToDate==null)){
		        	sql1+=" and m.date<='"+sqlUpToDate+"'";
		        	sql2+=" and j.date<='"+sqlUpToDate+"'";
		        	sql3+=" and m.chqdt<='"+sqlUpToDate+"'";
			    }
		        
		        if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
				     sql4=" and m.brhid='"+branch+"'";
				}
		        
		        if(!(txtaccid.equalsIgnoreCase("0") || txtaccid.equalsIgnoreCase("")))	    
		        {
		            if(cmbacctype.equalsIgnoreCase("Bank")){
		            	xsql+=" and de.acno='"+txtaccid+"'";sql5+=" and d1.acno='"+txtaccid+"'";
		            }else {
		            	xsql+=" and d.opsacno='"+txtaccid+"'";sql5+=" and d.acno='"+txtaccid+"'";
		            }
	            }
		        
		        if(reporttype.equalsIgnoreCase("rdall")){
		        	
			        if(code.equalsIgnoreCase("FPP")) {
				        sqls =  " union all (select m.dtype,m.doc_no,h1.account bank,h1.description bankname,d.acno,h.atype,h.account,h.description accountname,"
				        		+ "d.amount*d.dr amount,d1.acno bankacno,m.brhid,m.chqno,m.chqdt,b1.branchname from my_unclrchqbm m inner join my_unclrchqbd d  on "
				        		+ "(d.rdocno=m.doc_no and m.bpvno=0 and d.sr_no=1) left join my_unclrchqbd d1 on (d1.rdocno=m.doc_no and m.bpvno=0 and d1.sr_no=0 ) "
				        		+ "left join my_head h on (h.doc_no=d.acno) left join my_head h1 on h1.doc_no=d1.acno left join my_brch b1 on d.brhid=b1.doc_no where "
				        		+ "m.status=3"+sql4+""+sql3+""+sql5+")";
		    		}
			        
			        if(code.equalsIgnoreCase("FRO")){
				        sqls =  " union all (select m.dtype,m.doc_no,h1.account bank,h1.description bankname,d.acno,h.atype,h.account,h.description accountname,"
				        		+ "d.amount*d.dr amount,d1.acno bankacno,m.brhid,m.chqno,m.chqdt,b1.branchname from my_unclrchqreceiptm m inner join my_unclrchqreceiptd d  "
				        		+ "on (d.rdocno=m.doc_no and m.bpvno=0 and d.sr_no=1) left join my_unclrchqreceiptd d1  on (d1.rdocno=m.doc_no and m.bpvno=0 and d1.sr_no=0 ) "
				        		+ "left join my_head h on (h.doc_no=d.acno) left join my_head h1 on h1.doc_no=d1.acno left join my_brch b1 on d.brhid=b1.doc_no where "
				        		+ "m.status=3"+sql4+""+sql3+""+sql5+")";
		    		}		
		        }	
		        
		        if(reporttype.equalsIgnoreCase("rduncleared")){
		        	
		        	if(code.equalsIgnoreCase("FPP")) {
		        		
		        		sql6 =  "select m.dtype,m.doc_no,h1.account bank,h1.description bankname,d.acno,h.atype,h.account,h.description accountname,"
				        		+ "d.amount*d.dr amount,d1.acno bankacno,m.brhid,m.chqno,m.chqdt,b1.branchname from my_unclrchqbm m inner join my_unclrchqbd d  on "
		        				+ "(d.rdocno=m.doc_no and m.bpvno=0 and d.sr_no=1) left join my_unclrchqbd d1 on (d1.rdocno=m.doc_no and m.bpvno=0 and d1.sr_no=0 ) "
				        		+ "left join my_head h on (h.doc_no=d.acno) left join my_head h1 on h1.doc_no=d1.acno left join my_brch b1 on d.brhid=b1.doc_no where "
		        				+ "m.status=3"+sql4+""+sql3+""+sql5+"";
		        		
						ResultSet resultSet1 = stmtPDCOutStanding.executeQuery(sql6);
						
						RESULTDATA=commonDAO.convertToJSON(resultSet1);
		    		}else if(code.equalsIgnoreCase("FRO")){
			        	sql6 =  " select m.dtype,m.doc_no,h1.account bank,h1.description bankname,d.acno,h.atype,h.account,h.description accountname,"
				        		+ "d.amount*d.dr amount,d1.acno bankacno,m.brhid,m.chqno,m.chqdt,b1.branchname from my_unclrchqreceiptm m inner join my_unclrchqreceiptd d  "
			        			+ "on (d.rdocno=m.doc_no and m.bpvno=0 and d.sr_no=1) left join my_unclrchqreceiptd d1  on (d1.rdocno=m.doc_no and m.bpvno=0 and d1.sr_no=0 ) "
				        		+ "left join my_head h on (h.doc_no=d.acno) left join my_head h1 on h1.doc_no=d1.acno left join my_brch b1 on d.brhid=b1.doc_no where "
			        			+ "m.status=3"+sql4+""+sql3+""+sql5+"";
			        	
						ResultSet resultSet1 = stmtPDCOutStanding.executeQuery(sql6);
						
						RESULTDATA=commonDAO.convertToJSON(resultSet1);
		    		}		
		        }

		        if(reporttype.equalsIgnoreCase("rdall") || reporttype.equalsIgnoreCase("rdpdc")){
		        
				if (code.trim().equalsIgnoreCase("FPP")){ xsql+=" and m.dtype in ('BPV','IBP','OPP')";}else{ xsql+=" and  m.dtype in ('BRV','IBR')"; }
				
				xsql = "select * from ((select m.dtype,m.doc_no,h1.account bank,h1.description bankname,d.opsacno acno,h.atype, h.account,h.description accountname,"
						+ "de.amount*de.dr amount,de.acno bankacno,d.brhid,d.chqno,d.chqdt,b1.branchname from my_chqbm m inner join my_chqdet d on m.tr_no=d.tr_no "
						+ "inner join my_chqbd de on m.tr_no=de.tr_no and de.gridid<=1 inner join my_brch b1 on de.brhid=b1.doc_no inner join (select account,description,"
						+ "doc_no from my_head where den='305') h1 on de.acno=h1.doc_no left join my_head h on d.opsacno=h.doc_no left join my_jvtran j on d.pdcposttrno=j.tr_no "
						+ "and j.status=3"+sql2+" where m.status=3 and d.pdc=1 and j.tr_no is null"+sql4+""+sql1+""+xsql+")"+sqls+") as a";
				
				
				System.out.println("SQL ="+xsql);
				ResultSet resultSet = stmtPDCOutStanding.executeQuery(xsql);
				RESULTDATA=commonDAO.convertToJSON(resultSet);
		        }
			}
				
			stmtPDCOutStanding.close();
			conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			 conn.close();
		 }
        return RESULTDATA;
    }
	
	public JSONArray accountsDetails(HttpSession session,String atype,String accountno,String accountname,String mobile,String check) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null; 
       
	     try {
		       conn = connDAO.getMyConnection();
		       Statement stmtPDCOutStanding = conn.createStatement();
	
		       Enumeration<String> Enumeration = session.getAttributeNames();
	           int a=0;
	           while(Enumeration.hasMoreElements()){
	            if(Enumeration.nextElement().equalsIgnoreCase("BRANCHID")){
	             a=1;
	            }
	           }
	           if(a==0){
	              return RESULTDATA;
	            }
	           String branch=session.getAttribute("BRANCHID").toString();
	           String company = session.getAttribute("COMPANYID").toString();
	           
		        String sqltest="";
		        String sql="";
		        
		        String code= "";
				
				if(atype.equalsIgnoreCase("AP")){
					code="VND";
				}
				else if(atype.equalsIgnoreCase("AR")){
					code="CRM";
				}
		        
		        if(!(accountno.equalsIgnoreCase("0")) && !(accountno.equalsIgnoreCase(""))){
		            sqltest=sqltest+" and t.account like '%"+accountno+"%'";
		        }
		        if(!(accountname.equalsIgnoreCase("0")) && !(accountname.equalsIgnoreCase(""))){
		         sqltest=sqltest+" and t.description like '%"+accountname+"%'";
		        }
		        if(!(mobile.equalsIgnoreCase("0")) && !(mobile.equalsIgnoreCase(""))){
		         sqltest=sqltest+" and a1.per_mob like '%"+mobile+"%'";
		        }
		        
		        if(check.equalsIgnoreCase("1")){
		        	
	        	if(atype.equalsIgnoreCase("BANK")){
	        		sql="select t.doc_no,t.account,t.description,t.curid,c.code currency,c.c_rate rate from my_head t,"
	                		+ "(select curId from my_brch where doc_no=  '"+branch+"') h,my_curr c,(select (@i:=0)) a where t.m_s=0 and t.atype='GL' "
	                		+ "and c.doc_no=if(t.lApply,h.curId,t.curId) and t.cmpid in(0,'"+company+"') and t.brhid in(0,'"+branch+"') and den='305'"+sqltest;
				}else{
			        sql= "select (@i:=@i+1) recno,t.doc_no,t.account,t.description,t.curid,c.code currency,c.c_rate rate,if(a1.per_mob=0,a1.per_tel,a1.per_mob) mobile from my_head t,my_acbook a1, "
					    + "my_curr c,(select curId from my_brch where doc_no= '"+branch+"') h, (select (@i:=0)) a where  a1.active=1 and t.m_s=0 and c.doc_no=t.curId "
					    + "and t.cldocno=a1.cldocno and a1.dtype='"+code+"' and t.atype='"+atype+"' and c.doc_no=if(a1.brhId=0 and a1.curId=0,h.curId,if(a1.curId=0,h.curId,a1.curid)) and "
					    + "a1.cmpid in(0,'"+company+"') and a1.brhid in(0,'"+branch+"')"+sqltest;
				}
	        	
		       ResultSet resultSet = stmtPDCOutStanding.executeQuery(sql);
		       RESULTDATA=commonDAO.convertToJSON(resultSet);
	           
		       stmtPDCOutStanding.close();
		       conn.close();
		       }
		      stmtPDCOutStanding.close();
			  conn.close();   
	     } catch(Exception e){
		      e.printStackTrace();
		      conn.close();
	     } finally{
			 conn.close();
		 }
	       return RESULTDATA;
	  }
	
}
