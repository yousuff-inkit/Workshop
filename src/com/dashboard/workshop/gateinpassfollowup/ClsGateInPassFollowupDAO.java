package com.dashboard.workshop.gateinpassfollowup;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.dashboard.serviceandmaintenance.ClsServiceAndMaintenanceBean;

 
public class ClsGateInPassFollowupDAO

{
	
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

		
	public  JSONArray subDetails(String fromdate,String cldocno,String check,String salid) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        String sqltest="";
       
        java.sql.Date sqlfromdate = null;
        if(!(check.equalsIgnoreCase("1")))
        {
        	return RESULTDATA;
        }
        if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
     	{
     		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
     		
     	}
     	else{
     
     	}

     	
     	if(!(cldocno.equalsIgnoreCase("0")) && !(cldocno.equalsIgnoreCase(""))){
			sqltest+=" and w.cldocno="+cldocno+"";
        }
     	if(!(salid.equalsIgnoreCase("0")) && !(salid.equalsIgnoreCase(""))){
			sqltest+=" and ac.sal_id="+salid+"";
        }
        Connection conn = null;
       
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement (); // UAL - UNallocated ,ANI - allocated not  Invoiced, AIN- allocated Invoiced , POS -traffic posted, RES - Received
	      				
				String sql="select 'GIP Entered' statistics,count(*) count,'A' rds from ws_gateinpass w"
						+ " left join my_acbook ac on (ac.cldocno=w.cldocno and dtype='CRM') "
						+ " where w.date<= '"+sqlfromdate+"'  "+sqltest+" and w.processstatus=1  "
						+ " union all "
						+ " select 'Estimation - in approval' statistics,count(*) count,'B' rds from ws_gateinpass w left join my_acbook ac on (ac.cldocno=w.cldocno and dtype='CRM') "
						+ " where w.date<= '"+sqlfromdate+"'  "+sqltest+" and w.processstatus in (2,3) "
						+ " union all "
						+ " select 'Estimation- approved' statistics,count(*) count,'C' rds from ws_gateinpass w left join my_acbook ac on (ac.cldocno=w.cldocno and dtype='CRM') "
						+ " where w.date<= '"+sqlfromdate+"'  "+sqltest+" and w.processstatus=4   "
						+ " union all "
						+ " select 'Opened Job' statistics,count(*) count,'D' rds from ws_gateinpass w left join my_acbook ac on (ac.cldocno=w.cldocno and dtype='CRM')"
						+ " where w.date<= '"+sqlfromdate+"'  "+sqltest+" and w.processstatus=5   ";
				
            		
	      			System.out.println(sql);
	      				ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
     				stmtVeh.close();
     				conn.close();
            	
     				conn.close();
		}
		catch(Exception e){
			conn.close();
		}
		finally{
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
	
	
	 public JSONArray clentdetails() throws SQLException {

	        JSONArray RESULTDATA=new JSONArray();
	        
	        Connection conn =null;
	        try {
				 conn = ClsConnection.getMyConnection();
				 Statement stmtVeh = conn.createStatement ();
				
				String sql="select cldocno,refname from my_acbook where status=3 and dtype='CRM' and pcase=0 ";
				 ResultSet resultSet = stmtVeh.executeQuery(sql);
	        	
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
	 			
				stmtVeh.close();
	 			conn.close();
	       
		} catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
	        finally{
	        	conn.close();
	        }
			//System.out.println(RESULTDATA);
	        return RESULTDATA;
	    }
	
	
	public  JSONArray masterdetails(String fromdate,String cldocno,String check,String process,String salid) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        Connection conn = null;
        String sqltest="";
        java.sql.Date sqlfromdate = null;
        System.out.println(check);
       
        if(!(check.equalsIgnoreCase("1"))){
        	return RESULTDATA;
        }
        if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
     	{
     		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
     		
     	}
        
     	else{
     
     	}
        
        
        System.out.println("++++++++++++++++++++++++++++"+process);

      
        
     	if(!(cldocno.equalsIgnoreCase("0")) && !(cldocno.equalsIgnoreCase(""))){
			sqltest+=" and ws.cldocno="+cldocno+"";
        }
     	if(!(salid.equalsIgnoreCase("0")) && !(salid.equalsIgnoreCase(""))){
			sqltest+=" and ac.sal_id="+salid+"";
        }
     	if(process.equalsIgnoreCase("1")) {
			sqltest+=" and ws.processstatus="+process+"";
        }
     	else if(process.equalsIgnoreCase("2") || process.equalsIgnoreCase("3")) {
			sqltest+=" and ws.processstatus in (2,3) ";
        }
     	else if(process.equalsIgnoreCase("4")) {
			sqltest+=" and ws.processstatus="+process+"";
        }
     	else {
			sqltest+=" and ws.processstatus="+process+"";
        }
		try {
				 conn = ClsConnection.getMyConnection();
				  Statement stmtVeh = conn.createStatement ();  // UAL - UNallocated ,ANI - allocated not  Invoiced, AIN- allocated Invoiced // POS -traffic posted RES - Received
				  
				  
				  System.out.println("-----code------");
			
			String sql="select  ac1.refname billto,sm1.sal_name estimator,sm.sal_name serviceadvisor,ws.doc_no doc_no,ws.voc_no voc_no,ws.doc_no gateinpassdoc,ws.date,ws.estdeltime time,gr.name reptype, ws.regno, ws.pltid pcode,vb.brand_name brand,vm.vtype model,datediff( CURRENT_TIMESTAMP, ws.DATE) gipdate,"
					+ "  ws.estdeldate expdelivery, ws.estdeltime dtime,ws.desc1 description,ws.username,ws.mobile, "
					+ " ur.user_name estimtdby,uw.user_name gipuser,e.date estdate,e.doc_no estimationno,e.voc_no estimationvocno,j.doc_no jobno,j.voc_no jobvocno,j.date jdate,us.user_name user,ac.refname customer, "
					+ "  ws.processstatus,if(((ep.rdocno is null) and (el.rdocno is null)) ,'approved','notapproved') approval,if(j.complete=1,'Completed','Not Completed') jstatus from ws_gateinpass ws"
					+ " left join ws_gartype gr on gr.row_no=ws.repairtype left join gl_vehbrand vb on vb.doc_no=ws.brdid "
					+ " left join gl_vehmodel vm on vm.doc_no=ws.modid left join ws_estm e on e.gipno=ws.doc_no "
					+ " left join ws_jobcard j on ((e.doc_no=j.refno and reftype='EST') or (ws.doc_no=j.refno and reftype='GIP')) "
					+ " left join my_user ur on ur.doc_no=e.userid"
					+ " left join my_user us on us.doc_no=j.userid"
					+ " left join my_user uw on uw.doc_no=ws.userid"
					+ " left join my_acbook ac on ac.cldocno=ws.cldocno and ac.dtype='CRM' "
					+ " left join (select ep.rdocno,count(*) cnt from  ws_estspare ep where ep.approved=0 group by ep.rdocno) ep on e.doc_no=ep.rdocno"
					+ " left join (select el.rdocno,count(*) cnt from  ws_estlabour el where el.approved=0 group by el.rdocno) el on e.doc_no=el.rdocno left join my_salesman sm on sm.doc_no=ws.serviceadvisor and sm.sal_type='WSA' left join my_salesman sm1 on sm1.doc_no=ws.marketingperson and sm1.sal_type='WMP' left join my_acbook ac1 on ac1.cldocno=ws.insurcldocno and ac1.dtype='CRM'"
					+ " where ws.date<= '"+sqlfromdate+"'   "+sqltest+" ";
			
			System.out.println("-----asdasd----detail--"+sql);

       		ResultSet resultSet = stmtVeh.executeQuery(sql);
    		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
				stmtVeh.close();
				
            	
        conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
			
		}
		finally{
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
	
	public  JSONArray masterexceldetails(String fromdate,String cldocno,String check,String process,String salid) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        Connection conn = null;
        String sqltest="";
        java.sql.Date sqlfromdate = null;
        System.out.println(check);
       
        if(!(check.equalsIgnoreCase("1"))){
        	return RESULTDATA;
        }
        if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
     	{
     		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
     		
     	}
        
     	else{
     
     	}
        
        
        System.out.println("++++++++++++++++++++++++++++"+process);

      
        
     	if(!(cldocno.equalsIgnoreCase("0")) && !(cldocno.equalsIgnoreCase(""))){
			sqltest+=" and ws.cldocno="+cldocno+"";
        }
     	if(!(salid.equalsIgnoreCase("0")) && !(salid.equalsIgnoreCase(""))){
			sqltest+=" and ac.sal_id="+salid+"";
        }
     	if(process.equalsIgnoreCase("1")) {
			sqltest+=" and ws.processstatus="+process+"";
        }
     	if(process.equalsIgnoreCase("2") || process.equalsIgnoreCase("3")) {
			sqltest+=" and ws.processstatus in (2,3) ";
        }
     	if(process.equalsIgnoreCase("4")) {
			sqltest+=" and ws.processstatus="+process+"";
        }
     	else {
			sqltest+=" and ws.processstatus>="+process+"";
        }
		try {
				 conn = ClsConnection.getMyConnection();
				  Statement stmtVeh = conn.createStatement ();  // UAL - UNallocated ,ANI - allocated not  Invoiced, AIN- allocated Invoiced // POS -traffic posted RES - Received
				  
				  
				 // System.out.println("-----code------"+code);
			
			String sql="select  ws.voc_no 'Doc No',date_format(ws.date,'%d.%m.%Y') 'Date' ,ws.estdeltime 'Time',gr.name 'Repair Type', ws.regno 'Reg No', ws.pltid 'Plate Code',vb.brand_name 'Brand',vm.vtype 'Model',datediff( CURRENT_TIMESTAMP, ws.DATE) 'Days-GIP Date',"
					+ "  date_format(ws.estdeldate,'%d.%m.%Y') 'Exp.Delivery', ws.estdeltime 'Time',ws.desc1 'Description',ws.username 'User Open',"
					+ " ur.user_name estimtdby,e.date estdate,e.doc_no estimationno,j.doc_no jobno,j.date jdate,us.user_name user,ac.refname customer, "
					+ "  ws.processstatus,if(((ep.rdocno is null) and (el.rdocno is null)) ,'approved','notapproved') approval,if(j.complete=1,'Completed','Not Completed') jstatus,sm.sal_name 'Service Advisor',sm1.sal_name 'Estimator',ac1.refname 'Bill to' from ws_gateinpass ws"
					+ " left join ws_gartype gr on gr.row_no=ws.repairtype left join gl_vehbrand vb on vb.doc_no=ws.brdid "
					+ " left join gl_vehmodel vm on vm.doc_no=ws.modid left join ws_estm e on e.gipno=ws.doc_no "
					+ " left join ws_jobcard j on ((e.doc_no=j.refno and reftype='EST') or (ws.doc_no=j.refno and reftype='GIP')) "
					+ " left join my_user ur on ur.doc_no=e.userid"
					+ " left join my_user us on us.doc_no=j.userid"
					+ " left join my_acbook ac on ac.cldocno=ws.cldocno and ac.dtype='CRM' "
					+ " left join (select ep.rdocno,count(*) cnt from  ws_estspare ep where ep.approved=0 group by ep.rdocno) ep on e.doc_no=ep.rdocno"
					+ " left join (select el.rdocno,count(*) cnt from  ws_estlabour el where el.approved=0 group by el.rdocno) el on e.doc_no=el.rdocno left join my_salesman sm on sm.doc_no=ws.serviceadvisor and sm.sal_type='WSA' left join my_salesman sm1 on sm1.doc_no=ws.marketingperson and sm1.sal_type='WMP' left join my_acbook ac1 on ac1.cldocno=ws.insurcldocno and ac1.dtype='CRM'"
					+ " where ws.date<= '"+sqlfromdate+"'   "+sqltest+" ";
			System.out.println("-----asdasd------"+sql);

       		ResultSet resultSet = stmtVeh.executeQuery(sql);
    		 RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
				stmtVeh.close();
				
            	
        conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
			
		}
		finally{
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
	
	public  JSONArray masterdetailsexcel(String fromdate,String cldocno,String check) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        Connection conn = null;
        String sqltest="";
        java.sql.Date sqlfromdate = null;
        if(!(check.equalsIgnoreCase("1"))){
        	return RESULTDATA;
        }
        if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
     	{
     		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
     		
     	}
        
     	else{
    
     	}

      
        
     	if(!(cldocno.equalsIgnoreCase("0")) && !(cldocno.equalsIgnoreCase(""))){
			sqltest+=" and bp.rdocno="+cldocno+"";
        }
     	
		try {
				 conn = ClsConnection.getMyConnection();
				  Statement stmtVeh = conn.createStatement ();  // UAL - UNallocated ,ANI - allocated not  Invoiced, AIN- allocated Invoiced // POS -traffic posted RES - Received
				  
				  
				 // System.out.println("-----code------"+code);
			
			String sql="select  bp.date  'Date',  bp.acno 'Acc No',a.refname 'Client Name',coalesce(a.com_mob,a.per_mob) 'Mob No' , bp.remarks 'Comments',fdate 'Followup Date', process 'Process',b.branchname 'Branch Name' from gl_bcpf bp\r\n" + 
					"left join my_acbook a on a.acno=bp.acno\r\n" + 
					" left join  gl_bibp p on bp.bibpid=p.rowno\r\n" + 
					"  left join  my_brch b on b.doc_no=bp.brhid where bp.date<='"+sqlfromdate+"'  "+sqltest+" ";
			System.out.println("-----asdasdmmmmmmm------"+sql);

       		ResultSet resultSet = stmtVeh.executeQuery(sql);
    		 RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
				stmtVeh.close();
				
            	
        conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
			
		}
		finally{
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }

	
	public  ClsGateInPassFollowupBean getPrint(HttpServletRequest request,int cldocno,String fromdate,String todate) throws SQLException {
		ClsGateInPassFollowupBean bean = new ClsGateInPassFollowupBean();
		 Connection conn = null;
			
	        java.sql.Date sqlFromDate = null;
	        java.sql.Date sqlToDate = null;
	        
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmtVeh = conn.createStatement();
			String mainbranch="";
			
			if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
	        	sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
	        }
			
			if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
				sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
	        }
			
			
				mainbranch="1";
			
			String headersql="select b.branchname,'Client Followup Log' vouchername,CONCAT('Period From ',DATE_FORMAT('"+sqlFromDate+"','%d-%m-%Y'),' To ',DATE_FORMAT('"+sqlToDate+"' ,'%d-%m-%Y')) vouchername1,"
					+ "c.company,c.address,c.tel,c.tel2,c.email,c.web,c.fax,l.loc_name location from my_brch b left join my_locm l on l.brhid=b.doc_no left join my_comp c on "
					+ "b.cmpid=c.doc_no where b.doc_no="+mainbranch+" group by brhid";

					ResultSet resultSetHead = stmtVeh.executeQuery(headersql);
					
					while(resultSetHead.next()){
						bean.setLblcompname(resultSetHead.getString("company"));
						bean.setLblcompaddress(resultSetHead.getString("address"));
						bean.setLblprintname(resultSetHead.getString("vouchername"));
						bean.setLblprintname1(resultSetHead.getString("vouchername1"));
						bean.setLblcomptel(resultSetHead.getString("tel"));
						bean.setLblcompfax(resultSetHead.getString("fax"));
						bean.setLblbranch(resultSetHead.getString("branchname"));
						bean.setLbllocation(resultSetHead.getString("location"));
						}
		
					
		String sqldet="select refname,acno,address,per_mob,codeno from my_acbook where status=3 and dtype='CRM' and pcase=0 and  cldocno='"+cldocno+"' ";				
					
		ResultSet resultSetdet = stmtVeh.executeQuery(sqldet);
		
		while(resultSetdet.next()){
			bean.setLblname(resultSetdet.getString("refname"));
			bean.setLblacno(resultSetdet.getString("acno"));
			bean.setLbladdress(resultSetdet.getString("address"));
			bean.setLblmobno(resultSetdet.getString("per_mob"));
			bean.setLblcodeno(resultSetdet.getString("codeno"));
				}		
					
			String sql = "";
			
			sql="select DATE_FORMAT(bp.date,'%d-%m-%Y') date,  bp.acno, bp.remarks comnt,DATE_FORMAT(fdate,'%d-%m-%Y')  folupdate, process,b.branchname,mu.user_name usern from gl_bcpf bp\r\n" + 
					"left join my_acbook a on a.acno=bp.acno\r\n" + 
					" left join  gl_bibp p on bp.bibpid=p.rowno\r\n" + 
					"  left join  my_brch b on b.doc_no=bp.brhid "
					+ "left join  my_user mu on mu.doc_no=bp.userid where bp.date between  '"+sqlFromDate+"' and  '"+sqlToDate+"' and  bp.rdocno='"+cldocno+"' ";

			ResultSet resultSet1 = stmtVeh.executeQuery(sql);
			
			ArrayList<String> printclientarray= new ArrayList<String>();
			
			while(resultSet1.next()){
				bean.setFirstarray(1);
				String temp1="";
				temp1=resultSet1.getString("branchname")+"::"+resultSet1.getString("date")+"::"+resultSet1.getString("comnt")+"::"+resultSet1.getString("process")+"::"+resultSet1.getString("folupdate")+"::"+resultSet1.getString("usern");
				printclientarray.add(temp1);
			}
			request.setAttribute("printclientarray", printclientarray);
					
			stmtVeh.close();
			conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
		return bean;
	  }
	
	public JSONArray salesmandetails() throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn =null;
        try {
			 conn = ClsConnection.getMyConnection();
			 Statement stmtVeh = conn.createStatement ();
			
			String sql="select sal_name salesman,doc_no salesmanid from my_salm where status=3";
			 ResultSet resultSet = stmtVeh.executeQuery(sql);
        	
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
 			
			stmtVeh.close();
 			conn.close();
       
	} catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
        finally{
        	conn.close();
        }
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }


	
}




