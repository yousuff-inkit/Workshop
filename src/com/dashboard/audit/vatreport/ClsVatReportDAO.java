package com.dashboard.audit.vatreport;
import com.common.ClsCommon;
import com.connection.ClsConnection;

import java.sql.*;

import net.sf.json.JSONArray;
public class ClsVatReportDAO {

	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	
	public JSONArray getVatOutputData(String id,String branch,String fromdate,String todate) throws SQLException
	{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="",sqltest="",sqltest1="";
			java.sql.Date sqlfromdate=null,sqltodate=null;
			if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
				sqltest+=" and jv.brhid="+branch;
				sqltest1+=" and m.brhid="+branch;
			}
			if(!fromdate.equalsIgnoreCase("")){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
				sqltest+=" and jv.date>='"+sqlfromdate+"'";
			}
			if(!todate.equalsIgnoreCase("")){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
				sqltest+=" and jv.date<='"+sqltodate+"'";
			}
			
			 
			strsql="select a.date,a.branchname branch,a.refname,a.area,a.trnnumber clienttrn,a.dtype,a.vocno,a.doc_no docno,a.totalvalue,a.vatapplied, "
					+ " (a.totalvalue-a.vatapplied-a.vatcollected) vatnotapplied, a.vatcollected from ("+
			" select jv.date,br.branchname,ac.refname,coalesce(ar.area,'')area,ac.trnnumber,jv.dtype,convert(inv.voc_no,char(25)) vocno,inv.doc_no,round(sum(dramount),2)*-1"+
			" totalvalue,round(sum(if(invhead.tax=1 and ac.tax=1 and invhead.idno<>20 and (inv.date between tax.fromdate and tax.todate),"+
			" dramount,0)),2)*-1 vatapplied,0 vatnotapplied,round(sum(if(invhead.idno=20,dramount,0)),2)*-1 vatcollected "
			+ " from my_jvtran jv inner join gl_invmode invhead on"+
			" jv.acno=invhead.acno inner join ws_invm inv on (jv.tr_no=inv.tr_no) left join my_acbook ac on (inv.invoicetoacno=ac.acno and"+
			" ac.dtype='CRM' and ac.status=3) left join my_area ar on(ac.area_id=ar.doc_no) left join my_brch br on jv.brhid=br.doc_no left join gl_taxdetail tax on (inv.date between tax.fromdate and"+
			" tax.todate) where jv.status=3 and jv.dtype in ('MNT') "+sqltest+" and jv.id<0 group by jv.tr_no"+
			" union all"+
			" select jv.date,br.branchname,ac.refname,coalesce(ar.area,'')area,ac.trnnumber,jv.dtype,convert(sale.voc_no,char(25)) vocno,sale.doc_no,round(sum(dramount),2)*-1"+
			" totalvalue,round(sum(if(ac.tax=1 and invhead.idno<>20 and (sale.date between tax.fromdate and tax.todate),"+
			" dramount,0)),2)*-1 vatapplied,0 vatnotapplied,round(sum(if(invhead.idno=20,dramount,0)),2)*-1 vatcollected from my_jvtran jv"+
			" left join gl_invmode invhead on jv.acno=invhead.acno left join gl_vsalem sale on (jv.tr_no=sale.trno) left join my_acbook ac on"+
			" (sale.cldocno=ac.cldocno and ac.dtype='CRM') left join my_area ar on(ac.area_id=ar.doc_no) left join my_brch br on jv.brhid=br.doc_no left join gl_taxdetail tax on"+
			" (sale.date between tax.fromdate and tax.todate) where jv.status=3 and jv.dtype='VSI' "+sqltest+" and jv.id<0 group by"+
			" jv.tr_no union all"+
			" select date,branchname,refname,area,trnnumber,jv.dtype,convert(jv.doc_no,char(25)) vocno,jv.doc_no,sum(jv.netamount) netamount,"
			+ " sum(vatapplied) vatapplied ,sum(vatnotapplied) vatnotapplied,sum(jv.dramount) dramount from ( "
			+ " select jv.tr_no,c.date,b.branchname,a.refname,coalesce(ar.area,'')area,a.trnnumber,jv.dtype,convert(jv.doc_no,char(25)) vocno,jv.doc_no,c.netamount, "
			+ " 0 vatapplied ,0 vatnotapplied,jv.dramount  from my_jvtran jv inner join gl_invmode i on i.idno=20 and jv.acno=i.acno "+
			" inner join my_cnot c on jv.tr_no=c.tr_no inner join my_acbook a on a.acno=c.acno left join my_area ar on(a.area_id=ar.doc_no) inner join my_brch b on b.doc_no=c.brhid"+ " "
			+ "  where  jv.status=3 and jv.dtype in ('cno','DNO')   "+sqltest+" and (rdocno!=0) union all "
			+ " select jv.tr_no,c.date,b.branchname,a.refname,coalesce(ar.area,'')area,a.trnnumber,jv.dtype,convert(jv.doc_no,char(25)) vocno,jv.doc_no,0 netamount, "
			+ " sum(dramount) vatapplied ,0 vatnotapplied,0 dramount from my_jvtran jv inner join gl_invmode i on i.idno!=20 and "
			+ " jv.acno=i.acno and tax=1 inner join my_cnot c on jv.tr_no=c.tr_no inner join my_acbook a on a.acno=c.acno left join my_area ar on(a.area_id=ar.doc_no) inner join "
			+ " my_brch b on b.doc_no=c.brhid   where  jv.status=3 and jv.dtype in ('cno','DNO')    "+sqltest+"  and (rdocno!=0) "
			+ " group by jv.tr_no ) jv group by jv.tr_no"
 +"  union all  select a.date ,a.branchname,a.refname,a.area,a.trnnumber,a.dtype,convert(a.vocno,char(25)) vocno ,a.doc_no,a.totalvalue ,"
					+ " (a.totalvalue-a.vatcollected) vatapplied,(a.totalvalue-(a.totalvalue-a.vatcollected)-a.vatcollected) vatnotapplied,a.vatcollected "
					+ " from (select m.date,br.branchname,ac.refname,coalesce(ar.area,'')area,ac.trnnumber,ac.cldocno,jv.brhid,convert(m.voc_no,char(25)) vndinvno ,jv.dtype,"
					+ "  convert(m.voc_no,char(25)) vocno,m.doc_no,"
					+ " round(sum(jv.dramount),2) totalvalue,round(sum(if(ac.tax=1 and jv.acno<>tax.acno   and (m.date between tax.fromdate and tax.todate),"
					+ " jv.dramount,0)),2) vatapplied,0 vatnotapplied,round(sum(coalesce(jv1.dramount,0)),2)*-1 vatcollected from my_srvsalem m inner join"
					+ " my_jvtran jv on (jv.tr_no=m.tr_no and m.acno=jv.acno)  left join my_acbook ac on (m.acno=ac.acno and ac.dtype='CRM') left join my_area ar on(ac.area_id=ar.doc_no)"
					+ "   left join my_brch br on jv.brhid=br.doc_no  left join gl_taxmaster tax on (m.date between tax.fromdate and tax.todate and tax.type=2) "
					+ " left join my_jvtran jv1 on (jv1.tr_no=m.tr_no and tax.acno=jv1.acno) where m.status=3 and m.date>='"+sqlfromdate+"' "
							+ " and m.date<='"+sqltodate+"'   "+sqltest1+"  group by m.tr_no) a "
 +"  union all select m.date,br.branchname,ac.refname,coalesce(ar.area,'')area,ac.trnnumber,m.dtype,convert(m.voc_no,char(100))  vocno,m.doc_no ,totalvalue,vatapplied,vatnotapplied, vatcollected "
					+ " from my_invm  m left join (select sum(nettotal+taxamount)   totalvalue, sum(taxamount) vatcollected ,rdocno from my_invd group by rdocno) d1 "
					+ " on d1.rdocno=m.doc_no left join (select sum(nettotal) vatapplied,rdocno from my_invd  where taxamount>0 group by rdocno) d2 "
					+ " on d2.rdocno=m.doc_no left join (select sum(nettotal)   vatnotapplied,rdocno from my_invd where taxamount=0 group by rdocno) d3 "
					+ "	on d3.rdocno=m.doc_no  left join my_acbook ac on ac.cldocno=m.cldocno and ac.dtype='crm' left join my_area ar on(ac.area_id=ar.doc_no) left join my_brch br on br.doc_no=m.brhid where  m.status=3 and m.date>='"+sqlfromdate+"' and   m.date<='"+sqltodate+"' "+sqltest1+" group by m.doc_no "
					+ " union all select m.date,br.branchname,ac.refname,coalesce(ar.area,'')area,ac.trnnumber,m.dtype,convert(m.voc_no,char(100))  vocno,m.doc_no ,totalvalue,vatapplied,vatnotapplied, vatcollected  "
					+ " from my_invr  m left join (select sum(nettotal+taxamount)   totalvalue,sum(taxamount) vatcollected ,rdocno from my_inrd group by rdocno) d1 "
					+ " On d1.rdocno=m.doc_no left join (select sum(nettotal)   vatapplied,rdocno from my_inrd  where taxamount>0 group by rdocno) d2 "
					+ " on d2.rdocno=m.doc_no left join (select sum(nettotal)   vatnotapplied,rdocno from my_inrd where taxamount=0 group by rdocno) d3 "
					+ " on d3.rdocno=m.doc_no left join my_invm inv on inv.doc_no=m.rrefno left join my_acbook ac on ac.cldocno=m.cldocno and ac.dtype='crm' left join my_area ar on(ac.area_id=ar.doc_no) left join my_brch br on br.doc_no=m.brhid where  m.status=3 and m.date>='"+sqlfromdate+"' and   m.date<='"+sqltodate+"' "+sqltest1+" "
					+ " group by m.doc_no ) a"
					+ " union all select m.date,br.branchname,h.description,''area,0 trnno,m.dtype,convert(m.doc_no,char(25))vocno,m.refno,"
					+ " sum(if(d.nettotal<0,d.nettotal*-1,d.nettotal)*-1)  totalvalue,"
			        + " sum(if(taxamount!=0,if(d.amount<0,d.amount*-1,d.amount)*-1,0)) vatapplied,"
					+ " sum(if(taxamount=0,if(d.amount<0,d.amount*-1,d.amount)*-1,0))  vatnotapplied,"
			        + " sum(coalesce(if(d.taxamount<0,d.taxamount*-1,d.taxamount)*-1,0))  vatcollected from my_cnot m left join my_cnotd d " + "on m.tr_no=d.tr_no "
			        + " left join my_head h on h.doc_no=m.acno left join my_brch br on m.brhid=br.doc_no where m.status=3 and  m.dtype='TCN'  and h.atype='AR' and  m.date between '"+sqlfromdate+"' and '"+sqltodate+"' "+sqltest1+"  group by m.tr_no "
			        + "  union all"
						+ " select  m.date,br.branchname,h.description,''area,0 trno,m.dtype,convert(m.doc_no,char(25)) vocno,convert(m.refno,char(150)) invno,"
						+ " sum(if(d.nettotal<0,d.nettotal*-1,d.nettotal)) totalvalue,sum(if(taxamount!=0,if(d.amount<0,d.amount*-1,d.amount),0)) vatapplied,sum(if(taxamount=0,if(d.amount<0,d.amount*-1,d.amount),0))  vatnotapplied, sum(coalesce(if(d.taxamount<0,d.taxamount*-1,d.taxamount),0))  vatcollected from my_cnot m left join my_cnotd d on" 
						+ " m.tr_no=d.tr_no left join my_head h on h.doc_no=m.acno "
						+ " left join my_brch br on m.brhid=br.doc_no where m.status=3 and  m.dtype='TDN' and h.atype='AR' "
						+ " and  m.date between '"+sqlfromdate+"' and '"+sqltodate+"' "+sqltest1+"  group by m.tr_no "; 
			
			/*TDN - AP - Input  - -ve
			TDN - AR - Output  - +ve

			TCN - AP - Input  - +ve
			TCN - AR - Output  - -ve*/
			
			ResultSet rs=stmt.executeQuery(strsql);
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
	
	public JSONArray getVatInputData(String id,String branch,String fromdate,String todate) throws SQLException
	{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="",sqltest="",sqltest1="";
			java.sql.Date sqlfromdate=null,sqltodate=null;
			if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
				sqltest+=" and jv.brhid="+branch;
				
				sqltest1+=" and m.brhid="+branch;
			}
			if(!fromdate.equalsIgnoreCase("")){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
				/*sqltest+=" and jv.date>='"+sqlfromdate+"'";*/
			}
			if(!todate.equalsIgnoreCase("")){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
				/*sqltest+=" and jv.date<='"+sqltodate+"'";*/
			}
			/*strsql="select a.date,a.branchname branch,a.refname,a.trnnumber clienttrn,a.dtype,a.voc_no,a.doc_no docno,a.totalvalue,a.vatapplied,(a.totalvalue-a.vatapplied-a.vatcollected) vatnotapplied,"+
			" a.vatcollected from ("+
			" select br.branchname,ac.refname,ac.trnnumber,jv.dtype,convert(m.voc_no,char(25)) voc_no,m.doc_no,jv.date,round(sum(dramount),2)"+
			" totalvalue,round(sum(if(ac.tax=1 and jv.acno<>tax.acno and (m.date between tax.fromdate and tax.todate),"+
			" dramount,0)),2) vatapplied,0 vatnotapplied,round(sum(if(jv.acno=tax.acno,dramount,0)),2) vatcollected from my_jvtran jv"+
			" left join my_srvpurm m on (jv.tr_no=m.tr_no) left join my_acbook ac on"+
			" (m.acno=ac.acno and ac.dtype='VND') left join my_brch br on jv.brhid=br.doc_no left join gl_taxmaster tax on"+
			" (m.date between tax.fromdate and tax.todate) where jv.dtype='CPU' "+sqltest+" and jv.id>0 group by jv.tr_no"+
			" union all"+
			" select br.branchname,ac.refname,ac.trnnumber,jv.dtype,convert(m.voc_no,char(25)) voc_no,m.doc_no,jv.date,round(sum(dramount),2)"+
			" totalvalue,round(sum(if(ac.tax=1 and jv.acno<>tax.acno and (m.date between tax.fromdate and tax.todate),"+
			" dramount,0)),2) vatapplied,0 vatnotapplied,round(sum(if(jv.acno=tax.acno,dramount,0)),2) vatcollected from my_jvtran jv"+
			" left join gl_vpurm m on (jv.tr_no=m.tr_no) left join my_acbook ac on"+
			" (m.venid=ac.acno and ac.dtype='VND') left join my_brch br on jv.brhid=br.doc_no left join gl_taxmaster tax on"+
			" (m.date between tax.fromdate and tax.todate) where jv.dtype='VPU' "+sqltest+" and jv.id>0 group by jv.tr_no"+
			" union all"+
			" select br.branchname,ac.refname,ac.trnnumber,jv.dtype,convert(m.voc_no,char(25)) voc_noo,m.doc_no,jv.date,round(sum(dramount),2)"+
			" totalvalue,round(sum(if(ac.tax=1 and jv.acno<>tax.acno and (m.date between tax.fromdate and tax.todate),"+
			" dramount,0)),2) vatapplied,0 vatnotapplied,round(sum(if(jv.acno=tax.acno,dramount,0)),2) vatcollected from my_jvtran jv"+
			" left join gl_vpurdirm m on (jv.tr_no=m.tr_no) left join my_acbook ac on"+
			" (m.venid=ac.acno and ac.dtype='VND') left join my_brch br on jv.brhid=br.doc_no left join gl_taxmaster tax on"+
			" (m.date between tax.fromdate and tax.todate) where jv.dtype='VPD' "+sqltest+" and jv.id>0 group by jv.tr_no"+
			" union all"+
			" select br.branchname,ac.refname,ac.trnnumber,jv.dtype,convert(m.voc_no,char(25)) voc_no,m.doc_no,jv.date,round(sum(dramount),2)"+
			" totalvalue,round(sum(if(ac.tax=1 and jv.acno<>tax.acno and (m.date between tax.fromdate and tax.todate),"+
			" dramount,0)),2) vatapplied,0 vatnotapplied,round(sum(if(jv.acno=tax.acno,dramount,0)),2) vatcollected from my_jvtran jv"+
			" left join gl_vmcostm m on (jv.tr_no=m.trno) left join my_acbook ac on"+
			" (m.gargid=ac.cldocno and ac.dtype='VND') left join my_brch br on jv.brhid=br.doc_no left join gl_taxmaster tax on"+
			" (m.date between tax.fromdate and tax.todate) where jv.dtype='MRU' "+sqltest+" and jv.id>0 group by jv.tr_no"+
			" union all"+
			" select br.branchname,ac.refname,ac.trnnumber,jv.dtype,convert(m.voc_no,char(25)) voc_no,m.doc_no,jv.date,round(sum(dramount),2)"+
			" totalvalue,round(sum(if(ac.tax=1 and jv.acno<>tax.acno and (m.date between tax.fromdate and tax.todate),"+
			" dramount,0)),2) vatapplied,0 vatnotapplied,round(sum(if(jv.acno=tax.acno,dramount,0)),2) vatcollected from my_jvtran jv"+
			" left join gl_vmcostm m on (jv.tr_no=m.trno) left join my_acbook ac on"+
			" (m.gargid=ac.cldocno and ac.dtype='VND') left join my_brch br on jv.brhid=br.doc_no left join gl_taxmaster tax on"+
			" (m.date between tax.fromdate and tax.todate) where jv.dtype='MWO' "+sqltest+" and jv.id>0 group by jv.tr_no ) a";
			
			
			select convert(m.invno,char(25)) vndinvno,m.date,br.branchname,ac.refname,ac.trnnumber,jv.dtype,convert(m.voc_no,char(25)) vocno,m.doc_no,round(sum(jv.dramount),2)*-1 "+
			" totalvalue,round(sum(if(ac.tax=1 and jv.acno<>tax.acno and m.type=1 and (m.date between tax.fromdate and tax.todate), "+
			" jv.dramount,0)),2)*-1 vatapplied,0 vatnotapplied,round(sum(coalesce(jv1.dramount,0)),2) vatcollected from my_srvpurm m inner join "+
			" my_jvtran jv on (jv.tr_no=m.tr_no and m.acno=jv.acno) left join my_acbook ac on (m.acno=ac.acno and ac.dtype='VND') left join "+
			" my_brch br on jv.brhid=br.doc_no left join gl_taxmaster tax on (m.date between tax.fromdate and tax.todate and tax.type=1) "+
			" left join my_jvtran jv1 on (jv1.tr_no=m.tr_no and tax.acno=jv1.acno) where m.status=3 and m.date>='"+sqlfromdate+"' and "+
			" m.date<='"+sqltodate+"' "+sqltest+" group by m.tr_no union all
			
			
			'PIR',
			*/
			strsql="select coalesce(a.vndinvno,'') vndinvno,a.date,a.branchname branch,a.refname,a.area,a.trnnumber clienttrn,a.dtype,a.vocno,a.doc_no docno,a.totalvalue,"+
			" if(a.vatcollected<>0,(a.totalvalue-a.vatcollected),0)  vatapplied,(a.totalvalue-if(a.vatcollected<>0,(a.totalvalue-a.vatcollected),0)-a.vatcollected) vatnotapplied, if(dtype in ('CPR'), a.vatcollected*-1,a.vatcollected) vatcollected "+
			" from ("+
			" select convert(m.purno,char(25)) vndinvno,m.date,br.branchname,ac.refname,coalesce(ar.area,'')area,ac.trnnumber,jv.dtype,convert(m.voc_no,char(25)) vocno,m.doc_no,round(sum(jv.dramount),2)*-1 "+
			" totalvalue,round(sum(if(ac.tax=1 and jv.acno<>tax.acno and (m.date between tax.fromdate and tax.todate), jv.dramount,0)),2)*-1 "+
			" vatapplied,0 vatnotapplied, round(sum(coalesce(jv1.dramount,0)),2) vatcollected from gl_vpurm m inner join my_jvtran jv on "+
			" (jv.tr_no=m.tr_no and m.venid=jv.acno  and dramount<0) left join my_acbook ac on (m.venid=ac.acno and ac.dtype='VND') left join my_area ar on(ac.area_id=ar.doc_no)"+
			" left join my_brch br on jv.brhid=br.doc_no left join gl_taxmaster tax on (m.date between tax.fromdate and tax.todate and "+
			" tax.type=1 and per>0) left join my_jvtran jv1 on (jv1.tr_no=m.tr_no and tax.acno=jv1.acno) where m.status=3 and "+
			" m.date>='"+sqlfromdate+"' and m.date<='"+sqltodate+"' and m.tr_no is not null "+sqltest+" group by m.tr_no union all"+
			" select convert(m.invno,char(25)) vndinvno,m.date,br.branchname,ac.refname,coalesce(ar.area,'')area,ac.trnnumber,jv.dtype,convert(m.voc_no,char(25)) vocno,m.doc_no,round(sum(jv.dramount),2)*-1 "+
			" totalvalue,round(sum(if(ac.tax=1 and jv.acno<>tax.acno and (m.date between tax.fromdate and tax.todate), jv.dramount,0)),2)*-1 "+
			" vatapplied,0 vatnotapplied, round(sum(coalesce(jv1.dramount,0)),2) vatcollected from gl_vpurdirm m inner join my_jvtran jv on "+
			" (jv.tr_no=m.tr_no and m.venid=jv.acno  and dramount<0) left join my_acbook ac on (m.venid=ac.acno and ac.dtype='VND') left join my_area ar on(ac.area_id=ar.doc_no) left join "+
			" my_brch br on jv.brhid=br.doc_no left join gl_taxmaster tax on (m.date between tax.fromdate and tax.todate and tax.type=1 and per>0)"+
			" left join my_jvtran jv1 on (jv1.tr_no=m.tr_no and tax.acno=jv1.acno) where m.status=3 and m.date>='"+sqlfromdate+"' and "+
			" m.date<='"+sqltodate+"' and m.tr_no is not null "+sqltest+" group by m.tr_no union all"+
			" select convert(m.invno,char(25)) vndinvno,m.date,br.branchname,ac.refname,coalesce(ar.area,'')area,ac.trnnumber,jv.dtype,convert(m.voc_no,char(25)) vocno,m.doc_no,round(sum(jv.dramount),2)*-1 "+
			" totalvalue,round(sum(if(ac.tax=1 and jv.acno<>tax.acno and (m.date between tax.fromdate and tax.todate), jv.dramount,0)),2)*-1 "+
			" vatapplied,0 vatnotapplied, round(sum(coalesce(jv1.dramount,0)),2) vatcollected from gl_vmcostm m inner join gl_garrage g on "+
			" m.gargid=g.doc_no inner join my_jvtran jv on (jv.tr_no=m.trno and jv.acno=g.acc_no  and dramount<0) left join my_acbook ac on "+
			" (ac.acno=g.acc_no and ac.dtype='VND') left join my_area ar on(ac.area_id=ar.doc_no) left join my_brch br on  jv.brhid=br.doc_no left join gl_taxmaster tax on (m.date between "+
			" tax.fromdate and tax.todate and tax.type=1 and per>0) left join my_jvtran jv1 on (jv1.tr_no=m.trno and tax.acno=jv1.acno) where "+
			" m.status=3 and m.date>='"+sqlfromdate+"' and m.date<='"+sqltodate+"' and m.trno is not null "+sqltest+" group by m.trno "+
			
			"  union all select m.refinvno invno,m.date,br.branchname,ac.refname,coalesce(ar.area,'')area,ac.trnnumber,m.dtype,convert(m.voc_no,char(100)) vocno ,m.doc_no,totalvalue,vatapplied,vatnotapplied, vatcollected "
				+ " from my_srvm  m left join (select sum(nettotal+taxamount)   totalvalue, sum(taxamount) vatcollected ,rdocno from my_srvd group by rdocno) d1 "
				+ " on d1.rdocno=m.doc_no left join (select sum(nettotal)  vatapplied,rdocno from my_srvd  where taxamount>0 group by rdocno) d2 "
				+ " on d2.rdocno=m.doc_no "
				+ " left join (select sum(nettotal)   vatnotapplied,rdocno from my_srvd where taxamount=0 group by rdocno) d3 "
				+ " on d3.rdocno=m.doc_no left join my_acbook ac on ac.cldocno=m.cldocno and ac.dtype='VND' left join my_area ar on(ac.area_id=ar.doc_no) left join my_brch br on br.doc_no=m.brhid  where  m.status=3 and m.date>='"+sqlfromdate+"' and   m.date<='"+sqltodate+"' "+sqltest1+"  group by m.doc_no "
				+ " union all   select  inv.refinvno invno,m.date,br.branchname,ac.refname,coalesce(ar.area,'')area,ac.trnnumber,m.dtype,convert(m.voc_no,char(100)) vocno,m.doc_no,totalvalue*-1,vatapplied*-1,vatnotapplied, vatcollected*-1 vatcollected"
				+ " from my_srrm  m left join (select sum(nettotal+taxamount)   totalvalue,sum(taxamount) vatcollected ,rdocno from my_srrd group by rdocno) d1 "
				+ " on d1.rdocno=m.doc_no left join (select sum(nettotal)   vatapplied,rdocno from my_srrd  where taxamount>0 group by rdocno) d2 "
				+ "on d2.rdocno=m.doc_no left join (select sum(nettotal)   vatnotapplied,rdocno from my_srrd where taxamount=0 group by rdocno) d3 "
				+ "on d3.rdocno=m.doc_no  left join my_srvm inv on inv.doc_no=m.rrefno  left join my_acbook ac on ac.cldocno=m.cldocno and ac.dtype='VND' left join my_area ar on(ac.area_id=ar.doc_no) left join my_brch br on br.doc_no=m.brhid  "
				+ "where  m.status=3 and m.date>='"+sqlfromdate+"' and   m.date<='"+sqltodate+"' "+sqltest1+"  group by m.doc_no  "
					+ " union all select convert(m.invno,char(25))  invno,m.date,br.branchname,ac.refname,coalesce(ar.area,'')area,ac.trnnumber,'CPU' dtype,"
                     + " convert(m.voc_no,char(25)) vocno,m.doc_no,sum(d.nettotal+d.taxamount)  totalvalue,coalesce(aa.app,0) vatapplied, (sum(d.nettotal+coalesce(d.taxamount,0)))-coalesce(aa.app,0)-coalesce(aa.collect,0) vatnotapplied,"
                     +" coalesce(aa.collect,0)  vatcollected from my_srvpurm m left join (select   sum(nettotal) app,sum(taxamount) collect,rdocno"
                     +" from my_srvpurd where taxamount>0 group by rdocno) aa on aa.rdocno=m.doc_no left join (select   sum(nettotal) notapp,rdocno"
                     +" from my_srvpurd where taxamount=0 group by rdocno) bb on bb.rdocno=m.doc_no left join my_srvpurd d on d.rdocno=m.doc_no"
                     +" left join my_acbook ac on (m.acno=ac.acno and ac.dtype='VND') left join my_area ar on(ac.area_id=ar.doc_no) left join my_brch br on m.brhid=br.doc_no"
                     +" where  m.status=3 and m.date>='"+sqlfromdate+"' and   m.date<='"+sqltodate+"' "+sqltest1+"   group by m.tr_no)a "
                     + " union all select m.refno,m.date,br.branchname,h.description,''area,0 trnno,m.dtype,convert(m.doc_no,char(25))vocno,m.tr_no,"  
  					+ " sum(if(d.nettotal<0,d.nettotal*-1,d.nettotal))  totalvalue,"
  			        + " sum(if(taxamount!=0,if(d.amount<0,d.amount*-1,d.amount),0)) vatapplied,"
  					+ " sum(if(taxamount=0,if(d.amount<0,d.amount*-1,d.amount),0))  vatnotapplied,"
  			        + " sum(coalesce(if(d.taxamount<0,d.taxamount*-1,d.taxamount),0))  vatcollected from my_cnot m left join my_cnotd d " + "on m.tr_no=d.tr_no "
  			        + " left join my_head h on h.doc_no=m.acno left join my_brch br on m.brhid=br.doc_no where m.status=3 and m.dtype='TCN'  and h.atype in ('AP','GL') and  m.date between '"+sqlfromdate+"' and '"+sqltodate+"' "+sqltest1+"  group by m.tr_no "
                       + "  union all "
  						+ " select  convert(m.refno,char(150)) invno,m.date,br.branchname,h.description,''area,0 trno,m.dtype,convert(m.doc_no,char(25)) vocno,m.tr_no,"
  						// comment for tc 15273 pal + " sum(if(d.nettotal<0,d.nettotal*-1,d.nettotal)) totalvalue,sum(if(taxamount!=0,if(d.amount<0,d.amount*-1,d.amount),0)) vatapplied,sum(if(taxamount=0,if(d.amount<0,d.amount*-1,d.amount),0))  vatnotapplied, sum(coalesce(if(d.taxamount<0,d.taxamount*-1,d.taxamount),0))  vatcollected "
  						+ " sum(if(d.nettotal<0,d.nettotal*-1,d.nettotal))*-1 totalvalue,sum(if(taxamount!=0,if(d.amount<0,d.amount*-1,d.amount),0))*-1 vatapplied,sum(if(taxamount=0,if(d.amount<0,d.amount*-1,d.amount),0))*-1  vatnotapplied, sum(coalesce(if(d.taxamount<0,d.taxamount*-1,d.taxamount),0))*-1  vatcollected "
  						+ " from my_cnot m left join my_cnotd d on" 
  						+ " m.tr_no=d.tr_no left join my_head h on h.doc_no=m.acno "
  						+ " left join my_brch br on m.brhid=br.doc_no where m.status=3 and  m.dtype='TDN' and h.atype='AP' "
  						+ " and  m.date between '"+sqlfromdate+"' and '"+sqltodate+"' "+sqltest1+"  group by m.tr_no "
						+ " union all select convert(m.invno,char(25))  invno,m.date,br.branchname,ac.refname,coalesce(ar.area,'')area,ac.trnnumber,'CPR' dtype, convert(m.voc_no,char(25)) vocno,m.doc_no,sum(d.nettotal+d.taxamount)*-1  totalvalue,aa.app*-1 vatapplied, ((sum(d.nettotal+d.taxamount))-aa.app-coalesce(aa.collect,0))*-1 vatnotapplied, coalesce(aa.collect,0)*-1  vatcollected "
						+ " from my_srvpurretm m left join (select   sum(nettotal) app,sum(taxamount) collect,rdocno from my_srvpurretd where taxamount>0 group by rdocno) aa on aa.rdocno=m.doc_no "
						+ " left join (select   sum(nettotal) notapp,rdocno from my_srvpurretd where taxamount=0 group by rdocno) bb on bb.rdocno=m.doc_no left join my_srvpurretd d on d.rdocno=m.doc_no left join my_acbook ac on (m.acno=ac.acno and ac.dtype='VND') left join my_area ar on(ac.area_id=ar.doc_no) left join my_brch br on m.brhid=br.doc_no "
						+ " where  m.status=3 and m.date>='"+sqlfromdate+"' and   m.date<='"+sqltodate+"' "+sqltest1+"    group by m.tr_no";
			
			ResultSet rs=stmt.executeQuery(strsql);
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
	
	
	public JSONArray getVatOutputExcelData(String id,String branch,String fromdate,String todate) throws SQLException
	{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="",sqltest="",sqltest1="";;
			java.sql.Date sqlfromdate=null,sqltodate=null;
			if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
				sqltest+=" and jv.brhid="+branch;
				sqltest1+=" and m.brhid="+branch;
				
			}
			if(!fromdate.equalsIgnoreCase("")){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
				sqltest+=" and jv.date>='"+sqlfromdate+"'";
			}
			if(!todate.equalsIgnoreCase("")){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
				sqltest+=" and jv.date<='"+sqltodate+"'";
			}
			strsql="select a.branchname 'Branch',date_format(a.date,'%d.%m.%Y') 'Date',a.refname 'Customer',a.trnnumber 'TRN',a.dtype 'Inv Type',a.vocno 'Invoice No',"+
			" round(a.totalvalue,2) 'Total Invoice',round(a.vatapplied,2) 'VAT 5% Sales',round((a.totalvalue-a.vatapplied-a.vatcollected),2) 'VAT 0% Sales',a.vatcollected 'VAT Collected' from ("+
			" select jv.date,br.branchname,ac.refname,ac.trnnumber,jv.dtype,convert(inv.voc_no,char(25)) vocno,inv.doc_no,round(sum(dramount),2)*-1"+
			" totalvalue,round(sum(if(invhead.tax=1 and ac.tax=1 and invhead.idno<>20 and (inv.date between tax.fromdate and tax.todate),"+
			" dramount,0)),2)*-1 vatapplied,0 vatnotapplied,round(sum(if(invhead.idno=20,dramount,0)),2)*-1 vatcollected "
			+ " from my_jvtran jv inner join gl_invmode invhead on"+  
			" jv.acno=invhead.acno inner join ws_invm inv on (jv.tr_no=inv.tr_no) left join my_acbook ac on (inv.invoicetoacno=ac.acno and"+
			" ac.dtype='CRM' and ac.status=3) left join my_brch br on jv.brhid=br.doc_no left join gl_taxdetail tax on (inv.date between tax.fromdate and"+
			" tax.todate) where jv.status=3 and jv.dtype in ('MNT') "+sqltest+" and jv.id<0 group by jv.tr_no"+
			" union all"+
			" select jv.date,br.branchname,ac.refname,ac.trnnumber,jv.dtype,convert(sale.voc_no,char(25)) vocno,sale.doc_no,round(sum(dramount),2)*-1"+
			" totalvalue,round(sum(if(ac.tax=1 and invhead.idno<>20 and (sale.date between tax.fromdate and tax.todate),"+
			" dramount,0)),2)*-1 vatapplied,0 vatnotapplied,round(sum(if(invhead.idno=20,dramount,0)),2)*-1 vatcollected from my_jvtran jv"+
			" left join gl_invmode invhead on jv.acno=invhead.acno left join gl_vsalem sale on (jv.tr_no=sale.trno) left join my_acbook ac on"+
			" (sale.cldocno=ac.cldocno and ac.dtype='CRM') left join my_brch br on jv.brhid=br.doc_no left join gl_taxdetail tax on"+
			" (sale.date between tax.fromdate and tax.todate) where jv.status=3 and jv.dtype='VSI' "+sqltest+" and jv.id<0 group by"+
			" jv.tr_no union all"+
			" select date,branchname,refname,trnnumber,jv.dtype,convert(jv.doc_no,char(25)) vocno,jv.doc_no,sum(jv.netamount) netamount,"
			+ " sum(vatapplied) vatapplied ,sum(vatnotapplied) vatnotapplied,sum(jv.dramount) dramount from ( "
			+ " select jv.tr_no,c.date,b.branchname,a.refname,a.trnnumber,jv.dtype,convert(jv.doc_no,char(25)) vocno,jv.doc_no,c.netamount, "
			+ " 0 vatapplied ,0 vatnotapplied,jv.dramount  from my_jvtran jv inner join gl_invmode i on i.idno=20 and jv.acno=i.acno "+
			" inner join my_cnot c on jv.tr_no=c.tr_no inner join my_acbook a on a.acno=c.acno inner join my_brch b on b.doc_no=c.brhid"+ " "
			+ "  where jv.status=3 and  jv.dtype='cno' "+sqltest+" and (rdocno!=0) union all "
			+ " select jv.tr_no,c.date,b.branchname,a.refname,a.trnnumber,jv.dtype,convert(jv.doc_no,char(25)) vocno,jv.doc_no,0 netamount, "
			+ " sum(dramount) vatapplied ,0 vatnotapplied,0 dramount from my_jvtran jv inner join gl_invmode i on i.idno!=20 and "
			+ " jv.acno=i.acno and tax=1 inner join my_cnot c on jv.tr_no=c.tr_no inner join my_acbook a on a.acno=c.acno inner join "
			+ " my_brch b on b.doc_no=c.brhid   where  jv.status=3 and jv.dtype in ('cno','DNO')   "+sqltest+"  and (rdocno!=0) "
			+ " group by jv.tr_no ) jv group by jv.tr_no"

 +"  union all  select a.date ,a.branchname,a.refname,a.trnnumber,a.dtype,convert(a.vocno,char(25)) vocno ,a.doc_no,a.totalvalue ,"
	+ " (a.totalvalue-a.vatcollected) vatapplied,(a.totalvalue-(a.totalvalue-a.vatcollected)-a.vatcollected) vatnotapplied,a.vatcollected "
	+ " from (select m.date,br.branchname,ac.refname,ac.trnnumber,ac.cldocno,jv.brhid,convert(m.voc_no,char(25)) vndinvno ,jv.dtype,"
	+ "  convert(m.voc_no,char(25)) vocno,m.doc_no,"
	+ " round(sum(jv.dramount),2) totalvalue,round(sum(if(ac.tax=1 and jv.acno<>tax.acno   and (m.date between tax.fromdate and tax.todate),"
	+ " jv.dramount,0)),2) vatapplied,0 vatnotapplied,round(sum(coalesce(jv1.dramount,0)),2)*-1 vatcollected from my_srvsalem m inner join"
	+ " my_jvtran jv on (jv.tr_no=m.tr_no and m.acno=jv.acno)  left join my_acbook ac on (m.acno=ac.acno and ac.dtype='CRM')"
	+ "   left join my_brch br on jv.brhid=br.doc_no  left join gl_taxmaster tax on (m.date between tax.fromdate and tax.todate and tax.type=2) "
	+ " left join my_jvtran jv1 on (jv1.tr_no=m.tr_no and tax.acno=jv1.acno) where m.status=3 and m.date>='"+sqlfromdate+"' "
			+ " and m.date<='"+sqltodate+"'   "+sqltest1+"  group by m.tr_no) a "

			
 +"  union all select m.date,br.branchname,ac.refname,ac.trnnumber,m.dtype,convert(m.voc_no,char(100)) vocno,m.doc_no ,totalvalue,vatapplied,vatnotapplied, vatcollected "
					+ " from my_invm  m left join (select sum(nettotal+taxamount)   totalvalue, sum(taxamount) vatcollected ,rdocno from my_invd group by rdocno) d1 "
					+ " on d1.rdocno=m.doc_no left join (select sum(nettotal) vatapplied,rdocno from my_invd  where taxamount>0 group by rdocno) d2 "
					+ " on d2.rdocno=m.doc_no left join (select sum(nettotal)   vatnotapplied,rdocno from my_invd where taxamount=0 group by rdocno) d3 "
					+ "	on d3.rdocno=m.doc_no  left join my_acbook ac on ac.cldocno=m.cldocno and ac.dtype='crm' left join my_brch br on br.doc_no=m.brhid where  m.status=3 and m.date>='"+sqlfromdate+"' and   m.date<='"+sqltodate+"' "+sqltest1+" group by m.doc_no "
					+ " union all select m.date,br.branchname,ac.refname,ac.trnnumber,m.dtype,convert(m.voc_no,char(100))  vocno,m.doc_no ,totalvalue,vatapplied,vatnotapplied, vatcollected  "
					+ " from my_invr  m left join (select sum(nettotal+taxamount)   totalvalue,sum(taxamount) vatcollected ,rdocno from my_inrd group by rdocno) d1 "
					+ " On d1.rdocno=m.doc_no left join (select sum(nettotal)   vatapplied,rdocno from my_inrd  where taxamount>0 group by rdocno) d2 "
					+ " on d2.rdocno=m.doc_no left join (select sum(nettotal)   vatnotapplied,rdocno from my_inrd where taxamount=0 group by rdocno) d3 "
					+ " on d3.rdocno=m.doc_no left join my_invm inv on inv.doc_no=m.rrefno left join my_acbook ac on ac.cldocno=m.cldocno and ac.dtype='crm' left join my_brch br on br.doc_no=m.brhid where  m.status=3 and m.date>='"+sqlfromdate+"' and   m.date<='"+sqltodate+"' "+sqltest1+" "
					+ " group by m.doc_no "
					+ " union all select m.date,br.branchname,h.description refname,0 trnnumber,m.dtype,convert(m.doc_no,char(25))vocno,m.refno doc_no,"
					+ " sum(if(d.nettotal<0,d.nettotal*-1,d.nettotal)*-1)  totalvalue,"
			        + " sum(if(taxamount!=0,if(d.amount<0,d.amount*-1,d.amount)*-1,0)) vatapplied,"
					+ " sum(if(taxamount=0,if(d.amount<0,d.amount*-1,d.amount)*-1,0))  vatnotapplied,"
			        + " sum(coalesce(if(d.taxamount<0,d.taxamount*-1,d.taxamount)*-1,0))  vatcollected from my_cnot m left join my_cnotd d " + "on m.tr_no=d.tr_no "
			        + " left join my_head h on h.doc_no=m.acno left join my_brch br on m.brhid=br.doc_no where m.status=3 and  m.dtype='TCN' and  m.date between '"+sqlfromdate+"' and '"+sqltodate+"' "+sqltest1+"  group by m.tr_no	) a ";
			//System.out.println("outputexcel"+strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			data=objcommon.convertToEXCEL(rs);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return data;
	}
	

	public JSONArray getVatInputExcelData(String id,String branch,String fromdate,String todate) throws SQLException
	{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="",sqltest="",sqltest1="";
			java.sql.Date sqlfromdate=null,sqltodate=null;
			if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
				sqltest+=" and jv.brhid="+branch;
				sqltest1+=" and m.brhid="+branch;

			}
			if(!fromdate.equalsIgnoreCase("")){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
				/*sqltest+=" and jv.date>='"+sqlfromdate+"'";*/
			}
			if(!todate.equalsIgnoreCase("")){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
				/*sqltest+=" and jv.date<='"+sqltodate+"'";*/
			}
			strsql="select a.branchname 'Branch',date_format(a.date,'%d.%m.%Y') 'Date',a.refname 'Vendor',a.trnnumber 'TRN',a.dtype 'Doc Type',a.vocno "+
			" 'Doc No',coalesce(a.vndinvno,'') 'Vendor Inv No',a.totalvalue 'Total Amount',(a.totalvalue-a.vatcollected) 'VAT 5% Purchase',"+
			" (a.totalvalue-(a.totalvalue-a.vatcollected)-a.vatcollected) 'VAT 0% Purchase', a.vatcollected 'VAT Paid' "+
			" from ("+
			" select convert(m.purno,char(25)) vndinvno,m.date,br.branchname,ac.refname,ac.trnnumber,jv.dtype,convert(m.voc_no,char(25)) vocno,m.doc_no,round(sum(jv.dramount),2)*-1 "+
			" totalvalue,round(sum(if(ac.tax=1 and jv.acno<>tax.acno and (m.date between tax.fromdate and tax.todate), jv.dramount,0)),2)*-1 "+
			" vatapplied,0 vatnotapplied, round(sum(coalesce(jv1.dramount,0)),2) vatcollected from gl_vpurm m inner join my_jvtran jv on "+
			" (jv.tr_no=m.tr_no and m.venid=jv.acno  and dramount<0) left join my_acbook ac on (m.venid=ac.acno and ac.dtype='VND')"+
			" left join my_brch br on jv.brhid=br.doc_no left join gl_taxmaster tax on (m.date between tax.fromdate and tax.todate and "+
			" tax.type=1 and per>0) left join my_jvtran jv1 on (jv1.tr_no=m.tr_no and tax.acno=jv1.acno) where m.status=3 and "+
			" m.date>='"+sqlfromdate+"' and m.date<='"+sqltodate+"' and m.tr_no is not null "+sqltest+" group by m.tr_no union all"+
			" select convert(m.invno,char(25)) vndinvno,m.date,br.branchname,ac.refname,ac.trnnumber,jv.dtype,convert(m.voc_no,char(25)) vocno,m.doc_no,round(sum(jv.dramount),2)*-1 "+
			" totalvalue,round(sum(if(ac.tax=1 and jv.acno<>tax.acno and (m.date between tax.fromdate and tax.todate), jv.dramount,0)),2)*-1 "+
			" vatapplied,0 vatnotapplied, round(sum(coalesce(jv1.dramount,0)),2) vatcollected from gl_vpurdirm m inner join my_jvtran jv on "+
			" (jv.tr_no=m.tr_no and m.venid=jv.acno  and dramount<0) left join my_acbook ac on (m.venid=ac.acno and ac.dtype='VND') left join "+
			" my_brch br on jv.brhid=br.doc_no left join gl_taxmaster tax on (m.date between tax.fromdate and tax.todate and tax.type=1 and per>0)"+
			" left join my_jvtran jv1 on (jv1.tr_no=m.tr_no and tax.acno=jv1.acno) where m.status=3 and m.date>='"+sqlfromdate+"' and "+
			" m.date<='"+sqltodate+"' and m.tr_no is not null "+sqltest+" group by m.tr_no union all"+
			" select convert(m.invno,char(25)) vndinvno,m.date,br.branchname,ac.refname,ac.trnnumber,jv.dtype,convert(m.voc_no,char(25)) vocno,m.doc_no,round(sum(jv.dramount),2)*-1 "+
			" totalvalue,round(sum(if(ac.tax=1 and jv.acno<>tax.acno and (m.date between tax.fromdate and tax.todate), jv.dramount,0)),2)*-1 "+
			" vatapplied,0 vatnotapplied, round(sum(coalesce(jv1.dramount,0)),2) vatcollected from gl_vmcostm m inner join gl_garrage g on "+
			" m.gargid=g.doc_no inner join my_jvtran jv on (jv.tr_no=m.trno and jv.acno=g.acc_no  and dramount<0) left join my_acbook ac on "+
			" (ac.acno=g.acc_no and ac.dtype='VND') left join my_brch br on  jv.brhid=br.doc_no left join gl_taxmaster tax on (m.date between "+
			" tax.fromdate and tax.todate and tax.type=1 and per>0) left join my_jvtran jv1 on (jv1.tr_no=m.trno and tax.acno=jv1.acno) where "+
			" m.status=3 and m.date>='"+sqlfromdate+"' and m.date<='"+sqltodate+"' and m.trno is not null "+sqltest+" group by m.trno "
						+ "  union all select m.refinvno invno,m.date,br.branchname,ac.refname,ac.trnnumber,m.dtype,convert(m.voc_no,char(100)) vocno ,m.doc_no,totalvalue,vatapplied,vatnotapplied, vatcollected "
				+ " from my_srvm  m left join (select sum(nettotal+taxamount)   totalvalue, sum(taxamount) vatcollected ,rdocno from my_srvd group by rdocno) d1 "
				+ " on d1.rdocno=m.doc_no left join (select sum(nettotal)  vatapplied,rdocno from my_srvd  where taxamount>0 group by rdocno) d2 "
				+ " on d2.rdocno=m.doc_no "
				+ " left join (select sum(nettotal)   vatnotapplied,rdocno from my_srvd where taxamount=0 group by rdocno) d3 "
				+ " on d3.rdocno=m.doc_no left join my_acbook ac on ac.cldocno=m.cldocno and ac.dtype='VND' left join my_brch br on br.doc_no=m.brhid  where  m.status=3 and m.date>='"+sqlfromdate+"' and   m.date<='"+sqltodate+"' "+sqltest1+"  group by m.doc_no "
				+ " union all   select  inv.refinvno invno,m.date,br.branchname,ac.refname,ac.trnnumber,m.dtype,convert(m.voc_no,char(100)) vocno,m.doc_no,totalvalue*-1,vatapplied*-1,vatnotapplied, vatcollected*-1 vatcollected "
				+ " from my_srrm  m left join (select sum(nettotal+taxamount)   totalvalue,sum(taxamount) vatcollected ,rdocno from my_srrd group by rdocno) d1 "
				+ " on d1.rdocno=m.doc_no left join (select sum(nettotal)   vatapplied,rdocno from my_srrd  where taxamount>0 group by rdocno) d2 "
				+ "on d2.rdocno=m.doc_no left join (select sum(nettotal)   vatnotapplied,rdocno from my_srrd where taxamount=0 group by rdocno) d3 "
				+ "on d3.rdocno=m.doc_no  left join my_srvm inv on inv.doc_no=m.rrefno  left join my_acbook ac on ac.cldocno=m.cldocno and ac.dtype='VND' left join my_brch br on br.doc_no=m.brhid  "
				+ "where  m.status=3 and m.date>='"+sqlfromdate+"' and   m.date<='"+sqltodate+"' "+sqltest1+"  group by m.doc_no "
					+ " union all select convert(m.invno,char(25))  invno,m.date,br.branchname,ac.refname,ac.trnnumber,'CPU' dtype,"
                     + " convert(m.voc_no,char(25)) vocno,m.doc_no,sum(d.nettotal+d.taxamount)  totalvalue,aa.app vatapplied,"
                     +" (sum(d.nettotal+d.taxamount))-aa.app-coalesce(aa.collect,0) vatnotapplied,"
                     +" coalesce(aa.collect,0)  vatcollected from my_srvpurm m left join (select   sum(nettotal) app,sum(taxamount) collect,rdocno"
                     +" from my_srvpurd where taxamount>0 group by rdocno) aa on aa.rdocno=m.doc_no left join (select   sum(nettotal) notapp,rdocno"
                     +" from my_srvpurd where taxamount=0 group by rdocno) bb on bb.rdocno=m.doc_no left join my_srvpurd d on d.rdocno=m.doc_no"
                     +" left join my_acbook ac on (m.acno=ac.acno and ac.dtype='VND') left join my_brch br on m.brhid=br.doc_no"
                     +" where  m.status=3 and m.date>='"+sqlfromdate+"' and   m.date<='"+sqltodate+"' "+sqltest1+"   group by m.tr_no "
                     
                     + " union all select convert(m.invno,char(25))  invno,m.date,br.branchname,ac.refname,ac.trnnumber,'CPR' dtype, convert(m.voc_no,char(25)) vocno,m.doc_no,if(sum(d.nettotal+d.taxamount)<0,sum(d.nettotal+d.taxamount),sum(d.nettotal+d.taxamount)*-1)  totalvalue,if(aa.app<0,aa.app,aa.app*-1) vatapplied, if(((sum(d.nettotal+d.taxamount))-aa.app-coalesce(aa.collect,0))<0,((sum(d.nettotal+d.taxamount))-aa.app-coalesce(aa.collect,0)),((sum(d.nettotal+d.taxamount))-aa.app-coalesce(aa.collect,0))*-1) vatnotapplied, if(coalesce(aa.collect,0)<0,coalesce(aa.collect,0),coalesce(aa.collect,0)*-1)  vatcollected from my_srvpurretm m left join (select   sum(nettotal) app,sum(taxamount) collect,rdocno from my_srvpurretd where taxamount>0 group by rdocno) aa on aa.rdocno=m.doc_no left join (select   sum(nettotal) notapp,rdocno from my_srvpurretd where taxamount=0 group by rdocno) bb on bb.rdocno=m.doc_no left join my_srvpurretd d on d.rdocno=m.doc_no left join my_acbook ac on (m.acno=ac.acno and ac.dtype='VND') left join my_brch br on m.brhid=br.doc_no "
                     + " where  m.status=3 and m.date>='"+sqlfromdate+"' and   m.date<='"+sqltodate+"' "+sqltest1+"    group by m.tr_no"
                      + "  union all"
						+ " select  convert(m.refno,char(150)) invno,m.date,br.branchname,h.description refname,0 trnnumber,m.dtype,convert(m.doc_no,char(25)) vocno,m.tr_no,"
						+ " sum(if(d.nettotal<0,d.nettotal*-1,d.nettotal))"  
						+ " totalvalue,sum(if(taxamount!=0,if(d.amount<0,d.amount*-1,d.amount),0)) vatapplied,"
						+ " sum(if(taxamount=0,if(d.amount<0,d.amount*-1,d.amount),0))  vatnotapplied,"
						+ " sum(coalesce(if(d.taxamount<0,d.taxamount*-1,d.taxamount),0))  vatcollected from my_cnot m left join my_cnotd d on" 
						+ " m.tr_no=d.tr_no left join my_head h on h.doc_no=m.acno "
						+ " left join my_brch br on m.brhid=br.doc_no where m.status=3 and m.dtype='TDN' "
						+ "and  m.date between '"+sqlfromdate+"' and '"+sqltodate+"' "+sqltest1+"  group by m.tr_no) a ";  
			//System.out.println("inputexcel "+strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			data=objcommon.convertToEXCEL(rs);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return data;
	}

}
