package com.dashboard.workshop.partspurchase;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Enumeration;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsPartsPurchaseDAO {

	ClsConnection objconn = new ClsConnection();
	ClsCommon objcommon = new ClsCommon();

	public JSONArray getPartsPlanData(String id, String brhid, String filter) throws SQLException {
		JSONArray data = new JSONArray();
		if (!id.trim().equalsIgnoreCase("1")) {
			return data;
		}
		Connection conn = null;
		
		try {
			conn = objconn.getMyConnection();
			String sqlfilters = "";
			if (!brhid.trim().equalsIgnoreCase("") && !brhid.trim().equalsIgnoreCase("a")) {
				sqlfilters += " and job.brhid=" + brhid;
			}

			if (filter.trim().equalsIgnoreCase("PNDG")) {
				sqlfilters += " and est.doc_no in (select distinct rdocno from ws_estspare where approved=1 and (coalesce(qty,0)-(coalesce(goodsissueqty,0)+coalesce(cotqty,0)+coalesce(nipoqty,0)))>0)";

			} else if (filter.trim().equalsIgnoreCase("NICDPNDG")) {
				sqlfilters += " and est.doc_no in (select distinct rdocno from ws_estspare where approved=1 and (coalesce(qty,0)-(coalesce(goodsissueqty,0)+coalesce(nipurchaseqty,0)))>0 and coalesce(cotqty,0)>0)";
				
			} else if (filter.trim().equalsIgnoreCase("NIPOPNDG")) {
				sqlfilters += " and est.doc_no in (select distinct rdocno from ws_estspare where approved=1 and (coalesce(qty,0)-(coalesce(goodsissueqty,0)+coalesce(nipurchaseqty,0)))>0 and coalesce(nipoqty,0)>0)";

			}

			String strsql = "select gate.processstatus,sp.comp gistatus,gate.regno,ac.cldocno,job.doc_no jobdocno,job.voc_no jobvocno,job.date,est.doc_no estdocno,est.voc_no estvocno,gate.doc_no gatedocno,"
					+ " gate.voc_no gatevocno,br.doc_no brhid,br.branchname branch,concat(ac.refname,' , Address: ',ac.address,' , Telephone: ',"
					+ " ac.per_tel,' , Mobile: ',ac.per_mob,' , Mail: ',ac.mail1,' , Contact Person ',ac.contactperson) userdetails,"
					+ " convert(concat(coalesce(brd.brand_name,''),' ',coalesce(model.vtype,''),' Reg No: ',coalesce(gate.regno,''),' Plate Code: ',"
					+ " coalesce(gate.pltid,''),' YoM: ',coalesce(yom.yom,''),' Others: ',coalesce(gate.vehother,'')),char(200)) vehicledetails, "
					+ " coalesce(spt.qty,0)qty, coalesce(spt.issueqty,0)issueqty, coalesce(spt.cotqty,0)cotqty, coalesce(spt.nipoqty,0)nipoqty, coalesce(spt.niqty,0)niqty,"
					+ " coalesce(spt.balqty,0)balqty, coalesce(spt.nibalqty,0)nibalqty "
					+ " from ws_jobcard job left join ws_estm est on job.reftype='EST' and job.refno=est.doc_no left join ws_gateinpass gate on"
					+ " est.gipno=gate.doc_no left join my_brch br on job.brhid=br.doc_no left join my_acbook ac on"
					+ " (gate.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_vehbrand brd on gate.brdid=brd.doc_no "
					+ " left join gl_vehmodel model on gate.modid=model.doc_no left join gl_vehplate plate on gate.pltid=plate.doc_no "
					+ " left join gl_yom yom on gate.yom=yom.doc_no left join (select if(sum(qty- goodsissueqty)<=0,1,0) comp,rdocno from ws_estspare where approved=1 group by rdocno) sp on (est.doc_no=sp.rdocno) "
					+ " left join (select sum(coalesce(qty,0))qty, sum(coalesce(goodsissueqty,0))issueqty, sum(coalesce(cotqty,0))cotqty, sum(coalesce(nipoqty,0))nipoqty, sum(coalesce(nipurchaseqty,0))niqty, rdocno, "
					+ " sum(if((coalesce(qty,0)-(coalesce(goodsissueqty,0)+coalesce(cotqty,0)+coalesce(nipoqty,0)))>0,(coalesce(qty,0)-(coalesce(goodsissueqty,0)+coalesce(cotqty,0)+coalesce(nipoqty,0))),0))balqty,"
					+ " sum(if((coalesce(qty,0)-(coalesce(nipurchaseqty,0)+coalesce(goodsissueqty,0)))>0,(coalesce(qty,0)-(coalesce(nipurchaseqty,0)+coalesce(goodsissueqty,0))),0))nibalqty"
					+ " from ws_estspare where approved=1 group by rdocno) spt on est.doc_no=spt.rdocno "
					+ " where job.partsconfirm=0 and coalesce(spt.rdocno,0)!=0 " + sqlfilters;
			
			ResultSet rs = conn.createStatement().executeQuery(strsql);
			data = objcommon.convertToJSON(rs);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			conn.close();
		}
		return data;
	}

	public JSONArray getPartsData(String estdocno, String id, String brhid) throws SQLException {
		JSONArray data = new JSONArray();
		if (!id.trim().equalsIgnoreCase("1")) {
			return data;
		}
		Connection conn = null;
		try {
			conn = objconn.getMyConnection();

			String strsql = "select nipoqty hidnipoqty, coalesce(round(b.stock,2),0)stock,bh.* from (select sp.rdocno,if(sp.purchaseprice>0, sp.purchaseprice, sp.nipoprice)purchaseprice,sp.purchasereqdocno,sp.nipurchasedocno,sp.rowno,sp.psrno,sp.qty,(sp.sptotal/sp.qty) rate,sp.description,m.productname,m.doc_no prdid,at.mspecno as specid,m.munit as unitdocno,"
					+ "coalesce(sp.goodsissueqty,0) issqty, coalesce(sp.qty,0)-(coalesce(sp.goodsissueqty,0))issuebalqty, coalesce(sp.cotqty,0) cdqty, coalesce(sp.nipoqty,0)nipoqty, "
					+ "coalesce(sp.qty,0)-(coalesce(sp.goodsissueqty,0)+coalesce(sp.cotqty,0)+coalesce(sp.nipoqty,0))balqty,coalesce(sp.nipurchaseqty,0)niqty, coalesce(sp.qty,0)-(coalesce(sp.nipurchaseqty,0)+coalesce(sp.goodsissueqty,0))nibalqty "
					+ "from ws_estspare sp left join my_main m on sp.psrno=m.psrno left join my_unitm u on m.munit=u.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) "
					+ "where sp.rdocno=" + estdocno
					+ " and sp.approved=1)bh left join (select round(sum((op_qty-out_qty-rsv_qty-del_qty)+(foc-foc_out)),2)stock,psrno "
					+ "from my_prddin where brhid=" + brhid + " group by psrno)b on b.psrno=bh.psrno;";

			ResultSet rs = conn.createStatement().executeQuery(strsql);
			data = objcommon.convertToJSON(rs);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			conn.close();
		}
		return data;
	}

	public JSONArray getNiPendingJobs(String id, String brhid) throws SQLException {
		JSONArray data = new JSONArray();
		if (!id.trim().equalsIgnoreCase("1")) {
			return data;
		}
		Connection conn = null;
		try {
			conn = objconn.getMyConnection();
			String sqlfilters = "";
			if (!brhid.trim().equalsIgnoreCase("") && !brhid.trim().equalsIgnoreCase("a")) {
				sqlfilters += " and job.brhid=" + brhid;
			}
			
			String strsql = "select job.voc_no jobvocno,ac.RefName clientname,\r\n" + 
					"convert(concat(coalesce(brd.brand_name,''),' ',coalesce(model.vtype,''),' Reg No: ',coalesce(gate.regno,''),\r\n" + 
					"' Plate Code: ', coalesce(gate.pltid,''),' YoM: ',coalesce(yom.yom,''),' Others: ',coalesce(gate.vehother,'')),char(200)) vehicledetails,\r\n" + 
					"toac.Description cotaccount, ct.doc_no cotdocno, ct.date cotdate, coalesce(m.productname,spt.description)productname, sptd.qty cotqty, sptd.price cotamount\r\n" + 
					"from ws_jobcard job left join ws_estm est on job.reftype='EST' and job.refno=est.doc_no \r\n" + 
					"left join ws_gateinpass gate on est.gipno=gate.doc_no left join my_acbook ac on (gate.cldocno=ac.cldocno and ac.dtype='CRM') \r\n" + 
					"left join gl_vehbrand brd on gate.brdid=brd.doc_no left join gl_vehmodel model on gate.modid=model.doc_no \r\n" + 
					"left join gl_vehplate plate on gate.pltid=plate.doc_no left join gl_yom yom on gate.yom=yom.doc_no \r\n" + 
					"left join ws_estspare spt on spt.approved=1 and est.doc_no=spt.rdocno left join my_main m on spt.psrno=m.psrno \r\n" + 
					"left join ws_estsparepurchased sptd on sptd.estdocno=est.doc_no and sptd.estspare_rowno=spt.rowno and sptd.dtype='COT'\r\n" + 
					"left join my_contratrans ct on ct.doc_no=sptd.doc_no left join my_head toac on toac.DOC_NO=ct.acno_to\r\n" + 
					"where gate.processstatus<6 and spt.cotqty>0 and (spt.qty-(spt.goodsissueqty+spt.nipurchaseqty))>0 \r\n" + 
					 sqlfilters + " order by job.voc_no,spt.srno\r\n";
			
			ResultSet rs = conn.createStatement().executeQuery(strsql);
			data = objcommon.convertToJSON(rs);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			conn.close();
		}
		return data;
	}

	public JSONArray getPartsSearchData(String id, String partno, String prdctnme, String stock, String unit)
			throws SQLException {
		JSONArray partsdata = new JSONArray();
		if (!id.equalsIgnoreCase("1")) {
			return partsdata;
		}
		Connection conn = null;
		try {
			conn = objconn.getMyConnection();
			Statement stmt = conn.createStatement();
			String sqltest = "";
			if (!(partno.equalsIgnoreCase("undefined")) && !(partno.equalsIgnoreCase(""))
					&& !(partno.equalsIgnoreCase("0"))) {
				sqltest += sqltest + " and a.partno like '%" + partno + "%'";
			}
			if (!(prdctnme.equalsIgnoreCase("undefined")) && !(prdctnme.equalsIgnoreCase(""))
					&& !(prdctnme.equalsIgnoreCase("0"))) {
				sqltest += sqltest + " and a.productname like '%" + prdctnme + "%'";
			}
			if (!(stock.equalsIgnoreCase("undefined")) && !(stock.equalsIgnoreCase(""))
					&& !(stock.equalsIgnoreCase("0"))) {
				// sqltest+=sqltest+" and a.balqty like '%"+stock+"%'";
			}
			if (!(unit.equalsIgnoreCase("undefined")) && !(unit.equalsIgnoreCase(""))
					&& !(unit.equalsIgnoreCase("0"))) {
				sqltest += sqltest + " and a.unit like '%" + unit + "%'";
			}
			String strsql = "select coalesce(round(b.stock,2),0)stock,a.* from (select m.doc_no prdid,at.mspecno as specid,bd.brandname,m.fixingprice,m.psrno partdocno,m.part_no partno,m.productname,m.doc_no,"
					+ " u.unit,m.munit as unitdocno,m.psrno,'' qty"
					+ " from my_main m left join my_unitm u on m.munit=u.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd"
					+ " on m.brandid=bd.doc_no where m.status=3) a left join (select round(sum((op_qty-out_qty-rsv_qty-del_qty)+(foc-foc_out)),2)stock,psrno from my_prddin group by psrno)b on b.psrno=a.psrno  where 1=1 "
					+ sqltest + " ";

			ResultSet rs = stmt.executeQuery(strsql);
			partsdata = objcommon.convertToJSON(rs);
			stmt.close();
		} catch (Exception e) {
			e.printStackTrace();
			conn.close();
		} finally {
			conn.close();
		}
		return partsdata;
	}

	public JSONArray accountGridsearch(String type) throws SQLException {

		JSONArray RESULTDATA = new JSONArray();
		Connection conn = null;
		try {
			conn = objconn.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = ("select t.gr_type grtype,t.doc_no,t.account,t.description,c.code curr,c.doc_no curid,c.c_rate, if(den=604,'CASH','BANK')type "
					+ "from my_head t left join my_curr c on t.curid=c.doc_no where atype='" + type
					+ "' and den in (604,305) and m_s=0;");

			ResultSet resultSet = stmt.executeQuery(sql);

			RESULTDATA = objcommon.convertToJSON(resultSet);

			stmt.close();
			conn.close();

		} catch (Exception e) {
			conn.close();
			e.printStackTrace();
		}
		return RESULTDATA;
	}

	public JSONArray getEstimationDetails(String docno) throws SQLException {

		JSONArray RESULTDATA = new JSONArray();
		Connection conn = null;
		try {
			conn = objconn.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "select *, 'Print' print from (select m.brhid, m.doc_no, d.dtype, m.voc_no, m.date, m.nettotal, d.estdocno \r\n"
					+ "from my_gism m inner join ws_estsparepurchased d on d.doc_no=m.doc_no and d.dtype='GIS'\r\n"
					+ "union all select m.brhid, m.doc_no, d.dtype, m.doc_no, m.date, m.dramount, d.estdocno \r\n"
					+ "from my_contratrans m inner join ws_estsparepurchased d on d.doc_no=m.doc_no and d.dtype='COT'\r\n"
					+ "union all select m.brhid, m.doc_no, d.dtype, m.voc_no, m.date, m.netamount, d.estdocno \r\n"
					+ "from my_srvlpom m inner join ws_estsparepurchased d on d.doc_no=m.doc_no and d.dtype='NPO'\r\n"
					+ "union all select m.brhid, m.doc_no, d.dtype, m.voc_no, m.date, m.netamount, d.estdocno \r\n"
					+ "from my_srvpurm m inner join ws_estsparepurchased d on d.doc_no=m.doc_no and d.dtype='CPU')t\r\n"
					+ "where t.estdocno=" + docno
					+ " group by t.dtype, t.doc_no order by field (t.dtype, 'GIS','COT','NPO','CPU');";

			ResultSet resultSet = stmt.executeQuery(sql);

			RESULTDATA = objcommon.convertToJSON(resultSet);

			stmt.close();
			conn.close();

		} catch (Exception e) {
			conn.close();
			e.printStackTrace();
		}
		return RESULTDATA;
	}

	public JSONArray refnosearch(HttpSession session, String sparerownos) throws SQLException {

		JSONArray RESULTDATA = new JSONArray();
		Enumeration<String> Enumeration = session.getAttributeNames();
		int a = 0;
		while (Enumeration.hasMoreElements()) {
			if (Enumeration.nextElement().equalsIgnoreCase("BRANCHID")) {
				a = 1;
			}
		}
		if (a == 0) {
			return RESULTDATA;
		}
		String brcid = session.getAttribute("BRANCHID").toString();
		Connection conn = null;
		try {
			conn = objconn.getMyConnection();
			Statement stmt = conn.createStatement();
			
			String pySql = "select coalesce(m.typeid,0) typeid,coalesce(p.ptype,'') ptype,coalesce(p.per,0) per,m.doc_no,m.voc_no,m.date,m.netamount,m.type,m.acno,m.refno,m.curid,m.rate,m.delterm,m.payterm,m.deldate,m.desc1,h.description,h.cldocno,h.account "
					+ " from my_srvlpom m inner join my_srvlpod d on d.rdocno=m.doc_no"
					+ " left join (select p.doc_no,p.producttype ptype,m.per,m.acno taxaccount from my_ptype p "
					+ " left join gl_taxmaster m on p.doc_no=m.typeid and m.type=1 where m.type=1 and p.status=3 group by p.doc_no and m.typeid>0) p on p.doc_no=m.typeid "
					+ " left join my_head h on h.doc_no=m.acno where m.status=3 and d.qty-out_qty>0 "
					+ " and m.doc_no in (select doc_no from ws_estsparepurchased where dtype='NPO' and estspare_rowno in ("+sparerownos+"))"
					+ " group by m.doc_no";
			
			ResultSet resultSet = stmt.executeQuery(pySql);

			RESULTDATA = objcommon.convertToJSON(resultSet);
			stmt.close();
			conn.close();

		} catch (Exception e) {
			e.printStackTrace();
			conn.close();
		}
		return RESULTDATA;
	}
	
}
