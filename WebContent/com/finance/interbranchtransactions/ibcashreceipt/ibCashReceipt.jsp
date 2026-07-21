<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>

<style>
/* =========================================================
SCOPED UI: Modern Layout (Matches Client Master)
========================================================= */
body {
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    color: #222;
    margin: 0;
    padding: 24px 0;
    box-sizing: border-box;
    overflow-y: auto !important;
}

#mainBG {
    background: #fff;
    border-radius: 16px;
    padding: 15px;
    max-width: 100%;
    margin: 0 auto;
    box-shadow: 0 4px 24px rgba(0,0,0,0.06);
}

.modern-ui {
    font-family: Arial, sans-serif; 
    color: #333;
    font-size: 12px; 
    padding: 5px 15px;
    box-sizing: border-box;
    width: 100%;
}

/* Master Input Heights - Forced to 24px */
.modern-ui input[type="text"],
.modern-ui select { 
    height: 24px !important; 
    border: 1px solid #b8c6d8; 
    border-radius: 3px; 
    padding: 2px 6px;
    font-size: 12px;
    box-sizing: border-box; 
    background-color: #fff; 
    color: #333;
    width: 100%;
}

.modern-ui input[type="text"]:focus,
.modern-ui select:focus { 
    border-color: #007bff; 
    outline: none;
}

.modern-ui input[readonly],
.modern-ui input:disabled,
.modern-ui select:disabled { 
    background-color: #f8f9fa; 
    color: #6b7280;
}

/* Layout Utilities */
.modern-ui .field-row { 
    display: flex;
    align-items: center; 
    gap: 8px;
    margin-bottom: 10px; 
    flex-wrap: wrap;
}

.modern-ui .lbl-right { 
    text-align: right; 
    color: #444;
    font-size: 12px; 
    font-weight: bold;
    white-space: nowrap; 
    padding-right: 5px;
}

/* Middle Section Panels */
.modern-ui .middle-panel {
    border: 1px solid #c5d3e0; 
    padding: 20px 10px 10px 10px; 
    background: #ffffff; 
    position: relative; 
    border-radius: 4px; 
    margin-bottom: 15px;
    margin-top: 12px;
}

.modern-ui .middle-panel-title { 
    position: absolute; 
    top: -12px;
    left: 10px; 
    background: #ffffff; 
    padding: 0 8px; 
    color: #0056b3;
    font-weight: bold; 
    font-size: 14px; 
    border-left: 3px solid #0056b3;
    z-index: 2; 
    line-height: normal; 
}

/* Custom UI Buttons matching 24px height */
.modern-ui .myButton {
    height: 24px !important;
    line-height: 22px !important;
    padding: 0 12px;
    font-family: Arial, sans-serif;
    font-size: 11px;
    font-weight: bold;
    border-radius: 3px;
    cursor: pointer;
    text-shadow: none;
    transition: all 0.2s;
    box-shadow: 0 1px 2px rgba(0,0,0,0.1);
    border: none;
    background: linear-gradient(135deg, #0b45a2 0%, #2563eb 100%);
    color: #ffffff;
    white-space: nowrap;
}
.modern-ui .myButton:hover { background: linear-gradient(135deg, #083a8a 0%, #1d4ed8 100%); }

/* Search Icon Wrapper */
.modern-ui .input-search-container {
    position: relative;
    display: flex;
}
.modern-ui .input-search-container input {
    padding-right: 25px !important;
}
.modern-ui .magnifier-icon {
    position: absolute;
    right: 6px; 
    top: 50%;
    transform: translateY(-50%);
    cursor: pointer;
    color: #64748b; 
    z-index: 10;
}
.modern-ui .magnifier-icon:hover { color: #2563eb; }

/* Grid Wrappers */
.modern-ui .grid-container {
    border: 1px solid #c5d3e0;
    border-radius: 4px;
    background: #fff;
    overflow: hidden;
}

/* Scrollbar Logic */
.hidden-scrollbar {
    overflow-y: auto;
    height: calc(100vh - 120px);
    padding-right: 5px;
}
.hidden-scrollbar::-webkit-scrollbar { width: 6px; }
.hidden-scrollbar::-webkit-scrollbar-thumb { background: #c5d3e0; border-radius: 3px; }

form label.error { color:red; font-weight:bold; }
#errormsg { color:red; font-weight:bold; text-align:center; margin-bottom: 10px; }
</style>

<script type="text/javascript">
	$(document).ready(function() {
		 $("#btnvaluechange").hide();
		 
		 /* Formatted jqxDateTimeInput heights to match modern UI 24px */
		 $("#jqxIBCashReceiptDate").jqxDateTimeInput({ width: '125px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
		 $("#maindate").jqxDateTimeInput({ width: '125px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
		 
		 /* force internal alignment AFTER render */
		 setTimeout(function () {
		 	$("#jqxIBCashReceiptDate, #maindate").find("input").css({
		 		"margin-top": "0px",
		 		"line-height": "24px",
		 		"font-size": "12px", 
		 		"font-family": "Arial, sans-serif", 
		 		"padding": "0 6px", 
		 		"box-sizing":"border-box"
		 	});
		 	$("#jqxIBCashReceiptDate, #maindate").find(".jqx-action-button").css({
		 		"top": "0px",
		 		"height": "24px"
		 	});
		 }, 0);
		 
		 var popupConfig = {height: '58%', maxHeight: '70%', maxWidth: '51%', title: 'Search', position: { x: 300, y: 87 }, theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27};
		 $('#accountDetailsToWindow').jqxWindow($.extend({}, popupConfig, {width: '51%', title: 'Accounts Search'})).jqxWindow('close');  
		 $('#accountDetailsFromWindow').jqxWindow($.extend({}, popupConfig, {width: '51%', title: 'Accounts Search'})).jqxWindow('close');
		 $('#ibCashReceiptGridWindow').jqxWindow($.extend({}, popupConfig, {width: '51%', title: 'Accounts Search'})).jqxWindow('close');
		 $('#branchSearchWindow').jqxWindow($.extend({}, popupConfig, {width: '25%', maxWidth: '25%', title: 'Branch Search', position: { x: 420, y: 87 }})).jqxWindow('close');
 		 $('#costTypeSearchGridWindow').jqxWindow($.extend({}, popupConfig, {width: '25%', maxWidth: '25%', title: 'Cost Type Search', position: { x: 420, y: 87 }})).jqxWindow('close');
		 $('#costCodeSearchWindow').jqxWindow($.extend({}, popupConfig, {width: '25%', maxWidth: '25%', title: 'Cost Code Search', position: { x: 420, y: 87 }})).jqxWindow('close');
 		 
		 $('#txtfromaccid').dblclick(function(){
			  var date = $('#jqxIBCashReceiptDate').jqxDateTimeInput('getDate');
			  $("#maindate").jqxDateTimeInput('val', date);
			  accountFromSearchContent(<%=contextPath+"/"%>+"com/finance/accountsDetailsSearch.jsp?date="+date);
			  });
		 
		  $('#txttoaccid').dblclick(function(){
			  var date = $('#jqxIBCashReceiptDate').jqxDateTimeInput('getDate');
			  $("#maindate").jqxDateTimeInput('val', date);
			  accountToSearchContent(<%=contextPath+"/"%>+"com/finance/clientAccountDetailsSearch.jsp?atype="+$('#cmbtotype').val()+"&date="+date);
			  });  
			  
 		$('#jqxIBCashReceiptDate').on('change', function (event) {
			 var ibreceiptdate = $('#jqxIBCashReceiptDate').jqxDateTimeInput('getDate');
			 funDateInPeriod(ibreceiptdate);
		 });
	});
	
	function CashSearchContent(url) {
		$('#ibCashReceiptGridWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#ibCashReceiptGridWindow').jqxWindow('setContent', data);
		$('#ibCashReceiptGridWindow').jqxWindow('bringToFront');
	}); 
	} 
	
	function BranchSearchContent(url) {
		$('#branchSearchWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#branchSearchWindow').jqxWindow('setContent', data);
		$('#branchSearchWindow').jqxWindow('bringToFront');
	}); 
	} 
	
	function accountFromSearchContent(url) {
		    $('#accountDetailsFromWindow').jqxWindow('open');
			$.get(url).done(function (data) {
			$('#accountDetailsFromWindow').jqxWindow('setContent', data);
			$('#accountDetailsFromWindow').jqxWindow('bringToFront');
		}); 
		}
	
	function accountToSearchContent(url) {
		 	$('#accountDetailsToWindow').jqxWindow('open');
			$.get(url).done(function (data) {
			$('#accountDetailsToWindow').jqxWindow('setContent', data);
			$('#accountDetailsToWindow').jqxWindow('bringToFront');
		}); 
		}
	
	function costTypeSearchContent(url) {
	    $('#costTypeSearchGridWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#costTypeSearchGridWindow').jqxWindow('setContent', data);
		$('#costTypeSearchGridWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function costCodeSearchContent(url) {
	    $('#costCodeSearchWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#costCodeSearchWindow').jqxWindow('setContent', data);
		$('#costCodeSearchWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function funwarningopen(){
		$.messager.confirm('Confirm', 'Transaction will affect Links to the applied Bank Reconcilations & Prepayments.', function(r){
		    if (r){
		    	 $("#mode").val("EDIT");
				 $('#txtfromaccid').attr('readonly', true);$('#txtfromaccname').attr('readonly', true);$('#txtfromamount').attr('readonly', false);$('#txtdescription').attr('readonly', false);
				 $('#txttoaccid').attr('readonly', true);$('#txttoaccname').attr('readonly', true);$('#txttoamount').attr('readonly', false);$('#txtfromrate').attr('readonly', false);
			     $('#txtfrombaseamount').attr('readonly', true);$('#txttorate').attr('readonly', false);$('#txttobaseamount').attr('readonly', true);$('#txtapplyinvoiceamt').attr('readonly', true);
			     $('#txtapplyinvoiceapply').attr('readonly', true);$('#txtapplyinvoicebalance').attr('readonly', true);$('#txtdrtotal').attr('readonly', true);$('#txtcrtotal').attr('readonly', true);
				 $('#frmIbCashReceipt select').attr('disabled', false);$("#jqxApplyIbCashInvoicing").jqxGrid({ disabled: false});$("#jqxIbCashReceipt").jqxGrid({ disabled: false});     
		    }
		   });
	}
	  
	 function funReadOnly(){
			$('#frmIbCashReceipt input').attr('readonly', true );
			$('#frmIbCashReceipt select').attr('disabled', true);
			$('#jqxIBCashReceiptDate').jqxDateTimeInput({disabled: true});
			$("#jqxApplyIbCashInvoicing").jqxGrid({ disabled: true});
			$("#jqxIbCashReceipt").jqxGrid({ disabled: true});
			$("#btnvaluechange").hide();
	 }
	 
	 function funRemoveReadOnly(){
			getBranch();
			$('#frmIbCashReceipt input').attr('readonly', false );
			$('#frmIbCashReceipt select').attr('disabled', false);
			
			$('#txtfromaccid').attr('readonly', true );
			$('#txtfromaccname').attr('readonly', true );
			$('#txttoaccid').attr('readonly', true );
			$('#txttoaccname').attr('readonly', true );
			$('#txtapplyinvoiceamt').attr('readonly', true );
			$('#txtapplyinvoiceapply').attr('readonly', true );
			$('#txtapplyinvoicebalance').attr('readonly', true );
			$('#txtdrtotal').attr('readonly', true );
			$('#txtcrtotal').attr('readonly', true );
			$('#jqxIBCashReceiptDate').jqxDateTimeInput({disabled: false});
			$('#docno').attr('readonly', true);
			$("#jqxApplyIbCashInvoicing").jqxGrid({ disabled: false}); 
			$("#jqxIbCashReceipt").jqxGrid({ disabled: false});
			
			var date = $('#jqxIBCashReceiptDate').val();
		    getCurrencyId(date);
		    
			if ($("#mode").val() == "E") {
         	    $("#btnvaluechange").show();
         	    $('#frmIbCashReceipt input').attr('readonly', true );
   			    $('#frmIbCashReceipt select').attr('disabled', true);
   			    $("#jqxApplyIbCashInvoicing").jqxGrid({ disabled: true});
			    $("#jqxIbCashReceipt").jqxGrid({ disabled: true});
   			    $('#txtrefno').attr('readonly', false );
   			 	$('#txtdescription').attr('readonly', false );
   			 	$("#jqxIbCashReceipt").jqxGrid('addrow', null, {"docno": "","branch": "","brhid": "","type": "","accounts": "","accountname1": "","currency": "","currencyid": "","rate": "","costtype": "","costgroup": "","costcode": "","dr": true,"amount1": "","baseamount1": "","description": "","grtype": "","currencytype": "","sr_no":""});
			  }
			 else{
				$("#btnvaluechange").hide();
			} 
			
			if ($("#mode").val() == "A") {
				$('#jqxIBCashReceiptDate').val(new Date());
				$("#jqxIbCashReceipt").jqxGrid('clear'); 
				$("#jqxIbCashReceipt").jqxGrid('addrow', null, {"docno": "","branch": "","brhid": "","type": "","accounts": "","accountname1": "","currency": "","currencyid": "","rate": "","costtype": "","costgroup": "","costcode": "","dr": true,"amount1": "","baseamount1": "","description": "","grtype": "","currencytype": "","sr_no":""});
				$("#jqxApplyIbCashInvoicing").jqxGrid('clear');
				$("#jqxApplyIbCashInvoicing").jqxGrid('addrow', null, {});
			}
	 }
	 
	 function funSearchLoad(){
		changeContent('icrvMainSearch.jsp'); 
	 }
		
	 function funChkButton() {
			/* funReset(); */
		}
	 
	 function funFocus()
	    {
	    	$('#jqxIBCashReceiptDate').jqxDateTimeInput('focus'); 	    		
	    }
	 
	   $(function(){
	        $('#frmIbCashReceipt').validate({
	        	    rules: {
	                txtfromaccid:"required",
	                txtfromamount:{"required":true,number:true},
	                txttoamount:{number:true},
	                txtdescription:{maxlength:500}
	                 },
	                 messages: {
	                 txtfromaccid:" *",
	                 txtfromamount:{required:" *",number:"Invalid"},
	                 txttoamount:{number:"Invalid"},
	                 txtdescription: {maxlength:"    Max 500 chars"}
	                 }
	        });});
	   
	  function funNotify(){	
		  /* Validation */
		  
		    if(parseInt($('#brchName').val().trim())==parseInt($('#cmbtobranch').val().trim())){
			    document.getElementById("errormsg").innerText="Invalid Transaction !!! Main Branch and Inter-Branch should not be same.";
				return 0;
			}
			
		    var ibreceiptdate = $('#jqxIBCashReceiptDate').jqxDateTimeInput('getDate');
			var validdate=funDateInPeriod(ibreceiptdate);
			if(validdate==0){
			return 0;	
			}
			
			ibvalid=document.getElementById("txtibvalidation").value;
			 if(ibvalid==1){
				 document.getElementById("errormsg").innerText="Closing Done For Inter-Branch,Transaction Restricted. ";
				 return 0;
			 }
			 
			 valid=document.getElementById("txtvalidation").value;
			 if(valid==1){
				 document.getElementById("errormsg").innerText="Invalid Transaction !!!";
				 return 0;
			 }
			 
			 currency=document.getElementById("cmbfromcurrency").value;
			 if(currency==""){
				 document.getElementById("errormsg").innerText="Currency & Rate is Mandatory.";
				 return 0;
			 }
			 
			 currencyto=document.getElementById("cmbtocurrency").value;
			 acnoto=document.getElementById("txttoaccid").value;
			 if(currencyto=="" && acnoto!=""){
				 document.getElementById("errormsg").innerText="Currency & Rate is Mandatory.";
				 return 0;
			 }
		  
		    var drtot = parseFloat(document.getElementById("txtdrtotal").value);
	 		var crtot = parseFloat(document.getElementById("txtcrtotal").value);
	 		if(drtot>crtot || drtot<crtot){
	 			document.getElementById("errormsg").innerText="Invalid Transaction !!! Credit and Debit should be Equal.";
           return 0;
	 		}
	 		
	 		if(drtot=="" || crtot=="" || drtot=="NaN" || crtot=="NaN" || drtot==0 || crtot==0 || drtot==0.0 || crtot==0.0 || drtot==0.00 || crtot==0.00){
	 			 document.getElementById("errormsg").innerText="Invalid Transaction !!! Credit and Debit should not be Zero.";
	              return 0;
		 		}
	    	document.getElementById("errormsg").innerText="";
	    		
	    /* Validation Ends*/
	    		
	     /* Cash Receipt Grid  Saving*/
		  var rows = $("#jqxIbCashReceipt").jqxGrid('getrows');
		  var length=0;
		  for(var i=0 ; i < rows.length ; i++){
			    var chk=rows[i].docno;
			    if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){
					newTextBox = $(document.createElement("input"))
				    .attr("type", "dil")
				    .attr("id", "test"+length)
				    .attr("name", "test"+length)
				    .attr("hidden", "true");
					length=length+1;
					
					var amount,baseamount;
					if(rows[i].dr==true){
						 amount=rows[i].amount1*-1;
						 baseamount=rows[i].baseamount1*-1;
					}
					else if(rows[i].dr==false){
						 amount=rows[i].amount1;
						 baseamount=rows[i].rate*rows[i].amount1;
					}
					
				newTextBox.val(rows[i].docno+"::"+rows[i].currencyid+"::"+rows[i].rate+"::"+rows[i].dr+"::"+amount+"::"+rows[i].description+"::"+baseamount+"::0:: "+rows[i].costtype+":: "+rows[i].costcode+"::"+rows[i].brhid);
				newTextBox.appendTo('form');
				}
		  }
		  $('#gridlength').val(length);
	 		   /* Cash Receipt Grid  Saving Ends*/	 
	 		
	 		/* Applying Invoice Grid Saving */
	 		 var rows = $("#jqxApplyIbCashInvoicing").jqxGrid('getrows');
	 		 var lengthapply=0;
			 for(var i=0 ; i < rows.length ; i++){
				    var chks=rows[i].applying;
	  				if(typeof(chks) != "undefined" && typeof(chks) != "NaN" && chks != ""){
					newTextBox = $(document.createElement("input"))
				    .attr("type", "dil")
				    .attr("id", "txtapply"+lengthapply)
				    .attr("name", "txtapply"+lengthapply)
				    .attr("hidden", "true");
					lengthapply=lengthapply+1;
					
				newTextBox.val(rows[i].applying+"::"+parseFloat(rows[i].out_amount+rows[i].applying)+"::"+rows[i].currency+"::"+rows[i].tranid+"::"+rows[i].acno);
				newTextBox.appendTo('form');
				}
	  		  }
	  		 $('#applylength').val(lengthapply);
			 /* Applying Invoice Grid Saving Ends*/
			 
			 /* Applying Invoice Grid Updating */
		 		var rows = $("#jqxApplyIbCashInvoicing").jqxGrid('getrows');
		 		var lengthupdate=0;
				 for(var i=0 ; i < rows.length ; i++){
					 var chkd=rows[i].applying;
		  				if(typeof(chkd) != "undefined" && typeof(chkd) != "NaN" && chkd != ""){
						newTextBox = $(document.createElement("input"))
					    .attr("type", "dil")
					    .attr("id", "txtapplyupdate"+lengthupdate)
					    .attr("name", "txtapplyupdate"+lengthupdate)
					    .attr("hidden", "true");
						lengthupdate=lengthupdate+1;
						
					newTextBox.val(parseFloat(rows[i].out_amount-rows[i].applying)+"::"+rows[i].tranid);
					newTextBox.appendTo('form');
					}
	  			  }
	 			 $('#applylengthupdate').val(lengthupdate);
				 /* Applying Invoice Grid Updating Ends*/
				 
	    		return 1;	
		} 
	  
	  function setValues(){
		  getBranch();
		  
		  $('#jqxIBCashReceiptDate').jqxDateTimeInput({disabled: false});
		  var date = $('#jqxIBCashReceiptDate').val();
		  getCurrencyId(date);
		  $('#jqxIBCashReceiptDate').jqxDateTimeInput({disabled: true});
		  
		  document.getElementById("cmbtotype").value=document.getElementById("hidcmbtotype").value;
		  
		  if($('#hidjqxIBCashReceiptDate').val()){
				 $("#jqxIBCashReceiptDate").jqxDateTimeInput('val', $('#hidjqxIBCashReceiptDate').val());
			  }
		  
		  if($('#hidmaindate').val()){
				 $("#maindate").jqxDateTimeInput('val', $('#hidmaindate').val());
			  }
		  
	      if($('#msg').val()!=""){
				   $.messager.alert('Message',$('#msg').val());
				  }
			   
		  document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		  funSetlabel();
			
			 var indexVal = document.getElementById("docno").value;
			 if(indexVal>0){
	         $("#jqxIBCashReceiptGrid").load("ibCashReceiptGrid.jsp?txtcashreceiptdocno2="+indexVal);
			 }
	         var indexVal1 = document.getElementById("txttodocno").value;
	         var indexVal2 = document.getElementById("txttotrno").value;
	         if(indexVal1>0){
	         $("#jqxIbCashApplyInvoicing1").load("applyIbCashReceiptInvoicingGrid.jsp?txttoaccid1="+indexVal1+"&txttotrno1="+indexVal2); 
	         }
		}
	  
	  function getBranch() {
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText;
  				items = items.split('####');
  				var branchIdItems  = items[0].split(",");
  				var branchItems = items[1].split(",");
  				var optionsbranch = '<option value=""></option>';
  				for (var i = 0; i < branchItems.length; i++) {
  					optionsbranch += '<option value="' + branchIdItems[i] + '">'
  							+ branchItems[i] + '</option>';
  				}
  				$("select#cmbtobranch").html(optionsbranch);
  				if ($('#hidcmbtobranch').val() != null) {
  					$('#cmbtobranch').val($('#hidcmbtobranch').val());
  				}
  			} else {
  			}
  		}
  		x.open("GET", <%=contextPath+"/"%>+"com/finance/interbranchtransactions/getBranch.jsp", true);
  		x.send();
  	}

	  function getDrTotal(){
		  var fromamount = $('#txtfrombaseamount').val();
		  
		  if(!isNaN(fromamount)){
			  
		  var dr=0.0,cr=0.0,dr1=0.0;
  	      var rows = $('#jqxIbCashReceipt').jqxGrid('getrows');
	      var rowlength= rows.length;
	  		for(var i=0;i<=rowlength-1;i++) {
	  		
	  		  var value = rows[i].dr;
	          var baseamount = rows[i].baseamount1;
	          
	          if(typeof(baseamount) != "undefined" && typeof(baseamount) != "NaN" && baseamount != ""){
	        	  if(value==true){
               	   if(!isNaN(baseamount)){
               	      cr=cr+baseamount;
               	   }else if(isNaN(baseamount)){
                 		 baseamount=0.00;
                 		 cr=cr+baseamount;
                 	   }
                  }
                  else{
               	   if(!isNaN(baseamount)){
                    	  	dr=dr+baseamount;
                  	   }else if(isNaN(baseamount)){
                  		    baseamount=0.00;
                  		 	dr=dr+baseamount;
                  	   }
                    }
	  	       }
	  		}
	  		
	  		if(!isNaN(fromamount)){
               	dr1=parseFloat(dr) + parseFloat(fromamount);
                funRoundAmt(dr1,"txtdrtotal");
           	 }
	      }
		  else if(isNaN(fromamount)){
			$('#txtdrtotal').val(0.00);
			$('#txtfrombaseamount').val(0.00);			
		}
	  } 
	  
	  function getCrTotal(){
		  var toamount = $('#txttobaseamount').val();
		  if(!isNaN(toamount)){
			  
			    var dr=0.0,cr=0.0,cr1=0.0;
        	    var rows = $('#jqxIbCashReceipt').jqxGrid('getrows');
    	        var rowlength= rows.length;
        		for(var i=0;i<=rowlength-1;i++) {
        		
        		var value = rows[i].dr;
                var baseamount = rows[i].baseamount1;
                
                if(typeof(baseamount) != "undefined" && typeof(baseamount) != "NaN" && baseamount != ""){
                	 if(value==true){
                  	   if(!isNaN(baseamount)){
                  	      cr=cr+baseamount;
                  	   }else if(isNaN(baseamount)){
                    		 baseamount=0.00;
                    		 cr=cr+baseamount;
                    	   }
                     }
                     else{
                  	   if(!isNaN(baseamount)){
                       	  	dr=dr+baseamount;
                     	   }else if(isNaN(baseamount)){
                     		    baseamount=0.00;
                     		 	dr=dr+baseamount;
                     	   }
                       }
        	       }
        		}
        		
        		if(!isNaN(toamount)){
                    cr1=parseFloat(cr) + parseFloat(toamount);
                    funRoundAmt(cr1,"txtcrtotal");
                    }
		  }
		  else if(isNaN(toamount)){
		  	$('#txtcrtotal').val(0.00);
		  	$('#txttoamount').val(0.00);
		  }
	  } 
	  
	  function getAmount(){
		  var toamount = $('#txttoamount').val();
		  if(!isNaN(toamount)){
		  $('#txtapplyinvoiceamt').val(toamount);
		  }
		  else if(isNaN(toamount)){
			  $('#txtapplyinvoiceamt').val(0.00);
			  $('#txttoamount').val(0.00);
			}
	  }
	  
	  function getAcc(event){
          var x= event.keyCode;
          if(x==114){
        	  var date = $('#jqxIBCashReceiptDate').jqxDateTimeInput('getDate');
        	  $("#maindate").jqxDateTimeInput('val', date);
        	  accountFromSearchContent(<%=contextPath+"/"%>+"com/finance/accountsDetailsSearch.jsp?date="+date);
          }
          else{}
          }
	  
	  function getAccType(event){
          var x= event.keyCode;
          if(x==114){
        	  var date = $('#jqxIBCashReceiptDate').jqxDateTimeInput('getDate');
        	  $("#maindate").jqxDateTimeInput('val', date);
        	  accountToSearchContent(<%=contextPath+"/"%>+"com/finance/clientAccountDetailsSearch.jsp?atype="+$('#cmbtotype').val()+"&date="+date);
          }
          else{}
          }
	  
	  function funPrintBtn() {
			
			if (($("#mode").val() == "view") && $("#docno").val()!="") {
		        var url=document.URL;
		        var reurl=url.split("saveIbCashReceipt");
		        $("#docno").prop("disabled", false);  
		     
		        $.messager.confirm('Confirm', 'Do you want to have header?', function(r){
					if (r){
						 var win= window.open(reurl[0]+"printIBCashReceipt?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
					     win.focus();
					 }
					else{
						var win= window.open(reurl[0]+"printIBCashReceipt?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=0","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
					    win.focus();
					}
				   });
		     }
		    else {
				$.messager.alert('Message','Select a Document....!','warning');
				return;
			}
	    }
	  
	  function clearClientInfo(){
		  $("#txttodocno").val('');$("#txttoaccid").val('');$("#txttoaccname").val('');$("#txtapplyinvoiceapply").val(0.00);
		  $("#jqxApplyIbCashInvoicing").jqxGrid('clear');
		  $("#jqxApplyIbCashInvoicing").jqxGrid('addrow', null, {});
		  var atype=$('#cmbtotype').val();
      	  if(atype != "AR"){
      		$("#jqxApplyIbCashInvoicing").jqxGrid({ disabled: true});
      	  }else if(atype == "AR"){
      		$("#jqxApplyIbCashInvoicing").jqxGrid({ disabled: false});
      	  }
		  if (document.getElementById("txttoaccid").value == "") {
		        $('#txttoaccid').attr('placeholder', 'Press F3 to Search'); 
		  }
	  }
	  
	  function datechange(){
		  var date = $('#jqxIBCashReceiptDate').jqxDateTimeInput('getDate');
		  var validdate=funDateInPeriod(date);
			if(validdate==0){
				return 0;	
			}
		  $("#maindate").jqxDateTimeInput('val', date);
		  
		   if($('#cmbtobranch').val()!='' && $('#cmbtobranch').val()!=null){
			  	funIBDateInPeriod($('#jqxIBCashReceiptDate').val(),$('#cmbtobranch').val());
				
				if(parseInt($('#brchName').val().trim())==parseInt($('#cmbtobranch').val().trim())){
					document.getElementById("errormsg").innerText="Invalid Transaction !!! Main Branch and Inter-Branch should not be same.";
					return 0;
				}
				document.getElementById("errormsg").innerText="";
		  }
	  }
	  
</script>

</head>
<body onload="setValues();getBranch();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmIbCashReceipt" action="saveIbCashReceipt" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include>

<div class='modern-ui hidden-scrollbar'>
    <div id="errormsg"></div>

    <div class="middle-panel">
        <span class="middle-panel-title">IB Cash Receipt Details</span>
        
        <div class="field-row">
            <label class="lbl-right" style="width:80px;">Date</label>
            <div style="width: 125px;">
                <div id="jqxIBCashReceiptDate" name="jqxIBCashReceiptDate" onchange="datechange();" value='<s:property value="jqxIBCashReceiptDate"/>'></div>
            </div>
            <input type="hidden" id="hidjqxIBCashReceiptDate" name="hidjqxIBCashReceiptDate" value='<s:property value="hidjqxIBCashReceiptDate"/>'/>
            
            <label class="lbl-right" style="width:80px; margin-left:auto;">Ref. No.</label>
            <input type="text" id="txtrefno" name="txtrefno" style="width:125px;" value='<s:property value="txtrefno"/>'/>
            
            <label class="lbl-right" style="width:80px;">Doc No.</label>
            <input type="text" id="docno" name="txtibcashreceiptdocno" style="width:125px;" value='<s:property value="txtibcashreceiptdocno"/>' tabindex="-1" readonly/>
            
            <button class="myButton" type="button" id="btnvaluechange" name="btnvaluechange" onclick="funwarningopen();" style="margin-left: 10px;">Value Change</button>
        </div>
    </div>

    <div style="display: flex; gap: 15px;">
        <div class="middle-panel" style="flex: 1; margin-bottom: 0;">
            <span class="middle-panel-title">Cash</span>
            
            <div class="field-row">
                <label class="lbl-right" style="width:80px;">Cash</label>
                <div class="input-search-container" style="width: 125px;">
                    <input type="text" id="txtfromaccid" name="txtfromaccid" placeholder="Press F3" value='<s:property value="txtfromaccid"/>' onkeydown="getAcc(event);"/>
                    <svg class="magnifier-icon" onclick="$('#txtfromaccid').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                </div>
                <input type="text" id="txtfromaccname" name="txtfromaccname" style="flex:1;" value='<s:property value="txtfromaccname"/>' tabindex="-1" readonly/>
                <input type="hidden" id="txtfromdocno" name="txtfromdocno" value='<s:property value="txtfromdocno"/>'/>
            </div>
            
            <div class="field-row">
                <label class="lbl-right" style="width:80px;">Currency</label>
                <select id="cmbfromcurrency" name="cmbfromcurrency" style="width:125px;" value='<s:property value="cmbfromcurrency"/>' onchange="getRate(this.value,$('#jqxIBCashReceiptDate').val());">
                    <option></option>
                </select>
                <input type="hidden" id="hidcmbfromcurrency" name="hidcmbfromcurrency" value='<s:property value="hidcmbfromcurrency"/>'/>
                <input type="hidden" id="hidfromcurrencytype" name="hidfromcurrencytype" value='<s:property value="hidfromcurrencytype"/>'/>
                
                <label class="lbl-right" style="width:80px; margin-left:auto;">Rate</label>
                <input type="text" id="txtfromrate" name="txtfromrate" style="width:120px; text-align:right;" value='<s:property value="txtfromrate"/>' tabindex="-1" readonly/>
            </div>
            
            <div class="field-row">
                <label class="lbl-right" style="width:80px;">Amount</label>
                <input type="text" id="txtfromamount" name="txtfromamount" style="width:125px; text-align:right;" value='<s:property value="txtfromamount"/>' onblur="funRoundAmt(this.value,this.id);getBaseAmountFrom();getDrTotal();" />
                
                <label class="lbl-right" style="width:80px; margin-left:auto;">Base Amount</label>
                <input type="text" id="txtfrombaseamount" name="txtfrombaseamount" style="width:120px; text-align:right;" value='<s:property value="txtfrombaseamount"/>' tabindex="-1" readonly/>
            </div>
            
            <div class="field-row" style="margin-bottom:0;">
                <label class="lbl-right" style="width:80px;">Description</label>
                <input type="text" id="txtdescription" name="txtdescription" style="flex:1;" value='<s:property value="txtdescription"/>'/>
            </div>
        </div>

        <div class="middle-panel" style="flex: 1; margin-bottom: 0;">
            <span class="middle-panel-title">Payment From</span>
            
            <div class="field-row">
                <label class="lbl-right" style="width:80px;">Branch</label>
                <select id="cmbtobranch" name="cmbtobranch" style="flex:1;" onchange="funIBDateInPeriod($('#jqxIBCashReceiptDate').val(),this.value);" value='<s:property value="cmbtobranch"/>'>
                    <option></option>
                </select>
                <input type="hidden" id="hidcmbtobranch" name="hidcmbtobranch" value='<s:property value="hidcmbtobranch"/>'/>
                
                <label class="lbl-right" style="width:50px;">Type</label>
                <select id="cmbtotype" name="cmbtotype" style="width:80px;" onchange="clearClientInfo();" value='<s:property value="cmbtotype"/>'>
                    <option value="AR">AR</option>
                    <option value="AP">AP</option>
                </select>
                <input type="hidden" id="hidcmbtotype" name="hidcmbtotype" value='<s:property value="hidcmbtotype"/>'/>
            </div>
            
            <div class="field-row">
                <label class="lbl-right" style="width:80px;">Account</label>
                <div class="input-search-container" style="width: 125px;">
                    <input type="text" id="txttoaccid" name="txttoaccid" placeholder="Press F3" value='<s:property value="txttoaccid"/>' onkeydown="getAccType(event);"/>
                    <svg class="magnifier-icon" onclick="$('#txttoaccid').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                </div>
                <input type="text" id="txttoaccname" name="txttoaccname" style="flex:1;" value='<s:property value="txttoaccname"/>' tabindex="-1" readonly/>
                <input type="hidden" id="txttodocno" name="txttodocno" value='<s:property value="txttodocno"/>'/>
                <input type="hidden" id="txttotranid" name="txttotranid" value='<s:property value="txttotranid"/>'/>
                <input type="hidden" id="txttotrno" name="txttotrno" value='<s:property value="txttotrno"/>'/>
            </div>
            
            <div class="field-row">
                <label class="lbl-right" style="width:80px;">Currency</label>
                <select id="cmbtocurrency" name="cmbtocurrency" style="width:125px;" value='<s:property value="cmbtocurrency"/>' onchange="getRatevalue(this.value,$('#jqxIBCashReceiptDate').val());">
                    <option></option>
                </select>
                <input type="hidden" id="hidcmbtocurrency" name="hidcmbtocurrency" value='<s:property value="hidcmbtocurrency"/>'/>
                <input type="hidden" id="hidtocurrencytype" name="hidtocurrencytype" value='<s:property value="hidtocurrencytype"/>'/>
                
                <label class="lbl-right" style="width:80px; margin-left:auto;">Rate</label>
                <input type="text" id="txttorate" name="txttorate" style="width:120px; text-align:right;" value='<s:property value="txttorate"/>' tabindex="-1" readonly/>
            </div>
            
            <div class="field-row" style="margin-bottom:0;">
                <label class="lbl-right" style="width:80px;">Amount</label>
                <input type="text" id="txttoamount" name="txttoamount" style="width:125px; text-align:right;" value='<s:property value="txttoamount"/>' onblur="funRoundAmt(this.value,this.id);getBaseAmountTo();getAmount();getCrTotal();" />
                
                <label class="lbl-right" style="width:80px; margin-left:auto;">Base Amount</label>
                <input type="text" id="txttobaseamount" name="txttobaseamount" style="width:120px; text-align:right;" value='<s:property value="txttobaseamount"/>' tabindex="-1" readonly/>
            </div>
        </div>
    </div>

    <div class="middle-panel">
        <span class="middle-panel-title">Apply Invoices</span>
        <div id="jqxIbCashApplyInvoicing1" class="grid-container" style="margin-bottom: 10px;">
            <jsp:include page="applyIbCashReceiptInvoicingGrid.jsp"></jsp:include>
        </div> 
        
        <div class="field-row" style="margin-bottom:0;">
            <label class="lbl-right" style="width:80px;">Amount</label>
            <input type="text" id="txtapplyinvoiceamt" name="txtapplyinvoiceamt" style="width:125px; text-align:right;" value='<s:property value="txtapplyinvoiceamt"/>'/>
            <input type="hidden" id="txtvalidation" name="txtvalidation" value='<s:property value="txtvalidation"/>'/>
            
            <label class="lbl-right" style="width:80px; margin-left:auto;">Applied</label>
            <input type="text" id="txtapplyinvoiceapply" name="txtapplyinvoiceapply" style="width:125px; text-align:right;" value='<s:property value="txtapplyinvoiceapply"/>' tabindex="-1" readonly/>
            
            <label class="lbl-right" style="width:80px; margin-left:auto;">Balance</label>
            <input type="text" id="txtapplyinvoicebalance" name="txtapplyinvoicebalance" style="width:125px; text-align:right;" value='<s:property value="txtapplyinvoicebalance"/>' tabindex="-1" readonly/>
        </div>
    </div>

    <div class="middle-panel">
        <span class="middle-panel-title">Details</span>
        <div id="jqxIBCashReceiptGrid" class="grid-container">
            <jsp:include page="ibCashReceiptGrid.jsp"></jsp:include>
        </div>
        
        <div class="field-row" style="justify-content:flex-end; margin-top:15px; margin-bottom:0;">
            <label class="lbl-right" style="width:80px;">Dr. Total</label>
            <input type="text" id="txtdrtotal" name="txtdrtotal" style="width:150px; text-align:right; font-weight:bold; color:#0b45a2;" value='<s:property value="txtdrtotal"/>' readonly/>
            
            <label class="lbl-right" style="width:80px; margin-left:20px;">Cr. Total</label>
            <input type="text" id="txtcrtotal" name="txtcrtotal" style="width:150px; text-align:right; font-weight:bold; color:#0b45a2;" value='<s:property value="txtcrtotal"/>' tabindex="-1" readonly/>
        </div>
    </div>

    <!-- Hidden Logic Fields -->
    <div style="display:none;">
        <input type="hidden" id="mode" name="mode"/>
        <input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
        <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
        <input type="hidden" name="txtforsearch" id="txtforsearch" value="0"/>
        <div id="maindate" name="maindate" value='<s:property value="maindate"/>'></div>
        <input type="hidden" id="hidmaindate" name="hidmaindate" value='<s:property value="hidmaindate"/>'/>
        <input type="hidden" id="txtibvalidation" name="txtibvalidation" value='<s:property value="txtibvalidation"/>'/>
        <input type="hidden" id="gridlength" name="gridlength"/>
        <input type="hidden" id="applylength" name="applylength"/>
        <input type="hidden" id="applylengthupdate" name="applylengthupdate"/>
    </div>

</div>
</form>
	
<!-- Search Windows -->
<div id="ibCashReceiptGridWindow"><div></div><div></div></div>  
<div id="accountDetailsFromWindow"><div></div><div></div></div>  
<div id="accountDetailsToWindow"><div></div><div></div></div>
<div id="branchSearchWindow"><div></div><div></div></div>
<div id="costTypeSearchGridWindow"><div></div><div></div></div> 
<div id="costCodeSearchWindow"><div></div><div></div></div> 

</div>
</body>
</html>