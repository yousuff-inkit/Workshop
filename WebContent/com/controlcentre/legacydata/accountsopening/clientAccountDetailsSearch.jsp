<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath(); %>
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
    min-width: 800px; 
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
        // Standardized height to 24px
        $("#txtaccperiod").jqxDateTimeInput({ width: '125px', height: '24px', formatString: "dd.MM.yyyy" });
        
        // Safely map account type if the parent combo box exists
        var cmbAccType = document.getElementById("cmbacctype");
        if (cmbAccType && document.getElementById("txtatypes")) {
            document.getElementById("txtatypes").value = cmbAccType.value;
        }
        
        // Safely parse the parent window date
        try {
            if (window.parent && window.parent.txtaccountperiodfrom && window.parent.txtaccountperiodfrom.value) {
                var yearStr = window.parent.txtaccountperiodfrom.value;
                var newDate = yearStr.split('-');
                if (newDate.length === 3) {
                    var formattedYear = newDate[1] + "-" + newDate[0] + "-" + newDate[2];
                    $('#txtaccperiod').jqxDateTimeInput('setDate', new Date(formattedYear));
                }
            }
        } catch (e) {
            console.warn("Could not retrieve date from parent window.", e);
        }
    }); 
    
    function loadClientAccountSearch() {
        var clientaccountno = document.getElementById("accountsno") ? document.getElementById("accountsno").value : "";
        var clientaccountname = document.getElementById("accountsname") ? document.getElementById("accountsname").value : "";
        var clientmobile = document.getElementById("clientmobileno") ? document.getElementById("clientmobileno").value : "";
        var curr = document.getElementById("txtcurrencies") ? document.getElementById("txtcurrencies").value : "";
        var accounttype = document.getElementById("txtatypes") ? document.getElementById("txtatypes").value : "";
        
        // Use jQuery to safely get jqx value, fallback to standard DOM
        var date = $("#txtaccperiod").val() || (document.getElementById("txtaccperiod") ? document.getElementById("txtaccperiod").value : "");
        var checked = 1;
    
        getClientAccountDetails(clientaccountno, clientaccountname, clientmobile, curr, accounttype, date, checked);
    }
        
    function getClientAccountDetails(clientaccountno, clientaccountname, clientmobile, curr, accounttype, date, checked) {
        // Using encodeURIComponent to ensure special characters & spaces don't break the URL string
        $("#refreshClientAccountDiv").load("clientAccountDetailsSearchGrid.jsp?accountno=" + encodeURIComponent(clientaccountno) +
                                           '&accountname=' + encodeURIComponent(clientaccountname) +
                                           '&mobile=' + encodeURIComponent(clientmobile) +
                                           '&currency=' + encodeURIComponent(curr) +
                                           '&atype=' + encodeURIComponent(accounttype) +
                                           '&date=' + encodeURIComponent(date) +
                                           '&check=' + encodeURIComponent(checked));
    }
</script>
</head>

<body>

<div id="search" class="modern-ui">

    <div class="search-panel">
        <table class="form-grid" border="0" cellspacing="0" cellpadding="0">
            <!-- 6-column layout for perfect horizontal alignment -->
            <colgroup>
                <col width="10%" />  <col width="23%" />
                <col width="10%" />  <col width="23%" />
                <col width="10%" />  <col width="24%" />
            </colgroup>
            
            <tr>
                <td class="lbl-right">Account No</td>
                <td>
                    <input type="text" name="accountsno" id="accountsno" autocomplete="off" value='<s:property value="accountsno"/>'>
                </td>
                
                <td class="lbl-right">Currency</td>
                <td>
                    <input type="text" name="txtcurrencies" id="txtcurrencies" autocomplete="off" value='<s:property value="txtcurrencies"/>'>
                    
                    <!-- Hidden inputs maintained -->
                    <input type="hidden" name="txtatypes" id="txtatypes" value='<s:property value="txtatypes"/>'>
                    <div style="display:none;" id="txtaccperiod" name="txtaccperiod" value='<s:property value="txtaccperiod"/>'></div>
                </td>
                
                <td class="lbl-right">Mobile</td>
                <td>
                    <input type="text" name="clientmobileno" id="clientmobileno" autocomplete="off" value='<s:property value="clientmobileno"/>'>
                </td>
            </tr>
            
            <tr>
                <td class="lbl-right">Account Name</td>
                <!-- Spanning to give the name field plenty of space -->
                <td colspan="4">
                    <input type="text" name="accountsname" id="accountsname" autocomplete="off" value='<s:property value="accountsname"/>'>
                </td>
                
                <!-- Aligning search button directly under the mobile field column -->
                <td align="center" style="padding-left: 10px;">
                    <input type="button" name="btnClientAccountSearch" id="btnClientAccountSearch" class="myButton" value="Search" onclick="loadClientAccountSearch(); return false;">
                </td>
            </tr>
        </table>
    </div>

    <!-- Data Grid Container -->
    <div class="grid-container">
        <div id="refreshClientAccountDiv">
            <jsp:include page="clientAccountDetailsSearchGrid.jsp"></jsp:include>
        </div>
    </div>

</div>

</body>
</html>