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
.release-filter-table div[id^="uptodate"] {
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
		 $("#uptodate").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"dd.MM.yyyy"});
		 
		 $('#accountDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailsWindow').jqxWindow('close');
		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	  
	     document.getElementById("rdpayment").checked=true;
	     document.getElementById("rdall").checked=true;
	     
		 $('#txtaccid').dblclick(function(){
			 if($('#cmbtype').val()==''){
    			 $.messager.alert('Message','Please Choose Account Type.','warning');
    			 return 0;
    		 }
			  accountsSearchContent('accountsDetailsSearch.jsp');
			});

	});
	
	function accountsSearchContent(url) {
	    $('#accountDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#accountDetailsWindow').jqxWindow('setContent', data);
		$('#accountDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function getAccTypeFrom(event){
        var x= event.keyCode;
        if(x==114){
    		if($('#cmbtype').val()==''){
    			 $.messager.alert('Message','Please Choose Account Type.','warning');
    			 return 0;
    		 }
      		accountsSearchContent('accountsDetailsSearch.jsp');
        }
    }
	
	function clearAccountInfo(){
		$('#txtdocno').val('');$('#txtaccid').val('');$('#txtaccname').val('');
		
		if (document.getElementById("txtaccid").value == "") {
	        $('#txtaccid').attr('placeholder', 'Press F3 to Search'); 
	    }
	}
	
	function funClearInfo(){
	    $('#uptodate').val(new Date());
	    
		document.getElementById("rdpayment").checked=true;
		document.getElementById("rdall").checked=true;
		
		$('#cmbbranch').val('a');
	    $('#cmbtype').val('0');
		$('#txtdocno').val('');$('#txtaccid').val('');$('#txtaccname').val('');
		
		$("#pdcOutStandingGridID").jqxGrid('clear');
		$("#pdcOutStandingGridID").jqxGrid('addrow', null, {});
		
		if (document.getElementById("txtaccid").value == "") {
	        $('#txtaccid').attr('placeholder', 'Press F3 to Search'); 
	    }
	}

	function funreload(event){
        var branchval = document.getElementById("cmbbranch").value;
        var uptodate = $('#uptodate').val();
        var acctype = $('#cmbtype').val();
        var accno = $('#txtdocno').val();
        var reporttype = "";
        
        if(document.getElementById("rdall").checked==true){
            reporttype = $('#rdall').val();
        }else if(document.getElementById("rdpdc").checked==true){
            reporttype = $('#rdpdc').val();
        }else if(document.getElementById("rduncleared").checked==true){
            reporttype = $('#rduncleared').val();
        }
        
        $("#overlay, #PleaseWait").show();
        
        if(document.getElementById("rdreceipt").checked==true){
            $("#pdcOutStandingDiv").load("pdcOutStandingGrid.jsp?code=FRO&reporttype="+reporttype+'&branchval='+branchval+'&uptodate='+uptodate+'&acctype='+acctype+'&accno='+accno+'&check=1');								 
        } else {
            $("#pdcOutStandingDiv").load("pdcOutStandingGrid.jsp?code=FPP&reporttype="+reporttype+'&branchval='+branchval+'&uptodate='+uptodate+'&acctype='+acctype+'&accno='+accno+'&check=1');								 
        }
    }
	
	function funExportBtn(){
   		if(parseInt(window.parent.chkexportdata.value)=="1") {
   		  	JSONToCSVCon(data, 'PdcOutStanding', true);
   		} else {
   			 $("#pdcOutStandingGridID").jqxGrid('exportdata', 'xls', 'PdcOutStanding');
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
                            <td class="label-cell">Up To</td>
                            <td><div id="uptodate" name="uptodate" value='<s:property value="uptodate"/>'></div></td>
                        </tr>
                        <tr>
                            <td class="label-cell">Type</td>
                            <td>
                                <div class="radio-group">
                                    <label><input type="radio" id="rdall" name="rdos" value="rdall">All</label>
                                    <label><input type="radio" id="rdpdc" name="rdos" value="rdpdc">PDC</label>
                                    <label><input type="radio" id="rduncleared" name="rdos" value="rduncleared">Uncleared</label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="label-cell">Report Type</td>
                            <td>
                                <div class="radio-group">
                                    <label><input type="radio" id="rdpayment" name="rdo" value="FPP">Payment</label>
                                    <label><input type="radio" id="rdreceipt" name="rdo" value="FRO">Receipt</label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="label-cell">Account Type</td>
                            <td>
                                <select id="cmbtype" name="cmbtype" onchange="clearAccountInfo();" value='<s:property value="cmbtype"/>'>
                                    <option value="0">--Select--</option>
                                    <option value="BANK">Bank</option>
                                    <option value="AP">AP</option>
                                    <option value="AR">AR</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td class="label-cell">Account</td>
                            <td>
                                <input type="text" id="txtaccid" name="txtaccid" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtaccid"/>' onkeydown="getAccTypeFrom(event);"/>
                            </td>
                        </tr>
                        <tr>
                            <td class="label-cell"></td>
                            <td>
                                <input type="text" id="txtaccname" name="txtaccname" readonly="readonly" value='<s:property value="txtaccname"/>' tabindex="-1"/>
                                <input type="hidden" id="txtdocno" name="txtdocno" value='<s:property value="txtdocno"/>'/>
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
                <div id="pdcOutStandingDiv"><jsp:include page="pdcOutStandingGrid.jsp"></jsp:include></div>
            </div>

        </div>

        <!-- Modals -->
        <div id="accountDetailsWindow">
            <div></div><div></div>
        </div>
        
    </div> 
</div> 
</body>
</html>