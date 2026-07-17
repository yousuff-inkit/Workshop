package com.dashboard.integration.gps;

import java.sql.*;
import java.util.ArrayList;
import java.io.BufferedInputStream;
import java.io.File;
import java.io.InputStream;
import java.net.URL;
import java.net.URLConnection;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import net.sf.json.JSONArray;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import com.common.ClsCommon;
import com.connection.ClsConnection;
public class ClsGPSDAO {
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	public int downloadXMLData() throws SQLException{
		int maxdocno=0;
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmt=conn.createStatement();
			String gpsurl="";
			ArrayList<String> xmlarray=new ArrayList<>();
			String strgeturl="select gpsurl from my_comp where status=3";
			ResultSet rsgeturl=stmt.executeQuery(strgeturl);
			while(rsgeturl.next()){
				gpsurl=rsgeturl.getString("gpsurl");
			}
			int rowlength=0;
			String strrowlength="select count(*) rowlength from gl_gpsdata";
			ResultSet rsrowlength=stmt.executeQuery(strrowlength);
			while(rsrowlength.next()){
				rowlength=rsrowlength.getInt("rowlength");
			}
			if(rowlength>=5000){
				String strdeleterows="delete from gl_gpsdata order by srno asc limit 2000";
				int deleteval=stmt.executeUpdate(strdeleterows);
			}
			URL url = new URL(gpsurl);
			 URLConnection urlConnection = url.openConnection();
			 InputStream in = new BufferedInputStream(urlConnection.getInputStream());

			 //your code
			 DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
			 DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
			 Document doc = dBuilder.parse( in );
			    
				//optional, but recommended
				//read this - http://stackoverflow.com/questions/13786607/normalization-in-dom-parsing-with-java-how-does-it-work
				doc.getDocumentElement().normalize();

				System.out.println("Root element :" + doc.getDocumentElement().getNodeName());

				NodeList nList = doc.getElementsByTagName("MovementData");

				System.out.println("----------------------------"+nList.getLength());

				for (int temp = 0; temp < nList.getLength(); temp++) {

					Node nNode = nList.item(temp);

					System.out.println("\nCurrent Element :" + nNode.getNodeName());

					if (nNode.getNodeType() == Node.ELEMENT_NODE) {

						Element eElement = (Element) nNode;
						String strplatecode=eElement.getElementsByTagName("PlateNo").item(0).getTextContent();
						String strkm=eElement.getElementsByTagName("Odo").item(0).getTextContent();
						String strdatetime=eElement.getElementsByTagName("LocationTimeStamp").item(0).getTextContent();
						xmlarray.add(strplatecode+"::"+strkm+"::"+strdatetime);
					}
				}
				
				
			//Inserting Data
			String strmaxdocno="select coalesce(max(doc_no)+1,1) maxdocno from gl_gpsdata";
			ResultSet  rsmaxdocno=stmt.executeQuery(strmaxdocno);
			while(rsmaxdocno.next()){
				maxdocno=rsmaxdocno.getInt("maxdocno");
			}
			int error=0;
			for(int i=0;i<xmlarray.size();i++){
				String temp=xmlarray.get(i);
				System.out.println(temp);
				String authority=temp.split("::")[0].split(" ")[0];
				String regno=temp.split("::")[0].split(" ")[1].split("-")[0];
				String platecode=temp.split("::")[0].split("-")[1];
				String km=temp.split("::")[1];
				String strdatetime=temp.split("::")[2];
				String temptimestamp=strdatetime.substring(0, 4)+"-"+strdatetime.substring(4, 6)+"-"+strdatetime.substring(6, 8)+" "+strdatetime.substring(8, 10)+":"+strdatetime.substring(10, 12);
				String strinsert="insert into gl_gpsdata(doc_no,auth,regno,plate,km,gpsdatetime)values("+maxdocno+",'"+authority+"',"+regno+",'"+platecode+"',"+km+",'"+temptimestamp+"')";
				System.out.println(strinsert);
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
		return maxdocno;
	}
	
	public JSONArray getDownloadData(String docno,String id,String fromdate,String todate) throws SQLException{
		JSONArray downloaddata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return downloaddata;
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
				sqltest+=" and date(gps.gpsdatetime)>='"+sqlfromdate+"'";
			}
			if(sqltodate!=null){
				sqltest+=" and date(gps.gpsdatetime)<='"+sqltodate+"'";
			}
			String str="";
			if(!docno.equalsIgnoreCase("") && docno!=null){
				str="select convert(concat(gps.auth,' ',gps.regno,'-',gps.plate),char(50)) plateinfo,veh.fleet_no,veh.flname,gps.regno reg_no,"+
						" gps.gpsdatetime,veh.calibrationkm,gps.km gpskm,coalesce(veh.calibrationkm,0)+coalesce(gps.km,0) totalkm from  gl_gpsdata gps left join gl_vehmaster veh"+
						" on gps.regno=veh.reg_no left join gl_vehplate plt on (veh.pltid=plt.doc_no and gps.plate=plt.code_name) where gps.status=3 and gps.doc_no="+docno;
			}
			else {
				str="select convert(concat(gps.auth,' ',gps.regno,'-',gps.plate),char(50)) plateinfo,veh.fleet_no,veh.flname,gps.regno reg_no,"+
				" gps.gpsdatetime,veh.calibrationkm,gps.km gpskm,coalesce(veh.calibrationkm,0)+coalesce(gps.km,0) totalkm from  gl_gpsdata gps left join gl_vehmaster veh"+
				" on gps.regno=veh.reg_no left join gl_vehplate plt on (veh.pltid=plt.doc_no and gps.plate=plt.code_name) where gps.status=3"+sqltest;
			}
			 
			System.out.println(str);
			Statement stmt=conn.createStatement();
			ResultSet rs=stmt.executeQuery(str);
			downloaddata=objcommon.convertToJSON(rs);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return  downloaddata;
	}

	public boolean updateKm(String docno) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmt=conn.createStatement();
			String strupdate="update gl_gpsdata gps left join gl_vehmaster veh on gps.regno=veh.reg_no left join gl_vehplate"+
			" plt on veh.pltid=plt.doc_no and gps.plate=plt.code_name set veh.cur_km=gps.km,gps.updatestatus=1 where gps.doc_no="+docno+" and gps.updatestatus<>1";
			int update=stmt.executeUpdate(strupdate);
			if(update>0){
				conn.commit();
				return true;
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return false;
	}
}
