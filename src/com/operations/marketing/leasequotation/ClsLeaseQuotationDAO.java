package com.operations.marketing.leasequotation;

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

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsLeaseQuotationDAO {
	
    ClsCommon commonDAO=new ClsCommon();
    ClsConnection connDAO=new ClsConnection();
    
    ClsLeaseQuotationBean leaseQuotationBean= new ClsLeaseQuotationBean();
    
    public int insert(Date leaseQuotationDate, String formdetailcode, String cmbtype, int txtquotationno, int txtcustomerdocno, int chckleasetoown, int leasereqdoc, ArrayList<String> leaseapplicationarray, 
    		ArrayList<String> termslist, HttpSession session, HttpServletRequest request, String mode) throws SQLException {
		
		Connection conn = null;
		
		try{
			conn=connDAO.getMyConnection();
			conn.setAutoCommit(false);

			String branch=session.getAttribute("BRANCHID").toString().trim();
			String userid=session.getAttribute("USERID").toString().trim();
			String company=session.getAttribute("COMPANYID").toString().trim();
			
			CallableStatement stmtLQT = conn.prepareCall("{CALL leaseapplicationmDML(?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmtLQT.registerOutParameter(11, java.sql.Types.INTEGER);
			stmtLQT.setDate(1,leaseQuotationDate);
			stmtLQT.setInt(2,leasereqdoc);
			stmtLQT.setString(3,cmbtype);
			stmtLQT.setInt(4,txtquotationno);
			stmtLQT.setInt(5,txtcustomerdocno);
			stmtLQT.setInt(6,chckleasetoown);
			stmtLQT.setString(7,formdetailcode);
			stmtLQT.setString(8,branch);
			stmtLQT.setString(9,company);
			stmtLQT.setString(10,userid);
			stmtLQT.setString(12,mode);
			int datas=stmtLQT.executeUpdate();
			if(datas<=0){
				stmtLQT.close();
				conn.close();
				return 0;
			}
			int docno=stmtLQT.getInt("docNo");
			leaseQuotationBean.setDocno(docno);
			if (docno > 0) {
				
				/*Insertion to gl_leaseappd*/
				int insertData=insertion(conn, docno, formdetailcode, leasereqdoc, leaseapplicationarray, termslist, session, mode);
				if(insertData<=0){
					stmtLQT.close();
					conn.close();
					return 0;
				}
				/*Insertion to gl_leaseappd Ends*/
				
					conn.commit();
					stmtLQT.close();
					conn.close();
					return docno;
				 
			}
		stmtLQT.close();
		conn.close();
	 } catch(Exception e){
		 	e.printStackTrace();
		 	conn.close();
		 	return 0;
	 } finally{
			conn.close();
		}
		return 0;
	}
			
	
    public boolean edit(int docno, String formdetailcode, Date leaseQuotationDate, String cmbtype, int txtquotationno, int txtcustomerdocno, int chckleasetoown, int leasereqdoc, ArrayList<String> leaseapplicationarray, 
    		ArrayList<String> termslist,HttpSession session, HttpServletRequest request, String mode) throws SQLException {
    	
		Connection conn = null;
		
		try{
				conn=connDAO.getMyConnection();
				conn.setAutoCommit(false);
				Statement stmtLQT = conn.createStatement();
				
			    String branch=session.getAttribute("BRANCHID").toString().trim();
				String userid=session.getAttribute("USERID").toString().trim();
				String company=session.getAttribute("COMPANYID").toString().trim();
				
				/*Updating gl_leaseappm*/
                String sql=("update gl_leaseappm set date='"+leaseQuotationDate+"', reqdoc='"+leasereqdoc+"', type='"+cmbtype+"', refdocno='"+txtquotationno+"', cldocno='"+txtcustomerdocno+"', ownlease='"+chckleasetoown+"', dtype='"+formdetailcode+"', brhid='"+branch+"', cmpid='"+company+"' where brhId="+branch+" and doc_no="+docno+"");
                int data = stmtLQT.executeUpdate(sql);
				if(data<=0){
					stmtLQT.close();
					conn.close();
					return false;
				}
				/*Updating gl_leaseappm Ends*/
				
				/*Updating gl_leasecalcm*/
                String sql1=("update gl_leasecalcm set leaseappstatus=0 where status=3 and leaseappstatus="+docno+"");
                int data1 = stmtLQT.executeUpdate(sql1);
				if(data1<=0){
					stmtLQT.close();
					conn.close();
					return false;
				}
				/*Updating gl_leasecalcm Ends*/
				
				/*Updating gl_leasecalcm*/
                String sql2=("update gl_leasecalcm set leaseappstatus="+docno+" where status=3 and reqdoc="+leasereqdoc+"");
                int data2 = stmtLQT.executeUpdate(sql2);
				if(data2<=0){
					stmtLQT.close();
					conn.close();
					return false;
				}
				/*Updating gl_leasecalcm Ends*/
				
				/*Inserting into datalog*/
				String sqls=("insert into datalog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docno+"','"+branch+"','"+formdetailcode+"',now(),'"+userid+"','E')");
				int datas = stmtLQT.executeUpdate(sqls);
				/*Inserting into datalog Ends*/
			    
			    String sql3=("DELETE FROM gl_leaseappd WHERE rdocno="+docno+"");
			    int data3 = stmtLQT.executeUpdate(sql3);
			    
			    String sql4=("DELETE FROM my_trterms WHERE rdocno="+docno+"");
			    int data4 = stmtLQT.executeUpdate(sql4);
			    
			    leaseQuotationBean.setDocno(docno);
				if (docno > 0) {
				
					/*Insertion to gl_leaseappd*/
					int insertData=insertion(conn, docno, formdetailcode, leasereqdoc, leaseapplicationarray, termslist, session, mode);
					if(insertData<=0){
						stmtLQT.close();
						conn.close();
						return false;
					}
					/*Insertion to gl_leaseappd Ends*/
					
						conn.commit();
						stmtLQT.close();
						conn.close();
						return true;
				}
			stmtLQT.close();
			conn.close();
		 }catch(Exception e){	
			 	e.printStackTrace();
			    conn.close();
			 	return false;
		 }finally{
				conn.close();
			}
			return false;
	}

	public boolean delete(int docno,  String formdetailcode, HttpSession session) throws SQLException {
		
		Connection conn = null;
		
		try{
			    conn=connDAO.getMyConnection();
				conn.setAutoCommit(false);
				Statement stmtLQT = conn.createStatement();
				
				String branch=session.getAttribute("BRANCHID").toString().trim();
				String userid=session.getAttribute("USERID").toString().trim();
				 
				/*Status change in gl_leaseappm*/
				 String sql=("update gl_leaseappm set STATUS=7 where brhid="+branch+" and doc_no="+docno+"");
				 int data = stmtLQT.executeUpdate(sql);
				 if(data<=0){
				    stmtLQT.close();
					conn.close();
					return false;
				 }
				/*Status change in gl_leaseappm Ends*/
				 
				 /*Updating gl_leasecalcm*/
	                String sql1=("update gl_leasecalcm set leaseappstatus=0 where status=3 and leaseappstatus="+docno+"");
	                int data1 = stmtLQT.executeUpdate(sql1);
					if(data1<=0){
						stmtLQT.close();
						conn.close();
						return false;
					}
					/*Updating gl_leasecalcm Ends*/
					
				
				leaseQuotationBean.setDocno(docno);
				if (docno > 0) {
					
					/*Inserting into datalog*/
					 String sqls=("insert into datalog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docno+"','"+branch+"','"+formdetailcode+"',now(),'"+userid+"','D')");
					 int datas = stmtLQT.executeUpdate(sqls);
					/*Inserting into datalog Ends*/
					 
					conn.commit();
					stmtLQT.close();
					conn.close();
					return true;
				}	
				stmtLQT.close();
				conn.close();
		 } catch(Exception e){	
			 	e.printStackTrace();
			 	conn.close();
			 	return false;
		 } finally{
				conn.close();
			}
				return false;
	    }
	
	public ClsLeaseQuotationBean getViewDetails(HttpSession session,int docNo) throws SQLException {
		
		ClsLeaseQuotationBean leaseQuotationBean = new ClsLeaseQuotationBean();
		
		Connection conn = null;
		
		try {
		
			conn = connDAO.getMyConnection();
			Statement stmtLQT = conn.createStatement();
	
			String branch = session.getAttribute("BRANCHID").toString();
			
			ResultSet resultSet = stmtLQT.executeQuery ("select m.date,m.doc_no,m.reqdoc,m.type,m.refdocno,lc.vocno,m.cldocno,m.ownlease,if(req.reqtype=1,ac.com_mob,req.mob) mobile,if(req.reqtype=1,ac.refname,req.name) refname,"
					+ "if(req.reqtype=1,ac.address,req.com_add1) address,if(req.reqtype=1,ac.mail1,req.email) email,s.sal_name from gl_leaseappm m left join gl_leasecalcm lc on (m.refdocno=lc.doc_no and m.brhid=lc.brhid) "
					+ "left join my_acbook ac on (m.cldocno=ac.cldocno and ac.dtype='CRM') left join my_salm s on ac.sal_id=s.doc_no left join gl_lprm req on (m.reqdoc=req.doc_no) where m.status<>7 and m.brhid="+branch+" and m.doc_no="+docNo+"");
	
			while (resultSet.next()) {
					leaseQuotationBean.setDocno(docNo);
					leaseQuotationBean.setDate(resultSet.getDate("date").toString());
					leaseQuotationBean.setHidcmbtype(resultSet.getString("type"));
					leaseQuotationBean.setTxtquotationvocno(resultSet.getString("vocno"));
					leaseQuotationBean.setTxtquotationno(resultSet.getInt("refdocno"));
					leaseQuotationBean.setLeasereqdoc(resultSet.getInt("reqdoc"));
					leaseQuotationBean.setTxtcustomerdocno(resultSet.getInt("cldocno"));
					leaseQuotationBean.setTxtcustomername(resultSet.getString("refname"));
					leaseQuotationBean.setTxtcustomeraddress(resultSet.getString("address"));
					leaseQuotationBean.setTxtcustomeremail(resultSet.getString("email"));
					leaseQuotationBean.setTxtcustomermobile(resultSet.getString("mobile"));
					leaseQuotationBean.setTxtsalesman(resultSet.getString("sal_name"));
					leaseQuotationBean.setChckleasetoown(resultSet.getInt("ownlease"));
			}
			
			stmtLQT.close();
			conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			conn.close();
		}
		return leaseQuotationBean;
		}
	  
	public ClsLeaseQuotationBean getPrint(HttpServletRequest request,int docNo,int branch) throws SQLException {
		 ClsLeaseQuotationBean bean = new ClsLeaseQuotationBean();
		 Connection conn = null;
		 
		try {
			conn = connDAO.getMyConnection();
			Statement stmtLQT = conn.createStatement();
			
			String headersql="select if(m.dtype='LQT','Lease Application','  ') vouchername,c.company,c.address,c.tel,c.fax,lc.loc_name location,b.branchname,b.pbno,b.stcno,"
					+ "b.cstno from gl_leaseappm m inner join my_brch b on m.brhid=b.doc_no inner join my_comp c on b.cmpid=c.doc_no inner join my_locm l on l.brhid=b.doc_no "
					+ "inner join (select min(lo.loc) loc,lo.loc_name,lo.brhid from my_locm lo group by brhid) as lc on(lc.loc=l.loc and lc.brhid=b.doc_no) where m.dtype='LQT' "
					+ "and m.brhid="+branch+" and m.doc_no="+docNo+"";
			
			ResultSet resultSetHead = stmtLQT.executeQuery(headersql);
			
			while(resultSetHead.next()){
				
				bean.setLblcompname(resultSetHead.getString("company"));
				bean.setLblcompaddress(resultSetHead.getString("address"));
				bean.setLblprintname(resultSetHead.getString("vouchername"));
				bean.setLblcomptel(resultSetHead.getString("tel"));
				bean.setLblcompfax(resultSetHead.getString("fax"));
				bean.setLblbranch(resultSetHead.getString("branchname"));
				bean.setLbllocation(resultSetHead.getString("location"));
				bean.setLblcstno(resultSetHead.getString("cstno"));
				bean.setLblpan(resultSetHead.getString("pbno"));
				bean.setLblservicetax(resultSetHead.getString("stcno"));
				bean.setLblpobox(resultSetHead.getString("pbno"));
			}
			
			String sqls="select if(req.reqtype=1,ac.refname,req.name) refname,if(req.reqtype=1,ac.address,req.com_add1) address,if(req.reqtype=1,ac.com_mob,req.mob) mobile,if(req.reqtype=1,ac.mail1,req.email) email,"  
					+ "s.SponsorName,s.address sponsoraddress,ac.job_title,DATE_FORMAT(ac.joining_date,'%d-%m-%Y') joiningdate,ac.bank_name,if(m.ownlease=0,'Lease Only','Lease to Own') leasescheme,u.user_name preparedby,"
					+ "u1.user_name verifiedappr,u2.user_name approved from gl_leaseappm m left join my_acbook ac on (m.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_sponsor s on (ac.DOC_NO=s.DOC_NO) left join "
					+ "gl_lprm req on (m.reqdoc=req.doc_no) left join my_exdet ext on (m.doc_no=ext.doc_no and m.dtype=ext.dtype and ext.apprstatus=2) left join my_exdet ext1 on (m.doc_no=ext1.doc_no and m.dtype=ext1.dtype "
					+ "and ext1.apprstatus=3) left join my_user u on m.userid=u.doc_no left join my_user u1 on ext.userid=u1.doc_no left join my_user u2 on ext1.userid=u2.doc_no where m.status<>7 and m.brhid="+branch+" and m.doc_no="+docNo+"";
				
			ResultSet resultSets = stmtLQT.executeQuery(sqls);
			
			while(resultSets.next()){
				
				bean.setLblcustomername(resultSets.getString("refname"));
				bean.setLblcustomeraddress(resultSets.getString("address"));
				bean.setLblcustomermobile(resultSets.getString("mobile"));
				bean.setLblcustomeremail(resultSets.getString("email"));
				bean.setLblemployeename(resultSets.getString("SponsorName"));
				bean.setLblemployeeaddress(resultSets.getString("sponsoraddress"));
				bean.setLbljobtitle(resultSets.getString("job_title"));
				bean.setLbldateofjoining(resultSets.getString("joiningdate"));
				bean.setLblbankname(resultSets.getString("bank_name"));
				bean.setLblschemeoflease(resultSets.getString("leasescheme"));
				bean.setLblpreparedby(resultSets.getString("preparedby"));
				bean.setLblverifiedby(resultSets.getString("verifiedappr"));
				bean.setLblapprovedby(resultSets.getString("approved"));
				
			}
			
			String sqld="select round(totalcost,2) totalcost,round(advance,2) advance,leasemonths,installments,round(installmentpermonth,2) installmentpermonth,CONCAT('BRAND : ',br.brand_name,' & MODEL : ',m.vtype,COALESCE(CONCAT(' & VSB No : ',v.vin),' ')) typeofvehicle "
					+ "from gl_leaseappd d left join gl_vehmodel m on d.modid=m.doc_no left join gl_vehbrand br on d.brdid=br.doc_no left join gl_vehleasecdw cd on d.cdw=cd.doc_no left join gl_blaf bf on d.leasereqdocno=bf.rdocno "
					+ "left join gl_vehmaster v on v.fleet_no=bf.fleet where d.brhid="+branch+" and d.rdocno="+docNo+"";
					
			ResultSet resultSet1 = stmtLQT.executeQuery(sqld);
						
			ArrayList<String> printleaseapplication= new ArrayList<String>();
			
			while(resultSet1.next()){
				bean.setFirstarray(1);
				String temp="";
				temp=resultSet1.getString("typeofvehicle")+"::"+resultSet1.getString("totalcost")+"::"+resultSet1.getString("advance")+"::"+resultSet1.getString("leasemonths")+"::"+resultSet1.getString("installments")+"::"+resultSet1.getString("installmentpermonth");
				printleaseapplication.add(temp);
			}
			
			request.setAttribute("printleaseapplications", printleaseapplication);

			
			ArrayList trlist = new ArrayList<>();
		       
	       String sql2="select m.voc_no,m.dtype,termsheader terms,conditions conditions from my_trterms tr left join my_termsm m on(tr.termsid=m.voc_no) where "
					+ " tr.dtype='LQT' and tr.rdocno="+docNo+" order by terms";

			ResultSet rs3 = stmtLQT.executeQuery(sql2);

			int trcount=1;
			String oldtrms="";
			String newtrms="";
			String testing="";
			String cond="";
			while(rs3.next()){

				String temp="";
				newtrms=rs3.getString("terms");
				if(oldtrms.equalsIgnoreCase(newtrms)){
					testing="";
					trcount++;
				}
				else{
					trcount=1;
					testing=rs3.getString("terms");
				}
				cond=trcount+") "+rs3.getString("conditions");
				temp=testing+"::"+cond;	

				trlist.add(temp);
				oldtrms=newtrms;
			}
			bean.setTermlist(trlist);		       
		
			String sql3 = "select min(DATE_FORMAT(d.edate,'%d-%m-%Y')) preparedon,min(DATE_FORMAT(d.edate,'%H:%i:%s')) preparedat from gl_leaseappm m inner join datalog d on (m.doc_no=d.doc_no and m.dtype=d.dtype and m.brhid=d.brhid) where m.dtype='LQT' and m.brhid="+branch+" and m.doc_no="+docNo+"";
			
			ResultSet resultSet3 = stmtLQT.executeQuery(sql3);
			
			while(resultSet3.next()){
				bean.setLblpreparedon(resultSet3.getString("preparedon"));
				bean.setLblpreparedat(resultSet3.getString("preparedat"));
			}
			
			stmtLQT.close();
			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
		return bean;
	}
	
    public JSONArray applicationGridLoading(String reqdocno,String docno) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        if(reqdocno.equalsIgnoreCase("0") || reqdocno.equalsIgnoreCase("")){
        	return RESULTDATA;
        }
        
        Connection conn = null;
		
        try {
				conn = connDAO.getMyConnection();
				Statement stmt=conn.createStatement();
				
				String strsql = "select req.reqsrno,req.leasefromdate,req.brdid,req.modid modelid,req.spec specification,req.clrid,req.leasemonths,req.kmpermonth,req.grpid,req.totalvalue totalcost,((req.totalvalue/req.leasemonths)*3) advance,"
						      + "(req.totalvalue/req.leasemonths) rateperamount,req.leasereqdocno,req.rdocno,req.quantity qty,brd.brand_name brand,model.vtype model,clr.color,grp.gname from gl_leasecalcreq req "
						      + "left join gl_vehbrand brd on req.brdid=brd.doc_no left join gl_vehmodel model on  req.modid=model.doc_no left join my_color clr on req.clrid=clr.doc_no left join gl_lcgm lcg on "
						      + "(req.brdid=req.brdid and req.modid=lcg.modid) left join  gl_vehgroup grp on (lcg.grpid=grp.doc_no) where req.status=3 and req.rdocno="+docno+" and req.leasereqdocno="+reqdocno+"";
				
				/*strsql = "select req.leasefromdate,req.brdid,req.modid modelid,req.spec specification,req.clrid,req.leasemonths,req.kmpermonth,req.grpid,req.totalvalue rateperamount,"  
						+ "(req.leasemonths*req.totalvalue) totalcost,req.leasereqdocno,req.rdocno,brd.brand_name  brand,model.vtype model,clr.color,grp.gname,det.qty from gl_leasecalcreq req "
						+ "left join gl_lprd det on req.leasereqdocno=det.rdocno left join gl_vehbrand brd on req.brdid=brd.doc_no left join gl_vehmodel model on  req.modid=model.doc_no "
						+ "left join my_color clr on req.clrid=clr.doc_no left join gl_lcgm lcg on (req.brdid=req.brdid and req.modid=lcg.modid) left join  gl_vehgroup grp on (lcg.grpid=grp.doc_no) "
						+ "where req.status=3 and req.rdocno="+docno+" and req.leasereqdocno="+reqdocno+"";*/
				
				
				ResultSet resultSet = stmt.executeQuery(strsql);
				RESULTDATA=commonDAO.convertToJSON(resultSet);
				
				stmt.close();
		} catch(Exception e){
			e.printStackTrace();
		} finally{
			conn.close();
		}
        return RESULTDATA;
    }
    
    public JSONArray applicationGridReloading(HttpSession session,String docNo) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
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
        String branch = session.getAttribute("BRANCHID").toString();
        
  		try {
  				conn = connDAO.getMyConnection();
  				Statement stmtLQT = conn.createStatement();
  			
  				ResultSet resultSet = stmtLQT.executeQuery ("select reqsrno,leasefromdate, brdid, modid modelid, spec specification, clrid, leasemonths, kmpermonth, grpid, round(ratepermonth,2) rateperamount,qty,"
  						+ "round(totalcost,2) totalcost, round(advance,2) advance, installments noofinstallments,round(installmentpermonth,2) amountpermonth, brd.brand_name brand,grp.gname,m.vtype model,"
  						+ "clr.color,cd.name cdw from gl_leaseappd d left join gl_vehbrand brd on d.brdid=brd.doc_no left join gl_vehmodel m on d.modid=m.doc_no left join my_color clr on d.clrid=clr.doc_no left join "
  						+ "gl_vehgroup grp on (d.grpid=grp.doc_no) left join gl_vehleasecdw cd on d.cdw=cd.doc_no where d.brhid="+branch+" and d.rdocno="+docNo+"");
                
  				RESULTDATA=commonDAO.convertToJSON(resultSet);
  				
  				stmtLQT.close();
  				conn.close();
  		}
  		catch(Exception e){
  			e.printStackTrace();
  			conn.close();
  		}finally{
  			conn.close();
  		}
  		return RESULTDATA;
    }
    
    public JSONArray applicationGridEditReloading(HttpSession session,String docNo,String docno,String reqdocno) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
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
        String branch = session.getAttribute("BRANCHID").toString();
        
  		try {
  				conn = connDAO.getMyConnection();
  				Statement stmtLQT = conn.createStatement();
  			
  				ResultSet resultSet = stmtLQT.executeQuery ("select * from ( select reqsrno,leasefromdate, brdid, modid modelid, spec specification, clrid, leasemonths, kmpermonth, grpid,"  
  						+ "round(ratepermonth,2) rateperamount,round(totalcost,2) totalcost, round(advance,2) advance, installments noofinstallments,round(installmentpermonth,2) amountpermonth, "
  						+ "brd.brand_name brand,grp.gname,m.vtype model,clr.color,cd.name cdw,qty from gl_leaseappd d left join gl_vehbrand brd on d.brdid=brd.doc_no left join gl_vehmodel m on d.modid=m.doc_no "
  						+ "left join my_color clr on d.clrid=clr.doc_no left join gl_vehgroup grp on (d.grpid=grp.doc_no) left join gl_vehleasecdw cd on d.cdw=cd.doc_no where d.brhid="+branch+" and d.rdocno="+docNo+" "  
  						+ "UNION ALL select req.reqsrno,req.leasefromdate,req.brdid,req.modid modelid,req.spec specification,req.clrid,req.leasemonths,req.kmpermonth,req.grpid,(coalesce(req.totalvalue,0)/req.leasemonths) rateperamount,"
  						+ "coalesce(req.totalvalue,0) totalcost,(((coalesce(req.totalvalue,0)/req.leasemonths))*3) advance,0 noofinstallments,0 amountpermonth,brd.brand_name  brand,grp.gname,model.vtype model,clr.color,'' cdw,req.quantity qty from gl_leasecalcreq req "
  						+ "left join gl_vehbrand brd on req.brdid=brd.doc_no left join gl_vehmodel model on  req.modid=model.doc_no left join my_color clr on req.clrid=clr.doc_no left join gl_lcgm lcg on (req.brdid=req.brdid and req.modid=lcg.modid) "
  						+ "left join  gl_vehgroup grp on (lcg.grpid=grp.doc_no) where req.status=3 and req.rdocno="+docno+" and req.leasereqdocno="+reqdocno+") a group by a.reqsrno");
                
  				RESULTDATA=commonDAO.convertToJSON(resultSet);
  				
  				stmtLQT.close();
  				conn.close();
  		}
  		catch(Exception e){
  			e.printStackTrace();
  			conn.close();
  		}finally{
  			conn.close();
  		}
  		return RESULTDATA;
    }
    
    public JSONArray leaseCalcSearch(HttpSession session,String docno,String leasereqdocno,String date,String id,String client,String mobile) throws SQLException {

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
        String branch = session.getAttribute("BRANCHID").toString();
        
        if(!id.equalsIgnoreCase("1")){
        	return RESULTDATA;
        }
        
        Connection conn = null;
        
        java.sql.Date sqldate=null;
        
        String sqltest="";
        
		try {
				conn = connDAO.getMyConnection();
				Statement stmtLQT=conn.createStatement();
				
				if(!date.equalsIgnoreCase("")){
					sqldate=commonDAO.changeStringtoSqlDate(date);
				}
				if(!docno.equalsIgnoreCase("")){
					sqltest+=" and calc.vocno="+docno;
				}
				if(!leasereqdocno.equalsIgnoreCase("")){
					sqltest+=" and reqdoc="+leasereqdocno;
				}
				if(sqldate!=null){
					sqltest+=" and calc.date='"+sqldate+"'";
				}
				if(!client.equalsIgnoreCase("")){
					sqltest+=" and if(req.reqtype=1,ac.refname like '%"+client+"%',req.name like '%"+client+"%')";
				}
				if(!mobile.equalsIgnoreCase("")){
					sqltest+=" and if(req.reqtype=1,ac.com_mob like '%"+mobile+"%',req.mob like '%"+mobile+"%')";
				}
				
				String strsql="select req.cldocno,if(req.reqtype=1,ac.com_mob,req.mob) mobile,if(req.reqtype=1,ac.refname,req.name) refname,if(req.reqtype=1,ac.address,req.com_add1) address,"
						+ "if(req.reqtype=1,ac.mail1,req.email) email,calc.doc_no,calc.vocno,calc.date,calc.reqdoc leasereqdocno,s.sal_name from gl_leasecalcm calc left join gl_lprm req on (calc.reqdoc=req.doc_no) "
						+ "left join my_acbook ac on (req.cldocno=ac.cldocno and ac.dtype='CRM') left join my_salm s on ac.sal_id=s.doc_no where calc.status=3 and calc.leaseappstatus=0 and calc.brhid="+branch+""+sqltest;
				
				ResultSet resultSet = stmtLQT.executeQuery(strsql);
				RESULTDATA=commonDAO.convertToJSON(resultSet);
				
				stmtLQT.close();
		} catch(Exception e){
			e.printStackTrace();
		} finally{
			conn.close();
		}
        return RESULTDATA;
    }
    
    public String getLeaseCDW() throws SQLException {
    	
		String cellarray1 = "";  
	    Connection conn = null;
		try {
				conn = connDAO.getMyConnection();
				Statement stmtLQT = conn.createStatement();
				
				String tasql= "select name from gl_vehleasecdw where status=3";
				ResultSet resultSet5 = stmtLQT.executeQuery(tasql);

				while (resultSet5.next()) {
					cellarray1+=resultSet5.getString("name")+",";
				}
				cellarray1=cellarray1.substring(0, cellarray1.length()-1);
				stmtLQT.close();
				conn.close();
		}
		catch(Exception e){
			conn.close();
			e.printStackTrace();
		}
	    return cellarray1;
	}
    
    public JSONArray termsGridLoad(HttpSession session,String dtype) throws SQLException {
		  JSONArray RESULTDATA=new JSONArray();
		  Connection conn = null;

		  try {
			  conn = connDAO.getMyConnection();
			  Statement stmt = conn.createStatement();

			  String sql="select m.doc_no,m.voc_no,m.dtype,termsheader terms,termsfooter conditions from my_termsm m  inner join my_termsd d on(m.voc_no=d.rdocno) where d.status=3 and m.mand=1 and d.dtype='"+dtype+"' order by m.doc_no,d.doc_no";
			  
			  ResultSet resultSet = stmt.executeQuery(sql);
			  RESULTDATA=commonDAO.convertToJSON(resultSet);

		  	} catch(Exception e){
		  		e.printStackTrace();
		  	} finally{
		  		conn.close();
		  	}
		  return RESULTDATA;
		 }
		
	  public JSONArray termsGridReLoad(HttpSession session,String dtype,String qotdoc) throws SQLException {
		  JSONArray RESULTDATA=new JSONArray();
		  Connection conn = null;

		  try {
			  conn = connDAO.getMyConnection();
			  Statement stmt = conn.createStatement();

			  String sql="select m.voc_no,m.dtype,termsheader terms,conditions conditions from my_trterms tr left join my_termsm m on(tr.termsid=m.voc_no) where  tr.dtype='"+dtype+"' and tr.rdocno="+qotdoc+" order by terms";

			  ResultSet resultSet = stmt.executeQuery(sql);
			  RESULTDATA=commonDAO.convertToJSON(resultSet);

		  	} catch(Exception e){
		  		e.printStackTrace();
		  	} finally{
		  		conn.close();
		  	}
		  	return RESULTDATA;
		 }
  
	  public JSONArray termsSearch(HttpSession session,String dtype) throws SQLException {
		  JSONArray RESULTDATA=new JSONArray();
		  Connection conn = null;

		  try {
			  conn = connDAO.getMyConnection();
			  Statement stmt = conn.createStatement (); 

			  String sql="select doc_no,voc_no,dtype,termsheader as header from my_termsm where dtype='"+dtype+"'";

			  ResultSet resultSet = stmt.executeQuery (sql);
			  RESULTDATA=commonDAO.convertToJSON(resultSet);

			  stmt.close();
			  conn.close();

		  } catch(Exception e){
			  e.printStackTrace();
			  conn.close();
		  }
		  return RESULTDATA;
		 }
	  
	  public JSONArray condtnSearch(HttpSession session,String dtype,String tdocno) throws SQLException {

			JSONArray RESULTDATA=new JSONArray();

			Connection conn = null;

			try {
				conn = connDAO.getMyConnection();
				Statement stmt = conn.createStatement (); 


				String sql="select doc_no, rdocno, termsfooter from my_termsd where  dtype='"+dtype+"' and rdocno="+tdocno+"";

				ResultSet resultSet = stmt.executeQuery (sql);
				RESULTDATA=commonDAO.convertToJSON(resultSet);

				stmt.close();
				conn.close();

			} catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
			return RESULTDATA;
		}
    
    public JSONArray lqtMainSearch(HttpSession session,String docno,String leasereqdocno,String date,String id,String client,String mobile) throws SQLException {

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
        String branch=session.getAttribute("BRANCHID").toString();
        
        if(!id.equalsIgnoreCase("1")){
        	return RESULTDATA;
        }
        
        Connection conn = null;
        
        java.sql.Date sqldate=null;
        
        String sqltest="";
        
		try {
				conn = connDAO.getMyConnection();
				Statement stmt=conn.createStatement();
				
				if(!date.equalsIgnoreCase("")){
					sqldate=commonDAO.changeStringtoSqlDate(date);
				}
				if(!docno.equalsIgnoreCase("")){
					sqltest+=" and m.doc_no="+docno;
				}
				if(!leasereqdocno.equalsIgnoreCase("")){
					sqltest+=" and m.reqdoc="+leasereqdocno;
				}
				if(sqldate!=null){
					sqltest+=" and m.date='"+sqldate+"'";
				}
				if(!client.equalsIgnoreCase("")){
					sqltest+=" and if(req.reqtype=1,ac.refname like '%"+client+"%',req.name like '%"+client+"%')";
				}
				if(!mobile.equalsIgnoreCase("")){
					sqltest+=" and if(req.reqtype=1,ac.com_mob like '%"+mobile+"%',req.mob like '%"+mobile+"%')";
				}
				
				String strsql="select m.date,m.doc_no,m.reqdoc leasereqdocno,if(req.reqtype=1,ac.com_mob,req.mob) mobile,if(req.reqtype=1,ac.refname,req.name) refname from "
						+ "gl_leaseappm m left join my_acbook ac on (m.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_lprm req on (m.reqdoc=req.doc_no) where m.status<>7 "
						+ "and m.brhid="+branch+" "+sqltest;
				
				ResultSet resultSet = stmt.executeQuery(strsql);
				RESULTDATA=commonDAO.convertToJSON(resultSet);
				
				stmt.close();
		} catch(Exception e){
			e.printStackTrace();
		} finally{
			conn.close();
		}
        return RESULTDATA;
    }

    public int insertion(Connection conn,int docno,String formdetailcode,int leasereqdoc, ArrayList<String> leaseapplicationarray, ArrayList<String> termslist, HttpSession session,String mode) throws SQLException{
    	
		  try{
				conn.setAutoCommit(false);
				CallableStatement stmtLQT;
				Statement stmtLQT1 = conn.createStatement();
				
				String branch=session.getAttribute("BRANCHID").toString().trim();
				
				/*Lease Application Grid and Details Saving*/
				for(int i=0;i< leaseapplicationarray.size();i++){
					String[] leaseapp=leaseapplicationarray.get(i).split("::");
					if(!leaseapp[0].trim().equalsIgnoreCase("undefined") && !leaseapp[0].trim().equalsIgnoreCase("NaN")){
					
					java.sql.Date leaseFromDate=(leaseapp[0].trim().equalsIgnoreCase("undefined") || leaseapp[0].trim().equalsIgnoreCase("NaN") || leaseapp[0].trim().equalsIgnoreCase("") ||  leaseapp[0].trim().isEmpty()?null:commonDAO.changetstmptoSqlDate(leaseapp[0].trim()));
						
					
					stmtLQT = conn.prepareCall("{CALL leaseapplicationdDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
					
					/*Insertion to gl_leaseappd*/
					stmtLQT.setInt(19,docno);
					stmtLQT.registerOutParameter(20, java.sql.Types.INTEGER);
					stmtLQT.setInt(1,leasereqdoc); //leasereqdoc
					stmtLQT.setDate(2,leaseFromDate);  //dleaseFromDate
					stmtLQT.setString(3,(leaseapp[1].trim().equalsIgnoreCase("undefined") || leaseapp[1].trim().equalsIgnoreCase("NaN") || leaseapp[1].trim().isEmpty()?"0":leaseapp[1].trim()).toString()); //ibrdId
					stmtLQT.setString(4,(leaseapp[2].trim().equalsIgnoreCase("undefined") || leaseapp[2].trim().equalsIgnoreCase("NaN") || leaseapp[2].trim().isEmpty()?"0":leaseapp[2].trim()).toString()); //imodId 
					stmtLQT.setString(5,(leaseapp[3].trim().equalsIgnoreCase("undefined") || leaseapp[3].trim().equalsIgnoreCase("NaN") || leaseapp[3].trim().isEmpty()?"0":leaseapp[3].trim()).toString()); //vspec 
					stmtLQT.setString(6,(leaseapp[4].trim().equalsIgnoreCase("undefined") || leaseapp[4].trim().equalsIgnoreCase("NaN") || leaseapp[4].trim().isEmpty()?"0":leaseapp[4].trim()).toString()); //iclrId
					stmtLQT.setString(7,(leaseapp[5].trim().equalsIgnoreCase("undefined") || leaseapp[5].trim().equalsIgnoreCase("NaN") || leaseapp[5].trim().isEmpty()?"0":leaseapp[5].trim()).toString()); //ileaseMonths
					stmtLQT.setString(8,(leaseapp[6].trim().equalsIgnoreCase("undefined") || leaseapp[6].trim().equalsIgnoreCase("NaN") || leaseapp[6].trim().isEmpty()?0:leaseapp[6].trim()).toString()); //dkmPerMonth
					stmtLQT.setString(9,(leaseapp[7].trim().equalsIgnoreCase("undefined") || leaseapp[7].trim().equalsIgnoreCase("NaN") || leaseapp[7].trim().isEmpty()?"0":leaseapp[7].trim()).toString()); //igrpId
					stmtLQT.setString(10,(leaseapp[8].trim().equalsIgnoreCase("undefined") || leaseapp[8].trim().equalsIgnoreCase("NaN") || leaseapp[8].trim().isEmpty()?"0":leaseapp[8].trim()).toString()); //dratePerMonth
					stmtLQT.setString(11,(leaseapp[9].trim().equalsIgnoreCase("undefined") || leaseapp[9].trim().equalsIgnoreCase("NaN") || leaseapp[9].trim().isEmpty()?"0":leaseapp[9].trim()).toString()); //dtotalCost
					stmtLQT.setString(12,(leaseapp[10].trim().equalsIgnoreCase("undefined") || leaseapp[10].trim().equalsIgnoreCase("NaN") || leaseapp[10].trim().isEmpty()?"0":leaseapp[10].trim()).toString()); //dadvance
					stmtLQT.setString(13,(leaseapp[11].trim().equalsIgnoreCase("undefined") || leaseapp[11].trim().equalsIgnoreCase("NaN") || leaseapp[11].trim().isEmpty()?"0":leaseapp[11].trim()).toString()); //iinstallments
					stmtLQT.setString(14,(leaseapp[12].trim().equalsIgnoreCase("undefined") || leaseapp[12].trim().equalsIgnoreCase("NaN") || leaseapp[12].trim().isEmpty()?"0":leaseapp[12].trim()).toString()); //dinstallmentPerMonth
					stmtLQT.setString(15,(leaseapp[13].trim().equalsIgnoreCase("undefined") || leaseapp[13].trim().equalsIgnoreCase("NaN") || leaseapp[13].trim().isEmpty()?"0":leaseapp[13].trim()).toString()); //vcdw
					stmtLQT.setString(16,(leaseapp[14].trim().equalsIgnoreCase("undefined") || leaseapp[14].trim().equalsIgnoreCase("NaN") || leaseapp[14].trim().isEmpty()?"0":leaseapp[14].trim()).toString()); //iqty
					stmtLQT.setString(17,(leaseapp[15].trim().equalsIgnoreCase("undefined") || leaseapp[15].trim().equalsIgnoreCase("NaN") || leaseapp[15].trim().isEmpty()?"0":leaseapp[15].trim()).toString()); //ireqsrno
					/*gl_leaseappd Ends*/
					
					stmtLQT.setString(18,branch);
					stmtLQT.setString(21,"A");
					stmtLQT.execute();
					if(stmtLQT.getInt("irowsNo")<=0){
						stmtLQT.close();
						conn.close();
						return 0;
					}
					}
				    }
				    /*Lease Application Grid and Details Saving Ends*/
				
				for(int j=0;j< termslist.size();j++) {

				     String[] terms=((String) termslist.get(j)).split("::");

				     if(!((terms[0].equalsIgnoreCase("0"))||(terms[0].equalsIgnoreCase("undefined")))){

					      String termsql="insert into my_trterms(rdocno, brhid, priorno, termsid, conditions, status, dtype) VALUES ('"+docno+"', '"+branch+"', "+(j+1)+","
					        + "'"+(terms[0].equalsIgnoreCase("undefined") || terms[0].equalsIgnoreCase("") || terms[0].trim().equalsIgnoreCase("NaN")|| terms[0].isEmpty()?0:terms[0].trim())+"',"
					        + "'"+(terms[3].equalsIgnoreCase("undefined") || terms[3].equalsIgnoreCase("") || terms[3].trim().equalsIgnoreCase("NaN")|| terms[3].isEmpty()?0:terms[3].trim())+"',"
					        + "'3','"+formdetailcode+"')";
	
					      int resultSet3 = stmtLQT1.executeUpdate (termsql);
	
					      if(resultSet3<=0) {
					         conn.close();
					         return 0;
					      }
				     }
			    }
			     
			    String sql4=("DELETE FROM gl_leaseappd where rdocno="+docno+" and brhid="+branch+" and advance=0 and installmentpermonth=0");
			    int data1 = stmtLQT1.executeUpdate(sql4);
			     /*Deleting account of value zero ends*/
					
	   } catch(Exception e){	
		 	e.printStackTrace();
		 	conn.close();
		 	return 0;
	 }
		return 1;
	}
}
