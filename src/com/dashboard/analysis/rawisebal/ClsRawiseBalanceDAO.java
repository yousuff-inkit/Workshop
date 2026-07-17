package com.dashboard.analysis.rawisebal;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsRawiseBalanceDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	public JSONArray getBalanceData(String id,String branch,String uptodate,String category,String client,String agmttype,String agmtno,String agmtstatus,String fromdate,
			String todate,String chkrecievable,String chkrefund,String chkcurramt,String rcvfromamt,String rcvtoamt,String refundfromamt,
			String refundtoamt,String currfromamt,String currtoamt) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return RESULTDATA;
		}
		String sqltest="";
		String sqltest2="";
		java.sql.Date sqluptodate=null;
		if(!uptodate.equalsIgnoreCase("")){
			sqluptodate=ClsCommon.changeStringtoSqlDate(uptodate);
		}
		if(sqluptodate!=null){
			sqltest+=" and jv.date<='"+sqluptodate+"'";
		}
		if(!category.equalsIgnoreCase("")){
			sqltest+=" and ac.catid in ("+category+")";
		}
		if(!client.equalsIgnoreCase("")){
			sqltest+=" and ac.cldocno in ("+client+")";
		}
		if(!agmttype.equalsIgnoreCase("")){
			sqltest+=" and jv.rtype='"+agmttype+"'";
		}
		if(!agmtno.equalsIgnoreCase("")){
			sqltest+=" and jv.rdocno in ("+agmtno+")";
		}
		if(!agmtstatus.equalsIgnoreCase("")){
			sqltest+=" and (rag.clstatus="+agmtstatus+" or lag.status="+agmtstatus+")";
		}
		if(chkrecievable.equalsIgnoreCase("1")){
			if(!rcvfromamt.equalsIgnoreCase("")){
				sqltest2+=" and (aa.invamt-aa.creditamt-aa.collectamt+aa.refundamt+aa.salikamt+aa.trafficamt)>="+rcvfromamt;
			}
			if(!rcvtoamt.equalsIgnoreCase("")){
				sqltest2+=" and (aa.invamt-aa.creditamt-aa.collectamt+aa.refundamt+aa.salikamt+aa.trafficamt)<="+rcvtoamt;
			}
		}
		if(chkrefund.equalsIgnoreCase("1")){
			if(!refundfromamt.equalsIgnoreCase("")){
				sqltest2+=" and aa.refundamt>="+refundfromamt;
			}
			if(!refundtoamt.equalsIgnoreCase("")){
				sqltest2+=" and aa.refundamt<="+refundtoamt;
			}
		}
		int check=0;
		if(chkcurramt.equalsIgnoreCase("0") || chkcurramt.equalsIgnoreCase("")){
			check=0;
		}
		else if(chkcurramt.equalsIgnoreCase("1") && (!currfromamt.equalsIgnoreCase("") || !currtoamt.equalsIgnoreCase(""))){
			if(!currfromamt.equalsIgnoreCase("") && !currtoamt.equalsIgnoreCase("")){
				check=1;
			}
			else if(!currfromamt.equalsIgnoreCase("") && currtoamt.equalsIgnoreCase("")){
				check=2;
			}
			else if(currfromamt.equalsIgnoreCase("") && !currtoamt.equalsIgnoreCase("")){
				check=3;
			}
		}
		else if(chkcurramt.equalsIgnoreCase("1") && (currfromamt.equalsIgnoreCase("") && currfromamt.equalsIgnoreCase(""))){
			check=0;
		}
		
		Connection conn = null;
		ArrayList<String> balarray=new ArrayList<>();
		  try {
		    conn=ClsConnection.getMyConnection();
		    Statement stmtBalance=conn.createStatement();
		    String sql = "";
			double amount=0.0;
		    sql = "select aa.agmtdocno,aa.invdate,aa.trafficamt,aa.salikamt,aa.dateout,aa.refname,aa.agmtno,aa.agmttype,aa.invamt,aa.collectamt,aa.creditamt,aa.refundamt,(aa.invamt-"+
		    "aa.creditamt-aa.collectamt+aa.refundamt+aa.salikamt+aa.trafficamt) balance from (select case when jv.rtype='RAG' then rag.doc_no when jv.rtype='LAG' then lag.doc_no end "+
		    " agmtdocno,case when jv.rtype='RAG' then rag.invdate when jv.rtype='LAG' then lag.invdate end invdate,round(sum(coalesce(trf.trafficamt,0)),2) trafficamt,"+
		    " round(sum(coalesce(sal.salamt,0)),2) salikamt,jv.rdocno,convert(case when jv.rtype='RAG' then "+
		    " rag.odate when jv.rtype='LAG' then lag.outdate else '' end,date) dateout,ac.cldocno,ac.refname,convert(case when jv.rtype='RAG' then rag.voc_no when "+
			" jv.rtype='LAG' then lag.voc_no else '' end,char(20)) agmtno, coalesce(jv.rtype,'') agmttype,round(convert(if(jv.dtype in ('INV','INT','INS'),sum(dramount),0.0),"+
		    " decimal(15,4)),2) invamt,round(convert(if(jv.dtype in ('CNO'),sum(dramount),0.0),decimal(15,4)),2) creditamt,jv.dtype,round(convert(if(jv.dtype in ('CRV','BRV'),"+
			" sum(dramount),0.0),decimal(15,4)),2) collectamt,round(convert(if(jv.dtype in ('CPV','BPV'),sum(dramount),0.0),decimal(15,4)),2) refundamt from my_jvtran jv "+
		    " left join gl_ragmt rag on (jv.rtype='RAG' and jv.rdocno=rag.doc_no)  left join gl_lagmt lag on (jv.rtype='LAG' and jv.rdocno=lag.doc_no)  left join my_acbook "+
			" ac on ((case when jv.rtype='RAG' then rag.cldocno when jv.rtype='LAG' then lag.cldocno end)=ac.cldocno and ac.dtype='CRM') left join (select sum(amount) "+
		    " salamt,ra_no,rtype from gl_salik where isallocated=1 and amount>0 and inv_no=0 group by rtype,ra_no) sal on (jv.rdocno=sal.ra_no and (case when sal.rtype in "+
			" ('RA','RD','RW','RF','RM') then jv.rtype='RAG' when sal.rtype in ('LA','LC') then jv.rtype='LAG' end)) left join (select sum(amount) trafficamt,ra_no,rtype "+
		    " from gl_traffic where isallocated=1 and amount>0 and inv_no=0 group by rtype,ra_no) trf on (jv.rdocno=trf.ra_no and (case when trf.rtype in "+
			" ('RA','RD','RW','RF','RM') then jv.rtype='RAG' when trf.rtype in ('LA','LC') then jv.rtype='LAG' end)) where jv.status=3 and jv.id=1 and jv.rdocno>0 and "+
		    " jv.rtype<>'' and case when jv.rtype='RAG' then rag.invdate is not null  and rag.clstatus=0 when jv.rtype='LAG' then lag.invdate is not null  and lag.clstatus=0 end "+sqltest+" group by "+
			" jv.rdocno,jv.rtype)aa where 1=1"+sqltest2;
			System.out.println(sql);
			ResultSet resultSet = stmtBalance.executeQuery(sql);
			double balanceamt=0.0;
			while(resultSet.next()){
				amount=getAgmtCurrAmount(resultSet.getString("agmtdocno"),resultSet.getString("agmttype"),conn,sqluptodate);
				if(check==0){
						
					balanceamt=resultSet.getDouble("invamt")-resultSet.getDouble("creditamt")-resultSet.getDouble("collectamt")+resultSet.getDouble("refundamt")+amount+resultSet.getDouble("salikamt")+resultSet.getDouble("trafficamt");
					balarray.add(resultSet.getDate("invdate")+"::"+resultSet.getDouble("trafficamt")+"::"+resultSet.getDouble("salikamt")+"::"+resultSet.getDate("dateout")+"::"+
					resultSet.getString("refname")+"::"+resultSet.getString("agmtno")+"::"+resultSet.getString("agmttype")+"::"+resultSet.getDouble("invamt")+"::"+
					resultSet.getDouble("collectamt")+"::"+resultSet.getDouble("creditamt")+"::"+resultSet.getDouble("refundamt")+"::"+balanceamt+"::"+amount);
				}
				else if(check==1){
					if(amount>=Double.parseDouble(currfromamt) && amount<=Double.parseDouble(currtoamt)){
						balanceamt=resultSet.getDouble("invamt")-resultSet.getDouble("creditamt")-resultSet.getDouble("collectamt")+resultSet.getDouble("refundamt")+amount+resultSet.getDouble("salikamt")+resultSet.getDouble("trafficamt");
						balarray.add(resultSet.getDate("invdate")+"::"+resultSet.getDouble("trafficamt")+"::"+resultSet.getDouble("salikamt")+"::"+resultSet.getDate("dateout")+"::"+
						resultSet.getString("refname")+"::"+resultSet.getString("agmtno")+"::"+resultSet.getString("agmttype")+"::"+resultSet.getDouble("invamt")+"::"+
						resultSet.getDouble("collectamt")+"::"+resultSet.getDouble("creditamt")+"::"+resultSet.getDouble("refundamt")+"::"+balanceamt+"::"+amount);
					}
				}
				else if(check==2){
					if(amount>=Double.parseDouble(currfromamt)){
						balanceamt=resultSet.getDouble("invamt")-resultSet.getDouble("creditamt")-resultSet.getDouble("collectamt")+resultSet.getDouble("refundamt")+amount+resultSet.getDouble("salikamt")+resultSet.getDouble("trafficamt");
						balarray.add(resultSet.getDate("invdate")+"::"+resultSet.getDouble("trafficamt")+"::"+resultSet.getDouble("salikamt")+"::"+resultSet.getDate("dateout")+"::"+
						resultSet.getString("refname")+"::"+resultSet.getString("agmtno")+"::"+resultSet.getString("agmttype")+"::"+resultSet.getDouble("invamt")+"::"+
						resultSet.getDouble("collectamt")+"::"+resultSet.getDouble("creditamt")+"::"+resultSet.getDouble("refundamt")+"::"+balanceamt+"::"+amount);
					}
				}
				else if(check==3){
					if(amount<=Double.parseDouble(currtoamt)){
						balanceamt=resultSet.getDouble("invamt")-resultSet.getDouble("creditamt")-resultSet.getDouble("collectamt")+resultSet.getDouble("refundamt")+amount+resultSet.getDouble("salikamt")+resultSet.getDouble("trafficamt");
						balarray.add(resultSet.getDate("invdate")+"::"+resultSet.getDouble("trafficamt")+"::"+resultSet.getDouble("salikamt")+"::"+resultSet.getDate("dateout")+"::"+
						resultSet.getString("refname")+"::"+resultSet.getString("agmtno")+"::"+resultSet.getString("agmttype")+"::"+resultSet.getDouble("invamt")+"::"+
						resultSet.getDouble("collectamt")+"::"+resultSet.getDouble("creditamt")+"::"+resultSet.getDouble("refundamt")+"::"+balanceamt+"::"+amount);
					}
				}

			}
			RESULTDATA=convertArrayToJSON(balarray);
			
			stmtBalance.close();
		
		  }
		  catch(Exception e){
			  e.printStackTrace();
		  }
		  finally{
			  conn.close();
		  }
		  return RESULTDATA;
		}
	public  JSONArray convertArrayToJSON(ArrayList<String> arrayList) throws Exception {
		JSONArray jsonArray = new JSONArray();
		
		for (int i = 0; i < arrayList.size(); i++) {
			
			JSONObject obj = new JSONObject();
			
			String[] balarray=arrayList.get(i).split("::");
			
			obj.put("invdate",balarray[0]);
			obj.put("trafficamt",balarray[1]);
			obj.put("salikamt",balarray[2]);
			obj.put("dateout",balarray[3]);
			obj.put("refname",balarray[4]);
			obj.put("agmtno",balarray[5]);
			obj.put("agmttype",balarray[6]);
			obj.put("invamt",balarray[7]);
			obj.put("collectamt",balarray[8]);
			obj.put("creditamt",balarray[9]);
			obj.put("refundamt",balarray[10]);
			obj.put("balance",balarray[11]);
			obj.put("curramt",balarray[12]);
			
			
			jsonArray.add(obj);
		}
		return jsonArray;
		}
	public double getAgmtCurrAmount(String agmtno, String agmttype,Connection conn,java.sql.Date uptodate) {
		// TODO Auto-generated method stub
		double amount=0.0;
//		System.out.println(uptodate);
		try{
			Statement stmt=conn.createStatement();
			String strdetails="",invtype="",clstatus="",advchk="",strmonthcal="",strtariftype="",rentaltype="",strtarifsum="";
			int monthcal=0,datediff=0;
			java.sql.Date invdate=null,invtodate=null;
			
			
			if(agmttype.equalsIgnoreCase("RAG")){
				strdetails="select invtype,clstatus,invdate,invtodate,advchk from gl_ragmt where status=3 and doc_no="+agmtno;
			}
			else if(agmttype.equalsIgnoreCase("LAG")){
				strdetails="select inv_type invtype,clstatus,invdate,invtodate,adv_chk advchk from gl_lagmt where status=3 and doc_no="+agmtno;
			}
//			System.out.println(strtariftype);
//			System.out.println(strdetails);
			ResultSet rsdetails=stmt.executeQuery(strdetails);
			while(rsdetails.next()){
				invtype=rsdetails.getString("invtype");
				clstatus=rsdetails.getString("clstatus");
				advchk=rsdetails.getString("advchk");
				invdate=rsdetails.getDate("invdate");
				invtodate=rsdetails.getDate("invtodate");
			}
			if(agmttype.equalsIgnoreCase("RAG")){
				strtariftype="select datediff('"+uptodate+"','"+invdate+"') datediff,(select rentaltype from gl_rtarif where rstatus=5 and rdocno="+agmtno+") rentaltype";
			}
			else if(agmttype.equalsIgnoreCase("LAG")){
				strtariftype="select datediff('"+uptodate+"','"+invdate+"') datediff,'Monthly' rentaltype";
			}
			rsdetails=stmt.executeQuery(strtariftype);
			while(rsdetails.next()){
				rentaltype=rsdetails.getString("rentaltype");
				datediff=rsdetails.getInt("datediff");
			}
//			System.out.println(datediff);
			if(rentaltype.equalsIgnoreCase("daily")){
				monthcal=1;
			}
			if(rentaltype.equalsIgnoreCase("weekly")){
				monthcal=7;
			}
			if(rentaltype.equalsIgnoreCase("fortnightly")){
				monthcal=14;
			}
			if(rentaltype.equalsIgnoreCase("monthly")){
				if(invtype.equalsIgnoreCase("1")){
					if(agmttype.equalsIgnoreCase("RAG")){
						strmonthcal="select if(method=1,DAY(LAST_DAY('"+uptodate+"')),value) monthcal from gl_config where field_nme='monthlycal'";
					}
					else if(agmttype.equalsIgnoreCase("LAG")){
						strmonthcal="select if(method=1,DAY(LAST_DAY('"+uptodate+"')),value) monthcal from gl_config where field_nme='lesmonthlycal'";
					}
				}
				else{
					if(agmttype.equalsIgnoreCase("RAG")){
						strmonthcal="select if(method=1,datediff('"+uptodate+"','"+invdate+"'),value) monthcal from gl_config where field_nme='monthlycal'";
					}
					else if(agmttype.equalsIgnoreCase("LAG")){
						strmonthcal="select if(method=1,datediff('"+uptodate+"','"+invdate+"'),value) monthcal from gl_config where field_nme='lesmonthlycal'";
					}
				}
				rsdetails=stmt.executeQuery(strmonthcal);
				while (rsdetails.next()) {
					monthcal=rsdetails.getInt("monthcal");
				}	
			}
			
			if(agmttype.equalsIgnoreCase("RAG")){
				strtarifsum="select round(("+datediff+"/"+monthcal+")*rate,0) ratesum,round(("+datediff+"/"+monthcal+")*cdw,0) cdwsum,"+
			" round(("+datediff+"/"+monthcal+")*pai,0) paisum,round(("+datediff+"/"+monthcal+")*cdw1,0) cdw1sum,"+
			" round(("+datediff+"/"+monthcal+")*pai1,0) pai1sum,round(("+datediff+"/"+monthcal+")*gps,0) gpssum,"+
			" round(("+datediff+"/"+monthcal+")*babyseater,0) babyseatersum,round(("+datediff+"/"+monthcal+")*cooler,0)"+
			" coolersum from gl_rtarif where rdocno="+agmtno+" and rstatus=7";
			}
			else if(agmttype.equalsIgnoreCase("LAG")){
				strtarifsum="select round(("+datediff+"/"+monthcal+")*rate,0) ratesum,round(("+datediff+"/"+monthcal+")*cdw,0) cdwsum,"+
			" round(("+datediff+"/"+monthcal+")*pai,0) paisum,round(("+datediff+"/"+monthcal+")*cdw1,0) cdw1sum,"+
			" round(("+datediff+"/"+monthcal+")*pai1,0) pai1sum,round(("+datediff+"/"+monthcal+")*gps,0) gpssum,"+
			" round(("+datediff+"/"+monthcal+")*babyseater,0) babyseatersum,round(("+datediff+"/"+monthcal+")*cooler,0)"+
			" coolersum from gl_ltarif where rdocno="+agmtno+" and rstatus=0";
			}
//			System.out.println(strtarifsum);
			rsdetails=stmt.executeQuery(strtarifsum);
			while(rsdetails.next()){
				amount=rsdetails.getDouble("ratesum")+rsdetails.getDouble("cdwsum")+rsdetails.getDouble("paisum")+rsdetails.getDouble("cdw1sum")+
						rsdetails.getDouble("pai1sum")+rsdetails.getDouble("gpssum")+rsdetails.getDouble("babyseatersum")+rsdetails.getDouble("coolersum");
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return amount;
	}
	public JSONArray getAgmtno(String client,String mobile,String docno,String fleetno,String regno,String mrano,String allbranch,String branch,
			String agmttype,String agmtstatus,String agmtfromdate,String agmttodate,String id) throws SQLException {

   	 JSONArray RESULTDATA=new JSONArray();
   	 if(!id.equalsIgnoreCase("1")){
   		 return RESULTDATA;
   	 }
   	 if(agmttype.equalsIgnoreCase("")){
   		 return RESULTDATA;
   	 }
   	 java.sql.Date sqlfromdate=null;
   	 java.sql.Date sqltodate=null;
   	 String sqltest="";
   	 Connection conn=null;
   	 String strsql="";
   	 if(!agmtfromdate.equalsIgnoreCase("")){
   		 sqlfromdate=ClsCommon.changeStringtoSqlDate(agmtfromdate);
   	 }
   	 if(!agmttodate.equalsIgnoreCase("")){
   		 sqltodate=ClsCommon.changeStringtoSqlDate(agmttodate);
   	 }
   	 if(!client.equalsIgnoreCase("")){
   		 sqltest+=" and a.refname like '%"+client+"%'";
   	 }
   	 if(!mobile.equalsIgnoreCase("")){
   		 sqltest+=" and a.per_mob like '%"+mobile+"%'";
   	 }
   	 if(!docno.equalsIgnoreCase("")){
   		 sqltest+=" and r.voc_no like '%"+docno+"%'";
   	 }
   	 if(!fleetno.equalsIgnoreCase("")){
   		 if(agmttype.equalsIgnoreCase("RAG")){
   			 sqltest+=" and r.fleet_no like '%"+fleetno+"%'";
   		 }
   		 else if(agmttype.equalsIgnoreCase("LAG")){
   			 sqltest+=" and (r.perfleet like '%"+fleetno+"%' or r.tmpfleet like '%"+fleetno+"%')";
   		 }
   	 }
   	 if(!regno.equalsIgnoreCase("")){
   		 sqltest+=" and v.reg_no like '%"+regno+"%'";
   	 }
   	 if(!mrano.equalsIgnoreCase("")){
   		 if(agmttype.equalsIgnoreCase("RAG")){
   			 sqltest+=" and r.mrano like '%"+mrano+"%'";
   		 }
   		 else if(agmttype.equalsIgnoreCase("LAG")){
   			 sqltest+=" and r.manualra like '%"+mrano+"%'";
   		 }
   	 }
   	 if(!agmtstatus.equalsIgnoreCase("")){
   		 sqltest+=" and r.status=3";
   	 }
   	 if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a") && allbranch.equalsIgnoreCase("0")){
   		 sqltest+=" and r.brhid="+branch;
   	 }
   	 if(sqlfromdate!=null){
   		 sqltest+=" and r.date>="+sqlfromdate;
   	 }
   	 if(sqltodate!=null){
   		 sqltest+=" and r.date<="+sqltodate;
   	 }
   	 try {
   		 conn = ClsConnection.getMyConnection();
   		 if(agmttype.equalsIgnoreCase("RAG")){
   			strsql="select r.doc_no,r.voc_no,r.fleet_no,r.mrano mrnumber,v.reg_no,a.RefName,coalesce(a.per_mob,'') per_mob from gl_ragmt r left join"+
   			" gl_vehmaster v on v.fleet_no=r.fleet_no left join my_acbook a on a.cldocno= r.cldocno and a.dtype='CRM' left join my_salm m on"+
   			" a.sal_id=m.doc_no left join gl_rtarif t on t.rdocno=r.doc_no where r.status=3 "+sqltest+" group by doc_no";
   		 }
   		 else if(agmttype.equalsIgnoreCase("LAG")){
   			strsql="select r.doc_no,r.voc_no,if(r.perfleet=0,r.tmpfleet,r.perfleet) fleet_no,r.manualra mrnumber,v.reg_no,a.RefName,coalesce(a.per_mob,'')"+
   			" per_mob from gl_lagmt r left join gl_vehmaster v on (if(r.perfleet=0,r.tmpfleet=v.fleet_no,r.perfleet=v.fleet_no))"+
   			" left join my_acbook a on (a.cldocno=r.cldocno and a.dtype='CRM') left join my_salm m on a.sal_id=m.doc_no left join gl_ltarif t on t.rdocno=r.doc_no"+
   			" where r.status=3 "+sqltest+" group by r.doc_no";
   		 }
   		 Statement stmt=conn.createStatement();
   		 ResultSet resultSet = stmt.executeQuery (strsql);
   		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
   		 stmt.close(); 
		}
		catch(Exception e){
			e.printStackTrace();
		}
   	 	finally{
   	 		conn.close();
   	 	}
       return RESULTDATA;
   }
   


}
