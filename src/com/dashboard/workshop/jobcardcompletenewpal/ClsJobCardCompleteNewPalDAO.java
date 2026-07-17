package com.dashboard.workshop.jobcardcompletenewpal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.common.ClsAmountToWords;
import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.operations.commtransactions.invoice.ClsManualInvoiceDAO;
import com.workshop.wsinvoice.ClsWSInvoiceBean;

import net.sf.json.JSONArray;

public class ClsJobCardCompleteNewPalDAO {
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	
public JSONArray clientData(String clientname,String id) throws SQLException{
		
		JSONArray RESULTDATA=new JSONArray();

		if(!(id.equalsIgnoreCase("1"))) {
        	return RESULTDATA;
        }
		
		Connection conn =null;
        
		try {
			conn=objconn.getMyConnection();

			Statement stmt = conn.createStatement ();
        	
			String sqltest="";
			if(!clientname.equalsIgnoreCase("")){
				sqltest+=" and refname like '%"+clientname+"%'";
			}
			String sqlqry= "select refname clientname,cldocno from my_acbook where dtype='CRM' and status='3'"+sqltest;
			System.out.println("sqlqry ="+sqlqry);
			ResultSet resultSet = stmt.executeQuery(sqlqry);
			
			RESULTDATA=objcommon.convertToJSON(resultSet);
			
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
	
	return RESULTDATA;
	}
	public JSONArray getSparepartsData(String docno,String id,String savestatus) throws SQLException
	{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			/*String strsql="select description, qty, genuinerate, marketrate, usedrate, genuinetotal, markettotal, usedtotal, approval, approvedvalue from ws_estspare where rdocno="+docno+" and addition=0";*/
			String strsql="";
			if(savestatus.equalsIgnoreCase("1")){
				strsql="select cs.detdocno,cs.dettype,cs.chkcomplete,cs.description,cs.qty, cs.esttotal, cs.costtotal, cs.profitpercent catprofitpercent, cs.invoiceamt, cs.customeramt,main.part_no partno,main.productname partname,cs.psrno,cs.addition from ws_jccspare cs left join my_main main on cs.psrno=main.psrno where cs.jobcarddocno="+docno;
			}
			else{
				/*strsql="select spr.description,m.part_no partno,m.productname partname,m.psrno,m.munit unitdocno,spr.qty , spr.total esttotal ,"+
						" jc.price costtotal,cl.wsprofitpercent catprofitpercent,cl.wsprofitpercent*jc.price invoiceamt,((cl.wsprofitpercent/100)*jc.price)+jc.price customeramt  from "+
						" ws_estm em inner JOIN  (select description, remarks,rdocno ,psrno, sum(qty)  qty,SUM(approvedvalue) total from ws_estspare group "+
						" by rdocno,psrno ) spr on spr.rdocno=em.doc_no inner JOIN ws_gateinpass gip on (gip.doc_no=em.gipno ) inner JOIN ws_jobcard jb "+
						" on (jb.refno=em.gipno and jb.reftype='gip') or (jb.refno=em.doc_no and jb.reftype='est') left join ( SELECT COSTDOCNO,p.PSRNO,"+
						" SUM(p.QTY) qty ,sum(p.cost_price*p.qty) price  FROM MY_gisM M inner JOIN MY_gisd D ON M.DOC_NO=D.RDOCNO inner join MY_prddout p "+
						" on p.tr_no=d.tr_no and d.psrno=p.psrno WHERE M.STATUS=3 and costtype=9 GROUP BY COSTDOCNO,PSRNO) jc on jc.costdocno=jb.doc_no"+
						" and jc.psrno=spr.psrno left join my_main m on spr.psrno=m.psrno or jc.psrno=m.psrno left join my_prodattrib p on m.psrno=p.mpsrno"+
						" left join my_acbook a on a.cldocno= gip.cldocno and a.dtype='crm' left join my_clcatm cl on cl.doc_no=a.catid "+
						" where spr.psrno!=0 and em.doc_no="+docno;*/
/*				strsql="SELECT JCNO, ESTNO,description,m.part_no partno,m.productname partname,m.psrno,m.munit unitdocno, IF(ESTQTY=0, QTY,ESTQTY) "+
				" QTY,esttotal,price costtotal , cl.wsprofitpercent catprofitpercent,((cl.wsprofitpercent/100)*prod.price)+prod.price invoiceamt,"+
				" ((cl.wsprofitpercent/100)*prod.price)+prod.price customeramt,convert(addition,char(10)) addition FROM (select JCNO,gipno, psrno,ESTNO, SUM(estqty) ESTQTY, SUM(qty) QTY, "+
				" sum(esttotal) esttotal,sum(price) price, description,addition FROM"+
				" (select JB.DOC_no JCNO,em.gipno, EM.DOC_NO ESTNO,psrno, qty estqty,0 qty,approvedvalue esttotal,0 price,description,S.addition"+
				" from ws_estspare S LEFT JOIN WS_ESTM EM ON S.RDOCNO=EM.DOC_NO inner JOIN"+
				" ws_jobcard jb  ON (jb.refno=em.gipno and jb.reftype='gip') or (jb.refno=em.doc_no and jb.reftype='est')"+
				" where jb.doc_no="+docno+" and S.confirmed=1 and S.approved=1 group  by rdocno"+
				"  union ALL SELECT COSTDOCNO JCNO,em.gipno,em.doc_no ESTNO,p.PSRNO, 0 estqty,SUM(p.QTY-d.out_qty) qty ,0 total,sum(p.cost_price*p.qty) price, ' ' desc1,'' addition  FROM MY_gisM M"+
				" left JOIN MY_gisd D ON M.DOC_NO=D.RDOCNO inner join MY_prddout p  on p.tr_no=d.tr_no and d.psrno=p.psrno "
				+ " inner JOIN ws_jobcard jb  ON m.costdocno=jb.doc_no   LEFT JOIN WS_ESTM EM ON  (jb.refno=em.doc_no and jb.reftype='est')  "+
				" WHERE M.STATUS=3 and costtype=9 and p.QTY-d.out_qty>0  and costdocno="+docno+" GROUP BY m.COSTDOCNO,PSRNO union all"+
				//Getting NI
				" select orderdocno JCNO,em.gipno,em.doc_no ESTNO,0, 0 estqty,SUM(d.qty) qty ,0 total,sum(d.nettotal) price,"+
				" d.desc1,'' addition from my_srvpurm m left join my_srvpurd d on m.doc_no=d.rdocno inner join my_srvlpom pom on (m.reftype='NPO' and"+
				" m.refno=pom.doc_no) inner JOIN ws_jobcard jb  ON (pom.ordertype='WPC' and"+
				" pom.orderdocno=jb.doc_no) LEFT JOIN WS_ESTM EM ON (jb.refno=em.doc_no and jb.reftype='EST') WHERE M.STATUS=3"+
				" and pom.orderdocno="+docno+")A GROUP BY PSRNO ) PROD"+
				" left JOIN ws_gateinpass gip on (gip.doc_no=PROD.gipno ) "+
				" left join my_main m on prod.psrno=m.psrno"+
				" left join my_prodattrib p on m.psrno=p.mpsrno left join my_acbook a on ((gip.insurancecomp>0 and gip.insurcldocno=a.cldocno) or (gip.insurancecomp=0 and gip.cldocno=a.cldocno)) and a.dtype='crm' "+
				" left join my_clcatm cl on cl.doc_no=a.catid";
*/
				strsql="SELECT DETDOCNO,DETTYPE,1 chkcomplete,0 lumsumstatus,JCNO, ESTNO,description,coalesce(m.part_no,'') partno,coalesce(m.productname,'') partname, convert(coalesce(m.psrno,'0'),char(300)) psrno,coalesce(m.munit,'') munit, IF(ESTQTY=0, QTY,ESTQTY)"+
				 " QTY,esttotal,price costtotal , cl.wsprofitpercent catprofitpercent,((cl.wsprofitpercent/100)*prod.price)+prod.price invoiceamt,"+
				 " esttotal customeramt,addition FROM (select DETDOCNO,DETTYPE,JCNO,gipno, psrno,ESTNO, estqty ESTQTY, qty QTY,"+
				 " esttotal esttotal,price price, description,addition FROM"+
				 " (select S.ROWNO DETDOCNO,'ESP' DETTYPE,JB.DOC_no JCNO,em.gipno, EM.DOC_NO ESTNO,psrno, qty estqty,0 qty,approvedvalue esttotal,0 price,description,convert(S.addition,char(10)) addition"+
				 " from ws_estspare S LEFT JOIN WS_ESTM EM ON S.RDOCNO=EM.DOC_NO inner JOIN"+
				 " ws_jobcard jb  ON (jb.refno=em.gipno and jb.reftype='gip') or (jb.refno=em.doc_no and jb.reftype='est')"+
				 " where jb.doc_no="+docno+" and S.confirmed=1 and S.approved=1"+
				 "  union ALL SELECT D.ROWNO DETDOCNO,'GIS' DETTYPE,COSTDOCNO JCNO,em.gipno,em.doc_no ESTNO,p.PSRNO, 0 estqty,SUM(p.QTY-d.out_qty-coalesce(s.qty,0)) qty ,0 total,sum(p.cost_price*p.qty) price, ' ' desc1,'' addition  FROM MY_gisM M"+
				 " left JOIN MY_gisd D ON M.DOC_NO=D.RDOCNO inner join MY_prddout p  on p.tr_no=d.tr_no and d.psrno=p.psrno"+
				 " inner JOIN ws_jobcard jb  ON m.costdocno=jb.doc_no   LEFT JOIN WS_ESTM EM ON  (jb.refno=em.doc_no and jb.reftype='est') "
				 + " LEFT JOIN (select psrno ,rdocno,sum(qty) qty from ws_estspare group by rdocno,PSRNO) S ON S.RDOCNO=EM.DOC_NO and d.psrno=s.psrno "+
				 " WHERE M.STATUS=3 and costtype=9 and p.QTY-d.out_qty>0 and p.QTY-d.out_qty-coalesce(s.qty,0)>0  and costdocno="+docno+" GROUP BY m.COSTDOCNO,PSRNO )A  ) PROD"+
				 " left JOIN ws_gateinpass gip on (gip.doc_no=PROD.gipno )"+
				 " left join my_main m on prod.psrno=m.psrno"+
				 " left join my_prodattrib p on m.psrno=p.mpsrno left join my_acbook ac on ((gip.insurancecomp>0 and gip.insurcldocno=ac.cldocno and ac.dtype='CRM') or (gip.insurancecomp=0 and gip.cldocno=ac.cldocno and ac.dtype='CRM'))"+
				 " left join my_clcatm cl on cl.doc_no=ac.catid union all"+
				 " select 0 DETDOCNO,'ELP' DETTYPE,1 chkcomplete,-1 lumsumstatus,jb.doc_no jcno, est.doc_no estno,'Lump Sum Amount' description,'' partno,'' partname,0 psrno,'' munit,0 qty,est.lumsumamount esttotal,est.lumsumamount costtotal,"+
				 " 0 catprofitpercent,est.lumsumamount invoiceamt,est.lumsumamount customeramt,'0' addition from ws_jobcard jb left join ws_estm est ON (jb.refno=est.gipno and jb.reftype='gip') or (jb.refno=est.doc_no and jb.reftype='est') "+
				 " where est.approved=1 and  jb.doc_no="+docno+" and coalesce(est.chklumsum,0)>0 and coalesce(est.chkrandomlumsum,0)=0 union all"+
				 " select 0 DETDOCNO,'ELP' DETTYPE,1 chkcomplete,-2 lumsumstatus,jb.doc_no jcno, est.doc_no estno,'Additional Lump Sum Amount' description,'' partno,'' partname,0 psrno,'' munit,0 qty,est.lumsumamount esttotal,est.lumsumamount costtotal,"+
				 " 0 catprofitpercent,est.lumsumamount invoiceamt,est.lumsumamount customeramt,convert(est.addition,char(10)) addition from ws_jobcard jb left join ws_estmadd est ON (jb.refno=est.doc_no and jb.reftype='est') "+
				 " where est.approved=1 and jb.doc_no="+docno+" and coalesce(est.chklumsum,0)>0 and coalesce(est.chkrandomlumsum,0)=0";
			}
			System.out.println("Spare Query: "+strsql);
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
	
	
	
	
	public JSONArray getJobcardData(String clientname,String fromdate,String todate,String id,String brhid) throws SQLException{
		JSONArray RESULTDATA=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return RESULTDATA;
		}
		Connection conn =null;
		
		try {
			conn=objconn.getMyConnection();
			Statement stmt = conn.createStatement ();
			java.sql.Date sqlfromdate=null;
			java.sql.Date sqltodate=null;
			String sqltest="";
			if(!fromdate.equalsIgnoreCase("")){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
			}
			if(!fromdate.equalsIgnoreCase("")){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
				sqltest+=" and jc.date<='"+sqltodate+"'";
			}
			
			if(!clientname.equalsIgnoreCase("")){
				sqltest+=" and ac.refname like '%"+clientname+"%'";
			}
			if(!brhid.trim().equalsIgnoreCase("") && !brhid.trim().equalsIgnoreCase("a")){
				sqltest+=" and jc.brhid="+brhid;
			}
		/*	coalesce(jc.planstatus,0)*/
			String sqlqry="select br.branchname branch,1 planstatus,jc.voc_no,coalesce(gp.claim,'') claimno,coalesce(gp.lpo,'') lpono,round(coalesce(gp.lpoamount,0),2) lpoamount,es.doc_no estdocno,jc.savestatus,jc.doc_no doc_no, jc.date date, jc.reftype reftype, convert(case when jc.reftype='EST' then es.voc_no when jc.reftype='GIP' then gp.voc_no else ''  end,char(25)) refno, jc.brhid brhid, convert(concat(coalesce(brd.brand_name,''),' ',coalesce(model.vtype,''),' Reg No: ',coalesce(gp.regno,''),' Plate Code: ',"+
			" coalesce(gp.pltid,''),' YoM: ',coalesce(yom.yom,''),' Others: ',coalesce(gp.vehother,'')),char(200)) vehicledetails, concat(coalesce(ac.refname,''),' , Address: ',coalesce(ac.address,''),' , Telephone: ',coalesce(ac.per_tel,''),' , Mobile: ',"+
			" coalesce(ac.per_mob,''),' , Mail: ',coalesce(ac.mail1,''),' , Contact Person ',coalesce(ac.contactperson,'')) userdetails, 'View' as btnview from "+
					"ws_jobcard jc left join ws_estm es on (jc.refno=es.doc_no and jc.reftype='EST') "+
					"left join ws_gateinpass gp on((jc.refno=gp.doc_no and jc.reftype='GIP') or (es.gipno=gp.doc_no and jc.reftype='EST'))"+
					
					"left join my_acbook ac on (gp.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_vehplate plate on gp.pltid=plate.doc_no "+
					"left join gl_vehbrand brd on(gp.brdid=brd.doc_no) left join gl_vehmodel model on brd.doc_no=gp.modid "+
					"left join gl_yom yom on gp.yom=yom.doc_no left join ws_floormgmtdata flr on jc.doc_no=flr.jobdocno left join my_brch br on (br.doc_no=jc.brhid) where jc.status=3 and jc.complete=0 and flr.deliverystatus=1 "+sqltest+" group by jc.doc_no";
			
			System.out.println(clientname+"+++++"+sqlqry);
			
			ResultSet resultSet = stmt.executeQuery(sqlqry);
			
			RESULTDATA=objcommon.convertToJSON(resultSet);
			System.out.println(RESULTDATA);
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
	
	return RESULTDATA;
	}
	
	public JSONArray getJobcardExcelData(String clientname,String fromdate,String todate,String id) throws SQLException{
		JSONArray RESULTDATA=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return RESULTDATA;
		}
		Connection conn =null;
		
		try {
			conn=objconn.getMyConnection();
			Statement stmt = conn.createStatement ();
			java.sql.Date sqlfromdate=null;
			java.sql.Date sqltodate=null;
			String sqltest="";
			if(!fromdate.equalsIgnoreCase("")){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
			}
			if(!fromdate.equalsIgnoreCase("")){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
				sqltest+=" and jc.date<='"+sqltodate+"'";
			}
			
			if(!clientname.equalsIgnoreCase("")){
				sqltest+=" and ac.refname like '%"+clientname+"%'";
			}
			
			
			String sqlqry="select jc.voc_no 'Job Card No',jc.date 'Date',jc.reftype 'Ref Type',if(reftype='EST',es.voc_no,gp.voc_no) 'Ref No',es.voc_no 'Est No',concat(coalesce(ac.refname,''),' , Address: ',coalesce(ac.address,''),' , Telephone: ',coalesce(ac.per_tel,''),' , Mobile: ',"+
			" coalesce(ac.per_mob,''),' , Mail: ',coalesce(ac.mail1,''),' , Contact Person ',coalesce(ac.contactperson,'')) 'User Details', convert(concat(coalesce(brd.brand_name,''),' ',coalesce(model.vtype,''),' Reg No: ',coalesce(gp.regno,''),' Plate Code: ',"+
			" coalesce(gp.pltid,''),' YoM: ',coalesce(yom.yom,''),' Others: ',coalesce(gp.vehother,'')),char(200)) 'Vehicle Details' from "+
					"ws_jobcard jc left join ws_estm es on (jc.refno=es.doc_no and jc.reftype='EST') "+
					"left join ws_gateinpass gp on((jc.refno=gp.doc_no and jc.reftype='GIP') or (es.gipno=gp.doc_no and jc.reftype='EST'))"+
					
					"left join my_acbook ac on (gp.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_vehplate plate on gp.pltid=plate.doc_no "+
					"left join gl_vehbrand brd on(gp.brdid=brd.doc_no) left join gl_vehmodel model on brd.doc_no=gp.modid "+
					"left join gl_yom yom on gp.yom=yom.doc_no left join ws_floormgmtdata flr on jc.doc_no=flr.jobdocno where jc.status=3 and jc.complete=0 and flr.deliverystatus=1 "+sqltest+" group by jc.doc_no";
			
			System.out.println(clientname+"+++++"+sqlqry);
			
			ResultSet resultSet = stmt.executeQuery(sqlqry);
			
			RESULTDATA=objcommon.convertToEXCEL(resultSet);
			
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
	
	return RESULTDATA;
	}
	
	public JSONArray getLabourcostData(String docno,String id,String savestatus)throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="";
			if(savestatus.equalsIgnoreCase("1")){
				strsql="select lab.chkcomplete,lab.rowno,lab.invoiceamt,lab.strjobdesc jobdesc,m.doc_no,m.date,lab.hrs,lab.rate,t.type jobtype,lab.markupper markuppercent,lab.total,lab.remarks,"+
				" lab.jobid from ws_estlabour lab left join ws_estm est on est.doc_no=lab.rdocno left join ws_jobmaster m on (lab.jobid=m.doc_no ) left join ws_jobtype t on lab.jobid=t.doc_no "+
				" where lab.rdocno="+docno+" and lab.confirmed=1 and lab.approved=1 ";
				/*" union all"+
				" select lab.rowno,lab.invoiceamt,lab.strjobdesc jobdesc,m.doc_no,m.date,lab.hrs,lab.rate,t.type jobtype,lab.markupper markuppercent,lab.total,lab.remarks,"+
				" lab.jobid from ws_estlabour lab left join ws_estm est on est.doc_no=lab.rdocno left join ws_jobmaster m on (lab.jobid=m.doc_no ) left join ws_jobtype t on m.jobid=t.doc_no "+
				" where lab.rdocno="+docno+" and lab.confirmed=1 and lab.approved=1 and lab.lumsumstatus>0";*/
			}
			else{
				strsql="select 1 chkcomplete,lab.addition,convert(lab.rowno,char(15)) rowno,coalesce(lab.total,0) invoiceamt,lab.strjobdesc jobdesc,m.doc_no,m.date,lab.hrs,lab.rate,t.type jobtype,lab.markupper markuppercent,lab.total,lab.remarks,"+
				" lab.jobid from ws_estlabour lab left join ws_estm est on est.doc_no=lab.rdocno left join ws_jobmaster m on (lab.jobid=m.doc_no ) left join ws_jobtype t on lab.jobid=t.doc_no "+
				" where  lab.rdocno="+docno+" and lab.confirmed=1 and lab.approved=1  union all"+
				" select 1 chkcomplete,0 addition,convert(-1,char(15)) rowno,if(coalesce(est.chkrandomlumsum,0)>0,coalesce(est.randomlumsumamt,0),coalesce(est.servicelumsumamt,0)) invoiceamt,'Lump Sum Amount' jobdesc,0 doc_no,est.date,0 hrs,0 rate,'' "+
				" jobtype,0 markuppercent,if(coalesce(est.chkrandomlumsum,0)>0,coalesce(est.randomlumsumamt,0),coalesce(est.servicelumsumamt,0)),'' remarks,0 jobid from ws_estm est where est.approved=1 and  est.status=3 and "+
				" (coalesce(est.chkservicelumsum,0)>0 or coalesce(est.chkrandomlumsum,0)>0) and est.doc_no="+docno+" union all"+
				" select 1 chkcomplete,est.addition,convert(-2,char(15)) rowno,if(coalesce(est.chkrandomlumsum,0)>0,coalesce(est.randomlumsumamt,0),coalesce(est.servicelumsumamt,0)) invoiceamt,'Additional Lump Sum Amount' jobdesc,0 doc_no,est.date,0 hrs,0 rate,'' "+
				" jobtype,0 markuppercent,if(coalesce(est.chkrandomlumsum,0)>0,coalesce(est.randomlumsumamt,0),coalesce(est.servicelumsumamt,0)),'' remarks,0 jobid from ws_estmadd est where est.approved=1 and  est.status=3 and "+
				" (coalesce(est.chkservicelumsum,0)>0 or coalesce(est.chkrandomlumsum,0)>0) and est.doc_no="+docno;
			}
			
			System.out.println("Labour Data:"+strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			data=objcommon.convertToJSON(rs);
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

	public JSONArray getExtraData(String estdocno,String id,String savestatus)throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="";
			if(savestatus.equalsIgnoreCase("1")){
				strsql="select description,amount from ws_jccextra where estdocno="+estdocno;
			
			System.out.println("Extra Data:"+strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			data=objcommon.convertToJSON(rs);
			}
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

	public int insert(String estdocno, String docno, String brhid,
			ArrayList<String> labourarray, ArrayList<String> partsarray,ArrayList<String> extraarray,
			HttpSession session, HttpServletRequest request, String mode, String lpono, String claimno, String lpoamount) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmt=conn.createStatement();
			int errorstatus=0;
			String strdelete="delete from ws_jccspare where jobcarddocno="+docno;
			int deleteval=stmt.executeUpdate(strdelete);
			
			String strgetdefaultpsrnoconfig="select method,value from gl_config where field_nme='defaultConsumable'";
			int defaultpsrnomethod=0,defaultpsrno=0;
			ResultSet rsdefaultpsrno=stmt.executeQuery(strgetdefaultpsrnoconfig);
			while(rsdefaultpsrno.next()){
				defaultpsrnomethod=rsdefaultpsrno.getInt("method");
				defaultpsrno=rsdefaultpsrno.getInt("value");
			}
			
			for(int i=0;i<partsarray.size();i++){
				String temp[]=partsarray.get(i).trim().split("::");
				System.out.println("PSRNO:"+partsarray.get(i)+"////");
				temp[0]=temp[0].isEmpty()||temp[0].trim().equalsIgnoreCase("")||temp[0].trim().equalsIgnoreCase("undefined")||temp[0]==null?"":temp[0].trim();
				temp[1]=temp[1].isEmpty()||temp[1].trim().equalsIgnoreCase("")||temp[1].trim().equalsIgnoreCase("undefined")||temp[1]==null?"0":temp[1].trim();
				temp[2]=temp[2].isEmpty()||temp[2].trim().equalsIgnoreCase("")||temp[2].trim().equalsIgnoreCase("undefined")||temp[2]==null?"0":temp[2].trim();
				temp[3]=temp[3].isEmpty()||temp[3].trim().equalsIgnoreCase("")||temp[3].trim().equalsIgnoreCase("undefined")||temp[3]==null?"0":temp[3].trim();
				temp[4]=temp[4].isEmpty()||temp[4].trim().equalsIgnoreCase("")||temp[4].trim().equalsIgnoreCase("undefined")||temp[4]==null?"0":temp[4].trim();
				temp[5]=temp[5].isEmpty()||temp[5].trim().equalsIgnoreCase("")||temp[5].trim().equalsIgnoreCase("undefined")||temp[5]==null?"0":temp[5].trim();
				temp[6]=temp[6].isEmpty()||temp[6].trim().equalsIgnoreCase("")||temp[6].trim().equalsIgnoreCase("undefined")||temp[6]==null?"0":temp[6].trim();
				temp[7]=temp[7].isEmpty()||temp[7].trim().equalsIgnoreCase("")||temp[7].trim().equalsIgnoreCase("undefined")||temp[7]==null?"0":temp[7].trim();
				temp[8]=temp[8].isEmpty()||temp[8].trim().equalsIgnoreCase("")||temp[8].trim().equalsIgnoreCase("undefined")||temp[8]==null?"0":temp[8].trim();
				String lumsumstatus=temp[9].isEmpty()||temp[9].trim().equalsIgnoreCase("")||temp[9].trim().equalsIgnoreCase("undefined")||temp[9]==null?"0":temp[9].trim();
				String chkcomplete=temp[10].isEmpty()||temp[10].trim().equalsIgnoreCase("")||temp[10].trim().equalsIgnoreCase("undefined")||temp[10]==null?"0":temp[10].trim();
				String detdocno=temp[11].isEmpty()||temp[11].trim().equalsIgnoreCase("")||temp[11].trim().equalsIgnoreCase("undefined")||temp[11]==null?"0":temp[11].trim();
				String dettype=temp[12].isEmpty()||temp[12].trim().equalsIgnoreCase("")||temp[12].trim().equalsIgnoreCase("undefined")||temp[12]==null?"0":temp[12].trim();
				
				System.out.println(temp[1]+"//"+temp[0]+"//"+temp[7]+"//"+defaultpsrnomethod);
				if(temp[1].equalsIgnoreCase("0") && (temp[0].equalsIgnoreCase("Consumable") || temp[0].equalsIgnoreCase("Consumables")) && defaultpsrnomethod==1){
					temp[1]=defaultpsrno+"";
				}
				System.out.println("Lum Status:"+lumsumstatus);
				String qty="";
				if(lumsumstatus.equalsIgnoreCase("0")){
					qty=temp[2];
				}
				else{
					qty="1";
				}
				String strsql="insert into ws_jccspare (jobcarddocno, estdocno, description, psrno, qty, esttotal, costtotal, profitpercent,"+
				" invoiceamt, customeramt, status,addition,lumsumstatus,chkcomplete,detdocno,dettype)values("+docno+","+estdocno+",'"+temp[0]+"',"+temp[1]+","+qty+","+temp[3]+","+temp[4]+","+temp[5]+","+temp[6]+","+temp[7]+",3,"+temp[8]+","+(lumsumstatus.length()>1?lumsumstatus.charAt(1):lumsumstatus+"")+","+chkcomplete+","+detdocno+",'"+dettype+"')";
				System.out.println(strsql);
				int insertval=stmt.executeUpdate(strsql);
				if(insertval<=0){
					System.out.println("Parts Error");
					errorstatus=1;
					break;
				}
			}
			/*String strdeletelabour="delete from ws_estlabour where rdocno="+estdocno+" and lumsumstatus>0";
			int deletelabour=stmt.executeUpdate(strdeletelabour);*/
			for(int i=0;i<labourarray.size();i++){
				String temp[]=labourarray.get(i).trim().split("::");
				System.out.println(labourarray.get(i).trim());
				System.out.println("Check1:"+temp[0]);
				
				temp[0]=temp[0].trim().isEmpty()||temp[0].trim().equalsIgnoreCase("")||temp[0].trim().equalsIgnoreCase("undefined")||temp[0].trim()==null?"0":temp[0].trim();
				System.out.println("Check2:"+temp[0]);
				temp[1]=temp[1].isEmpty()||temp[1].trim().equalsIgnoreCase("")||temp[1].trim().equalsIgnoreCase("undefined")||temp[1]==null?"0":temp[1].trim();
				String jobdesc=temp[2].isEmpty()||temp[2].trim().equalsIgnoreCase("")||temp[2].trim().equalsIgnoreCase("undefined")||temp[2]==null?"0":temp[2].trim();
				String addition=temp[3].isEmpty()||temp[3].trim().equalsIgnoreCase("")||temp[3].trim().equalsIgnoreCase("undefined")||temp[3]==null?"0":temp[3].trim();
				String total=temp[4].isEmpty()||temp[4].trim().equalsIgnoreCase("")||temp[4].trim().equalsIgnoreCase("undefined")||temp[4]==null?"0":temp[4].trim();
				String chkcomplete=temp[5].isEmpty()||temp[5].trim().equalsIgnoreCase("")||temp[5].trim().equalsIgnoreCase("undefined")||temp[5]==null?"0":temp[5].trim();
				System.out.println("Complete:"+chkcomplete+"::"+temp[5]);
				int srno=0;
				ResultSet rslabsrno=stmt.executeQuery("select max(coalesce(srno,0))+1 maxsrno from ws_estlabour where rdocno="+estdocno+"");
				while(rslabsrno.next()){
					srno=rslabsrno.getInt("maxsrno");
				}
				System.out.println("Row:"+temp[0]);
				
				if(temp[0].trim().equalsIgnoreCase("-1") || temp[0].trim().equalsIgnoreCase("-2")){
					String lumsumstatus=temp[0].charAt(1)+"";
					String qty="1";
					double rate=Double.parseDouble(total);
					double invoiceamt=Double.parseDouble(temp[1]);
					invoiceamt=objcommon.Round(invoiceamt, 2);
					double discount=0.0;
					if(invoiceamt<rate){
						discount=rate-invoiceamt;
						discount=objcommon.Round(discount, 2);
					}
					double vatpercent=5.0;
					double vatamount=invoiceamt*0.05;
					vatamount=objcommon.Round(vatamount, 2);
					double netamount=invoiceamt+vatamount;
					netamount=objcommon.Round(netamount, 2);
					int seqno=0;
					ResultSet rslabseqno=stmt.executeQuery("select max(coalesce(seqno,0))+1 maxseqno from ws_estlabour where rdocno="+estdocno+"");
					while(rslabseqno.next()){
						seqno=rslabseqno.getInt("maxseqno");
					}
					String strsql="insert into ws_estlabour(rdocno, srno,total, addition, confirmed, approved,invoiceamt,strjobdesc,lumsumstatus,"+
					" chkcomplete,hrs,rate,strjobtype,seqno,jobqty,jobdiscount,jobvatpercent,jobvatamount,jobnetamount)values("+estdocno+","+
					" "+srno+","+total+","+addition+",1,1,"+temp[1]+",'"+jobdesc+"',"+lumsumstatus+","+chkcomplete+","+qty+","+rate+",'Service Lump Sum',"+
					" "+seqno+","+qty+","+discount+","+vatpercent+","+vatamount+","+netamount+")";
					System.out.println(strsql);
					int updateval=stmt.executeUpdate(strsql);
					if(updateval<0){
						System.out.println("Labour Error");
						errorstatus=1;
						break;
					}
				}
				else{
					String strsql="update ws_estlabour set chkcomplete="+chkcomplete+",invoiceamt="+temp[1]+" where rowno="+temp[0];
					System.out.println(strsql);
					int updateval=stmt.executeUpdate(strsql);
					if(updateval<0){
						System.out.println("Labour Error");
						errorstatus=1;
						break;
					}
				}
				
			}
			String strdeleteextra="delete from ws_jccextra where jobcarddocno="+docno;
			int deleteextra=stmt.executeUpdate(strdeleteextra);
			
			for(int i=0;i<extraarray.size();i++){
				String temp[]=extraarray.get(i).split("::");
				temp[0]=temp[0].isEmpty()||temp[0].trim().equalsIgnoreCase("")||temp[0].trim().equalsIgnoreCase("undefined")||temp[0]==null?"":temp[0].trim();
				temp[1]=temp[1].isEmpty()||temp[1].trim().equalsIgnoreCase("")||temp[1].trim().equalsIgnoreCase("undefined")||temp[1]==null?"0":temp[1].trim();
				String strsql="insert into ws_jccextra(jobcarddocno, estdocno, description, amount, status)values("+docno+","+estdocno+",'"+temp[0]+"',"+temp[1]+",3)";
				System.out.println(strsql);
				int updateval=stmt.executeUpdate(strsql);
				if(updateval<=0){
					System.out.println("Extra Error");
					errorstatus=1;
					break;
				}
			}
			String strupdatejobsave="update ws_jobcard set savestatus=1 where doc_no="+docno;
			int updatejobsave=stmt.executeUpdate(strupdatejobsave);
			if(updatejobsave<0){
				System.out.println("Update Jobcard Error");
				errorstatus=1;
				return 0;
			}
			if(lpoamount.equalsIgnoreCase("") || lpoamount==null || lpoamount.equalsIgnoreCase("undefined")){
				lpoamount="0";
			}
			String strupdategate="update ws_jobcard job left join ws_estm est on (job.reftype='EST' and job.refno=est.doc_no) left join "+
			" ws_gateinpass gate on (est.gipno=gate.doc_no) set gate.claim='"+claimno+"',gate.lpo='"+lpono+"',gate.lpoamount="+lpoamount+" "+
			" where job.doc_no="+docno;
			System.out.println(strupdategate);
			int updategate=stmt.executeUpdate(strupdategate);
			if(updategate<0){
				System.out.println("Update GIP Error");
				errorstatus=1;
				return 0;
			}
			/*String strupdatejobcard="update ws_jobcard set complete=1 where doc_no="+docno;
			int updatejobcard=stmt.executeUpdate(strupdatejobcard);
			if(updatejobcard<0){
				errorstatus=1;
				return 0;
			}
			String strinsertcomplete = "insert into ws_jobcardcomp(jobcardno, userid, brhid, date) values (?,?,?,date(now()))";
			PreparedStatement prestmt = conn.prepareStatement(strinsertcomplete);
			prestmt.setInt(1, Integer.parseInt(docno));
			prestmt.setInt(2, Integer.parseInt(session.getAttribute("USERID").toString()));
			prestmt.setInt(3, Integer.parseInt(brhid));
			int insertcomplete=prestmt.executeUpdate();
			if(insertcomplete<=0){
				errorstatus=1;
				return 0;
			}
			String strupdategate="update ws_jobcard jc left join ws_estm es on (jc.refno=es.doc_no and jc.reftype='EST')"+
			"left join ws_gateinpass gp on((jc.refno=gp.doc_no and jc.reftype='GIP') or (es.gipno=gp.doc_no and jc.reftype='EST'))"+
			"set gp.processstatus=6 where jc.doc_no="+docno;
			int updategate=stmt.executeUpdate(strupdategate);
			if(updategate<=0){
				errorstatus=1;
				return 0;
			}
			
			 ResultSet rsmaxdoc = stmt.executeQuery("select max(srno) from ws_jobcardcomp");
			 int logdocno=0;
			 while(rsmaxdoc.next()){
				 logdocno=rsmaxdoc.getInt(1);
			 }
			 
			 PreparedStatement stmtlog=conn.prepareStatement("insert into gl_biblog(doc_no, brhId, dtype, edate, userId, userNo, activity, ENTRY) values (?,?,?,now(),?,?,?,?)");
			 stmtlog.setInt(1,logdocno);
			 stmtlog.setInt(2,Integer.parseInt(brhid));
			 stmtlog.setString(3,"BWJC");
			 stmtlog.setInt(4, Integer.parseInt(session.getAttribute("USERID").toString()));
			 stmtlog.setInt(5, 0);
			 stmtlog.setInt(6, 0);
			 stmtlog.setString(7, "A");
			 int log=stmtlog.executeUpdate();
			 if(log<=0){
				 errorstatus=1;
				 return 0;
			 }*/
			 
			 if(errorstatus==0){
				 conn.commit();
				 return Integer.parseInt(docno);
			 }
			 else{
				 return 0;
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
	
	public ClsJobCardCompleteNewPalBean printDetails(String doc, HttpServletRequest request) throws SQLException {
		// TODO Auto-generated method stub
		ClsJobCardCompleteNewPalBean bean=new ClsJobCardCompleteNewPalBean();
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select br.imgpath,coalesce(br.tinno,'') comptrn,coalesce(bill.trnnumber,'') clienttrn,job.date sqldate,date_format(job.date,'%d.%m.%Y') date,ac.cldocno,if(job.reftype='EST',job.refno,0) estdocno,"+
			" u.user_name,DATE_FORMAT(CURDATE(),'%d.%m.%Y') finaldate,job.doc_no,br.branchname,comp.company, br.address compaddress,"+   
			" comp.tel,comp.fax,job.voc_no jobvocno,concat(job.reftype,' - ',case  when job.reftype='EST' then est.voc_no else '' end) refno,"+
			" concat(bill.cldocno,' - ',bill.refname) client,coalesce(bill.address,'')  address,coalesce(bill.per_mob) mobile,coalesce(bill.mail1,'') mail,"+
			" concat(gate.regno,' - ',gate.pltid,' - ',coalesce(brd.brand_name,''), ' ',coalesce(model.vtype,''),' ',coalesce(yom.yom,''),"+
			" ' Others: ', coalesce(gate.vehother,''),' Mileage: ',coalesce(gate.kmin,0)) vehicle,coalesce(gate.other,'')  chassis  from ws_jobcard job left join ws_estm est on"+
			" (job.reftype='EST' and job.refno=est.doc_no) left join"+
			" ws_gateinpass gate on ((job.reftype='GIP' and job.refno=gate.doc_no) or (job.reftype!='GIP' and est.gipno=gate.doc_no)) left join"+
			" my_acbook ac on (gate.cldocno=ac.cldocno and ac.dtype='CRM') left join my_acbook bill on ((gate.insurancecomp=1 and gate.insurcldocno=bill.cldocno) or (gate.insurancecomp=0 and gate.cldocno=bill.cldocno)) and bill.dtype='CRM' left join gl_vehbrand brd on gate.brdid=brd.doc_no left join"+
			" gl_vehmodel model on gate.modid=model.doc_no left join gl_vehplate plate on gate.pltid=plate.doc_no left join gl_yom yom on"+
			" gate.yom=yom.doc_no left join my_brch br on job.brhid=br.doc_no left join my_comp comp on br.cmpid=comp.doc_no left join"+
			" my_user u on u.doc_no=job.userid where job.status=3 and job.doc_no="+doc;
			System.out.println(strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			int gatedocno=0,estdocno=0;
			int docno=0;
			int cldocno=0;
			java.sql.Date sqldate=null;
			ClsAmountToWords objamount=new ClsAmountToWords();
			while(rs.next()){
				/*gatedocno=rs.getInt("gatedocno");*/
				estdocno=rs.getInt("estdocno");
				docno=rs.getInt("doc_no");
				cldocno=rs.getInt("cldocno");
				sqldate=rs.getDate("sqldate");
				bean.setLblprintpath(rs.getString("imgpath"));     
				bean.setLblbranch(rs.getString("branchname"));
				bean.setLblcompname(rs.getString("company"));
				bean.setLblcompaddress(rs.getString("compaddress"));
				bean.setLblcomptel(rs.getString("tel"));
				bean.setLblcompfax(rs.getString("fax"));
				bean.setLblprintname("Job Card");
				bean.setLblchassis(rs.getString("chassis"));
				bean.setLblrefno(rs.getString("refno"));
				bean.setLblclient(rs.getString("client"));
				bean.setLbldate(rs.getString("date"));
				bean.setLblinvno(rs.getString("jobvocno"));
				bean.setLbladdress(rs.getString("address"));
				bean.setLblmobile(rs.getString("mobile"));
				bean.setLblemail(rs.getString("mail"));
				bean.setLblvehicle(rs.getString("vehicle"));
				bean.setLblcheckedby(rs.getString("user_name"));
				bean.setLblfinaldate(rs.getString("finaldate"));
				bean.setLblclienttrn(rs.getString("clienttrn"));
				bean.setLblcomptrn(rs.getString("comptrn"));
			}
			ClsManualInvoiceDAO manualdao=new ClsManualInvoiceDAO();
			ArrayList<String> labourarray=new ArrayList<>();
			labourarray=getLabourPrint(conn,estdocno);
			request.setAttribute("LABOURPRINT", labourarray);
			ArrayList<String> partsarray=new ArrayList<>();
			partsarray=getPartsPrint(conn,estdocno);
			request.setAttribute("PARTSPRINT", partsarray);
			double total=0.0,nettotal=0.0;
			for(int i=0;i<labourarray.size()-1;i++){
				total+=Double.parseDouble(labourarray.get(i).split("::")[3]);
			}
			for(int i=0;i<partsarray.size()-1;i++){
				total+=Double.parseDouble(partsarray.get(i).split("::")[4]);
			}
			bean.setLbltotal(customRound(conn,total)+"");
			nettotal=total;
			String strchecktax="select (select method from gl_config where field_nme='tax') taxmethod,(select tax from my_acbook where cldocno="+cldocno+" and dtype='CRM') clienttaxmethod";
			//System.out.println(strchecktax);
			ResultSet rschecktax=stmt.executeQuery(strchecktax);
			int taxstatus=0;
			int clienttaxmethod=0;
			while(rschecktax.next()){
				taxstatus=rschecktax.getInt("taxmethod");
				clienttaxmethod=rschecktax.getInt("clienttaxmethod");
			}
			double vatval=0.0;
			if(taxstatus==1 && clienttaxmethod==1){
				String strgettax="select set_per,vat_per,inv.idno,inv.acno,inv.description from gl_taxdetail tax left join gl_invmode inv on tax.acidno=inv.idno where tax.status<>7 and '"+sqldate+"' between tax.fromdate and tax.todate";
				double vatpercent=0.0;
				ResultSet rsgettax=stmt.executeQuery(strgettax);
				while(rsgettax.next()){
					vatpercent=rsgettax.getDouble("vat_per");
					vatval=(total*(vatpercent/100));
					vatval=objcommon.Round(vatval, 2);
				}
				nettotal+=vatval;
			}
			/*bean.setLbltax(customRound(conn,vatval)+"");
			bean.setLblnetamount(customRound(conn,nettotal)+"");
			bean.setLblamountwords(objamount.convertAmountToWords(nettotal+""));*/
			bean.setLbltax(customRound(conn,vatval)+"");
			double roundedvalue=Math.round(nettotal);
			double roundoff=nettotal-roundedvalue;
			roundoff=objcommon.Round(roundoff, 2);
			System.out.println(roundedvalue+"//"+roundoff+"//"+nettotal);
			bean.setLblnetamount(customRound(conn,roundedvalue)+"");
			bean.setLblroundoff(customRound(conn,roundoff)+"");
			bean.setLblamountwords(objamount.convertAmountToWords(roundedvalue+""));
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

	public String customRound(Connection conn, double amount) throws SQLException {
		// TODO Auto-generated method stub
		String value="";
		try{
			Statement stmt=conn.createStatement();
			String str="select round("+amount+",2) amount";
			ResultSet rs=stmt.executeQuery(str);
			while(rs.next()){
				value=rs.getString("amount");
			}
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		return value;
	}

	public ArrayList<String> getPartsPrint(Connection conn, int estdocno) throws SQLException{
		// TODO Auto-generated method stub
		System.out.println("Inside Details");
		ArrayList<String> partsarray=new ArrayList<>();
		try{
			Statement stmt=conn.createStatement();
			String strgetdefaultpsrnoconfig="select method,value from gl_config where field_nme='defaultConsumable'";
			int defaultpsrnomethod=0,defaultpsrno=0;
			ResultSet rsdefaultpsrno=stmt.executeQuery(strgetdefaultpsrnoconfig);
			while(rsdefaultpsrno.next()){
				defaultpsrnomethod=rsdefaultpsrno.getInt("method");
				defaultpsrno=rsdefaultpsrno.getInt("value");
			}
			String sqltest="";
			/*if(defaultpsrno>0 && defaultpsrnomethod==1){
				sqltest+=" union all"+
			" select cs.description,sum(cs.qty) qty, round(cs.esttotal,2) esttotal, round(cs.costtotal,2) costtotal, round(cs.profitpercent,2) profitpercent, round(cs.invoiceamt,2) invoiceamt, round(sum(cs.customeramt),2) customeramt,round(cs.customeramt/cs.qty,2) rate,main.part_no partno,'Consumable' partname from ws_jccspare cs left join my_main main on "+defaultpsrno+"=main.psrno where cs.estdocno="+estdocno+" and catid=3  and coalesce(cs.psrno,0)=0 and cs.description in ('Consumable','Consumables') and cs.customeramt>0.0 ";
			}*/
			String strsql="select s.description,round(s.qty,0)qty,round(s.customeramt/s.qty,2) rate,round(s.customeramt,2) netamt from ws_jccspare s "
                         +" LEFT JOIN WS_ESTM EM ON S.estdocno=EM.DOC_NO "
                         +" inner JOIN ws_jobcard jb  ON (jb.refno=em.gipno and jb.reftype='gip') or   (jb.refno=em.doc_no and jb.reftype='est') "
                         +" where EM.doc_no="+estdocno;
			
			System.out.println("getPartsPrint="+strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			int i=1;
			double total=0.0;
			while(rs.next()){
				String temp=i+"::"+rs.getString("description")+"::"+rs.getString("qty")+"::"+rs.getString("rate")+"::"+rs.getString("netamt");
				partsarray.add(temp);
				total+=rs.getDouble("netamt");
				i++;
			}
			String finaltotal="";
			String strgetformatted="select format("+customRound(conn, total)+",2) finaltotal";
			ResultSet rsformatted=stmt.executeQuery(strgetformatted);
			while(rsformatted.next()){
				finaltotal=rsformatted.getString("finaltotal");
			}
			partsarray.add(" "+"::"+" "+"::"+" "+"::"+"Spare Parts Total"+"::"+finaltotal);
		}
		
		catch(Exception e){
			e.printStackTrace(); 
			conn.close();
		}
		return partsarray;
	}



	public ArrayList<String> getLabourPrint(Connection conn, int estdocno)throws SQLException {
		// TODO Auto-generated method stub
		ArrayList<String> labourarray=new ArrayList<>();
		try{
			Statement stmt=conn.createStatement();
			/*String strsql="select lab.rowno,round(lab.invoiceamt,2) invoiceamt,m.desc1 jobdesc,m.doc_no,m.date,lab.hrs,lab.rate,t.type jobtype,lab.markupper markuppercent,coalesce(round(lab.total,2),0) total,lab.remarks,"+
			" lab.jobid from ws_estlabour lab left join ws_jobmaster m on (lab.jobid=m.doc_no ) left join ws_jobtype t on m.jobid=t.doc_no "+
			" where m.status=3 and lab.rdocno="+estdocno+" and lab.confirmed=1 and lab.approved=1 union all"+
			" select 0,round(amount,2) invoiceamt,description jobdesc,0 doc_no,curdate() date,0 hrs,0 rate,'' jobtype,0"+
			" markuppercent,round(amount,2) total,'' remarks, 0 jobid from ws_jccextra where estdocno="+estdocno+" and status=3";*/
			String strsql="select lab.rowno,round(lab.invoiceamt,2) invoiceamt,lab.strjobdesc jobdesc,lab.hrs,lab.rate,lab.strjobtype jobtype,lab.markupper markuppercent,coalesce(round(lab.total,2),0) total,lab.remarks,"+
					" lab.jobid from ws_estlabour lab  "+
					" where lab.rdocno="+estdocno+" and lab.confirmed=1 and lab.approved=1 union all"+
					" select 0,round(amount,2) invoiceamt,description jobdesc,0 hrs,0 rate,'' jobtype,0"+
					" markuppercent,round(amount,2) total,'' remarks, 0 jobid from ws_jccextra where estdocno="+estdocno+" and status=3";
			//System.out.println("getLabourPrint="+strsql);     
			ResultSet rs=stmt.executeQuery(strsql);
			int i=1;
			double total=0.0;
			while(rs.next()){
				String temp=i+"::"+rs.getString("jobtype")+"::"+rs.getString("jobdesc")+"::"+rs.getString("invoiceamt");
				labourarray.add(temp);
				i++;
				total+=rs.getDouble("invoiceamt");
			}
			String finaltotal="";
			String strgetformatted="select format("+customRound(conn, total)+",2) finaltotal";
			ResultSet rsformatted=stmt.executeQuery(strgetformatted);
			while(rsformatted.next()){
				finaltotal=rsformatted.getString("finaltotal");
			}
			labourarray.add(" "+"::"+" "+"::"+"Service Total"+"::"+finaltotal);
		}
		catch(Exception e){
			e.printStackTrace(); 
			conn.close();
		}
		return labourarray;
	}
	public String getAddition(String estdocno,String id) throws SQLException{
		String addition="";
		if(!id.equalsIgnoreCase("1")){
			return addition;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select 0 addition from ws_estm where doc_no="+estdocno+" union all"+
			" select addition addition from ws_estmadd estadd left join ws_estm est on estadd.estdocno=est.doc_no where estdocno="+estdocno;
			ResultSet rs=stmt.executeQuery(strsql);
			int i=0;
			while(rs.next()){
				if(i==0){
					addition=rs.getString("addition");
				}
				else{
					addition+=","+rs.getString("addition");
				}
				i++;
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return addition;
	}
	
	public JSONArray getEstTotalData(String id,String estdocno) throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			String strsql="select 0 addition,"+
			" case when coalesce(em.chkrandomlumsum,0)=1 then em.randomlumsumamt else if(em.chkservicelumsum=0,coalesce(lab.labtot,0),coalesce(em.servicelumsumamt,0))+"+
			" if(em.chklumsum=0,coalesce(spr.sparetot,0),coalesce(em.lumsumamount,0)) end nettotal,"+
			" case when em.approved=0 then 'Not Approved' when em.approved=1 then 'Approved' when em.approved=2 then 'Waved Off' when"+
			" em.approved=3 then 'Cancelled' else '' end approved from ws_estm em"+
			" left join (select rdocno,addition, sum(total) labtot,confirmed,approved from ws_estlabour where confirmed=1 group by rdocno,addition) lab  on (em.doc_no=lab.rdocno and lab.addition=0)"+
			" left join (select rdocno,addition,sum(approvedvalue) sparetot,confirmed,approved from  ws_estspare where confirmed=1 group by rdocno,addition) spr on (em.doc_no=spr.rdocno and spr.addition=0)"+
			" where  em.doc_no="+estdocno+" group by em.doc_no union all"+
			" select ad.addition,"+
			" case when coalesce(ad.chkrandomlumsum,0)=1 then ad.randomlumsumamt else if(ad.chkservicelumsum=0,coalesce(lab.labtot,0),coalesce(ad.servicelumsumamt,0))+"+
			" if(ad.chklumsum=0,coalesce(spr.sparetot,0),coalesce(ad.lumsumamount,0)) end nettotal,"+
			" case when ad.approved=0 then 'Not Approved' when ad.approved=1 then 'Approved' when ad.approved=2 then 'Waved Off' when"+
			" ad.approved=3 then 'Cancelled' else '' end approved from ws_estm em"+
			" left join ws_estmadd ad on em.doc_no=ad.doc_no"+
			" left join (select rdocno,addition, sum(total) labtot,confirmed,approved from ws_estlabour where confirmed=1 group by rdocno,addition) lab  on (em.doc_no=lab.rdocno and lab.addition=ad.addition)"+
			" left join (select rdocno,addition,sum(approvedvalue) sparetot,confirmed,approved from  ws_estspare where confirmed=1 group by rdocno,addition) spr on (em.doc_no=spr.rdocno and spr.addition=ad.addition)"+
			" where  ad.doc_no="+estdocno+" and ad.addition>0 group by ad.doc_no,ad.addition";
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
}
