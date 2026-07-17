<%@page import="java.util.ArrayList"%>
<%@page import="com.connection.*"%>
<%@page import="com.common.*"%>
<%@page import="java.sql.*"%>
<%
String cmbinsurtype=request.getParameter("cmbinsurtype")==null?"":request.getParameter("cmbinsurtype");
String jobcarddocno=request.getParameter("jobcarddocno")==null?"":request.getParameter("jobcarddocno");
String chkmultiple=request.getParameter("chkmultiple")==null?"0":request.getParameter("chkmultiple");
String strexcess=request.getParameter("excess")==null || request.getParameter("excess").equalsIgnoreCase("")?"0.0":request.getParameter("excess");
String strclaimno=request.getParameter("claimno")==null?"":request.getParameter("claimno");
String strpono=request.getParameter("pono")==null?"":request.getParameter("pono");
String strpodate=request.getParameter("podate")==null?"":request.getParameter("podate");
String strvattype=request.getParameter("vattype")==null || request.getParameter("vattype").equalsIgnoreCase("")?"1":request.getParameter("vattype");
String strestarray=request.getParameter("estarray")==null?"":request.getParameter("estarray");
String seccldocno=request.getParameter("seccldocno")==null?"":request.getParameter("seccldocno");
System.out.println(jobcarddocno+"::"+chkmultiple+"::"+strexcess+"::"+strclaimno+"::"+strpono+"::"+strpodate+"::"+strvattype);
int errorstatus=0;
Connection conn=null;
try{
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	conn=objconn.getMyConnection();
	conn.setAutoCommit(false);
	Statement stmt=conn.createStatement();
	java.sql.Date sqlpodate=null;
	if(!strpodate.equalsIgnoreCase("") && !strpodate.equalsIgnoreCase("undefined")){
		sqlpodate=objcommon.changeStringtoSqlDate(strpodate);
	}
	ArrayList<String> estarray=new ArrayList();
	//System.out.println(jobcarddocno+"::"+chkmultiple+"::"+excess+"::"+claimno+"::"+pono+"::"+podate+"::"+vattype);
	for(int i=0;i<strestarray.split(",").length;i++){
		strestarray.split(",")[i].split("::")[0]=strestarray.split(",")[i].split("::")[0].equalsIgnoreCase("undefined")?"":strestarray.split(",")[i].split("::")[0];
		estarray.add(strestarray.split(",")[i]);
		System.out.println(estarray.get(i));
	}
	String strsql="";
	if(!cmbinsurtype.trim().equalsIgnoreCase("")){
		String strupdatejobcard="update ws_jobcard set insurtypedocno="+cmbinsurtype+" where doc_no="+jobcarddocno;
		int updatejobcard=stmt.executeUpdate(strupdatejobcard);
		if(updatejobcard<0){
			System.out.println("Update insurtype error");
			errorstatus=1;
		}	
	}
	
	String strdelete="delete from ws_investdata where jobdocno="+jobcarddocno+" and seccldocno="+seccldocno;
	int deleteval=stmt.executeUpdate(strdelete);
	
	if(chkmultiple.equalsIgnoreCase("1")){
		for(int i=0;i<estarray.size();i++){
			String estno=estarray.get(i).split("::")[0];
			String labourtotal=estarray.get(i).split("::")[1];
			String sparetotal=estarray.get(i).split("::")[2];
			String nettotal=estarray.get(i).split("::")[3];
			String chkclaim=estarray.get(i).split("::")[4].equalsIgnoreCase("true")?"1":"0";
			String claimno=(estarray.get(i).split("::")[5].equalsIgnoreCase("undefined") || estarray.get(i).split("::")[5].equalsIgnoreCase(""))?"":estarray.get(i).split("::")[5];
			String excess=(estarray.get(i).split("::")[6].equalsIgnoreCase("undefined") || estarray.get(i).split("::")[6].equalsIgnoreCase(""))?"0.0":estarray.get(i).split("::")[6];
			String pono=(estarray.get(i).split("::")[7].equalsIgnoreCase("undefined") || estarray.get(i).split("::")[7].equalsIgnoreCase(""))?"":estarray.get(i).split("::")[7];
			String podate=estarray.get(i).split("::")[8];
			String vattype=estarray.get(i).split("::")[9].equalsIgnoreCase("Insur.Company")?"2":"1";
			String addition=estarray.get(i).split("::")[10];
			String insurtypedocno=(estarray.get(i).split("::")[11].equalsIgnoreCase("undefined") || estarray.get(i).split("::")[11].equalsIgnoreCase(""))?"0":estarray.get(i).split("::")[11];
			String nontaxamt=(estarray.get(i).split("::")[12].equalsIgnoreCase("undefined") || estarray.get(i).split("::")[12].equalsIgnoreCase(""))?"0":estarray.get(i).split("::")[12].trim();
		//	System.out.println("===== "+estarray.get(i).split("::")[9]+"====="+estarray.get(i).split("::")[9].equalsIgnoreCase("Insur.Company"));
			java.sql.Date sqlpodatenew=null;
			if(!podate.equalsIgnoreCase("undefined") && !podate.equalsIgnoreCase("")){
				sqlpodatenew=objcommon.changeStringtoSqlDate(podate);
			}
			if(sqlpodatenew!=null){
				strsql="insert into ws_investdata(jobdocno, chkmultiple, estno, labourtotal, sparetotal, nettotal, chkclaim, claimno, excess, pono, "+
						" podate, vattype, status,addition,insurtypedocno,nontaxamt,seccldocno)values("+jobcarddocno+","+chkmultiple+",'"+estno+"',"+labourtotal+","+sparetotal+","+nettotal+","+chkclaim+","+
						" '"+claimno+"',"+excess+",'"+pono+"','"+sqlpodatenew+"',"+vattype+",3,"+addition+","+insurtypedocno+","+nontaxamt+","+seccldocno+")";
				System.out.println("Date Not Null Insert: "+strsql);
			}
			else{
				strsql="insert into ws_investdata(jobdocno, chkmultiple, estno, labourtotal, sparetotal, nettotal, chkclaim, claimno, excess, pono, "+
						" podate, vattype, status ,addition,insurtypedocno,nontaxamt,seccldocno)values("+jobcarddocno+","+chkmultiple+",'"+estno+"',"+labourtotal+","+sparetotal+","+nettotal+","+chkclaim+","+
						" '"+claimno+"',"+excess+",'"+pono+"',"+sqlpodatenew+","+vattype+",3,"+addition+","+insurtypedocno+","+nontaxamt+","+seccldocno+")";
				System.out.println("Date Null Insert: "+strsql);
			}
			int value=stmt.executeUpdate(strsql);
		//	System.out.println("Insert Value:"+value);
			if(value<=0){
				errorstatus=1;
				break;
			}
		
	}
	}
	if(chkmultiple.equalsIgnoreCase("0")){
		double labourtotal=0.0,sparetotal=0.0,nettotal=0.0,nontaxamt=0.0;
		String estno="";
		// strvattype=strvattype.equalsIgnoreCase("Insur.Company")?"2":"1";
		// System.out.println("===== "+strvattype+"====="+strvattype.equalsIgnoreCase("Insur.Company"));
		for(int i=0;i<estarray.size();i++){
			/* System.out.println("Array Values without multiple:"+estarray.get(i));
			System.out.println("Array Values without multiple:"+estarray.get(i).split("::")[1]);
			System.out.println("Array Values without multiple:"+estarray.get(i).split("::")[2]);
			System.out.println("Array Values without multiple:"+estarray.get(i).split("::")[3]); */
			estno=estarray.get(0).split("::")[0];
			labourtotal+=Double.parseDouble(estarray.get(i).split("::")[1]);
			sparetotal+=Double.parseDouble(estarray.get(i).split("::")[2]);
			nettotal+=Double.parseDouble(estarray.get(i).split("::")[3]);
			nontaxamt=Double.parseDouble((estarray.get(i).split("::")[12].equalsIgnoreCase("undefined") || estarray.get(i).split("::")[12].equalsIgnoreCase(""))?"0":estarray.get(i).split("::")[12].trim());
		}
		String sql="select gate.insurancecomp,gate.insurcldocno  from ws_jobcard job  left join ws_estm est "
				+" on (job.reftype='EST' and job.refno=est.doc_no) left join ws_gateinpass gate  " 
				+" on (if(job.reftype='GIP',job.refno=gate.doc_no,est.gipno=gate.doc_no)) where job.doc_no="+jobcarddocno;
		ResultSet rs=stmt.executeQuery(sql);
		int insurancecomp=0;
		while(rs.next()){
			insurancecomp=rs.getInt("insurancecomp");
		}
		String strinsert="";
		if(sqlpodate!=null){
			strinsert="insert into ws_investdata(jobdocno, chkmultiple, estno, labourtotal, sparetotal, nettotal, chkclaim, claimno, excess, pono, "+
					" podate, vattype, status,addition,nontaxamt,seccldocno)values("+jobcarddocno+","+chkmultiple+",'"+estno+"',"+labourtotal+","+sparetotal+","+nettotal+","+(Double.parseDouble(strexcess)>0.0 || insurancecomp==1 ? 1 : 0)+","+
					" '"+strclaimno+"',"+strexcess+",'"+strpono+"','"+sqlpodate+"',"+strvattype+",3,0,"+nontaxamt+","+seccldocno+")";	
		}
		else{
			strinsert="insert into ws_investdata(jobdocno, chkmultiple, estno, labourtotal, sparetotal, nettotal, chkclaim, claimno, excess, pono, "+
					" podate, vattype, status,addition,nontaxamt,seccldocno)values("+jobcarddocno+","+chkmultiple+",'"+estno+"',"+labourtotal+","+sparetotal+","+nettotal+","+(Double.parseDouble(strexcess)>0.0 || insurancecomp==1 ? 1 : 0)+","+
					" '"+strclaimno+"',"+strexcess+",'"+strpono+"',"+sqlpodate+","+strvattype+",3,0,"+nontaxamt+","+seccldocno+")";
		}
		
		System.out.println(strinsert);
		int insertval=stmt.executeUpdate(strinsert);                            
		if(insertval<=0){
			errorstatus=1;
		}
		
	}	
	if(errorstatus==0){
		conn.commit();
	}
}
catch(Exception e){
	e.printStackTrace();
	errorstatus=1;
}
finally{
	conn.close();
}

response.getWriter().write(errorstatus+"");
%>