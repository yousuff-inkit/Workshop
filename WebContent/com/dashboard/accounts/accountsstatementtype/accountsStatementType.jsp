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

/* Radio buttons & Checkbox layout */
.radio-group, .checkbox-group {
    display: flex;
    gap: 12px;
    align-items: center;
    font-size: 12px !important;
    color: #333;
    height: 24px;
    flex-wrap: wrap;
}
.radio-group label, .checkbox-group label {
    display: flex;
    align-items: center;
    cursor: pointer;
    margin: 0;
}
.radio-group input[type="radio"], .checkbox-group input[type="checkbox"] {
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
    display: flex;
    flex-direction: column;
}

/* Specific UI Elements */
.account-header {
    font-size: 13px;
    font-weight: 600;
    color: #1e293b;
    margin-bottom: 10px;
    padding: 8px 12px;
    background: #f8fafc;
    border: 1px solid #e2e8f0;
    border-radius: 4px;
}
.account-header span {
    color: #3b82f6;
    font-weight: 700;
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

.status {
	color: #FD8725;
	font-family: 'Segoe UI', Tahoma, sans-serif;
	font-size: 18px;
	font-weight: bold;
}

#lblclientstatus {
  -moz-animation-duration: 1s;
  -moz-animation-name: blink;
  -moz-animation-iteration-count: infinite;
  -moz-animation-direction: alternate;
  
  -webkit-animation-duration: 1s;
  -webkit-animation-name: blink;
  -webkit-animation-iteration-count: infinite;
  -webkit-animation-direction: alternate;
  
  animation-duration: 1s;
  animation-name: blink;
  animation-iteration-count: infinite;
  animation-direction: alternate;
}

@-moz-keyframes blink {
  from { opacity: 1; }
  to { opacity: 0; }
}

@-webkit-keyframes blink {
  from { opacity: 1; }
  to { opacity: 0; }
}

@keyframes blink {
  from { opacity: 1; }
  to { opacity: 0; }
}
</style>
<script type="text/javascript">

	$(document).ready(function () {
		var name='<%=request.getParameter("name")==null?"":request.getParameter("name")%>';
		
         // Adapted width and height for modern UI compliance
		 $("#fromdate").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"dd.MM.yyyy"});
		 $("#todate").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"dd.MM.yyyy"});
		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	     
		 $('#accountDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailsWindow').jqxWindow('close');
		 
		 var year = window.parent.txtaccountperiodfrom.value;
		 var newDate = year.split('-');
		 year = newDate[1] + "-" + newDate[0] + "-" + newDate[2];
		 $('#fromdate ').jqxDateTimeInput('setDate', new Date(year));
		 
		 $('#txtaccid').dblclick(function(){
			  accountsSearchContent('accountsDetailsSearch.jsp');
	     });
		 document.getElementById("chckopnprint").checked=true;
         $('#hidchckopnprint').val(1);
         opnprintcheck();
	});
	
	function accountsSearchContent(url) {
	    $('#accountDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#accountDetailsWindow').jqxWindow('setContent', data);
		$('#accountDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function funExportBtn(){ 
		var accname=$('#txtaccid').val()+" - "+$('#txtaccname').val(); 
		if(($('#lbldetailname').text()=='Accounts Statement AP')){  
			JSONToCSVCon(dataExcelExport,'AccountsStatementAP              '+' '+accname, true);    
        }else if(($('#lbldetailname').text()=='Accounts Statement AR')){
			JSONToCSVCon(dataExcelExport,'AccountsStatementAR              '+' '+accname, true);
        }else if(($('#lbldetailname').text()=='Accounts Statement GL')){             
			JSONToCSVCon(dataExcelExport,'AccountsStatementGL              '+' '+accname, true);
        }else if(($('#lbldetailname').text()=='Accounts Statement HR')){
			JSONToCSVCon(dataExcelExport,'AccountsStatementHR              '+' '+accname, true);
        }
	} 
	
	function getAccTypeFrom(event){
        var x= event.keyCode;
        if(x==114){
      		accountsSearchContent('accountsDetailsSearch.jsp');
        }
    }
	
	function getAccountingPeriod(date){
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText;
  			    $('#txtaccountperiodfrom').val(items);
  		    }
  		}
  		x.open("GET", "getAccountingPeriod.jsp?fromDate="+date, true);
  		x.send();
    }
	
	function getAccountFromPeriod(){
		 var date = $('#fromdate').val();
		 getAccountingPeriod(date);
			  
	 	 if($('#txtaccountperiodfrom').val()<0){
			  $.messager.alert('Message','Not in Account-Period.','warning');
			  return;
		 }
	}
	
	function funreload(event){
		if($('#txtaccountperiodfrom').val()<0){
			  $.messager.alert('Message','Not in Account-Period.','warning');
			  return;
		}
		
		 var branchval = document.getElementById("cmbbranch").value;
		 var fromdate = $('#fromdate').val();
		 var todate = $('#todate').val();
		 var accdocno = $('#txtdocno').val();
		 var chckopn=$('#hidchckopnprint').val();
		 
		 if(accdocno==''){
			 $.messager.alert('Message','Account is Mandatory.','warning');
			 return 0;
		 }
		
		 $("#overlay, #PleaseWait").show();
		 
		 document.getElementById("lblaccountname").innerText=$('#txtaccname').val(); 
		 $("#accountsStatementDiv").load("accountsStatementTypeGrid.jsp?branchval="+branchval+'&chckopn='+chckopn+'&fromdate='+fromdate+'&todate='+todate+'&accdocno='+accdocno+'&check=1');
	}
	
	function funPrintAccountStatement(){
    	if ($("#txtdocno").val()!="") {
	        var url=document.URL;
	        var reurl=url.split("accountsStatementType.jsp");
	        $("#txtdocno").prop("disabled", false);
	        var win= window.open(reurl[0]+"../../../../com/dashboard/accounts/accountsstatement/printAccountsStatement?acno="+document.getElementById("txtdocno").value+'&netamount='+document.getElementById("txtnetamount").value+'&branch='+document.getElementById("cmbbranch").value+'&fromDate='+document.getElementById("fromdate").value+'&toDate='+$('#todate').val()+'&chckopn='+$('#hidchckopnprint').val()+'&email=Nil&print=1',"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
	        win.focus();
	     }
	    else {
			$.messager.alert('Message','Account is Mandatory.','warning');
			return;
		}
    }
	function funPrintRAwise(){
    	if ($("#txtdocno").val()!="") {
	        var url=document.URL;
	        var reurl=url.split("accountsStatementType.jsp");
	        $("#txtdocno").prop("disabled", false);
	        var win= window.open(reurl[0]+"../../../../com/dashboard/accounts/accountsstatement/printRAWise?acno="+document.getElementById("txtdocno").value+'&netamount='+document.getElementById("txtnetamount").value+'&branch='+document.getElementById("cmbbranch").value+'&fromDate='+document.getElementById("fromdate").value+'&toDate='+$('#todate').val()+'&chckopn='+$('#hidchckopnprint').val()+'&email=Nil&print=1',"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
	        win.focus();
	     }
	    else {
			$.messager.alert('Message','Account is Mandatory.','warning');
			return;
		}
    }
	function funSendingEmail() {  
		
	    var email = document.getElementById("txtaccemail").value;
	    var res;var part1;var part2;var dotsplt;
	    if(email.indexOf("@")>=0) {
		    res = email.split('@');
		    part1=res[0];
		    part2=res[1];
		    dotsplt=part2.split('.');
	    }
	    
	   if ($("#txtdocno").val().trim()=="" || typeof($("#txtdocno").val().trim())=="undefined" || typeof($("#txtdocno").val().trim())=="NaN") {
		    $('#txtaccid').val('');$('#txtaccname').val('');$('#txtdocno').val('');$('#txtaccemail').val('');
			
			if (document.getElementById("txtaccid").value == "") {
		        $('#txtaccid').attr('placeholder', 'Press F3 to Search'); 
		    }
			$.messager.alert('Message','Account is Mandatory.','warning');
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
	    	    	
	    	    	  url: 'printAccountsStatement.action?acno='+document.getElementById("txtdocno").value+'&netamount='+document.getElementById("txtnetamount").value+'&branch='+document.getElementById("cmbbranch").value+'&fromDate='+document.getElementById("fromdate").value+'&toDate='+$('#todate').val()+'&email='+$('#txtaccemail').val()+'&print=0chckopn&chckopn=1',  
	    	          secureuri:false,//false  
	    	          fileElementId:'file', //id  <input type="file" id="file" name="file" />  
	    	          dataType: 'string',// json  
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
	    	              if(typeof(data.error) != 'undefined')  
	    	              {  
	    	                  if(data.error != '')  
	    	                  {  
	    	                      alert(data.error);  
	    	                  }else  
	    	                  {  
	    	                      alert(data.message);  
	    	                  }  
	    	              }  
	    	          },  
	    	           error: function (data, status, e)
	    	          {  
	    	              alert(e);  
	    	          }  
	    	      }) 
	    	     return false;
 		
		  } 
      }
	  
	  function getClientStatus(){
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText;
  				items = items.split('####');
  			    $('#lblclientstatus').html(items[0]);
  		    }
  		}
  		x.open("GET", "getClientStatus.jsp?accountno="+$("#txtdocno").val().trim(), true);
  		x.send();
 	}
	
	function opnprintcheck(){
		 if(document.getElementById("chckopnprint").checked){
			 document.getElementById("hidchckopnprint").value = 1;
		 }
		 else{
			 document.getElementById("hidchckopnprint").value = 0;
		 }
	}
	  
	function funPrintARProjectWise(){
	    if ($("#txtdocno").val()!="") {
		    var url=document.URL;
		    var reurl=url.split("accountsStatementType.jsp");
		    $("#txtdocno").prop("disabled", false);
		    var win= window.open(reurl[0]+"../../../../com/dashboard/accounts/accountsstatement/printARProjectWise?acno="+document.getElementById("txtdocno").value+'&netamount='+document.getElementById("txtnetamount").value+'&branch='+document.getElementById("cmbbranch").value+'&fromDate='+document.getElementById("fromdate").value+'&toDate='+$('#todate').val()+'&chckopn='+$('#hidchckopnprint').val()+'&email=Nil&print=1',"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
		    win.focus();
		 }
		else {
			$.messager.alert('Message','Account is Mandatory.','warning');
			return;
		}
	}

	function getProjectWisePrintAllowed(){
	  	var x = new XMLHttpRequest();
	  	x.onreadystatechange = function() {
	  		if (x.readyState == 4 && x.status == 200) {
	  			var items = x.responseText;
	  			if(parseInt(items)==1){
	  			    $('#btnPrintAccountStmt').show();
	  			} else {
	  				$('#btnPrintAccountStmt').hide();
	  			}
	  		}
	  	}
	  	x.open("GET", "getProjectWisePrintAllowed.jsp", true);
	  	x.send();
	}

	function getRAwiseprint(){
		var dname=document.getElementById("lbldetailname").innerText;
		var x = new XMLHttpRequest();
		x.onreadystatechange = function(){
			if(x.readyState ==4 && x.status == 200){
				var items = x.responseText;
				if(items==1 && dname=="Accounts Statement AR"){
					$('#btnRAPrintAccount').show();
				}else{
					$('#btnRAPrintAccount').hide();
				}
			}
		}
		x.open("GET","getrawise.jsp",true);
		x.send();
	}
	
</script>
</head>
<body onload="getBranch();getProjectWisePrintAllowed();getRAwiseprint();">
    <div id="mainBG" class="homeContent" data-type="background"> 
        <form id="frmAccountStatementType" action="saveAccountStatementType" method="post" autocomplete="off" style="height: 100%;">
            <div class="master-container">

                <!-- Sidebar / Filter Section -->
                <div class="sidebar-filters">
                    <div class="sidebar-scroll-content">
                        <div class="filter-card">
                            <table class="release-filter-table">
                                <tr>
                                    <td class="label-cell">Period</td>
                                    <td>
                                        <div id="fromdate" name="fromdate" onchange="getAccountFromPeriod();" value='<s:property value="fromdate"/>'></div>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="label-cell">To</td>
                                    <td>
                                        <div id="todate" name="todate" value='<s:property value="todate"/>'></div>
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
                                    </td>
                                </tr>
                            </table>

                            <!-- Client Status Label -->
                            <div style="text-align: center; padding: 15px 0;">
                                <label class="status" id="lblclientstatus" name="lblclientstatus"><s:property value="lblclientstatus"/></label>
                            </div>

                            <!-- OPN Checkbox & Actions -->
                            <div class="checkbox-group" style="justify-content: center; padding-bottom: 12px;">
                                <label>
                                    <input type="checkbox" id="chckopnprint" name="chckopnprint" value="" onchange="opnprintcheck();" onclick="$(this).attr('value', this.checked ? 1 : 0)" /> 
                                    OPN
                                </label>
                                <input type="hidden" id="hidchckopnprint" name="hidchckopnprint" value='<s:property value="hidchckopnprint"/>'/>
                            </div>

                            <div class="release-actions">
                                <button type="button" class="btn-submit" id="btnPrintAccount" name="btnPrintAccount" onclick="funPrintAccountStatement(event);">Account Statement</button>
                                <button type="button" class="btn-submit" id="btnRAPrintAccount" name="btnRAPrintAccount" onclick="funPrintRAwise(event);">RA wise Print</button>
                                <button type="button" class="btn-submit" id="btnPrintAccountStmt" name="btnPrintAccountStmt" onclick="funPrintARProjectWise(event);">Project Wise Print</button>
                            </div>

                            <!-- Hidden Fields -->
                            <input type="hidden" id="txtdocno" name="txtdocno" value='<s:property value="txtdocno"/>'/>
                            <input type="hidden" id="txtaccemail" name="txtaccemail" value='<s:property value="txtaccemail"/>'/>
                            <input type="hidden" id="txtaccountperiodfrom" name="txtaccountperiodfrom" value='<s:property value="txtaccountperiodfrom"/>'/>
                        </div>
                    </div>
                </div>

                <!-- Main Grid / Data Section -->
                <div class="main-content-area">
                    
                    <div class="top-toolbar-container">
                        <jsp:include page="../../heading.jsp"></jsp:include>
                    </div>

                    <div class="grid-content-container">
                        
                        <div class="account-header">
                            Account : <span id="lblaccountname"></span>
                        </div>

                        <!-- Data Grid Container -->
                        <div id="accountsStatementDiv" style="flex: 1; display: flex; flex-direction: column;">
                            <jsp:include page="accountsStatementTypeGrid.jsp"></jsp:include>
                        </div>

                        <!-- Bottom Totals Section -->
                        <div class="net-total-container">
                            <label>Net Amount :</label>
                            <input type="text" id="txtnetamount" name="txtnetamount" readonly="readonly" value='<s:property value="txtnetamount"/>'/>
                        </div>
                        
                    </div>

                </div>

            </div>
            
            <!-- Modals -->
            <div id="accountDetailsWindow">
                <div></div><div></div>
            </div>

        </form>
    </div> 
</body>
</html>