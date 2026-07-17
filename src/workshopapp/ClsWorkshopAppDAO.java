package workshopapp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import java.sql.*;
import java.util.ArrayList;
import java.util.Map;

import com.common.ClsCommon;
import com.common.ClsEncrypt;
import com.connection.ClsConnection;
import com.login.ClsLogin;
import com.workshop.wsjobcard_fancy.ClsWSJobCardDAO;

public class ClsWorkshopAppDAO {
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	ClsLogin objlogin=new ClsLogin();
	
	public JSONArray getVehColorData(Connection conn) throws SQLException{
		JSONArray data=new JSONArray();
		try{
			Statement stmt=conn.createStatement();
			String strsql="select doc_no docno, color refname from my_color where status=3";
			ResultSet rs=stmt.executeQuery(strsql);
			while(rs.next()){
				JSONObject objtemp=new JSONObject();
				objtemp.put("docno",rs.getString("docno"));
				objtemp.put("refname",rs.getString("refname"));
				data.add(objtemp);
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return data;
	}
	public  JSONArray getClientData(Connection conn) throws SQLException {
		JSONArray data=new JSONArray();
		try{
			Statement stmt=conn.createStatement();
			String strsql="select cldocno docno,refname,coalesce(per_mob,'') mobile,coalesce(mail1,'') email from my_acbook where status=3 and dtype='CRM'";
			ResultSet rs=stmt.executeQuery(strsql);
			while(rs.next()){
				JSONObject objtemp=new JSONObject();
				objtemp.put("docno",rs.getString("docno"));
				objtemp.put("refname",rs.getString("refname"));
				objtemp.put("mobile",rs.getString("mobile"));
				objtemp.put("email",rs.getString("email"));
				data.add(objtemp);
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return data;
    }
	
	public  JSONArray getServiceAdvisorData(Connection conn) throws SQLException {
		JSONArray data=new JSONArray();
		try{
			Statement stmt=conn.createStatement();
			String strsql="select sal.doc_no docno,sal.sal_name refname from my_salesman sal where status=3 and sal_type='WSA'";
			ResultSet rs=stmt.executeQuery(strsql);
			while(rs.next()){
				JSONObject objtemp=new JSONObject();
				objtemp.put("docno",rs.getString("docno"));
				objtemp.put("refname",rs.getString("refname"));
				data.add(objtemp);
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return data;
    }
	public JSONArray getYomData(Connection conn) throws SQLException{
		JSONArray data=new JSONArray();
		try{
			Statement stmt=conn.createStatement();
			String strsql="select doc_no docno,yom refname from gl_yom order by yom desc ";
			ResultSet rs=stmt.executeQuery(strsql);
			while(rs.next()){
				JSONObject objtemp=new JSONObject();
				objtemp.put("docno",rs.getString("docno"));
				objtemp.put("refname",rs.getString("refname"));
				data.add(objtemp);
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return data;
	}
	public JSONArray getVehPlateData(Connection conn) throws SQLException{
		JSONArray data=new JSONArray();
		try{
			Statement stmt=conn.createStatement();
			String strsql="select plt.doc_no docno,concat(coalesce(auth.authid,''),' ',coalesce(plt.code_name,'')) refname from gl_vehplate plt left join gl_vehauth auth on plt.authid=auth.doc_no where plt.status=3";
			ResultSet rs=stmt.executeQuery(strsql);
			while(rs.next()){
				JSONObject objtemp=new JSONObject();
				objtemp.put("docno",rs.getString("docno"));
				objtemp.put("refname",rs.getString("refname"));
				data.add(objtemp);
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return data;
	}
	
	public JSONArray getVehAuthData(Connection conn) throws SQLException{
		JSONArray data=new JSONArray();
		try{
			Statement stmt=conn.createStatement();
			String strsql="select doc_no docno,authname refname from gl_vehauth where status=3";
			ResultSet rs=stmt.executeQuery(strsql);
			while(rs.next()){
				JSONObject objtemp=new JSONObject();
				objtemp.put("docno",rs.getString("docno"));
				objtemp.put("refname",rs.getString("refname"));
				data.add(objtemp);
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return data;
	}
	
	public JSONArray getVehBrandData(Connection conn) throws SQLException{
		JSONArray data=new JSONArray();
		try{
			Statement stmt=conn.createStatement();
			String strsql="select doc_no docno,brand_name refname from gl_vehbrand where status=3";
			ResultSet rs=stmt.executeQuery(strsql);
			while(rs.next()){
				JSONObject objtemp=new JSONObject();
				objtemp.put("docno",rs.getString("docno"));
				objtemp.put("refname",rs.getString("refname"));
				data.add(objtemp);
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return data;
	}
	
	public JSONArray getRepairTypeData(Connection conn) throws SQLException{
		JSONArray data=new JSONArray();
		try{
			Statement stmt=conn.createStatement();
			String strsql="select row_no docno,name refname from ws_gartype order by row_no";
			ResultSet rs=stmt.executeQuery(strsql);
			while(rs.next()){
				JSONObject objtemp=new JSONObject();
				objtemp.put("docno",rs.getString("docno"));
				objtemp.put("refname",rs.getString("refname"));
				data.add(objtemp);
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return data;
	}
	
	public JSONArray getInventoryData(Connection conn) throws SQLException{
		JSONArray data=new JSONArray();
		try{
			Statement stmt=conn.createStatement();
			String strsql="select sr_no docno,name refname from gl_inspection where status=3";
			ResultSet rs=stmt.executeQuery(strsql);
			while(rs.next()){
				JSONObject objtemp=new JSONObject();
				objtemp.put("docno",rs.getString("docno"));
				objtemp.put("refname",rs.getString("refname"));
				data.add(objtemp);
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return data;
	}
	
	public JSONArray getModelData(Connection conn,String brandid) throws SQLException{
		JSONArray data=new JSONArray();
		if(brandid.trim().equalsIgnoreCase("") || brandid.trim().equalsIgnoreCase("undefined")){
			return data;
		}
		try{
			Statement stmt=conn.createStatement();
			String strsql="select doc_no docno,vtype refname from gl_vehmodel where status=3 and brandid="+brandid;
			ResultSet rs=stmt.executeQuery(strsql);
			while(rs.next()){
				JSONObject objtemp=new JSONObject();
				objtemp.put("docno",rs.getString("docno"));
				objtemp.put("refname",rs.getString("refname"));
				data.add(objtemp);
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return data;
	}
	
	public JSONArray getRegNoData(Connection conn,String brhid) throws SQLException{
		JSONArray data=new JSONArray();
		try{
			Statement stmt=conn.createStatement();
			String sqltest="";
			/*if(!brhid.equalsIgnoreCase("") && !brhid.equalsIgnoreCase("undefined") && brhid!=null){
				sqltest+=" and gip.brhid="+brhid;
			}*/
			String strsql="select distinct gip.regno,gip.yom,gip.email,gip.username,gip.mobile,gip.pltid,brd.doc_no brandid,brd.brand_name brandname,model.vtype modelname,model.doc_no modelid,"+
			" gip.other chassisno,ac.refname,ac.cldocno,clr.doc_no colorid,clr.color colorname from ws_gateinpass tempgip left join (select max(doc_no) maxdocno,regno,pltid "+
			" from ws_gateinpass group by regno,pltid) maxgip on (tempgip.regno=maxgip.regno and tempgip.pltid=maxgip.pltid) inner join "+
			" ws_gateinpass gip on (gip.doc_no=maxgip.maxdocno) left join my_acbook ac on (ac.cldocno=gip.cldocno and ac.dtype='CRM' and "+
			" ac.status=3) left join gl_vehbrand brd on brd.doc_no=gip.brdid left join gl_vehmodel model on model.doc_no=gip.modid "+
			" left join my_color clr on clr.doc_no=gip.colorid where gip.status=3"+sqltest;
			System.out.println(strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			while(rs.next()){
				JSONObject objtemp=new JSONObject();
				objtemp.put("regno",rs.getString("regno"));
				objtemp.put("pltid",rs.getString("pltid"));
				objtemp.put("brandid",rs.getString("brandid"));
				objtemp.put("brandname",rs.getString("brandname"));
				objtemp.put("modelname",rs.getString("modelname"));
				objtemp.put("modelid",rs.getString("modelid"));
				objtemp.put("colorname",rs.getString("colorname"));
				objtemp.put("colorid",rs.getString("colorid"));
				objtemp.put("chassisno",rs.getString("chassisno"));
				objtemp.put("refname",rs.getString("refname"));
				objtemp.put("cldocno",rs.getString("cldocno"));
				objtemp.put("mobile",rs.getString("mobile"));
				objtemp.put("username",rs.getString("username"));
				objtemp.put("email",rs.getString("email"));
				objtemp.put("yom",rs.getString("yom"));
				
				data.add(objtemp);
			
			}
		//	System.out.println(data.toString());
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return data;
	}
	
	public JSONArray getBranchData(Connection conn,HttpSession session) throws SQLException{
		JSONArray data=new JSONArray();
		try{
			Statement stmt=conn.createStatement();
			//String strsql="select doc_no docno,branchname refname from my_brch where status=3";
			String strsql="select b.branchname refname,b.mclose,b.doc_no docno,(select code from my_curr where doc_no=b.curId) as curr,(select type from my_curr where doc_no=b.curId) as type,b.curId "
					 +" from my_brch b  left join my_user u on u.doc_no='"+session.getAttribute("USERID") +"'  left join my_usrbr ub on ub.user_id=u.doc_no and ub.brhid=b.doc_no and u.permission=1 "
					 +" where  b.cmpid='"+session.getAttribute("COMPANYID")+"'  and  if(u.permission=1,ub.user_id,'"+session.getAttribute("USERID")+"')='"+session.getAttribute("USERID")+"'  and  b.status<>7" ;
			ResultSet rs=stmt.executeQuery(strsql);
			while(rs.next()){
				JSONObject objtemp=new JSONObject();
				objtemp.put("docno",rs.getString("docno"));
				objtemp.put("refname",rs.getString("refname"));
				data.add(objtemp);
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return data;
	}
	
	public boolean userLogin(String username, String password,
			HttpSession session, HttpServletRequest request) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn=null;
		try{
			int userid=0;
			String loginusername="";
			conn=objconn.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmt=conn.createStatement();
			ClsEncrypt objencrypt=new ClsEncrypt();
			String str="select doc_no,user_id userid,user_name username from my_user where user_id='"+username+"' and pass='"+objencrypt.encrypt(password)+"' and status=3";
			ResultSet rs=stmt.executeQuery(str);
			while(rs.next()){
				userid=rs.getInt("doc_no");
				loginusername=rs.getString("username");
			}
			
			String ip = objlogin.getRemortIP(request);
			String mac = objlogin.getMACAddress(ip);
			
			Map<String, String> env = System.getenv();
		    String xuser=env.get("USERNAME");
		    String xcomp=env.get("COMPUTERNAME");
			
		    if(userid>0){
		    	session.setAttribute("BRANCHID","1");
		    	session.setAttribute("USERID",userid);
		    	session.setAttribute("COMPANYID","1");
		    	session.setAttribute("USERNAME",loginusername);
				String strlog = "insert into gc_workshopapplog (userid,username,WIN_USER,win_cmp,WIN_MAC,DATE_IN) values ("+userid+",'"+loginusername+"','"+xuser+"','"+xcomp+"','"+mac+"',now())";
				int loginsert=stmt.executeUpdate(strlog);
				if(loginsert<=0){
					//System.out.println("Log Insert Query:"+strlog);
					System.out.println("Log Insert Error");
					conn.close();
					return false;
				}
				else{
					conn.commit();
					return true;
				}
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
	
	public boolean confirmEstimation(int estdocno,String labaddition,String spareaddition,String insurtype,String userid,String brhid,Connection conn)throws SQLException{
		int errorstatus=0;
		try{
			Statement stmt = conn.createStatement();
			
			String sqllabour="update ws_estlabour set confirmed=1 where rdocno="+estdocno;
			String sqlspare="update ws_estspare set confirmed=1 where rdocno="+estdocno;
			
			int l=stmt.executeUpdate(sqllabour);
			int s=stmt.executeUpdate(sqlspare);
			
			
			String sqlconfirm = "insert into ws_estconfirm(estno, userid, brhid, date) values (?,?,?,date(now()))";
			PreparedStatement prestmt = conn.prepareStatement(sqlconfirm);
			prestmt.setInt(1, estdocno);
			prestmt.setInt(2, Integer.parseInt(userid));
			prestmt.setInt(3, Integer.parseInt(brhid));
			
			int c=prestmt.executeUpdate();
			Statement stmtgate=conn.createStatement();
			int g = stmtgate.executeUpdate("update ws_gateinpass gip inner join ws_estm est on  est.gipno=gip.doc_no set gip.processstatus=3 where est.doc_no="+estdocno);
			
			if((c<=0)||g<=0){
				errorstatus = 1;
			}
			
			if(labaddition.equalsIgnoreCase("0") && spareaddition.equalsIgnoreCase("0")){
				String sqlinsuretype1="update ws_estm set insurtype="+insurtype+" where doc_no="+estdocno;
				int instype1=stmt.executeUpdate(sqlinsuretype1);
				if(instype1<=0){
					errorstatus=1;
				}
			}
			
			else{
				int addition=0;
				if(Integer.parseInt(labaddition)>Integer.parseInt(spareaddition)){
					addition=Integer.parseInt(labaddition);
				}
				else{
					addition=Integer.parseInt(spareaddition);
				}
				String sqlinsuretype2="update ws_estmadd set insurtype="+insurtype+" where doc_no="+estdocno+" and addition="+addition;
				int instype2=stmt.executeUpdate(sqlinsuretype2);
				if(instype2<=0){
					errorstatus=1;
				}
			}
			if(errorstatus==0){
				 ResultSet resultSet = stmt.executeQuery("select max(rowno) from ws_estconfirm");
				 int logdocno=0;
				 while(resultSet.next()){
					 logdocno=resultSet.getInt(1);
				 }
				 PreparedStatement stmtlog=conn.prepareStatement("insert into gl_biblog(doc_no, brhId, dtype, edate, userId, userNo, activity, ENTRY) values (?,?,?,now(),?,?,?,?)");
				 stmtlog.setInt(1,logdocno);
				 stmtlog.setInt(2,Integer.parseInt(brhid));
				 stmtlog.setString(3,"BWEC");
				 stmtlog.setInt(4, Integer.parseInt(userid));
				 stmtlog.setInt(5, 0);
				 stmtlog.setInt(6, 0);
				 stmtlog.setString(7, "A");
				 int log=stmtlog.executeUpdate();
				 
				 if(log>0){
				 
				 }
				 else
				 {
				 	errorstatus=1;
				 }
		}
	}
	catch(Exception e){
		errorstatus=1;
		e.printStackTrace();
		conn.close();
	}
	
	if(errorstatus==0){
		return true;
	}
	else{
		return false;
	}
	}	
	
	public boolean QuotationApproval(int estDocno,String userid,String brhid,Connection conn)throws SQLException{
		int errorstatus=0;
		try{
			Statement stmt = conn.createStatement ();
			int tobe=1;
			String strSql = "select doc_no from ws_jobcard where reftype='est' and refno ="+estDocno;
			ResultSet rs=stmt.executeQuery(strSql);
			int jobno=0;
			while(rs.next()){
				jobno=rs.getInt("doc_no");
			}
			
			String strSql1 = "update ws_estlabour set approved=1 where rdocno="+estDocno+" and confirmed=1 and approved=0";
			String strSql2 = "update ws_estspare set approved=1 where rdocno="+estDocno+" and confirmed=1 and approved=0";
			String strSql3 = "insert into ws_estapprove(estno,excess,excessamt,desc1,userid,brhid,date,lpo,waveoffreason) values(?,?,?,?,?,?,date(now()),?,?)";
			String strSql4="";
			if(jobno==0){
				if(tobe==1){
					strSql4 = "update ws_gateinpass set excess=?,excessamt=?,userid=?,lpo=?,processstatus=4 where doc_no=?";
				}
				if(tobe==2){
					strSql4 = "update ws_gateinpass set excess=?,excessamt=?,userid=?,lpo=? where doc_no=?";
				}
			}
			else{
				if(tobe==1){
				 	strSql4 = "update ws_gateinpass set excess=?,excessamt=?,userid=?,lpo=?,processstatus=5 where doc_no=?";
				}
				if(tobe==2){
					strSql4 = "update ws_gateinpass set excess=?,excessamt=?,userid=?,lpo=? where doc_no=?";
				}
			}
			
			String strSql5 = "insert into gl_biblog(doc_no,brhid,dtype,edate,userid,userno,activity,ENTRY) values(?,?,?,now(),?,?,?,?)";
			
			
			int x = stmt.executeUpdate(strSql1);
			int y = stmt.executeUpdate(strSql2);
			
			PreparedStatement ps=conn.prepareStatement(strSql3);	
			ps.setInt(1, estDocno);
			ps.setString(2, "0");
			ps.setString(3, "0.0");
			ps.setString(4, "");
			ps.setInt(5, Integer.parseInt(userid));
			ps.setString(6, brhid);
			ps.setString(7, "");
			ps.setString(8, "");
			int z=ps.executeUpdate();
			
			/*PreparedStatement ps1=conn.prepareStatement(strSql4);
			ps1.setString(1, excess);
			ps1.setString(2, excessamt);
			ps1.setInt(3, userid);
			ps1.setString(4,pono);
			ps1.setString(5, gipno);
			p=ps1.executeUpdate();
			*/
			PreparedStatement ps2=conn.prepareStatement(strSql5);
			ps2.setInt(1, estDocno);
			ps2.setString(2, brhid);
			ps2.setString(3, "BWQA");
			ps2.setString(4, userid);
			ps2.setString(5, "0");
			ps2.setString(6, "0");
			ps2.setString(7, "A");
			
			int q=ps2.executeUpdate();
			

			if((z<=0)||(q<=0)){
				errorstatus=1;
			}
			ClsWSJobCardDAO jobcarddao=new ClsWSJobCardDAO();
			int floormgmtconfig=jobcarddao.getFloorMgmtConfig(conn);
			if(floormgmtconfig==1){
				String strupdatefloormgmt="update ws_floormgmtdata flr left join ws_jobcard job on flr.jobdocno=job.doc_no left join ws_estm es on "+
				" (job.reftype='EST' and job.refno=es.doc_no) left join (select sum(total) labourtotal,rdocno,sum(hrs) labourhrs from ws_estlabour "+
				" where confirmed=1 and approved=1 group by rdocno) labour on (es.doc_no=labour.rdocno) left join (select sum(approvedvalue) sparetotal,"+
				" rdocno from ws_estspare where confirmed=1 and approved=1 group by rdocno) spare on (es.doc_no=spare.rdocno) "+
				" set flr.esttotal=labour.labourtotal+spare.sparetotal where es.doc_no="+estDocno;
				int updatefloormgmt=stmt.executeUpdate(strupdatefloormgmt);
			
			}
		}
		catch(Exception e){
			e.printStackTrace();
			errorstatus=1;
		}
		if(errorstatus==0){
			return true;
		}
		else{
			return false;
		}
	}

	public ArrayList<String> getUploadPicsData(int doc) throws SQLException{
		// TODO Auto-generated method stub
		ArrayList<String> imgarray=new ArrayList<>();
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select doc.path from ws_gateinpass gip left join my_fileattach doc on (doc.dtype='GIP' and doc.doc_no=gip.doc_no)"+
			" where gip.doc_no="+doc+" and substring_index(doc.path,'GIP',-1)<>substring_index(gip.signature,'GIP',-1)";
			ResultSet rs=stmt.executeQuery(strsql);
			while(rs.next()){
				imgarray.add(rs.getString("path"));
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return imgarray;
	}

	public JSONObject getLoggedUserData(HttpSession session,
			HttpServletRequest request) throws SQLException {
		Connection conn=null;
		JSONObject objtemp=new JSONObject();
		int errorstatus=0;
		String username="",password="",mode="";
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String userid=session.getAttribute("USERID")==null?"":session.getAttribute("USERID").toString();
			if(!userid.equalsIgnoreCase("")){
				String struserdet="select user_id username,pass from my_user where doc_no="+userid;
				ResultSet rsuser=stmt.executeQuery(struserdet);
				
				while(rsuser.next()){
					username=rsuser.getString("username");
					ClsEncrypt secdao=new ClsEncrypt();
					password=secdao.decrypt(rsuser.getString("pass"));
					mode="A";
				}
			}
		}
		catch(Exception e){
			e.printStackTrace();
			errorstatus=1;
		}
		finally{
			conn.close();
		}
		objtemp.put("errorstatus",errorstatus);
		objtemp.put("username",username);
		objtemp.put("password",password);
		objtemp.put("mode",mode);
		
		// TODO Auto-generated method stub
		return objtemp;
	}
}
