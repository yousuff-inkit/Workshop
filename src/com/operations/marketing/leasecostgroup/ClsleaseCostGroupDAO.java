package com.operations.marketing.leasecostgroup;

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

public class ClsleaseCostGroupDAO {
	Connection conn=null;
	
	ClsConnection connDAO=new ClsConnection();
	
	ClsCommon commDAO=new ClsCommon();
	public int Insert(Date mastedate, int groupid, int brandid,
			int modelid, String mode, String desc, HttpSession session,
			HttpServletRequest request, String formdetailcode) throws SQLException {

int docno;

try{
		conn=connDAO.getMyConnection();
		CallableStatement cstmtlcg = conn.prepareCall("{call leasecostGroupDML(?,?,?,?,?,?,?,?,?,?)}");
		cstmtlcg.registerOutParameter(10, java.sql.Types.INTEGER);
		cstmtlcg.setDate(1,mastedate);
		cstmtlcg.setInt(2,groupid);
	    cstmtlcg.setInt(3,brandid);
	    cstmtlcg.setInt(4,modelid);
		cstmtlcg.setString(5,desc);
		cstmtlcg.setString(6,session.getAttribute("USERID").toString());
		cstmtlcg.setString(7,session.getAttribute("BRANCHID").toString());
		cstmtlcg.setString(8,formdetailcode);
		cstmtlcg.setString(9,mode);
		cstmtlcg.executeQuery();
		docno=cstmtlcg.getInt("docNo");

	 
		if(docno<=0)
		{

			 conn.close();
			return 0;
		}	
		
		if (docno > 0) {
		 
			cstmtlcg.close();
			conn.close();
			return docno;
		}
		
		
}catch(Exception e){
    e.printStackTrace();
	
		conn.close();	
	}	
	 
		
		return 0;
	}
	public int update(int docno, Date mastedate, int groupid, int brandid,
			int modelid, String mode, String desc, HttpSession session,
			HttpServletRequest request, String formdetailcode) throws SQLException {
		 
		 
		try{
			conn=connDAO.getMyConnection();
			CallableStatement cstmtlcg = conn.prepareCall("{call leasecostGroupDML(?,?,?,?,?,?,?,?,?,?)}");
			cstmtlcg.setInt(10, docno);
			cstmtlcg.setDate(1,mastedate);
			cstmtlcg.setInt(2,groupid);
		    cstmtlcg.setInt(3,brandid);
		    cstmtlcg.setInt(4,modelid);
			cstmtlcg.setString(5,desc);
			cstmtlcg.setString(6,session.getAttribute("USERID").toString());
			cstmtlcg.setString(7,session.getAttribute("BRANCHID").toString());
			cstmtlcg.setString(8,formdetailcode);
			cstmtlcg.setString(9,mode);
			int res=cstmtlcg.executeUpdate();
			docno=cstmtlcg.getInt("docNo");

		 
			if(res<=0)
			{

				 conn.close();
				return 0;
			}	
			
			if (docno > 0) {
				cstmtlcg.close();
				conn.close();
				return docno;
			}
			
			
	}catch(Exception e){
	    e.printStackTrace();
		
			conn.close();	
		}	
		 
			
			return 0;
		}
	public int delete(int docno, String mode, HttpSession session,
			HttpServletRequest request, String formdetailcode) throws SQLException {

		try{
			conn=connDAO.getMyConnection();
			CallableStatement cstmtlcg = conn.prepareCall("{call leasecostGroupDML(?,?,?,?,?,?,?,?,?,?)}");
			cstmtlcg.setInt(10, docno);
			cstmtlcg.setDate(1,null);
			cstmtlcg.setInt(2,0);
		    cstmtlcg.setInt(3,0);
		    cstmtlcg.setInt(4,0);
			cstmtlcg.setString(5,null);
			cstmtlcg.setString(6,session.getAttribute("USERID").toString());
			cstmtlcg.setString(7,session.getAttribute("BRANCHID").toString());
			cstmtlcg.setString(8,formdetailcode);
			cstmtlcg.setString(9,mode);
			int res=cstmtlcg.executeUpdate();
			docno=cstmtlcg.getInt("docNo");

		 
			if(res<=0)
			{

				 conn.close();
				return 0;
			}	
			
			if (docno > 0) {
				cstmtlcg.close();
				conn.close();
				return docno;
			}
			
			
	}catch(Exception e){
	    e.printStackTrace();
		
			conn.close();	
		}	
		 
			
			return 0;
		}
	 
	public   JSONArray searchBrand() throws SQLException {

	    JSONArray RESULTDATA=new JSONArray();
	    
	    Connection conn = null;
		try {
				 conn = connDAO.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
	        	
				ResultSet resultSet = stmtVeh.executeQuery ("select brand,brand_name,doc_no from gl_vehbrand where status<>7;");

				RESULTDATA=commDAO.convertToJSON(resultSet);
				stmtVeh.close();
				conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
	    return RESULTDATA;
	}

public   JSONArray searchModel(String brandval) throws SQLException {

    JSONArray RESULTDATA=new JSONArray();
    
    Connection conn = null;
	try {
			 conn = connDAO.getMyConnection();
			Statement stmtVeh3 = conn.createStatement ();
        	
		/*	String modelsql= ("select vtype,doc_no from gl_vehmodel where brandid='"+brandval+"' and status<>7;");
			*/
			String modelsql= ("select mo.vtype,mo.doc_no,m.modid from  gl_vehmodel mo left join  gl_lcgm m on m.modid=mo.doc_no and m.status=3 "
					+ " where brandid='"+brandval+"' and mo.status=3 and m.modid is null");
			
			ResultSet resultSet = stmtVeh3.executeQuery(modelsql)  ;
			RESULTDATA=commDAO.convertToJSON(resultSet);
			stmtVeh3.close();
			conn.close();

	}
	catch(Exception e){
		e.printStackTrace();
		conn.close();
	}
	//System.out.println(RESULTDATA);
    return RESULTDATA;
}
public   JSONArray searchMaster(String gpname,String docno) throws SQLException {


  	 JSONArray RESULTDATA=new JSONArray();
 /* 	    Enumeration<String> Enumeration = session.getAttributeNames();
  	    int a=0;
  	    while(Enumeration.hasMoreElements()){
  	     if(Enumeration.nextElement().equalsIgnoreCase("BRANCHID")){
  	      a=1;
  	     }
  	    }
  	    if(a==0){
  	  return RESULTDATA;
  	     }
  	        */
   	 //  System.out.println("8888888888"+clnames); 	
  	// String brid=session.getAttribute("BRANCHID").toString();
   	
   	 
   	
   	String sqltest="";
   	if(!(docno.equalsIgnoreCase(""))){
   		sqltest=sqltest+" and g.doc_no like '%"+docno+"%'";
   	}
   	if(!(gpname.equalsIgnoreCase(""))){
   		sqltest=sqltest+" and g.gname like '%"+gpname+"%'";
   	}
   	 
   	
  
   	
   	 	    	
   	 Connection conn = null;

		try {
				 conn = connDAO.getMyConnection();
				Statement stmt1 = conn.createStatement ();
           	
				String clssql= ("select m.doc_no, m.date ,trim(g.gname) gpname, m.grpid, m.brdid, m.modid,b.brand_name brname,mo.vtype modelname, m.desc1 from gl_lcgm m\r\n" + 
						" left join gl_vehmodel mo on mo.doc_no=m.modid  left join gl_vehgroup g on g.doc_no=m.grpid  \r\n" + 
						" left join gl_vehbrand b on b.doc_no=m.brdid where m.status=3   " +sqltest);
				System.out.println("========"+clssql);
				ResultSet resultSet = stmt1.executeQuery(clssql);
				
				RESULTDATA=commDAO.convertToJSON(resultSet);
				stmt1.close();
				conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
       return RESULTDATA;
   }
public   JSONArray searchMaster() throws SQLException {


 
 
	 JSONArray RESULTDATA=new JSONArray();
  	 	    	
  	 Connection conn = null;

		try {
				 conn = connDAO.getMyConnection();
				Statement stmt1 = conn.createStatement ();
          	
				String clssql= ("select m.doc_no, m.date, trim(g.gname) gpname,m.grpid, m.brdid, m.modid,b.brand_name brname,mo.vtype modelname, m.desc1 from gl_lcgm m\r\n" + 
						" left join gl_vehmodel mo on mo.doc_no=m.modid left  join gl_vehgroup g on g.doc_no=m.grpid \r\n" + 
						" left join gl_vehbrand b on b.doc_no=m.brdid where m.status=3");
				//System.out.println("========"+clssql);
				ResultSet resultSet = stmt1.executeQuery(clssql);
				
				RESULTDATA=commDAO.convertToJSON(resultSet);
				stmt1.close();
				conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
      return RESULTDATA;
  }
public   JSONArray searchGroup() throws SQLException {

    JSONArray RESULTDATA=new JSONArray();
    Connection conn = null;
   
	try {
			 conn = connDAO.getMyConnection();
			Statement stmtVehclr = conn.createStatement ();
        	
			String sql= ("Select  trim(gname) gname,doc_no from  gl_vehgroup   where status=3;");
			//System.out.println("-------------"+sql);
			ResultSet resultSet = stmtVehclr.executeQuery(sql);

			RESULTDATA=commDAO.convertToJSON(resultSet);
			stmtVehclr.close();
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
