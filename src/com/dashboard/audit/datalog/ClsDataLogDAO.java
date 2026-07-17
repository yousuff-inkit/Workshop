package com.dashboard.audit.datalog;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsDataLogDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();


	public JSONArray getLogData(String branch,String fromdate,String todate,String id,String hiduser,String hidform,String value) throws SQLException {
		  String strSql="";
		    JSONArray RESULTDATA=new JSONArray();
		    if(!id.equalsIgnoreCase("1")){
				return RESULTDATA;
			}   
		    Connection  conn = null;
			java.sql.Date sqlfromdate=null,sqltodate=null;
	           try {
				if(!fromdate.equalsIgnoreCase("")){
					sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
				}
				if(!todate.equalsIgnoreCase("")){
					sqltodate=ClsCommon.changeStringtoSqlDate(todate);
				}
				String sqltest="";
				if(sqlfromdate!=null){
					sqltest+=" and dat.edate>='"+sqlfromdate+"'";
				}
				if(sqltodate!=null){
					sqltest+=" and dat.edate<='"+sqltodate+"'";
				}
				
				if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
					sqltest+=" and dat.brhid="+branch+"";
				}
				if(!hiduser.equalsIgnoreCase("")){
					sqltest+=" and dat.userid="+hiduser;
				}
				
				
					conn=ClsConnection.getMyConnection();
					Statement stmtmanual = conn.createStatement ();
					
					if(value.equalsIgnoreCase("formbtn")){
						
						if(!hidform.equalsIgnoreCase("")){
								if(hidform.equalsIgnoreCase("5")){
									sqltest+=" and dat.dtype='INT'";
								}
								else if(hidform.equalsIgnoreCase("6")){
									sqltest+=" and dat.dtype='INS'";
								}
								else{
									sqltest+=" and menu.mno="+hidform;
								}
								
							}
					strSql="select case when dat.dtype in ('INV','INS','INT') then inv.voc_no when dat.dtype='RAG' then rag.voc_no when dat.dtype='RAC' then"+
							" rac.voc_no when dat.dtype='LAG' then lag.voc_no when dat.dtype='LAC' then lac.voc_no else dat.doc_no end doc_no,br.branchname,"+
							" dat.dtype,case when dat.dtype='INT' then 'Invoice Traffic' when dat.dtype='INS' then 'Invoice Salik' else menu.menu_name end formname,usr.user_name user,case when dat.entry='A' then 'Add' when dat.entry='E' then 'Edit' when dat.entry='D' then"+
							" 'Delete' when dat.entry='R' then 'Release' else dat.entry end action,dat.edate date from datalog dat left join my_menu menu on"+
							" dat.dtype=menu.doc_type  left join my_user usr on dat.userid=usr.doc_no left join my_brch br on dat.brhid=br.doc_no left join"+
							" gl_ragmt rag on (dat.dtype='RAG' and dat.doc_no=rag.doc_no) left join gl_ragmtclosem rac on (dat.dtype='RAC' and"+
							" dat.doc_no=rac.doc_no) left join gl_lagmt lag on (dat.dtype='LAG' and dat.doc_no=lag.doc_no) left join gl_lagmtclosem lac on"+
							" (dat.dtype='LAC' and dat.doc_no=lac.doc_no) left join gl_invm inv on"
							+ " (dat.dtype in ('INV','INS','INT') and dat.doc_no=inv.doc_no) where 1=1 "+sqltest;
					 }
					 else if(value.equalsIgnoreCase("bibtn")){
						 if(!hidform.equalsIgnoreCase("")){
								
									sqltest+=" and menu.doc_no="+hidform;
								}
			
						 strSql="select dat.doc_no ,br.branchname, dat.dtype,case when dat.dtype='INT' then 'Invoice Traffic' "+
								"  when dat.dtype='INS' then 'Invoice Salik' else menu.description end formname, "+
								" usr.user_name user,case when dat.entry='A' then 'Add' when dat.entry='E' "+
								" then 'Edit' when dat.entry='D' then 'Delete' when dat.entry='R' then 'Release' "+
								 " else dat.entry end action,dat.edate date "+
								  " from gl_biblog dat left join "+
								 " gl_bibd menu on dat.dtype=menu.dtype "+
								 " left join my_user usr on dat.userid=usr.doc_no "+
								 " left join my_brch br on dat.brhid=br.doc_no "+
								  " where 1=1   "+sqltest ;
					 }
					 
				System.out.println(strSql);
					ResultSet resultSet = stmtmanual.executeQuery (strSql);
					RESULTDATA=ClsCommon.convertToJSON(resultSet);
					stmtmanual.close();
					conn.close();
			}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
			finally{
				conn.close();
			}
			//System.out.println("RESULTDATA=========>"+RESULTDATA);
		    return RESULTDATA;
		}

	
	public JSONArray getLogExcelData(String branch,String fromdate,String todate,String id,String hiduser,String hidform,String value) throws SQLException {
		 String strSql="";
		    JSONArray RESULTDATA=new JSONArray();
		    if(!id.equalsIgnoreCase("1")){
				return RESULTDATA;
			}   
		    Connection  conn = null;
			java.sql.Date sqlfromdate=null,sqltodate=null;
	           try {
				if(!fromdate.equalsIgnoreCase("")){
					sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
				}
				if(!todate.equalsIgnoreCase("")){
					sqltodate=ClsCommon.changeStringtoSqlDate(todate);
				}
				String sqltest="";
				if(sqlfromdate!=null){
					sqltest+=" and dat.edate>='"+sqlfromdate+"'";
				}
				if(sqltodate!=null){
					sqltest+=" and dat.edate<='"+sqltodate+"'";
				}
				
				if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
					sqltest+=" and dat.brhid="+branch+"";
				}
				if(!hiduser.equalsIgnoreCase("")){
					sqltest+=" and dat.userid="+hiduser;
				}
				
				
					conn=ClsConnection.getMyConnection();
					Statement stmtmanual = conn.createStatement ();
					
					if(value.equalsIgnoreCase("formbtn")){
						
						if(!hidform.equalsIgnoreCase("")){
								if(hidform.equalsIgnoreCase("5")){
									sqltest+=" and dat.dtype='INT'";
								}
								else if(hidform.equalsIgnoreCase("6")){
									sqltest+=" and dat.dtype='INS'";
								}
								else{
									sqltest+=" and menu.mno="+hidform;
								}
								
							}
					strSql="select case when dat.dtype in ('INV','INS','INT') then inv.voc_no when dat.dtype='RAG' then rag.voc_no when dat.dtype='RAC' then"+
							" rac.voc_no when dat.dtype='LAG' then lag.voc_no when dat.dtype='LAC' then lac.voc_no else dat.doc_no end doc_no,br.branchname,"+
							" dat.dtype,case when dat.dtype='INT' then 'Invoice Traffic' when dat.dtype='INS' then 'Invoice Salik' else menu.menu_name end formname,usr.user_name user,case when dat.entry='A' then 'Add' when dat.entry='E' then 'Edit' when dat.entry='D' then"+
							" 'Delete' when dat.entry='R' then 'Release' else dat.entry end action,dat.edate date from datalog dat left join my_menu menu on"+
							" dat.dtype=menu.doc_type  left join my_user usr on dat.userid=usr.doc_no left join my_brch br on dat.brhid=br.doc_no left join"+
							" gl_ragmt rag on (dat.dtype='RAG' and dat.doc_no=rag.doc_no) left join gl_ragmtclosem rac on (dat.dtype='RAC' and"+
							" dat.doc_no=rac.doc_no) left join gl_lagmt lag on (dat.dtype='LAG' and dat.doc_no=lag.doc_no) left join gl_lagmtclosem lac on"+
							" (dat.dtype='LAC' and dat.doc_no=lac.doc_no) left join gl_invm inv on"
							+ " (dat.dtype in ('INV','INS','INT') and dat.doc_no=inv.doc_no) where 1=1 "+sqltest;
					 }
					 else if(value.equalsIgnoreCase("bibtn")){
						 if(!hidform.equalsIgnoreCase("")){
								
									sqltest+=" and menu.doc_no="+hidform;
								}
			
						 strSql="select dat.doc_no ,br.branchname, dat.dtype,case when dat.dtype='INT' then 'Invoice Traffic' "+
								"  when dat.dtype='INS' then 'Invoice Salik' else menu.description end formname, "+
								" usr.user_name user,case when dat.entry='A' then 'Add' when dat.entry='E' "+
								" then 'Edit' when dat.entry='D' then 'Delete' when dat.entry='R' then 'Release' "+
								 " else dat.entry end action,dat.edate date "+
								  " from gl_biblog dat left join "+
								 " gl_bibd menu on dat.dtype=menu.dtype "+
								 " left join my_user usr on dat.userid=usr.doc_no "+
								 " left join my_brch br on dat.brhid=br.doc_no "+
								  " where 1=1   "+sqltest ;
					 }
					 
				System.out.println(strSql);
					ResultSet resultSet = stmtmanual.executeQuery (strSql);
					RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
					stmtmanual.close();
					conn.close();
			}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
			finally{
				conn.close();
			}
			//System.out.println("RESULTDATA=========>"+RESULTDATA);
		    return RESULTDATA;
		}

	
	
	
	
	
	public JSONArray getUser(String check) throws SQLException {
			String strSql="";
		    JSONArray RESULTDATA=new JSONArray();
		    if(!(check.trim().equalsIgnoreCase("1"))){
		    	return RESULTDATA;
		    }
		    Connection  conn = null;
	        try {
				conn=ClsConnection.getMyConnection();
				Statement stmtuser = conn.createStatement ();
				
				strSql="select user_name user,doc_no from my_user where status=3";
				ResultSet resultSet = stmtuser.executeQuery (strSql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				stmtuser.close();
				conn.close();
			}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
			finally{
				conn.close();
			}
			System.out.println("RESULTDATA=========>"+RESULTDATA);
		    return RESULTDATA;
		}
	
	public JSONArray getForm(String check) throws SQLException {
		String strSql="";
	    JSONArray RESULTDATA=new JSONArray();
	    if(!(check.equalsIgnoreCase("1")))
	    {
	    	return RESULTDATA;
	    }
	    Connection  conn = null;
        try {
			conn=ClsConnection.getMyConnection();
			Statement stmtuser = conn.createStatement ();
			
			strSql="select mno,menu_name menu from my_menu where pmenu<>0 and gate='E' and func<>'' ";
			ResultSet resultSet = stmtuser.executeQuery (strSql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
			stmtuser.close();
			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		//System.out.println("RESULTDATA=========>"+RESULTDATA);
	    return RESULTDATA;
	}
	
	public JSONArray getForm1(String check) throws SQLException {
		String strSql="";
	    JSONArray RESULTDATA=new JSONArray();
	    if(!(check.equalsIgnoreCase("1")))
	    {
	    	return RESULTDATA;
	    }
	    Connection  conn = null;
        try {
			conn=ClsConnection.getMyConnection();
			Statement stmtuser = conn.createStatement ();
			
			strSql="select doc_no,description from gl_bibd where status='1'";
			System.out.println(strSql);
			ResultSet resultSet = stmtuser.executeQuery (strSql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
			stmtuser.close();
			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		//System.out.println("RESULTDATA=========>"+RESULTDATA);
	    return RESULTDATA;
	}public JSONArray subDetails(String branch,String fromdate,String todate,String id,String hiduser,String hidform,String value) throws SQLException {

		 String strSql="";
		    JSONArray RESULTDATA=new JSONArray();
		    if(!id.equalsIgnoreCase("1")){
				return RESULTDATA;
			}   
		    Connection  conn = null;
			java.sql.Date sqlfromdate=null,sqltodate=null;
	           try {
				if(!fromdate.equalsIgnoreCase("")){
					sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
				}
				if(!todate.equalsIgnoreCase("")){
					sqltodate=ClsCommon.changeStringtoSqlDate(todate);
				}
				String sqltest="";
				if(sqlfromdate!=null){
					sqltest+=" and dat.edate>='"+sqlfromdate+"'";
				}
				if(sqltodate!=null){
					sqltest+=" and dat.edate<='"+sqltodate+"'";
				}
				
				if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
					sqltest+=" and dat.brhid="+branch+"";
				}
				if(!hiduser.equalsIgnoreCase("")){
					sqltest+=" and dat.userid="+hiduser;
				}
				
				
					conn=ClsConnection.getMyConnection();
					Statement stmtmanual = conn.createStatement ();
					
					if(value.equalsIgnoreCase("formbtn")){
						
						if(!hidform.equalsIgnoreCase("")){
								if(hidform.equalsIgnoreCase("5")){
									sqltest+=" and dat.dtype='INT'";
								}
								else if(hidform.equalsIgnoreCase("6")){
									sqltest+=" and dat.dtype='INS'";
								}
								else{
									sqltest+=" and menu.mno="+hidform;
								}
								
							}
					strSql="select case when dat.dtype in ('INV','INS','INT') then inv.voc_no when dat.dtype='RAG' then rag.voc_no when dat.dtype='RAC' then"+
							" rac.voc_no when dat.dtype='LAG' then lag.voc_no when dat.dtype='LAC' then lac.voc_no else dat.doc_no end doc_no,br.branchname,"+
							" dat.dtype,case when dat.dtype='INT' then 'Invoice Traffic' when dat.dtype='INS' then 'Invoice Salik' else menu.menu_name end formname,count(*) count,usr.user_name user,case when dat.entry='A' then 'Add' when dat.entry='E' then 'Edit' when dat.entry='D' then"+
							" 'Delete' when dat.entry='R' then 'Release' else dat.entry end action,dat.edate date from datalog dat left join my_menu menu on"+
							" dat.dtype=menu.doc_type  left join my_user usr on dat.userid=usr.doc_no left join my_brch br on dat.brhid=br.doc_no left join"+
							" gl_ragmt rag on (dat.dtype='RAG' and dat.doc_no=rag.doc_no) left join gl_ragmtclosem rac on (dat.dtype='RAC' and"+
							" dat.doc_no=rac.doc_no) left join gl_lagmt lag on (dat.dtype='LAG' and dat.doc_no=lag.doc_no) left join gl_lagmtclosem lac on"+
							" (dat.dtype='LAC' and dat.doc_no=lac.doc_no) left join gl_invm inv on"
							+ " (dat.dtype in ('INV','INS','INT') and dat.doc_no=inv.doc_no) where 1=1 "+sqltest+" group by usr.doc_no ";
					 }
					 else if(value.equalsIgnoreCase("bibtn")){
						 if(!hidform.equalsIgnoreCase("")){
								
									sqltest+=" and menu.doc_no="+hidform;
								}
			
						 strSql="select dat.doc_no ,br.branchname, dat.dtype,case when dat.dtype='INT' then 'Invoice Traffic' "+
								"  when dat.dtype='INS' then 'Invoice Salik' else menu.description end formname, "+
								"count(*) count, usr.user_name user,case when dat.entry='A' then 'Add' when dat.entry='E' "+
								" then 'Edit' when dat.entry='D' then 'Delete' when dat.entry='R' then 'Release' "+
								 " else dat.entry end action,dat.edate date "+
								  " from gl_biblog dat left join "+
								 " gl_bibd menu on dat.dtype=menu.dtype "+
								 " left join my_user usr on dat.userid=usr.doc_no "+
								 " left join my_brch br on dat.brhid=br.doc_no "+
								  " where 1=1   "+sqltest+" group by usr.doc_no "; 
					 }
					 
				System.out.println(strSql);
					ResultSet resultSet = stmtmanual.executeQuery (strSql);
					RESULTDATA=ClsCommon.convertToJSON(resultSet);
					stmtmanual.close();
					conn.close();
			}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
			finally{
				conn.close();
			}
			//System.out.println("RESULTDATA=========>"+RESULTDATA);
		    return RESULTDATA;
		}

	
}
