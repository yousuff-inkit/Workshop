package com.operations.marketing.leasepricerequest;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.operations.marketing.enquiry.ClsEnquiryBean;



public class ClsLeasepriceRequestDAO {
	ClsConnection connDAO= new ClsConnection();
	ClsCommon commonDAO= new ClsCommon();
	Connection conn;
	public int insert(Date sqlStartDate,String clid,String clname,String address,String mobile,int general,int client,String remarks,String clEmail,
			ArrayList<String> enqarray,HttpSession session,String mode,String Dtype, HttpServletRequest request,String hidenqsrc) throws SQLException {
		try{
			int docno;
			conn=connDAO.getMyConnection();
			conn.setAutoCommit(false);  
			CallableStatement stmtLeasepr = conn.prepareCall("{call leasepriceReqDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmtLeasepr.registerOutParameter(13, java.sql.Types.INTEGER);
			stmtLeasepr.registerOutParameter(15, java.sql.Types.INTEGER);
			stmtLeasepr.setDate(1,sqlStartDate);
			stmtLeasepr.setString(2,clid);
			stmtLeasepr.setString(3,clname);
			stmtLeasepr.setString(4,address);
		    stmtLeasepr.setString(5,mobile);
			stmtLeasepr.setInt(6,general);
			stmtLeasepr.setInt(7,client);
			stmtLeasepr.setString(8,remarks);
			stmtLeasepr.setString(9,clEmail);
			stmtLeasepr.setString(10,session.getAttribute("USERID").toString());
			stmtLeasepr.setString(11,session.getAttribute("BRANCHID").toString());
			stmtLeasepr.setString(12,Dtype);
			stmtLeasepr.setString(14,mode);
			stmtLeasepr.setString(16,hidenqsrc);
			stmtLeasepr.executeQuery();
			docno=stmtLeasepr.getInt("docNo");
	
			int vocno=stmtLeasepr.getInt("vocNo");	
			request.setAttribute("vocno", vocno);
			//System.out.println("sssssss"+session.getAttribute("USERID").toString());
			if(docno<=0)
			{

				 conn.close();
				return 0;
			}	
			for(int i=0;i< enqarray.size();i++){
		    	
			     String[] enqiury=enqarray.get(i).split("::");
			     if(!(enqiury[1].trim().equalsIgnoreCase("undefined")|| enqiury[1].trim().equalsIgnoreCase("NaN")||enqiury[1].trim().equalsIgnoreCase("")|| enqiury[1].isEmpty()))
			     {
			    	/* ROWNO,RDOCNO,SR_NO,BRDID,MODID,SPEC,CLRID,QTY,FRMDATE,KMUSAGE,LDUR*/
		     String sql="INSERT INTO gl_lprd(SR_NO,BRDID,MODID,SPEC,CLRID,LDUR,FRMDATE,KMUSAGE,QTY,RDOCNO)VALUES"
				       + " ("+(i+1)+","
				       + "'"+(enqiury[1].trim().equalsIgnoreCase("undefined") || enqiury[1].trim().equalsIgnoreCase("NaN")|| enqiury[1].trim().equalsIgnoreCase("")|| enqiury[1].isEmpty()?0:enqiury[1].trim())+"',"
				       + "'"+(enqiury[2].trim().equalsIgnoreCase("undefined") || enqiury[2].trim().equalsIgnoreCase("NaN")|| enqiury[2].trim().equalsIgnoreCase("")|| enqiury[2].isEmpty()?0:enqiury[2].trim())+"',"
				       + "'"+(enqiury[3].trim().equalsIgnoreCase("undefined") || enqiury[3].trim().equalsIgnoreCase("NaN")||enqiury[3].trim().equalsIgnoreCase("")|| enqiury[3].isEmpty()?0:enqiury[3].trim())+"',"
				       + "'"+(enqiury[4].trim().equalsIgnoreCase("undefined") || enqiury[4].trim().equalsIgnoreCase("NaN")||enqiury[4].trim().equalsIgnoreCase("")|| enqiury[4].isEmpty()?0:enqiury[4].trim())+"',"
				       + "'"+(enqiury[5].trim().equalsIgnoreCase("undefined") || enqiury[5].trim().equalsIgnoreCase("NaN")||enqiury[5].trim().equalsIgnoreCase("")|| enqiury[5].isEmpty()?0:enqiury[5].trim())+"',"
				       + "'"+(enqiury[6].trim().equalsIgnoreCase("undefined") || enqiury[6].trim().equalsIgnoreCase("NaN")||enqiury[6].trim().equalsIgnoreCase("")|| enqiury[6].isEmpty()?0:commonDAO.changeStringtoSqlDate(enqiury[6].trim()))+"',"
				       + "'"+(enqiury[7].trim().equalsIgnoreCase("undefined") || enqiury[7].trim().equalsIgnoreCase("NaN")||enqiury[7].trim().equalsIgnoreCase("")|| enqiury[7].isEmpty()?0:enqiury[7].trim())+"',"
				       + "'"+(enqiury[8].trim().equalsIgnoreCase("undefined") || enqiury[8].trim().equalsIgnoreCase("NaN")||enqiury[8].trim().equalsIgnoreCase("")|| enqiury[8].isEmpty()?0:enqiury[8].trim())+"',"
				       +"'"+docno+"')";
		   
				     int resultSet2 = stmtLeasepr.executeUpdate (sql);
				     if(resultSet2<=0)
				 	{
				 		 conn.close();
				 		return 0;
				 	}	
				     
			     }
				     
				     }
			if (docno > 0) {
				conn.commit();
				stmtLeasepr.close();
				conn.close();
				return docno;
			}
		}catch(Exception e){
         e.printStackTrace();
			
			conn.close();	
		}
		return 0;
	   }
	


	public boolean edit(int docno,Date sqlStartDate,String clid,String clname,String address,String mobile,int general,int client,
			String remarks,String clEmail,ArrayList<String> enqarray,HttpSession session,String mode,String Dtype,String hidenqsrc) throws SQLException {
		
		try{
			conn=connDAO.getMyConnection();
			conn.setAutoCommit(false);  
			CallableStatement stmtLeasepr = conn.prepareCall("{call leasepriceReqDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			
			stmtLeasepr.setDate(1,sqlStartDate);
			stmtLeasepr.setString(2,clid);
			stmtLeasepr.setString(3,clname);
			stmtLeasepr.setString(4,address);
			stmtLeasepr.setString(5,mobile);
			stmtLeasepr.setInt(6,general);
			stmtLeasepr.setInt(7,client);
			stmtLeasepr.setString(8,remarks);
			stmtLeasepr.setString(9,clEmail);
			stmtLeasepr.setString(10,session.getAttribute("USERID").toString());
			stmtLeasepr.setString(11,session.getAttribute("BRANCHID").toString());
			stmtLeasepr.setString(12,Dtype.trim());
			stmtLeasepr.setInt(13,docno);
			stmtLeasepr.setString(14,mode);
			stmtLeasepr.setInt(15,0);
			stmtLeasepr.setString(16,hidenqsrc);
			int aaa=stmtLeasepr.executeUpdate();
			docno=stmtLeasepr.getInt("docNo");
					
			 if(aaa<=0){
					
					return false;
					
				      }
			
			   String delsql="Delete from gl_lprd where rdocno="+docno+" ";
			   stmtLeasepr.executeUpdate(delsql);
				for(int i=0;i< enqarray.size();i++){
			    	
				     String[] enqiury=enqarray.get(i).split("::");
				     if(!(enqiury[1].trim().equalsIgnoreCase("undefined")|| enqiury[1].trim().equalsIgnoreCase("NaN")||enqiury[1].trim().equalsIgnoreCase("")|| enqiury[1].isEmpty()))
				     {
				    	 /* ROWNO,RDOCNO,SR_NO,BRDID,MODID,SPEC,CLRID,QTY,FRMDATE,KMUSAGE,LDUR*/
					     String sql="INSERT INTO gl_lprd(SR_NO,BRDID,MODID,SPEC,CLRID,LDUR,FRMDATE,KMUSAGE,QTY,RDOCNO)VALUES"
							       + " ("+(i+1)+","
							       + "'"+(enqiury[1].trim().equalsIgnoreCase("undefined") || enqiury[1].trim().equalsIgnoreCase("NaN")|| enqiury[1].trim().equalsIgnoreCase("")|| enqiury[1].isEmpty()?0:enqiury[1].trim())+"',"
							       + "'"+(enqiury[2].trim().equalsIgnoreCase("undefined") || enqiury[2].trim().equalsIgnoreCase("NaN")|| enqiury[2].trim().equalsIgnoreCase("")|| enqiury[2].isEmpty()?0:enqiury[2].trim())+"',"
							       + "'"+(enqiury[3].trim().equalsIgnoreCase("undefined") || enqiury[3].trim().equalsIgnoreCase("NaN")||enqiury[3].trim().equalsIgnoreCase("")|| enqiury[3].isEmpty()?0:enqiury[3].trim())+"',"
							       + "'"+(enqiury[4].trim().equalsIgnoreCase("undefined") || enqiury[4].trim().equalsIgnoreCase("NaN")||enqiury[4].trim().equalsIgnoreCase("")|| enqiury[4].isEmpty()?0:enqiury[4].trim())+"',"
							       + "'"+(enqiury[5].trim().equalsIgnoreCase("undefined") || enqiury[5].trim().equalsIgnoreCase("NaN")||enqiury[5].trim().equalsIgnoreCase("")|| enqiury[5].isEmpty()?0:enqiury[5].trim())+"',"
							       + "'"+(enqiury[6].trim().equalsIgnoreCase("undefined") || enqiury[6].trim().equalsIgnoreCase("NaN")||enqiury[6].trim().equalsIgnoreCase("")|| enqiury[6].isEmpty()?0:commonDAO.changeStringtoSqlDate(enqiury[6].trim()))+"',"
							       + "'"+(enqiury[7].trim().equalsIgnoreCase("undefined") || enqiury[7].trim().equalsIgnoreCase("NaN")||enqiury[7].trim().equalsIgnoreCase("")|| enqiury[7].isEmpty()?0:enqiury[7].trim())+"',"
							       + "'"+(enqiury[8].trim().equalsIgnoreCase("undefined") || enqiury[8].trim().equalsIgnoreCase("NaN")||enqiury[8].trim().equalsIgnoreCase("")|| enqiury[8].isEmpty()?0:enqiury[8].trim())+"',"
							       +"'"+docno+"')";
			   
					     int resultSet2 = stmtLeasepr.executeUpdate (sql);
					     if(resultSet2<=0)
					 	{
					 		 conn.close();
					 		return false;
					 	}	
					     
				     }
					     
					     }
			 
	
						
			if (aaa > 0) {
				conn.commit();
				stmtLeasepr.close();
				conn.close();
				System.out.println("Sucess");
				return true;
			}
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		return false;
	}

	public int delete(int docno,HttpSession session,String mode,String Dtype) throws SQLException {
		try{
			conn=connDAO.getMyConnection();
			 
			
			//Statement stmt = conn.createStatement ();
			
/*			String upsql="select clstatus from gl_enqm where doc_no='"+docno+"'";
						   ResultSet resultSet = stmt.executeQuery(upsql);
						 
						   while (resultSet.next()) {
						    
							 int  clstatus=resultSet.getInt("clstatus");
							   
							 if(clstatus>2)
							 {
								 stmt.close();
								 conn.close(); 
								return -1;
								 
							 }
							    
						    	
						    }		  
					 */
			
			
			
			
			CallableStatement stmtLeasepr = conn.prepareCall("{call leasepriceReqDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmtLeasepr.setDate(1,null);
			stmtLeasepr.setString(2,null);
			stmtLeasepr.setString(3,null);
			stmtLeasepr.setString(4,null);
			stmtLeasepr.setString(5,null);
			stmtLeasepr.setInt(6,0);
			stmtLeasepr.setInt(7,0);
			stmtLeasepr.setString(8,null);
			stmtLeasepr.setString(9,null);
			stmtLeasepr.setString(10,session.getAttribute("USERID").toString());
			stmtLeasepr.setString(11,session.getAttribute("BRANCHID").toString());
			stmtLeasepr.setString(12,Dtype.trim());
			stmtLeasepr.setInt(13,docno);
			stmtLeasepr.setString(14,"D");
			stmtLeasepr.setInt(15,0);
			stmtLeasepr.setString(16,"0");
			int aaa=stmtLeasepr.executeUpdate();
			
			
			
			if (aaa > 0) {
				
				stmtLeasepr.close();
				conn.close();
				System.out.println("Sucess");
				return 1;
			}	
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		return 0;
	}
	

	public   JSONArray searchrelode(String docno) throws SQLException {

	    JSONArray RESULTDATA=new JSONArray();
	    
	    Connection conn = null;
		try {
				 conn = connDAO.getMyConnection();
				Statement stmtrelode = conn.createStatement ();
	        	
				String resql=("select eq.sr_no,eq.brdid,eq.modid,eq.spec specification,eq.clrid,eq.qty,eq.frmdate fromdate,round(eq.kmusage) kmusage,DATE_FORMAT(frmdate,'%d.%m.%Y') AS"
						+ "    hidfromdate,eq.ldur,vb.brand_name brand,vm.vtype model,vc.color color"
						+ "    FROM gl_lprd eq left join gl_vehbrand vb on vb.doc_no=eq.BRDID"
						+ "    left join gl_vehmodel vm on vm.doc_no=eq.MODID"
						+ "     left join my_color vc on vc.doc_no=eq.clrid  where rdocno='"+docno+"' ");
				
				ResultSet resultSet = stmtrelode.executeQuery(resql);
				RESULTDATA=commonDAO.convertToJSON(resultSet);
				stmtrelode.close();
				conn.close();

				
				
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		
	    return RESULTDATA;
	}
	/*public  JSONArray searchUnit() throws SQLException {

	    JSONArray RESULTDATA=new JSONArray();
	    
	   
		try {
				Connection conn = ClsConnection.getMyConnection();
				Statement stmtunit = conn.createStatement ();
	        	
				ResultSet resultSet = stmtunit.executeQuery ("select unit,doc_no from my_unitm where status<>7;");

				RESULTDATA=commonDAO.convertToJSON(resultSet);
				stmtunit.close();
				conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
		}
		//System.out.println(RESULTDATA);
	    return RESULTDATA;
	}*/
public   JSONArray searchColor() throws SQLException {

    JSONArray RESULTDATA=new JSONArray();
    Connection conn = null;
   
	try {
			 conn = connDAO.getMyConnection();
			Statement stmtVehclr = conn.createStatement ();
        	
			ResultSet resultSet = stmtVehclr.executeQuery ("select  doc_no,color  from my_color  where status<>7 order by  doc_no;");

			RESULTDATA=commonDAO.convertToJSON(resultSet);
			stmtVehclr.close();
			conn.close();

	}
	catch(Exception e){
		e.printStackTrace();
		conn.close();
	}
	//System.out.println(RESULTDATA);
    return RESULTDATA;
}






	


	public   JSONArray searchBrand() throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
		try {
				 conn = connDAO.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
            	
				ResultSet resultSet = stmtVeh.executeQuery ("select brand,brand_name,doc_no from gl_vehbrand where status<>7;");

				RESULTDATA=commonDAO.convertToJSON(resultSet);
				stmtVeh.close();
				conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
	
	public   JSONArray searchModel(String brandval) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
		try {
				 conn = connDAO.getMyConnection();
				Statement stmtVeh3 = conn.createStatement ();
            	
				String modelsql= ("select vtype,doc_no from gl_vehmodel where brandid="+brandval+" and status<>7;");
				
				//System.out.println("========"+modelsql);
				
				ResultSet resultSet = stmtVeh3.executeQuery(modelsql)  ;
				RESULTDATA=commonDAO.convertToJSON(resultSet);
				stmtVeh3.close();
				conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
	
		
	    public   JSONArray searchClient(HttpSession session,String clname,String mob) throws SQLException {


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
	    	
	    	
	    	    	
	    	
	    		
	    	
	    	//System.out.println("name"+clname);
	    	
	    	String sqltest="";
	    	
	    	if(!(clname.equalsIgnoreCase(""))){
	    		sqltest=sqltest+" and refname like '%"+clname+"%'";
	    	}
	    	if(!(mob.equalsIgnoreCase(""))){
	    		sqltest=sqltest+" and per_mob like '%"+mob+"%'";
	    	}
	    	
	    	Connection conn = null;
	    
			try {
					 conn = connDAO.getMyConnection();
					Statement stmtVeh1 = conn.createStatement ();
	            	
					String clsql= ("select cldocno,refname,trim(address) address,per_mob,trim(mail1) mail1 from my_acbook where  dtype='CRM'  " +sqltest);
					//System.out.println("========"+clsql);
					ResultSet resultSet = stmtVeh1.executeQuery(clsql);
					
					RESULTDATA=commonDAO.convertToJSON(resultSet);
					stmtVeh1.close();
					conn.close();
			}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
			//System.out.println(RESULTDATA);
	        return RESULTDATA;
	    }
	    
	 
	    public   JSONArray searchMaster(HttpSession session,String msdocno,String clnames,String mobno,String enqdate,String enqtype) throws SQLException {


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
		   	        
		    	 //  System.out.println("8888888888"+clnames); 	
		   	 String brid=session.getAttribute("BRANCHID").toString();
		    	
		    	
			    
		    	java.sql.Date sqlStartDate=null;
		    
		    	
		    	//enqdate.trim();
		    	if(!(enqdate.equalsIgnoreCase("undefined"))&&!(enqdate.equalsIgnoreCase(""))&&!(enqdate.equalsIgnoreCase("0")))
		    	{
		    	sqlStartDate = commonDAO.changeStringtoSqlDate(enqdate);
		    	}
		    	
		    
		    	
		   
		    	
		    	
		    	String sqltest="";
		    	if(!(msdocno.equalsIgnoreCase(""))){
		    		sqltest=sqltest+" and voc_no like '%"+msdocno+"%'";
		    	}
		    	if(!(clnames.equalsIgnoreCase(""))){
		    		sqltest=sqltest+" and name like '%"+clnames+"%'";
		    	}
		    	if(!(mobno.equalsIgnoreCase(""))){
		    		sqltest=sqltest+" and mob like '%"+mobno+"%'";
		    	}
		    	
		    	if(!(enqtype.equalsIgnoreCase(""))){
		    		String enqtypeval="";
		    		if(enqtype.equalsIgnoreCase("general"))
		    				{
		    			 enqtypeval="0";
		    				}
		    		else if(enqtype.equalsIgnoreCase("client"))
    				{
    			           enqtypeval="1";
    				}
		    		else
		    		{
		    		}
		    		
		    		sqltest=sqltest+" and reqtype like '%"+enqtypeval+"%'";
		    	}
		    	 if(!(sqlStartDate==null)){
		    		sqltest=sqltest+" and date='"+sqlStartDate+"'";
		    	} 
		        
		    	
		    	 	    	
		    	 Connection conn = null;
		 
				try {
						 conn = connDAO.getMyConnection();
						Statement stmtenq1 = conn.createStatement ();
		            	
						String clssql= ("select enq.doc_no enqdocno,coalesce(enq.txtname,'') txtname,m.voc_no,m.doc_no,m.date,m.remarks,m.cldocno,m.name,m.com_add1,m.mob,m.email,m.reqtype from gl_lprm m left join cm_enqsource enq on m.enqsrc=enq.doc_no where m.status=3 and brhid='"+brid+"' " +sqltest);
						//System.out.println("========"+clssql);
						ResultSet resultSet = stmtenq1.executeQuery(clssql);
						
						RESULTDATA=commonDAO.convertToJSON(resultSet);
						stmtenq1.close();
						conn.close();
				}
				catch(Exception e){
					e.printStackTrace();
					conn.close();
				}
				//System.out.println(RESULTDATA);
		        return RESULTDATA;
		    }

		  public   ClsLeasepriceRequestBean getPrint(int docno) throws SQLException {
			  ClsLeasepriceRequestBean bean = new ClsLeasepriceRequestBean();
			  Connection conn = null;
			try {
					 conn = connDAO.getMyConnection();
					Statement stmtprint = conn.createStatement ();
		        	
					String resql=("Select e.voc_no,DATE_FORMAT(e.date,'%d.%m.%Y') AS date, "
							+ "e.name,e.com_add1,e.mob,e.email,if(e.reqtype=1,'Client','General') reqtype from gl_lprm e where e.doc_no="+docno+" ");
					
					ResultSet pintrs = stmtprint.executeQuery(resql);
					
				     
				       while(pintrs.next()){
				    	   // cldatails
				    	   
				    	  /* setLblclient setLblclientaddress setLblmob setLblemail setLbldate setLbltypep setDocvals*/
				    	   
				    	   
				    	    bean.setLblclient(pintrs.getString("name"));
				    	    bean.setLblclientaddress(pintrs.getString("com_add1"));
				    	    bean.setLblmob(pintrs.getString("mob"));
				    	    bean.setLblemail(pintrs.getString("email"));
				    	    //upper
				    	    bean.setLbldate(pintrs.getString("date"));
				    	    bean.setLbltypep(pintrs.getString("reqtype"));
				    	    bean.setDocvals(pintrs.getInt("voc_no"));
				       }
					

					stmtprint.close();
					
					
					
					 Statement stmtinvoice10 = conn.createStatement ();
					    String  companysql="select b.branchname,c.company,c.address,c.tel,c.fax,l.loc_name location from gl_lprm r  "
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
					       
					
					conn.close();



					
			}
			catch(Exception e){
				conn.close();
				e.printStackTrace();
			}
			return bean;
			
		
		}
			public   ArrayList<String> getPrintdetails(int docno) throws SQLException {
				ArrayList<String> arr=new ArrayList<String>();
				Connection conn = null;
				try {
					 conn = connDAO.getMyConnection();
					Statement stmtinvoice = conn.createStatement ();
					String strSqldetail="";
				strSqldetail="select eq.sr_no,eq.spec,if(eq.KMUSAGE>0,round(eq.KMUSAGE),'') kmusage,DATE_FORMAT(frmdate,'%d.%m.%Y') AS fromdate,if(eq.qty>0,round(eq.qty),'') qty,"
						+ "if(eq.LDUR='0','',eq.LDUR) ldur,vb.brand_name brand,coalesce(vm.vtype,'') model,coalesce(vc.color,'') color "
						+ "FROM gl_lprd eq left join gl_vehbrand vb on vb.doc_no=eq.BRDID "
						+ " left join gl_vehmodel vm on vm.doc_no=eq.MODID   left join my_color vc on vc.doc_no=eq.clrid  where rdocno="+docno+" ";
				
		
				ResultSet rsdetail=stmtinvoice.executeQuery(strSqldetail);
				
				int rowcount=1;
		
				while(rsdetail.next()){
	
						String temp="";
						String spci="";
						if(rsdetail.getString("spec").equalsIgnoreCase("0"))
						{
							spci="";
						}
						else
						{
							spci=rsdetail.getString("spec");
						}
						temp=rowcount+"::"+rsdetail.getString("brand")+"::"+rsdetail.getString("model")+"::"+spci+"::"+rsdetail.getString("color")+"::"+rsdetail.getString("ldur")+"::"+rsdetail.getString("fromdate")+"::"+rsdetail.getString("kmusage")+"::"+rsdetail.getString("qty") ;
	
						arr.add(temp);
						rowcount++;
		
				
					
			}
				stmtinvoice.close();
				conn.close();
				}
				catch(Exception e){
					e.printStackTrace();
					conn.close();
				}
		
				return arr;
			}
			
			
			public JSONArray getEnqsrcData(String id) throws SQLException{
				JSONArray enqdata=new JSONArray();
				if(!id.equalsIgnoreCase("1")){
					return enqdata;
				}
				Connection conn=null;
				try{
					conn=connDAO.getMyConnection();
					Statement stmt=conn.createStatement();
					String strsql="select doc_no,date,txtname,txtmobile from cm_enqsource where status=3";
					ResultSet rs=stmt.executeQuery(strsql);
					enqdata=commonDAO.convertToJSON(rs);
					stmt.close();
				}
				catch(Exception e){
					e.printStackTrace();
				}
				finally{
					conn.close();
				}
				return enqdata;
			}
			

}
