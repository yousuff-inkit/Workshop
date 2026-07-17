<%@page import="com.common.ClsCommon"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.connection.ClsConnection"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%
String jobdocno=request.getParameter("jobdocno")==null?"0":request.getParameter("jobdocno");
String id=request.getParameter("id")==null?"0":request.getParameter("id");
String invno=request.getParameter("invno")==null?"0":request.getParameter("invno");
Connection conn=null;
JSONArray gridarray=new JSONArray();

try{
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	String strsql="";
	if(id.equalsIgnoreCase("1")){
		strsql="select rowno, type, description, qty, rate, discount, amount, vatpercent, vatamount, netamount, serialno, estdocno, addition, jobdocno, invno from ws_investdetail where invno="+invno;
	}
	else if(id.equalsIgnoreCase("2")){
		strsql="select a.invno,a.jobdocno,a.estdocno,a.addition,a.jobtype type,convert(concat(a.voc_no,'-S',@i:=@i+1),char(25)) serialno,a.description,a.hrs qty,a.rate,a.jobdiscount discount,a.jobtotal amount,a.jobvatpercent vatpercent,a.jobvatamount vatamount,a.jobnetamount netamount,a.chkcomplete from ("+
				" select inv.doc_no invno,card.doc_no jobdocno,est.doc_no estdocno,lab.addition, @i:=0 count,lab.strjobtype jobtype,lab.strjobdesc description,est.voc_no,round(coalesce(lab.hrs,0),2) hrs,"+
				" round(coalesce(lab.rate,0),2) rate,round(coalesce(lab.jobdiscount,0),2) jobdiscount,round(coalesce(lab.jobtotal,0),2) jobtotal,"+
				" round(coalesce(lab.jobvatpercent,0),2) jobvatpercent,round(coalesce(lab.jobvatamount,0),2) jobvatamount,"+
				" round(coalesce(lab.jobnetamount,0),2) jobnetamount,lab.chkcomplete from ws_invm inv left join ws_jobcard card on (inv.reftype='JC' and inv.refno=card.doc_no) left join ws_estm est"+
				" on  (card.reftype='EST' and card.refno=est.doc_no) left join ws_estlabour lab on est.doc_no=lab.rdocno"+
				" where card.status=3 and lab.confirmed=1 and lab.approved=1 and card.doc_no="+jobdocno+""+
				" union all  select inv.doc_no invno,card.doc_no jobdocno,est.doc_no estdocno,0 addition,@i:=0 count,'Extra' jobtype,extra.description,est.voc_no,1 hrs,round(coalesce(extra.amount,0),2),0.0 labjobdiscount,round(coalesce(extra.amount,0),2) labjobtotal,5 jobvatpercent,round(coalesce(extra.amount*0.05,0),2) jobvatamount,round(coalesce(extra.amount*0.05,0),2)+round(coalesce(extra.amount,0),2) jobnetamount,0 chkcomplete from ws_invm inv left join ws_jobcard card on (inv.reftype='JC' and inv.refno=card.doc_no) left join ws_estm est on  (card.reftype='EST' and card.refno=est.doc_no)"+
				" left join ws_jccextra extra  on card.doc_no=extra.jobcarddocno where  card.status=3 and card.doc_no="+jobdocno+" and coalesce(extra.jobcarddocno,0)<>0)a"+
				" union all"+
				" select a.invno,a.jobdocno,a.estdocno,a.addition,'Parts' type,convert(concat(a.voc_no,'-P',@j:=@j+1),char(25)) serialno,a.description,a.qty,a.rate,a.jobdiscount discount,a.jobtotal amount,a.jobvatpercent vatpercent,a.jobvatamount vatamount,a.jobnetamount netamount,a.chkcomplete from ("+
				" select inv.doc_no invno,card.doc_no jobdocno,est.doc_no estdocno,spare.addition,@j:=0 count,if(spare.description='',m.productname,spare.description) description,round(coalesce(spare.qty,0),2) qty,"+
				" round(coalesce(spare.rate,0),2) rate,round(coalesce(spare.spdiscount,0),2) jobdiscount,round(coalesce(spare.sptotal,0),2) jobtotal,"+
				" round(coalesce(spare.spvatpercent,0),2) jobvatpercent,round(coalesce(spare.spvatamount,0),2) jobvatamount,round(coalesce(spare.spnetamount,0),2) jobnetamount,"+
				" est.voc_no,spare.chkcomplete from ws_invm inv left join ws_jobcard card on (inv.reftype='JC' and inv.refno=card.doc_no) left join ws_estm est"+
				" on  (card.reftype='EST' and card.refno=est.doc_no) left join ws_estspare spare on est.doc_no=spare.rdocno"+
				" left join my_main m on m.psrno=spare.psrno"+
				" where  card.status=3 and spare.confirmed=1 and card.doc_no="+jobdocno+" and spare.approved=1)a";
	}
	
	if(!strsql.equalsIgnoreCase("")){
		System.out.println(strsql);
		ResultSet rs=stmt.executeQuery(strsql);
		gridarray=objcommon.convertToJSON(rs);
	}

}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(gridarray+"");
%>