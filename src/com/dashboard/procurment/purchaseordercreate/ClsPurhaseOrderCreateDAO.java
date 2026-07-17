package com.dashboard.procurment.purchaseordercreate;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpSession;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsPurhaseOrderCreateDAO {
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	public   JSONArray accountsDetailsFrom(String date,String accountno, String accountname,String mob,String chk) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
	  
     //   JSONArray RESULTDATA=new JSONArray();
        Connection conn = null;
        
        
   java.sql.Date sqlDate=null;
      date.trim();
      String sqltest="";
                  /*   if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0")))
                     {
                      sqlDate = ClsCommon.changeStringtoSqlDate(date);
                     }*/
                     
                     if(!(accountno.equalsIgnoreCase("0")) && !(accountno.equalsIgnoreCase(""))){
                         sqltest=sqltest+" and t.account like '%"+accountno+"%'";
                     }
                     if(!(accountname.equalsIgnoreCase("0")) && !(accountname.equalsIgnoreCase(""))){
                      sqltest=sqltest+" and t.description like '%"+accountname+"%'";
                     }
                     if(!(mob.equalsIgnoreCase("0")) && !(mob.equalsIgnoreCase(""))){
                       sqltest=sqltest+" and if(a.per_mob=0,a.per_tel,a.per_mob) like '%"+mob+"%'";
                  }
  try {
     conn = ClsConnection.getMyConnection();
     if(chk.equalsIgnoreCase("1"))
     {
    Statement stmt = conn.createStatement ();
      
   
    String  sql= "select a.tax,t.doc_no,t.account,t.description,if(a.per_mob=0,a.per_tel,a.per_mob) mobile from my_head t "
    		+ " inner join my_acbook a on t.cldocno=a.cldocno and a.dtype='VND'	and t.atype='AP' where a.active=1 and t.m_s=0 "+sqltest;
 
    
    System.out.println("-----accountsql---+"+sql);
    
    ResultSet resultSet = stmt.executeQuery(sql);
    RESULTDATA=ClsCommon.convertToJSON(resultSet);
    
    stmt.close();
     }
    conn.close();
  }
  catch(Exception e){
   e.printStackTrace();
   conn.close();
  }
        return RESULTDATA;
    }

	public   JSONArray purchaseorderGridLoad(HttpSession session,String dates,String branch,String chk) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
	  
     //   JSONArray RESULTDATA=new JSONArray();
        Connection conn = null;
        if(!chk.equalsIgnoreCase("1"))
        {
        	return RESULTDATA;
        }
        String sqltest="";
        if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    		sqltest+=" and mm.brhid='"+branch+"'";
 		}
  try {
     conn = ClsConnection.getMyConnection();
    
    Statement stmt = conn.createStatement ();
    java.sql.Date masterdate = null;
	if(!(dates.equalsIgnoreCase("undefined"))&&!(dates.equalsIgnoreCase(""))&&!(dates.equalsIgnoreCase("0")))
 	{
		masterdate=ClsCommon.changeStringtoSqlDate(dates);
 		
 	}
 	else{
 
 	}
	
	
	

	int tax=0;
	Statement stmt3 = conn.createStatement (); 
 
	String chk31="select method  from gl_prdconfig where field_nme='tax' ";
	ResultSet rss3=stmt3.executeQuery(chk31); 
	if(rss3.next())
	{

		tax=rss3.getInt("method");
	}
	
	
	String joinsql="";
	
	String fsql="";
	
	String outfsql="";
	
	
	if(tax>0)
	{
			
			
			
			Statement pv=conn.createStatement();
			int prvdocno=0;
			String dd="select prvdocno from my_brch where doc_no='"+session.getAttribute("BRANCHID").toString()+"' ";
			ResultSet rs13=pv.executeQuery(dd); 
			if(rs13.next())
			{

				prvdocno=rs13.getInt("prvdocno");
			}
			
/*						
		joinsql=joinsql+" left join (select max(doc_no) tdocno,typeid from gl_taxmaster where   fromdate<='"+masterdate+"' and todate>='"+masterdate+"' and provid='"+prvdocno+"' group by typeid ) t1 on "
				+ " t1.typeid=m.typeid left join gl_taxmaster t on t.doc_no=t1.tdocno  and t.provid='"+prvdocno+"'   ";
		
		fsql=fsql+" case when 1="+cmbbilltype+"  then per when 2="+cmbbilltype+"  then cstper else 0 end as  'taxper' , ";
		
		outfsql=outfsql+ " taxper , ";*/
		
			joinsql=joinsql+" left join (select group_concat(cast(doc_no as char)) taxdocno, sum(per) per,sum(cstper) cstper,typeid from gl_taxmaster where   fromdate<='"+masterdate+"' and todate>='"+masterdate+"' and provid='"+prvdocno+"'  and type=1 and if(1=1,per,cstper)>0  group by typeid  ) t1 on "
					+ " t1.typeid=m.typeid   ";
		
			
			fsql=fsql+" case when 1=1  then t1.per when 2=0  then t1.cstper else 0 end as  'hidtax' ,t1.taxdocno , ";
			
			outfsql=outfsql+ " taxper ,taxdocno, ";
		
		
		
	}
   
    String sql=" select  "+fsql+" (d.qty-d.out_qty) chkqty,u.doc_no unitdoc,m.psrno,at.mspecno specid,mm.refno,mm.doc_no,mm.voc_no,mm.date,d.prdId prodoc,m.part_no productid,m.productname,u.unit, d.unitid unitdocno,d.qty "
			+ "  from my_reqm mm left join my_reqd d on d.tr_no=mm.tr_no left join my_main m on m.doc_no=d.prdId left join  "
			+ " my_unitm u on d.unitid=u.doc_no  left join my_prodattrib at on(at.mpsrno=m.doc_no)   "
			+ " "+joinsql+"  where    mm.status=3 "+sqltest+" having  chkqty>0";
    
    System.out.println("-----accountsqlcfgfg---+"+sql);
    
    ResultSet resultSet = stmt.executeQuery(sql);
    RESULTDATA=ClsCommon.convertToJSON(resultSet);
    
    stmt.close();
     
    conn.close();
  }
  catch(Exception e){
   e.printStackTrace();
   conn.close();
  }
        return RESULTDATA;
    }
	
}
