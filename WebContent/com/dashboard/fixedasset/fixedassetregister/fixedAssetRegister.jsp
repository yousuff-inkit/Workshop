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

/* Radio buttons layout */
.radio-group {
    display: flex;
    gap: 12px;
    align-items: center;
    font-size: 12px !important;
    color: #333;
    height: auto;
    flex-wrap: wrap;
    padding: 4px 0;
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
		// Converted to 100% width and 24px height for Master UI alignment
		$("#fromdate").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"dd.MM.yyyy"});
		$("#todate").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"dd.MM.yyyy"});
		 
		$('#assetDetailsWindow').jqxWindow({width: '30%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Asset Search',position: { x: 250, y: 120 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		$('#assetDetailsWindow').jqxWindow('close');
	     
		$('#groupDetailsWindow').jqxWindow({width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Group Search',position: { x: 250, y: 120 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	    $('#groupDetailsWindow').jqxWindow('close');
	     
		$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
		 
		var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	    var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	    var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	    $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	     
		$('#txtasset').dblclick(function(){
		    assetSearchContent('assetSearchGrid.jsp?check=1');
		});
		  
		$('#txtgroup').dblclick(function(){
		    groupSearchContent('groupSearchGrid.jsp?check=1');
		});
			
	    document.getElementById("rdall").checked=true;
	     
	});
	
	function funExportBtn(){
	    JSONToCSVConvertor(dataExcelExport, 'FixedAssetRegister', true);
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

	function assetSearchContent(url) {
	    $('#assetDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		    $('#assetDetailsWindow').jqxWindow('setContent', data);
		    $('#assetDetailsWindow').jqxWindow('bringToFront');
	    }); 
	}
	
	function groupSearchContent(url) {
	    $('#groupDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		    $('#groupDetailsWindow').jqxWindow('setContent', data);
		    $('#groupDetailsWindow').jqxWindow('bringToFront');
	    }); 
	}
	
	function getAsset(event){
        var x= event.keyCode;
        if(x==114){
        	assetSearchContent('assetSearchGrid.jsp?check=1');
        }
    }
	
	function getGroup(event){
        var x= event.keyCode;
        if(x==114){
        	groupSearchContent('groupSearchGrid.jsp?check=1');
        }
    }

	function funreload(event){
		 var branchval = document.getElementById("cmbbranch").value;
		 var fromdate = $('#fromdate').val();
		 var todate = $('#todate').val();
		 var assetno = $('#txtasset').val();
		 var group = $('#txtgroupno').val();
		 var check=1;
		 
		 $("#overlay, #PleaseWait").show();
		 
		 if(document.getElementById("rdall").checked==true){
			 $("#assetDiv").load("fixedAssetRegisterGrid.jsp?rpttype=1&branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&assetno='+assetno+'&group='+group+'&check='+check);
		 	
		 }else if(document.getElementById("rdsold").checked==true){
			 $("#assetDiv").load("fixedAssetRegisterGrid.jsp?rpttype=2&branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&assetno='+assetno+'&group='+group+'&check='+check);
			 
		 }else{
			 $("#assetDiv").load("fixedAssetRegisterGrid.jsp?rpttype=3&branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&assetno='+assetno+'&group='+group+'&check='+check);
		   }
    }
	
	function funClearInfo(){
		$('#fromdate').val(new Date());
		var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');;
	    var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	    var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	    $('#fromdate').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	     
	    $('#todate').val(new Date());
	    
		document.getElementById("txtasset").value="";
		document.getElementById("txtgroup").value="";
		document.getElementById("txtgroupno").value="";
		
		document.getElementById("rdall").checked=true;
		
		if (document.getElementById("txtgroup").value == "") {
		    $('#txtgroup').attr('placeholder', 'Press F3 to Search'); 
		}
		if (document.getElementById("txtasset").value == "") {
		    $('#txtasset').attr('placeholder', 'Press F3 to Search'); 
		}
	}

</script>
</head>
<body onload="getBranch();">
    <div id="mainBG" class="homeContent" data-type="background"> 
        <div class="master-container">

            <!-- Sidebar / Filter Section -->
            <div class="sidebar-filters">
                <div class="sidebar-scroll-content">
                    <div class="filter-card">
                        <table class="release-filter-table">
                            <tr>
                                <td class="label-cell">From Date</td>
                                <td><div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div></td>
                            </tr>
                            <tr>
                                <td class="label-cell">To Date</td>
                                <td><div id="todate" name="todate" value='<s:property value="todate"/>'></div></td>
                            </tr>
                            <tr>
                                <td class="label-cell">Asset</td>
                                <td>
                                    <input type="text" id="txtasset" name="txtasset" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtasset"/>' onkeydown="getAsset(event);"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="label-cell">Group</td>
                                <td>
                                    <input type="text" id="txtgroup" name="txtgroup" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtgroup"/>' onkeydown="getGroup(event);"/>
                                    <input type="hidden" id="txtgroupno" name="txtgroupno" value='<s:property value="txtgroupno"/>'/>
                                </td>
                            </tr>
                            <tr>
                                <td class="label-cell">Report Type</td>
                                <td>
                                    <div class="radio-group">
                                        <label><input type="radio" id="rdall" name="rdo" value="rdall">All</label>
                                        <label><input type="radio" id="rdsold" name="rdo" value="rdsold">Sold</label>
                                        <label><input type="radio" id="rdadditions" name="rdo" value="rdadditions">Additions</label>
                                    </div>
                                </td>
                            </tr>
                        </table>

                        <div class="release-actions">
                            <button type="button" class="btn-submit" name="clear" id="clear" onclick="funClearInfo();">Clear</button>
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
                    <div id="assetDiv"><jsp:include page="fixedAssetRegisterGrid.jsp"></jsp:include></div>
                </div>

            </div>

        </div>

        <!-- Modals -->
        <div id="assetDetailsWindow">
            <div></div><div></div>
        </div>
        <div id="groupDetailsWindow">
            <div></div><div></div>
        </div>

    </div>
</body>
</html>