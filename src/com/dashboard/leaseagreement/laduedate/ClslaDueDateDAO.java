package com.dashboard.leaseagreement.laduedate;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClslaDueDateDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();


	public JSONArray clentdetails() throws SQLException {

		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmtVeh = conn.createStatement ();

			String sql="select cldocno,refname from my_acbook where status=3 and dtype='CRM' ";
			ResultSet resultSet = stmtVeh.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
			stmtVeh.close();
			conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
		return RESULTDATA;
	}

	public JSONArray fleetdetails() throws SQLException {

		JSONArray RESULTDATA=new JSONArray();
		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmtVeh = conn.createStatement ();

			String sql="select fleet_no,flname,reg_no from gl_vehmaster where statu=3";
			ResultSet resultSet = stmtVeh.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
			stmtVeh.close();
			conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
		return RESULTDATA;
	}

	public JSONArray detailsgrid(String brnchval,String uptodate,String cldocno,String fleet) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();

		java.sql.Date sqluptodate = null;
		if(!(uptodate.equalsIgnoreCase("undefined"))&&!(uptodate.equalsIgnoreCase(""))&&!(uptodate.equalsIgnoreCase("0")))
		{
			sqluptodate=ClsCommon.changeStringtoSqlDate(uptodate);

		}
		else{
			return RESULTDATA;
		}


		String sqltest="";

		if(!(cldocno.equalsIgnoreCase("") || cldocno.equalsIgnoreCase("NA"))){
			sqltest=sqltest+" and a.cldocno='"+cldocno+"'";
		}
		if(!(fleet.equalsIgnoreCase("")|| fleet.equalsIgnoreCase("NA"))){
			sqltest=sqltest+" and if(l.perfleet=0,l.tmpfleet,l.perfleet)='"+fleet+"'";
		}

		if(!((brnchval.equalsIgnoreCase("a")) || (brnchval.equalsIgnoreCase("NA")))){
			sqltest+=" and l.brhid='"+brnchval+"'";
		}

		Connection conn = null;
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmtVeh = conn.createStatement ();

		
			String sql ="select * from (select ms.sal_name,l.voc_no,l.brhid,d.name drname,coalesce(manualra,'') mrno,l.doc_no, "
					+ "if(l.perfleet=0,l.tmpfleet,l.perfleet) fleet_no,l.cldocno,l.outdate,l.outtime,l.outkm,v.reg_no,v.FLNAME vehdetails,"
					+ "a.refname,a.per_mob,a.contactperson, if(l.per_name=1,DATE_ADD(l.outdate,INTERVAL l.per_value YEAR),"
					+ "DATE_ADD(l.outdate,INTERVAL l.per_value MONTH)) AS duedate,l.per_value from gl_lagmt l"
					+ " left join gl_vehmaster v on if(l.perfleet=0,l.tmpfleet,l.perfleet)=v.fleet_no"
					+ " left join my_acbook a on a.cldocno=l.cldocno and a.dtype='CRM' left join gl_vehgroup g on g.doc_no=v.vgrpid "
					+ "left join gl_vehbrand br on br.doc_no=v.brdid  left join gl_vehmodel mo on  mo.doc_no=v.vmodid "
					+ "left join gl_ldriver dr on dr.rdocno=l.doc_no left join  gl_drdetails d on (d.dr_id=dr.drid )"
					+ " left join my_salm ms on ms.doc_no=l.salid where l.status=3 and l.clstatus=0 "+sqltest+" group by l.doc_no) a "
					+ "where a.duedate<='"+sqluptodate+"' ";

			//   System.out.println("---dddd-------"+sql);

			ResultSet resultSet = stmtVeh.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
			stmtVeh.close();



			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
		return RESULTDATA;
	}
	public JSONArray exceldetailsgrid(String brnchval,String uptodate,String cldocno,String fleet) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();



		java.sql.Date sqluptodate = null;
		if(!(uptodate.equalsIgnoreCase("undefined"))&&!(uptodate.equalsIgnoreCase(""))&&!(uptodate.equalsIgnoreCase("0")))
		{
			sqluptodate=ClsCommon.changeStringtoSqlDate(uptodate);

		}
		else{
			return RESULTDATA;
		}


		String sqltest="";

		if(!(cldocno.equalsIgnoreCase("") || cldocno.equalsIgnoreCase("NA"))){
			sqltest=sqltest+" and a.cldocno='"+cldocno+"'";
		}
		if(!(fleet.equalsIgnoreCase("")|| fleet.equalsIgnoreCase("NA"))){
			sqltest=sqltest+" and if(l.perfleet=0,l.tmpfleet,l.perfleet)='"+fleet+"'";
		}

		if(!((brnchval.equalsIgnoreCase("a")) || (brnchval.equalsIgnoreCase("NA")))){
			sqltest+=" and l.brhid='"+brnchval+"'";
		}

		Connection conn = null;
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmtVeh = conn.createStatement();

			String sql ="select @s:=@s+1 SLNO,a.* from (select l.voc_no 'LA NO',if(l.perfleet=0,l.tmpfleet,l.perfleet) 'Fleet',"
					+ "v.FLNAME 'Fleet Name',v.reg_no 'Reg No',a.refname 'Client Name',a.contactperson 'Contact Person',"
					+ "d.name 'Driver',coalesce(a.per_mob,'') 'Mob NO',l.outdate 'Out Date',l.outtime 'Out Time',coalesce(manualra,'') 'Manual LA', "
					+ "if(l.per_name=1,DATE_ADD(l.outdate,INTERVAL l.per_value YEAR),DATE_ADD(l.outdate,INTERVAL l.per_value MONTH)) DueDate,"
					+ "ms.sal_name 'Salesman' from gl_lagmt l"
					+ " left join gl_vehmaster v on if(l.perfleet=0,l.tmpfleet,l.perfleet)=v.fleet_no"
					+ " left join my_acbook a on a.cldocno=l.cldocno and a.dtype='CRM' left join gl_vehgroup g on g.doc_no=v.vgrpid "
					+ "left join gl_vehbrand br on br.doc_no=v.brdid  left join gl_vehmodel mo on  mo.doc_no=v.vmodid "
					+ "left join gl_ldriver dr on dr.rdocno=l.doc_no left join  gl_drdetails d on (d.dr_id=dr.drid )"
					+ " left join my_salm ms on ms.doc_no=l.salid where l.status=3 and l.clstatus=0 "+sqltest+" group by l.doc_no) a,(select @s:=0) p "
					+ "where a.DueDate<='"+sqluptodate+"' ";


			ResultSet resultSet = stmtVeh.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
			System.out.println("==== "+RESULTDATA);
			stmtVeh.close();



			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
		return RESULTDATA;
	}


}
