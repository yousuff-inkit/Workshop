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
    min-width: 650px; 
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
    function loadSearch() {
        var accountNo = document.getElementById("txtaccountno") ? document.getElementById("txtaccountno").value : "";
        var accountName = document.getElementById("txtaccountname") ? document.getElementById("txtaccountname").value : "";
        var total = document.getElementById("txttotal") ? document.getElementById("txttotal").value : "";
    
        getdata(accountNo, accountName, total);
    }
    
    function getdata(accountNo, accountName, total) {
        // encodeURIComponent handles spaces, ampersands, and other special characters perfectly
        $("#refreshdiv").load('opnMainSearchGrid.jsp?accountNo=' + encodeURIComponent(accountNo) + 
                              '&accountName=' + encodeURIComponent(accountName) + 
                              '&total=' + encodeURIComponent(total));
    }
</script>
</head>

<body>

<div id="search" class="modern-ui">

    <div class="search-panel">
        <table class="form-grid" border="0" cellspacing="0" cellpadding="0">
            <!-- Structured 5-column layout for clean alignment -->
            <colgroup>
                <col width="10%" /> <col width="30%" />
                <col width="10%" /> <col width="30%" />
                <col width="20%" />
            </colgroup>
            
            <tr>
                <td class="lbl-right">A/c No</td>
                <td>
                    <input type="text" name="txtaccountno" id="txtaccountno" autocomplete="off" value='<s:property value="txtaccountno"/>'>
                </td>
                
                <td class="lbl-right">Balance</td>
                <td>
                    <input type="text" name="txttotal" id="txttotal" autocomplete="off" value='<s:property value="txttotal"/>'>
                </td>
                
                <!-- Spanning the search button across two rows to align it perfectly on the right -->
                <td rowspan="2" align="center" style="padding-left: 10px;">
                    <input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search" onclick="loadSearch(); return false;">
                </td>
            </tr>
            
            <tr>
                <td class="lbl-right">A/c Name</td>
                <!-- Spanning 3 columns so the A/c Name field has plenty of width -->
                <td colspan="3">
                    <input type="text" name="txtaccountname" id="txtaccountname" autocomplete="off" value='<s:property value="txtaccountname"/>'>
                </td>
            </tr>
        </table>
    </div>

    <!-- Data Grid Container -->
    <div class="grid-container">
        <div id="refreshdiv">
            <jsp:include page="opnMainSearchGrid.jsp"></jsp:include>
        </div>
    </div>

</div>

</body>
</html>