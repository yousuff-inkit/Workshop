package com.dashboard.workshop.jobexecution;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsJobExecutionDAO {
	
	ClsCommon objcommon=new ClsCommon();
	ClsConnection objconn=new ClsConnection();
	public JSONArray getJobData(String date,String id,String jcno)throws SQLException
	{
		JSONArray jcdata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return jcdata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			java.sql.Date uptodate=null,sqltodate=null;
			String sqltest="";
			if(!date.equalsIgnoreCase("") && date!=null){
				uptodate=objcommon.changeStringtoSqlDate(date);
			}
			if(!jcno.equalsIgnoreCase("")){
				sqltest+=" and job.voc_no="+jcno;
			}
			Statement stmt=conn.createStatement();
			String strsql="select gate.regno,gate.pltid plate,brd.brand_name brand,model.vtype model,datediff(curdate(),job.date) as daysjc,gate.username user,ac.cldocno,ac.refname client,job.voc_no jobno,est.doc_no,rtype.name repairtype "
						+" from ws_jobcard job left join ws_estm est on (job.reftype='EST' and job.refno=est.doc_no)"
						+" left join ws_gateinpass gate on (job.refno=gate.doc_no and reftype='gip') or (est.gipno=gate.doc_no) "
						+" left join my_acbook ac on(gate.cldocno=ac.cldocno and ac.dtype='CRM')"
						+" left join gl_vehbrand brd on gate.brdid=brd.doc_no"
						+" left join gl_vehmodel model on gate.modid=model.doc_no"
						+" left join gl_vehplate plate on gate.pltid=plate.doc_no"
						+" left join ws_gartype rtype on gate.repairtype=rtype.row_no"
						+" left join gl_yom yom on gate.yom=yom.doc_no where job.complete=0 and gate.date<='"+uptodate+"'"+sqltest;
			 System.out.println("jobcard-----------:"+strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			jcdata=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return jcdata;
	}
	
	public JSONArray getJobExcelData(String date,String id,String jcno)throws SQLException
	{
		JSONArray jobdata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return jobdata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			java.sql.Date uptodate=null,sqltodate=null;
			String sqltest="";
			if(!date.equalsIgnoreCase("") && date!=null){
				uptodate=objcommon.changeStringtoSqlDate(date);
			}
			if(!jcno.equalsIgnoreCase("")){
				sqltest+=" and job.voc_no="+jcno;
			}
			Statement stmt=conn.createStatement();
			String strsql="select job.voc_no 'Job No',ac.refname 'Client',gate.regno 'Reg No',gate.pltid 'Plate',brd.brand_name 'Brand',model.vtype 'Model',datediff(curdate(),job.date) as 'Days From JC',gate.username 'User'"
					+" from ws_jobcard job left join ws_estm est on (job.reftype='EST' and job.refno=est.doc_no)"
					+" left join ws_gateinpass gate on (if(job.reftype='GIP',job.refno=gate.doc_no,est.gipno=gate.doc_no))"
					+" left join my_acbook ac on(gate.cldocno=ac.cldocno and ac.dtype='CRM')"
					+" left join gl_vehbrand brd on gate.brdid=brd.doc_no"
					+" left join gl_vehmodel model on gate.modid=model.doc_no"
					+" left join gl_vehplate plate on gate.pltid=plate.doc_no"
					+" left join ws_gartype rtype on gate.repairtype=rtype.row_no"
					+" left join gl_yom yom on gate.yom=yom.doc_no where job.complete=0 and gate.date<='"+uptodate+"'"+sqltest;
		 System.out.println("jobcardExcel-----------:"+strsql);
			 
			ResultSet rs=stmt.executeQuery(strsql);
			jobdata=objcommon.convertToEXCEL(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return jobdata;
	}
	
	public JSONArray getServiceData(String docno,String id)throws SQLException
	{
		JSONArray jcdata=new JSONArray();
		if(!(id.equalsIgnoreCase("1"))){
			return jcdata;
		}
		
		
		
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select lab.remarks,m.desc1 description,t.type servicetype,lab.rowno,lab.technicianid,lab.bayid,tech.name technician,tech.doc_no techno,bay.name bay,bay.doc_no bayno,lab.complete completed,lab.execdetails"
					+" from ws_estlabour lab left join ws_jobmaster m on lab.jobid=m.doc_no"
					+" left join ws_jobtype t on m.jobid=t.doc_no"
					+" left join ws_technician tech on lab.technicianid=tech.doc_no"
					+" left join ws_bay bay on lab.bayid=bay.doc_no where lab.confirmed=1 and lab.approved=1 and lab.rdocno="+docno;
			//System.out.println("servce-----------------------------------"+strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			jcdata=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return jcdata;
	}
	
	public JSONArray getSparePartData(String docno,String id)throws SQLException
	{
		JSONArray jcdata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return jcdata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			int jobdocno=0;
			String strgetjobcard="select doc_no from ws_jobcard where reftype='EST' and refno="+docno+" and status=3";
			ResultSet rsgetjobcard=stmt.executeQuery(strgetjobcard);
			while(rsgetjobcard.next()){
				jobdocno=rsgetjobcard.getInt("doc_no");
			}
			String strsql="select m.productname partname,m.part_no partno,m.psrno,m.munit unitdocno,p.mspecno specid,spr.description,spr.remarks , spr.qty , jc.qty requested,(spr.qty - jc.qty) balance,coalesce(ord.qty,0) ordqty,coalesce(piv.qty,0) pivqty"
			+" from ws_estm em inner JOIN  (select description, remarks,rdocno ,psrno, sum(qty) qty from ws_estspare group by rdocno,psrno ) spr on spr.rdocno=em.doc_no inner JOIN ws_jobcard jb on (jb.refno=em.gipno and jb.reftype='gip') or (jb.refno=em.doc_no and jb.reftype='est') left join"
			+" (SELECT COSTDOCNO,PSRNO,SUM(QTY) qty FROM MY_MREQM M LEFT JOIN MY_MREQD D ON M.DOC_NO=D.RDOCNO WHERE M.STATUS=3 and costtype=9 and costdocno="+jobdocno+" GROUP BY COSTDOCNO,PSRNO) jc on jc.costdocno=jb.doc_no and jc.psrno=spr.psrno left join my_main m on spr.psrno=m.psrno left join my_prodattrib p on m.psrno=p.mpsrno"
			+" left join (select sum(qty-out_qty) qty,psrno,costtype,costcode from my_ordm m inner join my_ordd d on m.tr_no=d.tr_no where m.status<=3 and costcode!=0 and qty-out_qty!=0 and costcode="+jobdocno+" group by psrno,costtype,costcode) ord ON ord.costtype=9 and ord.costcode = jb.doc_no and ord.psrno=spr.psrno"
			+" left join (select sum(qty-out_qty) qty,psrno,costtype,costcode from my_srvm m inner join my_srvd d on m.tr_no=d.tr_no where m.status<=3 and costcode!=0 and qty-out_qty!=0 and costcode="+jobdocno+" group by psrno,costtype,costcode) piv ON piv.costtype=9 and piv.costcode = jb.doc_no and piv.psrno=spr.psrno"
			+" where spr.psrno!=0 and em.doc_no="+docno;
			/*m.productname partname,m.part_no partno,*/
			System.out.println(strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			jcdata=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return jcdata;
	}
	
public JSONArray technicianData(String techname,String id) throws SQLException{
		
		JSONArray RESULTDATA=new JSONArray();

		/*if(!(id.equalsIgnoreCase("1"))) {
        	return RESULTDATA;
        }*/
		Connection conn =null;
        
		try {
			conn=objconn.getMyConnection();

			Statement stmt = conn.createStatement ();
        	
			String sqltest="";
			if(!techname.equalsIgnoreCase("")){
				sqltest+=" and name like '%"+techname+"%'";
			}
			String sqlqry= "select name,doc_no from ws_technician where status<>7 "+sqltest;
			System.out.println("sqlqry ="+sqlqry);
			ResultSet resultSet = stmt.executeQuery(sqlqry);
			
			RESULTDATA=objcommon.convertToJSON(resultSet);
			
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

	
	public JSONArray bayData(String bayname,String id) throws SQLException{
		
		JSONArray RESULTDATA=new JSONArray();
	
		/*if(!(id.equalsIgnoreCase("1"))) {
	    	return RESULTDATA;
	    }*/
		Connection conn =null;
	    
		try {
			conn=objconn.getMyConnection();
	
			Statement stmt = conn.createStatement ();
	    	
			String sqltest="";
			if(!bayname.equalsIgnoreCase("")){
				sqltest+=" and name like '%"+bayname+"%'";
			}
			String sqlqry= "select name,code,doc_no from ws_bay where status<>7 "+sqltest;
			System.out.println("sqlqry ="+sqlqry);
			ResultSet resultSet = stmt.executeQuery(sqlqry);
			
			RESULTDATA=objcommon.convertToJSON(resultSet);
			
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

	public JSONArray jobCardData(String date,String id,String reftype,String clname) throws SQLException{
		
		JSONArray RESULTDATA=new JSONArray();

		if(!(id.equalsIgnoreCase("1"))) {
	    	return RESULTDATA;
	    }
		Connection conn =null;
	    
		try {
			conn=objconn.getMyConnection();

			Statement stmt = conn.createStatement ();
	    	
			String sqltest="";
			java.sql.Date sqldate=null;
			/*if(!docno.equalsIgnoreCase("")){
				sqltest+=" and docno like '%"+docno+"%'";
			}*/
			if(!date.equalsIgnoreCase("")){
				sqldate=objcommon.changeStringtoSqlDate(date);
				sqltest+=" and date='"+sqldate+"'";
			}
			if(!reftype.equalsIgnoreCase("")){
				sqltest+=" and job.reftype like '%"+reftype+"%'";
			}
			if(!clname.equalsIgnoreCase("")){
				sqltest+=" and ac.refname like '%"+clname+"%'";
			}
			String sqlqry= "select job.date,ac.refname,job.reftype,job.doc_no,job.voc_no from ws_jobcard job left join ws_estm est on (job.reftype='EST' and job.refno=est.doc_no)"
						+" left join ws_gateinpass gate on (if(job.reftype='GIP',job.refno=gate.doc_no,est.gipno=gate.doc_no))"
						+" left join my_acbook ac on(gate.cldocno=ac.cldocno and ac.dtype='CRM') where 1=1"+sqltest;
			System.out.println("sqlqry ="+sqlqry);
			ResultSet resultSet = stmt.executeQuery(sqlqry);
			
			RESULTDATA=objcommon.convertToJSON(resultSet);
			
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
	
public JSONArray partNoData(String partname,String partno,String id) throws SQLException{
	
	JSONArray RESULTDATA=new JSONArray();

	/*if(!(id.equalsIgnoreCase("1"))) {
    	return RESULTDATA;
    }*/
	Connection conn =null;
    
	try {
		conn=objconn.getMyConnection();

		Statement stmt = conn.createStatement ();
    	
		String sqltest="";
		if(!partname.equalsIgnoreCase("")){
			sqltest+=" and name like '%"+partname+"%'";
		}
		if(!partno.equalsIgnoreCase("")){
			sqltest+=" and name like '%"+partno+"%'";
		}
		
		String sqlqry= "select part_no,productname from my_main where 1=1"+sqltest;
		System.out.println("sqlqry ="+sqlqry);
		ResultSet resultSet = stmt.executeQuery(sqlqry);
		
		RESULTDATA=objcommon.convertToJSON(resultSet);
		
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

public int updateService(ArrayList<String> descarray,String docno)throws SQLException{
		
		Connection conn=null;
		int x=0;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			
			 
			for(int i=0;i< descarray.size();i++){
	
				String[] prod=((String) descarray.get(i)).split("::");
					
					String complete=(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?"":prod[0].trim())+"";
					String execdetails=(prod[1].equalsIgnoreCase("undefined") || prod[1].equalsIgnoreCase("") || prod[1].trim().equalsIgnoreCase("NaN")|| prod[1].isEmpty()?"":prod[1].trim())+"";
					String rowno=(prod[2].equalsIgnoreCase("undefined") || prod[2].equalsIgnoreCase("") || prod[2].trim().equalsIgnoreCase("NaN")|| prod[2].isEmpty()?0:prod[2].trim())+"";
					String bayno=(prod[3].equalsIgnoreCase("undefined") || prod[3].equalsIgnoreCase("") || prod[3].trim().equalsIgnoreCase("NaN")|| prod[3].isEmpty()?0:prod[3].trim())+"";
					String techno=(prod[4].equalsIgnoreCase("undefined") || prod[4].equalsIgnoreCase("") || prod[4].trim().equalsIgnoreCase("NaN")|| prod[4].isEmpty()?0:prod[4].trim())+"";
					 
		 
						String sql="update ws_estlabour set technicianid='"+techno+"',bayid='"+bayno+"',complete='"+complete+"',execdetails='"+execdetails+"' where rowno="+rowno;
						  x=stmt.executeUpdate(sql);
						  
						}
			
			
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		return x;
}
}


