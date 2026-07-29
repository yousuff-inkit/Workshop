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
        // Standardized height to 24px to match text inputs
        $("#datess").jqxDateTimeInput({ width: '125px', height: '24px', formatString: "dd.MM.yyyy", value: null }); 
    }); 

    function loadSearch() {
        var Cl_names = document.getElementById("Cl_names").value || "";
        var dates = $("#datess").jqxDateTimeInput('val') || "";
        var msdocno = document.getElementById("msdocno").value || ""; 
        var mobile = document.getElementById("mobile").value || "";
        var regno = document.getElementById("regno").value || "";
        var refno = document.getElementById("searchrefno").value || "";
        
        getdata1(Cl_names, msdocno, dates, mobile, regno, refno);
    }
    
    function getdata1(Cl_names, msdocno, dates, mobile, regno, refno) {
        var id = 1;
        var brhid = $('#brchName').val() || "";
        
        // Use encodeURIComponent to safely handle spaces and special characters globally
        var url = 'subMastersearch.jsp?Cl_namess=' + encodeURIComponent(Cl_names) + 
                  '&msdocno=' + encodeURIComponent(msdocno) + 
                  '&dates=' + encodeURIComponent(dates) + 
                  '&mobile=' + encodeURIComponent(mobile) + 
                  '&regno=' + encodeURIComponent(regno) + 
                  '&id=' + id + 
                  '&refno=' + encodeURIComponent(refno) + 
                  '&brhid=' + encodeURIComponent(brhid);
                  
        $("#refreshdivmas").load(url);
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
                <td class="lbl-right">Doc No</td>
                <td>
                    <input type="text" name="msdocno" id="msdocno" value='<s:property value="msdocno"/>' autocomplete="off">
                </td>
                
                <td class="lbl-right">Name</td>
                <td>
                    <input type="text" name="Cl_names" id="Cl_names" value='<s:property value="Cl_names"/>' autocomplete="off">
                </td>
                
                <td class="lbl-right">Mobile</td>
                <td>
                    <input type="text" name="mobile" id="mobile" value='<s:property value="mobile"/>' autocomplete="off">
                </td>
                
                <!-- Spacers to complete the 8-column row -->
                <td colspan="2"></td>
            </tr>
            
            <tr>
                <td class="lbl-right">Date</td>
                <td>
                    <!-- Struts property stored in data attribute safely since jqx uses standard divs -->
                    <div id="datess" data-value='<s:property value="datess"/>'></div>
                </td>
                
                <td class="lbl-right">Ref No</td>
                <td>
                    <input type="text" name="searchrefno" id="searchrefno" value='<s:property value="searchrefno"/>' autocomplete="off">
                </td>
                
                <td class="lbl-right">REG No.</td>
                <td>
                    <input type="text" name="regno" id="regno" value='<s:property value="regno"/>' autocomplete="off">
                </td>
                
                <!-- Search button aligned on the far right -->
                <td colspan="2" align="right">
                    <input type="button" name="btnrasearch" id="btnrasearch" class="myButton" value="Search" onclick="loadSearch()">
                    <!-- Hidden field to satisfy JS fallback -->
                    <input type="hidden" id="brchName" name="brchName" value="" />
                </td>
            </tr>
        </table>
    </div>

    <!-- Data Grid Container -->
    <div class="grid-container">
        <div id="refreshdivmas">
            <jsp:include page="subMastersearch.jsp"></jsp:include> 
        </div>
    </div>

</div>

</body>
</html>