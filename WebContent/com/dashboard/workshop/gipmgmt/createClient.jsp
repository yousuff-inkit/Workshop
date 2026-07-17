<%@page import="com.controlcentre.masters.client.ClsClientDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.connection.ClsConnection"%>
<%
String clientname=request.getParameter("clientname")==null?"":request.getParameter("clientname");
String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
String clientmobile=request.getParameter("clientmobile")==null?"":request.getParameter("clientmobile");
String clientemail=request.getParameter("clientemail")==null?"":request.getParameter("clientemail");
String clientaddress=request.getParameter("clientaddress")==null?"":request.getParameter("clientaddress");
String clientcat=request.getParameter("clientcat")==null?"":request.getParameter("clientcat");
String clienttrn=request.getParameter("clienttrn")==null?"":request.getParameter("clienttrn");
ClsClientDAO clientdao=new ClsClientDAO();

int errorstatus=0;
ClsConnection objconn=new ClsConnection();
java.sql.Date sqldate=null;
Connection conn=null;
try{
	conn=objconn.getMyConnection();
	int curid=0;
	String contactname="",contactmobile="";
	String strmisc="select gip.date,br.curid,username,mobile from ws_gateinpass gip left join my_brch br on gip.brhid=br.doc_no where gip.doc_no="+docno;
	Statement stmt=conn.createStatement();
	ResultSet rsmisc=stmt.executeQuery(strmisc);
	while(rsmisc.next()){
		sqldate=rsmisc.getDate("date");
		curid=rsmisc.getInt("curid");
		contactname=rsmisc.getString("username");
		contactmobile=rsmisc.getString("mobile");
	}
	String stracno="select doc_no,acc_group FROM my_clcatm where cat_name='RETAIL CUSTOMER' and status=3 and dtype='CRM'";
	int acgroup=0;
	int catid=0;
	ResultSet rsacno=stmt.executeQuery(stracno);
	while(rsacno.next()){
		acgroup=rsacno.getInt("acc_group");
		catid=rsacno.getInt("doc_no");
	}
	if(clientcat.trim().equalsIgnoreCase("")){
		clientcat=catid+"";
	}
	System.out.println("Client name:"+clientname);
	conn.close();
	ArrayList<String> blankarray=new ArrayList();
	/* java.sql.Date sqlDate,String client_name, int Currency,int Cmbacgroupid,int Cmbprivillege,int Cmbsalesmanid,int catid,String Txtcstno,String Txttinno,
	Double Fcredit_period_min,Double Fcredit_period_max,Double Fcredit_limit,String Txtaddress,String Txtextnno,String Txtmobile,String Txttelephone,
	String Txtfax,String Txtweb,String Txtemail,String Txtcontact,int areaid,String Txtaccountno,String Txtbankname,
	String Txtbranchname,String Txtbranchaddress,String Txtswiftno,String Txtibanno,String Txtcity,
	int countryid,String txtcontact,ArrayList cparrayList,HttpSession session,String mode,String formcode,String fin_name,String fin_adress,
	HttpServletRequest request,int chknotax */
	int clientvalue=clientdao.insert(sqldate, clientname, curid, acgroup, 3,0, Integer.parseInt(clientcat), "", clienttrn, 
			0.0, 0.0, 0.0,clientaddress,"",clientmobile,"",
			"","",clientemail,contactname,0,"","",
			"","","","","",
			0,contactname,blankarray, session, "A", "CRM","","", request,0);
	if(clientvalue>0){
		
		String strupdategip="update ws_gateinpass set cldocno="+clientvalue+" where doc_no="+docno;
		conn=objconn.getMyConnection();
		int gipupdate=conn.createStatement().executeUpdate(strupdategip);
		if(gipupdate<=0){
			errorstatus=1;
		}
		int updateacbook=conn.createStatement().executeUpdate("update my_acbook set trnnumber='"+clienttrn+"' where cldocno="+clientvalue+" and dtype='CRM'");
		if(updateacbook<=0){
			errorstatus=1;
		}
		conn.close();
	}
	else{
		errorstatus=clientvalue;
	}
	
}
catch(Exception e){
	e.printStackTrace();
	errorstatus=1;
	conn.close();
}
finally{
	conn.close();
}
response.getWriter().write(errorstatus+"");
%>