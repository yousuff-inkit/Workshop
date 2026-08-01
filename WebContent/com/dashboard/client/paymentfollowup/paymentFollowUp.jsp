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
    width: 310px; 
    flex: 0 0 310px; 
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
.release-filter-table div[id^="uptodate"],
.release-filter-table div[id^="followupdate"],
.release-filter-table div[id^="date"] {
    width: 100% !important;
    height: 24px !important;
}

/* Checkbox alignment */
.checkbox-group {
    display: flex;
    align-items: center;
    gap: 6px;
    font-size: 12px;
    color: #333;
    margin-top: 4px;
}
.checkbox-group input {
    margin: 0;
}

/* Range Inputs Container */
.range-container {
    display: flex;
    align-items: center;
    gap: 6px;
}
.range-container input {
    text-align: right;
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
    gap: 15px;
}
</style>

<script type="text/javascript">

	$(document).ready(function () {
		 // Converted width to 100% and height to 24px
		 $("#uptodate").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"dd.MM.yyyy"});
		 $("#followupdate").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"dd.MM.yyyy"});
		 $("#date").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"dd.MM.yyyy"});
		 
		 $('#accountDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailsWindow').jqxWindow('close');
		 
		 $('#uptodate').jqxDateTimeInput({disabled: true});
		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
		 
		 $('#txtclientaccount').dblclick(function(){
			  accountsSearchContent('clientAccountDetailsSearch.jsp');
		 });
		 $('#txtcalculation').val(0);
	});
	
	function accountsSearchContent(url) {
	    $('#accountDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#accountDetailsWindow').jqxWindow('setContent', data);
		$('#accountDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function isNumber(evt) {
        var iKeyCode = (evt.which) ? evt.which : evt.keyCode
        if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57))
         {
          $.messager.alert('Message',' Enter Numbers Only ','warning');    
            return false;
         }
        return true;
    }
	
	function getProcess() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				
				var srno  = items[0].split(",");
				var process = items[1].split(",");
				var optionsbranch = '<option value="" selected>-- Select -- </option>';
				for (var i = 0; i < process.length; i++) {
					optionsbranch += '<option value="' + srno[i].trim() + '">'
							+ process[i] + '</option>';
				}
				$("select#cmbprocess").html(optionsbranch);
				
			} else {}
		}
		x.open("GET","getProcess.jsp", true);
		x.send();
	}
	
	function getSalesPerson() {
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
		x.open("GET", "getCategory.jsp", true);
		x.send();
	}
	
	function getClientAccount(event){
       var x= event.keyCode;
       if(x==114){
     	  accountsSearchContent('clientAccountDetailsSearch.jsp');
       }
    }
	   
	function disable(){
		 $('#date').jqxDateTimeInput({ disabled: true});
		 $('#cmbprocess').attr("disabled",true);
		 $('#txtremarks').attr("readonly",true);
		 $('#btnupdate').attr("disabled",true);
		 $("#followUpDetailsGrid").jqxGrid('clear');
		 $("#followUpDetailsGrid").jqxGrid("addrow", null, {}); 
		 $("#followUpDetailsGrid").jqxGrid({ disabled: true});
	}
	
	function followupcheck(){
		 if(document.getElementById("chckfollowup").checked){
			 document.getElementById("hidchckfollowup").value = 1;
			 $('#followupdate').jqxDateTimeInput({ disabled: false});
		 }
		 else{
			 document.getElementById("hidchckfollowup").value = 0;
			 $('#followupdate').jqxDateTimeInput({ disabled: true});
		 }
	}

  	function funCalculate(){
		$("#overlay, #PleaseWait").show();
		$('#txtcalculation').val(1);
		$('#paymentFollowUp').jqxGrid('showcolumn', 'current');
		$('#paymentFollowUp').jqxGrid('showcolumn', 'salik');
		$('#paymentFollowUp').jqxGrid('showcolumn', 'traffic');   
		paymentFollowUpGriGridReload();
	}
	
	function paymentFollowUpGriGridReload(){
		var x=new XMLHttpRequest();
		   x.onreadystatechange=function(){
		   		if (x.readyState==4 && x.status==200) {
		   			var items = x.responseText.trim();
		   			var arrayitems=items.split(",");
		   			var rows=$('#paymentFollowUp').jqxGrid('getrows');
		   			for(var i=0;i<rows.length;i++){
		   				for(var j=0;j<arrayitems.length;j++){
		   					var temp=arrayitems[j].split("###");
			   				if(rows[i].cldocno==temp[0]){
			   					$('#paymentFollowUp').jqxGrid('setcellvalue', i, "current",temp[3]);
			   					$('#paymentFollowUp').jqxGrid('setcellvalue', i, "salik",temp[1]);
			   					$('#paymentFollowUp').jqxGrid('setcellvalue', i, "traffic",temp[2]);
			   				}
			   				if(i==rows.length-1){
			   					$("#overlay, #PleaseWait").hide();
			   				}	
		   				}
		   			}
		   		}
		   }
		 x.open("GET","paymentGridReload.jsp",true);
		 x.send();   
	}
	
	function funreload(event){
		 var branchval = document.getElementById("cmbbranch").value;
		 var uptodate = $('#uptodate').val();
		 var clientaccount = $('#txtclientaccountdocno').val();
		 var chkfollowup = $('#hidchckfollowup').val();
		 var followupdate = $('#followupdate').val();
		 var salesperson = $('#cmbsalesperson').val();
		 var category = $('#cmbcategory').val();
		 var amtrangefrm = $('#txtamtrangefrom').val();
		 var amtrangeto = $('#txtamtrangeto').val();
		 var clientstatus = $('#cmbclientstatus').val();
		 
		 $("#overlay, #PleaseWait").show();
		 
		 $("#paymentFollowUpDiv").load("paymentFollowUpGrid.jsp?clientaccount="+clientaccount+'&branchval='+branchval+'&uptodate='+uptodate+'&chkfollowup='+chkfollowup+'&followupdate='+followupdate+'&salesperson='+salesperson+'&category='+category+'&amtrangefrm='+amtrangefrm+'&amtrangeto='+amtrangeto+'&clientstatus='+clientstatus+'&check=1');
	}
	
	function funUpdate(event){
		var process = $('#cmbprocess').val();
		var processname = $("#cmbprocess option:selected").text().trim();
		var date =  $('#date').val();
		var branchid = $('#txtbranch').val();
		var remarks = $('#txtremarks').val();
		var docno = $('#txtdocno').val();
		var accountno = $('#txtacountno').val();
		var cldocno = $('#txtcldocno').val();
		
		if(process==''){
			 $.messager.alert('Message','Choose a Process.','warning');
			 return 0;
		 }

		 if(remarks==''){
			 $.messager.alert('Message','Please Enter Remarks.','warning');   
			 return 0;
		 }
		
		 $.messager.confirm('Message', 'Do you want to save changes?', function(r){
		     	if(r==false) {
		     		return false; 
		     	}
		     	else{
		     		saveGridData(process,processname,date,branchid,docno,accountno,remarks,cldocno);	
		     	}
		});
	}
	
	function funOutStandingStatement(){
		 var accno = $('#txtacountno').val();
		 
		 if(accno==''){
			 $.messager.alert('Message','Please Choose a Client.','warning');
			 return 0;
		 }
		
   	    if ($("#txtacountno").val()!="") {
	        var url=document.URL;
	        var reurl=url.split("paymentFollowUp.jsp");
	        $("#txtacountno").prop("disabled", false);
			
	        var win= window.open(reurl[0]+"printOutstandingsStatement?atype=AR&acno="+document.getElementById("txtacountno").value+'&level1from=0&level1to=30&level2from=31&level2to=60&level3from=61&level3to=90&level4from=91&level4to=120&level5from=121&branch='+document.getElementById("cmbbranch").value+'&uptoDate='+$("#uptodate").val()+'&email=Nil&print=1',"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
	        win.focus();
	    }
	    else {
			$.messager.alert('Message','Account is Mandatory.','warning');
			return;
		}
	}
	
	function funSendingEmail() {  
		
	    var email = document.getElementById("txtclientaccountemail").value;
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
	    	    	  url: 'printOutstandingsStatement.action?acno='+document.getElementById("txtacountno").value+'&atype=AR&level1from=0&level1to=30&level2from=31&level2to=60&level3from=61&level3to=90&level4from=91&level4to=120&level5from=121&branch='+document.getElementById("txtbranch").value+'&uptoDate='+$("#uptodate").val()+'&email='+$('#txtclientaccountemail').val()+'&print=0',  
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
	    	              if(typeof(data.error) != 'undefined') {  
	    	                  if(data.error != '') {  
	    	                      alert(data.error);  
	    	                  }else {  
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
	    
	function saveGridData(process,processname,date,branchid,docno,accountno,remarks,cldocno){
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		    if (x.readyState==4 && x.status==200){
				var items=x.responseText;
				
				$('#cmbprocess').val('');
				$('#date').val(new Date());
				$('#txtbranch').val('');
				$('#txtremarks').val('');
				$('#txtdocno').val('');
				$('#txtacountno').val('');
				$('#txtcldocno').val('');
				$('#cmbclientstatus').val('');
				$('#txtclientaccount').val('');
				$('#txtclientname').val('');
				$('#txtclientaccountdocno').val('');
				
				if (document.getElementById("txtclientaccount").value == "") {
			        $('#txtclientaccount').attr('placeholder', 'Press F3 to Search'); 
			    }
				
				$.messager.alert('Message', '  Record Successfully Updated ', function(r){
			    });
				disable();
		    }
		}
			
	    x.open("GET","saveData.jsp?process="+process+"&processname="+processname+"&date="+date+"&branchid="+branchid+"&docno="+docno+"&accountno="+accountno+"&remarks="+remarks+"&cldocno="+cldocno,true);
	    x.send();
	}
	
	function funExportBtn(){
		 if(parseInt(window.parent.chkexportdata.value)=="1") {
		  	JSONToCSVCon(dataExcelExport, 'PaymentFollowUp', true);
		 } else {
			 $("#paymentFollowUp").jqxGrid('exportdata', 'xls', 'PaymentFollowUp');
		 }
	}
	
</script>
</head>
<body onload="getBranch();getProcess();disable();getSalesPerson();getCategory();followupcheck();">
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
                                <td class="label-cell">Client</td>
                                <td>
                                    <input type="text" id="txtclientaccount" name="txtclientaccount" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtclientaccount"/>' onkeydown="getClientAccount(event);"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="label-cell"></td>
                                <td>
                                    <input type="text" id="txtclientname" name="txtclientname" readonly="readonly" value='<s:property value="txtclientname"/>' tabindex="-1"/>
                                    <input type="hidden" id="txtclientaccountdocno" name="txtclientaccountdocno" value='<s:property value="txtclientaccountdocno"/>'/>
                                    <input type="hidden" id="txtclientaccountemail" name="txtclientaccountemail" value='<s:property value="txtclientaccountemail"/>'/>
                                </td>
                            </tr>
                            <tr>
                                <td class="label-cell"></td>
                                <td>
                                    <div class="checkbox-group">
                                        <label>
                                            <input type="checkbox" id="chckfollowup" name="chckfollowup" value="" onchange="followupcheck();" onclick="$(this).attr('value', this.checked ? 1 : 0)" /> 
                                            FollowUp
                                        </label>
                                        <input type="hidden" id="hidchckfollowup" name="hidchckfollowup" value='<s:property value="hidchckfollowup"/>'/>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="label-cell">Date</td>
                                <td><div id="followupdate" name="followupdate" value='<s:property value="followupdate"/>'></div></td>
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
                                <td class="label-cell">Amount Range</td>
                                <td>
                                    <div class="range-container">
                                        <input type="text" id="txtamtrangefrom" name="txtamtrangefrom" onkeypress="javascript:return isNumber(event)" onblur="funRoundAmt(this.value,this.id);" value='<s:property value="txtamtrangefrom"/>'/>
                                        <span>-</span>
                                        <input type="text" id="txtamtrangeto" name="txtamtrangeto" onkeypress="javascript:return isNumber(event)" onblur="funRoundAmt(this.value,this.id);" value='<s:property value="txtamtrangeto"/>'/>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="label-cell">Client Status</td>
                                <td>
                                    <select id="cmbclientstatus" name="cmbclientstatus" value='<s:property value="cmbclientstatus"/>'>
                                        <option value="">--Select--</option>
                                        <option value="1">On Hire</option>
                                        <option value="2">Off Hire</option>
                                        <option value="3">On Hire Litigation</option>
                                        <option value="4">Off Hire Litigation</option>
                                        <option value="5">On Hire Dispute</option>
                                        <option value="6">Off Hire Dispute</option>
                                        <option value="7">Bad Debts</option>
                                    </select>
                                </td>
                            </tr>
                        </table>
                    </div>

                    <div class="filter-card">
                        <table class="release-filter-table">
                            <tr>
                                <td class="label-cell">Process</td>
                                <td>
                                    <select name="cmbprocess" id="cmbprocess" value='<s:property value="cmbprocess"/>'></select>
                                </td>
                            </tr>
                            <tr>
                                <td class="label-cell">Date</td>
                                <td>
                                    <div id="date" name="date" value='<s:property value="date"/>'></div>
                                </td>
                            </tr>
                            <tr>
                                <td class="label-cell">Remarks</td>
                                <td>
                                    <input type="text" id="txtremarks" name="txtremarks" value='<s:property value="txtremarks"/>'/>
                                </td>
                            </tr>
                        </table>
                        
                        <div class="release-actions">
                            <button type="button" class="btn-submit" id="btnupdate" name="btnupdate" onclick="funUpdate(event);">Update</button>
                            <button type="button" class="btn-submit" id="btnIndividual" name="btnIndividual" onclick="funOutStandingStatement();">Outstanding Statement</button>
                        </div>

                        <!-- Hidden fields -->
                        <input type="hidden" id="txtacountno" name="txtacountno" value='<s:property value="txtacountno"/>'/>
                        <input type="hidden" id="txtdocno" name="txtdocno" value='<s:property value="txtdocno"/>'/>
                        <input type="hidden" id="txtbranch" name="txtbranch" value='<s:property value="txtbranch"/>'/>
                        <input type="hidden" id="txtcldocno" name="txtcldocno" value='<s:property value="txtcldocno"/>'/>
                        <input type="hidden" id="txtcalculation" name="txtcalculation" value='<s:property value="txtcalculation"/>'/>
                    </div>
                </div>
            </div>

            <!-- Main Grid / Data Section -->
            <div class="main-content-area">
                
                <div class="top-toolbar-container">
                    <jsp:include page="../../heading.jsp"></jsp:include>
                </div>

                <div class="grid-content-container">
                    
                    <div id="paymentFollowUpDiv" style="flex: 1; display: flex; flex-direction: column;">
                        <jsp:include page="paymentFollowUpGrid.jsp"></jsp:include>
                    </div>
                    
                    <div id="detailDiv" style="flex: 1; display: flex; flex-direction: column;">
                        <jsp:include page="detailGrid.jsp"></jsp:include>
                    </div>

                </div>

            </div>

        </div>

        <!-- Modals -->
        <div id="accountDetailsWindow">
            <div></div>
        </div>

    </div> 
</body>
</html>