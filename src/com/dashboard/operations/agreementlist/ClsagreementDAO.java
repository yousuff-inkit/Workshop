package com.dashboard.operations.agreementlist;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;




public class ClsagreementDAO 
{
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();


    public JSONArray clentdetails() throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn =null;
        try {
			 conn = ClsConnection.getMyConnection();
			Statement stmtVeh = conn.createStatement ();
			
			String sql="select cldocno,refname from my_acbook where status=3 and dtype='CRM'  ";
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

    public JSONArray fleetdetails() throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn =null;
        try {
			 conn = ClsConnection.getMyConnection();
			Statement stmtVeh = conn.createStatement ();
			
			String sql="select fleet_no,flname,reg_no from gl_vehmaster where statu=3";
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
    public JSONArray groupdetails() throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        Connection conn = null;
       
        try {
			 conn = ClsConnection.getMyConnection();
			Statement stmtVeh = conn.createStatement ();
			
			String sql="select gname,doc_no from gl_vehgroup where status=3";
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
    public JSONArray modeldetails() throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        Connection conn =null;
       
        try {
			 conn = ClsConnection.getMyConnection();
			Statement stmtVeh = conn.createStatement ();
			
			String sql="select vtype,doc_no from gl_vehmodel where status=3";
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
    public JSONArray branddetails() throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        try {
			 conn = ClsConnection.getMyConnection();
			Statement stmtVeh = conn.createStatement ();
			
			String sql="select brand_name,doc_no from gl_vehbrand where status=3";
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
    
    public JSONArray detailsgrid(String brnchval,String fromdate,String todate,String cldocno,String status,String fleet, 
    		String group,String brand,String model,String type,String outchk,String inchk,String catid) throws SQLException {

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
     	
      	
    	String rsqltest="" , sqltest="";
    	if(!(status.equalsIgnoreCase("")|| status.equalsIgnoreCase("NA"))){
    		rsqltest=rsqltest+" and r.clstatus='"+status+"'";
    		sqltest=sqltest+" and l.clstatus='"+status+"'";
    	}
    	if(!(cldocno.equalsIgnoreCase("") || cldocno.equalsIgnoreCase("NA"))){
    		rsqltest=rsqltest+" and a.cldocno='"+cldocno+"'";
    		sqltest=sqltest+" and a.cldocno='"+cldocno+"'";
    	}
    	if(!(fleet.equalsIgnoreCase("")|| fleet.equalsIgnoreCase("NA"))){
    		rsqltest=rsqltest+" and r.fleet_no='"+fleet+"'";
    		sqltest=sqltest+" and if(l.perfleet=0,l.tmpfleet,l.perfleet)='"+fleet+"'";
    	}
    	if(!(group.equalsIgnoreCase("") || group.equalsIgnoreCase("NA"))){
    		rsqltest=rsqltest+" and g.doc_no='"+group+"'";
    		sqltest=sqltest+" and g.doc_no='"+group+"'";
    	}
    	if(!(model.equalsIgnoreCase("") || model.equalsIgnoreCase("NA"))){
    		rsqltest=rsqltest+" and mo.doc_no='"+model+"'";
    		sqltest=sqltest+" and mo.doc_no='"+model+"'";
    	}
    	if(!(brand.equalsIgnoreCase("")|| brand.equalsIgnoreCase("NA"))){
    		rsqltest=rsqltest+" and br.doc_no='"+brand+"'";
    		sqltest=sqltest+" and br.doc_no='"+brand+"'";
    	}
    	if(!(type.equalsIgnoreCase("") || type.equalsIgnoreCase("NA"))){
    		rsqltest=rsqltest+" and t.rentaltype='"+type+"' ";
    	}
    	if(!(catid.equalsIgnoreCase("") || catid.equalsIgnoreCase("NA"))){
    		rsqltest=rsqltest+" and a.catid='"+catid+"' ";
    	}
    	
    	
    	
    	if(!((brnchval.equalsIgnoreCase("a")) || (brnchval.equalsIgnoreCase("NA")))){
 			rsqltest+=" and r.brhid="+brnchval+"";
 			sqltest+=" and l.brhid='"+brnchval+"'";
 			
 		}
    	
    	
    	if(inchk.equalsIgnoreCase("IN"))
    	{
    		rsqltest+="	and  cs.indate between '"+sqlfromdate+"' and  '"+sqltodate+"' ";
    		sqltest+="	and  cs.indate between '"+sqlfromdate+"' and  '"+sqltodate+"' ";
    		
    	}
    	else
    	{
    		
    		rsqltest+="	and  r.odate between '"+sqlfromdate+"' and  '"+sqltodate+"' ";
    		sqltest+="	and  l.outdate between '"+sqlfromdate+"' and  '"+sqltodate+"' ";
    	}
    	
    	

    	
    	Connection conn =  null;
    	try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement (); 
			

            		
            		String sql ="(select 'Rent' as rltype,r.voc_no doc,r.fleet_no,v.FLNAME vehdetails,v.reg_no,r.ofleet_no ofno,v1.reg_no oreg_no,a.refname,a.contactperson,\r\n" + 
            				"cdr.name drname,a.per_mob,t.rentaltype,r.odate,r.otime,r.ddate,r.dtime,convert(coalesce(r.refno,''),char(30)) refnos,r.mrano mrno,convert(coalesce(cs.indate,''),char(30)) indate,\r\n" + 
            				"coalesce(cs.intime,'') intime,tc.rate rent,tc.cdw,tc.pai,\r\n" + 
            				"convert(if(r.invdate=r.odate,r.invdate,DATE_SUB(r.invdate,INTERVAL 1 DAY)),char(30)) AS invdate,\r\n" + 
            				"coalesce((select invoiced from gl_rcalc where rdocno=r.doc_no and invno >0 and idno=1 and rowno=(select max(rowno) from gl_rcalc where rdocno=r.doc_no and invno >0 and idno=1)),0) invRental,\r\n" + 
            				" coalesce((select invoiced from gl_rcalc where rdocno=r.doc_no and invno >0 and idno=17 and rowno=(select max(rowno) from gl_rcalc where rdocno=r.doc_no and invno >0 and idno=17)),0) invcdw\r\n" + 
            				" ,'' AS project,v1.eng_no originalfleet,v1.ch_no originalchase,'' replacefleet,'' replacechase,ur.user_name,clur.user_name closeuser,ms.sal_name,a.period2 crdp,mbr.branchname brch,ml.loc_name locname,if(r.invtype=1,'Month End','Period') invr,gy.yom\r\n" + 
            				"from gl_ragmt r \r\n" + 
            				" left join gl_vehmaster v on r.fleet_no=v.fleet_no left join my_acbook a on a.cldocno=r.cldocno   and a.dtype='CRM'\r\n" + 
            				"  left join gl_vehgroup g on g.doc_no=v.vgrpid    left join gl_vehmaster v1 on r.ofleet_no=v1.fleet_no\r\n" + 
            				"   left join  gl_rtarif t on t.rdocno=r.doc_no and t.rstatus=5  left join  gl_rtarif tc on tc.rdocno=r.doc_no and tc.rstatus=7\r\n" + 
            				"    left join gl_vehbrand br   on br.doc_no=v.brdid  left join gl_vehmodel mo on  mo.doc_no=v.vmodid\r\n" + 
            				"    left join     (select drid, rdocno from gl_rdriver where status=3 group by rdocno) dr  on dr.rdocno=r.doc_no    left join gl_drdetails cdr on cdr.dr_id=dr.drid\r\n" + 
            			" left join my_user ur on ur.doc_no=r.userid "+
            				"      left join gl_ragmtclosem cs on cs.agmtno=r.doc_no AND CS.STATUS=3"
            				+ " left join my_user clur on clur.doc_no=cs.userid "
            				+ " left join my_salm ms on ms.doc_no=r.salid "
            				
            				+ "left join my_brch mbr on mbr.doc_no=r.brhid left join my_locm ml on r.locid=ml.doc_no left join gl_yom gy on v.yom=gy.doc_no where r.status=3\r\n" + 
            				"        	"+rsqltest+" )\r\n" + 
            				"UNION\r\n" + 
            				"(select 'Lease' as rltype, l.voc_no doc, if(l.perfleet=0,l.tmpfleet,l.perfleet) fleet_no,v.FLNAME vehdetails,v.reg_no,l.perfleet ofno,orgveh.reg_no oreg_no,a.refname,a.contactperson,\r\n" + 
            				"d.name drname,a.per_mob,'Lease' rentaltype,l.outdate,l.outtime,if(l.per_name=1,DATE_ADD(l.outdate,INTERVAL l.per_value YEAR),DATE_ADD(l.outdate,INTERVAL l.per_value MONTH)) AS duedate,l.outtime dtime,coalesce(l.refno,'') refnos,\r\n" + 
            				"coalesce(l.manualra,'') mrno,convert(coalesce(cs.indate,''),char(30)) indate,\r\n" + 
            				"coalesce(cs.intime,'') intime,tr.rate rent,tr.cdw,tr.pai,convert(if(l.invdate=l.outdate,l.invdate,DATE_SUB(l.invdate,INTERVAL 1 DAY)),char(30)) AS invdate,\r\n" + 
            				"coalesce((select invoiced from gl_lcalc where rdocno=l.doc_no and invno >0 and idno=1 and rowno=(select max(rowno)\r\n" + 
            				" from gl_lcalc where rdocno=l.doc_no and invno >0 and idno=1)),0) invRental,\r\n" + 
            				"  coalesce((select invoiced from gl_lcalc where rdocno=l.doc_no and invno >0 and idno=17 and rowno=(select max(rowno) from gl_lcalc where rdocno=l.doc_no and invno >0 and idno=17)),0) invcdw,\r\n" + 
            				" coalesce(prj.project_name,'') AS project ,repveh.eng_no originalfleet,coalesce(orgveh.ch_no,'') originalchase,\r\n" + 
            				"convert(coalesce(repveh.fleet_no,''),char(25)) replacefleet,coalesce(repveh.ch_no,'') replacechase,ur.user_name,clur.user_name closeuser,ms.sal_name, a.period2 crdp ,br1.branchname brch ,ml.loc_name locname,if(l.inv_type=1,'Month End','Period') invr,gy.yom\r\n" + 
            				"from gl_lagmt l left join gl_project prj on l.projectno=prj.doc_no left join gl_vehmaster v on if(l.perfleet=0,l.tmpfleet,l.perfleet)=v.fleet_no\r\n" + 
            				"  left join gl_vehmaster orgveh on l.perfleet=orgveh.fleet_no left join gl_vehmaster repveh on l.tmpfleet=repveh.fleet_no\r\n" + 
            				"  left join my_acbook a on a.cldocno=l.cldocno and a.dtype='CRM' left join gl_vehgroup g on g.doc_no=v.vgrpid\r\n" + 
            				"   left join gl_vehbrand br on br.doc_no=v.brdid  left join gl_vehmodel mo on  mo.doc_no=v.vmodid\r\n" + 
            				"   left join gl_ltarif tr on tr.rdocno=l.doc_no  left join(select drid, rdocno from gl_ldriver where status=3 group by rdocno) dr on dr.rdocno=l.doc_no\r\n" + 
            				
            				"    left join  gl_drdetails d on (d.dr_id=dr.drid )"
            				+" left join my_user ur on ur.doc_no=l.userid "
            				+ " left join gl_lagmtclosem cs on cs.agmtno=l.doc_no\r\n" + 
            				 " left join my_user clur on clur.doc_no=cs.userid "+
            				"    left join my_salm ms on ms.doc_no=l.salid left join my_brch br1 on br1.doc_no=l.brhid  left join (select brhid,loc_name from my_locm group by brhid) ml on ml.brhid=br1.doc_no  left join gl_yom gy on orgveh.yom=gy.doc_no where l.status=3 "+sqltest+")";
            		
            	
           // System.out.println("---union-----"+sql);
                
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
            		// System.out.println("--------"+RESULTDATA);
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
    
    
    public JSONArray detailsgrids(String brnchval,String fromdate,String todate,String cldocno,String status,String fleet, 
    		String group,String brand,String model,String type,String outchk,String inchk,String catid) throws SQLException {

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
     	
      	
    	String rsqltest="" , sqltest="";
    	if(!(status.equalsIgnoreCase("")|| status.equalsIgnoreCase("NA"))){
    		rsqltest=rsqltest+" and r.clstatus='"+status+"'";
    		sqltest=sqltest+" and l.clstatus='"+status+"'";
    	}
    	if(!(cldocno.equalsIgnoreCase("") || cldocno.equalsIgnoreCase("NA"))){
    		rsqltest=rsqltest+" and a.cldocno='"+cldocno+"'";
    		sqltest=sqltest+" and a.cldocno='"+cldocno+"'";
    	}
    	if(!(fleet.equalsIgnoreCase("")|| fleet.equalsIgnoreCase("NA"))){
    		rsqltest=rsqltest+" and r.fleet_no='"+fleet+"'";
    		sqltest=sqltest+" and if(l.perfleet=0,l.tmpfleet,l.perfleet)='"+fleet+"'";
    	}
    	if(!(group.equalsIgnoreCase("") || group.equalsIgnoreCase("NA"))){
    		rsqltest=rsqltest+" and g.doc_no='"+group+"'";
    		sqltest=sqltest+" and g.doc_no='"+group+"'";
    	}
    	if(!(model.equalsIgnoreCase("") || model.equalsIgnoreCase("NA"))){
    		rsqltest=rsqltest+" and mo.doc_no='"+model+"'";
    		sqltest=sqltest+" and mo.doc_no='"+model+"'";
    	}
    	if(!(brand.equalsIgnoreCase("")|| brand.equalsIgnoreCase("NA"))){
    		rsqltest=rsqltest+" and br.doc_no='"+brand+"'";
    		sqltest=sqltest+" and br.doc_no='"+brand+"'";
    	}
    	if(!(type.equalsIgnoreCase("") || type.equalsIgnoreCase("NA"))){
    		rsqltest=rsqltest+" and t.rentaltype='"+type+"' ";
    	}
    	if(!(catid.equalsIgnoreCase("") || catid.equalsIgnoreCase("NA"))){
    		rsqltest=rsqltest+" and a.catid='"+catid+"' ";
    	}
    	
    	
    	
    	if(!((brnchval.equalsIgnoreCase("a")) || (brnchval.equalsIgnoreCase("NA")))){
 			rsqltest+=" and r.brhid="+brnchval+"";
 			sqltest+=" and l.brhid='"+brnchval+"'";
 			
 		}
    	
    	
    	if(inchk.equalsIgnoreCase("IN"))
    	{
    		rsqltest+="	and  cs.indate between '"+sqlfromdate+"' and  '"+sqltodate+"' ";
    		sqltest+="	and  cs.indate between '"+sqlfromdate+"' and  '"+sqltodate+"' ";
    		
    	}
    	else
    	{
    		
    		rsqltest+="	and  r.odate between '"+sqlfromdate+"' and  '"+sqltodate+"' ";
    		sqltest+="	and  l.outdate between '"+sqlfromdate+"' and  '"+sqltodate+"' ";
    	}
    	
    	

    	
    	Connection conn =  null;
    	try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement (); 
				String sql ="(select r.voc_no 'RA NO',mbr.branchname 'Branch',ml.loc_name 'Location',r.fleet_no 'Fleet',v.FLNAME 'Fleet Name',v.reg_no 'Reg NO',r.ofleet_no 'Contract Fleet',v1.reg_no 'Contract Reg No',a.refname 'Client Name',a.contactperson 'Contact Person',\r\n" + 
        				"cdr.name 'Driver',a.per_mob 'Mob NO',t.rentaltype 'Rental Type',r.odate 'Out Date',r.otime 'Out Time',r.ddate 'Due Date',r.dtime 'DueTime',r.mrano 'Manual RA',convert(coalesce(cs.indate,''),char(30)) 'In Date',\r\n" + 
        				"coalesce(cs.intime,'') 'In Time',tc.rate 'Rent',tc.cdw 'CDW',tc.pai 'PAI',\r\n" + 
        				"convert(if(r.invdate=r.odate,r.invdate,DATE_SUB(r.invdate,INTERVAL 1 DAY)),char(30)) 'Inv Date',\r\n" + 
        				"coalesce((select invoiced from gl_rcalc where rdocno=r.doc_no and invno >0 and idno=1 and rowno=(select max(rowno) from gl_rcalc where rdocno=r.doc_no and invno >0 and idno=1)),0) 'Inv Rent',\r\n" + 
        				" coalesce((select invoiced from gl_rcalc where rdocno=r.doc_no and invno >0 and idno=17 and rowno=(select max(rowno) from gl_rcalc where rdocno=r.doc_no and invno >0 and idno=17)),0) 'Inv CDW'\r\n" + 
        				" ,'' AS Project,v1.eng_no 'Original Fleet',v1.ch_no 'Original Chase',ur.user_name 'Open User',clur.user_name 'Close User',ms.sal_name 'Salesman',a.period2 'Credit Period',if(r.invtype=1,'Month End','Period') 'Invoice rule',gy.yom 'YOM'\r\n" + 
        				"from gl_ragmt r \r\n" + 
        				" left join gl_vehmaster v on r.fleet_no=v.fleet_no left join my_acbook a on a.cldocno=r.cldocno   and a.dtype='CRM'\r\n" + 
        				"  left join gl_vehgroup g on g.doc_no=v.vgrpid    left join gl_vehmaster v1 on r.ofleet_no=v1.fleet_no\r\n" + 
        				"   left join  gl_rtarif t on t.rdocno=r.doc_no and t.rstatus=5  left join  gl_rtarif tc on tc.rdocno=r.doc_no and tc.rstatus=7\r\n" + 
        				"    left join gl_vehbrand br   on br.doc_no=v.brdid  left join gl_vehmodel mo on  mo.doc_no=v.vmodid\r\n" + 
        				"    left join  (select drid, rdocno from gl_rdriver where status=3 group by rdocno) dr  on dr.rdocno=r.doc_no     left join gl_drdetails cdr on cdr.dr_id=dr.drid\r\n" + 
        				" left join my_user ur on ur.doc_no=r.userid "+
        				"      left join gl_ragmtclosem cs on cs.agmtno=r.doc_no AND CS.STATUS=3"
        				+ " left join my_user clur on clur.doc_no=cs.userid "
        				+ " left join my_salm ms on ms.doc_no=r.salid "
        				
        				+ "left join my_brch mbr on mbr.doc_no=r.brhid left join my_locm ml on r.locid=ml.doc_no left join gl_yom gy on v.yom=gy.doc_no where r.status=3\r\n" + 
        				"        	"+rsqltest+" )\r\n" + 
        				"UNION\r\n" + 
        				"(select l.voc_no doc,br1.branchname brch ,ml.loc_name locname, if(l.perfleet=0,l.tmpfleet,l.perfleet) fleet_no,v.FLNAME vehdetails,v.reg_no,l.perfleet ofno,orgveh.reg_no oreg_no,a.refname,a.contactperson,\r\n" + 
        				"d.name drname,a.per_mob,'Lease' rentaltype,l.outdate,l.outtime,if(l.per_name=1,DATE_ADD(l.outdate,INTERVAL l.per_value YEAR),DATE_ADD(l.outdate,INTERVAL l.per_value MONTH)) AS duedate,l.outtime dtime,\r\n" + 
        				"coalesce(l.manualra,'') mrno,convert(coalesce(cs.indate,''),char(30)) indate,\r\n" + 
        				"coalesce(cs.intime,'') intime,tr.rate rent,tr.cdw,tr.pai,convert(if(l.invdate=l.outdate,l.invdate,DATE_SUB(l.invdate,INTERVAL 1 DAY)),char(30)) AS invdate,\r\n" + 
        				"coalesce((select invoiced from gl_lcalc where rdocno=l.doc_no and invno >0 and idno=1 and rowno=(select max(rowno)\r\n" + 
        				" from gl_lcalc where rdocno=l.doc_no and invno >0 and idno=1)),0) invRental,\r\n" + 
        				"  coalesce((select invoiced from gl_lcalc where rdocno=l.doc_no and invno >0 and idno=17 and rowno=(select max(rowno) from gl_lcalc where rdocno=l.doc_no and invno >0 and idno=17)),0) invcdw,\r\n" + 
        				" coalesce(prj.project_name,'') project,repveh.eng_no originalfleet,coalesce(orgveh.ch_no,'') originalchase,\r\n" + 
        				" ur.user_name,clur.user_name closeuser ,ms.sal_name, a.period2 crdp ,if(l.inv_type=1,'Month End','Period') invr,gy.yom\r\n" + 
        				"from gl_lagmt l left join gl_project prj on l.projectno=prj.doc_no left join gl_vehmaster v on if(l.perfleet=0,l.tmpfleet,l.perfleet)=v.fleet_no\r\n" + 
        				"  left join gl_vehmaster orgveh on l.perfleet=orgveh.fleet_no left join gl_vehmaster repveh on l.tmpfleet=repveh.fleet_no\r\n" + 
        				"  left join my_acbook a on a.cldocno=l.cldocno and a.dtype='CRM' left join gl_vehgroup g on g.doc_no=v.vgrpid\r\n" + 
        				"   left join gl_vehbrand br on br.doc_no=v.brdid  left join gl_vehmodel mo on  mo.doc_no=v.vmodid\r\n" + 
        				"   left join gl_ltarif tr on tr.rdocno=l.doc_no  left join(select drid, rdocno from gl_ldriver where status=3 group by rdocno) dr on dr.rdocno=l.doc_no\r\n" + 
        				
        				"    left join  gl_drdetails d on (d.dr_id=dr.drid ) "
        				+" left join my_user ur on ur.doc_no=l.userid "
        				+" left join gl_lagmtclosem cs on cs.agmtno=l.doc_no\r\n" + 
        				 " left join my_user clur on clur.doc_no=cs.userid "+
        				"  left join my_salm ms on ms.doc_no=l.salid left join my_brch br1 on br1.doc_no=l.brhid left join (select brhid,loc_name from my_locm group by brhid) ml on ml.brhid=br1.doc_no left join gl_yom gy on orgveh.yom=gy.doc_no where l.status=3 "+sqltest+")";
                		
            	
        //    System.out.println("---union-----"+sql);
                
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
            		// System.out.println("--------"+RESULTDATA);
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
    
    public JSONArray catnamesearchdetails() throws SQLException {

    	  JSONArray RESULTDATA=new JSONArray();

        Connection conn=null;
  		try {
  				  conn = ClsConnection.getMyConnection();
  				Statement stmtVeh5 = conn.createStatement ();
            	
  				String  tarifsql=("select cat_name,doc_no from my_clcatm where dtype='CRM' and status=3;");
  			//	System.out.println("------------------------------"+tarifsql);
  				
  				ResultSet resultSet = stmtVeh5.executeQuery (tarifsql);
  				RESULTDATA=ClsCommon.convertToJSON(resultSet);
  				stmtVeh5.close();
  				conn.close();
  		}
  		catch(Exception e){
  			e.printStackTrace();
  			conn.close();
  		}
  		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
      
    
    
}

