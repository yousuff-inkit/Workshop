package com.dashboard.workshop.vehiclehistoryv3;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DecimalFormat;

import javax.servlet.http.HttpServletRequest;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.dashboard.workshop.vehiclehistorypal.ClsVehicleHistoryBean;

import net.sf.json.JSONArray;

public class ClsVehicleHistoryV3DAO {
	
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	
	public JSONArray getDetailNewGridData(String regno,String pltid,String fromdate,String todate,String id)throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			java.sql.Date sqlfromdate=null,sqltodate=null;
			if(!fromdate.equalsIgnoreCase("") && fromdate!=null){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
			}
			if(!todate.equalsIgnoreCase("") && todate!=null){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
			}
			String sqltest="";
			if(sqlfromdate!=null){
				sqltest+=" and gate.date>='"+sqlfromdate+"'";
			}
			if(sqltodate!=null){
				sqltest+=" and gate.date<='"+sqltodate+"'";
			}

			if(!((regno.equalsIgnoreCase("")) || (regno.equalsIgnoreCase("0")))){
                sqltest=sqltest+" and gate.regno='"+regno+"'";
            }
			
			if(!((pltid.equalsIgnoreCase("")) || (pltid.equalsIgnoreCase("0")))){
                sqltest=sqltest+" and gate.pltid='"+pltid+"'";
            }
			String strsql="select det.rowno, det.type, det.description, det.qty, det.rate, det.discount, det.amount, det.vatpercent, det.vatamount, det.netamount, det.serialno, det.estdocno, det.addition, det.jobdocno, det.invno from ws_investdetail det left join ws_estm est on det.estdocno=est.doc_no left join ws_gateinpass gate on gate.doc_no=est.gipno where 1=1 "+sqltest;
			System.out.println(strsql);
			ResultSet rs=conn.createStatement().executeQuery(strsql);
			data=objcommon.convertToJSON(rs);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return data;
	}
	
	public JSONArray getDetailLabourData(String regno,String pltid,String fromdate,String todate,String id)throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			java.sql.Date sqlfromdate=null,sqltodate=null;
			if(!fromdate.equalsIgnoreCase("") && fromdate!=null){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
			}
			if(!todate.equalsIgnoreCase("") && todate!=null){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
			}
			String sqltest="";
			if(sqlfromdate!=null){
				sqltest+=" and gate.date>='"+sqlfromdate+"'";
			}
			if(sqltodate!=null){
				sqltest+=" and gate.date<='"+sqltodate+"'";
			}

			if(!((regno.equalsIgnoreCase("")) || (regno.equalsIgnoreCase("0")))){
                sqltest=sqltest+" and gate.regno='"+regno+"'";
            }
			
			if(!((pltid.equalsIgnoreCase("")) || (pltid.equalsIgnoreCase("0")))){
                sqltest=sqltest+" and gate.pltid='"+pltid+"'";
            }
			String strsql="select coalesce(gate.kmin,0) mileage,job.voc_no jobvocno,job.date jobdate,det.rowno, det.type, det.description, det.qty, det.rate, det.discount, det.amount, det.vatpercent, det.vatamount, det.netamount, det.serialno, det.estdocno, det.addition, det.jobdocno, det.invno from ws_investdetail det left join ws_jobcard job on det.jobdocno=job.doc_no left join ws_estm est on det.estdocno=est.doc_no left join ws_gateinpass gate on gate.doc_no=est.gipno where det.type<>'Parts' "+sqltest;
			System.out.println(strsql);
			ResultSet rs=conn.createStatement().executeQuery(strsql);
			data=objcommon.convertToJSON(rs);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return data;
	}
	
	public JSONArray getDetailSpareData(String regno,String pltid,String fromdate,String todate,String id)throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			java.sql.Date sqlfromdate=null,sqltodate=null;
			if(!fromdate.equalsIgnoreCase("") && fromdate!=null){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
			}
			if(!todate.equalsIgnoreCase("") && todate!=null){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
			}
			String sqltest="";
			if(sqlfromdate!=null){
				sqltest+=" and gate.date>='"+sqlfromdate+"'";
			}
			if(sqltodate!=null){
				sqltest+=" and gate.date<='"+sqltodate+"'";
			}

			if(!((regno.equalsIgnoreCase("")) || (regno.equalsIgnoreCase("0")))){
                sqltest=sqltest+" and gate.regno='"+regno+"'";
            }
			
			if(!((pltid.equalsIgnoreCase("")) || (pltid.equalsIgnoreCase("0")))){
                sqltest=sqltest+" and gate.pltid='"+pltid+"'";
            }
			String strsql="select coalesce(gate.kmin,0) mileage,job.voc_no jobvocno,job.date jobdate,det.rowno, det.type, det.description, det.qty, det.rate, det.discount, det.amount, det.vatpercent, det.vatamount, det.netamount, det.serialno, det.estdocno, det.addition, det.jobdocno, det.invno from ws_investdetail det left join ws_jobcard job on det.jobdocno=job.doc_no left join ws_estm est on det.estdocno=est.doc_no left join ws_gateinpass gate on gate.doc_no=est.gipno where det.type='Parts' "+sqltest;
			System.out.println(strsql);
			ResultSet rs=conn.createStatement().executeQuery(strsql);
			data=objcommon.convertToJSON(rs);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return data;
	}
	
	public ClsVehicleHistoryV3Bean getPrint(HttpServletRequest request,String branch,String fromdate,String todate,
			String regno,String pltid,String cmbrepairtype) throws SQLException {
		ClsVehicleHistoryV3Bean bean = new ClsVehicleHistoryV3Bean();
		
		Connection conn = null;

	try {
		
		conn = objconn.getMyConnection();
		Statement stmtCollectionClosure = conn.createStatement();
		java.sql.Date sqlFromDate = null;
        java.sql.Date sqlToDate = null;
        
		String sqld="",sql="",sql1 = "",sql11 = "",sql2 = "",sql13 = "";
		
        if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
              sqlFromDate = objcommon.changeStringtoSqlDate(fromdate);
        }
        if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
              sqlToDate = objcommon.changeStringtoSqlDate(todate);
        }
		
		if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
			sqld+=" and r.brhId="+branch+"";
		}
		
		java.sql.Date sqlfromdate=null,sqltodate=null;
		if(!fromdate.equalsIgnoreCase("") && fromdate!=null){
			sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
		}
		if(!todate.equalsIgnoreCase("") && todate!=null){
			sqltodate=objcommon.changeStringtoSqlDate(todate);
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
		String partstr="select  coalesce(round(sum(netamount),2),0) totamt "
					+" from ws_gateinpass gate inner join ws_estm est on est.gipno=gate.doc_no "
					+" inner join ws_jobcard job on (job.reftype='EST' and job.refno=est.doc_no) "
					+" inner join ws_investdetail det on job.doc_no=det.jobdocno where det.type='Parts' and regno="+regno+" "+sqltest2+" group by regno";
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
		String servicestr=" select coalesce(round(sum(netamount),2),0) totamt from ws_gateinpass gate inner join ws_estm est on est.gipno=gate.doc_no "
						 +" left join ws_jobcard job on (job.reftype='EST' and job.refno=est.doc_no) inner join ws_investdetail det on job.doc_no=det.jobdocno where det.type<>'Parts' and regno="+regno+" "+sqltest2+" group by regno";
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
