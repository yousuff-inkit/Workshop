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
	$('#clientwindow').jqxWindow({ width: '62%', height: '65%',  maxHeight: '85%' ,maxWidth: '80%' , title: 'Client Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	$('#clientwindow').jqxWindow('close');
	$('#client').dblclick(function(){
		$('#clientwindow').jqxWindow('open');
		$('#clientwindow').jqxWindow('focus');
		clientSearchContent('clientINgridsearch.jsp', $('#clientwindow'));
	});
	var fromdate=new Date($('#fromdate').jqxDateTimeInput('getDate'));
	var onemonthbefore=new Date(new Date(fromdate).setMonth(fromdate.getMonth()-1)); 
    $('#fromdate').jqxDateTimeInput('setDate', new Date(onemonthbefore));
	document.getElementById("imgloading").style.display="none";
	
	
});
function getClient(event){
	var x= event.keyCode;
    if(x==114){
    	$('#clientwindow').jqxWindow('open');
  		$('#clientwindow').jqxWindow('focus');
  		clientSearchContent('clientINgridsearch.jsp', $('#clientwindow'));
    }
    else{
    }
}

function clientSearchContent(url) {
	$.get(url).done(function (data) {
    	$('#clientwindow').jqxWindow('setContent', data);
	}); 
}

function funreload(event)
{
	
	
	var branchvalue = document.getElementById("cmbbranch").value;
 	var fromdate= $('#fromdate').jqxDateTimeInput('getText');
 	var todate= $('#todate').jqxDateTimeInput('getText');
	var client=document.getElementById("hidclient").value;
 	var type='';
 	$('#leaseinvoicediv').load('leaseInvoiceGrid.jsp?fromdate='+fromdate+'&todate='+todate+'&branch='+branchvalue+'&client='+client+'&id=1&type='+type);
	}
function funCalculate(){
	
	}

	
	function funNotify(){
		
	}
	function setValues(){

	}
	 function funExportBtn(){
		if(parseInt(window.parent.chkexportdata.value)=="1")
		  {
		  	JSONToCSVCon(agmtdataexcel, 'Agreement Wise Invoice List of '+$('#tempclientname').val()+' with Invoice '+$('#invvocno').val(), true);
		  }
		 else
		  {
			 $("#leaseInvoiceGrid").jqxGrid('exportdata', 'xls', 'Lease Invoice');
		  }
		 
	}

		
</script>
</head>
<body onload="getBranch();setValues();">
<form id="frmDashboardLeaseInvoiceEasy" action="saveDashboardLeaseInvoiceEasy" method="post" >
<input type="hidden" id="selectedagmt" name="selectedagmt">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%">
<tr>
<td width="20%">
    <fieldset style="background: #ECF8E0;">
	<table width="100%">
	<jsp:include page="../../heading.jsp"></jsp:include>
	
	<!--  <tr><td colspan="2">&nbsp;</td></tr> -->
 <tr><td width="30%" align="right"><label class="branch">From Date</label></td><td width="70%"><div id="fromdate" name="fromdate"></div></td></tr>
 <tr><td  align="right"><label class="branch">To Date</label></td><td><div id="todate" name="todate"></div></td></tr>
<tr><td  align="right"><label class="branch">Client</label></td><td><input type="text" name="client" id="client" onkeydown="getClient(event);" readonly value='<s:property value="client"/>' style="height:18px;" placeholder="Press F3 to Search"></td></tr>
  <input type="hidden" name="hidagmtno" id="hidagmtno" value='<s:property value="hidagmtno"/>'>
<input type="hidden" name="hidclient" id="hidclient" >

   
	<tr>
	<td colspan="2"><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br></td>
	</tr>	
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td> <div id="imgdiv" style="position:absolute; z-index: 1;top:200;right:600;">
<img id="imgloading" alt="" src="../../../../icons/31load.gif"/></div> <div id="leaseinvoicediv"> <!-- 29load -->
<jsp:include page="leaseInvoiceGrid.jsp"></jsp:include></div><div id="leaseagmtdiv"> <!-- 29load -->
<jsp:include page="agmtDetailGrid.jsp"></jsp:include></div></td>
			 <input type="hidden" name="gridlength" id="gridlength" >
			  <input type="hidden" name="invgridlength" id="invgridlength" >
			  <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
			  <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
			  <input type="hidden" name="invvocno" id="invvocno" value='<s:property value="invvocno"/>'>
			  <input type="hidden" name="invtrno" id="invtrno" value='<s:property value="invtrno"/>'>
			  <input type="hidden" name="tempclientname" id="tempclientname" value='<s:property value="tempclientname"/>'>
		</tr>
	</table>
</tr>
</table>
</div>
<div id="clientwindow">
<div></div>
</div>
<div id="agmtwindow">
<div></div>
</div>
</div>
</form>
</body>
</html>