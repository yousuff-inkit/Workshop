<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.*" %>

<%	
	Connection conn = null;
ClsConnection ClsConnection=new ClsConnection();

ClsCommon ClsCommon=new ClsCommon();

	
	try{
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement ();
		String date=request.getParameter("paytype")==""?"0":request.getParameter("paytype");
		java.sql.Date    sqlDate=null;
		 if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0")))
         {
			 sqlDate  = ClsCommon.changeStringtoSqlDate(date);
         }
		

		
		String strSql = "select t.doc_no acno,t.account,t.description,t.atype,t.curid,c.code currency,round(cb.rate,2) rate,"
				+" c.type from my_head t left join my_curr c on t.curid=c.doc_no left join my_curbook cb on "
						+"t.curid=cb.curid inner join (select max(cr.doc_no) doc_no,cr.curid curid,cr.toDate,cr.frmDate "
								+"from my_curbook cr where coalesce(toDate,curdate())>='"+sqlDate+"' and frmDate<='"+sqlDate+"' "
										+"group by cr.curid) as bo on(cb.doc_no=bo.doc_no and cb.curid=bo.curid) where t.atype='GL' and t.m_s=0 "
												+" and t.doc_no=(select acno from gl_invmode mo where idno=9) ";
		ResultSet rs = stmt.executeQuery(strSql);
		
		String docno="",account="",description="",atype="",curid="",rate="",type="";
		if(rs.next()) {
					docno=rs.getString("acno");
					account=rs.getString("account");
					description=rs.getString("description");
					atype=rs.getString("atype");
					curid=rs.getString("curid");
					rate=rs.getString("rate");
					type=rs.getString("type");
				} 
		
		response.getWriter().write(docno+"####"+account+"####"+description+"####"+atype+"####"+curid+"####"+rate+"####"+type);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  