package com.workshop.packagemaster;

import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsWSPackageMasterDAO {

	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	
	public JSONArray getLabourSearchData(String jobdocno,String jobtype,String date,String id,String gatedocno,String jobtypename) throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="";
			String sqltest="";
			java.sql.Date sqldate=null;
			if(!jobdocno.equalsIgnoreCase("")){
				sqltest+=" and m.doc_no like '%"+jobdocno+"%'";
			}
			if(!jobtype.equalsIgnoreCase("")){
				sqltest+=" and m.desc1 like '%"+jobtype+"%'";
			}
			if(!date.equalsIgnoreCase("")){
				sqldate=objcommon.changeStringtoSqlDate(date);
				sqltest+=" and m.date='"+sqldate+"'";
			}
			if(!jobtypename.equalsIgnoreCase("")){
				sqltest+=" and t.type like '%"+jobtypename+"%'";
			}
			int movno=0,luxury=0,jobcostconfig=0;
			/*String strgate="select (select method from gl_config where field_nme='wsJobTypeCost') jobcostconfig,coalesce(movno,0) movno,coalesce(luxury,0) luxury from ws_gateinpass where doc_no="+gatedocno;
			ResultSet rsgate=stmt.executeQuery(strgate);
			while(rsgate.next()){
				movno=rsgate.getInt("movno");
				luxury=rsgate.getInt("luxury");
				jobcostconfig=rsgate.getInt("jobcostconfig");
			}*/
			String jobcost="";
			if(movno>0){
				jobcost="Internal";
			}
			else{
				if(luxury>0){
					jobcost="Luxury";
				}
				else{
					jobcost="External";
				}
			}
			double jobrate=0.0;
			if(!jobcost.equalsIgnoreCase("")){
				String strgetjobrate="select rate from ws_jobtypecost where description='"+jobcost+"'";
				ResultSet rsjobrate=stmt.executeQuery(strgetjobrate);
				while(rsjobrate.next()){
					jobrate=rsjobrate.getDouble("rate");
				}
			}
			if(jobcostconfig>0 && !jobcost.equalsIgnoreCase("")){
				strsql="select t.taxable,m.desc1 jobdesc,m.doc_no,m.date,m.stdrate hrs,"+jobrate+" rate,t.type jobtype,m.jobid from ws_jobmaster m left join ws_jobtype t on m.jobid=t.doc_no where m.status=3"+sqltest;
			}
			else{
				strsql="select t.taxable,m.desc1 jobdesc,m.doc_no,m.date,m.stdrate hrs,m.stdcostperhr rate,t.type jobtype,m.jobid from ws_jobmaster m left join ws_jobtype t on m.jobid=t.doc_no where m.status=3"+sqltest;
			}
			System.out.println(strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			data=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		
		return data;
	}

	public int insert(ClsWSPackageMasterAction masteraction,
			ArrayList<String> sparearray, ArrayList<String> labourarray,
			Date sqldate, Date sqlfromdate, Date sqltodate, HttpSession session, HttpServletRequest request, Connection conn) {
		// TODO Auto-generated method stub
		int docno=0;
		try{
			Statement stmt=conn.createStatement();
			ResultSet rsmaxdocno=stmt.executeQuery("select coalesce(max(doc_no),0)+1 maxdocno from ws_packagem");
			while(rsmaxdocno.next()){
				docno=rsmaxdocno.getInt("maxdocno");
			}
			String userid=session.getAttribute("USERID")==null?"0":session.getAttribute("USERID").toString();
			String strinsertmaster="insert into ws_packagem(doc_no, date, userid, brhid, packagename, fromdate, todate, brdid, modelid, amount, maxusage, description, status)values("+
			""+docno+",'"+sqldate+"',"+userid+","+masteraction.getBrchName()+",'"+masteraction.getPackagename()+"','"+sqlfromdate+"','"+sqltodate+"',"+masteraction.getCmbbrand()+","+masteraction.getCmbmodel()+","+masteraction.getAmount()+","+masteraction.getMaxusage()+",'"+masteraction.getDescription()+"',3)";
			int insertmaster=stmt.executeUpdate(strinsertmaster);
			if(insertmaster<=0){
				return 0;
			}
			for(int i=0;i<sparearray.size();i++){
				String spdesc=sparearray.get(i).split("::")[0].trim();
				String qty=sparearray.get(i).split("::")[1].trim();
				String psrno=sparearray.get(i).split("::")[2].trim();
				if(psrno.equalsIgnoreCase("") || psrno.equalsIgnoreCase("undefined") || psrno==null){
					psrno="0";
				}
				String seqno=sparearray.get(i).split("::")[3];
				
				String strinsert="insert into ws_packagespare(rdocno, spdesc, psrno, qty, seqno)values("+docno+",'"+spdesc+"',"+qty+","+psrno+","+seqno+")";
				int insert=stmt.executeUpdate(strinsert);
				if(insert<=0){
					return 0;
				}
			}
			for(int i=0;i<labourarray.size();i++){
				String jobid=labourarray.get(i).split("::")[0].trim();
				String hrs=labourarray.get(i).split("::")[1].trim();
				String remarks=labourarray.get(i).split("::")[2].trim();
				String jobtype=labourarray.get(i).split("::")[3].trim();
				String jobdesc=labourarray.get(i).split("::")[4].trim();
				String seqno=labourarray.get(i).split("::")[5];
				
				String strinsert="insert into ws_packagelabour(rdocno, jobtypeid, strjobtype, jobdesc, jobqty, remarks, seqno)values("+docno+","+jobid+",'"+jobtype+"','"+jobdesc+"',"+hrs+",'"+remarks+"',"+seqno+")";
				int insert=stmt.executeUpdate(strinsert);
				if(insert<=0){
					return 0;
				}
			}
			
			String strlog="insert into datalog(doc_no, brhId, dtype, edate, userId, userNo, activity, ENTRY)values("+docno+","+masteraction.getBrchName()+",'"+masteraction.getFormdetailcode()+"',now(),"+userid+",0,0,'A')";
			int log=stmt.executeUpdate(strlog);
			if(log<=0){
				return 0;
			}
			
		}
		catch(Exception e){
			e.printStackTrace();
			return 0;
		}
		
		return docno;
	}

	public boolean edit(ClsWSPackageMasterAction masteraction,
			ArrayList<String> sparearray, ArrayList<String> labourarray,
			Date sqldate, Date sqlfromdate, Date sqltodate,
			HttpSession session, HttpServletRequest request, Connection conn) {
		// TODO Auto-generated method stub
		try{
			Statement stmt=conn.createStatement();
			
			String userid=session.getAttribute("USERID")==null?"0":session.getAttribute("USERID").toString();
			String strinsertmaster="update ws_packagem set date='"+sqldate+"', userid="+userid+", brhid="+masteraction.getBrchName()+", packagename='"+masteraction.getPackagename()+"', fromdate='"+sqlfromdate+"', todate='"+sqltodate+"', brdid="+masteraction.getCmbbrand()+", modelid="+masteraction.getCmbmodel()+", amount="+masteraction.getAmount()+", maxusage="+masteraction.getMaxusage()+", description='"+masteraction.getDescription()+"' where doc_no="+masteraction.getDocno();
			int insertmaster=stmt.executeUpdate(strinsertmaster);
			if(insertmaster<=0){
				return false;
			}
			int deletespare=stmt.executeUpdate("delete from ws_packagespare where rdocno="+masteraction.getDocno());
			int deletelabour=stmt.executeUpdate("delete from ws_packagelabour where rdocno="+masteraction.getDocno());
			for(int i=0;i<sparearray.size();i++){
				String spdesc=sparearray.get(i).split("::")[0].trim();
				String qty=sparearray.get(i).split("::")[1].trim();
				String psrno=sparearray.get(i).split("::")[2].trim();
				if(psrno.equalsIgnoreCase("") || psrno.equalsIgnoreCase("undefined") || psrno==null){
					psrno="0";
				}
				String seqno=sparearray.get(i).split("::")[3];
				
				String strinsert="insert into ws_packagespare(rdocno, spdesc, psrno, qty, seqno)values("+masteraction.getDocno()+",'"+spdesc+"',"+qty+","+psrno+","+seqno+")";
				int insert=stmt.executeUpdate(strinsert);
				if(insert<=0){
					return false;
				}
			}
			for(int i=0;i<labourarray.size();i++){
				String jobid=labourarray.get(i).split("::")[0].trim();
				String hrs=labourarray.get(i).split("::")[1].trim();
				String remarks=labourarray.get(i).split("::")[2].trim();
				String jobtype=labourarray.get(i).split("::")[3].trim();
				String jobdesc=labourarray.get(i).split("::")[4].trim();
				String seqno=labourarray.get(i).split("::")[5];
				
				String strinsert="insert into ws_packagelabour(rdocno, jobtypeid, strjobtype, jobdesc, jobqty, remarks, seqno)values("+masteraction.getDocno()+","+jobid+",'"+jobtype+"','"+jobdesc+"',"+hrs+",'"+remarks+"',"+seqno+")";
				int insert=stmt.executeUpdate(strinsert);
				if(insert<=0){
					return false;
				}
			}
			
			String strlog="insert into datalog(doc_no, brhId, dtype, edate, userId, userNo, activity, ENTRY)values("+masteraction.getDocno()+","+masteraction.getBrchName()+",'"+masteraction.getFormdetailcode()+"',now(),"+userid+",0,0,'E')";
			int log=stmt.executeUpdate(strlog);
			if(log<=0){
				return false;
			}
			
		}
		catch(Exception e){
			e.printStackTrace();
			return false;
		}
		
		return true;
	}

	public boolean delete(ClsWSPackageMasterAction masteraction,
			ArrayList<String> sparearray, ArrayList<String> labourarray,
			Date sqldate, Date sqlfromdate, Date sqltodate,
			HttpSession session, HttpServletRequest request, Connection conn) {
		// TODO Auto-generated method stub
		try{
			Statement stmt=conn.createStatement();
			
			String userid=session.getAttribute("USERID")==null?"0":session.getAttribute("USERID").toString();
			String strinsertmaster="update ws_packagem set status=7 where doc_no="+masteraction.getDocno();
			int insertmaster=stmt.executeUpdate(strinsertmaster);
			if(insertmaster<=0){
				return false;
			}
			
			String strlog="insert into datalog(doc_no, brhId, dtype, edate, userId, userNo, activity, ENTRY)values("+masteraction.getDocno()+","+masteraction.getBrchName()+",'"+masteraction.getFormdetailcode()+"',now(),"+userid+",0,0,'D')";
			int log=stmt.executeUpdate(strlog);
			if(log<=0){
				return false;
			}
		}
		catch(Exception e){
			e.printStackTrace();
			return false;
		}
			
		return true;
	}
	
	public JSONArray getSparepartsData(String docno,String id) throws SQLException
	{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select spdesc description,psrno,qty,seqno from ws_packagespare where rdocno="+docno+" order by seqno";
			System.out.println("Spare==="+strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			data=objcommon.convertToJSON(rs);
			
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		return data;
	}
	
	public JSONArray getLabourcostData(String docno,String id)throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			/*String strsql="select m.desc1 jobdesc,m.doc_no,m.date,lab.hrs,lab.rate,t.type jobtype,lab.markupper markuppercent,lab.total,lab.remarks, "+
			" lab.jobid from ws_estlabour lab left join ws_jobmaster m on (lab.jobid=m.doc_no ) left join ws_jobtype t on m.jobid=t.doc_no "+
			" where m.status=3 and lab.addition=0 and lab.rdocno='"+docno+"'";*/
			String strsql="select lab.jobqty,lab.jobqty hrs,lab.seqno,lab.jobdesc,lab.strjobtype jobtype,lab.strjobtype,lab.remarks,lab.jobtypeid jobid from ws_packagelabour lab where lab.rdocno="+docno+" order by lab.seqno";
			System.out.println("Labour Data:"+strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			data=objcommon.convertToJSON(rs);
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		return data;
	}
	
	public JSONArray getMasterSearch(String brand,String packagename,String docno,String date,String id,String brhid,String model) throws SQLException
	{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			
			String strsql="";
			String sqltest="";
			java.sql.Date sqldate=null;
			if(!brand.equalsIgnoreCase("")){
				sqltest+=" and m.brdid="+brand;
			}
			
			if(!packagename.equalsIgnoreCase("")){
				sqltest+=" and m.packagename like '%"+packagename+"%'";
			}
			if(!docno.equalsIgnoreCase("")){
				sqltest+=" and m.doc_no like '%"+docno+"%'";
			}
			if(!model.equalsIgnoreCase("")){
				sqltest+=" and m.brdid="+model;
			}
			if(!date.equalsIgnoreCase("")){
				sqldate=objcommon.changeStringtoSqlDate(date);
				sqltest+=" and m.date='"+sqldate+"'";
			}
			if(!brhid.equalsIgnoreCase("")){
				sqltest+=" and m.brhid="+brhid;
			}
			strsql="select m.doc_no,m.date,m.packagename,m.fromdate,m.todate,m.brdid,m.modelid,brd.brand_name brand,model.vtype model,m.amount,m.maxusage,m.description from ws_packagem m"+
			" left join gl_vehbrand brd on m.brdid=brd.doc_no"+
			" left join gl_vehmodel model on m.modelid=model.doc_no where m.status=3"+sqltest;
			ResultSet rs=stmt.executeQuery(strsql);
			data=objcommon.convertToJSON(rs);
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		return data;
	}
}
