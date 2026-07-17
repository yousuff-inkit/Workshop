package com.dashboard.invoices.invoicetodispatch;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsInvoiceDispatchDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	public JSONArray invoicelist(String branchval,String fromdate,String todate,String cldocno,String rentaltype,String agmtNo,String clstatuss,String invtype) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        java.sql.Date sqlfromdate = null;
        java.sql.Date sqltodate = null;
        if(!fromdate.equalsIgnoreCase(""))
     	{
     		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
     		
     	}

        
     	if(!todate.equalsIgnoreCase(""))
     	{
     		sqltodate=ClsCommon.changeStringtoSqlDate(todate);
     		
     	}
     
	String sqltest="";
    	if(!cldocno.equalsIgnoreCase("")){
    		sqltest=sqltest+" and m.cldocno='"+cldocno+"'";
    	}
    	if(!(rentaltype.equalsIgnoreCase(""))){
    		sqltest=sqltest+" and m.ratype='"+rentaltype+"'";
    	}
    	if(!(agmtNo.equalsIgnoreCase(""))){
    		if(rentaltype.equalsIgnoreCase("RAG")){
    			sqltest=sqltest+" and r.voc_no='"+agmtNo+"'";
    		}
    		if(rentaltype.equalsIgnoreCase("LAG")){
    			sqltest=sqltest+" and l.voc_no='"+agmtNo+"'";
    		}
    	}
    	/*
    	if(!(clstatuss.equalsIgnoreCase(""))){
    		sqltest=sqltest+" and (r.clstatus='"+clstatuss+"' or l.clstatus='"+clstatuss+"')";
    	}*/
    	
    	if(!clstatuss.equalsIgnoreCase("")){
    		sqltest+=" and if(m.ratype='RAG',r.clstatus='"+clstatuss+"',l.clstatus='"+clstatuss+"')";
    	}
    	if(!invtype.equalsIgnoreCase("")){
    		if(invtype.equalsIgnoreCase("rental")){
    			sqltest+=" and m.manual in (2,3)";
    		}
    		else if(invtype.equalsIgnoreCase("lease")){
    			sqltest+=" and m.manual in (4,5)";
    		}
    		else if(invtype.equalsIgnoreCase("damage")){
    			sqltest+=" and m.manual=6";
    		}
    		else if(invtype.equalsIgnoreCase("salik")){
    			sqltest+=" and m.manual=8";
    		}
    		else if(invtype.equalsIgnoreCase("traffic")){
    			sqltest+=" and m.manual=9";
    		}
    		else if(invtype.equalsIgnoreCase("extrasrvc")){
    			sqltest+=" and m.manual=7";
    		}
    		else if(invtype.equalsIgnoreCase("extrakm")){
    			sqltest+=" and m.manual=10";
    		}
    	}
    	
    	
    	Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
			
            	if(branchval.equalsIgnoreCase("a"))
            	{

            		String sql ="select br.branchname branch,m.dtype,if(m.ratype='RAG',r.voc_no,l.voc_no) refvocno,'Dispatch' btndispatch,'Print' btnprint,m.doc_no,m.voc_no,h.description acname,h.account acno,m.doc_no,m.ratype,m.rano,m.cldocno,a.refname,m.fromdate,m.todate,convert(coalesce(sum(d.total),''),char(50)) amount , "
            				+ "convert(coalesce((select total from gl_invd where rdocno=m.doc_no and chid=1),' '),char(50)) rent, "
            				+ "convert(coalesce((select sum(total) from gl_invd where rdocno=m.doc_no and chid=17),''),char(50)) inschg, "
            				+ "convert(coalesce((select total from gl_invd where rdocno=m.doc_no and chid=2),''),char(50)) accchg, "
            				+ "convert(coalesce((select sum(total) from gl_invd where rdocno=m.doc_no and chid in (8,14)),''),char(50)) salik, "
            				+ "convert(coalesce((select sum(total) from gl_invd where rdocno=m.doc_no and chid in (9,15)),' '),char(50)) traffic,a.mail1,m.brhid  "
            				+ " from gl_invm m left join gl_invd d on m.doc_no=d.rdocno "
            				+ " left join my_acbook a on a.doc_no=m.cldocno and a.dtype='CRM' left join gl_lagmt l on l.doc_no=m.rano"
            				+ " left join gl_ragmt r on r.doc_no=m.rano left join my_head h on h.doc_no=m.acno left join my_brch br on m.brhid=br.doc_no  where m.status=3 and m.dispatch=0"
            				+ " and m.date between '"+sqlfromdate+"' and  '"+sqltodate+"' "+sqltest +" group by d.rdocno order by m.doc_no";
        System.out.println("============"+sql);
              
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
             		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
            		 stmtVeh.close();
            	}
            	else{	
            		
            		String sql ="select br.branchname branch, m.dtype,if(m.ratype='RAG',r.voc_no,l.voc_no) refvocno,'Dispatch' btndispatch,'Print' btnprint, m.doc_no,m.voc_no,h.description acname,h.account acno,m.doc_no,m.ratype,m.rano,m.cldocno,a.refname,m.fromdate,m.todate,convert(coalesce(sum(d.total),''),char(50)) amount , "
            				+ "convert(coalesce((select total from gl_invd where rdocno=m.doc_no and chid=1),' '),char(50)) rent, "
            				+ "convert(coalesce((select sum(total) from gl_invd where rdocno=m.doc_no and chid=17),''),char(50)) inschg, "
            				+ "convert(coalesce((select total from gl_invd where rdocno=m.doc_no and chid=2),''),char(50)) accchg, "
            				+ "convert(coalesce((select sum(total) from gl_invd where rdocno=m.doc_no and chid in (8,14)),''),char(50)) salik, "
            				+ "convert(coalesce((select sum(total) from gl_invd where rdocno=m.doc_no and chid in (9,15)),' '),char(50)) traffic,a.mail1,m.brhid  "
            				+ " from gl_invm m left join gl_invd d on m.doc_no=d.rdocno "
            				+ " left join my_acbook a on a.doc_no=m.cldocno and a.dtype='CRM' left join gl_lagmt l on l.doc_no=m.rano"
            				+ " left join gl_ragmt r on r.doc_no=m.rano left join my_head h on h.doc_no=m.acno  left join my_brch br on m.brhid=br.doc_no  where m.status=3 and m.dispatch=0"
            				+ " and m.date between '"+sqlfromdate+"' and  '"+sqltodate+"' and m.brhid='"+branchval+"' "+sqltest +" group by d.rdocno ";

            	     System.out.println("========2===="+sql);
     
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
         	 RESULTDATA=ClsCommon.convertToJSON(resultSet);
         	stmtVeh.close();
            	}
          
            	
 				conn.close();
		}
		catch(Exception e){
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
    
	
	
	
	public JSONArray agreementSearch(String branch, String sclname,String smob,String rno,String flno,String sregno,String rentaltype) throws SQLException {

    	JSONArray RESULTDATA=new JSONArray();
    	String sqltest="";
    	
    	if(rentaltype.equalsIgnoreCase("RAG"))
    	{

    		if(!(rno.equalsIgnoreCase(""))){
        		sqltest+=" and r.voc_no like '%"+rno+"%'";
        	}
        	if(!(flno.equalsIgnoreCase(""))){
        		sqltest+=" and r.fleet_no like '%"+flno+"%'";
        	}
    	}
    	else if(rentaltype.equalsIgnoreCase("LAG"))
    	{
    		
    		if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    			sqltest+=" l.brhid="+branch+"";
    		}
        	
        
        	if(!(rno.equalsIgnoreCase(""))){
        		sqltest+=" and l.voc_no like '%"+rno+"%'";
        	}
        	if(!(flno.equalsIgnoreCase(""))){
        		sqltest+=" and (l.tmpfleet like '%"+flno+"%' or l.perfleet like '%"+flno+"%')";
        	}
        	
    		
    	}
    		if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    			sqltest+=" and r.brhid="+branch+"";
    		}
        	
        	if(!(sclname.equalsIgnoreCase(""))){
        		sqltest+=" and a.RefName like '%"+sclname+"%'";
        	}
        	if(!(smob.equalsIgnoreCase(""))){
        		sqltest+=" and a.per_mob like '%"+smob+"%'";
        	}
        	
        	if(!(sregno.equalsIgnoreCase(""))){
        		sqltest+=" and v.reg_no like '%"+sregno+"%'";
        	}
    
        	if(!(sclname.equalsIgnoreCase(""))){
        		sqltest+=" and a.RefName like '%"+sclname+"%'";
        	}
        	if(!(smob.equalsIgnoreCase(""))){
        		sqltest+=" and a.per_mob like '%"+smob+"%'";
        	}
    	
        	if(!(sregno.equalsIgnoreCase(""))){
        		sqltest+=" and v.reg_no like '%"+sregno+"%'";
        	}
    		
    
    	
    	Connection conn=null;
     
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtinv = conn.createStatement();
				if(rentaltype.equalsIgnoreCase("RAG"))
		    	{
				String sql=("select r.doc_no,r.voc_no,r.fleet_no,a.RefName,a.per_mob,v.reg_no from gl_ragmt r left join gl_vehmaster v on v.fleet_no=r.fleet_no "
						+ " left join my_acbook a on (r.cldocno=a.cldocno and a.dtype='CRM') where 1=1 "+sqltest+" group by doc_no");
			//	System.out.println(sql);
				ResultSet resultSet = stmtinv.executeQuery(sql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
			
				
		    	}
				else if(rentaltype.equalsIgnoreCase("LAG"))
		    	{
					
					String sql=("select l.doc_no,l.voc_no,if(l.perfleet=0,l.tmpfleet,l.perfleet) fleet_no,a.RefName,a.per_mob,v.reg_no from gl_lagmt l left join gl_vehmaster v on v.fleet_no=if(l.perfleet=0,l.tmpfleet,l.perfleet)  "
							+ " left join my_acbook a on a.cldocno= l.cldocno and a.dtype='CRM' where 1=1 "+sqltest+" group by doc_no");	
					

					ResultSet resultSet = stmtinv.executeQuery(sql);
					RESULTDATA=ClsCommon.convertToJSON(resultSet);
					
					
					
		    	}
				stmtinv.close();
				conn.close();
		    	
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
        return RESULTDATA;
    }

	
	
	
	public JSONArray clientDetailsSearch() throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		    
		Connection conn = null;
	    
		  try {
		    conn = ClsConnection.getMyConnection();
		    Statement stmtsalik = conn.createStatement ();
		    
		    String sql = "";
			
			sql = "select cldocno,refname from my_acbook where status=3 and dtype='CRM'";
			
			ResultSet resultSet = stmtsalik.executeQuery(sql);
		                
		    RESULTDATA=ClsCommon.convertToJSON(resultSet);
		    stmtsalik.close();
		    conn.close();
		
		  }
		  catch(Exception e){
			  e.printStackTrace();
			  conn.close();
		  }
		  return RESULTDATA;
		}

}
