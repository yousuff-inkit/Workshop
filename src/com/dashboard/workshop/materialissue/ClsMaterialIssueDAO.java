package com.dashboard.workshop.materialissue;  

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsMaterialIssueDAO {

	
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();


public   JSONArray listsearch(HttpSession session,String branch,String aa,String cldocno,String docnoss) throws SQLException {

	
	JSONArray RESULTDATA=new JSONArray();
	
      
    
    Connection conn = null;
	try {
		conn = ClsConnection.getMyConnection();
		if(aa.equalsIgnoreCase("yes"))
		{	
		
			Statement stmtmain = conn.createStatement ();
			
			Statement stmt=conn.createStatement();
			int method=0;
			String chk="select method from  gl_prdconfig where field_nme='materialissueload' ";
			ResultSet rs=stmt.executeQuery(chk); 
			if(rs.next())
			{
				
				method=rs.getInt("method");
			}

			
			String sqltest="";
			
			if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
				
			 
					sqltest=sqltest+" and m.brhid='"+branch+"'";
				 
				
				
				
				
				}
			
			if(!(cldocno.equalsIgnoreCase("") || cldocno.equalsIgnoreCase("0"))){
				
				
				 
				 
					sqltest=sqltest+" and m.cldocno = '"+cldocno+"'";
				}
				
				
				
				
				
			
		
		 
			String sqltest1="";
			if(!(docnoss.equalsIgnoreCase(""))){
				sqltest1= " and a.costdocno = '"+docnoss+"'";
			}  
 
			
			  String pySql = " select a.* from (  select m.brhid, u.costgroup,t.type,m.description desc1,m.refno,m.doc_no,m.voc_no,m.date,m.issuetype,m.locid,l.loc_name, "
						+ " m.costtype,m.siteid,s.site,a.refname,m.cldocno,  case when m.costtype=1 then m.costdocno when m.costtype in(3,4) then co.doc_no "
						+ " when m.costtype in(5) then cs.doc_no  when m.costtype=9 then jo.voc_no else m.costdocno end as 'costdocno' ,  case when m.costtype=1 then  "
						+ " c.description when m.costtype in(3,4) then convert(concat(co.ref_type,' ',co.refdocno),char(100))  when m.costtype in (5) then  "
						+ " convert(concat(cs.contracttype,' ',cs.contractno),char(100))  when m.costtype in (9) then convert(concat(jo.reftype,''),char(100))  "
						+ " end as 'prjname'  from my_mreqm m left join my_locm l on l.doc_no=m.locid left join my_issuetype t on t.doc_no=m.issuetype left join my_costunit u " 
						+ "	on u.costtype=m.costtype   left join my_ccentre c on c.costcode=m.costdocno and m.costtype=1  left join cm_srvcontrm co on co.tr_no=m.costdocno "
						+ "and m.costtype in(3,4)  left join cm_cuscallm cs on cs.tr_no=m.costdocno and m.costtype=5  left join cm_srvcsited s on s.rowno=m.siteid and "
						+ " m.costtype in(3,4,5)  left join ws_jobcard jo on jo.doc_no=m.costdocno and m.costtype in (9)  left join my_acbook a on a.cldocno=m.cldocno and m.costtype "
						+ " in(3,4,5,9) and a.dtype='CRM'   left join my_mreqd d on d.rdocno=m.doc_no  where m.status=3 and jo.complete=0 and round(d.qty,2)>round(d.out_qty,2)    group by m.doc_no ) a  where 1=1 "+sqltest1+"" ;
		 
				
 
			           
						ResultSet resultSet = stmtmain.executeQuery(pySql);
						System.out.println("========= "+pySql);
						RESULTDATA=ClsCommon.convertToJSON(resultSet); 
						stmtmain.close();
		
		 
	           
	           
        	
	      
		}		
		 
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
//	System.out.println(RESULTDATA);
    return RESULTDATA;
}
public   JSONArray listsearchex(HttpSession session,String branch,String aa,String cldocno,String docnoss) throws SQLException {

	
	JSONArray RESULTDATA=new JSONArray();
	
      
    
    Connection conn = null;
	try {
		conn = ClsConnection.getMyConnection();
		if(aa.equalsIgnoreCase("yes"))
		{	
		
			Statement stmtmain = conn.createStatement ();
			
		 
			
			String sqltest="";
			
			if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
				
			 
					sqltest=sqltest+" and m.brhid='"+branch+"'";
				 
				
				}
			
			if(!(cldocno.equalsIgnoreCase("") || cldocno.equalsIgnoreCase("0"))){
				
				  
					sqltest=sqltest+" and m.cldocno = '"+cldocno+"'";
				 
				
				
				
				
				
			
			}
		 
			String sqltest1="";
			if(!(docnoss.equalsIgnoreCase(""))){
				sqltest1= " and a.costdocno = '"+docnoss+"'";
			}
 
			
			
 
 
				
		           String pySql = " select a.voc_no 'Doc_No',a.date 'Date',a.type  'Type',a.costgroup 'Group',a.costdocno 'Job No' ,"
		           			+ "   a.prjname 'Name', a.refname  'Client',a.site 'Site',a.loc_name 'Location',a.refno 'Ref No',a.desc1 'Description' "
		           			+ "   from ( select a.* from (  select m.brhid, u.costgroup,t.type,m.description desc1,m.refno,m.doc_no,m.voc_no,m.date,m.issuetype,m.locid,l.loc_name, "
						+ " m.costtype,m.siteid,s.site,a.refname,m.cldocno,  case when m.costtype=1 then m.costdocno when m.costtype in(3,4) then co.doc_no "
						+ " when m.costtype in(5) then cs.doc_no  when m.costtype=9 then jo.voc_no else m.costdocno end as 'costdocno' ,  case when m.costtype=1 then  "
						+ " c.description when m.costtype in(3,4) then convert(concat(co.ref_type,' ',co.refdocno),char(100))  when m.costtype in (5) then  "
						+ " convert(concat(cs.contracttype,' ',cs.contractno),char(100))  when m.costtype in (9) then convert(concat(jo.reftype,''),char(100))  "
						+ " end as 'prjname'  from my_mreqm m left join my_locm l on l.doc_no=m.locid left join my_issuetype t on t.doc_no=m.issuetype left join my_costunit u " 
						+ "	on u.costtype=m.costtype   left join my_ccentre c on c.costcode=m.costdocno and m.costtype=1  left join cm_srvcontrm co on co.tr_no=m.costdocno "
						+ "and m.costtype in(3,4)  left join cm_cuscallm cs on cs.tr_no=m.costdocno and m.costtype=5  left join cm_srvcsited s on s.rowno=m.siteid and "
						+ " m.costtype in(3,4,5)  left join ws_jobcard jo on jo.doc_no=m.costdocno and m.costtype in (9)  left join my_acbook a on a.cldocno=m.cldocno and m.costtype "
						+ " in(3,4,5,9) and a.dtype='CRM'   left join my_mreqd d on d.rdocno=m.doc_no  where m.status=3 and jo.complete=0 and round(d.qty,2)>round(d.out_qty,2)   group by m.doc_no ) a  where 1=1 "+sqltest1+"  ) a" ;
		 
			           
						ResultSet resultSet = stmtmain.executeQuery(pySql);

						RESULTDATA=ClsCommon.convertToEXCEL(resultSet); 
						stmtmain.close();
		
				 
	           
        	
	      
			
		}
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
//	System.out.println(RESULTDATA);
    return RESULTDATA;
}


public   JSONArray sublistGridReload(String barchval,String doc_no,String locid,String tr_no) throws SQLException {

	
	JSONArray RESULTDATA=new JSONArray();
	
      
    
    Connection conn = null;
	try {
		conn = ClsConnection.getMyConnection();
	 
		
		
			Statement stmtmain = conn.createStatement ();
			
		 
 
			
 
	        	String pySql="   select 0 erowno,a.locid,a.brhid,a.brandname,a.psrno,a.rowno,a.productid,a.productname,a.unit ,"
	        			+ "if(ebalqty<coalesce(i.stockqty,0),ebalqty,coalesce(i.stockqty,0)) issueqty ,if(ebalqty<coalesce(i.stockqty,0),ebalqty,coalesce(i.stockqty,0)) qtychk,"
	        				+ " coalesce(i.stockqty,0) stockqty , "
	        				+ " a.eqty,a.eissueqty,a.ebalqty,0 cqty  "
	        				+ "  from ( select d.qty eqty,d.out_qty eissueqty,"
	        				+ " ma.locid,ma.brhid,bd.brandname,d.psrno, d.qty-d.out_qty ebalqty , d.rowno," 
	        					+" m.part_no productid,m.productname,u.unit  from my_mreqm ma left join my_mreqd d on(ma.doc_no=d.rdocno) "
	        					+"left join my_main m on(d.psrno=m.doc_no and d.prdid=m.psrno) left join  my_unitm u on(d.unitid=u.doc_no) "
	        					+" left join  my_brand bd on m.brandid=bd.doc_no "
	        					+" left join my_prodattrib at on(at.mpsrno=m.doc_no and d.specno=at.mpsrno ) "
	        	   					+" where m.status=3 and d.rdocno='"+doc_no+"'     and d.qty>d.out_qty ) a "
	        					+" left join  ( select  sum(op_qty-(out_qty+del_qty+rsv_qty)) stockqty,psrno,locid,brhid,specno   from my_prddin "
	        					+" where brhid='"+barchval+"' and locid='"+locid+"'     group by psrno) i on    i.psrno=a.psrno ";
	        					 
	         
	        	System.out.println("Material:"+pySql);
				ResultSet resultSet = stmtmain.executeQuery(pySql);

				RESULTDATA=ClsCommon.convertToJSON(resultSet); 
				stmtmain.close();
				
				
			 
 
			
			
        	
			
		 
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
//	System.out.println(RESULTDATA);
    return RESULTDATA;
}




public   JSONArray sublistGridExcel(String barchval,String doc_no,String locid,String tr_no) throws SQLException {

	
	JSONArray RESULTDATA=new JSONArray();
	
      
    
    Connection conn = null;
	try {
		conn = ClsConnection.getMyConnection();
		
 
		
			Statement stmtmain = conn.createStatement ();
			
			 
				
 
	        	 
	        	

	        	String pySql="  select c.productid  'Product',c.productname 'Product Name',c.brandname 'Brand Name',c.unit 'Unit', c.eqty 'Qty',c.eissueqty 'Out_Qty ', "
						+ "  c.ebalqty  'Balance ',c.stockqty 'Stock Qty',c.issueqty 'To Be Issued' from(  select 0 erowno,a.locid,a.brhid,a.brandname,a.psrno,a.rowno,a.productid,a.productname,a.unit ,"
	        			+ "if(ebalqty<coalesce(i.stockqty,0),ebalqty,coalesce(i.stockqty,0)) issueqty ,if(ebalqty<coalesce(i.stockqty,0),ebalqty,coalesce(i.stockqty,0)) qtychk,"
	        				+ " coalesce(i.stockqty,0) stockqty , "
	        				+ " a.eqty,a.eissueqty,a.ebalqty  "
	        				+ "  from ( select d.qty eqty,d.out_qty eissueqty,"
	        				+ " ma.locid,ma.brhid,bd.brandname,d.psrno, d.qty-d.out_qty ebalqty , d.rowno," 
	        					+" m.part_no productid,m.productname,u.unit  from my_mreqm ma left join my_mreqd d on(ma.doc_no=d.rdocno) "
	        					+"left join my_main m on(d.psrno=m.doc_no and d.prdid=m.psrno) left join  my_unitm u on(d.unitid=u.doc_no) "
	        					+" left join  my_brand bd on m.brandid=bd.doc_no "
	        					+" left join my_prodattrib at on(at.mpsrno=m.doc_no and d.specno=at.mpsrno ) "
	        	   					+" where m.status=3 and d.rdocno='"+doc_no+"'     and d.qty>d.out_qty ) a "
	        					+" left join  ( select  sum(op_qty-(out_qty+del_qty+rsv_qty)) stockqty,psrno,locid,brhid,specno   from my_prddin "
	        					+" where brhid='"+barchval+"' and locid='"+locid+"'     group by psrno) i on    i.psrno=a.psrno) c ";
	        					 
	         
	        	
		         
	           
				ResultSet resultSet = stmtmain.executeQuery(pySql);

				RESULTDATA=ClsCommon.convertToEXCEL(resultSet); 
				stmtmain.close();
				
				
			 
 
			
			
        	
			
		 
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
//	System.out.println(RESULTDATA);
    return RESULTDATA;
}


public JSONArray getTechnician(String id) throws SQLException
{
	JSONArray data=new JSONArray();
	if(!id.equalsIgnoreCase("1")){
		return data;
	}
	Connection conn=null;
	try{
		conn=ClsConnection.getMyConnection();
		Statement stmt=conn.createStatement();
		String strsql="select doc_no,name from ws_technician where status=3";
		ResultSet rs=stmt.executeQuery(strsql);
		data=ClsCommon.convertToJSON(rs);
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



  