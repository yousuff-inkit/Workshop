package com.dashboard.audit.rentalcreatedisc;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsRentalCreateDiscDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	public JSONArray getRentalAgmtAudit(String branch,String id) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return RESULTDATA;
		}
		Connection conn = null;
		
		  try {
			    conn = ClsConnection.getMyConnection();
			    Statement stmt = conn.createStatement();
			    String sqltest = "";
			    
			    if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("")))){
	    			sqltest+=" and m.brhid="+branch+"";
	    		}
			    String sql="";
			    sql = "select aa.voc_no vocno,aa.doc_no,concat(CONVERT(v.fleet_no,CHAR(50)),' - ',v.flname) as vehicle,c.refname,"+
			    " CONVERT(concat(round(aa.distot/aa.totamount*100,2),' ','%'),char(200)) as prcent,round(aa.totamount,2) total,round(aa.distot,2)"+
			    " discount,aa.brhid,aa.rentaltype from (select m.cldocno,m.fleet_no,m.doc_no,m.voc_no,sum(d.rate+d.cdw+d.pai+d.cdw1+d.pai1+d.gps+d.babyseater+"+
			    " d.cooler+d.exkmrte+d.exhrchg+d.chaufchg) totamount,sum(d1.rate+d1.cdw+d1.pai+d1.cdw1+d1.pai1+d1.gps+d1.babyseater+d1.cooler+d1.exkmrte+d1.exhrchg+"+
			    " d1.chaufchg) distot,d.* from gl_ragmt m left join gl_rtarif d on m.doc_no=d.rdocno and (d.rstatus=5) left join gl_rtarif d1 on   m.doc_no=d1.rdocno "+
			    " and d1.rstatus=6 where  m.audit=0 "+sqltest+" group by m.doc_no having "+
			    " distot>0)aa left join gl_vehmaster v on v.fleet_no=aa.fleet_no left join my_acbook c on (aa.cldocno=c.cldocno and c.dtype='CRM')";

			    ResultSet resultSet = stmt.executeQuery(sql);
			    RESULTDATA=ClsCommon.convertToJSON(resultSet);
			    stmt.close();
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
