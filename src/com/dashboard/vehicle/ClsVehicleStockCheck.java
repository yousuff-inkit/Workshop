package com.dashboard.vehicle;

 import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsVehicleStockCheck  { 
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	
	public  JSONArray vehStockCheckGridLoading() throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtRefundable = conn.createStatement();
				String sql = "";
				
				sql = "select m.fleet_no,m.flname,m.brhid,m.tran_code,concat(coalesce(m.REG_NO,''),' - ',coalesce(p.code_name,'')) as regno,y.yom,l.loc_name,g.gname,s.st_desc status,"
					 + "br.branchname,convert(concat(' Fleet : ',coalesce(m.fleet_no),' * ','Fleet Name : ' ,coalesce(m.flname),' * ','Reg No : ' ,coalesce(m.reg_no),'  ',"
					 + "coalesce(p.code_name),' * ','YOM  : ',coalesce(y.yom),' * ','Location : ', coalesce(l.loc_name),' * ','Status : ', coalesce(s.st_desc)),char(1000)) vehinfo from gl_vehmaster m left join "
					 + "my_locm l on l.doc_no=m.A_LOC left join gl_vehgroup g on g.doc_no=m.VGRPID left join gl_vehplate p on m.pltid=p.doc_no left join gl_status s on m.tran_code=s.status "
					 + "left join my_brch br on br.doc_no=m.a_br  left join gl_yom y on y.doc_no=m.yom where m.tran_code IN('RR','UR')";
				
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
	
	public  JSONArray vehStockCheckGridReloading(String docno) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtRefundable = conn.createStatement();
				String sql = "";
				
				sql = "select m.fleet_no,m.flname,m.brhid,m.tran_code,concat(coalesce(m.REG_NO,''),' - ',coalesce(p.code_name,'')) as regno,y.yom,l.loc_name,g.gname,s.st_desc status,"
					 + "br.branchname,convert(concat(' Fleet : ',coalesce(m.fleet_no),' * ','Fleet Name : ' ,coalesce(m.flname),' * ','Reg No : ' ,coalesce(m.reg_no),'  ',"
					 + "coalesce(p.code_name),' * ','YOM  : ',coalesce(y.yom),' * ','Location : ', coalesce(l.loc_name),' * ','Status : ', coalesce(s.st_desc)),char(1000)) vehinfo from gl_vehmaster m left join "
					 + "my_locm l on l.doc_no=m.A_LOC left join gl_vehgroup g on g.doc_no=m.VGRPID left join gl_vehplate p on m.pltid=p.doc_no left join gl_status s on m.tran_code=s.status "
					 + "left join my_brch br on br.doc_no=m.a_br  left join gl_yom y on y.doc_no=m.yom where m.tran_code IN('RR','UR')";
				
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
	
}
