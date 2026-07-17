package com.dashboard.workshop.gateoutpass;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.dashboard.workshop.releasevehicle.ClsReleaseVehicleBean;

import net.sf.json.JSONArray;

public class ClsGateOutPassDAO {

	ClsCommon objcommon=new ClsCommon();
	ClsConnection objconn=new ClsConnection();
	public JSONArray getGateOutData(String fromdate,String todate,String id,String gatedocno,
			String regno,String cldocno,String status,String brhid)throws SQLException
	{
		JSONArray goutdata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return goutdata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			java.sql.Date sqlfromdate=null,sqltodate=null;
			if(!fromdate.equalsIgnoreCase("") && fromdate!=null){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
			}
			if(!todate.equalsIgnoreCase("") && todate!=null){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
			}
			String sqltest="";
			if(!gatedocno.equalsIgnoreCase("")){
				sqltest+=" and gate.doc_no="+gatedocno;
			}
			if(!regno.equalsIgnoreCase("")){
				sqltest+=" and gate.regno="+regno;
			}
			if(!cldocno.equalsIgnoreCase("")){
				sqltest+=" and ac.cldocno="+cldocno;
			}
			if(!brhid.trim().equalsIgnoreCase("") && !brhid.trim().equalsIgnoreCase("a")){
				sqltest+=" and gate.brhid="+brhid;
			}
			Statement stmt=conn.createStatement();
			/*String strsql="select gate.kmin kilometer,gate.fuel,gate.voc_no,gate.doc_no gipdocno,gate.date,ac.refname,convert(concat(coalesce(brd.brand_name,''),' ',coalesce(model.vtype,''),' ',coalesce(yom.yom,''),' reg no: ',coalesce(gate.regno,''),' ',coalesce(plate.code_name,''),' Others: ', coalesce(gate.vehother,'')),char(200)) vehicledetails"
						+" from ws_invm invm left join ws_jobcard job on (invm.reftype='JC' and invm.refno=job.doc_no)"
						+" left join ws_estm est on (job.reftype='EST' and job.refno=est.doc_no)"
						+" left join ws_gateinpass gate on (if(job.reftype='GIP',job.refno=gate.doc_no,est.gipno=gate.doc_no))"
						+" left join my_acbook ac on(gate.cldocno=ac.cldocno and ac.dtype='CRM')"
						+" left join gl_vehbrand brd on gate.brdid=brd.doc_no"
						+" left join gl_vehmodel model on gate.modid=model.doc_no"
						+" left join gl_vehplate plate on gate.pltid=plate.doc_no"
					
						+" left join gl_yom yom on gate.yom=yom.doc_no where invm.status=3 and gate.processstatus<7"+sqltest;*/
			String strsql="";
			if(status.equalsIgnoreCase("1")){
				if(sqlfromdate!=null){
					sqltest+=" and gate.date>='"+sqlfromdate+"'";
				}
				if(sqltodate!=null){
					sqltest+=" and gate.date<='"+sqltodate+"'";
				}
				strsql="select job.voc_no jobvocno,coalesce(gate.driver,'') driver,coalesce(wsa.sal_name,'') serviceadvisor,concat(date_format(outdate,'%d.%m.%Y'),' ',outtime) datetime,gate.processstatus,round(gate.outkm,2) kilometer,gate.fuel,gate.voc_no,gate.doc_no gipdocno,gate.date,ac.refname,convert(concat(coalesce(brd.brand_name,''),' ',coalesce(model.vtype,''),' ',coalesce(yom.yom,''),' reg no: ',coalesce(gate.regno,''),' ',coalesce(plate.code_name,''),' Others: ', coalesce(gate.vehother,'')),char(200)) vehicledetails,"
					+" case when outfuel=0.000 then 'Level 0/8' when outfuel=0.125 then 'Level 1/8' when outfuel=0.250 then 'Level 2/8' when outfuel=0.375 then 'Level 3/8'"
					+" when outfuel=0.500 then 'Level 4/8' when outfuel=0.625 then 'Level 5/8' when outfuel=0.750 then 'Level 6/8' when outfuel=0.875 then 'Level 7/8' when outfuel=1.000 then 'Level 8/8' end wfuel"
					+" from ws_jobcard job left join ws_estm est on (job.reftype='EST' and job.refno=est.doc_no)"
					+" left join ws_gateinpass gate on (if(job.reftype='GIP',job.refno=gate.doc_no,est.gipno=gate.doc_no))"
					+" left join my_acbook ac on(gate.cldocno=ac.cldocno and ac.dtype='CRM')"
					+" left join gl_vehbrand brd on gate.brdid=brd.doc_no"
					+" left join gl_vehmodel model on gate.modid=model.doc_no"
					+" left join gl_vehplate plate on gate.pltid=plate.doc_no left join my_salesman wsa on (gate.serviceadvisor=wsa.doc_no and wsa.sal_type='WSA') "
					+" left join gl_yom yom on gate.yom=yom.doc_no where gate.processstatus=8"+sqltest;
			
			}
			if(status.equalsIgnoreCase("2")){
				
				//Getting GOP Without Invoice Config
				String strgopconfig="select method from gl_config where field_nme='GOPWithoutInvoice'";
				int gopconfig=0;
				ResultSet rsgopconfig=stmt.executeQuery(strgopconfig);
				while(rsgopconfig.next()) {
					gopconfig=rsgopconfig.getInt("method");
				}
				if(gopconfig==0) {
					sqltest+=" and gate.processstatus in (7)";
				}
				else if(gopconfig>0) {
					sqltest+=" and gate.processstatus in (6,7)";
				}
				if(sqltodate!=null){
					sqltest+=" and gate.date<='"+sqltodate+"'";
					
				}
				strsql="select job.voc_no jobvocno,coalesce(gate.driver,'') driver,coalesce(wsa.sal_name,'') serviceadvisor,gate.processstatus,gate.kmin kilometer,gate.fuel,gate.voc_no,gate.doc_no gipdocno,gate.date,ac.refname,convert(concat(coalesce(brd.brand_name,''),' ',coalesce(model.vtype,''),' ',coalesce(yom.yom,''),' reg no: ',coalesce(gate.regno,''),' ',coalesce(plate.code_name,''),' Others: ', coalesce(gate.vehother,'')),char(200)) vehicledetails,"
				 +" case when fuel=0.000 then 'Level 0/8' when fuel=0.125 then 'Level 1/8' when fuel=0.250 then 'Level 2/8' when fuel=0.375 then 'Level 3/8'"
					+" when fuel=0.500 then 'Level 4/8' when fuel=0.625 then 'Level 5/8' when fuel=0.750 then 'Level 6/8' when fuel=0.875 then 'Level 7/8' when fuel=1.000 then 'Level 8/8' end wfuel"
						+" from ws_jobcard job left join ws_estm est on (job.reftype='EST' and job.refno=est.doc_no)"
						+" left join ws_gateinpass gate on (if(job.reftype='GIP',job.refno=gate.doc_no,est.gipno=gate.doc_no))"
						+" left join my_acbook ac on(gate.cldocno=ac.cldocno and ac.dtype='CRM')"
						+" left join gl_vehbrand brd on gate.brdid=brd.doc_no"
						+" left join gl_vehmodel model on gate.modid=model.doc_no left join my_salesman wsa on (gate.serviceadvisor=wsa.doc_no and wsa.sal_type='WSA') "
						+" left join gl_vehplate plate on gate.pltid=plate.doc_no"
						+" left join gl_yom yom on gate.yom=yom.doc_no where 1=1 "+sqltest;
				
				}
	
			System.out.println("sql==**"+strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			goutdata=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return goutdata;
	}
	
	
	public JSONArray getGateOutExcelData(String fromdate,String todate,String id,String gatedocno,String regno,String cldocno,String status)throws SQLException
	{
		JSONArray goutdata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return goutdata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			java.sql.Date sqlfromdate=null,sqltodate=null;
			if(!fromdate.equalsIgnoreCase("") && fromdate!=null){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
			}
			if(!todate.equalsIgnoreCase("") && todate!=null){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
			}
			String sqltest="";
			if(sqlfromdate!=null){
				sqltest+=" and gate.date>='"+sqlfromdate+"'";
			}
			if(sqltodate!=null){
				sqltest+=" and gate.date<='"+sqltodate+"'";
			}
			if(!gatedocno.equalsIgnoreCase("")){
				sqltest+=" and gate.doc_no="+gatedocno;
			}
			if(!regno.equalsIgnoreCase("")){
				sqltest+=" and gate.regno="+regno;
			}
			if(!cldocno.equalsIgnoreCase("")){
				sqltest+=" and ac.cldocno="+cldocno;
			}
			Statement stmt=conn.createStatement();
			/*String strsql="select gate.kmin kilometer,gate.fuel,gate.voc_no,gate.doc_no gipdocno,gate.date,ac.refname,convert(concat(coalesce(brd.brand_name,''),' ',coalesce(model.vtype,''),' ',coalesce(yom.yom,''),' reg no: ',coalesce(gate.regno,''),' ',coalesce(plate.code_name,''),' Others: ', coalesce(gate.vehother,'')),char(200)) vehicledetails"
						+" from ws_invm invm left join ws_jobcard job on (invm.reftype='JC' and invm.refno=job.doc_no)"
						+" left join ws_estm est on (job.reftype='EST' and job.refno=est.doc_no)"
						+" left join ws_gateinpass gate on (if(job.reftype='GIP',job.refno=gate.doc_no,est.gipno=gate.doc_no))"
						+" left join my_acbook ac on(gate.cldocno=ac.cldocno and ac.dtype='CRM')"
						+" left join gl_vehbrand brd on gate.brdid=brd.doc_no"
						+" left join gl_vehmodel model on gate.modid=model.doc_no"
						+" left join gl_vehplate plate on gate.pltid=plate.doc_no"
					
						+" left join gl_yom yom on gate.yom=yom.doc_no where invm.status=3 and gate.processstatus<7"+sqltest;*/
			String strsql="";
			if(status.equalsIgnoreCase("1")){
			 strsql="select gate.voc_no 'GIP No',date_format(gate.date,'%d.%m.%Y') 'Date',ac.refname 'User Name',convert(concat(coalesce(brd.brand_name,''),"+
			" ' ',coalesce(model.vtype,''),' ',coalesce(yom.yom,''),' reg no: ',coalesce(gate.regno,''),' ',coalesce(plate.code_name,''),' Others: ', "+
			" coalesce(gate.vehother,'')),char(200)) 'Vehicle Details',gate.kmin 'Kilometers',case when fuel=0.000 then 'Level 0/8' when fuel=0.125 then "+
			" 'Level 1/8' when fuel=0.250 then 'Level 2/8' when fuel=0.375 then 'Level 3/8' when fuel=0.500 then 'Level 4/8' when fuel=0.625 then "+
			" 'Level 5/8' when fuel=0.750 then 'Level 6/8' when fuel=0.875 then 'Level 7/8' when fuel=1.000 then 'Level 8/8' end 'Fuel' "+
			" from ws_jobcard job left join ws_estm est on (job.reftype='EST' and job.refno=est.doc_no)"
					+" left join ws_gateinpass gate on (if(job.reftype='GIP',job.refno=gate.doc_no,est.gipno=gate.doc_no))"
					+" left join my_acbook ac on(gate.cldocno=ac.cldocno and ac.dtype='CRM')"
					+" left join gl_vehbrand brd on gate.brdid=brd.doc_no"
					+" left join gl_vehmodel model on gate.modid=model.doc_no"
					+" left join gl_vehplate plate on gate.pltid=plate.doc_no"
					+" left join gl_yom yom on gate.yom=yom.doc_no where gate.processstatus=8"+sqltest;
			
			}
			if(status.equalsIgnoreCase("2")){
				strsql="select gate.voc_no 'GIP No',date_format(gate.date,'%d.%m.%Y') 'Date',ac.refname 'User Name',convert(concat(coalesce(brd.brand_name,''),"+
						" ' ',coalesce(model.vtype,''),' ',coalesce(yom.yom,''),' reg no: ',coalesce(gate.regno,''),' ',coalesce(plate.code_name,''),' Others: ', "+
						" coalesce(gate.vehother,'')),char(200)) 'Vehicle Details',gate.kmin 'Kilometers',case when fuel=0.000 then 'Level 0/8' when fuel=0.125 then "+
						" 'Level 1/8' when fuel=0.250 then 'Level 2/8' when fuel=0.375 then 'Level 3/8' when fuel=0.500 then 'Level 4/8' when fuel=0.625 then "+
						" 'Level 5/8' when fuel=0.750 then 'Level 6/8' when fuel=0.875 then 'Level 7/8' when fuel=1.000 then 'Level 8/8' end 'Fuel' "+
						" from ws_jobcard job left join ws_estm est on (job.reftype='EST' and job.refno=est.doc_no)"
						+" left join ws_gateinpass gate on (if(job.reftype='GIP',job.refno=gate.doc_no,est.gipno=gate.doc_no))"
						+" left join my_acbook ac on(gate.cldocno=ac.cldocno and ac.dtype='CRM')"
						+" left join gl_vehbrand brd on gate.brdid=brd.doc_no"
						+" left join gl_vehmodel model on gate.modid=model.doc_no"
						+" left join gl_vehplate plate on gate.pltid=plate.doc_no"
						+" left join gl_yom yom on gate.yom=yom.doc_no where gate.processstatus in (7,10)"+sqltest;
				
				}
	
			System.out.println(strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			goutdata=objcommon.convertToEXCEL(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return goutdata;
	}
	public JSONArray getGateInPassData(String id,String gatedocno,String gateregno,String clientname,String date) throws SQLException{
		JSONArray data=new JSONArray();
		/*if(!id.equalsIgnoreCase("1")){
			return data;
		}*/
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="";
			String sqltest="";
			java.sql.Date sqldate=null;
			if(!gatedocno.equalsIgnoreCase("")){
				sqltest+=" and gate.doc_no like '%"+gatedocno+"%'";
			}
			if(!gateregno.equalsIgnoreCase("")){
				sqltest+=" and gate.regno like '%"+gateregno+"%'";
			}
			if(!clientname.equalsIgnoreCase("")){
				sqltest+=" and ac.refname like '%"+clientname+"%'";
			}
			if(!date.equalsIgnoreCase("")){
				sqldate=objcommon.changeStringtoSqlDate(date);
				sqltest+=" and gate.date='"+sqldate+"'";
			}
			strsql="select gate.doc_no,gate.regno,ac.refname,gate.date from ws_gateinpass gate"
					+" left join my_acbook ac on (gate.cldocno=ac.cldocno and ac.dtype='CRM') where 1=1"+sqltest;
			System.out.println("Gate:"+strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			data=objcommon.convertToJSON(rs);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return data;
		
	}
	
	public JSONArray clientDetailsGridReloading(String cl_name,String chk) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        if(!chk.equalsIgnoreCase("1")){
			return RESULTDATA;
		}
        Connection conn = null;
        
		try {
				conn = objconn.getMyConnection();
				Statement stmtCRM = conn.createStatement();
				String sqltest="";
				if(!cl_name.equalsIgnoreCase("")){
					//System.out.println("sqltest");
					 sqltest+=" and RefName like'%"+cl_name+"%'";
				}
				String sqlqry="SELECT RefName clname,cldocno FROM my_acbook where dtype='CRM' and status<>7"+sqltest;
				ResultSet resultSet = stmtCRM.executeQuery (sqlqry);
                
				
				
				RESULTDATA=objcommon.convertToJSON(resultSet);
				
				stmtCRM.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
		return RESULTDATA;
		
    }
	public JSONArray driversearch() throws SQLException {  
        JSONArray RESULTDATA=new JSONArray();
        Connection conn = null;
        
		try {
				conn = objconn.getMyConnection();
				Statement stmtCRM = conn.createStatement();
				
				String sqlqry="select doc_no,sal_name driver,sal_type from my_salesman where status<>7 and sal_type in('DRV','STF')";

				ResultSet resultSet = stmtCRM.executeQuery (sqlqry);  
				RESULTDATA=objcommon.convertToJSON(resultSet);
				
				stmtCRM.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
		return RESULTDATA;
		
    }
	
	
	public ClsGateOutPassBean  getPrint(int Docno)throws SQLException{
		ClsGateOutPassBean bean=new ClsGateOutPassBean();
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();

			String resql=("select concat(coalesce(ws.pltid,''),'  ',coalesce(ws.regno,'')) as regno,ws.date,job.voc_no jobno,"
					+ " concat(coalesce(br.brand_name,''),'  ',coalesce(md.vtype,'')) as type,ac.refname customer,u.user_name person,ws.other chasisno"
					+ " ,ws.vehother engineno,y.yom model,CURDATE() as currdate"
					+ " from ws_gateinpass ws left join gl_vehbrand br on br.doc_no=ws.brdid"
					+ " left join gl_vehmodel md on md.doc_no=ws.modid "
					+ " left join my_acbook ac on ac.cldocno=ws.cldocno "
					+ " left join my_user u on u.doc_no=ws.userid "
					+ "left join gl_yom y on y.doc_no=ws.yom left join ws_estm est on est.gipno=ws.doc_no left join ws_jobcard job on (est.doc_no=job.refno and job.reftype='EST') where ws.doc_no='"+Docno+"'");
			
			 
		 System.out.println("---printaction--resql----"+resql);
			
			ResultSet pintrs = stmt.executeQuery(resql);
			
	 
		       while(pintrs.next()){
		    	
		    	
		    	    
		    	   bean.setLblrvehicleno(pintrs.getString("regno"));
		    	   bean.setLbldate(pintrs.getString("date"));
		    	   bean.setLbljobno(pintrs.getString("jobno"));
		    	   bean.setLbltype(pintrs.getString("type"));
		    	   bean.setLblcustomer(pintrs.getString("customer"));
		    	   bean.setLblperson(pintrs.getString("person"));
		    	   bean.setLblchasisno(pintrs.getString("chasisno"));
		    	   bean.setLblengineno(pintrs.getString("engineno"));
		    	   bean.setLblmodel(pintrs.getString("model"));
		    	   bean.setLbltodat(pintrs.getString("currdate"));
   	 }
			

			
			
			
			stmt.close();
			Statement stmt10 = conn.createStatement ();
		    String  companysql="select coalesce(b.tinno,'') comptrno,b.branchname,c.company,c.address,c.tel,c.fax,l.loc_name location from ws_gateinpass r  "
		    		+ " left join my_brch b on r.brhid=b.doc_no left join my_locm l on l.brhid=b.doc_no "
		    		+ "left join my_comp c on b.cmpid=c.doc_no where r.doc_no="+Docno+"  ";

                 System.out.println("++++"+companysql);
	         ResultSet resultsetcompany = stmt10.executeQuery(companysql); 
		       
		       while(resultsetcompany.next()){
		    	   bean.setLblcomptrn(resultsetcompany.getString("comptrno"));
		    	   bean.setLblbranch(resultsetcompany.getString("branchname"));
		    	   bean.setLblcompname(resultsetcompany.getString("company"));
		    	  
		    	   bean.setLblcompaddress(resultsetcompany.getString("address"));
		    	   bean.setLblcomptel(resultsetcompany.getString("tel"));
		    	  
		    	   bean.setLblcompfax(resultsetcompany.getString("fax"));
		    	   bean.setLbllocation(resultsetcompany.getString("location"));
		    	  
		    	   
		    	   
		       } 
		     stmt10.close();
			
			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return bean;
	}
}
