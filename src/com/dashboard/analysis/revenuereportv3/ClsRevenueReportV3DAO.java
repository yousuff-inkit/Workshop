package com.dashboard.analysis.revenuereportv3;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsRevenueReportV3DAO {
	ClsConnection ClsConnection = new ClsConnection();
	ClsCommon ClsCommon = new ClsCommon();

	public JSONArray clientSearch(String branch, String clname, String mob, String lcno, String passno, String nation,
			String dob) throws SQLException {
		JSONArray RESULTDATA = new JSONArray();
		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmtClientAnalysis = conn.createStatement();

			java.sql.Date sqlStartDate = null;

			dob.trim();
			if (!(dob.equalsIgnoreCase("undefined")) && !(dob.equalsIgnoreCase("")) && !(dob.equalsIgnoreCase("0"))) {
				sqlStartDate = ClsCommon.changeStringtoSqlDate(dob);
			}

			String sqltest = "";

			if (!(clname.equalsIgnoreCase(""))) {
				sqltest = sqltest + " and a.RefName like '%" + clname + "%'";
			}
			if (!(mob.equalsIgnoreCase(""))) {
				sqltest = sqltest + " and a.per_mob='%" + mob + "%'";
			}
			if (!(lcno.equalsIgnoreCase(""))) {
				sqltest = sqltest + " and d.dlno='%" + lcno + "%'";
			}
			if (!(passno.equalsIgnoreCase(""))) {
				sqltest = sqltest + " and d.passport_no='%" + passno + "%'";
			}
			if (!(nation.equalsIgnoreCase(""))) {
				sqltest = sqltest + " and d.nation like'%" + nation + "%'";
			}
			if (!(sqlStartDate == null)) {
				sqltest = sqltest + " and d.dob='" + sqlStartDate + "'";
			}

			String clsql = "select distinct a.cldocno,coalesce(d.nation,'') nation,d.dob,coalesce(d.dlno,'') dlno,trim(a.RefName) RefName,"
					+ " coalesce(a.per_mob,'')per_mob,coalesce(trim(a.address),'') address,a.codeno,a.acno,m.doc_no,coalesce(trim(m.sal_name),'') sal_name "
					+ " from my_acbook a left join my_salm m on a.sal_id=m.doc_no and m.status<>7 left join gl_drdetails d on d.cldocno=a.cldocno where a.dtype='CRM' and a.status=3"
					+ sqltest;

			ResultSet resultSet = stmtClientAnalysis.executeQuery(clsql);
			RESULTDATA = ClsCommon.convertToJSON(resultSet);

			stmtClientAnalysis.close();
			conn.close();

		} catch (Exception e) {
			e.printStackTrace();
			conn.close();
		} finally {
			conn.close();
		}

		return RESULTDATA;
	}

	public JSONArray clientSalesManSearch() throws SQLException {
		JSONArray RESULTDATA = new JSONArray();
		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmtClientAnalysis = conn.createStatement();

			String strSql = "select doc_no,sal_name clientslmname from my_salm where status=3";

			ResultSet resultSet = stmtClientAnalysis.executeQuery(strSql);
			RESULTDATA = ClsCommon.convertToJSON(resultSet);

			stmtClientAnalysis.close();
			conn.close();

			return RESULTDATA;

		} catch (Exception e) {
			e.printStackTrace();
			conn.close();
		} finally {
			conn.close();
		}

		return RESULTDATA;
	}

	public JSONArray repairTypeSearch() throws SQLException {
		JSONArray RESULTDATA = new JSONArray();
		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmtClientAnalysis = conn.createStatement();

			String strSql = "select name rtname,row_no docno from  ws_gartype";

			ResultSet resultSet = stmtClientAnalysis.executeQuery(strSql);
			RESULTDATA = ClsCommon.convertToJSON(resultSet);

			stmtClientAnalysis.close();
			conn.close();

			return RESULTDATA;

		} catch (Exception e) {
			e.printStackTrace();
			conn.close();
		} finally {
			conn.close();
		}

		return RESULTDATA;
	}

	public JSONArray getDetailData(String fromdate, String todate, String hidclient, String hidclientslm,
			String hidrepairtype, String id, String hidserviceadvisor) throws SQLException {
		JSONArray RESULTDATA = new JSONArray();
		Connection conn = null;
		if (!id.equalsIgnoreCase("1")) {
			return RESULTDATA;
		}

		String sqltest = "";
		java.sql.Date sqlfromdate = null, sqltodate = null;
		if (!fromdate.equalsIgnoreCase("") && fromdate != null) {
			sqlfromdate = ClsCommon.changeStringtoSqlDate(fromdate);
		}
		if (!todate.equalsIgnoreCase("") && todate != null) {
			sqltodate = ClsCommon.changeStringtoSqlDate(todate);
		}

		if (!hidclient.equalsIgnoreCase("")) {
			sqltest += " and ac.cldocno in (" + hidclient + ")";
		}
		if (!hidclientslm.equalsIgnoreCase("")) {
			sqltest += " and slm.doc_no in (" + hidclientslm + ")";
		}
		if (!hidrepairtype.equalsIgnoreCase("")) {
			sqltest += " and rtype.row_no in (" + hidrepairtype + ")";
		}
		if (!hidserviceadvisor.equalsIgnoreCase("")) {
			sqltest += " and gate.serviceadvisor in (" + hidserviceadvisor + ")";
		}

		try {
			conn = ClsConnection.getMyConnection();
			Statement detailstmt = conn.createStatement();

			String strSql = "select round(coalesce(lab.labtot,0),2) invlabourtotal,round(coalesce(sp.sparestot,0),2) invsparetotal,"
					+ "case when coalesce(est.chkrandomlumsum,0)=1 then est.randomlumsumamt else if(est.chkservicelumsum=0,coalesce(lab.labourtotal,0),coalesce(est.servicelumsumamt,0))+ if(est.chklumsum=0,coalesce(amtspare.amt,0),coalesce(est.lumsumamount,0)) end estnettotal,"
					+ "if(est.chkservicelumsum=0,coalesce(lab.labourtotal,0),coalesce(est.servicelumsumamt,0)) estlabourtotal,if(est.chklumsum=0,coalesce(amtspare.amt,0),coalesce(est.lumsumamount,0)) estsparetotal,wrb.sal_name referredby,ins.sal_name insursurveyor,round(coalesce(invm.nettotal,0.0)-coalesce(srv.nispareamt,0.0)-coalesce(lub.spramt,0.0)-coalesce(cns.spramt,0.0),2)-coalesce(oth.spramt,0) net,coalesce(spare.sparetotal,0.0) estapprvalue,convert(if(estadd.estaddition is not null, concat(est.voc_no,'-', estadd.estaddition),est.voc_no),char(100)) estall,coalesce(spare.sparetotal,0.0)+coalesce(labour.labourtotal,0.0) esttotalvalue,convert(lbr.estdocno,char(100)) estno,coalesce(lbr.esttotal,0) esttotal,srv.nispareamt actualspare,sm1.sal_name serviceadvisor,sm.sal_name estimator,cl.category clcategory,invm.date,invm.voc_no invoiceno,job.voc_no jobno,invm.nettotal totalinv,invm.clienttotal,invm.excesstotal,ac.refname client,"
					+ " concat(gate.regno,'-',gate.pltid) regno,usr.user_name,rtype.name repairtype,"
					+ " coalesce(invm.nettotal,0)-coalesce(lbr.spramt,0) labour,coalesce(spr.spramt,0) "
					+ " spares,coalesce(lub.spramt,0) lubricants,coalesce(cns.spramt,0) consumables,coalesce(oth.spramt,0) others,slm.sal_name salesman,"
					+ " h.description account from ws_jobcard job inner join (select reftype,date,convert(group_concat(voc_no SEPARATOR ' ,'),char(50)) voc_no,refno,sum(nettotal) nettotal,sum(coalesce(nettotal,0))-coalesce(excess,0) clienttotal, coalesce(excess,0) excesstotal from ws_invm where date between '"
					+ sqlfromdate + "' and '" + sqltodate + "' and status<>7 "
					+ " group by refno) invm on (job.doc_no=invm.refno and invm.reftype='JC') left join my_user usr on job.userid=usr.doc_no"
					+ " left join (select jobcarddocno,sum(coalesce(customeramt,0)) spramt, estdocno,sum(coalesce(esttotal,0)) esttotal from ws_jccspare  group by jobcarddocno) lbr on lbr.jobcarddocno=job.doc_no"
					+ " left join (select jobcarddocno,sum(coalesce(customeramt,0)) spramt from ws_jccspare jcs left join my_main mm on jcs.psrno=mm.psrno where mm.catid=1 group by jobcarddocno) spr on spr.jobcarddocno=job.doc_no"
					+ " left join (select jobcarddocno,sum(coalesce(customeramt,0)) spramt from ws_jccspare jcs left join my_main mm on jcs.psrno=mm.psrno where mm.catid=2 group by jobcarddocno) lub on lub.jobcarddocno=job.doc_no"
					+ " left join (select jobcarddocno,sum(coalesce(customeramt,0)) spramt from ws_jccspare jcs left join my_main mm on jcs.psrno=mm.psrno where mm.catid=3 group by jobcarddocno) cns on cns.jobcarddocno=job.doc_no"
					+ " left join (select jobcarddocno,sum(coalesce(customeramt,0)) spramt from ws_jccspare jcs left join my_main mm on jcs.psrno=mm.psrno where mm.catid>3 group by jobcarddocno) oth on oth.jobcarddocno=job.doc_no"
					+ " left join ws_estm est on (job.reftype='EST' and job.refno=est.doc_no)"
					+ " left join ws_gateinpass gate on (if(job.reftype='GIP',job.refno=gate.doc_no,est.gipno=gate.doc_no))"
					+ " left join (select sum(approvedvalue) amt,rdocno from ws_estspare group by rdocno) amtspare on est.doc_no=amtspare.rdocno"
					+ " left join (select sum(coalesce(invoiceamt,0)) labtot,rdocno,sum(coalesce(total,0)) labourtotal from ws_estlabour group by rdocno ) lab on est.doc_no=lab.rdocno"
					+ " left join (select sum(coalesce(customeramt,0)) sparestot,jobcarddocno from ws_jccspare group by jobcarddocno ) sp on job.doc_no=sp.jobcarddocno"
					+ " left join my_acbook ac on (gate.cldocno=ac.cldocno and ac.dtype='CRM')"
					+ " left join my_acbook bac on (gate.insurcldocno=bac.cldocno and bac.dtype='CRM' and insurancecomp=1)"
					+ " left join my_head h on (bac.acno=h.doc_no)  left join my_salesman wrb on (gate.referencedby=wrb.doc_no and wrb.sal_type='WRB') "
					+ " left join my_salm slm on ac.sal_id=slm.doc_no"
					+ " left join ws_gartype rtype on gate.repairtype=rtype.row_no  left join my_clcatm cl on cl.doc_no=ac.catid left join my_salesman sm on (sm.doc_no=gate.marketingperson and sm.sal_type='WMP') left join my_salesman sm1 on (sm1.doc_no=gate.serviceadvisor and sm1.sal_type='WSA') left join my_salesman ins on (ins.doc_no=gate.insurancesurvivor and ins.sal_type='WIS') left join (select costcode,sum(nettotal) nispareamt from my_srvpurd srv left join my_srvpurm srvm on srv.rdocno=srvm.doc_no  where costtype=9 and srvm.status!=7 group by costcode) srv on srv.costcode=job.doc_no "
					+ " left join (select  sum(approvedvalue) sparetotal,rdocno from  ws_estspare where confirmed=1 and "
					+ " approved=1 group by rdocno) spare on est.doc_no=spare.rdocno left join (select sum(total)  labourtotal, "
					+ " rdocno from  ws_estlabour  where confirmed=1 and approved=1 group by rdocno) labour on "
					+ " (est.doc_no=labour.rdocno) left join (select convert(group_concat(addition,'-'),char(100)) estaddition, "
					+ " jobcarddocno jobdocno from ws_estmadd where status=3 group by jobcarddocno) estadd on "
					+ " job.doc_no=estadd.jobdocno where 1=1 " + sqltest + " order by invm.voc_no";

			ResultSet resultSet = detailstmt.executeQuery(strSql);
			RESULTDATA = ClsCommon.convertToJSON(resultSet);

			detailstmt.close();
			conn.close();

			return RESULTDATA;

		} catch (Exception e) {
			e.printStackTrace();
			conn.close();
		} finally {
			conn.close();
		}

		return RESULTDATA;
	}

	public JSONArray getSummaryData(String fromdate, String todate, String hidclient, String hidclientslm,
			String hidrepairtype, String id, String sumtype, String hidserviceadvisor) throws SQLException {
		JSONArray RESULTDATA = new JSONArray();
		Connection conn = null;
		if (!id.equalsIgnoreCase("1")) {
			return RESULTDATA;
		}

		String sqltest = "";
		String sqlselect = "";
		String sqlgroup = "";
		java.sql.Date sqlfromdate = null, sqltodate = null;

		if (!fromdate.equalsIgnoreCase("") && fromdate != null) {
			sqlfromdate = ClsCommon.changeStringtoSqlDate(fromdate);
		}
		if (!todate.equalsIgnoreCase("") && todate != null) {
			sqltodate = ClsCommon.changeStringtoSqlDate(todate);
		}

		if (!hidclient.equalsIgnoreCase("")) {
			sqltest += " and ac.cldocno in (" + hidclient + ")";
		}
		if (!hidclientslm.equalsIgnoreCase("")) {
			sqltest += " and slm.doc_no in (" + hidclientslm + ")";
		}
		if (!hidrepairtype.equalsIgnoreCase("")) {
			sqltest += " and rtype.row_no in (" + hidrepairtype + ")";
		}
		if (!hidserviceadvisor.equalsIgnoreCase("")) {
			sqltest += " and gate.serviceadvisor in (" + hidserviceadvisor + ")";
		}

		if (sumtype.equalsIgnoreCase("clt")) {
			sqlselect = " cl.category,ac.cldocno,ac.refname,";
			sqlgroup = " group by ac.cldocno";
		} else if (sumtype.equalsIgnoreCase("sm")) {
			sqlselect = " slm.doc_no,slm.sal_name refname,";
			sqlgroup = " group by slm.doc_no";
		} else if (sumtype.equalsIgnoreCase("rt")) {
			sqlselect = " rtype.row_no,rtype.name refname,";
			sqlgroup = " group by rtype.row_no";
		} else if (sumtype.equalsIgnoreCase("wsa")) {
			sqlselect = " coalesce(wsa.sal_name) refname,";
			sqlgroup = " group by gate.serviceadvisor";
		} else if (sumtype.equalsIgnoreCase("dly")) {
			sqlselect = " invm.date refname,";
			sqlgroup = " group by invm.date";
		} else if (sumtype.equalsIgnoreCase("mly")) {
			sqlselect = " month(invm.date),CONVERT(concat(year(invm.date),'-',monthname(invm.date)),char) refname,";
			sqlgroup = " group by year(invm.date),month(invm.date)";
		} else if (sumtype.equalsIgnoreCase("yly")) {
			sqlselect = " year(invm.date) refname,";
			sqlgroup = " group by year(invm.date)";
		} else {
			sqlselect = "";
			sqlgroup = "";
		}

		try {
			conn = ClsConnection.getMyConnection();
			Statement detailstmt = conn.createStatement();

			/*
			 * String strSql="select "
			 * +sqlselect+"sum(invm.nettotal) totalinv,sum(invm.nettotal- lbr.spramt) labour,sum(spr.spramt) spares,sum(lub.spramt) lubricants,sum(cns.spramt) consumables,sum(oth.spramt) others"
			 * +" from ws_invm invm left join ws_jobcard job on (invm.reftype='JC' and invm.refno=job.doc_no)"
			 * +" left join (select jobcarddocno,sum(coalesce(customeramt,0)) spramt from ws_jccspare group by jobcarddocno) lbr on lbr.jobcarddocno=job.doc_no"
			 * +" left join (select jobcarddocno,sum(coalesce(customeramt,0)) spramt from ws_jccspare jcs left join my_main mm on jcs.psrno=mm.psrno where mm.catid=1 group by jobcarddocno) spr on spr.jobcarddocno=job.doc_no"
			 * +" left join (select jobcarddocno,sum(coalesce(customeramt,0)) spramt from ws_jccspare jcs left join my_main mm on jcs.psrno=mm.psrno where mm.catid=2 group by jobcarddocno) lub on lub.jobcarddocno=job.doc_no"
			 * +" left join (select jobcarddocno,sum(coalesce(customeramt,0)) spramt from ws_jccspare jcs left join my_main mm on jcs.psrno=mm.psrno where mm.catid=3 group by jobcarddocno) cns on cns.jobcarddocno=job.doc_no"
			 * +" left join (select jobcarddocno,sum(coalesce(customeramt,0)) spramt from ws_jccspare jcs left join my_main mm on jcs.psrno=mm.psrno where mm.catid>3 group by jobcarddocno) oth on oth.jobcarddocno=job.doc_no"
			 * +" left join ws_estm est on (job.reftype='EST' and job.refno=est.doc_no) left join ws_gateinpass gate on (if(job.reftype='GIP',job.refno=gate.doc_no,est.gipno=gate.doc_no))"
			 * +" left join my_acbook ac on (gate.cldocno=ac.cldocno and ac.dtype='CRM')"
			 * +" left join my_salm slm on ac.sal_id=slm.doc_no"
			 * +" left join ws_gartype rtype on gate.repairtype=rtype.row_no"
			 * +" where invm.date between '"+sqlfromdate+"' and '"+sqltodate+"'"+sqltest+
			 * sqlgroup;
			 */
//			if(sum(coalesce(invm.nettotal,0)- coalesce(lbr.spramt,0))<0,0,sum(coalesce(invm.nettotal,0)- coalesce(lbr.spramt,0))) labour
			String strSql = "select " + sqlselect
					+ "sum(coalesce(invm.nettotal,0)) totalinv,round(coalesce(lab.labtot,0),2) invlabourtotal,round(coalesce(sp.sparestot,0),2) invsparetotal,sum(coalesce(invm.nettotal,0)- coalesce(lbr.spramt,0)) labour,sum(coalesce(spr.spramt,0)) spares,sum(coalesce(lub.spramt,0)) lubricants,sum(coalesce(cns.spramt,0))"
					+ " consumables,sum(coalesce(oth.spramt,0)) others from ws_jobcard job inner join (select acno,reftype,date,voc_no,refno,sum(nettotal) nettotal from ws_invm where date between '"
					+ sqlfromdate + "' and '" + sqltodate
					+ "' and status<>7  group by refno,acno) invm on (job.doc_no=invm.refno and invm.reftype='JC')"
					+ " left join (select jobcarddocno,sum(coalesce(customeramt,0)) spramt from ws_jccspare group by jobcarddocno) lbr on lbr.jobcarddocno=job.doc_no"
					+ " left join (select jobcarddocno,sum(coalesce(customeramt,0)) spramt from ws_jccspare jcs left join my_main mm on jcs.psrno=mm.psrno where mm.catid=1 group by jobcarddocno) spr on spr.jobcarddocno=job.doc_no"
					+ " left join (select jobcarddocno,sum(coalesce(customeramt,0)) spramt from ws_jccspare jcs left join my_main mm on jcs.psrno=mm.psrno where mm.catid=2 group by jobcarddocno) lub on lub.jobcarddocno=job.doc_no"
					+ " left join (select jobcarddocno,sum(coalesce(customeramt,0)) spramt from ws_jccspare jcs left join my_main mm on jcs.psrno=mm.psrno where mm.catid=3 group by jobcarddocno) cns on cns.jobcarddocno=job.doc_no"
					+ " left join (select jobcarddocno,sum(coalesce(customeramt,0)) spramt from ws_jccspare jcs left join my_main mm on jcs.psrno=mm.psrno where mm.catid>3 group by jobcarddocno) oth on oth.jobcarddocno=job.doc_no"
					+ " left join ws_estm est on (job.reftype='EST' and job.refno=est.doc_no) left join ws_gateinpass gate on (if(job.reftype='GIP',job.refno=gate.doc_no,est.gipno=gate.doc_no))"
					+ " left join my_acbook ac on (invm.acno=ac.acno)"
					+ " left join my_clcatm cl on cl.doc_no=ac.catid "
					+ " left join my_salm slm on ac.sal_id=slm.doc_no"
					+ " left join my_salesman wsa on (gate.serviceadvisor=wsa.doc_no and wsa.sal_type='WSA' and wsa.status=3)"
					+ " left join ws_gartype rtype on gate.repairtype=rtype.row_no"
					+ " left join (select sum(coalesce(invoiceamt,0)) labtot,rdocno,sum(coalesce(total,0)) labourtotal from ws_estlabour group by rdocno ) lab on est.doc_no=lab.rdocno"
					+ " left join (select sum(coalesce(customeramt,0)) sparestot,jobcarddocno from ws_jccspare group by jobcarddocno ) sp on job.doc_no=sp.jobcarddocno"
					+ " where 1=1 " + sqltest + sqlgroup;

			System.out.println("revenue summary---:" + strSql);
			ResultSet resultSet = detailstmt.executeQuery(strSql);
			RESULTDATA = ClsCommon.convertToJSON(resultSet);

			detailstmt.close();
			conn.close();

			return RESULTDATA;

		} catch (Exception e) {
			e.printStackTrace();
			conn.close();
		} finally {
			conn.close();
		}

		return RESULTDATA;
	}

	public JSONArray getDetailExportData(String fromdate, String todate, String hidclient, String hidclientslm,
			String hidrepairtype, String id, String hidserviceadvisor) throws SQLException {
		JSONArray RESULTDATA = new JSONArray();
		Connection conn = null;
		if (!id.equalsIgnoreCase("1")) {
			return RESULTDATA;
		}

		String sqltest = "";
		java.sql.Date sqlfromdate = null, sqltodate = null;
		if (!fromdate.equalsIgnoreCase("") && fromdate != null) {
			sqlfromdate = ClsCommon.changeStringtoSqlDate(fromdate);
		}
		if (!todate.equalsIgnoreCase("") && todate != null) {
			sqltodate = ClsCommon.changeStringtoSqlDate(todate);
		}

		if (!hidclient.equalsIgnoreCase("")) {
			sqltest += " and ac.cldocno in (" + hidclient + ")";
		}
		if (!hidclientslm.equalsIgnoreCase("")) {
			sqltest += " and slm.doc_no in (" + hidclientslm + ")";
		}
		if (!hidrepairtype.equalsIgnoreCase("")) {
			sqltest += " and rtype.row_no in (" + hidrepairtype + ")";
		}
		if (!hidserviceadvisor.equalsIgnoreCase("")) {
			sqltest += " and gate.serviceadvisor in (" + hidserviceadvisor + ")";
		}
		try {
			conn = ClsConnection.getMyConnection();
			Statement detailstmt = conn.createStatement();

			/*
			 * String
			 * strSql="select invm.date 'Date',invm.voc_no 'Invoice No',ac.refname 'Client',usr.user_name 'Service Advisor',h.description 'Account Name',invm.refno 'Job No',concat(gate.regno,'-',gate.pltid) 'Reg No',CONVERT(coalesce(invm.nettotal,''),char) 'Total Inv Value',"
			 * +" convert(coalesce(format(invm.nettotal- lbr.spramt,2),'0.00'),char) 'Labour',convert(coalesce(format(spr.spramt,2),'0.00'),char) 'Spares',convert(coalesce(format(lub.spramt,2),'0.00'),char) 'Lubricants',convert(coalesce(format(cns.spramt,2),'0.00'),char) 'Consumables',convert(coalesce(format(oth.spramt,2),'0.00'),char) 'Others',coalesce(slm.sal_name,'') Salesman,coalesce(rtype.name,'') 'Repair Type'"
			 * +" from ws_invm invm left join ws_jobcard job on (invm.reftype='JC' and invm.refno=job.doc_no)"
			 * +" left join my_user usr on job.userid=usr.doc_no"
			 * +" left join (select jobcarddocno,sum(coalesce(customeramt,0)) spramt from ws_jccspare group by jobcarddocno) lbr on lbr.jobcarddocno=job.doc_no"
			 * +" left join (select jobcarddocno,sum(coalesce(customeramt,0)) spramt from ws_jccspare jcs left join my_main mm on jcs.psrno=mm.psrno where mm.catid=1 group by jobcarddocno) spr on spr.jobcarddocno=job.doc_no"
			 * +" left join (select jobcarddocno,sum(coalesce(customeramt,0)) spramt from ws_jccspare jcs left join my_main mm on jcs.psrno=mm.psrno where mm.catid=2 group by jobcarddocno) lub on lub.jobcarddocno=job.doc_no"
			 * +" left join (select jobcarddocno,sum(coalesce(customeramt,0)) spramt from ws_jccspare jcs left join my_main mm on jcs.psrno=mm.psrno where mm.catid=3 group by jobcarddocno) cns on cns.jobcarddocno=job.doc_no"
			 * +" left join (select jobcarddocno,sum(coalesce(customeramt,0)) spramt from ws_jccspare jcs left join my_main mm on jcs.psrno=mm.psrno where mm.catid>3 group by jobcarddocno) oth on oth.jobcarddocno=job.doc_no"
			 * +" left join ws_estm est on (job.reftype='EST' and job.refno=est.doc_no)"
			 * +" left join ws_gateinpass gate on (if(job.reftype='GIP',job.refno=gate.doc_no,est.gipno=gate.doc_no))"
			 * +" left join my_acbook ac on (gate.cldocno=ac.cldocno and ac.dtype='CRM')"
			 * +" left join my_acbook bac on (gate.insurcldocno=bac.cldocno and bac.dtype='CRM' and insurancecomp=1)"
			 * +" left join my_head h on (bac.acno=h.doc_no)"
			 * +" left join my_salm slm on ac.sal_id=slm.doc_no"
			 * +" left join ws_gartype rtype on gate.repairtype=rtype.row_no "
			 * +" where invm.date between '"+sqlfromdate+"' and '"+sqltodate+"'"+sqltest;
			 */
			/*
			 * invm.date,invm.voc_no invoiceno,invm.refno jobno,invm.nettotal
			 * totalinv,ac.refname client,"+
			 * " concat(gate.regno,'-',gate.pltid) regno,usr.user_name serviceadvisor,rtype.name repairtype,"
			 * +
			 * " if(coalesce(invm.nettotal,0)-coalesce(lbr.spramt,0)<0,0,coalesce(invm.nettotal,0)-coalesce(lbr.spramt,0)) labour,coalesce(spr.spramt,0) "
			 * +
			 * " spares,coalesce(lub.spramt,0) lubricants,coalesce(cns.spramt,0) consumables,coalesce(oth.spramt,0) others,slm.sal_name salesman,"
			 * + " h.description account from ws_jobcard job inner join (select
			 * reftype,date,voc_no,refno,sum(nettotal) nettotal
			 */ /*
				 * String
				 * strSql="select invm.date 'Date',invm.voc_no 'Invoice No',ac.refname 'Client Name',cl.category 'Client Category',sm.sal_name 'Estimator',sm1.sal_name 'Service Advisor',h.description 'Account Name',invm.refno 'Job No',concat(gate.regno,'-',gate.pltid) 'Reg No',CONVERT(coalesce(invm.nettotal,''),char) 'Total Inv Value',invm.clienttotal 'Clent',invm.excesstotal 'Ins. Co.',"
				 * +" convert(coalesce(format(coalesce(invm.nettotal,0)-coalesce(lbr.spramt,0),2),'0.00'),char) 'Labour',convert(coalesce(format(spr.spramt,2),'0.00'),char) 'Spares',srv.nispareamt 'Actual Spare',convert(coalesce(format(lub.spramt,2),'0.00'),char) 'Lubricants',convert(coalesce(format(cns.spramt,2),'0.00'),char) 'Consumables',convert(coalesce(format(oth.spramt,2),'0.00'),char) 'Others',coalesce(slm.sal_name,'') Salesman,coalesce(rtype.name,'') 'Repair Type' from ws_jobcard job inner join (select reftype,date,convert(group_concat(voc_no SEPARATOR ' ,'),char(50)) voc_no,refno,sum(nettotal) nettotal,sum(coalesce(nettotal,0))-coalesce(excess,0) clienttotal, coalesce(excess,0) excesstotal from ws_invm where date between '"
				 * +sqlfromdate+"' and '"+sqltodate+"' and status<>7 "+
				 * " group by refno) invm on (job.doc_no=invm.refno and invm.reftype='JC') left join my_user usr on job.userid=usr.doc_no"
				 * +
				 * " left join (select jobcarddocno,sum(coalesce(customeramt,0)) spramt from ws_jccspare  group by jobcarddocno) lbr on lbr.jobcarddocno=job.doc_no"
				 * +
				 * " left join (select jobcarddocno,sum(coalesce(customeramt,0)) spramt from ws_jccspare jcs left join my_main mm on jcs.psrno=mm.psrno where mm.catid=1 group by jobcarddocno) spr on spr.jobcarddocno=job.doc_no"
				 * +
				 * " left join (select jobcarddocno,sum(coalesce(customeramt,0)) spramt from ws_jccspare jcs left join my_main mm on jcs.psrno=mm.psrno where mm.catid=2 group by jobcarddocno) lub on lub.jobcarddocno=job.doc_no"
				 * +
				 * " left join (select jobcarddocno,sum(coalesce(customeramt,0)) spramt from ws_jccspare jcs left join my_main mm on jcs.psrno=mm.psrno where mm.catid=3 group by jobcarddocno) cns on cns.jobcarddocno=job.doc_no"
				 * +
				 * " left join (select jobcarddocno,sum(coalesce(customeramt,0)) spramt from ws_jccspare jcs left join my_main mm on jcs.psrno=mm.psrno where mm.catid>3 group by jobcarddocno) oth on oth.jobcarddocno=job.doc_no"
				 * + " left join ws_estm est on (job.reftype='EST' and job.refno=est.doc_no)"+
				 * " left join ws_gateinpass gate on (if(job.reftype='GIP',job.refno=gate.doc_no,est.gipno=gate.doc_no))"
				 * + " left join my_acbook ac on (gate.cldocno=ac.cldocno and ac.dtype='CRM')"+
				 * " left join my_acbook bac on (gate.insurcldocno=bac.cldocno and bac.dtype='CRM' and insurancecomp=1)"
				 * + " left join my_head h on (bac.acno=h.doc_no)"+
				 * " left join my_salm slm on ac.sal_id=slm.doc_no"+
				 * " left join ws_gartype rtype on gate.repairtype=rtype.row_no left join my_clcatm cl on cl.doc_no=ac.catid left join my_salesman sm on sm.doc_no=gate.marketingperson and sm.sal_type='WMP' left join my_salesman sm1 on sm1.doc_no=gate.serviceadvisor and sm1.sal_type='WSA' left join (select costcode,sum(nettaxamount) nispareamt from my_srvpurd srv left join my_srvpurm srvm on srv.rdocno=srvm.doc_no where costtype=9 and srvm.status!=7 group by costcode) srv on srv.costcode=job.doc_no where 1=1 "
				 * +sqltest+" order by invm.voc_no" ;
				 */ // query changed- Added estno and esttotal
			String strSql = "select invm.date 'Date',invm.voc_no 'Invoice No',ac.refname 'Client Name',cl.category 'Client Category',sm.sal_name 'Estimator',sm1.sal_name 'Service Advisor',h.description 'Account Name',invm.refno 'Job No',concat(gate.regno,'-',gate.pltid) 'Reg No',CONVERT(coalesce(invm.nettotal,''),char) 'Total Inv Value',invm.clienttotal 'Clent',convert(if(estadd.estaddition is not null, concat(est.voc_no,'-', estadd.estaddition),est.voc_no),char(100)) 'EST Docno(Additions)',coalesce(spare.sparetotal,0.0)+coalesce(labour.labourtotal,0.0) 'EST total value',invm.excesstotal 'Ins. Co.',"
					+ " convert(coalesce(format(coalesce(invm.nettotal,0)-coalesce(lbr.spramt,0),2),'0.00'),char) 'Labour',convert(coalesce(format(spr.spramt,2),'0.00'),char) 'Spares',srv.nispareamt 'Actual Spare',convert(coalesce(format(lub.spramt,2),'0.00'),char) 'Lubricants',convert(coalesce(format(cns.spramt,2),'0.00'),char) 'Consumables',convert(coalesce(format(oth.spramt,2),'0.00'),char) 'Others',coalesce(lbr.esttotal,0) 'EST Total',coalesce(spare.sparetotal,0.0) 'EST Appr.Value',coalesce(slm.sal_name,'') Salesman,coalesce(rtype.name,'') 'Repair Type' from ws_jobcard job inner join (select reftype,date,convert(group_concat(voc_no SEPARATOR ' ,'),char(50)) voc_no,refno,sum(nettotal) nettotal,sum(coalesce(nettotal,0))-coalesce(excess,0) clienttotal, coalesce(excess,0) excesstotal from ws_invm where date between '"
					+ sqlfromdate + "' and '" + sqltodate + "' and status<>7 "
					+ " group by refno) invm on (job.doc_no=invm.refno and invm.reftype='JC') left join my_user usr on job.userid=usr.doc_no"
					+ " left join (select jobcarddocno,sum(coalesce(customeramt,0)) spramt, estdocno,sum(coalesce(esttotal,0)) esttotal from ws_jccspare  group by jobcarddocno) lbr on lbr.jobcarddocno=job.doc_no"
					+ " left join (select jobcarddocno,sum(coalesce(customeramt,0)) spramt from ws_jccspare jcs left join my_main mm on jcs.psrno=mm.psrno where mm.catid=1 group by jobcarddocno) spr on spr.jobcarddocno=job.doc_no"
					+ " left join (select jobcarddocno,sum(coalesce(customeramt,0)) spramt from ws_jccspare jcs left join my_main mm on jcs.psrno=mm.psrno where mm.catid=2 group by jobcarddocno) lub on lub.jobcarddocno=job.doc_no"
					+ " left join (select jobcarddocno,sum(coalesce(customeramt,0)) spramt from ws_jccspare jcs left join my_main mm on jcs.psrno=mm.psrno where mm.catid=3 group by jobcarddocno) cns on cns.jobcarddocno=job.doc_no"
					+ " left join (select jobcarddocno,sum(coalesce(customeramt,0)) spramt from ws_jccspare jcs left join my_main mm on jcs.psrno=mm.psrno where mm.catid>3 group by jobcarddocno) oth on oth.jobcarddocno=job.doc_no"
					+ " left join ws_estm est on (job.reftype='EST' and job.refno=est.doc_no)"
					+ " left join ws_gateinpass gate on (if(job.reftype='GIP',job.refno=gate.doc_no,est.gipno=gate.doc_no))"
					+ " left join my_acbook ac on (gate.cldocno=ac.cldocno and ac.dtype='CRM')"
					+ " left join my_acbook bac on (gate.insurcldocno=bac.cldocno and bac.dtype='CRM' and insurancecomp=1)"
					+ " left join my_head h on (bac.acno=h.doc_no)" + " left join my_salm slm on ac.sal_id=slm.doc_no"
					+ " left join ws_gartype rtype on gate.repairtype=rtype.row_no left join my_clcatm cl on cl.doc_no=ac.catid left join my_salesman sm on sm.doc_no=gate.marketingperson and sm.sal_type='WMP' left join my_salesman sm1 on sm1.doc_no=gate.serviceadvisor and sm1.sal_type='WSA' left join (select costcode,sum(nettotal) nispareamt from my_srvpurd srv left join my_srvpurm srvm on srv.rdocno=srvm.doc_no where costtype=9 and srvm.status!=7 group by costcode) srv on srv.costcode=job.doc_no "
					+ " left join (select  sum(approvedvalue) sparetotal,rdocno from  ws_estspare where confirmed=1 and approved=1 "
					+ " group by rdocno) spare on est.doc_no=spare.rdocno left join (select sum(total)  labourtotal,rdocno from  "
					+ " ws_estlabour  where confirmed=1 and approved=1 group by rdocno) labour on (est.doc_no=labour.rdocno) left join "
					+ " (select convert(group_concat(addition,'-'),char(100)) estaddition,jobcarddocno jobdocno from ws_estmadd "
					+ " where status=3 group by jobcarddocno) estadd on job.doc_no=estadd.jobdocno where 1=1 " + sqltest
					+ " order by invm.voc_no";

			System.out.println("revenue Export detail---:" + strSql);
			ResultSet rs = detailstmt.executeQuery(strSql);
			RESULTDATA = ClsCommon.convertToEXCEL(rs);
			detailstmt.close();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			conn.close();
		}
		return RESULTDATA;
	}

	public JSONArray getServiceAdvisorData(String id) throws SQLException {
		JSONArray data = new JSONArray();
		Connection conn = null;
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmtClientAnalysis = conn.createStatement();
			String strSql = "select doc_no,sal_code,sal_name from my_salesman where status=3 and sal_type='WSA'";
			ResultSet resultSet = stmtClientAnalysis.executeQuery(strSql);
			data = ClsCommon.convertToJSON(resultSet);
			stmtClientAnalysis.close();
			conn.close();
			return data;

		} catch (Exception e) {
			e.printStackTrace();
			conn.close();
		} finally {
			conn.close();
		}

		return data;
	}

}
