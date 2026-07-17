<%@page import="java.sql.*"%>
<%@page import="com.common.ClsCommon"%>
<%@page import="com.connection.ClsConnection"%>
<% 

ClsConnection connDAO = new ClsConnection();
ClsCommon commonDAO= new ClsCommon();
Connection conn=null;
String estDocno=request.getParameter("estDocno")==null?"":request.getParameter("estDocno");
String brhid=request.getParameter("brhid")==null?"":request.getParameter("brhid");
String pono=request.getParameter("pono")==null?"":request.getParameter("pono");
String podate=request.getParameter("podate")==null?"":request.getParameter("podate");
String desc=request.getParameter("desc")==null?"":request.getParameter("desc");
String excess=request.getParameter("excess")==null?"":request.getParameter("excess");
String excessamt=request.getParameter("excessamt")==null || request.getParameter("excessamt").equalsIgnoreCase("")?"0":request.getParameter("excessamt");
String gipno=request.getParameter("gipno")==null?"":request.getParameter("gipno");

Integer userid=(Integer) session.getAttribute("USERID");
int errorstatus=0; 
int x=0,y=0,z=0,p=0,q=0,jobno=0;
try{
	 conn=connDAO.getMyConnection();
	 conn.setAutoCommit(false);
	 	
		Statement stmt = conn.createStatement ();
		
		String strSql = "select doc_no from ws_jobcard where reftype='est' and refno ="+estDocno;
		ResultSet rs=stmt.executeQuery(strSql);
		while(rs.next()){
			jobno=rs.getInt("doc_no");
		}
		
		String strSql1 = "update ws_estlabour set approved=1 where rdocno="+estDocno;
		String strSql2 = "update ws_estspare set approved=1 where rdocno="+estDocno;
		String strSql3 = "insert into ws_estapprove(estno,excess,excessamt,desc1,userid,brhid,date,lpo) values(?,?,?,?,?,?,date(now()),?)";
		String strSql4="";
		if(jobno==0){
			strSql4 = "update ws_gateinpass set excess=?,excessamt=?,userid=?,lpo=?,processstatus=4 where doc_no=?";
		}
		else{
			strSql4 = "update ws_gateinpass set excess=?,excessamt=?,userid=?,lpo=?,processstatus=5 where doc_no=?";
		}
		
		String strSql5 = "insert into gl_biblog(doc_no,brhid,dtype,edate,userid,userno,activity,ENTRY) values(?,?,?,now(),?,?,?,?)";
		
		
		 x = stmt.executeUpdate(strSql1);
		 y = stmt.executeUpdate(strSql2);
		
		PreparedStatement ps=conn.prepareStatement(strSql3);	
		ps.setString(1, estDocno);
		ps.setString(2, excess);
		ps.setString(3, excessamt);
		ps.setString(4, desc);
		ps.setInt(5, userid);
		ps.setString(6, brhid);
		ps.setString(7, pono);
		
		 z=ps.executeUpdate();
		
		PreparedStatement ps1=conn.prepareStatement(strSql4);
		ps1.setString(1, excess);
		ps1.setString(2, excessamt);
		ps1.setInt(3, userid);
		ps1.setString(4,pono);
		ps1.setString(5, gipno);
		p=ps1.executeUpdate();
		
		PreparedStatement ps2=conn.prepareStatement(strSql5);
		ps2.setString(1, estDocno);
		ps2.setString(2, brhid);
		ps2.setString(3, "BWQA");
		ps2.setInt(4, userid);
		ps2.setString(5, "0");
		ps2.setString(6, "0");
		ps2.setString(7, "A");
		
		q=ps2.executeUpdate();
		

		if((x<=0)||(z<=0)||(p<=0)||(q<=0)){
			errorstatus=1;
		}
		
		if(errorstatus==0){
			conn.commit();
		}
}catch(Exception e){
	e.printStackTrace();
	conn.close();
}
finally{
	conn.close();
}
response.getWriter().write(errorstatus+"");
%>