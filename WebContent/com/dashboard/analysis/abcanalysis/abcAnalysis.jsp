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
.release-filter-table div[id^="fromdate"],
.release-filter-table div[id^="todate"] {
    width: 100% !important;
    height: 24px !important;
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
    background-color: #ffffff !important; 
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
		 $("#fromdate").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"dd.MM.yyyy"});
		 $("#todate").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"dd.MM.yyyy"});
		   
		 $('#clientSearchWindow').jqxWindow({ width: '62%', height: '65%',  maxHeight: '85%' ,maxWidth: '80%' , title: 'Client Search' ,position: { x: 250, y: 60 }, theme: 'energyblue', keyboardCloseKey: 27});
		 $('#clientSearchWindow').jqxWindow('close');
		 
		 $('#clientCategorySearchWindow').jqxWindow({ width: '50%',height: '60%',  maxHeight: '80%'  ,maxWidth: '50%' , title: 'Client Category Search' ,position: { x: 250, y: 60 }, theme: 'energyblue', keyboardCloseKey: 27});
		 $('#clientCategorySearchWindow').jqxWindow('close');
		
		 $('#salesmanSearchWindow').jqxWindow({ width: '50%',height: '60%',  maxHeight: '80%'  ,maxWidth: '50%' , title: 'Salesman Search' ,position: { x: 250, y: 60 }, theme: 'energyblue', keyboardCloseKey: 27});
		 $('#salesmanSearchWindow').jqxWindow('close');
		
		 $('#clientStatusSearchWindow').jqxWindow({ width: '50%',height: '60%',  maxHeight: '80%'  ,maxWidth: '50%' , title: 'Client Status Search' ,position: { x: 250, y: 60 }, theme: 'energyblue', keyboardCloseKey: 27});
		 $('#clientStatusSearchWindow').jqxWindow('close');
		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
		 
		 var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	   
	     document.getElementById("rdall").checked=true;
	});
	
	function funExportBtn(){
	    JSONToCSVConvertor(data, 'ClientAnalysis', true);
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
	
	function getGridColumnCalculation(fromdate,todate){
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText;
  				 items = items.split('***');
		          var difference=items[0];
		          var columns=items[1];
		          
		          if(parseInt(columns)==1) {
						$.messager.alert('Message','Period is too Long,Limit Reached.','warning');
						return;
		          }else {
		        	  var branchval = document.getElementById("cmbbranch").value;
		        	  var summarytype = $('#cmbsummarytype').val();
		        	  var hidclientcat=document.getElementById("hidclientcat").value;
		        	  var hidclient=document.getElementById("hidclient").value;
		        	  var hidclientslm=document.getElementById("hidclientslm").value;
					  var hidclientstatus=document.getElementById("hidclientstatus").value;
		        	  var check=1;
                      
		        	  $("#overlay, #PleaseWait").show();
		     		 
		        	  if(document.getElementById("rdall").checked==true){
		        	  		$("#analysisDiv").load("abcAnalysisGrid.jsp?rptType=1&branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&summarytype='+summarytype+"&hidclientcat="+hidclientcat+"&hidclient="+hidclient+"&hidclientslm="+hidclientslm+"&hidclientstatus="+hidclientstatus+'&check='+check);
		        	  }else if(document.getElementById("rdsummary").checked==true){
		        	  		$("#analysisDiv").load("abcAnalysisGrid.jsp?rptType=2&branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&summarytype='+summarytype+"&hidclientcat="+hidclientcat+"&hidclient="+hidclient+"&hidclientslm="+hidclientslm+"&hidclientstatus="+hidclientstatus+'&check='+check);
		        	  }
		          }
    		}
		}
		x.open("GET", "getGridColumnCalculation.jsp?fromdate="+fromdate+"&todate="+todate, true);
		x.send();
   }
	
	function summaryDisable(){
		if(document.getElementById("rdall").checked==true){
			$('#cmbsummarytype').attr('disabled', true);
		}else if(document.getElementById("rdsummary").checked==true){
			$('#cmbsummarytype').attr('disabled', false);
		}
	}
	
	function funreload(event){
		 var fromdate = $('#fromdate').val();
		 var todate = $('#todate').val();
		 
		 if(fromdate==todate) {
				$.messager.alert('Message','Not a Valid Period,From Date & To Date are Same.','warning');
				return;
         }
		 
		 if(document.getElementById("rdsummary").checked==true){
		 	if($('#cmbsummarytype').val()=='') {
				$.messager.alert('Message','Please Choose a Summary Type.','warning');
				return;
		 	}
         }
		 
		 getGridColumnCalculation(fromdate,todate);
	}
	
	function clientSearchContent(url) {
	    $('#clientSearchWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#clientSearchWindow').jqxWindow('setContent', data);
		$('#clientSearchWindow').jqxWindow('bringToFront');
	    }); 
	}
	
	function clientCategorySearchContent(url) {
	    $('#clientCategorySearchWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#clientCategorySearchWindow').jqxWindow('setContent', data);
		$('#clientCategorySearchWindow').jqxWindow('bringToFront');
	    }); 
	}
	
	function salesmanSearchContent(url) {
	    $('#salesmanSearchWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#salesmanSearchWindow').jqxWindow('setContent', data);
		$('#salesmanSearchWindow').jqxWindow('bringToFront');
	    }); 
	}
	
	function clientStatusSearchContent(url) {
	    $('#clientStatusSearchWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#clientStatusSearchWindow').jqxWindow('setContent', data);
		$('#clientStatusSearchWindow').jqxWindow('bringToFront');
	    }); 
	}
	
	function getClient(){
	 	 clientSearchContent('clientSearch.jsp');
	}

	function getClientCategory(){
		 clientCategorySearchContent('clientCategorySearch.jsp?id=1');
	}
	
	function getClientSalesman(){
		salesmanSearchContent('clientSalesManSearch.jsp?id=2');
	}

	function getClientStatus(){
		clientStatusSearchContent('clientStatusSearch.jsp?id=3');
	}
	
	function setSearch(){
		var value=$('#searchby').val().trim();
		if(value=="clientcat"){
			getClientCategory();
		}
		else if(value=="client"){
			getClient();
		}
		else if(value=="clientslm"){
			getClientSalesman();
		}
		else if(value=="clientstatus"){
			getClientStatus();
		}
	}
	
	function setRemove(){
		var value=$('#searchby').val().trim();
		
		if(value=="client"){
			document.getElementById("searchdetails").value="";
			document.getElementById("client").value="";
			document.getElementById("hidclient").value="";
			if(document.getElementById("clientcat").value!=""){
				   document.getElementById("searchdetails").value+=document.getElementById("clientcat").value; 
			} if(document.getElementById("clientslm").value!=""){
				   document.getElementById("searchdetails").value+=document.getElementById("clientslm").value; 
			} if(document.getElementById("clientstatus").value!=""){
				   document.getElementById("searchdetails").value+=document.getElementById("clientstatus").value; 
			}
		} else if(value=="clientcat"){
			document.getElementById("searchdetails").value="";
			document.getElementById("clientcat").value="";
			document.getElementById("hidclientcat").value="";
			if(document.getElementById("client").value!=""){
				   document.getElementById("searchdetails").value+=document.getElementById("client").value; 
			} if(document.getElementById("clientslm").value!=""){
				   document.getElementById("searchdetails").value+=document.getElementById("clientslm").value; 
			} if(document.getElementById("clientstatus").value!=""){
				   document.getElementById("searchdetails").value+=document.getElementById("clientstatus").value; 
			}
		} else if(value=="clientslm"){
			document.getElementById("searchdetails").value="";
			document.getElementById("clientslm").value="";
			document.getElementById("hidclientslm").value="";
			if(document.getElementById("client").value!=""){
				   document.getElementById("searchdetails").value+=document.getElementById("client").value; 
			} if(document.getElementById("clientcat").value!=""){
				   document.getElementById("searchdetails").value+=document.getElementById("clientcat").value; 
			} if(document.getElementById("clientstatus").value!=""){
				   document.getElementById("searchdetails").value+=document.getElementById("clientstatus").value; 
			}
		} else if(value=="clientstatus"){
			document.getElementById("searchdetails").value="";
			document.getElementById("clientstatus").value="";
			document.getElementById("hidclientstatus").value="";
			if(document.getElementById("client").value!=""){
				   document.getElementById("searchdetails").value+=document.getElementById("client").value; 
			} if(document.getElementById("clientcat").value!=""){
				   document.getElementById("searchdetails").value+=document.getElementById("clientcat").value; 
			} if(document.getElementById("clientslm").value!=""){
				   document.getElementById("searchdetails").value+=document.getElementById("clientslm").value; 
			} 
		}
	}
	
	function funClearData(){
		$('#cmbbranch').val('a');
   	    $('#fromdate').val(new Date());
   	    var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	    var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	    var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	    $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	     
		$('#todate').val(new Date());
		
		document.getElementById("rdall").checked=true;		
		document.getElementById("searchdetails").value="";document.getElementById("searchby").value="";document.getElementById("clientcat").value="";
		document.getElementById("hidclientcat").value="";document.getElementById("client").value="";document.getElementById("hidclient").value="";
		document.getElementById("clientslm").value="";document.getElementById("hidclientslm").value="";document.getElementById("clientstatus").value="";
		document.getElementById("hidclientstatus").value="";
		summaryDisable();
	}
	
</script>
</head>
<body onload="getBranch();summaryDisable();">
<div id="mainBG" class="homeContent" data-type="background"> 
    <div class="master-container">

        <!-- Sidebar / Filter Section -->
        <div class="sidebar-filters">
            <div class="sidebar-scroll-content">
                <div class="filter-card">
                    <table class="release-filter-table">
                        <tr>
                            <td class="label-cell">From</td>
                            <td><div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div></td>
                        </tr>
                        <tr>
                            <td class="label-cell">To</td>
                            <td><div id="todate" name="todate" value='<s:property value="todate"/>'></div></td>
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
                                <select id="cmbsummarytype" name="cmbsummarytype" onchange="clearAccountInfo();" value='<s:property value="cmbsummarytype"/>'>
                                    <option value="">--Select--</option>
                                    <option value="CRM">Client</option>
                                    <option value="CAT">Client Category</option>
                                    <option value="PCASE">Client Status</option>
                                    <option value="SLM">Salesman</option>
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
                                        <option value="clientcat">Client Category</option>
                                        <option value="clientstatus">Client Status</option>
                                        <option value="clientslm">Salesman</option>
                                    </select>
                                    <button type="button" name="btnadditem" id="additem" class="btn-icon" onClick="setSearch();">+</button>
                                    <button type="button" name="btnremoveitem" id="btnremoveitem" class="btn-icon" onclick="setRemove();">-</button>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="padding-top: 5px;">
                                <textarea id="searchdetails" name="searchdetails" readonly="readonly" style="height:140px;"><s:property value="searchdetails"></s:property></textarea>
                            </td>
                        </tr>
                    </table>

                    <div class="release-actions">
                        <button type="button" name="btnclear" id="btnclear" class="btn-submit" onclick="funClearData();">Clear</button>
                    </div>

                    <!-- Hidden Fields -->
                    <input type="hidden" name="client" id="client"><input type="hidden" name="hidclient" id="hidclient">
                    <input type="hidden" name="clientcat" id="clientcat"><input type="hidden" name="hidclientcat" id="hidclientcat">
                    <input type="hidden" name="clientstatus" id="clientstatus"><input type="hidden" name="hidclientstatus" id="hidclientstatus">
                    <input type="hidden" name="clientslm" id="clientslm"><input type="hidden" name="hidclientslm" id="hidclientslm">
                </div>
            </div>
        </div>

        <!-- Main Grid / Data Section -->
        <div class="main-content-area">
            
            <div class="top-toolbar-container">
                <jsp:include page="../../heading.jsp"></jsp:include>
            </div>

            <div class="grid-content-container">
                <div id="analysisDiv"><jsp:include page="abcAnalysisGrid.jsp"></jsp:include></div>
            </div>

        </div>

        <!-- Modals -->
        <div id="clientSearchWindow">
            <div></div><div></div>
        </div>
        <div id="clientCategorySearchWindow">
            <div></div><div></div>
        </div>
        <div id="salesmanSearchWindow">
            <div></div><div></div>
        </div>
        <div id="clientStatusSearchWindow">
            <div></div><div></div>
        </div>

    </div>
</div> 
</body>
</html>