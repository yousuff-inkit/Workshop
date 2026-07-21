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
        // No JQWidgets required on this page
    }); 

    function loadSearch() {
        var vndname = document.getElementById("txtvendorsname").value || "";
        var vndaccno = document.getElementById("txtaccountno").value || "";
        var vndmob = document.getElementById("txtmobile").value || "";
        var vndtel = document.getElementById("txttelephone").value || "";

        getdata(vndname, vndaccno, vndmob, vndtel);
    }
    
    function getdata(vndname, vndaccno, vndmob, vndtel){
        /* Safely encoding URI components to handle spaces and special characters */
        $("#refreshdiv").load('vndMainSearchGrid.jsp?vndname=' + encodeURIComponent(vndname) + 
                              '&vndaccno=' + encodeURIComponent(vndaccno) + 
                              '&vndmob=' + encodeURIComponent(vndmob) + 
                              '&vndtel=' + encodeURIComponent(vndtel));
    }
</script>
</head>

<body style="background-color: #ffffff !important; margin: 0;">

<div id="search" class="modern-ui">

    <div class="search-panel">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <colgroup>
                <col width="8%" />  <col width="18%" /> <col width="8%" />  <col width="26%" /> <col width="8%" />  <col width="18%" /> <col width="14%" /> 
            </colgroup>
            
            <tr>
                <td class="lbl-right">Name</td>
                <td colspan="3">
                    <input type="text" name="txtvendorsname" id="txtvendorsname" autocomplete="off" value='<s:property value="txtvendorsname"/>'>
                </td>
                
                <td class="lbl-right">A/C No.</td>
                <td>
                    <input type="text" name="txtaccountno" id="txtaccountno" autocomplete="off" value='<s:property value="txtaccountno"/>'>
                </td>
                
                <td align="center" rowspan="2" valign="middle">
                    <input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search" onclick="loadSearch(); return false;">
                </td>
            </tr>
            
            <tr>
                <td class="lbl-right">Mob No.</td>
                <td>
                    <input type="text" name="txtmobile" id="txtmobile" autocomplete="off" value='<s:property value="txtmobile"/>'>
                </td>
                
                <td class="lbl-right">Tel No.</td>
                <td>
                    <input type="text" name="txttelephone" id="txttelephone" autocomplete="off" value='<s:property value="txttelephone"/>'>
                </td>
                
                <!-- Empty columns to maintain grid structure -->
                <td colspan="2"></td> 
            </tr>
        </table>
    </div>

    <div class="grid-container">
        <div id="refreshdiv">
            <jsp:include page="vndMainSearchGrid.jsp"></jsp:include>
        </div>
    </div>

</div>

</body>
</html>