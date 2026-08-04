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
}

/* Tables & Spacing */
.release-filter-table {
    width: 100%;
    border-collapse: collapse;
}

.release-filter-table td {
    padding: 6px 2px; /* Improved vertical spacing between rows */
    vertical-align: middle;
}

.release-filter-table .label-cell {
    text-align: right;
    padding-right: 10px;
    font-size: 12px !important; /* Strict 12px for labels */
    color: #4b5563;
    font-weight: normal;
    width: 95px; /* Enough space for "Summary Type" */
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
    font-size: 12px !important; /* Strict 12px for inputs */
    background-color: #ffffff !important; /* Forces white, kills the pink background */
    color: #333333 !important; /* Better text appearance */
    box-sizing: border-box;
    font-family: inherit;
    outline: none;
}

select:focus, input[type="text"]:focus, textarea:focus {
    border-color: #3b82f6 !important;
    box-shadow: 0 0 0 1px rgba(59, 130, 246, 0.1);
}

.release-filter-table textarea {
    height: 120px;
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

/* ===== ADD/REMOVE ITEM INPUT GROUP (+ and - buttons) ===== */
.search-by-group {
    display: flex;
    gap: 4px;
    align-items: center;
}
.search-by-group select {
    flex: 1;
}
.btn-icon {
    width: 24px;
    height: 24px;
    background-color: #ffffff !important; /* Master UI white/light grey button style */
    border: 1px solid #cbd5e1 !important;
    border-radius: 3px;
    cursor: pointer;
    font-weight: bold;
    color: #333333 !important;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 14px;
    padding: 0;
    margin: 0;
    box-shadow: 0 1px 2px rgba(0,0,0,0.05);
    transition: all 0.2s ease;
}
.btn-icon:hover {
    background-color: #f1f5f9 !important;
    border-color: #94a3b8 !important;
    color: #000000 !important;
}
.btn-icon:active {
    background-color: #e2e8f0 !important;
}

/* ===== BUTTONS (Clear Button) ===== */
.release-actions {
    margin-top: 15px;
    display: flex;
    flex-direction: column;
    gap: 8px;
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
         
    $('#clientToWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Client Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
    $('#clientToWindow').jqxWindow('close');
    
    $('#repairtypeSearchWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Repair Type Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
    $('#repairtypeSearchWindow').jqxWindow('close');
    
    $('#serviceAdvisorSearchWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Service Advisor Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
    $('#serviceAdvisorSearchWindow').jqxWindow('close');
    
    $('#salesmanSearchWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Salesman Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
    $('#salesmanSearchWindow').jqxWindow('close');
    
    document.getElementById("rdall").checked=true;
    summaryDisable();
    
});

function funreload(event)
{
    var fromdate=$('#fromdate').jqxDateTimeInput('val');
    var todate=$('#todate').jqxDateTimeInput('val');
    var hidclient=document.getElementById("hidclient").value;
    var hidclientslm=document.getElementById("hidclientslm").value;
    var hidrepairtype=document.getElementById("hidrepairtype").value;
    var hidserviceadvisor=document.getElementById("hidserviceadvisor").value;
  
    if(document.getElementById("rdall").checked==true){
        $("#overlay, #PleaseWait").show(); 
        $("#revenuereportdiv").load("detailGrid.jsp?fromdate="+fromdate+"&todate="+todate+"&id=1"+"&hidclient="+hidclient+"&hidclientslm="+hidclientslm+"&hidrepairtype="+hidrepairtype+"&hidserviceadvisor="+hidserviceadvisor);
        
    }else if(document.getElementById("rdsummary").checked==true){

        if($('#cmbsummarytype').val()=='') {
            $.messager.alert('Message','Please Choose a Summary Type.','warning');
        }
        var x=$("#cmbsummarytype option:selected").val();
        if(x=="clt"){
            $("#overlay, #PleaseWait").show(); 
            $("#revenuereportdiv").load("summaryGrid.jsp?fromdate="+fromdate+"&todate="+todate+"&id=1"+"&hidclient="+hidclient+"&hidclientslm="+hidclientslm+"&hidrepairtype="+hidrepairtype+"&hidserviceadvisor="+hidserviceadvisor+"&sumtype=clt"); 
            
        }else if(x=="sm"){
            $("#overlay, #PleaseWait").show(); 
            $("#revenuereportdiv").load("summaryGrid.jsp?fromdate="+fromdate+"&todate="+todate+"&id=1"+"&hidclient="+hidclient+"&hidclientslm="+hidclientslm+"&hidrepairtype="+hidrepairtype+"&hidserviceadvisor="+hidserviceadvisor+"&sumtype=sm"); 
            
        }else if(x=="rt"){
            $("#overlay, #PleaseWait").show(); 
            $("#revenuereportdiv").load("summaryGrid.jsp?fromdate="+fromdate+"&todate="+todate+"&id=1"+"&hidclient="+hidclient+"&hidclientslm="+hidclientslm+"&hidrepairtype="+hidrepairtype+"&hidserviceadvisor="+hidserviceadvisor+"&sumtype=rt"); 
            
        }else if(x=="wsa"){
            $("#overlay, #PleaseWait").show(); 
            $("#revenuereportdiv").load("summaryGrid.jsp?fromdate="+fromdate+"&todate="+todate+"&id=1"+"&hidclient="+hidclient+"&hidclientslm="+hidclientslm+"&hidrepairtype="+hidrepairtype+"&hidserviceadvisor="+hidserviceadvisor+"&sumtype=wsa"); 
            
        }else if(x=="dly"){
            $("#overlay, #PleaseWait").show(); 
            $("#revenuereportdiv").load("summaryGrid.jsp?fromdate="+fromdate+"&todate="+todate+"&id=1"+"&hidclient="+hidclient+"&hidclientslm="+hidclientslm+"&hidrepairtype="+hidrepairtype+"&hidserviceadvisor="+hidserviceadvisor+"&sumtype=dly"); 
            
        }else if(x=="mly"){
            $("#overlay, #PleaseWait").show(); 
            $("#revenuereportdiv").load("summaryGrid.jsp?fromdate="+fromdate+"&todate="+todate+"&id=1"+"&hidclient="+hidclient+"&hidclientslm="+hidclientslm+"&hidrepairtype="+hidrepairtype+"&hidserviceadvisor="+hidserviceadvisor+"&sumtype=mly"); 
            
        }else if(x=="yly"){
            $("#overlay, #PleaseWait").show(); 
            $("#revenuereportdiv").load("summaryGrid.jsp?fromdate="+fromdate+"&todate="+todate+"&id=1"+"&hidclient="+hidclient+"&hidclientslm="+hidclientslm+"&hidrepairtype="+hidrepairtype+"&hidserviceadvisor="+hidserviceadvisor+"&sumtype=yly"); 
            
        }
    }
}
	
function setValues(){
    if($('#msg').val()!=""){
        $.messager.alert('Message',$('#msg').val());
    }
}

function setSearch(){
    var value=$('#searchby').val().trim();
    if(value=="client"){
        getClient();
    }
    else if(value=="clientslm"){
        getClientSalesman();
    }
    else if(value=="repairtype"){
        getRepairType();
    }
    else if(value=="wsa"){
        getServiceAdvisor();
    }
    else{}
}

function getClient(){
    clientSearchContent('clientSearch.jsp');
}

function getRepairType(){
    repairTypeSearchContent('repairTypeSearch.jsp?id=1');
}

function getServiceAdvisor(){
    serviceAdvisorSearchContent('serviceAdvisorSearchGrid.jsp?id=1');
}

function getClientSalesman(){
    salesmanSearchContent('clientSalesManSearch.jsp?id=2');
}

function clientSearchContent(url) {
    $('#clientToWindow').jqxWindow('open');
    $.get(url).done(function (data) {
        $('#clientToWindow').jqxWindow('setContent', data);
        $('#clientToWindow').jqxWindow('bringToFront');
    }); 
}

function salesmanSearchContent(url) {
    $('#salesmanSearchWindow').jqxWindow('open');
    $.get(url).done(function (data) {
        $('#salesmanSearchWindow').jqxWindow('setContent', data);
        $('#salesmanSearchWindow').jqxWindow('bringToFront');
    }); 
}

function repairTypeSearchContent(url) {
    $('#repairtypeSearchWindow').jqxWindow('open');
    $.get(url).done(function (data) {
        $('#repairtypeSearchWindow').jqxWindow('setContent', data);
        $('#repairtypeSearchWindow').jqxWindow('bringToFront');
    }); 
}

function serviceAdvisorSearchContent(url) {
    $('#serviceAdvisorSearchWindow').jqxWindow('open');
    $.get(url).done(function (data) {
        $('#serviceAdvisorSearchWindow').jqxWindow('setContent', data);
        $('#serviceAdvisorSearchWindow').jqxWindow('bringToFront');
    }); 
}

function setRemove(){
    var value=$('#searchby').val().trim();
    if(value=="client"){
        document.getElementById("searchdetails").value="";
        document.getElementById("client").value="";
        document.getElementById("hidclient").value="";
        if(document.getElementById("clientslm").value!=""){
               document.getElementById("searchdetails").value+=document.getElementById("clientslm").value; 
        } if(document.getElementById("repairtype").value!=""){
               document.getElementById("searchdetails").value+=document.getElementById("repairtype").value; 
        }
        if(document.getElementById("serviceadvisor").value!=""){
            document.getElementById("searchdetails").value+=document.getElementById("serviceadvisor").value; 
        }
    }  else if(value=="clientslm"){
        document.getElementById("searchdetails").value="";
        document.getElementById("clientslm").value="";
        document.getElementById("hidclientslm").value="";
        if(document.getElementById("client").value!=""){
               document.getElementById("searchdetails").value+=document.getElementById("client").value; 
        } if(document.getElementById("repairtype").value!=""){
               document.getElementById("searchdetails").value+=document.getElementById("repairtype").value; 
        } 
        if(document.getElementById("serviceadvisor").value!=""){
            document.getElementById("searchdetails").value+=document.getElementById("serviceadvisor").value; 
        }
    } else if(value=="repairtype"){
        document.getElementById("searchdetails").value="";
        document.getElementById("repairtype").value="";
        document.getElementById("hidrepairtype").value="";
        if(document.getElementById("client").value!=""){
               document.getElementById("searchdetails").value+=document.getElementById("client").value; 
        } if(document.getElementById("clientslm").value!=""){
               document.getElementById("searchdetails").value+=document.getElementById("clientslm").value; 
        } 
        if(document.getElementById("serviceadvisor").value!=""){
            document.getElementById("searchdetails").value+=document.getElementById("serviceadvisor").value; 
        }
    } else if(value=="wsa"){
        document.getElementById("searchdetails").value="";
        document.getElementById("serviceadvisor").value="";
        document.getElementById("hidserviceadvisor").value="";
        if(document.getElementById("client").value!=""){
               document.getElementById("searchdetails").value+=document.getElementById("client").value; 
        } if(document.getElementById("clientslm").value!=""){
               document.getElementById("searchdetails").value+=document.getElementById("clientslm").value; 
        } 
        if(document.getElementById("repairtype").value!=""){
               document.getElementById("searchdetails").value+=document.getElementById("repairtype").value; 
        }
    }
}
	
function funClearData(){
    $('input[type=text],[type=hidden]').val('');
    $('select').find('option').prop("selected", false);
    $('#fromdate').jqxDateTimeInput('setDate',new Date());
    $('#todate').jqxDateTimeInput('setDate',new Date());
    var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
    var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
    $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate);
    document.getElementById("searchdetails").value="";
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
    $("#rrDetailGrid").excelexportjs({
        containerid: "rrDetailGrid",
        datatype: 'json',
        dataset: null,
        gridId: "rrDetailGrid",
        columns: getColumns("rrDetailGrid"),
        worksheetName: "Revenue Report List"
    });
}

function JSONToCSVConvertor(JSONData, ReportTitle, ShowLabel) {
    var arrData = typeof JSONData != 'object' ? JSON.parse(JSONData) : JSONData;
    var CSV = '';    
    CSV += ReportTitle + '\r\n\n';

    if (ShowLabel) {
        var row = "";
        for (var index in arrData[0]) {
            row += index + ',';
        }
        row = row.slice(0, -1);
        CSV += row + '\r\n';
    }
    
    for (var i = 0; i < arrData.length; i++) {
        var row = "";
        for (var index in arrData[i]) {
            row += '"' + arrData[i][index] + '",';
        }
        row.slice(0, row.length - 1);
        CSV += row + '\r\n';
    }

    if (CSV == '') {        
        alert("Invalid data");
        return;
    }   
    
    var fileName = "";
    fileName += ReportTitle.replace(/ /g,"_");   
    var uri = 'data:text/csv;charset=utf-8,' + escape(CSV);
    var link = document.createElement("a");    
    link.href = uri;
    link.style = "visibility:hidden";
    link.download = fileName + ".csv";
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
}

function funAccwisePrint(){
    var url=document.URL;
    var reurl=url.split("revenueReport.jsp");
    var hidclient=document.getElementById("hidclient").value;
    var hidclientslm=document.getElementById("hidclientslm").value;
    var hidrepairtype=document.getElementById("hidrepairtype").value;
    var hidserviceadvisor=document.getElementById("hidserviceadvisor").value;
    var branch=document.getElementById("cmbbranch").value;
    var type=document.getElementById("cmbsummarytype").value;
    var win= window.open(reurl[0]+"../../../../com/dashboard/analysis/revenuereport/printRevenueReport?client="+hidclient+'&clientslm='+hidclientslm+'&repairtype='+hidrepairtype+'&hidserviceadvisor='+hidserviceadvisor+'&type='+type+'&branch='+branch+'&fromDate='+document.getElementById("fromdate").value+'&toDate='+$('#todate').val()+'&email=Nil&print=1',"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
    win.focus();
}

function funMnthwisePrint(){
    var url=document.URL;
    var reurl=url.split("revenueReport.jsp");
    var branch=document.getElementById("cmbbranch").value;
    var win= window.open(reurl[0]+"../../../../com/dashboard/analysis/revenuereport/RevenueReportmnthwise?branch="+branch+'&fromDate='+document.getElementById("fromdate").value+'&toDate='+$('#todate').val()+'&email=Nil&print=1',"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
    win.focus();
}

</script>

</head>
<body onload="getBranch();">
<form id="revenueReport" method="post">
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
                                <td class="label-cell">Report Type</td>
                                <td>
                                    <div class="radio-group">
                                        <label><input type="radio" id="rdall" name="rdo" onclick="summaryDisable();" value="rdall">Detail</label>
                                        <label><input type="radio" id="rdsummary" name="rdo" onclick="summaryDisable();" value="rdsummary">Summary</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="label-cell">Summary Type</td>
                                <td>
                                    <select id="cmbsummarytype" name="cmbsummarytype" value='<s:property value="cmbsummarytype"/>'>
                                        <option value="">--Select--</option>
                                        <option value="clt">Client</option>
                                        <option value="sm">Sales Man</option>
                                        <option value="rt">Repair Type</option>
                                        <!-- <option value="wsa">Service Advisor</option> -->
                                        <option value="dly">Daily</option>
                                        <option value="mly">Monthly</option>
                                        <option value="yly">Yearly</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td class="label-cell">Search By</td>
                                <td>
                                    <div class="search-by-group">
                                        <select name="searchby" id="searchby">
                                            <option value="">--Select--</option>
                                            <option value="client">Client</option>
                                            <option value="clientslm">Salesman</option>
                                            <option value="repairtype">Repair Type</option>
                                            <!-- <option value="wsa">Service Advisor</option> -->
                                        </select>
                                        <button type="button" name="btnadditem" id="additem" class="btn-icon" onClick="setSearch();">+</button>
                                        <button type="button" name="btnremoveitem" id="btnremoveitem" class="btn-icon" onclick="setRemove();">-</button>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" style="padding-top: 5px;">
                                    <textarea id="searchdetails" name="searchdetails" readonly="readonly"><s:property value="searchdetails"></s:property></textarea>
                                </td>
                            </tr>
                        </table>

                        <div class="release-actions">
                            <button type="button" name="btnclear" id="btnclear" class="btn-submit" onclick="funClearData();">Clear</button>
                            <button type="button" name="btnrepprint" id="btnrepprint" class="btn-submit" onclick="funAccwisePrint();" style="display:none;">Account Wise Print</button>
                        </div>
                        
                        <div class="release-actions" style="border-top: none; margin-top: 0; padding-top: 0;">
                            <button type="button" name="btnrepprint_mnth" id="btnrepprint_mnth" class="btn-submit" onclick="funMnthwisePrint();" style="display:none;">Month Wise Print</button>
                        </div>

                        <!-- Hidden Elements -->
                        <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
                        <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
                        <input type="hidden" name="client" id="client"><input type="hidden" name="hidclient" id="hidclient">
                        <input type="hidden" name="clientslm" id="clientslm"><input type="hidden" name="hidclientslm" id="hidclientslm">
                        <input type="hidden" name="repairtype" id="repairtype"><input type="hidden" name="hidrepairtype" id="hidrepairtype">
                        <input type="hidden" name="serviceadvisor" id="serviceadvisor"><input type="hidden" name="hidserviceadvisor" id="hidserviceadvisor">
                    </div>
                </div>
            </div>

            <!-- Main Grid / Data Section -->
            <div class="main-content-area">
                
                <div class="top-toolbar-container">
                    <jsp:include page="../../heading.jsp"></jsp:include>
                </div>

                <div class="grid-content-container">
                    <div id="revenuereportdiv"><jsp:include page="detailGrid.jsp"></jsp:include></div>
                </div>

            </div>

        </div>

        <!-- Modals -->
        <div id="clientToWindow">
            <div></div>
        </div>
        <div id="salesmanSearchWindow">
            <div></div>
        </div>	
        <div id="repairtypeSearchWindow">
            <div></div>
        </div>
        <div id="serviceAdvisorSearchWindow">
            <div></div>
        </div>
    </div>
</form>
</body>
</html>