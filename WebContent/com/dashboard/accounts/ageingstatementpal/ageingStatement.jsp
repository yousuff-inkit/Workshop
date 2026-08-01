<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<script type="text/javascript" src="<%=contextPath%>/js/ajaxfileupload.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/resample.js"></script>

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
    width: 320px; /* Slightly wider for the level range inputs */
    flex: 0 0 320px; 
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
.release-filter-table div[id^="uptodate"] {
    width: 100% !important;
    height: 24px !important;
}

/* Range Inputs Layout */
.range-container {
    display: flex;
    align-items: center;
    gap: 6px;
}
.range-container input {
    text-align: center;
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
    gap: 8px;
}

.btn-submit:hover {
    background: #1d4ed8;
}

.btn-submit:disabled {
    background: #9ca3af;
    cursor: not-allowed;
}

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
}

.net-total-container {
    text-align: right;
    margin-top: 15px;
    padding: 10px 0;
    font-size: 12px;
    font-weight: bold;
    color: #1e293b;
    display: flex;
    justify-content: flex-end;
    align-items: center;
    gap: 10px;
}

.net-total-container input {
    width: 150px !important;
    text-align: right;
    font-weight: bold;
    color: #0f172a !important;
    background-color: #f1f5f9 !important;
}

#tabledata {
	display: none;
}
</style>

<script type="text/javascript">

	$(document).ready(function () {
         // Adapted width to 100% and height to 24px for Master UI
		 $("#uptodate").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"dd.MM.yyyy"});
		 
		 $('#accountDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailsWindow').jqxWindow('close');
		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
		 
		 $('#txtaccid').dblclick(function(){
		      if($('#cmbtype').val()==''){
    			 $.messager.alert('Message','Please Choose Account Type.','warning');
    			 return 0;
    		  }
			  accountsSearchContent('accountsDetailsSearch.jsp');
		 });
		
	});
	
	function funExportBtn(){
		$("#ageingStatementDiv").excelexportjs({
			containerid: "ageingStatementDiv",
			datatype: 'json', 
			dataset: null, 
			gridId: "ageingStatement", 
			columns: getColumns("ageingStatement") , 
			worksheetName: "Ageing Statement"
		});
	}
	
	function funOutExcelBtn(){
	    var accno = $('#txtacountno').val();
		if(accno==''){
			 $.messager.alert('Message','Please Choose a Client/Supplier.','warning');
			 return 0;
		 }
		 $("#overlay, #PleaseWait").show();
			var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
					var items = x.responseText;
					items = items.split('####');
					JSONToCSVConvertor(items[0], 'OutStanding Statement', true);
					$("#overlay, #PleaseWait").hide();
			    }
			}
			x.open("GET", 'getOutstanding.jsp?&acno='+document.getElementById("txtacountno").value+'&atype='+document.getElementById("cmbtype").value+'&branch='+document.getElementById("cmbbranch").value+'&uptoDate='+$("#uptodate").val(), true);
			x.send();
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
	
	function accountsSearchContent(url) {
	    $('#accountDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#accountDetailsWindow').jqxWindow('setContent', data);
		$('#accountDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function getSalesPerson() {
		 if(document.getElementById("lbldetailname").innerText=="Current Ageing"){
			$('#uptodate').jqxDateTimeInput({disabled: true});
		 }
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var salesagentItems = items[0].split(",");
				var salesagentIdItems = items[1].split(",");
				var optionssalesagent = '<option value="">--Select--</option>';
				for (var i = 0; i < salesagentItems.length; i++) {
					optionssalesagent += '<option value="' + salesagentIdItems[i] + '">'
							+ salesagentItems[i] + '</option>';
				}
				$("select#cmbsalesperson").html(optionssalesagent);
				if ($('#hidcmbsalesperson').val() != null) {
					$('#cmbsalesperson').val($('#hidcmbsalesperson').val());
				}
			}
		}
		x.open("GET", "getSalesPerson.jsp", true);
		x.send();
	}
  
    function getCategory() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var categoryItems = items[0].split(",");
				var categoryIdItems = items[1].split(",");
				var optionscategory = '<option value="">--Select--</option>';
				for (var i = 0; i < categoryItems.length; i++) {
					optionscategory += '<option value="' + categoryIdItems[i] + '">'
							+ categoryItems[i] + '</option>';
				}
				$("select#cmbcategory").html(optionscategory);
				if ($('#hidcmbcategory').val() != null) {
					$('#cmbcategory').val($('#hidcmbcategory').val());
				}
			}
		}
		x.open("GET", "getCategory.jsp?type="+$('#cmbtype').val(), true);
		x.send();
	}
	
	function changelevel1(){ 
	   var level1to=$('#txtlevel1to').val();
	   var level2to=$('#txtlevel2to').val();
	   var level1from=$('#txtlevel1from').val();
	   if(level2to!=""){
	       if(parseInt(level1to)>parseInt(level2to) || parseInt(level1to)<parseInt(level1from)){
			 $.messager.alert('Message','Not a Valid Range.','warning');
			 $('#txtlevel1to').val('');
			 return 0;
		   }
	   }
	   
	   if(level1to!=""){
		   $('#txtlevel2from').val(parseInt(level1to)+1);
	   } else {
		   $('#txtlevel2from').val('');
	   }
	}
	
	function changelevel2(){
		 var level2to=$('#txtlevel2to').val();
		 var level3to=$('#txtlevel3to').val();
		 var level2from=$('#txtlevel2from').val();
		 if(level3to!=""){
		     if(parseInt(level2to)>parseInt(level3to) || parseInt(level2to)<parseInt(level2from)){
				$.messager.alert('Message','Not a Valid Range.','warning');
				$('#txtlevel2to').val('');
				return 0;
			 }
		 }
		 
		 if(level2to!=""){
			 $('#txtlevel3from').val(parseInt(level2to)+1);
		 } else {
			 $('#txtlevel3from').val('');
		 } 
	}
	
	function changelevel3(){
		var level3to=$('#txtlevel3to').val();
		var level4to=$('#txtlevel4to').val();
		var level3from=$('#txtlevel3from').val();
		if(level4to!=""){
		    if(parseInt(level3to)>parseInt(level4to) || parseInt(level3to)<parseInt(level3from)){
				$.messager.alert('Message','Not a Valid Range.','warning');
				$('#txtlevel3to').val('');
				return 0;
			 }
		}
		 
		if(level3to!=""){
			$('#txtlevel4from').val(parseInt(level3to)+1);
		} else {
			$('#txtlevel4from').val('');
		} 
	}
	
	function changelevel4(){
		var level4to=$('#txtlevel4to').val();
		var level4from=$('#txtlevel4from').val();
		if(level4to!=""){
		    if(parseInt(level4to)<parseInt(level4from)){
				$.messager.alert('Message','Not a Valid Range.','warning');
				$('#txtlevel4to').val('');
				return 0;
			 }
		}
		
		if(level4to!=""){
			$('#txtlevel5from').val(parseInt(level4to)+1);
		} else {
			$('#txtlevel5from').val('');
		} 
	}
	
	function getAccType(event){
        var x= event.keyCode;
        if(x==114){
		    if($('#cmbtype').val()==''){
    		    $.messager.alert('Message','Please Choose Account Type.','warning');
    		    return 0;
    	    }
      	    accountsSearchContent('accountsDetailsSearch.jsp');
        }
    }
	
	function funOutStandingStatement(){
		 var accno = $('#txtacountno').val();
		 var level1from = $('#txtlevel1from').val();
		 var level1to = $('#txtlevel1to').val();
		 var level2from = $('#txtlevel2from').val();
		 var level2to = $('#txtlevel2to').val();
		 var level3from = $('#txtlevel3from').val();
		 var level3to = $('#txtlevel3to').val();
		 var level4from = $('#txtlevel4from').val();
		 var level4to = $('#txtlevel4to').val();
		 var level5from = $('#txtlevel5from').val();
		 
		 if(accno==''){
			 $.messager.alert('Message','Please Choose a Client/Supplier.','warning');
			 return 0;
		 }
		
  	     if ($("#txtacountno").val()!="") {
	        var url=document.URL;
	        var reurl=url.split("ageingStatement.jsp");
	        console.log("ac print");   
	        $("#txtacountno").prop("disabled", false);
	        var win= window.open(reurl[0]+"printAgeingOutstandingsStatementpal?&acno="+document.getElementById("txtacountno").value+'&atype='+document.getElementById("cmbtype").value+'&level1from='+level1from+'&level1to='+level1to+'&level2from='+level2from+'&level2to='+level2to+'&level3from='+level3from+'&level3to='+level3to+'&level4from='+level4from+'&level4to='+level4to+'&level5from='+level5from+'&branch='+document.getElementById("cmbbranch").value+'&uptoDate='+$("#uptodate").val()+'&email=Nil&print=1',"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
	        win.focus();
			funGetOutstandingTable();  
	     }
	    else {
	    	$.messager.alert('Message','Please Choose a Client/Supplier.','warning');
			return;
		}
	}
	
	function funageingprint(){
		 var accno = $('#txtacountno').val();
		 var salesperson = $('#cmbsalesperson').val();
		 var category = $('#cmbcategory').val();
		 var clientstatus = $('#cmbclientstatus').val();
		 var level1from = $('#txtlevel1from').val();
		 var level1to = $('#txtlevel1to').val();
		 var level2from = $('#txtlevel2from').val();
		 var level2to = $('#txtlevel2to').val();
		 var level3from = $('#txtlevel3from').val();
		 var level3to = $('#txtlevel3to').val();
		 var level4from = $('#txtlevel4from').val();
		 var level4to = $('#txtlevel4to').val();
		 var level5from = $('#txtlevel5from').val();
		 var atype = $('#cmbtype').val();
		 if(atype==''){
			 $.messager.alert('Message','Please Choose Account Type.','warning');
			 return 0;
		 } 
		
 	     if ($("#atype").val()!="") {  
	        var url=document.URL;
	        var reurl=url.split("ageingStatement.jsp");  
	        console.log("ac print");   
	        $("#txtacountno").prop("disabled", false);
	        var win= window.open(reurl[0]+"printAgeingStatementpal?&acno="+document.getElementById("txtacountno").value+'&atype='+document.getElementById("cmbtype").value+'&level1from='+level1from+'&level1to='+level1to+'&level2from='+level2from+'&level2to='+level2to+'&level3from='+level3from+'&level3to='+level3to+'&level4from='+level4from+'&level4to='+level4to+'&level5from='+level5from+'&branch='+document.getElementById("cmbbranch").value+'&uptoDate='+$("#uptodate").val()+'&salesperson='+salesperson+'&category='+category+'&clientstatus='+clientstatus+'&email=Nil&print=1',"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
	        win.focus();
			funGetOutstandingTable();  
	     }
	    else {
			$.messager.alert('Message','Please Choose Account Type.','warning');
			return 0;   
		}
	}
	
	function funauditletterprint(){
		 var accno = $('#txtacountno').val();
		 var level1from = $('#txtlevel1from').val();
		 var level1to = $('#txtlevel1to').val();
		 var level2from = $('#txtlevel2from').val();
		 var level2to = $('#txtlevel2to').val();
		 var level3from = $('#txtlevel3from').val();
		 var level3to = $('#txtlevel3to').val();
		 var level4from = $('#txtlevel4from').val();
		 var level4to = $('#txtlevel4to').val();
		 var level5from = $('#txtlevel5from').val();
		
		 if(accno==''){
			 $.messager.alert('Message','Please Choose a Client/Supplier.','warning');
			 return 0;
		 }
		
 	     if ($("#txtacountno").val()!="") {
	        var url=document.URL;
	        var reurl=url.split("ageingStatement.jsp");
	        
	        $("#txtacountno").prop("disabled", false);
	        var win= window.open(reurl[0]+"printAuditconfirmationletterpal?balance="+document.getElementById("txtbalance").value.replace(',','')+"&acno="+document.getElementById("txtacountno").value+'&atype='+document.getElementById("cmbtype").value+'&level1from='+level1from+'&level1to='+level1to+'&level2from='+level2from+'&level2to='+level2to+'&level3from='+level3from+'&level3to='+level3to+'&level4from='+level4from+'&level4to='+level4to+'&level5from='+level5from+'&branch='+document.getElementById("cmbbranch").value+'&uptoDate='+$("#uptodate").val()+'&email=Nil&print=1',"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
	        win.focus();
	     }
	    else {
	    	$.messager.alert('Message','Please Choose a Client/Supplier.','warning');
			return;
		}
	}
	
	
	function funSendingEmail() {  
		
	    var email = document.getElementById("txtaccemail").value;
	    var level1from = $('#txtlevel1from').val();
		var level1to = $('#txtlevel1to').val();
		var level2from = $('#txtlevel2from').val();
		var level2to = $('#txtlevel2to').val();
		var level3from = $('#txtlevel3from').val();
		var level3to = $('#txtlevel3to').val();
		var level4from = $('#txtlevel4from').val();
		var level4to = $('#txtlevel4to').val();
		var level5from = $('#txtlevel5from').val();
	    var res;var part1;var part2;var dotsplt;
	    if(email.indexOf("@")>=0) {
		    res = email.split('@');
		    part1=res[0];
		    part2=res[1];
		    dotsplt=part2.split('.');
	    }
	    
	   if ($("#txtacountno").val().trim()=="" || typeof($("#txtacountno").val().trim())=="undefined" || typeof($("#txtacountno").val().trim())=="NaN") {
		    $('#txtacountno').val('');
		    $.messager.alert('Message','Please Choose a Client/Supplier.','warning');
			return;
	  } else  if(email.trim()=="" || typeof(email.trim())=="undefined" || typeof(email.trim())=="NaN") {
		    $.messager.alert('Message','Email is not Configured Properly.','warning');
			return;
	  } else if(email.indexOf("@")<0) {
		    $.messager.alert('Message','Email is not Configured Properly.','warning');
			return;
	  } else if(email.split('@').length!=2) {
		    $.messager.alert('Message','Email is not Configured Properly.','warning');
			return;
	  } else if(part1.length==0) {
		    $.messager.alert('Message','Email is not Configured Properly.','warning');
			return;
	  } else if(part1.split(" ").length>2) {
		    $.messager.alert('Message','Email is not Configured Properly.','warning');
			return;
      } else if(part2.split(".").length<2) {
    	    $.messager.alert('Message','Email is not Configured Properly.','warning');
			return;
      } else if(dotsplt[0].length==0 ) {
    	    $.messager.alert('Message','Email is not Configured Properly.','warning');
			return;
      } else if(dotsplt[1].length<2 ||dotsplt[1].length>4) {
    	    $.messager.alert('Message','Email is not Configured Properly.','warning');
			return;
      } else {
 		
		    $("#overlay, #PleaseWait").show();
		   
	 		$.ajaxFileUpload ({  
	    	    	  url: 'printAgeingOutstandingsStatement.action?acno='+document.getElementById("txtacountno").value+'&atype='+document.getElementById("cmbtype").value+'&level1from='+level1from+'&level1to='+level1to+'&level2from='+level2from+'&level2to='+level2to+'&level3from='+level3from+'&level3to='+level3to+'&level4from='+level4from+'&level4to='+level4to+'&level5from='+level5from+'&branch='+document.getElementById("cmbbranch").value+'&uptoDate='+$("#uptodate").val()+'&email='+$('#txtaccemail').val()+'&print=0',  
	    	          secureuri:false, 
	    	          fileElementId:'file',   
	    	          dataType: 'string',  
	    	          success: function (data, status) {  
	    	             if(status=='success'){
							$("#overlay, #PleaseWait").hide();
							$.messager.alert('Message','E-Mail Send Successfully');
	    	              }
	    	             if(status=='error'){
	    	            	 $("#overlay, #PleaseWait").hide();
	    	            	 $.messager.alert('Message','E-Mail Sending failed');
	    	             }
	    	              $("#testImg").attr("src",data.message);
	    	              if(typeof(data.error) != 'undefined')  {  
	    	                  if(data.error != '')  {  
	    	                      alert(data.error);  
	    	                  }else  {  
	    	                      alert(data.message);  
	    	                  }  
	    	              }  
	    	          },  
	    	           error: function (data, status, e) {  
	    	              alert(e);  
	    	          }  
	    	      }) 
	    	     return false;
		  } 
    }
	    
	function clearAccountInfo(){
		$('#txtdocno').val('');$('#txtaccid').val('');$('#txtaccname').val('');
	} 
	
	function funreload(event){
		 var branchval = document.getElementById("cmbbranch").value;
		 var uptodate = $('#uptodate').val();
		 var atype = $('#cmbtype').val();
		 var accdocno = $('#txtdocno').val();
		 var salesperson = $('#cmbsalesperson').val();
		 var category = $('#cmbcategory').val();
		 var clientstatus = $('#cmbclientstatus').val();
		 var level1from = $('#txtlevel1from').val();
		 var level1to = $('#txtlevel1to').val();
		 var level2from = $('#txtlevel2from').val();
		 var level2to = $('#txtlevel2to').val();
		 var level3from = $('#txtlevel3from').val();
		 var level3to = $('#txtlevel3to').val();
		 var level4from = $('#txtlevel4from').val();
		 var level4to = $('#txtlevel4to').val();
		 var level5from = $('#txtlevel5from').val();
		 var check=1;
		 
		 if(atype==''){
			 $.messager.alert('Message','Please Choose Account Type.','warning');
			 return 0;
		 }
		 
		 if(level1from==''){$.messager.alert('Message','Level 1 is Mandatory.','warning');return 0;}
		 if(level1to==''){$.messager.alert('Message','Level 1 is Mandatory.','warning');return 0;}
		 if(level2from==''){$.messager.alert('Message','Level 2 is Mandatory.','warning');return 0;}
		 if(level2to==''){$.messager.alert('Message','Level 2 is Mandatory.','warning');return 0;}
		 if(level3from==''){$.messager.alert('Message','Level 3 is Mandatory.','warning');return 0;}
		 if(level3to==''){$.messager.alert('Message','Level 3 is Mandatory.','warning');return 0;}
		 if(level4from==''){$.messager.alert('Message','Level 4 is Mandatory.','warning');return 0;}
		 if(level4to==''){$.messager.alert('Message','Level 4 is Mandatory.','warning');return 0;}
		 if(level5from==''){$.messager.alert('Message','Level 5 is Mandatory.','warning');return 0;}
		 
		 $("#overlay, #PleaseWait").show();
		 
		 $("#ageingStatementDiv").load("ageingStatementGrid.jsp?branchval="+branchval+'&uptodate='+uptodate+'&atype='+atype+'&accdocno='+accdocno+'&salesperson='+salesperson+'&category='+category+'&level1from='+level1from+'&level1to='+level1to+'&level2from='+level2from+'&level2to='+level2to
				 +'&level3from='+level3from+'&level3to='+level3to+'&level4from='+level4from+'&level4to='+level4to+'&level5from='+level5from+'&clientstatus='+clientstatus+'&check='+check);
		 
	}
	
	function funGetOutstandingTable() {
		$("#overlay, #PleaseWait").show();
		var acno=document.getElementById("txtacountno").value;
		var atype=document.getElementById("cmbtype").value;
		var accno = $('#txtacountno').val();
		var level1from = $('#txtlevel1from').val();
		var level1to = $('#txtlevel1to').val();
		var level2from = $('#txtlevel2from').val();
		var level2to = $('#txtlevel2to').val();
		var level3from = $('#txtlevel3from').val();
		var level3to = $('#txtlevel3to').val();
		var level4from = $('#txtlevel4from').val();
		var level4to = $('#txtlevel4to').val();
		var level5from = $('#txtlevel5from').val();
		var branch=document.getElementById("cmbbranch").value;
		var uptoDate=$("#uptodate").jqxDateTimeInput('val');
		
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText.trim();
				$("#overlay, #PleaseWait").hide();
				$('#ageingStatementDiv').append($.parseHTML(items.split("::")[0]));
				$("#ageingStatementDiv").excelexportjs({
					containerid: "tabledata",
					datatype: 'table', 
					dataset: $.parseHTML(items.split("::")[0]),
					worksheetName: items.split("::")[1]
				});
			}
		}
		x.open("GET", "getOutstandingTable.jsp?acno="+acno+"&atype="+atype+"&level1from="+level1from+"&level1to="+level1to+"&level2from="+level2from+"&level2to="+level2to+"&level3from="+level3from+"&level3to="+level3to+"&level4from="+level4from+"&level4to="+level4to+"&level5from="+level5from+"&branch="+branch+"&uptoDate="+uptoDate+"&email=Nil&print=1", true);
		x.send();
	}
		
	function funAutoApply(){
		var accno = $('#txtacountno').val();
		var atype=document.getElementById("cmbtype").value;
		if(accno==''){
			 $.messager.alert('Message','Please Choose a Client/Supplier.','warning');
			 return 0;
		 }
		$("#overlay, #PleaseWait").show();
		
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText.trim();
				$("#overlay, #PleaseWait").hide();
				if(items=="S"){
					$.messager.alert('Message','Succesfully Applied','warning');
				}
			}
		}
		x.open("GET", "applydelete.jsp?acno="+accno+"&uptodate="+$("#uptodate").val()+"&atype="+document.getElementById("cmbtype").value, true );
		x.send();
	}
</script>
</head>
<body onload="getBranch();getSalesPerson();getCategory();">
    <div id="mainBG" class="homeContent" data-type="background"> 
        <div class="master-container">

            <!-- Sidebar / Filter Section -->
            <div class="sidebar-filters">
                <div class="sidebar-scroll-content">
                    <div class="filter-card">
                        <table class="release-filter-table">
                            <tr>
                                <td class="label-cell">Up To</td>
                                <td>
                                    <div id="uptodate" name="uptodate" value='<s:property value="uptodate"/>'></div>
                                </td>
                            </tr> 
                            <tr>
                                <td class="label-cell">Type</td>
                                <td>
                                    <select id="cmbtype" name="cmbtype" onchange="clearAccountInfo();getCategory();" value='<s:property value="cmbtype"/>'>
                                        <option value="">--Select--</option>
                                        <option value="AR" selected>AR</option>
                                        <option value="AP">AP</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td class="label-cell">Account</td>
                                <td>
                                    <input type="text" id="txtaccid" name="txtaccid" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtaccid"/>' onkeydown="getAccType(event);"/>
                                </td>
                            </tr> 
                            <tr>
                                <td class="label-cell"></td>
                                <td>
                                    <input type="text" id="txtaccname" name="txtaccname" readonly="readonly" value='<s:property value="txtaccname"/>' tabindex="-1"/>
                                    <input type="hidden" id="txtdocno" name="txtdocno" value='<s:property value="txtdocno"/>'/>
                                </td>
                            </tr> 
                            <tr>
                                <td class="label-cell">Sales Person</td>
                                <td>
                                    <select id="cmbsalesperson" name="cmbsalesperson" value='<s:property value="cmbsalesperson"/>'>
                                        <option value="">--Select--</option>
                                    </select>
                                    <input type="hidden" id="hidcmbsalesperson" name="hidcmbsalesperson" value='<s:property value="hidcmbsalesperson"/>'/>
                                </td>
                            </tr>
                            <tr>
                                <td class="label-cell">Category</td>
                                <td>
                                    <select id="cmbcategory" name="cmbcategory" value='<s:property value="cmbcategory"/>'>
                                        <option value="">--Select--</option>
                                    </select>
                                    <input type="hidden" id="hidcmbcategory" name="hidcmbcategory" value='<s:property value="hidcmbcategory"/>'/>
                                </td>
                            </tr>
                            <tr>
                                <td class="label-cell">Status</td>
                                <td>
                                    <select id="cmbclientstatus" name="cmbclientstatus" value='<s:property value="cmbclientstatus"/>'>
                                        <option value=''>-- Select --</option>
                                        <option value='0'>Active</option>
                                        <option value='1'>Litigation</option>
                                        <option value='2'>Dispute</option>
                                        <option value='3'>Bad Debts</option>
                                    </select>
                                    <input type="hidden" id="hidcmbclientstatus" name="hidcmbclientstatus" value='<s:property value="hidcmbclientstatus"/>'/>
                                </td>
                            </tr>
                            
                            <!-- Level Inputs -->
                            <tr>
                                <td class="label-cell">Level 1</td>
                                <td>
                                    <div class="range-container">
                                        <input type="text" id="txtlevel1from" name="txtlevel1from" readonly="readonly" value='0'/>
                                        <span>-</span>
                                        <input type="text" id="txtlevel1to" name="txtlevel1to" onblur="changelevel1();" value='30'/>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="label-cell">Level 2</td>
                                <td>
                                    <div class="range-container">
                                        <input type="text" id="txtlevel2from" name="txtlevel2from" readonly="readonly" value='31'/>
                                        <span>-</span>
                                        <input type="text" id="txtlevel2to" name="txtlevel2to" onblur="changelevel2();" value='60'/>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="label-cell">Level 3</td>
                                <td>
                                    <div class="range-container">
                                        <input type="text" id="txtlevel3from" name="txtlevel3from" readonly="readonly" value='61'/>
                                        <span>-</span>
                                        <input type="text" id="txtlevel3to" name="txtlevel3to" onblur="changelevel3();" value='90'/>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="label-cell">Level 4</td>
                                <td>
                                    <div class="range-container">
                                        <input type="text" id="txtlevel4from" name="txtlevel4from" readonly="readonly" value='91'/>
                                        <span>-</span>
                                        <input type="text" id="txtlevel4to" name="txtlevel4to" onblur="changelevel4();" value='120'/>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="label-cell">Level 5</td>
                                <td>
                                    <div class="range-container">
                                        <input type="text" id="txtlevel5from" name="txtlevel5from" value='121'/>
                                        <span style="font-size:12px;">&gt;=</span>
                                    </div>
                                </td>
                            </tr>
                        </table>

                        <div class="release-actions">
                            <button type="button" class="btn-submit" id="btnIndividual" name="btnIndividual" onclick="funOutStandingStatement();">Outstanding Statement</button>
                            <button type="button" class="btn-submit" id="btnnormalprint" name="btnnormalprint" onclick="funageingprint();">Print</button>
                            <button type="button" class="btn-submit btn-export" id="btnOutExcel" title="Export Outstanding Statement to Excel" onclick="funOutExcelBtn()">
                                Export to Excel
                            </button>
                            
                            <!-- Preserved Hidden Actions for logic hooks if needed -->
                            <button type="button" id="btnIndividual_Hidden" style="display:none;" onclick="funauditletterprint();">Audit Balance Confirmation Letter</button>
                            <button type="button" id="btnApply" style="display:none;" onclick="funAutoApply();">Auto Apply</button>
                        </div>

                        <!-- Hidden fields -->
                        <input type="hidden" id="txtacountno" name="txtacountno" value='<s:property value="txtacountno"/>'/>
                        <input type="hidden" id="txtaccemail" name="txtaccemail" value='<s:property value="txtaccemail"/>'/>
                        <input type="hidden" id="txtbalance" name="txtbalance" value='<s:property value="txtbalance"/>'/>
                        <input type="hidden" id="txtbranch" name="txtbranch" value='<s:property value="txtbranch"/>'/>
                    </div>
                </div>
            </div>

            <!-- Main Grid / Data Section -->
            <div class="main-content-area">
                
                <div class="top-toolbar-container">
                    <jsp:include page="../../heading.jsp"></jsp:include>
                </div>

                <div class="grid-content-container">
                    
                    <!-- Grid Data Area -->
                    <div id="ageingStatementDiv" style="flex: 1; display: flex; flex-direction: column;">
                        <jsp:include page="ageingStatementGrid.jsp"></jsp:include>
                    </div>

                    <!-- Bottom Totals Section -->
                    <div class="net-total-container">
                        <label>Net Total :</label>
                        <input type="text" id="txtnetbalance" name="txtnetbalance" readonly="readonly" value='<s:property value="txtnetbalance"/>'/>
                    </div>

                </div>

            </div>

        </div>

        <!-- Modals -->
        <div id="accountDetailsWindow">
            <div></div><div></div>
        </div>
    </div> 
</body>
</html>