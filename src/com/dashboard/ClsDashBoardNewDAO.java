package com.dashboard;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.connection.ClsConnection;

public class ClsDashBoardNewDAO {

    ClsConnection objconn = new ClsConnection();
    
    // =========================================================================
    // 1. WORKSHOP 12-MONTH TREND (Replaces Fleet Sales/Purchases)
    // Tracks Vehicles Received vs Vehicles Delivered/Invoiced over 12 months
    // =========================================================================
    public JSONObject getWorkshopTrendChartData() throws SQLException {
        Connection conn = null;
        JSONObject data = new JSONObject();
        try {
            conn = objconn.getMyConnection();
            Statement stmt = conn.createStatement();
            
            // Get date range (Last 12 months)
            java.sql.Date sqlfromdate = null, sqltodate = null;
            String strgetrequire = "select CURDATE() as todate, date_sub(CURDATE(), interval 12 month) as fromdate";
            ResultSet rsgetrequire = stmt.executeQuery(strgetrequire);
            while (rsgetrequire.next()) {
                sqlfromdate = rsgetrequire.getDate("fromdate");
                sqltodate = rsgetrequire.getDate("todate");
            }
            rsgetrequire.close();
            
            ArrayList<String> monthsarray = new ArrayList<>();
            ArrayList<String> monthsvaluesarray = new ArrayList<>();
            ArrayList<String> vehiclesReceivedCount = new ArrayList<>();
            ArrayList<String> vehiclesDeliveredCount = new ArrayList<>();
            
            for (int monthindex = 0; monthindex < 12; monthindex++) {
                String strgetmonthdate = "select date_format(date_add('" + sqlfromdate + "',interval " + monthindex + " month),'%b %Y') displaydate," +
                                         " date_add('" + sqlfromdate + "',interval " + monthindex + " month) basedate," +
                                         " month(date_add('" + sqlfromdate + "',interval " + monthindex + " month)) basemonth," +
                                         " year(date_add('" + sqlfromdate + "',interval " + monthindex + " month)) baseyear";
                
                int basemonth = 0, baseyear = 0;
                ResultSet rsgetmonthdate = stmt.executeQuery(strgetmonthdate);
                while (rsgetmonthdate.next()) {
                    monthsarray.add(rsgetmonthdate.getString("displaydate"));
                    monthsvaluesarray.add(rsgetmonthdate.getDate("basedate").toString());
                    basemonth = rsgetmonthdate.getInt("basemonth");
                    baseyear = rsgetmonthdate.getInt("baseyear");
                }
                rsgetmonthdate.close();
                
                // Count of Vehicles Received in Garage (Using gl_vmove IN status)
                int receivedCount = 0;
                String strGetReceived = "select coalesce(count(*),0) vehcount from gl_vmove where status='IN' and " +
                                        " month(date)=" + basemonth + " and year(date)=" + baseyear;
                ResultSet rsReceived = stmt.executeQuery(strGetReceived);
                if (rsReceived.next()) { receivedCount = rsReceived.getInt("vehcount"); }
                vehiclesReceivedCount.add(receivedCount + "");
                rsReceived.close();
                
                // Count of Vehicles Delivered/Invoiced (Using gl_vmove OUT status or JobCard closure)
                int deliveredCount = 0;
                String strGetDelivered = "select coalesce(count(*),0) vehcount from gl_vmove where status='OUT' and " +
                                         " month(date)=" + basemonth + " and year(date)=" + baseyear;
                ResultSet rsDelivered = stmt.executeQuery(strGetDelivered);
                if (rsDelivered.next()) { deliveredCount = rsDelivered.getInt("vehcount"); }
                vehiclesDeliveredCount.add(deliveredCount + "");
                rsDelivered.close();
            }
            
            // Current Vehicles actively on the floor
            JSONArray liveWorkshopArray = new JSONArray();
            String strgetlivefloor = "select brd.brand_name brandname, model.vtype modelname, veh.tran_code status, yom.yom " +
                                     "from gl_vehmaster veh " +
                                     "left join gl_vehbrand brd on veh.brdid=brd.doc_no " +
                                     "left join gl_vehmodel model on veh.vmodid=model.doc_no " +
                                     "left join gl_yom yom on veh.yom=yom.doc_no " +
                                     "where veh.tran_code IN ('GIP','EST','QOT','JOB','JCC','WIV','RLS')"; // Workshop codes
            
            ResultSet rsgetlivefloor = stmt.executeQuery(strgetlivefloor);
            while (rsgetlivefloor.next()) {
                JSONObject objtemp = new JSONObject();
                objtemp.put("brandname", rsgetlivefloor.getString("brandname"));
                objtemp.put("modelname", rsgetlivefloor.getString("modelname"));
                objtemp.put("status", rsgetlivefloor.getString("status"));
                objtemp.put("yom", rsgetlivefloor.getString("yom"));
                liveWorkshopArray.add(objtemp);
            }
            rsgetlivefloor.close();
            
            data.put("labelsvalues", monthsvaluesarray);
            data.put("labels", monthsarray);
            data.put("receivedmonthcount", vehiclesReceivedCount);
            data.put("deliveredmonthcount", vehiclesDeliveredCount);
            data.put("livefloor", liveWorkshopArray);
            data.put("workshopstatustitle", "Workshop Intake & Delivery " + monthsarray.get(0) + " - " + monthsarray.get(monthsarray.size()-1));
            
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if(conn != null) conn.close();
        }
        return data;
    }
    
    // =========================================================================
    // 2. BRAND-WISE WORKSHOP VISITS (Replaces Brand-wise Fleet Sales)
    // =========================================================================
    public JSONObject getBrandwiseWorkshopData(String basedate) throws SQLException {
        Connection conn = null;
        JSONObject data = new JSONObject();
        try {
            conn = objconn.getMyConnection();
            Statement stmt = conn.createStatement();
            
            String strbrandwise = "select brd.brand_name, count(v.doc_no) as visitcount " +
                                  "from gl_vmove v " +
                                  "left join gl_vehmaster veh on v.fleet_no=veh.fleet_no " +
                                  "left join gl_vehbrand brd on veh.brdid=brd.doc_no " +
                                  "where v.status='IN' and month(v.date)=month('" + basedate + "') " +
                                  "and year(v.date)=year('" + basedate + "') " +
                                  "group by brd.doc_no order by visitcount desc";
            
            ResultSet rs = stmt.executeQuery(strbrandwise);
            int srno = 1;
            ArrayList<String> brandwisearray = new ArrayList<>();
            while (rs.next()) {
                brandwisearray.add(srno + "::" + rs.getString("brand_name") + "::" + rs.getString("visitcount"));
                srno++;
            }
            rs.close();
            
            data.put("brandwisedata", brandwisearray);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if(conn != null) conn.close();
        }
        return data;
    }
    
    // =========================================================================
    // 3. MODEL-WISE WORKSHOP VISITS (Replaces Model-wise Fleet Sales)
    // =========================================================================
    public JSONObject getModelwiseWorkshopData(String basedate) throws SQLException {
        Connection conn = null;
        JSONObject data = new JSONObject();
        try {
            conn = objconn.getMyConnection();
            Statement stmt = conn.createStatement();
            
            String strmodelwise = "select concat(brd.brand_name,' ',model.vtype) modelname, count(v.doc_no) as visitcount " +
                                  "from gl_vmove v " +
                                  "left join gl_vehmaster veh on v.fleet_no=veh.fleet_no " +
                                  "left join gl_vehbrand brd on veh.brdid=brd.doc_no " +
                                  "left join gl_vehmodel model on veh.vmodid=model.doc_no " +
                                  "where v.status='IN' and month(v.date)=month('" + basedate + "') " +
                                  "and year(v.date)=year('" + basedate + "') " +
                                  "group by model.doc_no order by visitcount desc";
            
            ResultSet rs = stmt.executeQuery(strmodelwise);
            int srno = 1;
            ArrayList<String> modelwisearray = new ArrayList<>();
            while (rs.next()) {
                modelwisearray.add(srno + "::" + rs.getString("modelname") + "::" + rs.getString("visitcount"));
                srno++;
            }
            rs.close();
            
            data.put("modelwisedata", modelwisearray);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if(conn != null) conn.close();
        }
        return data;
    }
    
    // =========================================================================
    // 4. WORKSHOP FLOOR DISTRIBUTION (Replaces Fleet Dist Chart)
    // Breaks down current floor inventory by active stages (GIP, EST, etc.)
    // =========================================================================
    public JSONObject getWorkshopDistChartData() throws SQLException {
        Connection conn = null;
        JSONObject data = new JSONObject();
        try {
            conn = objconn.getMyConnection();
            Statement stmt = conn.createStatement();
            
            String strsql = "select st.st_desc trancode, brd.brand_name brandname, model.vtype modelname, " +
                            "grp.gname groupname, yom.yom " +
                            "from gl_vehmaster VEH " +
                            "LEFT JOIN GL_STATUS ST ON (VEH.tran_code=ST.STATUS) " +
                            "left join gl_vehbrand brd on veh.brdid=brd.doc_no " +
                            "left join gl_vehmodel model on veh.vmodid=model.doc_no " +
                            "left join gl_vehgroup grp on veh.vgrpid=grp.doc_no " +
                            "left join gl_yom yom on veh.yom=yom.doc_no " +
                            "where VEH.tran_code IN ('GIP','EST','QOT','JOB','JCC','WIV','RLS')";
            
            ResultSet rs = stmt.executeQuery(strsql);
            JSONArray floorDistArray = new JSONArray();
            while (rs.next()) {
                JSONObject objtemp = new JSONObject();
                objtemp.put("trancode", rs.getString("trancode") != null ? rs.getString("trancode") : "Unknown");
                objtemp.put("brandname", rs.getString("brandname"));
                objtemp.put("modelname", rs.getString("modelname"));
                objtemp.put("groupname", rs.getString("groupname"));
                objtemp.put("yom", rs.getString("yom"));
                floorDistArray.add(objtemp);
            }
            rs.close();
            data.put("floordistdata", floorDistArray);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if(conn != null) conn.close();
        }
        return data;
    }
    
    // =========================================================================
    // 5. WORKSHOP TIME UTILIZATION (Replaces Fleet Utilize Data)
    // Tracks time spent in Estimate vs Pending Parts vs Working vs Waiting Invoice
    // =========================================================================
    public JSONArray getWorkshopUtilizeData(Connection conn, String groupby, java.sql.Date sqlfromdate, java.sql.Date sqltodate) {
        JSONArray dataarray = new JSONArray();
        try {
            String sqlgroup = "", sqlselect = "";
            if (groupby.equalsIgnoreCase("brand") || groupby.equalsIgnoreCase("")) {
                sqlgroup = " group by f.brdid";
                sqlselect = " brd.doc_no refno, brd.brand_name description";
            } else if (groupby.equalsIgnoreCase("model")) {
                sqlgroup = " group by f.vmodid";
                sqlselect = " model.doc_no refno, model.vtype description";
            } else if (groupby.equalsIgnoreCase("status")) {
                sqlgroup = " group by f.tran_code";
                sqlselect = " f.tran_code refno, f.trancode description";
            }
            
            Statement stmt = conn.createStatement();
            
            // Simplified proxy SQL for Workshop time tracking logic
            // Assuming time tracked in a status history table or calculated from job card updates.
            // Replace `gl_jobhistory` with your actual workshop time tracking table if necessary.
            String strSql = "select refno, description, " +
                            "coalesce(sum(est_time),0) as estimate_hrs, " +
                            "coalesce(sum(wait_parts_time),0) as wait_parts_hrs, " +
                            "coalesce(sum(work_time),0) as working_hrs, " +
                            "coalesce(sum(inv_time),0) as invoice_hrs " +
                            "from ( " +
                            "  select veh.brdid, veh.vmodid, veh.tran_code, " +
                            "  12.5 as est_time, 4.0 as wait_parts_time, 24.5 as work_time, 2.0 as inv_time, " + // Dummy time data proxy
                            "  " + sqlselect + " " +
                            "  from gl_vehmaster veh " +
                            "  left join gl_vehbrand brd on veh.brdid=brd.doc_no " +
                            "  left join gl_vehmodel model on veh.vmodid=model.doc_no " +
                            ") as f where 1=1 " + sqlgroup;
            
            ResultSet rs = stmt.executeQuery(strSql);
            while (rs.next()) {
                JSONObject objtemp = new JSONObject();
                objtemp.put("refno", rs.getString("refno"));
                objtemp.put("description", rs.getString("description"));
                objtemp.put("estimate_hrs", rs.getString("estimate_hrs"));
                objtemp.put("wait_parts_hrs", rs.getString("wait_parts_hrs"));
                objtemp.put("working_hrs", rs.getString("working_hrs"));
                objtemp.put("invoice_hrs", rs.getString("invoice_hrs"));
                dataarray.add(objtemp);
            }
            rs.close();
            return dataarray;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return dataarray;
    }
}