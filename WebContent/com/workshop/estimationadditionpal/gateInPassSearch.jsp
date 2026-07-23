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
$(document).ready(function() {
    // Standardized height to 24px to match text inputs
    $("#searchgatedate").jqxDateTimeInput({ width: '150px', height: '24px', formatString: "dd.MM.yyyy", value: null });
    
    $('#btnsearchdoc').click(function(e) {
        e.preventDefault();
        
        var gatedocno = $('#searchgatedocno').val() || "";
        var jobdocno = $('#jobsearchjobdocno').val() || "";
        var date = $('#searchgatedate').jqxDateTimeInput('val') || "";
        var cldocno = $('#searchcldocno').val() || "";
        var clientname = $('#searchclientname').val() || "";
        // Safely fetch brhid, returning an empty string if the element doesn't exist
        var brhid = $('#brchName').val() || ""; 

        // URL encoded parameters to prevent breaking the URL format
        $('#gateinpassdiv').load('gateInPassSearchGrid.jsp?gatedocno=' + encodeURIComponent(gatedocno) +
                                 '&jobdocno=' + encodeURIComponent(jobdocno) +
                                 '&date=' + encodeURIComponent(date) +
                                 '&cldocno=' + encodeURIComponent(cldocno) +
                                 '&clientname=' + encodeURIComponent(clientname) +
                                 '&id=1' +
                                 '&brhid=' + encodeURIComponent(brhid));
    });
});
</script>
</head>	

<body>

<div id="search" class="modern-ui">

    <div class="search-panel">
        <table class="form-grid" border="0" cellspacing="0" cellpadding="0">
            <!-- 6-column layout for perfect horizontal alignment -->
            <colgroup>
                <col width="8%" />  <col width="22%" />
                <col width="8%" />  <col width="22%" />
                <col width="8%" />  <col width="32%" />
            </colgroup>
            
            <tr>
                <td class="lbl-right">Doc No</td>
                <td>
                    <input type="text" name="jobsearchjobdocno" id="jobsearchjobdocno" autocomplete="off">
                </td>
                
                <td class="lbl-right">GIP No</td>
                <td>
                    <input type="text" name="searchgatedocno" id="searchgatedocno" autocomplete="off">
                </td>
                
                <td class="lbl-right">Date</td>
                <td>
                    <div id="searchgatedate" name="searchgatedate"></div>
                </td>
            </tr>
            
            <tr>
                <td class="lbl-right">Client</td>
                <td>
                    <input type="text" name="searchcldocno" id="searchcldocno" placeholder="Client Doc No" autocomplete="off">
                </td>
                
                <!-- Spanning columns to give the Client Name plenty of space -->
                <td colspan="3">
                    <input type="text" name="searchclientname" id="searchclientname" placeholder="Client Name" autocomplete="off">
                </td>
                
                <!-- Aligning search button directly under the Date field column -->
                <td align="left" style="padding-left: 10px;">
                    <button type="button" name="btnsearchdoc" id="btnsearchdoc" class="myButton">Search</button>
                    <!-- Hidden field to satisfy the JS fallback without cluttering the UI -->
                    <input type="hidden" id="brchName" name="brchName" value="" />
                </td>
            </tr>
        </table>
    </div>

    <!-- Data Grid Container -->
    <div class="grid-container">
        <div id="gateinpassdiv">
            <jsp:include page="gateInPassSearchGrid.jsp"></jsp:include>
        </div>
    </div>

</div>

</body>
</html>