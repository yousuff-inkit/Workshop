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
}

.master-container {
    display: flex;
    width: 100%;
    height: 100vh;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
}

/* ===== LEFT SIDEBAR ===== */
.sidebar-filters {
    width: 300px; 
    flex: 0 0 300px; 
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

/* Cards */
.filter-card {
    background: #f8fafc;
    border: 1px solid #e3e8ee;
    border-radius: 12px;
    padding: 15px;
    margin-bottom: 12px;
}

/* Tables */
.release-filter-table {
    width: 100%;
    border-spacing: 0 10px;
}

.release-filter-table .label-cell {
    text-align: right;
    padding-right: 10px;
    font-size: 12px;
    color: #4e5e71;
    font-weight: 600;
    width: 90px;
}

/* ===== UNIFORM INPUTS & SELECTS ===== */
input[type="text"], select, textarea,
.release-filter-table input[type="text"],
.release-filter-table select,
.release-filter-table textarea {
    width: 100%;
    height: 24px;             
    padding: 2px 8px;         
    border: 1px solid #ccd6e0;
    border-radius: 4px;       
    font-size: 12px;          
    background-color: #ffffff;
    box-sizing: border-box;
    color: #333;
}

.release-filter-table textarea {
    height: auto;
    resize: none;
}

/* Readonly / disabled look */
input[readonly],
input:disabled,
textarea[readonly],
.release-filter-table input[readonly],
.release-filter-table input:disabled,
.release-filter-table select:disabled {
    background-color: #f3f6f9 !important;
    color: #555;
    border-color: #e1e8ed;
}

/* jqx date/time containers */
.release-filter-table div[id^="fromdate"],
.release-filter-table div[id^="todate"] {
    width: 100% !important;
}

.radio-group {
    display: flex;
    gap: 15px;
    align-items: center;
    font-size: 12px;
    color: #333;
    padding: 2px 0;
}

.radio-group label {
    display: flex;
    align-items: center;
    cursor: pointer;
}
.radio-group input[type="radio"] {
    margin-right: 4px;
}

/* Add/Remove Item Input Group */
.search-by-group {
    display: flex;
    gap: 5px;
    align-items: center;
}
.search-by-group select {
    flex: 1;
}
.btn-icon {
    width: 24px;
    height: 24px;
    background: #e1e8ed;
    border: 1px solid #ccd6e0;
    border-radius: 4px;
    cursor: pointer;
    font-weight: bold;
    color: #333;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 14px;
    transition: background 0.2s;
}
.btn-icon:hover {
    background: #d0d7de;
}

/* ===== BUTTONS ===== */
.btn-submit {
    width: 100%;
    height: 30px;            
    padding: 0 12px;         
    background: #2563eb;
    color: #fff;
    border: none;
    border-radius: 4px;      
    font-size: 13px;
    font-weight: 600;
    cursor: pointer;
    line-height: 30px;       
    transition: background 0.2s;
}

.btn-submit:hover {
    background: #1d4ed8;
}

.btn-submit:disabled {
    background: #9ca3af;
    cursor: not-allowed;
}

/* Action buttons layout */
.release-secondary-actions, .release-actions {
    display: flex;
    gap: 10px;
    justify-content: center;
    margin-top: 15px;
}

.release-actions .btn-submit {
    min-width: 100px;
}

/* ===== RIGHT CONTENT AREA (Dynamically fills screen) ===== */
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
  //  alert(jcno+"  "+techid);
  
  
  
    if(document.getElementById("rdall").checked==true){
    	$("#overlay, #PleaseWait").show(); 
   	   	$("#revenuereportdiv").load("detailGrid.jsp?fromdate="+fromdate+"&todate="+todate+"&id=1"+"&hidclient="+hidclient+"&hidclientslm="+hidclientslm+"&hidrepairtype="+hidrepairtype+"&hidserviceadvisor="+hidserviceadvisor);
		
	}else if(document.getElementById("rdsummary").checked==true){

		 	if($('#cmbsummarytype').val()=='') {
				$.messager.alert('Message','Please Choose a Summary Type.','warning');
		 	}
	   	var x=$("#cmbsummarytype option:selected").val();
	   	if(x=="clt"){
	   		/* alert(x); */
	   		$("#overlay, #PleaseWait").show(); 
	   	   	$("#revenuereportdiv").load("summaryGrid.jsp?fromdate="+fromdate+"&todate="+todate+"&id=1"+"&hidclient="+hidclient+"&hidclientslm="+hidclientslm+"&hidrepairtype="+hidrepairtype+"&hidserviceadvisor="+hidserviceadvisor+"&sumtype=clt"); 
	   		
	   	}else if(x=="sm"){
	   		$("#overlay, #PleaseWait").show(); 
	   	   	$("#revenuereportdiv").load("summaryGrid.jsp?fromdate="+fromdate+"&todate="+todate+"&id=1"+"&hidclient="+hidclient+"&hidclientslm="+hidclientslm+"&hidrepairtype="+hidserviceadvisor+"&sumtype=sm"); 
	   		
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
		
		//JSONToCSVConvertor(rrexportdata, 'Revenue Report List', true);
		//alert("inside Export");
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
	    
	   // alert("arrData");
	    var CSV = '';    
	    //Set Report title in first row or line
	    
	    CSV += ReportTitle + '\r\n\n';

	    //This condition will generate the Label/Header
	    if (ShowLabel) {
	        var row = "";
	        
	        //This loop will extract the label from 1st index of on array
	        for (var index in arrData[0]) {
	            
	            //Now convert each value to string and comma-seprated
	            row += index + ',';
	        }

	        row = row.slice(0, -1);
	        
	        //append Label row with line break
	        CSV += row + '\r\n';
	    }
	    
	    //1st loop is to extract each row
	    for (var i = 0; i < arrData.length; i++) {
	        var row = "";
	        
	        //2nd loop will extract each column and convert it in string comma-seprated
	        for (var index in arrData[i]) {
	            row += '"' + arrData[i][index] + '",';
	        }

	        row.slice(0, row.length - 1);
	        
	        //add a line break after each row
	        CSV += row + '\r\n';
	    }

	    if (CSV == '') {        
	        alert("Invalid data");
	        return;
	    }   
	    
	    //Generate a file name
	    var fileName = "";
	    //this will remove the blank-spaces from the title and replace it with an underscore
	    fileName += ReportTitle.replace(/ /g,"_");   
	    
	    //Initialize file format you want csv or xls
	    var uri = 'data:text/csv;charset=utf-8,' + escape(CSV);
	    
	    // Now the little tricky part.
	    // you can use either>> window.open(uri);
	    // but this will not work in some browsers
	    // or you will not get the correct file extension    
	    
	    //this trick will generate a temp <a /> tag
	    var link = document.createElement("a");    
	    link.href = uri;
	    
	    //set the visibility hidden so it will not effect on your web-layout
	    link.style = "visibility:hidden";
	    link.download = fileName + ".csv";
	    
	    //this part will append the anchor tag and remove it after automatic click
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
        //alert(type);
        
       /*  $("#txtdocno").prop("disabled", false); */
        var win= window.open(reurl[0]+"../../../../com/dashboard/analysis/revenuereport/printRevenueReport?client="+hidclient+'&clientslm='+hidclientslm+'&repairtype='+hidrepairtype+'&hidserviceadvisor='+hidserviceadvisor+'&type='+type+'&branch='+branch+'&fromDate='+document.getElementById("fromdate").value+'&toDate='+$('#todate').val()+'&email=Nil&print=1',"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
        win.focus();
    
}
	
	function funMnthwisePrint(){
    	
        var url=document.URL;
        var reurl=url.split("revenueReport.jsp");
       
        var branch=document.getElementById("cmbbranch").value;
       
        /* $("#txtdocno").prop("disabled", false); */
        var win= window.open(reurl[0]+"../../../../com/dashboard/analysis/revenuereport/RevenueReportmnthwise?branch="+branch+'&fromDate='+document.getElementById("fromdate").value+'&toDate='+$('#todate').val()+'&email=Nil&print=1',"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
        win.focus();
    
}
	
	/* setValues(); */
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
                                        <option value="wsa">Service Advisor</option>
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
                                            <option value="wsa">Service Advisor</option>
                                        </select>
                                        <button type="button" name="btnadditem" id="additem" class="btn-icon" onClick="setSearch();">+</button>
                                        <button type="button" name="btnremoveitem" id="btnremoveitem" class="btn-icon" onclick="setRemove();">-</button>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <textarea id="searchdetails" name="searchdetails" readonly="readonly" style="height:100px;"><s:property value="searchdetails"></s:property></textarea>
                                </td>
                            </tr>
                        </table>

                        <div class="release-actions">
                            <button type="button" name="btnclear" id="btnclear" class="btn-submit" onclick="funClearData();">Clear</button>
                            <!-- <button type="button" name="btnrepprint" id="btnrepprint" class="btn-submit" onclick="funAccwisePrint();">Print</button> -->
                        </div>

                        <!-- Hidden elements logically retained -->
                        <div style="display:none; text-align:center;">
                            <button type="button" name="btnrepprint_mnth" id="btnrepprint_mnth" class="btn-submit" onclick="funMnthwisePrint();">Month Wise Print</button>
                        </div>
                        
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