<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 
<style type="text/css">
	.hidden-scrollbar {
    overflow: auto;
    height: 550px;
}
</style>
<script type="text/javascript">

$(document).ready(function () {
	$.get("getInitData.jsp", function(data){
    	data=JSON.parse(data);
    	$('#insurtypeconfig').val(data.insurtypeconfig);
		//$('#insurtypeconfig').val(data.trim());
    	//alert(data);
    	if($('#insurtypeconfig').val()=='1'){
    		$('.insurtypetd').show();
    	}
    	else{
    		$('.insurtypetd').hide();
    	}
  	});
	$('.insurtypetd').hide();
	$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
	$("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200;right:600;'><img src='../../../../icons/31load.gif'/></div>");    
	$("#periodupto").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	$("#podate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	$('#insurtypewindow').jqxWindow({ width: '60%', height: '55%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Insurance Type Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
    $('#insurtypewindow').jqxWindow('close');
    $('#printWindow').jqxWindow({width: '51%', height: '28%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Print',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	$('#printWindow').jqxWindow('close'); 
    $('div[data-invoicing="normal"]').show();
	$('div[data-invoicing="nontax"]').hide();
	$('#chkmultiple').trigger('click');
	setMultiple();
	$('#periodupto').on('change', function (event) 
	{  
		var docdateval=funDateInPeriod($('#periodupto').jqxDateTimeInput('getDate'));
		if(docdateval==0){
			$('#periodupto').jqxDateTimeInput('focus');
			return false;
		}
	});
	$('#btninvsave').click(function(){
		var rowsCount = $('#amountGrid').jqxGrid('getrows').length;
    	for(var i=0;i<rowsCount;i++){
    		var invno=parseInt($('#amountGrid').jqxGrid('getcellvalue',i,'invno'));
    		/* var billtoacno=parseInt($('#amountGrid').jqxGrid('getcellvalue',i,'billtoacno'));
    		if(billtoacno==""){
    			$.messager.alert('Warning','Select Bill To');
    			return 0;
    		} */
    		if(invno>0){
    			$.messager.alert('Warning','Invoice Generated , Changes Restricted');
    			return 0;
		    }
    		
    	}
		var jobcarddocno=$('#jobcarddocno').val();
		var chkmultiple=$('#hidchkmultiple').val();
		var excess=$('#excess').val();
		var claimno=$('#claimno').val();
		var pono=$('#pono').val();
		var podate=$('#podate').jqxDateTimeInput('val');
		var vattype=$('#cmbvattype').val();
		var rows=$('#estimationGrid').jqxGrid('getrows');
		for(var j=0;j<rows.length;j++){
			var insurtype=$('#estimationGrid').jqxGrid('getcellvalue',j,'insurtypedocno');
			//alert(insurtype);
			if(insurtype=="" || insurtype=="undefined" || insurtype==null || typeof(insurtype)=="undefined"){
				$.messager.alert('Warning','Select Insurance Type');
    			return 0;
			}
		}
		var ownfaultconfig=$('#ownfaultconfig').val();
		var faulttype=$('#faulttype').val();
		var totalexcess=0.0;
		for(var i=0;i<rows.length;i++){
			var currentexcess=$('#estimationGrid').jqxGrid('getcellvalue',i,'excess');
			currentexcess=currentexcess==null || currentexcess=='' || currentexcess=='undefined' || typeof(currentexcess)=='undefined'?0.0:parseFloat(currentexcess);
			totalexcess+=parseFloat(currentexcess);
		}
		var clientinsurance=$('#clientinsurance').val();
		if(ownfaultconfig=='1' && faulttype=='2' && clientinsurance=='1' && parseFloat(totalexcess)==0.0){
			$.messager.alert('Warning','Excess is mandatory for Own Fault Type');
			return 0;
		}
		var estarray=new Array();
		for(var i=0;i<rows.length;i++){
			var arrestno=$('#estimationGrid').jqxGrid('getcellvalue',i,'estno');
			var arrlabourtotal=$('#estimationGrid').jqxGrid('getcellvalue',i,'labourtotal');
			var arrsparetotal=$('#estimationGrid').jqxGrid('getcellvalue',i,'sparetotal');
			var arrnettotal=$('#estimationGrid').jqxGrid('getcellvalue',i,'nettotal');
			var arrchkclaim=$('#estimationGrid').jqxGrid('getcellvalue',i,'chkclaim');
			var arrclaimno=$('#estimationGrid').jqxGrid('getcellvalue',i,'claimno');
			var arrexcess=$('#estimationGrid').jqxGrid('getcellvalue',i,'excess');
			var arrpono=$('#estimationGrid').jqxGrid('getcellvalue',i,'pono');
			var arrpodate=$('#estimationGrid').jqxGrid('getcelltext',i,'podate');
			var arrvattype=$('#estimationGrid').jqxGrid('getcellvalue',i,'vattype');
			var addition=$('#estimationGrid').jqxGrid('getcellvalue',i,'addition');
			var insurtypedocno=$('#estimationGrid').jqxGrid('getcellvalue',i,'insurtypedocno');
			var nontaxamt=$('#estimationGrid').jqxGrid('getcellvalue',i,'nontaxamt');
			if(arrestno!="" && arrestno!="undefined" && arrestno!=null && typeof(arrestno)!="undefined"){
				estarray.push(arrestno+"::"+arrlabourtotal+"::"+arrsparetotal+"::"+arrnettotal+"::"+arrchkclaim+"::"+arrclaimno+"::"+arrexcess+"::"+arrpono+"::"+arrpodate+"::"+arrvattype+"::"+addition+"::"+insurtypedocno+"::"+nontaxamt);
			}
		}
		// alert(jobcarddocno+"::"+chkmultiple+"::"+excess+"::"+claimno+"::"+pono+"::"+vattype);
		saveEstDataAJAX(jobcarddocno,chkmultiple,excess,claimno,pono,podate,vattype,estarray);
	});
	
	$('#btninvcalculate').click(function(){
		var rowsCount = $('#amountGrid').jqxGrid('getrows').length;
		for(var i=0;i<rowsCount;i++){
    		var invno=parseInt($('#amountGrid').jqxGrid('getcellvalue',i,'invno'));
    		if(invno>0){
    			$.messager.alert('Warning','Invoice Generated , Changes Restricted');
    			return 0;
		    }
    	}
		var jobcarddocno=$('#jobcarddocno').val();
		$.messager.confirm('Confirm', 'Do you want to calculate?', function(r){
			if (r){
				calculateDataAJAX(jobcarddocno);		
			}
		});
		
	});
	
	$('#btninvoiceconfirm').click(function(){
		var rowsCount = $('#amountGrid').jqxGrid('getrows').length;
		if(rowsCount>0){
			for(var i=0;i<rowsCount;i++){
	    		var invno=parseInt($('#amountGrid').jqxGrid('getcellvalue',i,'invno'));
	    		if(invno>0){
	    			
			    }
			    else{
			    	$.messager.alert('Warning','Invoice Not Generated , Confirmation Restricted');
	    			return false;
			    }
	    	}
	    	funConfirm();	
		}
		else{
			$.messager.alert('Warning','Invoice Not Generated , Confirmation Restricted');
	    	return false;
		}
		
	});
});

function insurtypeSearchContent(url) {
	$.get(url).done(function (data) {
    	$('#insurtypewindow').jqxWindow('setContent', data);
    }); 
}
function calculateDataAJAX(jobcarddocno){
	//alert(jobcarddocno);
	var seccldocno=$('#seccldocno').val();
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText.trim();
			if(items=="0"){
				$('#amountgriddiv').load('amountGrid.jsp?seccldocno='+seccldocno+'&id=1&jobdocno='+jobcarddocno);	
			}
			else{
				$.messager.alert('Warning','Not Calculated');
			}
			
			} else {
			}
		}
		x.open("GET", "calculateAJAX.jsp?jobdocno="+jobcarddocno+"&seccldocno="+seccldocno, true);
		x.send();
 }
 function saveEstDataAJAX(jobcarddocno,chkmultiple,excess,claimno,pono,podate,vattype,estarray){
	var cmbinsurtype=$('#cmbinsurtype').val();
	var seccldocno=$('#seccldocno').val();
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText.trim();
			if(items=="0"){
				$.messager.alert('Message','Saving Successfull,Please Calculate');
			}
			else{
				$.messager.alert('Warning','Not Saved');
				return false;
			}
			} else {
			}
		}
		x.open("GET", "saveEstDataAJAX.jsp?seccldocno="+seccldocno+"&cmbinsurtype="+cmbinsurtype+"&jobcarddocno="+jobcarddocno+"&chkmultiple="+chkmultiple+"&excess="+excess+"&claimno="+claimno+"&pono="+pono+"&podate="+podate+"&vattype="+vattype+"&estarray="+estarray, true);
		x.send();
 }
function funreload(event)
{
	$('#amountGrid,#estimationGrid').jqxGrid('clear');
	/*if($('#chkmultiple').is(':checked')==true){
		$('#chkmultiple').trigger('click');
	}*/
	$('#excess').val("0.0");
	$('#claimno').val("");
	$('#pono').val("");
	$('#cmbvattype').val("");
	/*if(document.getElementById("cmbbranch").value=='a'){
		document.getElementById("cmbbranch").value="1";
		//return false;
	}*/
	if(document.getElementById("cmbbranch").value=="" || document.getElementById("cmbbranch").value=='a'){
		$.messager.alert('Warning','Please Select Branch');
		return false;
	}
	var dateval=funDateInPeriod($('#periodupto').jqxDateTimeInput('getDate'));
	if(dateval==1){
		$("#overlay, #PleaseWait").show();
		var branch=document.getElementById("cmbbranch").value;
		var date=$('#periodupto').jqxDateTimeInput('val');
		$("#invoiceprocessinggriddiv").load("invoiceProcessingGrid.jsp?branch="+branch+"&todate="+date+"&id=1");
	}
}

	function funNotify(){
		var jobcarddocno=$('#jobcarddocno').val();
		var docdateval=funDateInPeriod($('#periodupto').jqxDateTimeInput('getDate'));
		if(docdateval==0){
			$('#periodupto').jqxDateTimeInput('focus');
			return false;
		}
		var branch=$('#cmbbranch').val();
		var nontaxstatus=0;
		if($('div[data-invoicing="nontax"]').is(':visible')){
			nontaxstatus=1;
			if($('#processstatus').val()=='7'){
				$.messager.alert('Warning','Already Invoiced');
				return false;
			}
		}
		var selectedrows=$('#amountGrid').jqxGrid('getselectedrowindexes');
		if(selectedrows.length==0 && nontaxstatus==0){
			$.messager.alert('Warning','Please select any document');
			return false;
		}
		for(var z=0;z<selectedrows.length;z++){
			var desc=$('#amountGrid').jqxGrid('getcellvalue',selectedrows[z],'description');
			if(desc.length>450){
				$.messager.alert('Warning','Max 450 chars allowed in description');
				return false;
			}
		}
		$.messager.confirm('Confirm', 'Do you want to generate invoice?', function(r){
			if (r){
				var invdate=$('#periodupto').jqxDateTimeInput('val');
				if(nontaxstatus==1){
					$.ajax({
					    url: 'insertNonTaxData.jsp',
					    data: {'jobdocno':jobcarddocno,'invdate':invdate,'branch':branch}, 
					    type: 'POST',
					    async:false,
					    success : function(data, status, xhr){
					    	data=JSON.parse(data);
					    	if(data.errorstatus=="0"){
					    		$.messager.alert('Message','Invoice '+data.invvoucher+' generated');
					    		$("#nonTaxGrid").jqxGrid('clear');
					    		funreload("");
					    	}
					    	else{
						    	$.messager.alert('Message','Invoice not generated');
						    	return false;
					    	}
					    },
					    error : function (xhr, ajaxOptions, thrownError){  
					        console.log(xhr.status);          
					        console.log(thrownError);
					    } 
					});
				}
				else{
					var invoicearray=new Array();
					for(var i=0;i<selectedrows.length;i++){
						var rowno=$('#amountGrid').jqxGrid('getcellvalue',selectedrows[i],'rowno');
						var insurstatus=$('#amountGrid').jqxGrid('getcellvalue',selectedrows[i],'insurstatus');
						var billtoacno=$('#amountGrid').jqxGrid('getcellvalue',selectedrows[i],'billtoacno');
						var claimno=$('#amountGrid').jqxGrid('getcellvalue',selectedrows[i],'claimno');
						var description=$('#amountGrid').jqxGrid('getcellvalue',selectedrows[i],'description');
						var amount=$('#amountGrid').jqxGrid('getcellvalue',selectedrows[i],'amount');
						var discount=$('#amountGrid').jqxGrid('getcellvalue',selectedrows[i],'discount');
						var net=$('#amountGrid').jqxGrid('getcellvalue',selectedrows[i],'net');
						var vat=$('#amountGrid').jqxGrid('getcellvalue',selectedrows[i],'vat');
						var total=$('#amountGrid').jqxGrid('getcellvalue',selectedrows[i],'total');
						var excess=$('#amountGrid').jqxGrid('getcellvalue',selectedrows[i],'excess');
						var roundoff=$('#amountGrid').jqxGrid('getcellvalue',selectedrows[i],'roundoff');
						var netbill=$('#amountGrid').jqxGrid('getcellvalue',selectedrows[i],'netbill');
						var remarks=$('#amountGrid').jqxGrid('getcellvalue',selectedrows[i],'remarks');
						var discountpercent=$('#amountGrid').jqxGrid('getcellvalue',selectedrows[i],'discountpercent');
						var nontaxamt=$('#amountGrid').jqxGrid('getcellvalue',selectedrows[i],'nontaxamt');
						
						//alert(rowno+"::"+insurstatus+"::"+billtoacno+"::"+claimno+"::"+description+"::"+amount+"::"+discount+"::"+net+"::"+vat+"::"+total+"::"+excess+"::"+roundoff+"::"+netbill);
						invoicearray.push(rowno+" :: "+insurstatus+" :: "+billtoacno+" :: "+claimno+" :: "+description+" :: "+amount+" :: "+discount+" :: "+net+" :: "+vat+" :: "+total+" :: "+excess+" :: "+roundoff+" :: "+netbill+" :: "+remarks+" :: "+discountpercent+" :: "+nontaxamt);
					}
					var seccldocno=$('#seccldocno').val();
					var x = new XMLHttpRequest();
					x.onreadystatechange = function() {
						if (x.readyState == 4 && x.status == 200) {
							var items = x.responseText.trim();
							if(items.split("::")[0]=="0"){
								$.messager.alert('Message','Invoice No(s) '+items.split("::")[1]+' Generated');
								$('#amountgriddiv').load('amountGrid.jsp?id=1&jobdocno='+jobcarddocno);	
							}
							else{
								$.messager.alert('Message','Invoice Not Generated');
								return false;
							}
						} else {
						}
					}
					x.open("GET", "generateInv.jsp?seccldocno="+seccldocno+"&invdate="+invdate+"&jobdocno="+jobcarddocno+"&invoicearray="+encodeURIComponent(invoicearray)+"&branch="+branch, true);
					x.send();
				}
				
			}
		});
	}
	function setValues(){
		if($('#msg').val()!=""){
   			$.messager.alert('Message','<center>'+$('#msg').val()+'</center>');
   		}
	}
	function funExportBtn(){
		if(parseInt(window.parent.chkexportdata.value)=="1")
		{
			JSONToCSVCon(invoicedata, 'Rental Invoice', true);
		}
		else
		{
			 $("#rentalInvoiceGrid").jqxGrid('exportdata', 'xls', 'Rental Invoice');
		}
	}
	
	function setMultiple(){
		$('#estimationGrid,#amountGrid').jqxGrid('clear');
		if(document.getElementById("chkmultiple").checked==true){
			document.getElementById("hidchkmultiple").value="1";
		}
		else{
			document.getElementById("hidchkmultiple").value="0";
		}
	}
	
	function funConfirm(){
		$.messager.confirm('Confirm', 'Do you want to confirm invoice?', function(r){
			if (r){
				var jobcarddocno=$('#jobcarddocno').val();
				var x = new XMLHttpRequest();
				x.onreadystatechange = function() {
					if (x.readyState == 4 && x.status == 200) {
						var items = x.responseText.trim();
						if(items=="0"){
							$.messager.alert('Message','Invoice Confirmed');
							funreload("");
						}
						else{
							$.messager.alert('Warning','Not Confirmed');
							return false;
						}
					} else {
					}
				}
				x.open("GET", "confirmInvoice.jsp?jobdocno="+jobcarddocno, true);
				x.send();
			}
		});
	}
	
	function funPrint(){
		var invno=$('#invno').val();
		var invbrhid=$('#invbrhid').val();
		if(invno=='' || invno==null || invno=='undefined'){
			$.messager.alert('Warning','Please select a valid Document');
		}
		else{
			/*var url=document.URL;
	        var reurl=url.split("com");
	        var win= window.open(reurl[0]+"com/workshop/invoice/WSInvoicePrintAction.action?&docno="+document.getElementById("invno").value+"&header=1&branch="+invbrhid,"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
	        //alert(reurl[0]+"WSInvoicePrintAction.action?&docno="+document.getElementById("invno").value+"&header=1&branch="+invbrhid);
	        win.focus();*/
	        invoicePrintContent('printVoucherWindow.jsp'); 
		}
	}
	function invoicePrintContent(url) {
		$('#printWindow').jqxWindow('open');
		$.get(url).done(function (data) {
			$('#printWindow').jqxWindow('setContent', data);
			$('#printWindow').jqxWindow('bringToFront');
		}); 
	}
	function funMovetoJCC(){
		if($('#jobcarddocno').val()==''){
			$.messager.alert('Warning','Please Select a jobcard');
			return false;
		}
		$.get('checkInvoiced.jsp',{jobdocno:$('#jobcarddocno').val()},function(data, status){
			data=JSON.parse(data);
			if(parseInt(data.invstatus)<=0){
				$.messager.confirm('Confirm', 'Do you want to move back to Job Card Complete?', function(r){
					if (r){
						$.post('moveToJCC.jsp',{jobdocno:$('#jobcarddocno').val(),brhid:$('#cmbbranch').val()},function(maindata, mainstatus){
							maindata=JSON.parse(maindata);
							if(maindata.errorstatus=="0"){
								$.messager.alert('Message','Updated Successfully');
								funreload("");
							}
							else{
								$.messager.alert('Message','Not Updated');
								return false;
							}
						});			
					}
				});
			}
			else{
				$.messager.alert('Warning','Job Card Already Invoiced');
				return false;	
			}
		});
		//Checking JobCard is invoiced;
		
	}
</script>
</head>
<body onload="getBranch();setValues();">
<form id="frmWSInvoiceProcessing" action="saveWSInvoiceProcessing" method="post">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%">
<tr>
<td width="20%">
    <fieldset style="background: #ECF8E0;">
	<table width="100%">
	<jsp:include page="../../heading.jsp"></jsp:include>

 <tr><td><label class="branch">Period Upto</label></td><td><div id="periodupto"></div></td></tr>
	<tr>
	<td colspan="2">
		<center>
			<div class="helper-jobcard" style="color:red;font-size: 10px;font-weight: bold;margin-bottom: 3px;"></div>
			<input type="button" name="btninvoicesave" id="btninvoicesave" class="myButton" value="Generate" onclick="funNotify();">
			<input type="button" name="btninvoiceconfirm" id="btninvoiceconfirm" class="myButton" value="Confirm">
			<input type="button" name="btninvoiceprint" id="btninvoiceprint" class="myButton" value="Print" onclick="funPrint();">
			<input type="button" name="btnmovetojcc" id="btnmovetojcc" class="myButton" value="Move to JobCard" onclick="funMovetoJCC();">
		</center>
	</td>
	</tr>
	<tr>
	<td colspan="2"><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br></td>
	</tr>	
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr>
			<td>
			 	<div id="imgdiv" style="position:absolute; z-index: 1;top:200;right:600;">
					<img id="imgloading" alt="" src="../../../../icons/29load.gif"/>
				</div>
				
				<div id="invoiceprocessinggriddiv"><jsp:include page="invoiceProcessingGrid.jsp"></jsp:include></div>
				<div data-invoicing="normal">
					<div style="margin-top:5px;margin-bottom:5px;"><input type="checkbox" name="chkmultiple" id="chkmultiple" onchange="setMultiple();"><label class="branch" style="background-color:transparent;" for="chkmultiple">Multiple</label></div>
					<div id="estimationgriddiv"><jsp:include page="estimationGrid.jsp"></jsp:include></div>
					<table width="100%">
						<tr>
							<td align="right"><label class="branch" style="background-color:transparent;">Excess</label></td>
							<td><input type="text" name="excess" id="excess"></td>
							<td align="right"><label class="branch" style="background-color:transparent;">Claim No</label></td>
							<td><input type="text" name="claimno" id="claimno"></td>
							<td align="right"><label class="branch" style="background-color:transparent;">PO No</label></td>
							<td><input type="text" name="pono" id="pono"></td>
							<td align="right"><label class="branch" style="background-color:transparent;">PO Date</label></td>
							<td><div id="podate"></div></td>
							<td align="right"><label class="branch" style="background-color:transparent;">VAT Type</label></td>
							<td><select name="cmbvattype" id="cmbvattype">
									<option value="">--Select--</option>
									<option value="1">Shared</option>
									<option value="2">Insur.Company</option>
								</select>
							</td>
							<td class="insurtypetd"><label class="branch">Type</label></td>
							<td class="insurtypetd"><select name="cmbinsurtype" id="cmbinsurtype">
									<option value="">--Select--</option>
								</select></td>
							<td><button type="button" id="btninvsave" name="btninvsave"><img src="../../../../icons/tarifsave.png" width="30px" height="30px"/></button>
								<button type="button" id="btninvcalculate" name="btninvcalculate"><img src="../../../../icons/btnbookreload.png"  width="30px" height="30px"/></button>
							</td>
						</tr>
					</table>
					<div id="amountgriddiv"><jsp:include page="amountGrid.jsp"></jsp:include></div>
				</div>
				<div data-invoicing="nontax" style="padding-top:8px;">
					<div id="nontaxgriddiv"><jsp:include page="nonTaxGrid.jsp"></jsp:include></div>
				</div>
				
			</td>
			
			  <input type="hidden" name="gridlength" id="gridlength" >
			  <input type="hidden" name="invgridlength" id="invgridlength" >
			  <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
			  <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
			  <input type="hidden" name="hidchkmultiple" id="hidchkmultiple" value='<s:property value="hidchkmultiple"/>'>
			  <input type="hidden" name="jobcarddocno" id="jobcarddocno" value='<s:property value="jobcarddocno"/>'>
			  <input type="hidden" name="invno" id="invno" value='<s:property value="invno"/>'>
			  <input type="hidden" name="insurtypeconfig" id="insurtypeconfig" value='<s:property value="insurtypeconfig"/>'>
			  <input type="hidden" name="seccldocno" id="seccldocno" value='<s:property value="seccldocno"/>'>
			  <input type="hidden" name="faulttype" id="faulttype" value='<s:property value="faulttype"/>'>
		</tr>
	</table>
</tr>
</table>
</div>
<div id="insurtypewindow">
   <div></div>
</div>
<div id="clientwindow">
<div></div>
</div>
<div id="printWindow">
	<div></div>
</div>
</div>
</form>
</body>
</html>