package com.workshop.wsestimationnew;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.operations.marketing.leasecalculator.ClsLeaseCalculatorBean;

import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public class ClsWSEstimationNewDAO {

	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	
	public JSONArray getSparepartsAmountData(String gatedocno,String id) throws SQLException
	{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select description,taxpercent vatpercent,genuine genuinetotal,market markettotal,used usedtotal,approved approvedtotal from ws_estspareamt where status=3 and addition=0 and gatedocno="+gatedocno;
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
				sqltest+=" and m.desc1 like '%"+jobtype+"%'";
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
			String strsql="select description, qty, genuinerate, marketrate, usedrate, genuinetotal, markettotal, usedtotal, approval, approvedvalue from ws_estspare where addition=0 and rdocno="+docno;
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
			String brchName, String servicesdiscount, String servicestotal, String netservices, String hidchklumsum, String lumsumamount) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn=null;
		int docno=0,vocno=0;
		try{
			conn=objconn.getMyConnection();
			conn.setAutoCommit(false);
			CallableStatement stmtEst = conn.prepareCall("{call WSEstimationNewDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmtEst.registerOutParameter(12, java.sql.Types.INTEGER);
			stmtEst.registerOutParameter(11, java.sql.Types.INTEGER);
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
			stmtEst.executeQuery();
			docno=stmtEst.getInt("docNo");
			vocno=stmtEst.getInt("vocNo");
			request.setAttribute("WSESTVOCNO", vocno);
			int errorstatus=0;
			if(docno<=0){
				errorstatus=1;
				return 0;
			}
			else{
				int sparecount=0,labourcount=0;
				Statement stmt=conn.createStatement();
				for(int i=0;i<sparepartsarray.size();i++){
					String temp[]=sparepartsarray.get(i).split("::");
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
					sparecount++;
					
					String strsql="insert into ws_estspare(rdocno, srno,description, qty, genuinerate, marketrate, usedrate, genuinetotal, markettotal, usedtotal, addition, confirmed, approved)values("+
					""+docno+","+sparecount+",'"+temp[0]+"',"+temp[1]+","+temp[2]+","+temp[3]+","+temp[4]+","+temp[5]+","+temp[6]+","+temp[7]+",0,0,0)";
					System.out.println(strsql);
					int gridinsert=stmt.executeUpdate(strsql);
					if(gridinsert<=0){
						errorstatus=1;
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
					String strsql="insert into ws_estlabour(rdocno, srno, jobid, hrs, rate, markupper, total, remarks, addition, confirmed, approved)values("+
					""+docno+","+labourcount+","+temp[0]+","+temp[1]+","+temp[2]+","+temp[3]+","+temp[4]+",'"+temp[5]+"',0,0,0)";
					System.out.println(strsql);
					int gridinsert=stmt.executeUpdate(strsql);
					if(gridinsert<=0){
						errorstatus=1;
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
			String brchName, String docno, String vocno,  String servicesdiscount, String servicestotal, String netservices,String hidchklumsum,String lumsumamount) throws SQLException {
		// TODO Auto-generated method stub
				Connection conn=null;
				try{
					conn=objconn.getMyConnection();
					conn.setAutoCommit(false);
					CallableStatement stmtEst = conn.prepareCall("{call WSEstimationNewDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
					stmtEst.setInt(12, Integer.parseInt(vocno));
					stmtEst.setInt(11, Integer.parseInt(docno));
					stmtEst.setDate(1,sqldate);
					stmtEst.setString(2,gatedocno);
					stmtEst.setString(3,sparepartstotal);
					stmtEst.setString(4, labourtotal);
					stmtEst.setString(5,discount);
					stmtEst.setString(6,esttotal);
					stmtEst.setString(7,formdetailcode);
					stmtEst.setString(8,mode);
					stmtEst.setString(9,session.getAttribute("USERID").toString());
					stmtEst.setString(10,brchName);
					stmtEst.setString(13,servicestotal);
					stmtEst.setString(14,servicesdiscount);
					stmtEst.setString(15,netservices);
					stmtEst.setString(16, hidchklumsum);
					stmtEst.setString(17, lumsumamount);
					int updateval=stmtEst.executeUpdate();
					int errorstatus=0;
					if(updateval<0){
						errorstatus=1;
						return false;
					}
					else{
						int sparecount=0,labourcount=0;
						Statement stmt=conn.createStatement();
						String strdeletespare="delete from ws_estspare where rdocno="+docno;
						int deletespare=stmt.executeUpdate(strdeletespare);
						if(deletespare<0){
							errorstatus=1;
							return false;
						}
						String strdeletelabour="delete from ws_estlabour where rdocno="+docno;
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
							String strsql="insert into ws_estspare(rdocno, srno,description, qty, genuinerate, marketrate, usedrate, genuinetotal, markettotal, usedtotal,approval,approvedvalue, addition, confirmed, approved)values("+
									""+docno+","+sparecount+",'"+temp[0]+"',"+temp[1]+","+temp[2]+","+temp[3]+","+temp[4]+","+temp[5]+","+temp[6]+","+temp[7]+",'"+temp[8]+"',"+temp[9]+",0,0,0)";
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
							String strsql="insert into ws_estlabour(rdocno, srno, jobid, hrs, rate, markupper, total, remarks, addition, confirmed, approved)values("+
									""+docno+","+labourcount+","+temp[0]+","+temp[1]+","+temp[2]+","+temp[3]+","+temp[4]+",'"+temp[5]+"',0,0,0)";
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
				try{
					conn=objconn.getMyConnection();
					conn.setAutoCommit(false);
					CallableStatement stmtEst = conn.prepareCall("{call WSEstimationNewDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
					stmtEst.setInt(12, Integer.parseInt(vocno));
					stmtEst.setInt(11, Integer.parseInt(docno));
					stmtEst.setDate(1,sqldate);
					stmtEst.setString(2,gatedocno);
					stmtEst.setString(3,sparepartstotal);
					stmtEst.setString(4, labourtotal);
					stmtEst.setString(5,discount);
					stmtEst.setString(6,esttotal);
					stmtEst.setString(7,formdetailcode);
					stmtEst.setString(8,mode);
					stmtEst.setString(9,session.getAttribute("USERID").toString());
					stmtEst.setString(10,brchName);
					stmtEst.setString(13,"0");
					stmtEst.setString(14,"0");
					stmtEst.setString(15,"0");
					stmtEst.setString(16,"0");
					stmtEst.setString(17,"0");
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
	
	public JSONArray getMasterSearch(String gatevocno,String cldocno,String clientname,String docno,String date,String id) throws SQLException
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
			if(!docno.equalsIgnoreCase("")){
				sqltest+=" and m.voc_no like '%"+docno+"%'";
			}
			if(!date.equalsIgnoreCase("")){
				sqldate=objcommon.changeStringtoSqlDate(date);
				sqltest+=" and m.date='"+sqldate+"'";
			}
			
			strsql="select m.chklumsum,round(m.lumsumamount,2) lumsumamount,m.doc_no,m.voc_no,m.date,round(m.servicestotal,2) servicestotal, round(m.servicesdiscount,2) servicesdiscount, round(m.netservices,2) netservices,"+
			" convert(concat(coalesce(brd.brand_name,''),' ',coalesce(model.vtype,''),' ',coalesce(yom.yom,''),' Others: ',"+
			" coalesce(gate.vehother,'')),char(200)) vehicledetails,gate.doc_no gatedocno,gate.voc_no gatevocno,gate.cldocno,gate.regno,ac.refname,"+
			" concat(ac.refname,' , Address: ',ac.address,' , Telephone: ',ac.per_tel,' , Mobile: ',ac.per_mob,' , Mail: ',ac.mail1,"+
			" ' , Contact Person ',ac.contactperson) userdetails from ws_estm m left join ws_gateinpass gate on m.gipno=gate.doc_no left join"+
			" my_acbook ac on (gate.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_vehplate plate on gate.pltid=plate.doc_no left join"+
			" gl_vehbrand brd on gate.brdid=brd.doc_no left join gl_vehmodel model on gate.modid=model.doc_no left join gl_yom yom on"+
			" gate.yom=yom.doc_no where m.status=3"+sqltest;
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
	public ClsWSEstimationNewBean viewdetails(int docno,int vocno) throws SQLException
	{
		ClsWSEstimationNewBean been=new ClsWSEstimationNewBean();
		Connection conn=null;
		
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			
			String strsql="";
			String sqltest="";
			
			
			strsql="select m.chklumsum,round(m.lumsumamount,2) lumsumamount,m.doc_no,m.voc_no,m.date,round(m.servicestotal,2) servicestotal, round(m.servicesdiscount,2) servicesdiscount, round(m.netservices,2) netservices,"+
			" convert(concat(coalesce(brd.brand_name,''),' ',coalesce(model.vtype,''),' ',coalesce(yom.yom,''),' Others: ',"+
			" coalesce(gate.vehother,'')),char(200)) vehicledetails,gate.doc_no gatedocno,gate.voc_no gatevocno,gate.cldocno,gate.regno,ac.refname,"+
			" concat(ac.refname,' , Address: ',ac.address,' , Telephone: ',ac.per_tel,' , Mobile: ',ac.per_mob,' , Mail: ',ac.mail1,"+
			" ' , Contact Person ',ac.contactperson) userdetails from ws_estm m left join ws_gateinpass gate on m.gipno=gate.doc_no left join"+
			" my_acbook ac on (gate.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_vehplate plate on gate.pltid=plate.doc_no left join"+
			" gl_vehbrand brd on gate.brdid=brd.doc_no left join gl_vehmodel model on gate.modid=model.doc_no left join gl_yom yom on"+
			" gate.yom=yom.doc_no where m.status=3 and m.doc_no="+docno;
			ResultSet rs=stmt.executeQuery(strsql);
			while(rs.next()) {
				been.setGateuserdetails(rs.getString("userdetails"));
				been.setGatedocno(rs.getString("gatevocno"));
				been.setVocno(rs.getString("voc_no"));
				been.setGatevehicledetails(rs.getString("vehicledetails"));
				been.setServicesdiscount("servicesdiscount");
				been.setNetservices("netservices");
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
