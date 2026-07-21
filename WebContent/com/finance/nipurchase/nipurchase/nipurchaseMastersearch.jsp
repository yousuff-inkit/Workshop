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
        /* Standardized JQX setup to 120px/24px */
        $("#datess").jqxDateTimeInput({ width: '120px', height: '24px', formatString: "dd.MM.yyyy", value: null });
        
        /* Force internal alignment AFTER render */
        setTimeout(function () {
            $(".jqx-datetimeinput").css({"margin-top": "0px", "border-color": "#BDBDBD", "border-radius": "3px", "background-color": "#ffffff"});
            $(".jqx-datetimeinput").find("input").css({
                "margin-top": "0px", "line-height": "24px", "font-size": "12px", 
                "font-family": "'Segoe UI', 'Roboto', 'Arial', sans-serif", "padding": "0 6px", "box-sizing": "border-box", "background-color": "#ffffff"
            });
            $(".jqx-datetimeinput").find(".jqx-action-button").css({"top": "0px", "height": "24px", "background-color": "#ffffff"});
        }, 100);
    }); 

    function loadSearchs() {
        var docnoss = document.getElementById("docnoss").value || "";
        var accountss = document.getElementById("accountss").value || "";
        var accnamess = document.getElementById("accnamess").value || "";
        var datess = $('#datess').jqxDateTimeInput('val') || "";
        var reftypess = document.getElementById("reftypess").value || "";
        var description = document.getElementById("description").value || "";
        var invno = document.getElementById("invnos").value || "";
        var aa = "yes";

        getdata(docnoss, accountss, accnamess, datess, reftypess, aa, description, invno);
    }
    
    function getdata(docnoss, accountss, accnamess, datess, reftypess, aa, description, invno){
        /* Safely encoding URI components to replace manual string substitutions */
        $("#refreshdivs").load('submasterSearch.jsp?docnoss=' + encodeURIComponent(docnoss) + 
                               '&accountss=' + encodeURIComponent(accountss) + 
                               '&accnamess=' + encodeURIComponent(accnamess) + 
                               '&datess=' + datess + 
                               '&reftypess=' + encodeURIComponent(reftypess) + 
                               '&aa=' + encodeURIComponent(aa) + 
                               '&description=' + encodeURIComponent(description) + 
                               '&invno=' + encodeURIComponent(invno));
    }
</script>
</head>

<body style="background-color: #ffffff !important; margin: 0;">

<div id="search" class="modern-ui">

    <div class="search-panel">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <colgroup>
                <col width="8%" />  <col width="18%" /> <col width="8%" />  <col width="18%" /> <col width="10%" />  <col width="23%" /> <col width="15%" /> 
            </colgroup>
            
            <tr>
                <td class="lbl-right">Doc No</td>
                <td>
                    <input type="text" name="docnoss" id="docnoss" autocomplete="off" value='<s:property value="docnoss"/>'>
                </td>
                
                <td class="lbl-right">Account</td>
                <td>
                    <input type="text" name="accountss" id="accountss" autocomplete="off" value='<s:property value="accountss"/>'>
                </td>
                
                <td class="lbl-right">Account Name</td>
                <td>
                    <input type="text" name="accnamess" id="accnamess" autocomplete="off" value='<s:property value="accnamess"/>'>
                </td>
                
                <td align="center" rowspan="3" valign="middle">
                    <input type="button" name="searchs" id="searchs" class="myButton" value="Search" onclick="loadSearchs(); return false;">
                </td>
            </tr>
            
            <tr>
                <td class="lbl-right">Date</td>
                <td>
                    <div id="datess" name="datess" value='<s:property value="datess"/>'></div>
                </td>
                
                <td class="lbl-right">Type</td>
                <td>
                    <select name="reftypess" id="reftypess" value='<s:property value="reftypess"/>'>
                        <option value="">--select--</option>
                        <option value="DIR">DIR</option>
                        <option value="NPO">NPO</option>
                    </select>
                </td>
                
                <td class="lbl-right">Description</td>
                <td>
                    <input type="text" name="description" id="description" autocomplete="off" value='<s:property value="description"/>'>
                </td>
            </tr>

            <tr>
                <td class="lbl-right">Inv No</td>
                <td>
                    <input type="text" name="invnos" id="invnos" autocomplete="off" value='<s:property value="invnos"/>'>
                </td>
                
                <!-- Spacer for layout balance -->
                <td colspan="4"></td>
            </tr>
        </table>
    </div>

    <div class="grid-container">
        <div id="refreshdivs">
            <jsp:include page="submasterSearch.jsp"></jsp:include>
        </div>
    </div>

</div>

</body>
</html>