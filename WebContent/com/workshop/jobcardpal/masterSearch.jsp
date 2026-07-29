<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
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

/* Standardized Input & Select Styles */
.modern-ui input[type="text"],
.modern-ui select {
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

.modern-ui input[type="text"]:focus,
.modern-ui select:focus {
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
    $(document).ready(function(e) {
        // Standardized height to 24px to match text inputs and selects
        $("#msearchdate").jqxDateTimeInput({ width: '125px', height: '24px', formatString: "dd.MM.yyyy", value: null });
        
        $('#btnmastersearch').click(function(e) {
            e.preventDefault();
            
            // Added fallbacks to ensure empty strings are sent rather than 'undefined'
            var refno = $('#msearchrefno').val() || "";
            var reftype = $('#msearchreftype').val() || "";
            var date = $('#msearchdate').jqxDateTimeInput('val') || "";
            var docno = $('#msearchdocno').val() || "";
            var cldocno = $('#msearchcldocno').val() || "";
            var accno = $('#mserchaccnos').val() || "";
            var reg = $('#regss').val() || "";
            var brhid = $('#brchName').val() || "";
            
            // Safe URL encoding applied to all parameters
            $('#mastersearchdiv').load('masterSearchGrid.jsp?refno=' + encodeURIComponent(refno) +
                                       '&reftype=' + encodeURIComponent(reftype) +
                                       '&date=' + encodeURIComponent(date) +
                                       '&docno=' + encodeURIComponent(docno) +
                                       '&id=1' +
                                       '&cldocno=' + encodeURIComponent(cldocno) +
                                       '&accno=' + encodeURIComponent(accno) +
                                       '&regno=' + encodeURIComponent(reg) +
                                       '&brhid=' + encodeURIComponent(brhid));
        });
    });
</script>
</head>

<body>

<div id="search" class="modern-ui">

    <div class="search-panel">
        <table class="form-grid" border="0" cellspacing="0" cellpadding="0">
            <!-- 8-column layout for perfectly aligned fields -->
            <colgroup>
                <col width="10%" /> <col width="15%" />
                <col width="8%" />  <col width="15%" />
                <col width="8%" />  <col width="15%" />
                <col width="10%" /> <col width="19%" />
            </colgroup>
            
            <tr>
                <td class="lbl-right">Doc No</td>
                <td>
                    <input type="text" name="msearchdocno" id="msearchdocno" autocomplete="off">
                </td>
                
                <td class="lbl-right">Date</td>
                <td>
                    <div id="msearchdate"></div>
                </td>
                
                <td class="lbl-right">Ref Type</td>
                <td>
                    <select name="msearchreftype" id="msearchreftype">
                        <option value="">--Select--</option>
                        <option value="GIP">Gate In Pass</option>
                        <option value="EST">Estimation</option>
                    </select>
                </td>
                
                <!-- Placing the search button neatly at the end of the first row -->
                <td colspan="2" align="right">
                    <input type="button" name="btnmastersearch" id="btnmastersearch" value="Search" class="myButton">
                    <!-- Hidden field to satisfy JS fallback -->
                    <input type="hidden" id="brchName" name="brchName" value="" />
                </td>
            </tr>
            
            <tr>
                <td class="lbl-right">Ref No</td>
                <td>
                    <input type="text" name="msearchrefno" id="msearchrefno" autocomplete="off">
                </td>
                
                <td class="lbl-right">Client Doc No</td>
                <td>
                    <input type="text" name="msearchcldocno" id="msearchcldocno" autocomplete="off">
                </td>
                
                <td class="lbl-right">Account No</td>
                <td>
                    <input type="text" name="mserchaccnos" id="mserchaccnos" autocomplete="off">
                </td>
                
                <td class="lbl-right">Reg No</td>
                <td>
                    <input type="text" name="regss" id="regss" autocomplete="off">
                </td>
            </tr>
        </table>
    </div>

    <!-- Data Grid Container -->
    <div class="grid-container">
        <div id="mastersearchdiv">
            <jsp:include page="masterSearchGrid.jsp"></jsp:include>
        </div>
    </div>

</div>

</body>
</html>