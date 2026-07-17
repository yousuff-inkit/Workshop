package com.operations.saleofvehicle.vehiclestockcheck;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsVehicleStockCheckDAO {

	ClsVehicleStockCheckBean vehicleStockCheckBean = new ClsVehicleStockCheckBean();
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	
	  public int insert(Date stockCheckDate, String formdetailcode, int txtreadytorent, int txtunrentable, int txttotal, String txtremarks,ArrayList<String> stockcheckarray, HttpSession session,String mode) throws SQLException {
		  	
		  	Connection conn = null;
		try{
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			
			String branch=session.getAttribute("BRANCHID").toString().trim();
			String userid=session.getAttribute("USERID").toString().trim();
			
			CallableStatement stmtVSTC = conn.prepareCall("{CALL vehStockCheckmDML(?,?,?,?,?,?,?,?,?,?)}");
			
			stmtVSTC.registerOutParameter(9, java.sql.Types.INTEGER);
			
			stmtVSTC.setDate(1,stockCheckDate);
			stmtVSTC.setInt(2,txtreadytorent);
			stmtVSTC.setInt(3,txtunrentable);
			stmtVSTC.setInt(4,txttotal);
			stmtVSTC.setString(5,txtremarks);
			stmtVSTC.setString(6,formdetailcode);
			stmtVSTC.setString(7,branch);
			stmtVSTC.setString(8,userid);
			stmtVSTC.setString(10,mode);
			int datas=stmtVSTC.executeUpdate();
			if(datas<=0){
				stmtVSTC.close();
				conn.close();
				return 0;
			}
			int docno=stmtVSTC.getInt("docNo");
			vehicleStockCheckBean.setTxtvehstockcheckdocno(docno);
			if (docno > 0) {
				/*Insertion to gl_vehstockd*/
				int insertData=insertion(conn, docno, formdetailcode, stockCheckDate,stockcheckarray, session, mode);
				if(insertData<=0){
					stmtVSTC.close();
					conn.close();
					return 0;
				}
				/*Insertion to gl_vehstockd Ends*/
				
				 if(insertData>0){
					conn.commit();
					stmtVSTC.close();
					conn.close();
					return docno;
				 }
			}
			
			stmtVSTC.close();
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
			
	
	public boolean edit(int txtvehstockcheckdocno, String formdetailcode, Date stockCheckDate, int txtreadytorent, int txtunrentable, int txttotal, String txtremarks, ArrayList<String> stockcheckarray, HttpSession session,String mode) throws SQLException {
		 	Connection conn = null;
		 	
		 try{
			    conn=ClsConnection.getMyConnection();
				conn.setAutoCommit(false);
			    
				String branch=session.getAttribute("BRANCHID").toString().trim();
				String userid=session.getAttribute("USERID").toString().trim();
				
				/*Updating gl_vehstockm*/
				CallableStatement stmtVSTC = conn.prepareCall("{CALL vehStockCheckmDML(?,?,?,?,?,?,?,?,?,?)}");
				
				stmtVSTC.setInt(9, txtvehstockcheckdocno);
				
				stmtVSTC.setDate(1,stockCheckDate);
				stmtVSTC.setInt(2,txtreadytorent);
				stmtVSTC.setInt(3,txtunrentable);
				stmtVSTC.setInt(4,txttotal);
				stmtVSTC.setString(5,txtremarks);
				stmtVSTC.setString(6,formdetailcode);
				stmtVSTC.setString(7,branch);
				stmtVSTC.setString(8,userid);
				stmtVSTC.setString(10,mode);
				int datas=stmtVSTC.executeUpdate();
				if(datas<=0){
					stmtVSTC.close();
					conn.close();
					return false;
				}
				/*Updating gl_vehstockm Ends*/
				
			    String sql3=("DELETE FROM gl_vehstockd WHERE rdocno="+txtvehstockcheckdocno+"");
			    int data3 = stmtVSTC.executeUpdate(sql3);
			    
			    int docno=txtvehstockcheckdocno;
			    vehicleStockCheckBean.setTxtvehstockcheckdocno(docno);
				if (docno > 0) {
				
					/*Insertion to gl_vehstockd*/
					int insertData=insertion(conn, docno, formdetailcode, stockCheckDate,stockcheckarray, session, mode);
					if(insertData<=0){
						stmtVSTC.close();
						conn.close();
						return false;
					}
					/*Insertion to gl_vehstockd Ends*/
					
					if(insertData>0){
						conn.commit();
						stmtVSTC.close();
						conn.close();
						return true;
					 }
				}
				stmtVSTC.close();
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

	public boolean delete(int txtvehstockcheckdocno, String formdetailcode,HttpSession session) throws SQLException {
		 
		Connection conn = null; 
		
		try{
				conn=ClsConnection.getMyConnection();
				conn.setAutoCommit(false);
				Statement stmtVSTC = conn.createStatement();
				
				String branch=session.getAttribute("BRANCHID").toString().trim();
				String userid=session.getAttribute("USERID").toString().trim();
				 
				 /*Status change in gl_vehstockm*/
				 String sql=("update gl_vehstockm set STATUS=7 where doc_no="+txtvehstockcheckdocno+"");
				 int resultSet = stmtVSTC.executeUpdate(sql);
				/*Status change in my_cashbm Ends*/
				 
				 /*Inserting into datalog*/
				 String sqls=("insert into datalog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+txtvehstockcheckdocno+"','"+branch+"','"+formdetailcode+"',now(),'"+userid+"','D')");
				 int resultSets = stmtVSTC.executeUpdate(sqls);
				 /*Inserting into datalog Ends*/
				 
				int docno=txtvehstockcheckdocno;
				vehicleStockCheckBean.setTxtvehstockcheckdocno(docno);
				if (docno > 0) {
					conn.commit();
					stmtVSTC.close();
				    conn.close();
					return true;
				}	
				stmtVSTC.close();
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
	
	public  JSONArray vehStockCheckGridLoading(String branch) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtVSTC = conn.createStatement();
				String sql = "";
				
				sql = "select m.fleet_no,m.flname,m.brhid,m.tran_code,concat(coalesce(m.REG_NO,''),' - ',coalesce(p.code_name,'')) as regno,y.yom,l.loc_name,g.gname,"
					+ "s.st_desc status,br.branchname,(select count(tran_code) from gl_vehmaster where tran_code='RR' and a_br="+branch+") ready,(select count(tran_code) from gl_vehmaster "
					+ "where tran_code='UR' and a_br="+branch+") unrent,(select count(tran_code) from gl_vehmaster where tran_code IN('RR','UR') and a_br="+branch+") total from gl_vehmaster m left join my_locm l "
					+ "on l.doc_no=m.A_LOC left join gl_vehgroup g on g.doc_no=m.VGRPID left join gl_vehplate p on m.pltid=p.doc_no left join gl_status s on m.tran_code=s.status "
					+ "left join my_brch br on br.doc_no=m.a_br left join gl_yom y on y.doc_no=m.yom where m.tran_code IN('RR','UR') and m.a_br="+branch+" ";
				
				//System.out.println("===nodoc=="+sql);
				
				ResultSet resultSet = stmtVSTC.executeQuery(sql);

				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtVSTC.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
	

	
	public  JSONArray excelvehStockCheck(String docno,String brhid) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtVSTC = conn.createStatement();
				
				String sql = "";
				
				sql = "select br.branchname 'Branch Name',l.loc_name 'Location',g.gname 'Group',m.fleet_no 'Fleet',v.flname 'Fleet Name',y.yom 'YOM',concat(coalesce(v.REG_NO,''),' - ',coalesce(p.code_name,'')) as 'Reg No',s.st_desc 'Status',if(m.remarks='0',' ',m.remarks) 'Remarks'"
					+ " from gl_vehstockm mr left join gl_vehstockd m on mr.doc_no=m.rdocno  and m.brhid=mr.brhid left join gl_vehmaster v on m.fleet_no=v.fleet_no left join my_locm l on "
					+ "l.doc_no=v.A_LOC left join gl_vehgroup g on g.doc_no=v.VGRPID left join gl_vehplate p on v.pltid=p.doc_no left join gl_status s on m.status=s.status "
					+ "left join my_brch br on br.doc_no=m.brhid  left join gl_yom y on y.doc_no=v.yom where rdocno="+docno+" and  mr.brhid="+brhid ;
				
					//System.out.println("===nodoc=="+sql);
				
				ResultSet resultSet = stmtVSTC.executeQuery(sql);

				RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
				
				stmtVSTC.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }

	
	
	
	
	public  JSONArray vehStockCheckGridReloading(String docno,String brhid) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtRefundable = conn.createStatement();
				String sql = "";
			//	brhid=brhid.trim()==""?
				sql = "select mr.readytorent ready,mr.unrentable unrent,mr.total,m.fleet_no,m.status tran_code,if(m.remarks='0',' ',m.remarks) remarks,m.brhid,v.flname,concat(coalesce(v.REG_NO,''),' - ',coalesce(p.code_name,'')) as regno,y.yom,"
					+ "l.loc_name,g.gname,s.st_desc status,br.branchname from gl_vehstockm mr left join gl_vehstockd m on mr.doc_no=m.rdocno and m.brhid=mr.brhid left join gl_vehmaster v on m.fleet_no=v.fleet_no left join my_locm l on "
					+ "l.doc_no=v.A_LOC left join gl_vehgroup g on g.doc_no=v.VGRPID left join gl_vehplate p on v.pltid=p.doc_no left join gl_status s on m.status=s.status "
					+ "left join my_brch br on br.doc_no=m.brhid  left join gl_yom y on y.doc_no=v.yom where rdocno="+docno+" and  mr.brhid="+brhid ;
				
//				System.out.println("===doc=="+sql);
				ResultSet resultSet = stmtRefundable.executeQuery(sql);

				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtRefundable.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	public  JSONArray vstcMainSearch(HttpSession session,String username,String docNo,String date) throws SQLException {

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
        
         String branch=session.getAttribute("BRANCHID").toString();
       
        java.sql.Date sqlStockDate=null;
        
        date.trim();
        if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0")))
        {
        	sqlStockDate = ClsCommon.changeStringtoSqlDate(date);
        }

        String sqltest="";
        
        if(!(docNo.equalsIgnoreCase(""))){
            sqltest=sqltest+" and m.doc_no like '%"+docNo+"%'";
        }
        if(!(username.equalsIgnoreCase(""))){
         sqltest=sqltest+" and u.user_name like '%"+username+"%'";
        }
        
        if(!(sqlStockDate==null)){
	         sqltest=sqltest+" and m.date='"+sqlStockDate+"'";
	        } 
           
     try {
	       conn = ClsConnection.getMyConnection();
	       Statement stmtVSTC = conn.createStatement();
	       
	       ResultSet resultSet = stmtVSTC.executeQuery("select m.date,m.doc_no,m.readytorent,m.unrentable,m.total,m.remarks,u.user_name from gl_vehstockm m left join my_user u on m.userid=u.doc_no where m.status<>7 and m.brhid="+branch+" "+sqltest);
	
	       RESULTDATA=ClsCommon.convertToJSON(resultSet);
	       
	       stmtVSTC.close();
	       conn.close();
     }catch(Exception e){
    	 e.printStackTrace();
    	 conn.close();
     }finally{
 		conn.close();
 	}
       return RESULTDATA;
   }
	
	 public int insertion(Connection conn,int docno,String formdetailcode,Date stockCheckDate, ArrayList<String> stockcheckarray, HttpSession session,String mode) throws SQLException{
		
		  try{
				conn.setAutoCommit(false);
				CallableStatement stmtVSTC;
				Statement stmtCPV1 = conn.createStatement();
				
				String branch=session.getAttribute("BRANCHID").toString().trim();
				String userid=session.getAttribute("USERID").toString().trim();
				
				/*Stock Check Grid and Details Saving*/
				for(int i=0;i< stockcheckarray.size();i++){
					String[] stockcheck=stockcheckarray.get(i).split("::");
					if(!stockcheck[0].trim().equalsIgnoreCase("undefined") && !stockcheck[0].trim().equalsIgnoreCase("NaN")){
					
					stmtVSTC = conn.prepareCall("{CALL vehStockCheckdDML(?,?,?,?,?,?,?,?,?)}");
					
					/*Insertion to gl_vehstockd*/
					stmtVSTC.setInt(7,docno);
					stmtVSTC.registerOutParameter(8, java.sql.Types.INTEGER);
					stmtVSTC.setInt(1,(i+1)); //Row NO
					stmtVSTC.setString(2,(stockcheck[0].trim().equalsIgnoreCase("undefined") || stockcheck[0].trim().equalsIgnoreCase("NaN") || stockcheck[0].trim().isEmpty()?0:stockcheck[0].trim()).toString());  //fleet no
					stmtVSTC.setString(3,(stockcheck[1].trim().equalsIgnoreCase("undefined") || stockcheck[1].trim().equalsIgnoreCase("NaN") || stockcheck[1].trim().isEmpty()?0:stockcheck[1].trim()).toString()); //status
					stmtVSTC.setString(4,(stockcheck[2].trim().equalsIgnoreCase("undefined") || stockcheck[2].trim().equalsIgnoreCase("NaN") || stockcheck[2].trim().equals(0) || stockcheck[2].trim().isEmpty()?0:stockcheck[2].trim()).toString()); //remarks 
					
					stmtVSTC.setString(5,branch);
					stmtVSTC.setString(6,userid);
					stmtVSTC.setString(9,mode);
					int detail=stmtVSTC.executeUpdate();
						if(detail<=0){
							stmtVSTC.close();
							conn.close();
							return 0;
						}
						stmtVSTC.close();
      				  }
				    }
				    /*Stock Check Grid and Details Saving Ends*/
				  
	   }catch(Exception e){	
		 	e.printStackTrace();
		 	conn.close();
		 	return 0;
	 }
		return 1;
	}

}
