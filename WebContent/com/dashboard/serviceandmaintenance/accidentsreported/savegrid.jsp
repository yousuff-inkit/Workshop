 <%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.util.*"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.common.*"%>


<%	
ClsConnection ClsConnection=new ClsConnection();

ClsCommon ClsCommon=new ClsCommon();

Connection conn = ClsConnection.getMyConnection();
try{
System.out.println("Inside Ajax");
	String accdate=request.getParameter("accdate");
	String report=request.getParameter("report");
	String collectdate=request.getParameter("collectdate");
	String place=request.getParameter("place");
	String accfines=request.getParameter("accfines");
    String claim=request.getParameter("claim");
    String remarks=request.getParameter("remarks");
    String docno=request.getParameter("docno");
   	String branchid=request.getParameter("branchid");
   	String reftype=request.getParameter("reftype");
	java.sql.Date sqlaccdate=ClsCommon.changetstmptoSqlDate(accdate);
	java.sql.Date sqlcollectdate=ClsCommon.changetstmptoSqlDate(collectdate);

	int val=0;
 
	Statement stmt = conn.createStatement ();
	Statement stmtlog = conn.createStatement ();
	int claimvalue=0;	//To distinguish between Own and Thirdparty..Own=1,Third Party=1
	int updatestatus=0;	//To Determine if any error occured 
	String getinsur="";	//Query for getting insurnce excess charge
	Statement stmtinsur=conn.createStatement();
	String tempreftype="";
	int tempagmtno=0;
	double tempinsurexcess=0.0;
	System.out.println("Reference Type:"+reftype);
	String sqltest="";
	if(claim.equalsIgnoreCase("Own")){
		claimvalue=1;
	}
	else{
		claimvalue=0;
	}
	
	
	
	if(reftype.equalsIgnoreCase("RAG")){
		getinsur="select insp.reftype,agmt.doc_no agmtno,coalesce(agmt.insex,0) insurexcess from gl_vinspm insp left join gl_ragmt agmt on (insp.refdocno=agmt.doc_no and "+
					" insp.reftype='RAG') where insp.doc_no="+docno;
	}
	if(reftype.equalsIgnoreCase("LAG")){
		getinsur="select insp.reftype,agmt.doc_no agmtno,coalesce(agmt.insurexcess,0)insurexcess from gl_vinspm insp left join gl_lagmt agmt on (insp.refdocno=agmt.doc_no and "+
					" insp.reftype='LAG') where insp.doc_no="+docno;
	}
	if(reftype.equalsIgnoreCase("RPL")){
		getinsur="select rpl.rtype reftype,rpl.rdocno agmtno,coalesce(if(rpl.rtype='RAG',rag.insex,lag.insurexcess),0) insurexcess from gl_vinspm insp left join gl_vehreplace rpl "+
				" on (insp.refdocno=rpl.doc_no and insp.reftype='RPL') left join gl_ragmt rag on (rpl.rdocno=rag.doc_no and rpl.rtype='RAG') left join gl_lagmt lag "+
				" on(rpl.rdocno=lag.doc_no and rpl.rtype='LAG') where insp.doc_no="+docno;
	}
	// System.out.println("Check Insur Query:"+getinsur);
	ResultSet rsgetinsur=stmtinsur.executeQuery(getinsur);
	while(rsgetinsur.next()){
		tempreftype=rsgetinsur.getString("reftype");
		tempagmtno=rsgetinsur.getInt("agmtno");
		tempinsurexcess=rsgetinsur.getDouble("insurexcess");
	}
	System.out.println(tempreftype+"::"+tempagmtno+"::"+tempinsurexcess);
	if(claimvalue==1){
		sqltest=",amount="+tempinsurexcess+"";
	}
	
	String calcinsert="";
	Statement stmtcalc=conn.createStatement();
	Statement stmtcheckagmt=conn.createStatement();
	String calcop="";		//Calc Operation..Either Insert or Update..Related to gl_rcalc
	String checkagmtno="";   //To determmine whether insert or update data to gl_rcalc
	if(tempreftype.equalsIgnoreCase("RAG") && tempinsurexcess>0 && claimvalue==1){
		checkagmtno="select count(*) count,dtype from gl_rcalc where rdocno="+tempagmtno+" and dtype='RAG' and idno=10";
		
	}
	if(tempreftype.equalsIgnoreCase("LAG") && tempinsurexcess>0 && claimvalue==1){
		checkagmtno="select count(*) count,dtype from gl_lcalc where rdocno="+tempagmtno+" and dtype='LAG' and idno=10";
	}
	int count=-1;
	if(!(checkagmtno.equalsIgnoreCase(""))){
	ResultSet rscheckagmt=stmtcheckagmt.executeQuery(checkagmtno);
	
	while(rscheckagmt.next()){
		count=rscheckagmt.getInt("count");
	}
	}
	if(count>0){
		calcop="update";
	}
	else if(count==0){
		calcop="insert";
	}
	if(calcop.equalsIgnoreCase("insert") && tempreftype.equalsIgnoreCase("RAG")){
		calcinsert="insert into gl_rcalc(brhid,rdocno,dtype,idno,amount,qty)values("+branchid+","+tempagmtno+",'RAG',10,"+tempinsurexcess+",1)";
	}
	else if(calcop.equalsIgnoreCase("insert") && tempreftype.equalsIgnoreCase("LAG")){
		calcinsert="insert into gl_lcalc(brhid,rdocno,dtype,idno,amount,qty)values("+branchid+","+tempagmtno+",'LAG',10,"+tempinsurexcess+",1)";
	}
	else if(calcop.equalsIgnoreCase("update") && tempreftype.equalsIgnoreCase("RAG")){
		calcinsert="update gl_rcalc set amount="+tempinsurexcess+" where rdocno="+tempagmtno+" and idno=10";
	}
	else if(calcop.equalsIgnoreCase("update") && tempreftype.equalsIgnoreCase("LAG")){
		calcinsert="update gl_lcalc set amount="+tempinsurexcess+" where rdocno="+tempagmtno+" and idno=10";
	}
	int calcval=0;
	if(!(calcinsert.equalsIgnoreCase(""))){
		calcval=stmtcalc.executeUpdate(calcinsert);	
	}
	
	if(calcval<0){
		updatestatus=1;
	}
	

	String updatesql="update gl_vinspm set polrep='"+report+"',acdate='"+sqlaccdate+"',coldate='"+sqlcollectdate+"',place='"+place+"',fine='"+accfines+"',"+
				" remarks='"+remarks+"',claim='"+claimvalue+"'"+sqltest+" where doc_no='"+docno+"'";
	String logsql="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ("+docno+",'"+branchid+"','BACR',now(),'"+session.getAttribute("USERID").toString()+"','E')";
	 int logval=0;
	 System.out.println("Update Sql:"+updatesql);
	 System.out.println("Log Sql:"+logsql);
	 int updateval= stmt.executeUpdate(updatesql);
		if(updateval>0){
			 logval=stmtlog.executeUpdate(logsql);
		}
		if(logval<0){
			updatestatus=1;
		}
	
		 response.getWriter().print(updatestatus);
	 	
	 	stmt.close();
	 	stmtlog.close();
	 	stmtinsur.close();
	 	stmtcalc.close();
	 	stmtcheckagmt.close();
	 	conn.close();
	 	
}
catch(Exception e1){
	e1.printStackTrace();
	conn.close();
}
	    
	
	%>
