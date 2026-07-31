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
    width: 290px; 
    flex: 0 0 290px; 
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

/* Modern Fieldset styles for Tax Tables */
fieldset.tax-section {
    border: 1px solid #e2e8f0;
    border-radius: 6px;
    padding: 15px;
    margin-bottom: 15px;
    background: #ffffff;
}

fieldset.tax-section legend {
    font-size: 13px;
    font-weight: 600;
    color: #3b82f6;
    padding: 0 8px;
    margin-bottom: 0;
}

.net-total-container {
    text-align: right;
    margin-right: 15px;
    padding: 10px 0;
    font-size: 12px;
    font-weight: bold;
    color: #1e293b;
    display: flex;
    justify-content: flex-end;
    align-items: center;
    gap: 10px;
}

.net-total-container input {
    width: 150px !important;
    text-align: right;
    font-weight: bold;
    color: #0f172a !important;
    background-color: #f1f5f9 !important;
}
</style>

<script type="text/javascript">

$(document).ready(function () {
	$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200px;right:750px;'><img src='../../../../icons/31load.gif'/></div>");
    
    // Adapted sizes for master UI compliance
 	$("#fromdate").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"dd.MM.yyyy"});
 	$("#todate").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"dd.MM.yyyy"});
 	
    var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
    var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
    $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate);
    
    $('#nettotal,#totalinput,#totaloutput').val("0");
});

function funreload(event)
{
    var fromdate=$('#fromdate').jqxDateTimeInput('val');
    var todate=$('#todate').jqxDateTimeInput('val');
    $("#overlay, #PleaseWait").show();
    $('#nettotal,#totalinput,#totaloutput').val("0");
    var nettotal=parseFloat($('#nettotal').val());
 	funRoundAmt(nettotal,"nettotal");  
 	var branch=$("#cmbbranch").val();      
   	$("#vatoutputdiv").load("vatOutputGrid.jsp?fromdate="+fromdate+"&todate="+todate+"&branch="+branch+"&id=1");
   	$("#vatinputdiv").load("vatInputGrid.jsp?fromdate="+fromdate+"&todate="+todate+"&branch="+branch+"&id=1");     
}

function setValues(){
	if($('#msg').val()!=""){
		$.messager.alert('Message',$('#msg').val());
	}
}
	
function funExportBtn(){
	$("#vatInputGrid").excelexportjs({
		containerid: "vatInputGrid",   
		datatype: 'json',
		dataset: null,
		gridId: "vatInputGrid",
		columns: getColumns("vatInputGrid") ,   
		worksheetName:"VAT Input"  
	}); 
    $("#vatOutputGrid").excelexportjs({
		containerid: "vatOutputGrid",   
		datatype: 'json',
		dataset: null,
		gridId: "vatOutputGrid",
		columns: getColumns("vatOutputGrid") ,   
		worksheetName:"VAT Output"  
	}); 
}
	
function funClearData(){
	$('input[type=text],[type=hidden]').val('');
	$('select').find('option').prop("selected", false);
	$('#fromdate').jqxDateTimeInput('setDate',new Date());
	$('#todate').jqxDateTimeInput('setDate',new Date());
	var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
    var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
    $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate); 
    $('#nettotal,#totalinput,#totaloutput').val("0");
}
	
</script>
</head>
<body onload="setValues();getBranch();">
<form id="frmReplaceList" method="post">
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
                        </table>

                        <div class="release-actions">
                            <button type="button" name="btnclear" id="btnclear" class="btn-submit" onclick="funClearData();">Clear</button>
                        </div>
                    </div>

                    <!-- Hidden Fields logically retained in the form -->
                    <input type="hidden" name="totalinput" id="totalinput" value='<s:property value="totalinput"/>'>
                    <input type="hidden" name="totaloutput" id="totaloutput" value='<s:property value="totaloutput"/>'>
                    <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
                    <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
                    <input type="hidden" name="printdocno" id="printdocno" value='<s:property value="printdocno"/>'>
                </div>
            </div>

            <!-- Main Grid / Data Section -->
            <div class="main-content-area">
                
                <div class="top-toolbar-container">
                    <jsp:include page="../../heading.jsp"></jsp:include>
                </div>

                <div class="grid-content-container">
                    
                    <!-- Output Tax Section -->
                    <fieldset class="tax-section">
                        <legend>Output Tax</legend>
                        <div id="vatoutputdiv"><jsp:include page="vatOutputGrid.jsp"></jsp:include></div>
                    </fieldset>
                    
                    <!-- Input Tax Section -->
                    <fieldset class="tax-section">
                        <legend>Input Tax</legend>
                        <div id="vatinputdiv"><jsp:include page="vatInputGrid.jsp"></jsp:include></div>
                    </fieldset>

                    <!-- Net Total Display -->
                    <div class="net-total-container">
                        <label>Net Total</label>
                        <input type="text" name="nettotal" id="nettotal" value='<s:property value="nettotal"/>' readonly onKeyPress="javascript:return isNumber (event,id)" onBlur="funRoundAmt(value,id);">
                    </div>

                </div>

            </div>

        </div>

        <!-- Modals -->
        <div id="clientsearchwindow">
            <div></div>
        </div>
        <div id="agmtnowindow">
            <div></div>
        </div>
    </div>
</form>
</body>
</html>