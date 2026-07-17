package com.dashboard.projectexecution.materialissue;  

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
 
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
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
			
			
			
			String sqltest="";
			
			if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
				sqltest=sqltest+" and m.brhid='"+branch+"'";
				}
			
			if(!(cldocno.equalsIgnoreCase(""))){
				sqltest=sqltest+" and m.cldocno = '"+cldocno+"'";
			}
		 
			String sqltest1="";
			if(!(docnoss.equalsIgnoreCase(""))){
				sqltest1= " and a.costdocno = '"+docnoss+"'";
			}
 
	           String pySql = " select a.* from (  select m.brhid, u.costgroup,t.type,m.description desc1,m.refno,m.doc_no,m.voc_no,m.date,m.issuetype,m.locid,l.loc_name,"
       				+ " m.costtype,m.siteid,s.site,a.refname,m.cldocno, "
       				+ " case when m.costtype=1 then m.costdocno when m.costtype in(3,4) then co.doc_no "
       				+ " when m.costtype in(5) then cs.doc_no  end as 'costdocno' , "
       				+ " case when m.costtype=1 then c.description when m.costtype in(3,4) then convert(concat(co.ref_type,' ',co.refdocno),char(100)) "
       				+ " when m.costtype in (5) then convert(concat(cs.contracttype,' ',cs.contractno),char(100))  end as 'prjname' "
       				+ " from my_mreqm m left join my_locm l on l.doc_no=m.locid left join my_issuetype t on t.doc_no=m.issuetype"
       				+ " left join my_costunit u on u.costtype=m.costtype  "
       				+ " left join my_ccentre c on c.costcode=m.costdocno and m.costtype=1 "
       				+ " left join cm_srvcontrm co on co.tr_no=m.costdocno and m.costtype in(3,4) "
       				+ " left join cm_cuscallm cs on cs.tr_no=m.costdocno and m.costtype=5 "
       				+ " left join cm_srvcsited s on s.rowno=m.siteid and m.costtype in(3,4,5) "
       				+ " left join my_acbook a on a.cldocno=m.cldocno and m.costtype in(3,4,5) and a.dtype='CRM'  "
       				+ " left join my_mreqd d on d.rdocno=m.doc_no  left join (select sum(qty) eqty ,sum(issueqty) issueqty ,"
       				+ " psrno,tr_no,costdocno from  gl_estconfirm es group by costdocno,psrno) e "
       				+ " on (m.costdocno=e.costdocno and d.psrno=e.psrno ) "
       				+ " where m.status=3  and e.eqty>e.issueqty  and d.qty>d.out_qty   "+sqltest+"  group by m.doc_no ) a  where 1=1 "+sqltest1+""    ;
        	
	        System.out.println("===pySql="+pySql);
     
			ResultSet resultSet = stmtmain.executeQuery(pySql);

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
//	System.out.println(RESULTDATA);
    return RESULTDATA;
}

public   JSONArray sublistGridReload(String barchval,String doc_no,String locid) throws SQLException {

	
	JSONArray RESULTDATA=new JSONArray();
	
      
    
    Connection conn = null;
	try {
		conn = ClsConnection.getMyConnection();
	 
		
			Statement stmtmain = conn.createStatement ();
			
 
        	String pySql="   select a.erowno,a.locid,a.brhid,a.brandname,a.psrno,a.qty,a.rowno,a.productid,a.productname,a.unit"
        			+ " ,if(a.eqty>(coalesce(i.stockqty,0)+coalesce(a.eresqty,0)),coalesce(i.stockqty,0)+coalesce(a.eresqty,0),a.eqty) issueqty ,"
        			+ " coalesce(i.stockqty,0)+coalesce(a.eresqty,0) stockqty , "
        			+ " coalesce(a.eresqty,0) eresqty ,a.eqty,a.eissueqty,a.ebalqty  "
        			+ "  from ( select erowno,coalesce(e.eresqty,0) eresqty ,eqty,eissueqty,eqty-eissueqty ebalqty,"
        			+ " ma.locid,ma.brhid,bd.brandname,d.psrno, d.qty-d.out_qty qty , d.rowno," 
        					+" m.part_no productid,m.productname,u.unit  from my_mreqm ma left join my_mreqd d on(ma.doc_no=d.rdocno) "
        					+"left join my_main m on(d.psrno=m.doc_no and d.prdid=m.psrno) left join  my_unitm u on(d.unitid=u.doc_no) "
        					+" left join  my_brand bd on m.brandid=bd.doc_no "
        					+" left join my_prodattrib at on(at.mpsrno=m.doc_no and d.specno=at.mpsrno ) "
        					 +"  inner join (select convert(group_concat(rowno SEPARATOR '@') ,char(100)) erowno,sum(qty) eqty ,sum(issueqty) eissueqty ,"
        					 + "  sum(resqty-resoutqty) eresqty,"
        					 + "  psrno,tr_no,costdocno from  "
        					 + " gl_estconfirm es group by costdocno,psrno) e "
        					 + " on (ma.costdocno=e.costdocno and d.psrno=e.psrno ) " 
        					+" where m.status=3 and d.rdocno='"+doc_no+"'   and e.eqty>e.eissueqty  and d.qty>d.out_qty ) a "
        					+" left join  ( select  sum(op_qty-(out_qty+del_qty+rsv_qty)) stockqty,psrno,locid,brhid,specno   from my_prddin "
        					+" where brhid='"+barchval+"' and locid='"+locid+"'     group by psrno) i on    i.psrno=a.psrno ";
        					 
         
//     System.out.println();
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
//	System.out.println(RESULTDATA);
    return RESULTDATA;
}







Connection conn=null;
public int insert(Date masterdate, String refno, String purdesc,
	double productTotal, HttpSession session, String mode,
	String formdetailcode, HttpServletRequest request,
	ArrayList<String> masterarray, int txtlocationid, int cldocno,
	int siteid, int type, int itemtype, int itemdocno,int brhid,Connection conn,int masterdocno) throws SQLException {
 

try{
	int docno;
 
	CallableStatement stmtgin= conn.prepareCall("{call tr_goodsissuenoteDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
	stmtgin.registerOutParameter(15, java.sql.Types.INTEGER);
	stmtgin.registerOutParameter(16, java.sql.Types.INTEGER);

	stmtgin.setDate(1,masterdate);
	stmtgin.setString(2,refno);
	stmtgin.setString(3,purdesc);
	stmtgin.setDouble(4,productTotal);
	stmtgin.setString(5,session.getAttribute("USERID").toString());
	stmtgin.setInt(6,brhid);
	stmtgin.setString(7,session.getAttribute("COMPANYID").toString());
	stmtgin.setString(8,formdetailcode);
	stmtgin.setString(9,mode);
	stmtgin.setInt(10,txtlocationid);
	stmtgin.setInt(11,siteid);
	stmtgin.setInt(12,type);
	stmtgin.setInt(13,itemtype);  
	stmtgin.setInt(14,itemdocno);
	stmtgin.setInt(17,cldocno);
	stmtgin.executeQuery();
	docno=stmtgin.getInt("docNo");
	int vocno=stmtgin.getInt("vocNo");	
	request.setAttribute("vocno", vocno);
	if(docno<=0)
	{
		conn.close();
		return 0;
		
	}
	 Statement stmt1=conn.createStatement();
	 Statement stmt=conn.createStatement();
		int mastertr_no=0;
		String sqlss="select tr_no from my_gism where doc_no='"+docno+"' ";
		ResultSet selrs=stmt1.executeQuery(sqlss);
		
		if(selrs.next())
		{
			mastertr_no=selrs.getInt("tr_no");
			
		}
		int prodet=0;
		int prodout=0;
		for(int i=0;i< masterarray.size();i++){

			String[] prod=((String) masterarray.get(i)).split("::");
			System.out.println("prod[0]===="+prod[0]);
			if(!((prod[0].equalsIgnoreCase("0"))||(prod[0].equalsIgnoreCase("undefined")))){

		String prdid=""+(prod[0].trim().equalsIgnoreCase("undefined") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].trim().equalsIgnoreCase("")|| prod[0].isEmpty()?0:prod[0].trim())+"";
		String specno=""+(prod[6].equalsIgnoreCase("undefined") || prod[6].equalsIgnoreCase("") || prod[6].trim().equalsIgnoreCase("NaN")|| prod[6].isEmpty()?0:prod[6].trim())+"";
		String  rqty=""+(prod[3].trim().equalsIgnoreCase("undefined") || prod[3].trim().equalsIgnoreCase("NaN")|| prod[3].trim().equalsIgnoreCase("")|| prod[3].isEmpty()?0:prod[3].trim())+"";
		double masterqty=Double.parseDouble(rqty);
		String  rns=""+(prod[10].trim().equalsIgnoreCase("undefined") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].trim().equalsIgnoreCase("")|| prod[10].isEmpty()?0:prod[10].trim().replaceAll("\\@", ","))+"";
		String  res=""+(prod[11].trim().equalsIgnoreCase("undefined") || prod[11].trim().equalsIgnoreCase("NaN")|| prod[11].trim().equalsIgnoreCase("")|| prod[11].isEmpty()?0:prod[11].trim())+"";
		double ress=Double.parseDouble(res);
		double balstkqty=0;
		double balstkqty1=0;
		int psrno=0;
		int stockid=0;
		double remstkqty=0;
		double outstkqty=0;
		double stkqty=0;
		double qty=0;
		double detqty=0;
		double unitprice=0.0;
		double tmp_qty=0.0;
		double prtmp_qty=0.0;
		double outqtys=0.0;
		double refqty=0.0;
		double rsvqty=0.0;
		String qty_fld="";
		String qryapnd="";
		String slquery="";
		String loc="";
		int rownos=0;
		int prdocno=0;
		double balrsvqty=0.0;
		double cost_price=0;
		int locids=0;
		if(ress>0)
		{
			qty_fld="pin.rsv_qty";
			slquery="(pin.out_qty+pin.del_qty)";
			loc="and pin.locid="+txtlocationid+" ";
		}
		else
		{
			rns="0";
			qty_fld="pin.out_qty";
		 	slquery="(pin.out_qty+pin.rsv_qty+pin.del_qty)";
		 	loc="and pin.locid="+txtlocationid+" ";
		}
		

		Statement stmtstk=conn.createStatement();
		Statement stmtstk1=conn.createStatement();
		String stkSql=" select coalesce(pr.rdocno,0) rownos,coalesce(pr.doc_no,0) prdocno,coalesce(pr.rsv_qty-pr.issueqty,0) balrsvqty,coalesce(pr.rsv_qty,0) rsvqty ,"
				+ " pin.cost_price,pin.locid,pin.stockid,pin.psrno,pin.specno,sum(pin.op_qty) stkqty,sum((pin.op_qty-"+slquery+")) balstkqty,"+slquery+" out_qty,"+qty_fld+" as qty,pin.out_qty qtys,pin.date from my_prddin pin"
				+ "   left join my_prddr pr on pr.stockid=pin.stockid and pin.psrno=pr.psrno and pr.rdocno in ("+rns+")  "
				+ "where pin.psrno='"+prdid+"' and pin.specno='"+specno+"' "+qryapnd+"  and pin.prdid='"+prdid+"' and pin.brhid="+brhid+" "+loc+"  "
				+ "group by pin.stockid,pin.cost_price,pin.prdid,pin.psrno having sum((op_qty-"+slquery+"))>0 order by pin.date,pin.stockid";
		//System.out.println("=1111111111111111111111   1stkSql=inside insert="+stkSql);
		ResultSet rsstk = stmtstk.executeQuery(stkSql);
		while(rsstk.next()) {
			balstkqty1=rsstk.getDouble("balstkqty");
			balstkqty=rsstk.getDouble("balstkqty");
			psrno=rsstk.getInt("psrno");
			outstkqty=rsstk.getDouble("out_qty");
			stockid=rsstk.getInt("stockid");
			stkqty=rsstk.getDouble("stkqty");
			qty=rsstk.getDouble("qty");
			outqtys=rsstk.getDouble("qtys");
			locids=rsstk.getInt("locid");
			cost_price=rsstk.getDouble("cost_price");
			rownos=rsstk.getInt("rownos");
			prdocno=rsstk.getInt("prdocno");
			rsvqty=rsstk.getDouble("rsvqty");
			balrsvqty=rsstk.getDouble("balrsvqty");
			refqty=masterqty;
		/*	System.out.println("--33--rownos---"+rownos);
			System.out.println("--33--rsvqty---"+rsvqty);
			System.out.println("--33--prdocno---"+prdocno);
			System.out.println("--33--balrsvqty---"+balrsvqty);*/
		/*	System.out.println("---masterqty-----"+masterqty);	
			System.out.println("---balstkqty-----"+balstkqty);	
			System.out.println("---out_qty-----"+outstkqty);	
			System.out.println("---stkqty-----"+stkqty);
			System.out.println("---qty-----"+qty);
			System.out.println("---cost_price-----"+cost_price);*/
			
			String queryappnd="";

			if(remstkqty>0)
			{

				masterqty=remstkqty;
			}

			 
			if(masterqty<=balstkqty)
			{
				detqty=masterqty;

 
		      //  queryappnd=","+qty_fld+"="+tmp_qty+"";	
				  
				qty_fld="rsv_qty";
				tmp_qty=qty-masterqty;
				
				 /* prtmp_qty=rsvqty-masterqty;*/
				if(tmp_qty<=0)
				{
					tmp_qty=0;
				}
				
				/*if(prtmp_qty<=0)
				{
					prtmp_qty=0;
				}
				*/
				
				queryappnd=","+qty_fld+"="+tmp_qty+"";	
					
				 
				if(ress<=0)
				{
					queryappnd="";
				}
				
				
				
				
			//	System.out.println("-----queryappnd-----"+queryappnd);
				

				masterqty=masterqty+outqtys;

				
				 
				
				
				
				
				String sqls="update my_prddin set out_qty="+masterqty+" "+queryappnd+"   where stockid="+stockid+" and prdid="+prdid+" and  psrno="+psrno+" and specno="+specno+" and brhid="+brhid+" and locid="+locids+"   ";
				System.out.println("--1---sqls---"+sqls);
				stmt.executeUpdate(sqls);
				
			
				
 


				masterqty=detqty;
			}
			else if(masterqty>balstkqty)
			{



				if(stkqty>=(masterqty+outstkqty))

				{
					balstkqty=masterqty+outqtys;	
					remstkqty=stkqty-outstkqty;

					//System.out.println("---balstkqty-1---"+balstkqty);
				}
				else
				{
					remstkqty=masterqty-balstkqty;
					balstkqty=stkqty-outstkqty+outqtys;

					/*System.out.println("---masterqty-2---"+masterqty);
					System.out.println("---outstkqty-2---"+outstkqty);
					System.out.println("---stkqty-2---"+stkqty);
					System.out.println("---remstkqty-2---"+remstkqty);
					System.out.println("---balstkqty--2--"+balstkqty);*/
				}
				detqty=stkqty-outstkqty;

				 qty_fld="rsv_qty";
					tmp_qty=qty-balstkqty;
					//  prtmp_qty=rsvqty-balstkqty;
					if(tmp_qty<=0)
					{
						tmp_qty=0;
					}
				/*	if(prtmp_qty<=0)
					{
						prtmp_qty=0;
					}
					*/
					queryappnd=","+qty_fld+"="+tmp_qty+"";	
					
					
					 
					if(ress<=0)
					{
						queryappnd="";
					}
					
					
					
				String sqls="update my_prddin set out_qty="+balstkqty+" "+queryappnd+"  where stockid="+stockid+" and prdid="+prdid+" and  psrno="+psrno+" and specno="+specno+" and brhid="+brhid+" and locid="+locids+"";	
			//	System.out.println("-2----sqls---"+sqls);

				stmt.executeUpdate(sqls);	
				
				
				
				
				
				
	 


			 


			}
			
			
			 
			if(ress>0)
			{
			 
			 
			String sqlsss="select issueqty,resoutqty,openqty,qty from gl_estconfirm where rowno="+rownos+" ";
			
			//System.out.println("--33--sqlsss---"+sqlsss);
			
			ResultSet rsstk1 = stmtstk1.executeQuery(sqlsss);

			if(rsstk1.next()) {
			 
				
				if(detqty>balrsvqty)
				{
				prtmp_qty=balrsvqty;
				}
				else if(detqty<balrsvqty)
				{
				prtmp_qty=detqty;
				}
				
				
				if(prtmp_qty<=0)
				{
					prtmp_qty=0;
					
				}
				
				String sqls11="update my_prddr set issueqty=("+rsstk1.getDouble("issueqty")+")+("+prtmp_qty+")  where stockid="+stockid+" and prdid="+prdid+" and  psrno="+psrno+"    and doc_no='"+prdocno+"'   "; 
				System.out.println("--1---sqls11---"+sqls11);
				stmt.executeUpdate(sqls11);
							
				
				String sqls12="update gl_estconfirm  set  resoutqty=("+rsstk1.getDouble("resoutqty")+")+("+prtmp_qty+"),openqty=("+rsstk1.getDouble("openqty")+")+(("+detqty+")-("+prtmp_qty+"))  where  rowno='"+rownos+"'   ";
				System.out.println("--2---sqls12---"+sqls12);
				stmt.executeUpdate(sqls12);
				
			}
			
						
			}
 
             double totalcostprice=cost_price*detqty;
			 String sql="insert into my_gisd(TR_NO, SR_NO,rdocno,stockid,SpecNo, psrno, prdId,  qty,  cost_price, totalcost_price , UNITID,  locid)VALUES"
					+ " ("+mastertr_no+","+(i+1)+",'"+docno+"',"
					+ "'"+stockid+"',"
					+ "'"+(prod[6].equalsIgnoreCase("undefined") || prod[6].equalsIgnoreCase("") || prod[6].trim().equalsIgnoreCase("NaN")|| prod[6].isEmpty()?0:prod[6].trim())+"',"
					+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
					+ "'"+(prod[1].equalsIgnoreCase("undefined") || prod[1].equalsIgnoreCase("") || prod[1].trim().equalsIgnoreCase("NaN")|| prod[1].isEmpty()?0:prod[1].trim())+"',"
					+ "'"+detqty+"',"
					+ ""+cost_price+","
					+ ""+totalcostprice+","
		 			+ "'"+(prod[2].trim().equalsIgnoreCase("undefined") || prod[2].trim().equalsIgnoreCase("") || prod[2].trim().equalsIgnoreCase("NaN")|| prod[2].isEmpty()?0:prod[2].trim())+"',"
					+ "'"+locids+"')";

			 stmt.executeUpdate(sql);
			 
			 double saveqty=0;
			 if(prtmp_qty>0)
			 {
				 saveqty=prtmp_qty*-1;
			 }
			 
				
		String prodoutsql="insert into my_prddout(sr_no,TR_NO, dtype, rdocno,stockid,date, specid, psrno,qty,prdid,brhid,locid,cost_price,unit_price,"+qty_fld+") Values"
						+ " ("+(i+1)+",'"+mastertr_no+"','"+formdetailcode+"',"+docno+","
						+ "'"+stockid+"',"
						+ "'"+masterdate+"',"
						+ "'"+(prod[6].equalsIgnoreCase("undefined") || prod[6].equalsIgnoreCase("") || prod[6].trim().equalsIgnoreCase("NaN")|| prod[6].isEmpty()?0:prod[6].trim())+"',"
						+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
						+ "'"+detqty+"',"
						+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
						+"'"+brhid+"','"+locids+"',"+cost_price+","+cost_price+","+saveqty+")";

			  
			//System.out.println("prodoutsql--->>>>Sql"+prodoutsql);
			prodout = stmt.executeUpdate (prodoutsql);
			
			
			
			
		//	System.out.println("masterqty--------------------------->>>>"+masterqty);
			
		//	System.out.println("balstkqty1---------------------------------->>>>"+balstkqty1);
	 	if(masterqty<=balstkqty1)
			{
				break;
			} 


		}
		
		 
		if(itemdocno>0)
		{
			double balqty=0;
			int docnos=0;
			double remqty=0;
			double out_qty=0;
			double qtys=0;


		String sqlsss="select  d.qty qty,sum((d.qty-d.issueqty)) balqty,d.rowno doc_no,d.issueqty  out_qty,d.prdid  "
				+ " from gl_estconfirm d where psrno="+psrno+" and costdocno="+itemdocno+"   group by d.rowno having  sum((d.qty-d.issueqty))>0 ";
		//System.out.println(" -----sqlsss--------------------->>>>"+sqlsss);
		ResultSet rs = stmtstk1.executeQuery(sqlsss);
		while(rs.next()) {

			balqty=rs.getDouble("balqty");
			out_qty=rs.getDouble("out_qty");
			docnos=rs.getInt("doc_no");
			qtys=rs.getDouble("qty");

		//	refqty=masterqty;
			/*System.out.println("---masterqty c-----"+masterqty);
			
			System.out.println("---refqty--c---"+refqty);	
			System.out.println("---balqty--c---"+balqty);	
			System.out.println("---out_qty--c---"+out_qty);	
			System.out.println("---qtys----c-"+qtys);*/


			if(remqty>0)
			{

				refqty=remqty;
			}


			if(refqty<=balqty)
			{
				refqty=refqty+out_qty;


				String sqls="update gl_estconfirm set issueqty="+refqty+" where  rowno="+docnos+" ";

				//System.out.println("--1--first-sqls---"+sqls);


				stmt.executeUpdate(sqls);
				break;


			}
			else if(refqty>balqty)
			{



				if(qtys>=(refqty+out_qty))

				{
					balqty=refqty+out_qty;	
					remqty=qtys-out_qty;

					//	System.out.println("---remqty-1---"+remqty);
				}
				else
				{
					remqty=refqty-balqty;
					balqty=qtys;

					//System.out.println("---remqty--2--"+remqty);
				}


				String sqls="update gl_estconfirm set issueqty="+balqty+"   where  rowno="+docnos+" ";
				System.out.println("-2----sqls---"+sqls);

				stmt.executeUpdate(sqls);	

				//remqty=masterqty-qtys;



			}

			}
			
		}
		
		
		
	 ///my_reqd
		 

			
			
			}
		
		



		}

		
		String vendorcur="1"; 
		double venrate=1;
		
 int accounts=0;
 
 
 double  finalamt=0;
	String refdetails="GIS"+""+vocno;
	
	int trno=0;
 
	String sql30="select tr_no,sum(totalcost_price) totalcost_price from my_gisd where rdocno='"+docno+"' ";
	System.out.println("-----4--sql2----"+sql30) ;

		ResultSet tass30 = stmt.executeQuery (sql30);

		if (tass30.next()) {

			finalamt=tass30.getDouble("totalcost_price");		
			trno=tass30.getInt("tr_no");
		}
	 
 
 
			
		String sql29="select acno from my_issuetype where doc_no='"+type+"' ";
	System.out.println("-----4--sql2----"+sql29) ;

		ResultSet tass19 = stmt.executeQuery (sql29);

		if (tass19.next()) {

			accounts=tass19.getInt("acno");		

		}
	 
		

		String sqls10="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+accounts+"'";
		//System.out.println("---1----sqls10----"+sqls10) ;
		ResultSet tass11 = stmt.executeQuery (sqls10);
		if(tass11.next()) {

			vendorcur=tass11.getString("curid");	


		}


		String currencytype="";
		String sqlvenselect = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
				+"where  coalesce(toDate,curdate())>='"+masterdate+"' and frmDate<='"+masterdate+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+vendorcur+"'";
		 System.out.println("-----2--sqlvenselect----"+sqlvenselect) ;
		ResultSet resultSet33 = stmt.executeQuery(sqlvenselect);

		while (resultSet33.next()) {
			venrate=resultSet33.getDouble("rate");
			currencytype=resultSet33.getString("type");
		}

		double	dramount=finalamt; 


		double ldramount=0;
		if(currencytype.equalsIgnoreCase("D"))
		{


			ldramount=dramount/venrate ;  
		}

		else
		{
			ldramount=dramount*venrate ;  
		}



		String sql1="";
 

			  sql1="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,dTYPE,brhId,tr_no,STATUS,costtype, costcode)   "
					+ "values('"+masterdate+"','"+refdetails+"',"+docno+",'"+accounts+"','"+refdetails+"','"+vendorcur+"','"+venrate+"',"+dramount+","+ldramount+",0,1,6,0,0,0,'"+venrate+"','GIS','"+brhid+"',"+trno+",3,"+itemtype+","+itemdocno+")";
 
		int ss = stmt.executeUpdate(sql1);

		if(ss<=0)
		{
			conn.close();
			return 0;

		}
		
		int acnos=0;
		String curris="1";
		double rates=1;



		String sql2="select  acno from my_account where codeno='STOCK ACCOUNT' ";
		//System.out.println("-----4--sql2----"+sql2) ;

		ResultSet tass1 = stmt.executeQuery (sql2);

		if (tass1.next()) {

			acnos=tass1.getInt("acno");		

		}



		String sqls3="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+acnos+"'";
		//System.out.println("-----5--sqls3----"+sqls3) ;
		ResultSet tass3 = stmt.executeQuery (sqls3);

		if (tass3.next()) {

			curris=tass3.getString("curid");	


		}
		String currencytype1="";
		String sqlveh = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
				+"where  coalesce(toDate,curdate())>='"+masterdate+"' and frmDate<='"+masterdate+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+curris+"'";
		//System.out.println("-----6--sqlveh----"+sqlveh) ;
		ResultSet resultSet44 = stmt.executeQuery(sqlveh);

		while (resultSet44.next()) {
			rates=resultSet44.getDouble("rate");
			currencytype1=resultSet44.getString("type");
		} 

		double pricetottal=finalamt*-1;
		double ldramounts=0 ;     
		if(currencytype1.equalsIgnoreCase("D"))
		{

			ldramounts=pricetottal/venrate ;  
		}

		else
		{
			ldramounts=pricetottal*venrate ;  
		}

		String sql11="";
	 

		  sql11="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,dTYPE,brhId,tr_no,STATUS,costtype, costcode)   "
				+ "values('"+masterdate+"','"+refdetails+"',"+docno+",'"+acnos+"','"+refdetails+"','"+curris+"','"+rates+"',"+pricetottal+","+ldramounts+",0,-1,6,0,0,0,'"+rates+"','GIS','"+brhid+"',"+trno+",3,"+itemtype+","+itemdocno+")";

	 

		int ss1 = stmt.executeUpdate(sql11);

		if(ss1<=0)
		{
			conn.close();
			return 0;

		}
		
		
		
		if(itemtype>0)
		{

			 int TRANIDs=0;
			 int sno=1;
			  
		Statement sss=conn.createStatement();
				String trsqlss="SELECT coalesce(max(TRANID),1) TRANID FROM my_jvtran where tr_no="+mastertr_no+" and acno="+accounts+" ";
		
				ResultSet tass111 = sss.executeQuery (trsqlss);
				
				if (tass111.next()) {
			
					TRANIDs=tass111.getInt("TRANID");	
				
				
					
			     }
				
				String ssql="insert into my_costtran(sr_no,acno,costtype,amount,jobid,tranid,tr_no) values("+sno+",'"+accounts+"', "
						+ " "+itemtype+","+finalamt+","+itemdocno+","+TRANIDs+","+mastertr_no+")";
						 
		  int costabsq=  stmtgin.executeUpdate(ssql);
		  
		  if(costabsq<=0)
			{
				conn.close();
				return 0;
				
			}
		}
		
		
		if(docno>0)
		{
		 	 
			stmtgin.close();
			 
			return docno;
			
		}
 
		
		}
 

catch (Exception e) {
	conn.close();
	e.printStackTrace();
}

conn.close();
return 0;
}


	
}

/*		


double balqty=0;
int docnos=0;
int rdocno=0;
double remqty=0;
double out_qty=0;
double qtys=0;

 

String strSql="select d.qty qty,sum((d.qty-d.out_qty)) balqty,d.rowno doc_no,d.rdocno,d.out_qty out_qty,d.prdid  from my_mreqm m  left join "
		+ "my_mreqd d on m.doc_no=d.rdocno where d.rdocno in ("+masterdocno+")  and d.prdid='"+prdid+"'  group by d.rowno having  sum(d.qty-d.out_qty)>0 "
		+ "order by m.date,d.rowno";

System.out.println("---strSql-----"+strSql);
ResultSet rs = stmt1.executeQuery(strSql);


while(rs.next()) {


	balqty=rs.getDouble("balqty");
	rdocno=rs.getInt("rdocno");
	out_qty=rs.getDouble("out_qty");

	docnos=rs.getInt("doc_no");
	qtys=rs.getDouble("qty");

//	refqty=masterqty;
	System.out.println("---masterqty-----"+masterqty);	
	System.out.println("---balqty-----"+balqty);	
	System.out.println("---out_qty-----"+out_qty);	
	System.out.println("---qtys-----"+qtys);


	if(remqty>0)
	{

		refqty=remqty;
	}


	if(refqty<=balqty)
	{
		refqty=refqty+out_qty;
		String sqls="update my_mreqd set out_qty="+refqty+" where rdocno="+rdocno+" and prdid="+prdid+" and  rowno="+docnos+" ";
		System.out.println("--1---save---"+sqls);
		stmt.executeUpdate(sqls);
		Statement ss=conn.createStatement();
        String sql="select qty,out_qty from my_mreqd   where rdocno="+rdocno+" and prdid="+prdid+" and rowno="+docnos+" and  out_qty>qty ";	
        System.out.println("-updatesql-"+sql);
		ResultSet rs2=ss.executeQuery(sql);
			if(rs2.next())
			{
				String sqls2="update my_mreqd set out_qty=qty where rdocno="+rdocno+" and prdid="+prdid+" and  rowno="+docnos+" ";
				ss.executeUpdate(sqls2);
				
			}
			break;

	}
	else if(refqty>balqty)
	{
		if(qtys>=(refqty+out_qty))
		{
			balqty=refqty+out_qty;	
			remqty=qtys-out_qty;
			//	System.out.println("---remqty-1---"+remqty);
		}
		else
		{
			remqty=refqty-balqty;
			balqty=qtys;
			//System.out.println("---remqty--2--"+remqty);
		}

		String sqls="update my_mreqd set out_qty="+balqty+" where rdocno="+rdocno+" and prdid="+prdid+" and  rowno="+docnos+" ";	
		System.out.println("-2----save---"+sqls);
		stmt.executeUpdate(sqls);	
	    Statement ss=conn.createStatement();
        String sql="select qty,out_qty from my_mreqd   where rdocno="+rdocno+" and prdid="+prdid+" and rowno="+docnos+" and  out_qty>qty ";	
        System.out.println("-updatesql-"+sql);
		ResultSet rs2=ss.executeQuery(sql);
			if(rs2.next())
			{
				String sqls2="update my_mreqd set out_qty=qty where rdocno="+rdocno+" and prdid="+prdid+" and  rowno="+docnos+" ";
				ss.executeUpdate(sqls2);
				
			}
		//remqty=masterqty-qtys;

	}

	}*/
