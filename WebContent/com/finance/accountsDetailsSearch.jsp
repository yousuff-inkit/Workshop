<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />

<style>
/* =========================================================
   SCOPED UI: Segoe UI Font & Clean White Search Panel
========================================================= */
html, body {
    margin: 0;
    padding: 0;
    background-color: #ffffff !important; /* Forced white background */
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif; 
}

.modern-ui {
    font-size: 12px;
    color: #333;
    padding: 10px;
    box-sizing: border-box;
    width: 100%;
    background-color: #ffffff !important; /* Forced white background */
}

/* Master Input Styles */
.modern-ui input[type="text"],
.modern-ui select {
    height: 24px !important;
    border: 1px solid #BDBDBD;
    border-radius: 3px;
    padding: 2px 6px;
    font-size: 12px; 
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    box-sizing: border-box;
    background-color: #ffffff !important; /* Forced white background */
    color: #333;
    width: 100%;
}

.modern-ui input[type="text"]:focus,
.modern-ui select:focus {
    border-color: #007bff;
    outline: none;
}

/* Panel Styling - Clean White Panel */
.modern-ui .search-panel {
    background-color: #ffffff !important; /* Forced white background */
    border: 1px solid #BDBDBD;
    border-radius: 4px;
    padding: 12px 10px;
    margin-bottom: 10px;
    width: 100%;
    box-sizing: border-box;
}

/* Table Alignment - STRICT PERCENTAGE GRID */
.modern-ui table {
    border-collapse: separate;
    border-spacing: 5px 8px; 
    width: 100%;
    table-layout: fixed; /* Locks columns from squishing */
    background-color: #ffffff !important; /* Forced white background */
}

.modern-ui td {
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

/* Search Button - Standard Blue */
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
    transition: all 0.2s;
}

.modern-ui .myButton:hover {
    background-color: #004494;
}

/* Grid Container */
.modern-ui .grid-container {
    border: 1px solid #BDBDBD;
    background-color: #ffffff !important; /* Forced white background */
    overflow: hidden;
    width: 100%;
}
</style>

<script type="text/javascript">
    $(document).ready(function () {
        /* Extracting values safely from parent document/fields if they exist */
        var formCode = document.getElementById("formdetailcode") ? document.getElementById("formdetailcode").value : "";
        var searchType = document.getElementById("txtforsearch") ? document.getElementById("txtforsearch").value : "";
        var mainDate = $('#maindate').length ? $('#maindate').val() : "";
        
        document.getElementById("txtdoctypes").value = formCode;
        document.getElementById("txtsearchtype").value = searchType;
        document.getElementById("txtnewdates").value = mainDate;
    }); 
    
    function loadAccountSearch() {
        var accountsno = document.getElementById("txtaccountsno").value || "";
        var accountsname = document.getElementById("txtaccountsname").value || "";
        var currs = document.getElementById("txtaccountcurrency").value || "";
        var formcode = document.getElementById("txtdoctypes").value || "";
        var searchtype = document.getElementById("txtsearchtype").value || "";
        var dates = document.getElementById("txtnewdates").value || "";
        var check = 1;

        getAccountDetails(accountsno, accountsname, currs, formcode, searchtype, dates, check);
    }
        
    function getAccountDetails(accountsno, accountsname, currs, formcode, searchtype, dates, check){
        /* Safely encoding URI components */
        $("#refreshAccountDetailsDiv").load("../../accountDetailsSearchGrid.jsp?accountno=" + encodeURIComponent(accountsno) + 
                                            "&accountname=" + encodeURIComponent(accountsname) + 
                                            "&currency=" + encodeURIComponent(currs) + 
                                            "&dtype=" + encodeURIComponent(formcode) + 
                                            "&searchtype=" + encodeURIComponent(searchtype) + 
                                            "&dates=" + encodeURIComponent(dates) + 
                                            "&check=" + check);
    }
</script>
</head>

<body style="background-color: #ffffff !important; margin: 0;">

<div id="search" class="modern-ui">

    <div class="search-panel">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <colgroup>
                <col width="6%" />  <col width="18%" /> <col width="8%" />  <col width="17%" /> <col width="9%" />  <col width="18%" /> <col width="24%" /> 
            </colgroup>
            
            <tr>
                <td class="lbl-right">Acct No</td>
                <td>
                    <input type="text" name="txtaccountsno" id="txtaccountsno" autocomplete="off" value='<s:property value="txtaccountsno"/>'>
                </td>
                
                <td class="lbl-right">Acct Name</td>
                <td>
                    <input type="text" name="txtaccountsname" id="txtaccountsname" autocomplete="off" value='<s:property value="txtaccountsname"/>'>
                </td>
                
                <td class="lbl-right">Currency</td>
                <td>
                    <input type="text" name="txtaccountcurrency" id="txtaccountcurrency" autocomplete="off" value='<s:property value="txtaccountcurrency"/>'>
                    <!-- Hidden fields correctly nested and out of sight -->
                    <input type="hidden" name="txtdoctypes" id="txtdoctypes" value='<s:property value="txtdoctypes"/>'>
                    <input type="hidden" name="txtsearchtype" id="txtsearchtype" value='<s:property value="txtsearchtype"/>'>
                    <input type="hidden" name="txtnewdates" id="txtnewdates" value='<s:property value="txtnewdates"/>'>
                </td>
                
                <td align="center" valign="middle">
                    <input type="button" name="btnAccountSearch" id="btnAccountSearch" class="myButton" value="Search" onclick="loadAccountSearch(); return false;">
                </td>
            </tr>
        </table>
    </div>

    <div class="grid-container">
        <div id="refreshAccountDetailsDiv">
            <jsp:include page="accountDetailsSearchGrid.jsp"></jsp:include>
        </div>
    </div>

</div>

</body>
</html>