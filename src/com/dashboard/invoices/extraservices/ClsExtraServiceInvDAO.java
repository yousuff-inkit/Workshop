package com.dashboard.invoices.extraservices;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsExtraServiceInvDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	
	public JSONArray getExServiceInvData(String uptodate,String branchvalue,String temp) throws SQLException {
		
        
        JSONArray RESULTDATA=new JSONArray();
        Connection  conn =null;
		try {
			conn=ClsConnection.getMyConnection();
			
			String sqlbranch="";
//			System.out.println("Branch Value:"+branchvalue);
			if(!((branchvalue.equalsIgnoreCase("NA"))||(branchvalue.equalsIgnoreCase("a")))){
				sqlbranch=" and req.brhid="+branchvalue;
			}
			java.sql.Date sqldate=null;
	        if(!(uptodate.equalsIgnoreCase(""))){
	        	sqldate=ClsCommon.changeStringtoSqlDate(uptodate);
	        }	
			
			//System.out.println("DESC1:"+desc1);
				
				Statement stmtservice = conn.createStatement ();
				if(temp.equalsIgnoreCase("1")){
					/*String strSql="select req.doc_no,req.aggno rano,req.rtype ratype,req.date,ac.acno,head.description acname,ac.cldocno,round(sum(reqd.amount),2) amount from "+
							" gl_othreq req left join gl_othreqd reqd on req.doc_no=reqd.rdocno left join my_acbook ac on (req.cldocno=ac.cldocno and ac.dtype='CRM') "+
							" left join my_head head on ac.acno=head.doc_no where invno=0 and req.date<='"+sqldate+"' "+sqlbranch+" group by reqd.rdocno"; */
			 String strSql="select if(req.rtype='RAG',agmt.voc_no,lagmt.voc_no) refvocno,req.doc_no,req.aggno rano,req.rtype ratype,req.date,ac.acno,"+
							" head.description acname,ac.cldocno,round(sum(reqd.amount),2) amount from gl_othreq req left join gl_othreqd reqd on "+
							" req.doc_no=reqd.rdocno  and req.brhid=reqd.brhid  left join gl_ragmt agmt on(req.aggno=agmt.doc_no and req.rtype='RAG') left join gl_lagmt lagmt on "+
							" (req.aggno=lagmt.doc_no and req.rtype='LAG') left join my_acbook ac on (req.cldocno=ac.cldocno and ac.dtype='CRM') left join "+
							" my_head head on ac.acno=head.doc_no where invno=0 and req.date<='"+sqldate+"' "+sqlbranch+"  group by reqd.rdocno";
				
			 // System.out.println("Grid Sql Query: "+strSql);
			             	ResultSet resultSet = stmtservice.executeQuery (strSql);
			        		RESULTDATA=ClsCommon.convertToJSON(resultSet);
							
							
			        		
							   	
				}
				stmtservice.close();
				conn.close();
  
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
        return RESULTDATA;
    }

	public String getInvmodeAcno() throws SQLException {
		// TODO Auto-generated method stub
		Connection conn=null;
		int accacno=0,extrainsuracno=0,otheracno=0;
		
		try{
			conn=ClsConnection.getMyConnection();
			Statement stmt=conn.createStatement();
			String stracno="select (select acno from gl_invmode where idno=2)accacno,(select acno from gl_invmode where idno=7)extrainsuracno,"+
					" (select acno from gl_invmode where idno=12)otheracno";
			ResultSet rsacno=stmt.executeQuery(stracno);
			
			while(rsacno.next()){
				accacno=rsacno.getInt("accacno");
				extrainsuracno=rsacno.getInt("extrainsuracno");
				otheracno=rsacno.getInt("otheracno");
				
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
		return accacno+"::"+extrainsuracno+"::"+otheracno;
	}

	public ArrayList<String> getServiceRequestData(int docno,String cmbbranch) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn=null;
		ArrayList<String> dataarray=new ArrayList<>();
		try{
			conn=ClsConnection.getMyConnection();
			Statement stmt=conn.createStatement();
			String strdata="select type_id,amount from gl_othreqd where rdocno="+docno+" and brhid="+cmbbranch;
			ResultSet rsdata=stmt.executeQuery(strdata);
			double accamt=0.0,insuramt=0.0,otheramt=0.0;
			while(rsdata.next()){
				if(rsdata.getString("type_id").equalsIgnoreCase("1")){
					accamt+=rsdata.getDouble("amount");
				}
				else if(rsdata.getString("type_id").equalsIgnoreCase("3")){
					insuramt+=rsdata.getDouble("amount");
				}
				else{
					otheramt+=rsdata.getDouble("amount");
				}
			}
			
			dataarray.add(accamt+"");
			dataarray.add(insuramt+"");
			dataarray.add(otheramt+"");
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
		return dataarray;
	}

	public int updateInvNo(Connection conn,int docno, int val,String cmbbranch) throws SQLException {
		// TODO Auto-generated method stub
		
		try{
			
			
			Statement stmt=conn.createStatement();
			String strupdate="update gl_othreq set invno="+val+" where doc_no="+docno+" and brhid="+cmbbranch;
			int updateval=stmt.executeUpdate(strupdate);
			if(updateval>0){
				return updateval;
			}
			else{
				return 0;
			}
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		return 0;
	}
}
