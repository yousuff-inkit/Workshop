<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  

<style type="text/css">
/* ===== MASTER LAYOUT (Modern Flexbox matching image_55e599.png) ===== */
html, body, #mainBG {
    height: 100%;
    margin: 0;
    overflow: hidden;
    background-color: #f4f7f9;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

.master-container {
    display: flex;
    width: 100%;
    height: 100vh;
}

/* ===== LEFT SIDEBAR ===== */
.sidebar-filters {
    width: 300px; 
    flex: 0 0 300px; 
    background: #f4f7f9;
    border-right: 1px solid #e1e8ed;
    display: flex;
    flex-direction: column;
    height: 100%;
    box-shadow: 2px 0 8px rgba(0,0,0,.05);
    z-index: 10;
}

.sidebar-scroll-content {
    flex: 1;
    overflow-y: auto;
    padding: 12px; 
}

/* Cards */
.filter-card {
    background: #ffffff;
    border: 1px solid #e2e8f0;
    border-radius: 6px;
    padding: 15px;
    margin-bottom: 12px;
}

/* Tables & Spacing */
.release-filter-table {
    width: 100%;
    border-collapse: collapse;
}

.release-filter-table td {
    padding: 6px 2px; 
    vertical-align: middle;
}

.release-filter-table .label-cell {
    text-align: right;
    padding-right: 10px;
    font-size: 12px !important; 
    color: #4b5563;
    font-weight: normal;
    width: 85px; 
}

/* ===== UNIFORM INPUTS & SELECTS (Fixes pink background & text styling) ===== */
input[type="text"], select, textarea,
.release-filter-table input[type="text"],
.release-filter-table select,
.release-filter-table textarea {
    width: 100%;
    height: 24px;             
    padding: 2px 6px;         
    border: 1px solid #cbd5e1 !important;
    border-radius: 3px;       
    font-size: 12px !important; 
    background-color: #ffffff !important; 
    color: #333333 !important; 
    box-sizing: border-box;
    font-family: inherit;
    outline: none;
}

select:focus, input[type="text"]:focus, textarea:focus {
    border-color: #3b82f6 !important;
    box-shadow: 0 0 0 1px rgba(59, 130, 246, 0.1);
}

.release-filter-table textarea {
    height: auto;
    resize: none;
    margin-top: 4px;
}

/* Readonly / disabled look */
input[readonly], input:disabled, textarea[readonly],
.release-filter-table input[readonly], .release-filter-table select:disabled {
    background-color: #f8fafc !important;
    color: #6b7280 !important;
    border-color: #e2e8f0 !important;
}

/* jqx date/time containers */
.release-filter-table div[id^="fromdate"],
.release-filter-table div[id^="todate"] {
    width: 100% !important;
    height: 24px !important;
}

/* Radio buttons layout */
.radio-group {
    display: flex;
    gap: 15px;
    align-items: center;
    font-size: 12px !important;
    color: #333;
    height: 24px;
    flex-wrap: wrap;
}
.radio-group label {
    display: flex;
    align-items: center;
    cursor: pointer;
    margin: 0;
}
.radio-group input[type="radio"] {
    margin: 0 5px 0 0;
    padding: 0;
}

/* ===== BUTTONS ===== */
.release-actions {
    margin-top: 15px;
    display: flex;
    flex-direction: column;
    gap: 8px;
    border-top: 1px solid #e3e8ee;
    padding-top: 15px;
}

.btn-submit {
    width: 100%;
    height: 32px;            
    background: #2563eb;
    color: #ffffff;
    border: none;
    border-radius: 4px;      
    font-size: 12px !important;
    font-weight: 600;
    cursor: pointer;
    transition: background 0.2s;
}

.btn-submit:hover {
    background: #1d4ed8;
}

.btn-submit:disabled {
    background: #9ca3af;
    cursor: not-allowed;
}

/* ===== RIGHT CONTENT AREA ===== */
.main-content-area {
    flex: 1;
    display: flex;
    flex-direction: column;
    background: #ffffff;
    height: 100%;
    overflow: hidden;
}

.top-toolbar-container {
    width: 100%;
    padding: 10px 15px;
    background: #ffffff;
    border-bottom: 1px solid #e1e8ed;
    box-sizing: border-box;
}

.grid-content-container {
    flex: 1;
    padding: 15px;
    overflow: auto; 
    box-sizing: border-box;
    display: flex;
    flex-direction: column;
}
</style>

<script type="text/javascript">

$(document).ready(function () {
    $("#btnExcel").click(function() {
        JSONToCSVCon(exceldata, 'Datalog Report', true);
    });
    $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200px;right:750px;'><img src='../../../../icons/31load.gif'/></div>");
    $('#vehdetaildiv').hide();
    
    // Converted to 100% width and 24px height for Master UI alignment
    $("#fromdate").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"dd.MM.yyyy"});
    $("#todate").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"dd.MM.yyyy"});
    
    $('#userwindow').jqxWindow({ width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'User Search' , theme: 'energyblue', position: { x: 250, y: 120 }, keyboardCloseKey: 27});
    $('#userwindow').jqxWindow('close');
    $('#formwindow').jqxWindow({ width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Form Search' , theme: 'energyblue', position: { x: 250, y: 120 }, keyboardCloseKey: 27});
    $('#formwindow').jqxWindow('close');
    
    var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
    var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
    $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate); 
   
    $('#user').dblclick(function(){
        userSearchContent('userSearchGrid.jsp?check=1');
    });
    
    $('#form').dblclick(function(){
        if (document.getElementById('formbtn').checked){
            formSearchContent('formSearchGrid.jsp?check=1');
        } else if  (document.getElementById('bibtn').checked){
            formSearchContent('formsearchgrid1.jsp?check=1');
        }
    });
});

function getUser(event){
    var x = event.keyCode;
    if(x == 114){
    	userSearchContent('userSearchGrid.jsp?check=1');
    }
}

function getForm(event){
	if (document.getElementById('formbtn').checked){
        var x = event.keyCode;
        if(x == 114){
            formSearchContent('formSearchGrid.jsp?check=1');	
        }
    } else if (document.getElementById('bibtn').checked){
        var x = event.keyCode;
        if(x == 114){
            formSearchContent('formsearchgrid1.jsp?check=1');	
        }
	}
}
    
function userSearchContent(url) {
    $('#userwindow').jqxWindow('open');
	$.get(url).done(function (data) {
	    $('#userwindow').jqxWindow('setContent', data);
	    $('#userwindow').jqxWindow('bringToFront');
    }); 
}

function formSearchContent(url) {
    $('#formwindow').jqxWindow('open');
	$.get(url).done(function (data) {
	    $('#formwindow').jqxWindow('setContent', data);
	    $('#formwindow').jqxWindow('bringToFront');
    }); 
}

function funreload(event)
{
	if(document.getElementById("cmbbranch").value == ""){
		$.messager.alert('Warning','Please Select Branch');
		return false;
	}
	var dateval = funDateInPeriod($('#todate').jqxDateTimeInput('getDate'));
	
	if(dateval == 1){
        var branch = document.getElementById("cmbbranch").value;
        var fromdate = $('#fromdate').jqxDateTimeInput('val');
        var todate = $('#todate').jqxDateTimeInput('val');
        var hidform = document.getElementById("hidform").value;
        var hiduser = document.getElementById("hiduser").value;
        
        $("#overlay, #PleaseWait").show();
        var test = "10";
        if (document.getElementById('formbtn').checked){
            var formbtn = document.getElementById("formbtn").value;
            $("#Readygrid").load("subgrid.jsp?branch="+branch+"&test="+test+"&from="+fromdate+"&to="+todate+"&id=1&hidform="+hidform+"&hiduser="+hiduser+"&value="+formbtn);
            $("#logdiv").load("datalogGrid.jsp?branch="+branch+"&fromdate="+fromdate+"&todate="+todate+"&id=1&hidform="+hidform+"&hiduser="+hiduser+"&value="+formbtn);   	 
        } else if (document.getElementById('bibtn').checked){
            var bibtn = document.getElementById("bibtn").value;
            $("#Readygrid").load("subgrid.jsp?branch="+branch+"&test="+test+"&from="+fromdate+"&to="+todate+"&id=1&hidform="+hidform+"&hiduser="+hiduser+"&value="+bibtn);
            $("#logdiv").load("datalogGrid.jsp?branch="+branch+"&fromdate="+fromdate+"&todate="+todate+"&id=1&hidform="+hidform+"&hiduser="+hiduser+"&value="+bibtn);   	 
        }
    }
}
	
function setValues(){
    if($('#msg').val()!=""){
        $.messager.alert('Message',$('#msg').val());
        $("#overlay, #PleaseWait").hide();
    }
}

function funClearData(){
    $('input[type=text],[type=hidden]').val('');
    $('#fromdate').jqxDateTimeInput('setDate',new Date());
    $('#todate').jqxDateTimeInput('setDate',new Date());
    var curfromdate = $('#fromdate').jqxDateTimeInput('getDate');
    var onemonthbackdate = new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
    $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate); 	
}

</script>
</head>
<body onload="getBranch();setValues();">
<form id="frmCostUpdate" method="post" action="saveCostUpdate">
    <div id="mainBG" class="homeContent" data-type="background"> 
        <div class="master-container">

            <!-- Sidebar / Filter Section -->
            <div class="sidebar-filters">
                <div class="sidebar-scroll-content">
                    
                    <div class="filter-card">
                        <table class="release-filter-table">
                            <tr>
                                <td class="label-cell">From Date</td>
                                <td><div id="fromdate"></div></td>
                            </tr>
                            <tr>
                                <td class="label-cell">To Date</td>
                                <td><div id="todate"></div></td>
                            </tr>
                            <tr>
                                <td class="label-cell">Type</td>
                                <td>
                                    <div class="radio-group">
                                        <label><input type="radio" name="chk" checked="checked" id="formbtn" value="formbtn" onchange="funchkval()">Form</label>
                                        <label><input type="radio" name="chk" id="bibtn" value="bibtn" onchange="funchkval()">BI</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="label-cell">Form Name</td>
                                <td>
                                    <input type="text" name="form" id="form" placeholder="Press F3 to Search" onKeyDown="getForm(event);" readonly>
                                </td>
                            </tr> 
                            <tr>
                                <td class="label-cell">User</td>
                                <td>
                                    <input type="text" name="user" id="user" placeholder="Press F3 to Search" onKeyDown="getUser(event);" readonly>
                                </td>
                            </tr>
                        </table>

                        <div class="release-actions">
                            <button type="button" name="btnclear" id="btnclear" class="btn-submit" onclick="funClearData();">Clear</button>
                        </div>
                    </div>

                    <!-- Subgrid Area within Sidebar -->
                    <div class="filter-card" style="padding: 10px;">
                        <div id="Readygrid"><jsp:include page="subgrid.jsp"></jsp:include></div>
                    </div>

                    <!-- Hidden Elements logically grouped -->
                    <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
                    <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
                    <input type="hidden" name="hiduser" id="hiduser">
                    <input type="hidden" name="hidform" id="hidform">	
                </div>
            </div>

            <!-- Main Grid / Data Section -->
            <div class="main-content-area">
                
                <div class="top-toolbar-container">
                    <jsp:include page="../../heading.jsp"></jsp:include>
                </div>

                <div class="grid-content-container">
                    <div id="logdiv"><jsp:include page="datalogGrid.jsp"></jsp:include></div> 		
                </div>

            </div>

        </div>
    </div>
</form>

<!-- Modals -->
<div id="userwindow">
    <div></div><div></div>
</div>
<div id="formwindow">
    <div></div><div></div>
</div>

</body>
</html>