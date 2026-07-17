package com.dashboard.limousine.assignlist;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsLimoAssignListDAO {

	ClsCommon objcommon=new ClsCommon();
	ClsConnection objconn=new ClsConnection();
	
	public JSONArray getAssignListData(String fromdate,String todate,String type,String driver,String branch,String id) throws SQLException{
		JSONArray assigndata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return assigndata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="";
			String sqltest="";
			String sqltransferbranch="";
			String sqlhoursbranch="";
			String sqltransferstatus="";
			String sqlhoursstatus="";
			java.sql.Date sqlfromdate=null,sqltodate=null;
			if(!fromdate.equalsIgnoreCase("")){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
			}
			if(!todate.equalsIgnoreCase("")){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
			}
			
			if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
				/*sqltest+=" and book.brhid="+branch;*/
				sqltransferbranch+=" and (tran.transferbranch=0 or tran.transferbranch="+branch+")";
				sqlhoursbranch+=" and (hours.transferbranch=0 or hours.transferbranch="+branch+")";
			}
			if(sqlfromdate!=null){
				sqltest+=" and book.date>='"+sqlfromdate+"'";
			}
			if(sqltodate!=null){
				sqltest+=" and book.date<='"+sqltodate+"'";
			}
			if(!driver.equalsIgnoreCase("")){
				sqltest+=" and sal.sal_type='DRV' and sal.doc_no="+driver;
			}
			sqltransferstatus+=" and tran.masterstatus>=3 and tran.masterstatus<>4";
			sqlhoursstatus+=" and hours.masterstatus>=3 and hours.masterstatus<>4";
			
			if(type.equalsIgnoreCase("Transfer")){
				strsql="select convert(concat(veh.fleet_no,' - ',veh.flname),char(50)) fleet,veh.reg_no,sal.sal_name driver,book.doc_no bookdocno,"+
			" book.cldocno,book.guestno,tran.doc_no detaildocno,tran.brandid,tran.modelid,tran.docname,ac.refname,guest.guest,'Transfer' type,null blockhrs,tran.pickupdate,"+
			" tran.pickuptime,pickup.location pickuplocation,tran.pickupadress pickupaddress,dropoff.location dropofflocation,tran.dropoffaddress,brd.brand_name brand, "+
			" model.vtype model,tran.nos from gl_limobookm book inner join gl_limobooktransfer tran on (book.doc_no=tran.bookdocno) left join my_acbook ac on "+
			" (book.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_limoguest guest on (book.guestno=guest.doc_no) left join gl_cordinates pickup on "+
			" (tran.pickuplocid=pickup.doc_no) left join gl_cordinates dropoff on (tran.dropfflocid=dropoff.doc_no) left join gl_vehbrand brd on tran.brandid=brd.doc_no "+
			" left join gl_vehmodel model on (tran.modelid=model.doc_no) left join my_salesman sal on (tran.assigneddriver=sal.doc_no and sal.sal_type='DRV') "+
			" left join gl_vehmaster veh on tran.assignedfleet=veh.fleet_no where book.status=3 "+sqltest+sqltransferbranch+sqltransferstatus;
			}
			else if(type.equalsIgnoreCase("Limo")){
				strsql="select convert(concat(veh.fleet_no,' - ',veh.flname),char(50)) fleet,veh.reg_no,sal.sal_name driver,book.doc_no bookdocno,book.cldocno,"+
			" book.guestno,hours.doc_no detaildocno,hours.brandid,hours.modelid,hours.docname,ac.refname,guest.guest,'Limo' type, hours.blockhrs,hours.pickupdate,"+
			" hours.pickuptime,pickup.location pickuplocation,hours.pickupaddress,null dropofflocation,null dropoffaddress, brd.brand_name brand,model.vtype model,"+
			" hours.nos from gl_limobookm book inner join gl_limobookhours hours on (book.doc_no=hours.bookdocno) left join my_acbook ac on (book.cldocno=ac.cldocno and "+
			" ac.dtype='CRM') left join gl_limoguest guest on (book.guestno=guest.doc_no) left join gl_cordinates pickup on (hours.pickuplocid=pickup.doc_no) left join "+
			" gl_vehbrand brd on (hours.brandid=brd.doc_no) left join gl_vehmodel model on (hours.modelid=model.doc_no)  left join my_salesman sal on "+
			" (hours.assigneddriver=sal.doc_no and sal.sal_type='DRV') left join gl_vehmaster veh on hours.assignedfleet=veh.fleet_no where book.status=3 "+
			" "+sqltest+sqlhoursbranch+sqlhoursstatus;
			}
			else{
				strsql="select convert(concat(veh.fleet_no,' - ',veh.flname),char(50)) fleet,veh.reg_no,sal.sal_name driver,book.doc_no bookdocno,book.cldocno,book.guestno,tran.doc_no detaildocno,tran.brandid,tran.modelid,tran.docname,ac.refname,guest.guest,'Transfer' type,null blockhrs,tran.pickupdate,"+
			" tran.pickuptime,pickup.location pickuplocation,tran.pickupadress pickupaddress,dropoff.location dropofflocation,tran.dropoffaddress,brd.brand_name brand, "+
			" model.vtype model,tran.nos from gl_limobookm book inner join gl_limobooktransfer tran on (book.doc_no=tran.bookdocno) left join my_acbook ac on "+
			" (book.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_limoguest guest on (book.guestno=guest.doc_no) left join gl_cordinates pickup on "+
			" (tran.pickuplocid=pickup.doc_no) left join gl_cordinates dropoff on (tran.dropfflocid=dropoff.doc_no) left join gl_vehbrand brd on tran.brandid=brd.doc_no "+
			" left join gl_vehmodel model on (tran.modelid=model.doc_no) left join my_salesman sal on (tran.assigneddriver=sal.doc_no and sal.sal_type='DRV') "+
			" left join gl_vehmaster veh on tran.assignedfleet=veh.fleet_no where book.status=3 "+sqltest+sqltransferbranch+sqltransferstatus+" union all "+
			" select convert(concat(veh.fleet_no,' - ',veh.flname),char(50)) fleet,veh.reg_no,sal.sal_name driver,book.doc_no bookdocno,book.cldocno,"+
			" book.guestno,hours.doc_no detaildocno,hours.brandid,hours.modelid,hours.docname,ac.refname,guest.guest,'Limo' type, hours.blockhrs,hours.pickupdate,"+
			" hours.pickuptime,pickup.location pickuplocation,hours.pickupaddress,null dropofflocation,null dropoffaddress, brd.brand_name brand,model.vtype model,"+
			" hours.nos from gl_limobookm book inner join gl_limobookhours hours on (book.doc_no=hours.bookdocno) left join my_acbook ac on (book.cldocno=ac.cldocno and "+
			" ac.dtype='CRM') left join gl_limoguest guest on (book.guestno=guest.doc_no) left join gl_cordinates pickup on (hours.pickuplocid=pickup.doc_no) left join "+
			" gl_vehbrand brd on (hours.brandid=brd.doc_no) left join gl_vehmodel model on (hours.modelid=model.doc_no) left join my_salesman sal on "+
			" (hours.assigneddriver=sal.doc_no and sal.sal_type='DRV') left join gl_vehmaster veh on hours.assignedfleet=veh.fleet_no where book.status=3 "+
			" "+sqltest+sqlhoursbranch+sqlhoursstatus;
			}
			System.out.println("Assign Sql:"+strsql);
			ResultSet rsassign=stmt.executeQuery(strsql);
			assigndata=objcommon.convertToJSON(rsassign);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return assigndata;
	}
	
	
	public JSONArray getDriver(String id) throws SQLException{
		JSONArray driverdata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return driverdata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select doc_no,sal_code,sal_name,lic_no,lic_exp_dt,authority,mobile mobno from my_salesman where status=3 and sal_type='DRV'";
			ResultSet rs=stmt.executeQuery(strsql);
			driverdata=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return driverdata;
	}
	
	
	
	public JSONArray getAssignListExcelData(String fromdate,String todate,String type,String driver,String branch,String id) throws SQLException{
		JSONArray assigndata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return assigndata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="";
			String sqltest="";
			String sqltransferbranch="";
			String sqlhoursbranch="";
			String sqltransferstatus="";
			String sqlhoursstatus="";
			java.sql.Date sqlfromdate=null,sqltodate=null;
			if(!fromdate.equalsIgnoreCase("")){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
			}
			if(!todate.equalsIgnoreCase("")){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
			}
			
			if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
				/*sqltest+=" and book.brhid="+branch;*/
				sqltransferbranch+=" and (tran.transferbranch=0 or tran.transferbranch="+branch+")";
				sqlhoursbranch+=" and (hours.transferbranch=0 or hours.transferbranch="+branch+")";
			}
			if(sqlfromdate!=null){
				sqltest+=" and book.date>='"+sqlfromdate+"'";
			}
			if(sqltodate!=null){
				sqltest+=" and book.date<='"+sqltodate+"'";
			}
			if(!driver.equalsIgnoreCase("")){
				sqltest+=" and sal.sal_type='DRV' and sal.doc_no="+driver;
			}
			sqltransferstatus+=" and tran.masterstatus>=3 and tran.masterstatus<>4";
			sqlhoursstatus+=" and hours.masterstatus>=3 and hours.masterstatus<>4";
			
			if(type.equalsIgnoreCase("Transfer")){
				strsql="select convert(concat(veh.fleet_no,' - ',veh.flname),char(50)) 'Fleet',veh.reg_no 'Reg No',sal.sal_name 'Driver',tran.docname 'Job Name',"+
			" ac.refname 'Client',guest.guest 'Guest' ,'Transfer' Type,null 'Block Hrs',tran.pickupdate 'Pickup Date',tran.pickuptime 'Pickup Time',"+
			" pickup.location 'Pickup Location',tran.pickupadress 'Pickup Address',dropoff.location 'Dropoff Location',tran.dropoffaddress 'Dropoff Address',"+
			" brd.brand_name 'Brand',model.vtype 'Model',tran.nos 'Nos' from gl_limobookm book inner join gl_limobooktransfer tran on (book.doc_no=tran.bookdocno) left join my_acbook ac on "+
			" (book.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_limoguest guest on (book.guestno=guest.doc_no) left join gl_cordinates pickup on "+
			" (tran.pickuplocid=pickup.doc_no) left join gl_cordinates dropoff on (tran.dropfflocid=dropoff.doc_no) left join gl_vehbrand brd on tran.brandid=brd.doc_no "+
			" left join gl_vehmodel model on (tran.modelid=model.doc_no) left join my_salesman sal on (tran.assigneddriver=sal.doc_no and sal.sal_type='DRV') "+
			" left join gl_vehmaster veh on tran.assignedfleet=veh.fleet_no where book.status=3 "+sqltest+sqltransferbranch+sqltransferstatus;
			}
			else if(type.equalsIgnoreCase("Limo")){
				strsql="select convert(concat(veh.fleet_no,' - ',veh.flname),char(50)) 'Fleet',veh.reg_no 'Reg No',sal.sal_name 'Driver',hours.docname 'Job Name',"+
			" ac.refname 'Client',guest.guest 'Guest','Limo' Type, hours.blockhrs 'Block Hrs',hours.pickupdate 'Pickup Date',hours.pickuptime 'Pickup Time',"+
			" pickup.location 'Pickup Location',hours.pickupaddress 'Pickup Address',null 'Dropoff Location',null 'Dropoff Address',"+
			" brd.brand_name 'Brand',model.vtype 'Model',hours.nos 'Nos' from gl_limobookm book inner join gl_limobookhours hours on (book.doc_no=hours.bookdocno) left join my_acbook ac on (book.cldocno=ac.cldocno and "+
			" ac.dtype='CRM') left join gl_limoguest guest on (book.guestno=guest.doc_no) left join gl_cordinates pickup on (hours.pickuplocid=pickup.doc_no) left join "+
			" gl_vehbrand brd on (hours.brandid=brd.doc_no) left join gl_vehmodel model on (hours.modelid=model.doc_no)  left join my_salesman sal on "+
			" (hours.assigneddriver=sal.doc_no and sal.sal_type='DRV') left join gl_vehmaster veh on hours.assignedfleet=veh.fleet_no where book.status=3 "+
			" "+sqltest+sqlhoursbranch+sqlhoursstatus;
			}
			else{
				strsql="select convert(concat(veh.fleet_no,' - ',veh.flname),char(50)) 'Fleet',veh.reg_no 'Reg No',sal.sal_name 'Driver',tran.docname 'Job Name',"+
			" ac.refname 'Client',guest.guest 'Guest' ,'Transfer' 'Type',null 'Block Hrs',tran.pickupdate 'Pickup Date',tran.pickuptime 'Pickup Time',"+
			" pickup.location 'Pickup Location',tran.pickupadress 'Pickup Address',dropoff.location 'Dropoff Location',tran.dropoffaddress 'Dropoff Address',"+
			" brd.brand_name 'Brand',model.vtype 'Model',tran.nos 'Nos' from gl_limobookm book inner join gl_limobooktransfer tran on (book.doc_no=tran.bookdocno) left join my_acbook ac on "+
			" (book.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_limoguest guest on (book.guestno=guest.doc_no) left join gl_cordinates pickup on "+
			" (tran.pickuplocid=pickup.doc_no) left join gl_cordinates dropoff on (tran.dropfflocid=dropoff.doc_no) left join gl_vehbrand brd on tran.brandid=brd.doc_no "+
			" left join gl_vehmodel model on (tran.modelid=model.doc_no) left join my_salesman sal on (tran.assigneddriver=sal.doc_no and sal.sal_type='DRV') "+
			" left join gl_vehmaster veh on tran.assignedfleet=veh.fleet_no where book.status=3 "+sqltest+sqltransferbranch+sqltransferstatus+" union all "+
			" select convert(concat(veh.fleet_no,' - ',veh.flname),char(50)) 'Fleet',veh.reg_no 'Reg No',sal.sal_name 'Driver',hours.docname 'Job Name',"+
			" ac.refname 'Client',guest.guest 'Guest','Limo' 'Type', hours.blockhrs 'Block Hrs',hours.pickupdate 'Pickup Date',hours.pickuptime 'Pickup Time',"+
			" pickup.location 'Pickup Location',hours.pickupaddress 'Pickup Address',null 'Dropoff Location',null 'Dropoff Address',"+
			" brd.brand_name 'Brand',model.vtype 'Model',hours.nos 'Nos' from gl_limobookm book inner join gl_limobookhours hours on (book.doc_no=hours.bookdocno) left join my_acbook ac on (book.cldocno=ac.cldocno and "+
			" ac.dtype='CRM') left join gl_limoguest guest on (book.guestno=guest.doc_no) left join gl_cordinates pickup on (hours.pickuplocid=pickup.doc_no) left join "+
			" gl_vehbrand brd on (hours.brandid=brd.doc_no) left join gl_vehmodel model on (hours.modelid=model.doc_no) left join my_salesman sal on "+
			" (hours.assigneddriver=sal.doc_no and sal.sal_type='DRV') left join gl_vehmaster veh on hours.assignedfleet=veh.fleet_no where book.status=3 "+
			" "+sqltest+sqlhoursbranch+sqlhoursstatus;
			}
			System.out.println("Assign Sql:"+strsql);
			ResultSet rsassign=stmt.executeQuery(strsql);
			assigndata=objcommon.convertToEXCEL(rsassign);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return assigndata;
	}

public ClsLimoAssignListBean getPrint(HttpServletRequest request,String branch,String Type,String fromdate,String todate,String driver) throws SQLException {
		
		ClsLimoAssignListBean bean = new ClsLimoAssignListBean();
		
		Connection conn = null;

		
      	
	try{
						
	String strsql="";
	String sqltest="";
	String sqltransferbranch="";
	String sqlhoursbranch="";
	String sqltransferstatus="";
	String sqlhoursstatus="";
	java.sql.Date sqlfromdate=null,sqltodate=null;
						
	if(!fromdate.equalsIgnoreCase("")){
	sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
			}
	if(!todate.equalsIgnoreCase("")){
	sqltodate=objcommon.changeStringtoSqlDate(todate);
						}
						
	if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
	/*sqltest+=" and book.brhid="+branch;*/
	sqltransferbranch+=" and (tran.transferbranch=0 or tran.transferbranch="+branch+")";
	sqlhoursbranch+=" and (hours.transferbranch=0 or hours.transferbranch="+branch+")";
						}
	if(sqlfromdate!=null){
	sqltest+=" and book.date>='"+sqlfromdate+"'";
						}
	if(sqltodate!=null){
	sqltest+=" and book.date<='"+sqltodate+"'";
				}
	if(!driver.equalsIgnoreCase("")){
	sqltest+=" and sal.sal_type='DRV' and sal.sal_name='"+driver+"'";
						}
	sqltransferstatus+=" and tran.masterstatus>=3 and tran.masterstatus<>4";
	sqlhoursstatus+=" and hours.masterstatus>=3 and hours.masterstatus<>4";
						
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
						
	String sql="select 'Driver Movement' vouchername,CONCAT('From ',DATE_FORMAT('"+sqlfromdate+"','%D %M  %Y '),'  To  ',DATE_FORMAT('"+sqltodate+"','%D %M  %Y ')) vouchername1,"
								+ "c.company,c.address,c.tel,c.fax,lc.loc_name location,b.branchname,b.pbno,b.stcno,b.cstno from gl_rentreceipt r inner join my_brch b on r.brhid=b.doc_no inner join my_comp c "
								+ "on b.cmpid=c.doc_no inner join my_locm l on l.brhid=b.doc_no inner join (select min(lo.loc) loc,lo.loc_name,lo.brhid from my_locm lo group by brhid) as lc "
								+ "on(lc.loc=l.loc and lc.brhid=b.doc_no) where 1=1  group by r.brhid";
							
ResultSet resultSet = stmt.executeQuery(sql);
//System.out.println(sql); 
while(resultSet.next()){
	bean.setLblcompname(resultSet.getString("company"));
	bean.setLblcompaddress(resultSet.getString("address"));
	bean.setLblprintname(resultSet.getString("vouchername"));
	bean.setLblprintname1(resultSet.getString("vouchername1"));
	bean.setLblcomptel(resultSet.getString("tel"));
	bean.setLblcompfax(resultSet.getString("fax"));
	bean.setLblbranch(resultSet.getString("branchname"));
	bean.setLbllocation(resultSet.getString("location"));
							}
	System.out.println(Type);
	if(Type.equalsIgnoreCase("Transfer")){
	strsql="select @id:=@id+1 srno,a.* from(select convert(concat(veh.fleet_no,' - ',veh.flname),char(50)) fleet,veh.reg_no,sal.sal_name driver,book.doc_no bookdocno,"+
						" book.cldocno,book.guestno,tran.doc_no detaildocno,tran.brandid,tran.modelid,tran.docname,ac.refname,guest.guest,'Transfer' type,' ' blockhrs,tran.pickupdate,"+
						" tran.pickuptime,pickup.location pickuplocation,tran.pickupadress pickupaddress,dropoff.location dropofflocation,tran.dropoffaddress,brd.brand_name brand, "+
						" model.vtype model,tran.nos from gl_limobookm book inner join gl_limobooktransfer tran on (book.doc_no=tran.bookdocno) left join my_acbook ac on "+
						" (book.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_limoguest guest on (book.guestno=guest.doc_no) left join gl_cordinates pickup on "+
						" (tran.pickuplocid=pickup.doc_no) left join gl_cordinates dropoff on (tran.dropfflocid=dropoff.doc_no) left join gl_vehbrand brd on tran.brandid=brd.doc_no "+
						" left join gl_vehmodel model on (tran.modelid=model.doc_no) left join my_salesman sal on (tran.assigneddriver=sal.doc_no and sal.sal_type='DRV') "+
						" left join gl_vehmaster veh on tran.assignedfleet=veh.fleet_no where book.status=3 "+sqltest+sqltransferbranch+sqltransferstatus+")a,(select @id:=0)r;";
						}
else if(Type.equalsIgnoreCase("Limo")){
	strsql="select @id:=@id+1 srno,a.* from(select convert(concat(veh.fleet_no,' - ',veh.flname),char(50)) fleet,veh.reg_no,sal.sal_name driver,book.doc_no bookdocno,book.cldocno,"+
						" book.guestno,hours.doc_no detaildocno,hours.brandid,hours.modelid,hours.docname,ac.refname,guest.guest,'Limo' type, coalesce(hours.blockhrs,' ')blockhrs,hours.pickupdate,"+
						" hours.pickuptime,pickup.location pickuplocation,hours.pickupaddress,null dropofflocation,null dropoffaddress, brd.brand_name brand,model.vtype model,"+
						" hours.nos from gl_limobookm book inner join gl_limobookhours hours on (book.doc_no=hours.bookdocno) left join my_acbook ac on (book.cldocno=ac.cldocno and "+
						" ac.dtype='CRM') left join gl_limoguest guest on (book.guestno=guest.doc_no) left join gl_cordinates pickup on (hours.pickuplocid=pickup.doc_no) left join "+
						" gl_vehbrand brd on (hours.brandid=brd.doc_no) left join gl_vehmodel model on (hours.modelid=model.doc_no)  left join my_salesman sal on "+
						" (hours.assigneddriver=sal.doc_no and sal.sal_type='DRV') left join gl_vehmaster veh on hours.assignedfleet=veh.fleet_no where book.status=3 "+
						" "+sqltest+sqlhoursbranch+sqlhoursstatus+")a,(select @id:=0)r;";
						}
	else{
		strsql="select @id:=@id+1 srno,a.* from(select convert(concat(veh.fleet_no,' - ',veh.flname),char(50)) fleet,veh.reg_no,sal.sal_name driver,book.doc_no bookdocno,book.cldocno,book.guestno,tran.doc_no detaildocno,tran.brandid,tran.modelid,tran.docname,ac.refname,guest.guest,'Transfer' type,' ' blockhrs,tran.pickupdate,"+
						" tran.pickuptime,pickup.location pickuplocation,tran.pickupadress pickupaddress,dropoff.location dropofflocation,tran.dropoffaddress,brd.brand_name brand, "+
						" model.vtype model,tran.nos from gl_limobookm book inner join gl_limobooktransfer tran on (book.doc_no=tran.bookdocno) left join my_acbook ac on "+
						" (book.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_limoguest guest on (book.guestno=guest.doc_no) left join gl_cordinates pickup on "+
						" (tran.pickuplocid=pickup.doc_no) left join gl_cordinates dropoff on (tran.dropfflocid=dropoff.doc_no) left join gl_vehbrand brd on tran.brandid=brd.doc_no "+
						" left join gl_vehmodel model on (tran.modelid=model.doc_no) left join my_salesman sal on (tran.assigneddriver=sal.doc_no and sal.sal_type='DRV') "+
						" left join gl_vehmaster veh on tran.assignedfleet=veh.fleet_no where book.status=3 "+sqltest+sqltransferbranch+sqltransferstatus+" union all "+
						" select convert(concat(veh.fleet_no,' - ',veh.flname),char(50)) fleet,veh.reg_no,sal.sal_name driver,book.doc_no bookdocno,book.cldocno,"+
						" book.guestno,hours.doc_no detaildocno,hours.brandid,hours.modelid,hours.docname,ac.refname,guest.guest,'Limo' type, coalesce(hours.blockhrs,' ') blockhrs,hours.pickupdate,"+
						" hours.pickuptime,pickup.location pickuplocation,hours.pickupaddress,null dropofflocation,null dropoffaddress, brd.brand_name brand,model.vtype model,"+
						" hours.nos from gl_limobookm book inner join gl_limobookhours hours on (book.doc_no=hours.bookdocno) left join my_acbook ac on (book.cldocno=ac.cldocno and "+
						" ac.dtype='CRM') left join gl_limoguest guest on (book.guestno=guest.doc_no) left join gl_cordinates pickup on (hours.pickuplocid=pickup.doc_no) left join "+
						" gl_vehbrand brd on (hours.brandid=brd.doc_no) left join gl_vehmodel model on (hours.modelid=model.doc_no) left join my_salesman sal on "+
						" (hours.assigneddriver=sal.doc_no and sal.sal_type='DRV') left join gl_vehmaster veh on hours.assignedfleet=veh.fleet_no where book.status=3 "+
						" "+sqltest+sqlhoursbranch+sqlhoursstatus+")a,(select @id:=0)r;";
						}
				
            		
			
		//System.out.println("======= "+strsql);
		ResultSet resultSet1 = stmt.executeQuery(strsql);
            	// RESULTDATA=ClsCommon.convertToJSON(resultSet);
       	
		ArrayList<String> printarray= new ArrayList<String>();
		
		while(resultSet1.next()){

		String temp="";
		temp=resultSet1.getString("srno")+"::"+resultSet1.getString("docname")+"::"+resultSet1.getString("driver")+"::"+resultSet1.getString("fleet")+"::"+resultSet1.getString("reg_no")+"::"+resultSet1.getString("refname")+"::"+resultSet1.getString("guest")+"::"+resultSet1.getString("type")+"::"+resultSet1.getString("blockhrs")+"::"+resultSet1.getString("pickupdate")+"::"+resultSet1.getString("pickuptime")+"::"+resultSet1.getString("pickuplocation")+"::"+resultSet1.getString("pickupaddress")+"::"+resultSet1.getString("dropofflocation")+"::"+resultSet1.getString("dropoffaddress");
		    printarray.add(temp);
		}
		request.setAttribute("printingarray", printarray);
		
		
		stmt.close();
		}
		catch(Exception e){
		e.printStackTrace();
		
	        }finally{
		conn.close();
	        }
	        return bean;
   
	}
}
