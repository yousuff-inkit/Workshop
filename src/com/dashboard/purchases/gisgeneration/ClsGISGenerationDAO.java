package com.dashboard.purchases.gisgeneration;

import java.sql.*;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.sales.InventoryTransfer.goodsissuenote.ClsGoodsissuenoteDAO;

public class ClsGISGenerationDAO {

	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	ClsGoodsissuenoteDAO goodsdao=new ClsGoodsissuenoteDAO();
	public JSONArray getMasterData(String uptodate,String branch,String id)throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select a.date,a.pivvocno,a.pivdocno,a.refname,a.invno,a.invdate,sum(amount) total,sum(jobwise) jobwisetotal,sum(stock) "+
			" stocktotal from ("+
			" select m.doc_no pivdocno,m.date,m.voc_no pivvocno,ac.refname,m.refinvno invno,m.refinvdate invdate,coalesce(d.nettaxamount,0)"+
			" amount,if(jobcarddocno>0,coalesce(nettaxamount,0),0) jobwise,if(jobcarddocno=0,coalesce(nettaxamount,0),0) stock"+
			" from my_srvm m left join my_srvd d on (m.doc_no=d.rdocno)"+
			" left join my_acbook ac on (m.cldocno=ac.cldocno and ac.dtype='VND') where m.status=3 and jobcarddocno!=0 and d.gistrno=0) a group by a.pivdocno";
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
	
	public JSONArray getDetailData(String pivdocno,String id) throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			String strsql="select d.jobcarddocno,job.voc_no jobcardvocno,din.batch_no,din.exp_date,bd.brandname,din.cost_price,d.foc,d.stockid,at.mspecno specid,m1.rdtype,m1.rrefno,m.part_no productid,m.productname,  "
			+ " d.sr_no,d.psrno,d.prdId prodoc,m.part_no proid ,m.productname proname, "
			+ " 	u.unit, d.unitid unitdocno,d.qty,d.qty oldqty,(dd.qty-dd.out_qty)+d.qty qutval,dd.out_qty-d.qty pqty,d.qty saveqty, "
			+ " 	d.amount unitprice,d.total,d.discount,d.disper discper,d.nettotal,d.taxper,d.taxamount taxperamt,d.nettaxamount taxamount,d.taxdocno from my_srvm m1  left join my_srvd d on m1.tr_no=d.tr_no  "
			+ " 	left join my_grnd dd on dd.stockid=d.stockid and dd.prdid=d.prdid and dd.specno=d.specno  "
			+ " left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no left join  my_brand bd on m.brandid=bd.doc_no  "
			+ "  left join my_prodattrib at on(at.mpsrno=m.doc_no) left join my_prddin din   on din.stockid=d.stockid and din.prdid=d.prdid and din.specno=d.specno"
			+ " left join ws_jobcard job on d.jobcarddocno=job.doc_no where m1.doc_no='"+pivdocno+"' and d.gistrno=0 group by d.stockid order by job.voc_no";
			Statement stmt=conn.createStatement();
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

	public int insert(String griddata, String pivdocno,
			HttpServletRequest request, HttpSession session) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			ArrayList<String> detailarray=new ArrayList<>();
			for(int i=0;i<griddata.split(",").length;i++){
				detailarray.add(griddata.split(",")[i]);
			}
			ArrayList<String> masterarray=new ArrayList<>();
			int oldjobcard=0;
			double total=0.0;
			for(int i=0;i<detailarray.size();i++){
				System.out.println("Detail Array:"+detailarray.get(i));
				System.out.println("Passed Job Card: "+Integer.parseInt(detailarray.get(i).split("::")[10].trim()));
				if(oldjobcard==0){
					oldjobcard=Integer.parseInt(detailarray.get(i).split("::")[10].trim());
				}
				System.out.println("After set1: "+oldjobcard);
				System.out.println("After set2: "+Integer.parseInt(detailarray.get(i).split("::")[10].trim()));
				System.out.println(i+"///"+(detailarray.size()-1));
				if(oldjobcard==Integer.parseInt(detailarray.get(i).split("::")[10].trim())){
					masterarray.add(detailarray.get(i).split("::")[0]+"::"+detailarray.get(i).split("::")[1]+"::"+detailarray.get(i).split("::")[2]+"::"+detailarray.get(i).split("::")[3]+"::"+detailarray.get(i).split("::")[4]+"::"+detailarray.get(i).split("::")[5]+"::"+detailarray.get(i).split("::")[6]+"::"+detailarray.get(i).split("::")[7]+"::"+detailarray.get(i).split("::")[8]+"::"+detailarray.get(i).split("::")[9]);
					total+=Double.parseDouble(detailarray.get(i).split("::")[9].trim());
				}
				else if((oldjobcard!=Integer.parseInt(detailarray.get(i).split("::")[10].trim()))){
					System.out.println("Inside Another Job card");
					String strmisc="select voc_no,curdate() sqlbasedate,cldocno,locid,brhid from my_srvm where doc_no="+pivdocno;
					java.sql.Date sqlbasedate=null;
					String refno="";
					int cldocno=0,locationid=0,brhid=0;
					ResultSet rsmisc=stmt.executeQuery(strmisc);
					while(rsmisc.next()){
						sqlbasedate=rsmisc.getDate("sqlbasedate");
						cldocno=rsmisc.getInt("cldocno");
						refno=rsmisc.getString("voc_no");
						locationid=rsmisc.getInt("locid");
						brhid=rsmisc.getInt("brhid");
					}
					String strgetjobcard="select if(gate.cldocno=0,gate.insurcldocno,gate.cldocno) cldocno from ws_jobcard job left join ws_estm est on (job.reftype='EST' and job.refno=est.doc_no) left join ws_gateinpass gate on (est.gipno=gate.doc_no) where job.doc_no="+oldjobcard;
					ResultSet rsgetjobcard=stmt.executeQuery(strgetjobcard);
					while(rsgetjobcard.next()){
						cldocno=rsgetjobcard.getInt("cldocno");
					}
					String description="Created from Purchase Inv "+refno;
					int goodsvalue=goodsdao.insert(sqlbasedate, refno, description, total, session, "A", "GIS", request, masterarray, locationid,
							cldocno, 0, 1, 9, oldjobcard);
					System.out.println("Goods Issue Value:"+goodsvalue);
					if(goodsvalue<=0){
						return 0;
					}
					ResultSet rsgistrno=stmt.executeQuery("select tr_no from my_gism where doc_no="+goodsvalue);
					int gistrno=0;
					while(rsgistrno.next()){
						gistrno=rsgistrno.getInt("tr_no");
					}
					String strupdatepiv="update my_srvd set gistrno="+gistrno+" where rdocno="+pivdocno+" and jobcarddocno="+oldjobcard;
					int updatepiv=stmt.executeUpdate(strupdatepiv);
					if(updatepiv<=0){
						return 0;
					}
					oldjobcard=0;
					masterarray=new ArrayList<>();
					total=0.0;
				}
				if(i==detailarray.size()-1){
					if(oldjobcard==0){
						oldjobcard=Integer.parseInt(detailarray.get(i).split("::")[10].trim());
					}
					if(oldjobcard==Integer.parseInt(detailarray.get(i).split("::")[10].trim())){
						masterarray.add(detailarray.get(i).split("::")[0]+"::"+detailarray.get(i).split("::")[1]+"::"+detailarray.get(i).split("::")[2]+"::"+detailarray.get(i).split("::")[3]+"::"+detailarray.get(i).split("::")[4]+"::"+detailarray.get(i).split("::")[5]+"::"+detailarray.get(i).split("::")[6]+"::"+detailarray.get(i).split("::")[7]+"::"+detailarray.get(i).split("::")[8]+"::"+detailarray.get(i).split("::")[9]);
						total+=Double.parseDouble(detailarray.get(i).split("::")[9].trim());
					}
					System.out.println("Inside End of loop");
					String strmisc="select voc_no,curdate() sqlbasedate,cldocno,locid,brhid from my_srvm where doc_no="+pivdocno;
					java.sql.Date sqlbasedate=null;
					String refno="";
					int cldocno=0,locationid=0,brhid=0;
					ResultSet rsmisc=stmt.executeQuery(strmisc);
					while(rsmisc.next()){
						sqlbasedate=rsmisc.getDate("sqlbasedate");
						cldocno=rsmisc.getInt("cldocno");
						refno=rsmisc.getString("voc_no");
						locationid=rsmisc.getInt("locid");
						brhid=rsmisc.getInt("brhid");
					}
					String strgetjobcard="select if(gate.cldocno=0,gate.insurcldocno,gate.cldocno) cldocno from ws_jobcard job left join ws_estm est on (job.reftype='EST' and job.refno=est.doc_no) left join ws_gateinpass gate on (est.gipno=gate.doc_no) where job.doc_no="+oldjobcard;
					ResultSet rsgetjobcard=stmt.executeQuery(strgetjobcard);
					while(rsgetjobcard.next()){
						cldocno=rsgetjobcard.getInt("cldocno");
					}
					String description="Created from Purchase Inv "+refno;
					int goodsvalue=goodsdao.insert(sqlbasedate, refno, description, total, session, "A", "GIS", request, masterarray, locationid,
							cldocno, 0, 1, 9, oldjobcard);
					System.out.println("Goods Issue Value:"+goodsvalue);
					if(goodsvalue<=0){
						return 0;
					}
					ResultSet rsgistrno=stmt.executeQuery("select tr_no from my_gism where doc_no="+goodsvalue);
					int gistrno=0;
					while(rsgistrno.next()){
						gistrno=rsgistrno.getInt("tr_no");
					}
					String strupdatepiv="update my_srvd set gistrno="+gistrno+" where rdocno="+pivdocno+" and jobcarddocno="+oldjobcard;
					int updatepiv=stmt.executeUpdate(strupdatepiv);
					if(updatepiv<=0){
						return 0;
					}
					oldjobcard=0;
					masterarray=new ArrayList<>();
				}
			}
			
			PreparedStatement stmtlog=conn.prepareStatement("insert into gl_biblog(doc_no, brhId, dtype, edate, userId, userNo, activity, ENTRY) values (?,?,?,now(),?,?,?,?)");
			stmtlog.setInt(1,Integer.parseInt(pivdocno));
			stmtlog.setInt(2,Integer.parseInt(session.getAttribute("BRANCHID").toString()));
			stmtlog.setString(3,"BGIG");
			stmtlog.setInt(4,Integer.parseInt(session.getAttribute("USERID").toString()));
			stmtlog.setInt(5, 0);
			stmtlog.setInt(6, 0);
			stmtlog.setString(7, "A");
			int log=stmtlog.executeUpdate();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return 1;
	}
}
