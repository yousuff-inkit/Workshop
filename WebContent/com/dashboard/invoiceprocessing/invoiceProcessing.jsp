<link href="../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<jsp:include page="../../../includes.jsp"></jsp:include>    
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
	$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
	$("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200;right:600;'><img src='../../../../icons/31load.gif'/></div>");    
	$("#periodupto").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	$("#podate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	$('#periodupto').on('change', function (event) 
	{  
		var docdateval=funDateInPeriod($('#periodupto').jqxDateTimeInput('getDate'));
		if(docdateval==0){
			$('#periodupto').jqxDateTimeInput('focus');
			return false;
		}
	});
	$('#btninvcalculate').click(function(){
		var jobcarddocno=$('#jobcarddocno').val();
		var chkmultiple=$('#hidchkmultiple').val();
		var excess=$('#excess').val();
		var claimno=$('#claimno').val();
		var pono=$('#pono').val();
		var podate=$('#podate').jqxDateTimeInput('val');
		var vattype=$('#cmbvattype').val();
		var rows=$('#estimationGrid').jqxGrid('getrows');
		var estarray=new Array();
		for(var i=0;i<rows.length;i++){
			var estno=$('#estimationGrid').jqxGrid('getcellvalue',i,'estno');
			var labourtotal=$('#estimationGrid').jqxGrid('getcellvalue',i,'labourtotal');
			var sparetotal=$('#estimationGrid').jqxGrid('getcellvalue',i,'sparetotal');
			var nettotal=$('#estimationGrid').jqxGrid('getcellvalue',i,'nettotal');
			var chkclaim=$('#estimationGrid').jqxGrid('getcellvalue',i,'chkclaim');
			var claimno=$('#estimationGrid').jqxGrid('getcellvalue',i,'claimno');
			var excess=$('#estimationGrid').jqxGrid('getcellvalue',i,'excess');
			var pono=$('#estimationGrid').jqxGrid('getcellvalue',i,'pono');
			var podate=$('#estimationGrid').jqxGrid('getcelltext',i,'podate');
			var vattype=$('#estimationGrid').jqxGrid('getcellvalue',i,'vattype');
			estarray.push(estno+"::"+labourtotal+"::"+sparetotal+"::"+nettotal+"::"+chkclaim+"::"+claimno+"::"+excess+"::"+pono+"::"+podate+"::"+vattype);
		}
		calculateAJAX(jobcarddocno,chkmultiple,excess,claimno,pono,podate,vattype,estarray);
	});
});

 function calculateAJAX(jobcarddocno,chkmultiple,excess,claimno,pono,podate,vattype,estarray){
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText.trim();
			} else {
			}
		}
		x.open("GET", "calculateAJAX.jsp?jobcarddocno="+jobcarddocno+"&chkmultiple="+chkmultiple+"&excess="+excess+"&claimno="+claimno+"&pono="+pono+"&podate="+podate+"&vattype="+vattype+"&estarray="+estarray, true);
		x.send();
 }
function funreload(event)
{
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
		var docdateval=funDateInPeriod($('#periodupto').jqxDateTimeInput('getDate'));
		if(docdateval==0){
			$('#periodupto').jqxDateTimeInput('focus');
			return false;
		}
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText.trim();
			} else {
			}
		}
		x.open("GET", "generateInv.jsp?jobcarddocno="+jobcarddocno+"&chkmultiple="+chkmultiple+"&excess="+excess+"&claimno="+claimno+"&pono="+pono+"&podate="+podate+"&vattype="+vattype+"&estarray="+estarray, true);
		x.send();
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
		$('#estimationGrid').jqxGrid('clear');
		if(document.getElementById("chkmultiple").checked==true){
			document.getElementById("hidchkmultiple").value="1";
		}
		else{
			document.getElementById("hidchkmultiple").value="0";
		}
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
	<jsp:include page="../heading.jsp"></jsp:include>

 <tr><td><label class="branch">Period Upto</label></td><td><div id="periodupto"></div></td></tr>
	<tr>
	<td colspan="2"><center><input type="button" name="btninvoicesave" id="btninvoicesave" class="myButton" value="Generate" onclick="funNotify();"></center></td>
	</tr>
	<tr>
	<td colspan="2"><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br></td>
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
						<td><button type="button" id="btninvcalculate" name="btninvcalculate" class="myButton">Calculate</button></td>
					</tr>
				</table>
				<div id="amountgriddiv"><jsp:include page="amountGrid.jsp"></jsp:include></div>
			</td>
			
			 <input type="hidden" name="gridlength" id="gridlength" >
			  <input type="hidden" name="invgridlength" id="invgridlength" >
			  <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
			  <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
			  <input type="hidden" name="hidchkmultiple" id="hidchkmultiple" value='<s:property value="hidchkmultiple"/>'>
			  <input type="hidden" name="jobcarddocno" id="jobcarddocno" value='<s:property value="jobcarddocno"/>'>
		</tr>
	</table>
</tr>
</table>
</div>
<div id="clientwindow">
<div></div>
</div>
</div>
</form>
</body>
</html>