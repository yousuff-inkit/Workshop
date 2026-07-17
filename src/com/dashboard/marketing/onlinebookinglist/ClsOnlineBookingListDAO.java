package com.dashboard.marketing.onlinebookinglist;


import net.sf.json.JSONArray;

import java.sql.*;
import java.util.ArrayList;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsOnlineBookingListDAO {

	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	
	public JSONArray getOnlineBookingList(String fromdate,String todate,String id) throws SQLException{
		JSONArray booklistdata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return booklistdata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			java.sql.Date sqlfromdate=null;
			java.sql.Date sqltodate=null;
			if(!fromdate.equalsIgnoreCase("")){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
			}
			if(!todate.equalsIgnoreCase("")){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
			}
			String sqltest="";
			if(sqlfromdate!=null){
				sqltest+=" and date(book.fromdt)>='"+sqlfromdate+"'";
			}
			if(sqltodate!=null){
				sqltest+=" and date(book.fromdt)<='"+sqltodate+"'";
			}
			
			String strsql="select book.tarifdoc tarifdocno,book.clientid cldocno,veh.fleetname,concat(cldoc.fname,' ',cldoc.lname) refname,book.idbooking bookdocno,book.clientid cldocno,date(book.fromdt) fromdate,date(book.todt) "+
			" todate,book.fromloc,book.toloc,renttype,book.booking_net_value netamt from sayara_online.booking book left join sayara_online.client cldoc on"+
			" (book.clientid=cldoc.idclient) left join sayara_online.vehmaster veh on book.vehid=veh.srno left join gl_bookingm m on m.onlinebookdocno=book.idbooking where 1=1 and m.onlinebookdocno is null "+sqltest;
			System.out.println(strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			booklistdata=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return booklistdata;
	}

	public ArrayList<String> getTariffArray(String fleetname,
			String tarifdocno, String renttype, String onlinebookdocno) throws SQLException{
		// TODO Auto-generated method stub
		ArrayList<String> tarifarray=new ArrayList<>();
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			int vehid=0;
			int maintarifdocno=0,days=0,type=0;
			double tarifamt=0.0,discount=0.0;
			int tarifdoc=0;
			String strgroup="select book.tariff rate,tarif.tariff tarifrate,book.vehid,tarif.idvehtariff maintarifdocno,tarif.tarifdoc,if(datediff(todt,fromdt)=0,1,datediff(todt,fromdt)) days,if(book.renttype='daily',1,if(book.renttype='weekly',7,if(book.renttype='Monthly',30,1))) type from sayara_online.booking book left join sayara_online.vehtariff tarif on"+
			" book.idvehtariff=tarif.idvehtariff where book.idbooking="+onlinebookdocno+" group by book.idbooking";
			
			ResultSet rsgroup=stmt.executeQuery(strgroup);
			while(rsgroup.next()){
				vehid=rsgroup.getInt("vehid");
				maintarifdocno=rsgroup.getInt("maintarifdocno");
				tarifdoc=rsgroup.getInt("tarifdoc");
				tarifamt=rsgroup.getDouble("rate");
				// tarifamt=rsgroup.getDouble("tarifrate");
				days=rsgroup.getInt("days");
				type=rsgroup.getInt("type");
				discount=(tarifamt-(rsgroup.getDouble("tarifrate")*(days/type)))/(days/type);
				tarifamt=rsgroup.getDouble("tarifrate")-(tarifamt/type);
			}
			double tarif5=0.0,cdw5=0.0,pai5=0.0,scdw5=0.0,gps5=0.0,cseat5=0.0,vmd5=0.0,kmrest5=0.0,kmrate5=0.0,chauffer5=0.0,ins_excess5=0.0;
			double tarif7=0.0,cdw7=0.0,pai7=0.0,scdw7=0.0,gps7=0.0,cseat7=0.0,vmd7=0.0,kmrest7=0.0,kmrate7=0.0,chauffer7=0.0,ins_excess7=0.0;
			double tarif6=0.0,cdw6=0.0,pai6=0.0,scdw6=0.0,gps6=0.0,cseat6=0.0,vmd6=0.0,kmrest6=0.0,kmrate6=0.0,chauffer6=0.0,ins_excess6=0.0;
			double selectedtarif=0.0,selectedcdw=0.0,selectedpai=0.0,selectedscdw=0.0,selectedgps=0.0,selectedcseat=0.0,selectedvmd=0.0,selectedkmrest=0.0,selectedkmrate=0.0,selectedchauffer=0.0,selectedins_excess=0.0;
			String strselectedtarif="select RENTTYPE,TARIFF,CDW,PAI,SCDW,GPS,CSEAT,VMD,KMREST,KMRATE,CHAUFFER,0.0 ins_excess from sayara_online.booking where idbooking="+onlinebookdocno;
			ResultSet rsselectedtarif=stmt.executeQuery(strselectedtarif);
			while(rsselectedtarif.next()){
				selectedtarif=rsselectedtarif.getDouble("tariff");
				selectedcdw=rsselectedtarif.getDouble("cdw");
				selectedpai=rsselectedtarif.getDouble("pai");
				selectedscdw=rsselectedtarif.getDouble("scdw");
				selectedgps=rsselectedtarif.getDouble("gps");
				selectedcseat=rsselectedtarif.getDouble("cseat");
				selectedvmd=rsselectedtarif.getDouble("vmd");
				selectedkmrest=rsselectedtarif.getDouble("kmrest");
				selectedkmrate=rsselectedtarif.getDouble("kmrate");
				selectedchauffer=rsselectedtarif.getDouble("chauffer");
				selectedins_excess=rsselectedtarif.getDouble("ins_excess");
			}
			String strtarif="select * from ("+
			" select case when renttype='Daily' then 1 when renttype='Weekly' then 2 when renttype='Monthly' then 3 else 0 end rstatus,"+
			" renttype,tariff,cdw,pai,scdw,gps,cseat,vmd,kmrest,kmrate,chauffer,ins_excess from sayara_online.vehtariff where tarifdoc="+tarifdoc+" and vehid="+vehid+" union all"+
			" select 5 rstatus,renttype,tariff,cdw,pai,scdw,gps,cseat,vmd,kmrest,kmrate,chauffer,ins_excess from sayara_online.vehtariff where tarifdoc="+tarifdoc+""+
			" and vehid="+vehid+" and renttype='"+renttype+"'  union all"+
			" select 7 rstatus,RENTTYPE,TARIFF,CDW,PAI,SCDW,GPS,CSEAT,VMD,KMREST,KMRATE,CHAUFFER,0.0 ins_excess from sayara_online.booking where idbooking="+onlinebookdocno+") a order by a.rstatus";
			System.out.println(strtarif);
			ResultSet rs=stmt.executeQuery(strtarif);
			while(rs.next()){
				String temp="";
				if(rs.getString("rstatus").equalsIgnoreCase("1") || rs.getString("rstatus").equalsIgnoreCase("2") || rs.getString("rstatus").equalsIgnoreCase("3")){
					temp=rs.getString("renttype")+" :: "+rs.getDouble("tariff")+" :: "+rs.getDouble("cdw")+" :: "+rs.getDouble("pai")+" :: "+rs.getDouble("scdw")+" :: "+0.0+" :: "+rs.getDouble("gps")+" :: "+rs.getDouble("cseat")+" :: "+rs.getDouble("vmd")+" :: "+rs.getDouble("kmrest")+" :: "+rs.getDouble("kmrate")+" :: "+rs.getDouble("ins_excess")+" :: "+0.0+" :: "+rs.getDouble("chauffer")+" :: "+0.0+" :: "+rs.getDouble("rstatus")+" :: ";
					tarifarray.add(temp);
				}
				else if(rs.getString("rstatus").equalsIgnoreCase("5")){
					tarif5=selectedtarif>0.0?rs.getDouble("tariff"):0.0;
					cdw5=selectedcdw>0.0?rs.getDouble("cdw"):0.0;
					pai5=selectedpai>0.0?rs.getDouble("pai"):0.0;
					scdw5=selectedscdw>0.0?rs.getDouble("scdw"):0.0;
					gps5=selectedgps>0.0?rs.getDouble("gps"):0.0;
					cseat5=selectedcseat>0.0?rs.getDouble("cseat"):0.0;
					vmd5=selectedvmd>0.0?rs.getDouble("vmd"):0.0;
					kmrest5=selectedkmrest>0.0?rs.getDouble("kmrest"):0.0;
					kmrate5=selectedkmrate>0.0?rs.getDouble("kmrate"):0.0;
					chauffer5=selectedchauffer>0.0?rs.getDouble("chauffer"):0.0;
					ins_excess5=selectedins_excess>0.0?rs.getDouble("ins_excess"):0.0;
					temp=rs.getString("renttype")+" :: "+tarif5+" :: "+cdw5+" :: "+pai5+" :: "+scdw5+" :: "+0.0+" :: "+gps5+" :: "+cseat5+" :: "+vmd5+" :: "+kmrest5+" :: "+kmrate5+" :: "+chauffer5+" :: "+0.0+" :: "+ins_excess5+" :: "+0.0+" :: "+rs.getDouble("rstatus")+" :: ";
					tarifarray.add(temp);
				}
				else if(rs.getString("rstatus").equalsIgnoreCase("7")){
					/*tarif7=rs.getDouble("tariff");
					cdw7=rs.getDouble("cdw");
					pai7=rs.getDouble("pai");
					scdw7=rs.getDouble("scdw");
					gps7=rs.getDouble("gps");
					cseat7=rs.getDouble("cseat");
					vmd7=rs.getDouble("vmd");
					kmrest7=rs.getDouble("kmrest");
					kmrate7=rs.getDouble("kmrate");
					chauffer7=rs.getDouble("chauffer");
					ins_excess7=rs.getDouble("ins_excess");*/
				}
			}
			/*
			 * Setting Default 0 to discount
			 * */
/*			tarif6=tarif7-tarif5;
			cdw6=cdw7-cdw6;
			pai6=pai7-pai5;
			scdw6=scdw7-scdw5;
			gps6=gps7-gps5;
			cseat6=cseat7-cseat5;
			vmd6=vmd7-vmd5;
			kmrest6=0.0;
			kmrate6=0.0;
			chauffer6=chauffer7-chauffer5;
			ins_excess6=ins_excess7-ins_excess5;*/
			tarifarray.add("Discount"+" :: "+(-discount)+" :: "+cdw6+" :: "+pai6+" :: "+scdw6+" :: "+0.0+" :: "+gps6+" :: "+cseat6+" :: "+vmd6+" :: "+kmrest6+" :: "+kmrate6+" :: "+ins_excess6+" :: "+0.0+" :: "+chauffer6+" :: "+0.0+" :: "+6+" :: ");
			tarifarray.add("Net Total"+" :: "+(tarif5+discount)+" :: "+cdw5+" :: "+pai5+" :: "+scdw5+" :: "+0.0+" :: "+gps5+" :: "+cseat5+" :: "+vmd5+" :: "+kmrest5+" :: "+kmrate5+" :: "+ins_excess5+" :: "+0.0+" :: "+chauffer5+" :: "+0.0+" :: "+7+" :: ");
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return tarifarray;
	}

	public int updateOnlineDocno(int val, String onlinebookdocno) throws SQLException{
		// TODO Auto-generated method stub
		Connection conn=null;
		int updateval=0;
		try{
			conn=objconn.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmt=conn.createStatement();
			updateval=stmt.executeUpdate("update gl_bookingm set refno="+onlinebookdocno+" ,onlinebookdocno="+onlinebookdocno+" where doc_no="+val);
			if(updateval>0){
				conn.commit();
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return updateval;
	}
	
		public boolean checkClientStatus(String lblclient, String lblhidclient, String onlinebookdocno) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			System.out.println("Client: "+lblclient);
			lblclient=lblclient==null?"":lblclient;
			if(!lblclient.equalsIgnoreCase("")){
				//Checking Client With my_acbook
				String strcheckclient="select ac.cldocno,ac.refname from sayara_online.booking book left join sayara_online.client cl on book.clientid=cl.idclient "+
				" left join my_acbook ac on (book.clientid=ac.cldocno and ac.refname=cl.fname) where cl.idclient="+lblhidclient+" and cl.fname='"+lblclient+"' and ac.status<>7";
				ResultSet rscheckclient=stmt.executeQuery(strcheckclient);
				String tempclient="",temphidclient="";
				while(rscheckclient.next()){
					temphidclient=rscheckclient.getString("cldocno");
					tempclient=rscheckclient.getString("refname");
				}
				if(temphidclient.equalsIgnoreCase(lblhidclient) && tempclient.equalsIgnoreCase(lblclient)){
					return true;
				}
				else{
					return false;
				}
				
			}
			else{
				return false;
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

	public ArrayList<String> getClientDetails(String onlinebookdocno) throws SQLException {
		// TODO Auto-generated method stub
		ArrayList<String> clientdetails=new ArrayList<>();
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strclientdetails="select coalesce(cl.title,0) title,coalesce(cl.fname,0) fname,coalesce(cl.address,0) address,coalesce(cl.email,0) email,"+
			" coalesce(cl.mobno,0) mobno,coalesce(cl.nationality,0) nationality,coalesce(cl.licno,0) licno,DATE_FORMAT(coalesce(cl.licexp,CURDATE()), '%d.%m.%Y') licexp,coalesce(cl.licplace,0) "+
			" licplace,coalesce(cl.passno,0) passno,DATE_FORMAT(coalesce(cl.passexp,CURDATE()), '%d.%m.%Y') passexp from sayara_online.booking book left join sayara_online.client cl on "+
			" book.clientid=cl.idclient where book.idbooking="+onlinebookdocno;
			System.out.println(strclientdetails);
			ResultSet rs=stmt.executeQuery(strclientdetails);
			while(rs.next()){
				clientdetails.add(rs.getString("title"));
				clientdetails.add(rs.getString("fname"));
				clientdetails.add(rs.getString("address"));
				clientdetails.add(rs.getString("email"));
				clientdetails.add(rs.getString("mobno"));
				clientdetails.add(rs.getString("nationality"));
				clientdetails.add(rs.getString("licno"));
				clientdetails.add(rs.getString("licexp"));
				clientdetails.add(rs.getString("licplace"));
				clientdetails.add(rs.getString("passno"));
				clientdetails.add(rs.getString("passexp"));
			}
			stmt.close();
			
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return clientdetails;
	}

	public ArrayList<String> getVehicleDetails(String onlinebookdocno) throws SQLException {
		// TODO Auto-generated method stub
		ArrayList<String> vehiclearray=new ArrayList<>();
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			int vehid=0;
			String strgroup="select book.vehid from sayara_online.booking book where book.idbooking="+onlinebookdocno+" group by book.idbooking";
			ResultSet rsgroup=stmt.executeQuery(strgroup);
			while(rsgroup.next()){
				vehid=rsgroup.getInt("vehid");
			}
			String strvehicle="select brdid brand,modid model,grpid groupid from sayara_online.vehmaster where srno="+vehid;
			ResultSet rsvehicle=stmt.executeQuery(strvehicle);
			while(rsvehicle.next()){
				vehiclearray.add(rsvehicle.getString("brand"));
				vehiclearray.add(rsvehicle.getString("model"));
				vehiclearray.add(rsvehicle.getString("groupid"));
			}
			String strtarifdoc="select tarif.tarifdoc from sayara_online.booking book left join sayara_online.vehtariff tarif on"+
			" book.idvehtariff=tarif.idvehtariff where book.idbooking="+onlinebookdocno+" group by book.idbooking";
			ResultSet rstarif=stmt.executeQuery(strtarifdoc);
			while(rstarif.next()){
				vehiclearray.add(rstarif.getInt("tarifdoc")+"");
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return vehiclearray;
	}

}
