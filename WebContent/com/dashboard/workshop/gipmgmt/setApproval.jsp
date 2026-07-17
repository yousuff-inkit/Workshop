<%@page import="java.sql.*"%>
<%@page import="com.common.ClsCommon"%>
<%@page import="com.connection.ClsConnection"%>
<%@page import="com.workshop.wsjobcard_fancy.ClsWSJobCardDAO"%>
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
String tobe1=request.getParameter("tobe")==null?"":request.getParameter("tobe");
String action=request.getParameter("action")==null?"":request.getParameter("action");
String waveoffreason=request.getParameter("waveoffreason")==null?"":request.getParameter("waveoffreason");
int tobe=Integer.parseInt(tobe1);
Integer userid=(Integer) session.getAttribute("USERID");
int errorstatus=0; 
int x=0,y=0,z=0,p=0,q=0,jobno=0;
try{
	 conn=connDAO.getMyConnection();
	 conn.setAutoCommit(false);
	 	
		Statement stmt = conn.createStatement ();
		//Checking if Addition is Present
		String strgetadd="select addition from ws_estmadd where doc_no="+estDocno+" and status=3";
		int addition=0;
		ResultSet rsgetadd=stmt.executeQuery(strgetadd);
		while(rsgetadd.next()){
			addition=rsgetadd.getInt("addition");
		}
		if(addition>0){
			//Additions Present
			errorstatus=-1;
		}
		else{
			if(brhid.trim().equalsIgnoreCase("") || brhid.trim().equalsIgnoreCase("a")){
				//Getting Branch when branch is not selected
				String strgetbranch="select brhid from ws_estm where doc_no="+estDocno;
				ResultSet rsgetbranch=stmt.executeQuery(strgetbranch);
				while(rsgetbranch.next()){
					brhid=rsgetbranch.getString("brhid");
				}
			}
			String strSql = "select doc_no from ws_jobcard where reftype='est' and refno ="+estDocno;
			ResultSet rs=stmt.executeQuery(strSql);
			while(rs.next()){
				jobno=rs.getInt("doc_no");
			}
			
			String strupdateappr="update ws_estm set approved="+action+" where doc_no="+estDocno;
			
			int updateappr=stmt.executeUpdate(strupdateappr);
			if(updateappr<=0){
				errorstatus=1;
			}
			String strSql1 = "update ws_estlabour set approved="+action+" where rdocno="+estDocno+" and confirmed=1 and approved=0";
			String strSql2 = "update ws_estspare set approved="+action+" where rdocno="+estDocno+" and confirmed=1 and approved=0";
			String strSql3 = "insert into ws_estapprove(estno,excess,excessamt,desc1,userid,brhid,date,lpo,waveoffreason) values(?,?,?,?,?,?,date(now()),?,?)";
			String strSql4="";
			if(jobno==0){
				if(tobe==1){
					strSql4 = "update ws_gateinpass set excess=?,excessamt=?,userid=?,lpo=?,processstatus=4 where doc_no=?";
				}
				if(tobe==2){
					strSql4 = "update ws_gateinpass set excess=?,excessamt=?,userid=?,lpo=? where doc_no=?";
				}
			}
			else{
				if(tobe==1){
				 	strSql4 = "update ws_gateinpass set excess=?,excessamt=?,userid=?,lpo=?,processstatus=5 where doc_no=?";
				}
				if(tobe==2){
					strSql4 = "update ws_gateinpass set excess=?,excessamt=?,userid=?,lpo=? where doc_no=?";
				}
			}
			
			String strSql5 = "insert into gl_biblog(doc_no,brhid,dtype,edate,userid,userno,activity,ENTRY) values(?,?,?,now(),?,?,?,?)";
			System.out.println(strSql1);
			System.out.println(strSql2);
			
			
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
			ps.setString(8, waveoffreason);
			System.out.println(strSql3);
			
			 z=ps.executeUpdate();
			
			PreparedStatement ps1=conn.prepareStatement(strSql4);
			ps1.setString(1, excess);
			ps1.setString(2, excessamt);
			ps1.setInt(3, userid);
			ps1.setString(4,pono);
			ps1.setString(5, gipno);
			System.out.println(strSql4);
			p=ps1.executeUpdate();
			
			PreparedStatement ps2=conn.prepareStatement(strSql5);
			ps2.setString(1, estDocno);
			ps2.setString(2, brhid);
			ps2.setString(3, "BWQA");
			ps2.setInt(4, userid);
			ps2.setString(5, "0");
			ps2.setString(6, "0");
			ps2.setString(7, "A");
			System.out.println(strSql5);
			q=ps2.executeUpdate();
			

			if((z<=0)||(p<=0)||(q<=0)){
				errorstatus=1;
			}
			ClsWSJobCardDAO jobcarddao=new ClsWSJobCardDAO();
			int floormgmtconfig=jobcarddao.getFloorMgmtConfig(conn);
			if(floormgmtconfig==1 && jobno>0){
				String strupdatefloormgmt="update ws_floormgmtdata flr inner join ws_jobcard job on flr.jobdocno=job.doc_no left join ws_estm es on "+
				" (job.reftype='EST' and job.refno=es.doc_no) left join (select sum(total) labourtotal,rdocno,sum(hrs) labourhrs from ws_estlabour "+
				" where confirmed=1 and approved=1 group by rdocno) labour on (es.doc_no=labour.rdocno) left join (select sum(approvedvalue) sparetotal,"+
				" rdocno from ws_estspare where confirmed=1 and approved=1 group by rdocno) spare on (es.doc_no=spare.rdocno) "+
				" set flr.esttotal=labour.labourtotal+spare.sparetotal where es.doc_no="+estDocno;
				System.out.println(strupdatefloormgmt);
				int updatefloormgmt=stmt.executeUpdate(strupdatefloormgmt);
			
			}
			if(errorstatus==0){
				conn.commit();
			}	
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