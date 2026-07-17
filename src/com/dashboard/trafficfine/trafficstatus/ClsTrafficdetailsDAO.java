package com.dashboard.trafficfine.trafficstatus;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.dashboard.trafficfine.ClsTrafficfineDAO;

 
public class ClsTrafficdetailsDAO

{
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	
	
	public JSONArray postingDetails(String fromdate,String todate,String ticketno,String regno) throws SQLException {

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
        String sqlticketno="";
        if(!ticketno.equalsIgnoreCase("")){
        	sqlticketno+=" and ticket_no="+ticketno;
        }
        String sqltest="";
        if(!(regno.equalsIgnoreCase("undefined"))&&!(regno.equalsIgnoreCase(""))&&!(regno.equalsIgnoreCase("0")))
    	{
    		sqltest=" and regno="+regno;
    	}
        Connection conn = null;
       
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement (); // UAL - UNallocated ,ANI - allocated not  Invoiced, AIN- allocated Invoiced , POS -traffic posted, RES - Received
		
 
            		String sql="select count(*) VALUE,'Posted' status,'POS' relodestatus from gl_traffic  " + 
            				"  where postdocno>0 and isallocated=1 and inv_no>0 and status in (1) and TRAFFIC_DATE between '"+sqlfromdate+"' and  '"+sqltodate+"'  "+sqlticketno+" "+sqltest;  
            		
            		
            	//	System.out.println("------------"+sql);
            		
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
     				stmtVeh.close();
     				conn.close();
            	
     				conn.close();
		}
		catch(Exception e){
			conn.close();
			
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
	
	public JSONArray subDetails(String fromdate,String todate,String ticketno,String regno) throws SQLException {

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
     	 String sqlticketno="";
         if(!ticketno.equalsIgnoreCase("")){
         	sqlticketno+=" and ticket_no="+ticketno;
         }
         String sqltest="";
        	if(!(regno.equalsIgnoreCase("undefined"))&&!(regno.equalsIgnoreCase(""))&&!(regno.equalsIgnoreCase("0")))
        	{
        		sqltest=" and regno="+regno;
        	}
        Connection conn = null;
       
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement (); // UAL - UNallocated ,ANI - allocated not  Invoiced, AIN- allocated Invoiced , POS -traffic posted, RES - Received
		
    /*        		String sql="select * from (select count(*) value,'Un Allocated' status,'UAL' relodestatus  "
            				+ "  from gl_traffic where isallocated=0 and status in (0,3) and TRAFFIC_DATE between   '"+sqlfromdate+"' and  '"+sqltodate+"' ) aa   union all   "
            				+ "  (select count(*) VALUE,'Allocated(Not Invoiced )' status,'ANI' relodestatus from gl_traffic where isallocated=1  "
            				+ "   and inv_no=0 and status in (0,3) and TRAFFIC_DATE between   '"+sqlfromdate+"' and  '"+sqltodate+"') union all  (select count(*) VALUE,'Invoiced' status,'AIN' relodestatus from gl_traffic  "
            				+ "   where isallocated=1 and inv_no>0 and status in (1) and TRAFFIC_DATE between   '"+sqlfromdate+"' and  '"+sqltodate+"') union all  "
            				+ "  (select count(*) VALUE,'Posted' status,'POS' relodestatus from gl_traffic  "
            				+ "    where postdocno>0 and isallocated=1 and inv_no>0 and status in (1) and TRAFFIC_DATE between   '"+sqlfromdate+"' and  '"+sqltodate+"') "
            						+ "union all select count(*) value,'Received' status from gl_invm m\r\n" + 
            						"inner join (select sum(amount) amt,rdocno from gl_invd where chid in (9,15) group by rdocno) d on m.doc_no=d.rdocno\r\n" + 
            						"inner join my_jvtran j on m.tr_no=j.tr_no and m.acno=j.acno and d.amt=j.dramount where (j.dramount-j.out_amount)=0 ";
            
            		*/
            		String sql="select b.value value,b.status,b.relodestatus from"
            				+ " (select * from (select count(*) value,'Fleet Not Recognize' status,'FNR' relodestatus from gl_traffic"
            				+ " where isallocated=0 and status in (0,3) and  reason  like  '%Fleet Not Recognize%' and "
            				+ "  TRAFFIC_DATE between  '"+sqlfromdate+"' and  '"+sqltodate+"' "+sqlticketno+" "+sqltest+") s "
            				+ " union all "
            				+ " (select count(*) value,'Un Allocated' status,'UAL' relodestatus    from gl_traffic where isallocated=0  "
            				+ " and status in (0,3) and coalesce(reason,'0') not like  '%Fleet Not Recognize%'  and"
            				+ " TRAFFIC_DATE between  '"+sqlfromdate+"' and  '"+sqltodate+"' "+sqlticketno+" "+sqltest+") "
            				+ " union all"
            				+ " (select count(*) VALUE,'Allocated(Not Invoiced )' status,'ANI' relodestatus from gl_traffic "
            				+ " where isallocated=1 and inv_no=0 and status in (0,3) and TRAFFIC_DATE between  '"+sqlfromdate+"' and  '"+sqltodate+"' "+sqlticketno+" "+sqltest+")"
            				+ " union all"
            				+ " (select count(*) VALUE,'Invoiced' status,'AIN' relodestatus from gl_traffic    "
            				+ " where isallocated=1 and inv_no>0 and status in (1) and TRAFFIC_DATE between   '"+sqlfromdate+"' and  '"+sqltodate+"' "+sqlticketno+" "+sqltest+")"
            				+ " union all"
            				+ " (select count(*) value,'Received' status ,'RES' relodestatus from gl_traffic  t"
            				+ " inner join gl_invm m on    m.doc_no=t.inv_no inner join (select sum(amount) amt,rdocno from gl_invd "
            				+ " where chid in (9,15) group by rdocno) d on m.doc_no=d.rdocno inner join my_jvtran j on m.tr_no=j.tr_no and m.acno=j.acno"
            				+ " where (j.dramount-j.out_amount)=0    and t.isallocated=1 and t.inv_no>0  "
            				+ "   and t.status in (1) and t.TRAFFIC_DATE between   '"+sqlfromdate+"' and  '"+sqltodate+"' "+sqlticketno+" "+sqltest+")"
            				+ " union all"
            				+ " select count(*) value,'ALL' status, 'ALL' relodestatus from gl_traffic"
            				+ " where TRAFFIC_DATE between  '"+sqlfromdate+"' and  '"+sqltodate+"' "+sqlticketno+" "+sqltest+") b "; 
            		
            		// and d.amt=j.dramount
            		// System.out.println("------------"+sql);
            		
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
     				stmtVeh.close();
     				conn.close();
            	
		}
		catch(Exception e){
			conn.close();
			
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
	
	public JSONArray masterdetails(String code,String fromdate,String todate,String ticketno) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        if(code.equalsIgnoreCase("")){
			return RESULTDATA;
		}
        Connection conn = null;
       
        
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
        
     	String sqlticketno="";
        if(!ticketno.equalsIgnoreCase("")){
        	sqlticketno+=" and t.ticket_no="+ticketno;
        }
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmtVeh = conn.createStatement ();  // UAL - UNallocated ,ANI - allocated not  Invoiced, AIN- allocated Invoiced // POS -traffic posted RES - Received
			// System.out.println("-----code------"+code);
			ClsTrafficfineDAO trafficcommon=new ClsTrafficfineDAO();
			double govfees=trafficcommon.getGovFees(conn);
			if(code.equalsIgnoreCase("FNR"))
			{
				String sql="select if(ac.ser_default=0,ac.per_trafficharge,0) trafficsrvc,veh.ch_no,t.tcno,t.regno, t.fleetno ,t.source, t.ticket_no ,t.traffic_date ,t.time,t.location, convert(coalesce(if(fine_source like '%DUBAI%' && "+
				" "+govfees+">0,amount+"+govfees+",amount),''),char(100)) amount,t.fine_source,vh.code_name from gl_traffic t left join gl_vehplate vh on "+
				" vh.doc_no=t.pcolor left join gl_vehmaster veh on t.fleetno=veh.fleet_no left join my_acbook ac on (t.emp_id=ac.cldocno and t.emp_type=ac.dtype) where t.isallocated=0 and t.status in (0,3) and  reason  like  '%Fleet Not Recognize%' and TRAFFIC_DATE between   "+
				" '"+sqlfromdate+"' and  '"+sqltodate+"'"+sqlticketno;
//			    System.out.println("----1--------"+sql);
           		ResultSet resultSet = stmtVeh.executeQuery(sql);
        		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
 				stmtVeh.close();
			     	
		 	}			  
				  
				  
				  
	 else if(code.equalsIgnoreCase("UAL"))
		{
            		String sql="select if(ac.ser_default=0,ac.per_trafficharge,0) trafficsrvc,veh.ch_no,t.tcno,regno, fleetno ,source, ticket_no ,traffic_date ,time,location, convert(coalesce(if(fine_source like '%DUBAI%' && "+govfees+">0,amount+"+govfees+",amount),''),char(100)) amount,fine_source,vh.code_name from gl_traffic t left join gl_vehplate vh on vh.doc_no=t.pcolor  "
            				+ "  left join gl_vehmaster veh on t.fleetno=veh.fleet_no left join my_acbook ac on (t.emp_id=ac.cldocno and t.emp_type=ac.dtype) where isallocated=0 and t.status in (0,3) and coalesce(reason,'0') not like  '%Fleet Not Recognize%' and TRAFFIC_DATE between   '"+sqlfromdate+"' and  '"+sqltodate+"'"+sqlticketno;
            		//System.out.println("----2--------"+sql);
               		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
     				stmtVeh.close();
     	
		}
		
		else if(code.equalsIgnoreCase("ANI"))
		{
     				
     				/*String sql="select   regno, fleetno ,source, ticket_no ,traffic_date ,location, convert(coalesce(amount,''),char(100)) amount from gl_traffic   "
     						+ " where isallocated=1 and inv_no=0 and status in (0,3);";
     				*/
     				
     				String sql=" select  if(ac.ser_default=0,ac.per_trafficharge,0) trafficsrvc,veh.ch_no,t.tcno, case when t.rtype in  ('RA','RD','RW','RF','RM') then 'RENTAL AGRREMENT' when  "
     						+ " t.rtype in ('LA','LC') then 'LEASE AGRREMENT' else  st.st_desc end as 'dtypedesc',  "
     						+ "	case when t.rtype in ('RM','RA', 'RD','RW','RF') then ragmt.voc_no when  "
     						+ " t.rtype in ('LA','LC')  then lagmt.voc_no else t.ra_no end as 'rano',t.regno, coalesce(ac.refname,sa.sal_name) refname, "
     						+ " t.fleetno ,t.source, t.ticket_no ,t.traffic_date ,time,t.location, convert(coalesce(if(t.fine_source like '%DUBAI%' && "+govfees+">0,t.amount+"+govfees+",t.amount),''),char(100)) amount,fine_source,vh.code_name "
     					+ " from gl_traffic t   left join gl_ragmt ragmt on  (t.ra_no=ragmt.doc_no and t.rtype in ('RA','RD','RW','RF','RM'))  "
     						+ "	left join gl_lagmt  lagmt on  (t.ra_no=lagmt.doc_no and t.rtype in ('LA','LC')) left join gl_status st on t.rtype=st.Status  left join gl_vehplate vh on vh.doc_no=t.pcolor left join my_acbook ac on ac.doc_no=t.emp_id and ac.dtype=t.emp_type  left join my_salesman sa on sa.doc_no=t.emp_id and sa.sal_type=t.emp_type "
     						+ "  left join gl_vehmaster veh on t.fleetno=veh.fleet_no where t.isallocated=1 and t.inv_no=0 and t.status in (0,3) and TRAFFIC_DATE between   '"+sqlfromdate+"' and  '"+sqltodate+"'"+sqlticketno;
     				//System.out.println("-----3-------"+sql);
     				

               		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
     				stmtVeh.close();
		}
		
		else if(code.equalsIgnoreCase("AIN"))
		{
		/*	String sql="select regno, fleetno ,source, ticket_no ,traffic_date ,location, convert(coalesce(amount,''),char(100)) amount  from gl_traffic   "
					+ " where isallocated=1 and inv_no>0 and status in (1);";*/
			
			
			String sql="select if(ac.ser_default=0,ac.per_trafficharge,0) trafficsrvc,veh.ch_no,t.tcno, coalesce(m.voc_no,t.inv_no) invno,coalesce(t.inv_type,'') invtype,case when t.rtype in  ('RA','RD','RW','RF','RM') then 'RENTAL AGRREMENT' when  "
					+ " t.rtype in ('LA','LC') then 'LEASE AGRREMENT' else  st.st_desc end as 'dtypedesc', "
					+ " case when t.rtype in ('RM','RA', 'RD','RW','RF') then ragmt.voc_no when  "
					+ " t.rtype in ('LA','LC')  then lagmt.voc_no else t.ra_no end as 'rano',t.regno,  coalesce(ac.refname,sa.sal_name) refname, "
					+ " t.fleetno ,t.source, t.ticket_no ,t.traffic_date ,time,t.location, convert(coalesce(if(t.fine_source like '%DUBAI%' && "+govfees+">0,t.amount+"+govfees+",t.amount),''),char(100)) amount,fine_source,vh.code_name  "
					+ " from gl_traffic t   left join gl_ragmt ragmt on (t.ra_no=ragmt.doc_no and t.rtype in ('RA','RD','RW','RF','RM'))  "
					+ " left join gl_lagmt  lagmt on (t.ra_no=lagmt.doc_no and t.rtype in ('LA','LC')) left join gl_status st on t.rtype=st.Status  "
					+ " left join gl_invm m on m.doc_no=t.inv_no and t.inv_type='INV' left join gl_vehplate vh on vh.doc_no=t.pcolor left join my_acbook ac on ac.doc_no=t.emp_id and ac.dtype=t.emp_type left join my_salesman sa on sa.doc_no=t.emp_id and sa.sal_type=t.emp_type"
					+ "  left join gl_vehmaster veh on t.fleetno=veh.fleet_no where t.isallocated=1 and t.inv_no>0 and t.status in (1) and TRAFFIC_DATE between   '"+sqlfromdate+"' and  '"+sqltodate+"' "+sqlticketno;
		 
			//System.out.println("-----4-------"+sql);
       		ResultSet resultSet = stmtVeh.executeQuery(sql);
    		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
				stmtVeh.close();
		}
		
		else if(code.equalsIgnoreCase("RES"))
		{
	 
			System.out.println("Inside RES");
			
			String sql="select  if(ac.ser_default=0,ac.per_trafficharge,0) trafficsrvc,veh.ch_no,t.tcno,vh.code_name,j1.date postdate,t.postdocno,r1.doc_no receiptno,r1.date receiptdate,if(j.out_amount>t.amount,t.amount,j.out_amount) out_amount,coalesce(m.voc_no,t.inv_no) invno,coalesce(t.inv_type,'') invtype,case when t.rtype in  ('RA','RD','RW','RF','RM') then 'RENTAL AGRREMENT' when  "
					+ " t.rtype in ('LA','LC') then 'LEASE AGRREMENT' else  st.st_desc end as 'dtypedesc', "
					+ " case when t.rtype in ('RM','RA', 'RD','RW','RF') then ragmt.voc_no when  "
					+ " t.rtype in ('LA','LC')  then lagmt.voc_no else t.ra_no end as 'rano',t.regno, coalesce(ac.refname,sa.sal_name) refname, "
					+ " t.fleetno ,t.source, t.ticket_no ,t.traffic_date ,time,t.location, convert(coalesce(if(t.fine_source like '%DUBAI%' && "+govfees+">0,t.amount+"+govfees+",t.amount),''),char(100)) amount,fine_source  "
					+ " from gl_traffic t   left join gl_ragmt ragmt on (t.ra_no=ragmt.doc_no and t.rtype in ('RA','RD','RW','RF','RM'))  "
					+ " left join gl_lagmt  lagmt on (t.ra_no=lagmt.doc_no and t.rtype in ('LA','LC')) left join gl_status st on t.rtype=st.Status  "
					+ "  left join gl_vehmaster veh on t.fleetno=veh.fleet_no left join gl_invm m on m.doc_no=t.inv_no  and t.inv_type='INV'  "
					+ " inner join (select sum(amount) amt,rdocno from gl_invd where chid in (9,15) group by rdocno) d on m.doc_no=d.rdocno \r\n"  
					+ " inner join my_jvtran j on m.tr_no=j.tr_no and m.acno=j.acno inner join  my_outd o on j.tranid=o.ap_trid "
					+ " inner join  my_jvtran r1 on o.tranid=r1.tranid "
					+ " left join my_acbook ac on ac.doc_no=t.emp_id and ac.dtype=t.emp_type  "
					+ " left join my_salesman sa on sa.doc_no=t.emp_id and sa.sal_type=t.emp_type"
					+ " left join my_jvtran j1 on j1.tr_no=t.posttrno  and j1.acno=(select acno from gl_invmode where idno=9) left join gl_vehplate vh on vh.doc_no=t.pcolor "
					+ " where (j.dramount-j.out_amount)=0 and t.isallocated=1 and t.inv_no>0 and t.status in (1) and TRAFFIC_DATE between   '"+sqlfromdate+"' and  '"+sqltodate+"' "+sqlticketno;
			 System.out.println("-----asdasd res------"+sql);

       		ResultSet resultSet = stmtVeh.executeQuery(sql);
    		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
				stmtVeh.close();
			
		}
		
		
		else if(code.equalsIgnoreCase("POS")) // 
		{
		/*	String sql="select regno, fleetno ,source, ticket_no ,traffic_date ,location, convert(coalesce(amount,''),char(100)) amount  from gl_traffic   "
					+ " where isallocated=1 and inv_no>0 and status in (1);";*/
			
			
			String sql="select  if(ac.ser_default=0,ac.per_trafficharge,0) trafficsrvc,postjv.date postdate,veh.ch_no,t.tcno, vh.code_name,t.postdocno,coalesce(m.voc_no,t.inv_no) invno,coalesce(t.inv_type,'') invtype,case when t.rtype in  ('RA','RD','RW','RF','RM') then 'RENTAL AGRREMENT' when  "
					+ " t.rtype in ('LA','LC') then 'LEASE AGRREMENT' else  st.st_desc end as 'dtypedesc', "
					+ " case when t.rtype in ('RM','RA', 'RD','RW','RF') then ragmt.voc_no when  "
					+ " t.rtype in ('LA','LC')  then lagmt.voc_no else t.ra_no end as 'rano',t.regno, coalesce(ac.refname,sa.sal_name) refname, "
					+ " t.fleetno ,t.source, t.ticket_no ,t.traffic_date ,time,t.location, convert(coalesce(if(t.fine_source like '%DUBAI%' && "+govfees+">0,t.amount+"+govfees+",t.amount),''),char(100)) amount,fine_source  "
					+ " from gl_traffic t   left join gl_ragmt ragmt on (t.ra_no=ragmt.doc_no and t.rtype in ('RA','RD','RW','RF','RM'))  "
					+ "  left join gl_vehmaster veh on t.fleetno=veh.fleet_no left join gl_lagmt  lagmt on (t.ra_no=lagmt.doc_no and t.rtype in ('LA','LC')) left join gl_status st on t.rtype=st.Status  "
					+ " left join gl_invm m on m.doc_no=t.inv_no and t.inv_type='INV'   left join my_acbook ac on ac.doc_no=t.emp_id and ac.dtype=t.emp_type  left join my_salesman sa on sa.doc_no=t.emp_id and sa.sal_type=t.emp_type left join gl_vehplate vh on vh.doc_no=t.pcolor  left join my_jvma postjv on t.posttrno=postjv.tr_no where t.postdocno>0 "
					+ " and t.isallocated=1 and t.inv_no>0 and t.status in (1) and TRAFFIC_DATE between   '"+sqlfromdate+"' and  '"+sqltodate+"' "+sqlticketno;
			//System.out.println("-----asdasd--sssssss----"+sql);
			 
       		ResultSet resultSet = stmtVeh.executeQuery(sql);
    		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
				stmtVeh.close();
		}
		else if(code.equalsIgnoreCase("ALL"))
		{
			String sql="select if(ac.ser_default=0,ac.per_trafficharge,0) trafficsrvc,veh.ch_no,t.tcno,j1.date postdate,coalesce(m.voc_no,t.inv_no) invno,t.ra_no  as 'rano',st1.st_desc as 'dtypedesc',coalesce(t.inv_type,'') invtype,t.postdocno,coalesce(ac.refname,sa.sal_name) refname,vh.code_name,o.doc_no receiptno,o.date receiptdate,if(j.out_amount>t.amount,t.amount,j.out_amount) out_amount,regno, fleetno ,source, ticket_no ,traffic_date ,time,location,convert(coalesce(amount,''),char(100)) amount,fine_source from gl_traffic t"
					+ "  left join gl_vehmaster veh on t.fleetno=veh.fleet_no left join gl_invm m on m.doc_no=t.inv_no and t.inv_type='INV'  "
					+ " left join my_jvtran j on m.tr_no=j.tr_no and m.acno=j.acno left join "
					+ " (select j.doc_no,j.date,ap_trid from my_outd d inner join "
					+ " my_jvtran j on d.tranid=j.tranid group by d.ap_trid) o on j.tranid=o.ap_trid  "
					+ " left join my_acbook ac on ac.doc_no=t.emp_id and ac.dtype=t.emp_type "
					+ "left join my_jvtran j1 on j1.tr_no=t.posttrno  and j1.acno=(select acno from gl_invmode where idno=9) "
					+ "left join gl_status st on t.rtype=st.Status "
    				+ "  left join gl_status st1 on t.rtype=st1.Status left join my_salesman sa on sa.doc_no=t.emp_id and sa.sal_type=t.emp_type left join gl_vehplate vh on vh.doc_no=t.pcolor where TRAFFIC_DATE between   '"+sqlfromdate+"' and  '"+sqltodate+"'"+sqlticketno;
    				/*+ " union all "
                    + " select j1.date postdate,t.postdocno,j.doc_no receiptno,j.date receiptdate,j.out_amount,regno, fleetno ,source, ticket_no ,traffic_date ,time,location,convert(coalesce(amount,''),char(100)) amount,fine_source "
                    + " from gl_traffic t left join gl_invm m on m.doc_no=t.inv_no"
                    + " inner join my_jvtran j on m.tr_no=j.tr_no and m.acno=j.acno "
                    + " left join my_jvtran j1 on j1.tr_no=t.posttrno "
                    + "where (j.dramount-j.out_amount)=0 and t.isallocated=1 and t.inv_no>0 "
                    + " and t.status in (1) and TRAFFIC_DATE between   '"+sqlfromdate+"' and  '"+sqltodate+"' ";*/
			// System.out.println("-----asdasd--sssssss----"+sql);
		        	ResultSet resultSet = stmtVeh.executeQuery(sql);
   		            RESULTDATA=ClsCommon.convertToJSON(resultSet);
			    	stmtVeh.close();
		}
     			
            	
        conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
			
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
	
	
	public JSONArray masterdetailsExcel(String code,String fromdate,String todate,String ticketno) throws SQLException {

		 JSONArray RESULTDATA=new JSONArray();
	        if(code.equalsIgnoreCase("")){
				return RESULTDATA;
			}
	        Connection conn = null;
	       
	        
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
	     	String sqlticketno="";
	        if(!ticketno.equalsIgnoreCase("")){
	        	sqlticketno+=" and t.ticket_no="+ticketno;
	        }
	        
			try {
					 conn = ClsConnection.getMyConnection();
					  Statement stmtVeh = conn.createStatement ();  // UAL - UNallocated ,ANI - allocated not  Invoiced, AIN- allocated Invoiced // POS -traffic posted RES - Received
					  
					  
					 // System.out.println("-----code------"+code);
					  ClsTrafficfineDAO trafficcommon=new ClsTrafficfineDAO();
					  double govfees=trafficcommon.getGovFees(conn);
		 if(code.equalsIgnoreCase("FNR"))
			 {
				            		String sql="select t.regno 'Reg No', t.ticket_no 'Ticket No',t.tcno 'Tc No',t.fleetno 'Fleet No',vh.code_name 'Plate Code',coalesce(veh.ch_no,'') 'Chassis No',date_format(t.traffic_date,'%d-%m-%Y') 'Traffic Date',t.time 'Traffic Time',t.location 'Location',t.source 'Source',convert(coalesce(if(fine_source like '%DUBAI%' && "+govfees+">0,amount+"+govfees+",amount),''),char(100)) 'Amount',if(ac.ser_default=0,ac.per_trafficharge,0) 'Service Charge',t.fine_source 'Fine Source' from gl_traffic t left join gl_vehplate vh on vh.doc_no=t.pcolor "
				            				+ "  left join gl_vehmaster veh on t.fleetno=veh.fleet_no left join my_acbook ac on (t.emp_id=ac.cldocno and t.emp_type='CRM' and ac.cldocno='CRM') where t.isallocated=0 and t.status in (0,3) and  reason  like  '%Fleet Not Recognize%' and TRAFFIC_DATE between   '"+sqlfromdate+"' and  '"+sqltodate+"'"+sqlticketno;
				            		System.out.println("----1--------"+sql);
				               		ResultSet resultSet = stmtVeh.executeQuery(sql);
				            		 RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
				     				stmtVeh.close();
				     	
			 	}			  
					  
					  
					  
		 else if(code.equalsIgnoreCase("UAL"))
			{
	            		String sql="select regno 'Reg No',ticket_no 'Ticket No',t.tcno 'Tc No',fleetno 'Fleet No',vh.code_name 'Plate Code',veh.ch_no 'Chassis No', date_format(t.traffic_date,'%d-%m-%Y') 'Traffic Date',t.time 'Traffic Time',t.location 'Location',t.source 'Source',convert(coalesce(if(fine_source like '%DUBAI%' && "+govfees+">0,amount+"+govfees+",amount),''),char(100)) 'Amount',if(ac.ser_default=0,ac.per_trafficharge,0) 'Service Charge',t.fine_source 'Fine Source' from gl_traffic t left join gl_vehplate vh on vh.doc_no=t.pcolor  "
	            				+ "  left join gl_vehmaster veh on t.fleetno=veh.fleet_no left join my_acbook ac on (t.emp_id=ac.cldocno and t.emp_type='CRM' and ac.cldocno='CRM') where isallocated=0 and t.status in (0,3) and coalesce(reason,'0') not like  '%Fleet Not Recognize%' and TRAFFIC_DATE between   '"+sqlfromdate+"' and  '"+sqltodate+"'"+sqlticketno;
	            		System.out.println("----2--------"+sql);
	               		ResultSet resultSet = stmtVeh.executeQuery(sql);
	            		 RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
	     				stmtVeh.close();
	     	
			}
			
			else if(code.equalsIgnoreCase("ANI"))
			{
	     				
	     				/*String sql="select   regno, fleetno ,source, ticket_no ,traffic_date ,location, convert(coalesce(amount,''),char(100)) amount from gl_traffic   "
	     						+ " where isallocated=1 and inv_no=0 and status in (0,3);";
	     				*/
	     				
	     				String sql="select case when t.rtype in ('RM','RA', 'RD','RW','RF') then ragmt.voc_no when  "
	     						+ " t.rtype in ('LA','LC')  then lagmt.voc_no else t.ra_no end as 'RA No',case when t.rtype in  ('RA','RD','RW','RF','RM') then "+
	     						" 'RENTAL AGRREMENT' when t.rtype in ('LA','LC') then 'LEASE AGRREMENT' else  st.st_desc end as 'Type',  "
	     						+ " coalesce(ac.refname,sa.sal_name) 'Client/Employee',t.regno 'Reg No',t.ticket_no 'Ticket No',t.tcno 'Tc No', "
	     						+ " t.fleetno 'Fleet No',vh.code_name 'Plate Code',veh.ch_no 'Chassis No',date_format(t.traffic_date,'%d-%m-%Y') 'Traffic Date',"+
	     						" t.time 'Traffic Time',t.location 'Location',t.source 'Source',convert(coalesce(if(t.fine_source like '%DUBAI%' && "+govfees+">0,t.amount+"+govfees+",t.amount),''),char(100)) 'Amount',if(ac.ser_default=0,ac.per_trafficharge,0) 'Service Charge',fine_source 'Fine Source' "
	     					+ " from gl_traffic t   left join gl_ragmt ragmt on  (t.ra_no=ragmt.doc_no and t.rtype in ('RA','RD','RW','RF','RM'))  "
	     						+ "	left join gl_lagmt  lagmt on  (t.ra_no=lagmt.doc_no and t.rtype in ('LA','LC')) left join gl_status st on t.rtype=st.Status  left join gl_vehplate vh on vh.doc_no=t.pcolor left join my_acbook ac on ac.doc_no=t.emp_id and ac.dtype=t.emp_type  left join my_salesman sa on sa.doc_no=t.emp_id and sa.sal_type=t.emp_type "
	     						+ "  left join gl_vehmaster veh on t.fleetno=veh.fleet_no where t.isallocated=1 and t.inv_no=0 and t.status in (0,3) and TRAFFIC_DATE between   '"+sqlfromdate+"' and  '"+sqltodate+"'"+sqlticketno;
	     				System.out.println("-----3-------"+sql);
	     				

	               		ResultSet resultSet = stmtVeh.executeQuery(sql);
	            		 RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
	     				stmtVeh.close();
			}
			
			else if(code.equalsIgnoreCase("AIN"))
			{
			/*	String sql="select regno, fleetno ,source, ticket_no ,traffic_date ,location, convert(coalesce(amount,''),char(100)) amount  from gl_traffic   "
						+ " where isallocated=1 and inv_no>0 and status in (1);";*/
				
				
				String sql="select coalesce(m.voc_no,t.inv_no) 'Inv No',coalesce(t.inv_type,'') 'Inv Type',case when t.rtype in ('RM','RA', 'RD','RW','RF') then ragmt.voc_no when  "
						+ " t.rtype in ('LA','LC')  then lagmt.voc_no else t.ra_no end as 'RA No',case when t.rtype in  ('RA','RD','RW','RF','RM') then 'RENTAL AGRREMENT' when  "
						+ " t.rtype in ('LA','LC') then 'LEASE AGRREMENT' else  st.st_desc end as 'Type',coalesce(ac.refname,sa.sal_name) 'Client/Employee', "
						+ " t.regno 'Reg No',t.ticket_no 'Ticket No',t.tcno 'Tc No',t.fleetno 'Fleet No',vh.code_name 'Plate Code',veh.ch_no 'Chassis No',date_format(t.traffic_date,'%d-%m-%Y') 'Traffic Date',"+
	     				" t.time 'Traffic Time',t.location 'Location',t.source 'Source',convert(coalesce(if(t.fine_source like '%DUBAI%' && "+govfees+">0,t.amount+"+govfees+",t.amount),''),char(100)) 'Amount',if(ac.ser_default=0,ac.per_trafficharge,0) 'Service Charge',fine_source 'Fine Source'"
						+ " from gl_traffic t   left join gl_ragmt ragmt on (t.ra_no=ragmt.doc_no and t.rtype in ('RA','RD','RW','RF','RM'))  "
						+ " left join gl_lagmt  lagmt on (t.ra_no=lagmt.doc_no and t.rtype in ('LA','LC')) left join gl_status st on t.rtype=st.Status  "
						+ " left join gl_invm m on m.doc_no=t.inv_no and t.inv_type='INV'   left join gl_vehplate vh on vh.doc_no=t.pcolor left join my_acbook ac on ac.doc_no=t.emp_id and ac.dtype=t.emp_type left join my_salesman sa on sa.doc_no=t.emp_id and sa.sal_type=t.emp_type"
						+ " left join gl_vehmaster veh on t.fleetno=veh.fleet_no where t.isallocated=1 and t.inv_no>0 and t.status in (1) and TRAFFIC_DATE between   '"+sqlfromdate+"' and  '"+sqltodate+"' "+sqlticketno;
			 
				System.out.println("-----4-------"+sql);
	       		ResultSet resultSet = stmtVeh.executeQuery(sql);
	    		 RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
					stmtVeh.close();
			}
			
			else if(code.equalsIgnoreCase("RES"))
			{
		 
				
				
				String sql="select coalesce(m.voc_no,t.inv_no) 'Inv No',coalesce(t.inv_type,'') 'Inv Type',case when t.rtype in ('RM','RA', 'RD','RW','RF') then ragmt.voc_no when  "
						+ " t.rtype in ('LA','LC')  then lagmt.voc_no else t.ra_no end as 'RA No',case when t.rtype in  ('RA','RD','RW','RF','RM') then 'RENTAL AGRREMENT' when  "
						+ " t.rtype in ('LA','LC') then 'LEASE AGRREMENT' else  st.st_desc end as 'Type',coalesce(ac.refname,sa.sal_name) 'Client/Employee',t.regno 'Reg No',"+
						"  t.ticket_no 'Ticket No',t.tcno 'Tc No',t.fleetno 'Fleet No',vh.code_name 'Plate Code',veh.ch_no 'Chassis No',"+
						" date_format(t.traffic_date,'%d-%m-%Y') 'Traffic Date',t.time 'Traffic Time',t.location 'Location',t.source 'Source',"+
						" convert(coalesce(if(t.fine_source like '%DUBAI%' && "+govfees+">0,t.amount+"+govfees+",t.amount),''),char(100)) 'Amount',"+
						" if(ac.ser_default=0,ac.per_trafficharge,0) 'Service Charge',r1.doc_no 'Reciept No',r1.date 'Reciept Date',if(j.out_amount>t.amount,t.amount,j.out_amount) 'Received Amt',fine_source 'Fine Source' "
						+ " from gl_traffic t left join gl_vehmaster veh on t.fleetno=veh.fleet_no left join gl_ragmt ragmt on (t.ra_no=ragmt.doc_no and t.rtype in ('RA','RD','RW','RF','RM'))  "
						+ " left join gl_lagmt  lagmt on (t.ra_no=lagmt.doc_no and t.rtype in ('LA','LC')) left join gl_status st on t.rtype=st.Status  "
						+ " left join gl_invm m on m.doc_no=t.inv_no  and t.inv_type='INV'   "
						+ " inner join (select sum(amount) amt,rdocno from gl_invd where chid in (9,15) group by rdocno) d on m.doc_no=d.rdocno \r\n"  
						+ " inner join my_jvtran j on m.tr_no=j.tr_no and m.acno=j.acno "
						+ " inner join  my_outd o on j.tranid=o.ap_trid  inner join  my_jvtran r1 on o.tranid=r1.tranid"
						+ " left join my_acbook ac on ac.doc_no=t.emp_id and ac.dtype=t.emp_type  "
						+ "left join my_salesman sa on sa.doc_no=t.emp_id and sa.sal_type=t.emp_type"
						+ " left join my_jvtran j1 on j1.tr_no=t.posttrno  and j1.acno=(select acno from gl_invmode where idno=9) left join gl_vehplate vh on vh.doc_no=t.pcolor "
						+ " where (j.dramount-j.out_amount)=0 and t.isallocated=1 and t.inv_no>0 and t.status in (1) and TRAFFIC_DATE between   '"+sqlfromdate+"' and  '"+sqltodate+"' "+sqlticketno;
//				System.out.println("-----asdasd------"+sql);

	       		ResultSet resultSet = stmtVeh.executeQuery(sql);
	    		 RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
					stmtVeh.close();
				
			}
			
			
			else if(code.equalsIgnoreCase("POS")) // 
			{
			/*	String sql="select regno, fleetno ,source, ticket_no ,traffic_date ,location, convert(coalesce(amount,''),char(100)) amount  from gl_traffic   "
						+ " where isallocated=1 and inv_no>0 and status in (1);";*/
				/*,,,coalesce(t.inv_type,'') invtype,, "
						+ " ,, , "
						+ "  ,t.source,  ,t.traffic_date ,time,t.location, convert(coalesce(if(t.fine_source like '%DUBAI%' && "+govfees+">0,t.amount+"+govfees+",t.amount),''),char(100)) amount,fine_source
*/				
				String sql="select t.postdocno 'Post Doc No',date_format(postjv.date,'%d-%m-%Y') 'Post Date',coalesce(m.voc_no,t.inv_no) 'Inv No',t.inv_type 'Inv Type' ,case when t.rtype in ('RM','RA', 'RD','RW','RF') then ragmt.voc_no when  "
						+ " t.rtype in ('LA','LC')  then lagmt.voc_no else t.ra_no end as 'RA No',case when t.rtype in  ('RA','RD','RW','RF','RM') then 'RENTAL AGRREMENT' when  "
						+ " t.rtype in ('LA','LC') then 'LEASE AGRREMENT' else  st.st_desc end as 'Type',coalesce(ac.refname,sa.sal_name) 'Client/Employee',t.regno 'Reg No',"+
						" t.ticket_no 'Ticket No',t.tcno 'Tc No',t.fleetno 'Fleet No',vh.code_name 'Plate Code',veh.ch_no 'Chassis No',date_format(t.traffic_date,'%d-%m-%Y') 'Traffic Date',"+
	     				" t.time 'Traffic Time',t.location 'Location',t.source 'Source',convert(coalesce(if(t.fine_source like '%DUBAI%' && "+govfees+">0,t.amount+"+govfees+",t.amount),''),char(100)) 'Amount', if(ac.ser_default=0,ac.per_trafficharge,0) 'Service Charge',fine_source 'Fine Source'  "
						+ " from gl_traffic t left join gl_vehmaster veh on t.fleetno=veh.fleet_no  left join gl_ragmt ragmt on (t.ra_no=ragmt.doc_no and t.rtype in ('RA','RD','RW','RF','RM'))  "
						+ " left join gl_lagmt  lagmt on (t.ra_no=lagmt.doc_no and t.rtype in ('LA','LC')) left join gl_status st on t.rtype=st.Status  "
						+ " left join gl_invm m on m.doc_no=t.inv_no and t.inv_type='INV'   left join my_acbook ac on ac.doc_no=t.emp_id and ac.dtype=t.emp_type  left join "+
						" my_salesman sa on sa.doc_no=t.emp_id and sa.sal_type=t.emp_type left join gl_vehplate vh on vh.doc_no=t.pcolor left join my_jvma postjv on t.posttrno=postjv.tr_no where t.postdocno>0 "
						+ " and t.isallocated=1 and t.inv_no>0 and t.status in (1) and TRAFFIC_DATE between   '"+sqlfromdate+"' and  '"+sqltodate+"' "+sqlticketno;
				System.out.println("-----asdasd--sssssss----"+sql);
				 
	       		ResultSet resultSet = stmtVeh.executeQuery(sql);
	    		 RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
					stmtVeh.close();
			}
			else if(code.equalsIgnoreCase("ALL"))
			{
				/*,j1.date postdate,coalesce(m.voc_no,t.inv_no) invno,t.ra_no  as 'rano',st1.st_desc as 'dtypedesc',coalesce(t.inv_type,'') invtype,t.postdocno,coalesce(ac.refname,sa.sal_name) refname,,o.doc_no receiptno,o.date receiptdate,j.out_amount 'Collected Amt',,  ,source,  ,traffic_date ,time,location,convert(coalesce(amount,''),char(100)) amount,fine_source*/
				String sql="select t.postdocno 'Post Doc No',date_format(j1.date,'%d-%m-%Y') 'Post Date',regno 'Reg No',ticket_no 'Ticket No',t.tcno 'Tc No',fleetno 'Fleet No',vh.code_name 'Plate Code',veh.ch_no 'Chassis No',date_format(t.traffic_date,'%d-%m-%Y') 'Traffic Date',"+
	     				" t.time 'Traffic Time',t.location 'Location',t.source 'Source',convert(coalesce(if(t.fine_source like '%DUBAI%' && "+govfees+">0,t.amount+"+govfees+",t.amount),''),char(100)) 'Amount', if(ac.ser_default=0,ac.per_trafficharge,0) 'Service Charge' , o.doc_no 'Receipt No',o.date 'Reciept Date' , "
	     						+ " if(j.out_amount>t.amount,t.amount,j.out_amount) 'Received Amt' ,fine_source 'Fine Source' from gl_traffic t"
						+ "  left join gl_vehmaster veh on t.fleetno=veh.fleet_no left join gl_invm m on m.doc_no=t.inv_no and t.inv_type='INV'   "
						+ " left join my_jvtran j on m.tr_no=j.tr_no and m.acno=j.acno  left join "
						+ " (select j.doc_no,j.date,ap_trid from my_outd d inner join  "
						+ " my_jvtran j on d.tranid=j.tranid group by d.ap_trid) o on j.tranid=o.ap_trid left "
						+ " join my_acbook ac on ac.doc_no=t.emp_id and ac.dtype=t.emp_type "
						+ "left join my_jvtran j1 on j1.tr_no=t.posttrno  and j1.acno=(select acno from gl_invmode where idno=9) "
						+ "left join gl_status st on t.rtype=st.Status "
	    				+ " left join gl_status st1 on t.rtype=st1.Status left join my_salesman sa on sa.doc_no=t.emp_id and sa.sal_type=t.emp_type left join gl_vehplate vh on vh.doc_no=t.pcolor where TRAFFIC_DATE between   '"+sqlfromdate+"' and  '"+sqltodate+"'"+sqlticketno;
	    				/*+ " union all "
	                    + " select j1.date postdate,t.postdocno,j.doc_no receiptno,j.date receiptdate,j.out_amount,regno, fleetno ,source, ticket_no ,traffic_date ,time,location,convert(coalesce(amount,''),char(100)) amount,fine_source "
	                    + " from gl_traffic t left join gl_invm m on m.doc_no=t.inv_no"
	                    + " inner join my_jvtran j on m.tr_no=j.tr_no and m.acno=j.acno "
	                    + " left join my_jvtran j1 on j1.tr_no=t.posttrno "
	                    + "where (j.dramount-j.out_amount)=0 and t.isallocated=1 and t.inv_no>0 "
	                    + " and t.status in (1) and TRAFFIC_DATE between   '"+sqlfromdate+"' and  '"+sqltodate+"' ";*/
				System.out.println("-----asdasd--sssssss----"+sql);
			        	ResultSet resultSet = stmtVeh.executeQuery(sql);
	   		            RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
				    	stmtVeh.close();
			}
	     			
	            	
	        conn.close();
			}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
				
			}
			//System.out.println(RESULTDATA);
	        return RESULTDATA;
	    }
	
	public JSONArray getTickets(String id,String fromdate,String todate) throws SQLException{
		JSONArray ticketarray=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return ticketarray;
		}
		Connection conn=null;
		try{
			conn=ClsConnection.getMyConnection();
			Statement stmt=conn.createStatement();
			java.sql.Date sqlfromdate=null,sqltodate=null;
			if(!fromdate.equalsIgnoreCase("")){
				sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
			}
			if(!todate.equalsIgnoreCase("")){
				sqltodate=ClsCommon.changeStringtoSqlDate(todate);
			}
			String strsql="select b.ticket_no ticketno,b.status,b.relodestatus from"+
			" (select * from (select ticket_no,'Fleet Not Recognize' status,'FNR' relodestatus from gl_traffic"+
			" where isallocated=0 and status in (0,3) and  reason  like  '%Fleet Not Recognize%' and"+
			" TRAFFIC_DATE between  '"+sqlfromdate+"' and '"+sqltodate+"') s"+
			" union all"+
			" (select ticket_no,'Un Allocated' status,'UAL' relodestatus    from gl_traffic where isallocated=0"+
			" and status in (0,3) and coalesce(reason,'0') not like  '%Fleet Not Recognize%'  and"+
			" TRAFFIC_DATE between  '"+sqlfromdate+"' and '"+sqltodate+"')"+
			" union all"+
			" (select ticket_no,'Allocated (Not Invoiced )' status,'ANI' relodestatus from gl_traffic"+
			" where isallocated=1 and inv_no=0 and status in (0,3) and TRAFFIC_DATE between  '"+sqlfromdate+"' and '"+sqltodate+"')"+
			" union all"+
			" (select ticket_no,'Invoiced' status,'AIN' relodestatus from gl_traffic"+
			" where isallocated=1 and inv_no>0 and status in (1) and TRAFFIC_DATE between  '"+sqlfromdate+"' and '"+sqltodate+"')"+
			" union all"+
			" (select ticket_no,'Received' status ,'RES' relodestatus from gl_traffic  t"+
			" inner join gl_invm m on    m.doc_no=t.inv_no inner join (select sum(amount) amt,rdocno from gl_invd"+
			" where chid in (9,15) group by rdocno) d on m.doc_no=d.rdocno inner join my_jvtran j on m.tr_no=j.tr_no and m.acno=j.acno"+
			" where (j.dramount-j.out_amount)=0    and t.isallocated=1 and t.inv_no>0"+
			" and t.status in (1) and t.TRAFFIC_DATE between  '"+sqlfromdate+"' and '"+sqltodate+"')) b";
			System.out.println("Ticket No Query: "+strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			ticketarray=ClsCommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return ticketarray;
	}
	public JSONArray getRegno(String id,String fromdate,String todate) throws SQLException{
		JSONArray ticketarray=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return ticketarray;
		}
		Connection conn=null;
		try{
			conn=ClsConnection.getMyConnection();
			Statement stmt=conn.createStatement();
			java.sql.Date sqlfromdate=null,sqltodate=null;
			if(!fromdate.equalsIgnoreCase("")){
				sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
			}
			if(!todate.equalsIgnoreCase("")){
				sqltodate=ClsCommon.changeStringtoSqlDate(todate);
			}
			String strsql=" select regno from gl_traffic  t where "+
			" t.TRAFFIC_DATE between  '"+sqlfromdate+"' and '"+sqltodate+"'";
			System.out.println("Reg No Query: "+strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			ticketarray=ClsCommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return ticketarray;
	}
}
