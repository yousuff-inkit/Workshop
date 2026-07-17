package com.dashboard.workshop.invoicelist;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import java.sql.*;

import net.sf.json.JSONArray;
public class ClsWSInvoiceListDAO {

	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();

	public JSONArray getInvoiceData(String branch,String fromdate,String todate,String id,String acno,String regno) throws SQLException {
        JSONArray data=new JSONArray();
        if(!id.equalsIgnoreCase("1")){
        	return data;
        }
    	Connection conn = null;
		try {
			java.sql.Date sqlfromdate = null;
			java.sql.Date sqltodate = null;
	        if(!fromdate.equalsIgnoreCase(""))
	     	{
	     		sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
	     	}
	        if(!todate.equalsIgnoreCase(""))
	     	{
	     		sqltodate=objcommon.changeStringtoSqlDate(todate);
	     	}
	        String sqltest="";
	        if(sqlfromdate!=null){
	        	sqltest+=" and m.date>='"+sqlfromdate+"'";
	        }
	        if(sqltodate!=null){
	        	sqltest+=" and m.date<='"+sqltodate+"'";
	        }
	        if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
	        	sqltest+=" and m.brhid="+branch;
	        }
	        if(!acno.equalsIgnoreCase("")){
	        	sqltest+=" and invto.doc_no="+acno;
	        }
	        if(!regno.equalsIgnoreCase("")){
	        	sqltest+=" and gate.regno="+regno;
	        }
	     	conn = objconn.getMyConnection();
			Statement stmt = conn.createStatement ();
			String sql="select ym.yom yom,clr.color color,model.vtype model,brand.brand_name brand,rt.name repairtype,wsa3.sal_name refered,wsa2.sal_name insurveyor,wsa1.sal_name estimator,wsa.sal_name serviceadvisor,sal.sal_name salesman,cat.category,jv.outamt outamount,m.taxtotal-jv.outamt balance,ac.per_mob,gate.regno,m.doc_no invdocno,m.voc_no invvocno,m.date invdate,job.voc_no jobvocno,est.voc_no estvocno,gate.voc_no gatevocno,"+
			" invto.account,invto.doc_no invtoacno,invto.description invtoacname,m.total,m.discount,m.excess,m.nettotal,m.taxamount,m.taxtotal,"+
			" m.roundamt from ws_invm m left join ws_jobcard job on (m.reftype='JC' and m.refno=job.doc_no) left join ws_estm est on"+
			" (job.reftype='EST' and job.refno=est.doc_no) left join ws_gateinpass gate on est.gipno=gate.doc_no left join my_head invto on"+
			" m.invoicetoacno=invto.doc_no  left join my_acbook ac on invto.doc_no=ac.acno left join my_clcatm cat on ac.catid=cat.doc_no"+
			" left join my_salm sal on ac.sal_id=sal.doc_no left join my_salesman wsa on (gate.serviceadvisor=wsa.doc_no and wsa.sal_type='WSA')"+
			" left join (select sum(out_amount) outamt,tr_no from my_jvtran group by tr_no) jv on m.tr_no=jv.tr_no  left join my_salesman wsa1 on (gate.marketingperson=wsa1.doc_no and wsa1.sal_type='WMP') left join my_salesman wsa2 on (gate.insurancesurvivor=wsa2.doc_no and wsa2.sal_type='WIS')left join my_salesman wsa3 on (gate.referencedby=wsa3.doc_no and wsa3.sal_type='WRB') "+
			" left join ws_gartype rt on rt.row_no=gate.repairtype left join gl_vehbrand brand on brand.doc_no=gate.brdid "+
			" left join gl_vehmodel model on model.doc_no=gate.modid left join my_color clr on clr.doc_no=gate.colorid "+
			" left join gl_yom ym on ym.doc_no=gate.yom where m.status=3"+sqltest;
			
			System.out.println("grid loading====="+sql);
              
            ResultSet resultSet = stmt.executeQuery(sql);
            data=objcommon.convertToJSON(resultSet);
 			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return data;
    }
	
	public JSONArray getInvoiceExcelData(String branch,String fromdate,String todate,String id,String acno,String regno) throws SQLException {
        JSONArray data=new JSONArray();
        if(!id.equalsIgnoreCase("1")){
        	return data;
        }
    	Connection conn = null;
		try {
			java.sql.Date sqlfromdate = null;
			java.sql.Date sqltodate = null;
	        if(!fromdate.equalsIgnoreCase(""))
	     	{
	     		sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
	     	}
	        if(!todate.equalsIgnoreCase(""))
	     	{
	     		sqltodate=objcommon.changeStringtoSqlDate(todate);
	     	}
	        String sqltest="";
	        if(sqlfromdate!=null){
	        	sqltest+=" and m.date>='"+sqlfromdate+"'";
	        }
	        if(sqltodate!=null){
	        	sqltest+=" and m.date<='"+sqltodate+"'";
	        }
	        if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
	        	sqltest+=" and m.brhid="+branch;
	        }
	        if(!acno.equalsIgnoreCase("")){
	        	sqltest+=" and invto.doc_no="+acno;
	        }
	        if(!regno.equalsIgnoreCase("")){
	        	sqltest+=" and gate.regno="+regno;
	        }
	     	conn = objconn.getMyConnection();
			Statement stmt = conn.createStatement();
			String sql="select m.voc_no 'Inv No',date_format(m.date,'%d.%m.%Y') 'Inv Date',job.voc_no 'Job No',gate.regno 'Reg No',ym.yom 'YOM',clr.color 'Color',model.vtype 'Model',brand.brand_name 'Brand',rt.name 'Repair Type', "+
			" invto.account 'Ac No',invto.description 'Ac Name',coalesce(ac.per_mob,'') 'Mobile',round(m.total,2) 'Total',round(m.discount,2) 'Discount',round(m.nettotal,2) "+
			" 'Net Total',round(m.taxamount,2) 'Tax Amount',round(m.roundamt,2) 'Round Amt',round(m.taxtotal,2) 'Net Bill',round(jv.outamt,2) 'Out Amount',"+
			" round(m.taxtotal-jv.outamt,2) 'Balance',coalesce(cat.category,'') 'Category',coalesce(sal.sal_name,'') 'Salesman',coalesce(wsa.sal_name,'') 'Service Advisor' ,wsa1.sal_name 'Estimator',wsa2.sal_name 'Ins.Surveyor',wsa3.sal_name 'Referred By' from ws_invm m left join "+
			" ws_jobcard job on (m.reftype='JC' and m.refno=job.doc_no) left join ws_estm est on"+
			" (job.reftype='EST' and job.refno=est.doc_no) left join ws_gateinpass gate on est.gipno=gate.doc_no left join my_head invto on"+
			" m.invoicetoacno=invto.doc_no left join my_acbook ac on invto.doc_no=ac.acno left join my_clcatm cat on ac.catid=cat.doc_no"+
			" left join my_salm sal on ac.sal_id=sal.doc_no left join my_salesman wsa on (gate.serviceadvisor=wsa.doc_no and wsa.sal_type='WSA')"+
			" left join (select sum(out_amount) outamt,tr_no from my_jvtran group by tr_no) jv on m.tr_no=jv.tr_no left join my_salesman wsa1 on (gate.marketingperson=wsa1.doc_no and wsa1.sal_type='WMP') left join my_salesman wsa2 on (gate.insurancesurvivor=wsa2.doc_no and wsa2.sal_type='WIS')left join my_salesman wsa3 on (gate.referencedby=wsa3.doc_no and wsa3.sal_type='WRB') "+
			" left join ws_gartype rt on rt.row_no=gate.repairtype left join gl_vehbrand brand on brand.doc_no=gate.brdid "+
			" left join gl_vehmodel model on model.doc_no=gate.modid left join my_color clr on clr.doc_no=gate.colorid "+
			" left join gl_yom ym on ym.doc_no=gate.yom where m.status=3"+sqltest;
			
			System.out.println("excel data==="+sql);
              
            ResultSet resultSet = stmt.executeQuery(sql);
            data=objcommon.convertToEXCEL(resultSet);
 			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return data;
    }
	public JSONArray getAccountSearchData(String clientname,String docno,String type,String id) throws SQLException {
	    
		System.out.println("Parameters:"+clientname+"::"+docno+"::"+id+"::"+type);
	    JSONArray RESULTDATA1=new JSONArray();
	    if(!(id.equalsIgnoreCase("1"))){
	    	return RESULTDATA1;
	    }
	    Connection conn=null;
	    
	    try {
	    	    conn = objconn.getMyConnection();
		        Statement stmtclient = conn.createStatement();
			
	    	    String sql = "";
	    	    String sqll ="";
	    	    
	            if(!(clientname.equalsIgnoreCase(""))){
	             sql=sql+" and head.description like '%"+clientname+"%'";
	            }
	            if(!(docno.equalsIgnoreCase(""))){
	                sql=sql+" and head.account like '%"+docno+"%'";
	            }
	            
	            if(type.equalsIgnoreCase("1")){
	            	sql+=" and cat.insurance!=1";
	            }
	            if(type.equalsIgnoreCase("2")){
	            	sql+=" and cat.insurance=1";
	            }
	            	sqll = "select if(cat.insurance=1,'Insur.Company','Client') type,head.doc_no acno,head.account,head.description acname"
							+ " from my_acbook ac left join my_clcatm cat on ac.catid=cat.doc_no left join my_head head on ac.acno=head.doc_no where ac.dtype='crm' and ac.status=3"
							+ " and cat.status=3 "+sql;
	            
	            System.out.println(sqll);
				ResultSet resultSet1 = stmtclient.executeQuery(sqll);
				
				RESULTDATA1=objcommon.convertToJSON(resultSet1);
				
				stmtclient.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
	    return RESULTDATA1;
	}
	
	
	public JSONArray getRegnoData(String id) throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select regno,pltid platecode from ws_gateinpass where status=3 group by regno,pltid";
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
}
