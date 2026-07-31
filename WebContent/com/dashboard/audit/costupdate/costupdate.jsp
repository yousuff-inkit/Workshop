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
    width: 80px; 
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
    gap: 12px;
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
    // setType(null);
    $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200px;right:750px;'><img src='../../../../icons/31load.gif'/></div>");
    
    $('#vehdetaildiv').hide();
    
    // Updated width to 100% and height to 24px for Master UI
    $("#fromdate").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"dd.MM.yyyy"});
    $("#todate").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"dd.MM.yyyy"});
    
    $('#costCodeDetailsWindow').jqxWindow({ width: '60%', height: '68%',  maxHeight: '68%' ,maxWidth: '60%' , title: 'Cost Detail Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
    $('#costCodeDetailsWindow').jqxWindow('close');
    
    var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
    var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
    $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate); 
    
    $('#costmissingdiv').hide();
    document.getElementById("rdodifference").checked=true;
    setCosttype();
    getCostType();
    
    $('#costcode').dblclick(function(){
        if(document.getElementById("cmbcosttype").value==""){
            $.messager.alert('warning','Cost Type is Mandatory');
            return false;
        }
        $('#costCodeDetailsWindow').jqxWindow('open');
        $('#costCodeDetailsWindow').jqxWindow('focus');
        costCodeDetailsContent('costCodeDetailsSearch.jsp?', $('#costCodeDetailsWindow'));
    });
});


function getCostCodeKey(event){
    if(document.getElementById("cmbcosttype").value==""){
        $.messager.alert('warning','Cost Type is Mandatory');
        return false;
    }
    var x= event.keyCode;
    if(x==114){
        $('#costCodeDetailsWindow').jqxWindow('open');
        $('#costCodeDetailsWindow').jqxWindow('focus');
        costCodeDetailsContent('costCodeDetailsSearch.jsp?', $('#costCodeDetailsWindow'));
    }
}

function costCodeDetailsContent(url) {
    $.get(url).done(function (data) {
        $('#costCodeDetailsWindow').jqxWindow('setContent', data);
    }); 
}

function funreload(event)
{
    if(document.getElementById("cmbbranch").value==""){
        $.messager.alert('Warning','Please Select Branch');
        return false;
    }
    var dateval=funDateInPeriod($('#todate').jqxDateTimeInput('getDate'));
    if(dateval==1){
        var branch=document.getElementById("cmbbranch").value;
        var fromdate=$('#fromdate').jqxDateTimeInput('val');
        var todate=$('#todate').jqxDateTimeInput('val');
        
        $("#overlay, #PleaseWait").show();
        if(document.getElementById("rdomissing").checked==true){
            $("#costmissingdiv").load("costMissingGrid.jsp?branch="+branch+"&fromdate="+fromdate+"&todate="+todate+"&id=1");
        }
        else if(document.getElementById("rdodifference").checked==true){
            $("#costupdatediv").load("costupdateGrid.jsp?branch="+branch+"&fromdate="+fromdate+"&todate="+todate+"&id=1");   	 
        }
    }
}
	

function setValues(){
    if($('#msg').val()!=""){
        $.messager.alert('Message',$('#msg').val());
        $("#overlay, #PleaseWait").hide();
    }
}

function funExportBtn(){
    $("#vehUtilizeGrid").jqxGrid('exportdata', 'xls', 'Vehicle Utilization');
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

function funPost(){
    var rows = $("#costupdateGrid").jqxGrid('selectedrowindexes');
    document.getElementById("hidtrno").value="";
    document.getElementById("hidgridacno").value="";
    
    for(var i=0;i<rows.length;i++){
        var trno=$('#costupdateGrid').jqxGrid('getcellvalue',rows[i],'tr_no');
        var acno=$('#costupdateGrid').jqxGrid('getcellvalue',rows[i],'acno');
        if(i==0){
            document.getElementById("hidgridacno").value=acno+"::"+trno;
        }
        else{
            document.getElementById("hidgridacno").value+=","+acno+"::"+trno;
        }
    }
    if(document.getElementById("rdodifference").checked==true){
        document.getElementById("mode").value="A";
        $("#overlay, #PleaseWait").show();
        document.getElementById("frmCostUpdate").submit();			
    }
}
	
function setCosttype(){
    if(document.getElementById("rdomissing").checked==true){
        $('#costupdatediv').hide();
        $('#costmissingdiv').show();
        $('#btncostupdate').show();
    }
    else if(document.getElementById("rdodifference").checked==true){
        $('#costmissingdiv').hide();
        $('#costupdatediv').show();
        $('#btncostupdate').hide();
    }
}
	
function getCostType() {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText;
            items = items.split('####');
            var srno  = items[0].split(",");
            var process = items[1].split(",");
            var optionsbranch = '<option value="" selected>-- Select -- </option>';
            for (var i = 0; i < process.length; i++) {
                optionsbranch += '<option value="' + srno[i].trim() + '">'
                    + process[i] + '</option>';
            }
            $("select#cmbcosttype").html(optionsbranch);
        }
    }
    x.open("GET","getCostType.jsp", true);
    x.send();
}
	
function funClearCosts(){
    $('#costcode,#costcodename,#hidcostcode').val('');
    $('#costcode').attr('placeholder','Press F3 to Search');
}
	
function funMissingUpdate(){
    if(document.getElementById("rdomissing").checked==false){
        $.messager.alert('warning','Please Enable the missing option');
        return false;
    }
    if(document.getElementById("cmbcosttype").value==""){
        $.messager.alert('warning','Please choose cost type');
        return false;
    }
    if(document.getElementById("costcode").value==""){
        $.messager.alert('warning','Please choose cost code');
        return false;
    }
    var selectedrows=$('#costMissingGrid').jqxGrid('selectedrowindexes');
    var trno="";
    for( var i=0;i<selectedrows.length;i++){
        if(i==0){
            document.getElementById("missingtrno").value+=$('#costMissingGrid').jqxGrid('getcellvalue',selectedrows[i],'tr_no')+"::"+$('#costMissingGrid').jqxGrid('getcellvalue',selectedrows[i],'acno');
        }
        else{
            document.getElementById("missingtrno").value+=","+$('#costMissingGrid').jqxGrid('getcellvalue',selectedrows[i],'tr_no')+"::"+$('#costMissingGrid').jqxGrid('getcellvalue',selectedrows[i],'acno');
        }
    }
    document.getElementById("mode").value="MU";
    $("#overlay, #PleaseWait").show();
    document.getElementById("frmCostUpdate").submit();		
}

function funUpdateMissing(trno,costtype,costcode){
    // Dummy function retained
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
                                <td class="label-cell">Status</td>
                                <td>
                                    <div class="radio-group">
                                        <label><input type="radio" name="rdocosttype" id="rdomissing" onchange="setCosttype();">Manual</label>
                                        <label><input type="radio" name="rdocosttype" id="rdodifference" onchange="setCosttype();">Automatic</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="label-cell">Cost Type</td>
                                <td>
                                    <select name="cmbcosttype" id="cmbcosttype" onchange="funClearCosts();">
                                        <option value="">--Select--</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td class="label-cell">Cost Code</td>
                                <td>
                                    <input type="text" name="costcode" id="costcode" placeholder="Press F3 to Search" readonly onkeydown="getCostCodeKey(event);">
                                </td>
                            </tr>
                            <tr>
                                <td class="label-cell"></td>
                                <td>
                                    <input type="text" name="costcodename" id="costcodename" readonly tabindex="-1">
                                </td>
                            </tr>
                        </table>

                        <div class="release-actions">
                            <button type="button" name="btncostupdate" id="btncostupdate" class="btn-submit" onClick="funMissingUpdate();">Update</button>
                            <button type="button" name="btnclear" id="btnclear" class="btn-submit" onclick="funClearData();">Clear</button>
                            <button type="button" name="btnpost" id="btnpost" class="btn-submit" onclick="funPost();">Post</button>
                        </div>

                        <!-- Hidden elements logically placed at bottom of sidebar form -->
                        <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
                        <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
                        <input type="hidden" name="hidtrno" id="hidtrno">
                        <input type="hidden" name="hidgridacno" id="hidgridacno">
                        <input type="hidden" name="hidcostcode" id="hidcostcode">
                        <input type="hidden" name="missingtrno" id="missingtrno" value='<s:property value="missingtrno"/>'>
                    </div>
                </div>
            </div>

            <!-- Main Grid / Data Section -->
            <div class="main-content-area">
                
                <div class="top-toolbar-container">
                    <jsp:include page="../../heading.jsp"></jsp:include>
                </div>

                <div class="grid-content-container">
                    <div id="costupdatediv"><jsp:include page="costupdateGrid.jsp"></jsp:include></div>
                    <div id="costmissingdiv"><jsp:include page="costMissingGrid.jsp"></jsp:include></div> 		
                </div>

            </div>

        </div>

        <!-- Modals -->
        <div id="costCodeDetailsWindow">
           <div></div>
        </div>
    </div>
</form>
</body>
</html>