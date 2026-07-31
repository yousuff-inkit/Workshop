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
/* ===== MASTER LAYOUT (Modern Flexbox) ===== */
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
    width: 80px; 
}

/* ===== UNIFORM INPUTS & SELECTS ===== */
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
}
</style>

<script type="text/javascript">

$(document).ready(function () {
		
	$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200px;right:750px;'><img src='../../../../icons/31load.gif'/></div>");
    
    $('#clientwindow').jqxWindow({ width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Client Search'  , theme: 'energyblue', position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	$('#clientwindow').jqxWindow('close');
	
    $('#gipwindow').jqxWindow({ width: '30%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Gate In Pass Search'  , theme: 'energyblue', position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	$('#gipwindow').jqxWindow('close');
	
    $("#todate").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"dd.MM.yyyy"});
	
    $('#client').dblclick(function(){
		$('#clientwindow').jqxWindow('open');
		clientSearchContent('clientsearch.jsp?id=1', $('#clientwindow')); 
	});
	
    $('#gipvocno,#regno').dblclick(function(){
		$('#gipwindow').jqxWindow('open');
		gipSearchContent('gipSearch.jsp?id=1', $('#gipwindow')); 
	});
});


function getClientInfo(event){
	 var x= event.keyCode;
	if(x==114){
		$('#clientwindow').jqxWindow('open');
		clientSearchContent('clientsearch.jsp?id=1', $('#clientwindow'));
	}
} 

function getGipInfo(event){
	 var x= event.keyCode;
	if(x==114){
		$('#gipwindow').jqxWindow('open');
		gipSearchContent('gipSearch.jsp?id=1', $('#gipwindow'));
	}
} 

function clientSearchContent(url) {
    $.get(url).done(function (data) {
        $('#clientwindow').jqxWindow('open');
        $('#clientwindow').jqxWindow('setContent', data);
    }); 
} 

function gipSearchContent(url) {
    $.get(url).done(function (data) {
        $('#gipwindow').jqxWindow('open');
        $('#gipwindow').jqxWindow('setContent', data);
    }); 
} 

function funreload(event)
{
    var todate=$('#todate').jqxDateTimeInput('val');
	var branch=$('#cmbbranch').val();
	var cldocno=$('#cldocno').val();
	var gipdocno=$('#gipdocno').val();
	var regno=$('#regno').val();
    
    $("#overlay, #PleaseWait").show();
   	$("#countdiv").load("countGrid.jsp?todate="+todate+"&id=1&branch="+branch+"&cldocno="+cldocno+"&gipdocno="+gipdocno+"&regno="+regno);
}
	
function setValues(){
    if($('#msg').val()!=""){
        $.messager.alert('Message',$('#msg').val());
    }
}
	
function funClearData(){
    $('input[type=text],[type=hidden]').val('');
    $('select').find('option').prop("selected", false);
    $('#todate').jqxDateTimeInput('setDate',new Date());
}

function funExportBtn(){
    JSONToCSVCon(detailexceldata,"Analysis of "+document.getElementById("docstatus").value, true);
}
	
</script>
</head>
<body onload="setValues();getBranch();">
<form id="frmICGateInPass" method="post" autocomplete="off">
<div id="mainBG" class="homeContent" data-type="background"> 
    <div class="master-container">

        <!-- Sidebar / Filter Section -->
        <div class="sidebar-filters">
            <div class="sidebar-scroll-content">
                <div class="filter-card">
                    <table class="release-filter-table">
                        <tr>
                            <td class="label-cell">Up To Date</td>
                            <td><div id="todate"></div></td>
                        </tr>
                        <tr>
                            <td class="label-cell">Client</td>
                            <td>
                                <input type="text" name="client" id="client" value='<s:property value="client"/>' onkeydown="getClientInfo(event);" placeholder="Press F3 to Search">
                                <input type="hidden" name="cldocno" id="cldocno" value='<s:property value="cldocno"/>'>
                            </td>
                        </tr>
                        <tr>
                            <td class="label-cell">GIP No</td>
                            <td>
                                <input type="text" name="gipvocno" id="gipvocno" value='<s:property value="gipvocno"/>' onkeydown="getGipInfo(event);" placeholder="Press F3 to Search">
                                <input type="hidden" name="gipdocno" id="gipdocno" value='<s:property value="gipdocno"/>'>
                            </td>
                        </tr>
                        <tr>
                            <td class="label-cell">Reg No</td>
                            <td>
                                <input type="text" name="regno" id="regno" value='<s:property value="regno"/>' onkeydown="getGipInfo(event);" placeholder="Press F3 to Search">
                            </td>
                        </tr>
                    </table>

                    <div class="release-actions">
                        <button type="button" name="btnclear" id="btnclear" class="btn-submit" onclick="funClearData();">Clear</button>
                    </div>
                </div>

                <!-- Embedded Count Grid -->
                <div class="filter-card" style="padding: 10px;">
                    <div id="countdiv"><jsp:include page="countGrid.jsp"></jsp:include></div>
                </div>

                <!-- Hidden Fields -->
                <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
                <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
                <input type="hidden" name="printdocno" id="printdocno" value='<s:property value="printdocno"/>'>
                <input type="hidden" name="docstatus" id="docstatus" value='<s:property value="docstatus"/>'>
            </div>
        </div>

        <!-- Main Grid / Data Section -->
        <div class="main-content-area">
            
            <div class="top-toolbar-container">
                <jsp:include page="../../heading.jsp"></jsp:include>
            </div>

            <div class="grid-content-container">
                <div id="detaildiv"><jsp:include page="detailGrid.jsp"></jsp:include></div>
            </div>

        </div>

        <!-- Modals -->
        <div id="clientwindow">
            <div></div>
        </div>
        <div id="gipwindow">
            <div></div>
        </div>

    </div>
</div>
</form>
</body>
</html>