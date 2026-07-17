package com.operations.marketing.enquiry;

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
import com.operations.agreement.rentalagreement.ClsRentalAgreementBean;
import com.operations.marketing.enquiry.ClsEnquiryBean;



public class ClsEnquiryDAO {
	
	
	ClsConnection connDAO=new ClsConnection();
	
	ClsCommon CommonDAO=new ClsCommon();

	Connection conn;
	public int insert(Date sqlStartDate,String clid,String clname,String address,String mobile,int general,int client, 
			String remarks,String clEmail,ArrayList<String> enqarray,HttpSession session,String mode,String Dtype, String telno,HttpServletRequest request) throws SQLException {
		try{
			int docno;
			conn=connDAO.getMyConnection();
			conn.setAutoCommit(false);  
			CallableStatement stmtEnquiry = conn.prepareCall("{call enquiryDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmtEnquiry.registerOutParameter(14, java.sql.Types.INTEGER);
			stmtEnquiry.registerOutParameter(16, java.sql.Types.INTEGER);
			stmtEnquiry.setDate(1,sqlStartDate);
			stmtEnquiry.setString(2,clid);
			stmtEnquiry.setString(3,clname);
			stmtEnquiry.setString(4,address);
		    stmtEnquiry.setString(5,mobile);
		  	stmtEnquiry.setInt(6,general);
			stmtEnquiry.setInt(7,client);
			stmtEnquiry.setString(8,remarks);
			stmtEnquiry.setString(9,clEmail);
			stmtEnquiry.setString(10,session.getAttribute("USERID").toString());
			stmtEnquiry.setString(11,session.getAttribute("BRANCHID").toString());
			stmtEnquiry.setString(12,Dtype.trim());
			stmtEnquiry.setString(13,telno);
			stmtEnquiry.setString(15,mode);
			
		
			
			stmtEnquiry.executeQuery();
			docno=stmtEnquiry.getInt("docNo");
			int vocno=stmtEnquiry.getInt("vocNo");	
			request.setAttribute("vocno", vocno);
			
			if(docno<=0)
			{
				 conn.close();
				return 0;
			}	
			for(int i=0;i< enqarray.size();i++){
		    	
			     String[] enqiury=enqarray.get(i).split("::");
			     if(!(enqiury[1].trim().equalsIgnoreCase("undefined")|| enqiury[1].trim().equalsIgnoreCase("NaN")||enqiury[1].trim().equalsIgnoreCase("")|| enqiury[1].isEmpty()))
			     {
			    	/* RDOCNO,SR_NO,BRDID,MODID,SPEC,CLRID,UNIT,FRMDATE,TODATE,RTYPE*/
			         String sql="INSERT INTO gl_enqd(SR_NO,BRDID,MODID,SPEC,CLRID,RTYPE,FRMDATE,TODATE,UNIT,RDOCNO)VALUES"
						       + " ("+(i+1)+","
						       + "'"+(enqiury[1].trim().equalsIgnoreCase("undefined") || enqiury[1].trim().equalsIgnoreCase("NaN")|| enqiury[1].trim().equalsIgnoreCase("")|| enqiury[1].isEmpty()?0:enqiury[1].trim())+"',"
						       + "'"+(enqiury[2].trim().equalsIgnoreCase("undefined") || enqiury[2].trim().equalsIgnoreCase("NaN")|| enqiury[2].trim().equalsIgnoreCase("")|| enqiury[2].isEmpty()?0:enqiury[2].trim())+"',"
						       + "'"+(enqiury[3].trim().equalsIgnoreCase("undefined") || enqiury[3].trim().equalsIgnoreCase("NaN")||enqiury[3].trim().equalsIgnoreCase("")|| enqiury[3].isEmpty()?0:enqiury[3].trim())+"',"
						       + "'"+(enqiury[4].trim().equalsIgnoreCase("undefined") || enqiury[4].trim().equalsIgnoreCase("NaN")||enqiury[4].trim().equalsIgnoreCase("")|| enqiury[4].isEmpty()?0:enqiury[4].trim())+"',"
						       + "'"+(enqiury[5].trim().equalsIgnoreCase("undefined") || enqiury[5].trim().equalsIgnoreCase("NaN")||enqiury[5].trim().equalsIgnoreCase("")|| enqiury[5].isEmpty()?0:enqiury[5].trim())+"',"
						       + "'"+(enqiury[6].trim().equalsIgnoreCase("undefined") || enqiury[6].trim().equalsIgnoreCase("NaN")||enqiury[6].trim().equalsIgnoreCase("")|| enqiury[6].isEmpty()?0:CommonDAO.changeStringtoSqlDate(enqiury[6].trim()))+"',"
						       + "'"+(enqiury[7].trim().equalsIgnoreCase("undefined") || enqiury[7].trim().equalsIgnoreCase("NaN")||enqiury[7].trim().equalsIgnoreCase("")|| enqiury[7].isEmpty()?0:CommonDAO.changeStringtoSqlDate(enqiury[7].trim()))+"',"
						       + "'"+(enqiury[8].trim().equalsIgnoreCase("undefined") || enqiury[8].trim().equalsIgnoreCase("NaN")||enqiury[8].trim().equalsIgnoreCase("")|| enqiury[8].isEmpty()?0:enqiury[8].trim())+"',"
						       +"'"+docno+"')";
		   
				     int resultSet2 = stmtEnquiry.executeUpdate (sql);
				     if(resultSet2<=0)
				 	{
				 		 conn.close();
				 		return 0;
				 	}	
				     
			     }
				     
				     }
			if (docno > 0) {
				conn.commit();
				stmtEnquiry.close();
				conn.close();
				return docno;
			}
		}catch(Exception e){	
		e.printStackTrace();
			conn.close();	
		}
		return 0;
	   }
	


	public boolean edit(int docno,Date sqlStartDate,String clid,String clname,String address,String mobile,int general,int client,String remarks,String clEmail,ArrayList<String> enqarray,HttpSession session,String mode,String Dtype,String telno) throws SQLException {
		
		try{
			conn=connDAO.getMyConnection();
			conn.setAutoCommit(false);  
			CallableStatement stmtEnquiry = conn.prepareCall("{call enquiryDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			
			stmtEnquiry.setDate(1,sqlStartDate);
			stmtEnquiry.setString(2,clid);
			stmtEnquiry.setString(3,clname);
			stmtEnquiry.setString(4,address);
			stmtEnquiry.setString(5,mobile);
			stmtEnquiry.setInt(6,general);
			stmtEnquiry.setInt(7,client);
			stmtEnquiry.setString(8,remarks);
			stmtEnquiry.setString(9,clEmail);
			stmtEnquiry.setString(10,session.getAttribute("USERID").toString());
			stmtEnquiry.setString(11,session.getAttribute("BRANCHID").toString());
			stmtEnquiry.setString(12,Dtype.trim());
			stmtEnquiry.setString(13,telno);
			stmtEnquiry.setInt(14,docno);
			stmtEnquiry.setString(15,mode);
			stmtEnquiry.setInt(16,0);
			
			
			int aaa=stmtEnquiry.executeUpdate();
			docno=stmtEnquiry.getInt("docNo");
					
			 if(aaa<=0){
					
					return false;
					
				      }
			
			   String delsql="Delete from gl_enqd where rdocno="+docno+"  ";
			   stmtEnquiry.executeUpdate(delsql);
				for(int i=0;i< enqarray.size();i++){
			    	
				     String[] enqiury=enqarray.get(i).split("::");
				     if(!(enqiury[1].trim().equalsIgnoreCase("undefined")|| enqiury[1].trim().equalsIgnoreCase("NaN")||enqiury[1].trim().equalsIgnoreCase("")|| enqiury[1].isEmpty()))
				     {
				    	
			     String sql="INSERT INTO gl_enqd(SR_NO,BRDID,MODID,SPEC,CLRID,RTYPE,FRMDATE,TODATE,UNIT,RDOCNO)VALUES"
					       + " ("+(i+1)+","
					       + "'"+(enqiury[1].trim().equalsIgnoreCase("undefined") || enqiury[1].trim().equalsIgnoreCase("NaN")|| enqiury[1].trim().equalsIgnoreCase("")|| enqiury[1].isEmpty()?0:enqiury[1].trim())+"',"
					       + "'"+(enqiury[2].trim().equalsIgnoreCase("undefined") || enqiury[2].trim().equalsIgnoreCase("NaN")|| enqiury[2].trim().equalsIgnoreCase("")|| enqiury[2].isEmpty()?0:enqiury[2].trim())+"',"
					       + "'"+(enqiury[3].trim().equalsIgnoreCase("undefined") || enqiury[3].trim().equalsIgnoreCase("NaN")||enqiury[3].trim().equalsIgnoreCase("")|| enqiury[3].isEmpty()?0:enqiury[3].trim())+"',"
					       + "'"+(enqiury[4].trim().equalsIgnoreCase("undefined") || enqiury[4].trim().equalsIgnoreCase("NaN")||enqiury[4].trim().equalsIgnoreCase("")|| enqiury[4].isEmpty()?0:enqiury[4].trim())+"',"
					       + "'"+(enqiury[5].trim().equalsIgnoreCase("undefined") || enqiury[5].trim().equalsIgnoreCase("NaN")||enqiury[5].trim().equalsIgnoreCase("")|| enqiury[5].isEmpty()?0:enqiury[5].trim())+"',"
					       + "'"+(enqiury[6].trim().equalsIgnoreCase("undefined") || enqiury[6].trim().equalsIgnoreCase("NaN")||enqiury[6].trim().equalsIgnoreCase("")|| enqiury[6].isEmpty()?0:CommonDAO.changeStringtoSqlDate(enqiury[6].trim()))+"',"
					       + "'"+(enqiury[7].trim().equalsIgnoreCase("undefined") || enqiury[7].trim().equalsIgnoreCase("NaN")||enqiury[7].trim().equalsIgnoreCase("")|| enqiury[7].isEmpty()?0:CommonDAO.changeStringtoSqlDate(enqiury[7].trim()))+"',"
					       + "'"+(enqiury[8].trim().equalsIgnoreCase("undefined") || enqiury[8].trim().equalsIgnoreCase("NaN")||enqiury[8].trim().equalsIgnoreCase("")|| enqiury[8].isEmpty()?0:enqiury[8].trim())+"',"
					       +"'"+docno+"')";
			   
					     int resultSet2 = stmtEnquiry.executeUpdate (sql);
					     if(resultSet2<=0)
					 	{
					 		 conn.close();
					 		return false;
					 	}	
					     
				     }
					     
					     }
			 
		/*	for(int i=0;i<enqarray.size();i++){
		    	
			     String[] enqiury=enqarray.get(i).split("::");
			     System.out.println("sdf"+enqarray.get(i).split("::"));
			     if(!(enqiury[1].trim().equalsIgnoreCase("undefined")|| enqiury[1].trim().equalsIgnoreCase("NaN")||enqiury[1].trim().equalsIgnoreCase("")|| enqiury[1].isEmpty()))
			     {
			    	  RDOCNO,SR_NO,BRDID,MODID,SPEC,CLRID,UNIT,FRMDATE,TODATE,RTYPE
		     String sql="update  gl_enqd set SR_NO="+(i+1)+","
		     		   + "BRDID='"+(enqiury[1].trim().equalsIgnoreCase("undefined") || enqiury[1].trim().equalsIgnoreCase("NaN")|| enqiury[1].trim().equalsIgnoreCase("")|| enqiury[1].isEmpty()?0:enqiury[1].trim())+"',"
				       + "MODID='"+(enqiury[2].trim().equalsIgnoreCase("undefined") || enqiury[2].trim().equalsIgnoreCase("NaN")|| enqiury[2].trim().equalsIgnoreCase("")|| enqiury[2].isEmpty()?0:enqiury[2].trim())+"',"
				       + "SPEC='"+(enqiury[3].trim().equalsIgnoreCase("undefined") || enqiury[3].trim().equalsIgnoreCase("NaN")||enqiury[3].trim().equalsIgnoreCase("")|| enqiury[3].isEmpty()?0:enqiury[3].trim())+"',"
				       + "CLRID='"+(enqiury[4].trim().equalsIgnoreCase("undefined") || enqiury[4].trim().equalsIgnoreCase("NaN")||enqiury[4].trim().equalsIgnoreCase("")|| enqiury[4].isEmpty()?0:enqiury[4].trim())+"',"
				       + "RTYPE='"+(enqiury[5].trim().equalsIgnoreCase("undefined") || enqiury[5].trim().equalsIgnoreCase("NaN")||enqiury[5].trim().equalsIgnoreCase("")|| enqiury[5].isEmpty()?0:enqiury[5].trim())+"',"
				       + "FRMDATE='"+(enqiury[6].trim().equalsIgnoreCase("undefined") || enqiury[6].trim().equalsIgnoreCase("NaN")||enqiury[6].trim().equalsIgnoreCase("")|| enqiury[6].isEmpty()?0:ClsCommon.changeStringtoSqlDate(enqiury[6].trim()))+"',"
				       + "TODATE='"+(enqiury[7].trim().equalsIgnoreCase("undefined") || enqiury[7].trim().equalsIgnoreCase("NaN")||enqiury[7].trim().equalsIgnoreCase("")|| enqiury[7].isEmpty()?0:ClsCommon.changeStringtoSqlDate(enqiury[7].trim()))+"',"
				       + "UNIT='"+(enqiury[8].trim().equalsIgnoreCase("undefined") || enqiury[8].trim().equalsIgnoreCase("NaN")||enqiury[8].trim().equalsIgnoreCase("")|| enqiury[8].isEmpty()?0:enqiury[8].trim())+"' where rdocno="+docno+"";
		   
		     //System.out.println(""+sql);
		     int resultSet4 = stmtEnquiry.executeUpdate(sql);
		     if(resultSet4<=0)
             {
                 return false;
                } 
			     }
				     
				     }
			*/
						
			if (aaa > 0) {
				conn.commit();
				stmtEnquiry.close();
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
			 
			
			Statement stmt = conn.createStatement ();
			
			String upsql="select clstatus from gl_enqm where doc_no='"+docno+"' ";
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
					 
			
			
			
			
			CallableStatement stmtEnquiry = conn.prepareCall("{call enquiryDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmtEnquiry.setDate(1,null);
			stmtEnquiry.setString(2,null);
			stmtEnquiry.setString(3,null);
			stmtEnquiry.setString(4,null);
			stmtEnquiry.setString(5,null);
			stmtEnquiry.setInt(6,0);
			stmtEnquiry.setInt(7,0);
			stmtEnquiry.setString(8,null);
			stmtEnquiry.setString(9,null);
			stmtEnquiry.setString(10,session.getAttribute("USERID").toString());
			stmtEnquiry.setString(11,session.getAttribute("BRANCHID").toString());
			stmtEnquiry.setString(12,Dtype.trim());
			stmtEnquiry.setString(13,null);
			stmtEnquiry.setInt(14,docno);
			stmtEnquiry.setString(15,"D");
			stmtEnquiry.setInt(16,0);
			
			int aaa=stmtEnquiry.executeUpdate();
			
			
			
			if (aaa > 0) {
				
				stmtEnquiry.close();
				conn.close();
				System.out.println("Sucess");
				return 1;
			}	
		}catch(Exception e){
			conn.close();
		}
		return 0;
	}


	public   JSONArray searchrelode(String docno,HttpSession session) throws SQLException {

	    //JSONArray RESULTDATA=new JSONArray();

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
	    Connection conn = null;
		try {
				 conn = connDAO.getMyConnection();
				Statement stmtrelode = conn.createStatement ();
	        	
				String resql=("select eq.sr_no,eq.brdid,eq.modid,eq.spec specification,eq.clrid,eq.unit,eq.frmdate fromdate,eq.todate,DATE_FORMAT(frmdate,'%d.%m.%Y') AS"
						+ "    hidfromdate,DATE_FORMAT(todate,'%d.%m.%Y') AS hidtodate,eq.rtype renttype,vb.brand_name brand,vm.vtype model,vc.color color"
						+ "    FROM gl_enqd eq left join gl_vehbrand vb on vb.doc_no=eq.BRDID"
						+ "    left join gl_vehmodel vm on vm.doc_no=eq.MODID"
						+ "     left join my_color vc on vc.doc_no=eq.clrid  where eq.rdocno='"+docno+"' ");
				
				ResultSet resultSet = stmtrelode.executeQuery(resql);
				RESULTDATA=CommonDAO.convertToJSON(resultSet);
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
				Connection conn = viewDAO.getMyConnection();
				Statement stmtunit = conn.createStatement ();
	        	
				ResultSet resultSet = stmtunit.executeQuery ("select unit,doc_no from my_unitm where status<>7;");

				RESULTDATA=ClsCommon.convertToJSON(resultSet);
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

			RESULTDATA=CommonDAO.convertToJSON(resultSet);
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
public   List<ClsEnquiryBean> list4() throws SQLException {
    List<ClsEnquiryBean> list1Bean = new ArrayList<ClsEnquiryBean>();
    Connection conn = null;
	try {
			 conn = connDAO.getMyConnection();
			Statement stmt6 = conn.createStatement ();
			
		
			String tasql= ("select rentaltype from gl_tlistm where status=1;");
			//System.out.println("----------"+tasql);
			ResultSet resultSet5 = stmt6.executeQuery(tasql);
			while (resultSet5.next()) {
				
				ClsEnquiryBean bean = new ClsEnquiryBean();
				 
				bean.setRentaltype(resultSet5.getString("rentaltype"));
				
			
			
				
            	list1Bean.add(bean);
        	//System.out.println(list1Bean);
			}
			stmt6.close();
			conn.close();
	}
	catch(Exception e){
		conn.close();
		e.printStackTrace();
	}
    return list1Bean;
}




	public   JSONArray searchBrand() throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
		try {
				 conn = connDAO.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
            	
				ResultSet resultSet = stmtVeh.executeQuery ("select brand,brand_name,doc_no from gl_vehbrand where status<>7;");

				RESULTDATA=CommonDAO.convertToJSON(resultSet);
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
            	
				String modelsql= ("select vtype,doc_no from gl_vehmodel where brandid='"+brandval+"' and status<>7;");
				
				//System.out.println("========"+modelsql);
				
				ResultSet resultSet = stmtVeh3.executeQuery(modelsql)  ;
				RESULTDATA=CommonDAO.convertToJSON(resultSet);
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
	            	
					String clsql= ("select per_tel pertel,cldocno,refname,trim(address) address,per_mob,trim(mail1) mail1 from my_acbook where  dtype='CRM'  " +sqltest);
					//System.out.println("========"+clsql);
					ResultSet resultSet = stmtVeh1.executeQuery(clsql);
					
					RESULTDATA=CommonDAO.convertToJSON(resultSet);
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
		    	sqlStartDate = CommonDAO.changeStringtoSqlDate(enqdate);
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
		    		
		    		sqltest=sqltest+" and enqtype like '%"+enqtypeval+"%'";
		    	}
		    	 if(!(sqlStartDate==null)){
		    		sqltest=sqltest+" and date='"+sqlStartDate+"'";
		    	} 
		        
		    	
		    	 	    	
		    	 Connection conn = null;
		 
				try {
						 conn = connDAO.getMyConnection();
						Statement stmtenq1 = conn.createStatement ();
		            	
						String clssql= ("select telno,doc_no,voc_no,date,remarks,cldocno,name,com_add1,mob,email,enqtype from gl_enqm where status=3 and brhid="+brid+" " +sqltest);
						//System.out.println("========"+clssql);
						ResultSet resultSet = stmtenq1.executeQuery(clssql);
						
						RESULTDATA=CommonDAO.convertToJSON(resultSet);
						stmtenq1.close();
						conn.close();
				}
				catch(Exception e){
					conn.close();
					e.printStackTrace();
				}
				//System.out.println(RESULTDATA);
		        return RESULTDATA;
		    }

		  public   ClsEnquiryBean getPrint(int docno,HttpSession session) throws SQLException {
			  ClsEnquiryBean bean = new ClsEnquiryBean();
			//  String brhid=session.getAttribute("BRANCHID").toString();
			  Connection conn = null;
			try {
					 conn = connDAO.getMyConnection();
					Statement stmtprint = conn.createStatement ();
		        	
					String resql=("Select e.voc_no,DATE_FORMAT(e.date,'%d.%m.%Y') AS date,e.name,e.com_add1,e.mob,e.email,if(e.enqtype=1,'Client','General') enqtype from gl_enqm e where e.doc_no='"+docno+"'  ");
					
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
				    	    bean.setLbltypep(pintrs.getString("enqtype"));
				    	    bean.setDocvals(pintrs.getInt("voc_no"));
				       }
					

					stmtprint.close();
					
					
					
					 Statement stmtinvoice10 = conn.createStatement ();
					 /*   String  companysql="select b.branchname,c.company,c.address,c.tel,c.fax,l.loc_name location from gl_enqm r  "
					    		+ " left join my_brch b on r.brhid=b.doc_no left join my_locm l on l.brhid=b.doc_no "
					    		+ "left join my_comp c on b.cmpid=c.doc_no where r.doc_no="+docno+"  ";*/
					    String  companysql="select c.company,c.address,c.tel,c.fax,lc.loc_name location,b.branchname,b.pbno,b.stcno,b.cstno from gl_enqm r inner join my_brch b on  "
					    		+ "r.brhid=b.doc_no inner join my_comp c on b.cmpid=c.doc_no inner join my_locm l on l.brhid=b.doc_no inner join (select min(lo.loc) loc,lo.loc_name, "
					    		+ " lo.brhid from my_locm lo group by brhid) as lc on(lc.loc=l.loc and lc.brhid=b.doc_no) where r.doc_no='"+docno+"' ";
//System.out.println("--------"+companysql);
				         ResultSet resultsetcompany = stmtinvoice10.executeQuery(companysql); 
					       
					       while(resultsetcompany.next()){
					    	   
					    	   bean.setLblbranch(resultsetcompany.getString("branchname"));
					    	   bean.setLblcompname(resultsetcompany.getString("company"));
					    	  
					    	   bean.setLblcompaddress(resultsetcompany.getString("address"));
					    	 
					    	   bean.setLblcomptel(resultsetcompany.getString("tel"));
					    	  
					    	   bean.setLblcompfax(resultsetcompany.getString("fax"));
					    	   bean.setLbllocation(resultsetcompany.getString("location"));
					    	  
					    	   
					    	   bean.setLblcstno(resultsetcompany.getString("cstno"));
						    	  
					    	   bean.setLblservicetax(resultsetcompany.getString("stcno"));
					    	   bean.setLblpan(resultsetcompany.getString("pbno"));
					    	  
					    	 
					    	  // setLblcstno setLblservicetax setLblpan
					    	   
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
			public   ArrayList<String> getPrintdetails(int docno,HttpSession session) throws SQLException {
				ArrayList<String> arr=new ArrayList<String>();
				Connection conn = null;
				// String brhid=session.getAttribute("BRANCHID").toString();
				try {
					 conn = connDAO.getMyConnection();
					Statement stmtinvoice = conn.createStatement ();
					String strSqldetail="";
				strSqldetail="select eq.sr_no,eq.spec,if(eq.unit>0,round(eq.unit),'') unit,DATE_FORMAT(frmdate,'%d.%m.%Y') AS fromdate,DATE_FORMAT(todate,'%d.%m.%Y') AS todate, "
						+ "if(eq.rtype='0','',eq.rtype) rtype,vb.brand_name brand,coalesce(vm.vtype,'') model,coalesce(vc.color,'') color     FROM gl_enqd eq left join gl_vehbrand vb on vb.doc_no=eq.BRDID "
						+ "	  left join gl_vehmodel vm on vm.doc_no=eq.MODID   left join my_color vc on vc.doc_no=eq.clrid  where eq.rdocno='"+docno+"' ";
				
		
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
						temp=rowcount+"::"+rsdetail.getString("brand")+"::"+rsdetail.getString("model")+"::"+spci+"::"+rsdetail.getString("color")+"::"+rsdetail.getString("rtype")+"::"+rsdetail.getString("fromdate")+"::"+rsdetail.getString("todate")+"::"+rsdetail.getString("unit") ;
	
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
}
