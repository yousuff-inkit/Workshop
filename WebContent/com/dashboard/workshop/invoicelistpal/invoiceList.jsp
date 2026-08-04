><jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  

<script type="text/javascript">

$(document).ready(function () {
	$("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	$("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	$('#accountwindow').jqxWindow({ width: '62%', height: '65%',  maxHeight: '85%' ,maxWidth: '80%' , title: 'Account Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	$('#accountwindow').jqxWindow('close');
	$('#regnowindow').jqxWindow({ width: '30%', height: '65%',  maxHeight: '85%' ,maxWidth: '30%' , title: 'Reg No Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	$('#regnowindow').jqxWindow('close');
	var fromdate=new Date($('#fromdate').jqxDateTimeInput('getDate'));
	var onemonthbefore=new Date(new Date(fromdate).setMonth(fromdate.getMonth()-1)); 
    $('#fromdate').jqxDateTimeInput('setDate', new Date(onemonthbefore));
	
	$('#todate').on('change', function (event) {
		var fromdate=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		var todate=new Date($('#todate').jqxDateTimeInput('getDate'));
		if(fromdates>todates){
			$.messager.alert('Message','To Date Less Than From Date  ','warning');   
			return false;
		}   
	});
	
	$('#account').dblclick(function(){
		$('#accountwindow').jqxWindow('open');
		$('#accountwindow').jqxWindow('focus');
		accountSearchContent('accountSearch.jsp');
	});
	$('#regno').dblclick(function(){
		$('#regnowindow').jqxWindow('open');
		$('#regnowindow').jqxWindow('focus');
		regnoSearchContent('regnoSearchGrid.jsp?id=1');
	});
});

function getAccount(event){
	var x= event.keyCode;
    if(x==114){
    	$('#accountwindow').jqxWindow('open');
		$('#accountwindow').jqxWindow('focus');
		accountSearchContent('accountSearch.jsp');
    }
    else{
    }
}
function getRegno(event){
	var x= event.keyCode;
    if(x==114){
    	$('#regnowindow').jqxWindow('open');
		$('#regnowindow').jqxWindow('focus');
		regnoSearchContent('regnoSearchGrid.jsp?id=1');
    }
    else{
    }
}
function accountSearchContent(url) {
	$.get(url).done(function (data) {
	    $('#accountwindow').jqxWindow('setContent', data);
	}); 
}
function regnoSearchContent(url) {
	$.get(url).done(function (data) {
	    $('#regnowindow').jqxWindow('setContent', data);
	}); 
}
function funClearData(){
	$('#fromdate,#todate').jqxDateTimeInput('setDate',new Date());
	var fromdate=new Date($('#fromdate').jqxDateTimeInput('getDate'));
	var onemonthbefore=new Date(new Date(fromdate).setMonth(fromdate.getMonth()-1)); 
    $('#fromdate').jqxDateTimeInput('setDate', new Date(onemonthbefore));
	$('#todate').val(new Date());
	$('input[type=text],[type=hidden]').val('');
}
	
function funreload(event){
	var fromdate=new Date($('#fromdate').jqxDateTimeInput('getDate'));
	var todate=new Date($('#todate').jqxDateTimeInput('getDate'));
	if(fromdate>todate){
		$.messager.alert('Message','To Date Less Than From Date','warning');   
		return false;
	} 
	else{
		var branch = document.getElementById("cmbbranch").value;
		fromdate = $('#fromdate').val();
		todate = $('#todate').val();
		var acno=$('#acno').val();
		var regno=$('#regno').val();
		$("#overlay, #PleaseWait").show();
		$('#invoicelistgriddiv').load('invoiceListGrid.jsp?branch='+branch+'&fromdate='+fromdate+'&todate='+todate+'&id=1&acno='+acno+'&regno='+regno);
	}
}

function funExportBtn(){
	$("#invoiceListGrid").excelexportjs({
		containerid: "invoiceListGrid",
		datatype: 'json',
		dataset: null,
		gridId: "invoiceListGrid",
		columns: getColumns("invoiceListGrid"),
		worksheetName: "Invoice List"
	});
}

function funPrint(){
	var invno=$('#invno').val();
	var invbrhid=$('#invbrhid').val();
	if(invno=='' || invno==null || invno=='undefined'){
		$.messager.alert('Warning','Please select a valid Document');
	}
	else{
		var url=document.URL;
        var reurl=url.split("com");
        var win= window.open(reurl[0]+"WSInvoicePrintActionpal.action?&docno="+document.getElementById("invno").value+"&header=1&branch="+invbrhid+"&type="+1+"&jobcarddocno="+$('#jobdocno').val(),"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
        //alert(reurl[0]+"WSInvoicePrintAction.action?&docno="+document.getElementById("invno").value+"&header=1&branch="+invbrhid);
        win.focus();
	}
}
</script>
<style>/* ===== MASTER LAYOUT ===== */
html, body, #mainBG, .hidden-scrollbar {
    height: 100%;
    margin: 0;
    overflow: hidden;
    background-color: #f4f7f9;
}

.master-container {
    display: flex;
    width: 100%;
    height: 100vh;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
}

/* ===== LEFT SIDEBAR ===== */
.sidebar-filters {
    width: 280px; 
    flex: 0 0 280px; 
    background: #fff;
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
    padding: 15px 15px 25px; 
}

/* Cards Layout Rules */
.filter-card {
    background: #f8fafc;
    border: 1px solid #e3e8ee;
    border-radius: 12px;
    padding: 15px;
    margin-bottom: 12px;
}

/* Internal Presentation Tables */
.filter-table {
    width: 100%;
    border-spacing: 0 10px;
}

.filter-table .label-cell {
    text-align: right;
    padding-right: 10px;
    font-size: 12px;
    color: #4e5e71;
    font-weight: 600;
    width: 70px;
}

/* ===== UNIFORM 24px INPUTS & SELECTS ===== */
input[type="text"], select,
.filter-table input[type="text"],
.filter-table select {
    width: 100%;
    height: 24px !important;             
    padding: 2px 8px !important;         
    border: 1px solid #ccd6e0 !important;
    border-radius: 4px !important;       
    font-size: 12px !important;          
    background-color: #ffffff;
    box-sizing: border-box;
    color: #333;
    outline: none;
}

/* Readonly fields override */
input[readonly],
input:disabled {
    background-color: #f3f6f9 !important;
    color: #555;
    border-color: #e1e8ed !important;
    cursor: text;
}

/* jqx Date Container Mapping Rules */
.filter-table div[id^="fromdate"],
.filter-table div[id^="todate"] {
    width: 100%;
}

/* ===== MASTER 30px BUTTON SYSTEM ===== */
.btn-submit {
    width: 100%;
    height: 30px !important;            
    padding: 0 12px !important;
    background: #2563eb !important;
    color: #fff !important;
    border: none !important;
    border-radius: 4px !important;
    font-size: 13px !important;
    font-weight: 600 !important;
    cursor: pointer;
    line-height: 30px !important;
    white-space: nowrap;
    text-align: center;
    transition: all 0.2s ease;
    box-shadow: none !important;
    display: inline-block;
    box-sizing: border-box;
    margin-bottom: 8px;
}

.btn-submit:hover {
    background: #1d4ed8 !important;
}

/* Button Group Styling */
.button-group-row {
    display: flex;
    gap: 8px;
    margin-bottom: 8px;
}

.button-group-row .btn-submit {
    flex: 1;
    margin-bottom: 0;
}

/* ===== RIGHT CONTENT AREA (Horizontally Aligned Heading) ===== */
.main-content-wrapper {
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

.scrollable-grid-area {
    flex: 1;
    padding: 15px 20px;
    overflow: auto; 
    box-sizing: border-box;
}</style>

</head>
<body onload="getBranch();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>

<div class="master-container">

    <!-- ================= LEFT PANEL (SIDEBAR) ================= -->
    <div class="sidebar-filters">
        <div class="sidebar-scroll-content">

            <!-- Primary Filters Card -->
            <div class="filter-card">
                <table class="filter-table">
                    <tr>
                        <td class="label-cell">From</td>
                        <td><div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div></td>
                    </tr> 
                    <tr>
                        <td class="label-cell">To</td>
                        <td><div id="todate" name="todate" value='<s:property value="todate"/>'></div></td>
                    </tr>
                    <tr>
                        <td class="label-cell">Reg No</td>
                        <td>
                            <input type="text" name="regno" id="regno" readonly placeholder="Press F3 to Search" onkeydown="getRegno(event);">
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Account</td>
                        <td>
                            <input type="text" name="account" id="account" readonly placeholder="Press F3 to Search" onkeydown="getAccount(event);">
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <input type="text" name="accountname" id="accountname" readonly disabled>
                        </td>
                    </tr>
                </table>
            </div>

            <!-- Action Buttons Card -->
            <div class="filter-card">
                <div class="button-group-row">
                    <input type="button" name="btninvoiceprint" id="btninvoiceprint" class="btn-submit" value="Print" onclick="funPrint();">
                    <input type="button" class="btn-submit" name="clear" id="clear" value="Clear" onclick="funClearData();" style="background:#64748b !important;">
                </div>
            </div>

            <!-- Hidden Inputs Maintained Safely Outside Visual Layout -->
            <div style="display:none;">
                <input type="hidden" name="acno" id="acno">
                <input type="hidden" name="invno" id="invno" value='<s:property value="invno"/>'>
                <input type="hidden" name="invbrhid" id="invbrhid" value='<s:property value="invbrhid"/>'>
                <input type="hidden" name="jobdocno" id="jobdocno" value='<s:property value="jobdocno"/>'>
            </div>

        </div>
    </div>

    <!-- ================= RIGHT PANEL (WORKSPACE GRIDS) ================= -->
    <div class="main-content-wrapper">
        
        <!-- Horizontally Aligned Heading Toolbar -->
        <div class="top-toolbar-container">
            <jsp:include page="../../heading.jsp"></jsp:include>
        </div>

        <div class="scrollable-grid-area">
            <div id="invoicelistgriddiv">
                <jsp:include page="invoiceListGrid.jsp"></jsp:include>
            </div>
        </div>

    </div>

</div>

<!-- Popups Maintained Outside the Layout Flow -->
<div id="accountwindow">
	<div></div>
</div>
<div id="regnowindow">
	<div></div>
</div>

</div> 
</div> 
</body>
</html>