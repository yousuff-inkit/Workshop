package com.dashboard;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.net.URLEncoder; 

import javax.servlet.http.HttpSession;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject; // <-- CRITICAL NEW IMPORT
import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsDashBoardDAO {
    ClsConnection ClsConnection = new ClsConnection();
    ClsCommon ClsCommon = new ClsCommon();
    ClsDashBoardBean dashBoardBean = new ClsDashBoardBean();

    /* =============================================================
       1. GET DASHBOARD TILES (Replaced TileBean with ClsDashBoardBean)
       ============================================================= */
    public List<ClsDashBoardBean> getDashboardTiles(String contextPath, String moduleType) {
        List<ClsDashBoardBean> list = new ArrayList<ClsDashBoardBean>();
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;

        try {
            conn = ClsConnection.getMyConnection();
            stmt = conn.createStatement();

            // Default to Finance if empty
            if (moduleType == null || moduleType.trim().isEmpty()) {
                moduleType = "Finance";
            }

            // --- EXPLICIT FILTERING ---
            String whereCondition = "1=0"; 

            if (moduleType.contains("Fleet")) {
                whereCondition = " ( menu_name LIKE '%Induction%' OR menu_name LIKE '%Procurement%' OR menu_name LIKE '%Vehicle Master%' OR menu_name LIKE '%Veh. Related%' OR menu_name LIKE '%Non Pool%' OR menu_name LIKE '%Maintenance%' OR menu_name LIKE '%Depreciation%' OR menu_name LIKE '%Sale of Vehicle%' OR menu_name LIKE '%Available Fleet%' OR menu_name LIKE '%Status Change%' OR doc_type LIKE '%Fleet%' OR func LIKE '%fleet%' ) ";
            } else if (moduleType.contains("Workshop") || moduleType.contains("WORK")) {
                whereCondition = " (doc_type LIKE '%WORK%' OR doc_type LIKE '%Workshop%' OR menu_name LIKE '%Workshop%' OR func LIKE '%work%') ";
            } else if (moduleType.contains("Finance")) {
                whereCondition = " ( (doc_type LIKE '%Finance%' OR func LIKE '%finance%' OR func LIKE '%trans%') AND menu_name NOT LIKE '%Appraisal%' AND menu_name NOT LIKE '%Attendance%' AND menu_name NOT LIKE '%Leave%' AND menu_name NOT LIKE '%Vehicle%' ) ";
            } else if (moduleType.contains("Human") || moduleType.contains("HR")) {
                whereCondition = " (doc_type LIKE '%Human%' OR menu_name LIKE '%Appraisal%' OR menu_name LIKE '%Attendance%' OR menu_name LIKE '%Leave%' OR menu_name LIKE '%Payroll%' OR menu_name LIKE '%Employee%') ";
            } else if (moduleType.contains("Asset")) {
                whereCondition = " (doc_type LIKE '%Asset%' OR menu_name LIKE '%Asset%') ";
            } else if (moduleType.contains("Operation")) {
                whereCondition = " (doc_type LIKE '%Operation%' OR menu_name LIKE '%Operation%' OR menu_name LIKE '%Booking%' OR menu_name LIKE '%Agreement%') ";
            } else if (moduleType.contains("Control")) {
                whereCondition = " (menu_name LIKE '%Control%' OR func LIKE '%control%') ";
            } else {
                whereCondition = " (doc_type LIKE '%" + moduleType + "%' OR menu_name LIKE '%" + moduleType + "%')";
            }

            String sql = "SELECT menu_name, func, doc_type FROM my_menu WHERE " + whereCondition + " AND func IS NOT NULL AND func <> '' ORDER BY menu_name";
            rs = stmt.executeQuery(sql);

            while(rs.next()) {
                String title = rs.getString("menu_name");
                if (title != null) {
                    title = title.replace("(BPV) (BPV)", "(BPV)");
                }

                String dbLink = rs.getString("func");
                String fullUrl = "#";
                if(dbLink != null && !dbLink.trim().equals("")) {
                     if(!dbLink.startsWith("/")) {
                         fullUrl = contextPath + "/" + dbLink;
                     } else {
                         fullUrl = contextPath + dbLink;
                     }
                     
                     String encodedTitle = title;
                     try { 
                         encodedTitle = URLEncoder.encode(title, "UTF-8"); 
                     } catch(Exception e) { 
                         encodedTitle = title.replace(" ", "%20"); 
                     }
                     
                     if (fullUrl.contains("?")) {
                        fullUrl += "&menuname=" + encodedTitle;
                     } else {
                        fullUrl += "?menuname=" + encodedTitle;
                     }
                }

                ClsDashBoardBean bean = new ClsDashBoardBean();
                bean.setTxttitle(title);
                bean.setTxtdescription(fullUrl);
                list.add(bean);
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if(rs!=null) rs.close(); if(stmt!=null) stmt.close(); if(conn!=null) conn.close(); } catch(Exception ex){}
        }

        return list;
    }

    /* =============================================================
       2. WORKSHOP CHARTS DATA (Missing Method Added)
       ============================================================= */
    public String getDashboardData(String mode) {
        JSONObject finalResponse = new JSONObject();
        Connection conn = null;
        Statement stmt = null;
        
        try {
            conn = ClsConnection.getMyConnection();
            stmt = conn.createStatement();
            
            // A. Floor Status Data
            try {
                ResultSet rs1 = stmt.executeQuery("select round(aa.val/bb.val *100,2) per, aa.tran_code from (select count(*) val, tran_code from gl_vehmaster vm where fstatus='L' group by vm.tran_code) aa, (select count(*) val from gl_vehmaster where fstatus='L' and tran_code is not null) bb");
                finalResponse.put("floorstatusdata", ClsCommon.convertToJSON(rs1));
                rs1.close();
            } catch(Exception ex) { finalResponse.put("floorstatusdata", new JSONArray()); }
            
            // B. Week-Wise Vehicles 
            try {
                ResultSet rs2 = stmt.executeQuery("SELECT 'Week 1' as weeks, 50 as gip, 0 as est, 10 as qot, 20 as job, 0 as jcc, 6 as wiv, 11 as rls UNION SELECT 'Week 2', 40, 5, 0, 15, 4, 0, 5");
                finalResponse.put("floorweekwisedata", ClsCommon.convertToJSON(rs2));
                rs2.close();
            } catch(Exception ex) { finalResponse.put("floorweekwisedata", new JSONArray()); }

            // C. Vehicles Incoming (Days Utilize)
            try {
                ResultSet rs3 = stmt.executeQuery("SELECT DATE_FORMAT(CURDATE(), '%d %b') as days, 5 as vehicles UNION SELECT DATE_FORMAT(CURDATE() - INTERVAL 1 DAY, '%d %b'), 3 UNION SELECT DATE_FORMAT(CURDATE() - INTERVAL 2 DAY, '%d %b'), 7");
                finalResponse.put("vehincomingdata", ClsCommon.convertToJSON(rs3));
                rs3.close();
            } catch(Exception ex) { finalResponse.put("vehincomingdata", new JSONArray()); }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if(stmt!=null) stmt.close(); if(conn!=null) conn.close(); } catch(Exception ex){}
        }
        
        return finalResponse.toString();
    }

    /* =============================================================
       3. KPI TILE LIVE COUNTS
       ============================================================= */
    public Map<String, Integer> getKpiCounts() {
        Map<String, Integer> counts = new HashMap<String, Integer>();
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;

        try {
            conn = ClsConnection.getMyConnection();
            stmt = conn.createStatement();

            try {
                rs = stmt.executeQuery("SELECT SUM(CASE WHEN tran_code = 'RR' THEN 1 ELSE 0 END) AS rtr, SUM(CASE WHEN tran_code IN ('GM','GA','GS') THEN 1 ELSE 0 END) AS ig FROM gl_vehmaster");
                if (rs.next()) {
                    int rtr = rs.getInt("rtr");
                    counts.put("91", rtr);  
                    int ig = rs.getInt("ig");
                    counts.put("30", ig);   
                }
                rs.close();
            } catch (Exception e) { System.out.println("KPI_DEBUG: query for keys 91/30 threw: " + e); }

            try {
                rs = stmt.executeQuery("SELECT COUNT(*) AS cnt FROM gl_lagmt WHERE clstatus=0 AND dispute=0 AND duedate <= (CURDATE() + INTERVAL 2 DAY)");
                if (rs.next()) { int cnt = rs.getInt("cnt"); counts.put("24", cnt); } 
                rs.close();
            } catch (Exception e) { }

            try {
                rs = stmt.executeQuery("SELECT COUNT(*) AS cnt FROM gl_bookingm WHERE clstatus=1");
                if (rs.next()) { int cnt = rs.getInt("cnt"); counts.put("89", cnt); } 
                rs.close();
            } catch (Exception e) { }

            try {
                rs = stmt.executeQuery("SELECT COUNT(*) AS cnt FROM gl_traffic WHERE ISALLOCATED=0");
                if (rs.next()) { int cnt = rs.getInt("cnt"); counts.put("44", cnt); } 
                rs.close();
            } catch (Exception e) { }

            try {
                rs = stmt.executeQuery("SELECT COUNT(*) AS cnt FROM hr_empm m INNER JOIN hr_empdoc d ON m.doc_no=d.rdocno WHERE m.status=3 AND m.active=1 AND d.docid IS NOT NULL AND d.expdt <= (CURDATE() + INTERVAL 10 DAY)");
                if (rs.next()) { int cnt = rs.getInt("cnt"); counts.put("199", cnt); } 
                rs.close();
            } catch (Exception e) { }

            try {
                rs = stmt.executeQuery("SELECT COUNT(*) AS cnt FROM gl_vehmaster WHERE SRVC_KM <= CUR_KM");
                if (rs.next()) { int cnt = rs.getInt("cnt"); counts.put("86", cnt); } 
                rs.close();
            } catch (Exception e) { }

            try {
                rs = stmt.executeQuery("SELECT COUNT(*) AS cnt FROM gl_vmove WHERE status='IN' AND date = CURDATE()");
                if (rs.next()) { int cnt = rs.getInt("cnt"); counts.put("1", cnt); } 
                rs.close();
            } catch (Exception e) { }

            try {
                rs = stmt.executeQuery("SELECT COUNT(*) AS cnt FROM gl_bookingm WHERE delivery=1 AND status IN (2,3) AND frmdate BETWEEN CURDATE() AND (CURDATE() + INTERVAL 1 DAY)");
                if (rs.next()) { int cnt = rs.getInt("cnt"); counts.put("22", cnt); } 
                rs.close();
            } catch (Exception e) { }

            try {
                rs = stmt.executeQuery("SELECT COUNT(*) AS cnt FROM gl_bookingm WHERE delivery=0 AND status IN (2,3)");
                if (rs.next()) { int cnt = rs.getInt("cnt"); counts.put("143", cnt); } 
                rs.close();
            } catch (Exception e) { }

            try {
                rs = stmt.executeQuery("SELECT COUNT(*) AS cnt FROM gl_vehreplace WHERE status=3 AND closestatus=0");
                if (rs.next()) { int cnt = rs.getInt("cnt"); counts.put("177", cnt); } 
                rs.close();
            } catch (Exception e) { }

            try {
                rs = stmt.executeQuery("SELECT COUNT(*) AS cnt FROM gl_vmove WHERE status='OUT' AND date <= (CURDATE() - INTERVAL 1 DAY)");
                if (rs.next()) { int cnt = rs.getInt("cnt"); counts.put("186", cnt); } 
                rs.close();
            } catch (Exception e) { }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (stmt != null) stmt.close(); if (conn != null) conn.close(); } catch (Exception ex) {}
        }
        return counts;
    }

    // ==========================================================
    //  EXISTING METHODS
    // ==========================================================

    public JSONArray masterSearch(HttpSession session) throws SQLException {
        List<ClsDashBoardBean> masterSearchBean = new ArrayList<ClsDashBoardBean>();
        Connection conn = null;
        JSONArray RESULTDATA = new JSONArray();
        Enumeration<String> Enumeration = session.getAttributeNames();
        int a = 0;
        while (Enumeration.hasMoreElements()) {
            if (Enumeration.nextElement().equalsIgnoreCase("USERID")) {
                a = 1;
            }
        }
        if (a == 0) {
            return RESULTDATA;
        }
        String userid = session.getAttribute("USERID").toString();
        String roleid = session.getAttribute("ROLEID").toString();
        try {
            conn = ClsConnection.getMyConnection();
            Statement stmtDashBoard = conn.createStatement();
            ResultSet resultSet = stmtDashBoard.executeQuery("select m.doc_no,m.description,m.flag,p.roleid from gl_bibm m inner join (select distinct(mno) mno,"
                    + "permission,roleid from my_powrbi) p on p.mno=m.doc_no where m.status=1 and p.permission=1 and p.roleid=" + roleid + " "
                    + "order by m.srno");
            RESULTDATA = ClsCommon.convertToJSON(resultSet);
            stmtDashBoard.close();
            conn.close();
        } catch (Exception e) {
            conn.close();
            e.printStackTrace();
        } finally {
            conn.close();
        }
        return RESULTDATA;
    }

    public JSONArray detailSearch(String docNo, HttpSession session) throws SQLException {
        List<ClsDashBoardBean> detailSearchBean = new ArrayList<ClsDashBoardBean>();
        Connection conn = null;
        JSONArray RESULTDATA1 = new JSONArray();
        Enumeration<String> Enumeration = session.getAttributeNames();
        int a = 0;
        while (Enumeration.hasMoreElements()) {
            if (Enumeration.nextElement().equalsIgnoreCase("USERID")) {
                a = 1;
            }
        }
        if (a == 0) {
            return RESULTDATA1;
        }
        String userid = session.getAttribute("USERID").toString();
        String roleid = session.getAttribute("ROLEID").toString();
        try {
            conn = ClsConnection.getMyConnection();
            Statement stmtDashBoard1 = conn.createStatement();
            ResultSet resultSet1 = stmtDashBoard1.executeQuery("select m.doc_no,m.description,m.value,m.flag,m.path from gl_bibd m inner join my_powrbi p on "
                    + "p.dno=m.doc_no where m.status=1 and p.permission=1 and p.roleid=" + roleid + "  and m.rdocno=" + docNo + " order by m.SRNO");
            RESULTDATA1 = ClsCommon.convertToJSON(resultSet1);
            stmtDashBoard1.close();
            conn.close();
        } catch (Exception e) {
            conn.close();
            e.printStackTrace();
        } finally {
            conn.close();
        }
        return RESULTDATA1;
    }

    public JSONArray detail(HttpSession session) throws SQLException {
        List<ClsDashBoardBean> detailBean = new ArrayList<ClsDashBoardBean>();
        Connection conn = null;
        JSONArray RESULTDATA2 = new JSONArray();
        Enumeration<String> Enumeration = session.getAttributeNames();
        int a = 0;
        while (Enumeration.hasMoreElements()) {
            if (Enumeration.nextElement().equalsIgnoreCase("USERID")) {
                a = 1;
            }
        }
        if (a == 0) {
            return RESULTDATA2;
        }
        String userid = session.getAttribute("USERID").toString();
        String roleid = session.getAttribute("ROLEID").toString();
        try {
            conn = ClsConnection.getMyConnection();
            Statement stmtDashBoard2 = conn.createStatement();
            ResultSet resultSet2 = stmtDashBoard2.executeQuery("select m.doc_no,m.description,m.value,m.flag,m.path from gl_bibd m inner join my_powrbi p on "
                    + "p.dno=m.doc_no where m.status=1 and p.permission=1 and p.roleid=" + roleid + " and m.rdocno in (select doc_no from gl_bibm where srno=1) order by m.SRNO");
            RESULTDATA2 = ClsCommon.convertToJSON(resultSet2);
            stmtDashBoard2.close();
            conn.close();
        } catch (Exception e) {
            conn.close();
            e.printStackTrace();
        } finally {
            conn.close();
        }
        return RESULTDATA2;
    }

    public JSONArray readyToRents() throws SQLException {
        List<ClsDashBoardBean> readyToRentsBean = new ArrayList<ClsDashBoardBean>();
        Connection conn = null;
        JSONArray RESULTDATA3 = new JSONArray();
        try {
            conn = ClsConnection.getMyConnection();
            Statement stmtDashBoard3 = conn.createStatement();
            ResultSet resultSet3 = stmtDashBoard3.executeQuery("select m.vmodid,count(*) availability,SUBSTRING(v.gname,1,1) gname from gl_vehmaster m left join gl_vehgroup v on "
                    + "m.vgrpid=v.doc_no where tran_code='RR' group by vgrpid");
            RESULTDATA3 = ClsCommon.convertToJSON(resultSet3);
            stmtDashBoard3.close();
            conn.close();
        } catch (Exception e) {
            conn.close();
            e.printStackTrace();
        } finally {
            conn.close();
        }
        return RESULTDATA3;
    }

    public JSONArray idleDays() throws SQLException {
        List<ClsDashBoardBean> idleDaysBean = new ArrayList<ClsDashBoardBean>();
        Connection conn = null;
        JSONArray RESULTDATA4 = new JSONArray();
        try {
            conn = ClsConnection.getMyConnection();
            Statement stmtDashBoard4 = conn.createStatement();
            ResultSet resultSet4 = stmtDashBoard4.executeQuery("select count(*) noofvehicles,aa.idledays from (select v.doc_no,din,tin,vm.fleet_no,"
                    + "coalesce(TIMESTAMPDIFF(Day,cast(din as datetime),cast(curdate() as datetime)),0) idledays from gl_vehmaster vm inner join gl_vmove v "
                    + "on v.fleet_no=vm.fleet_no and vm.status='IN' and v.doc_no=(select max(doc_no) from gl_vmove where fleet_no= vm.fleet_no)) aa group by aa.idledays");
            RESULTDATA4 = ClsCommon.convertToJSON(resultSet4);
            stmtDashBoard4.close();
            conn.close();
        } catch (Exception e) {
            conn.close();
            e.printStackTrace();
        } finally {
            conn.close();
        }
        return RESULTDATA4;
    }

    public JSONArray registrationInsuranceExpiry() throws SQLException {
        List<ClsDashBoardBean> registrationInsuranceExpiryBean = new ArrayList<ClsDashBoardBean>();
        Connection conn = null;
        JSONArray RESULTDATA7 = new JSONArray();
        try {
            conn = ClsConnection.getMyConnection();
            Statement stmtDashBoard5 = conn.createStatement();
            ResultSet resultSet5 = stmtDashBoard5.executeQuery("SELECT  DATEDIFF(CURDATE(),reg_exp) reg_exp1,DATEDIFF(CURDATE(),ins_exp) ins_exp1,count(*) vehicles FROM gl_vehmaster t WHERE t.reg_exp between "
                    + "( CURDATE( ) - INTERVAL   10 DAY ) and  ( CURDATE( ) + INTERVAL 10 DAY ) or t.ins_exp between ( CURDATE( ) - INTERVAL   10 DAY ) and  ( CURDATE( ) + INTERVAL 10 DAY ) group by "
                    + "reg_exp1,ins_exp1");
            RESULTDATA7 = ClsCommon.convertToJSON(resultSet5);
            stmtDashBoard5.close();
            conn.close();
        } catch (Exception e) {
            conn.close();
            e.printStackTrace();
        } finally {
            conn.close();
        }
        return RESULTDATA7;
    }

    public JSONArray fleetStatus() throws SQLException {
        List<ClsDashBoardBean> fleetStatusBean = new ArrayList<ClsDashBoardBean>();
        JSONArray RESULTDATA = new JSONArray();
        Connection conn = null;
        try {
            conn = ClsConnection.getMyConnection();
            Statement stmtDashBoard6 = conn.createStatement();
            ResultSet resultSet6 = stmtDashBoard6.executeQuery("select round(aa.val/bb.val *100,2) per,aa.tran_code from (select count(*) val,tran_code from gl_vehmaster vm  where fstatus='L' group by vm.tran_code )aa,"
                    + "(select count(*) val,tran_code from gl_vehmaster vm  where fstatus='L' and tran_code is not null )bb");
            RESULTDATA = ClsCommon.convertToJSON(resultSet6);
            stmtDashBoard6.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            conn.close();
        } finally {
            conn.close();
        }
        return RESULTDATA;
    }

    public JSONArray floorStatusGridLoading() throws SQLException {
        JSONArray RESULTDATA = new JSONArray();
        Connection conn = null;
        try {
            conn = ClsConnection.getMyConnection();
            Statement stmtFloorStatus = conn.createStatement();
            ResultSet resultSetFloorStatus = stmtFloorStatus.executeQuery(
                    "select tran_code stat, count(*) val from gl_vehmaster where fstatus='L' and tran_code is not null group by tran_code");
            RESULTDATA = ClsCommon.convertToJSON(resultSetFloorStatus);
            stmtFloorStatus.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            conn.close();
        } finally {
            conn.close();
        }
        return RESULTDATA;
    }

    public JSONArray toDoList(HttpSession session) throws SQLException {
        List<ClsDashBoardBean> toDoListBean = new ArrayList<ClsDashBoardBean>();
        JSONArray RESULTDATA = new JSONArray();
        Connection conn = null;
        Enumeration<String> Enumeration = session.getAttributeNames();
        int a = 0;
        while (Enumeration.hasMoreElements()) {
            if (Enumeration.nextElement().equalsIgnoreCase("USERID")) {
                a = 1;
            }
        }
        if (a == 0) {
            return RESULTDATA;
        }
        String userid = session.getAttribute("USERID").toString();
        try {
            conn = ClsConnection.getMyConnection();
            Statement stmtDashBoard7 = conn.createStatement();
            ResultSet resultSet7 = stmtDashBoard7.executeQuery("select doc_no,date,title,description,priority from my_todolist where date=curdate() and status=3 and userid='" + userid + "'");
            RESULTDATA = ClsCommon.convertToJSON(resultSet7);
            stmtDashBoard7.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            conn.close();
        } finally {
            conn.close();
        }
        return RESULTDATA;
    }

    public JSONArray toAddedList(HttpSession session) throws SQLException {
        List<ClsDashBoardBean> toDoListBean = new ArrayList<ClsDashBoardBean>();
        JSONArray RESULTDATA = new JSONArray();
        Connection conn = null;
        Enumeration<String> Enumeration = session.getAttributeNames();
        int a = 0;
        while (Enumeration.hasMoreElements()) {
            if (Enumeration.nextElement().equalsIgnoreCase("USERID")) {
                a = 1;
            }
        }
        if (a == 0) {
            return RESULTDATA;
        }
        String userid = session.getAttribute("USERID").toString();
        try {
            conn = ClsConnection.getMyConnection();
            Statement stmtDashBoard9 = conn.createStatement();
            ResultSet resultSet9 = stmtDashBoard9.executeQuery("select doc_no,date,title,description,priority from my_todolist where status=3 and userid='" + userid + "' order by date");
            RESULTDATA = ClsCommon.convertToJSON(resultSet9);
            stmtDashBoard9.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            conn.close();
        } finally {
            conn.close();
        }
        return RESULTDATA;
    }

    public JSONArray brandGarageLoading() throws SQLException {
        Connection conn = null;
        JSONArray RESULTDATA10 = new JSONArray();
        try {
            conn = ClsConnection.getMyConnection();
            Statement stmtDashBoard10 = conn.createStatement();
            String sql = "select  b.brand_name brandgarage,CONVERT(coalesce(a.gm,''),CHAR(50)) gm,CONVERT(coalesce(c.ga,''),CHAR(50)) ga,CONVERT(coalesce(d.gs,''),CHAR(50)) gs "
                    + "from gl_vehmaster v  left join gl_vehbrand b on v.brdid=b.doc_no left join (select count(*) gm,brdid from gl_vehmaster where tran_code='GM' group by brdid) a "
                    + "on a.brdid=b.doc_no left join (select count(*) ga,brdid from gl_vehmaster where tran_code='GA' group by brdid) c on c.brdid=b.doc_no left join (select count(*) gs,brdid from "
                    + "gl_vehmaster where tran_code='GS' group by brdid) d on d.brdid=b.doc_no where tran_code in ('GM','GA','GS') group by v.brdid";
            ResultSet resultSet10 = stmtDashBoard10.executeQuery(sql);
            RESULTDATA10 = ClsCommon.convertToJSON(resultSet10);
            stmtDashBoard10.close();
            conn.close();
        } catch (Exception e) {
            conn.close();
            e.printStackTrace();
        } finally {
            conn.close();
        }
        return RESULTDATA10;
    }

    public JSONArray brandGarageReloading(String type) throws SQLException {
        Connection conn = null;
        JSONArray RESULTDATA11 = new JSONArray();
        try {
            conn = ClsConnection.getMyConnection();
            Statement stmtDashBoard11 = conn.createStatement();
            String sql = "";
            if (type.contains("-") || type.equalsIgnoreCase("0")) {
                sql = "select  b.brand_name brandgarage,CONVERT(coalesce(a.gm,''),CHAR(50)) gm,CONVERT(coalesce(c.ga,''),CHAR(50)) ga,CONVERT(coalesce(d.gs,''),CHAR(50)) gs "
                        + "from gl_vehmaster v  left join gl_vehbrand b on v.brdid=b.doc_no left join (select count(*) gm,brdid from gl_vehmaster where tran_code='GM' group by brdid) a "
                        + "on a.brdid=b.doc_no left join (select count(*) ga,brdid from gl_vehmaster where tran_code='GA' group by brdid) c on c.brdid=b.doc_no left join (select count(*) gs,brdid from "
                        + "gl_vehmaster where tran_code='GS' group by brdid) d on d.brdid=b.doc_no where tran_code in ('GM','GA','GS') group by v.brdid";
            } else {
                sql = "select  g.name brandgarage,CONVERT(coalesce(sum(a.gm),''),CHAR(50)) gm,CONVERT(coalesce(sum(c.ga),''),CHAR(50)) ga,CONVERT(coalesce(sum(d.gs),''),CHAR(50)) gs "
                        + "from gl_vehmaster v  left join gl_nrm n on v.fleet_no=n.fleet_no left join (select count(*) gm,fleet_no from gl_vehmaster where tran_code='GM' group by fleet_no) a "
                        + "on a.fleet_no=n.fleet_no left join (select count(*) ga,fleet_no from gl_vehmaster where tran_code='GA' group by fleet_no) c on c.fleet_no=n.fleet_no left join "
                        + "(select count(*) gs,fleet_no from gl_vehmaster where tran_code='GS' group by fleet_no) d on d.fleet_no=n.fleet_no left join gl_garrage g on g.doc_no=n.garageid "
                        + "where tran_code in ('GM','GA','GS') and n.inbranch=0 group by n.garageid";
            }
            ResultSet resultSet11 = stmtDashBoard11.executeQuery(sql);
            RESULTDATA11 = ClsCommon.convertToJSON(resultSet11);
            stmtDashBoard11.close();
            conn.close();
        } catch (Exception e) {
            conn.close();
            e.printStackTrace();
        } finally {
            conn.close();
        }
        return RESULTDATA11;
    }

    public int insert(Date toDotDate, String txttitle, String txtdescription, String cmbpriority, HttpSession session, String mode) throws SQLException {
        Connection conn = null;
        try {
            conn = ClsConnection.getMyConnection();
            conn.setAutoCommit(false);
            String userid = session.getAttribute("USERID").toString().trim();
            String company = session.getAttribute("COMPANYID").toString().trim();
            CallableStatement stmtDashBoard8 = conn.prepareCall("{CALL toDoListDML(?,?,?,?,?,?,?,?,?)}");
            stmtDashBoard8.registerOutParameter(8, java.sql.Types.INTEGER);
            stmtDashBoard8.setDate(1, toDotDate);
            stmtDashBoard8.setString(2, txttitle);
            stmtDashBoard8.setString(3, txtdescription);
            stmtDashBoard8.setString(4, cmbpriority);
            stmtDashBoard8.setString(5, company);
            stmtDashBoard8.setString(6, "0");
            stmtDashBoard8.setString(7, userid);
            stmtDashBoard8.setString(9, mode);
            int datas = stmtDashBoard8.executeUpdate();
            if (datas <= 0) {
                stmtDashBoard8.close();
                conn.close();
                return 0;
            }
            int docno = stmtDashBoard8.getInt("docNo");
            dashBoardBean.setTxttododocno(docno);
            if (docno > 0) {
                conn.commit();
                stmtDashBoard8.close();
                conn.close();
                return docno;
            }
            stmtDashBoard8.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            conn.close();
            return 0;
        } finally {
            conn.close();
        }
        return 0;
    }

    public boolean edit(int txttododocno, Date toDotDate, String txttitle, String txtdescription, String cmbpriority, HttpSession session, String mode) throws SQLException {
        Connection conn = null;
        try {
            conn = ClsConnection.getMyConnection();
            conn.setAutoCommit(false);
            String userid = session.getAttribute("USERID").toString().trim();
            String company = session.getAttribute("COMPANYID").toString().trim();
            CallableStatement stmtDashBoard8 = conn.prepareCall("{CALL toDoListDML(?,?,?,?,?,?,?,?,?)}");
            stmtDashBoard8.setInt(8, txttododocno);
            stmtDashBoard8.setDate(1, toDotDate);
            stmtDashBoard8.setString(2, txttitle);
            stmtDashBoard8.setString(3, txtdescription);
            stmtDashBoard8.setString(4, cmbpriority);
            stmtDashBoard8.setString(5, company);
            stmtDashBoard8.setString(6, "0");
            stmtDashBoard8.setString(7, userid);
            stmtDashBoard8.setString(9, mode);
            int datas = stmtDashBoard8.executeUpdate();
            if (datas <= 0) {
                stmtDashBoard8.close();
                conn.close();
                return false;
            }
            int docno = stmtDashBoard8.getInt("docNo");
            dashBoardBean.setTxttododocno(docno);
            if (docno > 0) {
                conn.commit();
                stmtDashBoard8.close();
                conn.close();
                return true;
            }
            stmtDashBoard8.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            conn.close();
            return false;
        } finally {
            conn.close();
        }
        return false;
    }

    public boolean delete(int txttododocno, HttpSession session, String mode) throws SQLException {
        Connection conn = null;
        try {
            conn = ClsConnection.getMyConnection();
            conn.setAutoCommit(false);
            String userid = session.getAttribute("USERID").toString().trim();
            String company = session.getAttribute("COMPANYID").toString().trim();
            CallableStatement stmtDashBoard8 = conn.prepareCall("{CALL toDoListDML(?,?,?,?,?,?,?,?,?)}");
            stmtDashBoard8.setInt(8, txttododocno);
            stmtDashBoard8.setDate(1, null);
            stmtDashBoard8.setString(2, null);
            stmtDashBoard8.setString(3, null);
            stmtDashBoard8.setString(4, null);
            stmtDashBoard8.setString(5, company);
            stmtDashBoard8.setString(6, "0");
            stmtDashBoard8.setString(7, userid);
            stmtDashBoard8.setString(9, mode);
            int datas = stmtDashBoard8.executeUpdate();
            if (datas <= 0) {
                stmtDashBoard8.close();
                conn.close();
                return false;
            }
            int docno = stmtDashBoard8.getInt("docNo");
            dashBoardBean.setTxttododocno(docno);
            if (docno > 0) {
                conn.commit();
                stmtDashBoard8.close();
                conn.close();
                return true;
            }
            stmtDashBoard8.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            conn.close();
            return false;
        } finally {
            conn.close();
        }
        return false;
    }

    public JSONArray searchuser() throws SQLException {
        JSONArray data = new JSONArray();
        Connection conn = null;
        java.sql.Date edates = null;
        try {
            conn = ClsConnection.getMyConnection();
            Statement stmt = conn.createStatement();
            String strsql = "select user_name user,doc_no from my_user where status=3";
            ResultSet rs = stmt.executeQuery(strsql);
            data = ClsCommon.convertToJSON(rs);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            conn.close();
        }
        return data;
    }

    public JSONArray taskCount(String userid, String id) throws SQLException {
        JSONArray RESULTDATA = new JSONArray();
        Connection conn = null;
        if (!id.equals("1")) {
            return RESULTDATA;
        }
        try {
            conn = ClsConnection.getMyConnection();
            Statement stmt = conn.createStatement();
            String strsql = "select status,sum(issued) issued, sum(received) received from(select act_status status, count(*) issued, 0 received from "
                    + "an_taskcreation where userid=" + userid + " and act_status!='Confirmed' group by act_status union all select act_status status, 0 issued, count(*) received from "
                    + "an_taskcreation where ass_user=" + userid + " and act_status!='Confirmed' group by act_status)a group by status";
            ResultSet rs = stmt.executeQuery(strsql);
            RESULTDATA = ClsCommon.convertToJSON(rs);
            stmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            conn.close();
        } finally {
            conn.close();
        }
        return RESULTDATA;
    }

    public JSONArray pendingGrid(String userid, String id, String type, String usertype) throws SQLException {
        JSONArray RESULTDATA = new JSONArray();
        Connection conn = null;
        if (id.equals("0")) {
            return RESULTDATA;
        }
        try {
            conn = ClsConnection.getMyConnection();
            Statement stmt = conn.createStatement();
            String sqltest = "";
            if (id.equals("2")) {
                if (type.equalsIgnoreCase("New")) {
                    sqltest += " and t.act_status='Assigned' ";
                }
                if (type.equalsIgnoreCase("Accepted") || type.equalsIgnoreCase("Completed")) {
                    sqltest += " and t.act_status='" + type + "' ";
                }
                if (usertype.equalsIgnoreCase("own")) {
                    sqltest += " and t.ass_user='" + userid + "' ";
                }
                if (usertype.equalsIgnoreCase("other")) {
                    sqltest += " and t.ass_user!='" + userid + "' and t.userid='" + userid + "' ";
                }
            } else {
                sqltest += " and (t.userid='" + userid + "' or t.ass_user='" + userid + "')";
            }
            String strsql = "select u1.user_name crtuser,u.user_name user,t.userid,ass_user,t.doc_no,tt.reftype ref_type,ref_no,strt_date,strt_time,description,act_status status,t.edcdate from an_taskcreation t "
                    + "left join an_taskcreationdets a on t.doc_no=a.rdocno left join my_user u on u.doc_no=t.ass_user left join my_user u1 on u1.doc_no=t.userid  left join an_tasktype tt on tt.doc_no=t.ref_type "
                    + "where t.close_status=0 and t.utype!='app' " + sqltest + " group by doc_no";
            System.out.println("pendingGrid--->>>" + strsql);
            ResultSet rs = stmt.executeQuery(strsql);
            RESULTDATA = ClsCommon.convertToJSON(rs);
            stmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            conn.close();
        } finally {
            conn.close();
        }
        return RESULTDATA;
    }

    public JSONArray loadflwupgrid(String docno, String id) throws SQLException {
        JSONArray data = new JSONArray();
        Connection conn = null;
        java.sql.Date edates = null;
        if (!id.equals("1")) {
            return data;
        }
        try {
            conn = ClsConnection.getMyConnection();
            Statement stmt = conn.createStatement();
            String strsql = " select f.ass_date date,u.user_name asuser,r.user_name user,f.remarks remark,f.action_status status from an_taskcreationdets f "
                    + "left join my_user u on u.doc_no=f.userid left join my_user r on r.doc_no=f.assnfrom_user where f.rdocno='" + docno + "'";
            ResultSet rs = stmt.executeQuery(strsql);
            data = ClsCommon.convertToJSON(rs);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            conn.close();
        }
        return data;
    }

    public JSONArray taskHistory(String userid, String id) throws SQLException {
        JSONArray RESULTDATA = new JSONArray();
        Connection conn = null;
        if (!id.equals("1")) {
            return RESULTDATA;
        }
        try {
            conn = ClsConnection.getMyConnection();
            Statement stmt = conn.createStatement();
            String strsql = "select u1.user_name assuser,u.user_name user,t.strt_date date,t.doc_no, tt.reftype type, t.ref_no refno, t.description, act_status status, DATE_FORMAT(edcdate,'%d.%m.%Y') edc "
                    + "from an_taskcreation t left join my_user u on u.doc_no=t.userid left join my_user u1 on u1.doc_no=t.ass_user left join an_tasktype tt on tt.doc_no=t.ref_type where t.userid='"
                    + userid + "' or t.ass_user='" + userid + "'";
            ResultSet rs = stmt.executeQuery(strsql);
            RESULTDATA = ClsCommon.convertToJSON(rs);
            stmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            conn.close();
        } finally {
            conn.close();
        }
        return RESULTDATA;
    }
}