package com.workshop.wsjobcardpal;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.ibm.icu.impl.duration.impl.DataRecord.EGender;
import com.workshop.wsestimationnew.ClsWSEstimationNewBean;

import java.sql.*;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
public class ClsWSJobCardDAO {

	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	
	public JSONArray getRefData(String refgatevocno,String refestvocno,String clientname,String regno,String refdate,String branch,String reftype,String id) throws SQLException
	{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
			
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String sqltest="";
			java.sql.Date sqldate=null;
			if(!refgatevocno.equalsIgnoreCase("")){
				sqltest+=" and gate.voc_no like '%"+refgatevocno+"%'";
			}
			if(!refestvocno.equalsIgnoreCase("")){
				if(reftype.equalsIgnoreCase("EST")){
					sqltest+=" and est.voc_no like '%"+refestvocno+"%'";
				}
			}
			if(!regno.equalsIgnoreCase("")){
				sqltest+=" and gate.regno like '%"+regno+"%'";
			}
			if(!clientname.equalsIgnoreCase("")){
				sqltest+=" and ac.refname like '%"+clientname+"%'";
			}
			if(!regno.equalsIgnoreCase("")){
				sqltest+=" and gate.regno like '%"+regno+"%'";
			}
			if(!refdate.equalsIgnoreCase("")){
				sqldate=objcommon.changeStringtoSqlDate(refdate);
				if(reftype.equalsIgnoreCase("GIP")){
					sqltest+=" and gate.date='"+sqldate+"'";
				}
				else if(reftype.equalsIgnoreCase("EST")){
					sqltest+=" and est.date='"+sqldate+"'";
				}
			}
			if(!branch.equalsIgnoreCase("")){
				if(reftype.equalsIgnoreCase("GIP")){
					sqltest+=" and gate.brhid="+branch;
				}
				else if(reftype.equalsIgnoreCase("EST")){
					sqltest+=" and est.brhid="+branch;
				}
			}
			
			String strsql="";
			if(reftype.equalsIgnoreCase("GIP")){
				strsql="select ac.refname,gate.regno,gate.doc_no gatedocno,gate.brhid,gate.voc_no gatevocno,gate.date refdate,ac.cldocno,"+
				" concat(ac.refname,' , Address: ',ac.address,' , Telephone: ',ac.per_tel,' , Mobile: ',ac.per_mob,' , Mail: ',"+
				" ac.mail1,' , Contact Person ',ac.contactperson) userdetails,convert(concat(coalesce(brd.brand_name,''),' ',"+
				" coalesce(model.vtype,''),' Reg No: ',coalesce(gate.regno,''),' Plate Code: ',coalesce(gate.pltid,''),' YoM: ',"+
				" coalesce(yom.yom,''),' Others: ',coalesce(gate.vehother,'')),char(200)) vehicledetails "+
				" from ws_gateinpass gate left join my_acbook ac on (gate.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_vehbrand brd"+
				" on gate.brdid=brd.doc_no left join gl_vehmodel model on gate.modid=model.doc_no left join gl_vehplate plate on"+
				" gate.pltid=plate.doc_no left join gl_yom yom on gate.yom=yom.doc_no where 1=1"+sqltest;
			}
			else if(reftype.equalsIgnoreCase("EST")){
				strsql="select ac.refname,gate.regno,gate.voc_no gatevocno,gate.doc_no gatedocno,est.doc_no estdocno,est.brhid,est.voc_no estvocno,est.date refdate,ac.cldocno,"+
				" concat(ac.refname,' , Address: ',ac.address,' , Telephone: ',ac.per_tel,' , Mobile: ',ac.per_mob,' , Mail: ',"+
				" ac.mail1,' , Contact Person ',ac.contactperson) userdetails,convert(concat(coalesce(brd.brand_name,''),' ',"+
				" coalesce(model.vtype,''),' Reg No: ',coalesce(gate.regno,''),' Plate Code: ',coalesce(gate.pltid,''),' YoM: ',"+
				" coalesce(yom.yom,''),' Others: ',coalesce(gate.vehother,'')),char(200)) vehicledetails "+
				" from ws_estm est left join ws_gateinpass gate on est.gipno=gate.doc_no left join ws_estspare spare on "+
				" est.doc_no=spare.rdocno left join ws_estlabour lab on est.doc_no=lab.rdocno left join my_acbook ac on "+
				" (gate.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_vehbrand brd on gate.brdid=brd.doc_no left join "+
				" gl_vehmodel model on gate.modid=model.doc_no left join gl_vehplate plate on gate.pltid=plate.doc_no left join "+
				" gl_yom yom on gate.yom=yom.doc_no where est.status=3 "+sqltest+" and gate.processstatus=4 "+
				" and est.approved=1 group by est.doc_no";
				/*and lab.confirmed=1 and lab.approved=1 and (est.chklumsum=1 or (spare.confirmed=1 "+
				" and spare.approved=1)) group by est.doc_no ";*/
			}
			System.out.println("==== "+strsql);
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
			String strsql="select description, qty, genuinerate, marketrate, usedrate, genuinetotal, markettotal, usedtotal, approval, approvedvalue from ws_estspare where  confirmed=1 and approved=1 and rdocno="+docno;
			System.out.println(strsql);
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
	public int insert(String cmbreftype, String hidrefno, Date sqldate,
			HttpSession session, HttpServletRequest request,Date promdate, String promtime, String mode,
			String formdetailcode,String brchName,String jobdesc) throws SQLException {
		// TODO Auto-generated method stub
		int docno=0,vocno=0;
		Connection conn=null;
		try{
			
			jobdesc=jobdesc==null || jobdesc.trim().equalsIgnoreCase("undefined") || jobdesc.trim().equalsIgnoreCase("")?"":jobdesc.trim();
			conn=objconn.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmt=conn.createStatement();
			String strsql="select count(*) itemcount from ws_jobcard where reftype='"+cmbreftype+"' and refno="+hidrefno;
			int itemcount=0;
			ResultSet rscount=stmt.executeQuery(strsql);
			while(rscount.next()){
				itemcount=rscount.getInt("itemcount");
			}
			if(itemcount>0){
				System.out.println("Reference Already Present");
				return 0;
			}
			CallableStatement stmtEst = conn.prepareCall("{call WSJobCardFancyDML(?,?,?,?,?,?,?,?,?,?,?)}");
			stmtEst.registerOutParameter(8, java.sql.Types.INTEGER);
			stmtEst.registerOutParameter(9, java.sql.Types.INTEGER);
			stmtEst.setDate(1,sqldate);
			stmtEst.setString(2,hidrefno);
			stmtEst.setString(3,cmbreftype);
			stmtEst.setString(4,formdetailcode);
			stmtEst.setString(5,mode);
			stmtEst.setString(6,session.getAttribute("USERID").toString());
			stmtEst.setString(7,brchName);
			stmtEst.setDate(10,promdate);
			stmtEst.setString(11,promtime);
			stmtEst.executeQuery();
			System.out.println("Data-->"+stmtEst);
			docno=stmtEst.getInt("docNo");
			vocno=stmtEst.getInt("vocNo");
			request.setAttribute("WSJOBCARDVOCNO", vocno);
			int errorstatus=0;
			if(docno<=0){
				errorstatus=1;
				return 0;
			}
			if(docno>0){
				int updatejobcard=conn.createStatement().executeUpdate("update ws_jobcard set jobdesc='"+jobdesc+"' where doc_no="+docno);
				if(updatejobcard<0){
					errorstatus=1;
					return 0;
				}
			}
			
			int floormgmtconfig=getFloorMgmtConfig(conn);
			if(floormgmtconfig==1){
				int insertfloormgmt=insertFloorMgmtData(docno,vocno,conn);
				if(insertfloormgmt<=0){
					System.out.println("Floor Mgmt Insert Error");
					errorstatus=1;
				}
			}
			if(errorstatus==0){
				conn.commit();
				return docno;
			}
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		return 0;
	}
	
	public int getFloorMgmtConfig(Connection conn) {
		// TODO Auto-generated method stub
		int method=0;
		try{
			Statement stmt=conn.createStatement();
			String strconfig="select method from gl_config where field_nme='floorMgmt'";
			ResultSet rsconfig=stmt.executeQuery(strconfig);
			while(rsconfig.next()){
				method=rsconfig.getInt("method");
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return method;
	}
	public int insertFloorMgmtData(int docno, int vocno, Connection conn) {
		// TODO Auto-generated method stub
		int insertvalue=0;
		try{
			Statement stmt=conn.createStatement();
			String strsql="insert into ws_floormgmtdata(brhid,jobdocno, jobvocno,jobdate, vehicledetails, billto, client, service, age, priority, promiseddate, "+
			" esthrs, actualhrs, hrsdiff, grpname,estimator, srvcadvisor, salesman, insursurvivor, referredby,regno,partsstatus,esttotal)"+
			" select jc.brhid,jc.doc_no jobdocno,jc.voc_no jobvocno,jc.date, convert(concat(coalesce(gp.regno,''),' ',coalesce(gp.pltid,''),' ',"+
			" coalesce(brd.brand_name,''),' ',coalesce(model.vtype,''),' ',coalesce(clr.color,''),' ',coalesce(yom.yom,''),' ',coalesce(gp.vehother,'')),char(500)) "+
			" vehicledetails,coalesce(billto.refname,'') billto,ac.refname,repairtype.name"+
			" service,datediff(curdate(),jc.date) age,if(gp.priority=1,'Normal','High') priority,jc.promdate promiseddate,labour.labourhrs esthrs,"+
			" sum((TIMESTAMPDIFF(minute,cast(concat(clk.startdate,' ',clk.starttime)as datetime),cast(concat(clk.closedate,' ',clk.closetime)as"+
			" datetime))/60)) actualhrs,sum((TIMESTAMPDIFF(minute,cast(concat(clk.startdate,' ',clk.starttime)as datetime),"+
			" cast(concat(clk.closedate,' ',clk.closetime)as datetime))/60))-labour.labourhrs hrsdiff,gname grpname,"+
			" coalesce(wmp.sal_name,'') marketingperson,coalesce(wsa.sal_name,'') serviceadvisor,coalesce(sal.sal_name,'') salesman,"+
			" coalesce(wis.sal_name,'') insursurvivor,coalesce(wrb.sal_name,'') referredby,coalesce(gp.regno,'0'),'Not Available',coalesce(labour.labourtotal,0.0)+coalesce(spare.sparetotal,0.0) esttotal"+
			" from ws_jobcard jc"+
			" left join ws_estm es on (jc.refno=es.doc_no and jc.reftype='EST')"+
			" left join (select sum(total) labourtotal,rdocno,sum(hrs) labourhrs from ws_estlabour where confirmed=1 and approved=1 group by rdocno) labour on (es.doc_no=labour.rdocno)"+
			" left join (select sum(approvedvalue) sparetotal,rdocno from ws_estspare where confirmed=1 and approved=1 group by rdocno) spare on (es.doc_no=spare.rdocno)"+
			" left join ws_clockin clk on jc.doc_no=clk.jcno"+
			" left join ws_gateinpass gp on((jc.refno=gp.doc_no and jc.reftype='GIP') or (es.gipno=gp.doc_no and jc.reftype='EST'))"+
			" left join my_acbook ac on (gp.cldocno=ac.cldocno and ac.dtype='CRM')"+
			" left join my_acbook billto on (gp.insurcldocno=billto.cldocno and billto.dtype='CRM')"+
			" left join my_clcatm cat on (billto.catid=cat.doc_no and cat.status=3 and cat.insurance=1)"+
			/*" left join gl_vehplate plate on gp.pltid=plate.doc_no "+*/
			" left join gl_vehbrand brd on(gp.brdid=brd.doc_no)"+
			" left join gl_vehmodel model on gp.modid=model.doc_no"+
			" left join gl_vehgroup grp on model.groupid=grp.doc_no"+
			" left join gl_yom yom on gp.yom=yom.doc_no"+
			" left join my_color clr on gp.colorid=clr.doc_no"+
			" left join ws_gartype repairtype on gp.repairtype=repairtype.row_no"+
			" left join my_salesman wmp on (gp.marketingperson=wmp.doc_no and wmp.sal_type='WMP')"+
			" left join my_salesman wsa on (gp.serviceadvisor=wsa.doc_no and wsa.sal_type='WSA')"+
			" left join my_salesman wis on (gp.insurancesurvivor=wis.doc_no and wis.sal_type='WIS')"+
			" left join my_salesman wrb on (gp.referencedby=wrb.doc_no and wrb.sal_type='WRB')"+
			" left join ws_servicepackage wsp on (gp.servicepackage=wsp.doc_no)"+
			" left join ws_teammasterm wtm on (gp.teammaster=wtm.doc_no)"+
			" left join my_salm sal on (ac.sal_id=sal.doc_no) where jc.doc_no="+docno+" group by jc.doc_no";
			System.out.println(strsql);
			insertvalue=stmt.executeUpdate(strsql);
		//	insertvalue=1;
		}
		catch(Exception e){
			e.printStackTrace();
			insertvalue=0;
		}
		return insertvalue;
	}
	
	public JSONArray getSearchData(String refno,String date,String docno,String reftype,String id,String cldocno,String accno,String reg,String brhid) throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String sqltest="";
			java.sql.Date sqldate=null;
			
			if(!date.equalsIgnoreCase("")){
				sqldate=objcommon.changeStringtoSqlDate(date);
				sqltest+=" and job.date='"+sqldate+"'";
			}
			if(!docno.equalsIgnoreCase("")){
				sqltest+=" and job.voc_no like '%"+docno+"%'";
			}
			if(!accno.equalsIgnoreCase("")){
				sqltest+=" and h.account like '%"+accno+"%'";
			}
			if(!cldocno.equalsIgnoreCase("")){
				sqltest+=" and ac.cldocno like '%"+cldocno+"%'";
			}
			if(!reftype.equalsIgnoreCase("")){
				sqltest+=" and job.reftype='"+reftype+"'";
			}
			if(!reg.equalsIgnoreCase("")){
				sqltest+=" and gate.regno like '%"+reg+"%'";
			}
			if(!brhid.equalsIgnoreCase("")){
				sqltest+=" and job.brhid="+brhid;
			}
			if(!refno.equalsIgnoreCase("")){
				sqltest+=" and if(job.reftype='GIP',gate.voc_no,est.voc_no) like '%"+refno+"%'";
			}
			String strsql="select coalesce(job.jobdesc,'') jobdesc,gate.doc_no gipdocno,est.doc_no estdocno,ac.refname,h.account,if(job.reftype='GIP',gate.voc_no,est.voc_no) refvocno,job.promdate,job.promtime,job.doc_no,job.voc_no,job.date,job.reftype,job.refno,gate.regno,ac.cldocno,concat(coalesce(ac.refname,''),' , Address: ',coalesce(ac.address,''),' ,"+
			" Telephone: ',coalesce(ac.per_tel,''),' , Mobile: ',coalesce(ac.per_mob,''),' , Mail: ',coalesce(ac.mail1,''),' , Contact Person ',coalesce(ac.contactperson,'')) userdetails,"+
			" convert(concat(coalesce(brd.brand_name,''),' ',coalesce(model.vtype,''),' ',coalesce(yom.yom,''),' Others: ',"+
			" coalesce(gate.vehother,'')),char(200)) vehicledetails from ws_jobcard job  left join ws_estm est on (job.reftype='EST' and "+
			" job.refno=est.doc_no) left join ws_gateinpass gate on (if(job.reftype='GIP',job.refno=gate.doc_no,est.gipno=gate.doc_no)) left "+
			" join my_acbook ac on (gate.cldocno=ac.cldocno and ac.dtype='CRM') left join my_head h on ac.acno=h.doc_no left join gl_vehbrand brd on gate.brdid=brd.doc_no left join "+
			" gl_vehmodel model on gate.modid=model.doc_no left join gl_vehplate plate on gate.pltid=plate.doc_no left join gl_yom yom on "+
			" gate.yom=yom.doc_no where job.status=3"+sqltest;
			System.out.println("strsql--->>>"+strsql);    
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
	public ClsWSJobCardBean viewdetails(int docno) throws SQLException
	{
		ClsWSJobCardBean been=new ClsWSJobCardBean();
		Connection conn=null;
		
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			
			String strsql="";
			String sqltest="";
			System.out.println("12322323332");
			
			
			strsql="select job.jobdesc,ac.refname,if(job.reftype='GIP',gate.voc_no,est.voc_no) refvocno,job.doc_no,job.voc_no,job.date,job.reftype,job.refno,job.promdate,job.promtime,gate.regno,ac.cldocno,concat(ac.refname,' , Address: ',ac.address,' ,"+
			" Telephone: ',ac.per_tel,' , Mobile: ',ac.per_mob,' , Mail: ',ac.mail1,' , Contact Person ',ac.contactperson) userdetails,"+
			" convert(concat(coalesce(brd.brand_name,''),' ',coalesce(model.vtype,''),' ',coalesce(yom.yom,''),' Others: ',"+
			" coalesce(gate.vehother,'')),char(200)) vehicledetails from ws_jobcard job  left join ws_estm est on (job.reftype='EST' and "+
			" job.refno=est.doc_no) left join ws_gateinpass gate on (if(job.reftype='GIP',job.refno=gate.doc_no,est.gipno=gate.doc_no)) left "+
			" join my_acbook ac on (gate.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_vehbrand brd on gate.brdid=brd.doc_no left join "+
			" gl_vehmodel model on gate.modid=model.doc_no left join gl_vehplate plate on gate.pltid=plate.doc_no left join gl_yom yom on "+
			" gate.yom=yom.doc_no where job.status=3 and job.doc_no="+docno;
			ResultSet rs=stmt.executeQuery(strsql);
			System.out.println(strsql);
			while(rs.next()) {
				been.setJobdesc(rs.getString("jobdesc"));
				been.setDate(rs.getString("date"));
				been.setRegno(rs.getString("regno"));
				been.setRefno(rs.getString("refno"));
				been.setPromdate(rs.getString("promdate"));
				been.setPromtime(rs.getString("promtime"));
				been.setCmbreftype(rs.getString("reftype"));
				been.setVehicledetails(rs.getString("vehicledetails"));
				been.setUserdetails(rs.getString("userdetails"));
				been.setCldocno(rs.getString("cldocno"));
		  		} 
			
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		return been;
	}
	
	
	
	public ClsWSJobCardBean printDetails(String doc, HttpServletRequest request,String addition) throws SQLException {
		// TODO Auto-generated method stub
		ClsWSJobCardBean bean=new ClsWSJobCardBean();
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select gate.regno,gate.pltid,br.tinno comptrn,coalesce(usr.user_name,'') sal_name,coalesce(mc.color,'') color,round(coalesce(gate.kmin,0),2) inkm,coalesce(gate.pltid) plate,br.branchname,comp.company,br.doc_no brhid,br.address,comp.address compaddress,br.tel,comp.fax,est.doc_no estdocno,gate.doc_no gatedocno,coalesce(gate.other,'') other,job.reftype,case when job.reftype='GIP' then gate.voc_no when job.reftype='EST' then est.voc_no else '' end "+
			" refvocno,date_format(job.date,'%d.%m.%Y') date,date_format(job.promdate,'%d.%m.%Y') promdate,job.voc_no,date_format(gate.date,'%d.%m.%Y') gipdate, gate.VOC_NO lblgipno, ac.cldocno,ac.refname,ac.address,ac.per_mob,ac.mail1,gate.regno,"+
			" plt.code_name,brd.brand_name,model.vtype,yom.yom from ws_jobcard job left join ws_estm est on (job.reftype='EST' and "+
			" job.refno=est.doc_no) left join ws_gateinpass gate on (if(job.reftype='GIP',job.refno=gate.doc_no,est.gipno=gate.doc_no)) left "+
			" join my_acbook ac on (gate.cldocno=ac.cldocno and ac.dtype='CRM') left join my_salm sal on ac.sal_id=sal.doc_no left join gl_vehplate plt on gate.pltid=plt.doc_no left join "+
			" gl_vehbrand brd on gate.brdid=brd.doc_no left join gl_vehmodel model on gate.modid=model.doc_no left join my_color mc on gate.colorid=mc.doc_no"+
            " left join gl_yom yom on"+
			" gate.yom=yom.doc_no left join my_brch br on job.brhid=br.doc_no left join my_comp comp on br.cmpid=comp.doc_no left join my_user usr on job.userid=usr.doc_no where job.doc_no="+doc+" and job.status=3";
			System.out.println(strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			int gatedocno=0,estdocno=0;
			int regno=0;
			String plate="";
			while(rs.next()){
				regno=rs.getInt("regno");
				plate=rs.getString("pltid");
				gatedocno=rs.getInt("gatedocno");
				estdocno=rs.getInt("estdocno");
				bean.setLblcomptrn(rs.getString("comptrn"));
				bean.setLblmileage(rs.getString("inkm"));
				bean.setLblbranch(rs.getString("branchname"));
				bean.setLblcompname(rs.getString("company"));
				if(rs.getString("company").equalsIgnoreCase("PAL AUTO GARAGE")&& rs.getInt("brhid")!=3){
		    		   bean.setLblcompname(rs.getString("company")+" (Br.)");
		    	   }
				bean.setLblcompaddress(rs.getString("compaddress"));
				bean.setLblcomptel(rs.getString("tel"));
				bean.setLblcompfax(rs.getString("fax"));
				bean.setLblprintname("Job Card");
				bean.setLblchassis(rs.getString("other"));
				bean.setLblreftype(rs.getString("reftype"));
				bean.setLblrefvocno(rs.getString("refvocno"));
				bean.setLbldate(rs.getString("date"));
				bean.setLblvocno(rs.getString("voc_no"));
				bean.setLblcldocno(rs.getString("cldocno"));
				bean.setLblclientname(rs.getString("refname"));
				bean.setLblclientaddress(rs.getString("address"));
				bean.setLblclientmobile(rs.getString("per_mob"));
				bean.setLblclientemail(rs.getString("mail1"));
				bean.setLblregno(rs.getString("regno"));
				bean.setLblplatecode(rs.getString("code_name"));
				bean.setLblbrand(rs.getString("brand_name"));
				bean.setGipdate(rs.getString("gipdate"));
				bean.setLblgipno(rs.getString("lblgipno"));
				bean.setLblcolor(rs.getString("color"));
				bean.setPromdate(rs.getString("promdate"));
				bean.setLblmodel(rs.getString("vtype"));
				bean.setLblyom(rs.getString("yom"));
				bean.setLblplatecode(rs.getString("plate"));
				bean.setLblserviceadvisor(rs.getString("sal_name"));
			}
			ArrayList<String> complaintarray=new ArrayList<>();
			complaintarray=getComplaintPrint(conn,gatedocno,addition);
			System.out.println("EST Doc No--- "+estdocno+" Addition -- "+addition);
			ArrayList<String> servicearray=new ArrayList<>();
			servicearray=getServicesPrint(conn,estdocno,addition);
			ArrayList<String> partsarray=new ArrayList<>();
			partsarray=getPartsPrint(conn,estdocno,addition);
			ArrayList<String> visitedarray=new ArrayList<>();
			visitedarray=getVistedHistoryPrint(conn,regno,plate,doc);
			request.setAttribute("COMPLAINTPRINT", complaintarray);
			request.setAttribute("SERVICEPRINT", servicearray);
			request.setAttribute("PARTPRINT", partsarray);
			request.setAttribute("VISITPRINT", visitedarray);

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		return bean;
	}

	private ArrayList<String> getComplaintPrint(Connection conn, int gatedocno,String addition) throws SQLException{
		// TODO Auto-generated method stub
		ArrayList<String> data=new ArrayList<>();	
		try{
				
				Statement stmt=conn.createStatement();
				String strsql="select coalesce(comp.compname,'') complaint,coalesce(gate.desc1,'') description,comp.doc_no complaintid from ws_gateinpassd gate left join gl_complaint comp on gate.complaintid=comp.doc_no where gate.rdocno="+gatedocno;
				System.out.println(strsql);				
				ResultSet rs=stmt.executeQuery(strsql);
				int i=1;
				while(rs.next()){
					data.add(i+"::"+rs.getString("complaint")+"::"+rs.getString("description"));
					i++;
				}
			}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
			finally{
			}
		return data;

	}
	
	private ArrayList<String> getVistedHistoryPrint(Connection conn, int regno,
			String plate,String jobdocno) throws SQLException {
		// TODO Auto-generated method stub
		ArrayList<String> data=new ArrayList<>();	
		try{
				
				Statement stmt=conn.createStatement();
				String strsql="select job.voc_no,concat('GIP No ',gate.voc_no,' Dated on ',date_format(gate.date,'%d.%m.%Y'),' with Km ',coalesce(gate.kmin,'0')) description from "+
				" ws_gateinpass gate left join ws_estm est on gate.doc_no=est.gipno left join ws_jobcard job on (job.reftype='EST' and "+
				" job.refno=est.doc_no) where regno="+regno+" and pltid='"+plate+"' and job.doc_no is not null and job.doc_no<>"+jobdocno+" order by gate.doc_no";
				System.out.println(strsql);				
				ResultSet rs=stmt.executeQuery(strsql);
				int i=1;
				while(rs.next()){
					data.add(i+"::"+rs.getString("voc_no")+"::"+rs.getString("description"));
					i++;
				}
			}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
			finally{
			}
		return data;
	}
	private ArrayList<String> getServicesPrint(Connection conn, int estdocno,String addition) throws SQLException {
		// TODO Auto-generated method stub
		ArrayList<String> data=new ArrayList<>();	
		try{
				
				Statement stmt=conn.createStatement();
				
				String sqladdition="";
				if(!addition.equalsIgnoreCase("All")){
					sqladdition=" and lab.addition="+addition;
				}
				String strsql="select m.desc1 jobdesc,t.type jobtype,lab.remarks,"+
						" m.jobid from ws_estlabour lab left join ws_jobmaster m on (lab.jobid=m.doc_no ) left join ws_jobtype t on m.jobid=t.doc_no "+
						" where  lab.confirmed=1 and lab.approved=1 and m.status=3 and lab.rdocno="+estdocno+sqladdition;
				System.out.println(strsql);				
				ResultSet rs=stmt.executeQuery(strsql);
				int i=1;
				while(rs.next()){
					data.add(i+"::"+rs.getString("jobtype")+"::"+rs.getString("jobdesc")+"::"+rs.getString("remarks"));
					i++;
				}
			}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
			finally{
			}
		return data;

	}
	
	private ArrayList<String> getPartsPrint(Connection conn, int estdocno,String addition) throws SQLException{
		// TODO Auto-generated method stub
		ArrayList<String> data=new ArrayList<>();	
		try{
				
				Statement stmt=conn.createStatement();
				String sqladdition="";
				if(!addition.equalsIgnoreCase("All")){
					sqladdition=" and spare.addition="+addition;
				}
				String strsql="select round(spare.qty,0) qty,coalesce(spare.remarks,'') remarks, spare.description from ws_estspare spare where confirmed=1 and approved=1 and spare.rdocno="+estdocno+" "+sqladdition;
				System.out.println(strsql);				
				ResultSet rs=stmt.executeQuery(strsql);
				int i=1;
				while(rs.next()){
					data.add(i+"::"+rs.getString("description")+"::"+rs.getString("qty")+"::"+rs.getString("remarks"));
					i++;
				}
			}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
			finally{
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
			String strsql="select lab.strjobdesc jobdesc,m.doc_no,m.date,lab.hrs,lab.rate,lab.strjobtype jobtype,lab.markupper markuppercent,lab.total,lab.remarks,"+
			" lab.jobid from ws_estlabour lab left join ws_jobmaster m on (m.status=3 and lab.jobid=m.doc_no ) left join ws_jobtype t on m.jobid=t.doc_no "+
			" where  lab.confirmed=1 and lab.approved=1   and lab.rdocno="+docno;
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
}
