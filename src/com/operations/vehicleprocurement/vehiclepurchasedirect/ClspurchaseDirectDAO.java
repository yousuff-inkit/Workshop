package com.operations.vehicleprocurement.vehiclepurchasedirect;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsAmountToWords;
import com.common.ClsCommon;
import com.connection.ClsConnection;


public class ClspurchaseDirectDAO 
{
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	public  JSONArray fleetSearch(HttpSession session,String fleetno,String flname,String regno,String chk) throws SQLException {


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
	  	        
	   	    	
	  	  String sqltest="";

          
          if(!(fleetno.equalsIgnoreCase("0")) && !(fleetno.equalsIgnoreCase(""))){
              sqltest=sqltest+" and v.fleet_no like '%"+fleetno+"%'";
          }
          if(!(flname.equalsIgnoreCase("0")) && !(flname.equalsIgnoreCase(""))){
           sqltest=sqltest+" and v.flname like '%"+flname+"%'";
          }
          if(!(regno.equalsIgnoreCase("0")) && !(regno.equalsIgnoreCase(""))){
            sqltest=sqltest+" and v.reg_no like '%"+regno+"%'";
       }
	  	    
	  	    
	       String brid=session.getAttribute("BRANCHID").toString();
	    	

	   	 Connection conn=null;
			try {
				
				
					 conn = ClsConnection.getMyConnection();
					Statement stmtVeh8 = conn.createStatement ();
	           	
 if(chk.equalsIgnoreCase("Load"))
 {
					String vehsql="select v.prch_cost+v.add1 price,v.eng_no,v.ch_no,v.prch_cost,v.add1 addcost ,v.reg_no,v.fleet_no,v.FLNAME, "
							+ "c.color,v.clrid,g.gname,v.vgrpid,vb.brand_name,v.brdid,vm.vtype model,v.vmodid  from gl_vehmaster v "
							+ " left join gl_vmove m on v.fleet_no=m.fleet_no  left join my_color c  on v.clrid=c.doc_no left join gl_vehgroup g  on g.doc_no=v.vgrpid "
							+ "left join gl_vehbrand vb on vb.doc_no=v.brdid left join gl_vehmodel vm on vm.doc_no=v.vmodid where v.statu=3 and puchstatus=0 "+sqltest+ " group by v.fleet_no";
					
					
			//	System.out.println("---------------"+vehsql);
					ResultSet resultSet = stmtVeh8.executeQuery(vehsql);
					
					RESULTDATA=ClsCommon.convertToJSON(resultSet);
					stmtVeh8.close();
 }		
				
					conn.close();
					 return RESULTDATA;
			}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
			//System.out.println(RESULTDATA);
	       return RESULTDATA;
	   }
	
	
	
	public  JSONArray gridsearchrelode(String masterdocno) throws SQLException {

	    JSONArray RESULTDATA=new JSONArray();
	    
	           Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtrelode = conn.createStatement ();
	        	
				String resql=("select rq.puch_cost prch_cost,rq.add_cost addicost,rq.brdid,rq.modid,rq.clrid,rq.tot_cost price,rq.chaseno,rq.enginno,rq.fleet_no,"
						+ "  vb.brand_name brand,vm.vtype model,vc.color color from gl_vpurdird rq left join gl_vehbrand vb on vb.doc_no=rq.BRDID  "
						+ " left join gl_vehmodel vm on vm.doc_no=rq.MODID "
						+ " left join my_color vc on vc.doc_no=rq.clrid   where rq.rdocno='"+masterdocno+"' ");
				//System.out.println("================="+resql);
				ResultSet resultSet = stmtrelode.executeQuery(resql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				stmtrelode.close();
				conn.close();

				
				
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		
	    return RESULTDATA;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
    Connection conn=null;
	public int insert(Date sqlStartDate, Date invDate, int headacccode,
			String vehdesc, HttpSession session, String mode,
			String formdetailcode, ArrayList<String> descarray, int invno,
			HttpServletRequest request) throws SQLException {
         
   
        try
        {
        	
        conn=ClsConnection.getMyConnection();
        conn.setAutoCommit(false);
    	CallableStatement stmtvehpurchase= conn.prepareCall("{call vahpurchasedirDML(?,?,?,?,?,?,?,?,?,?,?)}"); 
        
    	stmtvehpurchase.registerOutParameter(10, java.sql.Types.INTEGER);
		stmtvehpurchase.registerOutParameter(11, java.sql.Types.INTEGER);
		stmtvehpurchase.setDate(1,sqlStartDate); 
		stmtvehpurchase.setInt(2,headacccode);     
		
		stmtvehpurchase.setString(3,vehdesc);
 
		stmtvehpurchase.setString(4,session.getAttribute("USERID").toString());
		stmtvehpurchase.setString(5,session.getAttribute("BRANCHID").toString());
		stmtvehpurchase.setString(6,formdetailcode);
		stmtvehpurchase.setDate(7,invDate);
		stmtvehpurchase.setInt(8,invno);
		stmtvehpurchase.setString(9,mode);
		
	//	System.out.println("------stmtvehpurchase------"+stmtvehpurchase);
		
		stmtvehpurchase.executeQuery();
		int docno=stmtvehpurchase.getInt("docNo");
		int vocno=stmtvehpurchase.getInt("vocNo");	
		request.setAttribute("vocno", vocno);
		if(docno<=0)
		{
			conn.close();
			return 0;
			
		}
		
		String descs="INV-"+""+invno+""+":-Dated :- "+invDate; 
		
	String refdetails="VPD"+""+vocno;
		
		double costtotal=0;
		for(int i=0;i< descarray.size();i++){
	    	
 
			
		     String[] vehpurreqarray1=descarray.get(i).split("::");
		     if(!(vehpurreqarray1[0].trim().equalsIgnoreCase("undefined")|| vehpurreqarray1[0].trim().equalsIgnoreCase("NaN")||vehpurreqarray1[0].trim().equalsIgnoreCase("")|| vehpurreqarray1[0].isEmpty()))
		     {
		    String amount=""+(vehpurreqarray1[8].trim().equalsIgnoreCase("undefined") || vehpurreqarray1[8].trim().equalsIgnoreCase("NaN")||vehpurreqarray1[8].trim().equalsIgnoreCase("")|| vehpurreqarray1[8].isEmpty()?0:vehpurreqarray1[8].trim())+"";
		    	 costtotal=costtotal+Double.parseDouble(amount);
		    	 
		    	 
		     }
		}
		
		
		for(int i=0;i< descarray.size();i++){
	    	
		     String[] vehpurreqarray=descarray.get(i).split("::");
		     if(!(vehpurreqarray[0].trim().equalsIgnoreCase("undefined")|| vehpurreqarray[0].trim().equalsIgnoreCase("NaN")||vehpurreqarray[0].trim().equalsIgnoreCase("")|| vehpurreqarray[0].isEmpty()))
		     {
		                      
				  
		    	// rowno, sr_no, rdocno, fleet_no, brdid, modid, clrid, puch_cost, add_cost, tot_cost, chaseno, enginno
		                        //                    0     1      2    3     4      5        6          7       8       9
	     String sql="INSERT INTO gl_vpurdird(sr_no,fleet_no,brdid,modid,clrid,chaseno,enginno,puch_cost,add_cost,tot_cost,rdocno)VALUES"
			       + " ("+(i+1)+","
			       + "'"+(vehpurreqarray[0].trim().equalsIgnoreCase("undefined") || vehpurreqarray[0].trim().equalsIgnoreCase("NaN")|| vehpurreqarray[0].trim().equalsIgnoreCase("")|| vehpurreqarray[0].isEmpty()?0:vehpurreqarray[0].trim())+"',"
			       + "'"+(vehpurreqarray[1].trim().equalsIgnoreCase("undefined") || vehpurreqarray[1].trim().equalsIgnoreCase("NaN")|| vehpurreqarray[1].trim().equalsIgnoreCase("")|| vehpurreqarray[1].isEmpty()?0:vehpurreqarray[1].trim())+"',"
			       + "'"+(vehpurreqarray[2].trim().equalsIgnoreCase("undefined") || vehpurreqarray[2].trim().equalsIgnoreCase("NaN")|| vehpurreqarray[2].trim().equalsIgnoreCase("")|| vehpurreqarray[2].isEmpty()?0:vehpurreqarray[2].trim())+"',"
			       + "'"+(vehpurreqarray[3].trim().equalsIgnoreCase("undefined") || vehpurreqarray[3].trim().equalsIgnoreCase("NaN")||vehpurreqarray[3].trim().equalsIgnoreCase("")|| vehpurreqarray[3].isEmpty()?0:vehpurreqarray[3].trim())+"',"
			       + "'"+(vehpurreqarray[4].trim().equalsIgnoreCase("undefined") || vehpurreqarray[4].trim().equalsIgnoreCase("NaN")||vehpurreqarray[4].trim().equalsIgnoreCase("")|| vehpurreqarray[4].isEmpty()?0:vehpurreqarray[4].trim())+"',"
			       + "'"+(vehpurreqarray[5].trim().equalsIgnoreCase("undefined") || vehpurreqarray[5].trim().equalsIgnoreCase("NaN")||vehpurreqarray[5].trim().equalsIgnoreCase("")|| vehpurreqarray[5].isEmpty()?0:vehpurreqarray[5].trim())+"',"
			       + "'"+(vehpurreqarray[6].trim().equalsIgnoreCase("undefined") || vehpurreqarray[6].trim().equalsIgnoreCase("NaN")||vehpurreqarray[6].trim().equalsIgnoreCase("")|| vehpurreqarray[6].isEmpty()?0:vehpurreqarray[6].trim())+"',"
			       + "'"+(vehpurreqarray[7].trim().equalsIgnoreCase("undefined") || vehpurreqarray[7].trim().equalsIgnoreCase("NaN")||vehpurreqarray[7].trim().equalsIgnoreCase("")|| vehpurreqarray[7].isEmpty()?0:vehpurreqarray[7].trim())+"',"
			       + "'"+(vehpurreqarray[8].trim().equalsIgnoreCase("undefined") || vehpurreqarray[8].trim().equalsIgnoreCase("NaN")||vehpurreqarray[8].trim().equalsIgnoreCase("")|| vehpurreqarray[8].isEmpty()?0:vehpurreqarray[8].trim())+"',"
			       +"'"+docno+"')";
	     
	 //	System.out.println("------sql------"+sql);
			     int resultSet2 = stmtvehpurchase.executeUpdate(sql);
			    
			     if(resultSet2<=0)
					{
						conn.close();
						return 0;
						
					}

			        int tranno=0;
					if(i==0)
					{
								String trsql="SELECT coalesce(max(trno)+1,1) trno FROM my_trno m";
							
								ResultSet tass = stmtvehpurchase.executeQuery (trsql);
								
										if (tass.next()) {
									
											tranno=tass.getInt("trno");		
											
									     }
										
							 
								
								String trnosql="insert into my_trno(edate,trtype,brhId,USERNO,trno) values(now(),3,'"+session.getAttribute("BRANCHID").toString()+"','"+session.getAttribute("USERID").toString()+"','"+tranno+"')";
								
								int dd=stmtvehpurchase.executeUpdate(trnosql);
							     
										 if(dd<=0)
											{
												conn.close();
												return 0;
												
											}
										 
										 
										 
										  	Statement stmt = conn.createStatement(); 	 
										 
										  int	venderaccount=headacccode;
										 
									double	  pricetottal=costtotal;
										 
										 String vendorcur="0"; 
										 double venrate=0.00;
										 
										 String sqls10="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+venderaccount+"'";
											//System.out.println("---1----sqls10----"+sqls10) ;
										   ResultSet tass11 = stmt.executeQuery (sqls10);
										   if(tass11.next()) {
										
											   vendorcur=tass11.getString("curid");	
											 
												
										        }
										 
										 
									     String currencytype="";
									     String sqlss = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
									        +"where  coalesce(toDate,curdate())>='"+sqlStartDate+"' and frmDate<='"+sqlStartDate+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+vendorcur+"'";
									     //System.out.println("-----2--sqlss----"+sqlss) ;
									     ResultSet resultSet33 = stmt.executeQuery(sqlss);
									         
									      while (resultSet33.next()) {
									    	  venrate=resultSet33.getDouble("rate");
									     currencytype=resultSet33.getString("type");
									                      }
									      
										   double	dramount=pricetottal*-1; 
										   
											 
										   double ldramount=0;
										   if(currencytype.equalsIgnoreCase("D"))
										   {
										   
								           	
								           	 ldramount=dramount/venrate ;  
										   }
										   
										   else
										   {
											    ldramount=dramount*venrate ;  
										   }
										   
							 
										
										 String sql1="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
										 		+ "values('"+sqlStartDate+"','"+refdetails+"',"+docno+",'"+venderaccount+"','"+descs+"','"+vendorcur+"','"+venrate+"',"+dramount+","+ldramount+",0,-1,3,0,0,0,'"+venrate+"',0,0,'VPD','"+session.getAttribute("BRANCHID").toString()+"',"+tranno+",3)";
									     
										   //	System.out.println("--sql1----"+sql1);
										 int ss = stmt.executeUpdate(sql1);

									     if(ss<=0)
											{
												conn.close();
											 
												
											}
									     
									     int acnos=0;
									     String curris="0";
									     double rates=0.00;
									     
									    
									     
									   String sql2="select  acno from my_account where codeno='VEH'";
									   //System.out.println("-----4--sql2----"+sql2) ;

							           ResultSet tass1 = stmt.executeQuery (sql2);
										
										if (tass1.next()) {
									
											acnos=tass1.getInt("acno");		
											
									        }
										
										
										
										 String sqls3="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+acnos+"'";
										   //System.out.println("-----5--sqls3----"+sqls3) ;
										   ResultSet tass3 = stmt.executeQuery (sqls3);
											
											if (tass3.next()) {
										
												curris=tass3.getString("curid");	
												 
												
										              }
											String currencytype1="";
											 String sqlveh = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
												        +"where  coalesce(toDate,curdate())>='"+sqlStartDate+"' and frmDate<='"+sqlStartDate+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+curris+"'";
											 //System.out.println("-----6--sqlveh----"+sqlveh) ;
												     ResultSet resultSet44 = stmt.executeQuery(sqlveh);
												         
												      while (resultSet44.next()) {
												    	  rates=resultSet44.getDouble("rate");
												      currencytype1=resultSet44.getString("type");
												                 } 
											 
												      
												      double ldramounts=0 ;     
												      if(currencytype1.equalsIgnoreCase("D"))
												      {
												      
										                   ldramounts=pricetottal/venrate ;  
												      }
												      
												      else
												      {
												    	   ldramounts=pricetottal*venrate ;  
												      }
									     
										 String sql11="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
											 		+ "values('"+sqlStartDate+"','"+refdetails+"',"+docno+",'"+acnos+"','"+descs+"','"+curris+"','"+rates+"',"+pricetottal+","+ldramounts+",0,1,3,0,0,0,'"+rates+"',0,0,'VPD','"+session.getAttribute("BRANCHID").toString()+"',"+tranno+",3)";
									     
									     
										// System.out.println("---sql11----"+sql11) ; 
									 
											 int ss1 = stmt.executeUpdate(sql11);

										     if(ss1<=0)
												{
													conn.close();
													//return 0;
													
												}
									     
										
										     
										 
										     
										     
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
											String sqlupdatess="update gl_vpurdirm set tr_no='"+tranno+"' where doc_no='"+docno+"' ";	
											
											int lastvals=stmtvehpurchase.executeUpdate(sqlupdatess);
											
											if(lastvals<=0)
											{
												conn.close();
												return 0;
											}
														
									//	 	System.out.println("------sqlupdatess------"+sqlupdatess);	 
										 
									 
										 
										 
								
					}
			     
			     int accnoss=0;     
				   String sql2="select  acno from my_account where codeno='VEH'";
				    
				   // select  acno  from my_account where codeno='VEH';
					//System.out.println("-----sql2-----"+sql2);
					

				   ResultSet tass1 = stmtvehpurchase.executeQuery (sql2);
					
					if (tass1.next()) {
				
						accnoss=tass1.getInt("acno");		
						
				     }
				//	System.out.println("------sql2------"+sql2);	 
					int assetdoc=0;
					   String sql99="select coalesce((max(doc_no)+1),1) docno from gc_assettran";
					    
					   // select  acno  from my_account where codeno='VEH';
						//System.out.println("-----sql2-----"+sql2);
						

					   ResultSet tass99 = stmtvehpurchase.executeQuery (sql99);
						
						if (tass99.next()) {
					
							assetdoc=tass99.getInt("docno");		
							
					     }
				    
/*                        //                    0     1      2    3     4      5        6          7       8       9
     String sql="INSERT INTO gl_vpurd(srno,fleet_no,brdid,modid,clrid,chaseno,enginno,puch_cost,add_cost,tot_cost,rdocno)VALUES"
			     */
			     String fleetnos=""+(vehpurreqarray[0].trim().equalsIgnoreCase("undefined") || vehpurreqarray[0].trim().equalsIgnoreCase("NaN")|| vehpurreqarray[0].trim().equalsIgnoreCase("")|| vehpurreqarray[0].isEmpty()?0:vehpurreqarray[0].trim())+"";
				 int  fleetnoss=Integer.parseInt(fleetnos);
			     String amounts=""+(vehpurreqarray[8].trim().equalsIgnoreCase("undefined") || vehpurreqarray[8].trim().equalsIgnoreCase("NaN")|| vehpurreqarray[8].trim().equalsIgnoreCase("")|| vehpurreqarray[8].isEmpty()?0:vehpurreqarray[8].trim())+"";


			     String chaseno=""+(vehpurreqarray[4].trim().equalsIgnoreCase("undefined") || vehpurreqarray[4].trim().equalsIgnoreCase("NaN")|| vehpurreqarray[4].trim().equalsIgnoreCase("")|| vehpurreqarray[4].isEmpty()?0:vehpurreqarray[4].trim())+"";
			     String enginno=""+(vehpurreqarray[5].trim().equalsIgnoreCase("undefined") || vehpurreqarray[5].trim().equalsIgnoreCase("NaN")|| vehpurreqarray[5].trim().equalsIgnoreCase("")|| vehpurreqarray[5].isEmpty()?0:vehpurreqarray[5].trim())+"";
			     String purchsecost=""+(vehpurreqarray[6].trim().equalsIgnoreCase("undefined") || vehpurreqarray[6].trim().equalsIgnoreCase("NaN")|| vehpurreqarray[6].trim().equalsIgnoreCase("")|| vehpurreqarray[6].isEmpty()?0:vehpurreqarray[6].trim())+"";
			     String addcost=""+(vehpurreqarray[7].trim().equalsIgnoreCase("undefined") || vehpurreqarray[7].trim().equalsIgnoreCase("NaN")|| vehpurreqarray[7].trim().equalsIgnoreCase("")|| vehpurreqarray[7].isEmpty()?0:vehpurreqarray[7].trim())+"";
			     
			     String sqla="INSERT INTO gc_assettran(date,doc_no,fleet_no,acno,dramount,brhid,ttype,ftype,tr_no)VALUES"
					       + " ('"+sqlStartDate+"','"+assetdoc+"',"
					       + "'"+fleetnoss+"',"
					       + "'"+accnoss+"',"
					       + "'"+amounts+"',"
					       + "'"+session.getAttribute("BRANCHID").toString()+"',"
					       +"'FAD',1,'"+tranno+"' )";
			     
			 //	//System.out.println("---sqla-------"+sqla);
					     int resultSet3 = stmtvehpurchase.executeUpdate(sqla);
					    
					     if(resultSet3<=0)
							{
								conn.close();
								return 0;
								
							}					   
			   
					     
				//	     select eng_no,ch_no,,prch_cost,tval from gl_vehmaster;   
					     
					    String strgetvendor="select ac.cldocno from my_acbook ac inner join my_head head on (head.doc_no=ac.acno) where head.account="+headacccode;
					    int vendorid=0;
					    ResultSet rsvendor=stmtvehpurchase.executeQuery(strgetvendor);
					    while(rsvendor.next()){
					    	vendorid=stmtvehpurchase.getInt("cldocno");
					    }
					 	String sqlupdates="update gl_vehmaster set puchstatus='"+docno+"',eng_no='"+enginno+"',ch_no='"+chaseno+"',prch_cost='"+purchsecost+"', add1='"+addcost+"', tval='"+amounts+"',depr_date='"+invDate+"',DLRID="+vendorid+"  where fleet_no='"+fleetnoss+"' ";	
					 	System.out.println("------sqlupdates------"+sqlupdates);	 
						int lastval=stmtvehpurchase.executeUpdate(sqlupdates);
						//System.out.println("------sqlupdates------"+sqlupdates);	 
						if(lastval<=0)
						{
							conn.close();
							return 0;
						}
									
				     
			     
			     
			     
		      }//if
		
		   }//for
        

		if(docno>0)
		{
			conn.commit();
			stmtvehpurchase.close();
			conn.close();
			return docno;
			
		}
        
        }//try
		
		
		
		 
        catch(Exception e)
        {
        	e.printStackTrace();
    		conn.close();
    		return 0;	
        	
        }
		
		
		
		
		return 0;
	}
	   
	public  JSONArray searchmaster(HttpSession session,String docnoss,String accountss,String accnamess,String datess ,String aa) throws SQLException {
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
	    String brcid=session.getAttribute("BRANCHID").toString();
	    java.sql.Date  sqlStartDate = null;
		if(!(datess.equalsIgnoreCase("undefined"))&&!(datess.equalsIgnoreCase(""))&&!(datess.equalsIgnoreCase("0")))
    	{
    	sqlStartDate = ClsCommon.changeStringtoSqlDate(datess);
    	}
    	
    	
	    
		String sqltest="";
	    
	   	if((!(docnoss.equalsIgnoreCase(""))) && (!(docnoss.equalsIgnoreCase("NA")))){
    		sqltest=sqltest+" and vo.voc_no like '%"+docnoss+"%'";
    	}
    	if((!(accountss.equalsIgnoreCase(""))) && (!(accountss.equalsIgnoreCase("NA")))){
    		sqltest=sqltest+" and h.account like '%"+accountss+"%'  ";
    	}
    	if((!(accnamess.equalsIgnoreCase(""))) && (!(accnamess.equalsIgnoreCase("NA")))){
    		sqltest=sqltest+" and h.description like '%"+accnamess+"%'";
    	}
     
    	
    	if(!(sqlStartDate==null)){
    		sqltest=sqltest+" and vo.date='"+sqlStartDate+"'";
    	} 
    	Connection conn = null;
		try {
			 conn = ClsConnection.getMyConnection();
			if(aa.equalsIgnoreCase("yes"))
			{
				
				Statement stmtmain = conn.createStatement ();
	        	String pySql=("  select  vo.voc_no,vo.doc_no,vo.date,vo.venid, vo.desc1,vo.invno purno,vo.puchdate purdate,h.description,h.account,h.doc_no headdoc "
	        			+ " from gl_vpurdirm vo  left  join my_head h on h.doc_no=vo.venid    where vo.status=3 and vo.brhid='"+brcid+"' "+sqltest );
	 
	        	//System.out.println("-----------"+pySql);
	        	
				ResultSet resultSet = stmtmain.executeQuery(pySql);

				RESULTDATA=ClsCommon.convertToJSON(resultSet); 
				stmtmain.close();
				
			}
			conn.close();
			 return RESULTDATA;
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
	//	System.out.println(RESULTDATA);
	    return RESULTDATA;
	}



	public boolean delete(int masterdoc_no, HttpSession session, String mode,
			String formdetailcode) throws SQLException {
		try
		{
		
		  conn=ClsConnection.getMyConnection();
 
	    	CallableStatement stmtvehpurchase= conn.prepareCall("{call vahpurchasedirDML(?,?,?,?,?,?,?,?,?,?,?)}"); 
	        
	    	stmtvehpurchase.setInt(10,masterdoc_no);
			stmtvehpurchase.setInt(11, 0);
			stmtvehpurchase.setDate(1,null); 
			stmtvehpurchase.setInt(2,0); 
			
			stmtvehpurchase.setString(3,null);
	 
			stmtvehpurchase.setString(4,session.getAttribute("USERID").toString());
			stmtvehpurchase.setString(5,session.getAttribute("BRANCHID").toString());
			stmtvehpurchase.setString(6,formdetailcode);
			stmtvehpurchase.setDate(7,null);
			stmtvehpurchase.setInt(8,0);
			stmtvehpurchase.setString(9,"D");
			
			
		   int res=stmtvehpurchase.executeUpdate();	
		
		
				if(res>0)
				{
				int	matertr_no=0;
				
				Statement stmtmain = conn.createStatement ();
					String trsql="select tr_no from gl_vpurdirm where doc_no='"+masterdoc_no+"'";
					
					ResultSet tass = stmtmain.executeQuery (trsql);
					
							if (tass.next()) {
						
								matertr_no=tass.getInt("trno");		
								
						     }
							
						String update="update my_jvtran set status=7 where tr_no='"+matertr_no+"'";	
						stmtvehpurchase.executeUpdate(update);
							
							
							 
					
					
					
					
					stmtvehpurchase.close();
					conn.close();
					return true;
					
				}
		
		
		
		
	     }
		
		
			catch(Exception e)
				{
				conn.close();
				return false;
						
				}
		       return false;


		 
	}
	
	
	
	
	public  ClspurchaseDirectBean getPrint(int docno, HttpServletRequest request) throws SQLException {
		ClspurchaseDirectBean bean = new ClspurchaseDirectBean();
		  ClsAmountToWords c = new ClsAmountToWords();
		  Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtprint = conn.createStatement ();
				String resql=("  select  vo.voc_no,vo.doc_no,DATE_FORMAT(vo.date,'%d.%m.%Y') date,vo.venid, vo.desc1,vo.invno purno,DATE_FORMAT(vo.puchdate,'%d.%m.%Y') purdate,h.description,h.account,h.doc_no headdoc "
	        			+ " from gl_vpurdirm vo  left  join my_head h on h.doc_no=vo.venid   where vo.doc_no='"+docno+"'" );
	 
	       /* 
				String resql=("  select o.voc_no refno,vo.voc_no,vo.doc_no,DATE_FORMAT(vo.date,'%d.%m.%Y') date,vo.venid, if(vo.rtype='DIR','Direct',concat('Purchase Order (',o.voc_no,')')) type, vo.rno,"
						+ " DATE_FORMAT(vo.expdeldt,'%d.%m.%Y')  expdeldt, vo.desc1, round(vo.nettotal,2) nettotal,vo.purno,DATE_FORMAT(vo.purdate,'%d.%m.%Y') purdate,h.description,h.account,h.doc_no headdoc "
	        			+ " from gl_vpurdirm vo  left  join my_head h on h.doc_no=vo.venid  left join gl_vpom o on o.doc_no=vo.rno where vo.doc_no='"+docno+"'" );
	 
		*/	//	System.out.println("-----resql----"+resql);
				
			//	String resql=("select voc_no,doc_no,DATE_FORMAT(date,'%d.%m.%Y') AS date,type,DATE_FORMAT(expdeldt,'%d.%m.%Y') AS expdeldt,desc1 from gl_vprm where doc_no='"+docno+"' ");
		
				ResultSet pintrs = stmtprint.executeQuery(resql);
				
			     
			       while(pintrs.next()){
			    	   // cldatails
			    	   
			    	  /* setLblclient setLblclientaddress setLblmob setLblemail setLbldate setLbltypep setDocvals*/
			    	   
			    	
			    	    bean.setLbldoc(pintrs.getInt("voc_no"));
			    	    bean.setLbldate(pintrs.getString("date"));
			    	    bean.setLbldesc1(pintrs.getString("desc1"));
			    	    
			    	    bean.setLblvendoeacc(pintrs.getString("account"));
			    	    bean.setLblvendoeaccName(pintrs.getString("description"));
			    	//    bean.setLbltotal(pintrs.getString("nettotal"));
			    	    
			    	    bean.setLblinvno(pintrs.getString("purno"));
			    	    
			    	    bean.setLblpurchaseDate(pintrs.getString("purdate"));
			    	    
			    	   // setLbltotal(pintbean.getLbltotal());
			       }
				

		
				
				String resql1=("select round(sum(rq.puch_cost+rq.add_cost),2) price   from gl_vpurdird rq where rdocno='"+docno+"'" );
	 
			
				ResultSet pintrs1 = stmtprint.executeQuery(resql1);
				
				   if(pintrs1.next()){
			  
			    	    bean.setLbltotal(pintrs1.getString("price"));
			    		bean.setAmountinwords(c.convertAmountToWords(pintrs1.getString("price")));	
				   }
				
				
					stmtprint.close();
				
				 Statement stmtinvoice10 = conn.createStatement ();
				    String  companysql="select b.branchname,c.company,c.address,c.tel,c.fax,l.loc_name location from gl_vpurm r  "
				    		+ " left join my_brch b on r.brhid=b.doc_no left join my_locm l on l.brhid=b.doc_no "
				    		+ "left join my_comp c on b.cmpid=c.doc_no where r.doc_no="+docno+"  ";


			         ResultSet resultsetcompany = stmtinvoice10.executeQuery(companysql); 
				       
				       while(resultsetcompany.next()){
				    	   
				    	   bean.setLblbranch(resultsetcompany.getString("branchname"));
				    	   bean.setLblcompname(resultsetcompany.getString("company"));
				    	  
				    	   bean.setLblcompaddress(resultsetcompany.getString("address"));
				    	 
				    	   bean.setLblcomptel(resultsetcompany.getString("tel"));
				    	  
				    	   bean.setLblcompfax(resultsetcompany.getString("fax"));
				    	   bean.setLbllocation(resultsetcompany.getString("location"));
				    	  
				    	 
				    	   
				       } 
				       stmtinvoice10.close();
				       
				       
				       ArrayList<String> arr=new ArrayList<String>();
					
						
							Statement stmtinvoice1 = conn.createStatement ();
							String strSqldetail1="";
					
							
							
							 strSqldetail1=("select  rq.fleet_no,v.reg_no,vb.brand_name brand,vm.vtype model,coalesce(vc.color,'') color,rq.chaseno,rq.enginno ,"
							 		+ " round(rq.puch_cost,2) puch_cost,round(rq.add_cost,2) add_cost,round((rq.puch_cost+rq.add_cost),2) as price from gl_vpurdird rq left join gl_vehbrand vb on vb.doc_no=rq.BRDID "
							 		+ "left join gl_vehmodel vm on vm.doc_no=rq.MODID left join my_color vc on vc.doc_no=rq.clrid "
							 		+ "left join gl_vehmaster v on v.fleet_no=rq.fleet_no where rq.rdocno="+docno+" ");
				//System.out.println("------------strSqldetail1----"+strSqldetail1);
						ResultSet rsdetail=stmtinvoice1.executeQuery(strSqldetail1);
						
						int rowcount=1;
				
						while(rsdetail.next()){

								String temp="";
								temp=rowcount+"::"+rsdetail.getString("fleet_no")+"::"+rsdetail.getString("reg_no")+"::"+rsdetail.getString("brand")+"::"+rsdetail.getString("model")+"::"+rsdetail.getString("color")+"::"+rsdetail.getString("chaseno")+"::"+rsdetail.getString("enginno")+"::"+rsdetail.getString("puch_cost")+"::"+rsdetail.getString("add_cost")+"::"+rsdetail.getString("price");

								arr.add(temp);
								rowcount++;
				
						
							
					}
						
						
						request.setAttribute("details",arr); 
						stmtinvoice1.close();
										
				conn.close();
			
		}
		catch(Exception e){
			conn.close();
			e.printStackTrace();
		}
		return bean;
		
	
	}

	
	
	
	
}
