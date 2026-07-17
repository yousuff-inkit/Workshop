package com.dashboard.android.checkinout;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.common.ClsCommon;
import com.connection.ClsConnection;


public class CheckInOutDAO
{
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	
	public JSONArray regnoSearch() throws SQLException {
	JSONArray RESULTDATA=new JSONArray();
	    
	Connection conn = null;
    
	  try {
	    conn = ClsConnection.getMyConnection();
	    Statement stmtreg = conn.createStatement ();
	    
	    String sql = "";
		
		sql = "select reg_no,fleet_no,pltid from gl_vehmaster";
		
		ResultSet resultSet = stmtreg.executeQuery(sql);
	                
	    RESULTDATA=ClsCommon.convertToJSON(resultSet);
	    stmtreg.close();
	    conn.close();
	
	  }
	  catch(Exception e){
		  e.printStackTrace();
		  conn.close();
	  }
	  return RESULTDATA;
	}
	
	
	public JSONArray searchcheckinout(String branchval,String fdateval,String tdateval,String regno,String type) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        java.sql.Date sqlfromdate = null;
        java.sql.Date sqltodate = null;
        if(!(fdateval.equalsIgnoreCase("undefined")) && !(fdateval.equalsIgnoreCase("")) && !(fdateval.equalsIgnoreCase("0")) && !(fdateval==null)){
       		sqlfromdate=ClsCommon.changeStringtoSqlDate(fdateval);
        }
        else{ }
        if(!(tdateval.equalsIgnoreCase("undefined")) && !(tdateval.equalsIgnoreCase("")) && !(tdateval.equalsIgnoreCase("0"))&& !(fdateval==null)){
        		sqltodate=ClsCommon.changeStringtoSqlDate(tdateval);
        } 
        else { }
          	Connection conn = null;
		try {
				conn=ClsConnection.getMyConnection();
				Statement stmtVeh1 = conn.createStatement ();
            	String sqltest="";
            	if(!(regno.equalsIgnoreCase("")|| regno.equalsIgnoreCase("NA"))){
    	    		sqltest+=sqltest+" and v.reg_no="+regno+"";
    	    	}
				if(!(branchval.equalsIgnoreCase("NA")) && !(branchval.equalsIgnoreCase("")) && !(branchval.equalsIgnoreCase("a"))){
            		sqltest+=" and c.rbrhid='"+branchval+"'";
            	}
				if(type.equalsIgnoreCase("IN"))
		    	{
		    		sqltest+=" and  c.stat='"+type+"' ";
		    		
		    	}
		    	else if(type.equalsIgnoreCase("OUT"))
		    	{
		    		
		    		sqltest+=" and  c.stat='"+type+"' ";
		    	}
		    	else
		    	{
		    		sqltest+=sqltest;
		    	}
            	  
        
            	String sqldata="SELECT c.stat type,v.reg_no,v.pltid,c.fleet,c.doc_no docno,DATE_FORMAT(c.date,'%d-%m-%Y') date1,br.branchname branch,c.rdocno,c.rdtype "
            			+ " FROM an_checksave c left join my_brch br on c.rbrhid=br.doc_no left join gl_vehmaster v on v.fleet_no=c.fleet"
            			+ " where date(c.date) between '"+sqlfromdate+"' and '"+sqltodate+"' "+sqltest+" ";
            	
            						
			//	System.out.println("-----chin-----:"+sqldata);
				ResultSet resultSet = stmtVeh1.executeQuery(sqldata);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtVeh1.close();
				conn.close();
				 return RESULTDATA;

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

	
	
	public JSONArray excelcheckinout(String branchval,String fdateval,String tdateval,String regno,String type) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        java.sql.Date sqlfromdate = null;
        java.sql.Date sqltodate = null;
        if(!(fdateval.equalsIgnoreCase("undefined")) && !(fdateval.equalsIgnoreCase("")) && !(fdateval.equalsIgnoreCase("0")) && !(fdateval==null)){
       		sqlfromdate=ClsCommon.changeStringtoSqlDate(fdateval);
        }
        else{ }
        if(!(tdateval.equalsIgnoreCase("undefined")) && !(tdateval.equalsIgnoreCase("")) && !(tdateval.equalsIgnoreCase("0"))&& !(fdateval==null)){
        		sqltodate=ClsCommon.changeStringtoSqlDate(tdateval);
        } 
        else { }
          	Connection conn = null;
		try {
				conn=ClsConnection.getMyConnection();
				Statement stmtVeh1 = conn.createStatement ();
            	String sqltest="";
            	if(!(regno.equalsIgnoreCase("")|| regno.equalsIgnoreCase("NA"))){
    	    		sqltest+=sqltest+" and v.reg_no="+regno+"";
    	    	}
				if(!(branchval.equalsIgnoreCase("NA")) && !(branchval.equalsIgnoreCase("")) && !(branchval.equalsIgnoreCase("a"))){
            		sqltest+=" and c.rbrhid='"+branchval+"'";
            	}
				if(type.equalsIgnoreCase("IN"))
		    	{
		    		sqltest+=" and  c.stat='"+type+"' ";
		    		
		    	}
		    	else if(type.equalsIgnoreCase("OUT"))
		    	{
		    		
		    		sqltest+=" and  c.stat='"+type+"' ";
		    	}
		    	else
		    	{
		    		sqltest+=sqltest;
		    	}
            	  
        
            	String sqldata="SELECT c.stat 'Type',v.reg_no 'Reg No',c.fleet 'Fleet No',v.pltid 'Plate Code',c.doc_no 'Doc No',DATE_FORMAT(c.date,'%d-%m-%Y') 'Date',br.branchname 'Branch',c.rdocno 'Ref Doc No',c.rdtype 'Ref Doc type' "
            			+ " FROM an_checksave c left join my_brch br on c.rbrhid=br.doc_no left join gl_vehmaster v on v.fleet_no=c.fleet"
            			+ " where date(c.date) between '"+sqlfromdate+"' and '"+sqltodate+"' "+sqltest+" ";
            	
            						
			//	System.out.println("-----chin-----:"+sqldata);
				ResultSet resultSet = stmtVeh1.executeQuery(sqldata);
				RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
				
				stmtVeh1.close();
				conn.close();
				 return RESULTDATA;

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

	
	
	
	
	public JSONArray subDetails(String doc) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        
       /* java.sql.Date sqlfromdate = null;
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
        */
        Connection conn = null;
        String sql="", vals="";
       
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement (); // UAL - UNallocated ,ANI - allocated not  Invoiced, AIN- allocated Invoiced , POS -traffic posted, RES - Received
			if(doc.equalsIgnoreCase("NA")||doc==null)
				{
					sql="SELECT name FROM gl_inspection ";  
				}
			else{
					String	values="SELECT value  FROM an_checksave where doc_no="+doc+" ";
					ResultSet rs = stmtVeh.executeQuery(values);
					while(rs.next())
					{
						vals=rs.getString("value")+",";
					}
					if(vals.endsWith(","))
					{
						vals = vals.substring(0,vals.length() - 1);
					}
					sql="select name,1 as val from gl_inspection where sr_no in ("+vals+") union all select name,0 as val from gl_inspection where sr_no not in ("+vals+")";

    	    	}
					
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

	 public JSONArray attachDetails(String docno) throws SQLException {
		     JSONArray RESULTDATA=new JSONArray();
			     try {
			    	 String  cpsql="";
			       Connection conn = ClsConnection.getMyConnection();
			       Statement cpstmt = conn.createStatement();
			      if(!(docno.equalsIgnoreCase("0")) || (docno.equalsIgnoreCase("NA")) || (docno.equalsIgnoreCase("")))
			       {
			     cpsql="select a.sr_no srno,a.dtype dtyp,a.descpt description,a.filename,replace(path,'\\\\',';') path"
			        		+ " from my_fileattach a left join an_checksave c on c.doc_no=a.doc_no "
			        		+ "where a.dtype='chi' and a.doc_no="+docno;
			     ResultSet resultSet = cpstmt.executeQuery(cpsql);
			       RESULTDATA=ClsCommon.convertToJSON(resultSet);
			       cpstmt.close();
			       conn.close();
			       }
			      
			       
			     }
			     catch(Exception e){
			      e.printStackTrace();
			     }
	           return RESULTDATA;
	       }
	 
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
