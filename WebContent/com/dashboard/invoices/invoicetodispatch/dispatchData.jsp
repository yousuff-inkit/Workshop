<%@page import="com.common.ClsCommon"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="java.lang.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="javax.servlet.http.HttpSession.*"%>
<%@page import="javax.servlet.http.HttpServletRequest.*"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>

<%
ClsConnection ClsConnection=new ClsConnection();

ClsCommon ClsCommon=new ClsCommon();

Connection conn=null;
try{	
String invno=request.getParameter("invno");
ArrayList<String> invarray=new ArrayList<String>();
if(invno.contains(":")){
	String [] inv=new String []{};
	inv=invno.split(":");
	System.out.print(inv.toString());
	for(int i=0;i<inv.length;i++){
		invarray.add(i, inv[i]);
		
	}
}
else{
	invarray.add(0, invno);
}

conn=ClsConnection.getMyConnection();
Statement stmt=conn.createStatement();
int a=1;
for(int i=0;i<invarray.size();i++){
	conn.setAutoCommit(false);
	String strsql="update gl_invm set dispatch=1 where doc_no="+invarray.get(i);
	int val=stmt.executeUpdate(strsql);
	if(val>0){
			Statement stmtbranch=conn.createStatement();
			ResultSet rsbranch=stmtbranch.executeQuery("select brhid from gl_invm where doc_no="+invarray.get(i)+"");
			int branch=0;
			if(rsbranch.next()){
				branch=rsbranch.getInt("brhid");	
			}
			Statement stmtlog=conn.createStatement();		
		  String upsql="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ("+invarray.get(i)+",'"+branch+"','BIVD',now(),'"+session.getAttribute("USERID").toString()+"','E')";
			int logval=stmtlog.executeUpdate(upsql);
			if(logval>0){
				conn.commit();
			}
			else{
				a=0;
				break;
				
			}
	}
}
response.getWriter().write(a+"");

}
catch(Exception e1){
	e1.printStackTrace();
}
finally{
	conn.close();
}

%>
  
