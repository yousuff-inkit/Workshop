package com.dashboard.invoices.damageinvoicelist;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsDamageInvoiceListDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	
	public  JSONArray damageinvSearch(String branchval,String fromdate,String todate,String cldocno,String fleetno) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        java.sql.Date sqlfromdate = null;
        java.sql.Date sqltodate = null;
        if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
     	{
     		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
     		
     	}

        
        if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
     	{
     		sqltodate=ClsCommon.changeStringtoSqlDate(todate);
     		
     	}
     
	String sqltest="";
    	if(!cldocno.equalsIgnoreCase("")){
    		sqltest=sqltest+" and iv.cldocno='"+cldocno+"'";
    	}
    	if(!(fleetno.equalsIgnoreCase(""))){
    		sqltest=sqltest+" and vm.fleet_no='"+fleetno+"'";
    	}
    	
    	
    		
   
    	
    	
    	Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
			
            	if(branchval.equalsIgnoreCase("a"))
            	{

            		String sql =" SELECT vm.fleet_no,vm.reg_no,vp.code_no pltcode,iv.voc_no doc_no,br.branchname branch,iv.fromdate,iv.todate,h.account acno, h.description acname, convert(coalesce(sum(d.total),''),char(50)) amount ,vn.fine insurex ,vn.doc_no inspdocno,vn.type,vn.reftype,vn.refdocno\r\n" + 
            				"FROM gl_invm iv\r\n" + 
            				" left join gl_vinspm vn on iv.doc_no=vn.invno\r\n" + 
            				"  left join gl_vehmaster vm on vn.rfleet=vm.fleet_no\r\n" + 
            				"  left join gl_vehplate vp on vm.pltid=vp.doc_no\r\n" + 
            				"  left join gl_invd d on iv.doc_no=d.rdocno\r\n" + 
            				"  left join my_head h on h.doc_no=iv.acno left join my_brch br on iv.brhid=br.doc_no"
            				+ "  where vn.type='IN'"
            				+ " and iv.date between '"+sqlfromdate+"' and  '"+sqltodate+"' "+sqltest +" group by d.rdocno order by iv.doc_no";
//        System.out.println("============"+sql);
              
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
             		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
            		 stmtVeh.close();
            	}
            	else{	
            		
            		String sql ="SELECT vm.fleet_no,vm.reg_no,vp.code_no pltcode,iv.voc_no doc_no,br.branchname branch,iv.fromdate,iv.todate,h.account acno, h.description acname, convert(coalesce(sum(d.total),''),char(50)) amount ,vn.fine insurex ,vn.doc_no inspdocno,vn.type,vn.reftype,vn.refdocno\r\n" + 
            				"FROM gl_invm iv\r\n" + 
            				" left join gl_vinspm vn on iv.doc_no=vn.invno\r\n" + 
            				"  left join gl_vehmaster vm on vn.rfleet=vm.fleet_no\r\n" + 
            				"  left join gl_vehplate vp on vm.pltid=vp.doc_no\r\n" + 
            				"  left join gl_invd d on iv.doc_no=d.rdocno\r\n" + 
            				"  left join my_head h on h.doc_no=iv.acno left join my_brch br on iv.brhid=br.doc_no \r\n" + 
            			 " where vn.type='IN'" +
            				 " and iv.date between '"+sqlfromdate+"' and  '"+sqltodate+"' and iv.brhid='"+branchval+"' "+sqltest +" group by d.rdocno ";

            	  //  System.out.println("========2===="+sql);
     
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
         	 RESULTDATA=ClsCommon.convertToJSON(resultSet);
         	stmtVeh.close();
            	}
          
            	
 				conn.close();
		}
		catch(Exception e){
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
    


	public  JSONArray damageinvoicelistExcel(String branchval,String fromdate,String todate,String cldocno,String fleetno) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        java.sql.Date sqlfromdate = null;
        java.sql.Date sqltodate = null;
        if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
     	{
     		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
     		
     	}

        
        if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
     	{
     		sqltodate=ClsCommon.changeStringtoSqlDate(todate);
     		
     	}
     
	String sqltest="";
    	if(!cldocno.equalsIgnoreCase("")){
    		sqltest=sqltest+" and iv.cldocno='"+cldocno+"'";
    	}
    	if(!(fleetno.equalsIgnoreCase(""))){
    		sqltest=sqltest+" and vm.fleet_no='"+fleetno+"'";
    	}
    	
    	
    		
   
    	
    	
    	Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
			
            	if(branchval.equalsIgnoreCase("a"))
            	{

            		String sql =" SELECT vm.fleet_no 'Fleet No',vm.reg_no 'Reg No',vp.code_no 'Plate Code',iv.voc_no 'Invoice No',br.branchname 'Branch Name',iv.fromdate 'From Date',iv.todate 'To Date',h.account 'Account No', h.description 'Account Name', convert(coalesce(sum(d.total),''),char(50)) 'Amount' ,vn.fine 'Insurance Excess' ,vn.doc_no 'Inspection Doc No',vn.type 'Type',vn.reftype 'Ref Type',vn.refdocno 'Ref Doc No'\r\n" + 
            				"FROM gl_invm iv\r\n" + 
            				" left join gl_vinspm vn on iv.doc_no=vn.invno\r\n" + 
            				"  left join gl_vehmaster vm on vn.rfleet=vm.fleet_no\r\n" + 
            				"  left join gl_vehplate vp on vm.pltid=vp.doc_no\r\n" + 
            				"  left join gl_invd d on iv.doc_no=d.rdocno\r\n" + 
            				"  left join my_head h on h.doc_no=iv.acno left join my_brch br on iv.brhid=br.doc_no"
            				+ "  where vn.type='IN'"
            				+ " and iv.date between '"+sqlfromdate+"' and  '"+sqltodate+"' "+sqltest +" group by d.rdocno order by iv.doc_no";
//        System.out.println("============"+sql);
              
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
             		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
            		 stmtVeh.close();
            	}
            	else{	
            		
            		String sql ="SELECT vm.fleet_no 'Fleet No',vm.reg_no 'Reg No',vp.code_no 'Plate Code',iv.doc_no 'Invoice No',br.branchname 'Branch Name',iv.fromdate 'From Date',iv.todate 'To Date',h.account 'Account No', h.description 'Account Name', convert(coalesce(sum(d.total),''),char(50)) 'Amount' ,vn.fine 'Insurance Excess' ,vn.doc_no 'Inspection Doc No',vn.type 'Type',vn.reftype 'Ref Type',vn.refdocno 'Ref Doc No'\r\n" + 
            				"FROM gl_invm iv\r\n" + 
            				" left join gl_vinspm vn on iv.doc_no=vn.invno\r\n" + 
            				"  left join gl_vehmaster vm on vn.rfleet=vm.fleet_no\r\n" + 
            				"  left join gl_vehplate vp on vm.pltid=vp.doc_no\r\n" + 
            				"  left join gl_invd d on iv.doc_no=d.rdocno\r\n" + 
            				"  left join my_head h on h.doc_no=iv.acno left join my_brch br on iv.brhid=br.doc_no \r\n" + 
            			 " where vn.type='IN'" +
            				 " and iv.date between '"+sqlfromdate+"' and  '"+sqltodate+"' and iv.brhid='"+branchval+"' "+sqltest +" group by d.rdocno ";

            	  //  System.out.println("========2===="+sql);
     
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
         	 RESULTDATA=ClsCommon.convertToJSON(resultSet);
         	stmtVeh.close();
            	}
          
            	
 				conn.close();
		}
		catch(Exception e){
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }

	
	
	
	
	
	
	
	
	public  JSONArray fleetseachmove() throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
			String sql="select pl.code_name,m.fleet_no,m.flname,m.reg_no,convert(concat(' Fleet ',coalesce(m.FLEET_NO,''),'  ',coalesce(m.FLNAME,''),'  ',coalesce(REG_NO,''),   ' * ', au.authname,'  ', "
					+ " coalesce(pl.code_name,''),' * ', 'YOM  ',coalesce(y.YOM,''),'   ',coalesce(c.color,''), ' * ','Salik Tag   ',coalesce(m.SALIK_TAG,''),' * ',   'Exp ',' ','Reg : ',coalesce(m.REG_EXP,''),'  ' , "
					+ "'Ins :' ,coalesce(m.INS_EXP,''),' * ', 'Insured at  ' ,coalesce(i.inname,''),' * ',    'Last Service  ', 'Date : ',coalesce(m.SRVC_DTE,''),' ',' KM :',coalesce(m.SRVC_KM,''),' * ' , "
					+ " 'Warranty ', 'Date :' ,coalesce(m.WAR,''),'     ',   'KM :',coalesce(m.WAR_KM,''),' * ',   'Engine NO  ' ,coalesce(m.ENG_NO,''),' * ','Chassis NO ',coalesce(m.CH_NO,'')),char(1000)) vehinfo  "
					+ "      from gl_vehmaster m left join gl_vehgroup g on g.doc_no=m.VGRPID   left join my_color c on(m.clrid=c.doc_no)    left join gl_yom y on y.doc_no=m.yom   "
					+ "  left join gl_vehauth au on au.doc_no=m.authid  left join  gl_vehplate pl  on pl.doc_no=m.pltid left join gl_vehin i on i.doc_no=m.ins_comp where m.statu=3  order by  m.fleet_no";
				
            		//System.out.println(""+sql);
            		
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
     				stmtVeh.close();
     				conn.close();
            	
          

		}
		catch(Exception e){
			conn.close();	
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }

	
	
	
		
	public  JSONArray clientDetailsSearch() throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		    
		Connection conn = null;
	    
		  try {
		    conn = ClsConnection.getMyConnection();
		    Statement stmtsalik = conn.createStatement ();
		    
		    String sql = "";
			
			sql = "select cldocno,refname from my_acbook where status=3 and dtype='CRM'";
			
			ResultSet resultSet = stmtsalik.executeQuery(sql);
		                
		    RESULTDATA=ClsCommon.convertToJSON(resultSet);
		    stmtsalik.close();
		    conn.close();
		
		  }
		  catch(Exception e){
			  e.printStackTrace();
			  conn.close();
		  }
		  return RESULTDATA;
		}

}
