package com.operations.vehicletransactions.custody;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.operations.vehicletransactions.replacement.ClsReplacementBean;






public class ClsCustodyDAO{

	ClsConnection connDAO=new ClsConnection();
	ClsCommon commDAO=new ClsCommon();

	Connection conn;
		
		

		public int insert(Date masterDate, Date srenralrefdate,
				String cmbrentaltype, int refno,Date rentdateout, String timeout, String outkm ,
				String cmbfuel, int txtfleetno, String reason,
				String infleettrancode, int mainbranchid,int locid,String mode,
				int coldrid, Date sqlcoldate, String coltime, String colkm, String colfuel,int chkcol,
				String inbranch, String inloc, Date indate, String intime, String inkm, String infuel,int clientid, 
				String formcode, HttpSession session, int searchbranch,String descnew) throws SQLException {
			
			try{
				int docno = 0;
			
				conn=connDAO.getMyConnection();
				
		
				
				CallableStatement stmtcus= conn.prepareCall("{call vehCustodyDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				//main
				stmtcus.registerOutParameter(14, java.sql.Types.INTEGER);
				stmtcus.setDate(1,masterDate);
				stmtcus.setString(2,cmbrentaltype);
				stmtcus.setInt(3,refno);
				stmtcus.setDate(4,srenralrefdate);
				stmtcus.setInt(5,txtfleetno);
				stmtcus.setDate(6,rentdateout);
			    stmtcus.setString(7,timeout);
				stmtcus.setString(8,outkm);
				stmtcus.setString(9,cmbfuel);
				stmtcus.setString(10,reason);
				stmtcus.setInt(11,mainbranchid);
				stmtcus.setInt(12,locid);
				stmtcus.setString(13,infleettrancode);
				stmtcus.setString(15,mode);
				//col
				stmtcus.setInt(16,coldrid);
				stmtcus.setDate(17,sqlcoldate);
				stmtcus.setString(18,coltime);
				stmtcus.setString(19,colkm);
				stmtcus.setString(20,colfuel);
				stmtcus.setInt(21,chkcol);
				//in branch
				stmtcus.setString(22,inbranch);
				stmtcus.setString(23,inloc);
				stmtcus.setDate(24,indate);
				stmtcus.setString(25,intime);
				stmtcus.setString(26,inkm);
				stmtcus.setString(27,infuel);
				stmtcus.setInt(28,clientid);
				stmtcus.setString(29,session.getAttribute("USERID").toString().trim());
				stmtcus.setString(30,session.getAttribute("BRANCHID").toString().trim());
				stmtcus.setString(31,formcode);
				stmtcus.setInt(32,searchbranch);
				
				
				//System.out.println("----stmtcus-----"+stmtcus);
				stmtcus.executeQuery();
				
				docno=stmtcus.getInt("docNo");
				
				
				if(docno<=0)
				{
					conn.close();
					return 0;
					
				}
				

			//	System.out.println("sssssss"+docno);
				if (docno > 0) {
					Statement stmt=conn.createStatement();
					int updateval=stmt.executeUpdate("update gl_vehcustody set description='"+descnew+"' where doc_no="+docno);
					if(updateval>=0){
						stmtcus.close();
						conn.close();
						return docno;
					}
					else{
						conn.close();
						return 0;
					}

				}
			}catch(Exception e){	
				
			e.printStackTrace();	
			conn.close();
			}
			return 0;
		   }
		public int update(Date branchoutdate, String outtime,
				String boutkm, String boutfuel,int docno,String delval, int refno, int fleetno, HttpSession session,String outdesc) throws SQLException {
			
			
			try
			{
				//conn=connDAO.getMyConnection();
			conn=connDAO.getMyConnection();
			CallableStatement branchout=conn.prepareCall("{call vehCustodyBroutDML(?,?,?,?,?,?,?,?,?,?)}");
			branchout.setDate(1,branchoutdate);
			branchout.setString(2,outtime);	
			branchout.setString(3,boutkm);	
			branchout.setString(4,boutfuel);
			branchout.setInt(5,docno);
			branchout.setString(6,delval);
			branchout.setInt(7,refno);
			branchout.setInt(8,fleetno);
			branchout.setString(9,session.getAttribute("USERID").toString().trim());
			branchout.setString(10, outdesc);
		int	aa=branchout.executeUpdate();
		
				if(aa>0)
				{
					branchout.close();	
					conn.close();
					return 1;
				}
				
			}
			catch(Exception e)
			{
			conn.close();
			e.printStackTrace();
			}
			
			
			return 0;
		}
		public int delupdate(int deldriverid, String deliveryto,
				Date deldate, String deltime, String delkm,
				String delfuel, int docno,int refno, int fleetno, HttpSession session) throws SQLException  {
		try{
			
			conn=connDAO.getMyConnection();
			CallableStatement delupdate=conn.prepareCall("{call vehCustodyDelupdate(?,?,?,?,?,?,?,?,?,?)}");
			delupdate.setInt(1,deldriverid);
			delupdate.setString(2,deliveryto);
			delupdate.setDate(3,deldate);
			delupdate.setString(4,deltime);
			delupdate.setString(5,delkm);
			delupdate.setString(6,delfuel);
			delupdate.setInt(7,docno);
			delupdate.setInt(8,refno);
			delupdate.setInt(9,fleetno);
			delupdate.setString(10,session.getAttribute("USERID").toString().trim());
			int bb=delupdate.executeUpdate();
	
			if(bb>0)
			{
				
				delupdate.close();	
				conn.close();
				return 1;
			}
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
			conn.close();
		}
			
			return 0;
		}

		 public  JSONArray mainSearch(String client,String reftype,String searchdate,String agmtno,String fleetno,String docno) throws SQLException {

		        JSONArray RESULTDATA=new JSONArray();
		        Connection conn=null;
		        try {    	
		       // String brnchid=session.getAttribute("BRANCHID").toString();
		    	//System.out.println("name"+sclname);
		    	
		    	String sqltest="";
		    	java.sql.Date sqldate=null;
		    	if(!(searchdate.equalsIgnoreCase(""))){
		    		sqldate=commDAO.changeStringtoSqlDate(searchdate);	
		    	}
		    	
		    	if(!(client.equalsIgnoreCase(""))){
		    		sqltest=sqltest+" and ac.refname like '%"+client+"%'";
		    	}
		    	if(!(reftype.equalsIgnoreCase(""))){
		    		sqltest=sqltest+" and c.rtype like '%"+reftype+"%'";
		    	}
		    	if(!(agmtno.equalsIgnoreCase(""))){
		    		sqltest=sqltest+" and if(c.rtype='RAG',ragmt.voc_no,lagmt.voc_no) like '%"+agmtno+"%'";
		    	}
		    	if(!(fleetno.equalsIgnoreCase(""))){
		    		sqltest=sqltest+" and c.fleet_no like '%"+fleetno+"%'";
		    	}
		    	if(!(docno.equalsIgnoreCase(""))){
		    		sqltest=sqltest+" and c.doc_no='"+docno+"'";
		    	}
		    	
		    	 if(sqldate!=null){
		    		 sqltest=sqltest+" and c.date='"+sqldate+"'";
		    	 }
		        
		    	 conn = connDAO.getMyConnection();
				
						
						Statement stmtsearch = conn.createStatement ();
						String str1Sql="select if(c.rtype='RAG',ragmt.voc_no,lagmt.voc_no) vocno,c.doc_no,c.date,c.rtype,c.rdocno,c.fleet_no,ac.refname from gl_vehcustody c left join gl_ragmt ragmt on "+
								" (c.rdocno=ragmt.doc_no and c.rtype='RAG') left join gl_lagmt lagmt on (c.rdocno=lagmt.doc_no and c.rtype='LAG') left join "+
								" my_acbook ac on(ragmt.cldocno=ac.cldocno or lagmt.cldocno=ac.cldocno) and ac.dtype='CRM' where 1=1 "+sqltest+" group by c.doc_no";
//						System.out.println("=========="+str1Sql);
						ResultSet resultSet = stmtsearch.executeQuery (str1Sql);
						RESULTDATA=commDAO.convertToJSON(resultSet);
						stmtsearch.close();
						conn.close();
						return RESULTDATA;
				}
				catch(Exception e){
					e.printStackTrace();
					conn.close();
				}
		        finally{
					conn.close();
				}
		        //System.out.println(RESULTDATA);
				conn.close();
		        return RESULTDATA;
		    }
		 
		 public  JSONArray getAgmtnoSearch(String docno,String fleet,String regno,String client,String agmttype,String date,String mobile,String branchsearch) throws SQLException {
		
			  String strSql="";
			    JSONArray RESULTDATA=new JSONArray();
			    Connection conn = null;
			    
				try {
				conn=connDAO.getMyConnection();	
					Statement stmtmanual = conn.createStatement ();
//					System.out.println();
//					System.out.println("==========="+docno+fleet+regno);
					String sqltest="";
					String docno5="";
//					System.out.println("checking   "+!((fleet.equalsIgnoreCase("0"))&&(fleet.trim().equalsIgnoreCase(""))&&(docno.isEmpty())));
					
					if(!((docno.equalsIgnoreCase("0"))||(docno.trim().equalsIgnoreCase(""))||(docno.isEmpty()))){
						sqltest=" and agmt.voc_no='"+docno+"'";
					}
					if(!((fleet.equalsIgnoreCase("0"))||(fleet.trim().equalsIgnoreCase(""))||(fleet.isEmpty()))){
						sqltest=sqltest+" and mov.fleet_no like '%"+fleet+"%'";
					}
					if(!((regno.equalsIgnoreCase("0"))||(regno.trim().equalsIgnoreCase(""))||(regno.isEmpty()))){
						sqltest=sqltest+" and veh.reg_no like '%"+regno+"%'";
					}
					if(!((client.equalsIgnoreCase("0"))||(client.trim().equalsIgnoreCase(""))||(client.isEmpty()))){
						sqltest=sqltest+" and ac.refname like '%"+client+"%'";
					}
					if(!((mobile.equalsIgnoreCase("0"))||(mobile.trim().equalsIgnoreCase(""))||(mobile.isEmpty()))){
						sqltest=sqltest+" and ac.per_mob like '%"+mobile+"%'";
					}
					
					java.sql.Date sqlsearchdate=null;
					if(!(date.equalsIgnoreCase("0")||date.equalsIgnoreCase(null)||date.equalsIgnoreCase(""))){
						sqlsearchdate=commDAO.changeStringtoSqlDate(date);
					}
					if(!(sqlsearchdate==null)){
						sqltest=sqltest+" and agmt.date='"+sqlsearchdate+"'";
					}
					//System.out.println("DOCNO:"+docno+"FLEET:"+fleet+"REGNO:"+regno+"CLIENT:"+client+"DATE:"+date+"MOBILE:"+mobile);
					JSONArray jsonArray = new JSONArray();
//				System.out.println("AGMT"+agmttype);
				if(agmttype.equalsIgnoreCase("")){
					conn.close();
					return RESULTDATA;
				}
					if(agmttype.equalsIgnoreCase("RAG")){
					strSql="select agmt.doc_no,agmt.voc_no,agmt.date,mov.fleet_no,mov.dout,mov.tout,round(mov.kmout) kmout,agmt.cldocno,mov.trancode infleettrancode,mov.fout,mov.obrhid,mov.olocid,"+
							" veh.flname,veh.reg_no,ac.refname,br.branchname,loc.loc_name from gl_ragmt agmt left join gl_vmove mov on "+
							" (agmt.doc_no=mov.rdocno and mov.rdtype='RAG') left join gl_vehmaster veh on mov.fleet_no=veh.fleet_no "+
							" left join my_acbook ac on (agmt.cldocno=ac.cldocno and ac.dtype='CRM') left join my_brch br on mov.obrhid=br.doc_no left join my_locm loc "+
							" on mov.olocid=loc.doc_no where agmt.status=3 and agmt.brhid='"+branchsearch+"' and mov.status='OUT' "+sqltest+" order by agmt.doc_no";
					}
					else if(agmttype.equalsIgnoreCase("LAG")){
					strSql="select agmt.doc_no,agmt.voc_no,agmt.date,mov.fleet_no,mov.dout,mov.tout,round(mov.kmout) kmout,agmt.cldocno,mov.trancode infleettrancode,mov.fout,mov.obrhid,mov.olocid,"+
							" veh.flname,veh.reg_no,ac.refname,br.branchname,loc.loc_name from gl_lagmt agmt left join gl_vmove mov on"+
							" (agmt.doc_no=mov.rdocno and mov.rdtype='LAG') left join gl_vehmaster veh on mov.fleet_no=veh.fleet_no"+
							" left join my_acbook ac on (agmt.cldocno=ac.cldocno and ac.dtype='CRM') left join my_brch br on mov.obrhid=br.doc_no left join"+
							" my_locm loc on mov.olocid=loc.doc_no where agmt.status=3 and agmt.brhid='"+branchsearch+"' and mov.status='OUT'"+sqltest+" order by agmt.doc_no";
					}
					if(!(strSql.equalsIgnoreCase(""))){
						ResultSet resultSet = stmtmanual.executeQuery (strSql);

						RESULTDATA=commDAO.convertToJSON(resultSet);
			
					}
					stmtmanual.close();
					conn.close();
					
//					System.out.println(strSql);
					
				}
				catch(Exception e){
					e.printStackTrace();
					conn.close();
				}
				
		
			    return RESULTDATA;
			}
		 
					public  ClsCustodyBean getViewDetails(int docno) throws SQLException {
				        ClsCustodyBean bean= new ClsCustodyBean();
				        Connection conn=null;
						try {
						  conn = connDAO.getMyConnection();
				        Statement stmt1=  conn.createStatement();
				        
				       
				        
				       String sql1="select coalesce(cu.outdesc,'') outdesc ,coalesce(cu.description,'') descnew,if(cu.rtype='RAG',ragmt.voc_no,lagmt.voc_no) vocno ,cu.refbrhid,cu.doc_no, cu.date, cu.rtype, cu.rdocno, cu.refdate, cu.fleet_no,cu.rodate, cu.rotime,round(cu.rokm) rokm, cu.rofuel, "
				       		+ " cu.rbrhid,cu.rlocid, cu.reason,cu.inbrhid,cu.inlocid, cu.indate, cu.intime, round(cu.inkm) inkm, cu.infuel,ac.refname "
				       		+ " ,rl.loc_name,rb.branchname,concat(v.flname,' , ','Reg No :',coalesce(reg_no)) fleetname from gl_vehcustody cu  left join "
				       		+ " my_acbook ac on(ac.cldocno=cu.cldocno and ac.dtype='CRM') left join gl_vehmaster v on v.fleet_no=cu.fleet_no  "
				       		+ "  left join gl_ragmt ragmt on  (cu.rdocno=ragmt.doc_no and cu.rtype='RAG') left join gl_lagmt lagmt on (cu.rdocno=lagmt.doc_no and cu.rtype='LAG') "
				       		+ " left join my_locm rl on(rl.doc_no=cu.rlocid)  left join my_brch rb on(rb.doc_no=cu.rbrhid)   where cu.doc_no='"+docno+"' "; 
				        
				     System.out.println(sql1);
				       
				       ResultSet rs1=stmt1.executeQuery(sql1);
			
				        if(rs1.next())
				        {
				        		bean.setOutdesc(rs1.getString("outdesc"));
				        		bean.setDescnew(rs1.getString("descnew"));
				        	    bean.setSearchbranch(rs1.getInt("refbrhid"));
				        	    bean.setDate(rs1.getString("date"));
					    	    bean.setCmbrentaltype(rs1.getString("rtype"));
					    	    bean.setRefname(rs1.getString("refname"));
					    	    bean.setRefdate(rs1.getString("refdate"));
					    	    
					    	    bean.setTxtfleetname(rs1.getString("fleetname"));
					    	    bean.setDateout(rs1.getString("rodate"));
					    	    bean.setTimeout(rs1.getString("rotime"));
					    	    bean.setOutkm(rs1.getString("rokm"));
					    	    bean.setCmbfuel(rs1.getString("rofuel"));
					    	    bean.setReason(rs1.getString("reason"));
					    	    bean.setTxtbranch(rs1.getString("branchname"));
					    	    bean.setTxtlocation(rs1.getString("loc_name"));
					    	    bean.setTxtfleetno(rs1.getInt("fleet_no"));
					    	    bean.setRefno(rs1.getInt("vocno"));
					    	    bean.setMasterrefno(rs1.getInt("rdocno"));

					    	    //in
					    	    bean.setInbranch(rs1.getString("inbrhid"));
					    	    bean.setInlocation(rs1.getString("inlocid"));
					    	    bean.setIndate(rs1.getString("indate"));
					    	    bean.setIntime(rs1.getString("intime"));
					    	    bean.setBinkm(rs1.getString("inkm"));
					    	    bean.setBinfuel(rs1.getString("infuel"));
				        }
				        stmt1.close();
				        
				        Statement stmt2=  conn.createStatement();
				        String sql2="select c.cdrid, c.cdate, c.ctime, round(c.ckm) ckm, c.cfuel,s.sal_name  from gl_vehcustody c left join my_salesman s on "
				        		+ " s.doc_no=c.cdrid and s.sal_type='DRV'   where c.cstatus=1 and c.doc_no='"+docno+"' "; 
					        
					       ResultSet rs2=stmt2.executeQuery(sql2);
						
				        if(rs2.next())
				        {
				            bean.setCollectiondriver(rs2.getString("sal_name"));
				    	    bean.setColldriverid(rs2.getInt("cdrid"));
				    	    bean.setColleteddate(rs2.getString("cdate"));
				    	    bean.setCollectedtime(rs2.getString("ctime"));
				    	    bean.setColletedkm(rs2.getString("ckm"));
				    	    bean.setCollectedfuel(rs2.getString("cfuel"));
				    	    bean.setCollectintickval(1);
				        		        			        	
				        	
				        }
				        stmt2.close();
				        
				        Statement stmt3=  conn.createStatement();
				        String sql3="select odate, otime, round(okm) okm, ofuel, ostatus, delivery  from gl_vehcustody where ostatus=1 and doc_no='"+docno+"' "; 
					        
					       ResultSet rs3=stmt3.executeQuery(sql3);
						
				        if(rs3.next())
				        {
				        	
				            bean.setOutdate(rs3.getString("odate"));
				    	    bean.setOuttime(rs3.getString("otime"));
				    	    bean.setBoutkm(rs3.getString("okm"));
				    	    bean.setBoutfuel(rs3.getString("ofuel"));
				    	    bean.setDelyesorno(rs3.getString("delivery"));
				    	    bean.setBranchoutval(1);
				    	 
				        		        			        	
				        	
				        }
				        stmt3.close();
				        Statement stmt4=  conn.createStatement();
				        String sql4=" select c.deldrid,c.delto, c.deldate, c.deltime, round(c.delkm) delkm, c.delfuel,s.sal_name  from gl_vehcustody c left join my_salesman s on "
				        		+ " s.doc_no=c.deldrid and s.sal_type='DRV'   where c.delstatus=1 and c.doc_no='"+docno+"' ";
					        
					       ResultSet rs4=stmt4.executeQuery(sql4);
						
				        if(rs4.next())
				        {
				        	
				        	
				            bean.setDeldriver(rs4.getString("sal_name"));
				    	    bean.setDeliveryto(rs4.getString("delto"));
				    	    bean.setDeldriverid(rs4.getInt("deldrid"));
				    	    bean.setDeldate(rs4.getString("deldate"));
				    	    bean.setDeltime(rs4.getString("deltime"));
				    	    bean.setDelkm(rs4.getString("delkm"));
				    	    bean.setDelfuel(rs4.getString("delfuel"));
				    	    bean.setDelchkval(1);
				        		        			        	
				        	
				        }
				        stmt4.close();
				        
				      
				        
				        conn.close();
						}
						catch(Exception e){
							
						e.printStackTrace();
						conn.close();
						} 
						
					
						return bean;
					}
					
					public   ClsCustodyBean getPrint(int docno) throws SQLException {
						ClsCustodyBean printbean = new ClsCustodyBean();
						 Connection conn = null; 
						 try {
							 conn = connDAO.getMyConnection();
					       Statement stmtpaint = conn.createStatement();
					       String strSql="";
					       
					   
					     /* strSql=("select coalesce(dr.name,dr1.name) drivenby,coalesce(r.description,'') description,deldrv.sal_name deldriver,coldrv.sal_name coldriver,"+
					    		  " outloc.loc_name outloc,inloc.loc_name inloc,v.flname infleetname,v1.flname outfleetname,loc.loc_name,r.delstatus delstatus1,r.clstatus,"+
					    		  " usr.user_name,opusr.user_name openuser,main.branchname mainbrch,inbr.branchname inandcolbrch,outbr.branchname outanddelbrch,st.st_desc,"+
					    		  " ac.acno,ac.refname,r.reptype,r.DOC_NO,DATE_FORMAT(r.DATE,'%d-%m-%Y') DATE,if(r.RTYPE='RAG','Rental','Lease') rtype,if(r.RTYPE='RAG',agmt.voc_no,lagmt.voc_no) agmtno,r.RDOCNO,r.RFLEETNO,"+
					    		  " DATE_FORMAT(r.RDATE,'%d-%m-%Y') RDATE,r.RTIME,round(r.RKM) rkm,r.RFUEL 'RFUEL',r.RLOCID,r.TRANCODE,r.REPTYPE,r.USERID,"+
					    		  " r.OBRHID,r.OLOCID,r.OFLEETNO,DATE_FORMAT(r.ODATE,'%d-%m-%Y') odate,r.OTIME,round(r.OKM) okm,r.ofuel 'ofuel',"+
					    		  " if(r.DELSTATUS=0,'NO','YES') delstatus ,r.DELDRVID,r.DELTIME,DATE_FORMAT(r.DELDATE,'%d-%m-%Y') DELDATE,round(r.DELKM) delkm,"+
					    		  " r.DELFUEL 'DELFUEL',r.DELAT,DATE_FORMAT(r.INDATE,'%d-%m-%Y') indate,r.INTIME,round(r.INKM) inkm,r.INFUEL 'infuel',r.INLOC,"+
					    		  " r.CLSTATUS,r.CLDRVID,DATE_FORMAT(r.CLDATE,'%d-%m-%Y') cldate,r.CLTIME,round(r.CLKM) clkm,r.CLFUEL 'CLFUEL', v.flname,"+
					    		  " concat(au.authid,'-',p.code_name,'-',v.reg_no) reg_no , concat(au1.authid,'-',p1.code_name,'-',v1.reg_no) reg_no2 from"+
					    		  " gl_vehreplace r left join gl_vehmaster v on v.fleet_no=r.rfleetno  left join gl_vehplate p on p.doc_no=v.pltid left join"+
					    		  " gl_vehauth au on au.doc_no=v.authid left join gl_vehmaster v1 on v1.fleet_no=r.OFLEETNO  left join gl_vehplate p1 on"+
					    		  " p1.doc_no=v1.pltid left join gl_vehauth au1 on au1.doc_no=v1.authid left join my_brch main on r.rbrhid=main.doc_no"+
					    		  " left join my_brch inbr on r.INBRHID=inbr.doc_no left join my_brch outbr on r.OBRHID=outbr.doc_no left join my_locm loc on"+
					    		  " r.rlocid=loc.doc_no left join gl_ragmt agmt on (r.rdocno=agmt.doc_no and r.rtype='RAG') left join gl_lagmt lagmt on"+
					    		  " (r.rdocno=lagmt.doc_no and r.rtype='LAG') left join my_acbook ac on (((agmt.cldocno=ac.cldocno and r.rtype='RAG' and ac.dtype='CRM') or (lagmt.cldocno=ac.cldocno and r.rtype='LAG'))"+
					    		  " and ac.dtype='CRM') left join gl_rdriver rdr on agmt.doc_no=rdr.rdocno left join gl_ldriver ldr on lagmt.doc_no=ldr.rdocno"+
					    		  " left join gl_drdetails dr on ((rdr.drid=dr.dr_id or ldr.drid=dr.dr_id) and dr.dtype='CRM')"+
					    		  " left join gl_drdetails dr1 on ((agmt.drid=dr1.doc_no or lagmt.drid=dr1.doc_no) and dr1.dtype='DRV')"+
					    		  " left join gl_status st on st.status=r.trancode  left join my_user usr on usr.doc_no=r.userid"+
					    		  " left join my_user opusr on opusr.doc_no=r.outuserid left join my_locm outloc on r.olocid=outloc.doc_no left join my_locm inloc"+
					    		  " on r.inloc=inloc.doc_no left join my_salesman deldrv on (r.deldrvid=deldrv.doc_no and deldrv.sal_type='DRV') left join my_salesman"+
					    		  " coldrv on (r.cldrvid=coldrv.doc_no and coldrv.sal_type='DRV' )where r.doc_no="+docno+" ");
						       
*/					   
					       strSql="select if(cu.rtype='RAG',ragmt.voc_no,lagmt.voc_no) agmtno ,rb.branchname mainbrch,cu.doc_no, DATE_FORMAT(cu.date,'%d-%m-%Y') date, if(cu.RTYPE='RAG','Rental','Lease') rtype, cu.rdocno,"
					       		+ " DATE_FORMAT(cu.refdate,'%d-%m-%Y') refdate,cu.fleet_no RFLEETNO,DATE_FORMAT(cu.rodate,'%d-%m-%Y') RDATE, cu.rotime RTIME,round(cu.rokm) rkm, cu.rofuel 'RFUEL',  cu.rbrhid,cu.rlocid, cu.reason st_desc,cu.inbrhid,cu.inlocid, DATE_FORMAT(cu.indate,'%d-%m-%Y') indate,"
					       		+ "cu.intime, round(cu.inkm) inkm, cu.infuel,ac.acno,ac.refname  ,opusr.user_name openuser,rl.loc_name,rb.branchname,v.flname infleetname,v.reg_no,"
					       		+ "DATE_FORMAT(cu.cdate,'%d-%m-%Y') cldate,cu.ctime cltime,round(cu.ckm) clkm,cu.cfuel clfuel,DATE_FORMAT(cu.odate,'%d-%m-%Y') odate,cu.otime,round(cu.okm) okm,cu.ofuel,DATE_FORMAT(cu.deldate,'%d-%m-%Y') deldate,cu.deltime,round(cu.delkm) delkm,cu.delfuel, "
					       		+ "s.sal_name coldriver,s1.sal_name deldriver from gl_vehcustody cu  left join  my_acbook ac on(ac.cldocno=cu.cldocno and ac.dtype='CRM') "
					       		+ "left join gl_vehmaster v on v.fleet_no=cu.fleet_no    left join gl_ragmt ragmt on  (cu.rdocno=ragmt.doc_no and cu.rtype='RAG') "
					       		+ "left join gl_lagmt lagmt on (cu.rdocno=lagmt.doc_no and cu.rtype='LAG')  left join my_locm rl on(rl.doc_no=cu.rlocid) "
					       		+ "left join my_brch rb on(rb.doc_no=cu.rbrhid) left join my_user opusr on opusr.doc_no=cu.ouserid "
					       		+ "left join my_salesman s on s.doc_no=cu.cdrid and s.sal_type='DRV' left join my_salesman s1 on s1.doc_no=cu.deldrid and s1.sal_type='DRV' "
					       		+ "where cu.doc_no="+docno+" ";
					       
					       // concat('On',' ',DATE_FORMAT(edate, '%d-%m-%Y'),' ','at',' ',DATE_FORMAT(edate, '%H:%i')) opendate

					//      System.out.println(strSql);
					      
					       ResultSet resultSet = stmtpaint.executeQuery(strSql); 
					       
					      ClsCommon common=new ClsCommon();
					       while(resultSet.next()){
					    	   
					    //	   printbean.setLbldrivenby(resultSet.getString("drivenby"));
					    //	   printbean.setLbldescription(resultSet.getString("description"));
					    	   printbean.setLblcoldriver(resultSet.getString("coldriver"));
					    	   printbean.setLbldeldriver(resultSet.getString("deldriver"));
					    	   printbean.setBrwithcompany(" "+resultSet.getString("mainbrch"));
					    	   printbean.setVrano(resultSet.getString("agmtno"));
					    	   printbean.setMtime(resultSet.getString("RTIME"));
					    	   printbean.setPfleetno(resultSet.getString("RFLEETNO"));
					    	   printbean.setPfuel(common.checkFuelName(conn,resultSet.getString("RFUEL")));
					    	   printbean.setPclient(resultSet.getString("refname"));
					    	   printbean.setClientacno(resultSet.getString("acno"));
					    	   printbean.setAgmt(" "+resultSet.getString("rtype"));
					    	   printbean.setPdocno(" "+resultSet.getString("doc_no"));
					    	   printbean.setPdate(resultSet.getString("date"));
					    	   printbean.setPregno(resultSet.getString("reg_no"));
					    	   printbean.setVradate(resultSet.getString("RDATE"));
					    	   printbean.setDtimes(resultSet.getString("rtime"));
					    	   
					    	   printbean.setPopened(resultSet.getString("openuser"));
					    	//   printbean.setReplaced(resultSet.getString("user_name"));
					    //	   printbean.setLbloutlocation(resultSet.getString("outloc"));
					    	   printbean.setLblinlocation(resultSet.getString("loc_name"));
					    	   
					    	  /* if(resultSet.getString("reptype").equalsIgnoreCase("collection")){
					    		   printbean.setReptype("Collection");   
					    	   }
					    	   else{
					    		   printbean.setReptype("At Branch");
					    	   }
*/
					    	   printbean.setPkm(resultSet.getString("rkm"));
					    	   printbean.setPoutdate(resultSet.getString("rdate")); 
					    //	   printbean.setPdelivery(resultSet.getString("delstatus")); 
					    	   printbean.setLblrlocation(resultSet.getString("loc_name"));
					    	   
					    // in
					   	   printbean.setInbrwithcompany(resultSet.getString("mainbrch"));
					    	   printbean.setInvehdate(resultSet.getString("indate"));
					    	   printbean.setInvehtime(resultSet.getString("intime"));
					    	   printbean.setInvehkm(resultSet.getString("inkm"));
					    	   printbean.setInvehfuel(common.checkFuelName(conn,resultSet.getString("INFUEL")));
					    	   printbean.setInvehreason(resultSet.getString("st_desc"));
					    	   printbean.setLblinfleetname(resultSet.getString("infleetname"));
					    	   
				// new out
					    //	   printbean.setNewbrwithcompany(resultSet.getString("outanddelbrch"));
					    	   printbean.setNewvehoutdate(resultSet.getString("odate"));
					    	   printbean.setNewvehouttime(resultSet.getString("otime"));
					   // 	   printbean.setNewvehfleet(resultSet.getString("ofleetno"));
					   // 	   printbean.setNewvehregno(resultSet.getString("reg_no2"));
					    //	   printbean.setLbloutfleetname(resultSet.getString("outfleetname"));
					    	   
					    	   printbean.setNewvehkm(resultSet.getString("okm"));
					    	   printbean.setNewvehfuel(common.checkFuelName(conn, resultSet.getString("oFUEL")));
					 // del
					    //	   printbean.setDelbrwithcompany(resultSet.getString("outanddelbrch"));
					    	   printbean.setDeldate(resultSet.getString("deldate"));
					    	   printbean.setDeltime(resultSet.getString("deltime"));
					    	   printbean.setDelfleet(resultSet.getString("rfleetno"));
					    	   printbean.setDelregno(resultSet.getString("reg_no"));
					    	   printbean.setDelkm(resultSet.getString("delkm"));
					    	   printbean.setDelfuel(common.checkFuelName(conn,resultSet.getString("delfuel")));
					    //	   printbean.setLbldelivery(resultSet.getString("delstatus1"));
					    	   printbean.setLbldelfleetname(resultSet.getString("infleetname"));
					  //col
					    	//   printbean.setColbrwithcompany(resultSet.getString("inandcolbrch"));
					    	   printbean.setColdate(resultSet.getString("cldate"));
					    	   printbean.setColtime(resultSet.getString("cltime"));
					    	   printbean.setColfleet(resultSet.getString("rfleetno"));
					    	   printbean.setColregno(resultSet.getString("reg_no"));
					    	   printbean.setColkm(resultSet.getString("clkm"));
					    	   printbean.setColfuel(common.checkFuelName(conn,resultSet.getString("clfuel"))); 
					    //	   printbean.setLblcollection(resultSet.getString("clstatus"));
					    	   printbean.setLblcolfleetname(resultSet.getString("infleetname"));
					    	   
					    	   
					    	   
					    	   
					       }
					       
					       stmtpaint.close();
					       
					       
					       Statement stmtinvoice10 = conn.createStatement ();
						    String  companysql="select c.company,c.address,c.tel,c.fax,l.loc_name location,b.branchname from gl_vehcustody r  "
						    		+ " left join my_brch b on r.rbrhid=b.doc_no left join my_locm l on l.brhid=b.doc_no "
						    		+ "left join my_comp c on b.cmpid=c.doc_no where r.doc_no="+docno+"  ";

						    
					         ResultSet resultsetcompany = stmtinvoice10.executeQuery(companysql); 
						       
						       while(resultsetcompany.next()){
						    	   
						  
						    	   printbean.setBarnchval(resultsetcompany.getString("branchname"));
						    	   printbean.setCompanyname(resultsetcompany.getString("company"));
						    	  
						    	   printbean.setAddress(resultsetcompany.getString("address"));
						    	 
						    	   printbean.setMobileno(resultsetcompany.getString("tel"));
						    	  
						    	   printbean.setFax(resultsetcompany.getString("fax"));
						    	   printbean.setLocation(resultsetcompany.getString("location"));
						    	  
						    	   
						    	   
						       } 
						       stmtinvoice10.close();
					       
					       
					       conn.close();
					      }
					      catch(Exception e){
					       e.printStackTrace();
					      conn.close();
					      }
						 finally{
								conn.close();
							}
					      return printbean;
					     }

					
				
}