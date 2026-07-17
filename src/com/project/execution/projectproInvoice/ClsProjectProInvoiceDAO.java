package com.project.execution.projectproInvoice;

import java.io.File;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.swing.filechooser.FileSystemView;

import com.common.ClsAmountToWords;
import com.common.ClsCommon;
import com.common.ClsNumberToWord;
import com.connection.ClsConnection;
import com.project.execution.projectproInvoice.ClsProjectProInvoiceBean;
import com.project.execution.quotation.ClsQuotationBean;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public class ClsProjectProInvoiceDAO {


	ClsCommon com=new ClsCommon();
	ClsConnection conobj=new ClsConnection();
	ClsProjectProInvoiceBean bean=new ClsProjectProInvoiceBean();

	Connection conn;
	public int edit(int maintrno,Date sqldate,String refno,String contracttype,int contractno,String client,String clientdet,String desc,String branchid,String clacno,int clientid,int costid,ArrayList<String> enqarray,HttpSession session,String mode,String dtype,HttpServletRequest request) throws SQLException {
		try{
			//	int docno;
			int protrno;
			String amount="0";
			String lfee="0";
			conn=conobj.getMyConnection();
			conn.setAutoCommit(false);

			for(int i=0;i< enqarray.size();i++){

				String[] invdata=enqarray.get(i).split("::");

				amount=(invdata[0].trim().equalsIgnoreCase("undefined") || invdata[0].trim().equalsIgnoreCase("NaN") || invdata[0].trim().equalsIgnoreCase("") || invdata[0].trim().isEmpty())? "0": invdata[0].trim();
				lfee=(invdata[1].trim().equalsIgnoreCase("undefined") || invdata[1].trim().equalsIgnoreCase("NaN") || invdata[1].trim().equalsIgnoreCase("") || invdata[1].trim().isEmpty())? "0": invdata[1].trim();

			}

			CallableStatement stmtinv = conn.prepareCall("{call projectproInvoiceDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");

			stmtinv.setDate(1,sqldate);
			stmtinv.setString(2,refno);
			stmtinv.setString(3,contracttype);

			stmtinv.setString(4,client);
			stmtinv.setString(5,clientdet);
			stmtinv.setString(6,desc);
			stmtinv.setString(7,dtype.trim());
			stmtinv.setString(8,mode);
			stmtinv.setString(9,clacno);
			stmtinv.setInt(10,clientid);
			stmtinv.setString(11,session.getAttribute("USERID").toString());
			stmtinv.setString(12,branchid);
			stmtinv.setString(13,session.getAttribute("COMPANYID").toString());

			stmtinv.setInt(14,costid);
			stmtinv.setString(15,amount);
			stmtinv.setString(16,lfee);

			stmtinv.setInt(17,contractno);
			stmtinv.setInt(18,maintrno);

			int datas=stmtinv.executeUpdate();
			//	docno=stmtinv.getInt("docNo");
			protrno=stmtinv.getInt("trno");

			if(protrno<=0)
			{
				conn.close();
				return 0;
			}	

			if (protrno > 0) {
				conn.commit();
				stmtinv.close();
				conn.close();
				return protrno;
			}

			return protrno;

		}catch(Exception e){	
			e.printStackTrace();
			conn.close();	
		}
		return 0;
	}


	public int insert(Date sqldate,String refno,String contracttype,int contractno,String client,String clientdet,String desc,String branchid,String clacno,int clientid,int costid,ArrayList<String> enqarray,HttpSession session,String mode,String dtype,HttpServletRequest request) throws SQLException {
		try{
			int docno;
			int protrno;
			int  trno=-1;
			String amount="0";
			String lfee="0";
			conn=conobj.getMyConnection();
			conn.setAutoCommit(false);

			Statement stmt = conn.createStatement ();
			/*  String insql="insert into my_trno(userno,trtype,brhid,edate,transid) values("+session.getAttribute("USERID").toString() +",'PJIV',"+branchid +",NOW(),0)";
			int inres=stmt.executeUpdate(insql);

			if(inres<=0)
			{
				 stmt.close();
				 conn.close(); 
				return -1;
			}
			String upsql="select max(trno) trno from my_trno ";
							   ResultSet resultSet = stmt.executeQuery(upsql);

						   while (resultSet.next()) {
						 trno=resultSet.getInt("trno");
						    }		  */
			for(int i=0;i< enqarray.size();i++){

				String[] invdata=enqarray.get(i).split("::");

				amount=(invdata[0].trim().equalsIgnoreCase("undefined")|| invdata[0].trim().equalsIgnoreCase("NaN")|| invdata[0].trim().equalsIgnoreCase("") || invdata[0].trim().isEmpty())? "0": invdata[0].trim();
				lfee=(invdata[1].trim().equalsIgnoreCase("undefined")|| invdata[1].trim().equalsIgnoreCase("NaN")|| invdata[1].trim().equalsIgnoreCase("") || invdata[1].trim().isEmpty())? "0": invdata[1].trim();


			}

			CallableStatement stmtEnquiry = conn.prepareCall("{call projectproInvoiceDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");

			stmtEnquiry.setDate(1,sqldate);
			stmtEnquiry.setString(2,refno);
			stmtEnquiry.setString(3,contracttype);	
			stmtEnquiry.setString(4,client);
			stmtEnquiry.setString(5,clientdet);
			stmtEnquiry.setString(6,desc);
			stmtEnquiry.setString(7,dtype.trim());
			stmtEnquiry.setString(8,mode);
			stmtEnquiry.setString(9,clacno);
			stmtEnquiry.setInt(10,clientid);
			stmtEnquiry.setString(11,session.getAttribute("USERID").toString());
			stmtEnquiry.setString(12,branchid);
			stmtEnquiry.setString(13,session.getAttribute("COMPANYID").toString());

			stmtEnquiry.setInt(14,costid);
			stmtEnquiry.setString(15,amount);
			stmtEnquiry.setString(16,lfee);

			stmtEnquiry.setInt(17,contractno);
			stmtEnquiry.registerOutParameter(18, java.sql.Types.INTEGER);

			stmtEnquiry.executeQuery();
			//	docno=stmtEnquiry.getInt("docNo");
			protrno=stmtEnquiry.getInt("trno");

			if(protrno<=0)
			{
				conn.close();
				return 0;
			}	

			if (protrno > 0) {
				conn.commit();
				stmtEnquiry.close();
				conn.close();
				return protrno;
			}

			return protrno;

		}catch(Exception e){	
			e.printStackTrace();
			conn.close();	
		}
		return 0;
	}



	public JSONArray contractSrearch(HttpSession session,String msdocno,String Cl_names,String Cl_mobno,String enqdate,String dtype) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();
		Enumeration<String> Enumeration = session.getAttributeNames();
		int a=0;
		while(Enumeration.hasMoreElements()){
			if(Enumeration.nextElement().equalsIgnoreCase("BRANCHID")){
				a=1;
			}
		}
		if(a==0){
			return RESULTDATA;
		}


		String brcid=session.getAttribute("BRANCHID").toString();


		String sqltest="";
		java.sql.Date sqlStartDate=null;
		if(!(enqdate.equalsIgnoreCase("undefined"))&&!(enqdate.equalsIgnoreCase(""))&&!(enqdate.equalsIgnoreCase("0")))
		{
			sqlStartDate = com.changeStringtoSqlDate(enqdate);
			sqltest=sqltest+" and cm.date<="+sqlStartDate+"";
		}
		if(!(msdocno.equalsIgnoreCase("undefined"))&&!(msdocno.equalsIgnoreCase(""))&&!(msdocno.equalsIgnoreCase("0"))){
			sqltest=sqltest+" and cm.doc_no like '%"+msdocno+"%'";
		}
		if(!(Cl_names.equalsIgnoreCase("undefined"))&&!(Cl_names.equalsIgnoreCase(""))&&!(Cl_names.equalsIgnoreCase("0"))){
			sqltest=sqltest+" and ac.refname like '%"+Cl_names+"%'";
		}
		if(!(Cl_mobno.equalsIgnoreCase("undefined"))&&!(Cl_mobno.equalsIgnoreCase(""))&&!(Cl_mobno.equalsIgnoreCase("0"))){
			sqltest=sqltest+" and ac.com_mob like '%"+Cl_mobno+"%'";
		}
		if(!(dtype.equalsIgnoreCase("undefined"))&&!(dtype.equalsIgnoreCase(""))&&!(dtype.equalsIgnoreCase("0"))){
			sqltest=sqltest+" and cm.dtype='"+dtype+"'";
		}




		Connection conn =null;
		Statement stmt = null;
		try {
			conn = conobj.getMyConnection();
			stmt = conn.createStatement ();

			/*String str1Sql=("select m.date,m.tr_no,m.doc_no, ac.refname as name,coalesce(ac.cldocno,0) as clientid,coalesce(ac.acno,0) as clacno,"
						+ "concat(coalesce(ac.address,''),' ',coalesce(ac.com_mob,'') ,' ',coalesce(ac.mail1,'')) as details,"
						+ "if(m.cpersonid>0,c.cperson,coalesce(m.cperson,'')) as cperson,coalesce(c.row_no,0) as cpersonid,c.mob as contmob,m.dtype "
						+ "from cm_srvcontrm m left join my_acbook ac on(m.cldocno=ac.doc_no and ac.dtype='CRM') "
						+ "left join my_crmcontact c on(c.row_no=m.cpersonid) where 1=1 and m.status=3 "+sqltest+"");*/


			String str1Sql="select convert(concat(pd.sr_no,'/',p.mcntr),char(50)) as dueno,cm.date,pd.sr_no,cm.doc_no,cm.dtype,ac.acno as clacno,ac.doc_no as clientid,"
					+ "con.row_no as cpersonid,ac.refname name,coalesce(con.cperson,' ') cperson,concat(coalesce(ac.address,''),' ',coalesce(ac.com_mob,'') ,' ',coalesce(ac.mail1,'')) as details ,"
					+ "cm.ref_type refdtype,cm.refno,cm.validfrom sdate,cm.validupto edate,round(coalesce(pd.amount,'0.00'),2) dueamt, round(coalesce(cm.legalchrg,'0.00'),2) lfee,"
					+ "cm.brhid brch,cm.tr_no,pd.duedate as duedate from cm_srvcontrm cm  left join my_crmcontact con on(cm.cpersonid=con.row_no) left join  "
					+ "cm_srvcontrpd   pd on(pd.tr_no=cm.tr_no and pd.dueafser=98) left join my_acbook ac on (cm.cldocno=ac.cldocno) "
					+ "left join (select count(*) mcntr,tr_no from cm_srvcontrpd group by tr_no) p on(p.tr_no=cm.tr_no)  where 1=1 "
					+ "and pstatus=1 and pinvno=0 "+sqltest+" order by cm.dtype,cm.doc_no";


//			System.out.println("======contractSrearch===="+str1Sql);

			ResultSet resultSet = stmt.executeQuery (str1Sql);
			RESULTDATA=com.convertToJSON(resultSet);
			stmt.close();
			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			stmt.close();
			conn.close();
		}
		//System.out.println(RESULTDATA);
		return RESULTDATA;
	}

	public JSONArray serviceGridLoad(HttpSession session,String trno) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";
			String brhid=session.getAttribute("BRANCHID").toString();

			sql="select if(costtype=3,'AMC','SJOB') dtype,doc_no docno,date,description descp,round(atotal,2) amount,round(legalchrg,2) lfee from "
					+ "my_serpvm   where tr_no="+trno+"";

			//	System.out.println("===sql===="+sql);

			ResultSet resultSet1 = stmt.executeQuery(sql);
			RESULTDATA1=com.convertToJSON(resultSet1);

		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}


		return RESULTDATA1;
	}

	public   JSONArray searchMaster(HttpSession session,String msdocno,String clnames,String contno,String invdate,String invtype) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();
		Enumeration<String> Enumeration = session.getAttributeNames();
		int a=0;
		while(Enumeration.hasMoreElements()){
			if(Enumeration.nextElement().equalsIgnoreCase("BRANCHID")){
				a=1;
			}
		}
		if(a==0){
			return RESULTDATA;
		}

		//  System.out.println("8888888888"+clnames); 	
		String brid=session.getAttribute("BRANCHID").toString();



		java.sql.Date sqlStartDate=null;


		//enqdate.trim();
		if(!(invdate.equalsIgnoreCase("undefined"))&&!(invdate.equalsIgnoreCase(""))&&!(invdate.equalsIgnoreCase("0")))
		{
			sqlStartDate = com.changeStringtoSqlDate(invdate);
		}






		String sqltest="";
		if(!(msdocno.equalsIgnoreCase(""))){
			sqltest=sqltest+" and m.doc_no="+msdocno+" ";
		}
		if(!(clnames.equalsIgnoreCase(""))){
			sqltest=sqltest+" and ac.refname like '%"+clnames+"%'";
		}
		if(!(contno.equalsIgnoreCase(""))){
			sqltest=sqltest+" and m.doc_no like '%"+contno+"%'";
		}

		if(!(invtype.equalsIgnoreCase(""))){
			String invtypeval="";
			if(invtype.equalsIgnoreCase("AMC"))
			{
				invtypeval="3";
			}
			else if(invtype.equalsIgnoreCase("SJOB"))
			{
				invtypeval="4";
			}
			else
			{
			}

			sqltest=sqltest+" and m.costtype like '%"+invtypeval+"%'";
		}
		if(!(sqlStartDate==null)){
			sqltest=sqltest+" and m.date='"+sqlStartDate+"'";
		} 



		Connection conn = null;

		try {
			conn = conobj.getMyConnection();
			Statement stmtenq1 = conn.createStatement ();

			String clssql= ("select m.doc_no,m.doc_no contno,ac.refname client,m.date,if(m.costtype=3,'AMC','SJOB') contype,m.tr_no from my_serpvm m "
					+ "left join my_acbook ac on(m.cldocno=ac.doc_no and ac.dtype='CRM') where m.status=3 and m.brhid="+brid+" " +sqltest);
			//System.out.println("========"+clssql);
			ResultSet resultSet = stmtenq1.executeQuery(clssql);

			RESULTDATA=com.convertToJSON(resultSet);
			stmtenq1.close();
			conn.close();
		}
		catch(Exception e){
			conn.close();
			e.printStackTrace();
		}
		//System.out.println(RESULTDATA);
		return RESULTDATA;
	}

	public ClsProjectProInvoiceBean getViewDetails(HttpSession session,int trno,String branchid) throws SQLException {
		ClsProjectProInvoiceBean ProinvBean = new ClsProjectProInvoiceBean();

		Connection conn = null;

		try {
			conn = conobj.getMyConnection();
			Statement stmtPRIV = conn.createStatement();

			String branch = branchid;

			ResultSet resultSet = stmtPRIV.executeQuery ("select m.tr_no,m.doc_no,m.date,m.refno,c.refname client,concat(coalesce(c.address,''),' ',coalesce(c.com_mob,'') ,' ',coalesce(c.mail1,'')) as details,m.ref_type conttype,"
					+ "m.description desp,m.cldocno,m.costid,m.acno clacno,m.trtype costtype from my_serpvm m left join my_acbook c on m.cldocno=c.doc_no and c.dtype='CRM'  where m.status=3  and m.brhid="+branch+" and m.tr_no="+trno+"");

//			System.out.println("select m.tr_no,m.doc_no,m.date,m.refno,c.refname client,concat(coalesce(c.address,''),' ',coalesce(c.com_mob,'') ,' ',coalesce(c.mail1,'')) as details,m.ref_type conttype,"
//					+ "m.description desp,m.cldocno,m.costid,m.acno clacno,m.trtype costtype from my_serpvm m left join my_acbook c on m.cldocno=c.doc_no and c.dtype='CRM'  where m.status=3  and m.brhid="+branch+" and m.tr_no="+trno+"");


			while (resultSet.next()) {

				ProinvBean.setDocno(resultSet.getInt("doc_no"));
				ProinvBean.setDate(resultSet.getDate("date").toString());
				ProinvBean.setRefno(resultSet.getString("refno"));
				ProinvBean.setTxtclient(resultSet.getString("client"));
				ProinvBean.setTxtclientdet(resultSet.getString("details"));
				ProinvBean.setCmbcontracttype(resultSet.getString("costtype"));
				ProinvBean.setDesc(resultSet.getString("desp"));
				ProinvBean.setMaintrno(resultSet.getInt("tr_no"));
				ProinvBean.setClientid(resultSet.getInt("cldocno"));
				ProinvBean.setClacno(resultSet.getString("clacno"));
				ProinvBean.setCostid(resultSet.getInt("costid"));					

			}
			stmtPRIV.close();
			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
		return ProinvBean;
	}




	public ClsProjectProInvoiceBean printMaster(HttpSession session,String msdocno,String brhid,String trno,String dtype) throws SQLException {


		Enumeration<String> Enumeration = session.getAttributeNames();
		int a=0;
		while(Enumeration.hasMoreElements()){
			if(Enumeration.nextElement().equalsIgnoreCase("BRANCHID")){
				a=1;
			}
		}

		String brid=session.getAttribute("BRANCHID").toString();
		java.sql.Date sqlStartDate=null;
		String sqltest="";
		int contrno=0;
		String cntrtype="";
		String amount="0.00";
		String leglfee="0.00";
		String total="0.00";
		String description="";
		
		Connection conn = null;
		ArrayList sitelist=null;
		ArrayList trlist=null;
		ArrayList serlist=null;
		ArrayList paylist=null;
		try {
			sitelist= new ArrayList();
			trlist= new ArrayList();
			serlist= new ArrayList();
			paylist= new ArrayList();
			
			ClsNumberToWord obj=new ClsNumberToWord();

			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement ();


			/*System.out.println("select m.tr_no,m.doc_no,DATE_FORMAT(m.date,'%d-%m-%Y') date,m.refno,c.refname client,coalesce(c.address,'') as details,coalesce(c.com_mob,'') as mob ,coalesce(c.mail1,'') as email,m.ref_type conttype,"
					+ "m.description desp,m.cldocno,m.costid,m.acno clacno,m.trtype costtype,concat(m.trtype,'-',m.doc_no) as jobref,round(atotal,2) as atotal,round(legalchrg,2) as legalchrg,(round(atotal,2)+round(legalchrg,2)) as total, "
					+ "b.branchname brch,b.address as baddress,b.tel,b.fax,com.company comp,loc.loc_name,DATE_FORMAT(CURDATE(),'%d/%m/%Y') as finaldate  from my_serpvm m "
					+ "left join my_acbook c on (m.cldocno=c.doc_no and c.dtype='CRM') left join my_brch b on(b.doc_no=m.brhid) left join my_locm loc on(b.doc_no=loc.brhid) left join my_comp com on(com.doc_no=b.cmpid)  "
					+ "where m.status=3  and m.brhid="+brhid+" and m.tr_no="+trno+"");
			*/
			ResultSet resultSet = stmt.executeQuery ("select m.tr_no,m.doc_no,DATE_FORMAT(m.date,'%d-%m-%Y') date,m.refno,c.refname client,coalesce(c.address,'') as details,coalesce(c.com_mob,'') as mob ,coalesce(c.mail1,'') as email,m.ref_type conttype,"
					+ "m.description desp,m.cldocno,m.costid,m.acno clacno,m.trtype costtype,concat(m.trtype,'-',m.doc_no) as jobref,round(atotal,2) as atotal,round(legalchrg,2) as legalchrg,(round(atotal,2)+round(legalchrg,2)) as total, "
					+ "b.branchname brch,b.address as baddress,b.tel,b.fax,com.company comp,loc.loc_name,DATE_FORMAT(CURDATE(),'%d/%m/%Y') as finaldate  from my_serpvm m "
					+ "left join my_acbook c on (m.cldocno=c.doc_no and c.dtype='CRM') left join my_brch b on(b.doc_no=m.brhid) left join my_locm loc on(b.doc_no=loc.brhid) left join my_comp com on(com.doc_no=b.cmpid)  "
					+ "where m.status=3  and m.brhid="+brhid+" and m.tr_no="+trno+"");

			
			while (resultSet.next()) {

				bean.setDocno(resultSet.getInt("doc_no"));
				bean.setDate(resultSet.getString("date"));
				bean.setRefno(resultSet.getString("refno"));
				bean.setTxtclient(resultSet.getString("client"));
				bean.setTxtclientdet(resultSet.getString("details"));
				bean.setCmbcontracttype(resultSet.getString("costtype"));
				bean.setDesc(resultSet.getString("desp"));
				bean.setMaintrno(resultSet.getInt("tr_no"));
				bean.setClientid(resultSet.getInt("cldocno"));
				bean.setClacno(resultSet.getString("clacno"));
				bean.setCostid(resultSet.getInt("costid"));
				bean.setTxtjobrefno(resultSet.getString("jobref"));
				bean.setTxtemail(resultSet.getString("email"));
				bean.setTxtmob(resultSet.getString("mob"));
				bean.setLblbranch(resultSet.getString("brch"));
				bean.setLblcompaddress(resultSet.getString("baddress"));
				bean.setLblcompfax(resultSet.getString("fax"));
				bean.setLblcomptel(resultSet.getString("tel"));
				bean.setLbllocation(resultSet.getString("loc_name"));
				bean.setLblcompname(resultSet.getString("comp"));
				bean.setLblfinaldate(resultSet.getString("finaldate"));

				
				contrno=resultSet.getInt("costid");
				cntrtype=resultSet.getString("costtype");
				amount=resultSet.getString("atotal");
				leglfee=resultSet.getString("legalchrg");
				total=resultSet.getString("total");

			}
			ClsAmountToWords obj1=new ClsAmountToWords();
			   //System.out.println("total==="+total);
			   bean.setAmountinword(obj1.convertAmountToWords(total));
			//System.out.println("contrno==="+contrno);
			   
			 //fire7 print
			   String sitesql="select  coalesce(group_concat(site),'')site  from  cm_srvcsited  d left join "
			     + " my_groupvals g on(d.areaid=g.doc_no and grptype='area') where tr_no="+contrno+"";

			  // System.out.println("=====sitesql===="+sitesql);
			   ResultSet siters = stmt.executeQuery(sitesql);
			   if(siters.next()){
			    bean.setSitedetail(siters.getString("site"));
			   }
			   
			   
			String contrsql="select coalesce(con.cperson,'') cperson,coalesce(con.tel,'') tel from cm_srvcontrm cm "
					+ "left join my_crmcontact con on cm.cpersonid= con.row_no where cm.tr_no="+contrno+" ";
		//	System.out.println("contrsql==="+contrsql);
ResultSet rscon = stmt.executeQuery(contrsql);
			
			while(rscon.next()){
				bean.setCperson(rscon.getString("cperson"));
				bean.setTelph(rscon.getString("tel"));
				
			}
			/*String st="select "+total+" tot,@i:=@i+1 srno,a.* from ( select 'Contract Payment' as des,"+amount+" as amt "
					+ " union all"
					+ " select 'Civil Defense Contract Charges' as des,"+leglfee+" as amt)a, "
					+ "(select @i:=0) r" ;
			System.out.println("======st=========="+st);
*/			
			
			String sql1="select  IF(description IS NULL or description = '', '     ', description) description from cm_srvcontrpd "
					+ " where tr_no="+contrno+" and dueafser=98";

			ResultSet rs = stmt.executeQuery(sql1);
			
			while(rs.next()){
				description=rs.getString("description");
			}
			
			
			
			if(Double.parseDouble(total)>0){
				
				serlist.add("1"+"::"+cntrtype+"::"+"Contract Payment "+"::"+amount+"::"+description);
				
				
				serlist.add("2"+"::"+"DCD"+"::"+"Civil Defense Contract Charges "+"::"+leglfee+"::"+description);
				
				
				serlist.add(""+"::"+""+"::"+"Total "+"::"+total);
				
				serlist.add(""+"::"+""+"::"+"Total Job Value "+"::"+total);
				serlist.add(""+"::"+""+"::"+"Total invoiced (incl.this invoice) "+"::"+total);
				serlist.add(""+"::"+""+"::"+"Balance to be invoiced "+"::"+"0.00");
				
			}
			bean.setSerlist(serlist);
			//round(p.amount,2) invamt,p.count as srno, mxrno ,round(balance,2) balance,round(total,2) total
			
			/*String csql="select coalesce( round(p.amount,2),'') invamt,coalesce (p.count,'') srno, mxrno ,coalesce (round(balance,2),'') balance,coalesce(round(total,2),'') total from "
					+ "(select sum(invamt) amount,count(*) as count,tr_no from cm_srvcontrpd where tr_no="+contrno+" and invtrno>0) p "
					+ "left join (select sum(amount) as total,tr_no,max(sr_no) as mxrno from cm_srvcontrpd where tr_no="+contrno+") as a on(a.tr_no=p.tr_no) "
					+ "left join (select sum(amount) as balance,tr_no from cm_srvcontrpd where tr_no="+contrno+" and invtrno<=0) as b on(b.tr_no=p.tr_no) "
					+ "where p.tr_no="+contrno+"";*/

String csql="select coalesce( round(p.amount,2),'0') invamt,coalesce (p.count,'0') srno, mxrno ,coalesce (round(b.balance,2),'0.00') balance, "
		+ "coalesce(round(total,2),'') total from "
		+ " (select sum(amount) as total,tr_no,max(sr_no) as mxrno  from cm_srvcontrpd where tr_no="+contrno+") as a left join "
		+ "(select sum(invamt) amount,count(*) as count,tr_no from cm_srvcontrpd  where tr_no="+contrno+" and invtrno>0) p "
		+ "on(a.tr_no=p.tr_no) "
		+ " left join (select sum(amount) as balance,tr_no from cm_srvcontrpd where tr_no="+contrno+" and invtrno<=0) as b on(b.tr_no=a.tr_no)";
			 
			 
			//System.out.println("=====invoice tabledetails===="+csql);
			
			ResultSet crs = stmt.executeQuery(csql);
			int serno=1;
			if(crs.next()){
				
				
				 // fire 7 print
			    bean.setMxrnomin(crs.getString("srno"));
			    bean.setMxrnomax(crs.getString("mxrno"));
			    bean.setTotal1(crs.getString("total"));
			    bean.setInvoived(crs.getString("invamt"));
			    bean.setBalance(crs.getString("balance"));
			    //end
				
				String temp="";
				
				paylist.add("Invoice "+crs.getString("srno")+" of "+crs.getString("mxrno")+"");
				paylist.add("Total Job Value "+"::"+crs.getString("total"));
				paylist.add("Total invoiced (incl.this invoice) "+"::"+crs.getString("invamt"));
				paylist.add("Balance to be invoiced "+"::"+crs.getString("balance"));
				
		
				
				serno=serno+1;
			}
			
			bean.setPaylist(paylist);
			
			

			String sql="select  groupname area,g.doc_no areaid,site,upper(concat(site,',',groupname)) as sited from  cm_srvcsited  d left join my_groupvals g on(d.areaid=g.doc_no and grptype='area') "
					+ " where tr_no="+contrno+"";

//			System.out.println("===sitelist==="+sql);

			ResultSet rs2 = stmt.executeQuery(sql);
			String site="";
			String temp="";
			while(rs2.next()){


				site=rs2.getString("sited")+"::"+site;

				temp=site.trim();
				
			}
			
	
				
				sitelist.add(temp);
				bean.setSitelist(sitelist);

			

			String sql2="select m.voc_no,m.dtype,termsheader terms,conditions conditions from my_trterms tr left join my_termsm m on(tr.termsid=m.voc_no) where "
					+ " tr.dtype='"+dtype+"' and tr.rdocno="+msdocno+" order by terms";

//			System.out.println("==sql2===="+sql2);
			
			ResultSet rs3 = stmt.executeQuery(sql2);

			int trcount=1;
			String oldtrms="";
			String newtrms="";
			String testing="";
			String cond="";
			temp="";
			while(rs3.next()){


				newtrms=rs3.getString("terms");
				if(oldtrms.equalsIgnoreCase(newtrms)){
					testing="";
					trcount++;
				}
				else{
					trcount=1;
					testing=rs3.getString("terms");
				}
				cond=trcount+")"+rs3.getString("conditions");
				temp=testing+"::"+cond;	

				trlist.add(temp);
				oldtrms=newtrms;
			}
			bean.setTermlist(trlist);
			
			
			
			
			String str1="select '1' as qty,round(atotal,2) unitamount,description descp, "
					+ "round(atotal,2) amount,'' total from my_serpvm   where tr_no="+trno+" "
					+ " union all "
					+ " select '1' as qty,round(legalchrg,2) as unitamount,'Civil Defence Contract Charges' as descp, "
					+ " round(legalchrg,2) as amount,(round(atotal,2)+round(legalchrg,2)) as "
					+ " total from my_serpvm   where tr_no="+trno+";";
			bean.setProinvqry(str1);
			//System.out.println("=====bean.setProinvqry(str1)======"+bean.getProinvqry());
			stmt.close();
			conn.close();
		}

		catch(Exception e){
			
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		//System.out.println(RESULTDATA);
		return bean;
	}
	public  JSONArray convertArrayToJSON(ArrayList<String> arrayList) throws Exception {
		JSONArray jsonArray = new JSONArray();

		for (int i = 0; i < arrayList.size(); i++) {

			JSONObject obj = new JSONObject();

			String[] Array=arrayList.get(i).split("::");

			obj.put("id",Array[0]);
			obj.put("description",Array[1]);
			obj.put("grpamt",Array[2]);
			obj.put("netamt",Array[3]);
			obj.put("childamt",Array[4]);
			obj.put("subchildamt",Array[5]);
			obj.put("parentid",Array[6]);
			obj.put("ordno",Array[7]);
			obj.put("groupno",Array[8]);
			obj.put("subac",Array[9]);
			obj.put("gp_id",Array[10]);

			jsonArray.add(obj);
		}
		return jsonArray;
	}




}
