package com.dashboard.procurment.stocklist;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;
public class ClsStocklistDAO {

	ClsConnection ClsConnection =new ClsConnection();
	ClsCommon ClsCommon =new ClsCommon();
	
	
	
	public   JSONArray stocklist(String branch,String status,String psrno,String load) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
      /*  
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
     
     	}*/
        
        
        if(!(load.equalsIgnoreCase("yes")))
        {
        	return RESULTDATA;
        }
        

        String sqltest="";
        String sqltest1="";
        
    	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    		sqltest+=" and c.brhid='"+branch+"'";
    		sqltest1+=" and i.brhid='"+branch+"'";
 		}
    	
    	 
    	if((!(psrno.equalsIgnoreCase("NA")) )&&(!(psrno.equalsIgnoreCase("")))){
    		sqltest+=" and m.doc_no='"+psrno+"'";
 		}
    	
 
    	   
    	
     	Connection conn = null;
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmt = conn.createStatement ();   
		
				
				
	
				String sql=" select cc.category,c.brhid,bd.brandname,c.qty,m.part_no productid,m.productname,c.amount from (select  b.brhid,sum(b.qty) qty,b.prdid,sum(amount) amount from (select i.brhid,i.op_qty-coalesce(a.outqty,0) qty,i.prdid "
						    + "  ,i.cost_price*(i.op_qty-coalesce(a.outqty,0)) amount from my_prddin i "
							+ "  left join (select sum(qty)+sum(del_qty)+sum(rsv_qty) outqty, stockid ,prdid from my_prddout where 1=1  group by stockid) a on a.stockid=i.stockid "
							+ "  where 1=1  "+sqltest1+"  group by i.stockid) b group by b.prdid ) c left join my_main m on m.doc_no=c.prdId  "
							+ "left join my_desc de on(de.psrno=m.doc_no and c.brhid= de.brhid)  left join  "
							+ "my_brand bd on m.brandid=bd.doc_no  left join my_catm  cc on cc.doc_no=m.catid where 1=1 and c.qty>0 "+sqltest ;
				
          
          	//System.out.println("-----------"+sql);	
            		ResultSet resultSet = stmt.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
     				stmt.close();
     				
            
            	conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }	
	
	public   JSONArray stockExcellist(String branch,String status,String psrno,String load) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
      /*  
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
     
     	}*/
        
        
        if(!(load.equalsIgnoreCase("yes")))
        {
        	return RESULTDATA;
        }
        

        String sqltest="";
        String sqltest1="";
        
    	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    		sqltest+=" and c.brhid='"+branch+"'";
    		sqltest1+=" and i.brhid='"+branch+"'";
 		}
    	
    	 
    	if((!(psrno.equalsIgnoreCase("NA")) )&&(!(psrno.equalsIgnoreCase("")))){
    		sqltest+=" and m.doc_no='"+psrno+"'";
 		}
    	
 
    	   
    	
     	Connection conn = null;
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmt = conn.createStatement ();   
		
				
				
	
				String sql=" select m.part_no 'product id',m.productname 'product Name', bd.brandname 'Brand Name',cc.category,c.qty,c.amount from "
						+ "(select  b.brhid,sum(b.qty) qty,b.prdid,sum(amount) amount from (select i.brhid,i.op_qty-coalesce(a.outqty,0) qty,i.prdid "
						    + "  ,i.cost_price*(i.op_qty-coalesce(a.outqty,0)) amount from my_prddin i "
							+ "  left join (select sum(qty)+sum(del_qty)+sum(rsv_qty) outqty, stockid ,prdid from my_prddout group by stockid) a on a.stockid=i.stockid "
							+ "  where 1=1 "+sqltest1+" group by i.stockid) b group by b.prdid ) c left join my_main m on m.doc_no=c.prdId  left join my_desc de on(de.psrno=m.doc_no and c.brhid= de.brhid)  left join  my_brand bd on m.brandid=bd.doc_no  left join my_catm  cc on cc.doc_no=m.catid where 1=1 and c.qty>0 "+sqltest ;
				
          
          //	System.out.println("-----------"+sql);	
            		ResultSet resultSet = stmt.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
     				stmt.close();
     				
            
            	conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }	
	
	
	public   JSONArray stockExcellistqty(String branch,String status,String psrno,String load) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
      /*  
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
     
     	}*/
        
        
        if(!(load.equalsIgnoreCase("yes")))
        {
        	return RESULTDATA;
        }
        

        String sqltest="";
        String sqltest1="";
        
    	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    		sqltest+=" and c.brhid='"+branch+"'";
    		sqltest1+=" and i.brhid='"+branch+"'";
 		}
    	
    	 
    	if((!(psrno.equalsIgnoreCase("NA")) )&&(!(psrno.equalsIgnoreCase("")))){
    		sqltest+=" and m.doc_no='"+psrno+"'";
 		}
    	
 
    	   
    	
     	Connection conn = null;
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmt = conn.createStatement ();   
		
				
				
	
				/*String sql=" select m.part_no 'product id',m.productname 'product Name', bd.brandname 'Brand Name',cc.category,c.qty from "
						+ "(select  b.brhid,sum(b.qty) qty,b.prdid,sum(amount) amount from (select i.brhid,i.op_qty-coalesce(a.outqty,0) qty,i.prdid "
						    + "  ,i.cost_price*(i.op_qty-coalesce(a.outqty,0)) amount from my_prddin i "
							+ "  left join (select sum(qty)+sum(del_qty)+sum(rsv_qty) outqty, stockid ,prdid from my_prddout group by stockid) a on a.stockid=i.stockid "
							+ "  where 1=1 "+sqltest1+" group by i.stockid) b group by b.prdid ) c left join my_main m on m.doc_no=c.prdId  left join my_catm  cc on cc.doc_no=m.catid left join my_desc de on(de.psrno=m.doc_no and c.brhid= de.brhid)  left join  my_brand bd on m.brandid=bd.doc_no where 1=1 and c.qty>0 "+sqltest ;*/
				
          String sql=" select m.part_no 'Product Id',m.productname 'Product Name',bd.brandname 'Brand Name',cc.category 'Category',f.name 'Floor',r.name 'Rack',b.name 'Bin',c.qty 'Qty' from (select  b.brhid,sum(b.qty) qty,b.prdid,sum(amount) amount from (select i.brhid,i.op_qty-coalesce(a.outqty,0) qty,i.prdid "
					    + "  ,i.cost_price*(i.op_qty-coalesce(a.outqty,0)) amount from my_prddin i "
						+ "  left join (select sum(qty)+sum(del_qty)+sum(rsv_qty) outqty, stockid ,prdid from my_prddout where 1=1  group by stockid) a on a.stockid=i.stockid "
						+ "  where 1=1  "+sqltest1+"  group by i.stockid) b group by b.prdid ) c left join my_main m on m.doc_no=c.prdId  "
						+ "left join my_desc de on(de.psrno=m.doc_no and c.brhid= de.brhid) "
						+ "left join (select bin,psrno,brhid  from my_desc where  bin>0 group by psrno ) aa on aa.psrno=m.psrno  "
						+ " left join my_flbin b on b.doc_no=aa.bin left join my_flrack r on r.doc_no=b.rck_id left join my_floor f on f.doc_no=b.fl_id"
						+ " left join  "
						+ "my_brand bd on m.brandid=bd.doc_no  left join my_catm  cc on cc.doc_no=m.catid where 1=1 and c.qty>0 "+sqltest ;
			
				
          //	System.out.println("-----------"+sql);	
            		ResultSet resultSet = stmt.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
     				stmt.close();
     				
            
            	conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }	
	
	
	
	
	public   JSONArray stockdetlist(String branch,String status,String psrno,String load) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
      /*  
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
     
     	}*/
        if(!(load.equalsIgnoreCase("yes")))
        {
        	return RESULTDATA;
        }
        
        String sqltest="";
    	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    		sqltest+=" and c.brhid='"+branch+"'";
 		}
    	
    	 
    	if((!(psrno.equalsIgnoreCase("NA")) )&&(!(psrno.equalsIgnoreCase("")))){
    		sqltest+=" and m.doc_no='"+psrno+"'";
 		}
    	
 
    
     	Connection conn = null;
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmt = conn.createStatement ();   
		
				
				
					/* branchname loc_name
				String sql=" select c.brhid,bd.brandname,c.qty,m.part_no productid,m.productname,c.amount from (select  b.brhid,sum(b.qty) qty,b.prdid,sum(amount) amount from (select i.brhid,i.op_qty-coalesce(a.outqty,0) qty,i.prdid "
						    + "  ,i.cost_price*(i.op_qty-coalesce(a.outqty,0)) amount from my_prddin i "
							+ "  left join (select sum(qty)+sum(del_qty)+sum(rsv_qty) outqty, stockid ,prdid from my_prddout group by stockid) a on a.stockid=i.stockid "
							+ "  where 1=1 group by i.stockid) b  ) c left join my_main m on m.doc_no=c.prdId  left join my_desc de on(de.psrno=m.doc_no and c.brhid= de.brhid)  left join  my_brand bd on m.brandid=bd.doc_no where 1=1 "+sqltest ;
				*/
				
				String sql="  select cc.category,bc.branchname,lc.loc_name,c.locid,c.brhid,bd.brandname,c.qty,m.part_no productid,m.productname,c.amount from "
						 + "  (select  b.locid,b.brhid,b.qty qty,b.prdid,amount amount from (select i.locid,i.brhid,i.op_qty-coalesce(a.outqty,0) qty,i.prdid "
						 + "  ,i.cost_price*(i.op_qty-coalesce(a.outqty,0)) amount from my_prddin i "
						 + "  left join (select sum(qty)+sum(del_qty)+sum(rsv_qty) outqty, stockid ,prdid from my_prddout group by stockid) a "
						 + "  on a.stockid=i.stockid   where 1=1 group by i.stockid) b  ) c left join my_main m on m.doc_no=c.prdId "
						 + "  left join my_desc de on(de.psrno=m.doc_no and c.brhid= de.brhid) left join my_brch bc on bc.doc_no=c.brhid "
						 + " left join my_locm lc on lc.doc_no=c.locid left join  my_brand bd on m.brandid=bd.doc_no left join my_catm  cc on cc.doc_no=m.catid where 1=1 and qty>0 "+sqltest;
				     
          //	System.out.println("-------asdas----"+sql);	
            		ResultSet resultSet = stmt.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
     				stmt.close();
     				
            
            	conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }	
	
	
	
	public   JSONArray stockexceldetlist(String branch,String status,String psrno,String load) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
      /*  
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
     
     	}*/
        if(!(load.equalsIgnoreCase("yes")))
        {
        	return RESULTDATA;
        }
        
        String sqltest="";
    	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    		sqltest+=" and c.brhid='"+branch+"'";
 		}
    	
    	 
    	if((!(psrno.equalsIgnoreCase("NA")) )&&(!(psrno.equalsIgnoreCase("")))){
    		sqltest+=" and m.doc_no='"+psrno+"'";
 		}
    	
 
    
     	Connection conn = null;
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmt = conn.createStatement ();   
		
				
				
					/* branchname loc_name
				String sql=" select c.brhid,bd.brandname,c.qty,m.part_no productid,m.productname,c.amount from (select  b.brhid,sum(b.qty) qty,b.prdid,sum(amount) amount from (select i.brhid,i.op_qty-coalesce(a.outqty,0) qty,i.prdid "
						    + "  ,i.cost_price*(i.op_qty-coalesce(a.outqty,0)) amount from my_prddin i "
							+ "  left join (select sum(qty)+sum(del_qty)+sum(rsv_qty) outqty, stockid ,prdid from my_prddout group by stockid) a on a.stockid=i.stockid "
							+ "  where 1=1 group by i.stockid) b  ) c left join my_main m on m.doc_no=c.prdId  left join my_desc de on(de.psrno=m.doc_no and c.brhid= de.brhid)  left join  my_brand bd on m.brandid=bd.doc_no where 1=1 "+sqltest ;
				*/
				
				String sql="  select m.part_no 'product id',m.productname 'product name',bd.brandname 'Brand Name',bc.branchname 'Branch',cc.category,lc.loc_name 'Location',c.qty,c.amount from "
						 + "  (select  b.locid,b.brhid,b.qty qty,b.prdid,amount amount from (select i.locid,i.brhid,i.op_qty-coalesce(a.outqty,0) qty,i.prdid "
						 + "  ,i.cost_price*(i.op_qty-coalesce(a.outqty,0)) amount from my_prddin i "
						 + "  left join (select sum(qty)+sum(del_qty)+sum(rsv_qty) outqty, stockid ,prdid from my_prddout group by stockid) a "
						 + "  on a.stockid=i.stockid   where 1=1 group by i.stockid) b  ) c left join my_main m on m.doc_no=c.prdId "
						 + "  left join my_desc de on(de.psrno=m.doc_no and c.brhid= de.brhid) left join my_brch bc on bc.doc_no=c.brhid "
						 + " left join my_locm lc on lc.doc_no=c.locid left join  my_brand bd on m.brandid=bd.doc_no left join my_catm  cc on cc.doc_no=m.catid where 1=1 and qty>0 "+sqltest;
				     
          //	System.out.println("-------asdas----"+sql);	
				ResultSet resultSet = stmt.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
     				stmt.close();
     				
            
            	conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }	
	
	
	public   JSONArray stockexceldetlistqty(String branch,String status,String psrno,String load) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
      /*  
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
     
     	}*/
        if(!(load.equalsIgnoreCase("yes")))
        {
        	return RESULTDATA;
        }
        
        String sqltest="",sqltest1="";
	    	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    		sqltest+=" and c.brhid='"+branch+"'";
	    		sqltest1+=" left join (select bin,psrno,brhid  from my_desc where  bin>0 group by psrno ) aa on aa.psrno=m.psrno   ";
	 		}
	    	else
	    	{
	    		sqltest1+=" left join (select bin,psrno,brhid  from my_desc where  bin>0 group by psrno) aa on aa.psrno=m.psrno ";
	    	}
	    	
	    	 
	    	if((!(psrno.equalsIgnoreCase("NA")) )&&(!(psrno.equalsIgnoreCase("")))){
	    		sqltest+=" and m.doc_no='"+psrno+"'";
	 		}
	    	
	 
 
    
     	Connection conn = null;
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmt = conn.createStatement ();   
		
				
				
					/* branchname loc_name
				String sql=" select c.brhid,bd.brandname,c.qty,m.part_no productid,m.productname,c.amount from (select  b.brhid,sum(b.qty) qty,b.prdid,sum(amount) amount from (select i.brhid,i.op_qty-coalesce(a.outqty,0) qty,i.prdid "
						    + "  ,i.cost_price*(i.op_qty-coalesce(a.outqty,0)) amount from my_prddin i "
							+ "  left join (select sum(qty)+sum(del_qty)+sum(rsv_qty) outqty, stockid ,prdid from my_prddout group by stockid) a on a.stockid=i.stockid "
							+ "  where 1=1 group by i.stockid) b  ) c left join my_main m on m.doc_no=c.prdId  left join my_desc de on(de.psrno=m.doc_no and c.brhid= de.brhid)  left join  my_brand bd on m.brandid=bd.doc_no where 1=1 "+sqltest ;
				*/
				
				/*String sql="  select m.part_no 'product id',m.productname 'product name',bd.brandname 'Brand Name',cc.category,bc.branchname 'Branch',lc.loc_name 'Location',c.qty from "
						 + "  (select  b.locid,b.brhid,b.qty qty,b.prdid,amount amount from (select i.locid,i.brhid,i.op_qty-coalesce(a.outqty,0) qty,i.prdid "
						 + "  ,i.cost_price*(i.op_qty-coalesce(a.outqty,0)) amount from my_prddin i "
						 + "  left join (select sum(qty)+sum(del_qty)+sum(rsv_qty) outqty, stockid ,prdid from my_prddout group by stockid) a "
						 + "  on a.stockid=i.stockid   where 1=1 group by i.stockid) b  ) c left join my_main m on m.doc_no=c.prdId "
						 + "  left join my_desc de on(de.psrno=m.doc_no and c.brhid= de.brhid) left join my_brch bc on bc.doc_no=c.brhid "
						 + " left join my_locm lc on lc.doc_no=c.locid left join my_catm  cc on cc.doc_no=m.catid left join  my_brand bd on m.brandid=bd.doc_no where 1=1 and qty>0 "+sqltest;*/
				     
					 String sql="  select m.part_no 'Productid',m.productname 'Product Name',bd.brandname 'Brand Name',cc.category 'Category',bc.branchname 'Branch',f.name 'Floor',r.name 'Rack',b.name 'Bin',lc.loc_name 'Location',c.qty 'Qty' from "
						 + "  (select  b.locid,b.brhid,b.qty qty,b.prdid,amount amount from (select i.locid,i.brhid,i.op_qty-coalesce(a.outqty,0) qty,i.prdid "
						 + "  ,i.cost_price*(i.op_qty-coalesce(a.outqty,0)) amount from my_prddin i "
						 + "  left join (select sum(qty)+sum(del_qty)+sum(rsv_qty) outqty, stockid ,prdid from my_prddout group by stockid) a "
						 + "  on a.stockid=i.stockid   where 1=1 group by i.stockid) b  ) c left join my_main m on m.doc_no=c.prdId "
						 + "  left join my_desc de on(de.psrno=m.doc_no and c.brhid= de.brhid) "
						 + " left join my_brch bc on bc.doc_no=c.brhid   "+sqltest1+" left join my_flbin b on b.doc_no=aa.bin left join my_flrack r on r.doc_no=b.rck_id left join my_floor f on f.doc_no=b.fl_id"
						 + " left join my_locm lc on lc.doc_no=c.locid left join  my_brand bd on m.brandid=bd.doc_no left join my_catm  cc on cc.doc_no=m.catid where 1=1 and qty>0 "+sqltest;
				         
				
          //	System.out.println("-------asdas----"+sql);	
				ResultSet resultSet = stmt.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
     				stmt.close();
     				
            
            	conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }	
	
	
	
	
	public JSONArray productSearch(HttpSession session,String docnos,String prdid,String prdname,String load) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();
			String sql1="";
		
			
			if(!((prdid.equalsIgnoreCase("")) || (prdid.equalsIgnoreCase("NA")))){
				sql1+=" and m.part_no like'%"+prdid+"%' ";
	 		}
			if(!((prdname.equalsIgnoreCase("")) || (prdname.equalsIgnoreCase("NA")))){
				sql1+=" and m.productname like '%"+prdname+"%' ";
	 		}
			
			if(load.equalsIgnoreCase("yes"))
					{
			
		 
				    	
			String sql="select m.psrno doc_no,m.part_no prodcode,m.productname prodname,um.unit from my_main m left join my_brand b on(m.brandid=b.doc_no)"
					+ "left join my_catm c on(m.catid=c.doc_no) left join my_scatm s on(m.scatid=s.doc_no) left join my_desc de on(de.psrno=m.doc_no)    "
					+ " left join my_unit u on(u.psrno=m.psrno) left join my_unitm um on(um.doc_no=u.unit)  where m.status=3  and de.discontinued=0 "+sql1+ "group by m.doc_no  ";
		//	System.out.println("==productSearch==="+sql);
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
					}

		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
