package com.dashboard.vehicle.movementupdate;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsMovementUpdateDAO 


{
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	
	public JSONArray searchmovement(String fleetno,String fromdate,String todate) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
     
        
        
        Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection(); 
				Statement stmtVeh1 = conn.createStatement ();
				String sqlbrch="";
		        java.sql.Date sqlfromdate = null;
		     	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
		     	{
		     		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
		     		
		     	}
		     	else{
		     
		     	}

		        java.sql.Date sqltodate = null;
		     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
		     	{
		     		sqltodate=ClsCommon.changeStringtoSqlDate(todate);
		     		
		     	}
		     	else{
		     
		     	}
			
			String sqldata=("select v.rdocno vmrdocno,convert(coalesce(v.fout,''),char(30)) hidfout,convert(coalesce(v.fin,''),char(30)) hidfin, "
					+ " v.doc_no,CASE  WHEN v.rdtype='RAG' THEN r.voc_no WHEN  rdtype='LAG' THEN l.voc_no else v.rdocno  END as "
					+ "  'rdocno' ,v.fleet_no,vm.reg_no,if(v.rdtype='','',v.rdtype) rdtype,  coalesce(vm.flname,'') flname  "
					+ "  ,coalesce(v.status,'') status, coalesce(s.st_desc,'') trancode,  "
					+ " convert(coalesce(v.dout,''),char(20)) dout,coalesce(v.tout,'') tout,CONVERT(coalesce(round(v.kmout),''),char(30)) kmout,  "
					+ "   CASE  WHEN coalesce(v.fout,'')='' THEN '' WHEN v.fout='0.000' THEN 'Level 0/8'  WHEN v.fout='0.125'  "
					+ "  THEN 'Level 1/8' WHEN v.fout='0.250'  THEN 'Level 2/8' WHEN v.fout='0.375'     THEN 'Level 3/8'  "
					+ "   WHEN v.fout='0.500' THEN 'Level 4/8' WHEN v.fout='0.625' THEN 'Level 5/8'   WHEN v.fout='0.750'  "
					+ "   THEN 'Level 6/8'   WHEN v.fout='0.875' THEN 'Level 7/8' WHEN v.fout='1.000' THEN 'Level 8/8'  "
					+ "    END as 'Fout' ,CONVERT(coalesce(v.din,''),char(15)) din,coalesce(v.tin,'') tin, "
					+ "  CONVERT(coalesce(round(kmin),''),char(30)) kmin,    CASE  WHEN coalesce(v.fin,'')='' THEN '' WHEN v.fin='0.000' THEN 'Level 0/8'  "
					+ " WHEN v.fin='0.125'    THEN 'Level 1/8' WHEN v.fin='0.250' THEN 'Level 2/8' WHEN v.fin='0.375'   THEN 'Level 3/8'  "
					+ "  WHEN v.fin='0.500'    THEN 'Level 4/8' WHEN v.fin='0.625' THEN 'Level 5/8' WHEN v.fin='0.750' "
					+ "      THEN 'Level 6/8' WHEN v.fin='0.875'    THEN 'Level 7/8' WHEN v.fin='1.000' THEN 'Level 8/8'  END as 'FIN'  "
					+ "  from gl_vmove v left join gl_status s    on(v.trancode=s.status) left join gl_ragmt r on  r.doc_no=v.rdocno and v.rdtype='RAG'  "
					+ "    left join gl_lagmt l on l.doc_no=v.rdocno and v.rdtype='LAG'    left join gl_vehmaster vm on (vm.fleet_no=v.fleet_no and vm.statu=3)  "
					+ " where  v.rdtype!='VEH' and  v.fleet_no='"+fleetno+"' and  v.DATE between '"+sqlfromdate+"' and  '"+sqltodate+"' order by v.doc_no desc "); 
			
			
			//System.out.println("---sqldata-----"+sqldata);

			
				ResultSet resultSet = stmtVeh1.executeQuery (sqldata);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtVeh1.close();
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
