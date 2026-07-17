package com.operations.marketing.leasecalculatoralfahim;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.itextpdf.text.pdf.PdfStructTreeController.returnType;
import com.operations.marketing.leasecalculator.ClsLeaseCalculatorBean;

import java.sql.*;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public class ClsLeaseCalcAlFahimDAO {

	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	
	  public JSONArray getReqSearchData(String reqbranch,String reqdocno,String reqname,String reqmob,String reqdate,String reqtype,String id) throws SQLException {

	        JSONArray RESULTDATA=new JSONArray();
	        if(!id.equalsIgnoreCase("1")){
	        	return RESULTDATA;
	        }
	        Connection conn = null;
	        String sqltest="";
	        java.sql.Date sqldate=null;
	        
			try {
					conn = objconn.getMyConnection();
					Statement stmt=conn.createStatement();
					if(!reqdate.equalsIgnoreCase("")){
						sqldate=objcommon.changeStringtoSqlDate(reqdate);
					}
					if(!reqbranch.equalsIgnoreCase("")){
						sqltest+=" and req.brhid="+reqbranch;
					}
					if(!reqdocno.equalsIgnoreCase("")){
						sqltest+=" and req.voc_no like "+reqdocno;
					}
					if(!reqname.equalsIgnoreCase("")){
						sqltest+=" and if(req.reqtype=1,ac.refname like '%"+reqname+"%',req.name like '%"+reqname+"%')";
					}
					if(!reqmob.equalsIgnoreCase("")){
						sqltest+=" and if(req.reqtype=1,ac.com_mob like '%"+reqmob+"%',req.mob like '%"+reqmob+"%')";
					}
					if(sqldate!=null){
						sqltest+=" and req.date='"+sqldate+"'";
					}
					if(!reqtype.equalsIgnoreCase("")){
						sqltest+=" and req.reqtype="+reqtype;
					}
					String strsql="select req.voc_no,req.doc_no,req.date,req.remarks,if(req.reqtype=1,ac.cldocno,req.cldocno) cldocno,if(req.reqtype=1,ac.refname,req.name) "+
					" name,if(req.reqtype=1,ac.address,req.com_add1) address,if(req.reqtype=1,ac.com_mob,req.mob) mobile,if(req.reqtype=1,ac.mail1,req.email)"+
					" email,req.reqtype from gl_lprm req left join my_acbook ac on (req.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_leasecalcm m on "+
					" (req.doc_no=m.reqdoc) where req.status=3  and m.reqdoc is null"+sqltest;
					System.out.println(strsql);
					ResultSet resultSet = stmt.executeQuery(strsql);
					RESULTDATA=objcommon.convertToJSON(resultSet);
					
					stmt.close();
			}catch(Exception e){
				e.printStackTrace();
			}finally{
				conn.close();
			}
	        return RESULTDATA;
	    }
	    
	
    public JSONArray getReqData(String reqdocno,String id,String docno) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        if(reqdocno.equalsIgnoreCase("0") || reqdocno.equalsIgnoreCase("")){
        	return RESULTDATA;
        }
        Connection conn = null;
		try {
				conn = objconn.getMyConnection();
				Statement stmt=conn.createStatement();
				String strsql="";
				if(id.equalsIgnoreCase("1")){
					strsql="select req.vsb,req.yomid,yom.yom,req.quantity qty,req.reqsrno,coalesce(req.confirmstatus,0) confirmstatus,req.totalvalue,vnd.name dealer,auth.authid,auth.authname authority,req.dealerid hiddealer,req.prchcost purchcost,req.downpytper,req.interestper,req.profitper,req.creditcardper,"+
					" req.authid hidauthority,req.overheadper,req.others,req.discount,req.savestatus,req.srno,req.rdocno,req.leasereqdocno,req.leasefromdate,"+
					" req.brdid,req.modid modelid,req.spec specification,req.clrid,req.leasemonths,req.kmpermonth,req.grpid,0 rowcolor,grp.gname,brd.brand_name "+
					" brand,model.vtype model,clr.color,'Quotation' quotbtn from gl_leasecalcreq req left join gl_vehbrand brd on req.brdid=brd.doc_no left join gl_vehmodel model on "+
					" req.modid=model.doc_no left join my_color clr on req.clrid=clr.doc_no left join gl_lcgm lcg on (req.brdid=req.brdid and req.modid=lcg.modid) left join "+
					" gl_vehgroup grp on (lcg.grpid=grp.doc_no) left join my_vendorm vnd on (req.dealerid=vnd.doc_no) left join gl_vehauth auth on "+
					" (req.authid=auth.doc_no) left join gl_yom yom on req.yomid=yom.doc_no where req.status=3 and req.rdocno="+docno+" and req.leasereqdocno="+reqdocno;
				}
				else{
					strsql="select det.yomid,det.vsb,yom.yom,det.qty,0 confirmstatus,0 savestatus,0 rowcolor,det.sr_no reqsrno,brd.doc_no brdid,model.doc_no modelid,clr.doc_no clrid,lcg.doc_no grpid,grp.gname,det.frmdate leasefromdate,det.spec specification,brd.brand_name brand,model.vtype model,det.spec,clr.color,det.ldur leasemonths,det.kmusage"+
							" kmpermonth,'Quotation' quotbtn from gl_lprd det left join gl_vehbrand brd on det.brdid=brd.doc_no left join gl_vehmodel model on det.modid=model.doc_no"+
							" left join my_color clr on det.clrid=clr.doc_no left join gl_lcgm lcg on (det.brdid=lcg.brdid and det.modid=lcg.modid) "+
							" left join gl_vehgroup grp on (lcg.grpid=grp.doc_no) left join gl_yom yom on det.yomid=yom.doc_no where det.rdocno="+reqdocno+" and det.dropstatus<>1";
					
				}
				System.out.println("dcgfvvvvg====="+strsql);
				ResultSet resultSet = stmt.executeQuery(strsql);
				RESULTDATA=objcommon.convertToJSON(resultSet);
				
				stmt.close();
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }

    
	public JSONArray getTypeoneData()throws SQLException{
		Connection conn=null;
		JSONArray typeonedata=new JSONArray();
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select srno,name description from gl_lcalculatoralf where status=3 and type=1 order by odno";
			ResultSet rs=stmt.executeQuery(strsql);
			typeonedata=objcommon.convertToJSON(rs);
			stmt.close();
		
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return typeonedata;
	}
	
	public JSONArray processTypetwoGrid(String typeonearray,String id,String kmuse,String reqdocno,String reqsrno,String calcdocno) throws SQLException{
		JSONArray typetwodata=new JSONArray();
		Connection conn=null;
		if(!id.equalsIgnoreCase("2")){
			return typetwodata;
		}
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			ArrayList<String> typemainarray=new ArrayList<String>();
			String temparray[]=typeonearray.split(",");
			for(int i=0;i<temparray.length;i++){
				typemainarray.add(temparray[i]);
			}
			double landedcost=0.0,supportcost=0.0,marginpercent=0.0,daimlersupportusd=0.0,usdconvertrate=0.0,financepercent=0.0,leaseprofit=0.0,advancepyt=0.0,
					installments=0.0,residalvalue=0.0,maintcost=0.0,insurcost=0.0,tyrecost=0.0,tracker=0.0,regcost=0.0,daimlersupport=0.0,trackervalue=0.0;
			for(int i=0;i<typemainarray.size();i++){
				String typetwo[]=typemainarray.get(i).split("::");
				if(typetwo[0].equalsIgnoreCase("1")){
					landedcost=Double.parseDouble(typetwo[1]);
				}
				else if(typetwo[0].equalsIgnoreCase("2")){
					supportcost=Double.parseDouble(typetwo[1]);
				}
				else if(typetwo[0].equalsIgnoreCase("3")){
					marginpercent=Double.parseDouble(typetwo[1]);
				}
				else if(typetwo[0].equalsIgnoreCase("4")){
					daimlersupportusd=Double.parseDouble(typetwo[1]);
				}
				else if(typetwo[0].equalsIgnoreCase("5")){
					financepercent=Double.parseDouble(typetwo[1]);
				}
				else if(typetwo[0].equalsIgnoreCase("6")){
					leaseprofit=Double.parseDouble(typetwo[1]);
				}
				else if(typetwo[0].equalsIgnoreCase("7")){
					advancepyt=Double.parseDouble(typetwo[1]);
				}
				else if(typetwo[0].equalsIgnoreCase("8")){
					installments=Double.parseDouble(typetwo[1]);
				}
				else if(typetwo[0].equalsIgnoreCase("20")){
					residalvalue=Double.parseDouble(typetwo[1]);
				}
				else if(typetwo[0].equalsIgnoreCase("31")){
					usdconvertrate=Double.parseDouble(typetwo[1]);
					daimlersupport=daimlersupportusd*usdconvertrate;
				}
				else if(typetwo[0].equalsIgnoreCase("34")){
					trackervalue=Double.parseDouble(typetwo[1]);
				}
			}
			System.out.println("Checking Support Cost: "+supportcost);
			int  groupid=0;
			String strgroup="select grpid from gl_leasecalcreq where status=3 and leasereqdocno="+reqdocno+" and reqsrno="+reqsrno;
			System.out.println(strgroup);
			ResultSet rsgroup=stmt.executeQuery(strgroup);
			while(rsgroup.next()){
				groupid=rsgroup.getInt("grpid");
			}
			double leasemonths=0.0;
			String strleasemonths="select leasemonths from gl_leasecalcreq where leasereqdocno="+reqdocno+" and reqsrno="+reqsrno;
			ResultSet rsleasemonths=stmt.executeQuery(strleasemonths);
			while(rsleasemonths.next()){
				leasemonths=rsleasemonths.getDouble("leasemonths");
			}
			ArrayList<String> typetwodesc=new ArrayList<>();
			ResultSet rstypetwo=stmt.executeQuery("select srno from gl_lcalculatoralf where status=3 and type=2 order by odno");
			while(rstypetwo.next()){
				typetwodesc.add(rstypetwo.getString("srno"));
			}
			double netcost=0.0,insurpercent=0.0,margincost=0.0,vehiclecost=0.0,financecost=0.0,totalcost=0.0,residentialcost=0.0,totalleasecost=0.0,balance=0.0,leasepermonth=0.0,replacecost=0.0;
			String strgetmetrics="select round(insurpercent,2) insurpercent,round(tracker,2) tracker,round(regcost,2) regcost,round(srvccost,2) "+
					" srvccost,round(replacecost,2) replacecost,round(tyrecost,2) tyrecost from gl_srvcmetricsm m left join gl_srvcmetricsd d on"+
					" (m.doc_no=d.rdocno) left join gl_lcgm costgrp on (m.tarifgroup=costgrp.grpid) where srvckm>="+kmuse+" and m.status=3 and d.status=3"+
					" and costgrp.doc_no="+groupid+" order by srvckm limit 1";
			System.out.println(strgetmetrics);
			ResultSet rsgetmetrics=stmt.executeQuery(strgetmetrics);
			int instatus=0;
			while(rsgetmetrics.next()){
				instatus=1;
				maintcost=rsgetmetrics.getDouble("srvccost");
				insurpercent=rsgetmetrics.getDouble("insurpercent");
				tracker=rsgetmetrics.getDouble("tracker");
				regcost=rsgetmetrics.getDouble("regcost");
				tyrecost=rsgetmetrics.getDouble("tyrecost");
				replacecost=rsgetmetrics.getDouble("replacecost");
			}
			if(instatus!=1){
				String strgetmetrics2="select round(insurpercent,2) insurpercent,round(tracker,2) tracker,round(regcost,2) regcost,round(srvccost,2) "+
						" srvccost,round(replacecost,2) replacecost,round(tyrecost,2) tyrecost from gl_srvcmetricsm m left join gl_srvcmetricsd d on"+
						" (m.doc_no=d.rdocno) left join gl_lcgm costgrp on (m.tarifgroup=costgrp.grpid) where m.status=3 and d.status=3"+
						" and costgrp.doc_no="+groupid+" order by srvckm limit 1";
				System.out.println("Instatus Query:"+strgetmetrics2);
				ResultSet rsgetmetrics2=stmt.executeQuery(strgetmetrics2);
				while(rsgetmetrics2.next()){
					maintcost=rsgetmetrics2.getDouble("srvccost");
					insurpercent=rsgetmetrics2.getDouble("insurpercent");
					tracker=rsgetmetrics2.getDouble("tracker");
					regcost=rsgetmetrics2.getDouble("regcost");
					tyrecost=rsgetmetrics2.getDouble("tyrecost");
					replacecost=rsgetmetrics2.getDouble("replacecost");
				}
			}
			System.out.println("Instatus:"+instatus);
			netcost=landedcost-supportcost;
			
			tracker=trackervalue;
			margincost=netcost*(marginpercent/100);
			vehiclecost=(netcost+margincost)-daimlersupport;
			insurcost=(vehiclecost*(insurpercent/100))*(leasemonths/12);
			financecost=(vehiclecost*(financepercent/100))*(leasemonths/12);
			System.out.println("Finance cost checking: "+financecost);
			totalcost=vehiclecost+financecost+maintcost+insurcost+tyrecost+tracker+regcost+replacecost;
			residentialcost=residalvalue;
			totalleasecost=(totalcost-residentialcost)+leaseprofit;
			balance=totalleasecost-advancepyt;
			leasepermonth=balance/installments;
			Statement stmtround=conn.createStatement();
			ResultSet rsround=stmtround.executeQuery("select round("+leasepermonth+",0) leasepermonth");
			while(rsround.next()){
				leasepermonth=rsround.getDouble("leasepermonth");
			}
			ArrayList<String> mainarray=new ArrayList<>();
			for(int i=0;i<typetwodesc.size();i++){
				System.out.println(typetwodesc.get(i));
				if(typetwodesc.get(i).equalsIgnoreCase("9")){
					mainarray.add(typetwodesc.get(i)+"::"+landedcost);
				}
				if(typetwodesc.get(i).equalsIgnoreCase("10")){
					mainarray.add(typetwodesc.get(i)+"::"+supportcost);
				}
				if(typetwodesc.get(i).equalsIgnoreCase("11")){
					mainarray.add(typetwodesc.get(i)+"::"+netcost);
				}
				if(typetwodesc.get(i).equalsIgnoreCase("12")){
					mainarray.add(typetwodesc.get(i)+"::"+daimlersupport);
				}
				if(typetwodesc.get(i).equalsIgnoreCase("13")){
					mainarray.add(typetwodesc.get(i)+"::"+financecost);
				}
				if(typetwodesc.get(i).equalsIgnoreCase("14")){
					mainarray.add(typetwodesc.get(i)+"::"+maintcost);
				}
				if(typetwodesc.get(i).equalsIgnoreCase("15")){
					mainarray.add(typetwodesc.get(i)+"::"+insurcost);
				}
				if(typetwodesc.get(i).equalsIgnoreCase("16")){
					mainarray.add(typetwodesc.get(i)+"::"+tyrecost);
				}
				if(typetwodesc.get(i).equalsIgnoreCase("17")){
					mainarray.add(typetwodesc.get(i)+"::"+tracker);
				}
				if(typetwodesc.get(i).equalsIgnoreCase("18")){
					mainarray.add(typetwodesc.get(i)+"::"+regcost);
				}
				if(typetwodesc.get(i).equalsIgnoreCase("19")){
					mainarray.add(typetwodesc.get(i)+"::"+totalcost);
				}
				if(typetwodesc.get(i).equalsIgnoreCase("21")){
					mainarray.add(typetwodesc.get(i)+"::"+residentialcost);
				}
				if(typetwodesc.get(i).equalsIgnoreCase("22")){
					mainarray.add(typetwodesc.get(i)+"::"+leaseprofit);
				}
				if(typetwodesc.get(i).equalsIgnoreCase("23")){
					mainarray.add(typetwodesc.get(i)+"::"+totalleasecost);
				}
				if(typetwodesc.get(i).equalsIgnoreCase("24")){
					mainarray.add(typetwodesc.get(i)+"::"+advancepyt);
				}
				if(typetwodesc.get(i).equalsIgnoreCase("25")){
					mainarray.add(typetwodesc.get(i)+"::"+balance);
				}
				if(typetwodesc.get(i).equalsIgnoreCase("26")){
					mainarray.add(typetwodesc.get(i)+"::"+installments);
				}
				if(typetwodesc.get(i).equalsIgnoreCase("27")){
					mainarray.add(typetwodesc.get(i)+"::"+leasepermonth);
				}
				if(typetwodesc.get(i).equalsIgnoreCase("29")){
					mainarray.add(typetwodesc.get(i)+"::"+vehiclecost);
				}
				if(typetwodesc.get(i).equalsIgnoreCase("30")){
					mainarray.add(typetwodesc.get(i)+"::"+margincost);
				}
				if(typetwodesc.get(i).equalsIgnoreCase("32")){
					mainarray.add(typetwodesc.get(i)+"::"+replacecost);
				}
				if(typetwodesc.get(i).equalsIgnoreCase("35")){
					mainarray.add(typetwodesc.get(i)+"::"+(leasepermonth*installments));
				}
			}
			int deleteval=stmt.executeUpdate("delete from gl_leasecalcalfahim where reqdocno="+reqdocno+" and reqsrno="+reqsrno);
			for(int i=0;i<mainarray.size();i++){
				String strsql="insert into gl_leasecalcalfahim(srno,amount,type,reqdocno,status,reqsrno,calcdocno)values("+mainarray.get(i).split("::")[0]+","+mainarray.get(i).split("::")[1]+",2,"+reqdocno+",3,"+reqsrno+","+calcdocno+")";
				System.out.println(strsql);
				int val=stmt.executeUpdate(strsql);
			}
			for(int i=0;i<typemainarray.size();i++){
				String strsql="insert into gl_leasecalcalfahim(srno,amount,type,reqdocno,status,reqsrno,calcdocno)values("+typemainarray.get(i).split("::")[0]+","+typemainarray.get(i).split("::")[1]+",1,"+reqdocno+",3,"+reqsrno+","+calcdocno+")";
				System.out.println(strsql);
				int val=stmt.executeUpdate(strsql);
			}
			String strgettypetwo="select calc.srno,des.name description,calc.amount from gl_leasecalcalfahim calc left join gl_lcalculatoralf des on"+
			" (calc.srno=des.srno) where calc.type=2 and calc.reqdocno="+reqdocno+" and calc.status=3 and calc.reqsrno="+reqsrno;
			System.out.println(strgettypetwo);
			ResultSet rsgettypetwo=stmt.executeQuery(strgettypetwo);;
			typetwodata=objcommon.convertToJSON(rsgettypetwo);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return typetwodata;
	}

	public int insert(Date sqldate, String hidleasereqdoc,
			ArrayList<String> reqarray, HttpSession session, String brchName,
			String mode, String formdetailcode,HttpServletRequest request) throws SQLException{
		// TODO Auto-generated method stub
		
		Connection conn=null;
		int val=0;
		try{
			conn=objconn.getMyConnection();
			conn.setAutoCommit(false);
			CallableStatement stmtReq = conn.prepareCall("{call leaseCalcDML(?,?,?,?,?,?,?,?)}");
			stmtReq.registerOutParameter(3, java.sql.Types.INTEGER);
			stmtReq.registerOutParameter(8, java.sql.Types.INTEGER);
			stmtReq.setDate(1,sqldate);
			stmtReq.setString(2, hidleasereqdoc);
			stmtReq.setString(4, brchName);
			stmtReq.setString(5, session.getAttribute("USERID").toString());
			stmtReq.setString(6, mode);
			stmtReq.setString(7, formdetailcode);
			stmtReq.executeQuery();
			val=stmtReq.getInt("docNo");
			request.setAttribute("VOCNO", stmtReq.getInt("voucherno"));
			System.out.println("Doc No:"+val);
			if(val<=0){
				return 0;
			}
			int reqval=reqinsert(reqarray,hidleasereqdoc,val,conn);
			
			System.out.println("Req Val"+reqval);
			if(reqval<=0){
				return 0;
			}
		/*	int calcval=calcinsert(typeonearray,hidleasereqdoc,val,conn);
			if(calcval<=0){
				return 0;
			}  */
			conn.commit();
			return val;
		}
		catch(Exception e){
			e.printStackTrace();
			return 0;
		}
		finally{
			conn.close();
		}
		
	}

	private int calcinsert(ArrayList<String> typeonearray,
			String hidleasereqdoc, int val, Connection conn) throws SQLException {
		
		// TODO Auto-generated method stub
		
		try{
			int errorstatus=0;
			Statement stmt=conn.createStatement();
			System.out.println("Inside Function");
			for(int i=0;i<typeonearray.size();i++){
				String strsql="insert into gl_leasecalcalfahim(srno,amount,type,reqdocno,calcdocno,status)values("+typeonearray.get(i).split("::")[0]+","+typeonearray.get(i).split("::")[1]+",1,"+hidleasereqdoc+","+val+",3)";
				System.out.println("Inside Loop:"+strsql);
				int insertval=stmt.executeUpdate(strsql);
				if(insertval<=0){
					errorstatus=1;
					return 0;
				}
			}
			int updateval=stmt.executeUpdate("update gl_leasecalcalfahim set calcdocno="+val+" where reqdocno="+hidleasereqdoc);
			if(updateval<0){
				errorstatus=1;
			}
			if(errorstatus==1){
				return 0;
			}
			else{
				return 1;
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			
		}
		return 0;
	}


	private int reqinsert(ArrayList<String> reqarray, String hidleasereqdoc,int val,Connection conn) {
		// TODO Auto-generated method stub
		int reqval=0;
		try{
			int errorstatus=0;
			Statement stmt=conn.createStatement();
			//System.out.println("Arraysize:"+reqarray.size());
			for(int i=0;i<reqarray.size();i++){
				java.sql.Date sqlfromdate=null;
				//System.out.println("Checking Array:"+reqarray.get(i));
				String req[]=reqarray.get(i).split("::");
				if(!req[0].equalsIgnoreCase("") && !req[0].equalsIgnoreCase("undefined")){
					sqlfromdate=objcommon.changeStringtoSqlDate(req[0]);
				}
				String brdid=req[1].equalsIgnoreCase("undefined") || req[1].isEmpty()?"0":req[1];
				String modelid=req[2].equalsIgnoreCase("undefined") || req[2].isEmpty()?"0":req[2];
				String spec=req[3].equalsIgnoreCase("undefined") || req[3].isEmpty()?"0":req[3];
				String clrid=req[4].equalsIgnoreCase("undefined") || req[4].isEmpty()?"0":req[4];
				String leasemonths=req[5].equalsIgnoreCase("undefined") || req[5].isEmpty()?"0":req[5];
				String kmpermonth=req[6].equalsIgnoreCase("undefined") || req[6].isEmpty()?"0":req[6];
				String grpid=req[7].equalsIgnoreCase("undefined") || req[7].isEmpty()?"0":req[7];
				String reqsrno=req[8].equalsIgnoreCase("undefined") || req[8].isEmpty()?"0":req[8];
				String quantity=req[9].equalsIgnoreCase("undefined") || req[9].isEmpty()?"0":req[9];
				String yomid=req[10].equalsIgnoreCase("undefined") || req[10].isEmpty()?"0":req[10];
				String vsb=req[11].equalsIgnoreCase("undefined") || req[11].isEmpty()?"":req[11];
				String strsql="insert into gl_leasecalcreq(rdocno,leasereqdocno,leasefromdate,brdid,modid,spec,clrid,leasemonths,kmpermonth,grpid,status,reqsrno,quantity,yomid,vsb)values("+val+","+
				hidleasereqdoc+",'"+sqlfromdate+"',"+brdid+","+modelid+",'"+spec+"',"+clrid+","+leasemonths+","+kmpermonth+","+grpid+",3,"+reqsrno+","+quantity+","+yomid+",'"+vsb+"')";
				//System.out.println("Req Insert Query:"+strsql);
				reqval=stmt.executeUpdate(strsql);
				if(reqval<=0){
					errorstatus=1;
					return 0;
				}
			}
			if(errorstatus==1){
				return 0;
			}
		}
		catch(Exception e){
			e.printStackTrace();
			return 0;
		}
		return reqval;
		
	}

	
	public JSONArray getTypeDataView(String id,String reqdocno,String type,String reqsrno,String calcdocno)throws SQLException{
		JSONArray typedata=new JSONArray();
		if(!id.equalsIgnoreCase("5")){
			return typedata;
		}
		System.out.println(reqdocno+"::"+calcdocno+"::"+reqsrno);
		Connection conn=null;
		
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String sqltest="";
			if(!calcdocno.equalsIgnoreCase("")){
				sqltest+=" and calc.calcdocno="+calcdocno;
			}
			if(!reqsrno.equalsIgnoreCase("")){
				sqltest+=" and calc.reqsrno="+reqsrno;
			}
			String strsql="select calc.srno,calc.amount,des.name description from gl_leasecalcalfahim calc left join gl_lcalculatoralf des on calc.srno=des.srno "+
			" where calc.type="+type+" and calc.status=3 and calc.reqdocno="+reqdocno+sqltest;
			System.out.println("=========type"+type+"=== "+strsql);
			ResultSet rstype=stmt.executeQuery(strsql);
			typedata=objcommon.convertToJSON(rstype);
			stmt.close();
					
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		
		return typedata;
	}
	
	public JSONArray getSearchData(String docno,String leasereqdocno,String date,String id,String client,String mobile,String branch) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        if(!id.equalsIgnoreCase("1")){
        	return RESULTDATA;
        }
        Connection conn = null;
        String sqltest="";
        java.sql.Date sqldate=null;
        
		try {
				conn = objconn.getMyConnection();
				Statement stmt=conn.createStatement();
				if(!date.equalsIgnoreCase("")){
					sqldate=objcommon.changeStringtoSqlDate(date);
				}
				if(!docno.equalsIgnoreCase("")){
					sqltest+=" and calc.vocno like '%"+docno+"%'";
				}
				if(!leasereqdocno.equalsIgnoreCase("")){
					sqltest+=" and req.voc_no like '%"+leasereqdocno+"%'";
				}
				if(sqldate!=null){
					sqltest+=" and date='"+sqldate+"'";
				}
				if(!client.equalsIgnoreCase("")){
					sqltest+=" and if(req.reqtype=1,ac.refname like '%"+client+"%',req.name like '%"+client+"%')";
				}
				if(!mobile.equalsIgnoreCase("")){
					sqltest+=" and if(req.reqtype=1,ac.com_mob like '%"+mobile+"%',req.mob like '%"+mobile+"%')";
				}
				if(!branch.equalsIgnoreCase("")){
					sqltest+=" and calc.brhid="+branch;
				}
				String strsql="select calc.vocno,req.voc_no leasereqdocno,if(req.reqtype=1,ac.com_mob,req.mob) mobile,if(req.reqtype=1,ac.refname,req.name) refname,calc.doc_no,calc.date,calc.reqdoc"+
				" hidleasereqdocno ,ac.mail1 email from gl_leasecalcm calc left join gl_lprm req on (calc.reqdoc=req.doc_no) left join my_acbook ac on "+
				" (req.cldocno=ac.cldocno and ac.dtype='CRM') where calc.status=3"+sqltest;
				System.out.println(strsql);
				ResultSet resultSet = stmt.executeQuery(strsql);
				RESULTDATA=objcommon.convertToJSON(resultSet);
				
				stmt.close();
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
    
	public ClsLeaseCalculatorBean getPrint(String docno, HttpServletRequest request) throws SQLException {
		// TODO Auto-generated method stub
	ClsLeaseCalculatorBean bean=new ClsLeaseCalculatorBean();
	Connection conn=null;
	try{
		conn=objconn.getMyConnection();
		Statement stmt=conn.createStatement();
		
		String strsql="select br.branchname,loc.loc_name,m.reqdoc,if(req.reqtype=1,ac.address,req.com_add1) clientaddress,if(req.reqtype=1,ac.com_mob,req.mob) "+
		" clientmobile,if(req.reqtype=1,ac.refname,req.name) refname,m.doc_no docno,m.reqdoc,DATE_FORMAT(m.date,'%d-%m-%Y') date,comp.company,comp.address,"+
		" comp.tel,comp.fax from gl_leasecalcm m left join my_brch br on m.brhid=br.doc_no left join my_comp comp on br.cmpid=comp.doc_no left join gl_lprm req on "+
		" (m.reqdoc=req.doc_no) left join my_acbook ac on (req.cldocno=ac.cldocno and ac.dtype='CRM') left join my_locm loc on (br.doc_no=loc.brhid) where "+
		" m.status=3 and m.doc_no="+docno+" limit 1";
		
		System.out.println("---------strsqlcarqut-------"+strsql);
		ResultSet rs=stmt.executeQuery(strsql);
		while(rs.next()){
			bean.setLbldate(rs.getString("date"));
			bean.setLbldocno(rs.getString("docno"));
			bean.setLblleasereqdocno(rs.getString("reqdoc"));
			bean.setLblcompname(rs.getString("company"));
			bean.setLblcompaddress(rs.getString("address"));
			bean.setLblcompfax(rs.getString("fax"));
			bean.setLblcomptel(rs.getString("tel"));
			bean.setLblclient(rs.getString("refname"));
			bean.setLblclientaddress(rs.getString("clientaddress"));
			bean.setLblmob(rs.getString("clientmobile"));
			bean.setLblleasereqdocno(rs.getString("reqdoc"));
			bean.setLblbranch(rs.getString("branchname"));
			bean.setLbllocation(rs.getString("loc_name"));
		}
	/*	ArrayList<String> reqarray=new ArrayList<>();
		reqarray=getLeaseReqDetails(docno,conn);
		request.setAttribute("REQPRINT",reqarray);*/
		
		ArrayList<String> reqarray=new ArrayList<>();
		reqarray=getLeaseReqDetails(docno,conn);
		request.setAttribute("REQPRINT", reqarray);
		ArrayList<String> reqdetailarray=new ArrayList<>();
		reqdetailarray=getCalcDetails(docno,conn);
		request.setAttribute("REQDETAILPRINT", reqdetailarray);
	}
	catch(Exception e){
		e.printStackTrace();
	}
	finally{
		conn.close();
	}
		return bean;
	}

	private ArrayList<String> getCalcDetails(String docno, Connection conn) {
		// TODO Auto-generated method stub
		ArrayList<String> reqdetailarray=new ArrayList<>();
		try{
			
			Statement stmt=conn.createStatement();
			/*String str="select srno,det.details,coalesce(round(amount,2),'') amount,coalesce(round(amount1,2),'') amount1,coalesce(round(amount2,2),'') amount2,"+
			" coalesce(round(amount3,2),'') amount3,coalesce(round(amount4,2),'') amount4,coalesce(round(amount5,2),'') amount5 from gl_leasecalcd"+
			" d left join gl_leasecalcdetails det on (d.detaildocno=det.doc_no) where rdocno="+docno;*/
			String str="select calc.reqsrno srno,des.name description,round(calc.amount,2) amount from gl_leasecalcalfahim calc left join gl_lcalculatoralf des on"+
			" (calc.srno=des.srno) where calc.type=2 and calc.calcdocno="+docno+" and calc.status=3 ";
			ResultSet rsdet=stmt.executeQuery(str);
			int i=0;
			int tempsrno=0;
			int rowcount=1;
			while (rsdet.next()) {
				i++;
				if(tempsrno!=rsdet.getInt("srno")){
					i=1;
				}
				//System.out.println(rsdet.getString("srno")+" :: "+rsdet.getString("description")+" :: "+rsdet.getString("amount"));
				reqdetailarray.add(rsdet.getString("srno")+" :: "+rsdet.getString("description")+" :: "+rsdet.getString("amount"));
				tempsrno=rsdet.getInt("srno");
				rowcount++;
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return reqdetailarray;
	}

	private ArrayList<String> getLeaseReqDetails(String docno,Connection conn) {
		// TODO Auto-generated method stub
		ArrayList<String> reqarray=new ArrayList<>();
		try{
			Statement stmt=conn.createStatement();
			String str="select req.savestatus,req.reqsrno srno,req.rdocno,coalesce(DATE_FORMAT(req.leasefromdate,'%d/%m/%Y'),'') leasefromdate,coalesce(brd.brand_name,'') brand,"+
			" coalesce(model.vtype,'') model,coalesce(req.spec,'') spec,coalesce(clr.color,'') color,coalesce(req.leasemonths,'') leasemonths,"+
			" coalesce(round(req.kmpermonth,2),'') kmpermonth,coalesce(grp.gname,'') gname,coalesce(vnd.name,'') vendor,coalesce(round(prchcost,2),'') prchcost,"+
			" coalesce(round(downpytper,2),'') downpytper,coalesce(round(interestper,2),'') interestper,coalesce(round(creditcardper,2),'')"+
			" creditper,coalesce(auth.authname,'') auth,coalesce(round(req.profitper,2),'') profitper,coalesce(round(overheadper,2),'')"+
			" overheadper,coalesce(round(others,2),'') others,coalesce(round(req.discount,2),'') discount,coalesce(round(req.totalvalue,2),'')"+
			" totalvalue,req.savestatus,req.confirmstatus from gl_leasecalcreq req left join gl_vehbrand brd on req.brdid=brd.doc_no left join gl_vehmodel model on"+
			" req.modid=model.doc_no left join my_color clr on req.clrid=clr.doc_no left join gl_lcgm lcg on req.grpid=lcg.doc_no left"+
			" join gl_vehgroup grp on lcg.grpid=grp.doc_no left join my_vendorm vnd on req.dealerid=vnd.doc_no left join gl_vehauth auth on"+
			" req.authid=auth.doc_no where req.status=3 and req.rdocno="+docno;
			ResultSet rsreq=stmt.executeQuery(str);
			int i=0;
			while(rsreq.next()){
				i++;
				/*" :: Sr No :: Details :: Total Amount :: Year1 :: Year2 :: Year3 :: Year4 :: Year5";*/
/*				reqarray.add(rsreq.getString("srno")+" :: "+rsreq.getString("rdocno")+" :: "+i+" :: "+rsreq.getString("leasefromdate")+" :: "+rsreq.getString("brand")+" :: "+rsreq.getString("model")+" :: "+rsreq.getString("spec")+" :: "+
				rsreq.getString("color")+" :: "+rsreq.getString("leasemonths")+" :: "+rsreq.getString("kmpermonth")+" :: "+rsreq.getString("gname")+" :: "+rsreq.getString("totalvalue")+" :: "+rsreq.getString("savestatus")+" :: "+
				"Dealer :: Purchase Cost :: Down payment % :: Interest % :: Credit card % :: Authority :: Profit % :: Overhead % :: Others :: Discount :: "+rsreq.getString("vendor")+" :: "+rsreq.getString("prchcost")+" :: "+rsreq.getString("downpytper")+" :: "+rsreq.getString("interestper")+" :: "+
				rsreq.getString("creditper")+" :: "+rsreq.getString("auth")+" :: "+rsreq.getString("profitper")+" :: "+rsreq.getString("overheadper")+" :: "+rsreq.getString("others")+" :: "+rsreq.getString("discount"));*/
				
				reqarray.add(rsreq.getString("srno")+" :: "+rsreq.getString("rdocno")+" :: "+i+" :: "+rsreq.getString("leasefromdate")+" :: "+rsreq.getString("brand")+" :: "+rsreq.getString("model")+" :: "+rsreq.getString("spec")+" :: "+
						rsreq.getString("color")+" :: "+rsreq.getString("leasemonths")+" :: "+rsreq.getString("kmpermonth")+" :: "+rsreq.getString("gname")+" :: "+rsreq.getString("totalvalue")+" :: "+rsreq.getString("savestatus"));
				//System.out.println(i+reqarray.get(i-1));
				//reqarray.addAll(getCalcDetails(docno, conn, reqarray, i));
				/*System.out.println(reqarray.get(i-1));*/
			}
			
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return reqarray;
	}



	 public   ClsLeaseCalcAlFahimBean getPrintQot(int docno, HttpServletRequest request) throws SQLException {
		 ClsLeaseCalcAlFahimBean bean = new ClsLeaseCalcAlFahimBean();
		  Connection conn = null;
		try {
				 conn = objconn.getMyConnection();
				Statement stmtprint = conn.createStatement ();
	        	
				String resql=("select q.voc_no,coalesce(q.glterms,'') glterms, q.DOC_NO,DATE_FORMAT(q.DATE,'%d-%m-%Y') DATE , q.REF_NO, "
						+ "if(q.REF_TYPE='DIR','Direct',concat('Enquiry ','(',q.REF_NO,')')) type,q.CONTACT_NO mob ,if(q.REF_TYPE='DIR',a.refname,e.name) name, "
						+ "if(q.REF_TYPE='DIR',a.address,e.com_add1) com_add1,if(q.REF_TYPE='DIR',a.per_mob,e.mob) mob,if(q.REF_TYPE='DIR',a.mail1,e.email) email from "
						+ "   gl_quotm q left join gl_qenq d on d.rdocno=q.doc_no   left join gl_enqm e on e.doc_no=q.ref_no left join my_acbook a  "
						+ "on a.cldocno=q.cldocno and a.dtype='CRM'   where q.DOC_NO="+docno+" ");
				System.out.println("++++++++++1111111111++++++"+resql);
				ResultSet pintrs = stmtprint.executeQuery(resql);
				
			     
			       while(pintrs.next()){
			    	   // cldatails
			    	   
			    	  /* setLblclient setLblclientaddress setLblmob setLblemail setLbldate setLbltypep setDocvals*/
			    	   if(!(pintrs.getString("glterms").equalsIgnoreCase("")) && (!(pintrs.getString("glterms").equalsIgnoreCase("NA"))))
			    	   {
			    		   bean.setGeneralterms(pintrs.getString("glterms"));
			    		   
			    		   bean.setTerms1("General Terms And Conditions" );
			    		   
			    	   }
			    	   
			    	   
			    	   
			    	    bean.setLblclient(pintrs.getString("name"));
			    	    bean.setLblclientaddress(pintrs.getString("com_add1"));
			    	    bean.setLblmob(pintrs.getString("mob"));
			    	    bean.setLblemail(pintrs.getString("email"));
			    	    //upper
			    	    bean.setLbldate(pintrs.getString("date"));
			    	    bean.setLbltypep(pintrs.getString("type"));
			    	    bean.setDocvals(pintrs.getInt("voc_no"));
			    	    
			    	    
			       }
				

				stmtprint.close();
				
				
				
				
				/*String saver="select usr.user_id from gl_leasecalcreq req left join gl_leasecalcm calcm on(req.rdocno=calcm.doc_no) "
						+ "  left join my_user usr on(calcm.userid=usr.doc_no)  where req.status=3 and req.rdocno="+docno+" ";
				*/

				String saver="select coalesce(usr.user_id,'')user_id from gl_leasecalcreq req left join gl_leasecalcm calcm on(req.rdocno=calcm.doc_no) "
						+ "  left join my_user usr on(calcm.userid=usr.doc_no)  where req.status=3 and req.rdocno="+docno+" ";
				
				Statement sav=conn.createStatement();
				ResultSet srs=sav.executeQuery(saver);
				while(srs.next()){
					bean.setSavedby(srs.getString("user_id"));
				}
				
				
				
				
				
				
				
					 Statement stmtinvoice10 = conn.createStatement ();
				  String  companysql="select c.company,c.address,c.tel,c.fax,lc.loc_name location,b.branchname,b.pbno,b.stcno,b.cstno from gl_leasecalcm r inner join my_brch b on  "
				    		+ "r.brhid=b.doc_no inner join my_comp c on b.cmpid=c.doc_no inner join my_locm l on l.brhid=b.doc_no inner join (select min(lo.loc) loc,lo.loc_name, "
				    		+ " lo.brhid from my_locm lo group by brhid) as lc on(lc.loc=l.loc and lc.brhid=b.doc_no) where r.doc_no='"+docno+"' ";
                     System.out.println("--------"+companysql);

			         ResultSet resultsetcompany = stmtinvoice10.executeQuery(companysql); 
				       while(resultsetcompany.next()){
				    	   bean.setLblbranch(resultsetcompany.getString("branchname"));
				    	   bean.setLblcompname(resultsetcompany.getString("company"));
				    	  
				    	   bean.setLblcompaddress(resultsetcompany.getString("address"));
				    	 
				    	   bean.setLblcomptel(resultsetcompany.getString("tel"));
				    	  
				    	   bean.setLblcompfax(resultsetcompany.getString("fax"));
				    	   bean.setLbllocation(resultsetcompany.getString("location"));
				    	  
				    	   bean.setLblcstno(resultsetcompany.getString("cstno"));
					    	  
				    		  bean.setLblservicetax(resultsetcompany.getString("stcno"));
				    		  bean.setLblpan(resultsetcompany.getString("pbno"));
				    	   
				       } 
				       stmtinvoice10.close();
				       ArrayList<String> arr=new ArrayList<String>();
						Statement stmtinvoice2 = conn.createStatement ();
					
						
					    
						String strSqldetail="select @i:=1 srno, DATE_FORMAT(req.leasefromdate,'%d-%m-%Y') leasefromdate,brd.brand_name,req.spec spec,\r\n" + 
								"brand,model.vtype model,coalesce(clr.color,'') color,req.leasemonths,round(req.kmpermonth,0) kmpermonth,grp.gname,\r\n" + 
								"coalesce(round(req.totalvalue,2),'') totalvalue from gl_leasecalcreq req left join gl_vehbrand brd on req.brdid=brd.doc_no left join gl_vehmodel model on\r\n" + 
								"req.modid=model.doc_no left join my_color clr on req.clrid=clr.doc_no left join gl_lcgm lcg on (req.brdid=req.brdid and req.modid=lcg.modid) left join\r\n" + 
								"gl_vehgroup grp on (lcg.grpid=grp.doc_no) left join my_vendorm vnd on (req.dealerid=vnd.doc_no) left join gl_vehauth auth on\r\n" + 
								"(req.authid=auth.doc_no)where req.status=3 and req.rdocno="+docno;
				System.out.println("tableeeeeeeeeeeeeeeee"+strSqldetail);
			
					ResultSet rsdetail=stmtinvoice2.executeQuery(strSqldetail);
					
					int rowcount=1;
			
					while(rsdetail.next()){
						
							String temp="";
							String spci="";
							 bean.setFirstarray(1); 
							if(rsdetail.getString("spec").equalsIgnoreCase("0"))
							{
								spci="";
							}
							else
							{
								spci=rsdetail.getString("spec");
							}
							temp=rowcount+"::"+rsdetail.getString("leasefromdate")+"::"+rsdetail.getString("brand")+"::"+rsdetail.getString("model")+"::"+spci+"::"+rsdetail.getString("color")+"::"+rsdetail.getString("leasemonths")+"::"+rsdetail.getString("kmpermonth")+"::"+rsdetail.getString("gname")+"::"+rsdetail.getString("totalvalue") ;
		
							arr.add(temp);
							rowcount++;
			
					
						
				              }
					stmtinvoice2.close();  
					request.setAttribute("details",arr); 
					
					// System.out.println("--------------"+arr);	
				       ArrayList<String> descarr=new ArrayList<String>();
								Statement stmtinvoice11 = conn.createStatement ();
							
								
								String stsql="select  concat(c.srno,' .  ',m.description,' ',' ',if(c.descplus='0','',c.descplus)) descplus from gl_quotc c "
										+ " left join gl_qcond m on c.desid=m.doc_no where m.status=3 and c.rdocno='"+docno+"' order by c.rowno";
								
						//	System.out.println("--------------"+strSqldetail);
					
							ResultSet rsdetails=stmtinvoice11.executeQuery(stsql);
							
						String temp1="";
					String ss="";
							while(rsdetails.next()){
								 bean.setTerms2("Special Notes" );
								
								temp1=ss+"::"+rsdetails.getString("descplus") ;
				
								descarr.add(temp1);
								
							
								
						              }
							stmtinvoice2.close();  
							request.setAttribute("desc",descarr); 
					
							

									
									Statement stmtprint1 = conn.createStatement();
				        	
							String resql1=("select voc_no,DATE_FORMAT(l.date,'%d-%m-%Y') date,coalesce(refname,name) refname, coalesce(address,com_add1) address, coalesce(per_mob,mob) per_mob, coalesce(mail1,email) mail1 from  gl_leasecalcm l left join gl_lprm l1 on reqdoc=l1.doc_no\r\n" + 
									"									left join my_acbook a on a.doc_no=l1.cldocno and a.dtype='CRM' where l.doc_no="+docno+" ");
							
						System.out.println("--+++++++++222++++++++++++--"+resql1);
							ResultSet pintrs1 = stmtprint1.executeQuery(resql1);
							
						     
						       while(pintrs1.next()){
						    	   // cldatails
						    	   
						    	  /* setLblclient setLblclientaddress setLblmob setLblemail setLbldate setLbltypep setDocvals*/
						    	    bean.setLblclient(pintrs1.getString("refname"));
						    	    bean.setLblclientaddress(pintrs1.getString("address"));
						    	    bean.setLblmob(pintrs1.getString("per_mob"));
						    	    bean.setLblemail(pintrs1.getString("mail1"));
						    	    //upper
						    	    bean.setLbldate(pintrs1.getString("date"));
						    	  //  bean.setLbltypep(pintrs1.getString("type"));
						    	    bean.setDocvals(pintrs1.getInt("voc_no"));
						    	    
						    	    
						       }
							

							stmtprint1.close();
							
				conn.close();



				
		}
		catch(Exception e){
			conn.close();
			e.printStackTrace();
		}
		return bean;
		
	
	 }

	 public double getResidualValue(String reqdocno,String reqsrno) throws SQLException{
		 double residualvalue=0.0;
		 System.out.println(reqdocno+"////////"+reqsrno);
		 if(reqdocno.equalsIgnoreCase("") || reqsrno.equalsIgnoreCase("")){
			 return residualvalue;
		 }
		 Connection conn=null;
		 try{
			 conn=objconn.getMyConnection();
			 Statement stmt=conn.createStatement();
			 String brandid="",modelid="",yomid="",leasemonths="",kmpermonth="";
			 String strgetdetails="select brdid,modid,yomid,leasemonths,kmpermonth from gl_leasecalcreq where leasereqdocno="+reqdocno+" and reqsrno="+reqsrno;
			 System.out.println(strgetdetails);
			 ResultSet rsgetdetails=stmt.executeQuery(strgetdetails);
			 while(rsgetdetails.next()){
				 brandid=rsgetdetails.getString("brdid");
				 modelid=rsgetdetails.getString("modid");
				 yomid=rsgetdetails.getString("yomid");
				 leasemonths=rsgetdetails.getString("leasemonths");
				 kmpermonth=rsgetdetails.getString("kmpermonth");
			 }
			 String strresidual="select residualvalue from gl_residualvaluem where months="+leasemonths+" and km="+kmpermonth+" and brandid="+brandid+" and modelid="+modelid+" and yomid="+yomid+" and status=3";
			 System.out.println(strresidual);
			 ResultSet rsresidual=stmt.executeQuery(strresidual);
			 while(rsresidual.next()){
				 residualvalue=rsresidual.getDouble("residualvalue");
			 }
		 }
		 catch(Exception e){
			 e.printStackTrace();
		 }
		 finally{
			 conn.close();
		 }
		 return residualvalue;
	 }
	 public double getConvertRate()throws SQLException{
		 double convertrate=0.0;
		 Connection conn=null;
		 try{
			 conn=objconn.getMyConnection();
			 Statement stmt=conn.createStatement();
			 String strsql="select if(method=1,round(value,2),0) convertrate from gl_config where field_nme='leasecalcconvertrate'";
			 ResultSet rs=stmt.executeQuery(strsql);
			 while(rs.next()){
				 convertrate=rs.getDouble("convertrate");
			 }
			 stmt.close();
		 }
		 catch(Exception e){
			 e.printStackTrace();
		 }
		 finally{
			 conn.close();
		 }
		 return convertrate;
	 }
	 public double getExKmRate(String reqdocno,String reqsrno) throws SQLException{
		 System.out.println(reqdocno+"////"+reqsrno);
		 double exkmrate=0.0;
		 if(reqdocno.equalsIgnoreCase("") || reqsrno.equalsIgnoreCase("")){
			 return exkmrate;
		 }
		 Connection conn=null;
		 try{
			 int grpid=0;
			 conn=objconn.getMyConnection();
			 Statement stmt=conn.createStatement();
			 String strsql="select grpid from gl_leasecalcreq where leasereqdocno="+reqdocno+" and reqsrno="+reqsrno+" and status=3";
			 ResultSet rs=stmt.executeQuery(strsql);
			 while(rs.next()){
				 grpid=rs.getInt("grpid");
			 }
			 String str="select round(coalesce(exkmrate,0),2) exkmrate from gl_srvcmetricsm where tarifgroup="+grpid+"";
			 System.out.println(str);
			 ResultSet rs1=stmt.executeQuery(str);
			 while(rs1.next()){
				 exkmrate=rs1.getDouble("exkmrate");
			 }
			 stmt.close();
		 }
		 catch(Exception e){
			 e.printStackTrace();
		 }
		 finally{
			 conn.close();
		 }
		 return exkmrate;
	 }
	 
	  public double getTracker(String reqdocno,String reqsrno) throws SQLException{
		 double tracker=0.0;
		 if(reqdocno.equalsIgnoreCase("") || reqsrno.equalsIgnoreCase("")){
			 return tracker;
		 }
		 Connection conn=null;
		 try{
			 int grpid=0;
			 conn=objconn.getMyConnection();
			 Statement stmt=conn.createStatement();
			 String strsql="select grpid from gl_leasecalcreq where leasereqdocno="+reqdocno+" and reqsrno="+reqsrno+" and status=3";
			 ResultSet rs=stmt.executeQuery(strsql);
			 while(rs.next()){
				 grpid=rs.getInt("grpid");
			 }
			 String str="select round(coalesce(tracker,0),2) tracker from gl_srvcmetricsm where tarifgroup="+grpid+"";
			 System.out.println(str);
			 ResultSet rs1=stmt.executeQuery(str);
			 while(rs1.next()){
				 tracker=rs1.getDouble("tracker");
			 }
			 stmt.close();
		 }
		 catch(Exception e){
			 e.printStackTrace();
		 }
		 finally{
			 conn.close();
		 }
		 return tracker;
	 }
}
