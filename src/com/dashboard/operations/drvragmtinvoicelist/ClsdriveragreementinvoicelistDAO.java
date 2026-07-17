package com.dashboard.operations.drvragmtinvoicelist;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.common.ClsAmountToWords;
import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.finance.transactions.debitnote.ClsDebitNoteBean;


public class ClsdriveragreementinvoicelistDAO
{
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	
	public JSONArray driverDetailsSearch() throws SQLException {
	JSONArray RESULTDATA=new JSONArray();
	    
	Connection conn = null;
    
	  try {
	    conn = ClsConnection.getMyConnection();
	    Statement stmtSailk = conn.createStatement ();
	    
	    String sql = "";
		
		sql = "select doc_no,sal_code code,sal_name name,lic_no license,lic_exp_dt licenseexpdate,mobile from my_salesman where sal_type='DRV' and status=3";
		
		ResultSet resultSet = stmtSailk.executeQuery(sql);
	                
	    RESULTDATA=ClsCommon.convertToJSON(resultSet);
	    stmtSailk.close();
	    conn.close();
	
	  }
	  catch(Exception e){
		  e.printStackTrace();
		  conn.close();
	  }
	  return RESULTDATA;
	}
	
	public JSONArray agreementSearch(String branch, String sclname,String docno) throws SQLException {

    	JSONArray RESULTDATA=new JSONArray();
    	String sqltest="";
    	
    
    	
    	

        
    		if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    			sqltest+=" and r.brhid="+branch+"";
    		}
        	
        	/*if(!(sclname.equalsIgnoreCase(""))){
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
    */
    	
    	
    	
    	Connection conn=null;
     
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtinv = conn.createStatement();
				
				String sql="select g.doc_no,ac.refname from gl_drvagmt g left join my_acbook ac on ac.doc_no=g.cldocno and ac.dtype='crm'";
				System.out.println(sql);
					ResultSet resultSet = stmtinv.executeQuery(sql);
					RESULTDATA=ClsCommon.convertToJSON(resultSet);				
		    	
				stmtinv.close();
				conn.close();
		    	
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
        return RESULTDATA;
    }
 public JSONArray invoicelist(String branchval,String fromdate,String todate,String drdocno,String agmtNo) throws SQLException {

	        JSONArray RESULTDATA=new JSONArray();
	        
	        java.sql.Date sqlfromdate = null;
	        if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
	     	{
	     		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
	     		
	     	}
	     	else{
	     
	     	}

	        java.sql.Date sqltodate = null;
	     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
	     	{
	     		sqltodate=ClsCommon.changeStringtoSqlDate(todate);
	     		
	     	}
	     	else{
	     
	     	}
	     	
	     	
        	String sqltest="";
        	String sqltest1="";
	    	if(!(drdocno.equalsIgnoreCase("")|| drdocno.equalsIgnoreCase("NA"))){
	    		sqltest=sqltest+" and sal.doc_no='"+drdocno+"'";
	    	}
	    	
	    	if(!(agmtNo.equalsIgnoreCase("")|| agmtNo.equalsIgnoreCase("NA"))){
	    		sqltest=sqltest+" and dr.agmtno='"+agmtNo+"'";
	    	}
	    	
	    	
	      	if(!((branchval.equalsIgnoreCase("a")) || (branchval.equalsIgnoreCase("NA")))){
	 			sqltest+=" and g.brhid="+branchval+"";
	 		}
	    	
	    	Connection conn = null;
			try {
					 conn = ClsConnection.getMyConnection();
					Statement stmtVeh = conn.createStatement ();
					
				
				
				//Fetching data from view instead direct from db;
				String sql="  select ac.refname client,cn.doc_no,dr.inv_trno,sal.sal_name driver,g.date,dr.agmtno,dr.normalot_hrs,dr.holidayot_hrs,"
						+ " dr.closedate,dr.totalrate,dr.totalnormalot,dr.totalholidayot,dr.invdate,dr.invtodate"
						+ " from gl_drvagmtinv dr left join gl_drvagmt g on g.doc_no=dr.agmtno left join my_salesman sal on g.drvid=sal.doc_no "
						+ " and sal.sal_type='drv' left join my_acbook ac on ac.doc_no=g.cldocno and ac.dtype='crm'"
						+ " left join my_cnot cn on cn.tr_no=dr.inv_trno where sal.status=3 "+sqltest+"";
				
				
	            		System.out.println("=====sqqql======"+sql);
	              
	            		ResultSet resultSet = stmtVeh.executeQuery(sql);
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
	    
 public ClsdriveragreementinvoicelistBean getPrint(HttpServletRequest request,int docNo,String branch,int header) throws SQLException {
	 ClsdriveragreementinvoicelistBean bean = new ClsdriveragreementinvoicelistBean();
	 Connection conn = null;
	 
	try {
			conn = ClsConnection.getMyConnection();
			Statement stmtDNO = conn.createStatement();
			String branchvl="";
					
			
			if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
				 branchvl=" and m.brhid="+branch+"";
	 		}
			String headersql="select if(m.dtype='DNO','Debit Note','  ') vouchername,sal.sal_name,drva.doc_no,c.company,c.address,drva.lpono,c.tel,c.fax,lc.loc_name location,b.branchname,b.pbno,b.stcno,"
					+ "b.cstno from my_cnot m left join gl_drvagmtinv drv on m.tr_no=drv.inv_trno left join gl_drvagmt drva on drv.agmtno=drva.doc_no left join my_salesman sal on sal.doc_no=drva.drvid inner join my_brch b on m.brhid=b.doc_no inner join my_comp c on b.cmpid=c.doc_no inner join my_locm l on l.brhid=b.doc_no "
					+ "inner join (select min(lo.loc) loc,lo.loc_name,lo.brhid from my_locm lo group by brhid) as lc on(lc.loc=l.loc and lc.brhid=b.doc_no) where m.dtype='DNO' "
					+ " "+branchvl+" and m.doc_no="+docNo+"";
				System.out.println(headersql);
				ResultSet resultSetHead = stmtDNO.executeQuery(headersql);
				
				while(resultSetHead.next()){
					
					bean.setLblcompname(resultSetHead.getString("company"));
					bean.setLblcompaddress(resultSetHead.getString("address"));
					
					bean.setLblcomptel(resultSetHead.getString("tel"));
					bean.setLblcompfax(resultSetHead.getString("fax"));
					bean.setLblbranch(resultSetHead.getString("branchname"));
					bean.setLbllocation(resultSetHead.getString("location"));
					bean.setLblcstno(resultSetHead.getString("cstno"));
					bean.setLblpan(resultSetHead.getString("pbno"));
					bean.setLblservicetax(resultSetHead.getString("stcno"));
					bean.setLblpobox(resultSetHead.getString("pbno"));
					bean.setLbllpono(resultSetHead.getString("lpono"));
				    bean.setLblagreement(resultSetHead.getString("doc_no"));
				    bean.setLbldriver(resultSetHead.getString("sal_name"));
				}
				
				String sql="select m.doc_no,DATE_FORMAT(m.date,'%d-%m-%Y') date,m.description,round(m.netAmount,2) netAmount,t.description accountname,u.user_name from my_cnot m left join my_head t on "
						+ "m.acno=t.doc_no left join my_user u on m.userid=u.doc_no where m.dtype='DNO' and m.brhid="+branch+" and m.doc_no="+docNo+"";
				
			ResultSet resultSet = stmtDNO.executeQuery(sql);
			
			ClsAmountToWords c = new ClsAmountToWords();
			
			while(resultSet.next()){
				
				bean.setLbldocumentno(resultSet.getString("doc_no"));
				bean.setLbldate(resultSet.getString("date"));
				bean.setLblaccountname(resultSet.getString("accountname"));
				bean.setLbldescription(resultSet.getString("description"));
				bean.setLbldebittotal(resultSet.getString("netAmount"));
				bean.setLblcredittotal(resultSet.getString("netAmount"));
				bean.setLblnetamount(resultSet.getString("netAmount"));
				bean.setLblnetamountwords(c.convertAmountToWords(resultSet.getString("netAmount")));
				bean.setLblpreparedby(resultSet.getString("user_name"));
			}
			
			bean.setTxtheader(header);

			String sql1 = "";
		
			sql1="SELECT t.account,t.description accountname,c.code currency,j.description,if(j.dramount>0,round((j.dramount*1),2),'  ') debit,if(j.dramount<0,round((j.dramount*-1),2),' ') credit "
			  + "FROM my_jvtran j left join my_head t on j.acno=t.doc_no left join my_curr c on c.doc_no=j.curId WHERE j.dtype='DNO' and j.brhid="+branch+" and j.doc_no="+docNo+"  order by j.dramount desc";
			
			ResultSet resultSet1 = stmtDNO.executeQuery(sql1);
			
			ArrayList<String> printarray= new ArrayList<String>();
			
			while(resultSet1.next()){
				bean.setFirstarray(1); 
				String temp="";
				temp=resultSet1.getString("account")+"::"+resultSet1.getString("accountname")+"::"+resultSet1.getString("description")+"::"+resultSet1.getString("currency")+"::"+resultSet1.getString("debit")+"::"+resultSet1.getString("credit");
			    printarray.add(temp);
			}

			request.setAttribute("printingarray", printarray);
			
			String sql2 = "select min(DATE_FORMAT(d.edate,'%d-%m-%Y')) preparedon,min(DATE_FORMAT(d.edate,'%H:%i:%s')) preparedat from my_cnot m inner join datalog d on (m.doc_no=d.doc_no and m.dtype=d.dtype and m.brhid=d.brhid) where m.dtype='DNO' and m.brhid="+branch+" and m.doc_no="+docNo+"";
			
			ResultSet resultSet2 = stmtDNO.executeQuery(sql2);
			
			while(resultSet2.next()){
				bean.setLblpreparedon(resultSet2.getString("preparedon"));
				bean.setLblpreparedat(resultSet2.getString("preparedat"));
			}
		
			stmtDNO.close();
			conn.close();
	}catch(Exception e){
		e.printStackTrace();
		conn.close();
	}finally{
		conn.close();
	}
	return bean;
}
	 
	  
	/* public JSONArray invoicelistExcel(String branchval,String fromdate,String todate,String drdocno,String agmtNo) throws SQLException {

		 JSONArray RESULTDATA=new JSONArray();
	        
	        java.sql.Date sqlfromdate = null;
	        if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
	     	{
	     		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
	     		
	     	}
	     	else{
	     
	     	}

	        java.sql.Date sqltodate = null;
	     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
	     	{
	     		sqltodate=ClsCommon.changeStringtoSqlDate(todate);
	     		
	     	}
	     	else{
	     
	     	}
	     	
	     	String sql="";
     	String sqltest="";
     	String sqltest1="";
	    	if(!(drdocno.equalsIgnoreCase("")|| drdocno.equalsIgnoreCase("NA"))){
	    		sqltest=sqltest+" and inv.cldocno='"+drdocno+"'";
	    	}
	    	
	    	if(!(agmtNo.equalsIgnoreCase("")|| agmtNo.equalsIgnoreCase("NA"))){
	    		sqltest=sqltest+" and inv.rano='"+agmtNo+"'";
	    	}
	    	
	    	
	      	if(!((branchval.equalsIgnoreCase("a")) || (branchval.equalsIgnoreCase("NA")))){
	 			sqltest+=" and inv.brhid="+branchval+"";
	 		}
	    	
	    	Connection conn = null;
			try {
					 conn = ClsConnection.getMyConnection();
					Statement stmtVeh = conn.createStatement ();
					
					
	            				
					 sql ="select * from my_cnot where dtype='dno'";
	       //System.out.println("============"+sql);
	              
	            		ResultSet resultSet = stmtVeh.executeQuery(sql);
	            		 RESULTDATA=convertToJSON(resultSet);//  convertToJSON(resultSet);
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
	    */
	 
	 
		public  JSONArray convertToJSON(ResultSet resultSet)
				throws Exception {
				JSONArray jsonArray = new JSONArray();
				
				while (resultSet.next()) {
				int total_rows = resultSet.getMetaData().getColumnCount();
				JSONObject obj = new JSONObject();
				for (int i = 0; i < total_rows; i++) {
					 obj.put(resultSet.getMetaData().getColumnLabel(i + 1), (resultSet.getObject(i + 1)==null) ? "NA" : ((resultSet.getObject(i + 1).equals("0.0000")) ? " " : (resultSet.getObject(i + 1).toString()).replaceAll("[^a-zA-Z0-9_-_._; ]", " ")));
					 obj.put(resultSet.getMetaData().getColumnLabel(i + 1), ((resultSet.getObject(i + 1)==null) ? "NA" : resultSet.getObject(i + 1).toString()));
				}
				jsonArray.add(obj);
				}
				//System.out.println("ConvertTOJson:   "+jsonArray);
				return jsonArray;
				}
			 
	 
	 
	 
}
