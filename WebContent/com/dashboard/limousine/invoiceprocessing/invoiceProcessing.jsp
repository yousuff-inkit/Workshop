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
	 document.getElementById("imgloading").style.display="none";
	 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
	 $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200;right:600;'><img src='../../../../icons/31load.gif'/></div>");    
	 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#currentdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $('#clientwindow').jqxWindow({width: '50%', height: '55%',  maxHeight: '55%' ,maxWidth: '50%' , title: 'Client Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 $('#clientwindow').jqxWindow('close');
	 $('#guestwindow').jqxWindow({width: '50%', height: '55%',  maxHeight: '55%' ,maxWidth: '50%' , title: 'Guest Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 $('#guestwindow').jqxWindow('close');
	  var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
         var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
         $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate); 
	 
	 $('#client').dblclick(function(){
		$('#clientwindow').jqxWindow('open');
		$('#clientwindow').jqxWindow('focus');
		clientSearchContent('masterClientSearch.jsp'); 
	 });
	 $('#guest').dblclick(function(){
		$('#guestwindow').jqxWindow('open');
		$('#guestwindow').jqxWindow('focus');
		guestSearchContent('masterGuestSearch.jsp'); 
	});
});
function clientSearchContent(url) {
	 $.get(url).done(function (data) {
		$('#clientwindow').jqxWindow('setContent', data);

}); 
}
function guestSearchContent(url) {
	 $.get(url).done(function (data) {
		$('#guestwindow').jqxWindow('setContent', data);

}); 
}

function getClient(event){
	if(event.keyCode==114){
		$('#clientwindow').jqxWindow('open');
		$('#clientwindow').jqxWindow('focus');
		clientSearchContent('masterClientSearch.jsp'); 
	}
}
function getGuest(event){
	if(event.keyCode==114){
		$('#guestwindow').jqxWindow('open');
		$('#guestwindow').jqxWindow('focus');
		guestSearchContent('masterGuestSearch.jsp'); 
	}
}

function funreload(event)
{
	var branch=$('#cmbbranch').val();
	
	if(branch=="" || branch=="a"){
		$.messager.alert('warning','Please select a specific branch');
		return false;
	}
	if(document.getElementById("rdoclient").checked==false  && document.getElementById("rdojob").checked==false){
		$.messager.alert('warning','Please select Invoice type');
		return false;
	}
	var client=document.getElementById("hidclient").value;
	var guest=document.getElementById("hidguest").value;
	var fromdate=$("#fromdate").jqxDateTimeInput('val');
	var todate=$("#todate").jqxDateTimeInput('val');
	var bookdocno=$('#bookdocno').val();
	var jobtype=$('#cmbjobtype').val();
	var invoicetype="";
	if(document.getElementById("rdoclient").checked==true){
		invoicetype="client";
	}
	else if(document.getElementById("rdojob").checked==true){
		invoicetype="job";
	}
	$('#limoinvoicediv').load('limoInvoiceGrid.jsp?client='+client+'&guest='+guest+'&fromdate='+fromdate+'&todate='+todate+'&branch='+branch+'&id=1&bookdocno='+bookdocno+'&jobtype='+jobtype+"&invoicetype="+invoicetype);
}
function funCalculate(){
	
}
	

function funNotify(){
	var selectedrows=$('#limoInvoiceGrid').jqxGrid('getselectedrowindexes');
	if(selectedrows.length==0){
		$.messsager.alert('warning','Cannot generate empty invoice');
		return 0;
	}
	if(document.getElementById("rdoclient").checked==false && document.getElementById("rdojob").checked==false){
		$.messager.alert('warning','Please select a valid invoice type');
		return 0;
	} 
	document.getElementById("gridlength").value=selectedrows.length;
	for(var i=0;i<selectedrows.length;i++){
		newTextBox = $(document.createElement("input"))
		.attr("type", "dil")
		.attr("id", "invoice"+i)
		.attr("name", "invoice"+i)
		.attr("hidden", "true");
		
		var cldocno=$('#limoInvoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'cldocno');
		var guestno=$('#limoInvoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'guestno');
		var jobtype=$('#limoInvoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'jobtype');
		var jobdocno=$('#limoInvoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'jobdocno');
		var bookdocno=$('#limoInvoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'bookdocno');
		var jobnametemp=$('#limoInvoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'jobnametemp');
		var total=$('#limoInvoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'total');
		var tarif=$('#limoInvoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'tarif');
		var nighttarif=$('#limoInvoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'nighttarif');
		var exkmchg=$('#limoInvoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'exkmchg');
		var exhrchg=$('#limoInvoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'exhrchg');
		var nightextrahrchg=$('#limoInvoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'nightextrahrchg');
		var fuelchg=$('#limoInvoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'fuelchg');
		var parkingchg=$('#limoInvoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'parkingchg');
		var otherchg=$('#limoInvoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'otherchg');
		var greetchg=$('#limoInvoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'greetchg');
		var vipchg=$('#limoInvoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'vipchg');
		var boquechg=$('#limoInvoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'boquechg');
		
		newTextBox.val(cldocno+"::"+guestno+"::"+jobtype+"::"+jobdocno+"::"+bookdocno+"::"+jobnametemp+"::"+total+"::"+tarif+"::"+nighttarif+"::"+exkmchg+"::"+exhrchg+"::"+nightextrahrchg+"::"+fuelchg+"::"+parkingchg+"::"+otherchg+"::"+greetchg+"::"+vipchg+"::"+boquechg+"::"+"0"+"::"+"0"+"::"+"0"+"::"+"0");
		newTextBox.appendTo('form');
		
		
	}
	document.getElementById("mode").value="A";
	document.getElementById("frmDashboardLimoInvoice").submit();
	
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

</script>
</head>
<body onload="getBranch();setValues();">
<form id="frmDashboardLimoInvoice" action="saveDashboardLimoInvoice" method="post">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%">
<tr>
<td width="19%">
    <fieldset style="background: #ECF8E0;">
	<table width="100%">
	<jsp:include page="../../heading.jsp"></jsp:include>

 <tr><td align="right"><label class="branch">From Date</label></td><td><div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div></td></tr>
 <tr>
   <td align="right"><label class="branch">To Date</label></td>
   <td><div id="todate" name="todate" value='<s:property value="todate"/>'></div></td>
 </tr>
 <tr>
   <td align="right"><span class="branch">Client</span></td>
   <td><input type="text" name="client" id="client" onkeydown="getClient(event);" readonly value='<s:property value="client"/>' style="height:18px;" placeholder="Press F3 to Search"></td>
 </tr>
 <tr>
   <td align="right"><span class="branch">Guest</span></td><td><input type="text" name="guest" id="guest" onkeydown="getGuest(event);" readonly value='<s:property value="guest"/>' style="height:18px;" placeholder="Press F3 to Search"></td></tr>
 
  <tr>
    <td align="right"><span class="branch">Booking</span></td>
    <td align="left"><input type="text" name="bookdocno" id="bookdocno" readonly value='<s:property value="bookdocno"/>' style="height:18px;" placeholder="Press F3 to Search"></td>
  </tr>
  <tr>
    <td  align="right"><span class="branch">Job Type</span></td>
    <td align="left">
    <select name="cmbjobtype" id="cmbjobtype" style="width:70%;">
    <option value="">--Select--</option>
    <option value="Transfer">Transfer</option>
    <option value="Limo">Limo</option>
    </select>
    </td>
  </tr>
  <tr>
    <td  align="right"><span class="branch">LPO No</span></td>
    <td align="left">
    <input type="text" name="lpono" id="lpono" value='<s:property value="lpono"/>' style="height:18px;">
    </td>
  </tr>
  <tr>
    <td  align="right"><span class="branch">Event</span></td>
    <td align="left">
    <input type="text" name="eventno" id="eventno" value='<s:property value="eventno"/>' style="height:18px;">
    </td>
  </tr>
  <tr>
    <td colspan="2" align="left">
    <fieldset><legend><span class="branch">Invoice Type</span></legend>
    	<center><input type="radio" name="limoinvtype" value="clientwise" id="rdoclient"><label for="rdoclient" class="branch">Client wise</label>
        &nbsp;&nbsp;
        <input type="radio" name="limoinvtype" value="jobwise" id="rdojob"><label for="rdojob" class="branch">Job wise</label></center>
    </fieldset>
    </td>
  </tr>
 <tr>
   <td colspan="2" align="center"><input type="button" name="btninvoicesave" id="btninvoicesave" class="myButton" value="Generate" onclick="funNotify();"></td>
   </tr>
<input type="hidden" name="hidclient" id="hidclient" >
<input type="hidden" name="hidguest" id="hidguest">
<tr>
  <td colspan="2" align="left">&nbsp;<br><br><br></td>
  </tr> 
  
   <tr>
     <td colspan="2">&nbsp;</td>
   </tr>
	<tr>
	<td colspan="2">&nbsp;</td>
	</tr>	
	</table>
	</fieldset>
</td>
<td width="81%">
	<table width="100%">
		<tr>
			 <td> <div id="imgdiv" style="position:absolute; z-index: 1;top:200;right:600;">
<img id="imgloading" alt="" src="../../../../icons/31load.gif"/></div> <div id="limoinvoicediv"><jsp:include page="limoInvoiceGrid.jsp"></jsp:include></div></td>
			 <input type="hidden" name="gridlength" id="gridlength" >
			  <input type="hidden" name="invgridlength" id="invgridlength" >
			  <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
			  <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
			  <div id="currentdate" name="currentdate" hidden="true"></div>
		</tr>
	</table>
</tr>
</table>
</div>
<div id="clientwindow">
	<div></div><div></div>
</div>
<div id="guestwindow">
	<div></div><div></div>
</div>
</div>
</form>
</body>
</html>