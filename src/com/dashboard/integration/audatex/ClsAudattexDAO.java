package com.dashboard.integration.audatex;

import java.io.BufferedInputStream;
import java.io.InputStream;
import java.net.URL;
import java.net.URLConnection;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.*;

import javax.xml.parsers.*;

import java.io.*;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.workshop.wsestimationfancy.ClsWSEstimationFancyDAO;

import net.sf.json.JSONArray;

public class ClsAudattexDAO {

	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	public JSONArray getGateInPassData(String fromdate,String todate,String id)throws SQLException
	{
		JSONArray gatedata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return gatedata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			java.sql.Date sqlfromdate=null,sqltodate=null;
			if(!fromdate.equalsIgnoreCase("") && fromdate!=null){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
			}
			if(!todate.equalsIgnoreCase("") && todate!=null){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
			}
			String sqltest="";
			if(sqlfromdate!=null){
				sqltest+=" and gate.date>='"+sqlfromdate+"'";
			}
			if(sqltodate!=null){
				sqltest+=" and gate.date<='"+sqltodate+"'";
			}
			Statement stmt=conn.createStatement();
			String strsql="select coalesce(gate.assessmentno,'') assessmentno,gate.username inuser,br.doc_no brhid,br.branchname branch,gate.voc_no,gate.doc_no,gate.date,ac.cldocno,ac.refname,gate.regno,"+
			" gate.pltid plate,concat(coalesce(brd.brand_name,''),' ',coalesce(model.vtype,'')) flname,gate.other chassis,yom.yom,gate.kmin inkm,"+
			" CASE WHEN gate.fuel=0.000 THEN 'Level 0/8' WHEN gate.fuel=0.125 THEN 'Level 1/8' WHEN gate.fuel=0.250 THEN 'Level 2/8' WHEN "+
			" gate.fuel=0.375 THEN 'Level 3/8' WHEN gate.fuel=0.500 THEN 'Level 4/8' WHEN gate.fuel=0.625 THEN 'Level 5/8'  WHEN gate.fuel=0.750 "+
			" THEN 'Level 6/8' WHEN gate.fuel=0.875 THEN 'Level 7/8' WHEN gate.fuel=1.000 THEN 'Level 8/8' END as infuel from ws_gateinpass gate "+
			" left join my_acbook ac on (gate.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_vehbrand brd on (gate.brdid=brd.doc_no) "+
			" left join gl_vehmodel model on (gate.modid=model.doc_no) left join gl_yom yom on gate.yom=yom.doc_no left join my_brch br on "+
			" gate.brhid=br.doc_no where gate.status=3 and gate.processstatus=1 "+sqltest+" order by gate.doc_no";
			System.out.println(strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			gatedata=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return gatedata;
	}
	
	
	public int downloadXMLData(String gatedocno,String assessmentno) throws SQLException{
		int maxdocno=0;
		int maxsparedocno=0;
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmt=conn.createStatement();
			/*String strupdate="update ws_gateinpass set assessmentno='"+assessmentno+"' where doc_no="+gatedocno;
			System.out.println("Update Query:"+strupdate);
			int updateval=stmt.executeUpdate(strupdate);
			if(updateval<0){
				return 0;
			}*/
			String dataurl="";
			java.sql.Date currentdate=null;
			ArrayList<String> xmlarray=new ArrayList<>();
			ArrayList<String> xmlpartsarray=new ArrayList<>();
			/*String strgeturl="select imgPath,curdate() currentdate from my_comp where status=3";
			ResultSet rsgeturl=stmt.executeQuery(strgeturl);
			while(rsgeturl.next()){
				dataurl=rsgeturl.getString("imgPath");
				currentdate=rsgeturl.getDate("currentdate");
			}*/
			String strgeturl="select path,curdate() currentdate from my_fileattach where doc_no="+gatedocno+" and dtype='ADT'";
			ResultSet rsgeturl=stmt.executeQuery(strgeturl);
			while(rsgeturl.next()){
				dataurl=rsgeturl.getString("path");
				currentdate=rsgeturl.getDate("currentdate");
			}
			System.out.println("URL:"+dataurl);
			if(dataurl.equalsIgnoreCase("")){
				System.out.println("Attachment Not Available");
				return 0;
			}
			/*int rowlength=0;
			String strrowlength="select count(*) rowlength from gl_gpsdata";
			ResultSet rsrowlength=stmt.executeQuery(strrowlength);
			while(rsrowlength.next()){
				rowlength=rsrowlength.getInt("rowlength");
			}
			if(rowlength>=5000){
				String strdeleterows="delete from gl_gpsdata order by srno asc limit 2000";
				int deleteval=stmt.executeUpdate(strdeleterows);
			}*/
			/*URL url = new URL(dataurl);
			 URLConnection urlConnection = url.openConnection();
			 InputStream in = new BufferedInputStream(urlConnection.getInputStream());

			 //your code
			 DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
			 DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
			 Document doc = dBuilder.parse( in );*/
			DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
			DocumentBuilder builder = factory.newDocumentBuilder();
			 
			//Build Document
			Document doc = builder.parse(new File(dataurl));
			    
				//optional, but recommended
				//read this - http://stackoverflow.com/questions/13786607/normalization-in-dom-parsing-with-java-how-does-it-work
				doc.getDocumentElement().normalize();

				System.out.println("Root element :" + doc.getDocumentElement().getNodeName());

				NodeList nList = doc.getElementsByTagName("CalculationItem");

				System.out.println("----------------------------"+nList.getLength());

				for (int temp = 0; temp < nList.getLength(); temp++) {

					Node nNode = nList.item(temp);

					System.out.println("\nCurrent Element :" + nNode.getNodeName());

					if (nNode.getNodeType() == Node.ELEMENT_NODE) {

						Element eElement = (Element) nNode;
						String type=eElement.getAttribute("xsi:type");
						System.out.println("Type:"+type);
						String code=eElement.getElementsByTagName("CodeText").item(0)==null?"":eElement.getElementsByTagName("CodeText").item(0).getTextContent();
						String desc=eElement.getElementsByTagName("DescriptionText").item(0)==null?"":eElement.getElementsByTagName("DescriptionText").item(0).getTextContent();
						String workunit=eElement.getElementsByTagName("WUCount").item(0)==null?"":eElement.getElementsByTagName("WUCount").item(0).getTextContent();
						String amount=eElement.getElementsByTagName("Amount").item(0)==null?"0.0":eElement.getElementsByTagName("Amount").item(0).getTextContent();
						System.out.println(code+"::"+desc+"::"+workunit);
						xmlarray.add(type+"::"+code+"::"+desc+"::"+workunit+"::"+amount);
					}
				}
				ArrayList<String> preparray=new ArrayList<>();
				preparray.add("PrepWorkPlasticWU::Preparation Work Plastic");
				preparray.add("PrepWorkMultilayerWU::Preparation Work Multi Layer");
				preparray.add("PrepInCaseofPrepaint::Preparation for Pre-Painting");
				for(int i=0;i<preparray.size();i++){
					String workunit=doc.getElementsByTagName(preparray.get(i).split("::")[0]).item(0)==null?"":doc.getElementsByTagName(preparray.get(i).split("::")[0]).item(0).getTextContent();
					xmlarray.add("LabourType"+"::"+""+"::"+preparray.get(i).split("::")[1]+"::"+workunit+"::"+0.0);
				}
				
				nList = doc.getElementsByTagName("Part");
				
				for (int temp = 0; temp < nList.getLength(); temp++) {

					Node nNode = nList.item(temp);

					System.out.println("\nCurrent Element :" + nNode.getNodeName());

					if (nNode.getNodeType() == Node.ELEMENT_NODE) {

						Element eElement = (Element) nNode;
						String type=eElement.getAttribute("xsi:type");
						if(type.equalsIgnoreCase("ValidPartType")){
							String amount=eElement.getElementsByTagName("Amount").item(0)==null?"0.0":eElement.getElementsByTagName("Amount").item(0).getTextContent();
							String desc=eElement.getElementsByTagName("DescriptionText").item(0)==null?"":eElement.getElementsByTagName("DescriptionText").item(0).getTextContent();
							String partnumber=eElement.getElementsByTagName("PartNumber").item(0)==null?"":eElement.getElementsByTagName("PartNumber").item(0).getTextContent();
							String qty=eElement.getElementsByTagName("RequiredQuantity").item(0)==null?"0":eElement.getElementsByTagName("RequiredQuantity").item(0).getTextContent();
							xmlpartsarray.add(type+"::"+partnumber+"::"+desc+"::"+qty+"::"+amount);
						}
					}
				}
			int error=0;	
			//Inserting Data
			String strdelete="delete from ws_assessmentdata where gatedocno="+gatedocno;
			int deleteval=stmt.executeUpdate(strdelete);
			String strdeletespare="delete from ws_assessmentsparedata where gatedocno="+gatedocno;
			int deletespareval=stmt.executeUpdate(strdeletespare);
			String strmaxdocno="select coalesce(max(doc_no)+1,1) maxdocno from ws_assessmentdata";
			ResultSet  rsmaxdocno=stmt.executeQuery(strmaxdocno);
			while(rsmaxdocno.next()){
				maxdocno=rsmaxdocno.getInt("maxdocno");
			}
			String strmaxsparedocno="select coalesce(max(doc_no)+1,1) maxdocno from ws_assessmentsparedata";
			ResultSet  rsmaxsparedocno=stmt.executeQuery(strmaxsparedocno);
			while(rsmaxsparedocno.next()){
				maxsparedocno=rsmaxsparedocno.getInt("maxdocno");
			}
			for(int i=0,j=1;i<xmlpartsarray.size();i++,j++){
				String temp[]=xmlpartsarray.get(i).split("::");
				String strinsert="insert into ws_assessmentsparedata(doc_no, srno, gatedocno, partno, desc1, qty, amount, type)values("+maxsparedocno+","+
			" "+j+","+gatedocno+",'"+temp[1]+"','"+temp[2]+"',"+temp[3]+","+temp[4]+",'"+temp[0]+"')";
				System.out.println("insert query:"+strinsert);
				int insertval=stmt.executeUpdate(strinsert);
				if(insertval<=0){
					error=1;
					break;
				}
			}
			for(int i=0;i<xmlarray.size();i++){
			
				String temp[]=xmlarray.get(i).split("::");
				String strjobtypecount="select count(*) jobtypecount,coalesce(doc_no,0) jobtypedocno from ws_jobtype where status=3 and type='"+temp[0]+"'";
//				System.out.println("Type Check"+strjobtypecount);
				ResultSet rsjobtypecount=stmt.executeQuery(strjobtypecount);
				int jobtypecount=0,jobtypedocno=0;
				while(rsjobtypecount.next()){
					jobtypecount=rsjobtypecount.getInt("jobtypecount");
					jobtypedocno=rsjobtypecount.getInt("jobtypedocno");
				}
				if(jobtypecount==0){
					String strjobtypemaxdocno="select max(coalesce(doc_no,1))+1 maxdocno from ws_jobtype";
					ResultSet rsjobtymaxdoc=stmt.executeQuery(strjobtypemaxdocno);
					while(rsjobtymaxdoc.next()){
						jobtypedocno=rsjobtymaxdoc.getInt("maxdocno");
					}
					String strinsertjobtype="insert into ws_jobtype(doc_no, type, status)values("+jobtypedocno+",'"+temp[0]+"',3)";
					int insertjobtype=stmt.executeUpdate(strinsertjobtype);
					if(insertjobtype<0){
						error=1;
						break;
					}
				}
				String code=temp[1];
				String desc=temp[2];
				String strrepaircount="";
				int repaircount=0,repairdocno=0;
				if(!code.equalsIgnoreCase("") && code.equalsIgnoreCase("undefined") && code!=null){
					strrepaircount="select count(*) repaircount,coalesce(doc_no,0) repairdocno from ws_jobmaster where code='"+code+"'";
				}
				else{
					strrepaircount="select count(*) repaircount,coalesce(doc_no,0) repairdocno from ws_jobmaster where desc1='"+desc+"'";
				}
				// System.out.println("===="+strrepaircount);
				ResultSet rsrepaircount=stmt.executeQuery(strrepaircount);
				while(rsrepaircount.next()){
					repaircount=rsrepaircount.getInt("repaircount");
					repairdocno=rsrepaircount.getInt("repairdocno");
				}
				if(repaircount==0){
					String strrepairmaxdocno="select max(coalesce(doc_no,1))+1 maxdocno from ws_jobmaster";
					ResultSet rsjobmaxdocno=stmt.executeQuery(strrepairmaxdocno);
					while(rsjobmaxdocno.next()){
						repairdocno=rsjobmaxdocno.getInt("maxdocno");
					}
					String strinsertjobtype="insert into ws_jobmaster(doc_no, date, jobid, desc1, status,code)values("+
					" "+repairdocno+",'"+currentdate+"',"+jobtypedocno+",'"+desc+"',3,'"+code+"')";
					int insertjobtype=stmt.executeUpdate(strinsertjobtype);
					if(insertjobtype<0){
						error=1;
						break;
					}
				}
				String strinsert="insert into ws_assessmentdata(gatedocno, jobtypedocno, code, desc1, workunit, status, doc_no,amount)values("+gatedocno+","+repairdocno+",'"+temp[1]+"','"+temp[2]+"','"+temp[3]+"',3,"+maxdocno+","+temp[4]+")";
				System.out.println("insert query:"+strinsert);
				int insertval=stmt.executeUpdate(strinsert);
				if(insertval<=0){
					error=1;
					break;
				}
			}
			if(error==1){
				return 0;
			}
			else{
				conn.commit();
				return maxdocno;
			}
			
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return maxdocno;
	}
	
	
	public JSONArray getAssessmentRepairData(String gatedocno,String id) throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strgetworkunit="select method,coalesce(value,0) value from gl_config where field_nme='WSWorkUnit'";
			ResultSet rsgetworkunit=stmt.executeQuery(strgetworkunit);
			int workunitmethod=0;
			int workunit=1;
			while(rsgetworkunit.next()){
				workunitmethod=rsgetworkunit.getInt("method");
				if(workunitmethod==1){
					workunit=rsgetworkunit.getInt("value");
				}
			}
			String strsql="select 0.0 markuppercent,job.doc_no jobid,jt.type jobtype,ass.code,ass.desc1 jobdesc,ass.workunit,ass.workunit/"+workunit+" hrs,ass.amount rate from ws_assessmentdata ass left join ws_jobmaster job on ass.jobtypedocno=job.doc_no left join ws_jobtype jt on job.jobid=jt.doc_no where ass.gatedocno="+gatedocno;
			ResultSet rs=stmt.executeQuery(strsql);
			data=objcommon.convertToJSON(rs);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return data;
	}
	
	
	public JSONArray getAssessmentSpareData(String docno,String id) throws SQLException
	{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select desc1 description,qty,amount genuinerate, 0.0 marketrate, 0.0 usedrate, qty*amount genuinetotal, 0.0 "+
			" markettotal, 0.0 usedtotal from ws_assessmentsparedata where gatedocno="+docno;
			ResultSet rs=stmt.executeQuery(strsql);
			data=objcommon.convertToJSON(rs);
			
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		return data;
	}


	public int createEst(String gatedocno, ArrayList<String> labourarray,
			ArrayList<String> partarray, HttpSession session, HttpServletRequest request) throws SQLException {
		// TODO Auto-generated method stub
		int vocno=0;
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			ClsWSEstimationFancyDAO estdao=new ClsWSEstimationFancyDAO();
			Statement stmt=conn.createStatement();
			String strgetdata="select brhid,curdate() sqldate from ws_gateinpass where doc_no="+gatedocno;
			ResultSet rsgetdata=stmt.executeQuery(strgetdata);
			String brhid="";
			java.sql.Date sqldate=null;
			while(rsgetdata.next()){
				brhid=rsgetdata.getString("brhid");
				sqldate=rsgetdata.getDate("sqldate");
			}
			
			double labourtotal=0.0;
			for(int i=0;i<labourarray.size();i++){
				labourtotal+=Double.parseDouble(labourarray.get(i).split("::")[4]);
			}
			double sparetotal=0.0;
			for(int i=0;i<partarray.size();i++){
				sparetotal+=Double.parseDouble(partarray.get(i).split("::")[5]);
			}
			String strprivilagedata="select prv.sparemarkup,prv.labdiscount from ws_gateinpass gate left join my_acbook ac on (gate.cldocno=ac.cldocno and "+
			" ac.dtype='CRM') left join my_clprivilage prv on ac.privillege=prv.doc_no where gate.status=3 and gate.doc_no="+gatedocno;
			ResultSet rsprivilage=stmt.executeQuery(strprivilagedata);
			double sparemarkup=0.0,labdiscount=0.0;
			while(rsprivilage.next()){
				sparemarkup=rsprivilage.getDouble("sparemarkup");
				labdiscount=rsprivilage.getDouble("labdiscount");
			}
			double labourdiscount=labourtotal*labdiscount;
			double labournettotal=labourtotal-labourdiscount;
			sparetotal=sparetotal+(sparetotal*sparemarkup);
			double esttotal=0.0;
			esttotal=sparetotal+labournettotal;
			int value=estdao.insert(gatedocno, sparetotal+"", labourtotal+"", "0.0", esttotal+"", sqldate, partarray, 
					labourarray, session, request, "A", "EST", brhid, labourdiscount+"", labourtotal+"", labournettotal+"", "0",
					"0.0" ,sparetotal+"", "0.0", sparetotal+"");

			if(value>0){
				String strgetvocno="select voc_no from ws_estm where doc_no="+value;
				ResultSet rsgetvocno=stmt.executeQuery(strgetvocno);
				while(rsgetvocno.next()){
					vocno=rsgetvocno.getInt("voc_no");
				}
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return vocno;
	}
}
