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
        // Safe check for parent window maindate element if it exists
        var mainDateEl = document.getElementById("maindate") || window.parent.document.getElementById("maindate");
        if(mainDateEl) {
            document.getElementById("txtnewdate").value = $(mainDateEl).val();
        }
    }); 

    function loadClientAccountSearch() {
        var clientaccountno = document.getElementById("accountsno").value || "";
        var clientaccountname = document.getElementById("accountsname").value || "";
        var clientmobile = document.getElementById("clientmobileno").value || "";
        var curr = document.getElementById("txtcurrencies").value || "";
        var date = document.getElementById("txtnewdate").value || "";
        var checked = 1;
        var salper = document.getElementById("salper").value || "";
        
        getClientAccountDetails(clientaccountno, clientaccountname, clientmobile, curr, date, checked, salper);
    }
    
    function getClientAccountDetails(clientaccountno, clientaccountname, clientmobile, curr, date, checked, salper){
        /* Safely encoding URI components to replace manual space substitutions */
        $("#refreshClientAccountDiv").load('clientAccountDetailsSearchGrid.jsp?accountno=' + encodeURIComponent(clientaccountno) + 
                                           '&accountname=' + encodeURIComponent(clientaccountname) + 
                                           '&mobile=' + encodeURIComponent(clientmobile) + 
                                           '&currency=' + encodeURIComponent(curr) + 
                                           '&atype=AR' + 
                                           '&date=' + encodeURIComponent(date) + 
                                           '&check=' + checked + 
                                           '&salper=' + encodeURIComponent(salper));
    }
</script>
</head>

<body style="background-color: #ffffff !important; margin: 0;">

<div id="search" class="modern-ui">

    <div class="search-panel">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <colgroup>
                <col width="10%" />  <col width="20%" /> <col width="10%" />  <col width="20%" /> <col width="8%" />   <col width="22%" /> <col width="10%" /> 
            </colgroup>
            
            <tr>
                <td class="lbl-right">Account No</td>
                <td>
                    <input type="text" name="accountsno" id="accountsno" autocomplete="off" value='<s:property value="accountsno"/>'>
                </td>
                
                <td class="lbl-right">Currency</td>
                <td>
                    <input type="text" name="txtcurrencies" id="txtcurrencies" autocomplete="off" value='<s:property value="txtcurrencies"/>'>
                    <input type="hidden" name="txtnewdate" id="txtnewdate" value='<s:property value="txtnewdate"/>'>
                </td>
                
                <td class="lbl-right">Mobile</td>
                <td>
                    <input type="text" name="clientmobileno" id="clientmobileno" autocomplete="off" value='<s:property value="clientmobileno"/>'>
                    <input type="hidden" name="txtcreditdebit" id="txtcreditdebit" value='<s:property value="txtcreditdebit"/>'>
                </td>
                
                <td align="center" rowspan="2" valign="middle">
                    <input type="button" name="btnClientAccountSearch" id="btnClientAccountSearch" class="myButton" value="Search" onclick="loadClientAccountSearch(); return false;">
                </td>
            </tr>
            
            <tr>
                <td class="lbl-right">Account Name</td>
                <td>
                    <input type="text" name="accountsname" id="accountsname" autocomplete="off" value='<s:property value="accountsname"/>'>
                </td>
                
                <td class="lbl-right">Sales Person</td>
                <td>
                    <input type="text" name="salper" id="salper" autocomplete="off" value='<s:property value="salper"/>'>
                </td>
                
                <!-- Spacer for layout balance -->
                <td colspan="2"></td>
            </tr>
        </table>
    </div>

    <div class="grid-container">
        <div id="refreshClientAccountDiv">
            <jsp:include page="clientAccountDetailsSearchGrid.jsp"></jsp:include>
        </div>
    </div>

</div>

</body>
</html>