<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="java.util.*" %>

<%

Connection conn = null;
ClsConnection ClsConnection=new ClsConnection();
int errorstatus=0;

String gridarray=request.getParameter("gridarray");
ArrayList<String> griddataarray = new ArrayList<String>();

String[] temparray=gridarray.split(",");
for(int i=0;i<temparray.length;i++){
	griddataarray.add(temparray[i]);
	System.out.println(temparray[i]);
}

try{
	conn=ClsConnection.getMyConnection();
	conn.setAutoCommit(false);
	Statement stmt = conn.createStatement();
	for(int i=0;i<griddataarray.size();i++){
		String[] temp=griddataarray.get(i).split("::");
		String rno=temp[0].trim();
		String psrno=temp[1].trim();
		String stdcost=temp[2].trim();
		String vndno=temp[3].trim();
		vndno=vndno.equalsIgnoreCase("")?"0":vndno;
		System.out.println("Values==============="+rno+"**"+psrno+"**"+stdcost+"**"+vndno);
		String sqlup="update ws_estspare set psrno='"+psrno+"', stdprice='"+stdcost+"', vndno='"+vndno+"' where rowno='"+rno+"'";
		System.out.println(sqlup);
		int up=stmt.executeUpdate(sqlup);
		System.out.println("^^^^^^"+up);
		if(up<=0){
			errorstatus = 1;
			break;
		}
		else{
			System.out.println("!!!!!!!!!!!!! Success"+i);
		}
	}

	int log=0;
	if(errorstatus==0){
		String estno=request.getParameter("estno").toString();
		String userid=session.getAttribute("USERID").toString();
		String brhid =session.getAttribute("BRANCHID").toString();
		System.out.println("insert into gl_biblog(doc_no, brhId, dtype, edate, userId, userNo, activity, ENTRY) values ("+estno+","+Integer.parseInt(brhid)+",BWPC,now(),"+ userid +",0,0,E)");
		 PreparedStatement stmtlog=conn.prepareStatement("insert into gl_biblog(doc_no, brhId, dtype, edate, userId, userNo, activity, ENTRY) values (?,?,?,now(),?,?,?,?)");
		 
		 stmtlog.setString(1,estno);
		 stmtlog.setInt(2,Integer.parseInt(brhid));
		 stmtlog.setString(3,"BWPC");
		 stmtlog.setString(4, userid);
		 stmtlog.setInt(5, 0);
		 stmtlog.setInt(6, 0);
		 stmtlog.setString(7, "E");
		 
		 log=stmtlog.executeUpdate();
		 if(log<=0){
			 errorstatus=1;
		 }
	}
	if(errorstatus==0){
		conn.commit();
	}
}
catch(Exception e){
	errorstatus=1;
	e.printStackTrace();
	conn.close();
}
finally{
	conn.close();
}

response.getWriter().write(errorstatus+"");
%>