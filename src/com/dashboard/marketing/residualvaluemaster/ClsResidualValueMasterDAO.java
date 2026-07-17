package com.dashboard.marketing.residualvaluemaster;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import java.sql.*;
import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
public class ClsResidualValueMasterDAO {
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	
	public JSONArray getBrand(String id) throws SQLException{
		JSONArray branddata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return branddata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select doc_no,brand_name from gl_vehbrand where status=3";
			ResultSet rs=stmt.executeQuery(strsql);
			branddata=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return branddata;
	}
	
	public JSONArray getModel(String id,String brand) throws SQLException{
		JSONArray modeldata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return modeldata;
		}
		if(brand.equalsIgnoreCase("")){
			return modeldata;
		}
		
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select doc_no,vtype model from gl_vehmodel where status=3 and brandid="+brand;
			ResultSet rs=stmt.executeQuery(strsql);
			modeldata=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		
		return modeldata;
	}
	
	public JSONArray getYom(String id) throws SQLException{
		JSONArray yomdata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return yomdata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select doc_no,yom from gl_yom";
			ResultSet rs=stmt.executeQuery(strsql);
			yomdata=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return yomdata;
	}
	
	public JSONArray getResidualGridData(String id,String type, String branch,String brand,String model,String yom,String brandid,String modelid,String yomid) throws SQLException{
		System.out.println(id+"::"+type+"::"+branch+"::"+brand+"::"+model+"::"+yom+"::"+brandid+"::"+modelid+"::"+yomid);
		JSONArray griddata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return griddata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="";
			String sqltest="";
			if(!brandid.equalsIgnoreCase("")){
				sqltest+=" and m.brandid="+brandid;
			}
			if(!modelid.equalsIgnoreCase("")){
				sqltest+=" and m.modelid="+modelid;
			}
			if(!yomid.equalsIgnoreCase("")){
				sqltest+=" and m.yomid="+yomid;
			}
			if(type.equalsIgnoreCase("Add")){
				/*strsql="select doc_no residualdocno,"+brandid+" brandid,'"+brand+"' brand,"+modelid+" modelid,'"+model+"' model,"+yomid+" yomid,"+yom+" yom,months,km from gl_residualkm  where status=3";*/
				strsql="select m.brandid,m.modelid,m.yomid,m.residualkmdocno residualdocno,m.months,m.km,brd.brand_name brand,model.vtype model,yom.yom,"+
				" m.residualvalue from gl_residualvaluem m left join gl_vehbrand brd on m.brandid=brd.doc_no left join gl_vehmodel model on"+
				" m.modelid=model.doc_no left join gl_yom yom on m.yomid=yom.doc_no where m.brandid="+brandid+" and m.modelid="+modelid+" and m.yomid="+yomid+""+
				" and m.status=3 union all"+
				" select "+brandid+" brandid,"+modelid+" modelid,"+yomid+" yomid,doc_no residualdocno,months,km,'"+brand+"' brand,'"+model+"' model,"+yom+" yom,"+
				" null residualvalue from gl_residualkm where doc_no not in (select residualkmdocno from gl_residualvaluem m where m.brandid="+brandid+" and "+
				" m.modelid="+modelid+" and m.yomid="+yomid+" and m.status=3) ";
			}
			else if(type.equalsIgnoreCase("View")){
				/*select m.brandid,m.modelid,m.yomid,m.residualkmdocno residualdocno,m.months,m.km,brd.brand_name brand,model.vtype model,yom.yom,
				m.residualvalue from gl_residualvaluem m left join gl_vehbrand brd on m.brandid=brd.doc_no left join gl_vehmodel model on
				m.modelid=model.doc_no left join gl_yom yom on m.yomid=yom.doc_no where m.brandid=2 and m.modelid=4 and m.yomid=3 and m.status=3
				union all
				select  m.brandid,m.modelid,m.yomid,m.residualkmdocno residualdocno,s.months, s.km,brd.brand_name brand,model.vtype model,yom.yom,
				m.residualvalue from gl_residualkm s,
				gl_residualvaluem m left join gl_vehbrand brd on m.brandid=brd.doc_no left join gl_vehmodel model on
				m.modelid=model.doc_no left join gl_yom yom on m.yomid=yom.doc_no where m.brandid=2 and m.modelid=4 and m.yomid=3 and m.status=3
				and (s.doc_no not in (select residualkmdocno from gl_residualvaluem m where
				m.brandid=2 and m.modelid=4 and m.yomid=3 and m.status=3)) group by s.doc_no
				;*/
				strsql="select m.brandid,m.modelid,m.yomid,m.residualkmdocno residualdocno,m.months,m.km,brd.brand_name brand,model.vtype model,yom.yom,"+
						" m.residualvalue from gl_residualvaluem m left join gl_vehbrand brd on m.brandid=brd.doc_no left join gl_vehmodel model on"+
						" m.modelid=model.doc_no left join gl_yom yom on m.yomid=yom.doc_no where m.status=3"+sqltest;
				

			}
			System.out.println(strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			griddata=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return griddata;
	}

	public int insert(HttpSession session, ArrayList<String> masterarray,
			String cmbbranch,java.sql.Date sqldate, String brandid, String modelid, String yomid) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmt=conn.createStatement();
			int errorstatus=0;
			int deleteval=stmt.executeUpdate("delete from gl_residualvaluem where brandid="+brandid+" and modelid="+modelid+" and yomid="+yomid+" and status=3");
			System.out.println("Array Size: "+masterarray.size());
			for(int i=0;i<masterarray.size();i++){
				System.out.println("Inside Loop");
				String temp[]=masterarray.get(i).split("::");
				String strsql="insert into  gl_residualvaluem(date,brandid,modelid,yomid,residualkmdocno,months,km,status,brhid,userid,residualvalue)values('"+sqldate+"',"+
				" "+temp[0]+","+temp[1]+","+temp[2]+","+temp[3]+","+temp[4]+","+temp[5]+",3,1,"+session.getAttribute("USERID").toString()+","+temp[6]+")";
				System.out.println(strsql);
				int val=stmt.executeUpdate(strsql);
				if(val<=0){
					errorstatus=1;
					break;
				}
			}
			if(errorstatus!=1){
				conn.commit();
				return 1;
			}
			else{
				return 0;
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return 0;
	}

		public JSONArray getExcelData() throws SQLException
	{
		JSONArray exceldata=new JSONArray();
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select @i:=coalesce(@i+1,1) 'Sr No',brd.brand_name 'Brand',model.vtype 'Model',yom.yom 'Yom',m.months 'Months',m.km 'Kms',m.residualvalue 'Residual Value' "+
			" from gl_residualvaluem m left join gl_vehbrand brd on m.brandid=brd.doc_no left join gl_vehmodel model on m.modelid=model.doc_no left join gl_yom yom "+
			" on m.yomid=yom.doc_no where m.status=3";
			ResultSet rs=stmt.executeQuery(strsql);
			exceldata=objcommon.convertToEXCEL(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return exceldata;
	}
}
