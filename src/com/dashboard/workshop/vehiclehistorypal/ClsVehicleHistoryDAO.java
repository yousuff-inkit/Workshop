package com.dashboard.workshop.vehiclehistorypal;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DecimalFormat;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsVehicleHistoryDAO  {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();
	
	 public JSONArray regnodetails() throws SQLException {

	        JSONArray RESULTDATA=new JSONArray();
	        
	        Connection conn =null;
	        try {
				 conn = ClsConnection.getMyConnection();
				 Statement stmtVeh = conn.createStatement ();
				
				String sql="select distinct aa.regno,aa.pltid,brd.brand_name brand,model.vtype model,ac.refname,aa.mobile,aa.other,CONVERT(concat(' Client : ',coalesce(ac.refname,' '),' * ','Mobile No. : ' ,coalesce(aa.mobile,' '),' * ','Email. : ' ,coalesce(aa.email,' '),' * ','Chasis No. : ' ,coalesce(aa.other,' ')"
						+ " ),CHAR(1000)) clientinfo  from ws_gateinpass aa left join my_acbook ac on (aa.cldocno=ac.cldocno and dtype='CRM') left join gl_vehbrand brd on aa.brdid=brd.doc_no and brd.status=3 left join gl_vehmodel model on aa.modid=model.doc_no and model.status=3 ; ";
				System.out.println(sql);
				ResultSet resultSet = stmtVeh.executeQuery(sql);
	        	
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
	 			
				stmtVeh.close();
	 			conn.close();
	       
		} catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
	        finally{
	        	conn.close();
	        }
			//System.out.println(RESULTDATA);
	        return RESULTDATA;
	    }
		public JSONArray getServicesexcel(String regno,String pltid,String id,String fromdate,String todate) throws SQLException{
			JSONArray data=new JSONArray();
			if(!id.equalsIgnoreCase("1")){
				return data;
			}
		String sql1="";
			Connection conn=null;
			try{
				conn=ClsConnection.getMyConnection();
				Statement stmt=conn.createStatement();
				
				java.sql.Date sqlfromdate=null,sqltodate=null;
				if(!fromdate.equalsIgnoreCase("") && fromdate!=null){
					sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
				}
				if(!todate.equalsIgnoreCase("") && todate!=null){
					sqltodate=ClsCommon.changeStringtoSqlDate(todate);
				}
				String sqltest="";
				if(sqlfromdate!=null){
					sqltest+=" and ws.date>='"+sqlfromdate+"'";
				}
				if(sqltodate!=null){
					sqltest+=" and ws.date<='"+sqltodate+"'";
				}

				
				
				if(!((regno.equalsIgnoreCase("")) || (regno.equalsIgnoreCase("0")))){
	                sql1=sql1+" and ws.regno='"+regno+"'";
	            }
				
				if(!((pltid.equalsIgnoreCase("")) || (pltid.equalsIgnoreCase("0")))){
	                sql1=sql1+" and ws.pltid='"+pltid+"'";
	            }
				String strsql="select wj.doc_no Jobcard_No,wj.date Date,t.type Jobtype,m.desc1 Job_Description,coalesce(wsa.sal_name,'') 'Service Advisor',coalesce(tech.name,'') 'Technician' "+
						"  from ws_estlabour lab left join ws_jobmaster m on (lab.jobid=m.doc_no ) left join ws_jobtype t on m.jobid=t.doc_no "+
						"   left join ws_estm est on est.doc_no=lab.rdocno "
						+ " left join ws_jobcard wj on est.doc_no=wj.refno left join ws_gateinpass ws on ws.doc_no=est.gipno  left join my_salesman wsa on"+
						" (ws.serviceadvisor=wsa.doc_no and wsa.sal_code='WSA') left join ws_technician tech on (lab.technicianid=tech.doc_no) where m.status=3 and wj.complete=1 "+sqltest+" "+sql1+" order by wj.doc_no";
				System.out.println("12344"+strsql);
				//System.out.println("service2345678");
				ResultSet rs=stmt.executeQuery(strsql);
				data=ClsCommon.convertToEXCEL(rs);
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
			return data;
		}
		
		
		public JSONArray getServices(String regno,String pltid,String id,String fromdate,String todate) throws SQLException{
			JSONArray data=new JSONArray();
			if(!id.equalsIgnoreCase("1")){
				return data;
			}
		    String sql1="";
			Connection conn=null;
			try{
				conn=ClsConnection.getMyConnection();
				Statement stmt=conn.createStatement();
				
				java.sql.Date sqlfromdate=null,sqltodate=null;
				if(!fromdate.equalsIgnoreCase("") && fromdate!=null){
					sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
				}
				if(!todate.equalsIgnoreCase("") && todate!=null){
					sqltodate=ClsCommon.changeStringtoSqlDate(todate);
				}
				String sqltest="";
				if(sqlfromdate!=null){
					sqltest+=" and ws.date>='"+sqlfromdate+"'";
				}
				if(sqltodate!=null){
					sqltest+=" and ws.date<='"+sqltodate+"'";
				}

				
				
				if(!((regno.equalsIgnoreCase("")) || (regno.equalsIgnoreCase("0")))){
	                sql1=sql1+" and ws.regno='"+regno+"'";
	            }
				
				if(!((pltid.equalsIgnoreCase("")) || (pltid.equalsIgnoreCase("0")))){
	                sql1=sql1+" and ws.pltid='"+pltid+"'";
	            }
				String strsql="select wj.voc_no jobvocno,wj.doc_no jobno,wj.date jdate,strjobdesc jobdesc,m.doc_no,m.date,lab.hrs,lab.rate,strjobtype jobtype,lab.markupper markuppercent,lab.total,lab.remarks,"+
						" lab.jobid,coalesce(wsa.sal_name,'') serviceadvisor,coalesce(tech.name,'') technician from ws_estlabour lab left join ws_jobmaster m on (lab.jobid=m.doc_no ) left join ws_jobtype t on m.jobid=t.doc_no "+
						"   left join ws_estm est on est.doc_no=lab.rdocno "
						+ " left join ws_jobcard wj on est.doc_no=wj.refno left join ws_gateinpass ws on ws.doc_no=est.gipno "+
						" left join ws_estmadd esta on esta.doc_no=lab.rdocno and lab.addition=esta.addition left join my_salesman wsa on ((ws.serviceadvisor=wsa.doc_no or esta.serviceadvisor=wsa.doc_no)  and wsa.sal_TYPE='WSA')  "
						+ "left join ws_technician tech on (lab.technicianid=tech.doc_no)where m.status=3 and lab.chkcomplete=1 and wj.complete=1 "+sqltest+" "+sql1+" order by wj.doc_no";
				System.out.println("service====="+strsql);
				//System.out.println("service2345678");
				ResultSet rs=stmt.executeQuery(strsql);
				data=ClsCommon.convertToEXCEL(rs);
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
			return data;
		}
		public JSONArray productSearch(HttpSession session,String docnos,String prdid,String prdname,String load) throws SQLException {


			JSONArray RESULTDATA=new JSONArray();

			Connection conn = null;

			try {
				conn = ClsConnection.getMyConnection();
				Statement stmt = conn.createStatement();
				String sql1="";
			
				
				if(!((prdid.equalsIgnoreCase("")) || (prdid.equalsIgnoreCase("NA")))){
					sql1+=" and m.part_no like'%"+prdid+"%' ";
		 		}
				if(!((prdname.equalsIgnoreCase("")) || (prdname.equalsIgnoreCase("NA")))){
					sql1+=" and m.productname like '%"+prdname+"%' ";
		 		}
				
				if(load.equalsIgnoreCase("yes"))
						{
				
			 
					String sql="select  m.psrno doc_no,m.part_no prodcode,m.productname prodname,b.brand from my_main m inner join my_brand b on(m.brandid=b.doc_no) "
							+ "inner join my_catm c on(m.catid=c.doc_no)  where m.status=3 "+sql1+"";	    	
				/*String sql="select m.psrno doc_no,m.part_no prodcode,m.productname prodname,um.unit from my_main m left join my_brand b on(m.brandid=b.doc_no)"
						+ "left join my_catm c on(m.catid=c.doc_no) left join my_scatm s on(m.scatid=s.doc_no) left join my_desc de on(de.psrno=m.doc_no)    "
						+ " left join my_unit u on(u.psrno=m.psrno) left join my_unitm um on(um.doc_no=u.unit)  where m.status=3 "+sql1+ "group by m.doc_no  ";*/				
					System.out.println("==productSearch==="+sql);
				ResultSet resultSet = stmt.executeQuery(sql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
						}

			}catch(Exception e){
				e.printStackTrace();

			}finally{
				conn.close();
			}
			return RESULTDATA;
		}
		public JSONArray getSparepartsDataexcel(String regno,String pltid,String id,String fromdate,String todate)throws SQLException{
			JSONArray data=new JSONArray();
			if(!id.equalsIgnoreCase("1")){
				return data;
			}
			String sql1="";
			Connection conn=null;
			try{
				conn=ClsConnection.getMyConnection();
				Statement stmt=conn.createStatement();
				
				java.sql.Date sqlfromdate=null,sqltodate=null;
				if(!fromdate.equalsIgnoreCase("") && fromdate!=null){
					sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
				}
				if(!todate.equalsIgnoreCase("") && todate!=null){
					sqltodate=ClsCommon.changeStringtoSqlDate(todate);
				}
				String sqltest="";
				if(sqlfromdate!=null){
					sqltest+=" and ws.date>='"+sqlfromdate+"'";
				}
				if(sqltodate!=null){
					sqltest+=" and ws.date<='"+sqltodate+"'";
				}
				if(!((regno.equalsIgnoreCase("")) || (regno.equalsIgnoreCase("0")))){
					sqltest+=" and ws.regno='"+regno+"'";
	            }
				
				if(!((pltid.equalsIgnoreCase("")) || (pltid.equalsIgnoreCase("0")))){
					sqltest+=" and ws.pltid='"+pltid+"'";
	            }
				
			/*	String strsql="select * from ( select wj.doc_no jobno,wj.date jdate,spare.qty,spare.rate,spare.markupper markuppercent,spare.total,spare.remarks,bd.brandname brand,bd.doc_no brdid,m.psrno partdocno,m.part_no partno,m.productname description,m.doc_no,u.unit,m.munit as unitdocno,m.psrno,sum(i.out_qty)"+
				" outqty,coalesce(sum(i.op_qty-(i.out_qty+i.del_qty+i.rsv_qty)),0) as stock,sum(i.op_qty) as totqty,i.stockid as stkid,i.cost_price unitprice"+
				" from ws_estspare spare left join my_main m on spare.psrno=m.psrno left join my_unitm u on m.munit=u.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd"+
				" on m.brandid=bd.doc_no left join my_prddin i on(i.psrno=m.psrno and i.prdid=m.doc_no and i.specno=at.mspecno)"+
				" left join  ws_estm est on est.doc_no=spare.rdocno"
				+ " left join ws_jobcard wj on est.doc_no=wj.refno left join ws_gateinpass ws on ws.doc_no=est.gipno where m.status=3 "+sql1+" "+sqltest+" group by i.prdid  order by i.date) a";*/
				
				//String strsql="select wj.doc_no Jobcard_No,wj.date Date,m.productname Description,gis.qty Qty from ws_gateinpass ws inner join ws_estm spare on ws.doc_no=spare.gipno inner join ws_jobcard wj on spare.doc_no=wj.refno and reftype='est' inner join (SELECT COSTDOCNO JCNO,d.PSRNO,SUM(d.QTY-d.out_qty) qty   FROM MY_gisM M left JOIN MY_gisd D ON M.DOC_NO=D.RDOCNO where costtype=9  and costdocno!=0 group by costdocno,psrno) gis on gis.JCNO=wj.doc_no left join my_main m on m.psrno=gis.psrno where m.status=3 and wj.complete=1 "+sql1+" "+sqltest+" order by wj.doc_no";
				
				String strsql="select wj.voc_no Jobcard_no,wj.date Date,m.productname description,qty"
						+" from ws_gateinpass ws inner join ws_estm spare on ws.doc_no=spare.gipno "
						+" inner join ws_jobcard wj on spare.doc_no=wj.refno and reftype='est' "
						+" inner join ws_jccspare sp on wj.doc_no=sp.jobcarddocno"
						+" inner join my_main m on m.psrno=sp.psrno"
						+" where regno="+regno+" "+sqltest+"";
				
				System.out.println("Spare Parts: "+strsql);
				ResultSet rs=stmt.executeQuery(strsql);
				data=ClsCommon.convertToEXCEL(rs);
				conn.close();
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
		
		
		public JSONArray getSparepartsData(String regno,String pltid,String id,String fromdate,String todate,String psrno)throws SQLException{
			JSONArray data=new JSONArray();
			if(!id.equalsIgnoreCase("1")){
				return data;
			}
			String sql1="";
			Connection conn=null;
			try{
				conn=ClsConnection.getMyConnection();
				Statement stmt=conn.createStatement();
				
				java.sql.Date sqlfromdate=null,sqltodate=null;
				if(!fromdate.equalsIgnoreCase("") && fromdate!=null){
					sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
				}
				if(!todate.equalsIgnoreCase("") && todate!=null){
					sqltodate=ClsCommon.changeStringtoSqlDate(todate);
				}
				String sqltest="",sqltest2="";
				if(sqlfromdate!=null){
					sqltest+=" and ws.date>='"+sqlfromdate+"'";
				}
				if(sqltodate!=null){
					sqltest+=" and ws.date<='"+sqltodate+"'";
				}
				if(!((regno.equalsIgnoreCase("")) || (regno.equalsIgnoreCase("0")))){
					sqltest+=" and ws.regno='"+regno+"'";
	            }
				
				if(!((pltid.equalsIgnoreCase("")) || (pltid.equalsIgnoreCase("0")))){
					sqltest+=" and ws.pltid='"+pltid+"'";
	            }
				/*if((!(psrno.equalsIgnoreCase("NA")) )&&(!(psrno.equalsIgnoreCase("")))){
		    		sqltest2+=" and m.doc_no='"+psrno+"'";
		 		}*/
			/*	String strsql="select * from ( select wj.doc_no jobno,wj.date jdate,spare.qty,spare.rate,spare.markupper markuppercent,spare.total,spare.remarks,bd.brandname brand,bd.doc_no brdid,m.psrno partdocno,m.part_no partno,m.productname description,m.doc_no,u.unit,m.munit as unitdocno,m.psrno,sum(i.out_qty)"+
				" outqty,coalesce(sum(i.op_qty-(i.out_qty+i.del_qty+i.rsv_qty)),0) as stock,sum(i.op_qty) as totqty,i.stockid as stkid,i.cost_price unitprice"+
				" from ws_estspare spare left join my_main m on spare.psrno=m.psrno left join my_unitm u on m.munit=u.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd"+
				" on m.brandid=bd.doc_no left join my_prddin i on(i.psrno=m.psrno and i.prdid=m.doc_no and i.specno=at.mspecno)"+
				" left join  ws_estm est on est.doc_no=spare.rdocno"
				+ " left join ws_jobcard wj on est.doc_no=wj.refno left join ws_gateinpass ws on ws.doc_no=est.gipno where m.status=3 "+sql1+" "+sqltest+" group by i.prdid  order by i.date) a";*/
				//Overriding Inner join with main for Alice Workshop
				int aliceconfig=0;
				String vehsql="select coalesce(method,0) method from gl_config where field_nme='alicevehiclehistoryprint'";
			    ResultSet rs4 = stmt.executeQuery(vehsql);
			    while(rs4.next()){ 
			    	aliceconfig=rs4.getInt("method");
				}
			    String strjoin="";
			    if(aliceconfig==1){
			    	strjoin="left";
			    }
			    else{
			    	strjoin="inner";
			    }
				String strsql="select wj.voc_no jono,wj.date jdate,if(coalesce(m.productname,'')='',sp.description,m.productname) description,qty,ws.kmin"
							+" from ws_gateinpass ws inner join ws_estm spare on ws.doc_no=spare.gipno "
							+" inner join ws_jobcard wj on spare.doc_no=wj.refno and reftype='est' "
							+" inner join ws_jccspare sp on wj.doc_no=sp.jobcarddocno"
							+" "+strjoin+" join my_main m on m.psrno=sp.psrno"
							+" where regno="+regno+" and sp.chkcomplete=1 "+sqltest+" union all"+
				" select job.voc_no jono,job.date jdate,d.desc1 description,d.qty,ws.kmin from my_srvpurm m left join my_srvpurd d on m.doc_no=d.rdocno left join ws_jobcard job on (d.costtype=9 and d.costcode=job.doc_no)"+
				" left join ws_estm est on (job.refno=est.doc_no and job.reftype='EST')"+
				" left join ws_gateinpass ws on est.gipno=ws.doc_no where d.costtype=9 and ws.regno="+regno+" "+sqltest;
				
				
				//String strsql="select m.productname description,wj.doc_no jono,wj.date jdate,gis.qty from ws_gateinpass ws inner join ws_estm spare on ws.doc_no=spare.gipno inner join ws_jobcard wj on spare.doc_no=wj.refno and reftype='est' inner join (SELECT COSTDOCNO JCNO,d.PSRNO,SUM(d.QTY-d.out_qty) qty   FROM MY_gisM M left JOIN MY_gisd D ON M.DOC_NO=D.RDOCNO where costtype=9  and costdocno!=0 group by costdocno,psrno) gis on gis.JCNO=wj.doc_no left join my_main m on m.psrno=gis.psrno where m.status=3 and wj.complete=1 "+sql1+" "+sqltest+" order by wj.doc_no";
				System.out.println("Spare Parts: "+strsql);
				ResultSet rs=stmt.executeQuery(strsql);
				data=ClsCommon.convertToEXCEL(rs);
				conn.close();
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
		
		
		
		
		public ClsVehicleHistoryBean getPrint(HttpServletRequest request,String branch,String fromdate,String todate,
				String regno,String pltid,String cmbrepairtype) throws SQLException {
			ClsVehicleHistoryBean bean = new ClsVehicleHistoryBean();
			
			Connection conn = null;

		try {
			
			conn = ClsConnection.getMyConnection();
			Statement stmtCollectionClosure = conn.createStatement();
			java.sql.Date sqlFromDate = null;
	        java.sql.Date sqlToDate = null;
	        
			String sqld="",sql="",sql1 = "",sql11 = "",sql2 = "",sql13 = "";
			
	        if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
	              sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
	        }
	        if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
	              sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
	        }
			
			if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
				sqld+=" and r.brhId="+branch+"";
			}
			
			java.sql.Date sqlfromdate=null,sqltodate=null;
			if(!fromdate.equalsIgnoreCase("") && fromdate!=null){
				sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
			}
			if(!todate.equalsIgnoreCase("") && todate!=null){
				sqltodate=ClsCommon.changeStringtoSqlDate(todate);
			}
			String sqltest="";
			if(sqlfromdate!=null){
				sqltest+=" and ws.date>='"+sqlfromdate+"'";
			}
			if(sqltodate!=null){
				sqltest+=" and ws.date<='"+sqltodate+"'";
			}
			
			String sqltest2="";
			if(sqlFromDate!=null){
				sqltest2+=" and gate.date>='"+sqlFromDate+"'";
			}
			if(sqlFromDate!=null){
				sqltest2+=" and gate.date<='"+sqlToDate+"'";
			}

			
			
			if(!((regno.equalsIgnoreCase("")) || (regno.equalsIgnoreCase("0")))){
                sql1=sql1+" and ws.regno='"+regno+"'";
            }
			
			if(!((pltid.equalsIgnoreCase("")) || (pltid.equalsIgnoreCase("0")))){
                sql1=sql1+" and ws.pltid='"+pltid+"'";
            }
			if(!cmbrepairtype.equalsIgnoreCase("")){
				sqltest2+=" and gate.repairtype='"+cmbrepairtype+"'";
				sql1=sql1+" and ws.repairtype='"+cmbrepairtype+"'";
			}
			sql="select 'Vehicle History' vouchername,CONCAT('From ',DATE_FORMAT('"+sqlFromDate+"','%D %M  %Y '),'  To  ',DATE_FORMAT('"+sqlToDate+"','%D %M  %Y ')) vouchername1,"
				+ "c.company,c.address,c.tel,c.fax,lc.loc_name location,b.branchname,b.pbno,b.stcno,b.cstno from ws_gateinpass r inner join my_brch b on r.brhid=b.doc_no inner join my_comp c "
				+ "on b.cmpid=c.doc_no inner join my_locm l on l.brhid=b.doc_no inner join (select min(lo.loc) loc,lo.loc_name,lo.brhid from my_locm lo group by brhid) as lc "
				+ "on(lc.loc=l.loc and lc.brhid=b.doc_no) where 1=1 "+sqld+" group by r.brhid";
			
			ResultSet resultSet = stmtCollectionClosure.executeQuery(sql);
			
			while(resultSet.next()){
				bean.setLblcompname(resultSet.getString("company"));
				bean.setLblcompaddress(resultSet.getString("address"));
				bean.setLblprintname(resultSet.getString("vouchername"));
				bean.setLblprintname1(resultSet.getString("vouchername1"));
				bean.setLblcomptel(resultSet.getString("tel"));
				bean.setLblcompfax(resultSet.getString("fax"));
				bean.setLblbranch(resultSet.getString("branchname"));
				bean.setLbllocation(resultSet.getString("location"));
				bean.setLblcstno(resultSet.getString("cstno"));
				bean.setLblpan(resultSet.getString("pbno"));
				bean.setLblservicetax(resultSet.getString("stcno"));
			}
			
			/*sql11 = "select a.*,@i:=@i+1 srno from (select wj.doc_no jobno,DATE_FORMAT(wj.date,'%d-%m-%Y ') jdate,m.desc1 jobdesc,m.doc_no,m.date,lab.hrs,lab.rate,t.type jobtype,lab.markupper markuppercent,lab.total,lab.remarks,"+
					" lab.jobid from ws_estlabour lab left join ws_jobmaster m on (lab.jobid=m.doc_no ) left join ws_jobtype t on m.jobid=t.doc_no "+
					"   left join ws_estm est on est.doc_no=lab.rdocno "
					+ " left join ws_jobcard wj on est.doc_no=wj.refno left join ws_gateinpass ws on ws.doc_no=est.gipno where m.status=3 and wj.complete=1 "+sqltest+" "+sql1+" order by wj.doc_no) a,(select @i:=0) as i";
			
			System.out.println("12345"+sql11);
			ResultSet resultSet1 = stmtCollectionClosure.executeQuery(sql11);
			
			ArrayList<String> printarray= new ArrayList<String>();
			
			while(resultSet1.next()){

				String temp="";
				temp=resultSet1.getString("srno")+"::"+resultSet1.getString("jobno")+"::"+resultSet1.getString("jdate")+"::"+resultSet1.getString("jobtype")+"::"+resultSet1.getString("jobdesc");
			    printarray.add(temp);
			}
			request.setAttribute("printingarray", printarray);
			
			
			
			sql13 = "select a.*,@i:=@i+1 srno from (select m.productname description,wj.doc_no jono,DATE_FORMAT(wj.date,'%d-%m-%Y ') jdate,"
					+ " gis.qty from ws_gateinpass ws inner join ws_estm spare on ws.doc_no=spare.gipno "
					+ " inner join ws_jobcard wj on spare.doc_no=wj.refno and reftype='est' "
					+ " inner join (SELECT COSTDOCNO JCNO,d.PSRNO,SUM(d.QTY-d.out_qty) qty   "
					+ " FROM MY_gisM M left JOIN MY_gisd D ON M.DOC_NO=D.RDOCNO where costtype=9  "
					+ " and costdocno!=0 group by costdocno,psrno) gis on gis.JCNO=wj.doc_no left join my_main m on m.psrno=gis.psrno "
					+ " where m.status=3 and wj.complete=1 "+sql1+" "+sqltest+" order by wj.doc_no) a,(select @i:=0) as i";
			System.out.println("qwert"+sql13);
			ResultSet resultSet4 = stmtCollectionClosure.executeQuery(sql13);
			
			ArrayList<String> printarray1= new ArrayList<String>();
			
			while(resultSet4.next()){

				String temp1="";
				temp1=resultSet4.getString("srno")+"::"+resultSet4.getString("jono")+"::"+resultSet4.getString("jdate")+"::"+resultSet4.getString("description")+"::"+resultSet4.getString("qty");
			    printarray1.add(temp1);
			}
			request.setAttribute("printingarray2", printarray1);*/
			
			
			sql2 = "select distinct ws.regno,ws.pltid,ac.refname,ac.address,ac.per_mob,ac.mail1,ws.mobile,ws.other chasis,vb.brand_name,om.yom,vm.vtype"
						+ "   from ws_gateinpass ws left join my_acbook ac on (ws.cldocno=ac.cldocno and dtype='CRM')"
						+ "  left join gl_vehbrand vb on ws.brdid=vb.doc_no left join gl_yom om on om.doc_no=ws.yom left join gl_vehmodel vm on vm.doc_no=ws.modid"
						+ " where 1=1 "+sql1+"";
			System.out.println("client"+sql2);
			ResultSet resultSet5 = stmtCollectionClosure.executeQuery(sql2);
			
			
			while(resultSet5.next()){
				bean.setLblcustname(resultSet5.getString("refname"));
				bean.setLblAddress(resultSet5.getString("address"));
				bean.setLblphone(resultSet5.getString("per_mob"));
				bean.setLblemail(resultSet5.getString("mail1"));
				bean.setLblregno(resultSet5.getString("regno"));
				bean.setLblchassis(resultSet5.getString("chasis"));
				bean.setLblbrand(resultSet5.getString("brand_name"));
				bean.setLblmodel(resultSet5.getString("vtype"));
				bean.setLblyom(resultSet5.getString("yom"));
				
			}
			stmtCollectionClosure.close();
			DecimalFormat df = new DecimalFormat("###,##0.00");
			double totamt1=0.0,totamt2=0.0,grandtotal=0.0;
			Statement stmt1=conn.createStatement();
			String partstr="select  coalesce(round(sum(customeramt),2),0) totamt "
						+" from ws_gateinpass gate inner join ws_estm est on est.gipno=gate.doc_no "
						+" inner join ws_jobcard job on (job.reftype='EST' and job.refno=est.doc_no) "
						+" inner join ws_jccspare sp on job.doc_no=sp.jobcarddocno where regno="+regno+" "+sqltest2+" group by regno";
			System.out.println("Parts Total Query: "+partstr);
			ResultSet partsrs=stmt1.executeQuery(partstr);
			
			while(partsrs.next()){
				bean.setPartstotal(df.format(partsrs.getDouble("totamt")));
				totamt1=partsrs.getDouble("totamt");
			}
			//stmt1.close();
			//Getting NI Purchase Total-PAL-31-08-2021
			partstr="select round(sum(d.nettaxamount),2) amt from my_srvpurm m left join my_srvpurd d on"+
			" m.doc_no=d.rdocno left join ws_jobcard job on (d.costtype=9 and d.costcode=job.doc_no) left join ws_estm est on"+
			" job.refno=est.doc_no and job.reftype='EST'  left join ws_gateinpass gate on est.gipno=gate.doc_no"+
			" where d.costtype=9 and regno="+regno+" "+sqltest2+" group by regno";
			System.out.println("Parts Total Query: "+partstr);
			ResultSet rsnipur=stmt1.executeQuery(partstr);
			
			while(rsnipur.next()){
				totamt1+=rsnipur.getDouble("amt");
				bean.setPartstotal(df.format(totamt1));
			}
			
			
			Statement stmt2=conn.createStatement();
			String servicestr=" select coalesce(round(sum(invoiceamt),2),0) totamt from ws_gateinpass gate inner join ws_estm est on est.gipno=gate.doc_no "
							 +" left join ws_jobcard job on (job.reftype='EST' and job.refno=est.doc_no) inner join ws_estlabour lab on est.doc_no=lab.rdocno "
							 +" left join ws_jobmaster jm on jm.doc_no=lab.jobid left join ws_jobtype jt on jt.doc_no=jm.jobid where regno="+regno+" "+sqltest2+" group by regno";
			System.out.println("Labour Total Query: "+servicestr);
			ResultSet servicers=stmt2.executeQuery(servicestr);
			while(servicers.next()){
				bean.setServicetotal(df.format(servicers.getDouble("totamt")));
				totamt2=servicers.getDouble("totamt");
			}
			grandtotal=totamt1+totamt2;
			System.out.println("totalaaa"+totamt1+":"+totamt2+":"+grandtotal);
			bean.setGrandtotal(grandtotal);
			stmt2.close();
			
			conn.close();
		} catch(Exception e){
			 e.printStackTrace();
			 conn.close();
		} finally{
			conn.close();
		}
		return bean;
	   }
		
		
}
