package com.dashboard.marketing.leaseapplicationcancel;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;



public class ClsleaseApplicationCancelDAO {

	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	/*public JSONArray fleetDetails(String srno) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();
		ResultSet resultSet=null;
		Connection conn = null;
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmtVeh = conn.createStatement ();
			for(int i=0;i<3;i++){
				String sql=" select brd.brand_name  brand,model.vtype model,round(coalesce(req.totalvalue,0),2) vcost,"
						+ "req.leasemonths nmonth,lp.qty, req.brdid,req.modid modelid,req.srno reqsrno,chasisno , allotno from gl_leasecalcreq req "
						+ "left join gl_vehbrand brd on req.brdid=brd.doc_no left join gl_vehmodel model on  req.modid=model.doc_no "
						+ " left join gl_lprd lp on lp.rdocno=req.leasereqdocno and lp.sr_no=req.reqsrno where req.status=3 and srno='"+srno+"' ";
			//	System.out.println("=====sql=="+sql);
				resultSet = stmtVeh.executeQuery(sql);

			}
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
			stmtVeh.close();
			conn.close();

		}
		catch(Exception e){
			conn.close();
		}
		//System.out.println(RESULTDATA);
		return RESULTDATA;
	}*/

	public JSONArray leasefollowtsearch(String brnchval,String satcateg) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();

		
		
		
		
		String sqltest="";
		String sqlleft="";
		String sqldata="";
		

		//System.out.println("kjbn c vv"+satcateg);
		
		
		//System.out.println("kjbn c vv"+brnchval);
		
		
		
		Connection conn = null;
		Statement stmtVeh= null;

		try {
			conn = ClsConnection.getMyConnection();
			 stmtVeh = conn.createStatement ();
			 
			 if(!((brnchval.equalsIgnoreCase("0")) || (brnchval.equalsIgnoreCase("NA")) || (brnchval.equalsIgnoreCase("a"))))
				{
					sqltest+=" and la.brhid='"+brnchval+"'";
				}
				
			 String sql="";
			
			if(satcateg.equalsIgnoreCase("cancel")) {
				
				
				
			 sql="select la.doc_no refdoc,brd.brand_name  brand,model.vtype model,req.leasefromdate fdate,"
					+ " round(coalesce(req.totalvalue,0),2) vcost,round(coalesce(req.residalvalue,0),2) residalvalue,"
					+ " req.leasemonths nmonth,round(lp.qty) qty,req.leasereqdocno,req.rdocno,req.brdid,"
					+ " req.modid modelid,req.srno,req.upd_quantity updqty,req.po_dealer,"
					+ " coalesce(req.prchcost,0) prchcost,a.contactPerson,a.mail1,a.cldocno,trim(a.RefName) client,"
					+ " a.per_mob,concat(a.address,'  ',a.address2) as address ,a.per_tel,a.codeno,a.acno,"
					+ " m.doc_no,req.reqsrno printsrno,la.brhid printbrhid,req.allotno,ven.name dealername,"
					+ " ven.acc_no vendacno,trim(m.sal_name) sal_name,round(req.kmpermonth) kmuse  from gl_leaseappm la   "
					+ " left join gl_leaseappd d on la.doc_no=d.rdocno and la.brhid=d.brhid "
					+ " left join gl_leasecalcreq req on la.reqdoc=req.leasereqdocno  and d.reqsrno=req.reqsrno   "
					+ " left join my_vendorm ven on ven.doc_no=req.po_dealer "
					+ " left join  gl_vehbrand brd on req.brdid=brd.doc_no"
					+ " left join gl_vehmodel model on  req.modid=model.doc_no "
					+ " left join my_color clr on req.clrid=clr.doc_no "
					+ " left join  gl_vehgroup grp on (req.grpid=grp.doc_no) "
					+ " left join gl_lprd lp on lp.rdocno=req.leasereqdocno and lp.sr_no=req.reqsrno "
					+ " left join my_acbook a on a.cldocno=la.cldocno and a.dtype='CRM' and a.status=3 "
					+ " left join my_salm m on a.sal_id=m.doc_no and m.status<>7 "
					+ " left join gl_blaf bl on bl.rdocno=req.srno and  ladocno!=0 "
					+ " left join gl_lagmt l on l.larefdocno=la.doc_no and blafsrno=bl.srno  where  "
					+ " la.status=3 and req.status=3  and req.lastatus<2 and (perfleet is null or perfleet=0 ) "+sqltest+" " ;
			}
			else if(satcateg.equalsIgnoreCase("cancellist")) {
				
				 sql="select la.doc_no refdoc,bla.remarks,mu.user_name,bla.testdate,brd.brand_name  brand,model.vtype model,req.leasefromdate fdate,"
							+ " round(coalesce(req.totalvalue,0),2) vcost,round(coalesce(req.residalvalue,0),2) residalvalue,"
							+ " req.leasemonths nmonth,round(lp.qty) qty,req.leasereqdocno,req.rdocno,req.brdid,"
							+ " req.modid modelid,req.srno,req.upd_quantity updqty,req.po_dealer,"
							+ " coalesce(req.prchcost,0) prchcost,a.contactPerson,a.mail1,a.cldocno,trim(a.RefName) client,"
							+ " a.per_mob,concat(a.address,'  ',a.address2) as address ,a.per_tel,a.codeno,a.acno,"
							+ " m.doc_no,req.reqsrno printsrno,la.brhid printbrhid,req.allotno,ven.name dealername,"
							+ " ven.acc_no vendacno,trim(m.sal_name) sal_name,round(req.kmpermonth) kmuse  from gl_leaseappm la   "
							+ " left join gl_leaseappd d on la.doc_no=d.rdocno and la.brhid=d.brhid "
							+ " left join gl_leasecalcreq req on la.reqdoc=req.leasereqdocno  and d.reqsrno=req.reqsrno   "
							+ " left join my_vendorm ven on ven.doc_no=req.po_dealer "
							+ " left join  gl_vehbrand brd on req.brdid=brd.doc_no"
							+ " left join gl_blac bla on req.srno=bla.srno"
							+ " left join my_user mu on bla.userid=mu.doc_no"
							+ " left join gl_vehmodel model on  req.modid=model.doc_no "
							+ " left join my_color clr on req.clrid=clr.doc_no "
							+ " left join  gl_vehgroup grp on (req.grpid=grp.doc_no) "
							+ " left join gl_lprd lp on lp.rdocno=req.leasereqdocno and lp.sr_no=req.reqsrno "
							+ " left join my_acbook a on a.cldocno=la.cldocno and a.dtype='CRM' and a.status=3 "
							+ " left join my_salm m on a.sal_id=m.doc_no and m.status<>7 "
							+ " left join gl_blaf bl on bl.rdocno=req.srno and  ladocno!=0 "
							+ " left join gl_lagmt l on l.larefdocno=la.doc_no and blafsrno=bl.srno  where  "
							+ " la.status=3 and req.status=3  and req.lastatus=7 and (perfleet is null or perfleet=0 ) "+sqltest+" " ;
				
			}
		 System.out.println("--hh--"+sql);
			ResultSet resultSet = stmtVeh.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
			
			//System.out.println(RESULTDATA);
			
			
			stmtVeh.close();
			conn.close();
		}
		catch(Exception e){
			
			conn.close();
		}
		//System.out.println(RESULTDATA);
		
		return RESULTDATA;
}

	public JSONArray leasefollowtsearchexcel(String brnchval,String satcateg) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();

		
		
		
		
		String sqltest="";
		String sqlleft="";
		String sqldata="";
		

		//System.out.println("kjbn c vv"+satcateg);
		
		
		//System.out.println("kjbn c vv"+brnchval);
		
		
		
		Connection conn = null;
		Statement stmtVeh= null;

		try {
			conn = ClsConnection.getMyConnection();
			 stmtVeh = conn.createStatement ();
			 
			 if(!((brnchval.equalsIgnoreCase("0")) || (brnchval.equalsIgnoreCase("NA")) || (brnchval.equalsIgnoreCase("a"))))
				{
					sqltest+=" and la.brhid='"+brnchval+"'";
				}
				
			 String sql="";
			
			if(satcateg.equalsIgnoreCase("cancel")) {
				
				
				
			 sql="select la.doc_no refdoc,brd.brand_name  brand,model.vtype model,req.leasefromdate fdate,"
					+ " round(coalesce(req.totalvalue,0),2) vcost,round(coalesce(req.residalvalue,0),2) residalvalue,"
					+ " req.leasemonths nmonth,round(lp.qty) qty,req.leasereqdocno,req.rdocno,req.brdid,"
					+ " req.modid modelid,req.srno,req.upd_quantity updqty,req.po_dealer,"
					+ " coalesce(req.prchcost,0) prchcost,a.contactPerson,a.mail1,a.cldocno,trim(a.RefName) client,"
					+ " a.per_mob,concat(a.address,'  ',a.address2) as address ,a.per_tel,a.codeno,a.acno,"
					+ " m.doc_no,req.reqsrno printsrno,la.brhid printbrhid,req.allotno,ven.name dealername,"
					+ " ven.acc_no vendacno,trim(m.sal_name) sal_name,round(req.kmpermonth) kmuse  from gl_leaseappm la   "
					+ " left join gl_leaseappd d on la.doc_no=d.rdocno and la.brhid=d.brhid "
					+ " left join gl_leasecalcreq req on la.reqdoc=req.leasereqdocno  and d.reqsrno=req.reqsrno   "
					+ " left join my_vendorm ven on ven.doc_no=req.po_dealer "
					+ " left join  gl_vehbrand brd on req.brdid=brd.doc_no"
					+ " left join gl_vehmodel model on  req.modid=model.doc_no "
					+ " left join my_color clr on req.clrid=clr.doc_no "
					+ " left join  gl_vehgroup grp on (req.grpid=grp.doc_no) "
					+ " left join gl_lprd lp on lp.rdocno=req.leasereqdocno and lp.sr_no=req.reqsrno "
					+ " left join my_acbook a on a.cldocno=la.cldocno and a.dtype='CRM' and a.status=3 "
					+ " left join my_salm m on a.sal_id=m.doc_no and m.status<>7 "
					+ " left join gl_blaf bl on bl.rdocno=req.srno and  ladocno!=0 "
					+ " left join gl_lagmt l on l.larefdocno=la.doc_no and blafsrno=bl.srno  where  "
					+ " la.status=3 and req.status=3  and req.lastatus<2 and (perfleet is null or perfleet=0 ) "+sqltest+" " ;
			}
			else if(satcateg.equalsIgnoreCase("cancellist")) {
				
				 sql="select la.doc_no refdoc,bla.remarkss,bla.testdate,brd.brand_name  brand,model.vtype model,req.leasefromdate fdate,"
							+ " round(coalesce(req.totalvalue,0),2) vcost,round(coalesce(req.residalvalue,0),2) residalvalue,"
							+ " req.leasemonths nmonth,round(lp.qty) qty,req.leasereqdocno,req.rdocno,req.brdid,"
							+ " req.modid modelid,req.srno,req.upd_quantity updqty,req.po_dealer,"
							+ " coalesce(req.prchcost,0) prchcost,a.contactPerson,a.mail1,a.cldocno,trim(a.RefName) client,"
							+ " a.per_mob,concat(a.address,'  ',a.address2) as address ,a.per_tel,a.codeno,a.acno,"
							+ " m.doc_no,req.reqsrno printsrno,la.brhid printbrhid,req.allotno,ven.name dealername,"
							+ " ven.acc_no vendacno,trim(m.sal_name) sal_name,round(req.kmpermonth) kmuse  from gl_leaseappm la   "
							+ " left join gl_leaseappd d on la.doc_no=d.rdocno and la.brhid=d.brhid "
							+ " left join gl_leasecalcreq req on la.reqdoc=req.leasereqdocno  and d.reqsrno=req.reqsrno   "
							+ " left join my_vendorm ven on ven.doc_no=req.po_dealer "
							+ " left join  gl_vehbrand brd on req.brdid=brd.doc_no"
							+ " left join gl_blac bla on req.srno=bla.docno"
							+ " left join gl_vehmodel model on  req.modid=model.doc_no "
							+ " left join my_color clr on req.clrid=clr.doc_no "
							+ " left join  gl_vehgroup grp on (req.grpid=grp.doc_no) "
							+ " left join gl_lprd lp on lp.rdocno=req.leasereqdocno and lp.sr_no=req.reqsrno "
							+ " left join my_acbook a on a.cldocno=la.cldocno and a.dtype='CRM' and a.status=3 "
							+ " left join my_salm m on a.sal_id=m.doc_no and m.status<>7 "
							+ " left join gl_blaf bl on bl.rdocno=req.srno and  ladocno!=0 "
							+ " left join gl_lagmt l on l.larefdocno=la.doc_no and blafsrno=bl.srno  where  "
							+ " la.status=3 and req.status=3  and req.lastatus=7 and (perfleet is null or perfleet=0 ) "+sqltest+" " ;
				
			}
		 //System.out.println("--hh--"+sql);
			ResultSet resultSet = stmtVeh.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
			
			//System.out.println(RESULTDATA);
			
			
			stmtVeh.close();
			conn.close();
		}
		catch(Exception e){
			
			conn.close();
		}
		//System.out.println(RESULTDATA);
		
		return RESULTDATA;
}

	/*public  JSONArray dealerMSearch() throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		try {
			Connection conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement ();

			ResultSet resultSet = stmt.executeQuery ("select name,doc_no,acc_no from my_vendorm where status<>7");

			RESULTDATA=ClsCommon.convertToJSON(resultSet);
			//	System.out.println("============"+RESULTDATA);
			stmt.close();
			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return RESULTDATA;
	}
	public  JSONArray fleetSearch(String brandid,String modid) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;
		try {
			conn= ClsConnection.getMyConnection();
			Statement stmtrelode = conn.createStatement (); 

			String resql=("select v.fleet_no,v.flname,v.doc_no,v.vin,v.ch_no from gl_vehmaster v \r\n" + 
					" left join (select fleet_no,rdocno from gl_vpurd p inner join gl_vpurm m on p.rdocno=m.doc_no and m.status=3) p on p.fleet_no=v.fleet_no  where v.statu=3 "
					+ " and  p.fleet_no  is null  and v.dtype='VEH' and puchstatus=0 and v.brdid='"+brandid+"' and  v.vmodid='"+modid+"' ");
			//	System.out.println("================="+resql);
			ResultSet resultSet = stmtrelode.executeQuery(resql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
			stmtrelode.close();
			conn.close();



		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}

		return RESULTDATA;
	}

	public  JSONArray salpersonSearch() throws SQLException {

		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;
		try {
			conn= ClsConnection.getMyConnection();
			Statement stmtsalname = conn.createStatement (); 

			String resql="select sal_name,doc_no from my_salm where status=3 ";
			//	System.out.println("================="+resql);
			ResultSet resultSet = stmtsalname.executeQuery(resql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
			stmtsalname.close();
			conn.close();



		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}

		return RESULTDATA;
	}
	
	public  ClsleaseApplicationFollowupBean getPrint(int docno) throws SQLException {
		ClsleaseApplicationFollowupBean bean = new ClsleaseApplicationFollowupBean();
		Connection conn = null;
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmtprint = conn.createStatement ();
			String resql=(" select v.name,DATE_FORMAT(po_date,'%d-%m-%Y') AS podate from gl_leasecalcreq lp left join my_vendorm v on v.doc_no=lp.po_dealer where v.status<>7 and srno='"+docno+"' ");
			//	String resql=("select voc_no,doc_no,DATE_FORMAT(date,'%d.%m.%Y') AS date,type,DATE_FORMAT(expdeldt,'%d.%m.%Y') AS expdeldt,desc1 from gl_vprm where doc_no='"+docno+"' ");

			ResultSet pintrs = stmtprint.executeQuery(resql);


			while(pintrs.next()){
				// cldatails

				 setLblclient setLblclientaddress setLblmob setLblemail setLbldate setLbltypep setDocvals


				bean.setVendor(pintrs.getString("name"));
				bean.setLdate(pintrs.getString("podate"));

			}


			stmtprint.close();



			Statement stmtinvoice10 = conn.createStatement ();
			String  companysql="select c.company,c.address,c.tel,c.fax,lc.loc_name location,b.branchname from gl_leasecalcreq r "
					+ "left join gl_leasecalcm m on r.rdocno=m.reqdoc inner join my_brch b on m.brhid=b.doc_no "
					+ "inner join my_comp c on b.cmpid=c.doc_no inner join my_locm l on l.brhid=b.doc_no "
					+ "inner join (select min(lo.loc) loc,lo.loc_name,lo.brhid "
					+ "from my_locm lo group by brhid) as lc on(lc.loc=l.loc and lc.brhid=b.doc_no) where r.srno="+docno+"  ";


			ResultSet resultsetcompany = stmtinvoice10.executeQuery(companysql); 

			while(resultsetcompany.next()){

				bean.setLblbranch(resultsetcompany.getString("branchname"));
				bean.setLblcompname(resultsetcompany.getString("company"));

				bean.setLblcompaddress(resultsetcompany.getString("address"));

				bean.setLblcomptel(resultsetcompany.getString("tel"));

				bean.setLblcompfax(resultsetcompany.getString("fax"));
				bean.setLbllocation(resultsetcompany.getString("location"));



			} 
			stmtinvoice10.close();


			conn.close();




		}
		catch(Exception e){
			conn.close();
			e.printStackTrace();
		}
		return bean;


	}
	public  ArrayList<String> getPrintdetails(int docno, HttpServletRequest request) throws SQLException {
		ArrayList<String> arr=new ArrayList<String>();
		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmtinvoice = conn.createStatement ();
			String strSqldetail="";

			strSqldetail=("select brd.brand_name  brand,model.vtype model,coalesce(req.allotno,'') allotno,coalesce(clr.color,'') color,round(lp.qty) qty,"
					+ "coalesce(round(req.prchcost,2),0) price,coalesce(round((lp.qty*req.prchcost),2),0) total "
					+ "from gl_leasecalcreq req left join gl_vehbrand brd on req.brdid=brd.doc_no "
					+ "left join gl_vehmodel model on  req.modid=model.doc_no left join my_color clr on req.clrid=clr.doc_no "
					+ "left join gl_lcgm lcg on (req.brdid=req.brdid and req.modid=lcg.modid) "
					+ "left join  gl_vehgroup grp on (lcg.grpid=grp.doc_no) "
					+ "left join gl_lprd lp on lp.rdocno=req.leasereqdocno and lp.sr_no=req.reqsrno where req.srno='"+docno+"' ");

			ResultSet rsdetail=stmtinvoice.executeQuery(strSqldetail);

			int rowcount=1;

			while(rsdetail.next()){

				String temp="";
				String spci="";
				if(rsdetail.getString("spec").equalsIgnoreCase("0"))
				{
					spci="";
				}
				else
				{
					spci=rsdetail.getString("spec");
				}
				temp=rowcount+"::"+rsdetail.getString("brand")+"::"+rsdetail.getString("model")+"::"+rsdetail.getString("allotno")+"::"+rsdetail.getString("color")+"::"+rsdetail.getString("qty")+"::"+rsdetail.getString("price")+"::"+rsdetail.getString("total") ;

				arr.add(temp);
				rowcount++;


			}
			request.setAttribute("details",arr); 
			stmtinvoice.close();
			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}

		return arr;
	}

	public  JSONArray subDetails(String fromdate,String todate,String branchval,String id,String salperson) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return RESULTDATA;
		}
		String sqltest="";

		java.sql.Date sqlfromdate = null;
		if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
		{
			sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);

		}
		else{

		}

		java.sql.Date sqltodate = null;
		if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
		{
			sqltodate=ClsCommon.changeStringtoSqlDate(todate);

		}
		else{

		}
		if(!(salperson.equalsIgnoreCase(""))){
			sqltest+=" and m.doc_no="+salperson+"";
		}
		if(!((branchval.equalsIgnoreCase("a")) || (branchval.equalsIgnoreCase("NA")))){
			sqltest+=" and la.brhid='"+branchval+"'";
		}
		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmtVeh = conn.createStatement (); // UAL - UNallocated ,ANI - allocated not  Invoiced, AIN- allocated Invoiced , POS -traffic posted, RES - Received
			String sql="select 'Not Alloted' process,'NA' short,count(*) count from gl_leaseappm la "
					+ "left join  gl_leasecalcreq req on la.reqdoc=req.leasereqdocno left join my_acbook a on a.cldocno=la.cldocno and a.dtype='CRM' and a.status=3 "
					+ "left join my_salm m on a.sal_id=m.doc_no and m.status<>7 "
					+ "where la.status=3 and req.status=3 and req.lastatus=0 and la.date between '"+sqlfromdate+"' and   '"+sqltodate+"' "+sqltest+" union all "
				
					+ "select 'Lease Agreement To Be Create' process,'LAC' short,count(*) count from gl_leaseappm la "
					+ "left join  gl_leasecalcreq req on la.reqdoc=req.leasereqdocno left join my_acbook a on a.cldocno=la.cldocno and a.dtype='CRM' and a.status=3 "
					+ "left join my_salm m on a.sal_id=m.doc_no and m.status<>7 "
					+ " inner join gl_blaf b on b.rdocno=req.srno and b.lastatus=0 and ladocno=0 "
					+ "where req.lastatus=1 and req.status=3 and la.status=3 and la.date between '"+sqlfromdate+"' and   '"+sqltodate+"' "+sqltest+" union all "
				
					+ " select 'Vehicle Release Request' process,'VR' short,count(*) count from gl_leaseappm la "
					+ "left join  gl_leasecalcreq req on la.reqdoc=req.leasereqdocno left join my_acbook a on a.cldocno=la.cldocno and a.dtype='CRM' and a.status=3 "
					+ "left join my_salm m on a.sal_id=m.doc_no and m.status<>7 inner join gl_blaf b on b.rdocno=req.srno and b.lastatus=0 "
					+ " where  la.status=3 and req.status=3 and req.lastatus=1 and ladocno!=0 and la.date between '"+sqlfromdate+"' and   '"+sqltodate+"' "+sqltest+" union all "
				
					+ "select 'Purchase Order' process,'PO' short,count(*) count from gl_leaseappm la "
					+ "left join  gl_leasecalcreq req on la.reqdoc=req.leasereqdocno left join my_acbook a on a.cldocno=la.cldocno and a.dtype='CRM' and a.status=3 "
					+ "left join my_salm m on a.sal_id=m.doc_no and m.status<>7 "
					+ " where  la.status=3 and req.status=3 and  req.lastatus=2 and req.upd_quantity=0 and la.date between '"+sqlfromdate+"' and   '"+sqltodate+"' "+sqltest+" union all "
					
					+ "select 'Fleet Update' process,'FU' short,count(*) count from gl_leaseappm la "
					+ "left join  gl_leasecalcreq req on la.reqdoc=req.leasereqdocno left join my_acbook a on a.cldocno=la.cldocno and a.dtype='CRM' and a.status=3 "
					+ "left join my_salm m on a.sal_id=m.doc_no and m.status<>7 "
					+ " left join gl_lprd lp on lp.rdocno=req.leasereqdocno and lp.sr_no=req.reqsrno "
					+ " where req.lastatus=3 and req.status=3 and la.status=3 and la.date between '"+sqlfromdate+"' and   '"+sqltodate+"'  and (lp.qty-req.upd_quantity)!=0  "+sqltest+" ";
			
			System.out.println("====sql=="+sql);
			ResultSet resultSet = stmtVeh.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
			stmtVeh.close();
			conn.close();
		}
		catch(Exception e){
			conn.close();

		}
		//System.out.println(RESULTDATA);
		return RESULTDATA;
	}   

*/

}
