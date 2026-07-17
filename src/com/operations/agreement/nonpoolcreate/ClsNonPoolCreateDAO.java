package com.operations.agreement.nonpoolcreate;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.operations.vehicletransactions.movement.ClsMovementBean;

public class ClsNonPoolCreateDAO {
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	public  JSONArray fleetSearch(String branch,String searchdate,String fleetno,String docno,String regno,String color,String group) throws SQLException {
	    Connection conn = null;
	    JSONArray RESULTDATA=new JSONArray();
		try {
			conn=objconn.getMyConnection();
			java.sql.Date sqldate=null;
			String sqltest="";
			if(!(searchdate.equalsIgnoreCase(""))){
				sqldate=objcommon.changeStringtoSqlDate(searchdate);
			}
			if(!(docno.equalsIgnoreCase(""))){
				sqltest=sqltest+" and veh.doc_no like '%"+docno+"%'";
			}
			if(!(fleetno.equalsIgnoreCase(""))){
				sqltest=sqltest+" and veh.fleet_no like '%"+fleetno+"%'";
			}
			if(!(regno.equalsIgnoreCase(""))){
				sqltest=sqltest+" and veh.reg_no like '%"+regno+"%'";
			}
			if(sqldate!=null){
				sqltest=sqltest+" and veh.date='"+sqldate+"'";
				
			}
			if(!(group.equalsIgnoreCase(""))){
				sqltest=sqltest+" and veh.vgrpid like '%"+group+"%'";
			}
			if(!(color.equalsIgnoreCase(""))){
				sqltest=sqltest+" and veh.clrid like '%"+color+"%'";
			}
				Statement stmtmovement = conn.createStatement();
		     	String strSql="select coalesce(mov.din,veh.date) din,coalesce(mov.tin,non.tin) tin,coalesce(mov.kmin,veh.cur_km) kmin,coalesce(mov.fin,veh.c_fuel) fin,"+
		     			" veh.doc_no,veh.date,veh.reg_no,veh.fleet_no,veh.flname,clr.color,grp.gid from gl_vehmaster veh left join"+
		     			" gl_nonpoolveh non on (veh.fleet_no=non.fleet_no ) left join my_color clr on veh.clrid=clr.doc_no left join gl_vehgroup grp"+
		     			" on veh.vgrpid=grp.doc_no left join gl_vmove mov on (veh.fleet_no=mov.fleet_no and mov.doc_no=(select max(doc_no) from"+
		     			" gl_vmove where fleet_no=veh.fleet_no)) where statu<>7 and a_br="+branch+" and veh.tran_code='IN' and veh.dtype='NPV'"+
		     			" and coalesce(non.clstatus,1)!=0 "+sqltest+"  group by veh.fleet_no";
//	        	System.out.println(strSql);
				ResultSet resultSet = stmtmovement.executeQuery (strSql);
				RESULTDATA=objcommon.convertToJSON(resultSet);
				stmtmovement.close();
				conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
//		System.out.println("RESULTDATA=========>"+RESULTDATA);
	    return RESULTDATA;
	}
	
	public  JSONArray getSearchData(String docno,String date,String vendor,String fleetno,String regno,String mobile,String branch) throws SQLException {
	    Connection conn = null;
	    JSONArray RESULTDATA=new JSONArray();
		try {
			
			conn=objconn.getMyConnection();
			java.sql.Date sqldate=null;
			String sqltest="";
			if(!(date.equalsIgnoreCase(""))){
				sqldate=objcommon.changeStringtoSqlDate(date);
			}
			if(!(docno.equalsIgnoreCase(""))){
				sqltest=sqltest+" and non.voc_no like '%"+docno+"%'";
			}
			if(!(fleetno.equalsIgnoreCase(""))){
				sqltest=sqltest+" and non.fleet_no like '%"+fleetno+"%'";
			}
			if(!(regno.equalsIgnoreCase(""))){
				sqltest=sqltest+" and veh.reg_no like '%"+regno+"%'";
			}
			if(sqldate!=null){
				sqltest=sqltest+" and non.edate='"+sqldate+"'";
				
			}
			if(!(vendor.equalsIgnoreCase(""))){
				sqltest=sqltest+" and ac.refname like '%"+vendor+"%'";
			}
			if(!(mobile.equalsIgnoreCase(""))){
				sqltest=sqltest+" and ac.per_mob like '%"+mobile+"%'";
			}
			
				Statement stmtmovement = conn.createStatement();
				if(!(branch.equalsIgnoreCase("0"))){
	        	String strSql="select non.doc_no,non.voc_no,non.edate,ac.refname,non.fleet_no,veh.reg_no,ac.per_mob from gl_nonpoolveh non left join gl_vehmaster veh on "+
				" non.fleet_no=veh.fleet_no left join my_acbook ac on(non.acc_no=ac.acno and ac.dtype='VND') where non.status<>7 and branch="+branch+""+sqltest;
//	        	System.out.println(strSql);
				ResultSet resultSet = stmtmovement.executeQuery (strSql);
				RESULTDATA=objcommon.convertToJSON(resultSet);
				
				stmtmovement.close();
				conn.close();
//				System.out.println("RESULTDATA=========>"+RESULTDATA);
				return RESULTDATA;
				}
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
//		System.out.println("RESULTDATA=========>"+RESULTDATA);
	    return RESULTDATA;
	}
	public   JSONArray getCheckData() throws SQLException {
	    List<ClsMovementBean> movementbean = new ArrayList<ClsMovementBean>();
	  String strSql="";
	    JSONArray RESULTDATA=new JSONArray();
	    Connection conn = null;
		try {
			conn= objconn.getMyConnection();
				
				Statement stmtmovement = conn.createStatement ();
				
				strSql="select doc_no,sal_name from my_salesman where sal_type='CHK' and status<>7";
//	        	System.out.println(strSql);
				ResultSet resultSet = stmtmovement.executeQuery (strSql);
				RESULTDATA=objcommon.convertToJSON(resultSet);
				stmtmovement.close();
				conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
			
		}
		finally{
			conn.close();
		}
		//System.out.println("RESULTDATA=========>"+RESULTDATA);
	    return RESULTDATA;
	}
	
	
	public   JSONArray vendorSearch(String searchdate,String name,String docno,String acno,String mobile) throws SQLException {
	    Connection conn = null;
	    JSONArray RESULTDATA=new JSONArray();
		try {
			conn=objconn.getMyConnection();
			java.sql.Date sqldate=null;
			String sqltest="";
			if(!(searchdate.equalsIgnoreCase(""))){
				sqldate=objcommon.changeStringtoSqlDate(searchdate);
			}
			if(!(docno.equalsIgnoreCase("") || docno.equalsIgnoreCase("0"))){
				sqltest=sqltest+" and cldocno like '%"+docno+"%'";
			}
			if(sqldate!=null){
				sqltest=sqltest+" and date='"+sqldate+"'";
				
			}
			if(!(name.equalsIgnoreCase("") || name.equalsIgnoreCase("0"))){
				sqltest=sqltest+" and refname like '%"+name+"%'";
			}
			if(!(acno.equalsIgnoreCase("") || acno.equalsIgnoreCase("0"))){
				sqltest=sqltest+" and acno like '%"+acno+"%'";
			}
			if(!(mobile.equalsIgnoreCase("") || mobile.equalsIgnoreCase("0"))){
				sqltest=sqltest+" and per_mob like '%"+mobile+"%'";
			}
				Statement stmtmovement = conn.createStatement();
	        	String strSql="select cldocno,refname,address,per_mob,acno,mail1 from my_acbook where dtype='VND' and status<>7 "+sqltest;
//	        	System.out.println(strSql);
				ResultSet resultSet = stmtmovement.executeQuery (strSql);
				RESULTDATA=objcommon.convertToJSON(resultSet);
				stmtmovement.close();
				conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
//		System.out.println("RESULTDATA=========>"+RESULTDATA);
	    return RESULTDATA;
	}
	
	
	public   JSONArray getInvmodeData() throws SQLException {
	  String strSql="";
	    JSONArray RESULTDATA=new JSONArray();
	    Connection conn = null;
		try {
			conn= objconn.getMyConnection();
				
				Statement stmtinvmode = conn.createStatement ();
				
				strSql="select idno,description,expense acno from gl_invmode where status=1";
//	        	System.out.println(strSql);
				ResultSet resultSet = stmtinvmode.executeQuery (strSql);
				RESULTDATA=objcommon.convertToJSON(resultSet);
				stmtinvmode.close();
				conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
			
		}
		finally{
			conn.close();
		}
		//System.out.println("RESULTDATA=========>"+RESULTDATA);
	    return RESULTDATA;
	}


	public int insert(String fleetno, String vendor, String vendoracno,
			String cmbperiodno, String cmbperiodtype, Date sqldate,
			Date sqldatein, String timein, Date sqldatedue, String timedue,
			String inkm, String cmbinfuel, String hidcheckin, String m1,
			String m2, String m3, String m4, String m5, String m6, String m7,
			String m8, String m9, String m10, String amt1, String amt2,
			String amt3, String amt4, String amt5, ArrayList<String> tarifarray, String mode, HttpSession session,
			String formdetailcode,String cmblocation,String cmbbranch,HttpServletRequest request) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
		
		 ArrayList<String> termclosearray= new ArrayList<>();
		  
		  termclosearray.add((m1.trim().equalsIgnoreCase("")?"0":m1)+":"+(m2.trim().equalsIgnoreCase("")?"0":m2)+":"+(amt1.trim().equalsIgnoreCase("")?"0":amt1));
		  termclosearray.add((m3.trim().equalsIgnoreCase("")?"0":m3)+":"+(m4.trim().equalsIgnoreCase("")?"0":m4)+":"+(amt2.trim().equalsIgnoreCase("")?"0":amt2));
		  termclosearray.add((m5.trim().equalsIgnoreCase("")?"0":m5)+":"+(m6.trim().equalsIgnoreCase("")?"0":m6)+":"+(amt3.trim().equalsIgnoreCase("")?"0":amt3));
		  termclosearray.add((m7.trim().equalsIgnoreCase("")?"0":m7)+":"+(m8.trim().equalsIgnoreCase("")?"0":m8)+":"+(amt4.trim().equalsIgnoreCase("")?"0":amt4));
		  termclosearray.add((m9.trim().equalsIgnoreCase("")?"0":m9)+":"+(m10.trim().equalsIgnoreCase("")?"0":m10)+":"+(amt5.trim().equalsIgnoreCase("")?"0":amt5));
		  
		conn.setAutoCommit(false);
		
		CallableStatement stmtnonpool = conn.prepareCall("{CALL nonPoolCreateDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");


			int nonpooldoc=0;
			int voucherno=0;
			stmtnonpool.registerOutParameter(24,java.sql.Types.INTEGER);
			stmtnonpool.registerOutParameter(30,java.sql.Types.INTEGER);
			//stmtnonpool.registerOutParameter(70,java.sql.Types.INTEGER);
			stmtnonpool.setInt(1,Integer.parseInt(fleetno));
			stmtnonpool.setInt(2,Integer.parseInt(cmbbranch));
			stmtnonpool.setDate(3, sqldate);
			stmtnonpool.setInt(4,Integer.parseInt(vendoracno));
			stmtnonpool.setInt(5,Integer.parseInt(cmbperiodno));
			stmtnonpool.setString(6, cmbperiodtype);
			
			stmtnonpool.setDate(7,null);
			stmtnonpool.setString(8, null);
			stmtnonpool.setString(9,null);
			stmtnonpool.setString(10, null);
			stmtnonpool.setDate(11, sqldatedue);
			stmtnonpool.setString(12, timedue);
			stmtnonpool.setString(13, null);
			stmtnonpool.setDouble(14, 0);
			stmtnonpool.setDate(15, sqldatein);
			stmtnonpool.setString(16, timein);
			stmtnonpool.setString(17, inkm);
			stmtnonpool.setString(18, cmbinfuel);
			stmtnonpool.setString(19, hidcheckin);
			stmtnonpool.setString(20, null);
			stmtnonpool.setString(21, null);
			stmtnonpool.setString(22,session.getAttribute("USERID").toString());
			stmtnonpool.setString(23, cmbbranch);
			//OUT param
			stmtnonpool.setString(25,mode);
			stmtnonpool.setString(26, formdetailcode);
			stmtnonpool.setString(27, null);
			stmtnonpool.setString(28, null);
			stmtnonpool.setString(29,cmblocation);
			stmtnonpool.executeQuery();

			nonpooldoc=stmtnonpool.getInt("docNooo");
			voucherno=stmtnonpool.getInt("voucher");
			request.setAttribute("VOUCHERNO", voucherno);

			//System.out.println("Nonpool Val"+val);
			if(nonpooldoc>0){
				
				Statement stmttarif=conn.createStatement();
			
			
		     String[] tariff=tarifarray.get(0).split("::");
		    
//		     System.out.println("Tariff Array:"+tariff);
		     String sql="INSERT INTO gl_ntarif(rate,cdw,pai,cdw1,pai1,gps,babyseater,cooler,kmrest,exkmrte,chaufchg,chaufexchg,rstatus,brhid,rdocno)VALUES"
		       + " ('"+(tariff[0].equalsIgnoreCase("undefined") || tariff[0].equalsIgnoreCase("") || tariff[0].trim().equalsIgnoreCase("NaN")|| tariff[0].isEmpty()?0:tariff[0].trim())+"',"
		       + "'"+(tariff[1].trim().equalsIgnoreCase("undefined")  || tariff[1].trim().equalsIgnoreCase("") || tariff[1].trim().equalsIgnoreCase("NaN")|| tariff[1].isEmpty()?0:tariff[1].trim())+"',"
		       + "'"+(tariff[2].trim().equalsIgnoreCase("undefined") || tariff[2].trim().equalsIgnoreCase("") || tariff[2].trim().equalsIgnoreCase("NaN")|| tariff[2].isEmpty()?0:tariff[2].trim())+"',"
		       + "'"+(tariff[3].trim().equalsIgnoreCase("undefined") || tariff[3].trim().equalsIgnoreCase("") || tariff[3].trim().equalsIgnoreCase("NaN")|| tariff[3].isEmpty()?0:tariff[3].trim())+"',"
		       + "'"+(tariff[4].trim().equalsIgnoreCase("undefined") || tariff[4].trim().equalsIgnoreCase("")|| tariff[4].trim().equalsIgnoreCase("NaN") || tariff[4].isEmpty()?0:tariff[4].trim())+"',"
		       + "'"+(tariff[5].trim().equalsIgnoreCase("undefined") || tariff[5].trim().equalsIgnoreCase("") || tariff[5].trim().equalsIgnoreCase("NaN")|| tariff[5].isEmpty()?0:tariff[5].trim())+"',"
		       + "'"+(tariff[6].trim().equalsIgnoreCase("undefined") || tariff[6].trim().equalsIgnoreCase("") || tariff[6].trim().equalsIgnoreCase("NaN")|| tariff[6].isEmpty()?0:tariff[6].trim())+"',"
		       + "'"+(tariff[7].trim().equalsIgnoreCase("undefined") || tariff[7].trim().equalsIgnoreCase("") || tariff[7].trim().equalsIgnoreCase("NaN")|| tariff[7].isEmpty()?0:tariff[7].trim())+"',"
		       + "'"+(tariff[8].trim().equalsIgnoreCase("undefined") || tariff[8].trim().equalsIgnoreCase("") || tariff[8].trim().equalsIgnoreCase("NaN")|| tariff[8].isEmpty()?0:tariff[8].trim())+"',"
		       + "'"+(tariff[9].trim().equalsIgnoreCase("undefined") || tariff[9].trim().equalsIgnoreCase("") || tariff[9].trim().equalsIgnoreCase("NaN")|| tariff[9].isEmpty()?0:tariff[9].trim())+"',"
		       + "'"+(tariff[10].trim().equalsIgnoreCase("undefined") || tariff[10].trim().equalsIgnoreCase("")|| tariff[10].trim().equalsIgnoreCase("NaN")|| tariff[10].isEmpty()?0:tariff[10].trim())+"',"
		       + "'"+(tariff[11].trim().equalsIgnoreCase("undefined") || tariff[11].trim().equalsIgnoreCase("")|| tariff[11].trim().equalsIgnoreCase("NaN")|| tariff[11].isEmpty()?0:tariff[11].trim())+"',"
		       + "'"+(tariff[12].trim().equalsIgnoreCase("undefined") || tariff[12].trim().equalsIgnoreCase("")|| tariff[12].trim().equalsIgnoreCase("NaN")|| tariff[12].isEmpty()?0:tariff[12].trim())+"',"
		       /* + "'"+(tariff[13].trim().equalsIgnoreCase("undefined") || tariff[13].trim().equalsIgnoreCase("")|| tariff[13].trim().equalsIgnoreCase("NaN")|| tariff[13].isEmpty()?0:tariff[13].trim())+"',"*/
		       +"'"+session.getAttribute("BRANCHID").toString()+"','"+nonpooldoc+"')";
//		   System.out.println("Tarif Sql:"+sql);
		     int tarifval = stmttarif.executeUpdate (sql);
		     if(tarifval<=0){
		    	 stmtnonpool.close();
		    	 stmttarif.close();
		    	 conn.close();
		    	 return 0;
		     }
		     if(tarifval>0){
		    	 
		    	 
		    	 Statement stmtlterm=conn.createStatement();
		    	 for(int i=0;i< termclosearray.size() ;i++){
					  String[] termclose=((String) termclosearray.get(i)).split(":");
					
					   String strtermclose="";
					   strtermclose="INSERT INTO gl_ntermcl(rdocno,mnthfrm,mnthto,amt) values('"+nonpooldoc+"',"
					  +"'"+(termclose[0].equalsIgnoreCase("undefined")||termclose[0]==null || termclose[0].equalsIgnoreCase("") || termclose[0].trim().equalsIgnoreCase("NaN")|| termclose[0].isEmpty()?0:termclose[0].trim())+"',"
					  + "'"+(termclose[1].trim().equalsIgnoreCase("undefined")||termclose[1]==null  || termclose[1].trim().equalsIgnoreCase("") || termclose[1].trim().equalsIgnoreCase("NaN")|| termclose[1].isEmpty()?0:termclose[1].trim())+"',"
					  +"'"+(termclose[2].equalsIgnoreCase("undefined")||termclose[2]==null || termclose[2].equalsIgnoreCase("") || termclose[2].trim().equalsIgnoreCase("NaN")|| termclose[2].isEmpty()?0:termclose[2].trim())+"')";
					//  System.out.println("==tclsql===+"+tclsql);
//					  System.out.println("Term:"+strtermclose);
					   int termcloseval= stmtlterm.executeUpdate (strtermclose);
					  
					  if(termcloseval<=0)
					     {
						  conn.close();
					    	 return 0; 
					     }
					  }
//		    	 System.out.println("Before Commit");
		    	 conn.commit();
					stmtnonpool.close();
					conn.close();
//					System.out.println("Return Value:"+nonpooldoc);
					return nonpooldoc;
		     }
		   
			else{
				stmtnonpool.close();
				conn.close();
				return 0;
			}
		}
			else{
				stmtnonpool.close();
				conn.close();
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

	public boolean close(int docno, Date sqlclosedate, String closetime,
			String closekm, String cmbclosefuel, String totalkm, String avgkm,
			String hidcheckout, String mode, HttpSession session,
			String fleetno,String formdetailcode,String amttotal,String vendoracno,String vendor,int voucherno) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			conn.setAutoCommit(false);
			
			CallableStatement stmtnonpool = conn.prepareCall("{CALL nonPoolCreateDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");

//			System.out.println("Inside DAO");
			
				int nonpooldoc=0;
				stmtnonpool.setInt(24,docno);
				stmtnonpool.setInt(30,voucherno);
				stmtnonpool.setInt(1,Integer.parseInt(fleetno));
				stmtnonpool.setInt(2,Integer.parseInt(session.getAttribute("BRANCHID").toString()));
				stmtnonpool.setDate(3, null);
				stmtnonpool.setInt(4,0);
				stmtnonpool.setInt(5,0);
				stmtnonpool.setString(6, null);
				
				stmtnonpool.setDate(7,sqlclosedate);
				stmtnonpool.setString(8, closetime);
				stmtnonpool.setString(9,closekm);
				stmtnonpool.setString(10, cmbclosefuel);
				stmtnonpool.setDate(11, null);
				stmtnonpool.setString(12, null);
				stmtnonpool.setString(13, hidcheckout);
				stmtnonpool.setDouble(14, 1);
				stmtnonpool.setDate(15, null);
				stmtnonpool.setString(16, null);
				stmtnonpool.setString(17, null);
				stmtnonpool.setString(18, null);
				stmtnonpool.setString(19, null);
				stmtnonpool.setDate(20, sqlclosedate);
				stmtnonpool.setString(21, session.getAttribute("BRANCHID").toString());
				stmtnonpool.setString(22,session.getAttribute("USERID").toString());
				stmtnonpool.setString(23, session.getAttribute("BRANCHID").toString());
				//OUT param
				stmtnonpool.setString(25,mode);
				stmtnonpool.setString(26, formdetailcode);
				stmtnonpool.setString(27, totalkm);
				stmtnonpool.setString(28, avgkm);
				stmtnonpool.setString(29, null);
				int val = stmtnonpool.executeUpdate();
				if (val>0) {
//					System.out.println("Success");
					conn.commit();
					stmtnonpool.close();
						conn.close();
						return true;
						
				}
				else{
					stmtnonpool.close();
					
					conn.close();
					return false;
				}
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
		conn.close();	
		}
				
		return false;
	}

	
	
	

	public boolean rateupdate(int docno, Date sqlclosedate ,String mode, HttpSession session,
			String fleetno, ArrayList<String> nonpoolratearray,
			String formdetailcode, String vendoracno,
			String vendor) throws SQLException {
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmtinvoice = conn.createStatement();
			int testcurid=0;
			double testcurrate=0.0;
			ResultSet rscurr=stmtinvoice.executeQuery("select c_rate,doc_no from my_curr where doc_no='"+session.getAttribute("CURRENCYID").toString()+"'");
			if(rscurr.next()){
				testcurid=rscurr.getInt("doc_no");
				testcurrate=rscurr.getDouble("c_rate");
			}
			else{
//				System.out.println("Currency Error");
				conn.close();
				return false;
			}
			int testtrno=0;
			ResultSet rstrno=stmtinvoice.executeQuery("select (max(trno)+1)  testtrno from my_trno"); 
			if(rstrno.next()){
				testtrno=rstrno.getInt("testtrno");
			}
			if(testtrno==0){
				testtrno=1;
			}
			Statement stmttrno=conn.createStatement();
			
			String strtemp="insert into my_trno(trno,userno,trtype,brhid,edate)values("+testtrno+",'"+session.getAttribute("USERID").toString()+"',"+
					"'"+formdetailcode+"','"+session.getAttribute("BRANCHID").toString()+"',now())";
//			System.out.println(strtemp);
			int temptrval=stmttrno.executeUpdate(strtemp);
			if(temptrval<=0){
				conn.close();
				return false;
			}
			//In case of deletion
			/*String strdelete="delete from gl_nonpoolrates where rdocno="+docno;
			Statement stmtdelete=conn.createStatement();
			int deleteval=stmtdelete.executeUpdate(strdelete);
			if(deleteval<0){
				stmtdelete.close();
				conn.close();
				return false;
			}
			stmtdelete.close();*/
			for(int i=0;i<nonpoolratearray.size();i++){
				
				String [] nonpool=nonpoolratearray.get(i).split("::");
				//Insertion Corresponding to Vendor Account;
				if(Double.parseDouble(nonpool[3].equalsIgnoreCase("undefined")?"0":nonpool[3])>0){
				Statement stmtdetail=conn.createStatement();
				String strdetail="insert into gl_nonpoolrates(rdocno,idno,qty,amount)values("+docno+","+nonpool[0]+",'"+nonpool[2]+"',"+nonpool[3]+")";
//				System.out.println("Rate Query:"+strdetail);
				int detailval=stmtdetail.executeUpdate(strdetail);
				if(detailval<=0){
					conn.close();
					return false;
				}
					Statement stmtjvvendor=conn.createStatement();
				double vendordramount=Double.parseDouble(nonpool[3])*-1;
				double vendorldramount=vendordramount*testcurrate;
				String strjvvendor="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,dtype,ldramount,"+
						"doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status,costtype,costcode)values("+testtrno+","+vendoracno+","+vendordramount+","+testcurrate+""+
						","+testcurid+",0,-1,"+(i+1)+","+session.getAttribute("BRANCHID").toString()+",'Non Pool Agreement for "+docno+"',0,'"+sqlclosedate+"','"+formdetailcode+"',"+vendorldramount+""+
						","+docno+",'"+nonpool[2]+"',"+testcurid+",'5',1,"+vendor+",3,6,"+fleetno+")";
				int jvval=stmtjvvendor.executeUpdate(strjvvendor);
				if(jvval<=0){
					conn.close();
					return false;
				}
				
				Statement stmtjvcompany=conn.createStatement();
				double companydramount=Double.parseDouble(nonpool[3]);
				double companyldramount=vendordramount*testcurrate;
				String strjvcompany="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,dtype,ldramount,"+
						"doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status,costtype,costcode)values("+testtrno+","+nonpool[1]+","+companydramount+","+testcurrate+""+
						","+testcurid+",0,1,"+(i+1)+","+session.getAttribute("BRANCHID").toString()+",'Non Pool Agreement for "+docno+"',0,'"+sqlclosedate+"','"+formdetailcode+"',"+companyldramount+""+
						","+docno+",'"+nonpool[2]+"',"+testcurid+",'5',1,"+vendor+",3,6,"+fleetno+")";
				int jvval2=stmtjvcompany.executeUpdate(strjvcompany);
				if(jvval2<=0){
					conn.close();
					return false;
				
				
				
				}
				stmtjvvendor.close();
				stmtjvcompany.close();
				}
			
			
		}
			Statement stmtcheck=conn.createStatement();
		String strcheckjv="select sum(dramount) drsum from my_jvtran where tr_no="+testtrno;
		ResultSet rscheckjv=stmtcheck.executeQuery(strcheckjv);
		double jvsum=0;
		while(rscheckjv.next()){
			jvsum=rscheckjv.getDouble("drsum");
		}
		if(jvsum==0.0){
			conn.commit();
			
			stmtcheck.close();
			stmtinvoice.close();
			stmttrno.close();
			conn.close();
			return true;
		}
		else{
			
			stmtcheck.close();
			stmtinvoice.close();
			stmttrno.close();
			conn.close();
			return false;
			
		}
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		
		// TODO Auto-generated method stub
		return false;
	}

	
	
	
	
	public   ClsNonPoolCreateBean getViewDetails(int docno) throws SQLException {
		// TODO Auto-generated method stub
		
		ClsNonPoolCreateBean bean=new ClsNonPoolCreateBean();
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmtview=conn.createStatement();
			String strview="select non.doc_no,non.voc_no,non.branch,non.location,non.edate,non.clstatus, non.acc_no,non.period,non.period_type,non.fleet_no,non.dout,non.tout,round(non.kmout,2) kmout,"+
					" non.fout,non.date_due,non.time_due,non.check_out,non.din,non.tin,non.fin,non.kmin,non.check_in,round(non.km_tot,2) km_tot,"+
					" round(non.avgkm,2) avgkm,non.inuser,non.outuser,veh.flname,veh.reg_no,grp.gname,clr.color,ac.cldocno,ac.refname,ac.address,ac.per_mob,ac.mail1,"+
					" chkin.sal_name checkinname,chkout.sal_name checkoutname,inuser.user_name inusername,outuser.user_name outusername"+
					" from gl_nonpoolveh non left join gl_vehmaster veh on non.fleet_no=veh.fleet_no left join my_acbook ac on"+
					" (non.acc_no=ac.acno and ac.dtype='VND') left join gl_vehgroup grp on veh.vgrpid=grp.doc_no left join my_color clr on"+
					" veh.clrid=clr.doc_no left join my_salesman chkout on (non.check_out=chkout.doc_no and chkout.sal_type='CHK') left join"+
					" my_salesman chkin on (non.check_in=chkin.doc_no and chkin.sal_type='CHK') left join my_user inuser  on non.inuser=inuser.doc_no"+
					" left join my_user outuser on non.outuser=outuser.doc_no where non.doc_no="+docno;
			ResultSet resultSet=stmtview.executeQuery(strview);
			while(resultSet.next()){
				bean.setDocno(Integer.parseInt(resultSet.getString("doc_no")));
				bean.setVoucherno(resultSet.getInt("voc_no"));
				bean.setDate(resultSet.getDate("edate").toString());
				bean.setVendoracno(resultSet.getString("acc_no"));
				bean.setHidcmbperiodno(resultSet.getString("period"));
				bean.setHidcmbperiodtype(resultSet.getString("period_type"));
				bean.setFleetno(resultSet.getString("fleet_no"));
				bean.setClosedate(resultSet.getString("dout"));
				bean.setHidclosetime(resultSet.getString("tout"));
				bean.setClosekm(resultSet.getString("kmout"));
				bean.setHidcmbclosefuel(resultSet.getString("fout"));
				bean.setClstatus(resultSet.getString("clstatus"));
				bean.setDatedue(resultSet.getDate("date_due").toString());
				bean.setHidtimedue(resultSet.getString("time_due"));
				bean.setHidcheckout(resultSet.getString("check_out"));
				bean.setDatein(resultSet.getString("din").toString());
				bean.setHidtimein(resultSet.getString("tin"));
				bean.setHidcmbinfuel(resultSet.getString("fin"));
				bean.setInkm(resultSet.getString("kmin"));
				bean.setHidcheckin(resultSet.getString("check_in"));
				bean.setTotalkm(resultSet.getString("km_tot"));
				bean.setAvgkm(resultSet.getString("avgkm"));
				bean.setHidinuser(resultSet.getString("inuser"));
				bean.setHidcloseuser(resultSet.getString("outuser"));
				bean.setFleetname(resultSet.getString("flname")+",Reg No: "+resultSet.getString("reg_no")+",Group: "+resultSet.getString("gname")+",Color: "+resultSet.getString("color"));
				bean.setVendor(resultSet.getString("cldocno"));
				bean.setVendorname(resultSet.getString("refname")+",Address: "+resultSet.getString("address")+",Mobile: "+resultSet.getString("per_mob")+",Mail: "+resultSet.getString("mail1"));
				bean.setCheckin(resultSet.getString("checkinname"));
				bean.setCheckout(resultSet.getString("checkoutname"));
				bean.setInuser(resultSet.getString("inusername"));bean.setCloseuser(resultSet.getString("outusername"));
				bean.setHidcmbbranch(resultSet.getString("branch"));
				bean.setHidcmblocation(resultSet.getString("location"));
				
			}
			Statement stmtview2=conn.createStatement();
			
			ResultSet rsterm=stmtview2.executeQuery("select rdocno,if(mnthfrm=0,' ',mnthfrm) mnthfrm,if(mnthto=0,' ',mnthto) mnthto,if(amt=0,' ',round(amt,2)) amt from gl_ntermcl where rdocno="+docno+"");
			int i=0;
			while(rsterm.next())
			{	
				
				
				if(i==0)
				{
				bean.setM1(rsterm.getString("mnthfrm"));
				bean.setM2(rsterm.getString("mnthto"));
				bean.setAmt1(rsterm.getString("amt"));
				}
				if(i==1)
				{
				bean.setM3(rsterm.getString("mnthfrm"));
				bean.setM4(rsterm.getString("mnthto"));
				bean.setAmt2(rsterm.getString("amt"));
				}
				if(i==2)
				{
				bean.setM5(rsterm.getString("mnthfrm"));
				bean.setM6(rsterm.getString("mnthto"));
				bean.setAmt3(rsterm.getString("amt"));
				}
				if(i==3)
				{
				bean.setM7(rsterm.getString("mnthfrm"));
				bean.setM8(rsterm.getString("mnthto"));
				bean.setAmt4(rsterm.getString("amt"));
				}
				if(i==4)
				{
				bean.setM9(rsterm.getString("mnthfrm"));
				bean.setM10(rsterm.getString("mnthto"));
				bean.setAmt5(rsterm.getString("amt"));
				}
			//	System.out.println("tercllist========"+i);
				
				i++;
				
			}
			stmtview.close();
			stmtview2.close();
			conn.close();
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
	
	
	
	 public   JSONArray ratereload(String docno) throws SQLException {

	    	JSONArray RESULTDATA=new JSONArray();
		  
	        Connection conn=null;
			try {
					  conn = objconn.getMyConnection();
					Statement stmtrate = conn.createStatement ();
	            	
					String  tarifsql=("select rdocno,rate,cdw,pai,cdw1,pai1,gps,babyseater,cooler,kmrest,exkmrte,chaufchg,chaufexchg from gl_ntarif where rdocno='"+docno+"' order by rstatus");
					//System.out.println("------------------------------"+tarifsql);
					
					ResultSet resultSet = stmtrate.executeQuery (tarifsql);
					RESULTDATA=objcommon.convertToJSON(resultSet);
					stmtrate.close();
					conn.close();
			}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
			finally{
				conn.close();
			}
			//System.out.println(RESULTDATA);
	        return RESULTDATA;
	    }
	 
	 public   JSONArray getNonPoolAmounts(String docno,String closestatus) throws SQLException {

	    	JSONArray RESULTDATA=new JSONArray();
		  
	        Connection conn=null;
			try {
					  conn = objconn.getMyConnection();
					Statement stmtrate = conn.createStatement ();
	            	if(closestatus.equalsIgnoreCase("1")){
	            		
	            	
					String  ratesql=("select rate.idno,invmode.acno,invmode.description,rate.qty,rate.amount from gl_nonpoolrates rate left join"+
							" gl_invmode invmode on (rate.idno=invmode.idno) where rate.rdocno='"+docno+"' order by rate.srno");
					//System.out.println("------------------------------"+tarifsql);
					
					ResultSet resultSet = stmtrate.executeQuery (ratesql);
					RESULTDATA=objcommon.convertToJSON(resultSet);
					stmtrate.close();
					conn.close();
	            	}
	            	else{
	            		stmtrate.close();
						conn.close();
	            	}
			}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
			finally{
				conn.close();
			}
			//System.out.println(RESULTDATA);
	        return RESULTDATA;
	    }
}
