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

/* Checkbox & Radio Buttons */
.checkbox-group {
    display: flex;
    gap: 12px;
    align-items: center;
    font-size: 12px !important;
    color: #333;
    height: 24px;
    flex-wrap: wrap;
}
.checkbox-group label {
    display: flex;
    align-items: center;
    cursor: pointer;
    margin: 0;
}
.checkbox-group input[type="checkbox"] {
    margin: 0 4px 0 0;
    padding: 0;
}

fieldset.radio-fieldset {
    border: 1px solid #e2e8f0;
    border-radius: 4px;
    padding: 10px;
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
    
	var selectedBox = null;
	
	$(document).ready(function () {
		 // Converted width to 100% and height to 24px
		 $("#fromdate").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"dd.MM.yyyy"});
		 $("#todate").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"dd.MM.yyyy"});
		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	     
		 var year = window.parent.txtaccountperiodfrom.value;
		 var newDate = year.split('-');
		 year = newDate[1] + "-" + newDate[0] + "-" + newDate[2];
		 $('#fromdate ').jqxDateTimeInput('setDate', new Date(year));
	     
 		 $(".chcklevels").click(function() {
 	        selectedBox = this.id;

 	        $(".chcklevels").each(function() {
 	            if ( this.id == selectedBox ) {
 	                this.checked = true;
 	               if ( this.id != "chcklevel4" ){  
 	               	 $('#btnprint').attr("disabled",true);
 	               }else{
 	               	 $('#btnprint').attr("disabled",false);
 	               } 
 	            }
 	            else {
 	                this.checked = false;
 	            };        
 	        });
 	    });    
 		 
		 document.getElementById("hidchcklevel4").value=1;
 		 document.getElementById("chcklevel4").checked = true;
 		 $('#btnprint').attr("disabled",true);
 		 getBalanceSheetPrintConfig();
	});
	
	function getBalanceSheetPrintConfig(){
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText;
  			    
  			  	if(parseInt(items)==1){
  				 	 $("#btnprint").show();
	  			 } else {
	  				 $("#btnprint").hide();
  				 }
  		    }
  		}
  		x.open("GET", "getBalanceSheetPrintConfig.jsp", true);
  		x.send();
    }
	
	function isNumber(evt) {
        var iKeyCode = (evt.which) ? evt.which : evt.keyCode
        if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57)) {
            $.messager.alert('Message',' Enter Numbers Only ','warning');    
            return false;
        }
        return true;
    }
	
	function analysischeck(){
		 if(document.getElementById("chckanalysis").checked){
			 document.getElementById("hidchckanalysis").value = 1;
			 $('#txtnoofdays').val("0");
 			 $('#txtfrequency').val("0");
		 }
		 else{
			 document.getElementById("hidchckanalysis").value = 0;
		 }
		 hidedata();
	 }
	
	function checklevel1(){
		if(document.getElementById("chcklevel1").checked){
			 document.getElementById("hidchcklevel1").value = 1;
			 document.getElementById("hidchcklevel2").value = 0;
			 document.getElementById("hidchcklevel3").value = 0;
			 document.getElementById("hidchcklevel4").value = 0;
		 }
		 else{
			 document.getElementById("hidchcklevel1").value = 0;
		 }
	 }
	
	function checklevel2(){
		 if(document.getElementById("chcklevel2").checked){
			 document.getElementById("hidchcklevel2").value = 1;
			 document.getElementById("hidchcklevel1").value = 0;
			 document.getElementById("hidchcklevel3").value = 0;
			 document.getElementById("hidchcklevel4").value = 0;
		 }
		 else{
			 document.getElementById("hidchcklevel2").value = 0;
		 }
	 }
	
	function checklevel3(){
		 if(document.getElementById("chcklevel3").checked){
			 document.getElementById("hidchcklevel3").value = 1;
			 document.getElementById("hidchcklevel1").value = 0;
			 document.getElementById("hidchcklevel2").value = 0;
			 document.getElementById("hidchcklevel4").value = 0;
		 }
		 else{
			 document.getElementById("hidchcklevel3").value = 0;
		 }
	 }
	
	function checklevel4(){
		 if(document.getElementById("chcklevel4").checked){
			 document.getElementById("hidchcklevel4").value = 1;
			 document.getElementById("hidchcklevel1").value = 0;
			 document.getElementById("hidchcklevel2").value = 0;
			 document.getElementById("hidchcklevel3").value = 0;
		 }
		 else{
			 document.getElementById("hidchcklevel4").value = 0;
		 }
	 }
	
	function hidedata(){
  		var analysis=$('#hidchckanalysis').val();
  		
  		if(parseInt(analysis)==1){
            $("#analysisDiv").prop("hidden", false);
            $("#viewDiv").attr("hidden", true);
  		}
        else{
            $("#analysisDiv").prop("hidden", true);
            $("#viewDiv").attr("hidden", false);
        }
  	}
	
	function funreload(event){
        var branchval = document.getElementById("cmbbranch").value;
        var fromdate = $('#fromdate').val();
        var todate = $('#todate').val();
        var level1 = $('#hidchcklevel1').val();
        var level2 = $('#hidchcklevel2').val();
        var level3 = $('#hidchcklevel3').val();
        var level4 = $('#hidchcklevel4').val();
        var check=1;
        var d = new Date();
        var entrydate = d.getTime();
        
        $("#entrydate").val(entrydate);     
        $("#overlay, #PleaseWait").show();
        
        if(document.getElementById("chcklevel4").checked){
            $('#btnprint').attr("disabled",true);
        }
        
        $("#balanceSheetDiv").load("balanceSheetGrid.jsp?branchval="+branchval+'&entrydate='+entrydate+'&fromdate='+fromdate+'&todate='+todate+'&level1='+level1+'&level2='+level2+'&level3='+level3+'&level4='+level4+'&check='+check);
	}
		
	function funExportBtn(){
        if(parseInt(window.parent.chkexportdata.value)=="1") {
            JSONToCSVCon(dataExcelExport, 'BalanceSheet', true);
        } else {
            $("#balanceSheetGrid").jqxTreeGrid('exportData', 'xls');
        }
    }
		
	function funPrintTForm(){
        var url=document.URL;
        var reurl=url.split("balanceSheet.jsp");

        var fromdate = $('#fromdate').jqxDateTimeInput('val');    
        var todate = $('#todate').jqxDateTimeInput('val');
        
        var win= window.open(reurl[0]+"printTFormbranch?branch="+document.getElementById("cmbbranch").value+'&fromdate='+fromdate+'&todate='+todate,"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
        win.focus();
    }
		
	function funPrint(){
        var entrydate = $('#entrydate').val();
        if(document.getElementById("chcklevel4").checked){
            var branchval = document.getElementById("cmbbranch").value;  
            var fromdate = $('#fromdate').val();
            var todate = $('#todate').val();
            
            var url=document.URL;
            var reurl=url.split("com/");
            var path= "balancesheetlist2branch.action?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&entrydate='+entrydate;
            var win= window.open(reurl[0]+path,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");		
            win.focus();		
        }
        else {
            var branchval = document.getElementById("cmbbranch").value;
            var fromdate = $('#fromdate').val();
            var todate = $('#todate').val();
            
            var url=document.URL;
            var reurl=url.split("com");  
            var path= "balancesheetlistbranch.action?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&entrydate='+entrydate;
            var win= window.open(reurl[0]+path,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");		
            win.focus();
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
                                <td class="label-cell">Period</td>
                                <td>
                                    <div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div>
                                </td>
                            </tr>
                        </table>
                    </div>

                    <div id="viewDiv">
                        <div class="filter-card">
                            <table class="release-filter-table">
                                <tr>
                                    <td class="label-cell">To</td>
                                    <td>
                                        <div id="todate" name="todate" value='<s:property value="todate"/>'></div>
                                    </td>
                                </tr>
                            </table>

                            <fieldset class="radio-fieldset" style="margin-top: 15px;">
                                <legend>Levels</legend>
                                <div class="checkbox-group">
                                    <label>
                                        <input type="checkbox" id="chcklevel1" name="chcklevel1" class="chcklevels" value="" onchange="checklevel1();" onclick="$(this).attr('value', this.checked ? 1 : 0)">
                                        Level 1
                                    </label>
                                    <input type="hidden" id="hidchcklevel1" name="hidchcklevel1" value='<s:property value="hidchcklevel1"/>'/>
                                </div>
                                <div class="checkbox-group">
                                    <label>
                                        <input type="checkbox" id="chcklevel2" name="chcklevel2" class="chcklevels" value="" onchange="checklevel2();" onclick="$(this).attr('value', this.checked ? 1 : 0)">
                                        Level 2
                                    </label>
                                    <input type="hidden" id="hidchcklevel2" name="hidchcklevel2" value='<s:property value="hidchcklevel2"/>'/>
                                </div>
                                <div class="checkbox-group">
                                    <label>
                                        <input type="checkbox" id="chcklevel3" name="chcklevel3" class="chcklevels" value="" onchange="checklevel3();" onclick="$(this).attr('value', this.checked ? 1 : 0)">
                                        Level 3
                                    </label>
                                    <input type="hidden" id="hidchcklevel3" name="hidchcklevel3" value='<s:property value="hidchcklevel3"/>'/>
                                </div>
                                <div class="checkbox-group">
                                    <label>
                                        <input type="checkbox" id="chcklevel4" name="chcklevel4" class="chcklevels" value="" onchange="checklevel4();" onclick="$(this).attr('value', this.checked ? 1 : 0)">
                                        Level 4
                                    </label>
                                    <input type="hidden" id="hidchcklevel4" name="hidchcklevel4" value='<s:property value="hidchcklevel4"/>'/>
                                </div>
                            </fieldset>

                            <div class="release-actions">
                                <button type="button" class="btn-submit" id="btnprint" onclick="funPrint();">Print</button>
                            </div>
                        </div>
                    </div>

                    <!-- Hidden Analysis div preserved for logical state requirements -->
                    <div id="analysisDiv" hidden="true">
                        <div class="filter-card">
                            <table class="release-filter-table">
                                <tr>
                                    <td>
                                        <div style="display:flex; gap:8px;">
                                            <select id="cmbchoose" name="cmbchoose" style="flex:1;" value='<s:property value="cmbchoose"/>'>
                                                <option value="1">Days</option>
                                                <option value="2">Monthly</option>
                                                <option value="3">Quarterly</option>
                                                <option value="4">Yearly</option>
                                            </select>
                                            <input type="text" id="txtnoofdays" name="txtnoofdays" style="flex:1;" value='<s:property value="txtnoofdays"/>'/>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <div style="display:flex; align-items:center; gap:8px; margin-top:8px;">
                                            <label class="label-cell" style="width: auto;">Frequency</label>
                                            <input type="text" id="txtfrequency" name="txtfrequency" style="flex:1;" value='<s:property value="txtfrequency"/>'/>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>

                    <!-- Hidden Field -->
                    <input type="hidden" id="entrydate" name="entrydate"/>
                </div>
            </div>

            <!-- Main Grid / Data Section -->
            <div class="main-content-area">
                
                <div class="top-toolbar-container">
                    <jsp:include page="../../heading.jsp"></jsp:include>
                </div>

                <div class="grid-content-container">
                    
                    <div id="balanceSheetDiv" style="flex: 1; display: flex; flex-direction: column;">
                        <jsp:include page="balanceSheetGrid.jsp"></jsp:include>
                    </div>

                </div>

            </div>

        </div>
    </div> 
</body>
</html>