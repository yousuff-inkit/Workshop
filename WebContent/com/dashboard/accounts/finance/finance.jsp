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
    width: 320px; 
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
.release-filter-table div[id^="fromdate"],
.release-filter-table div[id^="todate"] {
    width: 100% !important;
    height: 24px !important;
}

/* Range Inputs Container */
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

/* Flex containers for dynamic divs */
.flex-grid-wrapper {
    flex: 1; 
    display: flex; 
    flex-direction: column;
}
.flex-grid-wrapper[hidden] {
    display: none !important;
}
</style>

<script type="text/javascript">

	$(document).ready(function () {
         // Adapted width to 100% and height to 24px for Master UI
		 $("#fromdate").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"dd.MM.yyyy"});
		 $("#todate").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"dd.MM.yyyy"});
		 
		 $('#accountDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailsWindow').jqxWindow('close');
		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
		 
		 var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	     
	     $('#txtaccid').dblclick(function(){
	    	  if($('#cmbtype').val()==''){
    			 $.messager.alert('Message','Account Type is Mandatory.','warning');
    			 return 0;
    		  }
	    	  
	    	  if($('#cmbtype').val()==null){
	    			 $.messager.alert('Message','Account Search Not Available.','warning');
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
	
	function getDocumentType() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var dtypeItems = items[0].split(",");
				var menuItems = items[1].split(",");
				var optionssalutn = '<option value="">--Select--</option>';
				for (var i = 0; i < menuItems.length; i++) {
					optionssalutn += '<option value="' + dtypeItems[i] + '">'
							+ menuItems[i] + '</option>';
				}
				$("select#cmbdoctype").html(optionssalutn);
				if ($('#hidcmbdoctype').val() != null) {
					$('#cmbdoctype').val($('#hidcmbdoctype').val());
				}
			}
		}
		x.open("GET", "getDocumentType.jsp", true);
		x.send();
	} 
	
	function getAccTypeFrom(event){
        var x= event.keyCode;
        if(x==114){
          if($('#cmbtype').val()==''){
   			 $.messager.alert('Message','Account Type is Mandatory.','warning');
   			 return 0;
   		  }
          if($('#cmbtype').val()==null){
 			 $.messager.alert('Message','Account Search Not Available.','warning');
 			 return 0;
 	      }
      	  accountsSearchContent('accountsDetailsSearch.jsp');
        }
    }
		
	function funExportBtn(){
		 var dtype=$('#cmbdoctype').val();
		
		 if(dtype=='CRV'){JSONToCSVCon(dataExcelExport, 'CashReceiptVoucher', true);}
         if(dtype=='CPV'){JSONToCSVCon(dataExcelExport, 'CashPaymentVoucher', true);}
		 if(dtype=='BRV'){JSONToCSVCon(dataExcelExport1, 'BankReceiptVoucher', true);}
         if(dtype=='BPV'){JSONToCSVCon(dataExcelExport1, 'BankPaymentVoucher', true);}
		 if(dtype=='CNO'){JSONToCSVCon(dataExcelExport2, 'CreditVoucher', true);}
         if(dtype=='DNO'){JSONToCSVCon(dataExcelExport2, 'DebitVoucher', true);}
		 if(dtype=='JVT'){JSONToCSVCon(dataExcelExport3, 'JournalVoucher', true);}
         if(dtype=='IJV'){JSONToCSVCon(dataExcelExport3, 'IBJournalVoucher', true);}
		 if(dtype=='PC'){JSONToCSVCon(dataExcelExport, 'PettyCashVoucher', true);}
         if(dtype=='COT'){JSONToCSVCon(dataExcelExport4, 'ContraTransVoucher', true);}
		 if(dtype=='SEC'){JSONToCSVCon(dataExcelExport5, 'SecurityCheque', true);}
         if(dtype=='UCP'){JSONToCSVCon(dataExcelExport6, 'UnclearedChequePaymentVoucher', true);}
		 if(dtype=='UCR'){JSONToCSVCon(dataExcelExport6, 'UnclearedChequeReceiptVoucher', true);}
         if(dtype=='FCR'){JSONToCSVCon(dataExcelExport, 'FuelCardReimbursement', true);}
		 if(dtype=='ICRV'){JSONToCSVCon(dataExcelExport, 'IBCashReceiptVoucher', true);}
         if(dtype=='ICPV'){JSONToCSVCon(dataExcelExport, 'IBCashPaymentVoucher', true);}
		 if(dtype=='IBR'){JSONToCSVCon(dataExcelExport1, 'IBBankReceiptVoucher', true);}
         if(dtype=='IBP'){JSONToCSVCon(dataExcelExport1, 'IBBankPaymentVoucher', true);}
	} 
	
	function isNumber(evt) {
        var iKeyCode = (evt.which) ? evt.which : evt.keyCode
        if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57)) {
            $.messager.alert('Message',' Enter Numbers Only ','warning');    
            return false;
        }
        return true;
    }

	function funClearInfo(){
		$('#cmbbranch').val('a');
		$('#fromdate').val(new Date());
		var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	    var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	    var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	    $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	     
	    $('#todate').val(new Date());
	    
	    document.getElementById("lbldoctype").innerHTML="";
	    document.getElementById("cmbdoctype").value="";
	    document.getElementById("txtdocrangefrom").value="";
		document.getElementById("txtdocrangeto").value="";
		document.getElementById("txtamtrangefrom").value="";
		document.getElementById("txtamtrangeto").value="";
		document.getElementById("cmbtype").value="";
		document.getElementById("txtaccid").value="";
		document.getElementById("txtaccname").value="";
		document.getElementById("txtdocno").value="";
		
		$("#jqxCashVoucher").jqxGrid('clear');$("#jqxBankVoucher").jqxGrid('clear');$("#jqxCreditDebitVoucher").jqxGrid('clear');$("#jqxJournalVoucher").jqxGrid('clear');
		$("#jqxContraTransVoucher").jqxGrid('clear');$("#securityChequeList").jqxGrid('clear');$("#jqxUnclearedChequeVoucher").jqxGrid('clear');
		
		$("#jqxCashVoucher").jqxGrid('addrow', null, {});$("#jqxBankVoucher").jqxGrid('addrow', null, {});$("#jqxCreditDebitVoucher").jqxGrid('addrow', null, {});
		$("#jqxJournalVoucher").jqxGrid('addrow', null, {});$("#jqxContraTransVoucher").jqxGrid('addrow', null, {});$("#securityChequeList").jqxGrid('addrow', null, {});
		$("#jqxUnclearedChequeVoucher").jqxGrid('addrow', null, {});
		 
		$("#cashDiv").prop("hidden", false);$("#bankDiv").prop("hidden", true);$("#creditDiv").prop("hidden", true);$("#journalDiv").prop("hidden", true);$("#contraDiv").prop("hidden", true);
		$("#securityChqDiv").prop("hidden", true);$("#unclearedChqDiv").prop("hidden", true);
		
		if (document.getElementById("txtaccid").value == "") {
		    $('#txtaccid').attr('placeholder', 'Press F3 to Search'); 
		}
	}

	function docTypeInfo(){
        document.getElementById("lbldoctype").innerHTML="";
        document.getElementById("txtdocrangefrom").value="";
        document.getElementById("txtdocrangeto").value="";
        document.getElementById("txtamtrangefrom").value="";
        document.getElementById("txtamtrangeto").value="";
        document.getElementById("cmbtype").value="";
        document.getElementById("txtaccid").value="";
        document.getElementById("txtaccname").value="";
        document.getElementById("txtdocno").value="";
        
        $("#jqxCashVoucher").jqxGrid('clear');$("#jqxBankVoucher").jqxGrid('clear');$("#jqxCreditDebitVoucher").jqxGrid('clear');$("#jqxJournalVoucher").jqxGrid('clear');
        $("#jqxContraTransVoucher").jqxGrid('clear');$("#securityChequeList").jqxGrid('clear');$("#jqxUnclearedChequeVoucher").jqxGrid('clear');
        
        $("#jqxCashVoucher").jqxGrid('addrow', null, {});$("#jqxBankVoucher").jqxGrid('addrow', null, {});$("#jqxCreditDebitVoucher").jqxGrid('addrow', null, {});
        $("#jqxJournalVoucher").jqxGrid('addrow', null, {});$("#jqxContraTransVoucher").jqxGrid('addrow', null, {});$("#securityChequeList").jqxGrid('addrow', null, {});
        $("#jqxUnclearedChequeVoucher").jqxGrid('addrow', null, {});
            
        $("#cashDiv").prop("hidden", false);$("#bankDiv").prop("hidden", true);$("#creditDiv").prop("hidden", true);$("#journalDiv").prop("hidden", true);$("#contraDiv").prop("hidden", true);
        $("#securityChqDiv").prop("hidden", true);$("#unclearedChqDiv").prop("hidden", true);
        
        if($('#cmbdoctype').val()=='FCR'){
            $('#cmbtype').attr('disabled', true);
        }else{
            $('#cmbtype').attr('disabled', false);
        }
        
        if (document.getElementById("txtaccid").value == "") {
            $('#txtaccid').attr('placeholder', 'Press F3 to Search'); 
        }
	}
	
	function clearAccountInfo(){
		$('#txtdocno').val('');$('#txtaccid').val('');$('#txtaccname').val('');
		if (document.getElementById("txtaccid").value == "") {
	        $('#txtaccid').attr('placeholder', 'Press F3 to Search'); 
		}
	} 
	
	function funreload(event){
		
		 var branchval = document.getElementById("cmbbranch").value;
		 var fromdate = $('#fromdate').val();
		 var todate = $('#todate').val();
		 var accdocno = $('#txtdocno').val();
		 var dtype=$('#cmbdoctype').val();
		 var docrangefrom=$('#txtdocrangefrom').val();
		 var docrangeto=$('#txtdocrangeto').val();
		 var amtrangefrom=$('#txtamtrangefrom').val();
		 var amtrangeto=$('#txtamtrangeto').val();
		 var chk=1;
		 
		if(dtype==''){
			 $.messager.alert('Message','Please Choose Document Type.','warning');
			 return 0;
		 }
		 
		 var documenttype='';
		 if(dtype=='CRV'){documenttype='Listing of Cash Receipt Voucher (CRV)';}if(dtype=='CPV'){documenttype='Listing of Cash Payment Voucher (CPV)';}
		 if(dtype=='BRV'){documenttype='Listing of Bank Receipt Voucher (BRV)';}if(dtype=='BPV'){documenttype='Listing of Bank Payment Voucher (BPV)';}
		 if(dtype=='CNO'){documenttype='Listing of Credit Note (CNO)';}if(dtype=='DNO'){documenttype='Listing of Debit Note (DNO)';}
		 if(dtype=='JVT'){documenttype='Listing of Journal Voucher (JVT)';}if(dtype=='IJV'){documenttype='Listing of IB-Journal Voucher (IJV)';}
		 if(dtype=='PC'){documenttype='Listing of Petty Cash (PC)';}if(dtype=='COT'){documenttype='Listing of Contra Trans (COT)';}
		 if(dtype=='SEC'){documenttype='Listing of Security Cheque (SEC)';}if(dtype=='UCP'){documenttype='Listing of Uncleared Cheque Payment (UCP)';}
		 if(dtype=='UCR'){documenttype='Listing of Uncleared Cheque Receipt (UCR)';}if(dtype=='FCR'){documenttype='Listing of Fuel Card Reimbursement (FCR)';}
		 if(dtype=='ICRV'){documenttype='Listing of IB-Cash Receipt Voucher (ICRV)';}if(dtype=='ICPV'){documenttype='Listing of IB-Cash Payment Voucher (ICPV)';}
		 if(dtype=='IBR'){documenttype='Listing of IB-Bank Receipt Voucher (IBR)';}if(dtype=='IBP'){documenttype='Listing of IB-Bank Payment Voucher (IBP)';}
		
		 $("#overlay, #PleaseWait").show();
		 
		 document.getElementById("lbldoctype").innerText=documenttype; 
		 if(dtype=='CRV' || dtype=='CPV' || dtype=='ICRV' || dtype=='ICPV' || dtype=='PC' || dtype=='FCR'){
			 $("#unclearedChqDiv").prop("hidden", true);$("#securityChqDiv").prop("hidden", true);$("#contraDiv").prop("hidden", true);$("#cashDiv").prop("hidden", false);$("#bankDiv").prop("hidden", true);$("#creditDiv").prop("hidden", true);$("#journalDiv").prop("hidden", true);
				 $("#cashDiv").load("cashVoucher.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&accdocno='+accdocno+'&dtype='+dtype
						 +'&docrangefrom='+docrangefrom+'&docrangeto='+docrangeto+'&amtrangefrom='+amtrangefrom+'&amtrangeto='+amtrangeto+'&chk='+chk);
		 } else if(dtype=='BRV' || dtype=='BPV' || dtype=='IBR' || dtype=='IBP'){
			 $("#unclearedChqDiv").prop("hidden", true);$("#securityChqDiv").prop("hidden", true);$("#contraDiv").prop("hidden", true);$("#creditDiv").prop("hidden", true);$("#bankDiv").prop("hidden", false);$("#cashDiv").prop("hidden", true);$("#journalDiv").prop("hidden", true);
			 $("#bankDiv").load("bankVoucher.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&accdocno='+accdocno+'&dtype='+dtype
					 +'&docrangefrom='+docrangefrom+'&docrangeto='+docrangeto+'&amtrangefrom='+amtrangefrom+'&amtrangeto='+amtrangeto+'&chk='+chk);
	     } else if(dtype=='CNO' || dtype=='DNO'){
	    	 $("#unclearedChqDiv").prop("hidden", true);$("#securityChqDiv").prop("hidden", true);$("#contraDiv").prop("hidden", true);$("#creditDiv").prop("hidden", false);$("#bankDiv").prop("hidden", true);$("#cashDiv").prop("hidden", true);$("#journalDiv").prop("hidden", true);
			 $("#creditDiv").load("creditVoucher.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&accdocno='+accdocno+'&dtype='+dtype
					 +'&docrangefrom='+docrangefrom+'&docrangeto='+docrangeto+'&amtrangefrom='+amtrangefrom+'&amtrangeto='+amtrangeto+'&chk='+chk);
	     } else if(dtype=='COT'){
	    	 $("#unclearedChqDiv").prop("hidden", true);$("#securityChqDiv").prop("hidden", true);$("#contraDiv").prop("hidden", false);$("#creditDiv").prop("hidden", true);$("#bankDiv").prop("hidden", true);$("#cashDiv").prop("hidden", true);$("#journalDiv").prop("hidden", true);
			 $("#contraDiv").load("contraTransVoucher.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&accdocno='+accdocno+'&dtype='+dtype
					 +'&docrangefrom='+docrangefrom+'&docrangeto='+docrangeto+'&amtrangefrom='+amtrangefrom+'&amtrangeto='+amtrangeto+'&chk='+chk);
	     } else if(dtype=='SEC'){
	    	 $("#unclearedChqDiv").prop("hidden", true);$("#securityChqDiv").prop("hidden", false);$("#contraDiv").prop("hidden", true);$("#creditDiv").prop("hidden", true);$("#bankDiv").prop("hidden", true);$("#cashDiv").prop("hidden", true);$("#journalDiv").prop("hidden", true);
			 $("#securityChqDiv").load("securityCheque.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&accdocno='+accdocno+'&dtype='+dtype
					 +'&docrangefrom='+docrangefrom+'&docrangeto='+docrangeto+'&amtrangefrom='+amtrangefrom+'&amtrangeto='+amtrangeto+'&chk='+chk);
	     } else if(dtype=='UCP' || dtype=='UCR'){
			 $("#unclearedChqDiv").prop("hidden", false);$("#securityChqDiv").prop("hidden", true);$("#contraDiv").prop("hidden", true);$("#creditDiv").prop("hidden", true);$("#bankDiv").prop("hidden", true);$("#cashDiv").prop("hidden", true);$("#journalDiv").prop("hidden", true);
			 $("#unclearedChqDiv").load("unclearedVoucher.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&accdocno='+accdocno+'&dtype='+dtype
					 +'&docrangefrom='+docrangefrom+'&docrangeto='+docrangeto+'&amtrangefrom='+amtrangefrom+'&amtrangeto='+amtrangeto+'&chk='+chk);
	     }else {
	    	 $("#unclearedChqDiv").prop("hidden", true);$("#securityChqDiv").prop("hidden", true);$("#journalDiv").prop("hidden", false);$("#contraDiv").prop("hidden", true);$("#creditDiv").prop("hidden", true);$("#bankDiv").prop("hidden", true);$("#cashDiv").prop("hidden", true);
			 $("#journalDiv").load("journalVoucher.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&accdocno='+accdocno+'&dtype='+dtype
					 +'&docrangefrom='+docrangefrom+'&docrangeto='+docrangeto+'&amtrangefrom='+amtrangefrom+'&amtrangeto='+amtrangeto+'&chk='+chk);
		 }
	}
	
</script>
</head>
<body onload="getBranch();getDocumentType();">
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
                            <tr>
                                <td class="label-cell">To</td>
                                <td>
                                    <div id="todate" name="todate" value='<s:property value="todate"/>'></div>
                                </td>
                            </tr>  
                            <tr>
                                <td class="label-cell">Dtype</td>
                                <td>
                                    <select id="cmbdoctype" name="cmbdoctype" onchange="docTypeInfo();" value='<s:property value="cmbdoctype"/>'>
                                        <option value="">--Select--</option>
                                    </select>
                                    <input type="hidden" id="hidcmbdoctype" name="hidcmbdoctype" value='<s:property value="hidcmbdoctype"/>'/>
                                </td>
                            </tr>
                            <tr>
                                <td class="label-cell">Doc. Range</td>
                                <td>
                                    <div class="range-container">
                                        <input type="text" id="txtdocrangefrom" name="txtdocrangefrom" onkeypress="javascript:return isNumber(event)" value='<s:property value="txtdocrangefrom"/>'/>
                                        <span>-</span>
                                        <input type="text" id="txtdocrangeto" name="txtdocrangeto" onkeypress="javascript:return isNumber(event)" value='<s:property value="txtdocrangeto"/>'/>
                                    </div>
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
                                <td class="label-cell">Type</td>
                                <td>
                                    <select id="cmbtype" name="cmbtype" onchange="clearAccountInfo();" value='<s:property value="cmbtype"/>'>
                                        <option value="">--Select--</option>
                                        <option value="AP">AP</option>
                                        <option value="AR">AR</option>
                                        <option value="GL">GL</option>
                                        <option value="HR">HR</option>
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
                    
                    <div class="account-header">
                        Document Type : <span id="lbldoctype" name="lbldoctype"></span>
                    </div>
                    
                    <!-- Dynamic Grid Containers using flex wrapper class -->
                    <div id="cashDiv" class="flex-grid-wrapper"><jsp:include page="cashVoucher.jsp"></jsp:include></div>
                    <div id="bankDiv" class="flex-grid-wrapper" hidden="true"><jsp:include page="bankVoucher.jsp"></jsp:include></div>
                    <div id="creditDiv" class="flex-grid-wrapper" hidden="true"><jsp:include page="creditVoucher.jsp"></jsp:include></div>
                    <div id="journalDiv" class="flex-grid-wrapper" hidden="true"><jsp:include page="journalVoucher.jsp"></jsp:include></div>
                    <div id="contraDiv" class="flex-grid-wrapper" hidden="true"><jsp:include page="contraTransVoucher.jsp"></jsp:include></div>
                    <div id="securityChqDiv" class="flex-grid-wrapper" hidden="true"><jsp:include page="securityCheque.jsp"></jsp:include></div>
                    <div id="unclearedChqDiv" class="flex-grid-wrapper" hidden="true"><jsp:include page="unclearedVoucher.jsp"></jsp:include></div>
                    
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