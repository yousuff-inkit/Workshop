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
    background-color: #ffffff !important; 
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
    background-color: #ffffff !important; 
    border: 1px solid #BDBDBD;
    border-radius: 4px;
    padding: 12px 10px;
    margin-bottom: 10px;
    width: 100%;
    box-sizing: border-box;
    overflow-x: auto; 
}

/* Table Alignment - FLEXIBLE GRID */
.modern-ui table {
    border-collapse: separate;
    border-spacing: 5px 8px; 
    width: 100%;
    min-width: 750px; 
    background-color: #ffffff !important; 
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
    padding: 0 25px;
    background-color: #0056b3;
    color: #ffffff;
    border: none;
    border-radius: 3px;
    cursor: pointer;
    font-size: 12px;
    font-weight: bold;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    transition: all 0.2s;
    /* Removed width: 100% so the button doesn't stretch artificially */
    min-width: 100px;
}

.modern-ui .myButton:hover {
    background-color: #004494;
}

/* Grid Container */
.modern-ui .grid-container {
    border: 1px solid #BDBDBD;
    background-color: #ffffff !important; 
    overflow: hidden;
    width: 100%;
}
</style>

<script type="text/javascript">
    $(document).ready(function () {
        /* Set width to 100% so it fluidly fills the table cell without overflowing */
        $("#txtdob").jqxDateTimeInput({ width: '100%', height: '24px', formatString: "dd.MM.yyyy", value: null });
        
        /* Force internal alignment AFTER render */
        setTimeout(function () {
            $(".jqx-datetimeinput").css({"margin-top": "0px", "border-color": "#BDBDBD", "border-radius": "3px", "background-color": "#ffffff"});
            $(".jqx-datetimeinput").find("input").css({
                "margin-top": "0px", "line-height": "24px", "font-size": "12px", 
                "font-family": "'Segoe UI', 'Roboto', 'Arial', sans-serif", "padding": "0 6px", "box-sizing": "border-box", "background-color": "#ffffff", "width": "100%"
            });
            $(".jqx-datetimeinput").find(".jqx-action-button").css({"top": "0px", "height": "24px", "background-color": "#ffffff"});
        }, 100);

        getEmpDesignation();
        getEmpDepartment();
    }); 

    function getEmpDesignation() {
        var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {
                var items = x.responseText;
                items = items.split('####');
                var designationItems = items[0] ? items[0].split(",") : [];
                var designationIdItems = items[1] ? items[1].split(",") : [];
                var optionsdesignation = '<option value="">--Select--</option>';
                for (var i = 0; i < designationItems.length; i++) {
                    optionsdesignation += '<option value="' + designationIdItems[i] + '">'
                            + designationItems[i] + '</option>';
                }
                $("select#employeedesignation").html(optionsdesignation);
            }
        };
        x.open("GET", "getDesignation.jsp", true);
        x.send();
    }
  
    function getEmpDepartment() {
        var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {
                var items = x.responseText;
                items = items.split('####');
                var departmentItems = items[0] ? items[0].split(",") : [];
                var departmentIdItems = items[1] ? items[1].split(",") : [];
                var optionsdepartment = '<option value="">--Select--</option>';
                for (var i = 0; i < departmentItems.length; i++) {
                    optionsdepartment += '<option value="' + departmentIdItems[i] + '">'
                            + departmentItems[i] + '</option>';
                }
                $("select#employeedepartment").html(optionsdepartment);
            }
        };
        x.open("GET", "getDepartment.jsp", true);
        x.send();
    }

    function loadSearch() {
        var empname = document.getElementById("txtempname") ? document.getElementById("txtempname").value : "";
        var mob = document.getElementById("txtmobile") ? document.getElementById("txtmobile").value : "";
        var employeedesignation = document.getElementById("employeedesignation") ? document.getElementById("employeedesignation").value : "";
        var employeedepartment = document.getElementById("employeedepartment") ? document.getElementById("employeedepartment").value : "";
        var empid = document.getElementById("txtempid") ? document.getElementById("txtempid").value : "";
        var dob = $('#txtdob').jqxDateTimeInput('val') || "";

        getdata(empname, mob, employeedesignation, employeedepartment, empid, dob);
    }
    
    function getdata(empname, mob, employeedesignation, employeedepartment, empid, dob) {
        var scheduleDateEl = document.getElementById("deductionScheduleDate") || (window.parent ? window.parent.document.getElementById("deductionScheduleDate") : null);
        var docdate = scheduleDateEl ? scheduleDateEl.value : "";

        $("#refreshdiv").load('employeeDetailsSearchGrid.jsp?empname=' + encodeURIComponent(empname) + 
                              '&mob=' + encodeURIComponent(mob) + 
                              '&employeedesignation=' + encodeURIComponent(employeedesignation) + 
                              '&employeedepartment=' + encodeURIComponent(employeedepartment) + 
                              '&empid=' + encodeURIComponent(empid) + 
                              '&dob=' + encodeURIComponent(dob) + 
                              '&docdate=' + encodeURIComponent(docdate));
    }
</script>
</head>

<body style="background-color: #ffffff !important; margin: 0;">

<div id="search" class="modern-ui">

    <div class="search-panel">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <!-- Simplified to an 8-column grid for perfect symmetry -->
            <colgroup>
                <col width="10%" /> <col width="15%" /> 
                <col width="10%" /> <col width="15%" /> 
                <col width="10%" /> <col width="15%" /> 
                <col width="10%" /> <col width="15%" /> 
            </colgroup>
            
            <tr>
                <td class="lbl-right">Name</td>
                <td colspan="3">
                    <input type="text" name="txtempname" id="txtempname" autocomplete="off" value='<s:property value="txtempname"/>'>
                </td>
                
                <td class="lbl-right">Mob</td>
                <td>
                    <input type="text" name="txtmobile" id="txtmobile" autocomplete="off" value='<s:property value="txtmobile"/>'>
                </td>
                
                <!-- Search Button placed immediately after Mob in a left-aligned cell -->
                <td colspan="2" align="left" style="padding-left: 10px;">
                    <input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search" onclick="loadSearch(); return false;">
                </td>
            </tr>
            
            <tr>
                <td class="lbl-right">Designation</td>
                <td>
                    <select id="employeedesignation" name="employeedesignation" value='<s:property value="employeedesignation"/>'>
                        <option value="">--Select--</option>
                    </select>
                </td>
                
                <td class="lbl-right">Department</td>
                <td>
                    <select id="employeedepartment" name="employeedepartment" value='<s:property value="employeedepartment"/>'>
                        <option value="">--Select--</option>
                    </select>
                </td>
                
                <td class="lbl-right">Emp#</td>
                <td>
                    <input type="text" name="txtempid" id="txtempid" autocomplete="off" value='<s:property value="txtempid"/>'>
                </td>
                
                <td class="lbl-right">DOB</td>
                <td>
                    <div id="txtdob" name="txtdob" value='<s:property value="txtdob"/>'></div>
                </td>
            </tr>
        </table>
    </div>

    <div class="grid-container">
        <div id="refreshdiv">
            <jsp:include page="employeeDetailsSearchGrid.jsp"></jsp:include>
        </div>
    </div>

</div>

</body>
</html>