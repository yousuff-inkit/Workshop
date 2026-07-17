<%@page import="java.nio.file.StandardOpenOption"%>
<%@page import="java.nio.file.Paths"%>
<%@page import="java.nio.file.Files"%>
<%@page import="java.io.FileWriter"%>
<%@page import="java.io.File"%>
<%@page import="com.workshop.wsestimationalice.ClsWSEstimationAliceDAO"%>
<%@page import="com.workshop.wsjobcard_fancy.ClsWSJobCardDAO"%>
<%@page import="workshopapp.ClsWorkshopAppDAO"%>
<%@page import="com.workshop.wsestimationfancy.ClsWSEstimationFancyDAO"%>
<%@page import="com.common.ClsCommon"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="com.connection.ClsConnection"%>
<%@page import="com.workshop.gateinpassmaster.ClsGateInPassDAO"%>
<%
ClsGateInPassDAO gipdao=new ClsGateInPassDAO();
ClsWorkshopAppDAO appdao=new ClsWorkshopAppDAO();
ClsConnection objconn=new ClsConnection();
ClsWSJobCardDAO jobdao=new ClsWSJobCardDAO();
ClsCommon objcommon=new ClsCommon();
int errorstatus=0;
String docno="",imgpath="";
Connection conn=null;
try{
	String cldocno=request.getParameter("cldocno")==null?"":request.getParameter("cldocno").toString();
	String chkbackjob=request.getParameter("chkbackjob")==null?"0":request.getParameter("chkbackjob").toString();
	String recievedfromname=request.getParameter("recievedfromname")==null?"":request.getParameter("recievedfromname").toString();
	String recievedfrommobile=request.getParameter("recievedfrommobile")==null?"":request.getParameter("recievedfrommobile").toString();
	String chassisno=request.getParameter("chassisno")==null?"":request.getParameter("chassisno").toString();
	String regno=request.getParameter("regno")==null?"":request.getParameter("regno").toString();
	String platecode=request.getParameter("platecode")==null?"":request.getParameter("platecode").toString();
	String brandid=request.getParameter("brandid")==null?"0":request.getParameter("brandid").toString();
	String modelid=request.getParameter("modelid")==null?"0":request.getParameter("modelid").toString();
	String colorid=request.getParameter("colorid")==null?"0":request.getParameter("colorid").toString();
	String date=request.getParameter("gipestdate")==null?"":request.getParameter("gipestdate").toString();
	String time=request.getParameter("gipesttime")==null?"":request.getParameter("gipesttime").toString();
	String km=request.getParameter("km")==null?"0":request.getParameter("km").toString();
	String fuel=request.getParameter("fuel")==null?"0.000":request.getParameter("fuel").toString();
	String branchid=request.getParameter("branchid")==null?"":request.getParameter("branchid").toString();
	String userid=session.getAttribute("USERID")==null?"":session.getAttribute("USERID").toString();
	String mode=request.getParameter("mode")==null?"":request.getParameter("mode").toString();
	String cmbrepairtype=request.getParameter("cmbrepairtype")==null?"":request.getParameter("cmbrepairtype").toString();
	docno=request.getParameter("docno")==null || request.getParameter("docno").trim().equalsIgnoreCase("") || request.getParameter("docno").equalsIgnoreCase("undefined")?"":request.getParameter("docno").toString();
	String strinventoryarray=request.getParameter("inventoryarray")==null?"":request.getParameter("inventoryarray");
	String remarks=request.getParameter("remarks")==null?"":request.getParameter("remarks");
	String docexist=request.getParameter("docexist")==null?"":request.getParameter("docexist");
	String clientdetails=request.getParameter("clientdetails")==null?"":request.getParameter("clientdetails").toString();
	String recievedfromemail=request.getParameter("recievedfromemail")==null?"":request.getParameter("recievedfromemail").toString();
	String cmbyom=request.getParameter("cmbyom")==null?"":request.getParameter("cmbyom").toString();
	String cmbserviceadvisor=request.getParameter("cmbserviceadvisor")==null?"":request.getParameter("cmbserviceadvisor").toString();
	String strremarkarray=request.getParameter("remarkarray")==null?"":request.getParameter("remarkarray").toString();
	remarks=remarks.replace("'","");
	ArrayList<String> inventoryarray=new ArrayList();
	for(int i=0;i<strinventoryarray.split(",").length;i++){
		inventoryarray.add(strinventoryarray.split(",")[i]);
	}
	if(cldocno.trim().equalsIgnoreCase("") || cldocno.trim().equalsIgnoreCase("undefined")){
		cldocno="0";
	}
	if(cmbserviceadvisor.trim().equalsIgnoreCase("") || cmbserviceadvisor.trim().equalsIgnoreCase("undefined")){
		cmbserviceadvisor="0";
	}
	ArrayList<String> repairtypearray=new ArrayList();
	System.out.println("Repair Type :"+cmbrepairtype);
	if(cmbrepairtype.contains(",")){
		for(int i=0;i<cmbrepairtype.split(",").length;i++){
			repairtypearray.add(cmbrepairtype.split(",")[i]);
			System.out.println(cmbrepairtype.split(",")[i]);
		}
		cmbrepairtype=repairtypearray.get(0);
	}
	else{
		repairtypearray.add(cmbrepairtype);
	}
	ArrayList<String> remarkarray=new ArrayList();
	if(strremarkarray.contains(",")){
		for(int i=0;i<strremarkarray.split(",").length;i++){
			remarkarray.add(strremarkarray.split(",")[i]);
		}
	}
	System.out.println("Mode:"+mode);
	if(mode.equalsIgnoreCase("0")){
		conn=objconn.getMyConnection();
		ResultSet rsgetpath=conn.createStatement().executeQuery("select imgpath from my_comp where doc_no=1");
		while(rsgetpath.next()){
			imgpath=rsgetpath.getString("imgpath");
		}
		imgpath.replaceAll("//","////");
		request.setAttribute("IMGPATH",imgpath);
		Statement stmt=conn.createStatement();
		java.sql.Date sqldate=null;
		String strmisc="select CURDATE() sqldate";
		ResultSet rsmisc=stmt.executeQuery(strmisc);
		while(rsmisc.next()){
			sqldate=rsmisc.getDate("sqldate");
		}
		int gipdocno=0;
		int gipreleasestatus=0;
		String strcheckrelease="select gip.doc_no,gip.processstatus from ws_gateinpass gip where regno="+regno+" and pltid='"+platecode+"' and status=3";
		ResultSet rscheckrelease=stmt.executeQuery(strcheckrelease);
		while(rscheckrelease.next()){
			if(rscheckrelease.getInt("processstatus")==10){
				gipdocno=rscheckrelease.getInt("doc_no");
				gipreleasestatus=1;
			}
		}
		//getting vocno
		String gipvocno="";
		if(!docno.equalsIgnoreCase("")){
			String strgetvocno="select gip.doc_no,gip.voc_no from ws_gateinpass gip where doc_no="+docno;
			ResultSet rsgetvocno=stmt.executeQuery(strgetvocno);
			while(rsgetvocno.next()){
				gipvocno=rsgetvocno.getString("voc_no");
			}	
		}
		
		ArrayList<String> blankarray=new ArrayList();
		/* insert(Date sqldate, int docno, String cldocno, int 
		 clname, int clientid, String description, int apprchk, int backjob, String vehusername, String vehusrmobile, String 
		 vehusermail, String vehuserothers, String vehregno, String vehplatecode, int cmbbrand, int cmbmodel, int 
		 cmbyom, String vehothers, int vehkm, String cmbfueltype, int cmbrepairtype, Date sqlestdate, String esttime, 
		 String maintenanceremarks, String policereport, Date sqlpolicedate, String policestation, int cmbinsutype, int 
		 cmbfaulttype, String claim, String lpo, double lpoamount, int exceschk, double excesamount, ArrayList<String> 
		 complaintarray, HttpSession session, HttpServletRequest request, String mode, String formdetailcode, String 
		 brchName, String refno, int movno, int luxury, String marketingperson, String serviceadvisor, String 
		 insuranceservivor, String referencedby, String servicepackage, String teammaster, String cmbpriority, String 
		 cmbcolor, Date sqlregexpirydate) throws SQLException */
		if(gipreleasestatus==0){
			if(docno.equalsIgnoreCase("")){
				conn.close();
				gipdocno=gipdao.insert(sqldate,0, cldocno,0,0,"GIP created from APP",0,Integer.parseInt(chkbackjob), 
						recievedfromname, recievedfrommobile, recievedfromemail,chassisno, regno, platecode, Integer.parseInt(brandid), 
						Integer.parseInt(modelid),Integer.parseInt(cmbyom), "",Integer.parseInt(km), fuel,0,null,"", 
						"","",null,"",0,0,
						"","", 0.0,0,0.0,blankarray, 
						session, request,"A","GIP", branchid,"",
						0,0,"","","","",
						"","","0",colorid,sqldate,"0",blankarray);
					
			}
			else if(Integer.parseInt(docno)>0){
				String strupdategip="update ws_gateinpass set cldocno="+cldocno+",regno="+regno+",pltid='"+platecode+"',brdid="+brandid+",modid="+modelid+",yom="+cmbyom+",other='"+chassisno+"',clientname='"+clientdetails+"',username='"+recievedfromname+"',mobile='"+recievedfrommobile+"',email='"+recievedfromemail+"' where doc_no="+docno;
				int updategip=conn.createStatement().executeUpdate(strupdategip);
				if(updategip<0){
					errorstatus=1;
				}
				else{
					gipdocno=Integer.parseInt(docno);
				}
			}
				
		}
		else{			
			String strupdategip="update ws_gateinpass gip left join my_acbook ac on (gip.cldocno=ac.cldocno and ac.dtype='CRM') set gip.username='"+recievedfromname+"',gip.mobile='"+recievedfrommobile+"',gip.email='"+recievedfromemail+"',ac.mail1='"+recievedfromemail+"',gip.yom="+cmbyom+",gip.brdid="+brandid+",gip.modid="+modelid+",gip.other='"+chassisno+"',gip.clientname='"+clientdetails+"' where gip.doc_no="+gipdocno;
			int updategip=conn.createStatement().executeUpdate(strupdategip);
			if(updategip<0){
				System.out.println("Back Job gip update error");
				errorstatus=1;
			}
			int floormgmtconfig=0;
			String strfloormgmtconfig="select method from gl_config where field_nme='floorMgmt'";
			ResultSet rsfloorconfig=stmt.executeQuery(strfloormgmtconfig);
			while(rsfloorconfig.next()){
				floormgmtconfig=rsfloorconfig.getInt("method");
			}
			int brhid=0,oldstatus=0;
			String stroldstatus="select oldstatus,brhid from ws_vehrelease where gatedocno="+gipdocno;
			ResultSet rsoldstatus=stmt.executeQuery(stroldstatus);
			while(rsoldstatus.next()){
				brhid=rsoldstatus.getInt("brhid");
				oldstatus=rsoldstatus.getInt("oldstatus");
			}
			String strupdategate="update ws_gateinpass set processstatus="+oldstatus+" where doc_no="+gipdocno;
			int updategate=stmt.executeUpdate(strupdategate);
			// System.out.println(updategate+"strupdategate ====== "+strupdategate);
			if(updategate<=0){
				errorstatus=1;
			}
			String strmaxdoc="select doc_no maxdoc from ws_vehrelease where gatedocno="+gipdocno;
			ResultSet rsmaxdoc=stmt.executeQuery(strmaxdoc);
			int maxdoc=0;
			while(rsmaxdoc.next()){
				maxdoc=rsmaxdoc.getInt("maxdoc");
			}
			String strupdaterelease="update ws_vehrelease set clstatus=1 where gatedocno="+gipdocno;
			int updaterelease=stmt.executeUpdate(strupdaterelease);
			System.out.println(updaterelease+" strupdategate ====== "+strupdaterelease );
			if(updaterelease<=0){
				errorstatus=1;
			}
			PreparedStatement stmtlog=conn.prepareStatement("insert into gl_biblog(doc_no, brhId, dtype, edate, userId, userNo, activity, ENTRY) values (?,?,?,now(),?,?,?,?)");
			 stmtlog.setInt(1,maxdoc);
			 stmtlog.setInt(2,brhid);
			 stmtlog.setString(3,"BWRV");
			 stmtlog.setString(4, userid);
			 stmtlog.setInt(5, 0);
			 stmtlog.setInt(6, 0);
			 stmtlog.setString(7, "E");
			 int log=stmtlog.executeUpdate();
			 if(log<=0){
				 errorstatus=1;
			 }
			 if(floormgmtconfig>0){
				if(oldstatus>=5){
					String strgetjobcard="select job.doc_no from ws_gateinpass gip left join ws_estm est on gip.doc_no=est.gipno left join ws_jobcard job on job.reftype='EST' and job.refno=est.doc_no where gip.doc_no="+gipdocno;
					int jobcarddocno=0;
					ResultSet rsgetjobcard=stmt.executeQuery(strgetjobcard);
					while(rsgetjobcard.next()){
						jobcarddocno=rsgetjobcard.getInt("doc_no");
					}
					String strupdatefloormgmt="update ws_floormgmtdata set completestatus=0 where jobdocno="+jobcarddocno;
					int updatefloormgmt=stmt.executeUpdate(strupdatefloormgmt);
					if(updatefloormgmt<=0){
						errorstatus=1;
					}	
				}
				
			}
			conn.close();
		 }
		
		if(gipdocno>0){
			docno=gipdocno+"";
			//Checking config for Auto Estimation & Job Card
			conn=objconn.getMyConnection();
			stmt=conn.createStatement();
			String straautoconfig="select (select method from gl_config where field_nme='wsAutoEst') autoconfig,(select cldocno from ws_gateinpass where doc_no="+docno+") cldocno";
			ResultSet rsautoconfig=stmt.executeQuery(straautoconfig);
			int autoconfig=0;
			int gatecldocno=0;
			while(rsautoconfig.next()){
				autoconfig=rsautoconfig.getInt("autoconfig");
				gatecldocno=rsautoconfig.getInt("cldocno");
			}
			if(autoconfig>0 && gatecldocno>0){
				ClsWSEstimationAliceDAO estdao=new ClsWSEstimationAliceDAO();
				ArrayList<String> sparepartsarray=new ArrayList();
				sparepartsarray.add("Consumables"+" :: "+"1"+" :: "+"0.0"+" :: "+"0.0"+" :: "+"0.0"+" :: "+"0.0"+" :: "+"0.0"+" :: "+"0.0"+" :: "+"Genuine"+" :: "+"0.0"+" :: "+"0.0");
				int estinsert=estdao.insert(gipdocno+"", "0.0", "0.0", "0.0", "0.0", sqldate, sparepartsarray, blankarray, session, request, "A", 
						"EST", branchid, "0.0", "0.0", "0.0", "0", "0.0");
				
				if(estinsert>0){
					String estvocno=request.getAttribute("WSESTVOCNO").toString();
					boolean estedit=estdao.edit(gipdocno+"","0.0", "0.0", "0.0", "0.0", sqldate, sparepartsarray, blankarray, session, request, "E", "EST", branchid, 
							estinsert+"", estvocno, "0.0", "0.0", "0.0", "0", "0.0");
					if(estedit){
						boolean estconfirm=appdao.confirmEstimation(estinsert,"0","0","1",userid,branchid,conn);
						if(estconfirm){
							boolean estQuotation=appdao.QuotationApproval(estinsert, userid, branchid, conn);
							if(estQuotation){
								int jobdocno=jobdao.insert("EST",estinsert+"", sqldate, session, request, sqldate,"12:00", "A", 
										"JBC",branchid);
								if(jobdocno<0){
									System.out.println("Job Card Create Error");
									errorstatus=1;
								}
							}
							else{
								System.out.println("Quotation Approval Error");
								errorstatus=1;
							}
						}
						else{
							System.out.println("Confirm Estimation Error");	
							errorstatus=1;
						}
					}
					else{
						System.out.println("Estimation Edit Error");	
						errorstatus=1;
					}
				}
				else{
					System.out.println("Estimation Create Error");
				}
			}
			
			String strupdategip="update ws_gateinpass set appuserid="+userid+",clientname='"+clientdetails+"' where doc_no="+gipdocno;
			System.out.println(strupdategip);
			int updategip=stmt.executeUpdate(strupdategip);
			conn.close();	
		}
		else{
			errorstatus=1;
		}
	}
	else if(mode.equalsIgnoreCase("1")){
		conn=objconn.getMyConnection();
		conn.setAutoCommit(false);
		Statement stmt=conn.createStatement();
		ResultSet rsgetpath=stmt.executeQuery("select imgpath from my_comp where doc_no=1");
		while(rsgetpath.next()){
			imgpath=rsgetpath.getString("imgpath");
		}
		imgpath.replaceAll("//","////");
		String strupdategip="update ws_gateinpass set serviceadvisor="+cmbserviceadvisor+",kmin="+km+",fuel='"+fuel+"',backjob='"+chkbackjob+"',repairtype="+cmbrepairtype+" where doc_no="+docno;
		System.out.println(strupdategip);
		int updategip=stmt.executeUpdate(strupdategip);
		if(updategip<0){
			errorstatus=1;
		}
		//Updating Repairtype array
		for(int i=0;i<repairtypearray.size();i++){
			int repairdocno=Integer.parseInt(repairtypearray.get(i));
			String strinvinsert="insert into ws_giprepairtype(gipdocno,repairdocno,status)values("+docno+","+repairdocno+",3)";
			System.out.println(strinvinsert);
			int invinsert=stmt.executeUpdate(strinvinsert);
			if(invinsert<=0){
				errorstatus=1;
				break;
			}		
		}
		//System.out.println("Check:"+inventoryarray.size()+"::"+inventoryarray.get(0));
		for(int i=0;i<inventoryarray.size();i++){
			if(!inventoryarray.get(i).trim().equalsIgnoreCase("")){
				String invdocno=inventoryarray.get(i).split("::")[0];
				String value=inventoryarray.get(i).split("::")[1];
				String strinvinsert="insert into ws_gipinventory(gipdocno,invdocno,value)values("+docno+","+invdocno+","+value+")";
				int invinsert=stmt.executeUpdate(strinvinsert);
				if(invinsert<=0){
					errorstatus=1;
					break;
				}	
			}
		}
		if(errorstatus==0){
			conn.commit();
		}
		conn.close();
	}
	else if(mode.equalsIgnoreCase("2")){
		conn=objconn.getMyConnection();
		conn.setAutoCommit(false);
		Statement stmt=conn.createStatement();
		ResultSet rsgetpath=stmt.executeQuery("select imgpath from my_comp where doc_no=1");
		while(rsgetpath.next()){
			imgpath=rsgetpath.getString("imgpath");
		}
		imgpath.replaceAll("//","////");
		java.sql.Date sqlestdate=null;
		if(!date.equalsIgnoreCase("")){
			sqlestdate=objcommon.changeStringtoSqlDate(date);
		}
		
		String strupdategip="update ws_gateinpass set estdeldate='"+sqlestdate+"',estdeltime='"+time+"',mainremarks='"+remarks+"' where doc_no="+docno;
		System.out.println(strupdategip);
		int updategip=stmt.executeUpdate(strupdategip);
		System.out.println("Finish GIP Status:"+updategip);
		if(updategip<0){
			errorstatus=1;
		}
		for(int i=0;i<remarkarray.size();i++){
			if(!remarkarray.get(i).trim().equalsIgnoreCase("")){
				String strsql="insert into ws_gateinpassd (rdocno,srno,desc1,complaintid)values("+docno+",1,'"+remarkarray.get(i)+"',8)";
				System.out.println(strsql);
				int detailval=stmt.executeUpdate(strsql);
				if(detailval<=0){
					errorstatus=1;
				}
			}	
		}
		if(errorstatus==0){
			conn.commit();
		}
		conn.close();
	}
	
}
catch(Exception e){
	e.printStackTrace();
	errorstatus=1;
	File apperrorfile = new File(imgpath+"//attachment//app-errorlog.txt");
    if (apperrorfile.createNewFile()) {
    } else {
    }
    //FileWriter myWriter = new FileWriter("app-errorlog.txt");
    String currenterr="\n"+e.getMessage();
    Files.write(Paths.get(imgpath+"//attachment//app-errorlog.txt"),currenterr.getBytes(), StandardOpenOption.APPEND);
}
finally{
	if(conn!=null && conn.isClosed()==false){
		conn.close();
	}
}

response.getWriter().write(errorstatus+"::"+docno);
%>