package com.project.execution.projectInvoice;

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

import com.common.ClsCommon;
import com.common.ClsNumberToWord;
import com.connection.ClsConnection;
import com.project.execution.projectInvoice.ClsProjectInvoiceBean;
import com.project.execution.projectproInvoice.ClsProjectProInvoiceBean;

import net.sf.json.JSONArray;

public class ClsProjectInvoiceDAO {


	ClsCommon com=new ClsCommon();
	ClsConnection conobj=new ClsConnection();
	ClsProjectInvoiceBean bean= new ClsProjectInvoiceBean();
	Connection conn;


	public int insert(Date sqldate,String refno,String contracttype,int contractno,String client,String clientdet,String desc,String branchid,String clacno,int clientid,
			int costid,ArrayList<String> enqarray,ArrayList exparray,HttpSession session,String mode,String dtype,HttpServletRequest request,
			String legalamt,String seramt,String exptotal,String inctax,String pdid,String txtnotes,String ptype,Double taxamt,ArrayList taxlist,String nontax) throws SQLException {
		try{
			int docno;
			int protrno;
			int trno=-1;
			String amount="0";
			String lfee="0";
			conn=conobj.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmt = conn.createStatement ();
			double taxcalcamt=Double.parseDouble(legalamt)+Double.parseDouble(seramt)+Double.parseDouble(exptotal);

			trno=getTrno(session, dtype, branchid,conn);

			amount=seramt;
			lfee=legalamt;

			double taxinvamt=0.0;
			double totaltaxper=0.0;
			
			if(nontax.equalsIgnoreCase("0")){
			     if(inctax.equalsIgnoreCase("1")){
			    	 taxinvamt=Double.parseDouble(seramt)-taxamt;
			    	 

			       }
			     else {
			    	 taxinvamt=Double.parseDouble(seramt);
			     }
			}
			
			else{
				
				taxinvamt=Double.parseDouble(seramt);
			}
			if(contracttype.equalsIgnoreCase("SINV"))
			{
				amount=seramt+"";
			}
			else{
				amount=taxinvamt+"";
			}
			
			//System.out.println("=amount=="+amount+"==lfee==="+lfee+"==exptotal=="+exptotal+"===taxamt==="+taxamt+"==nettotal=="+nettotal);

			CallableStatement stmt1 = conn.prepareCall("{call Sr_projectInvoiceDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");

			stmt1.registerOutParameter(25, java.sql.Types.INTEGER);	
			stmt1.registerOutParameter(26, java.sql.Types.INTEGER);

			stmt1.setDate(1,sqldate);
			stmt1.setString(2,refno);
			stmt1.setString(3,contracttype);		
			stmt1.setString(4,client);
			stmt1.setString(5,clientdet);
			stmt1.setString(6,desc);
			stmt1.setString(7,dtype.trim());
			stmt1.setString(8,mode);
			stmt1.setString(9,clacno);
			stmt1.setInt(10,clientid);
			stmt1.setString(11,session.getAttribute("USERID").toString());
			stmt1.setString(12,branchid);
			stmt1.setString(13,session.getAttribute("COMPANYID").toString());
			stmt1.setInt(14,costid);
			stmt1.setString(15,amount);
			stmt1.setString(16,lfee);
			stmt1.setInt(17,contractno);
			stmt1.setDouble(18,taxcalcamt);
			stmt1.setString(19,pdid==null || pdid=="" || pdid.equalsIgnoreCase("")?"0":pdid);
			stmt1.setString(20,exptotal);
			stmt1.setString(21,txtnotes);
			stmt1.setString(22,ptype);
			stmt1.setDouble(23,taxamt);
			stmt1.setInt(24,trno);

//System.out.println("=====stmt1======"+stmt1);
			stmt1.executeQuery();
			
			docno=stmt1.getInt("docNo");
			protrno=stmt1.getInt("trno");

			request.setAttribute("docno", docno);
int sitemethod=0;
String description=desc;
			if(protrno>0){

				// site in jvtran with description
				String siteconfig="select method from gl_config where field_nme='invoicesite'";
				ResultSet siters = stmt.executeQuery (siteconfig);
				if (siters.next()) {
					sitemethod=siters.getInt("method");
				}
				if(sitemethod==1)
				{
					String sitedata="select site from cm_srvcsited where tr_no='"+costid+"' order by rowno limit 1";
					ResultSet sitedatars = stmt.executeQuery (sitedata);
					if (sitedatars.next()) {
						description=contracttype+"-"+contractno+","+desc+"-"+sitedatars.getString("site");
					}
				}


				for(int i=0;i< exparray.size();i++){


					String[] surveydet=((String) exparray.get(i)).split("::");
					if(!(surveydet[0].trim().equalsIgnoreCase("undefined")|| surveydet[0].trim().equalsIgnoreCase("NaN")||surveydet[0].trim().equalsIgnoreCase("")|| surveydet[0].isEmpty()))
					{

						String sql="INSERT INTO my_servd(SR_NO,DESCRIPTION,productId,qty, AMOUNT,NetTotal,TR_NO)VALUES"
								+ " ("+(i+1)+","
								+ "'"+(surveydet[0].trim().equalsIgnoreCase("undefined") || surveydet[0].trim().equalsIgnoreCase("NaN")|| surveydet[0].trim().equalsIgnoreCase("")|| surveydet[0].isEmpty()?0:surveydet[0].trim())+"',"
								+ "'"+(surveydet[1].trim().equalsIgnoreCase("undefined") || surveydet[1].trim().equalsIgnoreCase("NaN")|| surveydet[1].trim().equalsIgnoreCase("")|| surveydet[1].isEmpty()?0:surveydet[1].trim())+"',"
								+ "'"+(surveydet[3].trim().equalsIgnoreCase("undefined") || surveydet[3].trim().equalsIgnoreCase("NaN")|| surveydet[3].trim().equalsIgnoreCase("")|| surveydet[3].isEmpty()?0:surveydet[3].trim())+"',"
								+ "'"+(surveydet[4].trim().equalsIgnoreCase("undefined") || surveydet[4].trim().equalsIgnoreCase("NaN")|| surveydet[4].trim().equalsIgnoreCase("")|| surveydet[4].isEmpty()?0:surveydet[4].trim())+"',"
								+ "'"+(surveydet[5].trim().equalsIgnoreCase("undefined") || surveydet[5].trim().equalsIgnoreCase("NaN")|| surveydet[5].trim().equalsIgnoreCase("")|| surveydet[5].isEmpty()?0:surveydet[5].trim())+"',"
								+"'"+protrno+"')";

						//						System.out.println("==sitelist==="+sql);

						int resultSet2 = stmt.executeUpdate (sql);
						if(resultSet2<=0)
						{
							conn.close();
							return 0;
						}
						//conn.commit();

					}

				}

				//tmp=resultSet.getString("codeno")+"::"+resultSet.getString("acno")+"::"+resultSet.getString("per")+"::"+resultSet.getString("taxamt")+"::"+resultSet.getString("docno");
if(nontax.equalsIgnoreCase("0")){
				for(int i=0;i< taxlist.size();i++){

					String[] surveydet=((String) taxlist.get(i)).split("::");
					if(!(surveydet[0].trim().equalsIgnoreCase("undefined")|| surveydet[0].trim().equalsIgnoreCase("NaN")||surveydet[0].trim().equalsIgnoreCase("")|| surveydet[0].isEmpty()))
					{

						totaltaxper=totaltaxper+Double.parseDouble(surveydet[2].trim());
					
						String sql="INSERT INTO my_invtaxdet( rdocno, taxid,acno, per, amount)VALUES"
								+ " ("+(protrno)+","
								+ "'"+(surveydet[4].trim().equalsIgnoreCase("undefined") || surveydet[4].trim().equalsIgnoreCase("NaN")|| surveydet[4].trim().equalsIgnoreCase("")|| surveydet[4].isEmpty()?0:surveydet[4].trim())+"',"
								+ "'"+(surveydet[1].trim().equalsIgnoreCase("undefined") || surveydet[1].trim().equalsIgnoreCase("NaN")|| surveydet[1].trim().equalsIgnoreCase("")|| surveydet[1].isEmpty()?0:surveydet[1].trim())+"',"
								+ "'"+(surveydet[2].trim().equalsIgnoreCase("undefined") || surveydet[2].trim().equalsIgnoreCase("NaN")|| surveydet[2].trim().equalsIgnoreCase("")|| surveydet[2].isEmpty()?0:surveydet[2].trim())+"',"
								+ "'"+(surveydet[3].trim().equalsIgnoreCase("undefined") || surveydet[3].trim().equalsIgnoreCase("NaN")|| surveydet[3].trim().equalsIgnoreCase("")|| surveydet[3].isEmpty()?0:surveydet[3].trim())+"')";

						int rest = stmt.executeUpdate (sql);
						if(rest<=0)
						{
							conn.close();
							return 0;
						}
						//conn.commit();

					}

				}

}
				if(ptype.equalsIgnoreCase("2")){

					String sqlpl="update cm_servplan set invtrno="+trno+" where iserv=1 and doc_no="+costid+" and tr_no in ("+pdid+")";

					int spl = stmt.executeUpdate(sqlpl);
					
					String sqlothrupd="update cm_srvspares ss left join cm_srvdetm sv on sv.tr_no=ss.tr_no left join cm_servplan sch "
							+ "on sch.tr_no=sv.schrefdocno and ss.chg=1 and ss.invtrno=0 set ss.invtrno="+trno+" "
									+ "where sv.schrefdocno in ("+pdid+")";
					
					int othin = stmt.executeUpdate(sqlothrupd);
					if(spl<=0)
					{
						conn.close();
						return 0;

					}	

				}



				int acnos=0;
				String curris="1";
				double rates=1;
				double finalamt=0.0;
				double tper=0.0;
				int costtype=0;
				int costcode=0;
				int cldocno=0;
				String descs="Invoice "+dtype+"-"+""+docno+""+":-Dated :- "+sqldate; 
				String refdetails=""+dtype+""+docno;
				String sql2="";
				String jvbranch="";
				int id=0;
				int tranid=0;
				int loopval=3;
				loopval=taxlist.size()>0?(loopval+taxlist.size()):loopval;
				

				for(int a=0;a<=loopval;a++){

					acnos=0;

					if(a==0){
						if(contracttype.equalsIgnoreCase("AMC")){
							costtype=3;
							costcode=costid;
							sql2="select  acno from my_account where codeno='AMC INCOME' ";
						}
						if(contracttype.equalsIgnoreCase("SJOB")){
							costtype=4;
							costcode=costid;
							sql2="select  acno from my_account where codeno='SJOB INCOME' ";
						}
						
						System.out.println("==contracttype==="+contracttype);
						
						if(contracttype.equalsIgnoreCase("SINV")){
							costtype=0;
							costcode=costid;
							sql2="select  acno from my_account where codeno='SINCOME' ";
						}

						ResultSet tass1 = stmt.executeQuery (sql2);

						if (tass1.next()) {
							acnos=tass1.getInt("acno");
						}
						jvbranch=branchid;
						id=-1;

						if(inctax.equalsIgnoreCase("0") || contracttype.equalsIgnoreCase("SINV")){
							finalamt=Double.parseDouble(seramt);

						}
						else if(inctax.equalsIgnoreCase("1")){
							//finalamt=Double.parseDouble(seramt)-taxamt;
							
							
							finalamt=Double.parseDouble(seramt)/((totaltaxper/100)+1);
							System.out.println("finalamt=="+finalamt);
						}

						cldocno=0;
					}
					if(a==1){
						sql2="select  acno from my_account where codeno='Legal Contract' ";
						ResultSet tass1 = stmt.executeQuery (sql2);
						if (tass1.next()) {
							acnos=tass1.getInt("acno");
						}
						jvbranch=branchid+"";
						id=-1;
						if(inctax.equalsIgnoreCase("0") || contracttype.equalsIgnoreCase("SINV")){
							finalamt=Double.parseDouble(legalamt);

						}
						else if(inctax.equalsIgnoreCase("1")){
							
							finalamt=Double.parseDouble(legalamt)/((totaltaxper/100)+1);
						}
						
						//costtype=0;
						//costcode=0;
						cldocno=0;
					}

					if(a==2){
						sql2="select  acno from my_account where codeno='Other' ";
						ResultSet tass1 = stmt.executeQuery (sql2);
						if (tass1.next()) {
							acnos=tass1.getInt("acno");
						}
						jvbranch=branchid+"";
						id=-1;
						if(inctax.equalsIgnoreCase("0") || contracttype.equalsIgnoreCase("SINV")){
							finalamt=Double.parseDouble(exptotal);

						}
						else if(inctax.equalsIgnoreCase("1")){
							
							finalamt=Double.parseDouble(exptotal)/((totaltaxper/100)+1);
						}
					
						cldocno=0;
					}

					if(a==3){

						acnos=Integer.parseInt(clacno);
						jvbranch=branchid+"";
						id=1;

						if(inctax.equalsIgnoreCase("0") || contracttype.equalsIgnoreCase("SINV")){
							finalamt=taxcalcamt+taxamt;

						}
						else if(!(inctax.equalsIgnoreCase("0"))){
							finalamt=taxcalcamt;
						}
						costtype=0;
						costcode=0;
						cldocno=clientid;
					}

					if(a>3){
						
						String[] taxdet=((String) taxlist.get(a-4)).split("::");
						if(!(taxdet[0].trim().equalsIgnoreCase("undefined")|| taxdet[0].trim().equalsIgnoreCase("NaN")||taxdet[0].trim().equalsIgnoreCase("")|| taxdet[0].isEmpty()))
						{

							acnos=Integer.parseInt(taxdet[1].trim());
							finalamt=Double.parseDouble(taxdet[3].trim());
					
						jvbranch=branchid+"";
						id=-1;
						cldocno=0;
						
						}
					
					}
					
				/*	if(a==4){
						sql2="select t.tax_code,t.acno,t.value,per,("+taxcalcamt+"*t.per)/100 as taxamt,t.doc_no docno "
								+" from  gl_taxsubmaster t where   fromdate<='"+sqldate+"' and todate>='"+sqldate+"' and status=3 and type=2 and seqno=1";
						ResultSet tass1 = stmt.executeQuery (sql2);
						if (tass1.next()) {
							acnos=tass1.getInt("acno");
							finalamt=tass1.getDouble("taxamt");
						}
						jvbranch=branchid+"";
						id=-1;
						cldocno=0;
					}
					if(a==5){
						sql2="select t.tax_code,t.acno,t.value,per,("+taxcalcamt+"*t.per)/100 as taxamt,t.doc_no docno "
								+" from  gl_taxsubmaster t where   fromdate<='"+sqldate+"' and todate>='"+sqldate+"' and status=3 and type=2 and seqno=2";
						ResultSet tass1 = stmt.executeQuery (sql2);
						if (tass1.next()) {
							acnos=tass1.getInt("acno");
							finalamt=tass1.getDouble("taxamt");
						}
						jvbranch=branchid+"";
						id=-1;


						cldocno=0;
					}
					if(a==6){
						sql2="select t.tax_code,t.acno,t.value,per,("+taxcalcamt+"*t.per)/100 as taxamt,t.doc_no docno "
								+" from  gl_taxsubmaster t where   fromdate<='"+sqldate+"' and todate>='"+sqldate+"' and status=3 and type=2 and seqno=3";
						ResultSet tass1 = stmt.executeQuery (sql2);
						if (tass1.next()) {
							acnos=tass1.getInt("acno");
							finalamt=tass1.getDouble("taxamt");
						}
						jvbranch=branchid+"";
						id=-1;

						cldocno=0;
					}
					*/




					String sqls3="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+acnos+"'";
					//System.out.println("-----5--sqls3----"+sqls3) ;
					ResultSet tass3 = stmt.executeQuery (sqls3);

					if (tass3.next()) {

						curris=tass3.getString("curid");	


					}
					String currencytype1="";
					String sqlveh = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
							+"where  coalesce(toDate,curdate())>='"+sqldate+"' and frmDate<='"+sqldate+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+curris+"'";
					//System.out.println("-----6--sqlveh----"+sqlveh) ;
					ResultSet resultSet44 = stmt.executeQuery(sqlveh);

					while (resultSet44.next()) {
						rates=resultSet44.getDouble("rate");
						currencytype1=resultSet44.getString("type");
					} 

					double pricetottal=(finalamt)*id;
					double ldramounts=0 ;     
					if(currencytype1.equalsIgnoreCase("D"))
					{

						ldramounts=pricetottal/rates ;  
					}

					else
					{
						ldramounts=pricetottal*rates ;  
					}
					if(pricetottal!=0){

						String sql11="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
								+ "values('"+sqldate+"','"+refdetails+"',"+docno+",'"+acnos+"','"+description+"','"+curris+"','"+rates+"',"+pricetottal+","+ldramounts+",0,"+id+","+costtype+",0,0,"+cldocno+",'"+rates+"',"+costtype+","+costcode+",'"+dtype+"','"+jvbranch+"',"+trno+",3)";

						//					System.out.println("====sql11==a"+a+"===="+sql11);

						int ss1 = stmt.executeUpdate(sql11);

						if(ss1<=0)
						{
							conn.close();
							return 0;

						}

						if(a!=3){

							String sqlss="select tranid from my_jvtran where tr_no='"+trno+"' and brhId='"+jvbranch+"' and acno='"+acnos+"' and doc_no='"+docno+"' and dtype='"+dtype+"'";

							ResultSet rss = stmt.executeQuery(sqlss);

							while (rss.next()) {
								tranid=rss.getInt("tranid");
							}	

							String sql="insert into my_costtran(acno, costType, amount, tr_no, jobId,tranid,sr_no) "
									+ "values('"+acnos+"','"+costtype+"',"+ldramounts+",'"+trno+"','"+costcode+"',"+tranid+","+(a+1)+")";

							//System.out.println("==sql===="+sql);

							int rs2 = stmt.executeUpdate(sql);

							if(rs2<=0)
							{
								conn.close();
								return 0;

							}
						}
					}


				}

				conn.commit();


			}

			if(protrno<=0)
			{
				conn.close();
				return 0;
			}	

			if (protrno > 0) {
				conn.commit();
				stmt1.close();
				conn.close();
				return protrno;
			}

			//return protrno;

		}catch(Exception e){	
			e.printStackTrace();
			conn.close();	
		}
		return 0;
	}

	public int edit(int trno,int docno,Date sqldate,String refno,String contracttype,int contractno,String client,String clientdet,String desc,String branchid,String clacno,int clientid,
			int costid,ArrayList<String> enqarray,ArrayList exparray,HttpSession session,String mode,String dtype,HttpServletRequest request,
			String legalamt,String seramt,String exptotal,String inctax,String pdid,String txtnotes,String ptype,Double taxamt,ArrayList taxlist) throws SQLException {
		try{

			int protrno;
			String amount="0";
			String lfee="0";
			conn=conobj.getMyConnection();
			conn.setAutoCommit(false);

			Statement stmt = conn.createStatement ();
			double taxcalcamt=Double.parseDouble(legalamt)+Double.parseDouble(seramt)+Double.parseDouble(exptotal);
			for(int i=0;i< enqarray.size();i++){

				String[] invdata=enqarray.get(i).split("::");

				amount=(invdata[0].trim().equalsIgnoreCase("undefined")|| invdata[0].trim().equalsIgnoreCase("NaN"))? "0": invdata[0].trim();
				lfee=(invdata[1].trim().equalsIgnoreCase("undefined")|| invdata[1].trim().equalsIgnoreCase("NaN"))? "0": invdata[1].trim();


			}

			CallableStatement stmt1 = conn.prepareCall("{call Sr_projectInvoiceDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");


			stmt1.registerOutParameter(26, java.sql.Types.INTEGER);	

			stmt1.setDate(1,sqldate);
			stmt1.setString(2,refno);
			stmt1.setString(3,contracttype);		
			stmt1.setString(4,client);
			stmt1.setString(5,clientdet);
			stmt1.setString(6,desc);
			stmt1.setString(7,dtype.trim());
			stmt1.setString(8,mode);
			stmt1.setString(9,clacno);
			stmt1.setInt(10,clientid);
			stmt1.setString(11,session.getAttribute("USERID").toString());
			stmt1.setString(12,branchid);
			stmt1.setString(13,session.getAttribute("COMPANYID").toString());
			stmt1.setInt(14,costid);
			stmt1.setString(15,amount);
			stmt1.setString(16,lfee);
			stmt1.setInt(17,contractno);
			stmt1.setDouble(18,taxcalcamt);
			stmt1.setString(19,pdid);
			stmt1.setString(20,exptotal);
			stmt1.setString(21,txtnotes);
			stmt1.setString(22,ptype);
			stmt1.setDouble(23,taxamt);
			stmt1.setInt(24,trno);
			stmt1.setInt(25,docno);

			stmt1.executeQuery();
			docno=stmt1.getInt("docNo");
			protrno=stmt1.getInt("trno");

			request.setAttribute("docno", docno);

			if(protrno>0){


				/*				for(int i=0;i< exparray.size();i++){


					String[] surveydet=((String) exparray.get(i)).split("::");
					if(!(surveydet[0].trim().equalsIgnoreCase("undefined")|| surveydet[0].trim().equalsIgnoreCase("NaN")||surveydet[0].trim().equalsIgnoreCase("")|| surveydet[0].isEmpty()))
					{

						String sql="INSERT INTO my_servd(SR_NO,DESCRIPTION,productId,qty, AMOUNT,NetTotal,TR_NO)VALUES"
								+ " ("+(i+1)+","
								+ "'"+(surveydet[0].trim().equalsIgnoreCase("undefined") || surveydet[0].trim().equalsIgnoreCase("NaN")|| surveydet[0].trim().equalsIgnoreCase("")|| surveydet[0].isEmpty()?0:surveydet[0].trim())+"',"
								+ "'"+(surveydet[1].trim().equalsIgnoreCase("undefined") || surveydet[1].trim().equalsIgnoreCase("NaN")|| surveydet[1].trim().equalsIgnoreCase("")|| surveydet[1].isEmpty()?0:surveydet[1].trim())+"',"
								+ "'"+(surveydet[3].trim().equalsIgnoreCase("undefined") || surveydet[3].trim().equalsIgnoreCase("NaN")|| surveydet[3].trim().equalsIgnoreCase("")|| surveydet[3].isEmpty()?0:surveydet[3].trim())+"',"
								+ "'"+(surveydet[4].trim().equalsIgnoreCase("undefined") || surveydet[4].trim().equalsIgnoreCase("NaN")|| surveydet[4].trim().equalsIgnoreCase("")|| surveydet[4].isEmpty()?0:surveydet[4].trim())+"',"
								+ "'"+(surveydet[5].trim().equalsIgnoreCase("undefined") || surveydet[5].trim().equalsIgnoreCase("NaN")|| surveydet[5].trim().equalsIgnoreCase("")|| surveydet[5].isEmpty()?0:surveydet[5].trim())+"',"
								+"'"+protrno+"')";

						//						System.out.println("==sitelist==="+sql);

						int resultSet2 = stmt.executeUpdate (sql);
						if(resultSet2<=0)
						{
							conn.close();
							return 0;
						}
						//conn.commit();

					}

				}


				for(int i=0;i< taxlist.size();i++){

					String[] surveydet=((String) taxlist.get(i)).split("::");
					if(!(surveydet[0].trim().equalsIgnoreCase("undefined")|| surveydet[0].trim().equalsIgnoreCase("NaN")||surveydet[0].trim().equalsIgnoreCase("")|| surveydet[0].isEmpty()))
					{

						String sql="INSERT INTO my_invtaxdet( rdocno, taxid,acno, per, amount)VALUES"
								+ " ("+(protrno)+","
								+ "'"+(surveydet[4].trim().equalsIgnoreCase("undefined") || surveydet[4].trim().equalsIgnoreCase("NaN")|| surveydet[4].trim().equalsIgnoreCase("")|| surveydet[4].isEmpty()?0:surveydet[4].trim())+"',"
								+ "'"+(surveydet[1].trim().equalsIgnoreCase("undefined") || surveydet[1].trim().equalsIgnoreCase("NaN")|| surveydet[1].trim().equalsIgnoreCase("")|| surveydet[1].isEmpty()?0:surveydet[1].trim())+"',"
								+ "'"+(surveydet[2].trim().equalsIgnoreCase("undefined") || surveydet[2].trim().equalsIgnoreCase("NaN")|| surveydet[2].trim().equalsIgnoreCase("")|| surveydet[2].isEmpty()?0:surveydet[2].trim())+"',"
								+ "'"+(surveydet[3].trim().equalsIgnoreCase("undefined") || surveydet[3].trim().equalsIgnoreCase("NaN")|| surveydet[3].trim().equalsIgnoreCase("")|| surveydet[3].isEmpty()?0:surveydet[3].trim())+"')";

						int rest = stmt.executeUpdate (sql);
						if(rest<=0)
						{
							conn.close();
							return 0;
						}
						//conn.commit();

					}

				}

				if(ptype.equalsIgnoreCase("2")){

					String sqlpl="update cm_servplan set invtrno="+trno+" where iserv=1 and doc_no="+costid+" and tr_no in ("+pdid+")";

					int spl = stmt.executeUpdate(sqlpl);

					if(spl<=0)
					{
						conn.close();
						return 0;

					}	

				}

				int acnos=0;
				String curris="1";
				double rates=1;
				double finalamt=0.0;
				double tper=0.0;
				int costtype=0;
				int costcode=0;
				int cldocno=0;
				String descs="Invoice "+dtype+"-"+""+docno+""+":-Dated :- "+sqldate; 
				String refdetails=""+dtype+""+docno;
				String sql2="";
				String jvbranch="";
				int id=0;
				int tranid=0;
				int loopval=3;
				loopval=taxlist.size()>0?(loopval+taxlist.size()):loopval;

				for(int a=0;a<=loopval;a++){

					acnos=0;

					if(a==0){
						if(contracttype.equalsIgnoreCase("AMC")){
							costtype=3;
							costcode=costid;
							sql2="select  acno from my_account where codeno='AMC INCOME' ";
						}
						if(contracttype.equalsIgnoreCase("SJOB")){
							costtype=4;
							costcode=costid;
							sql2="select  acno from my_account where codeno='SJOB INCOME' ";
						}
						if(contracttype.equalsIgnoreCase("SINV")){
							costtype=0;
							costcode=costid;
							sql2="select  acno from my_account where codeno='SINCOME' ";
						}

						ResultSet tass1 = stmt.executeQuery (sql2);

						if (tass1.next()) {
							acnos=tass1.getInt("acno");
						}
						jvbranch=branchid;
						id=-1;

						if(inctax.equalsIgnoreCase("0")){
							finalamt=Double.parseDouble(seramt);

						}
						else if(!(inctax.equalsIgnoreCase("0"))){
							finalamt=Double.parseDouble(seramt)-taxamt;
						}

						cldocno=0;
					}
					if(a==1){
						sql2="select  acno from my_account where codeno='Legal Contract' ";
						ResultSet tass1 = stmt.executeQuery (sql2);
						if (tass1.next()) {
							acnos=tass1.getInt("acno");
						}
						jvbranch=branchid+"";
						id=-1;
						finalamt=Double.parseDouble(legalamt);
						//costtype=0;
						//costcode=0;
						cldocno=0;
					}

					if(a==2){
						sql2="select  acno from my_account where codeno='Other' ";
						ResultSet tass1 = stmt.executeQuery (sql2);
						if (tass1.next()) {
							acnos=tass1.getInt("acno");
						}
						jvbranch=branchid+"";
						id=-1;
						finalamt=Double.parseDouble(exptotal);

						cldocno=0;
					}

					if(a==3){

						acnos=Integer.parseInt(clacno);
						jvbranch=branchid+"";
						id=1;

						if(inctax.equalsIgnoreCase("0")){
							finalamt=taxcalcamt+taxamt;

						}
						else if(!(inctax.equalsIgnoreCase("0"))){
							finalamt=taxcalcamt;
						}
						costtype=0;
						costcode=0;
						cldocno=clientid;
					}

					if(a==4){
						sql2="select t.tax_code,t.acno,t.value,per,("+taxcalcamt+"*t.per)/100 as taxamt,t.doc_no docno "
								+" from  gl_taxsubmaster t where   fromdate<='"+sqldate+"' and todate>='"+sqldate+"' and status=3 and type=2 and seqno=1";
						ResultSet tass1 = stmt.executeQuery (sql2);
						if (tass1.next()) {
							acnos=tass1.getInt("acno");
							finalamt=tass1.getDouble("taxamt");
						}
						jvbranch=branchid+"";
						id=-1;
						cldocno=0;
					}
					if(a==5){
						sql2="select t.tax_code,t.acno,t.value,per,("+taxcalcamt+"*t.per)/100 as taxamt,t.doc_no docno "
								+" from  gl_taxsubmaster t where   fromdate<='"+sqldate+"' and todate>='"+sqldate+"' and status=3 and type=2 and seqno=2";
						ResultSet tass1 = stmt.executeQuery (sql2);
						if (tass1.next()) {
							acnos=tass1.getInt("acno");
							finalamt=tass1.getDouble("taxamt");
						}
						jvbranch=branchid+"";
						id=-1;


						cldocno=0;
					}
					if(a==6){
						sql2="select t.tax_code,t.acno,t.value,per,("+taxcalcamt+"*t.per)/100 as taxamt,t.doc_no docno "
								+" from  gl_taxsubmaster t where   fromdate<='"+sqldate+"' and todate>='"+sqldate+"' and status=3 and type=2 and seqno=3";
						ResultSet tass1 = stmt.executeQuery (sql2);
						if (tass1.next()) {
							acnos=tass1.getInt("acno");
							finalamt=tass1.getDouble("taxamt");
						}
						jvbranch=branchid+"";
						id=-1;

						cldocno=0;
					}




					String sqls3="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+acnos+"'";
					//System.out.println("-----5--sqls3----"+sqls3) ;
					ResultSet tass3 = stmt.executeQuery (sqls3);

					if (tass3.next()) {

						curris=tass3.getString("curid");	


					}
					String currencytype1="";
					String sqlveh = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
							+"where  coalesce(toDate,curdate())>='"+sqldate+"' and frmDate<='"+sqldate+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+curris+"'";
					//System.out.println("-----6--sqlveh----"+sqlveh) ;
					ResultSet resultSet44 = stmt.executeQuery(sqlveh);

					while (resultSet44.next()) {
						rates=resultSet44.getDouble("rate");
						currencytype1=resultSet44.getString("type");
					} 

					double pricetottal=(finalamt)*id;
					double ldramounts=0 ;     
					if(currencytype1.equalsIgnoreCase("D"))
					{

						ldramounts=pricetottal/rates ;  
					}

					else
					{
						ldramounts=pricetottal*rates ;  
					}
					if(pricetottal!=0){

						String sql11="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
								+ "values('"+sqldate+"','"+refdetails+"',"+docno+",'"+acnos+"','"+desc+"','"+curris+"','"+rates+"',"+pricetottal+","+ldramounts+",0,"+id+","+costtype+",0,0,"+cldocno+",'"+rates+"',"+costtype+","+costcode+",'"+dtype+"','"+jvbranch+"',"+trno+",3)";

						//					System.out.println("====sql11==a"+a+"===="+sql11);

						int ss1 = stmt.executeUpdate(sql11);

						if(ss1<=0)
						{
							conn.close();
							return 0;

						}

						if(a!=3){

							String sqlss="select tranid from my_jvtran where tr_no='"+trno+"' and brhId='"+jvbranch+"' and acno='"+acnos+"' and doc_no='"+docno+"' and dtype='"+dtype+"'";

							ResultSet rss = stmt.executeQuery(sqlss);

							while (rss.next()) {
								tranid=rss.getInt("tranid");
							}	

							String sql="insert into my_costtran(acno, costType, amount, tr_no, jobId,tranid,sr_no) "
									+ "values('"+acnos+"','"+costtype+"',"+ldramounts+",'"+trno+"','"+costcode+"',"+tranid+","+(a+1)+")";

							//System.out.println("==sql===="+sql);

							int rs2 = stmt.executeUpdate(sql);

							if(rs2<=0)
							{
								conn.close();
								return 0;

							}
						}
					}




				}
				 */
				conn.commit();


			}

			if(protrno<=0)
			{
				conn.close();
				return 0;
			}	

			if (protrno > 0) {
				conn.commit();
				stmt1.close();
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



	public int delete(int trno,int docno,Date sqldate,String refno,String contracttype,int contractno,String client,String clientdet,String desc,String branchid,String clacno,int clientid,
			int costid,ArrayList<String> enqarray,ArrayList exparray,HttpSession session,String mode,String dtype,HttpServletRequest request,
			String legalamt,String seramt,String exptotal,String nettotal,String pdid,String txtnotes,String ptype,Double taxamt,ArrayList taxlist) throws SQLException {
		try{

			int protrno;
			String amount="0";
			String lfee="0";
			conn=conobj.getMyConnection();
			conn.setAutoCommit(false);

			Statement stmt = conn.createStatement ();
			/*			String insql="insert into my_trno(userno,trtype,brhid,edate,transid) values("+session.getAttribute("USERID").toString() +",'"+dtype+"',"+branchid +",NOW(),0)";
			int inres=stmt.executeUpdate(insql);

			if(inres<=0)
			{
				stmt.close();
				conn.close(); 
				return -1;
			}
			String upsql="select max(trno) trno from my_trno ";
			ResultSet resultSet = stmt.executeQuery(upsql);
			 */
			/*while (resultSet.next()) {
				trno=resultSet.getInt("trno");
			}*/		  
			for(int i=0;i< enqarray.size();i++){

				String[] invdata=enqarray.get(i).split("::");

				amount=(invdata[0].trim().equalsIgnoreCase("undefined")|| invdata[0].trim().equalsIgnoreCase("NaN"))? "0": invdata[0].trim();
				lfee=(invdata[1].trim().equalsIgnoreCase("undefined")|| invdata[1].trim().equalsIgnoreCase("NaN"))? "0": invdata[1].trim();


			}

			CallableStatement stmt1 = conn.prepareCall("{call Sr_projectInvoiceDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");


			stmt1.registerOutParameter(26, java.sql.Types.INTEGER);	

			stmt1.setDate(1,sqldate);
			stmt1.setString(2,refno);
			stmt1.setString(3,contracttype);		
			stmt1.setString(4,client);
			stmt1.setString(5,clientdet);
			stmt1.setString(6,desc);
			stmt1.setString(7,dtype.trim());
			stmt1.setString(8,mode);
			stmt1.setString(9,clacno);
			stmt1.setInt(10,clientid);
			stmt1.setString(11,session.getAttribute("USERID").toString());
			stmt1.setString(12,branchid);
			stmt1.setString(13,session.getAttribute("COMPANYID").toString());
			stmt1.setInt(14,costid);
			stmt1.setString(15,amount);
			stmt1.setString(16,lfee);
			stmt1.setInt(17,contractno);
			stmt1.setString(18,nettotal);
			stmt1.setString(19,pdid);
			stmt1.setString(20,exptotal);
			stmt1.setString(21,txtnotes);
			stmt1.setString(22,ptype);
			stmt1.setDouble(23,taxamt);
			stmt1.setInt(24,trno);
			stmt1.setInt(25,docno);


			stmt1.executeQuery();
			docno=stmt1.getInt("docNo");
			protrno=stmt1.getInt("trno");

			request.setAttribute("docno", docno);

			if(protrno>0){

				conn.commit();


			}

			if(protrno<=0)
			{
				conn.close();
				return 0;
			}	

			if (protrno > 0) {
				conn.commit();
				stmt1.close();
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




	public JSONArray contractSrearch(HttpSession session,String msdocno,String Cl_names,String Cl_mobno,String enqdate,String dtype,String ptype) throws SQLException {

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


		String sqltest="",sqltest1="";
		java.sql.Date sqlStartDate=null;
		if(!(enqdate.equalsIgnoreCase("undefined"))&&!(enqdate.equalsIgnoreCase(""))&&!(enqdate.equalsIgnoreCase("0")))
		{
			sqlStartDate = com.changeStringtoSqlDate(enqdate);
			sqltest1=" having  duedate<='"+sqlStartDate+"'";
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
			if(ptype.equalsIgnoreCase("1")){
				sqltest=sqltest+" and dtype='"+dtype+"'";
			}
			else{

			}

		}




		Connection conn =null;
		Statement stmt = null;
		try {
			conn = conobj.getMyConnection();
			stmt = conn.createStatement ();


			/*			String str1Sql="select if(cm.dtype='AMC',3,4) costType,cm.tr_no tr_no,cm.dtype dtype,cm.doc_no doc_no,cm.refno as refno, ac.refname as name,ac.com_mob as contmob ,  "
					+ "concat(coalesce(ac.address,''),' ',coalesce(ac.com_mob,'') ,' ',coalesce(ac.mail1,'')) as details,"
					+ "cm.date date,if(dueafser=99,ifnull(least(cm.legalDate,duedate),duedate),duedate) as duedate,round(cm.netamount,2) as cval,round(coalesce(sv.netamount,0.0),2) tobeinvamt, "
					+ "round(amount,2) dueamt,dueafser,serviceno,round(if(cm.islegal=1 ,legalchrg,0),2) lfee,cm.cldocNo clientid,ac.refName client,ac.acno as clacno, "
					+ "trim(concat(ifnull(ac.per_mob,''),' ',ifnull(ac.com_mob,''))) contactNo,cm.validFrom sdate,cm.validUpto edate,cm.brhid brch,a.rowno as pdid from "
					+ "(select duedate,amount,dueafser,serviceno,m.tr_no,pd.rowno from   cm_srvcontrpd pd inner join cm_srvcontrm m on(m.tr_no=pd.tr_no and pstatus=2) "
					+ "where  pd.dueafser=98 and invtrno=0 union all select duedate,amount,dueafser,serviceno,tr_no,pd.rowno from  cm_srvcontrpd pd "
					+ "where pd.dueafser=99 and invtrno=0 union all select duedate,amount,dueafser,serviceno,tr_no,pd.rowno from  cm_srvcontrpd pd "
					+ "where  pd.dueafser not in (98,99) and serviceno>0 and invtrno=0 ) as a left join cm_srvcontrm cm on(cm.tr_no=a.tr_no) left join cm_servplan sch "
					+ "on ( a.tr_no=sch.doc_no and workper=100) left join cm_srvdetm sv on (sch.tr_no=sv.schrefdocno  and sv.wrkper=100) "
					+ "left join my_acbook ac on(ac.doc_no=cm.cldocno and ac.dtype='CRM') "
					+ "where  cm.status=3 "+sqltest+" and jbaction not in(1) "+sqltest1+" order by duedate,cm.tr_no,cm.doc_no ";
			 */
			/*			String sqldata="select * from (select if(cm.dtype='AMC',3,4) costType,cm.tr_no tr_no,cm.dtype dtype,cm.dtype rdtype,cm.doc_no doc_no,cm.refno as refno,  cm.date date,"
					+ " if(dueafser=99,ifnull(least(cm.legalDate,duedate),duedate),duedate) as duedate,round(cm.netamount,2) as cval, "
					+ "round(coalesce(ser.netamount,0.0),2) tobeinvamt, round(amount,2) dueamt,dueafser,serviceno,round(if(cm.islegal=1 ,legalchrg,0),2) lfee, "
					+ "cm.cldocNo clientid,ac.refName client,ac.acno as clacno, ifnull(ac.per_mob,ac.com_mob) contactno, "
					+ "concat(coalesce(ac.address,''),' ',coalesce(ac.com_mob,'') ,' ',coalesce(ac.mail1,'')) as details,"
					+ "cm.validFrom sdate,cm.validUpto edate,cm.brhid brch,a.rowno as pdid,1 as ptype from (select duedate,amount,dueafser,serviceno,m.tr_no,pd.rowno "
					+ "from   cm_srvcontrpd pd inner join cm_srvcontrm m on(m.tr_no=pd.tr_no and pstatus=2) where  pd.dueafser=98 and invtrno=0 "
					+ "union all select duedate,amount,dueafser,serviceno,tr_no,pd.rowno from  cm_srvcontrpd pd where pd.dueafser=99 and invtrno=0 "
					+ "union all select duedate,amount,dueafser,serviceno,tr_no,pd.rowno from  cm_srvcontrpd pd where  pd.dueafser not in (98,99) "
					+ "and serviceno>0 and invtrno=0 union all select duedate,amount,dueafser,serviceno,tr_no,pd.rowno from  cm_srvcontrpd pd "
					+ "where  pd.dueafser=0 and invtrno=0 ) as a left join cm_srvcontrm cm on(cm.tr_no=a.tr_no) "
					+ " left join (select sum(sv.netamount) as netamount,sch.doc_no from cm_servplan sch  left join "
					+ " cm_srvdetm sv on (sch.tr_no=sv.schrefdocno  and sv.wrkper=100)  group by  sch.doc_no) ser  on(ser.doc_no=a.tr_no) "
					+ "left join my_acbook ac on(ac.doc_no=cm.cldocno and ac.dtype='CRM') where  cm.status=3   and jbaction not in(1) union all "
					+ "select 3 costType,cm.tr_no tr_no,(pd.dtype) as dtype,concat('Service','-',pd.dtype) as rdtype,cm.doc_no doc_no,cm.refno as refno,  cm.date date, "
					+ "pd.date as duedate,round(cm.netamount,2) as cval,0.00 tobeinvamt, round(servamt,2) dueamt,'0' as dueafser,"
					+ "0 serviceno,round(if(cm.islegal=1 ,legalchrg,0),2) lfee,cm.cldocNo clientid,ac.refName client,ac.acno as clacno, "
					+ " coalesce(ac.per_mob,ac.com_mob) contactno,concat(coalesce(ac.address,''),' ',coalesce(ac.com_mob,'') ,' ',coalesce(ac.mail1,'')) as details,cm.validFrom sdate,cm.validUpto edate,cm.brhid brch, "
					+ "pd.tr_no as pdid,2 as ptype from cm_servplan pd left join cm_srvcontrm cm on(pd.doc_no=cm.tr_no) "
					+ "left join my_acbook ac on(ac.doc_no=cm.cldocno and ac.dtype='CRM') where cm.iser=1 and pd.iserv=1 and pd.invtrno<=0 and pd.workper=100 and cm.status=3 and jbaction not in(1) ) as a "
					+ " where 1=1 "+sqltest+" "+sqltest1+" and ptype="+ptype+" order by duedate,tr_no,doc_no";
			 */
			String sqldata="select * from (select if(cm.dtype='AMC',3,4) costType,cm.tr_no tr_no,cm.dtype dtype,cm.dtype rdtype,cm.doc_no doc_no,cm.refno as refno,  cm.date date,"
					+ " if(dueafser=99,ifnull(least(cm.legalDate,duedate),duedate),duedate) as duedate,round(cm.netamount,2) as cval, "
					+ "round(coalesce(ser.netamount,0.0),2) tobeinvamt, round(amount,2) dueamt,dueafser,serviceno,round(if(cm.islegal=1 ,legalchrg,0),2) lfee, "
					+ "cm.cldocNo clientid,ac.refName client,ac.acno as clacno, trim(concat(ifnull(ac.per_mob,''),' ',ifnull(ac.com_mob,''))) contactNo, "
					+ "cm.validFrom sdate,cm.validUpto edate,cm.brhid brch,a.rowno as pdid,1 as ptype,cm.inctax from (select duedate,amount,dueafser,serviceno,m.tr_no,pd.rowno "
					+ "from   cm_srvcontrpd pd inner join cm_srvcontrm m on(m.tr_no=pd.tr_no and pstatus=2) where  pd.dueafser=98 and invtrno=0 "
					+ "union all select duedate,amount,dueafser,serviceno,tr_no,pd.rowno from  cm_srvcontrpd pd where pd.dueafser=99 and invtrno=0 "
					+ "union all select duedate,amount,dueafser,serviceno,tr_no,pd.rowno from  cm_srvcontrpd pd where  pd.dueafser not in (98,99) "
					+ "and serviceno>0 and invtrno=0 union all select duedate,amount,dueafser,serviceno,tr_no,pd.rowno from  cm_srvcontrpd pd "
					+ "where  pd.dueafser=0 and invtrno=0 ) as a left join cm_srvcontrm cm on(cm.tr_no=a.tr_no) "
					+ " left join (select sum(sv.netamount) as netamount,sch.doc_no from cm_servplan sch  left join "
					+ " cm_srvdetm sv on (sch.tr_no=sv.schrefdocno  and sv.wrkper=100)  group by  sch.doc_no) ser  on(ser.doc_no=a.tr_no) "
					+ "left join my_acbook ac on(ac.doc_no=cm.cldocno and ac.dtype='CRM') where  cm.status=3   and jbaction not in(1) union all "
					+ "select 3 costType,cm.tr_no tr_no,(pd.dtype) as dtype,concat('Service','-',pd.dtype) as rdtype,cm.doc_no doc_no,cm.refno as refno,  cm.date date, "
					+ "pd.date as duedate,round(cm.netamount,2) as cval,0.00 tobeinvamt, round(servamt,2) dueamt,'0' as dueafser,"
					+ "0 serviceno,round(if(cm.islegal=1 ,legalchrg,0),2) lfee,cm.cldocNo clientid,ac.refName client,ac.acno as clacno, "
					+ "trim(concat(ifnull(ac.per_mob,''),' ',ifnull(ac.com_mob,''))) contactNo,cm.validFrom sdate,cm.validUpto edate,cm.brhid brch, "
					+ "pd.tr_no as pdid,2 as ptype,cm.inctax from cm_servplan pd left join cm_srvcontrm cm on(pd.doc_no=cm.tr_no) "
					+ "left join my_acbook ac on(ac.doc_no=cm.cldocno and ac.dtype='CRM') where cm.iser=1 and pd.iserv=1 and pd.serinv=1 and pd.invtrno<=0 and pd.workper=100 and cm.status=3 and jbaction not in(1) ) as a "
					+ " where 1=1 "+sqltest+" "+sqltest1+"   and ptype="+ptype+" order by duedate,tr_no,doc_no";



			//			System.out.println("======contractSrearch===="+sqldata);

			ResultSet resultSet = stmt.executeQuery (sqldata);
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

			sql="select sm.ref_type dtype,m.doc_no docno,sm.date,sm.description descp,round(sm.atotal,2) amount,round(sm.legalchrg,2) lfee from "
					+ "my_servm sm left join  cm_srvcontrm m on(sm.costid=m.tr_no)   where sm. tr_no="+trno+"";

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

	public JSONArray expenseGridLoad(HttpSession session,String trno) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";
			String brhid=session.getAttribute("BRANCHID").toString();

			sql="select concat(d.description,' : ',ma.productname) desc1,round(qty,2) as qty,round(d.total,2) amount,round(d.nettotal,2) total,ma.psrno as psrno,ma.doc_no as prdid from cm_srvspares d "
					+ "left join cm_srvdetm m on(d.tr_no=m.tr_no) left join my_main ma on(d.psrno=ma.doc_no and d.prdid=ma.doc_no) "
					+ "where m.wrkper=100 and  m.costid="+trno+"";

			//			System.out.println("===sql===="+sql);

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

	public JSONArray expenseGridReLoad(HttpSession session,String trno) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";
			String brhid=session.getAttribute("BRANCHID").toString();

		//	sql="select description desc1,productid as prdid,productid as psrno,qty,amount,nettotal as total from my_servd where tr_no="+trno+" ";
			sql="select description desc1,productid as prdid,productid as psrno,round(qty) qty,round(amount,2) amount,round(nettotal,2) as total "
					+ "from my_servd where tr_no="+trno+" ";

			//			System.out.println("===sql===="+sql);

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
			sqltest=sqltest+" and m.doc_no like '%"+msdocno+"%'"; 
		}
		if(!(clnames.equalsIgnoreCase(""))){
			sqltest=sqltest+" and ac.refname like '%"+clnames+"%'";
		}
		if(!(contno.equalsIgnoreCase(""))){
			sqltest=sqltest+" and m.refdocno like '%"+contno+"%'";
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
			Statement stmtenq1 = conn.createStatement();

			String clssql= ("select m.doc_no,m.refdocno contno,ac.refname client,m.date,m.ref_type contype,m.tr_no,m.cldocno,m.costid,m.acno clacno,m.costtype conttypeval from my_servm m "
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

	public ClsProjectInvoiceBean getViewDetails(HttpSession session,int trno,String branchid) throws SQLException {
		ClsProjectInvoiceBean ProinvBean = new ClsProjectInvoiceBean();

		Connection conn = null;

		try {
			conn = conobj.getMyConnection();
			Statement stmtPRIV = conn.createStatement();

			String branch = branchid;


			System.out.println("select m.tr_no,m.doc_no,m.date,m.refno,c.refname client,concat(coalesce(c.address,''),' ',coalesce(c.com_mob,'') ,' ',coalesce(c.mail1,'')) as details,m.ref_type conttype,"
					+ "m.description desp,m.cldocno,m.costid,m.acno clacno,m.costtype,if(refdocno=0,c2.description,refdocno) refdocno,m.pdrowno,round(m.etotal,2) etotal,round(m.netamount,2) netamount,round(m.atotal) as atotal,"
					+ "round(m.legalchrg,2) as legalchrg,coalesce(notes,'') notes from my_servm m left join my_acbook c on m.cldocno=c.doc_no and c.dtype='CRM'  left join my_ccentre c2 on(c2.doc_no=m.costid) where m.status=3 and m.dtype='PJIV' and m.brhid="+branch+" and m.tr_no="+trno+"");

			
			ResultSet resultSet = stmtPRIV.executeQuery ("select m.tr_no,m.doc_no,m.date,m.refno,c.refname client,concat(coalesce(c.address,''),' ',coalesce(c.com_mob,'') ,' ',coalesce(c.mail1,'')) as details,m.ref_type conttype,"
					+ "m.description desp,m.cldocno,m.costid,m.acno clacno,m.costtype,if(refdocno=0,c2.description,refdocno) as refdocno,m.pdrowno,round(m.etotal,2) etotal,round(m.netamount,2) netamount,round(m.atotal) as atotal,round(m.legalchrg,2) as legalchrg,coalesce(notes,'') notes "
					+ "from my_servm m left join my_acbook c on m.cldocno=c.doc_no and c.dtype='CRM' left join my_ccentre c2 on(c2.doc_no=m.costid)  where m.status=3 and m.dtype='PJIV' and m.brhid="+branch+" and m.tr_no="+trno+"");



			while (resultSet.next()) {
				ProinvBean.setDocno(resultSet.getInt("doc_no"));
				ProinvBean.setDate(resultSet.getDate("date").toString());
				ProinvBean.setRefno(resultSet.getString("refno"));
				ProinvBean.setTxtclient(resultSet.getString("client"));
				ProinvBean.setTxtclientdet(resultSet.getString("details"));
				ProinvBean.setCmbcontracttype(resultSet.getString("conttype"));
				ProinvBean.setDesc(resultSet.getString("desp"));
				ProinvBean.setMaintrno(resultSet.getInt("tr_no"));
				ProinvBean.setClientid(resultSet.getInt("cldocno"));
				ProinvBean.setClacno(resultSet.getString("clacno"));
				ProinvBean.setCostid(resultSet.getInt("costid"));
				ProinvBean.setTxtrefdetails(resultSet.getString("refdocno"));
				
				ProinvBean.setPdid(resultSet.getString("m.pdrowno"));
				ProinvBean.setTxtnettotal(resultSet.getString("netamount"));
				ProinvBean.setTxtseramt(resultSet.getString("atotal"));
				ProinvBean.setTxtlegalamt(resultSet.getString("legalchrg"));
				ProinvBean.setTxtexptotal(resultSet.getString("etotal"));
				ProinvBean.setTxtnotes(resultSet.getString("notes"));
ProinvBean.setTxtcontract(resultSet.getInt("refdocno"));
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




	

	public ClsProjectInvoiceBean printMaster(HttpSession session,String msdocno,String brhid,String trno,String dtype) throws SQLException {


		Enumeration<String> Enumeration = session.getAttributeNames();
		int a=0;
		while(Enumeration.hasMoreElements()){
			if(Enumeration.nextElement().equalsIgnoreCase("BRANCHID")){
				a=1;
			}
		}

	//	String brid=session.getAttribute("BRANCHID").toString();
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
		ArrayList list=null;
		try {
			sitelist= new ArrayList();
			trlist= new ArrayList();
			serlist= new ArrayList();
			paylist= new ArrayList();
			list= new ArrayList();

			ClsNumberToWord obj=new ClsNumberToWord();

			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement ();


			/*System.out.println("select m.tr_no,m.doc_no,DATE_FORMAT(m.date,'%d-%m-%Y') date,m.refno,c.refname client,coalesce(c.address,'') as details,coalesce(c.com_mob,'') as mob ,coalesce(c.mail1,'') as email,m.ref_type conttype,"
					+ "m.description desp,m.cldocno,m.costid,m.acno clacno,m.trtype costtype,concat(m.trtype,'-',m.doc_no) as jobref,round(atotal,2) as atotal,round(legalchrg,2) as legalchrg,(round(atotal,2)+round(legalchrg,2)) as total, "
					+ "b.branchname brch,b.address as baddress,b.tel,b.fax,com.company comp,loc.loc_name,DATE_FORMAT(CURDATE(),'%d/%m/%Y') as finaldate  from my_serpvm m "
					+ "left join my_acbook c on (m.cldocno=c.doc_no and c.dtype='CRM') left join my_brch b on(b.doc_no=m.brhid) left join my_locm loc on(b.doc_no=loc.brhid) left join my_comp com on(com.doc_no=b.cmpid)  "
					+ "where m.status=3  and m.brhid="+brhid+" and m.tr_no="+trno+"");*/

			/*ResultSet resultSet = stmt.executeQuery ("select m.tr_no,m.doc_no,DATE_FORMAT(m.date,'%d-%m-%Y') date,m.refno,c.refname client,coalesce(c.address,'') as details,coalesce(c.com_mob,'') as mob ,coalesce(c.mail1,'') as email,m.ref_type conttype,"
					+ "m.description desp,m.cldocno,m.costid,m.acno clacno,m.trtype costtype,concat(m.trtype,'-',m.doc_no) as jobref,round(atotal,2) as atotal,round(legalchrg,2) as legalchrg,(round(atotal,2)+round(legalchrg,2)) as total, "
					+ "b.branchname brch,b.address as baddress,b.tel,b.fax,com.company comp,loc.loc_name,DATE_FORMAT(CURDATE(),'%d/%m/%Y') as finaldate  from my_servm m "
					+ "left join my_acbook c on (m.cldocno=c.doc_no and c.dtype='CRM') left join my_brch b on(b.doc_no=m.brhid) left join my_locm loc on(b.doc_no=loc.brhid) left join my_comp com on(com.doc_no=b.cmpid)  "
					+ "where m.status=3  and m.brhid="+brhid+" and m.tr_no="+trno+"");*/

			/*String st1="select m.tr_no,m.doc_no,DATE_FORMAT(m.date,'%d-%m-%Y') date,m.refno,c.refname client,coalesce(c.address,'') as details,coalesce(c.com_mob,'') as mob,coalesce(c.per_mob,'') as tel ,coalesce(c.mail1,'') as email,m.ref_type conttype,"
					+ "m.description desp,m.cldocno,m.costid,m.acno clacno,m.trtype costtype,concat(m.ref_type,'-',m.refdocno) as jobref,round(atotal,2) as atotal,round(legalchrg,2) as legalchrg,(round(atotal,2)+round(legalchrg,2)) as total, "
					+ "b.branchname brch,b.address as baddress,b.tel,b.fax,com.company comp,loc.loc_name,DATE_FORMAT(CURDATE(),'%d/%m/%Y') as finaldate  from my_servm m "
					+ "left join my_acbook c on (m.cldocno=c.doc_no and c.dtype='CRM') left join my_brch b on(b.doc_no=m.brhid) left join my_locm loc on(b.doc_no=loc.brhid) left join my_comp com on(com.doc_no=b.cmpid)  "
					+ "where m.status=3  and m.brhid="+brhid+" and m.tr_no="+trno+"";*/
			/*String st1="select m.tr_no,m.doc_no,DATE_FORMAT(m.date,'%d-%m-%Y') date,m.refno,c.refname client, "
					+ "coalesce(c.address,'') as details,coalesce(c.com_mob,'') as mob,coalesce(c.per_mob,'') as tel ,"
					+ "coalesce(c.mail1,'') as email,m.ref_type conttype,m.description desp,m.cldocno,m.costid,"
					+ "m.acno clacno,m.trtype costtype,concat(m.ref_type,'-',m.refdocno) as jobref, "
					+ " b.branchname brch,b.address as baddress,b.tel,b.fax,com.company comp,loc.loc_name,"
					+ "DATE_FORMAT(CURDATE(),'%d/%m/%Y') as finaldate, coalesce(cm.cperson,con.cperson) cperson"
					+ "from my_servm m left join my_acbook c on (m.cldocno=c.doc_no and c.dtype='CRM') "
					+ "left join my_brch b on(b.doc_no=m.brhid) "
					+ "left join my_locm loc on(b.doc_no=loc.brhid) left join my_comp com on(com.doc_no=b.cmpid)"
					+ "   left join cm_srvcontrm cm on m.refdocno=cm.doc_no  and cm.dtype=m.ref_type"
					+ "    left join my_crmcontact con on cm.cpersonid=con.row_no where m.status=3"
					+ "    and m.brhid=1 and m.tr_no=112";*/

			String st1="select coalesce(m.notes,'') notes,concat(DATE_FORMAT(m.date,'%b/%y'),'-',m.doc_no) invono,m.tr_no,m.doc_no,DATE_FORMAT(m.date,'%d-%b-%Y') date,m.refno,c.refname client, c.tinno,"
					+ "coalesce(c.address,'') as details,coalesce(c.com_mob,'') as mob,coalesce(c.per_mob,'') as cltel ,"
					+ "coalesce(c.mail1,'') as email,m.ref_type conttype,m.description desp,m.cldocno,m.costid,"
					+ "m.acno clacno,m.trtype costtype,concat(m.ref_type,'-',m.refdocno) as jobref,"
					+ "round(atotal,2) as atotal,round(m.legalchrg,2) as legalchrg,(round(atotal,2)+round(m.legalchrg,2)) as total, "
					+ " b.branchname brch,b.address as baddress,b.tel,b.fax,com.company comp,loc.loc_name,"
					+ "DATE_FORMAT(CURDATE(),'%d/%m/%Y') as finaldate, coalesce(cm.cperson,con.cperson) cperson "
					+ "from my_servm m left join my_acbook c on (m.cldocno=c.doc_no and c.dtype='CRM') "
					+ "left join my_brch b on(b.doc_no=m.brhid) "
					+ "left join my_locm loc on(b.doc_no=loc.brhid) left join my_comp com on(com.doc_no=b.cmpid)"
					+ "   left join cm_srvcontrm cm on m.refdocno=cm.doc_no  and cm.dtype=m.ref_type"
					+ "    left join my_crmcontact con on cm.cpersonid=con.row_no where m.status=3"
					+ "    and m.brhid="+brhid+" and m.tr_no="+trno+"";
			System.out.println("+++++attn select?+++++"+st1);
			ResultSet resultSet = stmt.executeQuery (st1);

			while (resultSet.next()) {
				
				System.out.println("====notes = "+resultSet.getString("notes"));
			    bean.setTxtnotes(resultSet.getString("notes"));
				bean.setTinno(resultSet.getString("tinno"));
				bean.setCperson(resultSet.getString("cperson"));
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
				bean.setTelph(resultSet.getString("cltel"));
				bean.setLblbranch(resultSet.getString("brch"));
				bean.setLblcompaddress(resultSet.getString("baddress"));
				bean.setLblcompfax(resultSet.getString("fax"));
				bean.setLblcomptel(resultSet.getString("tel"));
				bean.setLbllocation(resultSet.getString("loc_name"));
				bean.setLblcompname(resultSet.getString("comp"));
				bean.setLblfinaldate(resultSet.getString("finaldate"));
				bean.setConttrno(resultSet.getString("costid"));
				bean.setTxtdtype(resultSet.getString("conttype"));




				contrno=resultSet.getInt("costid");
				cntrtype=resultSet.getString("costtype");
				amount=resultSet.getString("atotal");
				leglfee=resultSet.getString("legalchrg");
				total=resultSet.getString("total");

			}



			list.add("1"+"::"+"Contract Payment "+"::"+amount);
			list.add("2"+"::"+"Civil Defense Contract Charges "+"::"+leglfee);
			list.add(""+"::"+"Total "+"::"+total);


			bean.setList(list);

		
			String invonoqry="select concat(DATE_FORMAT(m.date,'%b'),DATE_FORMAT(y.ACCYR_F,'/%y'),'-',DATE_FORMAT(y.ACCYR_T,'%y/'),m.doc_no) invono "
					+ "from my_year y,my_servm m where y.cl_stat=0 and m.tr_no="+trno+" and m.status=3 and m.dtype='PJIV' and m.brhid="+brhid+" ;";
			System.out.println("invonoqry="+invonoqry);
			ResultSet invonors = stmt.executeQuery(invonoqry);
			while(invonors.next()){
				
				bean.setInvono(invonors.getString("invono"));
							
			}
			
			String brch_detqry="select BRANCHNAME,Address,pbno,if(coalesce(tel,'')!='' and coalesce(tel2,'')!='',concat(tel,'/',tel2),if(coalesce(tel,'')!='',tel,coalesce(tel2,''))) tel,EMAIL from my_brch where doc_no="+brhid+";";
			ResultSet br_det=stmt.executeQuery(brch_detqry);
			while(br_det.next()){
				bean.setBrch_name(br_det.getString("BRANCHNAME"));
				bean.setBrch_address(br_det.getString("Address"));
				bean.setBrch_pbno(br_det.getString("pbno"));
				bean.setBrch_tel(br_det.getString("tel"));
				bean.setBrch_email(br_det.getString("EMAIL"));
				
			}
		
			/*String sitqry="select distinct coalesce(s.site,'') site from my_servm m left join cm_servplan n on (m.tr_no=n.invtrno) left join"
					+ " cm_srvcsited s on (n.siteid=s.rowno) where m.status=3 and m.tr_no="+trno+";";*/

			String sitqry="select  if(sitecount>1,'',coalesce(site,'')) site, serinv from (select distinct coalesce(s.site,'') site,n.serinv,count( distinct n.siteid) sitecount"
				     + " from my_servm m "
				     + "left join cm_servplan n on (m.tr_no=n.invtrno) left join cm_srvcsited s on (n.siteid=s.rowno)  "
				     + "where n.serinv=1 and m.status=3 and m.tr_no="+trno+"  union all (select distinct coalesce(sd.site,'') site, 0 serinv,0 sitecount from my_servm m "
				     + "left join cm_srvcsited sd on m.costid=sd.tr_no  where m.status=3 and m.tr_no="+trno+" limit 1 ))a "
				     + "where serinv=(if(serinv=0,(select 0 from  cm_srvcontrpd where invtrno="+trno+" limit 1  ),"
				     + "(select serinv from  cm_servplan where invtrno="+trno+" limit 1))) ;";
			
			ResultSet siters = stmt.executeQuery(sitqry);
			
		//	System.out.println("======sitqry========="+sitqry);
			
			String sites="";
			
			while(siters.next()){
				sites=sites+siters.getString("site")+"\n";
					
			}
			
			
			
			bean.setSite(sites);
			
			
			
			
			
			String sql1="select  round(amount,2) as amount,IF(description IS NULL or description = '', '     ', description) description from cm_srvcontrpd "
					+ " where tr_no="+contrno+"";
		
			//System.out.println("=====payterms===="+sql1);

			ResultSet rs = stmt.executeQuery(sql1);
			int payno=1;
			while(rs.next()){

				String temp="";
				temp=payno+"::"+rs.getString("amount")+"::"+rs.getString("description");
				paylist.add(temp);

				payno=payno+1;
			}

			//			System.out.println("===paylist===="+paylist.size());

			paylist.add("DCD"+"::"+leglfee+"::"+"    ");

			bean.setPaylist(paylist);


			String fire7contractsql="select total,invoicedamt,total-invoicedamt balance,invc,totc from (select sum(amount) invoicedamt,count(*) invc from cm_srvcontrpd "
					+" where tr_no="+contrno+" and invtrno!=0  and sr_no <=(select sr_no from cm_srvcontrpd  where tr_no="+contrno+" and invtrno="+trno+" )) a, "
					+ " (select coalesce(sum(amount),0) total,count(*) totc from cm_srvcontrpd where tr_no="+contrno+") b;";

	System.out.println("=====invoicedetails numbering method fire7=new qry==="+fire7contractsql);

	ResultSet f7con=stmt.executeQuery(fire7contractsql);
	while(f7con.next()){
		bean.setFire7invamt(f7con.getString("invoicedamt"));
		bean.setFire7total(f7con.getString("total"));
		bean.setFire7balance(f7con.getString("balance"));
		bean.setFire7srno(f7con.getString("invc"));
		bean.setFire7mxrno(f7con.getString("totc"));
	}

			String csql="select round(p.amount,2) invamt,p.count as srno, mxrno ,round(balance,2) balance,round(total,2) total from "
					+ "(select sum(invamt) amount,count(*) as count,tr_no from cm_srvcontrpd where tr_no="+contrno+" and invtrno>0) p "
					+ "left join (select sum(amount) as total,tr_no,max(sr_no) as mxrno from cm_srvcontrpd where tr_no="+contrno+") as a on(a.tr_no=p.tr_no) "
					+ "left join (select sum(amount) as balance,tr_no from cm_srvcontrpd where tr_no="+contrno+" and invtrno<=0) as b on(b.tr_no=p.tr_no) "
					+ "where p.tr_no="+contrno+"";

		//	System.out.println("=====invoicedetails===="+csql);


			ResultSet crs = stmt.executeQuery(csql);
			int serno=1;
			if(crs.next()){
				
				bean.setMxrnomin(crs.getString("srno"));
				bean.setMxrnomax(crs.getString("mxrno"));
				bean.setTotal1(crs.getString("total"));
				bean.setInvoived(crs.getString("invamt"));
				bean.setBalance(crs.getString("balance"));
				String temp="";

				serlist.add("Invoice "+crs.getString("srno")+" of "+crs.getString("mxrno")+"");
				serlist.add("Total Job Value "+"::"+crs.getString("total"));
				serlist.add("Total invoiced (incl.this invoice) "+"::"+crs.getString("invamt"));
				serlist.add("Balance to be invoiced "+"::"+crs.getString("balance"));



				serno=serno+1;
			}

			bean.setSerlist(serlist);



			String sql="select  groupname area,g.doc_no areaid,site,upper(concat(site,',',groupname)) as sited from  cm_srvcsited  d left join my_groupvals g on(d.areaid=g.doc_no and grptype='area') "
					+ " where tr_no="+contrno+"";

		//	System.out.println("===sitelist==="+sql);

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
				//fire 7 site in print qry
			String fire7site="select GROUP_CONCAT(sd.site) site from MY_SERVM sm left join cm_srvcsited sd on sm.costid=sd.tr_no where sm.tr_no="+trno+" ";
			Statement f7site=conn.createStatement();
			ResultSet f7rs=f7site.executeQuery(fire7site);
			while(f7rs.next()){
				bean.setFire7site(f7rs.getString("site"));
			}

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




	public int getTrno(HttpSession session,String dtype,String branchid,Connection conn) throws SQLException {

		int trno=-1;
		//Connection Connection=null;
		try{

			//ClsConnection ClsConnection=new ClsConnection();

			//Connection=ClsConnection.getMyConnection();

			conn.setAutoCommit(false);

			Statement stmt = conn.createStatement ();
			String insql="insert into my_trno(userno,trtype,brhid,edate,transid) values("+session.getAttribute("USERID").toString() +",'"+dtype+"',"+branchid +",NOW(),0)";
			int inres=stmt.executeUpdate(insql);

			if(inres<=0)
			{
				stmt.close();
				conn.close(); 
				return -1;
			}else{
				conn.commit();
			}

			String upsql="select max(trno) trno from my_trno ";
			ResultSet resultSet = stmt.executeQuery(upsql);

			while (resultSet.next()) {
				trno=resultSet.getInt("trno");
			}  

		}
		catch(Exception e){
			conn.close();
			e.printStackTrace();

		}

		//System.out.println(RESULTDATA);
		return trno;
	}

	public ArrayList getTax(HttpSession session,Double netamount,java.sql.Date date,String inter) throws SQLException {

		int trno=-1;
		int config=0;
		Connection Connection=null;
		ArrayList taxlist=null;
		String tmp="";
		try{

			ClsConnection ClsConnection=new ClsConnection();
			Connection=ClsConnection.getMyConnection();
			Connection.setAutoCommit(false);


			taxlist=new ArrayList();
			
			Statement stmt = Connection.createStatement ();

			String consql="select method from gl_config where field_nme='tax'";
			ResultSet rsconfg = stmt.executeQuery(consql);

			while (rsconfg.next()) {
				config=rsconfg.getInt("method");
			}


			if(config>0){
				String upsql="";
				if(inter.equalsIgnoreCase("1")) //inter-state_IGST
				{
					upsql=" select t.tax_code,t.acno,t.value,cstper per,("+netamount+"*t.cstper)/100 as taxamt,t.doc_no docno "
							+" from  gl_taxsubmaster t where   fromdate<='"+date+"' and todate>='"+date+"' and status=3 and type=2 and cstper>0" ;
				}
				else{
					upsql=" select t.tax_code,t.acno,t.value,per,("+netamount+"*t.per)/100 as taxamt,t.doc_no docno "
						+" from  gl_taxsubmaster t where   fromdate<='"+date+"' and todate>='"+date+"' and status=3 and type=2 and per>0" ;
				}
				System.out.println("===exclusivetax====="+upsql);

				ResultSet resultSet = stmt.executeQuery(upsql);

				while (resultSet.next()) {

					
					tmp=resultSet.getString("t.tax_code")+"::"+resultSet.getString("acno")+"::"+resultSet.getString("per")+"::"+resultSet.getString("taxamt")+"::"+resultSet.getString("docno");

					taxlist.add(tmp);
				}

			}

		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			Connection.close();
		}
		//System.out.println(RESULTDATA);
		return taxlist;
	}	

	
	public ArrayList getinclusiveTax(HttpSession session,Double netamount,java.sql.Date date,String inter) throws SQLException {

		int trno=-1;
		int config=0;
		Connection Connection=null;
		ArrayList taxlist=null;
		String tmp="";
		try{

			ClsConnection ClsConnection=new ClsConnection();
			Connection=ClsConnection.getMyConnection();
			Connection.setAutoCommit(false);


			taxlist=new ArrayList();
			Statement stmt = Connection.createStatement ();

			String consql="select method from gl_config where field_nme='tax'";
			ResultSet rsconfg = stmt.executeQuery(consql);

			while (rsconfg.next()) {
				config=rsconfg.getInt("method");
			}


			if(config>0){
		double totalper=0.0;
		String upsql="";
		if(inter.equalsIgnoreCase("1")) //inter-state_IGST
		{
			String netamtsql=" select cstper "
					+" from  gl_taxsubmaster t where   fromdate<='"+date+"' and todate>='"+date+"' and status=3 and type=2 and cstper>0 " ;
			ResultSet resultSetnet = stmt.executeQuery(netamtsql);
			while (resultSetnet.next()) {
				totalper=totalper+resultSetnet.getDouble("cstper");
			}
			
			upsql=" select t.tax_code,t.acno,t.value,cstper per,round(( ("+netamount+" / (("+totalper+"/100)+1)))* (t.cstper/100),2) as taxamt,t.doc_no docno "
					+" from  gl_taxsubmaster t where   fromdate<='"+date+"' and todate>='"+date+"' and status=3 and type=2 and cstper>0 " ;
		}
		else{
				String netamtsql=" select per "
						+" from  gl_taxsubmaster t where   fromdate<='"+date+"' and todate>='"+date+"' and status=3 and type=2 and per>0 " ;
				ResultSet resultSetnet = stmt.executeQuery(netamtsql);
				while (resultSetnet.next()) {
					totalper=totalper+resultSetnet.getDouble("per");
				}
				
				upsql=" select t.tax_code,t.acno,t.value,per,round(( ("+netamount+" / (("+totalper+"/100)+1)))* (t.per/100),2) as taxamt,t.doc_no docno "
						+" from  gl_taxsubmaster t where   fromdate<='"+date+"' and todate>='"+date+"' and status=3 and type=2 and per>0 " ;
		}
				
				
				System.out.println("===inclusivetax====="+upsql);

				ResultSet resultSet = stmt.executeQuery(upsql);

				while (resultSet.next()) {

					
					tmp=resultSet.getString("t.tax_code")+"::"+resultSet.getString("acno")+"::"+resultSet.getString("per")+"::"+resultSet.getString("taxamt")+"::"+resultSet.getString("docno");

					taxlist.add(tmp);
				}

			}

		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			Connection.close();
		}
		//System.out.println(RESULTDATA);
		return taxlist;
	}	
		

	public  JSONArray costCodeSearch() throws SQLException {
		
	    JSONArray RESULTDATA=new JSONArray();
	    ClsCommon ClsCommon=new ClsCommon();
	    Connection Connection=null;
	    
		try {
			ClsConnection ClsConnection=new ClsConnection();
			Connection=ClsConnection.getMyConnection();
				Statement stmtVehclr = Connection.createStatement ();
			
	        		String sql="select c1.costcode code,c1.doc_no doc_no,c1.description name,coalesce(c2.description,c1.description) namedet,c1.grpno,c2.grpno from my_ccentre c1 left join my_ccentre c2 on(c1.doc_no=c2.grpno) ";
	        		ResultSet resultSet = stmtVehclr.executeQuery (sql);
	        		RESULTDATA=ClsCommon.convertToJSON(resultSet);
					stmtVehclr.close();
				
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			Connection.close();
		}
	    return RESULTDATA;
	}

	public JSONArray searchClient(HttpSession session,String clname,String mob,int id) throws SQLException {


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


		String brid=session.getAttribute("BRANCHID").toString();


		String sqltest="";

		if(!(clname.equalsIgnoreCase("undefined"))&&!(clname.equalsIgnoreCase(""))&&!(clname.equalsIgnoreCase("0"))){
			sqltest=sqltest+" and refname like '%"+clname+"%'";
		}
		if(!(mob.equalsIgnoreCase("undefined"))&&!(mob.equalsIgnoreCase(""))&&!(mob.equalsIgnoreCase("0"))){
			sqltest=sqltest+" and per_mob like '%"+mob+"%'";
		}


		Connection conn = null;
		try {
			conn = conobj.getMyConnection();
			Statement stmtVeh1 = conn.createStatement ();

			if(id>0){
			String clsql= ("select per_tel pertel,cldocno,refname,trim(address) address,per_mob,trim(mail1) mail1,acno from my_acbook where  dtype='CRM'  " +sqltest);

			ResultSet resultSet = stmtVeh1.executeQuery(clsql);

			RESULTDATA=com.convertToJSON(resultSet);
			stmtVeh1.close();
			conn.close();
			}
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
		return RESULTDATA;
	}



}
