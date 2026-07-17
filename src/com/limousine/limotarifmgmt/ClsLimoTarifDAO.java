package com.limousine.limotarifmgmt;

import java.sql.Array;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.controlcentre.masters.tarifmgmt.ClsTarifBean;

public class ClsLimoTarifDAO {
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	public int insert(Date sqldate, String cmbtariffor, String cmbtariftype,
			String hidtarifclient, Date sqlfromdate, Date sqltodate,
			String hidchkdelivery, String desc, String mode, HttpSession session, String brchname, String formdetailcode) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn=null;
		int docno=0;
		try{
			conn=objconn.getMyConnection();
			conn.setAutoCommit(false);
			CallableStatement stmttarif =conn.prepareCall("{call limoTarifMasterDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmttarif.registerOutParameter(12, java.sql.Types.INTEGER);
			stmttarif.setDate(1, sqldate);
	        stmttarif.setString(2, cmbtariftype);
	        stmttarif.setString(3, hidtarifclient);
	        stmttarif.setString(4, cmbtariffor);
	        stmttarif.setDate(5, sqlfromdate);
	        stmttarif.setDate(6, sqltodate);
	        stmttarif.setString(7, hidchkdelivery);
	        stmttarif.setString(8, brchname);
	        stmttarif.setString(9, session.getAttribute("USERID").toString());
	        stmttarif.setString(10, desc);
	        stmttarif.setString(11, session.getAttribute("COMPANYID").toString());
	        stmttarif.setString(13, mode);
	        stmttarif.setString(14, formdetailcode);
			stmttarif.executeQuery();
			docno=stmttarif.getInt("docNo");
			if(docno<=0){
				return 0;
			}
			else{
				conn.commit();
				return docno;
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return 0;
	}

	public boolean edit(int docno, Date sqldate,String cmbtariffor, String cmbtariftype,
			String hidtarifclient, Date sqlfromdate, Date sqltodate,
			String hidchkdelivery, String desc, String mode,
			HttpSession session, String brchName, String formdetailcode) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			conn.setAutoCommit(false);
			CallableStatement stmttarif =conn.prepareCall("{call limoTarifMasterDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmttarif.setInt(12, docno);
			stmttarif.setDate(1, sqldate);
	        stmttarif.setString(2, cmbtariftype);
	        stmttarif.setString(3, hidtarifclient);
	        stmttarif.setString(4, cmbtariffor);
	        stmttarif.setDate(5, sqlfromdate);
	        stmttarif.setDate(6, sqltodate);
	        stmttarif.setString(7, hidchkdelivery);
	        stmttarif.setString(8, brchName);
	        stmttarif.setString(9, session.getAttribute("USERID").toString());
	        stmttarif.setString(10, desc);
	        stmttarif.setString(11, session.getAttribute("COMPANYID").toString());
	        stmttarif.setString(13, mode);
	        stmttarif.setString(14, formdetailcode);
			int val=stmttarif.executeUpdate();
			if(val<0){
				return false;
			}
			else{
				conn.commit();
				return true;
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return false;
	}

	public boolean delete(int docno, Date sqldate, String cmbtariffor,
			String cmbtariftype, String hidtarifclient, Date sqlfromdate,
			Date sqltodate, String hidchkdelivery, String desc, String mode,
			HttpSession session, String brchName, String formdetailcode) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			conn.setAutoCommit(false);
			CallableStatement stmttarif =conn.prepareCall("{call limoTarifMasterDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmttarif.setInt(12, docno);
			stmttarif.setDate(1, sqldate);
	        stmttarif.setString(2, cmbtariftype);
	        stmttarif.setString(3, hidtarifclient);
	        stmttarif.setString(4, cmbtariffor);
	        stmttarif.setDate(5, sqlfromdate);
	        stmttarif.setDate(6, sqltodate);
	        stmttarif.setString(7, hidchkdelivery);
	        stmttarif.setString(8, brchName);
	        stmttarif.setString(9, session.getAttribute("USERID").toString());
	        stmttarif.setString(10, desc);
	        stmttarif.setString(11, session.getAttribute("COMPANYID").toString());
	        stmttarif.setString(13, mode);
	        stmttarif.setString(14, formdetailcode);
			int val=stmttarif.executeUpdate();
			if(val<0){
				return false;
			}
			else{
				conn.commit();
				return true;
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return false;
	}

	public JSONArray masterSearch() throws SQLException{
		JSONArray RESULTDATA=new JSONArray();
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			ResultSet rs=stmt.executeQuery("select trf.doc_no,trf.date,trf.brhid,trf.tariftype,trf.tarifclient,trf.tariffor,trf.validfrom fromdate,trf.validto todate,"+
			" trf.delstatus,trf.desc1,coalesce(ac.cat_name,'') refname,br.branchname from gl_limotarifm trf left join my_clcatm ac on (trf.tarifclient=ac.doc_no"+
			" and ac.dtype='CRM') left join my_brch br on trf.brhid=br.doc_no where trf.status=3");
			RESULTDATA=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return RESULTDATA;
	}
	
	public JSONArray getCategory(String tariftype) throws SQLException {
	    Connection conn = null;
	    JSONArray RESULTDATA=new JSONArray();
		try {
				conn=objconn.getMyConnection();
				Statement stmtTarif = conn.createStatement ();
	        	String strSql="";
	        	if(tariftype.equalsIgnoreCase("client")){
	        		strSql="select doc_no,refname from my_acbook where dtype='CRM' and status<>7";
	        	}
	        	else if(tariftype.equalsIgnoreCase("corporate")){
	        		strSql="select doc_no,cat_name refname from my_clcatm where dtype='CRM' and status<>7";
	        	}
	        	else{
	        		
	        	}
	        	if(!strSql.equalsIgnoreCase("")){
		        	ResultSet resultSet = stmtTarif.executeQuery (strSql);
					RESULTDATA=objcommon.convertToJSON(resultSet);
	        	}

				stmtTarif.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
	    return RESULTDATA;
	}
	
	public JSONArray getNewGroup() throws SQLException {
	    Connection conn = null;
	    JSONArray RESULTDATA=new JSONArray();
		try {
				conn=objconn.getMyConnection();
				Statement stmtTarif = conn.createStatement ();
	        	String strSql="select distinct gname gid,doc_no from gl_vehgroup where status<>7";
	        	ResultSet resultSet = stmtTarif.executeQuery (strSql);
				RESULTDATA=objcommon.convertToJSON(resultSet);
				stmtTarif.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
	    return RESULTDATA;
	}
	
	public JSONArray getGroup1(String docno) throws SQLException {
	    Connection conn = null;
	    JSONArray RESULTDATA=new JSONArray();
		try {
				conn=objconn.getMyConnection();
				Statement stmtTarif = conn.createStatement();
	        	String strSql= "select grp.gname gid,grp.doc_no from  gl_vehgroup grp where grp.status<>7 and grp.doc_no not in(select distinct if(td.gid is null,"+
	        			" if(tc.gid is null,'0',tc.gid),td.gid) gid from gl_limotarifm tm left join gl_limotariftransfer td on tm.doc_no=td.tarifdocno"+
	        			" left join gl_limotarifhours tc on tm.doc_no=tc.tarifdocno where tm.doc_no='"+docno+"')";
	        	ResultSet resultSet = stmtTarif.executeQuery (strSql);
				RESULTDATA=objcommon.convertToJSON(resultSet);
				stmtTarif.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
	    return RESULTDATA;
	}
	
	public  JSONArray getGroup2(String docno) throws SQLException {
	    JSONArray RESULTDATA=new JSONArray();
	    Connection conn = null;
		try {
				conn=objconn.getMyConnection();
				Statement stmtTarif = conn.createStatement ();
	        	/*String strSql="select distinct if(m2.gid is null,grp2.gname,grp1.gname) gid,if(m2.gid is null,grp2.doc_no,grp1.doc_no) docno,"+
	        			" coalesce(ex.securityamt,0) securityamt,coalesce(ex.insurexcess,0) insurexcess,coalesce(ex.cdwexcess,0) cdwexcess,coalesce(ex.scdwexcess,0) scdwexcess"+
	        			" from gl_tarifm m1 left join gl_tarifd m2 on m1.doc_no=m2.doc_no left join gl_tarifcondn m3 on m1.doc_no=m3.doc_no left join"+
	        			" gl_tarifexcess ex on ((m1.doc_no=ex.rdocno and m2.gid=ex.gid) or (m1.doc_no=ex.rdocno and m3.gid=ex.gid))"+
	        			" left join gl_vehgroup grp1 on m2.gid=grp1.doc_no left join gl_vehgroup grp2 on m3.gid=grp2.doc_no  where m1.doc_no='"+docno+"'";*/
				String strSql="select distinct if(m2.gid is null,grp2.gname,grp1.gname) gid,if(m2.gid is null,grp2.doc_no,grp1.doc_no) docno "+
	        			" from gl_limotarifm m1 left join gl_limotariftransfer m2 on m1.doc_no=m2.tarifdocno left join gl_limotarifhours m3 on m1.doc_no=m3.tarifdocno"+
	        			" left join gl_vehgroup grp1 on m2.gid=grp1.doc_no left join gl_vehgroup grp2 on m3.gid=grp2.doc_no  where m1.doc_no='"+docno+"'";
	        	ResultSet resultSet = stmtTarif.executeQuery (strSql);
				RESULTDATA=objcommon.convertToJSON(resultSet);
				stmtTarif.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
	    return RESULTDATA;
	}
	public  JSONArray getLocations() throws SQLException {
	    JSONArray locdata=new JSONArray();
	    Connection conn = null;
		try {
				conn=objconn.getMyConnection();
				Statement stmtTarif = conn.createStatement ();
				String strSql="select doc_no,location from gl_cordinates where status=3";
	        	ResultSet resultSet = stmtTarif.executeQuery (strSql);
	        	locdata=objcommon.convertToJSON(resultSet);
	        	
	        	stmtTarif.close();
		
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
	    return locdata;
	}
	
	
	public  JSONArray getTarifTransfer(String id,String gid,String docno) throws SQLException {
		JSONArray transferdata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
	    	return transferdata;
	    }

	    Connection conn = null;
		try {
				conn=objconn.getMyConnection();
				Statement stmtTarif = conn.createStatement ();
				String strSql="select pickup.location pickuploc,dropoff.location dropoffloc,tran.pickuplocid,tran.dropofflocid,tran.estdist estdistance,"+
				" tran.esttime,tran.tarif,tran.exdistrate exdistancerate,tran.extimerate from gl_limotariftransfer tran left join gl_cordinates"+
				" pickup on tran.pickuplocid=pickup.doc_no left join gl_cordinates dropoff on tran.dropofflocid=dropoff.doc_no where"+
				" tran.gid="+gid+" and tran.tarifdocno="+docno+" and tran.status=3";
	        	System.out.println(strSql);
				ResultSet resultSet = stmtTarif.executeQuery (strSql);
	        	transferdata=objcommon.convertToJSON(resultSet);
	        	
	        	stmtTarif.close();
		
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
	    return transferdata;
	}
	
	public  JSONArray getTarifHours(String id,String gid,String docno) throws SQLException {
		JSONArray hoursdata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
	    	return hoursdata;
	    }

	    Connection conn = null;
		try {
				conn=objconn.getMyConnection();
				Statement stmtTarif = conn.createStatement ();
				String strSql="select blockhrs,tarif limotarif,exhrrate,nighttarif,nightexhrrate from gl_limotarifhours tran where"+
				" tran.gid="+gid+" and tran.tarifdocno="+docno+" and tran.status=3";
	        	ResultSet resultSet = stmtTarif.executeQuery (strSql);
	        	hoursdata=objcommon.convertToJSON(resultSet);
	        	
	        	stmtTarif.close();
		
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
	    return hoursdata;
	}

	public int detailinsert(int docno, String hidgroup,
			ArrayList<String> transferarray, ArrayList<String> hoursarray,
			HttpSession session, String brchName) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmt=conn.createStatement();
			int deletevaltransfer=stmt.executeUpdate("delete from gl_limotariftransfer where tarifdocno="+docno+" and gid="+hidgroup+" and status=3");
			for(int i=0;i<transferarray.size();i++){
				String arr[]=transferarray.get(i).split("::");
				if(!arr[0].equalsIgnoreCase("") && !arr[0].equalsIgnoreCase("undefined") && arr[0]!=null){
					System.out.println("Time:"+arr[3]+"//////");
					CallableStatement stmttarif =conn.prepareCall("{call limoTarifDetailDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
					stmttarif.setInt(16, java.sql.Types.INTEGER);
					stmttarif.setInt(1, docno);
			        stmttarif.setString(2, hidgroup);
			        stmttarif.setString(3, arr[0]);
			        stmttarif.setString(4, arr[1]);
			        stmttarif.setString(5, arr[2]);
			        stmttarif.setString(6, arr[3]);
			        stmttarif.setString(7, arr[4]);
			        stmttarif.setString(8, arr[5]);
			        stmttarif.setString(9, arr[6]);
			        stmttarif.setString(10, "transfer");
			        stmttarif.setString(11, "0");
			        stmttarif.setString(12, "0");
			        stmttarif.setString(13, "0");
			        stmttarif.setString(14, "0");
			        stmttarif.setString(15, "0");
			        stmttarif.executeQuery();
			        int val=stmttarif.getInt("docNo");
					if(val<0){
						return 0;
					}
					else{
						conn.commit();
					}
				}
			}
			int deletevalhours=stmt.executeUpdate("delete from gl_limotarifhours where tarifdocno="+docno+" and gid="+hidgroup+" and status=3");
			for(int i=0;i<hoursarray.size();i++){
				String arr[]=hoursarray.get(i).split("::");
				if(!arr[0].equalsIgnoreCase("") && !arr[0].equalsIgnoreCase("undefined") && arr[0]!=null){
				
					CallableStatement stmttarif =conn.prepareCall("{call limoTarifDetailDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
					stmttarif.setInt(16, java.sql.Types.INTEGER);
					stmttarif.setInt(1, docno);
			        stmttarif.setString(2, hidgroup);
			        stmttarif.setString(3, "0");
			        stmttarif.setString(4, "0");
			        stmttarif.setString(5, "0");
			        stmttarif.setString(6, "0");
			        stmttarif.setString(7, "0");
			        stmttarif.setString(8, "0");
			        stmttarif.setString(9, "0");
			        stmttarif.setString(10, "hours");
			        stmttarif.setString(11, arr[0]);
			        stmttarif.setString(12, arr[1]);
			        stmttarif.setString(13, arr[2]);
			        stmttarif.setString(14, arr[3]);
			        stmttarif.setString(15, arr[4]);
			        stmttarif.executeQuery();
			        int val=stmttarif.getInt("docNo");
					if(val<0){
						return 0;
					}
					else{
						conn.commit();
					}
				}	
			}
			return 1;
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return 0;
	}
	
	
	public JSONArray getClient(String name,String mobile,String id,String tariftype) throws SQLException{
		JSONArray clientdata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return clientdata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String sqltest="";
			if(!name.equalsIgnoreCase("")){
				sqltest+=" and ac.refname like '%"+name+"%'";
			}
			if(!mobile.equalsIgnoreCase("")){
				sqltest+=" and ac.per_mob like '%"+mobile+"%'";
			}
			String strsql="";
			if(tariftype.equalsIgnoreCase("client")){
				strsql="select ac.cldocno,ac.refname,ac.address,ac.per_mob from my_acbook ac where ac.status=3 and ac.dtype='CRM'"+sqltest;
			}
			else if(tariftype.equalsIgnoreCase("corporate")){
				strsql="select doc_no cldocno,cat_name refname from my_clcatm where dtype='CRM' and status<>7";
			}
			ResultSet rsclient=stmt.executeQuery(strsql);
			clientdata=objcommon.convertToJSON(rsclient);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return clientdata;
	}
	
}
