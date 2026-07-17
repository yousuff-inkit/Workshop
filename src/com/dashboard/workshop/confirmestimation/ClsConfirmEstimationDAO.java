package com.dashboard.workshop.confirmestimation;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

	public class ClsConfirmEstimationDAO {
		ClsConnection ClsConnection=new ClsConnection();

		ClsCommon commonDAO = new ClsCommon();
		
		public JSONArray getEstimationData(String cldocno,String fromdate,String todate,String id) throws SQLException{
			JSONArray RESULTDATA=new JSONArray();
			if(!id.equalsIgnoreCase("1")){
				return RESULTDATA;
			}
			Connection conn =null;
			
			try {
				conn=ClsConnection.getMyConnection();

				Statement stmt = conn.createStatement ();

				java.sql.Date sqlfromdate=null;
				java.sql.Date sqltodate=null;
				
				String sqltest="";
				
				if(!fromdate.equalsIgnoreCase("")){
					sqlfromdate=commonDAO.changeStringtoSqlDate(fromdate);
					sqltest+=" and ESTM.date>='"+sqlfromdate+"'";
				}
				if(!todate.equalsIgnoreCase("")){
					sqltodate=commonDAO.changeStringtoSqlDate(todate);
					sqltest+=" and ESTM.date<='"+sqltodate+"'";
				}
				
				if(!cldocno.equalsIgnoreCase("")){
					sqltest+=" and gip.cldocno="+cldocno;
				}
				
				
				/*String sqlqry="select * from (select coalesce(aa.addition,0) labaddition,coalesce(bb.addition,0) spaddition,coalesce(aa.maddn,0) labmaddn,coalesce(bb.maddn,0) spmaddn,"
				+" jc.voc_no jobno,estm.doc_no doc_no, estm.date date, estm.gipno gateinpassdocno,"
				+" estm.brhid brhid, ac.refname clientname,convert(concat(coalesce(vbrand.brand_name,''),' ',coalesce(vmodel.vtype,''),' Regno: ',coalesce(gip.regno,''),"
				+" ' Plate code: ',coalesce(plate.code_name,''),' ', coalesce(yom.yom,''),' Others: ',coalesce(gip.vehother,'')), char(200)) vehicledetails,"
				+" if(estm.chklumsum=0,coalesce(espr.sparetot,0),coalesce(espr.sparetot,0)+estm.lumsumamount) sparetot,  elab.labtot labouttot,0 discount,"
				+" (if(estm.chklumsum=0,coalesce(espr.sparetot,0),coalesce(espr.sparetot,0)+estm.lumsumamount)+elab.labtot)   nettotal from ws_estm estm "
				+" left join ws_gateinpass gip on(estm.gipno=gip.doc_no) left join my_acbook ac on(gip.cldocno=ac.cldocno and ac.dtype='CRM') "
				+" left join gl_vehbrand vbrand on(gip.brdid=vbrand.doc_no) left join gl_vehplate plate on (gip.pltid=plate.code_no) "
				+" left join gl_vehmodel vmodel on (gip.modid=vmodel.doc_no) left join gl_yom yom on gip.yom=yom.doc_no "
				+ " left join ws_jobcard jc on (if(jc.reftype='EST',jc.refno=estm.doc_no,jc.refno=gip.doc_no))"
				+" left join (select rdocno, coalesce(sum(total),0) labtot,confirmed from ws_estlabour where confirmed=0  group by rdocno) elab  on (estm.doc_no=elab.rdocno) "
				+" left join (select rdocno,coalesce(sum(approvedvalue),0) sparetot,confirmed from  ws_estspare  where confirmed=0  group by rdocno) espr on (estm.doc_no=espr.rdocno)"
				+" left join (select count(addition) addition,max(addition) maddn,rdocno from ws_estlabour where  addition>0    group by rdocno   ) aa on aa.rdocno=estm.doc_no"
				+" left join (select count(addition) addition,rdocno, max(addition) maddn from ws_estspare where  addition>0    group by rdocno   ) bb on bb.rdocno=estm.doc_no"
				+" where elab.confirmed=0 or espr.confirmed=0 and gip.processstatus<7) w where 1=1 " +sqltest+" ";
				*/
				String sqlqry="select * from (select  jc.voc_no jobno,estmdoc_no doc_no,estmvocno voc_no, estmdate date, estmgipno gateinpassdocno,gatevocno gateinpassvocno, estmbrhid brhid, "+
				" ac.refname clientname,convert(concat(coalesce(vbrand.brand_name,''),' ',coalesce(vmodel.vtype,''),' Regno: ',coalesce(gip.regno,''),"+
				" ' Plate code: ',coalesce(plate.code_name,''),' ', coalesce(yom.yom,''),' Others: ',coalesce(gip.vehother,'')), char(200)) "+
				" vehicledetails, if(estmchklumsum=0,coalesce(espr.sparetot,0),coalesce(espr.sparetot,0)+estmlumsumamount) sparetot,  elab.labtot "+
				" labouttot,0 discount, (if(estmchklumsum=0,coalesce(espr.sparetot,0),coalesce(espr.sparetot,0)+estmlumsumamount)+elab.labtot) "+
				" nettotal from (SELECT estm.DOC_NO ESTMDOC_NO,estm.VOC_NO estmvocno,ESTM.DATE ESTMDATE,estm.gipno estmgipno, estm.brhid estmbrhid,estm.chklumsum "+
				" estmchklumsum,estm.lumsumamount estmlumsumamount, GIP.CLDOCNO GIPCLDOCNO ,GIP.*,gip.voc_no gatevocno FROM ws_estm estm  left join ws_gateinpass gip "+
				" on(estm.gipno=gip.doc_no) WHERE gip.processstatus<7 "+sqltest+") GIP left join "+
				" my_acbook ac on(gipcldocno=ac.cldocno and ac.dtype='CRM') left join gl_vehbrand vbrand on(gip.brdid=vbrand.doc_no) "+
				" left join gl_vehplate plate on (gip.pltid=plate.code_no)  left join gl_vehmodel vmodel on (gip.modid=vmodel.doc_no) left join "+
				" gl_yom yom on gip.yom=yom.doc_no  left join ws_jobcard jc on ((jc.reftype='EST' AND jc.refno=estmdoc_no) OR (jc.reftype='GIP' AND "+
				" jc.refno=gip.doc_no)) left join (select rdocno, coalesce(sum(total),0) labtot,confirmed from ws_estlabour where confirmed=0 "+
				" group by rdocno) elab  on (estmdoc_no=elab.rdocno) left join (select rdocno,coalesce(sum(approvedvalue),0) sparetot,confirmed "+
				" from  ws_estspare  where confirmed=0  group by rdocno) espr on (estmdoc_no=espr.rdocno) where elab.confirmed=0 or espr.confirmed=0  ) w where 1=1  ";
				System.out.println(sqlqry);
				
				ResultSet resultSet = stmt.executeQuery(sqlqry);
				
				RESULTDATA=commonDAO.convertToJSON(resultSet);
				
				stmt.close();
				conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
    		conn.close();
    	}
			return RESULTDATA;
		}
		
		public JSONArray getEstimationExcelData(String cldocno,String fromdate,String todate,String id) throws SQLException{
			JSONArray RESULTDATA=new JSONArray();
			if(!id.equalsIgnoreCase("1")){
				return RESULTDATA;
			}
			Connection conn =null;
			
			try {
				conn=ClsConnection.getMyConnection();
				Statement stmt = conn.createStatement ();
				java.sql.Date sqlfromdate=null;
				java.sql.Date sqltodate=null;
				String sqltest="";
				if(!fromdate.equalsIgnoreCase("")){
					sqlfromdate=commonDAO.changeStringtoSqlDate(fromdate);
					sqltest+=" and ESTM.date>='"+sqlfromdate+"'";
				}
				if(!todate.equalsIgnoreCase("")){
					sqltodate=commonDAO.changeStringtoSqlDate(todate);
					sqltest+=" and ESTM.date<='"+sqltodate+"'";
				}
				
				if(!cldocno.equalsIgnoreCase("")){
					sqltest+=" and gip.cldocno="+cldocno;
				}

				String sqlqry="select * from (select  jc.voc_no jobno,estmdoc_no doc_no, estmdate date, estmgipno gateinpassdocno, estmbrhid brhid, "+
				" ac.refname clientname,convert(concat(coalesce(vbrand.brand_name,''),' ',coalesce(vmodel.vtype,''),' Regno: ',coalesce(gip.regno,''),"+
				" ' Plate code: ',coalesce(plate.code_name,''),' ', coalesce(yom.yom,''),' Others: ',coalesce(gip.vehother,'')), char(200)) "+
				" vehicledetails, if(estmchklumsum=0,coalesce(espr.sparetot,0),coalesce(espr.sparetot,0)+estmlumsumamount) sparetot,  elab.labtot "+
				" labouttot,0 discount, (if(estmchklumsum=0,coalesce(espr.sparetot,0),coalesce(espr.sparetot,0)+estmlumsumamount)+elab.labtot) "+
				" nettotal from (SELECT estm.DOC_NO ESTMDOC_NO,ESTM.DATE ESTMDATE,estm.gipno estmgipno, estm.brhid estmbrhid,estm.chklumsum "+
				" estmchklumsum,estm.lumsumamount estmlumsumamount, GIP.CLDOCNO GIPCLDOCNO ,GIP.* FROM ws_estm estm  left join ws_gateinpass gip "+
				" on(estm.gipno=gip.doc_no) WHERE gip.processstatus<7 "+sqltest+") GIP left join "+
				" my_acbook ac on(gipcldocno=ac.cldocno and ac.dtype='CRM') left join gl_vehbrand vbrand on(gip.brdid=vbrand.doc_no) "+
				" left join gl_vehplate plate on (gip.pltid=plate.code_no)  left join gl_vehmodel vmodel on (gip.modid=vmodel.doc_no) left join "+
				" gl_yom yom on gip.yom=yom.doc_no  left join ws_jobcard jc on ((jc.reftype='EST' AND jc.refno=estmdoc_no) OR (jc.reftype='GIP' AND "+
				" jc.refno=gip.doc_no)) left join (select rdocno, coalesce(sum(total),0) labtot,confirmed from ws_estlabour where confirmed=0 "+
				" group by rdocno) elab  on (estmdoc_no=elab.rdocno) left join (select rdocno,coalesce(sum(approvedvalue),0) sparetot,confirmed "+
				" from  ws_estspare  where confirmed=0  group by rdocno) espr on (estmdoc_no=espr.rdocno) where elab.confirmed=0 or espr.confirmed=0  ) w where 1=1  ";
				
				System.out.println(sqlqry);
				ResultSet resultSet = stmt.executeQuery(sqlqry);
				RESULTDATA=commonDAO.convertToEXCEL(resultSet);
				stmt.close();
				conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
    		conn.close();
    	}
			return RESULTDATA;
		}
		
		
		
		
		public JSONArray clientData(String clientname,String id) throws SQLException{
			
			JSONArray RESULTDATA=new JSONArray();

			if(!(id.equalsIgnoreCase("1"))) {
	        	return RESULTDATA;
	        }
			
			Connection conn =null;
	        
			try {
				conn=ClsConnection.getMyConnection();

				Statement stmt = conn.createStatement ();
            	
				String sqltest="";
				if(!clientname.equalsIgnoreCase("")){
					sqltest+=" and refname like '%"+clientname+"%'";
				}
				String sqlqry= "select refname clientname,cldocno from my_acbook where dtype='CRM' and status='3'"+sqltest;
				System.out.println("sqlqry ="+sqlqry);
				ResultSet resultSet = stmt.executeQuery(sqlqry);
				
				RESULTDATA=commonDAO.convertToJSON(resultSet);
				
				stmt.close();
				conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
    		finally{
    			conn.close();
    		}
		
		return RESULTDATA;
		}


}
