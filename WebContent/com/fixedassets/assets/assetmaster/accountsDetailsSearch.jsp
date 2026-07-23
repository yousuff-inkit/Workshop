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

/* Standardized Input Styles */
.modern-ui input[type="text"] {
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

.modern-ui input[type="text"]:focus {
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
        var masterDateVal = $('#masterdate').val() || "";
        $('#txtnewdate').val(masterDateVal);
    }); 
    
    function loadClientAccountSearch() {
        var clientaccountno = document.getElementById("accountsno").value || "";
        var clientaccountname = document.getElementById("accountsname").value || "";
        var clientmobile = document.getElementById("clientmobileno").value || "";
        var curr = document.getElementById("txtcurrencies").value || "";
        var date = document.getElementById("txtnewdate").value || "";
        var checked = 1;

        getClientAccountDetails(clientaccountno, clientaccountname, clientmobile, curr, date, checked);
    }
        
    function getClientAccountDetails(clientaccountno, clientaccountname, clientmobile, curr, date, checked) {
        var url = "accountDetailsSearchGrid.jsp?accountno=" + encodeURIComponent(clientaccountno) +
                  "&accountname=" + encodeURIComponent(clientaccountname) +
                  "&mobile=" + encodeURIComponent(clientmobile) +
                  "&currency=" + encodeURIComponent(curr) +
                  "&date=" + encodeURIComponent(date) +
                  "&check=" + encodeURIComponent(checked);

        $("#refreshClientAccountDiv").load(url);
    }
</script>
</head>

<body>

<div id="search" class="modern-ui">

    <div class="search-panel">
        <table class="form-grid" border="0" cellspacing="0" cellpadding="0">
            <!-- 8-column layout for perfect field alignment -->
            <colgroup>
                <col width="8%" />  <col width="17%" />
                <col width="8%" />  <col width="17%" />
                <col width="8%" />  <col width="17%" />
                <col width="10%" /> <col width="15%" />
            </colgroup>
            
            <tr>
                <td class="lbl-right">Account No</td>
                <td>
                    <input type="text" name="accountsno" id="accountsno" value='<s:property value="accountsno"/>' autocomplete="off">
                </td>
                
                <td class="lbl-right">Currency</td>
                <td>
                    <input type="text" name="txtcurrencies" id="txtcurrencies" value='<s:property value="txtcurrencies"/>' autocomplete="off">
                    <input type="hidden" name="txtatypes" id="txtatypes" value='<s:property value="txtatypes"/>'>
                    <input type="hidden" name="txtdocumenttypes" id="txtdocumenttypes" value='<s:property value="txtdocumenttypes"/>'>
                </td>
                
                <td class="lbl-right">Mobile</td>
                <td>
                    <input type="text" name="clientmobileno" id="clientmobileno" value='<s:property value="clientmobileno"/>' autocomplete="off">
                    <input type="hidden" name="txtcreditdebit" id="txtcreditdebit" value='<s:property value="txtcreditdebit"/>'>
                    <input type="hidden" name="txtnewdate" id="txtnewdate" value='<s:property value="txtnewdate"/>'>
                </td>
                
                <!-- Spacer columns -->
                <td colspan="2"></td>
            </tr>
            
            <tr>
                <td class="lbl-right">Account Name</td>
                <!-- Expanded across 5 columns for cleaner layout -->
                <td colspan="5">
                    <input type="text" name="accountsname" id="accountsname" value='<s:property value="accountsname"/>' autocomplete="off">
                </td>
                
                <!-- Search Button aligned right -->
                <td colspan="2" align="right">
                    <input type="button" name="btnClientAccountSearch" id="btnClientAccountSearch" class="myButton" value="Search" onclick="loadClientAccountSearch();">
                </td>
            </tr>
        </table>
    </div>

    <!-- Data Grid Container -->
    <div class="grid-container">
        <div id="refreshClientAccountDiv">
            <jsp:include page="accountDetailsSearchGrid.jsp"></jsp:include>
        </div>
    </div>

</div>

</body>
</html>