package com.operations.vehicleprocurement.purchaserequest;

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

import com.common.ClsCommon;
import com.connection.ClsConnection;



public class ClsvehpurchasereqDAO{
	
	
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	
	Connection conn;
		
	
	public int insert(Date sqlStartDate, Date sqlpurdeldate, String cmbreftype,
			String purdesc, HttpSession session, String mode,
			String formdetailcode,ArrayList<String> descarray, HttpServletRequest request)  throws SQLException {
		
		try{
			int docno;
		
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			CallableStatement stmtpurreq= conn.prepareCall("{call vahpurchaseReqDML(?,?,?,?,?,?,?,?,?,?)}");
			stmtpurreq.registerOutParameter(8, java.sql.Types.INTEGER);
			stmtpurreq.registerOutParameter(10, java.sql.Types.INTEGER);
			stmtpurreq.setDate(1,sqlStartDate);
			stmtpurreq.setString(2,cmbreftype);
			stmtpurreq.setString(3,purdesc);
			stmtpurreq.setString(4,formdetailcode);
			stmtpurreq.setDate(5,sqlpurdeldate);
			stmtpurreq.setString(6,session.getAttribute("USERID").toString());
			stmtpurreq.setString(7,session.getAttribute("BRANCHID").toString());
			stmtpurreq.setString(9,mode);
			stmtpurreq.executeQuery();
			docno=stmtpurreq.getInt("docNo");
			int vocno=stmtpurreq.getInt("vocNo");	
			request.setAttribute("vocno", vocno);
			if(docno<=0)
			{
				conn.close();
				return 0;
				
				
			}
			
			//System.out.println("sssssss"+session.getAttribute("USERID").toString());
			for(int i=0;i< descarray.size();i++){
		    	
			     String[] vehpurreqarray=descarray.get(i).split("::");
			     if(!(vehpurreqarray[1].trim().equalsIgnoreCase("undefined")|| vehpurreqarray[1].trim().equalsIgnoreCase("NaN")||vehpurreqarray[1].trim().equalsIgnoreCase("")|| vehpurreqarray[1].isEmpty()))
			     {
			    	 
		     String sql="INSERT INTO gl_vprd(srno,brdid,modid,spec,clrid,qty,remarks,rdocno)VALUES"
				       + " ("+(i+1)+","
				       + "'"+(vehpurreqarray[1].trim().equalsIgnoreCase("undefined") || vehpurreqarray[1].trim().equalsIgnoreCase("NaN")|| vehpurreqarray[1].trim().equalsIgnoreCase("")|| vehpurreqarray[1].isEmpty()?0:vehpurreqarray[1].trim())+"',"
				       + "'"+(vehpurreqarray[2].trim().equalsIgnoreCase("undefined") || vehpurreqarray[2].trim().equalsIgnoreCase("NaN")|| vehpurreqarray[2].trim().equalsIgnoreCase("")|| vehpurreqarray[2].isEmpty()?0:vehpurreqarray[2].trim())+"',"
				       + "'"+(vehpurreqarray[3].trim().equalsIgnoreCase("undefined") || vehpurreqarray[3].trim().equalsIgnoreCase("NaN")||vehpurreqarray[3].trim().equalsIgnoreCase("")|| vehpurreqarray[3].isEmpty()?0:vehpurreqarray[3].trim())+"',"
				       + "'"+(vehpurreqarray[4].trim().equalsIgnoreCase("undefined") || vehpurreqarray[4].trim().equalsIgnoreCase("NaN")||vehpurreqarray[4].trim().equalsIgnoreCase("")|| vehpurreqarray[4].isEmpty()?0:vehpurreqarray[4].trim())+"',"
				       + "'"+(vehpurreqarray[5].trim().equalsIgnoreCase("undefined") || vehpurreqarray[5].trim().equalsIgnoreCase("NaN")||vehpurreqarray[5].trim().equalsIgnoreCase("")|| vehpurreqarray[5].isEmpty()?0:vehpurreqarray[5].trim())+"',"
				       + "'"+(vehpurreqarray[6].trim().equalsIgnoreCase("undefined") || vehpurreqarray[6].trim().equalsIgnoreCase("NaN")||vehpurreqarray[6].trim().equalsIgnoreCase("")|| vehpurreqarray[6].isEmpty()?0:vehpurreqarray[6].trim())+"',"
				       +"'"+docno+"')";
		 
				     int resultSet2 = stmtpurreq.executeUpdate(sql);
				    
				 	if(resultSet2<=0)
					{
						conn.close();
						return 0;
						
						
					}
			     }
				     
				     }
		//	System.out.println("sssssss"+docno);
			if (docno > 0) {
				conn.commit();
				stmtpurreq.close();
				conn.close();
				return docno;
			}
		}catch(Exception e){	
			conn.close();
		e.printStackTrace();	
		}
		return 0;
	   }
	


	public boolean edit(int docno, Date sqlStartDate, Date sqlpurdeldate,
			String cmbreftype, String purdesc, HttpSession session,
			String mode, String formdetailcode ,ArrayList<String> descarray) throws SQLException {
		
		try{
			
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			CallableStatement stmtpurreq= conn.prepareCall("{call vahpurchaseReqDML(?,?,?,?,?,?,?,?,?,?)}");
			stmtpurreq.setDate(1,sqlStartDate);
			stmtpurreq.setString(2,cmbreftype);
			stmtpurreq.setString(3,purdesc);
			stmtpurreq.setString(4,formdetailcode);
			stmtpurreq.setDate(5,sqlpurdeldate);
			stmtpurreq.setString(6,session.getAttribute("USERID").toString());
			stmtpurreq.setString(7,session.getAttribute("BRANCHID").toString());
			stmtpurreq.setInt(8,docno);
			stmtpurreq.setString(9,"E");
			stmtpurreq.setInt(10,0);
			
			int aaa=stmtpurreq.executeUpdate();
			docno=stmtpurreq.getInt("docNo");
					
			if(aaa<=0)
			{
				conn.close();
				return false;
				
				
			}
			
			
			
			  String delsql="Delete from gl_vprd where rdocno="+docno+" ";
			  stmtpurreq.executeUpdate(delsql);
		//	System.out.println("aaaaaaaaaaaaaaaaa"+aaa);
			for(int i=0;i<descarray.size();i++){
		    	
			     String[] vehpurreqarray=descarray.get(i).split("::");
			    
			     if(!(vehpurreqarray[1].trim().equalsIgnoreCase("undefined")|| vehpurreqarray[1].trim().equalsIgnoreCase("NaN")||vehpurreqarray[1].trim().equalsIgnoreCase("")|| vehpurreqarray[1].isEmpty()))
			     {
			    	 
			    	 
			    	  String sql="INSERT INTO gl_vprd(srno,brdid,modid,spec,clrid,qty,remarks,rdocno)VALUES"
						       + " ("+(i+1)+","
						       + "'"+(vehpurreqarray[1].trim().equalsIgnoreCase("undefined") || vehpurreqarray[1].trim().equalsIgnoreCase("NaN")|| vehpurreqarray[1].trim().equalsIgnoreCase("")|| vehpurreqarray[1].isEmpty()?0:vehpurreqarray[1].trim())+"',"
						       + "'"+(vehpurreqarray[2].trim().equalsIgnoreCase("undefined") || vehpurreqarray[2].trim().equalsIgnoreCase("NaN")|| vehpurreqarray[2].trim().equalsIgnoreCase("")|| vehpurreqarray[2].isEmpty()?0:vehpurreqarray[2].trim())+"',"
						       + "'"+(vehpurreqarray[3].trim().equalsIgnoreCase("undefined") || vehpurreqarray[3].trim().equalsIgnoreCase("NaN")||vehpurreqarray[3].trim().equalsIgnoreCase("")|| vehpurreqarray[3].isEmpty()?0:vehpurreqarray[3].trim())+"',"
						       + "'"+(vehpurreqarray[4].trim().equalsIgnoreCase("undefined") || vehpurreqarray[4].trim().equalsIgnoreCase("NaN")||vehpurreqarray[4].trim().equalsIgnoreCase("")|| vehpurreqarray[4].isEmpty()?0:vehpurreqarray[4].trim())+"',"
						       + "'"+(vehpurreqarray[5].trim().equalsIgnoreCase("undefined") || vehpurreqarray[5].trim().equalsIgnoreCase("NaN")||vehpurreqarray[5].trim().equalsIgnoreCase("")|| vehpurreqarray[5].isEmpty()?0:vehpurreqarray[5].trim())+"',"
						       + "'"+(vehpurreqarray[6].trim().equalsIgnoreCase("undefined") || vehpurreqarray[6].trim().equalsIgnoreCase("NaN")||vehpurreqarray[6].trim().equalsIgnoreCase("")|| vehpurreqarray[6].isEmpty()?0:vehpurreqarray[6].trim())+"',"
						       +"'"+docno+"')";
			    	 
		/*     String sql="update  gl_vprd set srno="+(i+1)+","
		     		   + "brdid='"+(vehpurreqarray[1].trim().equalsIgnoreCase("undefined") || vehpurreqarray[1].trim().equalsIgnoreCase("NaN")|| vehpurreqarray[1].trim().equalsIgnoreCase("")|| vehpurreqarray[1].isEmpty()?0:vehpurreqarray[1].trim())+"',"
				       + "modid='"+(vehpurreqarray[2].trim().equalsIgnoreCase("undefined") || vehpurreqarray[2].trim().equalsIgnoreCase("NaN")|| vehpurreqarray[2].trim().equalsIgnoreCase("")|| vehpurreqarray[2].isEmpty()?0:vehpurreqarray[2].trim())+"',"
				       + "spec='"+(vehpurreqarray[3].trim().equalsIgnoreCase("undefined") || vehpurreqarray[3].trim().equalsIgnoreCase("NaN")||vehpurreqarray[3].trim().equalsIgnoreCase("")|| vehpurreqarray[3].isEmpty()?0:vehpurreqarray[3].trim())+"',"
				       + "clrid='"+(vehpurreqarray[4].trim().equalsIgnoreCase("undefined") || vehpurreqarray[4].trim().equalsIgnoreCase("NaN")||vehpurreqarray[4].trim().equalsIgnoreCase("")|| vehpurreqarray[4].isEmpty()?0:vehpurreqarray[4].trim())+"',"
				       + "qty='"+(vehpurreqarray[5].trim().equalsIgnoreCase("undefined") || vehpurreqarray[5].trim().equalsIgnoreCase("NaN")||vehpurreqarray[5].trim().equalsIgnoreCase("")|| vehpurreqarray[5].isEmpty()?0:vehpurreqarray[5].trim())+"',"
				       + "remarks='"+(vehpurreqarray[6].trim().equalsIgnoreCase("undefined") || vehpurreqarray[6].trim().equalsIgnoreCase("NaN")||vehpurreqarray[6].trim().equalsIgnoreCase("")|| vehpurreqarray[6].isEmpty()?0:vehpurreqarray[6].trim())+"' where rdocno="+docno+"";
		    */
		     int resultSet4 = stmtpurreq.executeUpdate(sql);
				   
		     if(resultSet4<=0)
				{
					conn.close();
					return false;
					
					
				}
		     
		     
			     }
				     
				     }
			
						
			if (aaa > 0) {
				conn.commit();
				stmtpurreq.close();
				conn.close();
				System.out.println("Sucess");
				return true;
			}
		}catch(Exception e){
			conn.close();
		}
		return false;
	}

	public boolean delete(int docno, HttpSession session, String mode,
			String formdetailcode)  throws SQLException {
		try{
			conn=ClsConnection.getMyConnection();
			//conn.setAutoCommit(false);
			CallableStatement stmtpurreq= conn.prepareCall("{call vahpurchaseReqDML(?,?,?,?,?,?,?,?,?,?)}");
		
			stmtpurreq.setDate(1,null);
			stmtpurreq.setString(2,null);
			stmtpurreq.setString(3,null);
			stmtpurreq.setString(4,null);
			stmtpurreq.setDate(5,null);
			stmtpurreq.setString(6,session.getAttribute("USERID").toString());
			stmtpurreq.setString(7,session.getAttribute("BRANCHID").toString());
			stmtpurreq.setInt(8,docno);
			stmtpurreq.setString(9,"D");
			stmtpurreq.setInt(10,0);
			int aaa=stmtpurreq.executeUpdate();
			
			
		
			if (aaa > 0) {
				//conn.commit();
				stmtpurreq.close();
				conn.close();
				System.out.println("Sucess");
				return true;
			}	
		}catch(Exception e){
			conn.close();
		}
		return false;
	}
	
	public  JSONArray searchBrand() throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
            	
				ResultSet resultSet = stmtVeh.executeQuery ("select brand,brand_name,doc_no from gl_vehbrand where status<>7;");

				RESULTDATA=ClsCommon.convertToJSON(resultSet);
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
	public  JSONArray searchColor() throws SQLException {

	    JSONArray RESULTDATA=new JSONArray();
	    
        Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVehclr = conn.createStatement ();
	        	
				ResultSet resultSet = stmtVehclr.executeQuery ("select  doc_no,color color1  from my_color  where status<>7 order by  doc_no;");

				RESULTDATA=ClsCommon.convertToJSON(resultSet);
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
	public  JSONArray searchModel(String brandval) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh3 = conn.createStatement ();
            	
				String modelsql= ("select vtype,doc_no from gl_vehmodel where brandid="+brandval+" and status<>7;");
				
				//System.out.println("========"+modelsql);
				
				ResultSet resultSet = stmtVeh3.executeQuery(modelsql)  ;
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
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
	public  JSONArray SearchMasters(HttpSession session) throws SQLException {


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
   

	
		
        Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtmain = conn.createStatement ();
	        	String pySql=("  select voc_no,doc_no,date,type,expdeldt,desc1 from gl_vprm  where status=3 and brhid='"+brcid+"'" );
	        	//System.out.println("======pySql=="+pySql);
				ResultSet resultSet = stmtmain.executeQuery(pySql);

				RESULTDATA=ClsCommon.convertToJSON(resultSet); 
				stmtmain.close();
				conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
	//	System.out.println(RESULTDATA);
	    return RESULTDATA;
	}

	public  JSONArray searchrelode(String docno) throws SQLException {

	    JSONArray RESULTDATA=new JSONArray();
	    
        Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtrelode = conn.createStatement ();
	        	
				String resql=("select rq.srno,rq.brdid,rq.modid,rq.spec specification,rq.clrid,rq.qty,rq.remarks , "
						+ "vb.brand_name brand,vm.vtype model,vc.color color "
						+ " from gl_vprd rq left join gl_vehbrand vb on vb.doc_no=rq.BRDID "
						+ "	   left join gl_vehmodel vm on vm.doc_no=rq.MODID "
						+ " left join my_color vc on vc.doc_no=rq.clrid  where rq.clstatus=0 and rq.rdocno='"+docno+"' ");
				
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
	
	
	//gl_vprd(srno,brdid,modid,spec,clrid,qty,remarks,rdocno)VALUES"
	
	 public  ClsvehpurchasereqBean getPrint(int docno) throws SQLException {
		 ClsvehpurchasereqBean bean = new ClsvehpurchasereqBean();
		  Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtprint = conn.createStatement ();
	        	
				String resql=("select voc_no,doc_no,DATE_FORMAT(date,'%d.%m.%Y') AS date,type,DATE_FORMAT(expdeldt,'%d.%m.%Y') AS expdeldt,desc1 from gl_vprm where doc_no='"+docno+"'");
				
				ResultSet pintrs = stmtprint.executeQuery(resql);
				
			     
			       while(pintrs.next()){
			    	   // cldatails
			    	   
			    	  /* setLblclient setLblclientaddress setLblmob setLblemail setLbldate setLbltypep setDocvals*/
			    	   
			    	   
			    	    bean.setLbldoc(pintrs.getInt("voc_no"));
			    	    bean.setLbldate(pintrs.getString("date"));
			    	    bean.setLbltype(pintrs.getString("type"));
			    	    bean.setLbldesc1(pintrs.getString("desc1"));
			    	    bean.setExpdeldate(pintrs.getString("expdeldt"));
			    	  
			       }
				

				stmtprint.close();
				
				
				
				 Statement stmtinvoice10 = conn.createStatement ();
				    String  companysql="select b.branchname,c.company,c.address,c.tel,c.fax,l.loc_name location from gl_vprm r  "
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
		public  ArrayList<String> getPrintdetails(int docno) throws SQLException {
			ArrayList<String> arr=new ArrayList<String>();
			Connection conn = null;
			try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtinvoice = conn.createStatement ();
				String strSqldetail="";
			strSqldetail="select rq.srno,rq.brdid,rq.modid,rq.spec,rq.clrid,round(rq.qty) qty,rq.remarks , "
						+ "vb.brand_name brand,vm.vtype model,vc.color color "
						+ " from gl_vprd rq left join gl_vehbrand vb on vb.doc_no=rq.BRDID "
						+ "	   left join gl_vehmodel vm on vm.doc_no=rq.MODID "
						+ " left join my_color vc on vc.doc_no=rq.clrid  where rq.clstatus=0 and rq.rdocno='"+docno+"'";
			
	
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
					temp=rowcount+"::"+rsdetail.getString("brand")+"::"+rsdetail.getString("model")+"::"+spci+"::"+rsdetail.getString("color")+"::"+rsdetail.getString("qty")+"::"+rsdetail.getString("remarks") ;

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
