package com.dashboard.analysis.vehprofit;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsVehProfitDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	public JSONArray getVehProfit(String branch,String fromdate,String todate,String grpby1,String hidbrand,String hidmodel,String hidgroup,String hidyom,String temp,String gridtype,String hidfleet) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        Connection  conn =null;
		try {
			
			conn=ClsConnection.getMyConnection();
			if(!temp.equalsIgnoreCase("1")){
				return RESULTDATA;
			}
			Statement stmtsales=conn.createStatement();
			java.sql.Date sqlfromdate=null,sqltodate=null;
			if(!fromdate.equalsIgnoreCase("")){
				sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
			}
			if(!todate.equalsIgnoreCase("")){
				sqltodate=ClsCommon.changeStringtoSqlDate(todate);
			}
			String sqltest="";
			String sqlgroup="";
			String sqlgroupdet="";
			int i=0;
			String sqlselect="";
			
			if(grpby1.equalsIgnoreCase("")){
				sqlgroup=" group by fleetno";
				sqlselect="fleetno refno,veh.flname description";
			}
			else{
			
				sqlgroup="group by";
				
				if(grpby1.equalsIgnoreCase("brand")){
					sqlgroupdet=" veh.brdid";
					sqlselect="brd.doc_no refno,brd.brand_name description";
				}
				else if(grpby1.equalsIgnoreCase("model")){
					sqlgroupdet=" veh.vmodid";
					sqlselect="model.doc_no refno,model.vtype description";
				}
				else if(grpby1.equalsIgnoreCase("group")){
					sqlgroupdet=" veh.vgrpid";
					sqlselect="grp.doc_no refno,grp.gname description";
					
				}
				else if(grpby1.equalsIgnoreCase("yom")){
					sqlgroupdet=" veh.yom";
					sqlselect="yom.doc_no refno,yom.yom description";
				}
				else{
					
				}
				
				
				sqlgroup+=sqlgroupdet;
			}
		
			
			
			if(sqlfromdate!=null){
				sqltest+=" and jv.date>='"+sqlfromdate+"'";
			}
			if(sqltodate!=null){
				sqltest+=" and jv.date<='"+sqltodate+"'";
			}
			if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
				sqltest+=" and jv.brhid="+branch+"";
			}
			String sqlcommon="";
			if(!hidbrand.equalsIgnoreCase("")){
				sqlcommon+=" and veh.brdid in ("+hidbrand+")";
			}
			if(!hidmodel.equalsIgnoreCase("")){
				sqlcommon+=" and veh.vmodid in ("+hidmodel+")";
			}
			if(!hidgroup.equalsIgnoreCase("")){
				sqlcommon+=" and veh.vgrpid in ("+hidgroup+")";
			}
			if(!hidyom.equalsIgnoreCase("")){
				sqlcommon+=" and veh.yom in ("+hidyom+")";
			}
			if(!hidfleet.equalsIgnoreCase("")){
				sqlcommon+=" and veh.doc_no in ("+hidfleet+")";
			}
			
			
				String strSql="";
				if(gridtype.equalsIgnoreCase("detail")){
					if(grpby1.equalsIgnoreCase("")){
						sqlgroup="";
						
					}
					strSql="select acno,description,inv as income,exp as expenses,(inv-exp) netamount,fleetno,veh.flname,brd.brand_name brand,model.vtype"+
							" model,grp.gname,yom.yom from (select cost.acno,head.description,0.0 as inv,if(cost.amount<0,cost.amount*-1,cost.amount) exp,cost.jobid as fleetno from my_costtran cost left join"+
							" my_jvtran jv on (cost.tranid=jv.tranid) inner join my_head head on (cost.acno=head.doc_no"+
							" and head.gr_type=4) where 1=1 and cost.costtype=6 "+sqltest+" "+
							" union all"+
							" select cost.acno,head.description,if(cost.amount<0,cost.amount*-1,cost.amount) inv ,0.0 as exp,cost.jobid as fleetno from my_costtran"+
							" cost left join my_jvtran jv on(cost.tranid=jv.tranid)  inner join my_head head on ("+
							" cost.acno=head.doc_no)  where 1=1  and cost.costtype=6 "+sqltest+"  ) as b  left join gl_vehmaster veh on b.fleetno=veh.fleet_no"+
							" left join gl_vehbrand brd on veh.brdid=brd.doc_no left join gl_vehmodel model on veh.vmodid=model.doc_no left join gl_vehgroup"+
							" grp on veh.vgrpid=grp.doc_no left join gl_yom yom on veh.yom=yom.doc_no where 1=1 "+sqlcommon+"  order by fleetno";
				}
				else{
					
					strSql="select sum(inv) as income,sum(exp) as expenses,(sum(inv)-sum(exp)) netamount,"+sqlselect+",coalesce(veh.tval,0) purcost,((sum(inv) - sum(exp))  / tval)* 100 returnprice"+
							" from (select 0.0 as inv,sum(if(cost.amount<0,cost.amount*-1,cost.amount)) exp,cost.jobid as fleetno from my_costtran cost left join"+
						" my_jvtran jv on (cost.tranid=jv.tranid ) inner join my_head head on (cost.acno=head.doc_no"+
						" and head.gr_type=4) where 1=1  and cost.costtype=6 "+sqltest+" group by cost.jobid"+
						" union all"+
						" select sum(if(cost.amount<0,cost.amount*-1,cost.amount)) inv ,0.0 as exp,cost.jobid as fleetno from my_costtran"+
						" cost left join my_jvtran jv on(cost.tranid=jv.tranid)  inner join my_head head on ("+
						" cost.acno=head.doc_no and head.gr_type=5) where 1=1  and cost.costtype=6 "+sqltest+" group by cost.jobid) as b  left join gl_vehmaster veh on b.fleetno=veh.fleet_no"+
						" left join gl_vehbrand brd on veh.brdid=brd.doc_no left join gl_vehmodel model on veh.vmodid=model.doc_no left join gl_vehgroup"+
						" grp on veh.vgrpid=grp.doc_no left join gl_yom yom on veh.yom=yom.doc_no where 1=1 "+sqlcommon+""+sqlgroup; 
				}
				
			//	System.out.println("Check Query:"+strSql);
             	ResultSet resultSet = stmtsales.executeQuery(strSql);
             	
        		RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
        		stmtsales.close();
				conn.close();
				
				   return RESULTDATA;
  
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
}
