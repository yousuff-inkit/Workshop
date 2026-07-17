package com.workshop.estimationadditionpal;

import java.sql.CallableStatement;
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

public class ClsEstimationAdditionPalDAO {
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	public JSONArray getSparepartsAmountData(String gatedocno,String id,String addition) throws SQLException
	{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select description,taxpercent vatpercent,genuine genuinetotal,market markettotal,used usedtotal,approved approvedtotal from ws_estspareamt where status=3 and addition="+addition+" and gatedocno="+gatedocno;
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
	public JSONArray getLabourSearchData(String jobdocno,String jobtype,String date,String id,String gatedocno) throws SQLException{
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
				sqltest+=" and t.type like '%"+jobtype+"%'";
			}
			if(!date.equalsIgnoreCase("")){
				sqldate=objcommon.changeStringtoSqlDate(date);
				sqltest+=" and m.date='"+sqldate+"'";
			}
			int movno=0,luxury=0,jobcostconfig=0;
			String strgate="select (select method from gl_config where field_nme='wsJobTypeCost') jobcostconfig,coalesce(movno,0) movno,coalesce(luxury,0) luxury from ws_gateinpass where doc_no="+gatedocno;
			ResultSet rsgate=stmt.executeQuery(strgate);
			while(rsgate.next()){
				movno=rsgate.getInt("movno");
				luxury=rsgate.getInt("luxury");
				jobcostconfig=rsgate.getInt("jobcostconfig");
			}
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
				strsql="select m.desc1 jobdesc,m.doc_no,m.date,m.stdrate hrs,"+jobrate+" rate,t.type jobtype,m.jobid from ws_jobmaster m left join ws_jobtype t on m.jobid=t.doc_no where m.status=3"+sqltest;
			}
			else{
				strsql="select m.desc1 jobdesc,m.doc_no,m.date,m.stdrate hrs,m.stdcostperhr rate,t.type jobtype,m.jobid from ws_jobmaster m left join ws_jobtype t on m.jobid=t.doc_no where m.status=3"+sqltest;
			}
			
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
	public JSONArray getSparepartsData(String docno,String id,String addition) throws SQLException
	{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select description, qty,rate sprate, genuinerate, marketrate, usedrate, genuinetotal, markettotal, usedtotal, approval, approvedvalue from ws_estspare where rdocno="+docno+" and addition="+addition+" order by srno";
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
	
	
	public JSONArray getGateInPassData(String gatedocno,String cldocno,String clientname,
			String jobcarddocno,String date,String id,String brhid) throws SQLException{
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
			if(!gatedocno.equalsIgnoreCase("")){
				sqltest+=" and gate.voc_no like '%"+gatedocno+"%'";
			}
			if(!cldocno.equalsIgnoreCase("")){
				sqltest+=" and gate.cldocno like '%"+cldocno+"%'";
			}
			if(!clientname.equalsIgnoreCase("")){
				sqltest+=" and ac.refname like '%"+clientname+"%'";
			}
			if(!jobcarddocno.equalsIgnoreCase("")){
				sqltest+=" and job.voc_no like '%"+jobcarddocno+"%'";
			}
			if(!date.equalsIgnoreCase("")){
				sqldate=objcommon.changeStringtoSqlDate(date);
				sqltest+=" and job.date='"+sqldate+"'";
			}
			if(!brhid.equalsIgnoreCase("")){
				sqltest+=" and job.brhid="+brhid;
			}
			strsql="select  coalesce(gate.serviceadvisor,0) serviceadvisor,coalesce(insur.refname,'') gipinsurcomp,coalesce(gate.claim,'') gipclaimno,date_format(dat.edate,'%d.%m.%Y %H:%i') gipdatetime,coalesce(max(addd.addition),0) addition,job.doc_no,job.voc_no,est.doc_no estdocno,convert(concat(coalesce(brd.brand_name,''),' ',"+
				" coalesce(model.vtype,''),' Reg No: ',coalesce(gate.regno,''),' Plate Code: ',coalesce(gate.pltid,''),' YoM: ',"+
				" coalesce(yom.yom,''),' Others: ',coalesce(gate.vehother,'')),char(200)) vehicledetails "+
				" ,gate.doc_no gatedocno,gate.voc_no gatevocno,"+
			" job.date,gate.cldocno,gate.regno,ac.refname,concat(ac.refname,' , Address: ',ac.address,' , Telephone: ',ac.per_tel,' , Mobile: ',"+
			" ac.per_mob,' , Mail: ',ac.mail1,' , Contact Person ',ac.contactperson) userdetails from ws_jobcard job left join ws_estm est on (job.reftype='EST' and job.refno=est.doc_no)  left join ws_estlabour lab on (est.doc_no=lab.rdocno) left join ws_gateinpass gate on (est.gipno=gate.doc_no) left join my_acbook "+
			" ac on (gate.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_vehplate plate on gate.pltid=plate.doc_no left join gl_vehbrand "+
			" brd on gate.brdid=brd.doc_no left join gl_vehmodel model on gate.modid=model.doc_no left join gl_yom yom on "+
			" gate.yom=yom.doc_no left join my_acbook insur on (gate.insurcldocno=insur.cldocno and insur.dtype='CRM') inner join datalog dat on (dat.brhid=gate.brhid and dat.doc_no=gate.doc_no and dat.dtype='GIP' and dat.entry='A') left join ws_estmadd addd on est.doc_no=addd.doc_no where job.status=3 and job.complete=0 "+sqltest+" group by job.doc_no";
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
	public int insert(String gatedocno, String sparepartstotal,
			String labourtotal, String discount, String esttotal, Date sqldate,
			ArrayList<String> sparepartsarray,
			ArrayList<String> labourcostarray, HttpSession session,
			HttpServletRequest request, String mode, String formdetailcode,
			String brchName, String servicesdiscount, String servicestotal, String netservices, 
			String hidchklumsum, String lumsumamount, String jobcarddocno, String estdocno,
			String hidchkservicelumsum,String servicelumsumamt,String hidchkrandomlumsum,
			String randomlumsumamt,String header,String notes,String internalremarks,
			String gipclaimno,String gipdatetime,String estimatedays,String cmbserviceadvisor,
			String sparetotal, String sparediscount, String netspare) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn=null;
		int docno=0,vocno=0,addition=0;
		try{
			System.out.println(jobcarddocno+"/////"+estdocno);
			
			sparetotal=sparetotal==null || sparetotal.trim().equalsIgnoreCase("undefined") || sparetotal.trim().equalsIgnoreCase("")?"0":sparetotal.trim();
			sparediscount=sparediscount==null || sparediscount.trim().equalsIgnoreCase("undefined") || sparediscount.trim().equalsIgnoreCase("")?"0":sparediscount.trim();
			netspare=netspare==null || netspare.trim().equalsIgnoreCase("undefined") || netspare.trim().equalsIgnoreCase("")?"0":netspare.trim();
			
			conn=objconn.getMyConnection();
			conn.setAutoCommit(false);
			CallableStatement stmtEst = conn.prepareCall("{call WSEstimationAdditionDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmtEst.registerOutParameter(12, java.sql.Types.INTEGER);
			stmtEst.registerOutParameter(11, java.sql.Types.INTEGER);
			stmtEst.registerOutParameter(20, java.sql.Types.INTEGER);
			stmtEst.setDate(1,sqldate);
			stmtEst.setString(2,gatedocno);
			stmtEst.setString(3,"0");
			stmtEst.setString(4, "0");
			stmtEst.setString(5,"0");
			stmtEst.setString(6,"0");
			stmtEst.setString(7,formdetailcode);
			stmtEst.setString(8,mode);
			stmtEst.setString(9,session.getAttribute("USERID").toString());
			stmtEst.setString(10,brchName);
			stmtEst.setString(13,servicestotal);
			stmtEst.setString(14,servicesdiscount);
			stmtEst.setString(15,netservices);
			stmtEst.setString(16, hidchklumsum);
			stmtEst.setString(17, lumsumamount);
			stmtEst.setString(18, jobcarddocno);
			stmtEst.setString(19, estdocno);
			stmtEst.executeQuery();
			docno=Integer.parseInt(estdocno);
			vocno=stmtEst.getInt("vocNo");
			addition=stmtEst.getInt("vaddition");
			System.out.println("Result: "+docno+"//"+vocno+"//"+addition);
			request.setAttribute("WSESTADDVOCNO", vocno);
			request.setAttribute("WSESTADDITION", addition);
			int errorstatus=0;
			if(docno<=0){
				errorstatus=1;
				System.out.println("Main Error");
				return 0;
			}
			else{
				Statement stmt=conn.createStatement();
				hidchklumsum=hidchklumsum==null || hidchklumsum.trim().equalsIgnoreCase("")||hidchklumsum.trim().equalsIgnoreCase("undefined")?"0":hidchklumsum.trim();
				hidchkservicelumsum=hidchklumsum==null ||hidchkservicelumsum.trim().equalsIgnoreCase("")||hidchkservicelumsum.trim().equalsIgnoreCase("undefined")?"0":hidchkservicelumsum.trim();
				hidchkrandomlumsum=hidchkrandomlumsum==null || hidchkrandomlumsum.trim().equalsIgnoreCase("")||hidchkrandomlumsum.trim().equalsIgnoreCase("undefined")?"0":hidchkrandomlumsum.trim();
				lumsumamount=lumsumamount==null || lumsumamount.trim().equalsIgnoreCase("")||lumsumamount.trim().equalsIgnoreCase("undefined")?"0":lumsumamount.trim();
				servicelumsumamt=servicelumsumamt==null || servicelumsumamt.trim().equalsIgnoreCase("")||servicelumsumamt.trim().equalsIgnoreCase("undefined")?"0":servicelumsumamt.trim();
				randomlumsumamt=randomlumsumamt==null || randomlumsumamt.trim().equalsIgnoreCase("")||randomlumsumamt.trim().equalsIgnoreCase("undefined")?"0":randomlumsumamt.trim();
				gipclaimno=gipclaimno==null || gipclaimno.trim().equalsIgnoreCase("")||gipclaimno.trim().equalsIgnoreCase("undefined")?"":gipclaimno.trim();
				header=header==null || header.trim().equalsIgnoreCase("")||header.trim().equalsIgnoreCase("undefined")?"":header.trim();
				gipdatetime=gipdatetime==null || gipdatetime.trim().equalsIgnoreCase("")||gipdatetime.trim().equalsIgnoreCase("undefined")?"":gipdatetime.trim();
				notes=notes==null || notes.trim().equalsIgnoreCase("")||notes.trim().equalsIgnoreCase("undefined")?"":notes.trim();
				estimatedays=estimatedays==null || estimatedays.trim().equalsIgnoreCase("")||estimatedays.trim().equalsIgnoreCase("undefined")?"":estimatedays.trim();
				internalremarks=internalremarks==null || internalremarks.trim().equalsIgnoreCase("")||internalremarks.trim().equalsIgnoreCase("undefined")?"":internalremarks.trim();
				cmbserviceadvisor=cmbserviceadvisor==null || cmbserviceadvisor.trim().equalsIgnoreCase("")||cmbserviceadvisor.trim().equalsIgnoreCase("undefined")?"0":cmbserviceadvisor.trim();
				
				String strresetjob="update ws_estmadd est inner join ws_jobcard job on (est.doc_no=job.refno and job.reftype='EST') set job.savestatus=0 where est.doc_no="+docno+" and addition="+addition;
				int updateresetjob=stmt.executeUpdate(strresetjob);
				
				String strupdateest="update ws_estmadd set sparetotal="+sparetotal+",sparediscount="+sparediscount+",sparenettotal="+netspare+",serviceadvisor="+cmbserviceadvisor+",claimno='"+gipclaimno+"',gipdatetime='"+gipdatetime+"',estimatedays='"+estimatedays+"',header='"+header+"',notes='"+notes+"',internalremarks='"+internalremarks+"',chklumsum="+hidchklumsum+",lumsumamount="+lumsumamount+",chkservicelumsum="+hidchkservicelumsum+",servicelumsumamt="+servicelumsumamt+",chkrandomlumsum="+hidchkrandomlumsum+",randomlumsumamt="+randomlumsumamt+" where doc_no="+docno+" and addition="+addition;
				System.out.println(strupdateest);
				int updateest=stmt.executeUpdate(strupdateest);
				if(updateest<=0){
					System.out.println("Master Update Error");
					errorstatus=1;
					return 0;
				}
				int sparecount=0,labourcount=0;
				
				for(int i=0;i<sparepartsarray.size();i++){
					String temp[]=sparepartsarray.get(i).split("::");
					sparecount++;
					temp[0]=temp[0].trim().equalsIgnoreCase("")||temp[0].trim().equalsIgnoreCase("undefined")||temp[0]==null||temp[0].isEmpty()?"":temp[0].trim();
					temp[1]=temp[1].trim().equalsIgnoreCase("")||temp[1].trim().equalsIgnoreCase("undefined")||temp[1]==null||temp[1].isEmpty()?"0":temp[1].trim();
					temp[2]=temp[2].trim().equalsIgnoreCase("")||temp[2].trim().equalsIgnoreCase("undefined")||temp[2]==null||temp[2].isEmpty()?"0":temp[2].trim();
					temp[3]=temp[3].trim().equalsIgnoreCase("")||temp[3].trim().equalsIgnoreCase("undefined")||temp[3]==null||temp[3].isEmpty()?"0":temp[3].trim();

					String strsql="insert into ws_estspare(rdocno, srno,description, qty, rate,approvedvalue, addition, confirmed, approved)values("+
					""+estdocno+","+sparecount+",'"+temp[0]+"',"+temp[1]+","+temp[2]+","+temp[3]+","+addition+",1,0)";
/*					String strsql="insert into ws_estsparenew(rdocno, description, qty, genuinerate, marketrate, usedrate, genuinetotal, markettotal, usedtotal, status)values("+
					" "+docno+",'"+temp[0]+"',"+temp[1]+","+temp[2]+","+temp[3]+","+temp[4]+","+temp[5]+","+temp[6]+","+temp[7]+",3)";
*/					System.out.println(strsql);
					int gridinsert=stmt.executeUpdate(strsql);
					if(gridinsert<=0){
						errorstatus=1;
						System.out.println("Spare Error");
						return 0;
					}
				}
				for(int i=0;i<labourcostarray.size();i++){
					String temp[]=labourcostarray.get(i).split("::");
					labourcount++;
					temp[0]=temp[0].trim().equalsIgnoreCase("")||temp[0].trim().equalsIgnoreCase("undefined")||temp[0]==null||temp[0].isEmpty()?"0":temp[0].trim();
					temp[1]=temp[1].trim().equalsIgnoreCase("")||temp[1].trim().equalsIgnoreCase("undefined")||temp[1]==null||temp[1].isEmpty()?"0":temp[1].trim();
					temp[2]=temp[2].trim().equalsIgnoreCase("")||temp[2].trim().equalsIgnoreCase("undefined")||temp[2]==null||temp[2].isEmpty()?"0":temp[2].trim();
					temp[3]=temp[3].trim().equalsIgnoreCase("")||temp[3].trim().equalsIgnoreCase("undefined")||temp[3]==null||temp[3].isEmpty()?"0":temp[3].trim();
					temp[4]=temp[4].trim().equalsIgnoreCase("")||temp[4].trim().equalsIgnoreCase("undefined")||temp[4]==null||temp[4].isEmpty()?"0":temp[4].trim();
					temp[5]=temp[5].trim().equalsIgnoreCase("")||temp[5].trim().equalsIgnoreCase("undefined")||temp[5]==null||temp[5].isEmpty()?"":temp[5].trim();
					String strjobtype=temp[6].trim().equalsIgnoreCase("")||temp[6].trim().equalsIgnoreCase("undefined")||temp[6]==null||temp[6].isEmpty()?"":temp[6].trim();
					String strjobdesc=temp[7].trim().equalsIgnoreCase("")||temp[7].trim().equalsIgnoreCase("undefined")||temp[7]==null||temp[7].isEmpty()?"":temp[7].trim();
					String seqno=temp[8].trim().equalsIgnoreCase("")||temp[8].trim().equalsIgnoreCase("undefined")||temp[8]==null||temp[8].isEmpty()?"":temp[8].trim();
					if(seqno.trim().equalsIgnoreCase("")){
						seqno=labourcount+"";
					}
					String strsql="insert into ws_estlabour(rdocno, srno, jobid, hrs, rate, markupper, total, remarks, addition, confirmed, approved,strjobtype,strjobdesc,seqno)values("+
					""+estdocno+","+labourcount+","+temp[0]+","+temp[1]+","+temp[2]+","+temp[3]+","+temp[4]+",'"+temp[5]+"',"+addition+",1,0,'"+strjobtype+"','"+strjobdesc+"',"+seqno+")";
					System.out.println(strsql);
					int gridinsert=stmt.executeUpdate(strsql);
					if(gridinsert<=0){
						errorstatus=1;
						System.out.println("Labour Error");
						return 0;
					}
				}
				
				if(errorstatus==0){
					conn.commit();
					return docno;
				}
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
	public boolean edit(String gatedocno, String sparepartstotal,
			String labourtotal, String discount, String esttotal, Date sqldate,
			ArrayList<String> sparepartsarray,
			ArrayList<String> labourcostarray, HttpSession session,
			HttpServletRequest request, String mode, String formdetailcode,
			String brchName, String docno, String vocno,  String servicesdiscount, 
			String servicestotal, String netservices,String hidchklumsum,
			String lumsumamount, String jocarddocno, String estdocno,String addition,
			String hidchkservicelumsum,String servicelumsumamt,String hidchkrandomlumsum,
			String randomlumsumamt,String header,String notes,String internalremarks,
			String gipclaimno,String gipdatetime,String estimatedays,String cmbserviceadvisor,
			String sparetotal, String sparediscount, String netspare) throws SQLException {
		// TODO Auto-generated method stub
				Connection conn=null;
				try{

					sparetotal=sparetotal==null || sparetotal.trim().equalsIgnoreCase("undefined") || sparetotal.trim().equalsIgnoreCase("")?"0":sparetotal.trim();
					sparediscount=sparediscount==null || sparediscount.trim().equalsIgnoreCase("undefined") || sparediscount.trim().equalsIgnoreCase("")?"0":sparediscount.trim();
					netspare=netspare==null || netspare.trim().equalsIgnoreCase("undefined") || netspare.trim().equalsIgnoreCase("")?"0":netspare.trim();
					System.out.println("Service Total:"+servicestotal);
					System.out.println("Service Discount:"+servicesdiscount);
					System.out.println("Service Net Total:"+netservices);
					
					conn=objconn.getMyConnection();
					conn.setAutoCommit(false);
					CallableStatement stmtEst = conn.prepareCall("{call WSEstimationAdditionDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
					stmtEst.setInt(12, Integer.parseInt(vocno));
					stmtEst.setInt(11, Integer.parseInt(docno));
					stmtEst.setInt(20, Integer.parseInt(addition));
					stmtEst.setDate(1,sqldate);
					stmtEst.setString(2,gatedocno);
					stmtEst.setString(3,"0");
					stmtEst.setString(4, "0");
					stmtEst.setString(5,"0");
					stmtEst.setString(6,"0");
					stmtEst.setString(7,formdetailcode);
					stmtEst.setString(8,mode);
					stmtEst.setString(9,session.getAttribute("USERID").toString());
					stmtEst.setString(10,brchName);
					stmtEst.setString(13,servicestotal);
					stmtEst.setString(14,servicesdiscount);
					stmtEst.setString(15,netservices);
					stmtEst.setString(16, hidchklumsum);
					stmtEst.setString(17, lumsumamount);
					stmtEst.setString(18, jocarddocno);
					stmtEst.setString(19, estdocno);
					//stmtEst.executeQuery();
					//addition=stmtEst.getInt("vaddition");
					int updateval=stmtEst.executeUpdate();
					int errorstatus=0;
					if(updateval<0){
						errorstatus=1;
						return false;
					}
					else{
						
						Statement stmt=conn.createStatement();
						hidchklumsum=hidchklumsum==null || hidchklumsum.trim().equalsIgnoreCase("")||hidchklumsum.trim().equalsIgnoreCase("undefined")?"0":hidchklumsum;
						hidchkservicelumsum=hidchklumsum==null ||hidchkservicelumsum.trim().equalsIgnoreCase("")||hidchkservicelumsum.trim().equalsIgnoreCase("undefined")?"0":hidchkservicelumsum;
						hidchkrandomlumsum=hidchkrandomlumsum==null || hidchkrandomlumsum.trim().equalsIgnoreCase("")||hidchkrandomlumsum.trim().equalsIgnoreCase("undefined")?"0":hidchkrandomlumsum;
						lumsumamount=lumsumamount==null || lumsumamount.trim().equalsIgnoreCase("")||lumsumamount.trim().equalsIgnoreCase("undefined")?"0":lumsumamount;
						servicelumsumamt=servicelumsumamt==null || servicelumsumamt.trim().equalsIgnoreCase("")||servicelumsumamt.trim().equalsIgnoreCase("undefined")?"0":servicelumsumamt;
						randomlumsumamt=randomlumsumamt==null || randomlumsumamt.trim().equalsIgnoreCase("")||randomlumsumamt.trim().equalsIgnoreCase("undefined")?"0":randomlumsumamt;
						gipclaimno=gipclaimno==null || gipclaimno.trim().equalsIgnoreCase("")||gipclaimno.trim().equalsIgnoreCase("undefined")?"":gipclaimno;
						header=header==null || header.trim().equalsIgnoreCase("")||header.trim().equalsIgnoreCase("undefined")?"":header;
						gipdatetime=gipdatetime==null || gipdatetime.trim().equalsIgnoreCase("")||gipdatetime.trim().equalsIgnoreCase("undefined")?"":gipdatetime;
						notes=notes==null || notes.trim().equalsIgnoreCase("")||notes.trim().equalsIgnoreCase("undefined")?"":notes;
						estimatedays=estimatedays==null || estimatedays.trim().equalsIgnoreCase("")||estimatedays.trim().equalsIgnoreCase("undefined")?"":estimatedays;
						internalremarks=internalremarks==null || internalremarks.trim().equalsIgnoreCase("")||internalremarks.trim().equalsIgnoreCase("undefined")?"":internalremarks;
						cmbserviceadvisor=cmbserviceadvisor==null || cmbserviceadvisor.trim().equalsIgnoreCase("")||cmbserviceadvisor.trim().equalsIgnoreCase("undefined")?"0":cmbserviceadvisor.trim();
						
						String strresetjob="update ws_estmadd est inner join ws_jobcard job on (est.doc_no=job.refno and job.reftype='EST') set job.savestatus=0 where est.doc_no="+docno+" and addition="+addition;
						int updateresetjob=stmt.executeUpdate(strresetjob);
						
						String strupdateest="update ws_estmadd set sparetotal="+sparetotal+",sparediscount="+sparediscount+",sparenettotal="+netspare+",serviceadvisor="+cmbserviceadvisor+",claimno='"+gipclaimno+"',gipdatetime='"+gipdatetime+"',estimatedays='"+estimatedays+"',header='"+header+"',notes='"+notes+"',internalremarks='"+internalremarks+"',chklumsum="+hidchklumsum+",lumsumamount="+lumsumamount+",chkservicelumsum="+hidchkservicelumsum+",servicelumsumamt="+servicelumsumamt+",chkrandomlumsum="+hidchkrandomlumsum+",randomlumsumamt="+randomlumsumamt+" where doc_no="+docno+" and addition="+addition;
						int updateest=stmt.executeUpdate(strupdateest);
						if(updateest<=0){
							System.out.println("Master Update Error");
							errorstatus=1;
							return false;
						}
						
						int sparecount=0,labourcount=0;
						String strdeletespare="delete from ws_estspare where rdocno="+estdocno+" and addition="+addition;
						int deletespare=stmt.executeUpdate(strdeletespare);
						if(deletespare<0){
							errorstatus=1;
							return false;
						}
						String strdeletelabour="delete from ws_estlabour where rdocno="+estdocno+" and addition="+addition;
						int deletelabour=stmt.executeUpdate(strdeletelabour);
						if(deletelabour<0){
							errorstatus=1;
							return false;
						}
						for(int i=0;i<sparepartsarray.size();i++){
							String temp[]=sparepartsarray.get(i).split("::");
							sparecount++;
							temp[0]=temp[0].trim().equalsIgnoreCase("")||temp[0].trim().equalsIgnoreCase("undefined")||temp[0]==null||temp[0].isEmpty()?"":temp[0].trim();
							temp[1]=temp[1].trim().equalsIgnoreCase("")||temp[1].trim().equalsIgnoreCase("undefined")||temp[1]==null||temp[1].isEmpty()?"0":temp[1].trim();
							temp[2]=temp[2].trim().equalsIgnoreCase("")||temp[2].trim().equalsIgnoreCase("undefined")||temp[2]==null||temp[2].isEmpty()?"0":temp[2].trim();
							temp[3]=temp[3].trim().equalsIgnoreCase("")||temp[3].trim().equalsIgnoreCase("undefined")||temp[3]==null||temp[3].isEmpty()?"0":temp[3].trim();

							String strsql="insert into ws_estspare(rdocno, srno,description, qty, rate, approvedvalue, addition, confirmed, approved)values("+
									""+estdocno+","+sparecount+",'"+temp[0]+"',"+temp[1]+","+temp[2]+","+temp[3]+","+addition+",1,0)";
							System.out.println(strsql);
							int gridinsert=stmt.executeUpdate(strsql);
							if(gridinsert<=0){
								errorstatus=1;
								return false;
							}
						}
						for(int i=0;i<labourcostarray.size();i++){
							String temp[]=labourcostarray.get(i).split("::");
							labourcount++;
							temp[0]=temp[0].trim().equalsIgnoreCase("")||temp[0].trim().equalsIgnoreCase("undefined")||temp[0]==null||temp[0].isEmpty()?"0":temp[0].trim();
							temp[1]=temp[1].trim().equalsIgnoreCase("")||temp[1].trim().equalsIgnoreCase("undefined")||temp[1]==null||temp[1].isEmpty()?"0":temp[1].trim();
							temp[2]=temp[2].trim().equalsIgnoreCase("")||temp[2].trim().equalsIgnoreCase("undefined")||temp[2]==null||temp[2].isEmpty()?"0":temp[2].trim();
							temp[3]=temp[3].trim().equalsIgnoreCase("")||temp[3].trim().equalsIgnoreCase("undefined")||temp[3]==null||temp[3].isEmpty()?"0":temp[3].trim();
							temp[4]=temp[4].trim().equalsIgnoreCase("")||temp[4].trim().equalsIgnoreCase("undefined")||temp[4]==null||temp[4].isEmpty()?"0":temp[4].trim();
							temp[5]=temp[5].trim().equalsIgnoreCase("")||temp[5].trim().equalsIgnoreCase("undefined")||temp[5]==null||temp[5].isEmpty()?"":temp[5].trim();
							String strjobtype=temp[6].trim().equalsIgnoreCase("")||temp[6].trim().equalsIgnoreCase("undefined")||temp[6]==null||temp[6].isEmpty()?"":temp[6].trim();
							String strjobdesc=temp[7].trim().equalsIgnoreCase("")||temp[7].trim().equalsIgnoreCase("undefined")||temp[7]==null||temp[7].isEmpty()?"":temp[7].trim();
							String seqno=temp[8].trim().equalsIgnoreCase("")||temp[8].trim().equalsIgnoreCase("undefined")||temp[8]==null||temp[8].isEmpty()?"":temp[8].trim();
							if(seqno.trim().equalsIgnoreCase("")){
								seqno=labourcount+"";
							}
							String strsql="insert into ws_estlabour(rdocno, srno, jobid, hrs, rate, markupper, total, remarks, addition, confirmed, approved,strjobtype,strjobdesc,seqno)values("+
							""+estdocno+","+labourcount+","+temp[0]+","+temp[1]+","+temp[2]+","+temp[3]+","+temp[4]+",'"+temp[5]+"',"+addition+",1,0,'"+strjobtype+"','"+strjobdesc+"',"+seqno+")";
							int gridinsert=stmt.executeUpdate(strsql);
							if(gridinsert<=0){
								errorstatus=1;
								return false;
							}
						}
						if(errorstatus==0){
							conn.commit();
							return true;
						}
					}
				}
				catch(Exception e){
					e.printStackTrace();
					conn.close();
				}
				finally{
					conn.close();
				}
				return false;
	}
	
	public boolean delete(String gatedocno, String sparepartstotal,
			String labourtotal, String discount, String esttotal, Date sqldate,
			ArrayList<String> sparepartsarray,
			ArrayList<String> labourcostarray, HttpSession session,
			HttpServletRequest request, String mode, String formdetailcode,
			String brchName, String docno, String vocno) throws SQLException {
		// TODO Auto-generated method stub
				Connection conn=null;
				System.out.println("inside deletion docno"+docno+" branch"+brchName);
				try{
					conn=objconn.getMyConnection();
					conn.setAutoCommit(false);
					CallableStatement stmtEst = conn.prepareCall("{call WSEstimationAdditionDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
					stmtEst.registerOutParameter(12, java.sql.Types.INTEGER);
					stmtEst.registerOutParameter(11, java.sql.Types.INTEGER);
					stmtEst.registerOutParameter(20, java.sql.Types.INTEGER);
					stmtEst.setDate(1,sqldate);
					stmtEst.setString(2,gatedocno);
					stmtEst.setString(3,"0");
					stmtEst.setString(4, "0");
					stmtEst.setString(5,"0");
					stmtEst.setString(6,"0");
					stmtEst.setString(7,formdetailcode);
					stmtEst.setString(8,mode);
					stmtEst.setString(9,session.getAttribute("USERID").toString());
					stmtEst.setString(10,brchName);
					stmtEst.setString(13,"0");
					stmtEst.setString(14,"0");
					stmtEst.setString(15,"0");
					stmtEst.setString(16, "0");
					stmtEst.setString(17, "0");
					stmtEst.setString(18, "0");
					stmtEst.setString(19, "0");
					//stmtEst.executeQuery();
					int updateval=stmtEst.executeUpdate();
					int errorstatus=0;
					if(updateval<0){
						System.out.println("Master Error");
						errorstatus=1;
						return false;
					}
					if(errorstatus==0){
						conn.commit();
						return true;
					}
				}
				catch(Exception e){
					e.printStackTrace();
					conn.close();
				}
				finally{
					conn.close();
				}
				return false;
	}
	
	public JSONArray getMasterSearch(String gatevocno,String cldocno,String clientname,String docno,
			String date,String id,String branch,String regno) throws SQLException
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
			if(!gatevocno.equalsIgnoreCase("")){
				sqltest+=" and gate.voc_no like '%"+gatevocno+"%'";
			}
			if(!regno.equalsIgnoreCase("")){
				sqltest+=" and gate.regno like '%"+regno+"%'";
			}
			if(!gatevocno.equalsIgnoreCase("")){
				sqltest+=" and gate.voc_no like '%"+gatevocno+"%'";
			}
			if(!cldocno.equalsIgnoreCase("")){
				sqltest+=" and ac.cldocno like '%"+cldocno+"%'";
			}
			if(!clientname.equalsIgnoreCase("")){
				sqltest+=" and ac.refname like '%"+clientname+"%'";
			}
			if(!docno.equalsIgnoreCase("")){
				sqltest+=" and m1.voc_no like '%"+docno+"%'";
			}
			if(!date.equalsIgnoreCase("")){
				sqldate=objcommon.changeStringtoSqlDate(date);
				sqltest+=" and m1.date='"+sqldate+"'";
			}
			if(!branch.equalsIgnoreCase("")){
				sqltest+=" and m1.brhid="+branch;
			}
			strsql="select round(coalesce(m1.sparetotal,0),2) sparetotal,round(coalesce(m1.sparediscount,0),2) sparediscount,round(coalesce(m1.sparenettotal,0),2) netspare,coalesce(m1.serviceadvisor,0) serviceadvisor,coalesce(insur.refname,'') gipinsurcomp,coalesce(m1.claimno,'') gipclaimno,coalesce(m1.gipdatetime,'') gipdatetime,coalesce(m1.estimatedays,'') estimatedays,m1.header,m1.notes,m1.internalremarks,m1.chkservicelumsum chkservicelumsum,round(m1.servicelumsumamt,2) servicelumsumamt,m1.chkrandomlumsum chkrandomlumsum,round(m1.randomlumsumamt,2) randomlumsumamt,job.doc_no jobdocno,job.voc_no jobvocno,m1.addition,m1.chklumsum,round(m1.lumsumamount,2) lumsumamount,m1.doc_no,m1.voc_no,m1.date,round(m1.servicestotal,2) servicestotal, round(m1.servicesdiscount,2) servicesdiscount, round(m1.netservices,2) netservices,"+
			" convert(concat(coalesce(brd.brand_name,''),' ',coalesce(model.vtype,''),' ','Reg No ',coalesce(gate.regno,''),' ',coalesce(gate.pltid,''),' ',coalesce(yom.yom,''),' Others: ',"+
			" coalesce(gate.vehother,'')),char(200)) vehicledetails,gate.doc_no gatedocno,gate.voc_no gatevocno,gate.cldocno,gate.regno,ac.refname,"+
			" concat(coalesce(ac.refname,''),' , Address: ',coalesce(ac.address,''),' , Telephone: ',coalesce(ac.per_tel,''),' , Mobile: ',coalesce(ac.per_mob,''),' , Mail: ',coalesce(ac.mail1,''),"+
			" ' , Contact Person ',coalesce(ac.contactperson,'')) userdetails from ws_estmadd m1 left join ws_jobcard job on (m1.jobcarddocno=job.doc_no) left join ws_estm m on m1.doc_no=m.doc_no left join ws_gateinpass gate on m.gipno=gate.doc_no left join"+
			" my_acbook ac on (gate.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_vehplate plate on gate.pltid=plate.doc_no left join"+
			" gl_vehbrand brd on gate.brdid=brd.doc_no left join gl_vehmodel model on gate.modid=model.doc_no left join gl_yom yom on"+
			" gate.yom=yom.doc_no left join my_acbook insur on (insur.cldocno=gate.insurcldocno and insur.dtype='CRM') where m.status=3"+sqltest;
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
	public JSONArray getLabourcostData(String docno,String id,String addition)throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select coalesce(lab.seqno,0) seqno,lab.strjobdesc jobdesc,m.doc_no,m.date,lab.hrs,lab.rate,lab.strjobtype jobtype,lab.markupper markuppercent,lab.total,lab.remarks,"+
			" lab.jobid from ws_estlabour lab left join ws_jobmaster m on (m.status=3 and lab.jobid=m.doc_no ) left join ws_jobtype t on m.jobid=t.doc_no "+
			" where lab.addition="+addition+" and lab.rdocno="+docno+" and lab.lumsumstatus=0 order by lab.seqno ";
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
	
	public ClsEstimationAdditionPalBean viewdetails(int docno,int vocno,String addition) throws SQLException
{
	ClsEstimationAdditionPalBean been=new ClsEstimationAdditionPalBean();
	Connection conn=null;
	
	try{
		conn=objconn.getMyConnection();
		Statement stmt=conn.createStatement();
		
		String strsql="";
		String sqltest="";
		if(addition!=null && !addition.trim().equalsIgnoreCase("") && !addition.trim().equalsIgnoreCase("undefined") && !addition.equalsIgnoreCase("0")){
			sqltest+=" and m.addition="+addition;
		}
		
		strsql="select round(coalesce(m.sparetotal,0),2) sparetotal,round(coalesce(m.sparediscount,0),2) sparediscount,round(coalesce(m.sparenettotal,0),2) netspare,m.chkservicelumsum chkservicelumsum,round(m.servicelumsumamt,2) servicelumsumamt,m.chkrandomlumsum chkrandomlumsum,round(m.randomlumsumamt,2) randomlumsumamt,m.estdocno,job.voc_no jobcardvocno,job.doc_no jobcarddocno,coalesce(m.serviceadvisor,0) serviceadvisor,coalesce(m.brhid,0) estbrhid,coalesce(insur.refname,'') gipinsurcomp,coalesce(m.claimno,'') gipclaimno,coalesce(m.gipdatetime,'') gipdatetime,coalesce(m.estimatedays,'') estimatedays,m.header,m.notes,m.internalremarks,m.chklumsum,round(m.lumsumamount,2) lumsumamount,m.doc_no,m.voc_no,m.date,round(m.servicestotal,2) servicestotal, round(m.servicesdiscount,2) servicesdiscount, round(m.netservices,2) netservices,"+
		" convert(concat(coalesce(brd.brand_name,''),' ',coalesce(model.vtype,''),' ','Reg No ',coalesce(gate.regno,''),' ',coalesce(gate.pltid,''),' ',coalesce(yom.yom,''),' Others: ',"+
		" coalesce(gate.vehother,'')),char(200)) vehicledetails,gate.doc_no gatedocno,gate.voc_no gatevocno,gate.cldocno,gate.regno,ac.refname,"+
		" concat(ac.refname,' , Address: ',ac.address,' , Telephone: ',ac.per_tel,' , Mobile: ',ac.per_mob,' , Mail: ',ac.mail1,"+
		" ' , Contact Person ',ac.contactperson) userdetails from ws_estmadd m left join ws_gateinpass gate on m.gatedocno=gate.doc_no left join"+
		" my_acbook ac on (gate.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_vehplate plate on gate.pltid=plate.doc_no left join"+
		" gl_vehbrand brd on gate.brdid=brd.doc_no left join gl_vehmodel model on gate.modid=model.doc_no left join gl_yom yom on"+
		" gate.yom=yom.doc_no left join ws_jobcard job on (m.jobcarddocno=job.doc_no) left join my_acbook insur on (gate.insurcldocno=insur.cldocno and insur.dtype='CRM') where m.status=3 and m.doc_no="+docno+sqltest;
		System.out.println(strsql);
		ResultSet rs=stmt.executeQuery(strsql);
		while(rs.next()) {
			been.setSparetotal(rs.getString("sparetotal"));
			been.setSparediscount(rs.getString("sparediscount"));
			been.setNetspare(rs.getString("netspare"));
			
			been.setJobcarddocno(rs.getString("jobcarddocno"));
			been.setJobcardvocno(rs.getString("jobcardvocno"));
			been.setHidcmbserviceadvisor(rs.getString("serviceadvisor"));
			been.setDate(rs.getDate("date").toString());
			been.setBrhid(rs.getString("estbrhid"));
			been.setGipdatetime(rs.getString("gipdatetime"));
			been.setEstimatedays(rs.getString("estimatedays"));
			been.setGateuserdetails(rs.getString("userdetails"));
			been.setGatedocno(rs.getString("gatedocno"));
			been.setGatevocno(rs.getString("gatevocno"));
			been.setDocno(rs.getString("doc_no"));
			been.setVocno(rs.getString("voc_no"));
			been.setGatevehicledetails(rs.getString("vehicledetails"));
			been.setServicesdiscount(rs.getString("servicesdiscount"));
			been.setNetservices(rs.getString("netservices"));
			been.setHeader(rs.getString("header"));
	  		been.setNotes(rs.getString("notes"));
	  		been.setInternalremarks(rs.getString("internalremarks"));
	  		been.setGipinsurcomp(rs.getString("gipinsurcomp"));
	  		been.setGipclaimno(rs.getString("gipclaimno"));
	  		been.setEstdocno(rs.getString("estdocno"));
	  		been.setHidchkservicelumsum(rs.getString("chkservicelumsum"));
	  		if(been.getHidchkservicelumsum().trim().equalsIgnoreCase("1")){
	  			been.setServicelumsumamt(rs.getString("servicelumsumamt"));
	  		}
	  		been.setHidchkrandomlumsum(rs.getString("chkrandomlumsum"));
	  		if(been.getHidchkrandomlumsum().trim().equalsIgnoreCase("1")){
	  			been.setRandomlumsumamt(rs.getString("randomlumsumamt"));
	  		}
	  		been.setHidchklumsum(rs.getString("chklumsum"));
	  		if(been.getHidchklumsum().trim().equalsIgnoreCase("1")){
	  			been.setLumsumamount(rs.getString("lumsumamount"));
	  		}
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
	
}
