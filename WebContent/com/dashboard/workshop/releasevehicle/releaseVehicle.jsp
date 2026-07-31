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

<style>
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

/* Radio buttons layout */
.radio-group {
    display: flex;
    gap: 12px;
    align-items: center;
    font-size: 12px !important;
    color: #333;
    height: 24px;
    flex-wrap: wrap;
    padding-top: 4px;
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

fieldset.radio-fieldset {
    border: 1px solid #e2e8f0;
    border-radius: 4px;
    padding: 10px;
    margin-top: 10px;
    margin-bottom: 12px;
}
fieldset.radio-fieldset legend {
    font-size: 12px;
    font-weight: 600;
    color: #4b5563;
    padding: 0 5px;
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
    display: flex;
    align-items: center;
    justify-content: center;
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
	 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	 
     // Adapted width to 100% and height to 24px for Master UI
	 $("#todate").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"dd.MM.yyyy"});
	 
	 document.getElementById("rdonotreleased").checked=true;
});

function funreload(event) {
    var todate= $("#todate").jqxDateTimeInput('val'); 
    var branch=$('#cmbbranch').val();
    var releasestatus=0;
    
    if(document.getElementById("rdonotreleased").checked==true){
        releasestatus=0;
    }
    else if(document.getElementById("rdoreleased").checked==true){
        releasestatus=1;
    }
    $("#releasediv").load("releaseVehicleGrid.jsp?todate="+todate+"&id=1&branch="+branch+"&releasestatus="+releasestatus);
}
	
function funClearData() {
	$('#frmReleaseVehicle input:not([type="radio"])').val('');
	$('#releaseVehicleGrid').jqxGrid('clear');
}

function funUpdate(){
	if(document.getElementById("jobcarddocno").value==""){
		$.messager.alert('Warning','Please Select Valid Document','Warning');
		return false;
	}
	else{
		funUpdateAJAX();
	}
}

function funUpdateAJAX(){
	var gatedocno=$('#gatedocno').val();
	var jobcarddocno=$('#jobcarddocno').val();
	var reltype=$('#reltype').val();
	var releasestatus=0;
	if(document.getElementById("rdonotreleased").checked==true){
		releasestatus=0;
	}
	else if(document.getElementById("rdoreleased").checked==true){
		releasestatus=1;
	}
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText.trim();
			if(items=="0"){
				$.messager.alert('Message','Vehicle Released Succesfully','info');
				funClearData();
				funreload(1);
			}
			else if(items==1){
				$.messager.alert('Message','Vehicle Release Failed','warning');
			}
		}
	}
	x.open("GET", "releaseVeh.jsp?jobcarddocno="+jobcarddocno+"&gatedocno="+gatedocno+"&releasestatus="+releasestatus+"&reltype="+reltype, true);
	x.send();
}

function funExportBtn(){
	var releasetitle="";
	if(document.getElementById("rdonotreleased").checked==true){
		releasetitle="Vehicle To Be Released";
	}
	else if(document.getElementById("rdoreleased").checked==true){
		releasetitle="Released Vehicles";
	}
	JSONToCSVCon(releaseexceldata, releasetitle, true);
}

function funPrint(){
	if($('#jobcarddocno').val()!='' && $('#jobcarddocno').val()!='0'){
		var url=document.URL;
		var reurl=url.split("com");
		var path= "com/dashboard/workshop/releasevehicle/printReleaseVehicle.action?jobcarddocno="+$('#jobcarddocno').val();
		var win= window.open(reurl[0]+path,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");		
		win.focus();		
	}
	else {
		$.messager.alert('Message','Please Select a jobcard.','warning');
		return;
	}
}
</script>
</head>
<body onload="getBranch();">
    <div id="mainBG" class="homeContent" data-type="background"> 
        <form id="frmReleaseVehicle" method="POST" style="height: 100%;">
            <div class="master-container">

                <!-- Sidebar / Filter Section -->
                <div class="sidebar-filters">
                    <div class="sidebar-scroll-content">
                        <div class="filter-card">
                            <table class="release-filter-table">
                                <tr>
                                    <td class="label-cell">Upto Date</td>
                                    <td>
                                        <div id='todate' name='todate' value='<s:property value="todate"/>'></div>
                                    </td>
                                </tr> 
                                <tr>
                                    <td class="label-cell">Remarks</td>
                                    <td>
                                        <select name="reltype" id="reltype" value='<s:property value="reltype"/>'>
                                            <option value="1">LPO</option>
                                            <option value="2">Parts</option>
                                            <option value="3">Total Loss</option>
                                        </select>
                                    </td>
                                </tr>
                            </table>

                            <fieldset class="radio-fieldset">
                                <legend>Release Status</legend>
                                <div class="radio-group">
                                    <label><input type="radio" name="rdorelease" id="rdonotreleased">To Be Released</label>
                                    <label><input type="radio" name="rdorelease" id="rdoreleased">Released</label>
                                </div>
                            </fieldset>

                            <div class="release-actions">
                                <button type="button" class="btn-submit" id="btnprint" onclick="funPrint();">Print</button>
                                <button type="button" class="btn-submit" id="btnupdate" onclick="funUpdate();">Release</button>
                                <button type="button" class="btn-submit" id="btnclear" onclick="funClearData();">Clear</button>
                            </div>

                            <!-- Hidden Fields Logical Grouping -->
                            <input type="hidden" name="jobcarddocno" id="jobcarddocno">
                            <input type="hidden" name="gatedocno" id="gatedocno">
                        </div>
                    </div>
                </div>

                <!-- Main Grid / Data Section -->
                <div class="main-content-area">
                    
                    <div class="top-toolbar-container">
                        <jsp:include page="../../heading.jsp"></jsp:include>
                    </div>

                    <div class="grid-content-container">
                        
                        <!-- Data Grid Container -->
                        <div id="releasediv" style="flex: 1; display: flex; flex-direction: column;">
                            <jsp:include page="releaseVehicleGrid.jsp"></jsp:include>
                        </div>
                        
                    </div>

                </div>

            </div>
        </form>
    </div>
</body>
</html>