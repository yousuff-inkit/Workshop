package com.dashboard.workshop.partsplanning;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsPartsPlanningDAO {

	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	
	public JSONArray getPartsPlanData(String id,String brhid) throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.trim().equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			String sqlfilters="";
			if(!brhid.trim().equalsIgnoreCase("") && !brhid.trim().equalsIgnoreCase("a")){
				sqlfilters+=" and job.brhid="+brhid;
			}
			String strsql="select sp.comp gistatus,gate.regno,ac.cldocno,job.doc_no jobdocno,job.voc_no jobvocno,job.date,est.doc_no estdocno,est.voc_no estvocno,gate.doc_no gatedocno,"+
			" gate.voc_no gatevocno,br.doc_no brhid,br.branchname branch,concat(ac.refname,' , Address: ',ac.address,' , Telephone: ',"+
			" ac.per_tel,' , Mobile: ',ac.per_mob,' , Mail: ',ac.mail1,' , Contact Person ',ac.contactperson) userdetails,"+
			" convert(concat(coalesce(brd.brand_name,''),' ',coalesce(model.vtype,''),' Reg No: ',coalesce(gate.regno,''),' Plate Code: ',"+
			" coalesce(gate.pltid,''),' YoM: ',coalesce(yom.yom,''),' Others: ',coalesce(gate.vehother,'')),char(200)) vehicledetails from"+
			" ws_jobcard job left join ws_estm est on job.reftype='EST' and job.refno=est.doc_no left join ws_gateinpass gate on"+
			" est.gipno=gate.doc_no left join my_brch br on job.brhid=br.doc_no left join my_acbook ac on"+
			" (gate.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_vehbrand brd on gate.brdid=brd.doc_no left join"+
			" gl_vehmodel model on gate.modid=model.doc_no left join gl_vehplate plate on gate.pltid=plate.doc_no left join"+
			" gl_yom yom on gate.yom=yom.doc_no left join (select if(sum(qty- goodsissueqty)<=0,1,0) comp,rdocno from ws_estspare where approved=1 group by rdocno) sp on (est.doc_no=sp.rdocno) where gate.processstatus<6"+sqlfilters;
			System.out.println(strsql);
			ResultSet rs=conn.createStatement().executeQuery(strsql);
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
	
	
	public JSONArray getPartsData(String estdocno,String id,String brhid) throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.trim().equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			//session.setAttribute("BRANCHID",brhid);
			conn=objconn.getMyConnection();
			String sqlfilters="";
			String strsql="select coalesce(round(b.stock,2),0)stock,bh.* from (select sp.rdocno,sp.purchaseprice,sp.purchasereqdocno,sp.nipurchasedocno,sp.rowno,sp.psrno,sp.qty,sp.rate,sp.description,m.productname,m.doc_no prdid,at.mspecno as specid,m.munit as unitdocno,coalesce(sp.goodsissueqty,0)goodsissueqty,coalesce(sp.goodsissueqty,0) issqty from ws_estspare sp left join my_main m on sp.psrno=m.psrno left join my_unitm u on m.munit=u.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) where sp.rdocno="+estdocno+" and sp.approved=1)bh left join (select round(sum((op_qty-out_qty-rsv_qty-del_qty)+(foc-foc_out)),2)stock,psrno from my_prddin  where brhid="+brhid+" group by psrno)b on b.psrno=bh.psrno"; 
			System.out.println("partsgridxcvxcv=="+strsql);
			ResultSet rs=conn.createStatement().executeQuery(strsql);
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
	
	public JSONArray getPartsSearchData(String id,String partno,String prdctnme,String stock,String unit) throws SQLException{
		JSONArray partsdata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return partsdata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String sqltest="";
			//System.out.println("++++++++++"+unit);
			if(!(partno.equalsIgnoreCase("undefined"))&&!(partno.equalsIgnoreCase(""))&&!(partno.equalsIgnoreCase("0"))) {
				sqltest+=sqltest+" and a.partno like '%"+partno+"%'";
	        }
			if(!(prdctnme.equalsIgnoreCase("undefined"))&&!(prdctnme.equalsIgnoreCase(""))&&!(prdctnme.equalsIgnoreCase("0"))) {
				sqltest+=sqltest+" and a.productname like '%"+prdctnme+"%'";
	        }
			if(!(stock.equalsIgnoreCase("undefined"))&&!(stock.equalsIgnoreCase(""))&&!(stock.equalsIgnoreCase("0"))) {
			//	sqltest+=sqltest+" and a.balqty like '%"+stock+"%'";
	        }
			if(!(unit.equalsIgnoreCase("undefined"))&&!(unit.equalsIgnoreCase(""))&&!(unit.equalsIgnoreCase("0"))) {
				sqltest+=sqltest+" and a.unit like '%"+unit+"%'";
	        }
			String strsql="select coalesce(round(b.stock,2),0)stock,a.* from (select m.doc_no prdid,at.mspecno as specid,bd.brandname,m.fixingprice,m.psrno partdocno,m.part_no partno,m.productname,m.doc_no,"+
			" u.unit,m.munit as unitdocno,m.psrno,'' qty"+
			" from my_main m left join my_unitm u on m.munit=u.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd"+
			" on m.brandid=bd.doc_no where m.status=3) a left join (select round(sum((op_qty-out_qty-rsv_qty-del_qty)+(foc-foc_out)),2)stock,psrno from my_prddin group by psrno)b on b.psrno=a.psrno  where 1=1 " +sqltest+" ";
			
			
			
			ResultSet rs=stmt.executeQuery(strsql);
			partsdata=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		return partsdata;
	}
}
