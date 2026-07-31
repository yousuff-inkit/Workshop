<jsp:include page="../../../../includes.jsp"></jsp:include>    
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
.release-filter-table div[id^="fromdate"],
.release-filter-table div[id^="todate"] {
    width: 100% !important;
    height: 24px !important;
}

/* Radio buttons layout */
.radio-group {
    display: flex;
    gap: 10px;
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
    margin: 0 4px 0 0;
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
}
</style>

<script type="text/javascript">

$(document).ready(function () {
		
	$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200px;right:750px;'><img src='../../../../icons/31load.gif'/></div>");
    
	$("#fromdate").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"dd.MM.yyyy"});
	$("#todate").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"dd.MM.yyyy"});
	 
	var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
	var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
	$('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate);
	 
	$('#technician').dblclick(function(){
		techSearchContent("technicianSearch.jsp");
	});
	 
	$('#technicianToWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Client Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	$('#technicianToWindow').jqxWindow('close');
	 
	$('#jobcard').dblclick(function(){
		jobCardSearchContent("jobCardSearch.jsp");
	});
	 
	$('#jobCardToWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Client Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	$('#jobCardToWindow').jqxWindow('close');
	 
	document.getElementById("rdall").checked=true;
	summaryDisable();
	 
});


function funreload(event)
{
	var brhid=$('#cmbbranch').val();
    var fromdate=$('#fromdate').jqxDateTimeInput('val');
    var todate=$('#todate').jqxDateTimeInput('val');
    var jcno=document.getElementById("jobcard").value;
    var techid=document.getElementById("techid").value;
  
    if(document.getElementById("rdall").checked==true){
    	$("#overlay, #PleaseWait").show(); 
   	   	$("#jobclockanalysisdiv").load("jobClockAnalysisGrid.jsp?fromdate="+fromdate+"&todate="+todate+"&id=1"+"&jcno="+jcno+"&techid="+techid+'&brhid='+brhid);
		
	}else if(document.getElementById("rdsummary").checked==true){

        if($('#cmbsummarytype').val()=='') {
            $.messager.alert('Message','Please Choose a Summary Type.','warning');
        }
	   	var x=$("#cmbsummarytype option:selected").val();
	   	if(x=="tech"){
	   		$("#overlay, #PleaseWait").show(); 
	   	   	$("#jobclockanalysisdiv").load("technicianGroupGrid.jsp?fromdate="+fromdate+"&todate="+todate+"&id=1"+"&jcno="+jcno+"&techid="+techid+"&brhid="+brhid); 
	   		
	   	}else if(x=="jc"){
	   		$("#overlay, #PleaseWait").show(); 
	   	   	$("#jobclockanalysisdiv").load("jobcardGroupGrid.jsp?fromdate="+fromdate+"&todate="+todate+"&id=1"+"&jcno="+jcno+"&techid="+techid+"&brhid="+brhid); 
	   		
	   	}
	}
}
	
function setValues(){
    if($('#msg').val()!=""){
        $.messager.alert('Message',$('#msg').val());
    }
}
	
function getTechDetails(event){
    var x= event.keyCode;
    if(x==114){
        techSearchContent("technicianSearch.jsp");
    }
}
	
function techSearchContent(url) {
    $('#technicianToWindow').jqxWindow('open');
    $.get(url).done(function (data) {
        $('#technicianToWindow').jqxWindow('setContent', data);
    });
}
	
function getjobCardDetails(event){
    var x= event.keyCode;
    if(x==114){
        jobCardSearchContent("jobCardSearch.jsp");
    }
}
	
function jobCardSearchContent(url) {
    $('#jobCardToWindow').jqxWindow('open');
    $.get(url).done(function (data) {
        $('#jobCardToWindow').jqxWindow('setContent', data);
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
}
	
function summaryDisable(){
    if(document.getElementById("rdall").checked==true){
        $('#cmbsummarytype').attr('disabled', true);
        $('select').find('option').prop("selected", false);
        
    }else if(document.getElementById("rdsummary").checked==true){
        $('#cmbsummarytype').attr('disabled', false);
    }
}
	
function funExportBtn(){
    var excelname="";
    if(document.getElementById("rdall").checked==true){
        excelname="Job Clock Analysis List";
    }
    else{
        if(document.getElementById("cmbsummarytype").value=='jc'){
            excelname="Job Clock Analysis - Jobcard wise Summary";			
        }
        else{
            excelname="Job Clock Analysis - Technician wise Summary";
        }
    }
    
    $("#jobExecutionGrid").excelexportjs({
        containerid: "jobExecutionGrid",
        datatype: 'json',
        dataset: null,
        gridId: "jobExecutionGrid",
        columns: getColumns("jobExecutionGrid") ,
        worksheetName:excelname
    });	
}
	
</script>
</head>
<body onload="getBranch();">
<form id="frmWorkJobExecution" method="post">
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
                                <td class="label-cell">Job Card</td>
                                <td>
                                    <input type="text" name="jobcard" id="jobcard" readonly placeholder="Press F3 to Search" onkeydown="getjobCardDetails(event)">
                                </td>
                            </tr>
                            <tr>
                                <td class="label-cell">Technician</td>
                                <td>
                                    <input type="text" name="technician" id="technician" readonly placeholder="Press F3 to Search" onkeydown="getTechDetails(event)">
                                </td>
                            </tr>
                            <tr>
                                <td class="label-cell">Report Type</td>
                                <td>
                                    <div class="radio-group">
                                        <label><input type="radio" id="rdall" name="rdo" onclick="summaryDisable();" value="rdall">All</label>
                                        <label><input type="radio" id="rdsummary" name="rdo" onclick="summaryDisable();" value="rdsummary">Summary</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="label-cell">Summary Type</td>
                                <td>
                                    <select id="cmbsummarytype" name="cmbsummarytype" value='<s:property value="cmbsummarytype"/>'>
                                        <option value="">--Select--</option>
                                        <option value="tech">Technician</option>
                                        <option value="jc">Job Card</option>
                                    </select>
                                </td>
                            </tr>
                        </table>

                        <div class="release-actions">
                            <button type="button" name="btnclear" id="btnclear" class="btn-submit" onclick="funClearData();">Clear</button>
                        </div>

                        <!-- Hidden fields -->
                        <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
                        <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
                        <input type="hidden" name="techid" id="techid" value='<s:property value="techid"/>'>
                        <input type="hidden" name="clockDocno" id="clockDocno" value='<s:property value="clockDocno"/>'>
                    </div>
                </div>
            </div>

            <!-- Main Grid / Data Section -->
            <div class="main-content-area">
                
                <div class="top-toolbar-container">
                    <jsp:include page="../../heading.jsp"></jsp:include>
                </div>

                <div class="grid-content-container">
                    <div id="jobclockanalysisdiv"><jsp:include page="jobClockAnalysisGrid.jsp"></jsp:include></div>
                </div>

            </div>

        </div>
    </div>
</form>

<!-- Modals -->
<div id="technicianToWindow">
    <div></div>
</div>
<div id="jobCardToWindow">
    <div></div>
</div>	
	
</body>
</html>