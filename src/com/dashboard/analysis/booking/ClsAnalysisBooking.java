package com.dashboard.analysis.booking;

 import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsAnalysisBooking  { 
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	

	public JSONArray bookinglistsearch(String brnchval,String fromdate,String todate) throws SQLException {

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

        
        
     	Connection conn = null;
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement();
				//String sql="";
				//ResultSet resultSet ;
//				System.out.println("========="+brnchval);
				String sql1="";
				//ResultSet resultSet ;
//				System.out.println("========="+brnchval);
				 if(!(brnchval.trim().equalsIgnoreCase("a"))){
				        //sql1+=" and r.brhid="+brnchval+"";
				       }

            		String sql="select r.voc_no,r.brhid, r.DATE,a.cldocno clientno,a.refname ,bran.branchname,v.reg_no, concat(br.brand_name,' ',mo.vtype) brmodel,H.account acno,\r\n" + 
            				" tr.rentaltype reftype, r.voc_no RAno, (cast(concat(odate,' ',otime)as datetime)) raopendate, (cast(concat(rcm.indate,' ',rcm.intime)\r\n" + 
            				" as datetime)) raclosedate, coalesce(timestampdiff(second,(cast(concat(odate,' ',otime)as datetime)),\r\n" + 
            				" (cast(concat(rcm.indate,' ',rcm.intime)as datetime)))/3600,0) tothr,  coalesce(rc.amt,0) invoicedamt,coalesce(rkm.amt,0) kmamt,\r\n" + 
            				" coalesce(rvat.amt,0) vat ,coalesce(rdis.amt,0) discount,coalesce(roth.amt,0) other,coalesce(rdam.amt,0) damege , coalesce(rtra.amt,0)\r\n" + 
            				" traffic,coalesce(rdel.amt,0) delivery, coalesce(rtot.amt,0) total  from  gl_ragmt r left join my_acbook a on a.cldocno=r.cldocno\r\n" + 
            				" and a.dtype='CRM'  left join my_head h on h.cldocno=r.cldocno and a.dtype='CRM'  left join gl_ragmtclosem rcm on\r\n" + 
            				" r.doc_no=rcm.agmtno left join gl_vehmaster v on r.fleet_no=v.fleet_no left join gl_vehmodel mo on mo.doc_no=v.vmodid\r\n" + 
            				" left join gl_vehbrand br on br.doc_no=v.brdid  left join my_brch bran on r.brhid=bran.doc_no  left join\r\n" + 
            				" (select rdocno,rentaltype  from gl_rtarif where rstatus=5) tr on r.doc_no=tr.rdocno left join \r\n" + 
            				" (select sum(coalesce(amount,0)) amt,rano from gl_invm m inner join gl_invd d\r\n" + 
            				"  on m.doc_no=d.rdocno where  status=3 and chid=1 group by  rano,ratype) rc on r.doc_no=rc.RANO left join\r\n" + 
            				" (select sum(coalesce(amount,0)) amt,rano from gl_invm m inner join gl_invd d\r\n" + 
            				"  on m.doc_no=d.rdocno where  status=3 and chid=4 group by  rano,ratype) rkm on r.doc_no=rkm.RANO  left join\r\n" + 
            				" (select sum(coalesce(amount,0)) amt,rano from gl_invm m inner join gl_invd d on m.doc_no=d.rdocno where  status=3 and chid=20 group by\r\n" + 
            				"  rano,ratype) rvat on r.doc_no=rvat.rano  left join\r\n" + 
            				"  (select sum(coalesce(amount,0)) amt,rano from gl_invm m inner join gl_invd d\r\n" + 
            				"  on m.doc_no=d.rdocno where status=3 and chid=13 group by  rano,ratype) rdis on r.doc_no=rdis.rano  left join\r\n" + 
            				"  (select sum(coalesce(amount,0)) amt,rano from gl_invm m inner join gl_invd d\r\n" + 
            				"  on m.doc_no=d.rdocno where status=3 and chid IN (12,18) group by  rano,ratype) roth on r.doc_no=roth.rano\r\n" + 
            				"   left join (select sum(coalesce(amount,0)) amt,rano from gl_invm m inner join gl_invd d\r\n" + 
            				"  on m.doc_no=d.rdocno where status=3 and chid=10 group by  rano,ratype) rdam on\r\n" + 
            				"   r.doc_no=rdam.rano left join (select sum(coalesce(amount,0)) amt,rano from gl_invm m inner join gl_invd d\r\n" + 
            				"  on m.doc_no=d.rdocno where status=3 and chid=9 group by  rano,ratype) rtra\r\n" + 
            				"   on r.doc_no=rtra.rano left join (select sum(coalesce(amount,0)) amt,rano from gl_invm m inner join gl_invd d\r\n" + 
            				"  on m.doc_no=d.rdocno where status=3 and  chid=6 group by  rano,ratype) rdel\r\n" + 
            				"    on r.doc_no=rdel.rano left join (select sum(coalesce(amount,0)) amt,rano from gl_invm m inner join gl_invd d\r\n" + 
            				"  on m.doc_no=d.rdocno where status=3 and  chid in (1,4,20,13,12,18,10,9,6)  group by  rano,ratype ) rtot on r.doc_no=rtot.rano "
            				+ "  where r.status=3 and r.DATE between '"+sqlfromdate+"' and  '"+sqltodate+"'  "+sql1;

            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            	 RESULTDATA=ClsCommon.convertToJSON(resultSet);
	//	System.out.println("======= "+sql);
            	 stmtVeh.close();
 				
            	conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
//		System.out.println(RESULTDATA);
        return RESULTDATA;
    }
	

     

	public JSONArray bookingexcelsearch(String brnchval,String fromdate,String todate) throws SQLException {

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

        
        
     	Connection conn = null;
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
				String sql1="";
				//ResultSet resultSet ;
				//System.out.println("========="+brnchval);
				 if(!(brnchval.trim().equalsIgnoreCase("a"))) {
				       // sql1+=" and r.brhid="+brnchval+"";
				       }
            		

				 String sql="select r.voc_no,r.brhid, r.DATE,a.cldocno clientno,a.refname ,bran.branchname,v.reg_no, concat(br.brand_name,' ',mo.vtype) brmodel,H.account acno,\r\n" + 
         				" tr.rentaltype reftype, r.voc_no RAno, (cast(concat(odate,' ',otime)as datetime)) raopendate, (cast(concat(rcm.indate,' ',rcm.intime)\r\n" + 
         				" as datetime)) raclosedate, coalesce(timestampdiff(second,(cast(concat(odate,' ',otime)as datetime)),\r\n" + 
         				" (cast(concat(rcm.indate,' ',rcm.intime)as datetime)))/3600,0) tothr,  coalesce(rc.amt,0) invoicedamt,coalesce(rkm.amt,0) kmamt,\r\n" + 
         				" coalesce(rvat.amt,0) vat ,coalesce(rdis.amt,0) discount,coalesce(roth.amt,0) other,coalesce(rdam.amt,0) damege , coalesce(rtra.amt,0)\r\n" + 
         				" traffic,coalesce(rdel.amt,0) delivery, coalesce(rtot.amt,0) total  from  gl_ragmt r left join my_acbook a on a.cldocno=r.cldocno\r\n" + 
         				" and a.dtype='CRM'  left join my_head h on h.cldocno=r.cldocno and a.dtype='CRM'  left join gl_ragmtclosem rcm on\r\n" + 
         				" r.doc_no=rcm.agmtno left join gl_vehmaster v on r.fleet_no=v.fleet_no left join gl_vehmodel mo on mo.doc_no=v.vmodid\r\n" + 
         				" left join gl_vehbrand br on br.doc_no=v.brdid  left join my_brch bran on r.brhid=bran.doc_no  left join\r\n" + 
         				" (select rdocno,rentaltype  from gl_rtarif where rstatus=5) tr on r.doc_no=tr.rdocno left join \r\n" + 
         				" (select sum(coalesce(amount,0)) amt,rano from gl_invm m inner join gl_invd d\r\n" + 
         				"  on m.doc_no=d.rdocno where  status=3 and chid=1 group by  rano,ratype) rc on r.doc_no=rc.RANO left join\r\n" + 
         				" (select sum(coalesce(amount,0)) amt,rano from gl_invm m inner join gl_invd d\r\n" + 
         				"  on m.doc_no=d.rdocno where  status=3 and chid=4 group by  rano,ratype) rkm on r.doc_no=rkm.RANO  left join\r\n" + 
         				" (select sum(coalesce(amount,0)) amt,rano from gl_invm m inner join gl_invd d on m.doc_no=d.rdocno where  status=3 and chid=20 group by\r\n" + 
         				"  rano,ratype) rvat on r.doc_no=rvat.rano  left join\r\n" + 
         				"  (select sum(coalesce(amount,0)) amt,rano from gl_invm m inner join gl_invd d\r\n" + 
         				"  on m.doc_no=d.rdocno where status=3 and chid=13 group by  rano,ratype) rdis on r.doc_no=rdis.rano  left join\r\n" + 
         				"  (select sum(coalesce(amount,0)) amt,rano from gl_invm m inner join gl_invd d\r\n" + 
         				"  on m.doc_no=d.rdocno where status=3 and chid IN (12,18) group by  rano,ratype) roth on r.doc_no=roth.rano\r\n" + 
         				"   left join (select sum(coalesce(amount,0)) amt,rano from gl_invm m inner join gl_invd d\r\n" + 
         				"  on m.doc_no=d.rdocno where status=3 and chid=10 group by  rano,ratype) rdam on\r\n" + 
         				"   r.doc_no=rdam.rano left join (select sum(coalesce(amount,0)) amt,rano from gl_invm m inner join gl_invd d\r\n" + 
         				"  on m.doc_no=d.rdocno where status=3 and chid=9 group by  rano,ratype) rtra\r\n" + 
         				"   on r.doc_no=rtra.rano left join (select sum(coalesce(amount,0)) amt,rano from gl_invm m inner join gl_invd d\r\n" + 
         				"  on m.doc_no=d.rdocno where status=3 and  chid=6 group by  rano,ratype) rdel\r\n" + 
         				"    on r.doc_no=rdel.rano left join (select sum(coalesce(amount,0)) amt,rano from gl_invm m inner join gl_invd d\r\n" + 
         				"  on m.doc_no=d.rdocno where status=3 and  chid in (1,4,20,13,12,18,10,9,6)  group by  rano,ratype ) rtot on r.doc_no=rtot.rano "
         				+ "  where r.status=3 and r.DATE between '"+sqlfromdate+"' and  '"+sqltodate+"'  "+sql1;

            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
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
	

}
