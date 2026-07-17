package com.operations.marketing.leasecalculator;

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


public class ClsLeaseCalculatorDAO {
    ClsCommon objcommon=new ClsCommon();
    ClsConnection objconn=new ClsConnection();
    public   JSONArray leaseGridLoading() throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
		try {
				conn = objconn.getMyConnection();
				Statement stmtCRM = conn.createStatement();
            	
				ResultSet resultSet = stmtCRM.executeQuery ("select details,flow from gl_leasecalcdetails where status=3");

				RESULTDATA=objcommon.convertToJSON(resultSet);
				
				stmtCRM.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
    
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
    
    
    public JSONArray getSearchData(String docno,String leasereqdocno,String date,String id,String client,String mobile) throws SQLException {

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
					sqltest+=" and doc_no="+docno;
				}
				if(!leasereqdocno.equalsIgnoreCase("")){
					sqltest+=" and reqdoc="+leasereqdocno;
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
				String strsql="select if(req.reqtype=1,ac.com_mob,req.mob) mobile,if(req.reqtype=1,ac.refname,req.name) refname,calc.doc_no,calc.date,calc.reqdoc"+
				" leasereqdocno from gl_leasecalcm calc left join gl_lprm req on (calc.reqdoc=req.doc_no) left join my_acbook ac on "+
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
					strsql="select coalesce(req.confirmstatus,0) confirmstatus,req.totalvalue,vnd.name dealer,auth.authid,auth.authname authority,req.dealerid hiddealer,req.prchcost purchcost,req.downpytper,req.interestper,req.profitper,req.creditcardper,"+
					" req.authid hidauthority,req.overheadper,req.others,req.discount,req.savestatus,req.srno,req.rdocno,req.leasereqdocno,req.leasefromdate,"+
					" req.brdid,req.modid modelid,req.spec specification,req.clrid,req.leasemonths,req.kmpermonth,req.grpid,0 rowcolor,grp.gname,brd.brand_name "+
					" brand,model.vtype model,clr.color,'Quotation' quotbtn from gl_leasecalcreq req left join gl_vehbrand brd on req.brdid=brd.doc_no left join gl_vehmodel model on "+
					" req.modid=model.doc_no left join my_color clr on req.clrid=clr.doc_no left join gl_lcgm lcg on (req.brdid=req.brdid and req.modid=lcg.modid) left join "+
					" gl_vehgroup grp on (lcg.grpid=grp.doc_no) left join my_vendorm vnd on (req.dealerid=vnd.doc_no) left join gl_vehauth auth on "+
					" (req.authid=auth.doc_no)where req.status=3 and req.rdocno="+docno+" and req.leasereqdocno="+reqdocno;
				}
				else{
					strsql="select 0 confirmstatus,0 savestatus,0 rowcolor,brd.doc_no brdid,model.doc_no modelid,clr.doc_no clrid,lcg.doc_no grpid,grp.gname,det.frmdate leasefromdate,det.spec specification,brd.brand_name brand,model.vtype model,det.spec,clr.color,det.ldur leasemonths,det.kmusage"+
							" kmpermonth,'Quotation' quotbtn from gl_lprd det left join gl_vehbrand brd on det.brdid=brd.doc_no left join gl_vehmodel model on det.modid=model.doc_no"+
							" left join my_color clr on det.clrid=clr.doc_no left join gl_lcgm lcg on (det.brdid=lcg.brdid and det.modid=lcg.modid) "+
							" left join gl_vehgroup grp on (lcg.grpid=grp.doc_no)where det.rdocno="+reqdocno;
					
				}
				//System.out.println(strsql);
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

    
    public JSONArray getAuthority() throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
		try {
				conn = objconn.getMyConnection();
				Statement stmt = conn.createStatement();
            	
				ResultSet resultSet = stmt.executeQuery ("select doc_no,authname,authid from gl_vehauth where status=3");

				RESULTDATA=objcommon.convertToJSON(resultSet);
				
				stmt.close();
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
    
    public JSONArray calculate(String purchcost,String downpytper,String interestper,String creditper,String authority,String profitper,String overheadper,
    		String others,String discount,String leasemonths,String kmpermonth,String grpid,String id,String authid,String srno,String docno,String leasereqdocno) throws SQLException{
    	JSONArray RESULTDATA=new JSONArray();
    	//System.out.println("Here");
    	if(!id.equalsIgnoreCase("1")){
    		return RESULTDATA;
    	}
    	Connection conn=null;
    	try{
    		conn=objconn.getMyConnection();
    		Statement  stmt=conn.createStatement();
//    		double months=Integer.parseInt(leasemonths)/12 > 12 ? 12  :  (Integer.parseInt(leasemonths)/12);
    		
    		double months = Integer.parseInt(leasemonths)/12;
    		double mininsur=0.0,costpermonth=0.0;
    		double depryear1=0.0,depryear2=0.0,depryear3=0.0,depryear4=0.0,depryear5=0.0,insurper=0.0,srvkm=0.0,tyrechangekm=0.0,tyrecost=0.0,maintcost=0.0,replacecost=0.0,
    				carwashcost=0.0,auhcost=0.0,dxbcost=0.0,shjcost=0.0,fujcost=0.0,rakcost=0.0,regcost=0.0;
    		double vehvalueyear1=0.0,vehvalueyear2=0.0,vehvalueyear3=0.0,vehvalueyear4=0.0,vehvalueyear5=0.0,vehvaluetotal=0.0;
    		double deprcost1=0.0,deprcost2=0.0,deprcost3=0.0,deprcost4=0.0,deprcost5=0.0,deprtotalcost=0.0;
    		double insurcost1=0.0,insurcost2=0.0,insurcost3=0.0,insurcost4=0.0,insurcost5=0.0,insurtotalcost=0.0;
    		double carwashcost1=0.0,carwashcost2=0.0,carwashcost3=0.0,carwashcost4=0.0,carwashcost5=0.0,carwashtotalcost=0.0;
    		double maintcost1=0.0,maintcost2=0.0,maintcost3=0.0,maintcost4=0.0,maintcost5=0.0,mainttotalcost=0.0;
    		double replacecost1=0.0,replacecost2=0.0,replacecost3=0.0,replacecost4=0.0,replacecost5=0.0,replacetotalcost=0.0;
    		double tyrecost1=0.0,tyrecost2=0.0,tyrecost3=0.0,tyrecost4=0.0,tyrecost5=0.0,tyretotalcost=0.0;
    		double regcost1=0.0,regcost2=0.0,regcost3=0.0,regcost4=0.0,regcost5=0.0,regtotalcost=0.0;
    		double totalcost1=0.0,totalcost2=0.0,totalcost3=0.0,totalcost4=0.0,totalcost5=0.0;
    		double extrainsurperyear=0.0,extrainsurperyear1=0.0,extrainsurperyear2=0.0,extrainsurperyear3=0.0,extrainsurperyear4=0.0,extrainsurperyear5=0.0;
    		double majorsrvckm=0.0,majorsrvckm1=0.0,majorsrvckm2=0.0,majorsrvckm13=0.0,majorsrvckm14=0.0,majorsrvckm15=0.0;
    		double majorsrvccost=0.0,majorsrvccost1=0.0,majorsrvccost2=0.0,majorsrvccost3=0.0,majorsrvccost4=0.0,majorsrvccost5=0.0;
    		double trackidexp=0.0,trackidexp1=0.0,trackidexp2=0.0,trackidexp3=0.0,trackidexp4=0.0,trackidexp5=0.0;
    		double interestcost1=0.0,interestcost2=0.0,interestcost3=0.0,interestcost4=0.0,interestcost5=0.0,interesttotalcost=0.0;
    		double mastertotal=0.0,overheadpertotal=0.0,profittotal=0.0,rentabletotal=0.0,permonthtotal=0.0,credittotal=0.0,rentpermonthtotal=0.0,
    				discounttotal=0.0,netrentaltotal=0.0,rentalcollecttotal=0.0,residualtotal=0.0,inflowtotal=0.0,expensetotal=0.0,overheadtotal=0.0,
    				loanrepaytotal=0.0,outflowtotal,surplustotal=0.0,investtotal=0.0,netinvesttotal=0.0,irrtotal=0.0,netprofittotal=0.0,salesprofittotal=0.0,
    				extrainsurperyeartotal=0.0,majorsrvckmtotal=0.0,majorsrvccosttotal=0.0,trackidexptotal=0.0;
    		//System.out.println("========== "+months months+"".split(".")[0]);
    		
//    		select 
    		
    		
    		/*
    		int monthsnumber=(int) months;
    		double monthsdecimal=months-monthsnumber;
    		System.out.println("Month Decimal:"+monthsdecimal+" Month Decimal:"+monthsnumber);
    		
    		if(monthsdecimal>0){
    			monthsnumber+=1;
    		}
    		
    		for(int i=0;i<=monthsnumber;i++){
    			
    			double mnthfac = curmonth  > 12 ? 12  :  curmonth/12;
    			
    		System.out.println("====mnthfac = "+mnthfac+"curmnth = "+curmonth);	
    			curmonth=curmonth-12;
    		}
    		*/
    		double vehiclevalue=Double.parseDouble(purchcost);
    		String strdepr="select coalesce(l.extrainsurperyear,0) extrainsurperyear,coalesce(l.majorsrvckm,0) majorsrvckm,coalesce(l.majorsrvccost,0) majorsrvccost,coalesce(l.trackidexp,0) trackidexp,coalesce(l.dy1,0) depryear1, coalesce(l.dy2,0) depryear2, coalesce(l.dy3,0) depryear3, coalesce(l.dy4,0) depryear4, coalesce(l.dy5,0) depryear5, "+
      " coalesce(l.ins_per,0) insurper,coalesce(l.mininsur,0) mininsur, coalesce(l.srv_km,0) srvkm, coalesce(l.tyrechg_km,0) tyrechangekm,coalesce(l.tyre_cost,0) tyrecost, coalesce(l.maint_cost,0) maintcost, "+
      " coalesce(l.repl_cost,0) replacecost, coalesce(l.carwash_cost,0) carwashcost, coalesce(l.AUH,0) AUH, coalesce(l.DXB,0) DXB, coalesce(l.SHJ,0) SHJ, coalesce(l.FUJ,0) FUJ, "+
      " coalesce(l.RAK,0) RAK from gl_leasecost l left join gl_lcgm lg on l.grpid=lg.grpid where lg.status=3 and lg.doc_no="+grpid;
    		ResultSet rsdepr=stmt.executeQuery(strdepr);
    		while(rsdepr.next()){
    			depryear1=objcommon.Round(rsdepr.getDouble("depryear1"), 2);
    			depryear2=objcommon.Round(rsdepr.getDouble("depryear2"), 2);
    			depryear3=objcommon.Round(rsdepr.getDouble("depryear3"), 2);
    			depryear4=objcommon.Round(rsdepr.getDouble("depryear4"), 2);
    			depryear5=objcommon.Round(rsdepr.getDouble("depryear5"), 2);
    			insurper=objcommon.Round(rsdepr.getDouble("insurper"), 2);
    			mininsur=objcommon.Round(rsdepr.getDouble("mininsur"), 2);
    			extrainsurperyear=objcommon.Round(rsdepr.getDouble("extrainsurperyear"), 2);
    			majorsrvckm=objcommon.Round(rsdepr.getDouble("majorsrvckm"), 2);
    			majorsrvccost=objcommon.Round(rsdepr.getDouble("majorsrvccost"), 2);
    			trackidexp=objcommon.Round(rsdepr.getDouble("trackidexp"), 2);
    			srvkm=objcommon.Round(rsdepr.getDouble("srvkm"), 2);
    			tyrechangekm=objcommon.Round(rsdepr.getDouble("tyrechangekm"), 2);
    			tyrecost=objcommon.Round(rsdepr.getDouble("tyrecost"), 2);
    			maintcost=objcommon.Round(rsdepr.getDouble("maintcost"), 2);
    			replacecost=objcommon.Round(rsdepr.getDouble("replacecost"), 2);
    			carwashcost=objcommon.Round(rsdepr.getDouble("carwashcost"), 2);
    			auhcost=objcommon.Round(rsdepr.getDouble("AUH"), 2);
    			dxbcost=objcommon.Round(rsdepr.getDouble("DXB"), 2);
    			shjcost=objcommon.Round(rsdepr.getDouble("SHJ"), 2);
    			fujcost=objcommon.Round(rsdepr.getDouble("FUJ"), 2);
    			rakcost=objcommon.Round(rsdepr.getDouble("RAK"), 2);
    		}
    		
    		
    		
    		if(!authid.equalsIgnoreCase("")){
				if(authid.equalsIgnoreCase("AUH")){
					regcost=auhcost;
				}
				else if(authid.equalsIgnoreCase("DXB")){
					regcost=dxbcost;
				}
				else if(authid.equalsIgnoreCase("SHJ")){
					regcost=shjcost;
				}
				else if(authid.equalsIgnoreCase("FUJ")){
					regcost=fujcost;
				}
				else if(authid.equalsIgnoreCase("RAK")){
					regcost=rakcost;
				}
				else{
					
				}
			}
    		int curmonth=Integer.parseInt(leasemonths);
    		ArrayList<String> temparray=new ArrayList<>();
    		int i=1;
    		//System.out.println("Total Months:"+curmonth);
    		double mnthfac=0.0;
    		double trackexppermonth=trackidexp/12;
    		while(curmonth>0){
    			/*double mnthfac = curmonth  > 12 ? 12  :  curmonth/12;*/
//    			System.out.println("Monthcalc:"+curmonth);
    			if(curmonth>=12){
    				mnthfac=12;
    			}
    			else{
    				mnthfac=curmonth;
//    				System.out.println("Else:"+curmonth/12);
    			}
//    			System.out.println("Months:"+mnthfac);
    		//	System.out.println("====mnthfac = "+mnthfac+"curmnth = "+curmonth);	
    			
    			if(i==1){
    				
    				carwashcost1=objcommon.Round((Double.parseDouble(kmpermonth)*mnthfac)/srvkm*carwashcost,2);
    				//System.out.println(kmpermonth+"::"+mnthfac+"::"+srvkm+"::"+carwashcost);
    				maintcost1=objcommon.Round((Double.parseDouble(kmpermonth)*mnthfac)/srvkm*maintcost,2);
    				replacecost1=objcommon.Round((Double.parseDouble(kmpermonth)*mnthfac)/srvkm*replacecost,2);
    				tyrecost1=objcommon.Round((Double.parseDouble(kmpermonth)*mnthfac)/tyrechangekm*tyrecost,2);
    				regcost1=objcommon.Round(regcost,2);
    				vehvalueyear1=objcommon.Round(vehiclevalue,2);
        			deprcost1=objcommon.Round(vehiclevalue*(depryear1*0.01),2);
        			insurcost1=objcommon.Round(vehiclevalue*(insurper*0.01),2);
        			if(mininsur>insurcost1){
        				insurcost1=mininsur;
        			}
        			extrainsurperyear1=extrainsurperyear*mnthfac;
        			/*trackidexp1=trackidexp*mnthfac;*/
        			if(mnthfac==12){
        				trackidexp1=trackidexp;
        			}
        			else if(mnthfac<12){
        				trackidexp1=trackexppermonth*mnthfac;
        			}
        			majorsrvccost1=(Double.parseDouble(kmpermonth)*mnthfac)/majorsrvckm*majorsrvccost;
        			/*interestcost1=objcommon.Round(vehvalueyear1*((100-(Double.parseDouble(downpytper)))*0.01)*(Double.parseDouble(interestper))*0.01,2);*/
        			interestcost1=objcommon.Round(vehiclevalue*((100-(Double.parseDouble(downpytper)))*0.01)*(Double.parseDouble(interestper))*0.01,2);
//        			System.out.println(kmpermonth+"::"+mnthfac+"::"+majorsrvckm+"::"+majorsrvccost);
    			}
    			else if(i==2){
    				carwashcost2=objcommon.Round((Double.parseDouble(kmpermonth)*mnthfac)/srvkm*carwashcost,2);
    				maintcost2=objcommon.Round((Double.parseDouble(kmpermonth)*mnthfac)/srvkm*maintcost,2);
    				replacecost2=objcommon.Round((Double.parseDouble(kmpermonth)*mnthfac)/srvkm*replacecost,2);
    				tyrecost2=objcommon.Round((Double.parseDouble(kmpermonth)*mnthfac)/tyrechangekm*tyrecost,2);
    				regcost2=objcommon.Round(regcost,2);
        			vehvalueyear2=objcommon.Round(vehvalueyear1-deprcost1,2);
        			deprcost2=objcommon.Round(vehvalueyear2*(depryear2*0.01),2);
        			insurcost2=objcommon.Round(vehvalueyear2*(insurper*0.01),2);
        			if(mininsur>insurcost2){
        				insurcost2=mininsur;
        			}
        			/*interestcost2=objcommon.Round(vehvalueyear2*((100-(Double.parseDouble(downpytper)))*0.01)*(Double.parseDouble(interestper))*0.01,2);*/
        			interestcost2=objcommon.Round(vehiclevalue*((100-(Double.parseDouble(downpytper)))*0.01)*(Double.parseDouble(interestper))*0.01,2);
        			extrainsurperyear2=extrainsurperyear*mnthfac;
        			/*trackidexp2=trackidexp*mnthfac;*/
        			if(mnthfac==12){
        				trackidexp2=trackidexp;
        			}
        			else if(mnthfac<12){
        				trackidexp2=trackexppermonth*mnthfac;
        			}
        			majorsrvccost2=(Double.parseDouble(kmpermonth)*mnthfac)/majorsrvckm*majorsrvccost;
    			}
    			else if(i==3){
    				carwashcost3=objcommon.Round((Double.parseDouble(kmpermonth)*mnthfac)/srvkm*carwashcost,2);
    				maintcost3=objcommon.Round((Double.parseDouble(kmpermonth)*mnthfac)/srvkm*maintcost,2);
    				replacecost3=objcommon.Round((Double.parseDouble(kmpermonth)*mnthfac)/srvkm*replacecost,2);
    				tyrecost3=objcommon.Round((Double.parseDouble(kmpermonth)*mnthfac)/tyrechangekm*tyrecost,2);
    				regcost3=objcommon.Round(regcost,2);
    				vehvalueyear3=objcommon.Round(vehvalueyear2-deprcost2,2);	
    				deprcost3=objcommon.Round(vehvalueyear3*(depryear3*0.01),2);
    				insurcost3=objcommon.Round(vehvalueyear2*(insurper*0.01),2);
    				if(mininsur>insurcost3){
    					insurcost3=mininsur;
        			}
    				/*interestcost3=objcommon.Round(vehvalueyear3*((100-(Double.parseDouble(downpytper)))*0.01)*(Double.parseDouble(interestper))*0.01,2);*/
    				interestcost3=objcommon.Round(vehiclevalue*((100-(Double.parseDouble(downpytper)))*0.01)*(Double.parseDouble(interestper))*0.01,2);
    				extrainsurperyear3=extrainsurperyear*mnthfac;
        			/*trackidexp3=trackidexp*mnthfac;*/
    				if(mnthfac==12){
    					trackidexp3=trackidexp;
        			}
        			else if(mnthfac<12){
        				trackidexp3=trackexppermonth*mnthfac;
        			}
        			majorsrvccost3=(Double.parseDouble(kmpermonth)*mnthfac)/majorsrvckm*majorsrvccost;
    			}
    			else if(i==4){
    				carwashcost4=objcommon.Round((Double.parseDouble(kmpermonth)*mnthfac)/srvkm*carwashcost,2);
    				maintcost4=objcommon.Round((Double.parseDouble(kmpermonth)*mnthfac)/srvkm*maintcost,2);
    				replacecost4=objcommon.Round((Double.parseDouble(kmpermonth)*mnthfac)/srvkm*replacecost,2);
    				tyrecost4=objcommon.Round((Double.parseDouble(kmpermonth)*mnthfac)/tyrechangekm*tyrecost,2);
    				regcost4=objcommon.Round(regcost,2);
    				vehvalueyear4=objcommon.Round(vehvalueyear3-deprcost3,2);
    				deprcost4=objcommon.Round(vehvalueyear4*(depryear4*0.01),2);
    				insurcost4=objcommon.Round(vehvalueyear2*(insurper*0.01),2);
    				if(mininsur>insurcost4){
    					insurcost4=mininsur;
        			}
    				/*interestcost4=objcommon.Round(vehvalueyear4*((100-(Double.parseDouble(downpytper)))*0.01)*(Double.parseDouble(interestper))*0.01,2);*/
    				interestcost4=objcommon.Round(vehiclevalue*((100-(Double.parseDouble(downpytper)))*0.01)*(Double.parseDouble(interestper))*0.01,2);
    				extrainsurperyear4=extrainsurperyear*mnthfac;
        			/*trackidexp4=trackidexp*mnthfac;*/
    				if(mnthfac==12){
    					trackidexp4=trackidexp;
        			}
        			else if(mnthfac<12){
        				trackidexp4=trackexppermonth*mnthfac;
        			}
    				
        			majorsrvccost4=(Double.parseDouble(kmpermonth)*mnthfac)/majorsrvckm*majorsrvccost;
    			}
    			else if(i==5){
    				carwashcost5=objcommon.Round((Double.parseDouble(kmpermonth)*mnthfac)/srvkm*carwashcost,2);
    				maintcost5=objcommon.Round((Double.parseDouble(kmpermonth)*mnthfac)/srvkm*maintcost,2);
    				replacecost5=objcommon.Round((Double.parseDouble(kmpermonth)*mnthfac)/srvkm*replacecost,2);
    				tyrecost5=objcommon.Round((Double.parseDouble(kmpermonth)*mnthfac)/tyrechangekm*tyrecost,2);
    				regcost5=objcommon.Round(regcost,2);
    				vehvalueyear5=objcommon.Round(vehvalueyear4-deprcost4,2);
    				deprcost5=objcommon.Round(vehvalueyear5*(depryear5*0.01),2);
    				insurcost5=objcommon.Round(vehvalueyear4*(insurper*0.01),2);
    				if(mininsur>insurcost5){
    					insurcost5=mininsur;
        			}
    				/*interestcost5=objcommon.Round(vehvalueyear5*((100-(Double.parseDouble(downpytper)))*0.01)*(Double.parseDouble(interestper))*0.01,2);*/
    				
    				interestcost5=objcommon.Round(vehiclevalue*((100-(Double.parseDouble(downpytper)))*0.01)*(Double.parseDouble(interestper))*0.01,2);
    				extrainsurperyear5=extrainsurperyear*mnthfac;
        			/*trackidexp5=trackidexp*mnthfac;*/
    				if(mnthfac==12){
    					trackidexp5=trackidexp;
        			}
        			else if(mnthfac<12){
        				trackidexp5=trackexppermonth*mnthfac;
        			}
    				
        			majorsrvccost5=(Double.parseDouble(kmpermonth)*mnthfac)/majorsrvckm*majorsrvccost;
    			}
    			
    			curmonth=curmonth-12;
    			i++;
    			
    		}
    			
    			
    			vehvaluetotal=objcommon.Round(vehvalueyear1+vehvalueyear2+vehvalueyear3+vehvalueyear4+vehvalueyear5,2);
    			totalcost1=objcommon.Round(deprcost1+interestcost1+insurcost1+regcost+carwashcost1+maintcost1+replacecost1+tyrecost1+insurcost2+majorsrvccost2+trackidexp2,2);
    			totalcost2=objcommon.Round(deprcost2+interestcost2+insurcost2+regcost+carwashcost2+maintcost2+replacecost2+tyrecost2,2);
    			totalcost3=objcommon.Round(deprcost3+interestcost3+insurcost3+regcost+carwashcost3+maintcost3+replacecost3+tyrecost3,2);
    			totalcost4=objcommon.Round(deprcost4+interestcost4+insurcost4+regcost+carwashcost4+maintcost4+replacecost4+tyrecost4,2);
    			totalcost5=objcommon.Round(deprcost5+interestcost5+insurcost5+regcost+carwashcost5+maintcost5+replacecost5+tyrecost5,2);
    			extrainsurperyeartotal=objcommon.Round(extrainsurperyear1+extrainsurperyear2+extrainsurperyear3+extrainsurperyear4+extrainsurperyear5, 2);
    			majorsrvccosttotal=objcommon.Round(majorsrvccost1+majorsrvccost2+majorsrvccost3+majorsrvccost4+majorsrvccost5,2);
    			trackidexptotal=objcommon.Round(trackidexp1+trackidexp2+trackidexp3+trackidexp4+trackidexp5,2);
    			deprtotalcost=objcommon.Round(deprcost1+deprcost2+deprcost3+deprcost4+deprcost5,2);
    			interesttotalcost=objcommon.Round(interestcost1+interestcost2+interestcost3+interestcost4+interestcost5,2);
    			insurtotalcost=objcommon.Round(insurcost1+insurcost2+insurcost3+insurcost4+insurcost5,2);
    			carwashtotalcost=objcommon.Round(carwashcost1+carwashcost2+carwashcost3+carwashcost4+carwashcost5,2);
    			mainttotalcost=objcommon.Round(maintcost1+maintcost2+maintcost3+maintcost4+maintcost5,2);
    			replacetotalcost=objcommon.Round(replacecost1+replacecost2+replacecost3+replacecost4+replacecost5,2);
    			tyretotalcost=objcommon.Round(tyrecost1+tyrecost2+tyrecost3+tyrecost4+tyrecost5,2);
    			regtotalcost=objcommon.Round(regcost1+regcost2+regcost3+regcost4+regcost5,2);
    			mastertotal=objcommon.Round(deprtotalcost+interesttotalcost+insurtotalcost+carwashtotalcost+mainttotalcost+replacetotalcost+tyretotalcost+(Double.parseDouble(others))+regtotalcost+extrainsurperyeartotal+majorsrvccosttotal+trackidexptotal,2);
    			overheadpertotal=objcommon.Round(mastertotal*((Double.parseDouble(overheadper))*0.01),2);
    			profittotal=objcommon.Round((mastertotal+overheadpertotal)*(Double.parseDouble(profitper)*0.01), 2);
    			rentabletotal=objcommon.Round(mastertotal+overheadpertotal+profittotal, 2);
    			permonthtotal=objcommon.Round(rentabletotal/Integer.parseInt(leasemonths), 2);
    			credittotal=objcommon.Round((permonthtotal*(1+(Double.parseDouble(creditper))*0.01))*Double.parseDouble(creditper)*0.01,2);
    			rentpermonthtotal=objcommon.Round(permonthtotal+credittotal, 2);
    			discounttotal=objcommon.Round(Double.parseDouble(discount), 2);
    			netrentaltotal=objcommon.Round(rentpermonthtotal-discounttotal, 2);
    			rentalcollecttotal=objcommon.Round(netrentaltotal*Double.parseDouble(leasemonths), 2);
    			residualtotal=objcommon.Round(vehiclevalue-deprtotalcost, 2);
    			inflowtotal=objcommon.Round(rentalcollecttotal+residualtotal,2);
    			expensetotal=objcommon.Round(mastertotal-deprtotalcost, 2);
    			overheadtotal=objcommon.Round(overheadpertotal, 2);
    			loanrepaytotal=objcommon.Round(vehiclevalue*(100-(Double.parseDouble(downpytper)))*0.01,2);
    			outflowtotal=objcommon.Round(expensetotal+overheadtotal+loanrepaytotal,2);
    			surplustotal=objcommon.Round((rentalcollecttotal+residualtotal)-(expensetotal+overheadtotal+loanrepaytotal),2);
    			investtotal=objcommon.Round(vehiclevalue*Double.parseDouble(downpytper)*0.01,2);
    			netinvesttotal=objcommon.Round(surplustotal-investtotal, 2);
    			irrtotal=objcommon.Round((netinvesttotal/investtotal)*100, 2);
    			netprofittotal=objcommon.Round(rentalcollecttotal-mastertotal-overheadpertotal, 2);
    			salesprofittotal=objcommon.Round(netprofittotal/rentalcollecttotal, 2);
    			costpermonth=mastertotal/Integer.parseInt(leasemonths);
    			//	status=3;
    			//srno="1";
//    			System.out.println("Major srvc cost:"+majorsrvccosttotal+"::"+majorsrvccost+"::"+majorsrvccost1+"::"+majorsrvccost2+"::"+majorsrvccost3+"::"+majorsrvccost4+"::"+majorsrvccost5);
    			ArrayList<String> finalarray=new ArrayList<>();
    			ResultSet rsdetail=stmt.executeQuery("select doc_no,details from gl_leasecalcdetails where status=3");
    			while(rsdetail.next()){
//    				System.out.println("Details:"+rsdetail.getString("details")+"////");
    				if(rsdetail.getString("details").equalsIgnoreCase("Vehicle Value")){
    					finalarray.add(docno+"::"+leasereqdocno+"::"+srno+"::"+rsdetail.getString("doc_no")+"::"+null+"::"+vehvalueyear1+"::"+vehvalueyear2+"::"+vehvalueyear3+"::"+vehvalueyear4+"::"+vehvalueyear5);
    				}
    				else if(rsdetail.getString("details").equalsIgnoreCase("Depreciation %")){
    					finalarray.add(docno+"::"+leasereqdocno+"::"+srno+"::"+rsdetail.getString("doc_no")+"::"+null+"::"+depryear1+"::"+depryear2+"::"+depryear3+"::"+depryear4+"::"+depryear5);
    				}
    				else if(rsdetail.getString("details").equalsIgnoreCase("Depreciation Cost")){
    					finalarray.add(docno+"::"+leasereqdocno+"::"+srno+"::"+rsdetail.getString("doc_no")+"::"+deprtotalcost+"::"+deprcost1+"::"+deprcost2+"::"+deprcost3+"::"+deprcost4+"::"+deprcost5);
    				}
    				else if(rsdetail.getString("details").equalsIgnoreCase("Bank Interest")){
    					finalarray.add(docno+"::"+leasereqdocno+"::"+srno+"::"+rsdetail.getString("doc_no")+"::"+interesttotalcost+"::"+interestcost1+"::"+interestcost2+"::"+interestcost3+"::"+interestcost4+"::"+interestcost5);
    				}
    				else if(rsdetail.getString("details").equalsIgnoreCase("Insurance")){
    					finalarray.add(docno+"::"+leasereqdocno+"::"+srno+"::"+rsdetail.getString("doc_no")+"::"+insurtotalcost+"::"+insurcost1+"::"+insurcost2+"::"+insurcost3+"::"+insurcost4+"::"+insurcost5);
    				}
    				else if(rsdetail.getString("details").equalsIgnoreCase("Registration Cost")){
    					finalarray.add(docno+"::"+leasereqdocno+"::"+srno+"::"+rsdetail.getString("doc_no")+"::"+regtotalcost+"::"+regcost1+"::"+regcost2+"::"+regcost3+"::"+regcost4+"::"+regcost5);
    				}
    				else if(rsdetail.getString("details").equalsIgnoreCase("Car Wash")){
    					finalarray.add(docno+"::"+leasereqdocno+"::"+srno+"::"+rsdetail.getString("doc_no")+"::"+carwashtotalcost+"::"+carwashcost1+"::"+carwashcost2+"::"+carwashcost3+"::"+carwashcost4+"::"+carwashcost5);
    				}
    				else if(rsdetail.getString("details").equalsIgnoreCase("Maintenance Cost")){
    					finalarray.add(docno+"::"+leasereqdocno+"::"+srno+"::"+rsdetail.getString("doc_no")+"::"+mainttotalcost+"::"+maintcost1+"::"+maintcost2+"::"+maintcost3+"::"+maintcost4+"::"+maintcost5);
    				}
    				else if(rsdetail.getString("details").equalsIgnoreCase("Replacement Cost")){
    					finalarray.add(docno+"::"+leasereqdocno+"::"+srno+"::"+rsdetail.getString("doc_no")+"::"+replacetotalcost+"::"+replacecost1+"::"+replacecost2+"::"+replacecost3+"::"+replacecost4+"::"+replacecost5);
    				}
    				else if(rsdetail.getString("details").equalsIgnoreCase("Tyre Cost")){
    					finalarray.add(docno+"::"+leasereqdocno+"::"+srno+"::"+rsdetail.getString("doc_no")+"::"+tyretotalcost+"::"+tyrecost1+"::"+tyrecost2+"::"+tyrecost3+"::"+tyrecost4+"::"+tyrecost5);
    				}
    				else if(rsdetail.getString("details").equalsIgnoreCase("Others")){
    					finalarray.add(docno+"::"+leasereqdocno+"::"+srno+"::"+rsdetail.getString("doc_no")+"::"+others+"::"+null+"::"+null+"::"+null+"::"+null+"::"+null);
    				}
    				else if(rsdetail.getString("details").equalsIgnoreCase("Total Cost")){
    					finalarray.add(docno+"::"+leasereqdocno+"::"+srno+"::"+rsdetail.getString("doc_no")+"::"+mastertotal+"::"+totalcost1+"::"+totalcost2+"::"+totalcost3+"::"+totalcost4+"::"+totalcost5);
    				}
    				else if(rsdetail.getString("details").equalsIgnoreCase("Cost Per Month")){
    					finalarray.add(docno+"::"+leasereqdocno+"::"+srno+"::"+rsdetail.getString("doc_no")+"::"+costpermonth+"::"+null+"::"+null+"::"+null+"::"+null+"::"+null);
    				}
    				else if(rsdetail.getString("details").equalsIgnoreCase("Overhead %")){
    					finalarray.add(docno+"::"+leasereqdocno+"::"+srno+"::"+rsdetail.getString("doc_no")+"::"+overheadpertotal+"::"+null+"::"+null+"::"+null+"::"+null+"::"+null);
    				}
    				else if(rsdetail.getString("details").equalsIgnoreCase("Profit")){
    					finalarray.add(docno+"::"+leasereqdocno+"::"+srno+"::"+rsdetail.getString("doc_no")+"::"+profittotal+"::"+null+"::"+null+"::"+null+"::"+null+"::"+null);
    				}
    				else if(rsdetail.getString("details").equalsIgnoreCase("Total rentable value")){
    					finalarray.add(docno+"::"+leasereqdocno+"::"+srno+"::"+rsdetail.getString("doc_no")+"::"+rentabletotal+"::"+null+"::"+null+"::"+null+"::"+null+"::"+null);
    				}
    				else if(rsdetail.getString("details").equalsIgnoreCase("Per month")){
    					finalarray.add(docno+"::"+leasereqdocno+"::"+srno+"::"+rsdetail.getString("doc_no")+"::"+permonthtotal+"::"+null+"::"+null+"::"+null+"::"+null+"::"+null);
    				}
    				else if(rsdetail.getString("details").equalsIgnoreCase("Credit card charges")){
    					finalarray.add(docno+"::"+leasereqdocno+"::"+srno+"::"+rsdetail.getString("doc_no")+"::"+credittotal+"::"+null+"::"+null+"::"+null+"::"+null+"::"+null);
    				}
    				else if(rsdetail.getString("details").equalsIgnoreCase("Rental per month")){
    					finalarray.add(docno+"::"+leasereqdocno+"::"+srno+"::"+rsdetail.getString("doc_no")+"::"+rentpermonthtotal+"::"+null+"::"+null+"::"+null+"::"+null+"::"+null);
    				}
    				else if(rsdetail.getString("details").equalsIgnoreCase("Discount")){
    					finalarray.add(docno+"::"+leasereqdocno+"::"+srno+"::"+rsdetail.getString("doc_no")+"::"+discounttotal+"::"+null+"::"+null+"::"+null+"::"+null+"::"+null);
    				}
    				else if(rsdetail.getString("details").equalsIgnoreCase("Net Rental")){
    					finalarray.add(docno+"::"+leasereqdocno+"::"+srno+"::"+rsdetail.getString("doc_no")+"::"+netrentaltotal+"::"+null+"::"+null+"::"+null+"::"+null+"::"+null);
    				}
    				else if(rsdetail.getString("details").equalsIgnoreCase("Rental Collection")){
    					finalarray.add(docno+"::"+leasereqdocno+"::"+srno+"::"+rsdetail.getString("doc_no")+"::"+rentalcollecttotal+"::"+null+"::"+null+"::"+null+"::"+null+"::"+null);
    				}
    				else if(rsdetail.getString("details").equalsIgnoreCase("Residual value")){
    					finalarray.add(docno+"::"+leasereqdocno+"::"+srno+"::"+rsdetail.getString("doc_no")+"::"+residualtotal+"::"+null+"::"+null+"::"+null+"::"+null+"::"+null);
    				}
    				else if(rsdetail.getString("details").equalsIgnoreCase("Cash in flow")){
    					finalarray.add(docno+"::"+leasereqdocno+"::"+srno+"::"+rsdetail.getString("doc_no")+"::"+inflowtotal+"::"+null+"::"+null+"::"+null+"::"+null+"::"+null);
    				}
    				else if(rsdetail.getString("details").equalsIgnoreCase("Expenses")){
    					finalarray.add(docno+"::"+leasereqdocno+"::"+srno+"::"+rsdetail.getString("doc_no")+"::"+expensetotal+"::"+null+"::"+null+"::"+null+"::"+null+"::"+null);
    				}
    				else if(rsdetail.getString("details").equalsIgnoreCase("Over head")){
    					finalarray.add(docno+"::"+leasereqdocno+"::"+srno+"::"+rsdetail.getString("doc_no")+"::"+overheadtotal+"::"+null+"::"+null+"::"+null+"::"+null+"::"+null);
    				}
    				else if(rsdetail.getString("details").equalsIgnoreCase("Loan repayment")){
    					finalarray.add(docno+"::"+leasereqdocno+"::"+srno+"::"+rsdetail.getString("doc_no")+"::"+loanrepaytotal+"::"+null+"::"+null+"::"+null+"::"+null+"::"+null);
    				}
    				else if(rsdetail.getString("details").equalsIgnoreCase("Out flow")){
    					finalarray.add(docno+"::"+leasereqdocno+"::"+srno+"::"+rsdetail.getString("doc_no")+"::"+outflowtotal+"::"+null+"::"+null+"::"+null+"::"+null+"::"+null);
    				}
    				else if(rsdetail.getString("details").equalsIgnoreCase("Surplus/shortage")){
    					finalarray.add(docno+"::"+leasereqdocno+"::"+srno+"::"+rsdetail.getString("doc_no")+"::"+surplustotal+"::"+null+"::"+null+"::"+null+"::"+null+"::"+null);
    				}
    				else if(rsdetail.getString("details").equalsIgnoreCase("Investment")){
    					finalarray.add(docno+"::"+leasereqdocno+"::"+srno+"::"+rsdetail.getString("doc_no")+"::"+investtotal+"::"+null+"::"+null+"::"+null+"::"+null+"::"+null);
    				}
    				else if(rsdetail.getString("details").equalsIgnoreCase("Net flow on investment")){
    					finalarray.add(docno+"::"+leasereqdocno+"::"+srno+"::"+rsdetail.getString("doc_no")+"::"+netinvesttotal+"::"+null+"::"+null+"::"+null+"::"+null+"::"+null);
    				}
    				else if(rsdetail.getString("details").equalsIgnoreCase("IRR")){
    					finalarray.add(docno+"::"+leasereqdocno+"::"+srno+"::"+rsdetail.getString("doc_no")+"::"+irrtotal+"::"+null+"::"+null+"::"+null+"::"+null+"::"+null);
    				}
    				else if(rsdetail.getString("details").equalsIgnoreCase("Net Profit")){
    					finalarray.add(docno+"::"+leasereqdocno+"::"+srno+"::"+rsdetail.getString("doc_no")+"::"+netprofittotal+"::"+null+"::"+null+"::"+null+"::"+null+"::"+null);
    				}
    				else if(rsdetail.getString("details").equalsIgnoreCase("Profit % on sales")){
    					finalarray.add(docno+"::"+leasereqdocno+"::"+srno+"::"+rsdetail.getString("doc_no")+"::"+salesprofittotal+"::"+null+"::"+null+"::"+null+"::"+null+"::"+null);
    				}
    				else if(rsdetail.getString("details").equalsIgnoreCase("Ext. Insurance Cost")){
    					finalarray.add(docno+"::"+leasereqdocno+"::"+srno+"::"+rsdetail.getString("doc_no")+"::"+extrainsurperyeartotal+"::"+extrainsurperyear1+"::"+extrainsurperyear2+"::"+extrainsurperyear3+"::"+extrainsurperyear4+"::"+extrainsurperyear5);
    				}
    				else if(rsdetail.getString("details").equalsIgnoreCase("Major Services Cost")){
    					finalarray.add(docno+"::"+leasereqdocno+"::"+srno+"::"+rsdetail.getString("doc_no")+"::"+majorsrvccosttotal+"::"+majorsrvccost1+"::"+majorsrvccost2+"::"+majorsrvccost3+"::"+majorsrvccost4+"::"+majorsrvccost5);
    				}
    				else if(rsdetail.getString("details").equalsIgnoreCase("Tracking ID Expense")){
    					finalarray.add(docno+"::"+leasereqdocno+"::"+srno+"::"+rsdetail.getString("doc_no")+"::"+trackidexptotal+"::"+trackidexp1+"::"+trackidexp2+"::"+trackidexp3+"::"+trackidexp4+"::"+trackidexp5);
    				}
    				
    				
    			}
    			
    			
    			int val=arrayInsert(finalarray,conn,docno,leasereqdocno,srno);
    			String strgetGridDetails="select rdocno,leasereqdocno,srno,detaildocno,det.flow,det.details,amount totalamount,amount1,amount2,amount3,amount4,amount5 "+
    			" from gl_leasecalcd cd left join gl_leasecalcdetails det on cd.detaildocno=det.doc_no where cd.rdocno="+docno+" and cd.leasereqdocno="+leasereqdocno+""+
    			" and cd.srno="+srno+" and cd.status=3";
    			ResultSet rsgriddetails=stmt.executeQuery(strgetGridDetails);
    			RESULTDATA=objcommon.convertToJSON(rsgriddetails);
    	}
    	catch(Exception e){
    		e.printStackTrace();
    	}
    	finally{
    		conn.close();
    	}
    	return RESULTDATA;
    }
	private int arrayInsert(ArrayList<String> finalarray, Connection conn,String docno,String leasereqdocno,String srno) {
		// TODO Auto-generated method stub
		int value=0;
		try{
			Statement stmt=conn.createStatement();
			conn.setAutoCommit(false);
			int val=stmt.executeUpdate("delete from gl_leasecalcd where rdocno="+docno+" and leasereqdocno="+leasereqdocno+" and srno="+srno);
			for(int i=0;i<finalarray.size();i++){
				String temp[]=finalarray.get(i).split("::");
			//System.out.println(temp[0]+","+temp[1]+","+temp[2]+","+temp[3]+","+temp[4]+","+temp[5]+","+temp[6]+","+temp[7]+","+temp[8]+","+temp[9]);
			String strinsert="insert into gl_leasecalcd(rdocno, leasereqdocno, srno, detaildocno, amount, amount1, amount2, amount3, amount4, amount5, status)"+
			" values("+temp[0]+","+temp[1]+","+temp[2]+","+temp[3]+","+temp[4]+","+temp[5]+","+temp[6]+","+temp[7]+","+temp[8]+","+temp[9]+",3)";
			System.out.println(strinsert);
			value=stmt.executeUpdate(strinsert);
			if(value<=0){
				return 0;
			}
		
			}
			conn.commit();
		}
		catch(Exception e){
			e.printStackTrace();
			return 0;
		}
		
		return value;
	}

	
	
    public JSONArray getCalculateView(String docno,String leasereqdocno,String srno,String id) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        if(!id.equalsIgnoreCase("2")){
        	return RESULTDATA;
        }
        Connection conn = null;
		try {
				conn = objconn.getMyConnection();
				Statement stmt=conn.createStatement();
            	
				ResultSet resultSet = stmt.executeQuery ("select rdocno,leasereqdocno,srno,detaildocno,det.flow,det.details,amount totalamount,amount1,amount2,amount3,amount4,amount5 "+
    			" from gl_leasecalcd cd left join gl_leasecalcdetails det on cd.detaildocno=det.doc_no where cd.rdocno="+docno+" and cd.leasereqdocno="+leasereqdocno+""+
    			" and cd.srno="+srno+" and cd.status=3");
				RESULTDATA=objcommon.convertToJSON(resultSet);
				stmt.close();
		}catch(Exception e){
			e.printStackTrace();
			return RESULTDATA;
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }

    public int insert(Date sqldate, String hidleasereqdoc,
			ArrayList<String> reqarray, HttpSession session,String brchName,String mode,String formdetailcode) throws SQLException {
		// TODO Auto-generated method stub
		
		Connection conn=null;
		int val=0;
		try{
			conn=objconn.getMyConnection();
			conn.setAutoCommit(false);
			CallableStatement stmtReq = conn.prepareCall("{call leaseCalcDML(?,?,?,?,?,?,?)}");
			stmtReq.registerOutParameter(3, java.sql.Types.INTEGER);
			stmtReq.setDate(1,sqldate);
			stmtReq.setString(2, hidleasereqdoc);
			stmtReq.setString(4, brchName);
			stmtReq.setString(5, session.getAttribute("USERID").toString());
			stmtReq.setString(6, mode);
			stmtReq.setString(7, formdetailcode);
			stmtReq.executeQuery();
			val=stmtReq.getInt("docNo");
			System.out.println("Doc No:"+val);
			if(val<=0){
				return 0;
			}
			int reqval=reqinsert(reqarray,hidleasereqdoc,val,conn);
			System.out.println("Req Val"+reqval);
			if(reqval<=0){
				return 0;
			}
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

	private int reqinsert(ArrayList<String> reqarray, String hidleasereqdoc,int val,Connection conn) {
		// TODO Auto-generated method stub
		int reqval=0;
		try{
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
				String strsql="insert into gl_leasecalcreq(rdocno,leasereqdocno,leasefromdate,brdid,modid,spec,clrid,leasemonths,kmpermonth,grpid,status)values("+val+","+
				hidleasereqdoc+",'"+sqlfromdate+"',"+brdid+","+modelid+",'"+spec+"',"+clrid+","+leasemonths+","+kmpermonth+","+grpid+",3)";
				//System.out.println("Req Insert Query:"+strsql);
				reqval=stmt.executeUpdate(strsql);
				if(reqval<=0){
					return 0;
				}
			}
			
		}
		catch(Exception e){
			e.printStackTrace();
			return 0;
		}
		return reqval;
		
	}

	public ClsLeaseCalculatorBean getPrint(String docno, HttpServletRequest request) throws SQLException {
		// TODO Auto-generated method stub
	ClsLeaseCalculatorBean bean=new ClsLeaseCalculatorBean();
	Connection conn=null;
	try{
		conn=objconn.getMyConnection();
		Statement stmt=conn.createStatement();
		
		String strsql="select m.doc_no docno,m.reqdoc,DATE_FORMAT(m.date,'%d/%m/%Y') date,comp.company,comp.address,comp.tel,comp.fax from gl_leasecalcm m "+
		" left join my_brch br on m.brhid=br.doc_no left join my_comp comp on br.cmpid=comp.doc_no where m.status=3 and m.doc_no="+docno;
		ResultSet rs=stmt.executeQuery(strsql);
		while(rs.next()){
			bean.setLbldate(rs.getString("date"));
			bean.setLbldocno(rs.getString("docno"));
			bean.setLblleasereqdocno(rs.getString("reqdoc"));
			bean.setLblcompname(rs.getString("company"));
			bean.setLblcompaddress(rs.getString("address"));
			bean.setLblcompfax(rs.getString("fax"));
			bean.setLblcomptel(rs.getString("tel"));
			
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
			String str="select srno,det.details,coalesce(round(amount,2),'') amount,coalesce(round(amount1,2),'') amount1,coalesce(round(amount2,2),'') amount2,"+
			" coalesce(round(amount3,2),'') amount3,coalesce(round(amount4,2),'') amount4,coalesce(round(amount5,2),'') amount5 from gl_leasecalcd"+
			" d left join gl_leasecalcdetails det on (d.detaildocno=det.doc_no) where rdocno="+docno;
			ResultSet rsdet=stmt.executeQuery(str);
			int i=0;
			int tempsrno=0;
			while (rsdet.next()) {
				i++;
				if(tempsrno!=rsdet.getInt("srno")){
					i=1;
				}
				reqdetailarray.add(rsdet.getString("srno")+" :: "+rsdet.getString("details")+" :: "+rsdet.getString("amount")+" :: "+rsdet.getString("amount1")+" :: "+rsdet.getString("amount2")+" :: "+rsdet.getString("amount3")+" :: "+rsdet.getString("amount4")+" :: "+rsdet.getString("amount5"));
				tempsrno=rsdet.getInt("srno");
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
			String str="select req.savestatus,req.srno,req.rdocno,coalesce(DATE_FORMAT(req.leasefromdate,'%d/%m/%Y'),'') leasefromdate,coalesce(brd.brand_name,'') brand,"+
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
				reqarray.add(rsreq.getString("srno")+" :: "+rsreq.getString("rdocno")+" :: "+i+" :: "+rsreq.getString("leasefromdate")+" :: "+rsreq.getString("brand")+" :: "+rsreq.getString("model")+" :: "+rsreq.getString("spec")+" :: "+
				rsreq.getString("color")+" :: "+rsreq.getString("leasemonths")+" :: "+rsreq.getString("kmpermonth")+" :: "+rsreq.getString("gname")+" :: "+rsreq.getString("totalvalue")+" :: "+rsreq.getString("savestatus")+" :: "+
				"Dealer :: Purchase Cost :: Down payment % :: Interest % :: Credit card % :: Authority :: Profit % :: Overhead % :: Others :: Discount :: "+rsreq.getString("vendor")+" :: "+rsreq.getString("prchcost")+" :: "+rsreq.getString("downpytper")+" :: "+rsreq.getString("interestper")+" :: "+
				rsreq.getString("creditper")+" :: "+rsreq.getString("auth")+" :: "+rsreq.getString("profitper")+" :: "+rsreq.getString("overheadper")+" :: "+rsreq.getString("others")+" :: "+rsreq.getString("discount"));
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



	 public   ClsLeaseCalculatorBean getPrintQot(int docno, HttpServletRequest request) throws SQLException {
		 ClsLeaseCalculatorBean bean = new ClsLeaseCalculatorBean();
		  Connection conn = null;
		try {
				 conn = objconn.getMyConnection();
				Statement stmtprint = conn.createStatement ();
	        	
				String resql=("select q.voc_no,coalesce(q.glterms,'') glterms, q.DOC_NO,DATE_FORMAT(q.DATE,'%d-%m-%Y') DATE , q.REF_NO, "
						+ "if(q.REF_TYPE='DIR','Direct',concat('Enquiry ','(',q.REF_NO,')')) type,q.CONTACT_NO mob ,if(q.REF_TYPE='DIR',a.refname,e.name) name, "
						+ "if(q.REF_TYPE='DIR',a.address,e.com_add1) com_add1,if(q.REF_TYPE='DIR',a.per_mob,e.mob) mob,if(q.REF_TYPE='DIR',a.mail1,e.email) email from "
						+ "   gl_quotm q left join gl_qenq d on d.rdocno=q.doc_no   left join gl_enqm e on e.doc_no=q.ref_no left join my_acbook a  "
						+ "on a.cldocno=q.cldocno and a.dtype='CRM'   where q.DOC_NO="+docno+" ");
				
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
					 Statement stmtinvoice10 = conn.createStatement ();
				  String  companysql="select c.company,c.address,c.tel,c.fax,lc.loc_name location,b.branchname,b.pbno,b.stcno,b.cstno from gl_quotm r inner join my_brch b on  "
				    		+ "r.branch=b.doc_no inner join my_comp c on b.cmpid=c.doc_no inner join my_locm l on l.brhid=b.doc_no inner join (select min(lo.loc) loc,lo.loc_name, "
				    		+ " lo.brhid from my_locm lo group by brhid) as lc on(lc.loc=l.loc and lc.brhid=b.doc_no) where r.doc_no='"+docno+"' ";
                      //System.out.println("--------"+companysql);

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
					
						
					    
						String strSqldetail="select @i:=1 srno, req.leasefromdate,brd.brand_name,req.spec spec,\r\n" + 
								"brand,model.vtype model,clr.color,req.leasemonths,req.kmpermonth,grp.gname,\r\n" + 
								"coalesce(req.totalvalue,'') totalvalue from gl_leasecalcreq req left join gl_vehbrand brd on req.brdid=brd.doc_no left join gl_vehmodel model on\r\n" + 
								"req.modid=model.doc_no left join my_color clr on req.clrid=clr.doc_no left join gl_lcgm lcg on (req.brdid=req.brdid and req.modid=lcg.modid) left join\r\n" + 
								"gl_vehgroup grp on (lcg.grpid=grp.doc_no) left join my_vendorm vnd on (req.dealerid=vnd.doc_no) left join gl_vehauth auth on\r\n" + 
								"(req.authid=auth.doc_no)where req.status=3 and req.rdocno="+docno;
				
			
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
				        	
							String resql1=("select voc_no,l.date,coalesce(refname,name) refname, coalesce(address,com_add1) address, "
									+ "coalesce(per_mob,mob) per_mob, coalesce(mail1,email) mail1 from  gl_leasecalcm l left join gl_lprm l1 on reqdoc=l1.voc_no\r\n" + 
									"									left join my_acbook a on a.doc_no=l1.cldocno and a.dtype='CRM' where l.doc_no="+docno+" ");
							
					//	System.out.println("----"+resql1);
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









}
