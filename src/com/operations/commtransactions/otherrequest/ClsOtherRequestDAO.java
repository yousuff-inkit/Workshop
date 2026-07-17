package com.operations.commtransactions.otherrequest;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsOtherRequestDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	ClsOtherRequestBean otherRequestBean = new ClsOtherRequestBean();
	
	
	public int insert(String formdetailcode, String branch, Date otherRequestDate,String txtrefno, int txtclientdocno, String cmbratype, int txtrano, String adddriverintickval,String txtremarks, String txtdescription,
			double txtamount,ArrayList<String> otherrequestarray,ArrayList<String> driverarray,HttpSession session, String mode) throws SQLException {
		  
		Connection conn = null;
		
		try{
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			
			String userid=session.getAttribute("USERID").toString().trim();
			
			if(adddriverintickval.equalsIgnoreCase("")){
				adddriverintickval="0";
			}
			
			CallableStatement stmtORQ = conn.prepareCall("{CALL otherRequestDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			
			stmtORQ.registerOutParameter(13, java.sql.Types.INTEGER);
			stmtORQ.setDate(1,otherRequestDate);
			stmtORQ.setString(2,txtrefno);
			stmtORQ.setInt(3,txtclientdocno);
			stmtORQ.setString(4,adddriverintickval);
			stmtORQ.setString(5,txtdescription);
			stmtORQ.setString(6,txtremarks);
			stmtORQ.setDouble(7,txtamount);
			stmtORQ.setString(8,cmbratype);
			stmtORQ.setInt(9,txtrano);
			stmtORQ.setString(10,formdetailcode);
			stmtORQ.setString(11,branch);
			stmtORQ.setString(12,userid);
			stmtORQ.setString(14,mode);
			int datas=stmtORQ.executeUpdate();
			if(datas<=0){
				stmtORQ.close();
				conn.close();
				return 0;
			}
			int docno=stmtORQ.getInt("docNo");
			otherRequestBean.setTxtotherrequestdocno(docno);
			if (docno > 0) {
				
				/*Insertion to gl_othreqd,gl_othreqdr*/
				int insertData=insertion(conn, docno, txtclientdocno, cmbratype, txtrano, adddriverintickval, otherrequestarray, driverarray, branch);
				if(insertData<=0){
					stmtORQ.close();
					conn.close();
					return 0;
				}
				/*Insertion to gl_othreqd,gl_othreqdr Ends*/
				
				conn.commit();
				stmtORQ.close();
				conn.close();
				return docno;
			}
		stmtORQ.close();
		conn.close();
	 }catch(Exception e){	
		 	e.printStackTrace();	
		 	conn.close();
		 	return 0;
	 }finally{
		 conn.close();
	 }
		return 0;
	}
			
	
	public int edit(String formdetailcode, String branch, int txtotherrequestdocno,Date otherRequestDate, String txtrefno, int txtclientdocno,String cmbratype, int txtrano, String adddriverintickval, String txtremarks,
			String txtdescription, double txtamount, ArrayList<String> otherrequestarray, ArrayList<String> driverarray, HttpSession session,String mode) throws SQLException {
		
		Connection conn = null;
		
		try{
				conn=ClsConnection.getMyConnection();
				conn.setAutoCommit(false);
				Statement stmtORQ1 = conn.createStatement();
				
				String userid=session.getAttribute("USERID").toString().trim();
				
				String sql1="select invno from gl_othreq where brhid="+branch+" and doc_no="+txtotherrequestdocno+"";
				ResultSet resultSet1 = stmtORQ1.executeQuery(sql1);	
			    
				int invno=0;
				while (resultSet1.next()) {
					invno=resultSet1.getInt("invno");
				}	
				
				if(invno==0){
					
			    CallableStatement stmtORQ = conn.prepareCall("{CALL otherRequestDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				
				stmtORQ.setInt(13,txtotherrequestdocno);
				stmtORQ.setDate(1,otherRequestDate);
				stmtORQ.setString(2,txtrefno);
				stmtORQ.setInt(3,txtclientdocno);
				stmtORQ.setString(4,adddriverintickval);
				stmtORQ.setString(5,txtdescription);
				stmtORQ.setString(6,txtremarks);
				stmtORQ.setDouble(7,txtamount);
				stmtORQ.setString(8,cmbratype);
				stmtORQ.setInt(9,txtrano);
				stmtORQ.setString(10,formdetailcode);
				stmtORQ.setString(11,branch);
				stmtORQ.setString(12,userid);
				stmtORQ.setString(14,mode);
				int datas=stmtORQ.executeUpdate();
				if(datas<=0){
					stmtORQ.close();
					conn.close();
					return 0;
				}
				int docno=txtotherrequestdocno;
				otherRequestBean.setTxtotherrequestdocno(docno);
				if (docno > 0) {
					
					String sql="DELETE FROM gl_othreqd WHERE brhid="+branch+" and rdocno="+docno+"";
					int data = stmtORQ.executeUpdate(sql);
					
					/*Insertion to gl_othreqd,gl_othreqdr*/
					int insertData=insertion(conn, docno, txtclientdocno, cmbratype, txtrano, adddriverintickval, otherrequestarray, driverarray, branch);
					if(insertData<=0){
						stmtORQ.close();
						conn.close();
						return 0;
					}
					/*Insertion to gl_othreqd,gl_othreqdr Ends*/
					
					conn.commit();
					stmtORQ.close();
					conn.close();
					return 1;
				}
			stmtORQ.close();
		    }
			stmtORQ1.close();
			conn.close();
		 }catch(Exception e){	
			 	e.printStackTrace();	
			 	 conn.close();
			 	return 0;
		 }finally{
			 conn.close();
		 }
			return 0;
		}

	public int delete(String branch, int txtotherrequestdocno, String formdetailcode,HttpSession session,String mode) throws SQLException {
		
		Connection conn = null;
		
		try{
				conn=ClsConnection.getMyConnection();
				conn.setAutoCommit(false);
				Statement stmtORQ = conn.createStatement();
				
				String userid=session.getAttribute("USERID").toString().trim();
				 
				String sql1="select invno from gl_othreq where brhid="+branch+" and doc_no="+txtotherrequestdocno+"";
				ResultSet resultSet1 = stmtORQ.executeQuery(sql1);	
			    
				int invno=0;
				while (resultSet1.next()) {
					invno=resultSet1.getInt("invno");
				}	
				
				if(invno==0){
					/*Status change in gl_othreq*/
					 String sql=("update gl_othreq set status=7 where brhid="+branch+" and doc_no="+txtotherrequestdocno+"");
					 int data = stmtORQ.executeUpdate(sql);
					 if(data<=0){
						    stmtORQ.close();
			    			conn.close();
			    			return 0;
			            }
					/*Status change in gl_othreq Ends*/
					 
					 /*Inserting into datalog*/
					 String sqls=("insert into datalog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+txtotherrequestdocno+"','"+branch+"','"+formdetailcode+"',now(),'"+userid+"','"+mode+"')");
					 int datas = stmtORQ.executeUpdate(sqls);
					 /*Inserting into datalog Ends*/
				}
				else if(invno>0){
					return -1;
				}
				
				 int docno=txtotherrequestdocno;
				 otherRequestBean.setTxtotherrequestdocno(docno);
				if (docno > 0) {
					conn.commit();
					stmtORQ.close();
				    conn.close();
					return 1;
				}
			stmtORQ.close();
			conn.close();
		 }catch(Exception e){
			 	e.printStackTrace();
			 	conn.close();
			 	return 0;
		 }finally{
			 conn.close();
		 }
				return 0;
	    }

	
	public  JSONArray clientDetailsSearch() throws SQLException {
        List<ClsOtherRequestBean> clientDetailsSearchBean = new ArrayList<ClsOtherRequestBean>();
        
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtORQ = conn.createStatement();
            	
				ResultSet resultSet = stmtORQ.executeQuery ("select t.account,t.description,c.cldocno from my_acbook c left join  my_head t on t.doc_no=c.acno where "
						+ "t.atype='AR'");

				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtORQ.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	public  JSONArray otherRequestGridReloading(String docNo,HttpSession session) throws SQLException {
        List<ClsOtherRequestBean> otherRequestGridReloadingBean = new ArrayList<ClsOtherRequestBean>();    
        
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;

        try {
				conn = ClsConnection.getMyConnection();
				Statement stmtORQ = conn.createStatement();
				String mainHeaderBranch=session.getAttribute("BRANCHID").toString().trim();
				
				String sqlnew=("select type,if(remarks='0',' ',remarks) remarks,round(amount,2) amount,type_id typeid from gl_othreqd where sr_no>0 and brhid='"+mainHeaderBranch+"' and rdocno="+docNo+"");
				ResultSet resultSet = stmtORQ.executeQuery (sqlnew);
                
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtORQ.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
		return RESULTDATA;
    }
	
	public  JSONArray clientDriverSearch(String clientid,String rentaltype,String aggno) throws SQLException {

		  JSONArray RESULTDATA=new JSONArray();
		         
		  Connection conn=null;
		     
		  try {
		       conn = ClsConnection.getMyConnection();
		       Statement stmtORQ = conn.createStatement();
		       
		       String sqltest="";
			     
			   if(rentaltype.equalsIgnoreCase("RAG")){
			    	 sqltest+="  gl_rdriver"; 
			   }
			   
			   else if(rentaltype.equalsIgnoreCase("LAG")){
			    	 sqltest+=" gl_ldriver";
			   }
		              
		       ResultSet resultSet = stmtORQ.executeQuery("SELECT d.dr_id,d.doc_no,d.name,d.dob,d.nation,d.mobno,d.dlno,d.issdate,d.led,d.ltype,d.issfrm,d.passport_no,"
		       	 + "d.pass_exp,d.visano,d.visa_exp,d.hcdlno,d.hcissdate,d.hcled ,d.cldocno,DATE_FORMAT(FROM_DAYS(DATEDIFF(CURRENT_DATE,d.dob)),'%y ') AS age,"
		       	 + "DATE_FORMAT(FROM_DAYS(DATEDIFF(CURRENT_DATE,d.issdate)),'%y ') AS expiryear,(select value from gl_config where field_nme='drage') drage ,"
		       	 + "(select value from gl_config where field_nme='licyr') licyr FROM gl_drdetails d WHERE d.cldocno="+clientid+" and d.dr_id not in (select drid from "+sqltest+" where rdocno="+aggno+")");
		       
		      RESULTDATA=ClsCommon.convertToJSON(resultSet);
		      
		      stmtORQ.close();
		      conn.close();
		   }
		   catch(Exception e){
		     e.printStackTrace();
		     conn.close();
		   }
		         return RESULTDATA;
		 }
	
	public  JSONArray extraServiceGridSearch() throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtCRM = conn.createStatement();
            	
				ResultSet resultSet = stmtCRM.executeQuery ("select doc_no,description from gl_extraservices where status=1");

				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtCRM.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	public  JSONArray nationGridSearch() throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtCRM = conn.createStatement();
            	
				ResultSet resultSet = stmtCRM.executeQuery ("SELECT nation FROM my_natm order by nation");

				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtCRM.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
    
    public  JSONArray stateGridSearch() throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtCRM = conn.createStatement();
            	
				ResultSet resultSet = stmtCRM.executeQuery ("select state from my_uaestatesm order by state");

				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtCRM.close();
				conn.close();

		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	public  JSONArray driverGridReloading(String docNo,String cldocno,HttpSession session) throws SQLException {
        
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtCRM = conn.createStatement();
				String branch=session.getAttribute("BRANCHID").toString().trim();
				
				ResultSet resultSet = stmtCRM.executeQuery ("select d.doc_no,d.dr_id,d.name,d.dob,DATE_FORMAT(d.dob,'%d.%m.%Y') AS hiddob,d.nation as nation1,d.mobno,d.passport_no,d.pass_exp,"
					+ "DATE_FORMAT(d.pass_exp,'%d.%m.%Y') AS hidpassexp,d.dlno,d.issdate,DATE_FORMAT(d.issdate,'%d.%m.%Y') AS hidissdate,d.issfrm,d.led,DATE_FORMAT(d.led,'%d.%m.%Y') AS hidled,"
					+ "d.ltype,d.visano,d.visa_exp,DATE_FORMAT(d.visa_exp,'%d.%m.%Y') AS hidvisaexp FROM gl_othreqdr dr left join gl_drdetails d on d.dr_id=dr.drid and d.dtype='CRM' where "
					+ "dr.cldocno="+cldocno+" and dr.brhid="+branch+" and dr.rdocno="+docNo+"");
				
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtCRM.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
		return RESULTDATA;
    }
	
	public  JSONArray agreementSearch(String sclname,String smob,String rno,String flno,String sregno,String rentaltype,String clientId) throws SQLException {

	     JSONArray RESULTDATA=new JSONArray();
	     String sqltest="";
	     
	     if(rentaltype.equalsIgnoreCase("RAG")){
	         if(!(sclname.equalsIgnoreCase(""))){
	          sqltest+=" and a.RefName like '%"+sclname+"%'";
	         }
	         if(!(smob.equalsIgnoreCase(""))){
	          sqltest+=" and a.per_mob like '%"+smob+"%'";
	         }
	         if(!(rno.equalsIgnoreCase(""))){
	          sqltest+=" and r.voc_no like '%"+rno+"%'";
	         }
	         if(!(flno.equalsIgnoreCase(""))){
	          sqltest+=" and r.fleet_no like '%"+flno+"%'";
	         }
	         if(!(sregno.equalsIgnoreCase(""))){
	          sqltest+=" and v.reg_no like '%"+sregno+"%'";
	         }
	     }
	     
	     else if(rentaltype.equalsIgnoreCase("LAG")){
	         if(!(sclname.equalsIgnoreCase(""))){
	          sqltest+=" and a.RefName like '%"+sclname+"%'";
	         }
	         if(!(smob.equalsIgnoreCase(""))){
	          sqltest+=" and a.per_mob like '%"+smob+"%'";
	         }
	         if(!(rno.equalsIgnoreCase(""))){
	          sqltest+=" and l.voc_no like '%"+rno+"%'";
	         }
	         if(!(flno.equalsIgnoreCase(""))){
	          sqltest+=" and (l.tmpfleet like '%"+flno+"%' or l.perfleet like '%"+flno+"%')";
	         }
	         if(!(sregno.equalsIgnoreCase(""))){
	          sqltest+=" and v.reg_no like '%"+sregno+"%'";
	         }
	     }
	     
	     Connection conn=null;
	     
	  try {
		    conn = ClsConnection.getMyConnection();
		    Statement stmtRRV = conn.createStatement();
		    
		    if(rentaltype.equalsIgnoreCase("RAG")){
			    
		    	String sql=("select r.voc_no,r.doc_no,r.fleet_no,a.RefName,a.per_mob,v.reg_no from gl_ragmt r left join gl_vehmaster v on v.fleet_no=r.fleet_no "
			      + " left join my_acbook a on a.cldocno= r.cldocno and a.dtype='CRM'where r.cldocno="+clientId+""+sqltest+" group by doc_no");
		    
		    ResultSet resultSet = stmtRRV.executeQuery(sql);
		    RESULTDATA=ClsCommon.convertToJSON(resultSet);
		    
		    stmtRRV.close();
		    conn.close();
		    }
		    
		    else if(rentaltype.equalsIgnoreCase("LAG")){
			     
		    	String sql=("select l.voc_no,l.doc_no,if(l.perfleet=0,l.tmpfleet,l.perfleet) fleet_no,a.RefName,a.per_mob,v.reg_no from gl_lagmt l left join gl_vehmaster v on v.fleet_no=if(l.perfleet=0,l.tmpfleet,l.perfleet)  "
			       + " left join my_acbook a on a.cldocno= l.cldocno and a.dtype='CRM' where l.cldocno="+clientId+""+sqltest+" group by doc_no"); 
		     
		     ResultSet resultSet = stmtRRV.executeQuery(sql);
		     RESULTDATA=ClsCommon.convertToJSON(resultSet);
		     
		     stmtRRV.close();
		     conn.close();
	       }
		 stmtRRV.close();
		 conn.close(); 
	  }
	  catch(Exception e){
		   e.printStackTrace();
		   conn.close();
	  }finally{
		  conn.close();
	  }
       return RESULTDATA;
   }
	
	public  JSONArray oreMainSearch(String branch,String partyname,String docNo,String date,String ratype,String raNo) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
           
        java.sql.Date sqlRequestDate=null;
        
        date.trim();
        if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0")))
        {
        	sqlRequestDate = ClsCommon.changeStringtoSqlDate(date);
        }

        String sqltest="";
        
        if(!(docNo.equalsIgnoreCase(""))){
            sqltest=sqltest+" and o.doc_no like '%"+docNo+"%'";
        }
        if(!(partyname.equalsIgnoreCase(""))){
         sqltest=sqltest+" and c.refname like '%"+partyname+"%'";
        }
        if(!(ratype.equalsIgnoreCase(""))){
        		sqltest=sqltest+" and o.rtype like '%"+ratype+"%'";
        }
        if(!(raNo.equalsIgnoreCase(""))){
        	if(ratype.equalsIgnoreCase("RAG")){
        		sqltest=sqltest+" and ra.voc_no like '%"+raNo+"%'";
        	}
        	else if(ratype.equalsIgnoreCase("LAG")){
        		sqltest=sqltest+" and la.voc_no like '%"+raNo+"%'";
        	}else{
        		sqltest=sqltest+" and ra.voc_no like '%"+raNo+"%' or la.voc_no like '%"+raNo+"%'";
        	}
           }
        if(!(sqlRequestDate==null)){
	         sqltest=sqltest+" and o.date='"+sqlRequestDate+"'";
	        } 
           
     try {
	       conn = ClsConnection.getMyConnection();
	       Statement stmtORQ = conn.createStatement();
	       
	       ResultSet resultSet = stmtORQ.executeQuery("select o.date,o.doc_no,o.amount,o.rtype ratype,CONVERT(if(o.rtype='0','',if(o.rtype='RAG',ra.voc_no,la.voc_no)),CHAR(50)) rano,c.refname from gl_othreq o left join my_acbook c on o.cldocno=c.cldocno and c.dtype='CRM' "
	       		+ "left join gl_ragmt ra on (o.aggno=ra.doc_no and o.rtype='RAG') left join gl_lagmt la on (o.aggno=la.doc_no and o.rtype='LAG') where o.brhid="+branch+" and o.status<>7" +sqltest);
	
	      
	       RESULTDATA=ClsCommon.convertToJSON(resultSet);
	       
	       stmtORQ.close();
	       conn.close();
     }catch(Exception e){
    	 e.printStackTrace();
    	 conn.close();
     }finally{
    	 conn.close();
     }
       return RESULTDATA;
   }
	
	 public  ClsOtherRequestBean getViewDetails(String mainHeaderBranch,int docNo) throws SQLException {
		ClsOtherRequestBean otherRequestBean = new ClsOtherRequestBean();
		Connection conn = null;
	
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmtORQ = conn.createStatement();
			
			ResultSet resultSet = stmtORQ.executeQuery ("select o.date,o.refno,o.cldocno,o.rtype,o.aggno,if(o.rtype='0','',if(o.rtype='RAG',ra.voc_no,la.voc_no)) aggvocno,"
					+ "o.servicedesc,o.remarks,o.adddr,o.amount,c.refname from gl_othreq o left join my_acbook c on o.cldocno=c.cldocno and c.dtype='CRM' left join gl_ragmt ra "
					+ "on (o.aggno=ra.doc_no and o.rtype='RAG') left join gl_lagmt la on (o.aggno=la.doc_no and o.rtype='LAG') where o.brhid='"+mainHeaderBranch+"' and o.doc_no="+docNo);
	
			while (resultSet.next()) {
				otherRequestBean.setTxtotherrequestdocno(docNo);
				otherRequestBean.setJqxOtherRequestDate(resultSet.getDate("date").toString());
				otherRequestBean.setTxtrefno(resultSet.getString("refno"));
				
				otherRequestBean.setTxtclientdocno(resultSet.getInt("cldocno"));
				otherRequestBean.setTxtclientname(resultSet.getString("refname"));
				otherRequestBean.setHidcmbratype(resultSet.getString("rtype"));
				otherRequestBean.setTxtrano(resultSet.getInt("aggno"));
				otherRequestBean.setTxtravocher(resultSet.getString("aggvocno"));
				otherRequestBean.setTxtremarks(resultSet.getString("remarks"));
				otherRequestBean.setChkadddriver(resultSet.getString("adddr"));
				
				if(resultSet.getString("adddr").equalsIgnoreCase("1")){
					otherRequestBean.setTxtdescription(resultSet.getString("servicedesc"));
					otherRequestBean.setTxtamount(resultSet.getDouble("amount"));
				}
			   }
			stmtORQ.close();
			conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
		return otherRequestBean;
		}
	 
	 public  ClsOtherRequestBean getPrint(int branch,HttpServletRequest request,int docNo) throws SQLException {
		 ClsOtherRequestBean bean = new ClsOtherRequestBean();
		 Connection conn = null;

		 try {
			
			conn = ClsConnection.getMyConnection();
			Statement stmtORQ = conn.createStatement();
			
			String sqls="select if(m.dtype='ORQ','Extra Service Request','  ') vouchername,c.company,c.address,c.tel,c.fax,lc.loc_name location,b.branchname,b.pbno,b.stcno,b.cstno from gl_othreq m inner join my_brch b on "
					+ "m.brhid=b.doc_no inner join my_comp c on b.cmpid=c.doc_no inner join my_locm l on l.brhid=b.doc_no inner join (select min(lo.loc) loc,lo.loc_name,lo.brhid "
					+ "from my_locm lo group by brhid) as lc on(lc.loc=l.loc and lc.brhid=b.branch) where m.brhid="+branch+" and  m.doc_no="+docNo+"";
				
				ResultSet resultSets = stmtORQ.executeQuery(sqls);

				while(resultSets.next()){
					bean.setLblcompname(resultSets.getString("company"));
					bean.setLblcompaddress(resultSets.getString("address"));
					bean.setLblcomptel(resultSets.getString("tel"));
					bean.setLblcompfax(resultSets.getString("fax"));
					bean.setLbllocation(resultSets.getString("location"));
					bean.setLblbranch(resultSets.getString("branchname"));
					bean.setLblcstno(resultSets.getString("cstno"));
					bean.setLblpan(resultSets.getString("pbno"));
					bean.setLblservicetax(resultSets.getString("stcno"));
					bean.setLblprintname(resultSets.getString("vouchername"));
				}
				
			String sql="select m.doc_no,DATE_FORMAT(m.date ,'%d-%m-%Y') date,m.remarks,if(m.rtype='RAG','Rental Agreement','Lease Agreement') rtype,m.aggno,a.refname,"
					+ "c.company,c.address,c.tel,c.fax,b.branchname,l.loc_name location from gl_othreq m left join my_acbook a on m.cldocno=a.cldocno and a.dtype='CRM' "
					+ "left join my_brch b on m.brhid=b.doc_no left join my_locm l on l.brhid=b.doc_no left join my_comp c on b.cmpid=c.doc_no where m.brhid="+branch+" and "
					+ "m.doc_no="+docNo+"";
					
				ResultSet resultSet = stmtORQ.executeQuery(sql);
				
				while(resultSet.next()){
					
					bean.setLbldate(resultSet.getString("date"));
					bean.setLblratype(resultSet.getString("rtype"));
					bean.setLblrano(resultSet.getString("aggno"));
					bean.setLbldocno(resultSet.getString("doc_no"));
					bean.setLblclient(resultSet.getString("refname"));
					bean.setLbldescription(resultSet.getString("remarks"));
				}
			
			String sql1 = "";

			sql1="select type,remarks,round(amount,2) amount from gl_othreqd where brhid="+branch+" and rdocno="+docNo+"";
			
			ResultSet resultSet1 = stmtORQ.executeQuery(sql1);
			
			ArrayList<String> prints= new ArrayList<String>();
			
			while(resultSet1.next()){
				bean.setFirstarray(1);

				String temp="";
				temp=resultSet1.getString("type")+"::"+resultSet1.getString("remarks")+"::"+resultSet1.getString("amount");
				prints.add(temp);
			}
			request.setAttribute("printingarray", prints);
			
			stmtORQ.close();
			conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
		return bean;
	}
	 
	 public int insertion(Connection conn,int docno,int txtclientdocno,String cmbratype,int txtrano,String adddriverintickval, ArrayList<String> otherrequestarray,ArrayList<String> driverarray,String branch) throws SQLException{
		
		  try{
				conn.setAutoCommit(false);
				CallableStatement stmtORQ=null;
				
				/*Other Request Grid and Details Saving*/
				for(int i=0;i< otherrequestarray.size();i++){
					String[] othreq=otherrequestarray.get(i).split("::");
					if(!othreq[0].trim().equalsIgnoreCase("undefined") && !othreq[0].trim().equalsIgnoreCase("NaN")){
					
					/*Insertion to gl_othreqd*/
					stmtORQ = conn.prepareCall("insert into gl_othreqd(rdocno, type, remarks, amount, type_id, sr_no, brhid) values(?,?,?,?,?,?,?)");
					
					stmtORQ.setInt(1,docno);
					stmtORQ.setString(2,(othreq[0].trim().equalsIgnoreCase("undefined") || othreq[0].trim().equalsIgnoreCase("NaN") || othreq[0].trim().equalsIgnoreCase("") ||othreq[0].trim().isEmpty()?0:othreq[0].trim()).toString());
					stmtORQ.setString(3,(othreq[1].trim().equalsIgnoreCase("undefined") || othreq[1].trim().equalsIgnoreCase("NaN") || othreq[1].trim().equalsIgnoreCase("") ||othreq[1].trim().isEmpty()?0:othreq[1].trim()).toString());
					stmtORQ.setString(4,(othreq[2].trim().equalsIgnoreCase("undefined") || othreq[2].trim().equalsIgnoreCase("NaN") || othreq[2].trim().equalsIgnoreCase("") ||othreq[2].trim().isEmpty()?0:othreq[2].trim()).toString());
					stmtORQ.setString(5,(othreq[3].trim().equalsIgnoreCase("undefined") || othreq[3].trim().equalsIgnoreCase("NaN") || othreq[3].trim().equalsIgnoreCase("") ||othreq[3].trim().isEmpty()?0:othreq[3].trim()).toString());
					stmtORQ.setInt(6,adddriverintickval.equalsIgnoreCase("0")?(i+1):i);
					stmtORQ.setString(7, branch);
					int detail=stmtORQ.executeUpdate();
						if(detail<=0){
							stmtORQ.close();
							conn.close();
							return 0;
						}
      				  }
				    }
				    /*Other Request Grid and Details Saving Ends*/
				
					/*Driver Grid Saving*/
					for(int i=0;i< driverarray.size();i++){
					CallableStatement stmtCRM1=null;
					String[] client=driverarray.get(i).split("::");
					if(!client[0].equalsIgnoreCase("undefined") && !client[0].equalsIgnoreCase("NaN")){
						
						String driverIds="";
						int driver=0;
						
						String sql="select * from gl_drdetails where dtype='CRM' and cldocno="+txtclientdocno+" and name='"+client[0].trim()+"'";
						ResultSet resultSet = stmtORQ.executeQuery(sql);	
					    
						while (resultSet.next()) {
							driver=1;
						}	
						
						if(driver==0){
							
						java.sql.Date dob=(client[1].trim().equalsIgnoreCase("undefined") || client[1].trim().equalsIgnoreCase("NaN") || client[1].trim().equalsIgnoreCase("") ||  client[1].trim().isEmpty()?null:ClsCommon.changeStringtoSqlDate(client[1].trim()));
						java.sql.Date passexp=(client[5].trim().equalsIgnoreCase("undefined") || client[5].trim().equalsIgnoreCase("NaN") || client[5].trim().equalsIgnoreCase("") ||  client[5].trim().isEmpty()?null:ClsCommon.changeStringtoSqlDate(client[5].trim()));
						java.sql.Date issdate=(client[7].trim().equalsIgnoreCase("undefined") || client[7].trim().equalsIgnoreCase("NaN") || client[7].trim().equalsIgnoreCase("") ||  client[7].trim().isEmpty()?null:ClsCommon.changeStringtoSqlDate(client[7].trim()));
						java.sql.Date led=(client[9].trim().equalsIgnoreCase("undefined") || client[9].trim().equalsIgnoreCase("NaN") || client[9].trim().equalsIgnoreCase("") ||  client[9].trim().isEmpty()?null:ClsCommon.changeStringtoSqlDate(client[9].trim()));
						java.sql.Date visaexp=(client[12].trim().equalsIgnoreCase("undefined") || client[12].trim().equalsIgnoreCase("NaN") || client[12].trim().equalsIgnoreCase("") ||  client[12].trim().isEmpty()?null:ClsCommon.changeStringtoSqlDate(client[12].trim()));
						
						String sql1="select max(sr_no)+1 srno from gl_drdetails where dtype='CRM' and cldocno="+txtclientdocno+"";
						ResultSet resultSet1 = stmtORQ.executeQuery(sql1);	
					    
						int srno=0;
						while (resultSet1.next()) {
							srno=resultSet1.getInt("srno");
						}	
						
						stmtCRM1 = conn.prepareCall("INSERT INTO gl_drdetails(name,dob,nation,mobno,passport_no,pass_exp,dlno,issdate,issfrm,led,ltype,visano,visa_exp,sr_no,dtype,branch,cldocno,doc_no) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
						
						stmtCRM1.setString(1,(client[0].trim().equalsIgnoreCase("undefined") || client[0].trim().equalsIgnoreCase("NaN") || client[0].trim().equalsIgnoreCase("") ||client[0].trim().isEmpty()?0:client[0].trim()).toString());
						stmtCRM1.setDate(2,dob);
						stmtCRM1.setString(3,(client[2].trim().equalsIgnoreCase("undefined") || client[2].trim().equalsIgnoreCase("NaN") || client[2].trim().equalsIgnoreCase("") ||client[2].trim().isEmpty()?0:client[2].trim()).toString());
						stmtCRM1.setString(4,(client[3].trim().equalsIgnoreCase("undefined") || client[3].trim().equalsIgnoreCase("NaN") || client[3].trim().equalsIgnoreCase("") ||client[3].trim().isEmpty()?0:client[3].trim()).toString());
						stmtCRM1.setString(5,(client[4].trim().equalsIgnoreCase("undefined") || client[4].trim().equalsIgnoreCase("NaN") || client[4].trim().equalsIgnoreCase("") ||client[4].trim().isEmpty()?0:client[4].trim()).toString());
						stmtCRM1.setDate(6,passexp);
						stmtCRM1.setString(7,(client[6].trim().equalsIgnoreCase("undefined") || client[6].trim().equalsIgnoreCase("NaN") || client[6].trim().equalsIgnoreCase("") ||client[6].trim().isEmpty()?0:client[6].trim()).toString());
						stmtCRM1.setDate(8,issdate);
						stmtCRM1.setString(9,(client[8].trim().equalsIgnoreCase("undefined") || client[8].trim().equalsIgnoreCase("NaN") || client[8].trim().equalsIgnoreCase("") ||client[8].trim().isEmpty()?0:client[8].trim()).toString());
						stmtCRM1.setDate(10,led);
						stmtCRM1.setString(11,(client[10].trim().equalsIgnoreCase("undefined") || client[10].trim().equalsIgnoreCase("NaN") || client[10].trim().equalsIgnoreCase("") ||client[10].trim().isEmpty()?0:client[10].trim()).toString());
						stmtCRM1.setString(12,(client[11].trim().equalsIgnoreCase("undefined") || client[11].trim().equalsIgnoreCase("NaN") || client[11].trim().equalsIgnoreCase("") ||client[11].trim().isEmpty()?0:client[11].trim()).toString());
						stmtCRM1.setDate(13,visaexp);
						stmtCRM1.setInt(14,srno);
						stmtCRM1.setString(15,"CRM");
						stmtCRM1.setString(16,branch);
						stmtCRM1.setInt(17,txtclientdocno);
						stmtCRM1.setInt(18,txtclientdocno);
					    int datas = stmtCRM1.executeUpdate();
					    
						String sql2="select max(dr_id) drid from gl_drdetails where cldocno="+txtclientdocno+"";
						ResultSet resultSets = stmtORQ.executeQuery(sql2);	
					    
						while (resultSets.next()) {
							driverIds=resultSets.getString("drid");
						}	
				     }
						
						CallableStatement stmtORQ1 = null;
					
						if(cmbratype.equalsIgnoreCase("RAG")){
							/*Insertion to gl_rdriver*/
							stmtORQ1 = conn.prepareCall("insert into gl_rdriver(rdocno, brhid, drid, cldocno) values(?,?,?,?)");
						}
						
						else if(cmbratype.equalsIgnoreCase("LAG")){
							/*Insertion to gl_ldriver*/
							stmtORQ1 = conn.prepareCall("insert into gl_ldriver(rdocno, brhid, drid, cldocno) values(?,?,?,?)");
						}
						
						stmtORQ1.setInt(1,txtrano);
						stmtORQ1.setString(2,branch);
						stmtORQ1.setString(3,(client[13].trim().equalsIgnoreCase("undefined") || client[13].trim().equalsIgnoreCase("NaN") || client[13].trim().equalsIgnoreCase("") ||client[13].trim().isEmpty()?0:client[13].trim()).toString().equalsIgnoreCase("0")?driverIds:(client[13].trim().equalsIgnoreCase("undefined") || client[13].trim().equalsIgnoreCase("NaN") || client[13].trim().equalsIgnoreCase("") ||client[13].trim().isEmpty()?0:client[13].trim()).toString());
						stmtORQ1.setInt(4,txtclientdocno);
						int data1=stmtORQ1.executeUpdate();
							if(data1<=0){
								stmtORQ1.close();
								conn.close();
								return 0;
							}
							/*Insertion to gl_rdriver & gl_ldriver Ends*/
						stmtORQ1.close();	
						
						/*Insertion to gl_othreqdr*/
						CallableStatement stmtORQ2 = null;
						
						stmtORQ2 = conn.prepareCall("insert into gl_othreqdr(rdocno, cldocno, drid, ratype, rano, brhid) values(?,?,?,?,?,?)");

						stmtORQ2.setInt(1,docno);
						stmtORQ2.setInt(2,txtclientdocno);
						stmtORQ2.setString(3,(client[13].trim().equalsIgnoreCase("undefined") || client[13].trim().equalsIgnoreCase("NaN") || client[13].trim().equalsIgnoreCase("") ||client[13].trim().isEmpty()?0:client[13].trim()).toString().equalsIgnoreCase("0")?driverIds:(client[13].trim().equalsIgnoreCase("undefined") || client[13].trim().equalsIgnoreCase("NaN") || client[13].trim().equalsIgnoreCase("") ||client[13].trim().isEmpty()?0:client[13].trim()).toString());
						stmtORQ2.setString(4,cmbratype);						
						stmtORQ2.setInt(5,txtrano);
						stmtORQ2.setString(6, branch);
						int data2=stmtORQ2.executeUpdate();
							if(data2<=0){
								stmtORQ2.close();
								conn.close();
								return 0;
							}
							/*Insertion to gl_othreqdr Ends*/
						stmtORQ2.close();
						
				  }
				}  
				stmtORQ.close();
				
			    
	   }catch(Exception e){	
		 	e.printStackTrace();
		 	conn.close();
		 	return 0;
	 }
		return 1;
	}

}
