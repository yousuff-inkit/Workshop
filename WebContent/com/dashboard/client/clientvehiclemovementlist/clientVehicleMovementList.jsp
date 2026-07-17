
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
<script type="text/javascript">

$(document).ready(function () {
	 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
	 $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200;right:600;'><img src='../../../../icons/31load.gif'/></div>");    
	 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	
	 var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
     var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
     $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate);
     $('#fleetwindow').jqxWindow({ width: '40%', height: '50%',  maxHeight: '50%' ,maxWidth: '40%' , title: 'Fleet Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	 $('#fleetwindow').jqxWindow('close');
	 $('#fleetno').dblclick(function(){
	 	$('#fleetwindow').jqxWindow('open');
		$('#fleetwindow').jqxWindow('focus');
		fleetSearchContent('fleetSearch.jsp', $('#fleetwindow'));
	 });
});
function getFleet(event){
	var x= event.keyCode;
	if(x==114){
		$('#fleetwindow').jqxWindow('open');
		$('#fleetwindow').jqxWindow('focus');
		fleetSearchContent('fleetSearch.jsp', $('#fleetwindow'));
   	}
   	else{
    }
}
function fleetSearchContent(url) {
	$.get(url).done(function (data) {
   		$('#fleetwindow').jqxWindow('setContent', data);
	}); 
}
function funreload(event)
{
	
	if($('#fleetno').val()==''){
		$.messager.alert('warning','Please select Fleet');
		return false;
	}
	var fromdate=$('#fromdate').jqxDateTimeInput('val');
	var todate=$('#todate').jqxDateTimeInput('val');
	var branch=$('#cmbbranch').val();
	var fleetno=$('#fleetno').val();
	$('#overlay,#PleaseWait').show();
	$("#clientvehiclediv").load("clientVehicleGrid.jsp?fromdate="+fromdate+"&todate="+todate+"&branch="+branch+"&id=1&fleetno="+fleetno+"&check=1");
}
function setValues(){
	
	if($('#msg').val()!=""){
		$.messager.alert('Message','<center>'+$('#msg').val()+'</center>');
	}
}
function funExportBtn(){

/* 		 if(parseInt(window.parent.chkexportdata.value)=="1")
	  {
	  	JSONToCSVCon(invoicedata, 'Rental Invoice', true);
	  }
	 else
	  {
		 $("#rentalInvoiceGrid").jqxGrid('exportdata', 'xls', 'Rental Invoice');
	  }
*/
	
	
}

</script>
</head>
<body onload="getBranch();setValues();">
<form id="frmClientVehicleMovement" action="saveclientVehicleMovement" method="post">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%">
<tr>
<td width="20%">
    <fieldset style="background: #ECF8E0;">
	<table width="100%">
	<jsp:include page="../../heading.jsp"></jsp:include>

 <tr><td width="26%" align="right"><label class="branch">From Date</label></td><td width="74%"><div id="fromdate" name="fromdate"></div></td></tr>
 <tr><td align="right"><label class="branch">To Date</label></td><td ><div id="todate" name="todate"></div></td></tr>
  <tr>
   <td align="right"><label class="branch">Fleet</label></td>
   <td><input type="text" name="fleetno" id="fleetno" style="height:18px;" placeholder="Press F3 to Search" readonly></td>
 </tr>
		 <tr>
	<td colspan="2">&nbsp;</td>
	</tr> 
	<tr>
	<td colspan="2"><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br></td>
	</tr>	
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="clientvehiclediv"><jsp:include page="clientVehicleGrid.jsp"></jsp:include></div> </td>
			  <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
			  <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
			   
		</tr>
	</table>
</tr>
</table>
</div>
<div id="fleetwindow">
<div></div>
</div>
</div>
</form>
</body>
</html>