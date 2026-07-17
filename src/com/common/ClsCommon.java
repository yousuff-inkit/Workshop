package com.common;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.connection.*;
import com.google.gson.JsonElement;

import freemarker.core.ParseException;

import org.apache.commons.collections.map.StaticBucketMap;
import org.apache.struts2.ServletActionContext;

public class ClsCommon {
	ClsConnection ClsConnection=new ClsConnection();
	
	public  Date changeStringtoSqlDate(String startDate){
		java.sql.Date sqlStartDate=null;
		try{
			SimpleDateFormat sdf1 = new SimpleDateFormat("dd.MM.yyyy");
			java.util.Date date = sdf1.parse(startDate);
			sqlStartDate = new java.sql.Date(date.getTime());
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return sqlStartDate;
	}
	
	public  Date changeStringtoSqlDate2(String startDate){
		java.sql.Date sqlStartDate=null;
		try{
			SimpleDateFormat sdf1 = new SimpleDateFormat("dd-MM-yyyy");
			java.util.Date date = sdf1.parse(startDate);
			sqlStartDate = new java.sql.Date(date.getTime());
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return sqlStartDate;
	}
	public  String changeSqltoString(Date startDate){
		String testdate=startDate.toString();
		String temp="";
		try{
		    SimpleDateFormat format2 = new SimpleDateFormat("dd-MM-yyyy");
		    temp = format2.format(startDate);
		    
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return temp;
	}
	
	public  JSONArray convertToJSON(ResultSet resultSet)
			throws Exception {
			JSONArray jsonArray = new JSONArray();
			while (resultSet.next()) {
			int total_rows = resultSet.getMetaData().getColumnCount();
			JSONObject obj = new JSONObject();
			for (int i = 0; i < total_rows; i++) {
				 /*obj.put(resultSet.getMetaData().getColumnLabel(i + 1).toLowerCase(), (resultSet.getObject(i + 1)==null) ? "NA" : ((resultSet.getObject(i + 1).equals("0.0000")) ? " " : (resultSet.getObject(i + 1).toString()).replaceAll("[^a-zA-Z0-9_-_._; ]", " ")));*/
				 
			//	obj.put(resultSet.getMetaData().getColumnLabel(i + 1).toLowerCase(), ((resultSet.getObject(i + 1)==null) ? "" : resultSet.getObject(i + 1).toString().replaceAll("[^\\w\\s\\-_]", "")));
//commented on 05-05-2018				obj.put(resultSet.getMetaData().getColumnLabel(i + 1).toLowerCase(), ((resultSet.getObject(i + 1)==null) ? "" : resultSet.getObject(i + 1).toString().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " ")));
				  obj.put(resultSet.getMetaData().getColumnLabel(i + 1).toLowerCase(), ((resultSet.getObject(i + 1)==null) ? ""
						 : resultSet.getObject(i + 1).toString().replaceAll("[^a-zA-Z0-9/.+\\s+\\s-\\s:\\s*\\s@\\s\\&\\s%\\s(\\s)\\s;\\s_\\s,\\s#\\s]", " ").replaceAll("\t"," ")));
				
			}
			jsonArray.add(obj);
			}
			//System.out.println("ConvertTOJson:   "+jsonArray);
			return jsonArray;
			}
	
				
	public  JSONArray convertToSIF(ResultSet resultSet) throws Exception {
		   
		   JSONArray jsonArray = new JSONArray();

		   while (resultSet.next()) {
		   int total_rows = resultSet.getMetaData().getColumnCount();
		   
		   JSONObject obj = new JSONObject();
		   for (int i = 0; i < total_rows; i++) {
			 obj.put(resultSet.getMetaData().getColumnLabel(i + 1), ((resultSet.getObject(i + 1)==null) ? "NA" : resultSet.getObject(i + 1).toString()));
		   }
		   jsonArray.add(obj);
		   }
	   return jsonArray;
	   }
	public  Date changeStringtoSqlDate3(String startDate){
		java.sql.Date sqlStartDate=null;
		try{
			SimpleDateFormat sdf1 = new SimpleDateFormat("dd/MM/yyyy");
			java.util.Date date = sdf1.parse(startDate);
			sqlStartDate = new java.sql.Date(date.getTime());
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return sqlStartDate;
	}

	public  Date changetstmptoSqlDate(String startDate){

		   java.sql.Date sqlStartDate=null;
		    try{
		     
              SimpleDateFormat targetFormat = new SimpleDateFormat("EEE MMM dd yyyy HH:mm:ss");
              java.util.Date date1 = targetFormat.parse(startDate);
              sqlStartDate = new java.sql.Date(date1.getTime());
		              
		  }
		  catch(Exception e){
		   e.printStackTrace();
		  }
		  return sqlStartDate;
		 }
	
	public  double round(double value,HttpSession session) {
          int places=session.getAttribute("AMTDEC")==null?0:Integer.parseInt(session.getAttribute("AMTDEC").toString());
          if (places < 0) throw new IllegalArgumentException();
      
          BigDecimal bd = new BigDecimal(value);
          bd = bd.setScale(places, RoundingMode.HALF_UP);
          return bd.doubleValue();
      }
	public  String getMonthandDays(java.sql.Date closedate,java.sql.Date opendate,Connection conn) throws SQLException{
		Statement stmt=conn.createStatement();
		/*String getMonth="select a.months,DAY(LAST_DAY('"+closedate+"')) lastday, DATEDIFF( '"+closedate+"', DATE_ADD('"+opendate+"',INTERVAL a.months month) ) days from ("+
				" select if(day('"+opendate+"')>day('"+closedate+"'),PERIOD_DIFF( EXTRACT( YEAR_MONTH FROM '"+closedate+"' ),"+
				" EXTRACT( YEAR_MONTH FROM '"+opendate+"' ) )-1,PERIOD_DIFF( EXTRACT( YEAR_MONTH FROM '"+closedate+"' ),"+
				" EXTRACT( YEAR_MONTH FROM '"+opendate+"' ) )) months) a";*/
		
		/*String getMonth="select a.months,DAY(LAST_DAY('"+closedate+"')) lastday, DATEDIFF( '"+closedate+"',if(a.months>0,LAST_DAY(DATE_ADD( '"+opendate+"',INTERVAL a.months month)),"+
				" DATE_ADD('"+opendate+"',INTERVAL a.months month))) days from (select if(day('"+opendate+"')>day('"+closedate+"'),PERIOD_DIFF( EXTRACT( YEAR_MONTH FROM '"+closedate+"' ),"+
				" EXTRACT( YEAR_MONTH FROM '"+opendate+"' ) )-1,PERIOD_DIFF( EXTRACT( YEAR_MONTH FROM '"+closedate+"' ),EXTRACT( YEAR_MONTH FROM '"+opendate+"' ) )) months) a";*/
		
		/*(2015-05-18) String getMonth="select a.months,DAY(LAST_DAY('"+closedate+"')) lastday,DATEDIFF('"+closedate+"', '"+opendate+"' ) days from (select if(day('"+opendate+"')>day('"+closedate+"'),"+
				" PERIOD_DIFF( EXTRACT( YEAR_MONTH FROM '"+closedate+"' ),EXTRACT( YEAR_MONTH FROM '"+opendate+"' ) )-1,PERIOD_DIFF( EXTRACT( YEAR_MONTH FROM '"+closedate+"' ),"+
				" EXTRACT( YEAR_MONTH FROM '"+opendate+"' ) )) months) a";*/
		
		String getMonth="select if((DATEDIFF('"+closedate+"', '"+opendate+"')/DAY(LAST_DAY('"+closedate+"'))>=1),"+
				" concat(round(DATEDIFF('"+closedate+"', '"+opendate+"')/DAY(LAST_DAY('"+closedate+"'))),' Month'),concat(round(DATEDIFF('"+closedate+"', '"+opendate+"')),"+
				" ' Days')) days";
//		System.out.println("MnthDays Query:"+getMonth);
		ResultSet rsgetMonth=stmt.executeQuery(getMonth);
		String months="",days="",returnvalue="";
		while(rsgetMonth.next()){
			//months=rsgetMonth.getString("months");
			days=rsgetMonth.getString("days");
		}
/*		if(Double.parseDouble(months)<=0){
			returnvalue=days+" Days";
		}
		else if(Double.parseDouble(months)==1 && Double.parseDouble(days)==0){
			returnvalue=months+" Month";
		}
		else if(Double.parseDouble(months)>0 && Double.parseDouble(days)==0){
			
				returnvalue=months+" Months";
		}
		else if(Double.parseDouble(months)==1 && Double.parseDouble(days)==1){
			returnvalue=months+" Month "+days+" Day";
		}
		else{
			returnvalue=months+" Months "+days+" Days";
		}*/
		returnvalue=days;
		return returnvalue;
	}
	public  ArrayList<Double> getSalik(Date fromdate,Date todate,String clientid,String agmtno,String agmttype) throws SQLException{
		Connection conn=null;
		
		ArrayList<Double> salikarray= new ArrayList<Double>();
		try {
			String sqltestsalik="";
			String sqltesttraffic="";
			String sqlrtype="";
			
			conn=ClsConnection.getMyConnection();
		Statement	stmt = conn.createStatement();
			if(!(fromdate==null && todate==null)){
				if(agmttype.equalsIgnoreCase("RAG")){
					sqlrtype=" and rtype in('RA','RD','RW','RF','RM') ";
				}
				else if(agmttype.equalsIgnoreCase("LAG")){
					sqlrtype=" and rtype in('LA','LC') ";
				}
				sqltestsalik=" and sal_date <='"+todate+"'"+sqlrtype;
				sqltesttraffic=" and traffic_date <= '"+todate+"'"+sqlrtype;
				
			}
			
		int salikcount=0;
		double salamount=0.0;
		String strsalik="select COALESCE(sum(amount),0.0) amount,count(*) count,COALESCE(amount,0.0) salamount from gl_salik where amount>0 and inv_no=0 and  ra_no='"+agmtno+"' and isallocated=1 "+sqltestsalik;
		//System.out.println(strsalik);
		ResultSet rssalik=stmt.executeQuery(strsalik);
		double salikamt=0.0;
		while(rssalik.next()){
			salikamt=rssalik.getDouble("amount");
			salikcount=rssalik.getInt("count");
			salamount=rssalik.getDouble("salamount");
			
		}
		/*String srvcsalik="select method from gl_config where field_nme='srvcchgsalik'";
		//System.out.println(srvcsalik);
		ResultSet rssrvcsalik=stmt.executeQuery(srvcsalik);
		int srvcsalikmethod=0;
		if(rssrvcsalik.next()){
			srvcsalikmethod=rssrvcsalik.getInt("method");
		}*/
		
		int srvcdefault=0;
		double salikrate=0.0,trafficrate=0.0;
		String stracbook="select ser_default,per_salikrate,per_trafficharge from my_acbook where cldocno='"+clientid+"' and dtype='CRM' and status<>7";
		//System.out.println("Acbbok"+stracbook);
		ResultSet rsacbook=stmt.executeQuery(stracbook);
		while(rsacbook.next()){
			srvcdefault=rsacbook.getInt("ser_default");
			if(srvcdefault==0){
				salikrate=rsacbook.getDouble("per_salikrate");
				trafficrate=rsacbook.getDouble("per_trafficharge");
			}
		}
		
		int trafficmethod=0;
		double trafficapply=0.0;
		double trafficsrvc=0.0;
		double trafficsrvcper=0.0;
		double trafficpercalc=0.0;
		double finaltrafficsrvc=0.0;
		int trafficpermethod=0,trafficsrvmethod=0;
		double trafficamt=0.0;
		int trafficcount=0;
		if(srvcdefault==0){
			String strtraffic="select  COALESCE(sum(amount),0.0) trafficamt,count(*) count  from gl_traffic where amount>0 and inv_no=0 and isallocated=1 and emp_type='CRM' and ra_no='"+agmtno+"'"+sqltesttraffic;
//			System.out.println(strtraffic);
			ResultSet rstraffic=stmt.executeQuery(strtraffic);
			while(rstraffic.next()){
				trafficamt=rstraffic.getDouble("trafficamt");
				trafficcount=rstraffic.getInt("count");
			}	
		}
		
		if(srvcdefault==1){
			String saliksrv="select if((select method from gl_config where field_nme='saliksrv')=1,(select value from gl_config where field_nme='saliksrv'),0)"+
					" saliksrv  from gl_config where field_nme='saliksrv'";
			ResultSet rssaliksrv=stmt.executeQuery(saliksrv);
			while(rssaliksrv.next()){
				salikrate=rssaliksrv.getDouble("saliksrv");
			}
			String strtrafficsrv="select method,value,field_nme from gl_config where field_nme in('trafficsrvapply','trafficsrvper','trafficsrv')";
			//String strtrafficsrv="select method,value from gl_config where field_nme='trafficsrvapply'";
			ResultSet rstrafficsrvapply=stmt.executeQuery(strtrafficsrv);
			while(rstrafficsrvapply.next()){
				if(rstrafficsrvapply.getString("field_nme").equalsIgnoreCase("trafficsrvapply")){
					trafficmethod=rstrafficsrvapply.getInt("method");
					trafficapply=rstrafficsrvapply.getDouble("value");	
				}
				if(rstrafficsrvapply.getString("field_nme").equalsIgnoreCase("trafficsrvper")){
					trafficpermethod=rstrafficsrvapply.getInt("method");
					trafficsrvcper=rstrafficsrvapply.getDouble("value");
				}
				if(rstrafficsrvapply.getString("field_nme").equalsIgnoreCase("trafficsrv")){
					trafficsrvmethod=rstrafficsrvapply.getInt("method");
					trafficsrvc=rstrafficsrvapply.getDouble("value");
				}
				
			}		
			
			
			double traffic=0.0,pertraffic=0.0,amttraffic=0.0; 
			ClsCommon objcommon=new ClsCommon();
			double trafficfees=0.0;
			trafficfees=objcommon.getTrafficFees(Integer.parseInt(agmtno),fromdate,todate,agmttype,"1");
			
			
			
			String strtrafficvalues="select  if(COALESCE(sum(amount),0.0)>0.0,COALESCE(sum(amount),0.0)+"+trafficfees+",0.0) trafficamt,count(*) count  from gl_traffic where amount>0 and inv_no=0 and emp_type='CRM' and ra_no='"+agmtno+"'"+sqltesttraffic;
			System.out.println(" Inside Srvc Default Traffic Query"+strtrafficvalues);
			ResultSet rstrafficvalues=stmt.executeQuery(strtrafficvalues);
			while(rstrafficvalues.next()){
				if(trafficrate>0.0)	{
					traffic=trafficrate*rstrafficvalues.getDouble("trafficamt");
					trafficcount=rstrafficvalues.getInt("count");
				}
				else {
						if(trafficpermethod==1){
							pertraffic=rstrafficvalues.getDouble("trafficamt")*(trafficsrvcper/100);
							trafficcount=rstrafficvalues.getInt("count");
						}
						else if(trafficpermethod==0){
							pertraffic=0;
							}
					
						if(trafficsrvmethod==1){
							amttraffic=trafficsrvc;
							trafficcount=rstrafficvalues.getInt("count");
						}
						else if(trafficsrvmethod==0){
							amttraffic=0;
						}
						if(trafficmethod==1){traffic=pertraffic;	}
						if(trafficmethod==0){traffic=amttraffic*trafficcount;	}
						if(trafficmethod==2){traffic=(trafficapply>=pertraffic)?trafficapply:pertraffic;	}
					}	
//				System.out.println("Traffic Method Check:"+trafficmethod);
				finaltrafficsrvc+=traffic;
				trafficamt+=rstrafficvalues.getDouble("trafficamt");
				//System.out.println("============"+finaltrafficsrvc);
			}
			}
		else{
			finaltrafficsrvc=trafficrate*trafficcount;
		}
			//System.out.println("FinalTraffic"+finaltrafficsrvc);
				
				
	/*		if(srvcdefault==1){
				salikrate=salikamt;
			}*/
		double saliksrvcchg=salikcount*salikrate;
		double saliktemprate=0.0;
		if(salamount>0){
			saliktemprate=salikrate;
		}
		
		//System.out.println("Salik Srvc"+saliksrvcchg);
		salikarray.add(salikamt);
		salikarray.add(trafficamt);
		salikarray.add(saliksrvcchg);
		salikarray.add(finaltrafficsrvc);
		salikarray.add((double) salikcount);
		salikarray.add((double)trafficcount);
		salikarray.add(salamount);
		salikarray.add(saliktemprate);
		conn.close();
		return salikarray;
		
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			conn.close();
		
		}
		finally{
			conn.close();
		}
		return salikarray;
		
	}
	
	
	public  java.sql.Date getSqlDate(Object value)
    {
       java.sql.Date dtvalue=null;
       try
       {
        java.util.Date utilDate=null;
          if(value instanceof java.util.Date)
           utilDate=(java.util.Date) value;
          else  if(value instanceof java.sql.Date)
          {
           dtvalue=(java.sql.Date) value;
           return dtvalue; 
          }
          else
         utilDate=parseDate((String)value);
           dtvalue=new java.sql.Date(utilDate.getTime());
       }catch(Exception e){
    	   e.printStackTrace();
    	   
       }
        return dtvalue;
    }
 

    public  java.util.Date parseDate(Object ostr_date) throws ParseException, java.text.ParseException
    {
         DateFormat formatter ;
         //Date date = null ;
         java.util.Date date =null;
         String str_date=null;
         formatter = new SimpleDateFormat("dd/MM/yyyy");
         formatter.setLenient(false);
         if (ostr_date!=null)
         {
        if (ostr_date instanceof java.sql.Date)
        {
         date =new java.util.Date(((java.sql.Date)ostr_date).getTime());
        }
        if (ostr_date instanceof java.util.Date)
        {
         date =(java.util.Date)ostr_date;
        }
        else
        {
          str_date=String.valueOf(ostr_date);
          if (str_date.length()>4 && (str_date.indexOf('/')==4 || str_date.indexOf('.')==4 || str_date.indexOf('-')==4))
          {
           str_date=(str_date.substring(8,10)+"/"+str_date.substring(5,7) +"/"+ str_date.substring(0,4));
          }
          if (str_date!=null && !str_date.isEmpty())
              date = formatter.parse(str_date);                     
          }
        }
        return date;
    }
    
    public String checkFuelName(Connection conn,String fuel) throws SQLException{
		String fuelname="";
		try{
		Statement stmtfuelcheck=conn.createStatement();
		String strfuelcheck="select CASE WHEN "+fuel+"=0.000 THEN 'Level 0/8' WHEN "+fuel+"=0.125 THEN 'Level 1/8' WHEN "+fuel+"=0.250 THEN 'Level 2/8'"+
				" WHEN "+fuel+"=0.375 THEN 'Level 3/8' WHEN "+fuel+"=0.500 THEN 'Level 4/8' WHEN "+fuel+"=0.625 THEN 'Level 5/8'  WHEN "+fuel+"=0.750"+
				" THEN 'Level 6/8' WHEN "+fuel+"=0.875 THEN 'Level 7/8' WHEN "+fuel+"=1.000 THEN 'Level 8/8'  END as 'fuel'";
		ResultSet rsfuelcheck=stmtfuelcheck.executeQuery(strfuelcheck);
		while(rsfuelcheck.next()){
			fuelname=rsfuelcheck.getString("fuel");
		}
		}
		catch(Exception e){
			conn.close();
			return fuelname;
		}
		return fuelname;
	}
    
    
    public  double Round(double value,int deci) throws SQLException
    {
    	Connection conn=null;
    	try{
    		
    		conn=ClsConnection.getMyConnection();
    		Statement stmt=conn.createStatement();
    		String compid="1";
    		String str="select cvalue from my_system where comp_id="+compid+" and codeno='amtdec'";
    		ResultSet rs=stmt.executeQuery(str);
    		while(rs.next()){
    			deci=rs.getInt("cvalue");
    		}
    		BigDecimal bd = new BigDecimal(value).setScale(deci, RoundingMode.HALF_EVEN);
    	      value = bd.doubleValue();
    	      stmt.close();
    	      conn.close();
    	      
    	}
    	catch(Exception e){
    		e.printStackTrace();
    		conn.close();
    	}
    	finally{
    		conn.close();
    	}
    	return value; 
   }
    
    public String getBIBPrintPath(String dtype) throws SQLException{
	     
		Connection conn=null;
	    String path="";
	     
	     try{
	        conn=ClsConnection.getMyConnection();
	        Statement stmtpath=conn.createStatement();
	      
	        String sqlpath="select printpath from gl_bibd where dtype='"+dtype+"'";
	        ResultSet rspath=stmtpath.executeQuery(sqlpath);
	      
	        while(rspath.next()){
	           path=rspath.getString("printpath");
	        }
	        
	        stmtpath.close();
	        conn.close();
	     }
	     catch(Exception e){
	         e.printStackTrace();
	         conn.close();
	         return "fail";
	     }
	     return path;
	    }
    
    public  String getPrintPath(String dtype) throws SQLException{
	     
		Connection conn=null;
	    String path="";
	     
	     try{
	        conn=ClsConnection.getMyConnection();
	        Statement stmtpath=conn.createStatement();
	      
	        String sqlpath="select printpath from my_menu where doc_type='"+dtype+"'";
	        ResultSet rspath=stmtpath.executeQuery(sqlpath);
	      
	        while(rspath.next()){
	           path=rspath.getString("printpath");
	        }
	        
	        stmtpath.close();
	        conn.close();
	     }
	     catch(Exception e){
	         e.printStackTrace();
	         conn.close();
	         return "fail";
	     }
	     return path;
	    }
    
	public  String getPrintPath2(String dtype) throws SQLException{
        
        Connection conn=null;
           String path2="";
           // System.out.println("---------------------------------");
            try{
               conn=ClsConnection.getMyConnection();
               Statement stmtpath=conn.createStatement();
             
               String sqlpath="select printpath2 from my_menu where doc_type='"+dtype+"'";
              // System.out.println("sqlpath---------------"+sqlpath);
               ResultSet rspath=stmtpath.executeQuery(sqlpath);
             
               while(rspath.next()){
                  path2=rspath.getString("printpath2");
                  
                  //System.out.println("path------"+path2);
                  
               }
               
               stmtpath.close();
               conn.close();
            }
            catch(Exception e){
                e.printStackTrace();
                conn.close();
                return "fail";
            }
            return path2;
           }
		   
		   public  JSONArray convertToEXCEL(ResultSet resultSet)
		   throws Exception {
//		   System.out.println("==== "+resultSet);
		   JSONArray jsonArray = new JSONArray();
//		   resultSet.first();
		   while (resultSet.next()) {
			 //  System.out.println("===== TOT=== "+resultSet.getMetaData().getColumnCount());
		   int total_rows = resultSet.getMetaData().getColumnCount();
		   
		   JSONObject obj = new JSONObject();
		   for (int i = 0; i < total_rows; i++) {
			//   System.out.println("===="+resultSet.getMetaData().getColumnLabel(i + 1)+"===="+ ((resultSet.getObject(i + 1)==null) ? "NA" : resultSet.getObject(i + 1).toString()));
		     obj.put(resultSet.getMetaData().getColumnLabel(i + 1), ((resultSet.getObject(i + 1)==null) ? "NA" : resultSet.getObject(i + 1).toString()));
		   }
		   jsonArray.add(obj);
		   }
//		   System.out.println("js=="+jsonArray);
		   return jsonArray;
		   }
    
		/*For Cheque Line Breaker[Amount in Words]*/
		public  String addLinebreaks(String input, double maxLineLength) {

	 	StringTokenizer tok = new StringTokenizer(input, " ");
	    StringBuilder output = new StringBuilder(input.length());
	    int lineLen = 0;
	    while (tok.hasMoreTokens()) {
	        String word = tok.nextToken()+" ";

	        if (lineLen + word.length() > maxLineLength) {
	            output.append("::"+"\n");
	            lineLen = 0;
	        }
	        output.append(word);
	        lineLen += word.length();
	    }
	        return output.toString();
	    }
		/*For Cheque Line Breaker[Amount in Words] Ends*/
		
		/*Finace Reports Case Statement for Voc_no in Doc_no*/
		public  String getFinanceVocTablesCase(Connection conn) throws SQLException{
    	String vocCase="CASE";
    	
		try{
			Statement stmtFinace=conn.createStatement();
		
			String strvoctable="select alias_name,dtype from win_tbldet where vocno_status=1";
			ResultSet rsvocjoins=stmtFinace.executeQuery(strvoctable);
			
			String aliasName="";String vocDtypeName="";
			
			while(rsvocjoins.next()){
				aliasName=rsvocjoins.getString("alias_name");
				vocDtypeName=rsvocjoins.getString("dtype");
				
				vocCase+=" WHEN a.transType in ("+vocDtypeName+") THEN "+aliasName+".voc_no";
			}
			vocCase+=" ELSE a.transno END AS 'transno',";
			
		stmtFinace.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
			return vocCase;
		}
		return vocCase;
	}
    /*Finace Reports Case Statement for Voc_no in Doc_no Ends*/
	
	/*Finace Reports Joins for Voc_no in Doc_no*/
		public  String getFinanceVocTablesJoins(Connection conn) throws SQLException{
	    	String vocJoins="";
	    	
			try{
				Statement stmtFinace=conn.createStatement();
			
				String strvoctable="select voc_joins from win_tbldet where vocno_status=1";
				ResultSet rsvocjoins=stmtFinace.executeQuery(strvoctable);
				
				while(rsvocjoins.next()){
					
					vocJoins+=" "+rsvocjoins.getString("voc_joins");
				}
			
			stmtFinace.close();
			}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
				return vocJoins;
			}
			return vocJoins;
		}
		
		/*public  String getFinanceVocTablesJoins(Connection conn) throws SQLException{
    	String vocJoins="";
    	
		try{
			Statement stmtFinace=conn.createStatement();
		
			String strvoctable="select mstTable,alias_name,dtype from win_tbldet where vocno_status=1";
			ResultSet rsvocjoins=stmtFinace.executeQuery(strvoctable);
			
			String vocTableJoins="";String aliasName="";String vocDtypeName="";
			
			while(rsvocjoins.next()){
				vocTableJoins=rsvocjoins.getString("mstTable");
				aliasName=rsvocjoins.getString("alias_name");
				vocDtypeName=rsvocjoins.getString("dtype");
				
				vocJoins+=" left join "+vocTableJoins+" "+aliasName+" on a.transno="+aliasName+".doc_no and a.transType in ("+vocDtypeName+")";
			}
		
		stmtFinace.close();
		}
		catch(Exception e){
			conn.close();
			return vocJoins;
		}
		return vocJoins;
	}*/
	/*Finace Reports Joins for Voc_no in Doc_no Ends*/


		   public double getTrafficFees(int agmtno, java.sql.Date fromdate,java.sql.Date todate, String agmttype,String datemode) throws SQLException {
				// TODO Auto-generated method stub
				Connection conn=null;
				try{
					conn=ClsConnection.getMyConnection();
					Statement stmt=conn.createStatement();
					int feesmethod=0;
					double feesvalue=0.0;
					int trafficcount=0;
					double finaltrafficfees=0.0;
					String sqltesttraffic="";
					String strgetfees="select method,value from gl_config where field_nme='govTrafficFees'";
					
					ResultSet rsgetfees=stmt.executeQuery(strgetfees);
					while(rsgetfees.next()){
						feesmethod=rsgetfees.getInt("method");
						feesvalue=rsgetfees.getDouble("value");
					}
					if(agmttype.equalsIgnoreCase("RAG")){
						sqltesttraffic+=" and rtype in ('RA','RD','RW','RF','RM')";
					}
					if(agmttype.equalsIgnoreCase("LAG")){
						sqltesttraffic+=" and rtype in ('LA','LC')";
					}
					if(datemode.equalsIgnoreCase("1")){
						sqltesttraffic=" and traffic_date <= '"+todate+"'";	
					}
					if(datemode.equalsIgnoreCase("0")){
						sqltesttraffic=" and traffic_date >= '"+fromdate+"' and traffic_date<='"+todate+"'";
					}
					
					String strgettraffic="select count(*) maxcount from gl_traffic where emp_type='CRM' and amount>0 and inv_no=0 and isallocated=1 and fine_source like '%DUBAI%' and ra_no='"+agmtno+"'"+sqltesttraffic;
					//System.out.println(strgettraffic);
					ResultSet rsgettraffic=stmt.executeQuery(strgettraffic);
					while(rsgettraffic.next()){
						trafficcount=rsgettraffic.getInt("maxcount");
					}
					
					if(feesmethod==1 && feesvalue>0.0){
						finaltrafficfees=trafficcount*feesvalue;
					}
					stmt.close();
					return finaltrafficfees;
				}
				catch(Exception e){
					e.printStackTrace();
					
				}
				finally{
					conn.close();
				}
				return 0;
			}


 public String getBIBPrintPath1(String dtype) throws SQLException{
	     
		Connection conn=null;
	    String path="";
	     
	     try{
	        conn=ClsConnection.getMyConnection();
	        Statement stmtpath=conn.createStatement();
	      
	        String sqlpath="select printpath1 from gl_bibd where dtype='"+dtype+"'";
	        ResultSet rspath=stmtpath.executeQuery(sqlpath);
	      
	        while(rspath.next()){
	           path=rspath.getString("printpath1");
	        }
	        
	        stmtpath.close();
	        conn.close();
	     }
	     catch(Exception e){
	         e.printStackTrace();
	         conn.close();
	         return "fail";
	     }
	     return path;
	    }

    public  double sqlRound(double value,int deci) throws SQLException
    {
    	Connection conn=null;
    	double roundvalue=0.0;
    	try{
    		
    		conn=ClsConnection.getMyConnection();
    		Statement stmt=conn.createStatement();
    		String str="select round("+value+","+deci+") roundvalue";
    		ResultSet rs=stmt.executeQuery(str);
    		while(rs.next()){
    			roundvalue=rs.getDouble("roundvalue");
    		}

    		stmt.close();
    	      conn.close();
    	      
    	}
    	catch(Exception e){
    		e.printStackTrace();
    		conn.close();
    	}
    	finally{
    		conn.close();
    	}
    	return roundvalue; 
   }

	
}
