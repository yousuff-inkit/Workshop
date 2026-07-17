<%@page import="net.sf.json.JSONArray"%>
<%@page import="com.google.gson.JsonArray"%>
<%@page import="com.dashboard.accounts.ageingstatement.ClsAgeingStatementDAO"%>
<%@page import="com.common.ClsCommon"%>
<%@page import="com.dashboard.accounts.ageingstatement.ClsAgeingStatementBean"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String atype = request.getParameter("atype");
int acno=Integer.parseInt(request.getParameter("acno"));
String branch = request.getParameter("branch");
String uptoDate = request.getParameter("uptoDate");
Connection conn=null;
String result="",lblprintname="",sqld="",sqld1="",sqlAgeing="",sqlbrch="";
String sqlOutStandingpal = "";
Date sqlUpToDate=null;
JSONArray det=new JSONArray();
try{
	ClsCommon commonDAO=new ClsCommon();
	ClsConnection connect=new ClsConnection();
	conn=connect.getMyConnection();
	String joins=commonDAO.getFinanceVocTablesJoins(conn);
	String casestatement=commonDAO.getFinanceVocTablesCase(conn);
	if(!(uptoDate.equalsIgnoreCase("undefined")) && !(uptoDate.equalsIgnoreCase("")) && !(uptoDate.equalsIgnoreCase("0"))){
		sqlUpToDate = commonDAO.changeStringtoSqlDate(uptoDate);
    }
	  if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
			sqlAgeing+=" and j.brhId="+branch+"";
			sqlbrch=" and j.brhId="+branch+"";
			
		}
	  
	  if(atype.equalsIgnoreCase("AR")){
			sqld=" and j.id < 0";
			sqld1=" and j.id > 0";
			sqlOutStandingpal = "select a.transno DocNo,branchname,  regno , claimno,vehtype,  date, transType Dtype, ref_detail, description, netamount, applied, balance, duedys,  @running_total:=@running_total + balance as runtot from "
					+ "(select "+casestatement+" coalesce(invd.regno,opn.regno) regno ,coalesce(invd.claimno,opn.claimno) claimno,a.date,a.transType,a.ref_detail,a.branchname,a.description,round(a.netamount,2) netamount,round(a.applied,2) applied,round(a.balance,2) balance,a.duedys,a.brhid,coalesce(invd.vtype,opn.flname)  vehtype from ("
					+ "select j.doc_no transNo,coalesce(j.ref_detail,'') ref_detail,j.description, j.date sqldate,DATE_FORMAT((j.date),'%d-%m-%Y') date,j.dtype transType,round(sum(j.dramount)*j.id,2) netamount,round(coalesce(o.amount,0),2) applied," 
					+ "round((sum(dramount) - coalesce(o.amount,0)*id)*j.id,2) balance,b.branchname,TIMESTAMPDIFF(Day,cast(j.date as datetime),cast('"+sqlUpToDate+"' as datetime)) duedys,j.brhid from my_jvtran j inner join my_head h "
					+ "on j.acno=h.doc_no left join (select ap_trid,o.tranid,sum(coalesce(amount,0)) amount from my_outd o inner join my_jvtran j on j.tranid=o.trANid where j.date<='"+sqlUpToDate+"' group by AP_trid) o on "
					+ "j.tranid=o.ap_trid inner join my_brch b on j.brhId=b.doc_no where j.status=3 and h.atype='"+atype+"' and j.acno="+acno+" and j.date<='"+sqlUpToDate+"'"+sqld1+" "+sqlbrch+"  group by j.tranid having balance<>0 order by j.date,j.doc_no) a"+joins+" "
					+ " left join (select invno,group_concat(invd.regno) regno,group_concat(distinct invd.claimno) claimno,group_concat(concat(brd.brand_name,' ',model.vtype)) vtype from ws_invcalctemp invd  left join ws_jobcard j on j.doc_no=invd.jobdocno left join ws_estm e on e.doc_no=j.refno and j.reftype='EST' left join ws_gateinpass g on g.doc_no=e.gipno left join gl_vehbrand brd on g.brdid=brd.doc_no left join gl_vehmodel model on g.modid=model.doc_no group by invno ) invd on invd.invno=mnt.doc_no  left join ws_opndetails opn on (a.transno=opn.rdocno and a.brhid=opn.brhid and a.transType in ('OPN')) order by a.sqldate,transNo)a,(SELECT @running_total:=0) r";

	  }
	  else if(atype.equalsIgnoreCase("AP")){
			sqld=" and j.id > 0";
			sqld1=" and j.id < 0";
			sqlOutStandingpal = "select  a.transno DocNo,branchname,  date, transType dtype, ref_detail, description, netamount, applied, balance, duedys, round(@running_total:=@running_total + balance,2) as runtot  from (select "+casestatement+"a.date,a.transType,a.ref_detail,a.branchname,a.description,round(a.netamount,2) netamount,round(a.applied,2) applied,round(a.balance,2) balance,a.duedys,a.brhid from ("
					+ "select j.doc_no transNo,coalesce(j.ref_detail,'') ref_detail,j.description,DATE_FORMAT((j.date),'%d-%m-%Y') date,j.dtype transType,round(sum(j.dramount)*j.id,2) netamount,round(coalesce(o.amount,0),2) applied," 
					+ "round((sum(dramount) - coalesce(o.amount,0)*id)*j.id,2) balance,b.branchname,TIMESTAMPDIFF(Day,cast(j.date as datetime),cast('"+sqlUpToDate+"' as datetime)) duedys,j.brhid from my_jvtran j inner join my_head h "
					+ "on j.acno=h.doc_no left join (select ap_trid,o.tranid,sum(coalesce(amount,0)) amount from my_outd o inner join my_jvtran j on j.tranid=o.trANid where j.date<='"+sqlUpToDate+"' group by AP_trid) o on "
					+ "j.tranid=o.ap_trid inner join my_brch b on j.brhId=b.doc_no where j.status=3 and h.atype='"+atype+"' and j.acno="+acno+" and j.date<='"+sqlUpToDate+"'"+sqld1+" "+sqlbrch+" group by j.tranid having balance<>0 order by j.date,j.doc_no) a"+joins+" ) a,(SELECT @running_total:=0) r";
		
	  }
//	  System.out.println("sqlOutStanding==="+sqlOutStandingpal);  

	Statement stmt=conn.createStatement();
	ResultSet rs= stmt.executeQuery(sqlOutStandingpal);
	   det= commonDAO.convertToJSON(rs);
	// 	System.out.println("sqlOutStandingpal==="+det);   
	
	
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(det+"");
%>