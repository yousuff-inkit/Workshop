package com.dashboard.analysis.maintenanceanalysis;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsmaintenanceanalysisDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();


	
	
/*	public  JSONArray getSalesInvoices_Dates(String branch,String fromdate,String todate,String grpby1,String hidclientcat,
			String hidclient,String hidsalesman,String hidrentalagent,String hidbrand,String hidmodel,String hidgroup,String hidyom,String temp) throws SQLException {*/
//		System.out.println("Inside");
	public JSONArray getmasterdatas(String branch,String fromdate,String todate,String hidfleet,String hidbrand,String hidmodel,String hidyom,String hidmtype,String radiotype) throws SQLException {
	
        JSONArray RESULTDATA=new JSONArray();
        Connection  conn =null;
		try {
			
			conn=ClsConnection.getMyConnection();
			Statement stmtsales=conn.createStatement(); 
			
			
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
			String sqltest="";
			if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
				sqltest+=" and m.brhid="+branch+"";
			}
			String sqlselect="";
			String sqlrad="";
			String sqlgroup="";
			/*	String sqlgroupdet="";*/
			
			if(!(hidfleet.equalsIgnoreCase("undefined"))&&!(hidfleet.equalsIgnoreCase(""))&&!(hidfleet.equalsIgnoreCase("0")))
	     	{
				sqltest+=" and m.fleetno in("+hidfleet+") " ;
	     		
	     	}
		 
			if(!(hidbrand.equalsIgnoreCase("undefined"))&&!(hidbrand.equalsIgnoreCase(""))&&!(hidbrand.equalsIgnoreCase("0")))
	     	{
				sqltest+=" and v.brdid in("+hidbrand+") " ;
	     		
	     	}
			
			
			
				if(!(hidmodel.equalsIgnoreCase("undefined"))&&!(hidmodel.equalsIgnoreCase(""))&&!(hidmodel.equalsIgnoreCase("0")))
		     	{
					sqltest+=" and v.vmodid in("+hidmodel+") " ;
		     		
		     	}
				
				if(!(hidyom.equalsIgnoreCase("undefined"))&&!(hidyom.equalsIgnoreCase(""))&&!(hidyom.equalsIgnoreCase("0")))
		     	{
					sqltest+=" and v.yom in("+hidyom+") " ;
		     		
		     	}
				if(!(hidmtype.equalsIgnoreCase("undefined"))&&!(hidmtype.equalsIgnoreCase(""))&&!(hidmtype.equalsIgnoreCase("0")))
		     	{
					sqltest+=" and rp.docno in("+hidmtype+") " ;
		     		
		     	}
				if(radiotype.equalsIgnoreCase("RS")){
					 
					
					sqlrad= "convert(if(sum(d.labcost)>0,sum(d.labcost),''),char(50)) labcost,convert(if(sum(d.partcost)>0,sum(d.partcost),''),char(50)) partscost,convert(if(sum(total)>0,sum(total),''),char(50)) totalcost";
					sqlgroup=" group by m.doc_no ";
				
				}
				else if(radiotype.equalsIgnoreCase("RD"))
				{
					sqlrad= "rp.mtype,rp.name mdesc,convert(if(d.labcost>0,d.labcost,''),char(50)) labcost,convert(if(d.partcost>0,d.partcost,''),char(50)) partscost,convert(if(total>0,total,''),char(50)) totalcost";
				
				}
			
		/*	System.out.println("--groupby-"+groupby);
			
			if(groupby.equalsIgnoreCase("gpwithdoc"))
			{
				
				System.out.println("---1--");
				sqlselect="group by m.doc_no";
			}
			
			else if(groupby.equalsIgnoreCase("gpwithfilter"))
			
			{
				System.out.println("---2-");
			}
			else
			{
				System.out.println("---3--");
				sqlselect="group by m.doc_no";
			}*/
			
			
			
	/*		if(!temp.equalsIgnoreCase("1")){
				return RESULTDATA;
			}
			
			java.sql.Date sqlfromdate=null,sqltodate=null;
			if(!fromdate.equalsIgnoreCase("")){
				sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
			}
			if(!todate.equalsIgnoreCase("")){
				sqltodate=ClsCommon.changeStringtoSqlDate(todate);
			}*/
			

/*			int i=0;
			if(grpby1.equalsIgnoreCase("")){
				sqlgroup=" group by ac.cldocno";
				sqlselect="ac.cldocno refno,ac.refname description,if(sum(amount)<0,sum(amount)*-1,sum(amount)) amount";

			}
			else{
				sqlgroup="group by";
				if(grpby1.equalsIgnoreCase("clientcat")){
					sqlgroupdet=" cat.doc_no";
					sqlselect="cat.doc_no refno,cat.cat_name description,if(sum(amount)<0,sum(amount)*-1,sum(amount)) amount";
				}
				else if(grpby1.equalsIgnoreCase("client")){
					sqlgroupdet=" ac.cldocno";
					sqlselect="ac.cldocno refno,ac.refname description,if(sum(amount)<0,sum(amount)*-1,sum(amount)) amount";
				}
				else if(grpby1.equalsIgnoreCase("salesman")){
					sqlgroupdet=" sal.doc_no";
					sqlselect=" sal.doc_no refno,sal.sal_name description,if(sum(amount)<0,sum(amount)*-1,sum(amount)) amount";
				}
				else if(grpby1.equalsIgnoreCase("rentalagent")){
					sqlgroupdet=" rarla.doc_no";
					sqlselect="rarla.doc_no refno,rarla.sal_name description,if(sum(amount)<0,sum(amount)*-1,sum(amount)) amount";
				}
				else if(grpby1.equalsIgnoreCase("brand")){
					sqlgroupdet=" veh.brdid";
					sqlselect=" veh.brdid refno,brd.brand_name description,if(sum(amount)<0,sum(amount)*-1,sum(amount)) amount";
				}
				else if(grpby1.equalsIgnoreCase("model")){
					sqlgroupdet=" veh.vmodid";
					sqlselect=" veh.vmodid refno,model.vtype description,if(sum(amount)<0,sum(amount)*-1,sum(amount)) amount";
				}
				else if(grpby1.equalsIgnoreCase("group")){
					sqlgroupdet=" veh.vgrpid";
					sqlselect=" veh.vgrpid refno,grp.gname description,if(sum(amount)<0,sum(amount)*-1,sum(amount)) amount";
				}
				else if(grpby1.equalsIgnoreCase("yom")){
					sqlgroupdet=" veh.yom";
					sqlselect=" veh.yom refno,yom.yom description,if(sum(amount)<0,sum(amount)*-1,sum(amount)) amount";
				}
				else{
					
				}
				
				
			
				sqlgroup+=sqlgroupdet;
			}
		
			
			
			if(sqlfromdate!=null){
				sqltest+=" and inv.date>='"+sqlfromdate+"'";
			}
			if(sqltodate!=null){
				sqltest+=" and inv.date<='"+sqltodate+"'";
			}
		
			
			if(!hidclientcat.equalsIgnoreCase("")){
				sqltest+=" and cat.doc_no in ("+hidclientcat+")";
			}
			if(!hidclient.equalsIgnoreCase("")){
				sqltest+=" and ac.cldocno in ("+hidclient+")";
			}
			if(!hidsalesman.equalsIgnoreCase("")){
				sqltest+=" and sal.doc_no in ("+hidsalesman+")";
			}
			if(!hidrentalagent.equalsIgnoreCase("")){
				sqltest+=" and rarla.doc_no in ("+hidrentalagent+")";
			}
			if(!hidbrand.equalsIgnoreCase("")){
				sqltest+=" and veh.brdid in ("+hidbrand+")";
			}
			if(!hidmodel.equalsIgnoreCase("")){
				sqltest+=" and veh.vmodid in ("+hidmodel+")";
			}
			if(!hidgroup.equalsIgnoreCase("")){
				sqltest+=" and veh.vgrpid in ("+hidgroup+")";
			}
			if(!hidyom.equalsIgnoreCase("")){
				sqltest+=" and veh.yom in ("+hidyom+")";
			}
			*/
			 
			
			String strSql="select m.trno,m.psstatus,m.dtype,m.voc_no docno,m.doc_no,m.fleetno fleet_no,v.reg_no,y.yom,br.brand_name brand,mo.vtype model,m.doc_no,upper(m.mtype) type,\r\n" + 
					"convert(coalesce(round(m.currkm),''),char(30)) current_km,convert(coalesce(round(m.serduekm),''),char(30)) nxtser_km\r\n" + 
					","+sqlrad+"  from gl_vmcostm m left join gl_vcostd d on m.doc_no=d.rdocno left join gl_vrepm rp on rp.mtype=d.type and d.repdesc=rp.name left join gl_vehmaster v on v.fleet_no=m.fleetno\r\n" + 
					"left join gl_yom y on y.doc_no=v.yom left join gl_vehbrand br on br.doc_no=v.brdid left join gl_vehmodel mo on mo.doc_no=v.vmodid\r\n" + 
					" where m.status=3 and \r\n" + 
					" if(m.dtype='MWO',m.psstatus,if(m.dtype='MRU',coalesce(m.trno,0),0))>0 and m.postdate between '"+sqlfromdate+"' and '"+sqltodate+"' " +sqltest+"  "+sqlgroup+"";
			
			
				/*String strSql="select m.trno,m.psstatus,m.dtype,m.voc_no docno,m.doc_no,m.fleetno fleet_no,v.reg_no,y.yom,br.brand_name brand,mo.vtype model,m.doc_no,m.mtype type,\r\n" + 
						"coalesce(m.currkm,'') current_km,coalesce(m.serduekm,'') nxtser_km,\r\n" + 
						"aa.labcost labour_cost ,aa.partcost parts_cost \r\n" + 
						" from gl_vmcostm m left join gl_vehmaster v on v.fleet_no=m.fleetno\r\n" + 
						"left join gl_yom y on y.doc_no=v.yom left join gl_vehbrand br on br.doc_no=v.brdid left join gl_vehmodel mo on mo.doc_no=v.vmodid\r\n" + 
						"left join my_jvtran j on j.tr_no=m.trno\r\n" + 
						"  left join (select sum(labcost) labcost,sum(partcost) partcost,rdocno from gl_vcostd where 1=1 group by rdocno) aa\r\n" + 
						"  on aa.rdocno=m.doc_no where if(m.dtype='MWO',m.psstatus,if(m.dtype='MRU',coalesce(m.trno,0),0))>0  group by m.doc_no"; */
			System.out.println("Check Query==rad=="+strSql);
             	ResultSet resultSet = stmtsales.executeQuery (strSql);
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
	
	public JSONArray excelmasterdatas(String branch,String fromdate,String todate,String hidfleet,String hidbrand,String hidmodel,String hidyom,String hidmtype,String radiotype) throws SQLException {
		
        JSONArray RESULTDATA=new JSONArray();
        Connection  conn =null;
		try {
			
			conn=ClsConnection.getMyConnection();
			Statement stmtsales=conn.createStatement(); 
			
			
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
			String sqltest="";
			if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
				sqltest+=" and m.brhid="+branch+"";
			}
			String sqlselect="";
			String sqlrad="";
			String sqlgroup="";
			/*	String sqlgroupdet="";*/
			
			if(!(hidfleet.equalsIgnoreCase("undefined"))&&!(hidfleet.equalsIgnoreCase(""))&&!(hidfleet.equalsIgnoreCase("0")))
	     	{
				sqltest+=" and m.fleetno in("+hidfleet+") " ;
	     		
	     	}
		 
			if(!(hidbrand.equalsIgnoreCase("undefined"))&&!(hidbrand.equalsIgnoreCase(""))&&!(hidbrand.equalsIgnoreCase("0")))
	     	{
				sqltest+=" and v.brdid in("+hidbrand+") " ;
	     		
	     	}
			
			
			
				if(!(hidmodel.equalsIgnoreCase("undefined"))&&!(hidmodel.equalsIgnoreCase(""))&&!(hidmodel.equalsIgnoreCase("0")))
		     	{
					sqltest+=" and v.vmodid in("+hidmodel+") " ;
		     		
		     	}
				
				if(!(hidyom.equalsIgnoreCase("undefined"))&&!(hidyom.equalsIgnoreCase(""))&&!(hidyom.equalsIgnoreCase("0")))
		     	{
					sqltest+=" and v.yom in("+hidyom+") " ;
		     		
		     	}
				if(!(hidmtype.equalsIgnoreCase("undefined"))&&!(hidmtype.equalsIgnoreCase(""))&&!(hidmtype.equalsIgnoreCase("0")))
		     	{
					sqltest+=" and rp.docno in("+hidmtype+") " ;
		     		
		     	}
				if(radiotype.equalsIgnoreCase("RS")){
					 
					
					sqlrad= "convert(if(sum(d.labcost)>0,sum(d.labcost),''),char(50)) as 'Labour Cost',convert(if(sum(d.partcost)>0,sum(d.partcost),''),char(50)) as 'Parts Cost',convert(if(sum(total)>0,sum(total),''),char(50)) as 'Total Cost'";
					sqlgroup=" group by m.doc_no ";
				
				}
				else if(radiotype.equalsIgnoreCase("RD"))
				{
					sqlrad= "rp.mtype 'Maintenance Type',rp.name 'Description',convert(if(d.labcost>0,d.labcost,''),char(50)) as 'Labour Cost',convert(if(d.partcost>0,d.partcost,''),char(50)) as 'Parts Cost',convert(if(total>0,total,''),char(50)) as 'Total Cost'";
				
				}
						 
			
			String strSql="select @sl:=@sl+1 as sl,a.* from(select m.fleetno 'Fleet',v.reg_no 'Reg No',br.brand_name 'Brand',mo.vtype 'Model',y.yom 'YOM',m.dtype 'DType',m.voc_no 'Doc No',"+sqlrad+",upper(m.mtype) 'Type',\r\n" + 
					"convert(coalesce(round(m.currkm),''),char(30)) 'Current Km',convert(coalesce(round(m.serduekm),''),char(30)) 'Next Service Km'\r\n" + 
					"  from gl_vmcostm m left join gl_vcostd d on m.doc_no=d.rdocno left join gl_vrepm rp on rp.mtype=d.type and d.repdesc=rp.name left join gl_vehmaster v on v.fleet_no=m.fleetno\r\n" + 
					"left join gl_yom y on y.doc_no=v.yom left join gl_vehbrand br on br.doc_no=v.brdid left join gl_vehmodel mo on mo.doc_no=v.vmodid\r\n" + 
					" where m.status=3 and \r\n" + 
					" if(m.dtype='MWO',m.psstatus,if(m.dtype='MRU',coalesce(m.trno,0),0))>0 and m.postdate between '"+sqlfromdate+"' and '"+sqltodate+"' " +sqltest+"  "+sqlgroup+") a,(select @sl:=0) as sl";
			
		System.out.println("Check Query==excel=="+strSql);
             	ResultSet resultSet = stmtsales.executeQuery (strSql);
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
	
	
	public JSONArray getmastergrouping(String branch,String fromdate,String todate,String grpby1,String hidbrand,String hidmodel,String hidyom,String hidfleet,String hidmtype) throws SQLException {
		
        JSONArray RESULTDATA=new JSONArray();
        Connection  conn =null;
		try {
			
			conn=ClsConnection.getMyConnection();
			Statement stmtsales=conn.createStatement(); 
			
			
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
			String sqltest="";
			if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
				sqltest+=" and m.brhid="+branch+"";
			}
			String sqlselect="";
 			String sqlgroup="";
	/*		String sqlgroupdet=""; */
			
			 
			 
 	 
			if(grpby1.equalsIgnoreCase("fleetno")){
				 
				
				sqlgroup= " m.fleetno refno,v.flname desc1,";
				
				sqlselect= " group by m.fleetno";

			}
			else if(grpby1.equalsIgnoreCase("brand"))
			{
				sqlgroup= " v.brdid refno,br.brand_name desc1,";
				
				sqlselect= " group by br.doc_no";	
			}
			else if(grpby1.equalsIgnoreCase("model"))
			{
				
				
				sqlgroup= " v.vmodid refno,mo.vtype desc1,";
				
				sqlselect= " group by mo.doc_no";	
			}
			else if(grpby1.equalsIgnoreCase("yom"))
			{
				sqlgroup= " v.yom refno,y.yom desc1,";
				sqlselect= " group by y.doc_no";	
			}
			else if(grpby1.equalsIgnoreCase("mtype"))
			{
				sqlgroup= " rp.docno refno,rp.mtype desc1,";
				sqlselect= " group by rp.mtype";	
			}
			else if(grpby1.equalsIgnoreCase("mdesc"))
			{
				sqlgroup= " rp.docno refno,rp.name desc1,";
				sqlselect= " group by rp.docno";	
			}
			else
			{
				sqlselect=" group by m.doc_no ";
			}
							 
			if(!(hidfleet.equalsIgnoreCase("undefined"))&&!(hidfleet.equalsIgnoreCase(""))&&!(hidfleet.equalsIgnoreCase("0")))
	     	{
				sqltest+=" and m.fleetno in("+hidfleet+") " ;
	     		
	     	}
		 
			if(!(hidbrand.equalsIgnoreCase("undefined"))&&!(hidbrand.equalsIgnoreCase(""))&&!(hidbrand.equalsIgnoreCase("0")))
	     	{
				sqltest+=" and v.brdid in("+hidbrand+") " ;
	     		
	     	}
			
			
			
				if(!(hidmodel.equalsIgnoreCase("undefined"))&&!(hidmodel.equalsIgnoreCase(""))&&!(hidmodel.equalsIgnoreCase("0")))
		     	{
					sqltest+=" and v.vmodid in("+hidmodel+") " ;
		     		
		     	}
				
				if(!(hidyom.equalsIgnoreCase("undefined"))&&!(hidyom.equalsIgnoreCase(""))&&!(hidyom.equalsIgnoreCase("0")))
		     	{
					sqltest+=" and v.yom in("+hidyom+") " ;
		     		
		     	}
				if(!(hidmtype.equalsIgnoreCase("undefined"))&&!(hidmtype.equalsIgnoreCase(""))&&!(hidmtype.equalsIgnoreCase("0")))
		     	{
					sqltest+=" and rp.docno in("+hidmtype+") " ;
		     		
		     	}
			 
		
			String strSql="select "+sqlgroup+" convert(if(sum(d.labcost)>0,sum(d.labcost),''),char(50)) labcost,convert(if(sum(d.partcost)>0,sum(d.partcost),''),char(50)) partscost, "
					+ " convert(if(sum(total)>0,sum(total),''),char(50)) totalcost \r\n " + 
					" from gl_vmcostm m left join  gl_vcostd d on m.doc_no=d.rdocno left join gl_vrepm rp on rp.mtype=d.type and d.repdesc=rp.name left join gl_vehmaster v on v.fleet_no=m.fleetno\r\n" + 
					" left join gl_yom y on y.doc_no=v.yom left join gl_vehbrand br on br.doc_no=v.brdid left join gl_vehmodel mo on mo.doc_no=v.vmodid \r\n" + 
					"  where m.status=3 and \r\n" + 
					" if(m.dtype='MWO',m.psstatus,if(m.dtype='MRU',coalesce(m.trno,0),0))>0 and m.postdate between '"+sqlfromdate+"' and '"+sqltodate+"' " +sqltest+"  "+sqlselect;
			
		 
		//	System.out.println("Check Query pp:--------"+strSql);
             	ResultSet resultSet = stmtsales.executeQuery (strSql);
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
	
public JSONArray excelmastergrouping(String branch,String fromdate,String todate,String grpby1,String hidbrand,String hidmodel,String hidyom,String hidfleet,String hidmtype) throws SQLException {
		
        JSONArray RESULTDATA=new JSONArray();
        Connection  conn =null;
		try {
			
			conn=ClsConnection.getMyConnection();
			Statement stmtsales=conn.createStatement(); 
			
			
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
			String sqltest="";
			if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
				sqltest+=" and m.brhid="+branch+"";
			}
			String sqlselect="";
 			String sqlgroup="";
	/*		String sqlgroupdet=""; */
			
			 
			 
 	 
			if(grpby1.equalsIgnoreCase("fleetno")){
				 
				
				sqlgroup= " m.fleetno 'Ref No',v.flname 'Description',";
				
				sqlselect= " group by m.fleetno";

			}
			else if(grpby1.equalsIgnoreCase("brand"))
			{
				sqlgroup= " v.brdid 'Ref No',br.brand_name 'Description',";
				
				sqlselect= " group by br.doc_no";	
			}
			else if(grpby1.equalsIgnoreCase("model"))
			{
				
				
				sqlgroup= " v.vmodid 'Ref No',mo.vtype 'Description',";
				
				sqlselect= " group by mo.doc_no";	
			}
			else if(grpby1.equalsIgnoreCase("yom"))
			{
				sqlgroup= " v.yom 'Ref No',y.yom 'Description',";
				sqlselect= " group by y.doc_no";	
			}
			else if(grpby1.equalsIgnoreCase("mtype"))
			{
				sqlgroup= " rp.docno 'Ref No',rp.mtype 'Description',";
				sqlselect= " group by rp.mtype";	
			}
			else if(grpby1.equalsIgnoreCase("mdesc"))
			{
				sqlgroup= " rp.docno 'Ref No',rp.name 'Description',";
				sqlselect= " group by rp.docno";	
			}
			else
			{
				sqlselect=" group by m.doc_no ";
			}
							 
			if(!(hidfleet.equalsIgnoreCase("undefined"))&&!(hidfleet.equalsIgnoreCase(""))&&!(hidfleet.equalsIgnoreCase("0")))
	     	{
				sqltest+=" and m.fleetno in("+hidfleet+") " ;
	     		
	     	}
		 
			if(!(hidbrand.equalsIgnoreCase("undefined"))&&!(hidbrand.equalsIgnoreCase(""))&&!(hidbrand.equalsIgnoreCase("0")))
	     	{
				sqltest+=" and v.brdid in("+hidbrand+") " ;
	     		
	     	}
			
			
			
				if(!(hidmodel.equalsIgnoreCase("undefined"))&&!(hidmodel.equalsIgnoreCase(""))&&!(hidmodel.equalsIgnoreCase("0")))
		     	{
					sqltest+=" and v.vmodid in("+hidmodel+") " ;
		     		
		     	}
				
				if(!(hidyom.equalsIgnoreCase("undefined"))&&!(hidyom.equalsIgnoreCase(""))&&!(hidyom.equalsIgnoreCase("0")))
		     	{
					sqltest+=" and v.yom in("+hidyom+") " ;
		     		
		     	}
				if(!(hidmtype.equalsIgnoreCase("undefined"))&&!(hidmtype.equalsIgnoreCase(""))&&!(hidmtype.equalsIgnoreCase("0")))
		     	{
					sqltest+=" and rp.docno in("+hidmtype+") " ;
		     		
		     	}
			 
		
			String strSql="select "+sqlgroup+" convert(if(sum(d.labcost)>0,sum(d.labcost),''),char(50)) 'Labour Cost',convert(if(sum(d.partcost)>0,sum(d.partcost),''),char(50)) 'Parts Cost', "
					+ " convert(if(sum(total)>0,sum(total),''),char(50)) 'Total Cost' \r\n " + 
					" from gl_vmcostm m left join  gl_vcostd d on m.doc_no=d.rdocno left join gl_vrepm rp on rp.mtype=d.type and d.repdesc=rp.name left join gl_vehmaster v on v.fleet_no=m.fleetno\r\n" + 
					" left join gl_yom y on y.doc_no=v.yom left join gl_vehbrand br on br.doc_no=v.brdid left join gl_vehmodel mo on mo.doc_no=v.vmodid \r\n" + 
					"  where m.status=3 and \r\n" + 
					" if(m.dtype='MWO',m.psstatus,if(m.dtype='MRU',coalesce(m.trno,0),0))>0 and m.postdate between '"+sqlfromdate+"' and '"+sqltodate+"' " +sqltest+"  "+sqlselect;
			
		 
		//	System.out.println("Check Query pp:--------"+strSql);
             	ResultSet resultSet = stmtsales.executeQuery (strSql);
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
public JSONArray monthwise(String branch,String fromdate,String todate,String grpby1,String hidbrand,String hidmodel,String hidyom,String hidfleet,String cmbfrequency,String tempval,String hidmtype) throws SQLException {
		
        JSONArray RESULTDATA=new JSONArray();
		 
		 JSONArray ROWDATA=new JSONArray();
		 JSONArray COLUMNDATA=new JSONArray();
        Connection  conn =null;
   	try {
			
				conn=ClsConnection.getMyConnection();
			if(tempval.equalsIgnoreCase("1"))
			{
			
			Statement stmtBalance=conn.createStatement(); 
			
			 java.sql.Date sqlFromDate = null;
		     java.sql.Date sqlToDate = null;
		     java.sql.Date analysisDate=null;
		     java.sql.Date analysisFromDate=null;
		     java.sql.Date analysisToDate=null;
		     String analysingDate="",analysingToDate="";
		     int amountLength=0,txtfrequency=0;
		      
		        if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
		     	{
		        	sqlFromDate=ClsCommon.changeStringtoSqlDate(fromdate);
		     		
		     	}
		     	else{
		     
		     	}

		       
		     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
		     	{
		     		sqlToDate=ClsCommon.changeStringtoSqlDate(todate);
		     		
		     	}
		     	else{ 
		     		
		     		
		     
		     	}
		     	
		     	
		     	
				String sqltest="";
				if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
					sqltest+=" and m.brhid="+branch+"";
				}
				String sqlselect="";
	 			String sqlgroup="";
	 			String sqlmtypeselect="";
		/*		String sqlgroupdet=""; */
				
				 
				 
	 	 /*
				if(grpby1.equalsIgnoreCase("fleetno")){
					 
					
					sqlgroup= " m.fleetno refno,v.flname description,";
					
					sqlselect= " group by m.fleetno";

				}
				else if(grpby1.equalsIgnoreCase("brand"))
				{
					sqlgroup= " v.brdid refno,br.brand_name description,";
					
					sqlselect= " group by br.doc_no";	
				}
				else if(grpby1.equalsIgnoreCase("model"))
				{
					sqlgroup= " v.vmodid refno,mo.vtype description,";
					
					sqlselect= " group by mo.doc_no";	
				}
				else if(grpby1.equalsIgnoreCase("yom"))
				{
					sqlgroup= " v.yom refno,y.yom description,";
					sqlselect= " group by y.doc_no";	
				}
				else if(grpby1.equalsIgnoreCase("mtype"))
				{
					sqlgroup= " rp.docno refno,rp.mtype description,";
					sqlmtypeselect= " group by rp.mtype";	
				}
				else if(grpby1.equalsIgnoreCase("mdesc"))
				{
					sqlgroup= " rp.docno refno,rp.name description,";
					sqlselect= " group by rp.docno";	
				}
				else
				{
					sqlselect=" group by m.doc_no ";
				}*/

				if(grpby1.equalsIgnoreCase("fleetno")){
					 
					
					sqlgroup= " m.fleetno refno,v.flname description,";
					
					sqlselect= " group by refno";

				}
				else if(grpby1.equalsIgnoreCase("brand"))
				{
					sqlgroup= " v.brdid refno,br.brand_name description,";
					
					sqlselect= " group by refno";	
				}
				else if(grpby1.equalsIgnoreCase("model"))
				{
					sqlgroup= " v.vmodid refno,mo.vtype description,";
					
					sqlselect= " group by refno";	
				}
				else if(grpby1.equalsIgnoreCase("yom"))
				{
					sqlgroup= " v.yom refno,y.yom description,";
					sqlselect= " group by refno";	
				}
				else if(grpby1.equalsIgnoreCase("mtype"))
				{
					sqlgroup= " rp.docno refno,rp.mtype description,";
					sqlselect= " group by a.description";	
				}
				else if(grpby1.equalsIgnoreCase("mdesc"))
				{
					sqlgroup= " rp.docno refno,rp.name description,";
					sqlselect= " group by refno";	
				}
				
								 
				if(!(hidfleet.equalsIgnoreCase("undefined"))&&!(hidfleet.equalsIgnoreCase(""))&&!(hidfleet.equalsIgnoreCase("0")))
		     	{
					sqltest+=" and m.fleetno in("+hidfleet+") " ;
		     		
		     	}
			 
				if(!(hidbrand.equalsIgnoreCase("undefined"))&&!(hidbrand.equalsIgnoreCase(""))&&!(hidbrand.equalsIgnoreCase("0")))
		     	{
					sqltest+=" and v.brdid in("+hidbrand+") " ;
		     		
		     	}
				
				
					if(!(hidmodel.equalsIgnoreCase("undefined"))&&!(hidmodel.equalsIgnoreCase(""))&&!(hidmodel.equalsIgnoreCase("0")))
			     	{
						sqltest+=" and v.vmodid in("+hidmodel+") " ;
			     		
			     	}
					
					if(!(hidyom.equalsIgnoreCase("undefined"))&&!(hidyom.equalsIgnoreCase(""))&&!(hidyom.equalsIgnoreCase("0")))
			     	{
						sqltest+=" and v.yom in("+hidyom+") " ;
			     		
			     	}
					
					if(!(hidmtype.equalsIgnoreCase("undefined"))&&!(hidmtype.equalsIgnoreCase(""))&&!(hidmtype.equalsIgnoreCase("0")))
			     	{
						sqltest+=" and rp.docno in("+hidmtype+") " ;
			     		
			     	}
		     	
		     	
		     	  ArrayList<String> analysiscolumnarray= new ArrayList<String>();
		     	  
		     	 //analysiscolumnarray.add(""+analysingDate+"::amount"+i+"::right::right:: :: ::d2::yellowClass::['sum']");
		     	  
				     analysiscolumnarray.add("Sr No::id::center::center:: ::5%:: ::headClass:: ");
				     analysiscolumnarray.add("Ref No::refno::center::center:: ::10%:: ::headClass:: ");
				     analysiscolumnarray.add("Description::description::left::left:: ::25%:: ::headClass:: ");
				     		     
			     String xsql="",xsqls="";
			     String sql = "",sql1 = "",sql2="",sql3="",sql4="";
			     String dayDiff="",monthDiff="";
		     	
		     	if(cmbfrequency.equalsIgnoreCase("2")){
			    	 
		    	 	String sqls = "select TIMESTAMPDIFF(MONTH, '"+sqlFromDate+"', '"+sqlToDate+"') monthdiff";
		    	    ResultSet rs1 = stmtBalance.executeQuery(sqls);
					
					while(rs1.next()) {
						txtfrequency=rs1.getInt("monthdiff");
					} 
					
					xsqls=1 + (cmbfrequency.equalsIgnoreCase("2")?" Month ":" Year ");
					
		     }
		     	
		     	else if(cmbfrequency.equalsIgnoreCase("3")){
			    	 
		    	    String sqls = "select TIMESTAMPDIFF(MONTH, '"+sqlFromDate+"', '"+sqlToDate+"') monthdiff";
		    	    ResultSet rs1 = stmtBalance.executeQuery(sqls);
					
					while(rs1.next()) {
						monthDiff=rs1.getString("monthdiff");
					} 
					
					String sqls1 = "select ("+monthDiff+"/3) monthdifference";
					ResultSet rs2 = stmtBalance.executeQuery(sqls1);
					
					while(rs2.next()) {
						txtfrequency=rs2.getInt("monthdifference");
					} 
		    	    
					xsqls= "3 Month";
					
		     }else if(cmbfrequency.equalsIgnoreCase("4")){

		    	 	String sqls = "select TIMESTAMPDIFF(YEAR, '"+sqlFromDate+"', '"+sqlToDate+"') yeardiff";
		    	 	ResultSet rs1 = stmtBalance.executeQuery(sqls);
					
					while(rs1.next()) {
						txtfrequency=rs1.getInt("yeardiff");
					} 
					
					xsqls=1 + (cmbfrequency.equalsIgnoreCase("2")?" Month ":" Year ");
		     }
		     	
		      	 if(cmbfrequency.equalsIgnoreCase("2")){
				     	
				     	analysisDate=sqlFromDate;
						for(int i=0;i<=txtfrequency;i++)
						{
						   
						   if(i==0){
							  // xsql= "Select LAST_DAY('"+analysisDate+"') analysisDate,CONCAT(DATE_FORMAT('"+analysisDate+"','%d-%m-%Y'),' To ',DATE_FORMAT(LAST_DAY('"+analysisDate+"'),'%d-%m-%Y')) analysisDates";
							  // xsql= "Select LAST_DAY('"+analysisDate+"') analysisDate, MONTHNAME('"+analysisDate+"') analysisDates";
							   xsql= "Select LAST_DAY('"+analysisDate+"') analysisDate,DATE_FORMAT('"+analysisDate+"','%b %Y') analysisDates";
							   
							   
							   ResultSet rs = stmtBalance.executeQuery(xsql);
							   
							   while(rs.next()){
								     analysisDate=rs.getDate("analysisDate");
								     analysingDate=rs.getString("analysisDates");
			
								   //  sql3+=" if (inv.date between '"+sqlFromDate+"' and '"+analysisDate+"',if(amount<0,amount*-1,amount),'') amount"+i+",";
								     sql3+=" if(m.postdate>='"+sqlFromDate+"'  and m.postdate<='"+analysisDate+"' ,coalesce(round(d.total,2),0),0) amount"+i+",";
								     sql4+= " if(sum(amount"+i+")<>0,sum(amount"+i+"),'') amount"+i+",";
									// temparray.add(" and inv.date between '"+sqlFromDate+"' and '"+analysisDate+"'");
								     amountLength=amountLength+1;
								     
								     analysiscolumnarray.add(""+analysingDate+"::amount"+i+"::right::right:: :: ::d2::yellowClass::['sum']");
							     }
							}else{
							    xsql= "Select DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day ) analysisFromDate,LAST_DAY(DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day )) analysisToDate,"
								   		+ "DATE_FORMAT(DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day ),'%b %Y') analysisDates,DATE_FORMAT(DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day ),'%b %Y') analysingDate"+
									   ",DATE_FORMAT(LAST_DAY(DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day )),'%b %Y') stranalysisToDate"; 
							   
							   
							/*   xsql= "Select DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day ) analysisFromDate,LAST_DAY(DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day )) analysisToDate,"
							           + "DATE_FORMAT(DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day ),'%b %Y') analysisDates,DATE_FORMAT('"+sqlToDate+"','%b %Y') analysingDate";
							   */
						//System.out.println("Month xsql:"+xsql);
														   ResultSet rs = stmtBalance.executeQuery(xsql);
								   
								   while(rs.next()){
									     analysisFromDate=rs.getDate("analysisFromDate");
									     analysisToDate=rs.getDate("analysisToDate");
									     analysingDate=rs.getString("analysisDates");
									     analysingToDate=rs.getString("analysingDate");
				
									     if(analysisToDate.after(sqlToDate) || analysisToDate.equals(sqlToDate)){
									    	   analysisToDate=sqlToDate;
									    	   analysingDate=rs.getString("stranalysisToDate");
									      }
									     
										     //sql3+=" if (inv.date between '"+analysisFromDate+"' and '"+analysisToDate+"',if(amount<0,amount*-1,amount),'') amount"+i+",";
										     
										     sql3+=" if(m.postdate>='"+analysisFromDate+"'  and m.postdate<='"+analysisToDate+"' ,coalesce(round(d.total,2),0),0) amount"+i+",";
										     sql4+= " if(sum(amount"+i+")<>0,sum(amount"+i+"),'') amount"+i+",";
										     
										     //temparray.add(" and inv.date between '"+analysisFromDate+"' and '"+analysisToDate+"'");
										     amountLength=amountLength+1;
										     
										     analysiscolumnarray.add(""+analysingDate+"::amount"+i+"::right::right:: ::8%::d2::yellowClass::['sum']");
									     
									         analysisDate=analysisToDate;
								     }
							   }
						   
						     if(analysisDate.after(sqlToDate) || analysisDate.equals(sqlToDate)){
						    	 break;
						     }
						}
						
				     }
		     	else if(cmbfrequency.equalsIgnoreCase("3")){
			     	
			     	analysisDate=sqlFromDate;
					for(int i=0;i<=txtfrequency;i++)
					{
					   
					   if(i==0){
						   xsql= "Select LAST_DAY(DATE_ADD(date('"+analysisDate+"'),INTERVAL 2 Month)) analysisDate,CONCAT(DATE_FORMAT('"+analysisDate+"','%b %Y'),' To ',DATE_FORMAT(LAST_DAY(DATE_ADD(date('"+analysisDate+"'),INTERVAL 2 Month)),'%b %Y')) analysisDates";
						   ResultSet rs = stmtBalance.executeQuery(xsql);
						   
						   while(rs.next()){
							     analysisDate=rs.getDate("analysisDate");
							     analysingDate=rs.getString("analysisDates");
		
							     sql3+=" if(m.postdate>='"+sqlFromDate+"'  and m.postdate<='"+analysisDate+"' ,coalesce(round(d.total,2),0),0) amount"+i+",";
							     sql4+= " if(sum(amount"+i+")<>0,sum(amount"+i+"),'') amount"+i+",";
							     amountLength=amountLength+1;
							     
							     analysiscolumnarray.add(""+analysingDate+"::amount"+i+"::right::right:: :: ::d2::yellowClass::['sum']");
						     }
						}else{
							   
							   xsql= "Select DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day ) analysisFromDate,LAST_DAY(DATE_ADD(date('"+analysisDate+"'),INTERVAL 3 Month )) analysisToDate,CONCAT(DATE_FORMAT(DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day ),'%b %Y'),' To ',"
							   		+ "DATE_FORMAT(LAST_DAY(DATE_ADD(date('"+analysisDate+"'),INTERVAL 3 Month )),'%b %Y')) analysisDates,CONCAT(DATE_FORMAT(DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day ),'%b %Y'),' To ',"
							   		+ "DATE_FORMAT('"+sqlToDate+"','%b %Y')) analysingDate";
							   
							   ResultSet rs = stmtBalance.executeQuery(xsql);
							   
							   while(rs.next()){
								     analysisFromDate=rs.getDate("analysisFromDate");
								     analysisToDate=rs.getDate("analysisToDate");
								     analysingDate=rs.getString("analysisDates");
								     analysingToDate=rs.getString("analysingDate");
			
								     if(analysisToDate.after(sqlToDate) || analysisToDate.equals(sqlToDate)){
								    	   analysisToDate=sqlToDate;
								    	   analysingDate=analysingToDate;
								      }
								     
								     sql3+=" if(m.postdate>='"+analysisFromDate+"'  and m.postdate<='"+analysisToDate+"' ,coalesce(round(d.total,2),0),0) amount"+i+",";
								     sql4+= " if(sum(amount"+i+")<>0,sum(amount"+i+"),'') amount"+i+",";
									     amountLength=amountLength+1;
									     
									     analysiscolumnarray.add(""+analysingDate+"::amount"+i+"::right::right:: ::12%::d2::yellowClass::['sum']");
								     
								         analysisDate=analysisToDate;
							     }
						   }
					   
					   if(analysisDate.after(sqlToDate) || analysisDate.equals(sqlToDate)){
					    	 break;
					     }
					}
					
			     }
		     	
		     	else if(cmbfrequency.equalsIgnoreCase("4")){
		     		
		     		analysisDate=sqlFromDate;
					for(int i=0;i<=txtfrequency;i++)
					{
					   
					   if(i==0){
						   String sqls = "SELECT YEAR('"+analysisDate+"') year";
						   ResultSet rs1 = stmtBalance.executeQuery(sqls);
						   
						   int year=0;
						   while(rs1.next()){
							    year=rs1.getInt("year");
						   }
						   
						   String sqls1= "SELECT TIMESTAMPDIFF(MONTH, '"+analysisDate+"', '"+year+"-12-31') noofmonths";
						   ResultSet rss = stmtBalance.executeQuery(sqls1);
						   
						   int noOfMonths=0;
						   while(rss.next()){
							     noOfMonths=rss.getInt("noofmonths");
						   }
						   
						   /*xsql= "Select LAST_DAY(DATE_ADD(date('"+analysisDate+"'),INTERVAL "+noOfMonths+" Month)) analysisDate,YEAR('"+analysisDate+"') analysisDates";*/
						   
						   xsql= "Select LAST_DAY(DATE_ADD(date('"+analysisDate+"'),INTERVAL "+noOfMonths+" Month)) analysisDate,DATE_FORMAT('"+analysisDate+"','%Y') analysisDates";
//						  System.out.println("year xsql: "+xsql);
						   ResultSet rs = stmtBalance.executeQuery(xsql);
						   
						   while(rs.next()){
							     analysisDate=rs.getDate("analysisDate");
							     analysingDate=rs.getString("analysisDates");
		
							     sql3+=" if(m.postdate>='"+sqlFromDate+"'  and m.postdate<='"+analysisDate+"' ,coalesce(round(d.total,2),0),0) amount"+i+",";
							     sql4+= " if(sum(amount"+i+")<>0,sum(amount"+i+"),'') amount"+i+",";
								 
							     amountLength=amountLength+1;
							     
							     analysiscolumnarray.add(""+analysingDate+"::amount"+i+"::right::right:: ::8%::d2::yellowClass::['sum']");
						     }
						}else{
							   
							   /*xsql= "Select DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day ) analysisFromDate,LAST_DAY(DATE_ADD(date('"+analysisDate+"'),INTERVAL 12 Month )) analysisToDate,YEAR(DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day )) analysisDates,CONCAT(DATE_FORMAT(DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day ),'%d-%m-%Y'),' To ',"
							   		+ "DATE_FORMAT('"+sqlToDate+"','%d-%m-%Y')) analysingDate,YEAR(LAST_DAY(DATE_ADD(date('"+analysisDate+"'),INTERVAL 12 Month ))) stranalysisToDate";*/
									
							  xsql= "Select DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day ) analysisFromDate,LAST_DAY(DATE_ADD(date('"+analysisDate+"'),INTERVAL 12 Month )) analysisToDate,"
									+ "DATE_FORMAT(DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day ),'%Y') analysisDates,DATE_FORMAT('"+sqlToDate+"','%Y') analysingDate";
							   
							   
							   ResultSet rs = stmtBalance.executeQuery(xsql);
							   
							   while(rs.next()){
								     analysisFromDate=rs.getDate("analysisFromDate");
								     analysisToDate=rs.getDate("analysisToDate");
								     analysingDate=rs.getString("analysisDates");
								     analysingToDate=rs.getString("analysingDate");
			
								     if(analysisToDate.after(sqlToDate) || analysisToDate.equals(sqlToDate)){
								    	   analysisToDate=sqlToDate;
								    	   analysingDate=rs.getString("analysingDate");
								      }
								     
								     sql3+=" if(m.postdate>='"+analysisFromDate+"'  and m.postdate<='"+analysisToDate+"' ,coalesce(round(d.total,2),0),0) amount"+i+",";
								     sql4+= " if(sum(amount"+i+")<>0,sum(amount"+i+"),'') amount"+i+",";
										 
									     amountLength=amountLength+1;
									     
									     analysiscolumnarray.add(""+analysingDate+"::amount"+i+"::right::right:: ::8%::d2::yellowClass::['sum']");
								     
								         analysisDate=analysisToDate;
							     }
						   }
					   
					   if(analysisDate.after(sqlToDate) || analysisDate.equals(sqlToDate)){
					    	 break;
					     }
					}
		     	}
			
			String strSql="select "+sql4+" @i:=@i+1 id,refno,description from(	\r\n" + 		 
					"select "+sql3+" m.doc_no,"+sqlgroup+" m.postdate   "+
					"  from gl_vmcostm m left join gl_vcostd d on m.doc_no=d.rdocno left join gl_vrepm rp on rp.mtype=d.type and d.repdesc=rp.name left join gl_vehmaster v on v.fleet_no=m.fleetno\r\n" + 
					"left join gl_yom y on y.doc_no=v.yom left join gl_vehbrand br on br.doc_no=v.brdid left join gl_vehmodel mo on mo.doc_no=v.vmodid\r\n" + 
					
		 			" where m.status=3 and\r\n" + 
					" if(m.dtype='MWO',m.psstatus,if(m.dtype='MRU',coalesce(m.trno,0),0))>0 and m.postdate between '"+sqlFromDate+"' and '"+sqlToDate+"' "+sqltest+" ) a,(SELECT @i:= 0) as i where 1=1 "+sqlselect+" order by id ";
			

			// System.out.println("--------------sdaf-mm-------"+strSql);
             	ResultSet resultSet = stmtBalance.executeQuery (strSql);
   			 ArrayList<ArrayList<String>> analysisrowarray= new ArrayList<ArrayList<String>>();
   			while(resultSet.next()){
				ArrayList<String> temp=new ArrayList<String>();
		
				temp.add(resultSet.getString("id"));
				temp.add(resultSet.getString("refno"));
				temp.add(resultSet.getString("description"));
				//temp.add(resultSet.getString("amount"));
				//System.out.println(amtarray);
				for (int l = 0; l < amountLength; l++) {
					temp.add(resultSet.getString("amount"+l+""));
					//temp.add(amtarray.get(l)+"l");
				}
				
				analysisrowarray.add(temp);
			}
			
		 COLUMNDATA=convertColumnAnalysisArrayToJSON(analysiscolumnarray);
		 ROWDATA=convertRowAnalysisArrayToJSON(analysisrowarray);
		 
		 JSONArray analysisarray=new JSONArray();
		 
		 analysisarray.addAll(COLUMNDATA);
		 analysisarray.addAll(ROWDATA);
		
		 RESULTDATA=analysisarray;
		// System.out.println("====== "+RESULTDATA);		
        		stmtBalance.close();
				conn.close();
				
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
        return RESULTDATA;
    }
	
public  JSONArray convertColumnAnalysisArrayToJSON(ArrayList<String> columnsAnalysisList) throws Exception {
	JSONArray jsonArray = new JSONArray();
	JSONArray jsonArray1 = new JSONArray();
	
	for (int i = 0; i < columnsAnalysisList.size(); i++) {
		
		JSONObject obj = new JSONObject();
		
		String[] analysisColumnArray=columnsAnalysisList.get(i).split("::");
		
		obj.put("text",analysisColumnArray[0]);
		obj.put("datafield",analysisColumnArray[1]);
		obj.put("cellsAlign",analysisColumnArray[2]);
		obj.put("align",analysisColumnArray[3]);
		if(!(analysisColumnArray[4].trim().equalsIgnoreCase(""))){
			obj.put("hidden",analysisColumnArray[4]);
	    }
		if(!(analysisColumnArray[5].trim().equalsIgnoreCase(""))){
			obj.put("width",analysisColumnArray[5]);
	    }
		if(!(analysisColumnArray[6].trim().equalsIgnoreCase(""))){
		    obj.put("cellsFormat",analysisColumnArray[6]);
		}
		if(!(analysisColumnArray[7].trim().equalsIgnoreCase(""))){
		    obj.put("cellclassname",analysisColumnArray[7]);
		}
		if(!(analysisColumnArray[8].trim().equalsIgnoreCase(""))){
		    obj.put("aggregates",analysisColumnArray[8]);
		}
		
		
		jsonArray.add(obj);
	}
	JSONObject obj1 = new JSONObject();
	obj1.put("columns",jsonArray);
	jsonArray1.add(obj1);
	return jsonArray1;
	}

public  JSONArray convertRowAnalysisArrayToJSON(ArrayList<ArrayList<String>> rowsAnalysisList) throws Exception {
	JSONArray jsonArray = new JSONArray();
	JSONArray jsonArray1 = new JSONArray();
	
	for (int i = 0; i < rowsAnalysisList.size(); i++) {
		
		JSONObject obj = new JSONObject();
		
		ArrayList<String> analysisRowArray=rowsAnalysisList.get(i);
		
		int length = analysisRowArray.size();
		
		obj.put("id",analysisRowArray.get(0));
		obj.put("refno",analysisRowArray.get(1));
		obj.put("description",analysisRowArray.get(2));
 
		for (int j = 3,k=0; j < length; j++,k++) {
			if(!(analysisRowArray.get(j).trim().equalsIgnoreCase(""))){
				obj.put("amount"+k,analysisRowArray.get(j));
			}
		}
		
		jsonArray.add(obj);
	}
	JSONObject obj1 = new JSONObject();
	obj1.put("rows",jsonArray);
	jsonArray1.add(obj1);
	return jsonArray1;
	}

	
	
	public JSONArray getFleet() throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        Connection  conn =null;
		try {
//			System.out.println("Here");
			conn=ClsConnection.getMyConnection();
			Statement stmtsales=conn.createStatement();
				String strSql="select veh.doc_no,veh.fleet_no,veh.flname,veh.reg_no,plate.code_name plate from gl_vmcostm m left join gl_vehmaster veh  on m.fleetno=veh.fleet_no left join gl_vehplate plate on veh.pltid=plate.doc_no where m.status=3 group by m.fleetno";
              	System.out.println(strSql);
				ResultSet resultSet = stmtsales.executeQuery (strSql);
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
	
	public JSONArray getMtype() throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        Connection  conn =null;
		try {
//			System.out.println("Here");
			conn=ClsConnection.getMyConnection();
			Statement stmtsales=conn.createStatement();
				String strSql="select docno,mtype,name from gl_vrepm m where m.status=3 ";
              //	System.out.println(strSql);
				ResultSet resultSet = stmtsales.executeQuery (strSql);
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
	
	
	public JSONArray getBrand() throws SQLException { 
        JSONArray RESULTDATA=new JSONArray();
        Connection  conn =null;
		try {
			conn=ClsConnection.getMyConnection();
			Statement stmtsales=conn.createStatement();
				String strSql="select br.doc_no,br.brand_name brand  from gl_vmcostm m \r\n" + 
						"left join gl_vehmaster v on v.fleet_no=m.fleetno left join gl_vehbrand br on br.doc_no=v.brdid   where m.status=3 group by br.doc_no;";
             	ResultSet resultSet = stmtsales.executeQuery (strSql);
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
	public JSONArray getModel() throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        Connection  conn =null;
		try {
			conn=ClsConnection.getMyConnection();
			Statement stmtsales=conn.createStatement();
				String strSql="			select model.doc_no,model.vtype model from   gl_vmcostm m \r\n" + 
						"left join gl_vehmaster v on v.fleet_no=m.fleetno left join gl_vehmodel model on model.doc_no=v.vmodid \r\n" + 
						"where m.status=3 group by model.doc_no;";
             	ResultSet resultSet = stmtsales.executeQuery (strSql);
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
	
	
	public JSONArray getYom() throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        Connection  conn =null;
		try {
			conn=ClsConnection.getMyConnection();
			Statement stmtsales=conn.createStatement();
				String strSql="select y.doc_no,y.yom from gl_vmcostm m \r\n" + 
						"left join gl_vehmaster v on v.fleet_no=m.fleetno left join gl_yom y on v.yom=y.doc_no where m.status=3 group by y.doc_no";
             	ResultSet resultSet = stmtsales.executeQuery (strSql);
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
