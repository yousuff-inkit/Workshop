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
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 
<style>
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

/* Specific styling for export or alternate buttons if needed */
.btn-export {
    background: #10b981; 
}
.btn-export:hover {
    background: #059669;
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
    gap: 15px;
}

/* For labels in the content area */
#user {
    font-weight: 600;
    font-size: 14px;
    color: #3b82f6;
    margin-bottom: 8px;
    display: inline-block;
}

/* Subgrid Container specifically for this page */
.subgrid-container {
    margin-top: 15px;
    border-top: 1px solid #e2e8f0;
    padding-top: 15px;
}
</style>

<script type="text/javascript">

$(document).ready(function () {
	 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	
     $('#clientwindow').jqxWindow({ width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Client Search'  , theme: 'energyblue', position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	 $('#clientwindow').jqxWindow('close');
	  
	 $("#cmbbranch").attr('hidden',true); 
     
     // Adjusted to 100% width and 24px height for modern layout
	 $("#fromdate").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"dd.MM.yyyy"});
	 $("#todate").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"dd.MM.yyyy"});
	 
     var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
	 var onemounth=new Date(new Date(fromdates).setMonth(fromdates.getMonth()-1)); 
	  
     $('#fromdate').jqxDateTimeInput('setDate', new Date(onemounth));
	 $('#todate').on('change', function (event) {
		   var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		 	 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); 
		   if(fromdates>todates){
			   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
		       return false;
		  }   
	 });
	 
	 $('#clientname').dblclick(function(){
		   $('#clientwindow').jqxWindow('open');
		   clientSearchContent('clientsearch.jsp', $('#clientwindow')); 
	 });
	 
});

function funreload(event)
{
	var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
	var todates=new Date($('#todate').jqxDateTimeInput('getDate')); 
	 	 
	if(fromdates>todates){
		$.messager.alert('Message','To Date Less Than From Date  ','warning');   
	    return false;
	} 
	else {
        var fromdate= $("#fromdate").val();
        var todate= $("#todate").val(); 
        var cldocno=$("#cldocno").val();
        var test ="10"; 

        $("#Readygrid").load("subgrid.jsp?test="+test+"&from="+fromdate+"&to="+todate+"&cldocno="+cldocno+'&check=1');
    }
}
	
function hiddenbrh(){
	$("#branchlabel").attr('hidden',true);
	$("#branchdiv").attr('hidden',true);
}

function getclinfo(event){
	var x= event.keyCode;
	if(x==114){
 		$('#clientwindow').jqxWindow('open');
		clientSearchContent('clientsearch.jsp', $('#clientwindow'));    
    }
} 

function clientSearchContent(url) {
	$.get(url).done(function (data) {
		$('#clientwindow').jqxWindow('open');
		$('#clientwindow').jqxWindow('setContent', data);
    }); 
} 
	
function funExportBtn(){
	JSONToCSVConvertor(clientexceldata, 'Client Followup Log List', true);
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

function funcleardata() {
    $("#userdetails").jqxGrid('clear');
    $("#userdetails").jqxGrid('addrow', null, {});
    document.getElementById("cldocno").value="";
    document.getElementById("clientname").value="";
    
    if (document.getElementById("clientname").value == "") {
        $('#clientname').attr('placeholder', 'Press F3 TO Search'); 
    }
}

function funPrint() {
    var client=$('#clientname').val();
    if(client==''){
        $.messager.alert('Message','Please Select a Client.','warning');
        return 0;
    }
            
    if ($("#cldocno").val()!="") {
        var url=document.URL;
        var reurl=url.split("clientfollowuplog.jsp");
        var win= window.open(reurl[0]+"printclientfollowup?&cldocno="+document.getElementById("cldocno").value+'&fromdate='+$("#fromdate").val()+'&todate='+$("#todate").val(),"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
        win.focus();
    }
    else {
        $.messager.alert('Message','Please Select a Client.','warning');
        return;
    }
}
	  
</script>
</head>
<body onload="getBranch();hiddenbrh()">
    <div id="mainBG" class="homeContent" data-type="background"> 
        <div class="master-container">

            <!-- Sidebar / Filter Section -->
            <div class="sidebar-filters">
                <div class="sidebar-scroll-content">
                    <div class="filter-card">
                        <table class="release-filter-table">
                            <tr>
                                <td class="label-cell">From</td>
                                <td>
                                    <div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div>
                                </td>
                            </tr>
                            <tr>
                                <td class="label-cell">To</td>
                                <td>
                                    <div id="todate" name="todate" value='<s:property value="todate"/>'></div>
                                </td>
                            </tr>
                            <tr>
                                <td class="label-cell">Client</td>
                                <td>
                                    <input type="text" name="clientname" id="clientname" placeholder="Press F3 To Search" readonly="readonly" onKeyDown="getclinfo(event);" onclick="this.placeholder=''" value='<s:property value="clientname"/>'>
                                    <!-- Hidden field logical grouping -->
                                    <input type="hidden" name="cldocno" id="cldocno" value='<s:property value="cldocno"/>'>
                                </td>
                            </tr>
                        </table>

                        <div class="release-actions">
                            <button type="button" class="btn-submit" name="clear" id="clear" onclick="funcleardata()">Clear</button>
                            <button type="button" class="btn-submit" name="btnPrint" id="btnPrint" onclick="funPrint();">Print</button>
                        </div>

                        <!-- Subgrid container moved inside sidebar for layout consistency (optional depending on use case, but fits the structure nicely) -->
                        <div class="subgrid-container">
                            <div id="Readygrid"><jsp:include page="subgrid.jsp"></jsp:include></div>
                        </div>

                    </div>
                </div>
            </div>

            <!-- Main Grid / Data Section -->
            <div class="main-content-area">
                
                <div class="top-toolbar-container">
                    <jsp:include page="../../heading.jsp"></jsp:include>
                </div>

                <div class="grid-content-container">
                    
                    <div><label name="user" id="user"></label></div>
                    
                    <div id="fleetdiv" style="flex: 1; display: flex; flex-direction: column;">
                        <jsp:include page="detailsgrid.jsp"></jsp:include>
                    </div>

                    <!-- Hidden charts div preserved -->
                    <div>
                        <!-- <table width="100%" id="chart">
                            <tr>
                                <td width="50%">
                                <div id='fleetStatus1' style="width: 100%; height: 250px;"></div>
                                <div id='sec1' style="width: 100%; height: 250px;"></div>
                                </td><td>  <div id='thr1' style="width: 100%; height: 250px;"></div>
                                <div id='four1' style="width: 100%; height: 250px;"></div></td></tr>
                        </table> -->
                    </div>

                </div>

            </div>

        </div>

        <!-- Modals -->
        <div id="clientwindow">
            <div></div>
        </div>

    </div>
</body>
</html>