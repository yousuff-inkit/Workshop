package com.operations.agreement.rentalagmtemc;

import java.sql.*;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.connection.*;
import com.common.*;
import com.connection.*;
import com.operations.commtransactions.rentalreceipts.ClsRentalReceiptsDAO;
public class ClsRentalAgmtEMCDAO {
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	ClsRentalReceiptsDAO rentalReceiptsDAO=new ClsRentalReceiptsDAO();
    
	   
    public   JSONArray clientSearch(HttpSession session,String clname,String mob,String lcno,String passno,String nation,String dob,String idno) throws SQLException {
   	 JSONArray RESULTDATA=new JSONArray();

    	java.sql.Date sqlStartDate=null;
    
    	
    
    	if(!(dob.equalsIgnoreCase("undefined"))&&!(dob.equalsIgnoreCase(""))&&!(dob.equalsIgnoreCase("0")))
    	{
    	sqlStartDate = objcommon.changeStringtoSqlDate(dob);
    	}
    	
    		
    	
    	//System.out.println("name"+clname);
    	
    	String sqltest="";
    	
    	if(!(clname.equalsIgnoreCase(""))){
    		sqltest=sqltest+" and c.RefName like '%"+clname+"%'";
    	}
    	if(!(mob.equalsIgnoreCase(""))){
    		sqltest=sqltest+" and (c.per_mob like '%"+mob+"%' or d.mobno like '%"+mob+"%')  ";
    	}
    	if(!(lcno.equalsIgnoreCase(""))){
    		sqltest=sqltest+" and d.dlno like '%"+lcno+"%'";
    	}
    	if(!(passno.equalsIgnoreCase(""))){
    		sqltest=sqltest+" and d.passport_no like '%"+passno+"%'";
    	}
    	if(!(nation.equalsIgnoreCase(""))){
    		sqltest=sqltest+" and d.nation like '%"+nation+"%'";
    	}
    	 if(!(sqlStartDate==null)){
    		sqltest=sqltest+" and d.dob='"+sqlStartDate+"'";
    	} 
        if(!idno.equalsIgnoreCase("")){
        	sqltest+=" and d.visano like '%"+idno+"%'";
        }
    	 Connection conn=null;
		try {
				 conn = objconn.getMyConnection();
				Statement stmtVeh8 = conn.createStatement ();
            	
				int method=0;
				
				String chk="select method  from gl_config where field_nme='Clientinvchk'";
				ResultSet rs=stmtVeh8.executeQuery(chk); 
				if(rs.next())
				{
					
					method=rs.getInt("method");
				}
				
				
				
				
				
		/*		String clsql= ("select distinct a.pcase,d.dob,d.dlno,d.nation,d.name drname,a.contactPerson,a.mail1,a.cldocno,trim(a.RefName) RefName,a.per_mob,concat(coalesce(a.address,''),'  ',coalesce(a.address2,'')) as address ,a.per_tel,a.codeno,a.acno,m.doc_no, "
						+ " trim(m.sal_name) sal_name from my_acbook a left join my_salm m on a.sal_id=m.doc_no and m.status<>7 "
						+ "left join gl_drdetails d on d.cldocno=a.cldocno where a.dtype='CRM' and a.status=3 " +sqltest);
				String clsql= ("select distinct "+method+" method, a.advance,a.invc_method,a.pcase,d.dob,d.dlno,d.nation,d.name drname,a.contactPerson,a.mail1,a.cldocno,trim(a.RefName) RefName,a.per_mob,concat(coalesce(a.address,''),'  ',coalesce(a.address2,'')) as address ,a.per_tel,a.codeno,a.acno,m.doc_no, "
						+ " trim(m.sal_name) sal_name from my_acbook a left join my_salm m on a.sal_id=m.doc_no and m.status<>7 "
						+ "left join gl_drdetails d on d.cldocno=a.cldocno and d.dtype=a.dtype where a.dtype='CRM' and a.status=3 " +sqltest);*/
			
				String clsql= ("select distinct "+method+" method,d.visano idno,coalesce(round(a.balance,2),0) outstanding,c.cldocno,c.advance,c.invc_method,c.pcase,d.dob,d.dlno,d.nation,"+
				" d.name drname,c.contactPerson,c.mail1,trim(c.RefName) RefName,c.per_mob,concat(coalesce(c.address,''),'  ',coalesce(c.address2,'')) as address ,"+
				" c.per_tel,c.codeno,c.acno,m.doc_no,trim(m.sal_name) sal_name from my_acbook c left join ("+
				" select sum(j.dramount) balance,j.acno from my_jvtran j left join my_head h on h.doc_no=j.acno and h.atype='AR' where"+
				" j.status=3 and j.yrid=0 group by j.acno) a on c.acno=a.acno left join my_salm m on c.sal_id=m.doc_no and m.status<>7"+
				" left join gl_drdetails d on d.cldocno=c.cldocno and d.dtype=c.dtype where c.dtype='CRM' and c.status=3 " +sqltest);
				
				//System.out.println("-------------"+clsql);
					
	
				
				ResultSet resultSet = stmtVeh8.executeQuery(clsql);
				
				RESULTDATA=objcommon.convertToJSON(resultSet);
				stmtVeh8.close();
				conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
    

    
    public   JSONArray vehSearch(HttpSession session,String fleetno,String regno,String flname,String color,String group,String aa) throws SQLException {


	   	 JSONArray RESULTDATA=new JSONArray();
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
	   	        
	    	    	

	   	    
	   	    
	        String brid=session.getAttribute("BRANCHID").toString();
	     	

	    	String sqltest="";
	    	
	    	if((!(fleetno.equalsIgnoreCase(""))) && (!(fleetno.equalsIgnoreCase("NA")))){
	    		sqltest=sqltest+" and v.fleet_no like '%"+fleetno+"%'";
	    	}
	    	if((!(regno.equalsIgnoreCase(""))) && (!(regno.equalsIgnoreCase("NA")))){
	    		sqltest=sqltest+" and v.reg_no like '%"+regno+"%'  ";
	    	}
	    	if((!(flname.equalsIgnoreCase(""))) && (!(flname.equalsIgnoreCase("NA")))){
	    		sqltest=sqltest+" and v.FLNAME like '%"+flname+"%'";
	    	}
	    	if((!(color.equalsIgnoreCase(""))) && (!(color.equalsIgnoreCase("NA")))){
	    		sqltest=sqltest+" and c.color like '%"+color+"%'";
	    	}
	    	if((!(group.equalsIgnoreCase(""))) && (!(group.equalsIgnoreCase("NA")))){
	    		sqltest=sqltest+" and g.gname like '%"+group+"%'";
	    	}
	   
	    	 Connection conn=null;
			try {
				 conn = objconn.getMyConnection();
				if(aa.equalsIgnoreCase("yes"))
				{
				
					
					Statement stmtVeh8 = conn.createStatement ();
	            	
					String vehsql="select coalesce(v.calibrationkm,0)+coalesce(v.cur_km,0) totalkm,round(g.emcrate,2) emcrate,m.din,m.tin,(select method from gl_config where field_nme='mrano') mraconfig,plate.code_name platecode,v.doc_no vdocno,v.reg_no,v.fleet_no,v.FLNAME,v.a_loc, "
							+ "	CASE WHEN m.FIN='0.000' THEN 'Level 0/8'  WHEN m.FIN='0.125' THEN 'Level 1/8' WHEN m.FIN='0.250' THEN 'Level 2/8' WHEN m.FIN='0.375' "
							+ "	THEN 'Level 3/8' WHEN m.FIN='0.500' THEN 'Level 4/8' WHEN m.FIN='0.625' THEN 'Level 5/8' "
							+ "	WHEN m.FIN='0.750' THEN 'Level 6/8' WHEN m.FIN='0.875' THEN 'Level 7/8' WHEN m.FIN='1.000' THEN 'Level 8/8' "
							+ "	 END as 'FIN',m.FIN hidfin,m.fleet_no ,m.kmin,c.doc_no,c.color,g.gname,g.doc_no gid from gl_vehmaster v "
							+ "	left join gl_vmove m on v.fleet_no=m.fleet_no  left join my_color c "
							+ " on v.clrid=c.doc_no left join gl_vehgroup g on g.doc_no=v.vgrpid left join gl_vehplate plate on v.pltid=plate.doc_no "
							+ "	where v.a_br="+brid+" and ins_exp >=current_date and v.statu <> 7 and   "
							+ "	m.doc_no=(select (max(doc_no)) from gl_vmove where fleet_no=v.fleet_no) and "
							+ " fstatus in ('L','N') and v.status='IN' and v.tran_code='RR' and v.renttype in ('A','R') " +sqltest;
			System.out.println("---------------"+vehsql);
					ResultSet resultSet = stmtVeh8.executeQuery(vehsql);
					
					RESULTDATA=objcommon.convertToJSON(resultSet);
					stmtVeh8.close();
					
					
					
				}
				conn.close();
				 return RESULTDATA;
			}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
			/*finally
			{
				conn.close();
			}*/
			//System.out.println(RESULTDATA);
	        return RESULTDATA;
	    }



	public int insert(Date sqldate, Date sqloutdate, Date sqlduedate,
			String outtime, String duetime, String cldocno, String description,
			String hidsalesman, String fleetno, String outkm,
			String cmboutfuel, String platecode, String regno,
			String chassisno, String jobcardno, String clientvehremarks,
			String courtesydays, String rate, String formdetailcode,
			String mode, HttpSession session, HttpServletRequest request,ArrayList<String> paymentarray,ArrayList<String> driverarray,
			String clientacno,String branch,String clientname) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn=null;
		int docno=0;
		try{
			conn=objconn.getMyConnection();
			conn.setAutoCommit(false);
			CallableStatement stmtrentalagmt = conn.prepareCall("{CALL rentalAgmtDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
            
	      stmtrentalagmt.registerOutParameter(2, java.sql.Types.INTEGER);
	      stmtrentalagmt.registerOutParameter(39, java.sql.Types.INTEGER);
	      // main
	      stmtrentalagmt.setDate(1,sqldate);
	      stmtrentalagmt.setString(3,fleetno);
	      stmtrentalagmt.setString(4,cldocno);
	      stmtrentalagmt.setInt(5,hidsalesman.trim().equalsIgnoreCase("")?0:Integer.parseInt(hidsalesman));
	      stmtrentalagmt.setString(6,"0");
	      stmtrentalagmt.setString(7,clientacno);
	      // drv
	      stmtrentalagmt.setInt(8,0);
	      stmtrentalagmt.setString(9,"0");
	      stmtrentalagmt.setInt(10,0);
	      stmtrentalagmt.setInt(11,0);
	      stmtrentalagmt.setInt(12,0);
	      // triffmain 
	      stmtrentalagmt.setString(13,"Manual");
	      stmtrentalagmt.setString(14,"0");
	      stmtrentalagmt.setString(15,"0");
	      stmtrentalagmt.setString(16,"0");
	     
	      // thariff sub
	      stmtrentalagmt.setString(17,outkm);
	      stmtrentalagmt.setString(18,cmboutfuel);
	      stmtrentalagmt.setDate(19,sqloutdate);
	      stmtrentalagmt.setString(20,outtime);
	      stmtrentalagmt.setInt(21,0);
	      stmtrentalagmt.setInt(22,0);
	      stmtrentalagmt.setInt(23,0);
	      stmtrentalagmt.setDate(24,sqlduedate);
	      stmtrentalagmt.setString(25,duetime);
	    
	    //payment
	      stmtrentalagmt.setString(26,"0");
	      stmtrentalagmt.setString(27,"0");
	      stmtrentalagmt.setString(28,fleetno);
	      // ex
	      stmtrentalagmt.setString(29,"0");

	      stmtrentalagmt.setString(30,session.getAttribute("COMPANYID").toString().trim());
	      
	      /*if(tasystem.equalsIgnoreCase("Manual"))
	      {
	    	
	      stmtrentalagmt.setString(31,session.getAttribute("BRANCHID").toString().trim());
	      }
	      else
	      {
	    	  
	    	  stmtrentalagmt.setString(31,barchid) ;
	      }*/
	      stmtrentalagmt.setString(31,branch) ;
	     // stmtrentalagmt.setString(31,session.getAttribute("BRANCHID").toString().trim());
	      stmtrentalagmt.setString(32,session.getAttribute("USERID").toString().trim());
	      stmtrentalagmt.setString(33,session.getAttribute("CURRENCYID").toString().trim());

	      stmtrentalagmt.setString(34,"Daily");
	      stmtrentalagmt.setInt(35,0);
	      stmtrentalagmt.setString(36,formdetailcode);
	      stmtrentalagmt.setString(37,mode);
	      stmtrentalagmt.setString(38,"0");
	      stmtrentalagmt.setString(40,"");
	      stmtrentalagmt.setInt(41,0);
	      
	   //  System.out.println("-----------"+stmtrentalagmt);
	 
	      stmtrentalagmt.executeQuery();
	      docno=stmtrentalagmt.getInt("docNo");
	      int vocno=stmtrentalagmt.getInt("vocNo");	
	      request.setAttribute("vocno", vocno);
	      if(docno<=0)
	      {
	    	  conn.close();
	    	  return 0;
	      }
	      String strupdateemc="update gl_ragmt set desc1='"+description+"',emcplate='"+platecode+"', emcregno='"+regno+"', emcchassisno='"+chassisno+"', emcjobcard='"+jobcardno+"', emcremarks='"+clientvehremarks+"', emccourtesydays="+courtesydays+", emcrate="+rate+",emcduedate='"+sqlduedate+"', emcduetime='"+duetime+"' where doc_no="+docno;
	      Statement stmtemc=conn.createStatement();
	      int emcupdate=stmtemc.executeUpdate(strupdateemc);
	      if(emcupdate<=0){
	    	  conn.close();
	    	  return 0;
	      }
	      ArrayList<String> blankarray= new ArrayList<String>();
		    
		  for(int i=0;i< paymentarray.size();i++){
			  String[] payment=paymentarray.get(i).split("::");
			  if(!(payment[1].trim().equalsIgnoreCase("undefined")||payment[1].trim().equalsIgnoreCase("")|| payment[1].trim().equalsIgnoreCase("NaN")|| payment[1].isEmpty()))
			  {

				  // String paytype="'"+ payment[1].trim()+"'";
				  String cardtype=""+(payment[7].trim().equalsIgnoreCase("undefined") ||payment[7].trim().equalsIgnoreCase("")|| payment[7].trim().equalsIgnoreCase("NaN")|| payment[7].isEmpty()?0:payment[7].trim())+"";
				  String paidas=""+(payment[10].trim().equalsIgnoreCase("undefined") ||payment[10].trim().equalsIgnoreCase("")|| payment[10].trim().equalsIgnoreCase("NaN")|| payment[10].isEmpty()?0:payment[10].trim())+"";
				  String Amt= ""+(payment[2].trim().equalsIgnoreCase("undefined") || payment[2].trim().equalsIgnoreCase("")|| payment[2].trim().equalsIgnoreCase("NaN")|| payment[2].isEmpty()?0:payment[2].trim())+"";
				  String paytypeid=""+(payment[8].trim().equalsIgnoreCase("undefined") ||payment[8].trim().equalsIgnoreCase("")|| payment[8].trim().equalsIgnoreCase("NaN")|| payment[8].isEmpty()?0:payment[8].trim())+"";
				  String refdoc=""+(payment[4].trim().equalsIgnoreCase("undefined") ||payment[4].trim().equalsIgnoreCase("")|| payment[4].trim().equalsIgnoreCase("NaN")|| payment[4].isEmpty()?0:payment[4].trim())+"";
				  int cldoc = Integer.parseInt(cldocno);
				  int claccount=Integer.parseInt(clientacno);
				  String aggno=""+docno;
				  double Amount=Double.parseDouble(Amt);
				  int srno=0;
				  String type="";
				  if(!(paidas.equalsIgnoreCase("3")))
				  {
         /*  if(!paytypeid.equalsIgnoreCase("3"))
           {
          	*/
           /* type=paytypeid.equalsIgnoreCase("1")?"rcash":"rcard";
           }
           else
           {
          	 type="ronline"; 
           }*/
           
       /*    String selectsql="select t.doc_no,t.account,t.description from my_account a inner JOIN MY_HEAD t on a.acno=t.doc_no where codeno='"+type+"'";
           
			 ResultSet resSet = stmtrentalagmt.executeQuery(selectsql);
			     if (resSet.next()) {
			    	 headdoc = resSet.getInt("doc_no");
			                      }*/
          	
					  int headdoc=0;
					  String selectsql="select acno from my_cardm where doc_no='"+paytypeid+"' and dtype='mode'";
					  ResultSet resSet = stmtrentalagmt.executeQuery(selectsql);
					  if (resSet.next()) {
						  headdoc = resSet.getInt("acno");
 			          }	
			     
					  String payid="";
					  String advorsec="";
				     if((paidas.equalsIgnoreCase("1")))
				     {
				    	 payid="2"; 
				    	 advorsec="Advance";
				    	 
				    	 
				     }
				     else
				     {
				    	 payid="3"; 
				    	 advorsec="Security";
				     }
          	     	
				     int valre=rentalReceiptsDAO.insert(conn,sqldate,"RRV",paytypeid,headdoc,cardtype,refdoc.trim(),sqldate,"RA"+" "+vocno+" "+advorsec,0,"0",cldoc,claccount,"RAG",aggno,payid,Amount,0.00,0.00,0.00,
		    		 Amount,"RA"+" "+vocno+" "+advorsec,clientname,0.00,blankarray,session,request);
		     
		     
		      srno=(int) request.getAttribute("isrno");
		    if(valre<=0)	{
		    	
		    	 conn.close();
		    	 return 0; 
		    	
		                  }
              }
		    	 
		    	 String sql="INSERT INTO gl_rpyt(payment,mode,amount,acode,cardno,expdate,card,cardtype,paytype,payid,brhid,rdocno,recieptno)VALUES"
					       + " ('"+(payment[0].equalsIgnoreCase("undefined") || payment[0].isEmpty()?0:payment[0])+"',"
					       + "'"+(payment[1].trim().equalsIgnoreCase("undefined") || payment[1].trim().equalsIgnoreCase("")|| payment[1].trim().equalsIgnoreCase("NaN")|| payment[1].isEmpty()?0:payment[1].trim())+"',"
					       + "'"+(payment[2].trim().equalsIgnoreCase("undefined") || payment[2].trim().equalsIgnoreCase("")|| payment[2].trim().equalsIgnoreCase("NaN")|| payment[2].isEmpty()?0:payment[2].trim())+"',"
					       + "'"+(payment[3].trim().equalsIgnoreCase("undefined") ||payment[3].trim().equalsIgnoreCase("")|| payment[3].trim().equalsIgnoreCase("NaN")|| payment[3].isEmpty()?0:payment[3].trim())+"',"
					       + "'"+(payment[4].trim().equalsIgnoreCase("undefined") ||payment[4].trim().equalsIgnoreCase("")|| payment[4].trim().equalsIgnoreCase("NaN")|| payment[4].isEmpty()?0:payment[4].trim())+"',"
					       + "'"+(payment[5].trim().equalsIgnoreCase("undefined") ||payment[5].trim().equalsIgnoreCase("")|| payment[5].trim().equalsIgnoreCase("NaN")|| payment[5].isEmpty()?"":payment[5].trim())+"',"
					        + "'"+(payment[6].trim().equalsIgnoreCase("undefined") ||payment[6].trim().equalsIgnoreCase("")|| payment[6].trim().equalsIgnoreCase("NaN")|| payment[6].isEmpty()?"":payment[6].trim())+"',"
					         + "'"+(payment[7].trim().equalsIgnoreCase("undefined") ||payment[7].trim().equalsIgnoreCase("")|| payment[7].trim().equalsIgnoreCase("NaN")|| payment[7].isEmpty()?0:payment[7].trim())+"',"
					          + "'"+(payment[8].trim().equalsIgnoreCase("undefined") ||payment[8].trim().equalsIgnoreCase("")|| payment[8].trim().equalsIgnoreCase("NaN")|| payment[8].isEmpty()?0:payment[8].trim())+"',"
					       + "'"+(payment[10].trim().equalsIgnoreCase("undefined") ||payment[10].trim().equalsIgnoreCase("")|| payment[10].trim().equalsIgnoreCase("NaN")|| payment[10].isEmpty()?0:payment[10].trim())+"',"
					       +"'"+session.getAttribute("BRANCHID").toString()+"','"+docno+"','"+srno+"')";
					     int resultSet2 = stmtrentalagmt.executeUpdate (sql);
			     if(resultSet2<=0)
			     {
			    	 conn.close();
			    	 return 0; 
			     }
		  
		     
		     //gl_config
		     
		     //update
				 
			     if((paidas.equalsIgnoreCase("3")))
			            
		            {
			    	 
			    	 
			    	 String dateval="select round(value) plusval from gl_config where field_nme='ccrelDate'";
		             
			    	 String plusval="0";
					 ResultSet resSet = stmtrentalagmt.executeQuery(dateval);
					 if (resSet.next()) {
						 plusval = resSet.getString("plusval").trim();
					 }
					     
					 String upsql="update gl_rpyt set reldate=(select DATE_ADD('"+sqloutdate+"', interval '"+plusval+"' day )) where rdocno="+docno+" and payid='"+paidas+"'";
					 int upval = stmtrentalagmt.executeUpdate (upsql);
			   
					 if(upval<=0)
					 {
					 	conn.close();
				    	return 0; 
					 }
							   
			   
		            }
		       }   
			     
			     
		    }
		    
		    
		    
		 	
		    for(int i=0;i< driverarray.size();i++){
		    	String[] driver=driverarray.get(i).split("::");
			    if(!(driver[0].trim().equalsIgnoreCase("undefined")||driver[0].trim().equalsIgnoreCase("")|| driver[0].isEmpty()))
			    {
			    	String sql="INSERT INTO gl_rdriver(drid,brhid,rdocno,cldocno)VALUES"
				    + " ('"+(driver[0].trim().equalsIgnoreCase("undefined") ||driver[0].trim().equalsIgnoreCase("")|| driver[0].isEmpty()?0:driver[0].trim())+"',"
				    +"'"+session.getAttribute("BRANCHID").toString()+"','"+docno+"','"+cldocno+"' )";
				    int resultSet3 = stmtrentalagmt.executeUpdate (sql);
				    if(resultSet3<=0)
				    {   
				    	conn.close();
				    	return 0; 
				    }
			    }
		    }
		    conn.commit();
		 	return	docno;
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		return 0;
	}



	public ClsRentalAgmtEMCBean getViewDetails(HttpSession session, String docno) throws SQLException {
		// TODO Auto-generated method stub
		ClsRentalAgmtEMCBean bean=new ClsRentalAgmtEMCBean();
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String str="select agmt.doc_no,agmt.date,agmt.voc_no,agmt.cldocno,agmt.salid,sal.sal_name,agmt.desc1 description,ac.refname,coalesce(ac.contactperson,'') contactperson,"+
			" coalesce(ac.per_mob,'') mobile,coalesce(ac.mail1,'') email,coalesce(ac.address,'') address,coalesce(ac.per_tel,'') telephone,veh.fleet_no,veh.flname,veh.reg_no,grp.gname,clr.color,"+
			" plate.code_name platecode,agmt.odate outdate,agmt.otime outtime,round(agmt.okm,0) outkm,agmt.ofuel outfuel,agmt.ddate duedate,"+
			" agmt.dtime duetime,agmt.emcplate,agmt.emcregno,agmt.emcchassisno, agmt.emcjobcard,agmt.emcremarks,agmt.emccourtesydays,round(agmt.emcrate,2) emcrate "+
			" from gl_ragmt agmt left join my_acbook ac on (agmt.cldocno=ac.cldocno and ac.dtype='CRM') left join my_salm sal on agmt.salid=sal.doc_no"+
			" left join gl_vehmaster veh on agmt.fleet_no=veh.fleet_no left join gl_vehgroup grp on veh.vgrpid=grp.doc_no left join my_color clr"+
			" on veh.clrid=clr.doc_no left join gl_vehplate plate on veh.pltid=plate.doc_no where agmt.doc_no="+docno+" and agmt.status=3";
			ResultSet rs=stmt.executeQuery(str);
			String temp="";
			while(rs.next()){
				bean.setDocno(rs.getString("doc_no"));
				bean.setDate(rs.getDate("date").toString());
				bean.setVocno(rs.getString("voc_no"));
				bean.setCldocno(rs.getString("cldocno"));
				bean.setClientname(rs.getString("refname"));
				temp="";
				temp+="Contact Person :"+rs.getString("contactperson")+" , Mob :"+rs.getString("mobile")+" , Email :"+rs.getString("email")+" , Address :"+rs.getString("address")+" , Tel No :"+rs.getString("telephone");
				System.out.println("Client temp"+temp);
				bean.setClientdetails(temp);
				bean.setDescription(rs.getString("description"));
				bean.setFleetno(rs.getString("fleet_no"));
				temp="";
				temp+="Reg No : "+rs.getString("reg_no")+" , Name : "+rs.getString("flname")+" , Group : "+rs.getString("gname")+" , Color : "+rs.getString("color")+" , Plate Code : "+rs.getString("platecode");
				bean.setFleetdetails(temp);
				bean.setOutdate(rs.getDate("outdate").toString());
				bean.setHidouttime(rs.getString("outtime"));
				bean.setOutkm(rs.getString("outkm"));
				bean.setHidcmboutfuel(rs.getString("outfuel"));
				bean.setPlatecode(rs.getString("emcplate"));
				bean.setRegno(rs.getString("emcregno"));
				bean.setChassisno(rs.getString("emcchassisno"));
				bean.setJobcardno(rs.getString("emcjobcard"));
				bean.setClientvehremarks(rs.getString("emcremarks"));
				bean.setCourtesydays(rs.getString("emccourtesydays"));
				bean.setRate(rs.getString("emcrate"));
				bean.setDuedate(rs.getDate("duedate").toString());
				bean.setDuetime(rs.getString("duetime"));
			}
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		return bean;
	}
	    
   	 public  ClsRentalAgmtEMCBean getPrint(int docno) throws SQLException {
		 ClsRentalAgmtEMCBean bean = new ClsRentalAgmtEMCBean();
	    	 Connection conn =null;
	      try {
	    	   conn = objconn.getMyConnection();
	       Statement stmtinvoice = conn.createStatement();
	       
	       double totaldays=0; // this for calculate total rate
	       
	       String strSql="";
	   
/*	      strSql=("select r.voc_no,round(r.insex,2) insex,if(r.clstatus=0,'Open','Closed') clstatus, r.doc_no,round(r.addrchg,2) addrchg,r.mrano,round(r.okm) okm,"
		       		+ " CASE WHEN r.ofuel='0.000' THEN 'Level 0/8' WHEN r.ofuel='0.125' THEN 'Level 1/8' WHEN r.ofuel='0.250' "
		       		+ "THEN 'Level 2/8' WHEN r.ofuel='0.375'	THEN 'Level 3/8'	WHEN r.ofuel='0.500' THEN 'Level 4/8' WHEN "
		       		+ "r.ofuel='0.625' THEN 'Level 5/8'  WHEN r.ofuel='0.750' THEN 'Level 6/8' WHEN r.ofuel='0.875' THEN 'Level 7/8' "
		       		+ "WHEN r.ofuel='1.000' THEN 'Level 8/8' 	END as 'ofuel' ,DATE_FORMAT(r.odate,'%d-%m-%Y')odate,r.otime,a.refname,  "
		       		+ "a.address,a.per_mob,a.mail1,br.branchname,concat(v.reg_no,' ',p.code_name) reg_no,v.flname,g.gname,mo.vtype,"
		       		+ "(select round(rate,2) rate  from gl_rtarif where  rdocno="+docno+" and rstatus=7) as rate, (select  round(cdw,2)+round(cdw1,2) "
		       		+ "  from gl_rtarif where  rdocno="+docno+" and rstatus=7) as cdw , (select round(gps,2)+round(babyseater,2)+round(cooler,2) "
		       		+ "	 from gl_rtarif where  rdocno="+docno+" and rstatus=7) as accessories, "
		       		+ "  (select round(kmrest)  from gl_rtarif where  rdocno="+docno+" and rstatus=7) as raextrakm, "
		       		+ "(select round(exkmrte,2)  from gl_rtarif where  rdocno="+docno+" and rstatus=7) as raexxtakmchg,"
		       				+ "(select rentaltype  from gl_rtarif where  rdocno="+docno+" and rstatus=5) as rentaltypes, "
		       				+ " CASE WHEN rc.infuel='0.000' THEN 'Level 0/8' "
		       		+ "	 WHEN rc.infuel='0.125' THEN 'Level 1/8' WHEN rc.infuel='0.250' 	THEN 'Level 2/8' WHEN rc.infuel='0.375' "
		       		+ "	THEN 'Level 3/8'	WHEN rc.infuel='0.500' THEN 'Level 4/8' WHEN rc.infuel='0.625' THEN 'Level 5/8' "
		       		+ "	 WHEN rc.infuel='0.750' THEN 'Level 6/8' WHEN rc.infuel='0.875' THEN 'Level 7/8' WHEN rc.infuel='1.000' "
		       		+ "	  THEN 'Level 8/8' 	 END as 'infuel',round(rc.inkm) inkm,DATE_FORMAT(rc.indate,'%d-%m-%Y') indate,rc.intime,co.color,yo.yom "
		       		+ "	  from gl_ragmt r left join my_acbook a on a.cldocno=r.cldocno  and  a.dtype='CRM' left join gl_drdetails d on "
		       		+ "	  d.cldocno=a.cldocno  left join my_brch br on br.branch=r.brhid left join gl_vehmaster  v on v.fleet_no=r.fleet_no 	   "
		       		+ "	  left join gl_vehgroup g on g.doc_no=v.vgrpid   left join gl_vehmodel mo on mo.doc_no=v.vmodid 	   			        "
		       		+ "left join gl_vehplate p on p.doc_no=v.pltid left join gl_rtarif t on t.rdocno=r.doc_no  	   			"
		       		+ " left join gl_ragmtclosem rc on rc.agmtno=r.doc_no left join gl_yom yo on yo.doc_no=v.yom 	   		"
		       		+ " left join my_color co on co.doc_no=v.clrid   where r.doc_no="+docno+" group by r.doc_no");*/
	       //pai,chaufchg
	       
	       // getting total in cosmo print
	       double cosmoscdw=0.0,cosmocdw=0.0,cosmopai=0.0,cosmodelchg=0.0,cosmorate=0.0;
		   
			
		   String strindigo="select coalesce(agmt.emcchassisno,'') emcchassisno, round(clm.inkm,0) inkm,rpt.cardno,rpt.expdate,agmt.acno,agmt.okm outkm, "
				   + "DATE_FORMAT(agmt.odate,'%d-%m-%y') outdate,agmt.otime outtime,agmt.ofuel outfuel, "
				   +" clm.inkm inkm,DATE_FORMAT(clm.indate,'%d-%m-%y') indate,coalesce(clm.intime,'') intime, "     //clm.infuel infuel, "
				   +"   CASE WHEN clm.infuel='0.000' THEN 'Level 0/8' "
		       		+ "	 WHEN clm.infuel='0.125' THEN 'Level 1/8' WHEN clm.infuel='0.250' 	THEN 'Level 2/8' WHEN clm.infuel='0.375' "
		       		+ "	THEN 'Level 3/8'	WHEN clm.infuel='0.500' THEN 'Level 4/8' WHEN clm.infuel='0.625' THEN 'Level 5/8' "
		       		+ "	 WHEN clm.infuel='0.750' THEN 'Level 6/8' WHEN clm.infuel='0.875' THEN 'Level 7/8' WHEN clm.infuel='1.000' "
		       		+ "	  THEN 'Level 8/8' 	 END as 'infuel', "
				   +" a.refname customername,a.address billingaddr,a.per_mob custmemob,a.mail1 emailid , "
+" concat(agmt.emcplate,'/',agmt.emcregno)emcregno,agmt.emcjobcard,dr.passport_no, coalesce(ra.sal_code,'') rentalagent,coalesce(dr.nation,'') nationality,coalesce(br.tel,'') indigobranchtel,coalesce(br.fax,'') indigobranchmobile,agmt.cldocno from gl_ragmt agmt left join my_brch br on "+
		   " agmt.brhid=br.doc_no left join gl_rdriver rdr on (agmt.doc_no=rdr.rdocno and rdr.status=3) left join gl_drdetails dr on rdr.drid=dr.dr_id "+
		   " left join my_salesman ra on (agmt.raid=ra.doc_no and ra.sal_type='RLA') "
		 + "left join gl_ragmtclosem  clm on  agmt.doc_no=clm.agmtno "
		   +" left join my_acbook a on( agmt.cldocno=a.cldocno and a.dtype='crm') "
		   +" left join (select cardno,expdate,rdocno from gl_rpyt group by rdocno) rpt on agmt.doc_no=rpt.rdocno "
		   + " where agmt.doc_no="+docno;
		   //System.out.println("Indigo"+strindigo);
		   /*left join gl_drdetails d left join gl_rdriver rr  "
   		+ " on rr.drid=d.dr_id where rr.rdocno="+docno+" and rr.srno between(select min(srno) srno from gl_rdriver  where rdocno="+docno+") "
   		+ " and (select max(srno) srno from gl_rdriver  where rdocno="+docno+") and  rr.status=3 where agmt.doc_no="+docno;*/
		   ResultSet rsindigo=stmtinvoice.executeQuery(strindigo);
		   while(rsindigo.next()){
			   bean.setVehdet_chasisno(rsindigo.getString("emcchassisno"));
			  bean.setLblindigobranchmobile(rsindigo.getString("indigobranchmobile"));
			  bean.setLblindigobranchtel(rsindigo.getString("indigobranchtel"));
			  bean.setLblindigocldocno(rsindigo.getString("cldocno"));
			  bean.setLblindigonationality(rsindigo.getString("nationality"));
			  bean.setLblindigorentalagent(rsindigo.getString("rentalagent"));
			  // emc print
			    bean.setAccountnoprint(rsindigo.getString("cardno"));
			  bean.setExpirydate(rsindigo.getString("expdate"));
			  bean.setJob_cardno(rsindigo.getString("emcjobcard"));
			  bean.setReg_no(rsindigo.getString("emcregno"));
			  bean.setEmiratesid(rsindigo.getString("passport_no"));
			  bean.setCustomername(rsindigo.getString("customername"));
			  bean.setCusaddress(rsindigo.getString("billingaddr"));
			  bean.setCustomeremail(rsindigo.getString("emailid"));
			  bean.setCustomerphno(rsindigo.getString("custmemob"));
			  
			  bean.setOutkm(rsindigo.getString("outkm"));
			  bean.setOutdateprint(rsindigo.getString("outdate"));
			  bean.setOutfueldet(rsindigo.getString("outfuel"));
			  bean.setOutdate(rsindigo.getString("outdate"));
			  bean.setOuttime(rsindigo.getString("outtime"));
			  bean.setInmileageprint(rsindigo.getString("inkm"));
			  bean.setIndate(rsindigo.getString("indate"));
			  bean.setIntime(rsindigo.getString("intime"));
			  bean.setInfueldet(rsindigo.getString("infuel"));
			  bean.setInkm(rsindigo.getString("inkm") );
			  bean.setIndateprint(rsindigo.getString("indate"));
		   }
		   
		   String strrentserdue="select lst_srv from gl_vehmaster where doc_no="+docno+"";
		   
		   System.out.println("----suss---"+strrentserdue);
		   ResultSet rarentserdue=stmtinvoice.executeQuery(strrentserdue);
		   while(rarentserdue.next()){
			   bean.setRarentserdue(rarentserdue.getString("lst_srv"));
		   }
		  
		   String strindigotarif="select (select rentaltype  from gl_rtarif where  rdocno="+docno+" and rstatus=5) as rentaltype,"+
		   "(select round(rate,2) rate  from gl_rtarif where  rdocno="+docno+" and rstatus=5) as rate,"+
		   "(select round(rate,2) rate  from gl_rtarif where  rdocno="+docno+" and rstatus=6) as discount,"+
		   "(select round(rate,2) rate  from gl_rtarif where  rdocno="+docno+" and rstatus=7) as nettotal";
		   
		   
		   ResultSet rsindigotarif=stmtinvoice.executeQuery(strindigotarif);
		   while(rsindigotarif.next()){
			   /*if(rsindigotarif.getString("rentaltype").equalsIgnoreCase("Monthly")){
				   bean.setLblindigorenttype(rsindigotarif.getString("rentaltype")+"(30 Days)");
			   }
			   else{
				   bean.setLblindigorenttype(rsindigotarif.getString("rentaltype"));
			   }
			   bean.setLblindigorate(rsindigotarif.getString("rate"));
			   bean.setLblindigodiscount(rsindigotarif.getString("discount"));
			   bean.setLblindigonettotal(rsindigotarif.getString("nettotal"));*/
			   
		   }
		   
		      strSql=("select DATE_FORMAT(r.ddate,'%d-%m-%Y') ddate, dtime, ra.sal_name ragnt,sa.sal_name sagnt, sm.sal_name ,   round(coalesce(r.delchg,0),2) delchg,a.per_tel,if(a.ser_default=1,if(g1.method=1,round(g1.value,2),0),round(per_salikrate,2)) salikcharge, \r\n" 
		    		    + "    if(a.ser_default=1,round(g2.value,2),round(per_trafficharge,2)) trafficcharge, \r\n"  
		      		    + "     4+if(a.ser_default=1,if(g1.method=1,round(g1.value,2),0),round(per_salikrate,2)) saliktotal,concat(u.authid,' ',p.code_name,' ',v.reg_no) reg_noval,r.voc_no,round(r.insex,2) insex,if(r.clstatus=0,'Open','Closed') clstatus,a.per_tel,a.fax1, r.doc_no,round(r.addrchg,2) addrchg,r.mrano,round(r.okm) okm,"
			       		+ " CASE WHEN r.ofuel='0.000' THEN 'Level 0/8' WHEN r.ofuel='0.125' THEN 'Level 1/8' WHEN r.ofuel='0.250' "
			       		+ "THEN 'Level 2/8' WHEN r.ofuel='0.375'	THEN 'Level 3/8'	WHEN r.ofuel='0.500' THEN 'Level 4/8' WHEN "
			       		+ "r.ofuel='0.625' THEN 'Level 5/8'  WHEN r.ofuel='0.750' THEN 'Level 6/8' WHEN r.ofuel='0.875' THEN 'Level 7/8' "
			       		+ "WHEN r.ofuel='1.000' THEN 'Level 8/8' 	END as 'ofuel' ,DATE_FORMAT(r.odate,'%d-%m-%Y')odate,r.otime,a.refname,  "
			       		+ "a.address,a.per_mob,a.mail1,br.branchname,concat(v.reg_no,' ',p.code_name) reg_no,v.flname,g.gname,mo.vtype,"
			       		+ "(select round(rate,2) rate  from gl_rtarif where  rdocno="+docno+" and rstatus=7) as rate, (select  round(cdw,2)+round(cdw1,2) "
			       		+ "  from gl_rtarif where  rdocno="+docno+" and rstatus=7) as cdw , (select round(gps,2)+round(babyseater,2)+round(cooler,2) "
			       		+ "	 from gl_rtarif where  rdocno="+docno+" and rstatus=7) as accessories, "
			       				+ " (select round(cdw1,2)  from gl_rtarif where  rdocno="+docno+" and rstatus=7) as scdw , "
			       					+ " (select round(cdw1,2)  from gl_rtarif where  rdocno="+docno+" and rstatus=7) as vmd , "
			       		+ "  (select round(kmrest,2)  from gl_rtarif where  rdocno="+docno+" and rstatus=7) as raextrakm, "
			       		+ "(select round(exkmrte,2)  from gl_rtarif where  rdocno="+docno+" and rstatus=7) as raexxtakmchg,"
			       		+ "(select round(pai,2)  from gl_rtarif where  rdocno="+docno+" and rstatus=7) as pai,"
			       		+ "(select round(chaufchg,2)  from gl_rtarif where  rdocno="+docno+" and rstatus=7) as chaufchg,"
			       				+ "(select rentaltype  from gl_rtarif where  rdocno="+docno+" and rstatus=5) as rentaltypes, "
			       				+ " CASE WHEN rc.infuel='0.000' THEN 'Level 0/8' "
			       		+ "	 WHEN rc.infuel='0.125' THEN 'Level 1/8' WHEN rc.infuel='0.250' 	THEN 'Level 2/8' WHEN rc.infuel='0.375' "
			       		+ "	THEN 'Level 3/8'	WHEN rc.infuel='0.500' THEN 'Level 4/8' WHEN rc.infuel='0.625' THEN 'Level 5/8' "
			       		+ "	 WHEN rc.infuel='0.750' THEN 'Level 6/8' WHEN rc.infuel='0.875' THEN 'Level 7/8' WHEN rc.infuel='1.000' "
			       		+ "	  THEN 'Level 8/8' 	 END as 'infuel',round(rc.inkm) inkm,DATE_FORMAT(rc.indate,'%d-%m-%Y') indate,rc.intime,co.color,yo.yom "
			       		+ "	  from gl_ragmt r left join my_acbook a on a.cldocno=r.cldocno  and  a.dtype='CRM' left join gl_drdetails d on "
			       		+ "	  d.cldocno=a.cldocno  left join my_brch br on br.branch=r.brhid left join gl_vehmaster  v on v.fleet_no=r.fleet_no 	   "
			       		+ "	  left join gl_vehgroup g on g.doc_no=v.vgrpid left join  my_salesman sa on sa.doc_no=r.said and sa.sal_type='SLA'  left join  my_salesman ra on ra.doc_no=r.raid and  ra.sal_type='RLA' "
			       		+ " left join gl_config g1 on g1.field_nme='saliksrv'\r\n" + 
			       		"    left join gl_config g2 on g2.field_nme='trafficsrv'    left join gl_vehmodel mo on mo.doc_no=v.vmodid  left join gl_vehauth u on u.doc_no=v.authid	   			        "
			       		+ "left join gl_vehplate p on p.doc_no=v.pltid left join gl_rtarif t on t.rdocno=r.doc_no  	   			"
			       		+ " left join gl_ragmtclosem rc on rc.agmtno=r.doc_no left join gl_yom yo on yo.doc_no=v.yom 	   		"
			       		+ " left join my_color co on co.doc_no=v.clrid  left join my_salm sm on sm.doc_no=r.salid   where r.doc_no="+docno+" group by r.doc_no");
		      

	      
	      
	      System.out.println("-----iu----"+strSql);
	      
	      
	       
		      
	 
	       ResultSet resultSet = stmtinvoice.executeQuery(strSql); 
	       
	     
	       while(resultSet.next()){
	    	  // bean.setLbmasterdate(resultSet.getString("date"));
	    	   
	    	   // cldatails
	    	   
	    	  // getDuedate getSalagent getRaagent
	    	    
	    	   bean.setDuedate(resultSet.getString("ddate"));
		//mm
		  bean.setDuetime(resultSet.getString("dtime"));

	    	   bean.setRaagent(resultSet.getString("ragnt"));
	    	   bean.setSalagent(resultSet.getString("sagnt"));
	    	  
	    	   
	    	   

	    	   bean.setSalikcharge(resultSet.getString("salikcharge"));
	    	   bean.setTrafficcharge(resultSet.getString("trafficcharge"));
	    	   bean.setTotalsalikandtraffic(resultSet.getString("saliktotal"));
	    	   
	    	    bean.setClname(resultSet.getString("refname"));
	    	    bean.setCladdress(resultSet.getString("address"));
	    	    bean.setClemail(resultSet.getString("mail1"));
	    	    bean.setClmobno(resultSet.getString("per_mob"));
		//mm
		   bean.setSalname(resultSet.getString("sal_name"));
	    	    
	    	    bean.setLdllandno(resultSet.getString("per_tel"));
	    	    
	    	    //upper
	    	   
	    	    bean.setMrano(resultSet.getString("mrano"));
	    	    bean.setRentaldoc(resultSet.getString("voc_no"));
	    	    
	    	    
	    	//    bean.setLbfueltype(resultSet.getString("fueltype"));
	    	 //   bean.setLbmodel(resultSet.getString("vtype"));
	 
	    	    
	    	  // veh details
	    	    
	    	    
	    	    bean.setRavehname(resultSet.getString("flname"));
	    	    bean.setRavehgroup(resultSet.getString("gname"));
	    	    bean.setRavehmodel(resultSet.getString("vtype"));
	    	    bean.setRavehregno(resultSet.getString("reg_no"));
	    	    bean.setRadateout(resultSet.getString("odate"));
	    	    bean.setRatimeout(resultSet.getString("otime"));
	    	    bean.setRaklmout(resultSet.getString("okm"));
	    	    
	    	    
	    	    
	    	
	    	    
	    	    // rental type
	    	    
	    	 //   bean.setRadaily(resultSet.getString("daily"));
	    	   // bean.setRaweakly(resultSet.getString("weekly"));
	    	  //  bean.setRamonthly(resultSet.getString("monthly"));
	    	    bean.setTariff(resultSet.getString("rate"));
	    	    bean.setRacdwscdw(resultSet.getString("cdw"));
	    	    bean.setRaaccessory(resultSet.getString("accessories"));
	    	    bean.setRaadditionalcge(resultSet.getString("addrchg"));
	    	    
	    	    
	    	    bean.setRasupercdw(resultSet.getString("scdw"));
	    	    bean.setRavmd(resultSet.getString("vmd"));
	    	    
	    	    
	    	    
	    	// in details
	    	    
		    	   bean.setColdates(resultSet.getString("indate"));
		    	   bean.setColtimes(resultSet.getString("intime"));
		    	   bean.setColkmins(resultSet.getString("inkm"));
		    	   bean.setColfuels(resultSet.getString("infuel"));
	    	    
	    	   // bean.setKmused(resultSet.getString("kmused"));
	    	   // bean.setNoofdays(resultSet.getString("noofdays"));
	    	     
	    	   
	    	  //  bean.setPertel(resultSet.getString("per_tel"));
	    	  //  bean.setFaxno(resultSet.getString("fax1"));
	    	         
	    	    
	    	    
	    	    
	    	    bean.setOutdetails("Delivered");
	    	    
	    	    bean.setColdetails("Collected");
	    	    
	    	  //  setIndetails,setColdetails
	    	    
	    	  
	    	    bean.setRastatus(resultSet.getString("clstatus"));
	    	    bean.setRafuelout(resultSet.getString("ofuel"));
	    	   //
	    	    
	    	   bean.setRayom(resultSet.getString("yom"));
	    	   bean.setRacolor(resultSet.getString("color")) ;
	    	   
	    	   
	    	   //setRaextrakm,setRaexxtakmchg
	    	   
	    	   bean.setRaextrakm(resultSet.getString("raextrakm"));
	    	   bean.setRaexxtakmchg(resultSet.getString("raexxtakmchg"));
	    	   bean.setRarenttypes(resultSet.getString("rentaltypes"));
	    	 
	    	   //pai,chaufchg
	    	   bean.setLblpai(resultSet.getString("pai"));
	    	   bean.setLaldelcharge(resultSet.getString("delchg"));
	    	   bean.setLblchafcharge(resultSet.getString("chaufchg"));
	    	   
	    	//   getLblpai() ,  getLaldelcharge() getLblchafcharge()
	    	   
	    	   
	    	   /*if(resultSet.getString("cdw").equalsIgnoreCase("0.00"))
	    			   {
	    		   bean.setExcessinsu(resultSet.getString("insex")); 
	    	 
	    			   }
	    	   else
	    	   {
	    		    
	    		   bean.setExcessinsu("0.00");   
	    	   }*/
	    	   
	// driven
	    	   //  setLblpertel setLblfaxno   setLbldobdate setLblradlno setDrivravehregno 
	   	    bean.setLblclname(resultSet.getString("refname"));
 	    bean.setLblcladdress(resultSet.getString("address"));
 	    bean.setLblclemail(resultSet.getString("mail1"));
 	    bean.setLblclmobno(resultSet.getString("per_mob"));   
	    	   
 	    bean.setDrivravehregno(resultSet.getString("reg_noval"));   
 	    bean.setLblpertel(resultSet.getString("per_tel"));
	    	 bean.setLblfaxno(resultSet.getString("fax1"));
	    	 
	    	 
	    	 
	    	// setLbldobdate    setLblradlno   setLbcardno setLbexpcarddate 
			
				 
	    	  
	    	 //For getting total in cosmo print
	    	 cosmoscdw=resultSet.getDouble("scdw");
	    	 cosmocdw=resultSet.getDouble("cdw");
	    	 cosmopai=resultSet.getDouble("pai");
	    	 cosmodelchg=resultSet.getDouble("delchg");
	    	 cosmorate=resultSet.getDouble("rate");
	    	 
	    	
	       }
	       
		   
	       String strcosmo="select (select round(rate,2) rate  from gl_rtarif where  rdocno="+docno+" and rstatus=7) as rate,"+
	    		  " round(coalesce(r.delchg,0),2) delchg,(select round(pai,2)  from gl_rtarif where  rdocno="+docno+" and rstatus=7) as pai,"+
	    		   " (select  round(cdw,2)+round(cdw1,2) from gl_rtarif where  rdocno="+docno+" and rstatus=7) as cdw,"+
	    		  " (select round(cdw1,2)  from gl_rtarif where  rdocno="+docno+" and rstatus=7) as scdw,round(rc.colchg,2) cosmocollectchg,"+
	    		  " (select round(gps,2) from gl_rtarif where  rdocno="+docno+" and rstatus=7) as cosmogps,"+
	    		  " (select round(babyseater,2) from gl_rtarif where  rdocno="+docno+" and rstatus=7) as cosmobabyseater,"+
	    		  " (select round(cooler,2) from gl_rtarif where  rdocno="+docno+" and rstatus=7) as cosmocooler,"+
	    		  " (select round(kmrest,2) kmrest  from gl_rtarif where  rdocno="+docno+" and rstatus=1) cosmokmrestrictdaily,"+
	    		  " (select round(kmrest,2) kmrest  from gl_rtarif where  rdocno="+docno+" and rstatus=2) cosmokmrestrictweekly,"+
	    		  " (select round(kmrest,2) kmrest  from gl_rtarif where  rdocno="+docno+" and rstatus=3) cosmokmrestrictmonthly,"+
	    		  " (select round(exkmrte,2) exkmrte  from gl_rtarif where  rdocno="+docno+" and rstatus=1) cosmoexkmratedaily,"+
	    		  " (select round(exkmrte,2) exkmrte  from gl_rtarif where  rdocno="+docno+" and rstatus=2) cosmoexkmrateweekly,"+
	    		  " (select round(exkmrte,2) exkmrte  from gl_rtarif where  rdocno="+docno+" and rstatus=3) cosmoexkmratemonthly,"+
	    		  " if(pyt.payid=1,pyt.amount,'') cosmoadvance,if(pyt.payid=2,pyt.amount,'') cosmosecurity,if(pyt.mode='CARD',pyt.cardno,'') cosmocreditcardno,"+
	    		  " if(pyt.mode='CARD',pyt.expdate,'') cosmocreditcarddate,rc.infuel cosmofuelin,rc.inkm cosmokmin,checkin.sal_name cosmocheckin,checkout.sal_name "+
	    		  " cosmocheckout,v.fleet_no cosmofleetno,brd.brand_name cosmobrand,d.issfrm cosmoissuedat,coalesce(round(r.insex,2),'') insurexcess from gl_ragmt r left join my_acbook a on a.cldocno=r.cldocno  and  a.dtype='CRM' left join gl_drdetails d on "
		       		+ "	  d.cldocno=a.cldocno  left join my_brch br on br.branch=r.brhid left join gl_vehmaster  v on v.fleet_no=r.fleet_no 	   "
		       		+ "	  left join gl_vehgroup g on g.doc_no=v.vgrpid left join  my_salesman sa on sa.doc_no=r.said and sa.sal_type='SLA'  left join  my_salesman ra on ra.doc_no=r.raid and  ra.sal_type='RLA' "
		       		+ " left join gl_config g1 on g1.field_nme='saliksrv'\r\n" + 
		       		"    left join gl_config g2 on g2.field_nme='trafficsrv'    left join gl_vehmodel mo on mo.doc_no=v.vmodid  left join gl_vehauth u on u.doc_no=v.authid	   			        "
		       		+ "left join gl_vehplate p on p.doc_no=v.pltid left join gl_rtarif t on t.rdocno=r.doc_no  	   			"
		       		+ " left join gl_ragmtclosem rc on rc.agmtno=r.doc_no left join gl_yom yo on yo.doc_no=v.yom 	   		"
		       		+ " left join my_color co on co.doc_no=v.clrid  left join my_salm sm on sm.doc_no=r.salid left join gl_vehbrand brd on v.brdid=brd.doc_no "+
		       		" left join my_salesman checkout on (r.ochkid=checkout.doc_no and checkout.sal_type='CHK') left join my_salesman checkin on "+
		       		" (rc.chkinid=checkin.doc_no and checkin.sal_type='CHK') left join gl_rpyt pyt on (r.doc_no=pyt.rdocno) where r.doc_no="+docno+" group by r.doc_no";
	       // System.out.println("Cosmo Sql:"+strcosmo);
	       Statement stmtcosmo=conn.createStatement();
	       ResultSet rscosmo=stmtcosmo.executeQuery(strcosmo);
	       while(rscosmo.next()){
	    	   //data for cosmo print

		    	 bean.setLblcosmokmrestrictdaily(rscosmo.getString("cosmokmrestrictdaily"));
		    	 bean.setLblcosmokmrestrictweekly(rscosmo.getString("cosmokmrestrictweekly"));
		    	 bean.setLblcosmokmrestrictmonthly(rscosmo.getString("cosmokmrestrictmonthly"));
		    	 bean.setLblcosmoexkmratedaily(rscosmo.getString("cosmoexkmratedaily"));
		    	 bean.setLblcosmoexkmrateweekly(rscosmo.getString("cosmoexkmrateweekly"));
		    	 bean.setLblcosmoexkmratemonthly(rscosmo.getString("cosmoexkmratemonthly"));
		    	 bean.setLblcosmoadvance(rscosmo.getString("cosmoadvance"));
		    	 bean.setLblcosmosecurity(rscosmo.getString("cosmosecurity"));
		    	 bean.setLblcosmocreditcardno(rscosmo.getString("cosmocreditcardno"));
		    	 bean.setLblcosmocreditvaliddate(rscosmo.getString("cosmocreditcarddate"));
		    	 bean.setLblcosmofuelin(objcommon.checkFuelName(conn, rscosmo.getString("cosmofuelin")));
		    	 bean.setLblcosmokmin(rscosmo.getString("cosmokmin"));
		    	 bean.setLblcosmocheckin(rscosmo.getString("cosmocheckin"));
		    	 bean.setLblcosmocheckout(rscosmo.getString("cosmocheckout"));
		    	 bean.setLblcosmofleetno(rscosmo.getString("cosmofleetno"));
		    	 bean.setLblcosmofleetbrand(rscosmo.getString("cosmobrand"));
		    	 bean.setLblcosmoissuedat(rscosmo.getString("cosmoissuedat"));
		    	 bean.setLblcosmogps(rscosmo.getString("cosmogps"));
		    	 bean.setLblcosmobabyseater(rscosmo.getString("cosmobabyseater"));
		    	 bean.setLblcosmocollectchg(rscosmo.getString("cosmocollectchg"));
				 bean.setLblcosmoexcessamt(rscosmo.getString("insurexcess"));
				 System.out.println("===="+cosmoscdw+"---"+cosmocdw+"---"+cosmopai+"---"+cosmodelchg+"---"+cosmorate+"---"+rscosmo.getDouble("cosmogps")+"---"+rscosmo.getDouble("cosmobabyseater")+"---"+rscosmo.getDouble("cosmocollectchg"));
		    	 double cosmototaltemp=cosmoscdw+cosmocdw+cosmopai+cosmodelchg+cosmorate+rscosmo.getDouble("cosmogps")+rscosmo.getDouble("cosmobabyseater")+rscosmo.getDouble("cosmocollectchg");
		    	 bean.setLblcosmototal(cosmototaltemp+"");
	       }
	       
	       
		   
		    String strselcartarif="select (select round(rate,2)  from gl_rtarif where  rdocno="+docno+" and rstatus=7) as selcartarif,"+
		   "(select round(cdw,2)  from gl_rtarif where  rdocno="+docno+" and rstatus=7) as selcarcdw,"+
		   "(select round(cdw1,2)  from gl_rtarif where  rdocno="+docno+" and rstatus=7) as selcarcdw1,"+
		   "(select round(pai,2)  from gl_rtarif where  rdocno="+docno+" and rstatus=7) as selcarpai,"+
		   "(select round(cooler,2)  from gl_rtarif where  rdocno="+docno+" and rstatus=7) as selcarvmd,"+
		   "(select round(gps,2)+round(babyseater)  from gl_rtarif where  rdocno="+docno+" and rstatus=7) as selcaracc";
		   
		   ResultSet rsselcarrates=stmtcosmo.executeQuery(strselcartarif);
		   while(rsselcarrates.next()){
			   bean.setSelcaracc(rsselcarrates.getString("selcaracc"));
			   bean.setSelcarcdw(rsselcarrates.getString("selcarcdw"));
			   bean.setSelcarcdw1(rsselcarrates.getString("selcarcdw1"));
			   bean.setSelcarpai(rsselcarrates.getString("selcarpai"));
			   bean.setSelcartarif(rsselcarrates.getString("selcartarif"));
			   bean.setSelcarvmd(rsselcarrates.getString("selcarvmd"));
		   }
		   
		   
		   
		   
	       stmtinvoice.close();
	       
	       
	       
	       
	       
	       
	       
	       
Statement stmtinvoice66 = conn.createStatement();
	       Statement stmtcosmodriver=conn.createStatement();
	       String strcosmodriver="select name,mobno,dlno,DATE_FORMAT(d.led,'%d-%m-%Y') led,passport_no from gl_drdetails d left join gl_rdriver rr  "
	       		+ " on rr.drid=d.dr_id where rr.rdocno="+docno+" and rr.srno between(select min(srno) srno from gl_rdriver  where rdocno="+docno+") "
	       		+ " and (select max(srno) srno from gl_rdriver  where rdocno="+docno+") and  rr.status=3  limit 2";
	       ResultSet rscosmodriver=stmtcosmodriver.executeQuery(strcosmodriver);
		   int drivercount=0;
	       while(rscosmodriver.next()){
	    	   if(drivercount>0){
			   bean.setLblcosmodrivername(rscosmodriver.getString("name"));
	    	   bean.setLblcosmodrivermobile(rscosmodriver.getString("mobno"));
	    	   bean.setLblcosmodriverlicense(rscosmodriver.getString("dlno"));
	    	   bean.setLblcosmodrivervalidupto(rscosmodriver.getString("led"));
	    	   bean.setLblcosmodriverpassport(rscosmodriver.getString("passport_no"));
			   }
	    	   drivercount++;
	       }
	       String  maindr=" select coalesce(d.mobno,'') mobile,coalesce(d.ltype,'') licensetype,coalesce(visano) visano,coalesce(d.nation,'') nation,coalesce(issfrm,'') issuedby,coalesce(DATE_FORMAT(d.issdate,'%d-%m-%Y'),'') issuedfrom,"+
				" d.name drname,d.dlno,DATE_FORMAT(d.dob,'%d-%m-%Y') dob,DATE_FORMAT(d.led,'%d-%m-%Y') led,if(d.PASSPORT_NO='0','',d.PASSPORT_NO) "
	       		+ " PASSPORT_NO,DATE_FORMAT(d.pass_exp,'%d-%m-%Y') pass_exp from gl_drdetails d left join gl_rdriver rr  "
	       		+ " on rr.drid=d.dr_id where rr.rdocno="+docno+" and rr.srno between(select min(srno) srno from gl_rdriver  where rdocno="+docno+") "
	       		+ " and (select max(srno) srno from gl_rdriver  where rdocno="+docno+") and  rr.status=3  limit 3 ";
	     System.out.println("---------maindr------"+maindr);
	       
   ResultSet resultmain = stmtinvoice66.executeQuery(maindr); 
	       
   int i=0;
   
	       while(resultmain.next()){
	    	   if(i==0)
	    	   {
	    		    bean.setRadrname(resultmain.getString("drname"));
		    	    bean.setRadlno(resultmain.getString("dlno"));
		    	    bean.setPassno(resultmain.getString("passport_no"));
		    	    bean.setLicexpdate(resultmain.getString("led"));
		    	    bean.setPassexpdate(resultmain.getString("pass_exp"));
		    	    bean.setDobdate(resultmain.getString("dob"));
		    	   bean.setLblnation(resultmain.getString("nation"));
		    	    bean.setLblissby(resultmain.getString("licensetype"));
					bean.setLblpassissued(resultmain.getString("issuedby"));
		    	    bean.setLblissfromdate(resultmain.getString("issuedfrom"));
		    	    bean.setLblidno(resultmain.getString("visano"));
		    	    //drin
		    	    bean.setLbldobdate(resultmain.getString("dob"));  
		    	    bean.setLblradlno(resultmain.getString("dlno"));  
					bean.setAdddrname1("None");
	    	   }
	    	   
	    	   if(i==1)
	    	   {
	    		   bean.setAdddrname1(resultmain.getString("drname"));
		    	   bean.setAddlicno1(resultmain.getString("dlno"));
		    	   bean.setLbladdpassno1(resultmain.getString("passport_no"));
		    	   bean.setExpdate1(resultmain.getString("led"));
		    	   bean.setLbladdpassexp1(resultmain.getString("pass_exp"));
		    	   bean.setAdddob1(resultmain.getString("dob"));
		    	   bean.setLbladdnation1(resultmain.getString("nation"));
	    		   bean.setLbladdissby1(resultmain.getString("licensetype"));
	    		   bean.setLbladdpassissued1(resultmain.getString("issuedby"));
	    		   bean.setLbladdissfrom1(resultmain.getString("issuedfrom"));
	    		   bean.setLbladdid1(resultmain.getString("visano"));
				   bean.setLblindigoaddmobile(resultmain.getString("mobile"));
	    		   	bean.setLblindigoaddnationality(resultmain.getString("nation"));
	    		   
	    	   }
	    	   
	    	   
	    	   if(i==2)
	    	   {
	    		   
	    		   bean.setAdddrname2(resultmain.getString("drname"));
			    	  
		    	   bean.setAddlicno2(resultmain.getString("dlno"));
		    	 
		    	   bean.setExpdate2(resultmain.getString("led"));
		    	  
		    	   bean.setAdddob2(resultmain.getString("dob"));
	    	   }
	    	   
	    	   i=i+1;
	    	   
	       }
	       stmtinvoice66.close();
	        
  /*  Statement stmtinvoice4 = conn.createStatement();
	       
	       
	 String  maindr=" select d.name drname,d.dlno,DATE_FORMAT(d.dob,'%d-%m-%Y') dob,DATE_FORMAT(d.led,'%d-%m-%Y') "
	 		+ "led,if(d.PASSPORT_NO='0','',d.PASSPORT_NO) PASSPORT_NO,DATE_FORMAT(d.pass_exp,'%d-%m-%Y') pass_exp from gl_drdetails d left join gl_rdriver rr on rr.drid=d.dr_id where rr.rdocno="+docno+" and rr.srno=(select MIN(srno) from gl_rdriver where rdocno="+docno+") group by rr.rdocno ";
	 
	 System.out.println("-----------"+maindr);
	 
	 ResultSet resultmain = stmtinvoice4.executeQuery(maindr); 
	       
	       while(resultmain.next()){
	    	   
	    	    bean.setRadrname(resultmain.getString("drname"));
	    	    bean.setRadlno(resultmain.getString("dlno"));
	    	    bean.setPassno(resultmain.getString("passport_no"));
	    	    bean.setLicexpdate(resultmain.getString("led"));
	    	    bean.setPassexpdate(resultmain.getString("pass_exp"));
	    	    bean.setDobdate(resultmain.getString("dob"));
	    	   
	    	    //drin
	    	    bean.setLbldobdate(resultmain.getString("dob"));  
	    	    bean.setLblradlno(resultmain.getString("dlno"));  
	    
	    	   
	       }
	       stmtinvoice4.close();
	        
	       
	      
	       
	       
	       Statement stmtinvoice1 = conn.createStatement();
	       

	 String  drone="select dr.name name1,dr.dlno licno1,DATE_FORMAT(dr.dob,'%d-%m-%Y') dob1,DATE_FORMAT(dr.led,'%d-%m-%Y') led1 from gl_drdetails dr left join gl_rdriver rr on rr.drid=dr_id where rr.rdocno="+docno+" and rr.srno=(select MIN(srno)+1 from gl_rdriver where rdocno="+docno+")";
	 
	 ResultSet resultone = stmtinvoice1.executeQuery(drone); 
	       
	       while(resultone.next()){
	    	   
	    	   bean.setAdddrname1(resultone.getString("name1"));
	    	 
	    	   bean.setAddlicno1(resultone.getString("licno1"));
	    	  
	    	   bean.setExpdate1(resultone.getString("led1"));
	    	
	    	   bean.setAdddob1(resultone.getString("dob1"));
	    	  
	    	   
	       }
	       stmtinvoice1.close();
	     
	   	
	    Statement stmtinvoice2 = conn.createStatement ();
	    String  drtwo="select dr.name name2,dr.dlno licno2,DATE_FORMAT(dr.dob,'%d-%m-%Y') dob2,DATE_FORMAT(dr.led,'%d-%m-%Y') led2 from gl_drdetails dr left join gl_rdriver rr on rr.drid=dr_id where rr.rdocno="+docno+" and rr.srno=(select MIN(srno)+2 from gl_rdriver where rdocno="+docno+")";
	 
ResultSet resulttwo = stmtinvoice2.executeQuery(drtwo); 
	       
	       while(resulttwo.next()){
	    	   
	    	 
	    	   bean.setAdddrname2(resulttwo.getString("name2"));
	    	  
	    	   bean.setAddlicno2(resulttwo.getString("licno2"));
	    	 
	    	   bean.setExpdate2(resulttwo.getString("led2"));
	    	  
	    	   bean.setAdddob2(resulttwo.getString("dob2"));
	    	  
	    	   
	       } 
	       stmtinvoice2.close();
	
	       */
	       
	       
	       
	       Statement stmtinvoice51 = conn.createStatement();
	      
	 String  sql011="select if(aa.defaultcard=1,aa.cardno,cardno) cardno,if(aa.defaultcard=1,DATE_FORMAT(aa.exp_date,'%d-%m-%Y'),DATE_FORMAT(exp_date,'%d-%m-%Y')) exp_date,"
	 		+ " if(aa.defaultcard=1,aa.defaultcard,defaultcard) defaultcard from "
	 		+ " (SELECT cardno,exp_date,defaultcard FROM my_clbankdet where rdocno=(select cldocno from gl_ragmt where doc_no='"+docno+"') "
	 		+ " and sr_no=(select sr_no from  my_clbankdet where rdocno=(select cldocno from gl_ragmt where doc_no='"+docno+"')and defaultcard=1)) aa "
	 		+ " union all (SELECT cardno,DATE_FORMAT(exp_date,'%d-%m-%Y') exp_date,defaultcard FROM my_clbankdet where rdocno=(select cldocno from gl_ragmt where doc_no='"+docno+"') and "
	 		+ "sr_no=(select min(sr_no) from  my_clbankdet where rdocno=(select cldocno from gl_ragmt where doc_no='"+docno+"') and defaultcard=0) ) limit 1 ;";
	 
	 //System.out.println("----sql011------"+sql011);
	 
	 ResultSet ress1 = stmtinvoice51.executeQuery(sql011); 
	   
	       while(ress1.next()){
	    	   bean.setLbexpcarddate(ress1.getString("exp_date"));
	    	   bean.setLbcardno(ress1.getString("cardno"));
	    	   //setLbcardno setLbexpcarddate  
	                   }
	    
	       stmtinvoice51.close();
	       
	       
	       
	       
	       Statement stmtinvoice10 = conn.createStatement ();
		   /* String  companysql="select b.branchname,c.company,c.address,c.tel,c.fax,l.loc_name location from gl_ragmt r  "
		    		+ " left join my_brch b on r.brhid=b.doc_no left join my_locm l on l.brhid=b.doc_no "
		    		+ "left join my_comp c on b.cmpid=c.doc_no where r.doc_no="+docno+"  ";*/
		    

		    
		    String  companysql="select coalesce(c.tel2,'') tel2,coalesce(c.email,'') email,coalesce(c.web,'') web,c.company,c.address,c.tel,c.fax,lc.loc_name location,b.branchname,b.pbno,b.stcno,b.cstno from gl_ragmt r inner join my_brch b on  "
		    		+ "r.brhid=b.doc_no inner join my_comp c on b.cmpid=c.doc_no inner join my_locm l on l.brhid=b.doc_no inner join (select min(lo.loc) loc,lo.loc_name, "
		    		+ " lo.brhid from my_locm lo group by brhid) as lc on(lc.loc=l.loc and lc.brhid=b.doc_no) where r.doc_no="+docno+" ";
		    
		    
		 //   System.out.println("----------"+companysql);
		    

	         ResultSet resultsetcompany = stmtinvoice10.executeQuery(companysql); 
		       
		       while(resultsetcompany.next()){
			   bean.setLbltel1(resultsetcompany.getString("tel"));
		    	   bean.setLbltel2(resultsetcompany.getString("tel2"));
		    	   bean.setLblcompmail(resultsetcompany.getString("email"));
		    	   bean.setLblcompwebsite(resultsetcompany.getString("web"));
		    	   bean.setBarnchval(resultsetcompany.getString("branchname"));
		    	   bean.setCompanyname(resultsetcompany.getString("company"));
		    	  
		    	   bean.setAddress(resultsetcompany.getString("address"));
		    	 
		    	   bean.setMobileno(resultsetcompany.getString("tel"));
		    	  
		    	   bean.setFax(resultsetcompany.getString("fax"));
		    	   bean.setLocation(resultsetcompany.getString("location"));
		    	  
		    	   
		    	   
		       } 
		       stmtinvoice10.close();
		       
		    
		
		       Statement stmttatal = conn.createStatement ();
			    String  totalsql="select if(bb.inv-aa.total=0,'',bb.inv-aa.total) balance,if(aa.total=0,'',aa.total) total,if(bb.inv=0,'',bb.inv) inv from ((select coalesce(round(sum(dramount),2),0) total from my_jvtran where rtype='RAG' and rdocno="+docno+"   and dtype='CRV' and id=1)  aa, "
			    		+ "(select coalesce(round(sum(dramount),2),0) inv from my_jvtran where rtype='RAG' and rdocno="+docno+"   and dtype='INV' and id=1) bb);  ";
			//	System.out.println("======="+totalsql);
		         ResultSet restotal = stmttatal.executeQuery(totalsql); 
		        
			       
			       while(restotal.next()){
			 
			    	   bean.setTotalpaid(restotal.getString("total"));
			    	   
			    	   bean.setInvamount(restotal.getString("inv"));
			    	   bean.setBalance(restotal.getString("balance"));
			    	   
			       } 
			       stmttatal.close();
			    
			   	
			       Statement delstmt = conn.createStatement ();
			       String  delsql="select DATE_FORMAT(v.din,'%d-%m-%Y') din, v.tin tin, round(v.kmin) kmin,  "
				       		+ " CASE WHEN v.fin='0.000'   THEN 'Level 0/8' WHEN v.fin='0.125' THEN 'Level 1/8' WHEN v.fin='0.250' THEN 'Level 2/8' "
				       		+ "  WHEN   v.fin='0.375' THEN 'Level 3/8' WHEN v.fin='0.500' THEN 'Level 4/8' WHEN v.fin='0.625' THEN 'Level 5/8' "
				       		+ "    WHEN v.fin='0.750' THEN 'Level 6/8' WHEN v.fin='0.875' THEN 'Level 7/8' WHEN v.fin='1.000' THEN 'Level 8/8' "
				       		+ "        END as 'fin' from gl_ragmt r inner join gl_vmove v on v.rdocno=r.doc_no and v.rdtype='RAG' and v.status='IN' "
				       		+ "           and v.trancode='DL'  and v.doc_no=(select min(doc_no) from gl_vmove where  rdtype='RAG' and status='IN'   "
				       		+ " and trancode='DL'  and rdocno=r.doc_no and repno=0 and custno=0 and exchng=0 )    where r.delstatus=1 and r.doc_no="+docno+"  and v.repno=0 and v.custno=0 and v.exchng=0";
				       
			       
			         ResultSet rsdel = delstmt.executeQuery(delsql); 
			        
				       
				       while(rsdel.next()){
				    	   
				    	   bean.setOutdetails("Out :");
				    	   bean.setDeldetailss("Delivered :");
				    	    
				    	     
				 
				    	   bean.setDeldates(rsdel.getString("din"));
				    	   
				    	   bean.setDeltimes(rsdel.getString("tin"));
				    	   bean.setDelkmins(rsdel.getString("kmin"));
				    	   bean.setDelfuels(rsdel.getString("fin"));
				    	   
				    	   
				    	  
				    	   
				       } 
				       rsdel.close();
				       
					   	
				       Statement colstmt = conn.createStatement ();
				       String  colsql="select DATE_FORMAT(v.dout,'%d-%m-%Y') din, v.tout tin, round(v.kmout) kmin, CASE WHEN v.fout='0.000' THEN 'Level 0/8' WHEN v.fout='0.125' THEN 'Level 1/8' WHEN v.fout='0.250' "
					       		+ "THEN 'Level 2/8' WHEN v.fout='0.375' THEN 'Level 3/8' WHEN v.fout='0.500' THEN 'Level 4/8' WHEN "
					       		+ "v.fout='0.625' THEN 'Level 5/8'  WHEN v.fout='0.750' THEN 'Level 6/8' WHEN v.fout='0.875' THEN "
					       		+ "'Level 7/8' WHEN v.fout='1.000' THEN 'Level 8/8'  END as 'fin' from gl_ragmt r inner join gl_vmove v on v.rdocno=r.doc_no "
					       		+ "and v.rdtype='RAG' and v.status='IN' and trancode='DL' inner join gl_ragmtclosem col on col.agmtno=r.doc_no "
					       		+ " where col.colstatus=1 and r.doc_no="+docno+"  and v.doc_no =(select max(doc_no) from gl_vmove where rdocno="+docno+" "
					       		+ "and rdtype='RAG' and status='IN' and trancode='DL' and repno=0 and  custno=0 and exchng=0) ";
				 
				         ResultSet rscol = colstmt.executeQuery(colsql); 
				        
					       
					       while(rscol.next()){
					 
					    	 	 bean.setIndetails("Collected :");
								    
							     bean.setColdetails("In :");
						    	
					            
						    	   bean.setInkm(rscol.getString("kmin"));
						    	    bean.setInfuel(rscol.getString("fin"));
						    	    bean.setIndate(rscol.getString("din"));
						    	    bean.setIntime(rscol.getString("tin"));
						    	       
					    	   
					    	  
					    	   
					       } 
					       rscol.close();
					       
					       
					       
					       
					       
					       
					       Statement rstmt = conn.createStatement ();
					       String  rstmtsql="select if(cardno='0','',cardno) cardno,coalesce(expdate,'') expdate,if(acode='0','',acode) acode,round(amount,2) amount from gl_rpyt  where payid=2 and rdocno='"+docno+"' ";
					 
					         ResultSet rsp = rstmt.executeQuery(rstmtsql); 
					      //   setSecuritycardno(),setSecurityexpdate(),setSecuritypreauthno(),setSecuritypreauthamt(),
						       
						       while(rsp.next()){
						 
						    	 
							    	   bean.setSecuritycardno(rsp.getString("cardno"));
							    	    bean.setSecurityexpdate(rsp.getString("expdate"));
							    	    bean.setSecuritypreauthno(rsp.getString("acode"));
							    	    bean.setSecuritypreauthamt(rsp.getString("amount"));
							    	       
						    	   
						    	  
						    	   
						       } 
						       rsp.close();
						       
						       
						       Statement rstmt2 = conn.createStatement ();
						       String  rstmtsql2="select DATEDIFF(r.ddate,coalesce(mv.din,r.odate)) totaldays from gl_ragmt r left join "
						       		+ " gl_vmove mv on mv.rdocno=r.doc_no and mv.rdtype='RAG' and mv.trancode='DL' and mv.repno=0 and mv.custno=0  and mv.exchng=0 \r\n" + 
						       		" where r.doc_no='"+docno+"' ";
						// System.out.println("1========"+rstmtsql2);
						         ResultSet rsp2 = rstmt2.executeQuery(rstmtsql2); 
						      //   setSecuritycardno(),setSecurityexpdate(),setSecuritypreauthno(),setSecuritypreauthamt(),
							       
							       while(rsp2.next()){
							 
							    	   totaldays=rsp2.getDouble("totaldays");
								    	  
								    	    
							    	   
							    	  
							    	   
							       } 
							       rsp2.close();
							       
						       
						       
						       
						   	double paidtotalamt=0;
						       Statement rstmt1 = conn.createStatement ();
						       String  rstmtsql1="select amount from gl_rpyt  where payid=1 and rdocno='"+docno+"' ";
						 
						         ResultSet rsp1 = rstmt1.executeQuery(rstmtsql1); 
						      //   setSecuritycardno(),setSecurityexpdate(),setSecuritypreauthno(),setSecuritypreauthamt(),
							       
							       while(rsp1.next()){
							 
							    	 
							    	   paidtotalamt=(rsp1.getDouble("amount"));
								    	
							    	   
							       } 
							       rsp1.close();
						  
							 
							 
								double tariftotal=0,cdwtotal=0,accsssorytotal=0,deltotal=0;
								
								double totalamt=0;
								 
								double balamount=0;
								String rentaltype=bean.getRarenttypes();
								
								double divval=1;
								//EMC Override
								rentaltype="Monthly";
								if(rentaltype.equalsIgnoreCase("Monthly"))
									
								{
									
									if(totaldays<=30)
							    	{
							    		totaldays=1;
							    		divval=1;
							    	
							    		
							    	}
									else
									{
										divval=30;
									}
									
								}
								else if(rentaltype.equalsIgnoreCase("Weekly"))
								{
									
									if(totaldays<=7)
							    	{
							    		totaldays=1;
							    		divval=1;
							    	}else
							    	{
							    		divval=7;
							    	}
							    	   
									
								}
								else
								{
									if(totaldays<=0)
							    	{
							    		totaldays=1;
							    		divval=1;
							    	}
									else
									{
										divval=1;
									}
									
								}
							 
								//System.out.println("divval======"+divval);
								
								
								
								//System.out.println("-----totaldays--="+totaldays);
								//DecimalFormat df=new DecimalFormat("0.00");
								
							/*	tariftotal=(Double.parseDouble(bean.getTariff())*totaldays)/divval;
								cdwtotal=(Double.parseDouble(bean.getRacdwscdw())*totaldays)/divval; 	   
								accsssorytotal=(Double.parseDouble(bean.getRaaccessory())*totaldays)/divval;
								deltotal=(Double.parseDouble(bean.getLaldelcharge())*totaldays)/divval;
								
						       bean.setTarifftotal(df.format(tariftotal)+"");
						       bean.setRacdwscdwtotal(df.format(cdwtotal)+"");
						       bean.setRaaccessorytotal(df.format(accsssorytotal)+"");
						       bean.setLaldelchargetotal(df.format(deltotal)+"");
						       
						       
						       totalamt=tariftotal+cdwtotal+accsssorytotal+deltotal;
						       
						       balamount=totalamt-paidtotalamt;
						       
						       bean.setAdvtotalamont(df.format(totalamt)+"");
						       bean.setAdvpaidamount(df.format(paidtotalamt)+"");
						       bean.setAdvbalance(df.format(balamount)+"");
						       */
								    	   //   Double.parseDouble(bean.getRacdwscdw())*totaldays;
								    	   //  Double.parseDouble(bean.getRaaccessory())*totaldays;
								    	   // Double.parseDouble(bean.getLaldelcharge())*totaldays;	   
								    	   // getTarifftotal(),getRacdwscdwtotal(), getLaldelchargetotal(),getAdvtotalamont(),getAdvpaidamount(),getAdvbalance(),
							       
					       
					       
				
	       conn.close();
	      }
	      catch(Exception e){
	    	  conn.close();
	    	  e.printStackTrace();
	       
	      
	      }
	      return bean;
	     }
}
