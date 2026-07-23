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
    min-width: 700px; 
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
        // Initialization space if needed
    }); 

    function loadVendorSearch() {
        var docno = document.getElementById("vndsearchdocno") ? document.getElementById("vndsearchdocno").value : "";
        var clientname = document.getElementById("vndsearchname") ? document.getElementById("vndsearchname").value : "";
        var mobile = document.getElementById("vndsearchmobile") ? document.getElementById("vndsearchmobile").value : "";
        var email = document.getElementById("vndsearchemail") ? document.getElementById("vndsearchemail").value : "";
        
        getdata(docno, clientname, mobile, email);
    }
    
    function getdata(docno, clientname, mobile, email) {
        // Enclosing parameters in encodeURIComponent to prevent breakage on special characters (like '+' in emails or '&' in names)
        $("#refreshdiv").load("vendorSearchGrid.jsp?docno=" + encodeURIComponent(docno) + 
                              "&clientname=" + encodeURIComponent(clientname) + 
                              "&mobile=" + encodeURIComponent(mobile) + 
                              "&email=" + encodeURIComponent(email) + 
                              "&id=1");
    }
</script>
</head>

<body>

<div id="search" class="modern-ui">

    <div class="search-panel">
        <table class="form-grid" border="0" cellspacing="0" cellpadding="0">
            <!-- Structured 5-column layout for clean alignment -->
            <colgroup>
                <col width="10%" /> <col width="25%" />
                <col width="10%" /> <col width="40%" />
                <col width="15%" />
            </colgroup>
            
            <tr>
                <td class="lbl-right">Doc No.</td>
                <td>
                    <input type="text" name="vndsearchdocno" id="vndsearchdocno" autocomplete="off" value='<s:property value="vndsearchdocno"/>'>
                </td>
                
                <td class="lbl-right">Name</td>
                <td>
                    <input type="text" name="vndsearchname" id="vndsearchname" autocomplete="off" value='<s:property value="vndsearchname"/>'>
                </td>
                
                <!-- Spanning the search button across two rows to align it perfectly on the right -->
                <td rowspan="2" align="center" style="padding-left: 10px;">
                    <input type="button" name="btnvndsearch" id="btnvndsearch" class="myButton" value="Search" onclick="loadVendorSearch(); return false;">
                </td>
            </tr>
            
            <tr>
                <td class="lbl-right">Mobile No.</td>
                <td>
                    <input type="text" name="vndsearchmobile" id="vndsearchmobile" autocomplete="off" value='<s:property value="vndsearchmobile"/>'>
                </td>
                
                <td class="lbl-right">Email</td>
                <td>
                    <input type="text" name="vndsearchemail" id="vndsearchemail" autocomplete="off" value='<s:property value="vndsearchemail"/>'>
                </td>
            </tr>
        </table>
    </div>

    <!-- Data Grid Container -->
    <div class="grid-container">
        <div id="refreshdiv">
            <jsp:include page="vendorSearchGrid.jsp"></jsp:include>
        </div>
    </div>

</div>

</body>
</html>