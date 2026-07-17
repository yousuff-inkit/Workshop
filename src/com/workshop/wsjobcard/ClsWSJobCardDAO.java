package com.workshop.wsjobcard;

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
				" gl_yom yom on gate.yom=yom.doc_no where est.status=3 "+sqltest+" and gate.processstatus=4 and lab.confirmed=1 and lab.approved=1 and ((spare.confirmed is null) or (est.chklumsum=1)  or (spare.confirmed=1 "+
				" and spare.approved=1)) group by est.doc_no ";
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
			String strsql="select description, qty, genuinerate, marketrate, usedrate, genuinetotal, markettotal, usedtotal, approval, approvedvalue from ws_estspare where rdocno='"+docno+"'";
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
			HttpSession session, HttpServletRequest request, String mode,String formdetailcode,String brchName) throws SQLException {
		// TODO Auto-generated method stub
		int docno=0,vocno=0;
		Connection conn=null;
		try{
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
			CallableStatement stmtEst = conn.prepareCall("{call WSJobCardDML(?,?,?,?,?,?,?,?,?)}");
			stmtEst.registerOutParameter(8, java.sql.Types.INTEGER);
			stmtEst.registerOutParameter(9, java.sql.Types.INTEGER);
			stmtEst.setDate(1,sqldate);
			stmtEst.setString(2,hidrefno);
			stmtEst.setString(3,cmbreftype);
			stmtEst.setString(4,formdetailcode);
			stmtEst.setString(5,mode);
			stmtEst.setString(6,session.getAttribute("USERID").toString());
			stmtEst.setString(7,brchName);
			stmtEst.executeQuery();
			docno=stmtEst.getInt("docNo");
			vocno=stmtEst.getInt("vocNo");
			request.setAttribute("WSJOBCARDVOCNO", vocno);
			int errorstatus=0;
			if(docno<=0){
				errorstatus=1;
				return 0;
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
	
	public JSONArray getSearchData(String refno,String date,String docno,String reftype,String id,String cldocno,String accno,String giprefno) throws SQLException{
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
			if(!refno.equalsIgnoreCase("")){
				sqltest+=" and job.refno like '%"+refno+"%'";
			}
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
			if(!giprefno.equalsIgnoreCase("")){
				sqltest+=" and gate.refno like '%"+giprefno+"%'";
			}
			String strsql="select gate.refno giprefno,ac.refname,h.account,if(job.reftype='GIP',gate.voc_no,est.voc_no) refvocno,job.doc_no,job.voc_no,job.date,job.reftype,job.refno,gate.regno,ac.cldocno,concat(ac.refname,' , Address: ',ac.address,' ,"+
			" Telephone: ',ac.per_tel,' , Mobile: ',ac.per_mob,' , Mail: ',ac.mail1,' , Contact Person ',ac.contactperson) userdetails,"+
			" convert(concat(coalesce(brd.brand_name,''),' ',coalesce(model.vtype,''),' ',coalesce(yom.yom,''),' Others: ',"+
			" coalesce(gate.vehother,'')),char(200)) vehicledetails from ws_jobcard job  left join ws_estm est on (job.reftype='EST' and "+
			" job.refno=est.doc_no) left join ws_gateinpass gate on (if(job.reftype='GIP',job.refno=gate.doc_no,est.gipno=gate.doc_no)) left "+
			" join my_acbook ac on (gate.cldocno=ac.cldocno and ac.dtype='CRM') left join my_head h on ac.acno=h.doc_no left join gl_vehbrand brd on gate.brdid=brd.doc_no left join "+
			" gl_vehmodel model on gate.modid=model.doc_no left join gl_vehplate plate on gate.pltid=plate.doc_no left join gl_yom yom on "+
			" gate.yom=yom.doc_no where job.status=3"+sqltest;
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
			
			strsql="select ac.refname,if(job.reftype='GIP',gate.voc_no,est.voc_no) refvocno,job.doc_no,job.voc_no,job.date,job.reftype,job.refno,gate.regno,ac.cldocno,concat(ac.refname,' , Address: ',ac.address,' ,"+
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
				been.setDate(rs.getString("date"));
				been.setRegno(rs.getString("regno"));
				been.setRefno(rs.getString("refno"));
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
			String strsql="select gate.Refno,acc.refname billto,gate.regno,gate.pltid,br.tinno comptrn,coalesce(usr.user_name,'') sal_name,round(coalesce(gate.kmin,0),2) inkm,coalesce(gate.pltid) plate,br.branchname,comp.company,comp.address compaddress,comp.tel,comp.fax,est.doc_no estdocno,gate.doc_no gatedocno,coalesce(gate.other,'') other,job.reftype,case when job.reftype='GIP' then gate.voc_no when job.reftype='EST' then est.voc_no else '' end "+
			" refvocno,date_format(job.date,'%d.%m.%Y') date,job.voc_no,ac.cldocno,ac.refname,ac.address,ac.per_mob,ac.mail1,gate.regno,"+
			" plt.code_name,brd.brand_name,model.vtype,yom.yom from ws_jobcard job left join ws_estm est on (job.reftype='EST' and "+
			" job.refno=est.doc_no) left join ws_gateinpass gate on (if(job.reftype='GIP',job.refno=gate.doc_no,est.gipno=gate.doc_no)) left "+
			" join my_acbook ac on (gate.cldocno=ac.cldocno and ac.dtype='CRM') left  join my_acbook acc on (gate.insurcldocno=acc.cldocno and acc.dtype='CRM') left join my_salm sal on ac.sal_id=sal.doc_no left join gl_vehplate plt on gate.pltid=plt.doc_no left join "+
			" gl_vehbrand brd on gate.brdid=brd.doc_no left join gl_vehmodel model on gate.modid=model.doc_no left join gl_yom yom on"+
			" gate.yom=yom.doc_no left join my_brch br on job.brhid=br.doc_no left join my_comp comp on br.cmpid=comp.doc_no left join my_user usr on job.userid=usr.doc_no where job.doc_no="+doc+" and job.status=3";
			System.out.println("qryyy"+strsql);
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
				bean.setLblmodel(rs.getString("vtype"));
				bean.setLblyom(rs.getString("yom"));
				bean.setLblplatecode(rs.getString("plate"));
				bean.setLblserviceadvisor(rs.getString("sal_name"));
				bean.setLblbillto(rs.getString("billto"));
				bean.setLblrefno(rs.getString("Refno"));
			}
			ArrayList<String> complaintarray=new ArrayList<>();
			complaintarray=getComplaintPrint(conn,gatedocno,addition);
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
				String strsql="select coalesce(comp.compname,'') complaint,gate.desc1 description,comp.doc_no complaintid from ws_gateinpassd gate left join gl_complaint comp on gate.complaintid=comp.doc_no where gate.rdocno="+gatedocno;
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
				" job.refno=est.doc_no) where regno="+regno+" and pltid='"+plate+"' and job.doc_no is not null and job.doc_no<>"+jobdocno+" order by gate.doc_no DESC limit 3 ";
				System.out.println("last visited"+strsql);				
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
						" where m.status=3 and lab.rdocno="+estdocno+sqladdition;
				System.out.println("service grid"+strsql);				
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
				String strjobstatus="select coalesce(savestatus,0) savestatus from ws_jobcard where reftype='EST' and refno="+estdocno+" and status=3";
				ResultSet rsjobstatus=stmt.executeQuery(strjobstatus);
				int jobstatus=0;
				while(rsjobstatus.next()){
					jobstatus=rsjobstatus.getInt("savestatus");
				}
				String strsql="";
				if(jobstatus==0){
					strsql="select a.description,round(a.qty,1) qty from ( select round(spare.qty,0) qty,spare.rate,spare.markupper markuppercent,spare.total,spare.remarks,bd.brandname brand,bd.doc_no brdid,m.psrno partdocno,m.part_no partno,m.productname description,m.doc_no,u.unit,m.munit as unitdocno,m.psrno,sum(i.out_qty)"+
							" outqty,coalesce(sum(i.op_qty-(i.out_qty+i.del_qty+i.rsv_qty)),0) as stock,sum(i.op_qty) as totqty,i.stockid as stkid,i.cost_price unitprice"+
							" from ws_estspare spare left join my_main m on spare.psrno=m.psrno left join my_unitm u on m.munit=u.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd"+
							" on m.brandid=bd.doc_no left join my_prddin i on(i.psrno=m.psrno and i.prdid=m.doc_no and i.specno=at.mspecno)"+
							" where m.status=3 and spare.rdocno="+estdocno+" "+sqladdition+" and spare.psrno>0 group by i.prdid ) a union all "+
							"select spare.description,round(spare.qty,1) qty from ws_estspare spare where spare.rdocno="+estdocno+" "+sqladdition+" and coalesce(spare.psrno,0)=0";
				}
				else{
					strsql="select case when coalesce(jcc.description,'')='' then m.productname else jcc.description end description,round(jcc.qty,1) qty from ws_jccspare jcc left join my_main m on jcc.psrno=m.psrno where estdocno="+estdocno;
				}
				/*String strsql="select * from ( select round(spare.qty,0) qty,spare.rate,spare.markupper markuppercent,spare.total,spare.remarks,bd.brandname brand,bd.doc_no brdid,m.psrno partdocno,m.part_no partno,m.productname description,m.doc_no,u.unit,m.munit as unitdocno,m.psrno,sum(i.out_qty)"+
						" outqty,coalesce(sum(i.op_qty-(i.out_qty+i.del_qty+i.rsv_qty)),0) as stock,sum(i.op_qty) as totqty,i.stockid as stkid,i.cost_price unitprice"+
						" from ws_estspare spare left join my_main m on spare.psrno=m.psrno left join my_unitm u on m.munit=u.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd"+
						" on m.brandid=bd.doc_no left join my_prddin i on(i.psrno=m.psrno and i.prdid=m.doc_no and i.specno=at.mspecno)"+
						" where m.status=3 and  spare.rdocno="+estdocno+" "+sqladdition+" group by i.prdid  order by i.date) a";*/
				//String strsql="select round(spare.qty,0) qty,coalesce(spare.remarks,'') remarks, spare.description from ws_estspare spare where confirmed=1 and approved=1 and spare.rdocno="+estdocno+" "+sqladdition;
				System.out.println("Parts Print:"+strsql);				
				ResultSet rs=stmt.executeQuery(strsql);
				int i=1;
				while(rs.next()){
					data.add(i+"::"+rs.getString("description")+"::"+rs.getString("qty")+"::"+"");
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
}
