<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath = request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>

<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />

<style type="text/css">
/* =========================================================
   SCOPED UI: Modern Segoe UI Theme & Search Panel
========================================================= */
html, body {
    margin: 0;
    padding: 0;
    background-color: #ffffff !important; 
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif; 
}

.modern-ui {
    font-size: 12px;
    color: #333;
    padding: 10px;
    box-sizing: border-box;
    width: 100%;
    background-color: #ffffff !important; 
}

/* Standardized Input & Select Controls */
.modern-ui input[type="text"],
.modern-ui select {
    height: 24px !important;
    border: 1px solid #BDBDBD;
    border-radius: 3px;
    padding: 2px 6px;
    font-size: 12px; 
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    box-sizing: border-box;
    background-color: #ffffff !important; 
    color: #333;
    width: 100%;
}

.modern-ui input[type="text"]:focus,
.modern-ui select:focus {
    border-color: #007bff;
    outline: none;
}

/* Panel Container */
.modern-ui .search-panel {
    background-color: #ffffff !important; 
    border: 1px solid #BDBDBD;
    border-radius: 4px;
    padding: 12px 10px;
    margin-bottom: 10px;
    width: 100%;
    box-sizing: border-box;
    overflow-x: auto; 
}

/* Grid Layout Table */
.modern-ui table.form-grid {
    border-collapse: separate;
    border-spacing: 5px 8px; 
    width: 100%;
    min-width: 900px; 
    background-color: #ffffff !important; 
}

.modern-ui table.form-grid td {
    vertical-align: middle;
}

.modern-ui .lbl-right { 
    text-align: right; 
    color: #222;
    font-size: 12px; 
    font-weight: 600;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    white-space: nowrap; 
    padding-right: 5px;
}

/* Modern Primary Button */
.modern-ui .myButton {
    height: 26px;
    padding: 0 20px;
    background-color: #0056b3;
    color: #ffffff;
    border: none;
    border-radius: 3px;
    cursor: pointer;
    font-size: 12px;
    font-weight: bold;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    transition: all 0.2s ease-in-out;
    min-width: 90px;
}

.modern-ui .myButton:hover {
    background-color: #004494;
}

/* Results Grid Container */
.modern-ui .grid-container {
    border: 1px solid #BDBDBD;
    border-radius: 4px;
    background-color: #ffffff !important; 
    overflow: hidden;
    width: 100%;
}
</style>

<script type="text/javascript">
    $(document).ready(function () {
        if ($("#msearchdate").length) {
            $("#msearchdate").jqxDateTimeInput({
                width: '100%',
                height: '24px',
                formatString: "dd.MM.yyyy",
                value: null
            });
        }
    }); 

    function mainSearch() {
        var docno = document.getElementById("msearchdocno") ? document.getElementById("msearchdocno").value : "";
        var date = $("#msearchdate").length ? $('#msearchdate').jqxDateTimeInput('val') : "";
        var client = document.getElementById("msearchclient") ? document.getElementById("msearchclient").value : "";
        var type = document.getElementById("msearchcmbtype") ? document.getElementById("msearchcmbtype").value : "";
        var acno = document.getElementById("msearchacno") ? document.getElementById("msearchacno").value : "";
        var mobile = document.getElementById("msearchmobile") ? document.getElementById("msearchmobile").value : "";
        
        var branchElem = document.getElementById("brchName");
        var branch = branchElem ? branchElem.value : "";

        getmaindata(docno, date, client, type, acno, mobile, branch);
    }

    function getmaindata(docno, date, client, type, acno, mobile, branch) {
        var url = 'assetSalesSearch.jsp?docno=' + encodeURIComponent(docno) +
                  '&date=' + encodeURIComponent(date) +
                  '&client=' + encodeURIComponent(client) +
                  '&type=' + encodeURIComponent(type) +
                  '&acno=' + encodeURIComponent(acno) +
                  '&mobile=' + encodeURIComponent(mobile) +
                  '&branch=' + encodeURIComponent(branch) +
                  '&id=1';

        $("#srefreshdiv").load(url);
    }
</script>
</head>

<body>

<div id="search" class="modern-ui">

    <div class="search-panel">
        <table class="form-grid" border="0" cellspacing="0" cellpadding="0">
            <!-- Standardized 8-column layout -->
            <colgroup>
                <col width="8%" />  <col width="17%" />
                <col width="8%" />  <col width="17%" />
                <col width="8%" />  <col width="17%" />
                <col width="10%" /> <col width="15%" />
            </colgroup>
            
            <tr>
                <td class="lbl-right">Doc No</td>
                <td>
                    <input type="text" name="msearchdocno" id="msearchdocno" autocomplete="off">
                </td>
                
                <td class="lbl-right">Date</td>
                <td>
                    <div id="msearchdate"></div>
                </td>
                
                <td class="lbl-right">Type</td>
                <td>
                    <select name="msearchcmbtype" id="msearchcmbtype">
                        <option value="">--Select--</option>
                        <option value="S">Sale</option>
                        <option value="L">Total Loss</option>
                    </select>
                </td>
                
                <!-- Empty spacer columns for top row -->
                <td colspan="2"></td>
            </tr>
            
            <tr>
                <td class="lbl-right">Client</td>
                <td>
                    <input type="text" name="msearchclient" id="msearchclient" autocomplete="off">
                </td>
                
                <td class="lbl-right">A/c No</td>
                <td>
                    <input type="text" name="msearchacno" id="msearchacno" autocomplete="off">
                </td>
                
                <td class="lbl-right">Mobile</td>
                <td>
                    <input type="text" name="msearchmobile" id="msearchmobile" autocomplete="off">
                </td>
                
                <!-- Search Button aligned on far right -->
                <td colspan="2" align="right">
                    <input type="button" name="searchbtn" id="searchbtn" class="myButton" value="Search" onclick="mainSearch();">
                </td>
            </tr>
        </table>
    </div>

    <!-- Data Grid Container -->
    <div class="grid-container">
        <div id="srefreshdiv">
            <jsp:include page="assetSalesSearch.jsp"></jsp:include>
        </div>
    </div>

</div>

</body>
</html>