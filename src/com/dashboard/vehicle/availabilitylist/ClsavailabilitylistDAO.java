package com.dashboard.vehicle.availabilitylist;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
 

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsavailabilitylistDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();


	public JSONArray vehSearch(String branch) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();

	   	 Connection conn=null;
			try {
				
				String sqltest="";
					conn = ClsConnection.getMyConnection();
					Statement stmtVeh8 = conn.createStatement ();
	         //  	System.out.println("-----branch----"+branch);
					if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
			 			sqltest+=" and v.a_br="+branch+"";
			 		}
 
					
					String vehsql="select *  from (select v.a_loc,v.reg_no,v.fleet_no,v.FLNAME,convert(if(v.fleet_no>0,'',''),char(20)) days,c.color,v.clrid,g.gname,v.vgrpid,vb.brand_name,v.brdid,vm.vtype model,v.vmodid  from gl_vehmaster v   "
							+ "	left join gl_vmove m on v.fleet_no=m.fleet_no  left join my_color c  on v.clrid=c.doc_no left join gl_vehgroup g  on g.doc_no=v.vgrpid  "
							+ " left join gl_vehbrand vb on vb.doc_no=v.brdid left join gl_vehmodel vm on vm.doc_no=v.vmodid where   "
							+ "  ins_exp >=current_date "+sqltest+" and v.statu=3	 and m.doc_no=(select (max(doc_no)) from gl_vmove where fleet_no=v.fleet_no) and "
							+ " fstatus in ('L','N')  and v.status='IN'	  and v.tran_code='RR' and v.renttype in ('A','R')) aa 	union all "
							+ " (select v.a_loc,v.reg_no,v.fleet_no,v.FLNAME, convert((SELECT DATEDIFF(r.ddate,curdate())),char(20)) AS days,c.color,v.clrid,g.gname, "
							+ "v.vgrpid,vb.brand_name,v.brdid,vm.vtype model,v.vmodid  from gl_vehmaster v "
							+ "left join my_color c  on v.clrid=c.doc_no left join gl_vehgroup g  on g.doc_no=v.vgrpid  "
							+ " left join gl_vehbrand vb on vb.doc_no=v.brdid left join gl_vehmodel vm on vm.doc_no=v.vmodid "
							+ " inner join gl_ragmt r on(r.fleet_no=v.fleet_no and r.clstatus=0 and date_add(curdate(), INTERVAL 30 DAY)>r.ddate) where 1=1 "+sqltest+"  ) ";
					
					
				//System.out.println("---------------"+vehsql);
					ResultSet resultSet = stmtVeh8.executeQuery(vehsql);
					
					RESULTDATA=ClsCommon.convertToJSON(resultSet);
					stmtVeh8.close();
					
				
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
