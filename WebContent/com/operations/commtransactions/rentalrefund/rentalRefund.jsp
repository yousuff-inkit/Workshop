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

<script type="text/javascript">
$(document).ready(function() {
	
	 $("#jqxRentalRefundDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
	 $("#maindate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
	 $("#jqxReferenceDate").jqxDateTimeInput({ width: '110px', height: '15px', formatString:"dd.MM.yyyy"});		 

	 $('#accountDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 $('#accountDetailsWindow').jqxWindow('close'); 
	 
	 $('#agreementDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Agreement Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 $('#agreementDetailsWindow').jqxWindow('close');
	 
	 $('#clientDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Client Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 $('#clientDetailsWindow').jqxWindow('close'); 
	 
	 $('#cardDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Card Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 $('#cardDetailsWindow').jqxWindow('close');
	 
	 $('#printWindow').jqxWindow({width: '31%', height: '28%',  maxHeight: '70%' ,maxWidth: '31%' , title: 'Print',position: { x: 400, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 $('#printWindow').jqxWindow('close');
	 
	 $('#txtaccid').dblclick(function(){
		  var date = $('#jqxRentalRefundDate').jqxDateTimeInput('getDate');
 	  	  $("#maindate").jqxDateTimeInput('val', date);
 	  	  accountSearchContent(<%=contextPath+"/"%>+"com/operations/accountsDetailsSearch.jsp?date="+date);
		  });
	 
	  $('#txtagreementvocher').dblclick(function(){
		  agreementSearchContent('agreementSearch.jsp?clientId='+$('#txtcldocno').val());
		  });
	 
	  $('#txtclientid').dblclick(function(){
		  var date = $('#jqxRentalRefundDate').jqxDateTimeInput('getDate');
		  $("#maindate").jqxDateTimeInput('val', date);
		  clientSearchContent(<%=contextPath+"/"%>+"com/operations/clientAccountDetailsSearch.jsp?atype=AR"+"&date="+date);
          $('#txtforsearch').val(1);
	 });
});

function getBranch() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var branchIdItems  = items[0].split(",");
				var branchItems = items[1].split(",");
				var optionsbranch = '<option value="">--Select--</option>';
				for (var i = 0; i < branchItems.length; i++) {
					optionsbranch += '<option value="' + branchIdItems[i].trim() + '">'
							+ branchItems[i] + '</option>';
				}
				$("select#cmbbranch").html(optionsbranch);
				if ($('#hidcmbbranch').val() != null) {
					$('#cmbbranch').val($('#hidcmbbranch').val());
				}
			} else {
			}
		}
		x.open("GET", <%=contextPath+"/"%>+"com/operations/commtransactions/getBranch.jsp", true);
		x.send();
	}
	
	function accountSearchContent(url) {
	 	$('#accountDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#accountDetailsWindow').jqxWindow('setContent', data);
		$('#accountDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function agreementSearchContent(url) {
	 	$('#agreementDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#agreementDetailsWindow').jqxWindow('setContent', data);
		$('#agreementDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function clientSearchContent(url) {
	 	$('#clientDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#clientDetailsWindow').jqxWindow('setContent', data);
		$('#clientDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function cardSearchContent(url) {
	 	$('#cardDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#cardDetailsWindow').jqxWindow('setContent', data);
		$('#cardDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function RefundPrintContent(url) {
		$('#printWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#printWindow').jqxWindow('setContent', data);
		$('#printWindow').jqxWindow('bringToFront');
	}); 
	} 
	
	function checkIb(){
		 if(document.getElementById("hidchckib").value==1){
			 document.getElementById("chckib").checked = true;
		 }
		 else if(document.getElementById("hidchckib").value==0){
			document.getElementById("chckib").checked = false;
		  }
		 }
	
	 function funReadOnly(){
			$('#frmRentalRefund input').attr('readonly', true );
			$('#frmRentalRefund select').attr('disabled', true);
			$('#chckib').attr('disabled', true);
			$('#jqxRentalRefundDate').jqxDateTimeInput({disabled: true});
			$('#jqxReferenceDate').jqxDateTimeInput({disabled: true});
			$('#btnCardSearch').attr('disabled', true);
			$("#jqxSecurity").jqxGrid({ disabled: true});
	 }
	 function funRemoveReadOnly(){
		    getBranch();getCardTypes();checkIb();
			$('#frmRentalRefund input').attr('readonly', false );
			$('#frmRentalRefund select').attr('disabled', false);
			$('#chckib').attr('disabled', false);
			$('#jqxRentalRefundDate').jqxDateTimeInput({disabled: false});
			$('#jqxReferenceDate').jqxDateTimeInput({disabled: false});
			$('#docno').attr('readonly', true);
			$('#txtdoctype').attr('readonly', true);
			$('#txtsrno').attr('readonly', true);
			$('#txtaccid').attr('readonly', true);
			$('#txtaccname').attr('readonly', true);
			$('#txtclientid').attr('readonly', true);
			$('#txtclientname').attr('readonly', true);
			$('#txtagreementvocher').attr('readonly', true);
			$('#txtnetamount').attr('readonly', true ); 
			$('#txtchequeno').attr('readonly', true);
			$('#cmbbranch').attr('disabled', true);
			$('#txtamount').attr('readonly', true);
			$("#jqxSecurity").jqxGrid({ disabled: false});
			
		    if ($("#mode").val() == "E") {
			    $('#cmbpaytype').attr('disabled', true);
				$('#chckib').attr('disabled', true);
				$('#cmbbranch').attr('disabled', true);
				$('#txtaccid').attr('readonly', true);
				$('#txtaccname').attr('readonly', true);
				$('#cmbcardtype').attr('disabled', true);
			} 
			
			if ($("#mode").val() == "A") {
				$('#jqxRentalRefundDate').val(new Date());
				$('#jqxReferenceDate').val(new Date());
				$("#jqxSecurity").jqxGrid('clear');
				$("#jqxSecurity").jqxGrid('addrow', null, {});
				$('#cmbpaytype').val('');$('#cmbcardtype').val('');$('#cmbratype').val('');$('#cmbpayedas').val('');
				$('#txtaccid').attr('placeholder','');
			}
	 }
	
	function funSearchLoad(){
	      changeContent('rrpMainSearch.jsp');  
	}
		
	 function funChkButton() {
			/* funReset(); */
	}
	 
	function funFocus(){
	    	$('#jqxRentalRefundDate').jqxDateTimeInput('focus'); 	    		
	}
	
	 /* Validations */
	 $(function(){
	    $('#frmRentalRefund').validate({
	    	    rules: {
	            txtamount:{number:true},
	            txtdeduction:{number:true},
				txtaddamount:{number:true},
	            txtnetamount:{number:true},
	            txtonaccountamount:{number:true},
	            txtdescription:{maxlength:500},
	            txtdescriptions:{maxlength:500},
	            cmbpayedas:"required"
	             },
	             messages: {
	             txtamount:{number:"Invalid"},
	             txtdeduction:{number:"Invalid"},
				 txtaddamount:{number:"Invalid"},
	             txtnetamount:{number:"Invalid"},
	             txtonaccountamount:{number:"Invalid"},
	             txtdescription: {maxlength:"    Max 500 chars"},
	             txtdescriptions: {maxlength:"    Max 500 chars"},
	             cmbpayedas:"*"
	             }
	 });}); 
	
    function funNotify(){	
    	/* Validation */
		
		var paydate = $('#jqxRentalRefundDate').jqxDateTimeInput('getDate');
		var validdate=funDateInPeriod(paydate);
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
		 
		if($('#hidchckib').val()==1){
			 mainbranch=document.getElementById("brchName").value;
			 ibbranch=document.getElementById("cmbbranch").value;
			 if(mainbranch==ibbranch){
				 document.getElementById("errormsg").innerText="Main branch & Inter-Branch need to be Different,Transaction Restricted.";
				 return 0;
			 }
		}
		 
		 document.getElementById("errormsg").innerText="";
		 /* Validation Ends*/
    	 
    	/* Security Grid Saving */
 		var rows = $("#jqxSecurity").jqxGrid('getrows');
		var length=0;
		 for(var i=0 ; i < rows.length ; i++){
			var chk=rows[i].tobepaid;
			if(typeof(chk) != "undefined"){
				length=length+1;
				newTextBox = $(document.createElement("input"))
			    .attr("type", "dil")
			    .attr("id", "txtapply"+i)
			    .attr("name", "txtapply"+i)
			    .attr("hidden", "true");
				
			newTextBox.val(rows[i].tobepaid+"::"+(parseInt(rows[i].out_amount)+parseInt(rows[i].tobepaid))+"::"+rows[i].currency+"::"+rows[i].tranid+"::"+rows[i].securityacno);
			newTextBox.appendTo('form');
			}
		 }
		 $('#applylength').val(length);
		 /* Security Grid Saving Ends*/
		 
		 /* Security Grid Updating */
	 		var rows = $("#jqxSecurity").jqxGrid('getrows');
			var length=0;
			 for(var i=0 ; i < rows.length ; i++){
				var chk=rows[i].tobepaid;
				if(typeof(chk) != "undefined"){
					length=length+1;
					newTextBox = $(document.createElement("input"))
				    .attr("type", "dil")
				    .attr("id", "txtapplyupdate"+i)
				    .attr("name", "txtapplyupdate"+i)
				    .attr("hidden", "true");
					
				newTextBox.val(parseInt(rows[i].out_amount)-parseInt(rows[i].tobepaid)+"::"+rows[i].tranid);
				newTextBox.appendTo('form');
				}
			 }
			 $('#applylengthupdate').val(length);
			 /* Security Grid Updating Ends*/
			 
		 $('#jqxRentalRefundDate').jqxDateTimeInput({disabled: false});
         $('#jqxReferenceDate').jqxDateTimeInput({disabled: false});
         $('#cmbpaytype').attr('disabled', false);
		 $('#cmbcardtype').attr('disabled', false);
  		 $('#chckib').attr('disabled', false);
  		 $('#cmbbranch').attr('disabled', false);
	   			 
  		return 1;
	} 
	
   function setValues(){
	  getBranch();getCardTypes();checkIb();
	  
	  document.getElementById("cmbpaytype").value=document.getElementById("hidcmbpaytype").value;
	  document.getElementById("cmbratype").value=document.getElementById("hidcmbratype").value;
	  document.getElementById("cmbpayedas").value=document.getElementById("hidcmbpayedas").value;
	  document.getElementById("cmbcardtype").value=document.getElementById("hidcmbcardtype").value;
	   
	  if($('#hidjqxRentalRefundDate').val()){
			 $("#jqxRentalRefundDate").jqxDateTimeInput('val', $('#hidjqxRentalRefundDate').val());
		  }
	  
	  if($('#hidjqxReferenceDate').val()){
			 $("#jqxReferenceDate").jqxDateTimeInput('val', $('#hidjqxReferenceDate').val());
		  }
	  
	   if($('#msg').val()!=""){
		   $.messager.alert('Message',$('#msg').val());
		  }
	   
	   var paid = document.getElementById("cmbpayedas").value;
	   if(paid==1){
	    var indexVal = document.getElementById("txttranno").value;
	    var indexVal1 = document.getElementById("txtsecurityacno").value;
		if(indexVal>0){
	         $("#jqxSecurityGrid").load("securityGrid.jsp?txttranno2="+indexVal+"&txtsecurityacno2="+indexVal1); 
	         } 
	      }
       } 
	
	function getAccounts(a){
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText;
  				items = items.split('####');
  				var accountIdItems  = items[0];
  				var accountItems = items[1];
  				var docNoItems = items[2];
				var payTypeItems = items[3];
  				
  				if(parseInt(payTypeItems)==1 || parseInt(payTypeItems)==3){
					$('#txtaccid').val(accountIdItems) ;
					$('#txtaccname').val(accountItems) ;
					$('#txtdocno').val(docNoItems) ;
				}
  		}
  		}
  		x.open("GET", "getAccounts.jsp?paytype="+a, true);
  		x.send();
    }
	
	function getCardTypes() {
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText;
  				items = items.split('####');
  				var cardIdItems  = items[0].split(",");
  				var cardItems = items[1].split(",");
  				var optionscard = '<option value="">--Select--</option>';
  				for (var i = 0; i < cardItems.length; i++) {
  					optionscard += '<option value="' + cardIdItems[i].trim() + '">'
  							+ cardItems[i] + '</option>';
  				}
  				$("select#cmbcardtype").html(optionscard);
  				if ($('#hidcmbcardtype').val() != null) {
  					$('#cmbcardtype').val($('#hidcmbcardtype').val());
  				}
  			} else {
  			}
  		}
  		x.open("GET", "getCardTypes.jsp", true);
  		x.send();
  	}
	
	function getAgreement(event){
	  var x= event.keyCode;
	  if(x==114){
	  	agreementSearchContent('agreementSearch.jsp');
	  }
	 }
	 
	function getClient(event){
	  var x= event.keyCode;
	  if(x==114){
		  var date = $('#jqxRentalRefundDate').jqxDateTimeInput('getDate');
		  $("#maindate").jqxDateTimeInput('val', date);
		  clientSearchContent(<%=contextPath+"/"%>+"com/operations/clientAccountDetailsSearch.jsp?atype=AR"+"&date="+date);
          $('#txtforsearch').val(1);
	  }
	 }
	 
	 function funCardSearch(){
		cardSearchContent('cardDetailsSearchGrid.jsp?clientId='+$('#txtcldocno').val());
	}
	 
	 function getAcc(event){
        var x= event.keyCode;
        if(x==114){
      	  var date = $('#jqxRentalRefundDate').jqxDateTimeInput('getDate');
      	  $("#maindate").jqxDateTimeInput('val', date);
      	  accountSearchContent(<%=contextPath+"/"%>+"com/operations/accountsDetailsSearch.jsp?date="+date);
        }
        else{}
        }
	
	function funCheck(a){
		  if(document.getElementById("chckib").checked != false){
		 		 $('#hidchckib').val(1);
		 		 $('#cmbbranch').attr('disabled', false );
		  }
		  else{
			  $('#hidchckib').val(0); 
			  $('#cmbbranch').attr('disabled', true );
		  }
	  }
		
	function funchequedate(){
		  paytype=document.getElementById("cmbpaytype").value;
		  if(paytype==1){
			  $('#cmbcardtype').attr('disabled', true);
			  $('#txtchequeno').attr('readonly', true);  
			  $('#btnCardSearch').attr('disabled', true);
			  $('#cmbcardtype').val('');
			  $('#txtchequeno').val('');$('#jqxReferenceDate').val(new Date());
		  }else if(paytype==2){
			  $('#cmbcardtype').attr('disabled', true);
			  $('#txtchequeno').attr('readonly', false);
			  $('#btnCardSearch').attr('disabled', true);
			  $('#cmbcardtype').val('');
			  $('#txtchequeno').val('');$('#jqxReferenceDate').val(new Date());
	      } else if(paytype==3){
    		  $('#cmbcardtype').attr('disabled', false); 
    		  $('#txtchequeno').attr('readonly', false);
    		  $('#btnCardSearch').attr('disabled', false);
    		  $('#cmbcardtype').val('');
    		  $('#txtchequeno').val('');$('#jqxReferenceDate').val(new Date());
    	  }
    }
	
	function funclearchequecardno(){
    	$('#txtchequeno').val('');$('#jqxReferenceDate').val(new Date());
    }
	
	function bankAccountSearch(){
		 if(document.getElementById("cmbpaytype").value == 2){
			 $('#txtaccid').val('');$('#txtaccname').val('');$('#txtdocno').val('');
			 if (document.getElementById("txtaccid").value == "") {
			        $('#txtaccid').attr('placeholder', 'Press F3 to Search'); 
			    }
			 $('#txtaccid').focus();
			 
		 }else{
			 $('#txtaccid').val('');$('#txtaccid').attr('placeholder', '');
			 $('#txtaccid').attr('tabindex', '-1');
			 $('#txtaccname').attr('tabindex', '-1');
		 }
	}
	 
	function applyDisable(){
    	paid=document.getElementById("cmbpayedas").value;
        if(paid==1){
    		var indexVal = document.getElementById("txtagreement").value;
    		var rtype = document.getElementById("cmbratype").value;
    		if(indexVal>0){
   	         $("#jqxSecurityGrid").load("securityGrid.jsp?txtagreement2="+indexVal+"&cmbratype2="+rtype); 
   	         } 
    		$("#jqxSecurity").jqxGrid({ disabled: false});
    		$('#txtdeduction').attr('readonly', false);
			$('#txtaddamount').attr('readonly', false);
    		$('#txtnetamount').attr('readonly', false);
    		$('#txtonaccountamount').attr('readonly', true);
    		$('#txtonaccountamount').val('');
    		
    	}
        else if(paid==2){
    		$("#jqxSecurity").jqxGrid('clear');
			$("#jqxSecurity").jqxGrid('addrow', null, {});
    	    $("#jqxSecurity").jqxGrid({ disabled: true});
    		$('#txtdeduction').attr('readonly', true);
			$('#txtaddamount').attr('readonly', true);
    		$('#txtnetamount').attr('readonly', true);
    		$('#txtonaccountamount').attr('readonly', false);
    		$('#txtamount').val('');$('#txtdeduction').val('');
    		$('#txtaddamount').val('');$('#txtnetamount').val('');
    	}
    } 
	
	function getNetTotal(){
        var amount = $('#txtamount').val();
        var discount = $('#txtdeduction').val();
        var additionalamt = $('#txtaddamount').val();
        var netamount=$('#txtnetamount').val();
        
        if(amount!=''){
        	netamount=(parseFloat(amount));
      	}
        
        if(discount!=''){
      		netamount=((parseFloat(amount)-parseFloat(discount)));
      	}
     
        if(additionalamt!=''){
     		netamount=((parseFloat(amount)-parseFloat(discount))+parseFloat(additionalamt));
     	}
        
     	funRoundAmt(Math.round(netamount),"txtnetamount");
    }
	
	function funPrintBtn(){
    	if (($("#mode").val() == "view") && $("#txtsrno").val()!="") {
	        RefundPrintContent('printVoucherWindow.jsp');
	     }
	    else {
			$.messager.alert('Message','Select a Document....!','warning');
			return;
		}
    }
	
	function datechange(){
		  var date = $('#jqxRentalRefundDate').jqxDateTimeInput('getDate');
		  var validdate=funDateInPeriod(date);
			if(validdate==0){
			return 0;	
			}
		  $("#maindate").jqxDateTimeInput('val', date);
		  
		  if($('#hidchckib').val()==1){
			  if($('#cmbbranch').val()!='' && $('#cmbbranch').val()!=null){
				funIBDateInPeriod($('#jqxRentalRefundDate').val(),$('#cmbbranch').val());
			  }
			}
	  }
	
</script>
<style>
.hidden-scrollbar {
  overflow: auto;
  height: 530px;
}
</style>

</head>
<body onload="setValues();getBranch();getCardTypes();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmRentalRefund" action="saveRentalRefund" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include>

<div  class='hidden-scrollbar'>
<table width="100%">
  <tr>
    <td width="3%" height="42" align="right">Date</td>
    <td width="20%"><div id="jqxRentalRefundDate" name="jqxRentalRefundDate" onchange="datechange();" value='<s:property value="jqxRentalRefundDate"/>'></div>
    <input type="hidden" id="hidjqxRentalRefundDate" name="hidjqxRentalRefundDate" value='<s:property value="hidjqxRentalRefundDate"/>'/></td>
    <td width="10%" align="right">Doc Type</td>
    <td width="20%"><input type="text" id="txtdoctype" name="txtdoctype" style="width:50%;" value='<s:property value="txtdoctype"/>' tabindex="-1"/></td>
    <td width="7%" align="right">Doc No.</td>
    <td width="21%"><input type="text" id="docno" name="txtrentalrefunddocno" style="width:50%;" value='<s:property value="txtrentalrefunddocno"/>' tabindex="-1"/></td>
    <td width="5%" align="right">Receipt No.</td>
    <td width="14%"><input type="text" id="txtsrno" name="txtsrno" style="width:60%;" value='<s:property value="txtsrno"/>' tabindex="-1"/></td>
  </tr>
</table>
<table width="100%">
<tr>
<td width="50%">
<fieldset>
<table width="100%">
  <tr>
    <td colspan="2" align="center"><input type="checkbox" id="chckib" name="chckib" onclick="funCheck();">&nbsp;Inter-Branch
    <input type="hidden" id="hidchckib" name="hidchckib" value='<s:property value="hidchckib"/>'/></td>
    <td width="22%" align="right">Branch</td>
    <td colspan="2"><select id="cmbbranch" name="cmbbranch" style="width:65%;" onchange="funIBDateInPeriod($('#jqxRentalRefundDate').val(),this.value);" value='<s:property value="cmbbranch"/>'>
      <option value=""></option></select>
    <input type="hidden" id="hidcmbbranch" name="hidcmbbranch" value='<s:property value="hidcmbbranch"/>'/></td>
  </tr>
  <tr>
    <td width="7%" align="right">Client</td>
    <td width="26%"><input type="text" id="txtclientid" name="txtclientid" style="width:80%;" placeholder="Press F3 to Search" value='<s:property value="txtclientid"/>' onkeydown="getClient(event);"/></td>
    <td colspan="3"><input type="text" id="txtclientname" name="txtclientname" style="width:75%;" value='<s:property value="txtclientname"/>'/>
     <input type="hidden" id="txtcldocno" name="txtcldocno" value='<s:property value="txtcldocno"/>'/>
     <input type="hidden" id="txtacno" name="txtacno" value='<s:property value="txtacno"/>'/></td>
  </tr>
  <tr>
    <td align="right">Agreement</td>
    <td><select id="cmbratype" name="cmbratype" style="width:50%;" value='<s:property value="cmbratype"/>'>
      <option value="RAG">Rental</option><option value="LAG">Lease</option></select>
      <input type="hidden" id="hidcmbratype" name="hidcmbratype" value='<s:property value="hidcmbratype"/>'/></td>
    <td><input type="text" id="txtagreementvocher" name="txtagreementvocher" style="width:80%;" placeholder="Press F3 to Search" value='<s:property value="txtagreementvocher"/>' onkeydown="getAgreement(event);"/>
    <input type="hidden" id="txtagreement" name="txtagreement" value='<s:property value="txtagreement"/>'/></td>
   <td width="13%" align="right">Paid As</td>
    <td width="32%"><select id="cmbpayedas" name="cmbpayedas" style="width:50%;" onchange="applyDisable();" value='<s:property value="cmbpayedas"/>'>
    <option value="1">Security</option><option value="2">On Account</option></select>
    <input type="hidden" id="hidcmbpayedas" name="hidcmbpayedas" value='<s:property value="hidcmbpayedas"/>'/>
    <input type="hidden" id="txtsecurityacno" name="txtsecurityacno" value='<s:property value="txtsecurityacno"/>'/></td>
  </tr>
</table>
</fieldset>
</td>

<td width="50%">
<fieldset>
<table width="100%">
  <tr>
    <td width="7%" align="right">Pay Type</td>
    <td width="16%"><select id="cmbpaytype" name="cmbpaytype" style="width:95%;" value='<s:property value="cmbpaytype"/>' onchange="bankAccountSearch();funchequedate();getAccounts(this.value);">
      <option value="1">Cash</option><option value="2">Cheque/Online</option><option value="3">Paid to Card</option></select>
      <input type="hidden" id="hidcmbpaytype" name="hidcmbpaytype" value='<s:property value="hidcmbpaytype"/>'/></td>
    <td width="11%" align="right">Account</td>
    <td width="15%"><input type="text" id="txtaccid" name="txtaccid" style="width:95%;" value='<s:property value="txtaccid"/>' onkeydown="getAcc(event);" /></td>
    <td colspan="3"><input type="text" id="txtaccname" name="txtaccname" style="width:90%;" value='<s:property value="txtaccname"/>'/>
    <input type="hidden" id="txtdocno" name="txtdocno" value='<s:property value="txtdocno"/>'/>
    <input type="hidden" id="txttranno" name="txttranno" value='<s:property value="txttranno"/>'/></td>
  </tr>
  <tr>
    <td align="center"><button type="button" class="icon" id="btnCardSearch" title="Search Card" onclick="funCardSearch();">
							<img alt="Search Card" src="<%=contextPath%>/icons/cardsearch.png">
						</button></td>
                         <td colspan="2" align="center">Card Type&nbsp;
                           <select id="cmbcardtype" name="cmbcardtype" style="width:50%;" onchange="funclearchequecardno();" value='<s:property value="cmbcardtype"/>'>
                           <%-- <option value="">--Select--</option><option value="1">Visa</option><option value="2">Master</option></select> --%>
                           <option value="">--Select--</option></select>
      <input type="hidden" id="hidcmbcardtype" name="hidcmbcardtype" value='<s:property value="hidcmbcardtype"/>'/></td>
    <td align="right">Chq/Card No/Online</td>
    <td width="24%"><input type="text" id="txtchequeno" name="txtchequeno" style="width:100%;" value='<s:property value="txtchequeno"/>'/></td>
   
    <td width="4%" align="right">Date</td>
    <td width="23%"><div id="jqxReferenceDate" name="jqxReferenceDate" value='<s:property value="jqxReferenceDate"/>'></div>
    <input type="hidden" id="hidjqxReferenceDate" name="hidjqxReferenceDate" value='<s:property value="hidjqxReferenceDate"/>'/></td>
  </tr>
  <tr>
    <td align="right">Description</td>
    <td colspan="6"><input type="text" id="txtdescription" name="txtdescription" style="width:95%;" value='<s:property value="txtdescription"/>'/></td>
  </tr>
</table></fieldset>
</td>
</tr></table>
<fieldset><legend>Security Details</legend>
<div id="jqxSecurityGrid"><center><jsp:include page="securityGrid.jsp"></jsp:include></center></div>
</fieldset><br/>
<fieldset>
<table width="100%">
  <tr>
    <td width="7%" align="right">Amount</td>
    <td width="14%"><input type="text" id="txtamount" name="txtamount" style="width:70%;text-align: right;" value='<s:property value="txtamount"/>' onblur="funRoundAmt(this.value,this.id);getNetTotal();"/></td>
    <td width="6%" align="right">Deduction</td>
    <td width="12%"><input type="text" id="txtdeduction" name="txtdeduction" style="width:70%;text-align: right;" onblur="funRoundAmt(this.value,this.id);getNetTotal();" value='<s:property value="txtdeduction"/>'/></td>
    <td width="5%" align="right">Add. Amount</td>
    <td width="12%"><input type="text" id="txtaddamount" name="txtaddamount" style="width:70%;text-align: right;" value='<s:property value="txtaddamount"/>' onblur="funRoundAmt(this.value,this.id);getNetTotal();"/></td>
    <td width="8%" align="right">Net Amount</td>
    <td width="14%"><input type="text" id="txtnetamount" name="txtnetamount" style="width:70%;text-align: right;" value='<s:property value="txtnetamount"/>' tabindex="-1"/></td>
    <td width="8%" align="right">On Account Amount</td>
    <td width="15%"><input type="text" id="txtonaccountamount" name="txtonaccountamount" style="width:75%;text-align: right;" onblur="funRoundAmt(this.value,this.id);" value='<s:property value="txtonaccountamount"/>'/></td>
  </tr>
  <tr>
    <td align="right">Description</td>
    <td colspan="5"><input type="text" id="txtdescriptions" name="txtdescriptions" style="width:93%;" value='<s:property value="txtdescriptions"/>'/></td>
    <td align="right">Paid To</td>
    <td colspan="5"><input type="text" id="txtpaidto" name="txtpaidto" style="width:90%;" value='<s:property value="txtpaidto"/>'/></td>
  </tr>
</table>
</fieldset>

<input type="hidden" id="mode" name="mode"/>
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<input type="hidden" name="txtforsearch" id="txtforsearch" value='<s:property value="txtforsearch"/>'/>
<div hidden="true" id="maindate" name="maindate" value='<s:property value="maindate"/>'></div>
<input type="hidden" id="hidmaindate" name="hidmaindate" value='<s:property value="hidmaindate"/>'/>
<input type="hidden" name="txtvalidation" id="txtvalidation" value='<s:property value="txtvalidation"/>'/>
<input type="hidden" id="txtibvalidation" name="txtibvalidation" value='<s:property value="txtibvalidation"/>'/>
<input type="hidden" id="applylength" name="applylength"/>
<input type="hidden" id="applylengthupdate" name="applylengthupdate"/>
</div>
</form>
<div id="agreementDetailsWindow">
	<div></div><div></div>
</div>  
<div id="clientDetailsWindow">
	<div></div><div></div>
</div> 
<div id="accountDetailsWindow">
	<div></div><div></div>
</div>
<div id="cardDetailsWindow">
	<div></div><div></div>
</div> 
<div id="printWindow">
	<div></div><div></div>
</div> 
</div>
</body>
</html>