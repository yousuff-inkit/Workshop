<%@page import="com.finance.transactions.contratrans.ClsContraTransDAO"%>
<%@page import="com.common.ClsCommon"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String strpartsarray[] = request.getParameterValues("strpartsarray[]");
String estdocno = request.getParameter("estdocno") == null ? "" : request.getParameter("estdocno");
String date = request.getParameter("date") == null ? "" : request.getParameter("date");
String fromaccount = request.getParameter("fromaccount") == null ? "" : request.getParameter("fromaccount");
String toaccount = request.getParameter("toaccount") == null ? "" : request.getParameter("toaccount");
String totalcdamount = request.getParameter("totalcdamount") == null ? "" : request.getParameter("totalcdamount");
String remarks = request.getParameter("remarks") == null ? "" : request.getParameter("remarks");

Connection conn = null;
JSONObject objdata = new JSONObject();
int errorstatus = 0;
try {
    ClsConnection objconn = new ClsConnection();
    ClsCommon objcommon = new ClsCommon();
    conn = objconn.getMyConnection();

    Statement stmt = conn.createStatement();

    conn.setAutoCommit(false);

    java.sql.Date sqldate = null;
    if (!date.trim().equalsIgnoreCase("")) {
        sqldate = objcommon.changeStringtoSqlDate(date);
    }

    ClsContraTransDAO DAO = new ClsContraTransDAO();

    String fromAccType = fromaccount.split("###")[0];
    String fromAccId = fromaccount.split("###")[1];
    String fromCurId = "1";
    Double fromCurrRate = 1.0;

    String fromCurSql = "select a.curid,a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate " +
        "from my_curbook cb where coalesce(toDate,curdate())>='" + sqldate + "' and frmDate<='" + sqldate + "'" +
        "group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) " +
        "inner join my_head h on h.curid=a.curid where h.doc_no=" + fromAccId + ";";

    ResultSet fromCurRs = stmt.executeQuery(fromCurSql);
    while (fromCurRs.next()) {
        fromCurId = fromCurRs.getString("curid");
        fromCurrRate = fromCurRs.getDouble("rate");
    }

    String toAccType = toaccount.split("###")[0];
    String toAccId = toaccount.split("###")[1];
    String toCurId = "1";
    Double toCurrRate = 1.0;

    String toCurSql = "select a.curid,a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate " +
        "from my_curbook cb where coalesce(toDate,curdate())>='" + sqldate + "' and frmDate<='" + sqldate + "'" +
        "group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) " +
        "inner join my_head h on h.curid=a.curid where h.doc_no=" + toAccId + ";";

    ResultSet toCurRs = stmt.executeQuery(toCurSql);
    while (toCurRs.next()) {
        toCurId = toCurRs.getString("curid");
        toCurrRate = toCurRs.getDouble("rate");
    }

    double amount = Double.parseDouble(totalcdamount);
    double fromBaseAmount = amount * fromCurrRate;
    double toBaseAmount = amount * toCurrRate;

    /*Cash Payment Saving*/
	ArrayList cashpaymentarray= new ArrayList();
	cashpaymentarray.add(fromAccId+"::"+fromCurId+"::"+fromCurrRate+"::false::"+amount*-1+"::"+remarks+"::"+fromBaseAmount*-1+"::0::0::0");
	cashpaymentarray.add(toAccId+"::"+toCurId+"::"+toCurrRate+"::true::"+amount+"::"+remarks+"::"+toBaseAmount+"::0::0::0");
	
	/*Bank Payment Saving*/
	ArrayList bankpaymentarray= new ArrayList();
	bankpaymentarray.add(fromAccId+"::"+fromCurId+"::"+fromCurrRate+"::false::"+amount*-1+"::"+remarks+"::"+fromBaseAmount*-1+"::0::0::0::"+0+"::"+0);
	bankpaymentarray.add(toAccId+"::"+toCurId+"::"+toCurrRate+"::true::"+amount+"::"+remarks+"::"+toBaseAmount+"::0::0::0::"+0+"::"+0);
	
	/*Ib-Cash Payment Grid Saving*/
	ArrayList ibcashpaymentarray= new ArrayList();
	
	/*Ib-Bank Payment Saving*/
	ArrayList ibbankpaymentarray= new ArrayList();

    int contra = DAO.insert(sqldate, "COT", estdocno, fromAccType, Integer.parseInt(fromAccId), fromCurId, fromCurrRate,
        0, 0, "", sqldate, amount, fromBaseAmount, remarks, 0,
        "", toAccType, Integer.parseInt(toAccId), toCurId, toCurrRate, amount, toBaseAmount,
        cashpaymentarray, ibcashpaymentarray, bankpaymentarray, ibbankpaymentarray, session, request, "A");

    objdata.put("refdocno", contra);

    if (contra <= 0) {
        errorstatus = 1;
    }

    for (int i = 0; i < strpartsarray.length; i++) {
        String rowno = strpartsarray[i].split("::")[0].trim();
        String cotqty = strpartsarray[i].split("::")[1].trim();
        String cotamount = strpartsarray[i].split("::")[2].trim();
        cotqty = cotqty == null || cotqty.trim().equalsIgnoreCase("") || cotqty.trim().equalsIgnoreCase("undefined") ? "0" : cotqty;
        cotamount = cotamount == null || cotamount.trim().equalsIgnoreCase("") || cotamount.trim().equalsIgnoreCase("undefined") ? "0" : cotamount;

        String strupdaterows = "";
        if (rowno != null && !rowno.trim().equalsIgnoreCase("") && !rowno.trim().equalsIgnoreCase("undefined")) {
            strupdaterows = "update ws_estspare set cotno=if(cotno='','" + contra + "',concat(cotno,'," + contra + "')), cotqty=cotqty+" + cotqty + ", cotamount=cotamount+" + cotamount +
                " where rdocno=" + estdocno + " and rowno=" + rowno.trim();

            int update = stmt.executeUpdate(strupdaterows);
            if (update < 0) {
                errorstatus = 1;
            }
            String strins="insert into ws_estsparepurchased(estdocno, estspare_rowno, dtype, doc_no, qty, price) values ("+estdocno+","+rowno.trim()+",'COT',"+contra+","+cotqty+","+cotamount+")";
			update=stmt.executeUpdate(strins);
			if (update < 0) {
	        	errorstatus = 1;
	        }
        }
    }

    if (errorstatus == 0) {
        conn.commit();
        conn.close();
    }
} catch (Exception e) {
    e.printStackTrace();
    conn.close();
} finally {}
objdata.put("errorstatus", errorstatus);
response.getWriter().write(objdata + "");
%>