package com.dashboard.marketing.costsheet;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClscostSheetDAO {
	
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	public  JSONArray searchgrid() throws SQLException
	{
		 
	 
	        JSONArray RESULTDATA=new JSONArray();
	        
	        Connection conn = null;
			try {
					 conn = ClsConnection.getMyConnection();
					Statement stmt = conn.createStatement (); 
	            
						
						String sqldata="select 'Edit' btnsave, m.doc_no,trim(g.gname) gpname,mm.desc1 descp, m.grpid,convert(if(m.extrainsurperyear=0,'',m.extrainsurperyear),char(100)) extrainsurperyear,convert(if(m.majorsrvckm=0,'',m.majorsrvckm),char(100)) majorsrvckm,convert(if(m.majorsrvccost=0,'',m.majorsrvccost),char(100)) majorsrvccost,convert(if(m.trackidexp=0,'',m.trackidexp),char(100)) trackidexp,convert(if(m.dy1=0,'',m.dy1),char(100)) dy1,  "
								+ " convert(if(m.dy2=0,'',m.dy2),char(100)) dy2, convert(if(m.dy3=0,'',m.dy3),char(100)) dy3, convert(if(m.dy4=0,'',m.dy4),char(100)) dy4 , "
								+ " convert(if(m.dy5=0,'',m.dy5),char(100)) dy5, convert(if(m.ins_per=0,'',m.ins_per),char(100)) ins_per, convert(if(m.mininsur=0,'',m.mininsur),char(100)) mininsur, "
								+ " convert(if(m.srv_km=0,'',m.srv_km),char(100))  srv_km, convert(if(m.tyrechg_km=0,'',m.tyrechg_km),char(100)) tyrechg_km, "
								+ "convert(if(m.tyre_cost=0,'',m.tyre_cost),char(100)) tyre_cost,\r\n" + 
								"   convert(if(m.maint_cost=0,'',m.maint_cost),char(100)) maint_cost,convert(if(m.repl_cost=0,'',m.repl_cost),char(100)) repl_cost,"
								+ " convert(if(m.carwash_cost=0,'',m.carwash_cost),char(100))  carwash_cost,convert(if(m.AUH=0,'', m.AUH),char(100))  auh,convert(if(m.DXB=0,'', m.DXB),char(100)) dxb,convert(if(m.SHJ=0,'', m.SHJ),char(100)) shj,convert(if(m.FUJ=0,'', m.FUJ),char(100)) fuj,convert(if(m.RAK=0,'', m.RAK),char(100)) rak  from gl_leasecost m left join gl_vehgroup g on g.doc_no=m.grpid left join gl_lcgm  mm\r\n" + 
								"   on mm.grpid=m.grpid where m.status=3 and  mm.grpid is not null group by m.doc_no  order by m.grpid";
						
	 System.out.println("======excel  ===== "+sqldata);
					ResultSet resultSet = stmt.executeQuery (sqldata);
					RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
					
					stmt.close();
					conn.close();
					 return RESULTDATA;

			}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
			//System.out.println(RESULTDATA);
	        return RESULTDATA;
	    }
		
		
	
	public   JSONArray loadbeanAndmodel(String grpid) throws SQLException { 

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmt = conn.createStatement ();   
            
			 
				
					
					String sqldata=" select b.brand_name,mo.vtype model_name from gl_lcgm m left join gl_vehbrand b on b.doc_no=m.brdid left join gl_vehmodel \r\n" + 
							" mo on mo.doc_no=m.modid  where grpid='"+grpid+"'";
// System.out.println("======excel asdasdasd ===== "+sqldata);
				ResultSet resultSet = stmt.executeQuery (sqldata);
				RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
				 
				stmt.close();
				conn.close();
				 return RESULTDATA;

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
	
	
	
	

}
