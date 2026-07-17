package com.dashboard.workshop.invoicetodispatch;

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

	public JSONArray invoicelist(String branchval,String fromdate,String todate,String cldocno,String id) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        if(!id.equalsIgnoreCase("1")){
        	return RESULTDATA;
        }
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
    		sqltest=sqltest+" and gate.cldocno='"+cldocno+"'";
    	}
    	if(sqlfromdate!=null){
    		sqltest+=" and inv.date>='"+sqlfromdate+"'";
    	}
    	if(sqltodate!=null){
    		sqltest+=" and inv.date<='"+sqltodate+"'";
    	}
    	if(!branchval.equalsIgnoreCase("") && !branchval.equalsIgnoreCase("a")){
    		sqltest+=" and inv.brhid="+branchval;
    	}
    	
    	Connection conn = null;
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmtVeh = conn.createStatement ();
			String strsql="select calc.addition,if(cat.insurance=0,'CRM','VND') actype,coalesce(ac.mail1,'') mailid,inv.doc_no invdocno,inv.voc_no invvocno,job.doc_no jobdocno,job.voc_no jobvocno,est.doc_no estdocno,est.voc_no estvocno,"+
			" gate.doc_no gatedocno,gate.voc_no gatevocno,inv.date,br.branchname branch,head.account,head.description acname,round(coalesce(inv.taxtotal,0),2) taxtotal,inv.brhid from ws_invm inv"+
			" left join ws_jobcard job on (inv.reftype='JC' and inv.refno=job.doc_no)"+
			" left join ws_estm est on (job.reftype='EST' and job.refno=est.doc_no)"+
			" left join ws_gateinpass gate on est.gipno=gate.doc_no"+
			" left join my_brch br on inv.brhid=br.doc_no"+
			" left join my_head head on inv.invoicetoacno=head.doc_no "+
			" left join my_acbook ac on head.doc_no=ac.acno "+
			" left join my_clcatm cat on ac.catid=cat.doc_no "+
			" left join ws_invcalctemp calc on inv.doc_no=calc.invno where inv.status=3 and inv.dispatch=0"+sqltest;
			System.out.println(strsql);
            ResultSet resultSet = stmtVeh.executeQuery(strsql);
            RESULTDATA=ClsCommon.convertToJSON(resultSet);
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

	
	
	
	public JSONArray clientDetailsSearch(String id) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
//			System.out.println(id);
			return RESULTDATA;
			
		}
		Connection conn = null;
	    
		  try {
		    conn = ClsConnection.getMyConnection();
		    Statement stmtsalik = conn.createStatement ();
		    
		    String sql = "";
			
			sql = "select cldocno,refname from my_acbook where status=3 and dtype='CRM'";
//	/		System.out.println(sql);
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
