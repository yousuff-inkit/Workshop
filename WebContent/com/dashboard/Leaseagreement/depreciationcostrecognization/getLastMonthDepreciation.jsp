<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.*"%>
<%	
	Connection conn = null;

	try{
		ClsCommon commonDAO = new ClsCommon();
		ClsConnection connDAO = new ClsConnection();
		conn = connDAO.getMyConnection();
		Statement stmt = conn.createStatement();
		String deprDate="0";
		String dateDiff="0";
		java.sql.Date sqlDate=null;
		String dates="",dated="",deprDates="",deprDated="",lastDeprDates="";
		int days=0,dateCheck=0,noofdays=0;
		
		String date=request.getParameter("date");
		String branch=request.getParameter("branch");
		
	    if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0"))){
		     sqlDate=commonDAO.changeStringtoSqlDate(date);
		}
	    
		String sql = "select DATEDIFF(LAST_DAY('"+sqlDate+"'),'"+sqlDate+"') diff";
		ResultSet rs1 = stmt.executeQuery(sql);
		
		while(rs1.next()) {
			dateDiff=rs1.getString("diff");
		} 
		
		/* String sqls = "select DATE_FORMAT(min(date),'%d-%m-%Y') deprdates from (select v.depr_date date from gl_vehmaster v left join gc_assettran g on " 
				+ "v.fleet_no=g.fleet_no where v.fstatus<>'Z' and v.statu=3 and v.depr_date is not null and v.brhid='"+branch+"' group by v.fleet_no having "
		        + " sum(g.dramount)>0 order by depr_date) a"; */

		        String sqls = "select DATE_FORMAT(min(date),'%d-%m-%Y') deprdates from (select v.depr_date date,if(l.per_name=1,DATE_ADD(l.outdate,INTERVAL l.per_value YEAR),DATE_ADD(l.outdate,INTERVAL l.per_value MONTH)) leasetodate from gl_vehmaster v " 
		        		+ " inner join gl_lagmt l on v.fleet_no=l.perfleet and l.clstatus=0 " 
						+ " where v.fstatus<>'Z' and v.statu=3 and v.depr_date is not null and l.brhid='"+branch+"' UNION ALL"
								+ " select v.depr_date date,s.todate leasetodate from gl_stockvehicles s "
								+ " left join gl_vehmaster v on v.fleet_no=s.fleet_no where s.status=3 and v.stockrelease=1 and s.vehreturnstatus=0 order by date ) a where leasetodate > last_day(date_sub('"+sqlDate+"',INTERVAL 1 MONTH)) ";
		 System.out.println(" ===== 1 == "+sqls);
		        ResultSet rs2 = stmt.executeQuery(sqls);
		
		while(rs2.next()) {
			deprDates=rs2.getString("deprdates");
		}
		
		if(dateDiff.equalsIgnoreCase("0")){

/* 		   String strSql = "select v.fleet_no,v.depr_date deprdate,DATEDIFF(last_day('"+sqlDate+"'),min(v.depr_date)) deprDiff,(DATEDIFF(last_day('"+sqlDate+"'),"
		    		 + "min(v.depr_date))) dateDiff,DAY(LAST_DAY('"+sqlDate+"')) noofdays from gl_vehmaster v left join gc_assettran g on v.fleet_no=g.fleet_no where "
		    		 + "v.fstatus<>'Z' and v.statu=3 and v.depr_date is not null and v.brhid='"+branch+"' group by v.fleet_no having sum(g.dramount)>0 order by depr_date";
 */

			 		   String strSql = "select * from (select v.fleet_no,v.depr_date deprdate,DATEDIFF(last_day('"+sqlDate+"'),min(v.depr_date)) deprDiff,(DATEDIFF(last_day('"+sqlDate+"'),"
			 + "min(v.depr_date))) dateDiff,DAY(LAST_DAY('"+sqlDate+"')) noofdays,leasetodate from gl_vehmaster v inner join (select if(l.per_name=1,DATE_ADD(l.outdate,INTERVAL l.per_value YEAR), "
			 +" DATE_ADD(l.outdate,INTERVAL l.per_value MONTH)) leasetodate,perfleet from gl_lagmt l where  l.clstatus=0 and l.brhid='"+branch+"' UNION ALL select s.todate  date,s.fleet_no  from gl_stockvehicles s  left join gl_vehmaster v on v.fleet_no=s.fleet_no where s.status=3 and v.stockrelease=1 and s.vehreturnstatus=0) l on v.fleet_no=l.perfleet where "
			 + "v.fstatus<>'Z' and v.statu=3 and v.depr_date is not null and leasetodate > last_day(date_sub('"+sqlDate+"',INTERVAL 1 MONTH)) order by depr_date) a ";

			 System.out.println(" ===== 2 == "+strSql);
			ResultSet rs = stmt.executeQuery(strSql);
			
			while(rs.next()) {
				deprDated=rs.getString("deprDiff");
				dates=rs.getString("deprdate");
				dateCheck=rs.getInt("dateDiff");
				noofdays=rs.getInt("noofdays");
				
				if(dateCheck>noofdays){
					deprDate="0";
					dateDiff="0";
					break;					
				}
				
				if(dateCheck>0 && dateCheck<=noofdays){
					deprDate="1";
					dateDiff="0";
					break;
				}
				
				if(dateCheck<=0 && !(deprDate=="1") && !(dateDiff=="0")){
					deprDate="2";
					dateDiff="0";
				}
			}	
		}else{
		        dateDiff="2";
	    }
		
		response.getWriter().write(deprDate+"***"+dateDiff+"***"+deprDates);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  