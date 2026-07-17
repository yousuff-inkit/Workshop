package com.workshop.evaluation;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsEvaluationDAO {

	ClsCommon commonDAO = new ClsCommon();
	ClsConnection connDAO = new ClsConnection();

	public int insert(Date date, String masterdocno,String formdetailcode, String billingamt,String carmaker, String chassisno, String engineno,
			String evaluatedfor,String exterior,String interior, String marketprice, String mileage,
			String model,String noofcylinders, String remakrs, String specification, String transmission,String warranty,String yearofmake,HttpSession session,HttpServletRequest request) throws SQLException {	
		Connection conn = null;
		
		try{    
				conn=connDAO.getMyConnection();
				conn.setAutoCommit(false);
				
				String company=session.getAttribute("COMPANYID").toString().trim();
				String branch=session.getAttribute("BRANCHID").toString().trim();
				String currency=session.getAttribute("CURRENCYID").toString().trim();
				String userid=session.getAttribute("USERID").toString().trim();
				
				CallableStatement stmtEVL = conn.prepareCall("{CALL evaluationDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");

				stmtEVL.registerOutParameter(24, java.sql.Types.INTEGER);
				stmtEVL.registerOutParameter(25, java.sql.Types.INTEGER);   
				stmtEVL.setDate(1,date);
				stmtEVL.setString(2,carmaker);
				stmtEVL.setString(3,chassisno);
				stmtEVL.setString(4,engineno);
				stmtEVL.setString(5,evaluatedfor);
				stmtEVL.setString(6,exterior);
				stmtEVL.setString(7,interior);
			    stmtEVL.setString(8,mileage);
				stmtEVL.setString(9,model);
				stmtEVL.setString(10,noofcylinders);
				stmtEVL.setString(11,remakrs);
				stmtEVL.setString(12,specification);
				stmtEVL.setString(13,transmission);
				stmtEVL.setString(14,warranty);
				stmtEVL.setString(15,yearofmake);
				stmtEVL.setDouble(16,marketprice=="" || marketprice==null?0.0:Double.parseDouble(marketprice));               
				stmtEVL.setDouble(17,billingamt=="" || billingamt==null?0.0:Double.parseDouble(billingamt));    
				stmtEVL.setString(18,formdetailcode);
				stmtEVL.setString(19,currency);
				stmtEVL.setString(20,branch);
				stmtEVL.setString(21,company);
				stmtEVL.setString(22,userid);
				stmtEVL.setString(23,"A");
				stmtEVL.executeQuery();   
				int docno=stmtEVL.getInt("docNo");
				int vocno=stmtEVL.getInt("vocNo");     
				request.setAttribute("vocno", vocno);        
				
				if (docno>0) {
					conn.commit();
					stmtEVL.close();
					conn.close();
					return docno;
				}
				stmtEVL.close();
				conn.close();
			 }catch(Exception e){
				 	e.printStackTrace();
				 	conn.close();
				 	return 0;
			 }finally{
				 conn.close();
			 }
		return 0;
	}

	public int edit(Date date, String masterdocno, String docno,String formdetailcode, String billingamt,String carmaker, String chassisno, String engineno,
			String evaluatedfor,String exterior,String interior, String marketprice, String mileage,
			String model,String noofcylinders, String remakrs, String specification, String transmission,String warranty,String yearofmake,HttpSession session,HttpServletRequest request) throws SQLException {	
		Connection conn = null;
		
		try{    
				conn=connDAO.getMyConnection();
				conn.setAutoCommit(false);   
				
				String company=session.getAttribute("COMPANYID").toString().trim();
				String branch=session.getAttribute("BRANCHID").toString().trim();
				String currency=session.getAttribute("CURRENCYID").toString().trim();
				String userid=session.getAttribute("USERID").toString().trim();
				
				CallableStatement stmtEVL = conn.prepareCall("{CALL evaluationDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");

				stmtEVL.setString(24, masterdocno);
				stmtEVL.setString(25, docno);                
				stmtEVL.setDate(1,date);
				stmtEVL.setString(2,carmaker);
				stmtEVL.setString(3,chassisno);
				stmtEVL.setString(4,engineno);
				stmtEVL.setString(5,evaluatedfor);
				stmtEVL.setString(6,exterior);
				stmtEVL.setString(7,interior);
			    stmtEVL.setString(8,mileage);
				stmtEVL.setString(9,model);
				stmtEVL.setString(10,noofcylinders);
				stmtEVL.setString(11,remakrs);
				stmtEVL.setString(12,specification);
				stmtEVL.setString(13,transmission);
				stmtEVL.setString(14,warranty);
				stmtEVL.setString(15,yearofmake);
				stmtEVL.setDouble(16,marketprice=="" || marketprice==null?0.0:Double.parseDouble(marketprice));               
				stmtEVL.setDouble(17,billingamt=="" || billingamt==null?0.0:Double.parseDouble(billingamt));    
				stmtEVL.setString(18,formdetailcode);
				stmtEVL.setString(19,currency);
				stmtEVL.setString(20,branch);
				stmtEVL.setString(21,company);
				stmtEVL.setString(22,userid);
				stmtEVL.setString(23,"E");   
				stmtEVL.executeQuery();   
				int docnoss=stmtEVL.getInt("docNo");
				if (docnoss>0) {    
					conn.commit();
					stmtEVL.close();
					conn.close();
					return 1;   
				}
				stmtEVL.close();
				conn.close();
			 }catch(Exception e){
				 	e.printStackTrace();
				 	conn.close();
				 	return 0;
			 }finally{
				 conn.close();
			 }
		return 0;
	}
	
	public int delete(Date date, String masterdocno, String docno,String formdetailcode, String billingamt,String carmaker, String chassisno, String engineno,
			String evaluatedfor,String exterior,String interior, String marketprice, String mileage,
			String model,String noofcylinders, String remakrs, String specification, String transmission,String warranty,String yearofmake,HttpSession session,HttpServletRequest request) throws SQLException {	
		Connection conn = null;
		
		try{    
				conn=connDAO.getMyConnection();
				conn.setAutoCommit(false);   
				
				String company=session.getAttribute("COMPANYID").toString().trim();
				String branch=session.getAttribute("BRANCHID").toString().trim();
				String currency=session.getAttribute("CURRENCYID").toString().trim();
				String userid=session.getAttribute("USERID").toString().trim();
				
				CallableStatement stmtEVL = conn.prepareCall("{CALL evaluationDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");

				stmtEVL.setString(24, masterdocno);
				stmtEVL.setString(25, docno);                
				stmtEVL.setDate(1,null);
				stmtEVL.setString(2,null);
				stmtEVL.setString(3,null);
				stmtEVL.setString(4,null);
				stmtEVL.setString(5,null);
				stmtEVL.setString(6,null);
				stmtEVL.setString(7,null);
			    stmtEVL.setString(8,null);
				stmtEVL.setString(9,null);
				stmtEVL.setString(10,null);
				stmtEVL.setString(11,null);
				stmtEVL.setString(12,null);
				stmtEVL.setString(13,null);
				stmtEVL.setString(14,null);
				stmtEVL.setString(15,null);
				stmtEVL.setDouble(16,0.0);               
				stmtEVL.setDouble(17,0.0);    
				stmtEVL.setString(18,formdetailcode);
				stmtEVL.setString(19,currency);
				stmtEVL.setString(20,branch);
				stmtEVL.setString(21,company);
				stmtEVL.setString(22,userid);       
				stmtEVL.setString(23,"D");   
				stmtEVL.executeQuery();   
				int docnoss=stmtEVL.getInt("docNo");
				if (docnoss>0) {    
					conn.commit();
					stmtEVL.close();
					conn.close();
					return 1;   
				}
				stmtEVL.close();
				conn.close();
			 }catch(Exception e){
				 	e.printStackTrace();
				 	conn.close();
				 	return 0;
			 }finally{
				 conn.close();
			 }
		return 0;
	}
	
	

	public ClsEvaluationBean getViewDetails(String docNo) throws SQLException {
		ClsEvaluationBean bean = new ClsEvaluationBean();
		
		Connection conn = null;
		
		try {
			conn = connDAO.getMyConnection();
			Statement stmtEVL = conn.createStatement();

			String sql="select m.doc_no, m.voc_no, date_format(m.date,'%d.%m.%Y') date, m.brhid, m.userid, m.dtype, m.carmaker, m.chassisno, m.engineno, m.cldocno, m.exterior, m.interior, m.mileage,"
					+ " m.model, m.cylinders, m.transmission, m.warranty, m.yearofmake, m.specification, round(m.marketprice,2) marketprice, round(m.billingamt,2) billingamt, m.remarks,ac.refname from ws_evalm m "
					+ " left join my_acbook ac on ac.cldocno=m.cldocno and ac.dtype='CRM' where m.status=3 and m.doc_no="+docNo+"";
			ResultSet rs = stmtEVL.executeQuery(sql);
			while (rs.next()) {
				    bean.setCldocno(rs.getString("cldocno"));   
				    bean.setDocno(rs.getString("voc_no"));
				    bean.setHiddate(rs.getString("date"));
				    bean.setTxtbillingamt(rs.getString("billingamt"));
				    bean.setTxtcarmaker(rs.getString("carmaker"));
				    bean.setTxtchassisno(rs.getString("chassisno"));
				    bean.setTxtengineno(rs.getString("engineno"));
				    bean.setTxtevaluatedfor(rs.getString("refname"));     
				    bean.setTxtexterior(rs.getString("exterior"));
				    bean.setTxtinterior(rs.getString("interior"));
				    bean.setTxtmarketprice(rs.getString("marketprice"));
				    bean.setTxtmileage(rs.getString("mileage"));
				    bean.setTxtmodel(rs.getString("model"));
				    bean.setTxtnoofcylinders(rs.getString("cylinders"));
				    bean.setTxtremakrs(rs.getString("remarks"));
				    bean.setTxtspecification(rs.getString("specification"));
				    bean.setTxttransmission(rs.getString("transmission"));
				    bean.setTxtwarranty(rs.getString("warranty"));
				    bean.setTxtyearofmake(rs.getString("yearofmake"));
			}
			stmtEVL.close();
			conn.close();
			}catch(Exception e){
				e.printStackTrace();
				conn.close();
			}finally{
				 conn.close();
			 }
			return bean;     
			}
	
	
	 public JSONArray searchClient(HttpSession session,String clname,String mob,int id) throws SQLException {
	 		JSONArray RESULTDATA=new JSONArray();
			if(id==0){
				return RESULTDATA;
			}   
			String brid=session.getAttribute("BRANCHID").toString();
			String sqltest="",clsql="",sqltest3="";     
			if(!(clname.equalsIgnoreCase("undefined"))&&!(clname.equalsIgnoreCase(""))&&!(clname.equalsIgnoreCase("0"))){
				sqltest=sqltest+" and refname like '%"+clname+"%'";
			}
			if(!(mob.equalsIgnoreCase("undefined"))&&!(mob.equalsIgnoreCase(""))&&!(mob.equalsIgnoreCase("0"))){
				sqltest=sqltest+" and per_mob like '%"+mob+"%'";    
			}  

			Connection conn = null;
			try {
				conn = connDAO.getMyConnection();
				ResultSet resultSet1;
				Statement stmt=conn.createStatement();
			   
						Statement stmtVeh1 = conn.createStatement ();    
						ResultSet resultSet=null;  
						clsql= "select per_tel pertel,ac.cldocno,refname,trim(address) address,per_mob mobno,trim(mail1) mail1 from my_acbook ac  where  dtype='CRM' and ac.status<>7  " +sqltest+" "+sqltest3+"";	
						resultSet = stmtVeh1.executeQuery(clsql); 
						RESULTDATA=commonDAO.convertToJSON(resultSet); 
					   
					//System.out.println("clsql======"+clsql);            
					    
					stmtVeh1.close();  
					conn.close();
			}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
			//System.out.println(RESULTDATA);
			return RESULTDATA;
		}
	 public JSONArray evlMainSearch(HttpSession session,String clname,String docno,String date,String id) throws SQLException {
	 		JSONArray RESULTDATA=new JSONArray();
			if(!id.equalsIgnoreCase("1")){    
				return RESULTDATA;
			}   
			String brid=session.getAttribute("BRANCHID").toString();
			String sqltest="";  
			java.sql.Date dates ; 
			if(!(clname.equalsIgnoreCase("undefined"))&&!(clname.equalsIgnoreCase(""))&&!(clname.equalsIgnoreCase("0"))){
				sqltest=sqltest+" and ac.refname like '%"+clname+"%'";
			}
			if(!(docno.equalsIgnoreCase("undefined"))&&!(docno.equalsIgnoreCase(""))&&!(docno.equalsIgnoreCase("0"))){
				sqltest=sqltest+" and m.voc_no like '%"+docno+"%'";               
			}  
			if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0"))){
				dates = commonDAO.changeStringtoSqlDate(date);     
				sqltest=sqltest+" and m.date='"+dates+"'";                   
			} 
			
			Connection conn = null;
			try {
				conn = connDAO.getMyConnection();
				ResultSet resultSet1;
				Statement stmt=conn.createStatement();
			   
						Statement stmtVeh1 = conn.createStatement ();    
						ResultSet resultSet=null;     
						String sql="select m.doc_no, m.voc_no, date_format(m.date,'%d.%m.%Y') date, m.brhid, m.userid, m.dtype, m.carmaker, m.chassisno, m.engineno, m.cldocno, m.exterior, m.interior, m.mileage,"
								+ " m.model, m.cylinders, m.transmission, m.warranty, m.yearofmake, m.specification, m.marketprice, m.billingamt, m.remarks,ac.refname from ws_evalm m "
								+ " left join my_acbook ac on ac.cldocno=m.cldocno and ac.dtype='CRM' where m.status=3 and m.brhid='"+brid+"' "+sqltest+"";	    
						resultSet = stmtVeh1.executeQuery(sql); 
						RESULTDATA=commonDAO.convertToJSON(resultSet); 
					   
					//System.out.println("sql======"+sql);                
					    
					stmtVeh1.close();  
					conn.close();
			}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
			//System.out.println(RESULTDATA);
			return RESULTDATA;
		}
}
