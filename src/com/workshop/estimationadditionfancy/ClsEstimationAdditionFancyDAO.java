package com.workshop.estimationadditionfancy;

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

public class ClsEstimationAdditionFancyDAO {
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
			System.out.println("Spare Amount Query:"+strsql);
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
			String strsql="select description, qty, genuinerate, marketrate, usedrate, genuinetotal, markettotal, usedtotal, approval, approvedvalue from ws_estspare where rdocno="+docno+" and addition="+addition;
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
	
	
	public JSONArray getGateInPassData(String gatedocno,String cldocno,String clientname,String jobcarddocno,String date,String id) throws SQLException{
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
			strsql="select  prv.sparemarkup,prv.labdiscount,coalesce(max(lab.addition),0) addition,job.doc_no,job.voc_no,est.doc_no estdocno,convert(concat(coalesce(brd.brand_name,''),' ',"+
				" coalesce(model.vtype,''),' Reg No: ',coalesce(gate.regno,''),' Plate Code: ',coalesce(gate.pltid,''),' YoM: ',"+
				" coalesce(yom.yom,''),' Others: ',coalesce(gate.vehother,'')),char(200)) vehicledetails "+
				" ,gate.doc_no gatedocno,gate.voc_no gatevocno,"+
			" job.date,gate.cldocno,gate.regno,ac.refname,concat(ac.refname,' , Address: ',ac.address,' , Telephone: ',ac.per_tel,' , Mobile: ',"+
			" ac.per_mob,' , Mail: ',ac.mail1,' , Contact Person ',ac.contactperson) userdetails from ws_jobcard job left join ws_estm est on (job.reftype='EST' and job.refno=est.doc_no)  left join ws_estlabour lab on (est.doc_no=lab.rdocno) left join ws_gateinpass gate on (est.gipno=gate.doc_no) left join my_acbook "+
			" ac on (gate.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_vehplate plate on gate.pltid=plate.doc_no left join gl_vehbrand "+
			" brd on gate.brdid=brd.doc_no left join gl_vehmodel model on gate.modid=model.doc_no left join gl_yom yom on "+
			" gate.yom=yom.doc_no  left join my_clprivilage prv on ac.privillege=prv.doc_no where job.status=3  and job.complete=0 "+sqltest+" group by job.doc_no";
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
			String sparetotal,String sparediscount,String sparenettotal) throws SQLException {
		// TODO Auto-generated method stub
		
		Connection conn=null;
		int docno=0,vocno=0,addition=0;
		try{
			System.out.println(jobcarddocno+"/////"+estdocno);
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
			if(docno>0){
				Statement stmt=conn.createStatement();
				String strupdate="update ws_estmadd set sparetotal="+sparetotal+",sparediscount="+sparediscount+",sparenettotal="+sparenettotal+" where doc_no="+docno;
				int updateval=stmt.executeUpdate(strupdate);
				if(updateval<=0){
					errorstatus=1;
					return 0;
				}
			}
			if(docno<=0){
				errorstatus=1;
				System.out.println("Main Error");
				return 0;
			}
			else{
				int sparecount=0,labourcount=0;
				Statement stmt=conn.createStatement();
				for(int i=0;i<sparepartsarray.size();i++){
					String temp[]=sparepartsarray.get(i).split("::");
					sparecount++;
					temp[0]=temp[0].trim().equalsIgnoreCase("")||temp[0].trim().equalsIgnoreCase("undefined")||temp[0]==null||temp[0].isEmpty()?"":temp[0].trim();
					temp[1]=temp[1].trim().equalsIgnoreCase("")||temp[1].trim().equalsIgnoreCase("undefined")||temp[1]==null||temp[1].isEmpty()?"0":temp[1].trim();
					temp[2]=temp[2].trim().equalsIgnoreCase("")||temp[2].trim().equalsIgnoreCase("undefined")||temp[2]==null||temp[2].isEmpty()?"0":temp[2].trim();
					temp[3]=temp[3].trim().equalsIgnoreCase("")||temp[3].trim().equalsIgnoreCase("undefined")||temp[3]==null||temp[3].isEmpty()?"0":temp[3].trim();
					temp[4]=temp[4].trim().equalsIgnoreCase("")||temp[4].trim().equalsIgnoreCase("undefined")||temp[4]==null||temp[4].isEmpty()?"0":temp[4].trim();
					temp[5]=temp[5].trim().equalsIgnoreCase("")||temp[5].trim().equalsIgnoreCase("undefined")||temp[5]==null||temp[5].isEmpty()?"0":temp[5].trim();
					temp[6]=temp[6].trim().equalsIgnoreCase("")||temp[6].trim().equalsIgnoreCase("undefined")||temp[6]==null||temp[6].isEmpty()?"0":temp[6].trim();
					temp[7]=temp[7].trim().equalsIgnoreCase("")||temp[7].trim().equalsIgnoreCase("undefined")||temp[7]==null||temp[7].isEmpty()?"0":temp[7].trim();
					temp[8]=temp[8].trim().equalsIgnoreCase("")||temp[8].trim().equalsIgnoreCase("undefined")||temp[8]==null||temp[8].isEmpty()?"":temp[8].trim();
					temp[9]=temp[9].trim().equalsIgnoreCase("")||temp[9].trim().equalsIgnoreCase("undefined")||temp[9]==null||temp[9].isEmpty()?"0":temp[9].trim();
					if(temp[10].trim().equalsIgnoreCase("true")){
						temp[10]="1";
					}
					else{
						temp[10]="0";
					}
					String strsql="insert into ws_estspare(rdocno, srno,description, qty, genuinerate, marketrate, usedrate, genuinetotal, markettotal, usedtotal, addition, confirmed, approved,chkexcess)values("+
					""+estdocno+","+sparecount+",'"+temp[0]+"',"+temp[1]+","+temp[2]+","+temp[3]+","+temp[4]+","+temp[5]+","+temp[6]+","+temp[7]+","+addition+",0,0,"+temp[10]+")";
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
					if(temp[6].trim().equalsIgnoreCase("true")){
						temp[6]="1";
					}
					else{
						temp[6]="0";
					}
					String strsql="insert into ws_estlabour(rdocno, srno, jobid, hrs, rate, markupper, total, remarks, addition, confirmed, approved,chkexcess)values("+
					""+estdocno+","+labourcount+","+temp[0]+","+temp[1]+","+temp[2]+","+temp[3]+","+temp[4]+",'"+temp[5]+"',"+addition+",0,0,"+temp[6]+")";
					System.out.println(strsql);
					int gridinsert=stmt.executeUpdate(strsql);
					if(gridinsert<=0){
						errorstatus=1;
						System.out.println("Labour Error");
						return 0;
					}
				}
				double dblabourtotal=0.0,dbsparetotal=0.0;
				String strgetesttotal="select (select sum(lab.total) from ws_jobcard job left join ws_estm est on job.refno=est.doc_no left join ws_estlabour lab on (est.doc_no=lab.rdocno and lab.confirmed=1 and lab.approved=1) where est.status<>7 and job.doc_no="+jobcarddocno+") labourtotal,(select sum(approvedvalue) from ws_jobcard job left join ws_estm est on job.refno=est.doc_no left join ws_estspare sp on (est.doc_no=sp.rdocno and sp.confirmed=1 and sp.approved=1) where est.status<>7 and job.doc_no="+jobcarddocno+") sparetotal";
				ResultSet rsgetesttotal=stmt.executeQuery(strgetesttotal);
				while(rsgetesttotal.next()){
					dblabourtotal=rsgetesttotal.getDouble("labourtotal");
					dbsparetotal=rsgetesttotal.getDouble("sparetotal");
				}
				String strupdatefloormgmt="update ws_floormgmtdata set esttotal="+(dblabourtotal+dbsparetotal)+" where jobdocno="+jobcarddocno;
				int updatefloormgmt=stmt.executeUpdate(strupdatefloormgmt);
				if(updatefloormgmt<=0){
					errorstatus=1;
					System.out.println("Floor Mgmt Update Error");
					return 0;
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
			String sparetotal,String sparediscount,String sparenettotal) throws SQLException {
		
		// TODO Auto-generated method stub
				Connection conn=null;
				try{
					conn=objconn.getMyConnection();
					conn.setAutoCommit(false);
					CallableStatement stmtEst = conn.prepareCall("{call WSEstimationAdditionDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
					stmtEst.setInt(12, Integer.parseInt(vocno));
					stmtEst.setInt(11, Integer.parseInt(docno));
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
					stmtEst.setString(18, jocarddocno);
					stmtEst.setString(19, estdocno);
					//stmtEst.executeQuery();
					//addition=stmtEst.getInt("vaddition");
					int updateval=stmtEst.executeUpdate();
					int errorstatus=0;
					if(Integer.parseInt(docno)>0){
						Statement stmt=conn.createStatement();
						String strupdate="update ws_estmadd set sparetotal="+sparetotal+",sparediscount="+sparediscount+",sparenettotal="+sparenettotal+" where doc_no="+docno;
						int updatevalue=stmt.executeUpdate(strupdate);
						if(updatevalue<=0){
							errorstatus=1;
							return false;
						}
					}
					if(updateval<0){
						errorstatus=1;
						return false;
					}
					else{
						int sparecount=0,labourcount=0;
						Statement stmt=conn.createStatement();
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
							temp[4]=temp[4].trim().equalsIgnoreCase("")||temp[4].trim().equalsIgnoreCase("undefined")||temp[4]==null||temp[4].isEmpty()?"0":temp[4].trim();
							temp[5]=temp[5].trim().equalsIgnoreCase("")||temp[5].trim().equalsIgnoreCase("undefined")||temp[5]==null||temp[5].isEmpty()?"0":temp[5].trim();
							temp[6]=temp[6].trim().equalsIgnoreCase("")||temp[6].trim().equalsIgnoreCase("undefined")||temp[6]==null||temp[6].isEmpty()?"0":temp[6].trim();
							temp[7]=temp[7].trim().equalsIgnoreCase("")||temp[7].trim().equalsIgnoreCase("undefined")||temp[7]==null||temp[7].isEmpty()?"0":temp[7].trim();
							temp[8]=temp[8].trim().equalsIgnoreCase("")||temp[8].trim().equalsIgnoreCase("undefined")||temp[8]==null||temp[8].isEmpty()?"":temp[8].trim();
							temp[9]=temp[9].trim().equalsIgnoreCase("")||temp[9].trim().equalsIgnoreCase("undefined")||temp[9]==null||temp[9].isEmpty()?"0":temp[9].trim();
							if(temp[10].trim().equalsIgnoreCase("true")){
								temp[10]="1";
							}
							else{
								temp[10]="0";
							}
							String strsql="insert into ws_estspare(rdocno, srno,description, qty, genuinerate, marketrate, usedrate, genuinetotal, markettotal, usedtotal,approval,approvedvalue, addition, confirmed, approved,chkexcess)values("+
									""+estdocno+","+sparecount+",'"+temp[0]+"',"+temp[1]+","+temp[2]+","+temp[3]+","+temp[4]+","+temp[5]+","+temp[6]+","+temp[7]+",'"+temp[8]+"',"+temp[9]+","+addition+",0,0,"+temp[10]+")";
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
							if(temp[6].trim().equalsIgnoreCase("true")){
								temp[6]="1";
							}
							else{
								temp[6]="0";
							}
							String strsql="insert into ws_estlabour(rdocno, srno, jobid, hrs, rate, markupper, total, remarks, addition, confirmed, approved,chkexcess)values("+
									""+estdocno+","+labourcount+","+temp[0]+","+temp[1]+","+temp[2]+","+temp[3]+","+temp[4]+",'"+temp[5]+"',"+addition+",0,0,"+temp[6]+")";
							int gridinsert=stmt.executeUpdate(strsql);
							if(gridinsert<=0){
								errorstatus=1;
								return false;
							}
						}
						double dblabourtotal=0.0,dbsparetotal=0.0;
						String strgetesttotal="select (select sum(lab.total) from ws_jobcard job left join ws_estm est on job.refno=est.doc_no left join ws_estlabour lab on (est.doc_no=lab.rdocno and lab.confirmed=1 and lab.approved=1) where est.status<>7 and job.doc_no="+jocarddocno+") labourtotal,(select sum(approvedvalue) from ws_jobcard job left join ws_estm est on job.refno=est.doc_no left join ws_estspare sp on (est.doc_no=sp.rdocno and sp.confirmed=1 and sp.approved=1) where est.status<>7 and job.doc_no="+jocarddocno+") sparetotal";
						ResultSet rsgetesttotal=stmt.executeQuery(strgetesttotal);
						while(rsgetesttotal.next()){
							dblabourtotal=rsgetesttotal.getDouble("labourtotal");
							dbsparetotal=rsgetesttotal.getDouble("sparetotal");
						}
						String strupdatefloormgmt="update ws_floormgmtdata set esttotal="+(dblabourtotal+dbsparetotal)+" where jobdocno="+jocarddocno;
						int updatefloormgmt=stmt.executeUpdate(strupdatefloormgmt);
						if(updatefloormgmt<=0){
							errorstatus=1;
							System.out.println("Floor Mgmt Update Error");
							return false;
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
	
	public JSONArray getMasterSearch(String gatevocno,String cldocno,String clientname,String docno,String date,String id,String reg) throws SQLException
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
			if(!cldocno.equalsIgnoreCase("")){
				sqltest+=" and ac.cldocno like '%"+cldocno+"%'";
			}
			if(!clientname.equalsIgnoreCase("")){
				sqltest+=" and ac.refname like '%"+clientname+"%'";
			}
			if(!reg.equalsIgnoreCase("")){
				sqltest+=" and gate.regno like '%"+reg+"%'";
			}
			if(!docno.equalsIgnoreCase("")){
				sqltest+=" and m.voc_no like '%"+docno+"%'";
			}
			if(!date.equalsIgnoreCase("")){
				sqldate=objcommon.changeStringtoSqlDate(date);
				sqltest+=" and m.date='"+sqldate+"'";
			}
			
			strsql="select m1.sparetotal,m1.sparediscount,m1.sparenettotal,prv.sparemarkup,prv.labdiscount,job.doc_no jobdocno,job.voc_no jobvocno,m1.addition,m.chklumsum,round(m.lumsumamount,2) lumsumamount,m.doc_no,m.voc_no,m.date,round(m.servicestotal,2) servicestotal, round(m.servicesdiscount,2) servicesdiscount, round(m.netservices,2) netservices,"+
					" convert(concat(coalesce(brd.brand_name,''),' ',coalesce(model.vtype,''),' ',coalesce(yom.yom,''),' Others: ',"+
					" coalesce(gate.vehother,'')),char(200)) vehicledetails,gate.doc_no gatedocno,gate.voc_no gatevocno,gate.cldocno,gate.regno,ac.refname,"+
					" concat(ac.refname,' , Address: ',ac.address,' , Telephone: ',ac.per_tel,' , Mobile: ',ac.per_mob,' , Mail: ',ac.mail1,"+
					" ' , Contact Person ',ac.contactperson) userdetails from ws_estmadd m1 left join ws_jobcard job on (m1.jobcarddocno=job.doc_no) left join ws_estm m on m1.doc_no=m.doc_no left join ws_gateinpass gate on m.gipno=gate.doc_no left join"+
					" my_acbook ac on (gate.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_vehplate plate on gate.pltid=plate.doc_no left join"+
					" gl_vehbrand brd on gate.brdid=brd.doc_no left join gl_vehmodel model on gate.modid=model.doc_no left join gl_yom yom on"+
					" gate.yom=yom.doc_no left join my_clprivilage prv on ac.privillege=prv.doc_no where m.status=3"+sqltest;
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
			String strsql="select m.desc1 jobdesc,m.doc_no,m.date,lab.hrs,lab.rate,t.type jobtype,lab.markupper markuppercent,lab.total,lab.remarks,"+
			" lab.jobid from ws_estlabour lab left join ws_jobmaster m on (lab.jobid=m.doc_no ) left join ws_jobtype t on m.jobid=t.doc_no "+
			" where m.status=3 and lab.addition="+addition+" and lab.rdocno="+docno;
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
	
	public ClsEstimationAdditionFancyBean viewdetails(int docno,int vocno,String addition) throws SQLException
{
	ClsEstimationAdditionFancyBean bean=new ClsEstimationAdditionFancyBean();
	Connection conn=null;
	
	try{
		conn=objconn.getMyConnection();
		Statement stmt=conn.createStatement();
		
		String strsql="";
		String sqltest="";
		
		/**/
		strsql="select job.doc_no jobcarddocno,job.voc_no jobcardvocno,m.sparetotal,m.sparediscount,m.sparenettotal,prv.sparemarkup,prv.labdiscount,m.chklumsum,round(m.lumsumamount,2) lumsumamount,m.doc_no,m.voc_no,m.date,round(m.servicestotal,2) servicestotal, round(m.servicesdiscount,2) servicesdiscount, round(m.netservices,2) netservices,"+
		" convert(concat(coalesce(brd.brand_name,''),' ',coalesce(model.vtype,''),' ',coalesce(yom.yom,''),' Others: ',"+
		" coalesce(gate.vehother,'')),char(200)) vehicledetails,gate.doc_no gatedocno,gate.voc_no gatevocno,gate.cldocno,gate.regno,ac.refname,"+
		" concat(ac.refname,' , Address: ',ac.address,' , Telephone: ',ac.per_tel,' , Mobile: ',ac.per_mob,' , Mail: ',ac.mail1,"+
		" ' , Contact Person ',ac.contactperson) userdetails from ws_estmadd m1 left join ws_jobcard job on (m1.jobcarddocno=job.doc_no) left join ws_estm m on m1.doc_no=m.doc_no left join ws_gateinpass gate on m.gipno=gate.doc_no left join"+
		" my_acbook ac on (gate.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_vehplate plate on gate.pltid=plate.doc_no left join"+
		" gl_vehbrand brd on gate.brdid=brd.doc_no left join gl_vehmodel model on gate.modid=model.doc_no left join gl_yom yom on"+
		" gate.yom=yom.doc_no left join my_clprivilage prv on ac.privillege=prv.doc_no where m.status=3 and m1.doc_no="+docno+" and m1.addition="+addition;
		ResultSet rs=stmt.executeQuery(strsql);
		while(rs.next()) {
			bean.setGateuserdetails(rs.getString("userdetails"));
			bean.setGatedocno(rs.getString("gatedocno"));
			bean.setGatevocno(rs.getString("gatevocno"));
			bean.setVocno(rs.getString("voc_no"));
			bean.setDocno(rs.getString("doc_no"));
			bean.setDate(rs.getString("date").toString());
			bean.setGatevehicledetails(rs.getString("vehicledetails"));
			bean.setServicesdiscount(rs.getString("servicesdiscount"));
			bean.setNetservices(rs.getString("netservices"));
			bean.setServicestotal(rs.getString("servicestotal"));
			bean.setSparetotal(rs.getString("sparetotal"));
			bean.setSparenettotal(rs.getString("sparenettotal"));
			bean.setSparediscount(rs.getString("sparediscount"));
			bean.setJobcarddocno(rs.getString("jobcarddocno"));
			bean.setJobcardvocno(rs.getString("jobcardvocno"));
			/*bean.setHidchklumsum(rs.getString("chklumsum"));
			if(bean.getHidchklumsum().equalsIgnoreCase("1")){
				bean.setLumsumamount(rs.getString("lumsumamount"));
			}*/
			bean.setSparemarkup(rs.getString("sparemarkup"));
			bean.setLabdiscount(rs.getString("labdiscount"));
	  		} 
		
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
	
}
