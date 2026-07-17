<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  

<style type="text/css">
.myButtons {
	-moz-box-shadow:inset 0px -1px 3px 0px #91b8b3;
	-webkit-box-shadow:inset 0px -1px 3px 0px #91b8b3;
	box-shadow:inset 0px -1px 3px 0px #91b8b3;
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #768d87), color-stop(1, #6c7c7c));
	background:-moz-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-webkit-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-o-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-ms-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:linear-gradient(to bottom, #768d87 5%, #6c7c7c 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#768d87', endColorstr='#6c7c7c',GradientType=0);
	background-color:#768d87;
	border:1px solid #566963;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	
	font-size:8pt;
	
	padding:3px 17px;
	text-decoration:none;
	text-shadow:0px -1px 0px #2b665e;
}
.myButtons:hover {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #6c7c7c), color-stop(1, #768d87));
	background:-moz-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-webkit-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-o-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-ms-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:linear-gradient(to bottom, #6c7c7c 5%, #768d87 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#6c7c7c', endColorstr='#768d87',GradientType=0);
	background-color:#6c7c7c;
}
.myButtons:active {
	position:relative;
	top:1px;
}

.textbox {
    border: 0;
    height: 25px;
    width: 20%;
    border-radius: 5px;
    -moz-border-radius: 5px;
    -webkit-border-radius: 5px;
    box-shadow: 1px 1px 0 0 #E0ECF8, 5px 5px 40px 2px #E0ECF8 inset;
    -moz-box-shadow: 1px 1px 0 0 #E0ECF8, 5px 5px 40px 2px #E0ECF8 inset;
    -webkit-box-shadow: 1px 1px 0 0 #E0ECF8, 5px 5px 40px 2px #E0ECF8 inset;
    -webkit-background-clip: padding-box;
    outline: 0;
}
</style>

<script type="text/javascript">

	$(document).ready(function () {
		 $("#uptodate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 $("#date").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 $("#chqdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 
		 $('#accountDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailsWindow').jqxWindow('close');
		 
		 $('#branchSearchWindow').jqxWindow({width: '20%', height: '58%',  maxHeight: '60%' ,maxWidth: '30%' , title: 'Branch Search',position: { x: 250, y: 120 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#branchSearchWindow').jqxWindow('close');
		 
		 $('#cardDetailsWindow').jqxWindow({width: '30%', height: '58%',  maxHeight: '70%' ,maxWidth: '30%' , title: 'Card Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#cardDetailsWindow').jqxWindow('close');
		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
		 
	     document.getElementById("hidchckibbranch").value=0;
	     
	     $('#txtclientaccount').dblclick(function(){
			  accountsSearchContent('clientDetailsSearch.jsp');
			  });
		  
		  $('#txttypeaccid').dblclick(function(){
			  accountsSearchContent('accountsDetailsSearch.jsp');
			  });
		  
		  $('#txtibbranch').dblclick(function(){
			  branchSearchContent('branchSearchGrid.jsp?check=1');
			  });
		  
	     $('#cmbtype').attr('disabled', true );$('#txttypeaccid').attr('readonly', true );$('#txttypeaccid').attr('readonly', true );
	     $('#txtchequeno').attr('readonly', true );$('#txtremarks').attr('readonly', true );$('#txtibbranch').attr('disabled', true );
	     $('#btnRefund').attr('disabled', true );$('#btnRelease').attr('disabled', true );$('#date').jqxDateTimeInput({disabled: true});
	     $('#chqdate').jqxDateTimeInput({disabled: true});$('#cmbcardtype').attr('disabled', true );$('#btnCardSearch').attr('disabled', true);
	     
	});
	
	function accountsSearchContent(url) {
	    $('#accountDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#accountDetailsWindow').jqxWindow('setContent', data);
		$('#accountDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function branchSearchContent(url) {
		$('#branchSearchWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#branchSearchWindow').jqxWindow('setContent', data);
		$('#branchSearchWindow').jqxWindow('bringToFront');
	}); 
	} 
	
	function cardSearchContent(url) {
	 	$('#cardDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#cardDetailsWindow').jqxWindow('setContent', data);
		$('#cardDetailsWindow').jqxWindow('bringToFront');
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
	
	function getAccounts(a,b){
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText;
  				items = items.split('####');
  				var docNoItems = items[0];
  				var accountIdItems  = items[1];
  				var accountItems = items[2];
  				var accountTypeItems = items[3];
  				var accountCurIdItems  = items[4];
  				var accountRateItems = items[5];
  				var accCurrTypeItems = items[6];
  				var payTypeItems = items[7];
  				
  			 if(parseInt(payTypeItems)==1 || parseInt(payTypeItems)==3){
  			    $('#txttypedocno').val(docNoItems);	
  			    $('#txttypeaccid').val(accountIdItems);
  			    $('#txttypeaccname').val(accountItems);
  			  	$('#txttypeatype').val(accountTypeItems);
			    $('#txttypecurid').val(accountCurIdItems);
			    $('#txttyperate').val(accountRateItems);
			    $('#txttypetype').val(accCurrTypeItems);
  			 }
  		}
  		}
  		x.open("GET", "getAccounts.jsp?paytype="+a+"&date="+b, true);
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
	
	function getClient(event){
      var x= event.keyCode;
      if(x==114){
    	  accountsSearchContent('clientDetailsSearch.jsp');
      }
      else{
       }
      }
	
	function getAccType(event){
        var x= event.keyCode;
        if(x==114){
      	  accountsSearchContent('accountsDetailsSearch.jsp');
        }
        else{
         }
        }
	
	function getIbBranch(event){
        var x= event.keyCode;
        if(x==114){
        	branchSearchContent('branchSearchGrid.jsp?check=1');
        }
        else{
         }
        }
	
	function funCardSearch(){
		cardSearchContent('cardDetailsSearchGrid.jsp');
	}
	
	function ibbranchcheck(){
		 if(document.getElementById("chckibbranch").checked){
			 document.getElementById("hidchckibbranch").value = 1;
			 $('#txtibbranch').attr('disabled', false );
		 }
		 else{
			 document.getElementById("hidchckibbranch").value = 0;
			 $('#txtibbranchid').val('0');$('#txtibbranch').val('');
			 $('#txtibbranch').attr('disabled', true );
			 
			 if (document.getElementById("txtibbranch").value == "") {
			        $('#txtibbranch').attr('placeholder', 'Press F3 to Search'); 
			  }
		 }
	 }
	
	function funreload(event){
		
		 var branchval = document.getElementById("cmbbranch").value;
		 var uptodate = $('#uptodate').val();
		 var agreementcloseddays = $('#txtagreementcloseddays').val();
		 var clientAccount = $('#txtcldocno').val();
		 
		 $("#overlay, #PleaseWait").show();
		 
		 $("#refundableDiv").load("refundGrid.jsp?branchval="+branchval+'&uptodate='+uptodate+'&agreementcloseddays='+agreementcloseddays.replace(/ /g, "%20")+'&clientAccount='+clientAccount);
		}
	
	function  funClearInfo(){
		
		$('#cmbbranch').val('a');
		$('#uptodate').val(new Date());$('#date').val(new Date());$('#chqdate').val(new Date());
	    
		$('#txtagreementcloseddays').val('');$('#txtclientaccount').val('');$('#txtclientname').val('');$('#txtcldocno').val('');$('#clientinfo').val('');
		$('#txtnetamount').val('0.00');
		
		document.getElementById("hidchckibbranch").value = 0;
		 if(document.getElementById("hidchckibbranch").value==0){
			 document.getElementById("chckibbranch").checked = false;
		 }
		 $('#txtibbranchid').val('0');$('#txtibbranch').val('');
		 $('#cmbtype').val('');$('#hidcmbtype').val('');$('#txttypedocno').val('');$('#txttypeaccid').val('');
		 $('#txttypeaccname').val('');$('#txttypeatype').val('');$('#txttypecurid').val('');$('#txttyperate').val('');
		 $('#txttypetype').val('');$('#txtchequeno').val('');$('#txtremarks').val('');

		 $('#cmbtype').attr('disabled', true );$('#txttypeaccid').attr('readonly', true );$('#txttypeaccid').attr('readonly', true );
		 $('#cmbcardtype').val('');$('#cmbcardtype').attr('disabled', true );
	     $('#txtchequeno').attr('readonly', true );$('#txtremarks').attr('readonly', true );$('#txtibbranch').attr('disabled', true );
	     $('#btnRefund').attr('disabled', true );$('#btnRelease').attr('disabled', true );$('#date').jqxDateTimeInput({disabled: true});
	     $('#chqdate').jqxDateTimeInput({disabled: true});$('#btnCardSearch').attr('disabled', true);
		 $("#jqxRefund").jqxGrid('clear');$("#jqxRefund").jqxGrid('addrow', null, {});
		
		if (document.getElementById("txtagreementcloseddays").value == "") {
		        $('#txtagreementcloseddays').attr('placeholder', 'Agreement Closed Days'); 
		}
		  
		 if (document.getElementById("txtclientaccount").value == "") {
		        $('#txtclientaccount').attr('placeholder', 'Press F3 to Search'); 
		 }
		 
		 if (document.getElementById("txtibbranch").value == "") {
		        $('#txtibbranch').attr('placeholder', 'Press F3 to Search'); 
		  }
		
		}
	
	function bankAccountSearch(){
		 if(document.getElementById("cmbtype").value == 2){
			 $('#txttypedocno').val('');$('#txttypeaccid').val('');$('#txttypeaccname').val('');
			 $('#txttypeatype').val('');$('#txttypecurid').val('');$('#txttyperate').val('');
			 $('#txttypetype').val('');$('#txtchequeno').attr('readonly', false );
			 $('#cmbcardtype').val('');$('#cmbcardtype').attr('disabled', true );
			 $('#btnCardSearch').attr('disabled', true);
			 $('#chqdate').jqxDateTimeInput({disabled: false});
			 
			 if (document.getElementById("txttypeaccid").value == "") {
			        $('#txttypeaccid').attr('placeholder', 'Press F3 to Search'); 
			    }
			 $('#txttypeaccid').focus();
			 
		 }else if(document.getElementById("cmbtype").value == 3){
			 $('#txttypeaccid').attr('tabindex', '-1');
			 $('#txttypeaccname').attr('tabindex', '-1');
			 $('#cmbcardtype').val('');$('#cmbcardtype').attr('disabled', false );
			 $('#txtchequeno').attr('readonly', false );
			 $('#btnCardSearch').attr('disabled', false);
			 $('#chqdate').jqxDateTimeInput({disabled: false});
			 
		 }else{
			 $('#txttypeaccid').attr('tabindex', '-1');
			 $('#txttypeaccname').attr('tabindex', '-1');
			 $('#cmbcardtype').val('');$('#cmbcardtype').attr('disabled', true );
			 $('#txtchequeno').attr('readonly', true );
			 $('#btnCardSearch').attr('disabled', true);
			 $('#chqdate').jqxDateTimeInput({disabled: true});
		 }
	 }
	
	function funRefund(event){
		
		var refunddate = $('#date').val();
		var ibbranch = $('#txtibbranchid').val();
		var chckibbranch = $('#hidchckibbranch').val();
		var type = $('#cmbtype').val();
		var typeaccount = $('#txttypedocno').val();
		var chequeno = $('#txtchequeno').val();
		var remarks = $('#txtremarks').val();
		var clientaccount = $('#txtclaccount').val();
		var clientdocno = $('#txtclientdocno').val();
		var clientname = $('#txtclname').val();
		var rano = $('#txtrano').val();
		var rtype = $('#txtrtype').val();
		var mainbrhid = $('#txtmainbrhid').val();
		var securityamount = $('#txtsecurityamount').val();
		var balanceamount = $('#txtbalanceamount').val();
		var cardtype = $('#cmbcardtype').val();
		var process="REFUNDED";
		
		if(type==''){
			 $.messager.alert('Message','Please Choose a Type.','warning');
			 return 0;
		 }
		
		if(typeaccount==''){
			 $.messager.alert('Message','Please Choose an Account.','warning');
			 return 0;
		 }
		
		if(securityamount.trim()==''){
			 $.messager.alert('Message','Security Amount Unavailable, Transaction Restricted.','warning');
			 return 0;
		 }
		
		/*if(balanceamount<0){
			 $.messager.alert('Message','Net Amount is Negative, Transaction Restricted.','warning');
			 return 0;
		 }*/
		
		if(($('#hidchckibbranch').val()=='1') && ($('#txtibbranchid').val()=='0')){
			 $.messager.alert('Message','Please Choose Inter-Branch.','warning');
			 return 0;
		}
		
		ibvalid=document.getElementById("txtibvalidation").value;
		  if(ibvalid==1){
			 $.messager.alert('Message','Closing Done For Inter-Branch,Transaction Restricted.','warning');
			 return 0;
		  }
		  
		if(remarks==''){
		    $.messager.alert('Message','Please Enter Remarks.','warning');
			return 0;
		}
		
		var date = $('#date').jqxDateTimeInput('getDate');
		var validdate=funDateInPeriod(date);
		if(validdate==0){
			return 0;	
		}
		
		    $.messager.confirm('Message', 'Do you want to Refund Security?', function(r){
			        
		     	if(r==false)
		     	  {
		     		return false; 
		     	  }
		     	else{
		     		 $('#chqdate').jqxDateTimeInput({disabled: false});
		     		 var chequedate = $('#chqdate').val();
		     		 saveGridData(refunddate,ibbranch,chckibbranch,type,typeaccount,chequeno,chequedate,remarks,clientaccount,clientdocno,clientname,rano,rtype,mainbrhid,securityamount,balanceamount,cardtype,process);	
		     	}
		 });
	}
	
	function funRelease(event){
		
		var refunddate = $('#date').val();
		var ibbranch = $('#txtibbranchid').val();
		var chckibbranch = $('#hidchckibbranch').val();
		var type = $('#cmbtype').val();
		var typeaccount = $('#txttypedocno').val();
		var chequeno = $('#txtchequeno').val();
		var remarks = $('#txtremarks').val();
		var clientaccount = $('#txtclaccount').val();
		var clientdocno = $('#txtclientdocno').val();
		var clientname = $('#txtclname').val();
		var rano = $('#txtrano').val();
		var rtype = $('#txtrtype').val();
		var mainbrhid = $('#txtmainbrhid').val();
		var securityamount = $('#txtsecurityamount').val();
		var balanceamount = $('#txtbalanceamount').val();
		var cardtype = $('#cmbcardtype').val();
		var process="RELEASED";
		
		if(securityamount.trim()==''){
			 $.messager.alert('Message','Security Amount Unavailable, Transaction Restricted.','warning');
			 return 0;
		 }
		  
		if(remarks==''){
		    $.messager.alert('Message','Please Enter Remarks.','warning');
			return 0;
		}
		
		var date = $('#date').jqxDateTimeInput('getDate');
		var validdate=funDateInPeriod(date);
		if(validdate==0){
			return 0;	
		}
		
		    $.messager.confirm('Message', 'Do you want to Release Security?', function(r){
			        
		     	if(r==false)
		     	  {
		     		return false; 
		     	  }
		     	else{
		     		 $('#chqdate').jqxDateTimeInput({disabled: false});
		     		 var chequedate = $('#chqdate').val();
		     		 saveGridData(refunddate,ibbranch,chckibbranch,type,typeaccount,chequeno,chequedate,remarks,clientaccount,clientdocno,clientname,rano,rtype,mainbrhid,securityamount,balanceamount,cardtype,process);	
		     	}
		 });
	}
	
	function saveGridData(refunddate,ibbranch,chckibbranch,type,typeaccount,chequeno,chequedate,remarks,clientaccount,clientdocno,clientname,rano,rtype,mainbrhid,securityamount,balanceamount,cardtype,process){
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText;
				items = items.split('***');
				var val = items[0];
				var rrpno = items[1];
				var result = items[2];
				
				result = result.toLowerCase().replace(/\b[a-z]/g, function(letter) {
				    return letter.toUpperCase();
				});
				
				$.messager.alert('Message', ''+result+' Successfully, Doc No. '+rrpno+'', function(r){
				});
				
			  funClearInfo();
		      funreload(event); 
		  }
		}
			
	x.open("GET","saveData.jsp?refunddate="+refunddate+"&ibbranch="+ibbranch+"&chckibbranch="+chckibbranch+"&type="+type+"&typeaccount="+typeaccount+"&chequeno="+chequeno+"&chequedate="+chequedate+"&remarks="+remarks+"&clientaccount="+clientaccount+"&clientdocno="+clientdocno+"&clientname="+clientname+"&rano="+rano+"&rtype="+rtype+"&mainbranch="+mainbrhid+"&securityamount="+securityamount+"&balanceamount="+balanceamount+"&cardtype="+cardtype+"&process="+process,true);
	x.send();
	}
	
	function funExportBtn(){
		 if(parseInt(window.parent.chkexportdata.value)=="1") {
		  	JSONToCSVCon(data, 'SecurityRefund', true);
		 } else {
			 $("#jqxRefund").jqxGrid('exportdata', 'xls', 'SecurityRefund');
		 }
	 }
	
</script>
</head>
<body onload="getBranch();getCardTypes();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%">
	<jsp:include page="../../heading.jsp"></jsp:include>
		
	<tr><td align="right"><label class="branch">Up To</label></td>
    <td align="left"><div id="uptodate" name="uptodate" value='<s:property value="uptodate"/>'></div></td></tr> 
	<tr><td align="right"><label class="branch">Closed Before</label></td>
    <td align="left"><input type="text" id="txtagreementcloseddays" name="txtagreementcloseddays" style="width:65%;height:20px;" placeholder="Agreement Closed Days" onkeypress="javascript:return isNumber(event)" value='<s:property value="txtagreementcloseddays"/>'/></td></tr>
	<tr><td align="right"><label class="branch">Client</label></td>
	<td align="left"><input type="text" id="txtclientaccount" name="txtclientaccount" style="width:60%;height:20px;" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtclientaccount"/>' onkeydown="getClient(event);"/></td></tr> 
	<tr><td>&nbsp;</td>
	<td><input type="text" id="txtclientname" name="txtclientname" style="width:100%;height:20px;" readonly="readonly" value='<s:property value="txtclientname"/>' tabindex="-1"/>
    <input type="hidden" id="txtcldocno" name="txtcldocno" value='<s:property value="txtcldocno"/>'/></td></tr>
     <tr><td colspan="2" align="center"><textarea id="clientinfo" style="height:60px;width:200px;font: 10px Tahoma;resize:none" name="clientinfo"  readonly="readonly"><s:property value="clientinfo" ></s:property></textarea></td></tr>
    <tr><td align="right"><label class="branch">Date</label></td>
    <td align="left"><div id="date" name="date" value='<s:property value="date"/>'></div>
    <input type="hidden" id="hiddate" name="hiddate" style="width:60%;height:20px;" readonly="readonly" value='<s:property value="hiddate"/>'/></td></tr>
     <tr><td align="right"><label class="branch">Branch</label></td>
     <td align="left"><input type="text" id="txtibbranch" name="txtibbranch" style="width:60%;height:20px;" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtibbranch"/>' onkeydown="getIbBranch(event);"/>
     <input type="hidden" id="txtibbranchid" name="txtibbranchid" style="width:60%;height:20px;" readonly="readonly" value='<s:property value="txtibbranchid"/>'/>
     <input type="checkbox" id="chckibbranch" name="chckibbranch" value="" onchange="ibbranchcheck();" onclick="$(this).attr('value', this.checked ? 1 : 0)" />
     <input type="hidden" id="hidchckibbranch" name="hidchckibbranch" style="width:60%;height:20px;" readonly="readonly" value='<s:property value="hidchckibbranch"/>'/></td></tr>
	<tr><td align="right"><label class="branch">Type</label></td>
	<td align="left"><select id="cmbtype" name="cmbtype" style="width:50%;" onchange="bankAccountSearch();getAccounts(this.value,$('#date').val());" value='<s:property value="cmbtype"/>'>
    <option value="">--Select--</option><option value="1">Cash</option><option value="2">Cheque/Online</option><option value="3">Paid to Card</option></select>
    <input type="hidden" id="hidcmbtype" name="hidcmbtype" style="width:60%;height:20px;" readonly="readonly" value='<s:property value="hidcmbtype"/>'/></td></tr>
    <tr><td align="right"><label class="branch">Account</label></td>
	<td align="left"><input type="text" id="txttypeaccid" name="txttypeaccid" style="width:60%;height:20px;" readonly="readonly" value='<s:property value="txttypeaccid"/>' onkeydown="getAccType(event);" tabindex="-1"/></td></tr>
	<tr><td>&nbsp;</td>
	<td><input type="text" id="txttypeaccname" name="txttypeaccname" style="width:100%;height:20px;" readonly="readonly" value='<s:property value="txttypeaccname"/>' tabindex="-1"/>
    <input type="hidden" id="txttypedocno" name="txttypedocno" style="width:60%;height:20px;" readonly="readonly" value='<s:property value="txttypedocno"/>'/>
    <input type="hidden" id="txttypeatype" name="txttypeatype" style="width:60%;height:20px;" readonly="readonly" value='<s:property value="txttypeatype"/>'/>
    <input type="hidden" id="txttypecurid" name="txttypecurid" style="width:60%;height:20px;" readonly="readonly" value='<s:property value="txttypecurid"/>'/>
    <input type="hidden" id="txttyperate" name="txttyperate" style="width:60%;height:20px;" readonly="readonly" value='<s:property value="txttyperate"/>'/>
    <input type="hidden" id="txttypetype" name="txttypetype" style="width:60%;height:20px;" readonly="readonly" value='<s:property value="txttypetype"/>'/></td></tr>
    <tr><td align="right"><label class="branch">Card Type</label></td>
	<td align="left"><select id="cmbcardtype" name="cmbcardtype" style="width:50%;" value='<s:property value="cmbcardtype"/>'>
    <option value="">--Select--</option></select>&nbsp;&nbsp;<button type="button" class="icon" id="btnCardSearch" title="Search Card" onclick="funCardSearch();">
							<img alt="Search Card" src="<%=contextPath%>/icons/cardsearch.png"></button>
    <input type="hidden" id="hidcmbcardtype" name="hidcmbcardtype" style="width:60%;height:20px;" readonly="readonly" value='<s:property value="hidcmbcardtype"/>'/></td></tr>
    <tr><td align="right"><label class="branch">Cheque/Card No.</label></td>
    <td align="left"><input type="text" id="txtchequeno" name="txtchequeno" style="width:60%;height:20px;" value='<s:property value="txtchequeno"/>'/></td></tr>
    <tr><td align="right"><label class="branch">Cheque/Card Date</label></td>
    <td align="left"><div id="chqdate" name="chqdate" value='<s:property value="chqdate"/>'></div>
    <input type="hidden" id="hidchqdate" name="hidchqdate" style="width:60%;height:20px;" readonly="readonly" value='<s:property value="hidchqdate"/>'/></td></tr>
    <tr><td align="right"><label class="branch">Remarks</label></td>
	<td align="left"><input type="text" id="txtremarks" name="txtremarks" style="width:100%;height:20px;" value='<s:property value="txtremarks"/>'/></td></tr> 
    <tr><td colspan="2"><button class="myButton" type="button" id="btnRefund" name="btnRefund" onclick="funRefund(event);">Refund</button>
    <input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funClearInfo();">
	<button class="myButton" type="button" id="btnRelease" name="btnRelease" onclick="funRelease(event);">Release</button></td></tr>
    <tr><td colspan="2"><input type="hidden" id="txtclientdocno" name="txtclientdocno" style="width:60%;height:20px;" value='<s:property value="txtclientdocno"/>'/>
    <input type="hidden" id="txtclaccount" name="txtclaccount" style="width:60%;height:20px;" value='<s:property value="txtclaccount"/>'/>
    <input type="hidden" id="txtclname" name="txtclname" style="width:60%;height:20px;" value='<s:property value="txtclname"/>'/>
    <input type="hidden" id="txtrano" name="txtrano" style="width:60%;height:20px;" value='<s:property value="txtrano"/>'/>
    <input type="hidden" id="txtrtype" name="txtrtype" style="width:60%;height:20px;" value='<s:property value="txtrtype"/>'/>
    <input type="hidden" id="txtmainbrhid" name="txtmainbrhid" style="width:60%;height:20px;" value='<s:property value="txtmainbrhid"/>'/>
    <input type="hidden" id="txtsecurityamount" name="txtsecurityamount" style="width:60%;height:20px;" value='<s:property value="txtsecurityamount"/>'/>
    <input type="hidden" id="txtbalanceamount" name="txtbalanceamount" style="width:60%;height:20px;" value='<s:property value="txtbalanceamount"/>'/>
    <input type="hidden" id="txtibvalidation" name="txtibvalidation" style="width:60%;height:20px;" value='<s:property value="txtibvalidation"/>'/></td></tr>
	</table>
	</fieldset>
</td>
<td width="80%">

<table width="100%">
		<tr>
			 <td><div id="refundableDiv"><jsp:include page="refundGrid.jsp"></jsp:include></div></td>
		</tr>
</table>
</tr>
</table>
<table width="100%">
	<tr>
		<td width="92%" align="right" style="font-family: Myriad Pro;font-size: 12px;font-weight: bold;">Net Balance :&nbsp;</td>
        <td width="8%" align="left"><input type="text" class="textbox" id="txtnetamount" name="txtnetamount" style="width:80%;text-align: right;" value='<s:property value="txtnetamount"/>'/></td>
	</tr>
</table>
</div>

<div id="accountDetailsWindow">
	<div></div><div></div>
</div>
<div id="branchSearchWindow">
	<div></div><div></div>
</div>
<div id="cardDetailsWindow">
	<div></div><div></div>
</div>
</div> 
</body>
</html>