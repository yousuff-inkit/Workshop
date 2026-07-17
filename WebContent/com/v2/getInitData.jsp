<%@page import="net.sf.json.JSONArray"%>
<%@page import="com.common.ClsCommon"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="com.dashboard.*"%>
<%@page import="java.sql.*"%>

<%
	
	JSONObject data=new JSONObject();
	JSONObject fleetdistdata=new JSONObject();
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	JSONObject objdata=new JSONObject();
	Connection conn=null;
	try{
		conn=objconn.getMyConnection();
		Statement stmt=conn.createStatement();
		
		String strgetbranch="select branchname name,doc_no docno from my_brch where status=3";
		ResultSet rsgetbranch=stmt.executeQuery(strgetbranch);
		JSONArray brancharray=new JSONArray();
		while(rsgetbranch.next()){
			JSONObject objtemp=new JSONObject();
			objtemp.put("docno",rsgetbranch.getString("docno"));
			objtemp.put("name",rsgetbranch.getString("name"));
			brancharray.add(objtemp);
		}
		objdata.put("branchdata",brancharray);
		/* String strgetoccupancy="select (select count(*) from gl_vehmaster where statu=3 and fstatus in ('L','I')) totalcount,"+
		" (select count(*) from gl_vehmaster where statu=3 and fstatus in ('L','I') and tran_code in ('RA','LA')) agmtcount,"+
		" (select count(*) from gl_vehmaster where statu=3 and fstatus in ('L','I') and tran_code in ('GA','GS','GM','FS','NR')) availcount,"+
		" (select count(*) from gl_vehmaster where statu=3 and fstatus in ('L','I') and tran_code in ('GA','GS','GM')) garagecount,"+
		" (select count(*) from gl_vehmaster where statu=3 and fstatus in ('L','I') and tran_code in ('UR')) unrentablelcount";
		System.out.println(strgetoccupancy);
		double totalcount=0,agmtcount=0,availtempcount=0,unrentablelcount=0,garagecount=0;
		ResultSet rsgetoccupancy=stmt.executeQuery(strgetoccupancy);
		while(rsgetoccupancy.next()){
			totalcount=rsgetoccupancy.getDouble("totalcount");
			agmtcount=rsgetoccupancy.getDouble("agmtcount");
			availtempcount=rsgetoccupancy.getDouble("availcount");
			garagecount=rsgetoccupancy.getDouble("garagecount");
			unrentablelcount=rsgetoccupancy.getDouble("unrentablelcount");
		}
		System.out.println(totalcount+"::"+agmtcount+"::"+availtempcount+"::"+garagecount+"::"+unrentablelcount);
		objdata.put("occtotal",objcommon.Round(((agmtcount/totalcount)*100), 2));
		objdata.put("occavail",objcommon.Round(((agmtcount/(totalcount-availtempcount))*100), 2));
		objdata.put("occgarage",objcommon.Round(((garagecount/totalcount)*100), 2));
		objdata.put("occunrentable",objcommon.Round(((unrentablelcount/totalcount)*100), 2));
		
		String stragmtcount="select (select count(*) from gl_ragmt agmt left join gl_rtarif rtf on (agmt.doc_no=rtf.rdocno) where status=3 and clstatus=0 and rtf.rstatus=5 and rtf.rentaltype='Daily') dailycount,"+
		" (select count(*) from gl_ragmt agmt left join gl_rtarif rtf on (agmt.doc_no=rtf.rdocno) where status=3 and clstatus=0 and rtf.rstatus=5 and rtf.rentaltype='Weekly') weeklycount,"+
		" (select count(*) from gl_ragmt agmt left join gl_rtarif rtf on (agmt.doc_no=rtf.rdocno) where status=3 and clstatus=0 and rtf.rstatus=5 and rtf.rentaltype='Monthly') monthlycount,"+
		" (select count(*) from gl_lagmt agmt  where status=3 and clstatus=0) leasecount";
		System.out.println(stragmtcount);
		ResultSet rsagmtcount=stmt.executeQuery(stragmtcount);
		int dailycount=0,weeklycount=0,monthlycount=0,leasecount=0;
		while(rsagmtcount.next()){
			dailycount=rsagmtcount.getInt("dailycount");
			weeklycount=rsagmtcount.getInt("weeklycount");
			monthlycount=rsagmtcount.getInt("monthlycount");
			leasecount=rsagmtcount.getInt("leasecount");
		}
		/* String strgetclients="select coalesce(sal.sal_name,'') salesman,coalesce(cat.cat_name,'') category,if(ac.date between date_sub(curdate(),interval 1"+
		" month) and curdate(),1,0) newstatus,if(ac.date<date_sub(curdate(),interval 1 month),1,0) oldstatus,if(ac.rostatus>0 or"+
		" ac.lostatus>0,1,0) active,if(ac.rostatus<=0 and ac.lostatus<=0,1,0) inactive from my_acbook ac left join my_salm sal on ac.sal_id=sal.doc_no left join"+
		" my_clcatm cat on ac.catid=cat.doc_no where ac.status=3 limit 100"; 
		
		String strgetclientssalesmanwise="select coalesce(sal.sal_name,'') salesman,coalesce(cat.cat_name,'') category,sum(if(ac.date between date_sub(curdate(),interval 1"+
		" month) and curdate(),1,0)) newstatus,sum(if(ac.date<date_sub(curdate(),interval 1 month),1,0)) oldstatus,sum(if(ac.rostatus>0 or"+
		" ac.lostatus>0,1,0)) active,sum(if(ac.rostatus<=0 and ac.lostatus<=0,1,0)) inactive from my_acbook ac left join my_salm sal on ac.sal_id=sal.doc_no left join"+
		" my_clcatm cat on ac.catid=cat.doc_no where ac.status=3 group by sal.doc_no";
		ResultSet rsgetclientssalesmanwise=stmt.executeQuery(strgetclientssalesmanwise);
		JSONArray clientarraysalesmanwise=new JSONArray();
		while(rsgetclientssalesmanwise.next()){
			JSONObject objtemp=new JSONObject();
			objtemp.put("salesman",rsgetclientssalesmanwise.getString("salesman"));
			objtemp.put("category",rsgetclientssalesmanwise.getString("category"));
			objtemp.put("newstatus",rsgetclientssalesmanwise.getString("newstatus"));
			objtemp.put("oldstatus",rsgetclientssalesmanwise.getString("oldstatus"));
			objtemp.put("active",rsgetclientssalesmanwise.getString("active"));
			objtemp.put("inactive",rsgetclientssalesmanwise.getString("inactive"));
			clientarraysalesmanwise.add(objtemp);
		}
		
		String strgetclientscategorywise="select coalesce(sal.sal_name,'') salesman,coalesce(cat.cat_name,'') category,sum(if(ac.date between date_sub(curdate(),interval 1"+
		" month) and curdate(),1,0)) newstatus,sum(if(ac.date<date_sub(curdate(),interval 1 month),1,0)) oldstatus,sum(if(ac.rostatus>0 or"+
		" ac.lostatus>0,1,0)) active,sum(if(ac.rostatus<=0 and ac.lostatus<=0,1,0)) inactive from my_acbook ac left join my_salm sal on ac.sal_id=sal.doc_no left join"+
		" my_clcatm cat on ac.catid=cat.doc_no where ac.status=3 group by cat.doc_no";
		ResultSet rsgetclientscategorywise=stmt.executeQuery(strgetclientscategorywise);
		JSONArray clientarraycategorywise=new JSONArray();
		while(rsgetclientscategorywise.next()){
			JSONObject objtemp=new JSONObject();
			objtemp.put("salesman",rsgetclientscategorywise.getString("salesman"));
			objtemp.put("category",rsgetclientscategorywise.getString("category"));
			objtemp.put("newstatus",rsgetclientscategorywise.getString("newstatus"));
			objtemp.put("oldstatus",rsgetclientscategorywise.getString("oldstatus"));
			objtemp.put("active",rsgetclientscategorywise.getString("active"));
			objtemp.put("inactive",rsgetclientscategorywise.getString("inactive"));
			clientarraycategorywise.add(objtemp);
		}
		
		java.sql.Date sqlfleetutilizefromdate=null;
		java.sql.Date sqlfleetutilizetodate=null;
		String strmisc="select curdate() basedate,date_sub(curdate(),interval 10 day) lasttendays";
		ResultSet rsmisc=stmt.executeQuery(strmisc);
		while(rsmisc.next()){
			sqlfleetutilizefromdate=rsmisc.getDate("lasttendays");
			sqlfleetutilizetodate=rsmisc.getDate("basedate");
		}
		
		objdata.put("agmtdailycount",dailycount);
		objdata.put("agmtweeklycount",weeklycount);
		objdata.put("agmtmonthlycount",monthlycount);
		objdata.put("agmtleasecount",leasecount);
		objdata.put("clientdataarraysalesmanwise",clientarraysalesmanwise);
		objdata.put("clientdataarraycategorywise",clientarraycategorywise); */ 
		
	}
	catch(Exception e){
		e.printStackTrace();
		conn.close();
	}
	finally{
		conn.close();
	}
	
	response.getWriter().write(objdata.toString());
%>