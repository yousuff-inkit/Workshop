<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String gatedocno=request.getParameter("docno")==null||request.getParameter("docno")==""?"0":request.getParameter("docno");

Connection conn=null;
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	String sqltest="",sqlbranch="";
	
	int attachcount=0,attachmethod=0,checklist=0,accident=0;
	String strattach="select coalesce(method,0) method from  gl_config where field_nme='gipattachrestrict'";
	ResultSet rsattach=stmt.executeQuery(strattach);
	while(rsattach.next()){
		attachmethod= rsattach.getInt("method");
	}
	{
		if(attachmethod==1)
		{
			if (!(gatedocno==""))
			{
				
				String straccchk="select * from ws_giprepairtype g left join ws_gartype g1 on g.repairdocno=g1.row_no where gipdocno='"+gatedocno+"' and accident=1";
				//System.out.println("straccccheck=========="+straccchk);
				ResultSet rscheckacc=stmt.executeQuery(straccchk);
				if(rscheckacc.next()){
				
				accident=1;
				String strcheck="select count(distinct ref_id) count from my_fileattach where doc_no='"+gatedocno+"' and dtype='gip' and ref_id in (18,19,20,21)and status=3;";
			//	System.out.println("strcheck=========="+strcheck);

				ResultSet rscheck=stmt.executeQuery(strcheck);
				while(rscheck.next()){
					attachcount= rscheck.getInt("count");
				}
				int insutype=0;
				String strsql="select insutype from ws_gateinpass where doc_no='"+gatedocno+"'" ;
				ResultSet rssql=stmt.executeQuery(strsql);

				while(rssql.next()){
					insutype=rssql.getInt("insutype");
					if(insutype>0)
					{
					checklist= 1;
					}
				}
				}
			}
		}
	}
	System.out.println("attachcount=="+attachcount+"attchmethod===="+attachmethod+"checklist========"+checklist+"accident====="+accident);
	response.getWriter().print(attachmethod+"::"+attachcount+"::"+checklist+"::"+accident);
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}

%>