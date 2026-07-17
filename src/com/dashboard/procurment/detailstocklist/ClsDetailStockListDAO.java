package com.dashboard.procurment.detailstocklist;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpSession;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsDetailStockListDAO {

	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	public   JSONArray orderlistsearch(String branch,String fromdate,String todate,String psrno,String load) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        
        if(!(load.equalsIgnoreCase("yes")))
        {
        	return RESULTDATA;
        }
   
    	
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
    	 
    	int method=0;
     	Connection conn = null;
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();     
				String strSql2 ="select method from gl_prdconfig where field_nme like 'vataddoramount'";
				ResultSet rs2 = stmtVeh.executeQuery(strSql2);
				while (rs2.next()){
					method=rs2.getInt("method");
				}
				if(method>0){
					sqltest=",round((d.nettaxamount/d.qty),2)sp";
				}else{
					sqltest=",round((d.nettotal/d.qty),2)sp";
				}
		
				
		/*		String sql=" select mm.doc_no,mm.voc_no,mm.date,d.prdId prodoc,if(d.clstatus=1,'Canceled','') status,d.clstatus, "
						+ "  h.account,h.description acname, "
						+ "  m.part_no productid,m.productname,u.unit, d.unitid unitdocno,d.taxper, d.taxamount, d.nettaxamount, "
						+ "  d.qty,convert(if(d.out_qty=0,'',d.out_qty),char(30)) out_qty,convert(if(d.qty-d.out_qty=0,'',d.qty-d.out_qty),char(50)) balqty,"
						+ "  d.amount,d.total,convert(if(d.disper=0,'',d.disper),char(30)) disper,"
						+ "  convert(if(d.discount=0,'',d.discount),char(30)) discount,d.nettotal  "
						+ "  from my_ordm mm left join my_ordd d on d.tr_no=mm.tr_no left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no "
						+ "  left join my_head h on h.doc_no=mm.acno "
						+ "    where "
						+ "  mm.DATE between  '"+sqlfromdate+"' and  '"+sqltodate+"'   and d.psrno="+psrno+" ";*/
				
				
				String sql=" select mm.doc_no,mm.voc_no,mm.date,d.prdId prodoc, "
						+ "  h.account,h.description acname, "
						+ "  d.taxper, d.taxamount, d.nettaxamount, "
						+ "  d.qty,convert(if(d.foc=0,'',d.foc),char(30)) foc,convert(if((d.out_qty+d.foc_out)=0,'',d.out_qty+d.foc_out),char(30)) out_qty,convert(if((d.qty+d.foc)-(d.out_qty+d.foc_out)=0,'',(d.qty+d.foc)-(d.out_qty+d.foc_out)),char(50)) balqty,"
						+ "  d.amount,d.total,convert(if(d.disper=0,'',d.disper),char(30)) disper,"
						+ "  convert(if(d.discount=0,'',d.discount),char(30)) discount,d.nettotal"+sqltest+"  "
						+ "  from my_ordm mm left join my_ordd d on d.rdocno=mm.doc_no   "
						+ "  left join my_head h on h.doc_no=mm.acno     where "
						+ "  mm.DATE between  '"+sqlfromdate+"' and  '"+sqltodate+"'  and ((d.qty+d.foc)-(d.out_qty+d.foc_out))>0  and d.psrno="+psrno+" ";
			
          
            	// System.out.println("-----------"+sql);	
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
     				stmtVeh.close();
     				
            
            	conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }	
	
	
	
	
	
	public   JSONArray purchaselistsearch(String branch,String fromdate,String todate,String psrno,String load) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        
        if(!(load.equalsIgnoreCase("yes")))
        {
        	return RESULTDATA;
        }
   
    	
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
    	 int method=0;
    	   
    	
     	Connection conn = null;
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();   
		
				
				String strSql2 ="select method from gl_prdconfig where field_nme like 'vataddoramount'";
				ResultSet rs2 = stmtVeh.executeQuery(strSql2);
				while (rs2.next()){
					method=rs2.getInt("method");
				}
				if(method>0){
					sqltest=",round((d.nettaxamount/d.qty),2)sp";
				}else{
					sqltest=",round((d.nettotal/d.qty),2)sp";
				}
				
				String sql=" select   mm.doc_no,mm.voc_no,mm.date,d.prdId prodoc, "
						+ "  h.account,h.description acname, "
						+ "   d.taxper, d.taxamount, d.nettaxamount,convert('',char(30))    expfocrvd ,"
						+ "  d.qty,convert(if(d.foc=0,'',d.foc),char(30)) foc,convert(if(d.out_qty=0,'',d.out_qty),char(30)) out_qty,convert(if(d.qty-d.out_qty=0,'',d.qty-d.out_qty),char(50)) balqty,d.amount,d.total,convert(if(d.disper=0,'',d.disper),char(30)) disper,"
						+ "  convert(if(d.discount=0,'',d.discount),char(30)) discount,d.nettotal"+sqltest+"  "
						+ "  from my_srvm mm left join my_srvd d on d.rdocno=mm.doc_no  "
						+ "  left join my_head h on h.doc_no=mm.acno     where    mm.DATE between  '"+sqlfromdate+"' and  '"+sqltodate+"'   and d.psrno="+psrno+" " ;
			
          
            //	System.out.println("-----------"+sql);	
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
     				stmtVeh.close();
     				
            
            	conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }	
	
	
	
	public   JSONArray salelistsearch(String branch,String fromdate,String todate,String psrno,String load) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        
        if(!(load.equalsIgnoreCase("yes")))
        {
        	return RESULTDATA;
        }
   
    	
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
    	 int method=0;
    	   
    	
     	Connection conn = null;
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();   
				String strSql2 ="select method from gl_prdconfig where field_nme like 'vataddoramount'";
				ResultSet rs2 = stmtVeh.executeQuery(strSql2);
				while (rs2.next()){
					method=rs2.getInt("method");
				}
				if(method>0){
					sqltest=",round((d.nettaxamount/d.qty),2)sp";
				}else{
					sqltest=",round((d.nettotal/d.qty),2)sp";
				}
				
				
				String sql=" select   mm.doc_no,mm.voc_no,mm.date,d.prdId prodoc, "
						+ "  h.account,h.description acname, "
						+ "   d.taxper, d.taxamount, d.nettaxamount, "
						+ "  d.qty,convert(if(d.foc=0,'',d.foc),char(30)) foc,convert(if(d.out_qty=0,'',d.out_qty),char(30)) out_qty,convert(if(d.qty-d.out_qty=0,'',d.qty-d.out_qty),char(50)) balqty,d.amount,d.total,convert(if(d.disper=0,'',d.disper),char(30)) disper,"
						+ "  convert(if(d.discount=0,'',d.discount),char(30)) discount,d.nettotal"+sqltest+"  "
						+ "  from my_invm mm left join my_invd d on d.rdocno=mm.doc_no  "
						+ "  left join my_head h on h.doc_no=mm.acno     where    mm.DATE between  '"+sqlfromdate+"' and  '"+sqltodate+"'   and d.psrno="+psrno+" " ;
			
          
            //	System.out.println("-----------"+sql);	
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
     				stmtVeh.close();
     				
            
            	conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }	
	
	
	public   JSONArray foclistgridsearch(String psrno,String load) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        
        
        if(!(load.equalsIgnoreCase("yes")))
        {
        	return RESULTDATA;
        }
   
    	
    	
     	Connection conn = null;
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmt  = conn.createStatement ();  
			 
				 
		 
				
 				String sql=" select  qty,foc from  my_prodfocfixing where  psrno='"+psrno+"' order by sr_no ";  
				
 				// System.out.println("====sql==="+sql);
            	 
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
	
	public   JSONArray batchlistgridsearch(String psrno,String load) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        
        
        if(!(load.equalsIgnoreCase("yes")))
        {
        	return RESULTDATA;
        }
   
    	
     	Connection conn = null;
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmt  = conn.createStatement ();  
			 
				 
		 
				
 				String sql=" select date_format(exp_date,'%d.%m.%Y') exp_date, batch_no,sum(op_qty-(out_qty+rsv_qty+del_qty))   qty "
	 + " from my_prddin pin where psrno='"+psrno+"'  group by  batch_no,pin.exp_date,psrno having sum(op_qty-(out_qty+rsv_qty+del_qty))>0 "
	 + "  order by pin.exp_date,stockid  ";  
				
 				// System.out.println("====sql==="+sql);
            	 
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
	
	
	public   JSONArray productsearch() throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
   
    	
     	Connection conn = null;
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmt  = conn.createStatement ();  
			 
				 
			
				
 				String sql=" select m.sellprice,m.fixingprice, totstock,rsv_qty ,totstock-rsv_qty balqty, bd.brandname ,m.part_no,concat(m.part_no,' - ',m.productname) productname,m.doc_no,m.munit,m.psrno"
 						+ " from my_main m 	 left join  my_brand bd on m.brandid=bd.doc_no 	left join ( select sum(op_qty-(out_qty+del_qty)) totstock,sum(rsv_qty) rsv_qty,psrno "
 						+ " from my_prddin   group by psrno) pin  on pin.psrno=m.psrno	where m.status=3    ";  
				
 				// System.out.println("====sql==="+sql);
            	 
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
	
	
	
	public JSONArray stockLedgerDetail(HttpSession session,String fromDate,String toDate ,String psrno,String load) throws SQLException {

 
		JSONArray RESULTDATA=new JSONArray();
		if(!(load.equalsIgnoreCase("yes")))
		{
			return RESULTDATA;
		}
		
		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();
 

			java.sql.Date frmdate=ClsCommon.changeStringtoSqlDate(fromDate);

			java.sql.Date todate=ClsCommon.changeStringtoSqlDate(toDate);

 
			 
/*		String sqlss="select l.doc_no docno,l.date,l.dtype,h.description accountname,l.qty,l.balqty from( "
				+"	select case when d.dtype='INR' then ir.voc_no when d.dtype='INV' then iv.voc_no when d.dtype='PIV' "
				+"		 then m.voc_no when d.dtype='PIR' then r.voc_no else 0 end as doc_no, "
				+"		 case when d.dtype='INR' then ir.acno when d.dtype='INV' then iv.acno when d.dtype='PIV' "
				+"		 then m.acno when d.dtype='PIR' then r.acno else 0 end as acno, d.tr_no,d.dtype,d.date,d.qty,d.balqty from ( "
				+"		select tr_no,stockid,dtype,psrno,date,qty,@i:=@i+if(dtype='INV' || dtype='PIR',out_qty,qty)  balqty from ( "
				+"		 select   pin.tr_no,pin.stockid,pin.dtype,pin.psrno, pin.date "
				+"		 ,pin.op_qty qty,pin.op_qty-pin.out_qty out_qty	   from my_prddin pin "
				+"		where 1=1  and   pin.date>='"+frmdate+"' and  pin.date<='"+todate+"' "
				+"		and psrno='"+psrno+"'   group by pin.stockid "
				+"		union all "
				+"		select   o.tr_no,o.stockid,o.dtype,o.psrno, o.date , o.qty qty,o.qty*-1 out_qty  from my_prddout o "
				+"		 where 1=1  and   o.date>='"+frmdate+"' and  o.date<='"+todate+"' and (o.dtype='INV' || o.dtype='PIR')   	and psrno='"+psrno+"'  group by o.doc_no "
				+"		) c,(select @i:=0) as i  order by tr_no ) d "
				+"		left join my_srvm m on m.tr_no=d.tr_no "
				+"		left join my_srrm r on r.tr_no=d.tr_no "
				+"		left join my_invm iv on iv.tr_no=d.tr_no "
				+"		left join my_invr ir on ir.tr_no=d.tr_no "
				+"		 order by d.date desc ,d.tr_no desc ) l  left join my_head h on  h.doc_no=l.acno ";
		*/
		
		
		
		
			String sqlss="select  pstatus,l.doc_no docno,l.date,l.dtype,h.description accountname,l.qty,l.balqty,sr from( "
					+"select pstatus,case when d.dtype='PHK' then ph.voc_no when d.dtype='INR' then ir.voc_no when d.dtype='INV' then iv.voc_no when d.dtype='PIV' "
				+" then m.voc_no when d.dtype='PIR' then r.voc_no else d.rdocno end as doc_no, "
				+" case when d.dtype='INR' then ir.acno when d.dtype='INV' then iv.acno when d.dtype='PIV' "
				+" then m.acno when d.dtype='PIR' then r.acno else 0 end as acno, d.tr_no,d.dtype,d.date,d.qty,d.balqty,sr from ( "
			+"	select pstatus,rdocno,tr_no,stockid,dtype,psrno,date,qty,@i:=@i+if(id=0,out_qty,qty)  balqty,@m:=@m+1 sr from ( "
			+"	 select  1 pstatus,  0 rdocno, 0 tr_no,0 stockid,'OPN' dtype,pin.psrno,0 id, pin.date "
			+"	 ,sum(pin.op_qty) qty, sum(pin.op_qty)-qty out_qty	   from my_prddin pin "
				+" left join (select sum(qty) qty,psrno from my_prddout where psrno='"+psrno+"' and  date<'"+frmdate+"' ) d on d.psrno=pin.psrno "
			+"	where 1=1  and   pin.date<'"+frmdate+"' "
			+"	and pin.psrno='"+psrno+"'        group by pin.psrno "
			+"	union all "
				+" select 1 pstatus, 0 rdocno, pin.tr_no,pin.stockid,pin.dtype,pin.psrno,1 id, pin.date "
			+"	 ,pin.op_qty qty,pin.op_qty-pin.out_qty out_qty	   from my_prddin pin "
			+"	where 1=1  and   pin.date>='"+frmdate+"' and  pin.date<='"+todate+"' "
			+"	and psrno='"+psrno+"'   group by pin.stockid "
			+"	union all "
			+"	select 0 pstatus, o.rdocno,  o.tr_no,o.stockid,o.dtype,o.psrno,0 id, o.date , o.qty qty,o.qty*-1 out_qty  from my_prddout o "
			+"	 where 1=1  and   o.date>='"+frmdate+"' and  o.date<='"+todate+"' and  o.dtype!='SOR' and o.dtype!='SRR' "
			+"	 and psrno='"+psrno+"'  group by o.doc_no ) c,(select @i:=0) as i ,(select @m:=0) as  m order by tr_no ) d "
			+"	left join my_srvm m on m.tr_no=d.tr_no "
			+"	left join my_srrm r on r.tr_no=d.tr_no "
			+"	left join my_invm iv on iv.tr_no=d.tr_no "
			+"	left join my_invr ir on ir.tr_no=d.tr_no "
			+"	left join my_phkm ph on ph.tr_no=d.tr_no "
				+" order by d.tr_no     ) l  left join my_head h on  h.doc_no=l.acno order by sr desc ";
 
 
		//System.out.println("=======sqlss="+sqlss);
		
			ResultSet rs = stmt.executeQuery(sqlss);
			RESULTDATA=ClsCommon.convertToJSON(rs);
			
			
 

		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}

	
	
	/*public JSONArray stockLedgerDetail1(HttpSession session,String hidbrand,String fromDate,String toDate,String hidtype,String hidcat,
			String hidsubcat,String hidproduct,String branchid,String hidept,String load) throws SQLException {

		//System.out.println("load==============="+load);
		JSONArray RESULTDATA=new JSONArray();
		if(!(load.equalsIgnoreCase("yes")))
		{
			return RESULTDATA;
		}
		
		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();
			String minyom="",maxyom="";
			String sqljoin ="";
			String sqljoin1 ="";
			String sqljoin2 ="";
			String wheresql="";

		 String insql="";
		 String outsql="";

			java.sql.Date frmdate=ClsCommon.changeStringtoSqlDate(fromDate);

			java.sql.Date todate=ClsCommon.changeStringtoSqlDate(toDate);

			if(!(hidbrand.equalsIgnoreCase("0") || hidbrand.equalsIgnoreCase("") || hidbrand.equalsIgnoreCase("undefined"))){
				wheresql=wheresql+" and bd.doc_no in ("+hidbrand+")";
			}

			if(!(hidtype.equalsIgnoreCase("0") || hidtype.equalsIgnoreCase("") || hidtype.equalsIgnoreCase("undefined"))){
				wheresql=wheresql+"  and pt.doc_no in ("+hidtype+")";
			}

			if(!(hidcat.equalsIgnoreCase("0") || hidcat.equalsIgnoreCase("") || hidcat.equalsIgnoreCase("undefined"))){
				wheresql=wheresql+"  and cat.doc_no in ("+hidcat+")";
			}
			if(!(hidsubcat.equalsIgnoreCase("0") || hidsubcat.equalsIgnoreCase("") || hidsubcat.equalsIgnoreCase("undefined"))){
				wheresql=wheresql+"  and sc.doc_no in ("+hidsubcat+")";
			}

			if(!(hidproduct.equalsIgnoreCase("0") || hidproduct.equalsIgnoreCase("") || hidproduct.equalsIgnoreCase("undefined"))){
				wheresql=wheresql+"  and m.doc_no in ("+hidproduct+")";
			}
			
			String opsql="";
		 if(!(branchid.equalsIgnoreCase("0") || branchid.equalsIgnoreCase("") || branchid.equals("undefined")|| branchid.equalsIgnoreCase("a"))){
				insql=" and pin.brhid in ("+branchid+")";
				outsql=" and pout.brhid in ("+branchid+")";
				opsql="and brhid in ("+branchid+")";
				
			} 
			if(!(hidept.equalsIgnoreCase("0") || hidept.equalsIgnoreCase("") || hidept.equalsIgnoreCase("undefined"))){
				wheresql=wheresql+"  and dep.doc_no in ("+hidept+")";
			}
			 
			sqljoin = " left join my_main m on(pin.psrno=m.psrno) "
					+ " left join my_ptype pt on(m.typeid=pt.doc_no) "
					+ " left join my_brand bd on(m.brandid=bd.doc_no) "
					+ " left join my_dept dep on(dep.doc_no=m.deptid) "
					+ " left join my_catm cat on(m.catid=cat.doc_no)"
					+ " left join my_scatm sc on(m.scatid=sc.doc_no)" ;
				 
			
			

			sqljoin1 = " left join my_main m on(pout.psrno=m.psrno) "
					+ " left join my_ptype pt on(m.typeid=pt.doc_no) "
					+ " left join my_brand bd on(m.brandid=bd.doc_no) "
					+ " left join my_dept dep on(dep.doc_no=m.deptid) "
					+ " left join my_catm cat on(m.catid=cat.doc_no) "
					+ " left join my_scatm sc on(m.scatid=sc.doc_no) " ;
 
			
			sqljoin2 = " left join my_main m on(ops.prdid=m.psrno) "
					+ " left join my_ptype pt on(m.typeid=pt.doc_no) "
					+ " left join my_brand bd on(m.brandid=bd.doc_no) "
					+ " left join my_dept dep on(dep.doc_no=m.deptid) "
					+ " left join my_catm cat on(m.catid=cat.doc_no) "
					+ " left join my_scatm sc on(m.scatid=sc.doc_no) " ;
 
			String	sql="   select ord,valtype trtype,DATE_FORMAT(date,'%d-%m-%Y') date,convert(docno,char(100)) docno,convert(dtype,char(100)) trans_type,"
					+ " convert(inqty,char(100)) inqty,convert(inval,char(100)) inval ,convert(isqty,char(20)) isqty,convert(isval,char(100)) isval,"
					+ " convert(if(valtype!='out',cpu,''),char(100)) cpu,convert(description,char(100))  desc1,coalesce(round(@i:=@i+(inqty-issqty1),2),0) balqty ,coalesce(round(@j:=@j+(inval-isval1),2),0)  balval"
					+ "  from ("
				 	+ " select 0 ord, 0 minus,'OP' valtype, 0  tr_no,ops.prdid psrno,cast(DATE_ADD('"+frmdate+"', INTERVAL -1 DAY) as date) date, "
					+ " 'OPENING' description,0 stockid,'OPN' dtype, '' docno, '' acno,ops.inqty, ops.inval,'' isqty,'' issqty1, '' isval, '' isval1, '' balqty, '' balcost, "
					+ " ops.inval/ops.inqty cpu from (select sum(op.opqty) inqty,sum(op.cost_price)  inval,op.prdid from "
					+ "  (select (p.op_qty)-(coalesce(a.outqty,0)) opqty ,((op_qty)-(coalesce(a.outqty,0)))*p.cost_price  "
					+ " cost_price,p.Stockid,p.prdid,p.brhid from my_prddin  p	left join (select sum(qty) outqty,stockid from my_prddout where "
					+ "     cast(date as date)<'"+frmdate+"' "+opsql+"   group by stockid) a      on a.stockid=p.stockid "
							+ " where  cast(p.date as date)<'"+frmdate+"'  "+opsql+"  group by p.Stockid)  op group by op.prdid ) ops  "+sqljoin2+" where 1=1 "+wheresql+""
									+ " union all  "
					+ "select 1 ord,0 minus,'in' valtype, ins.tr_no, ins.psrno,ins.date,h.description, "
					+ "ins.stockid,ins.dtype,ins.docno,ins.acno,ins.inqty,ins.inval,ins.isqty, ins.isqty issqty1, "
					+ "  ins.isval,ins.isval isval1,ins.balqty,ins.balcost,ins.cpu from  "
						 + "(select pin.tr_no,pin.stockid, case when pin.dtype='GRN' then GRN.voc_no   when pin.dtype='PIV' then PIV.voc_no  "
						 + "when pin.dtype='DLR' then DLR.voc_no  when pin.dtype='INR' then INR.voc_no  "
						 + "when  pin.dtype='ITR' then ITR.voc_no   when  pin.dtype='GIR' then GIR.voc_no  else ''  end as DOCNO,  "
						 + "case when pin.dtype='GRN' then GRN.acno   when pin.dtype='PIV' then PIV.acno  "
						 + "when pin.dtype='DLR' then DLR.acno  when pin.dtype='INR' then INR.acno  "
						 + "when  pin.dtype='ITR' then ITR.acno   when  pin.dtype='GIR' then GIR.acno  else ''  end as acno,  "
						 + "pin.dtype, pin.brhid,pin.psrno,pin.date ,pin.op_qty inqty ,pin.op_qty*pin.cost_price inval ,  "
						 + " ' ' isqty,' ' isqty1, ' '  isval, ' '  isval1,  "
						 + " ' ' balqty, ' ' balcost,  "
						 + " cost_price cpu  from my_prddin pin  "
						  + "left join my_grnm GRN on GRN.tr_no=pin.tr_no and pin.dtype='GRN'  "
						  + "left join my_srvm piv on PIV.tr_no=pin.tr_no and pin.dtype='PIV'  "
						  + "left join my_delrm DLR on DLR.tr_no=pin.tr_no and pin.dtype='DLR'  "
						  + "left join   my_invr  INR on INR.tr_no=pin.tr_no and pin.dtype='INR'  "
						  + "left join   my_invtranreceptm  ITR on ITR.tr_no=pin.tr_no and pin.dtype='ITR'  "
						  + "left join   my_girm  GIR on GIR.tr_no=pin.tr_no and pin.dtype='GIR' "+sqljoin+" where 1=1  and "
						  + "  cast(pin.date as date)>='"+frmdate+"' and cast(pin.date as date)<='"+todate+"'  "+insql+" "+wheresql+"  "
						  + "group by pin.stockid order by pin.stockid) ins  "
						  + "left join my_head h on(h.doc_no=ins.acno)  "
						  + " union all  "
						 + " select 2 ord,outs.minus ,'out' valtype, outs.tr_no,outs.psrno, outs.date,ac.refname description,outs.Stockid,outs.dtype,outs.docno,  "
						 + " outs.acno,' ' inqty,' ' inval,outs.issqty isqty,outs.issqty1,outs.issqty*outs.issuecostprice isval , "
						 + " outs.issqty1*outs.issuecostprice isval1,  "
						  + "' 'balqty,' ' balcost, outs.issuecostprice cpu  "
						  + "from (select case when pout.dtype='INV' then if(pout.rsv_qty<0,pout.rsv_qty,pout.del_qty) else 0 end as minus,pout.tr_no,pout.psrno,pout.Stockid,pout.dtype,cast(pout.date as date) date,  "
						  + "case when pout.dtype='GRR' then GRR.voc_no   when pout.dtype='PIR' then PIR.voc_no  "
						  + "	when pout.dtype='SOR' then SOR.voc_no  when pout.dtype='JOR' then JOR.voc_no  "
						  + "	when  pout.dtype='DEL' then DEL.voc_no   when  pout.dtype='INV' then INV.voc_no  when  pout.dtype='ITI' then ITI.voc_no  "
						  + "	when  pout.dtype='GIS' then GIS.voc_no  "
						  + "	else ''  end as DOCNO,   case when pout.dtype='GRR' then GRR.cldocno   when pout.dtype='PIR' then PIR.cldocno    when pout.dtype='SOR'  "
						  + " then SOR.cldocno  when pout.dtype='JOR' then JOR.cldocno    when  pout.dtype='DEL'  then DEL.cldocno   when  pout.dtype='INV' then INV.cldocno  "
						  + " 	when  pout.dtype='GIS' then GIS.cldocno  	else ''  end as cldocno , "
						  + "	case when pout.dtype='GRR' then GRR.acno   when pout.dtype='PIR' then PIR.acno  "
						 + "    when pout.dtype='SOR' then SOR.acno  "
						 + "    when  pout.dtype='DEL' then DEL.acno   when  pout.dtype='INV' then INV.acno  when  pout.dtype='ITI' then ITI.acno  "
						 + "	when  pout.dtype='GIS' then GIS.acno  "
						 + "	else ''  end as acno, case when  pout.dtype='DEL' then  "
						 + "	de.del_qty  "
						 + "	when  pout.dtype='SOR' ||  pout.dtype='JOR' then  "
						 + "	 rs.rsv_qty  "
						 + "	else pout.qty end as issqty, case when  pout.dtype='DEL' then  "
						 + "	de.del_qty  "
						 + "	when  pout.dtype='SOR' ||  pout.dtype='JOR' then  "
						 + "	 rs.rsv_qty  "
						 + "	else pout.qty+pout.del_qty end as issqty1, p.cost_price issuecostprice "
						 + "	from my_prddout pout left join  my_prddin p     on pout.stockid=p.stockid and pout.dtype!='SOR'  and pout.dtype!='JOR'  "
						 + " left join (select rsv_qty,stockid,doc_no from my_prddout group by stockid,doc_no) rs on rs.Stockid=pout.stockid and rs.doc_no=pout.doc_no "
						 + " left join (select del_qty,stockid,doc_no from my_prddout group by stockid,doc_no) de on de.Stockid=pout.stockid and de.doc_no=pout.doc_no "
						 + "	left join my_grrm GRR on GRR.tr_no=pout.tr_no and pout.dtype='GRR'  "
						 + "	left join my_srvm PIR on PIR.tr_no=pout.tr_no and pout.dtype='PIR'  "
						 + "	left join my_sorderm SOR on SOR.tr_no=pout.tr_no and pout.dtype='SOR'  "
						 + "	left join   my_joborderm  JOR on JOR.tr_no=pout.tr_no and pout.dtype='JOR'  "
						 + "	left join   my_delm  DEL on DEL.tr_no=pout.tr_no and pout.dtype='DEL'  "
						 + "	left join   my_invm  INV on INV.tr_no=pout.tr_no and pout.dtype='INV'  "
						 + "	left join   my_invtranissuem ITI on ITI.tr_no=pout.tr_no and pout.dtype='ITI'  "
						 + "    left join   my_gism  GIS on GIS.tr_no=pout.tr_no and GIS.dtype='GIS'  "+sqljoin1+" "
						 + "	where 1=1  and  pout.dtype!='SOR' and pout.dtype!='JOR' and cast(pout.date as date)>='"+frmdate+"' and cast(pout.date as date)<='"+todate+"'   "+outsql+"  "+wheresql+"   order by stockid,pout.doc_no) outs  "
						 + "    left join my_head h on(h.doc_no=outs.acno)     left join my_acbook ac on(ac.doc_no=outs.cldocno and ac.dtype='CRM') ) "
						 + "  res,(select @i:=0) as i,(select @j:=0) as j order by res.psrno, res.date,res.tr_no "; 
	 	 
			
			
			 left join (select sum(del_qty) del_qty,stockid,doc_no from my_prddout group by stockid) de
			   on de.Stockid=pout.stockid

		//	ArrayList<String> stldarray= new ArrayList<String>();
			ResultSet rs = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(rs);
			
			
 

		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}
*/
 

	 
	
}
