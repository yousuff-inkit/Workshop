><jsp:include page="../../../../includes.jsp"></jsp:include>    
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

<script type="text/javascript">

$(document).ready(function () {
	$("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	$("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	$('#accountwindow').jqxWindow({ width: '62%', height: '65%',  maxHeight: '85%' ,maxWidth: '80%' , title: 'Account Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	$('#accountwindow').jqxWindow('close');
	$('#regnowindow').jqxWindow({ width: '30%', height: '65%',  maxHeight: '85%' ,maxWidth: '30%' , title: 'Reg No Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	$('#regnowindow').jqxWindow('close');
	var fromdate=new Date($('#fromdate').jqxDateTimeInput('getDate'));
	var onemonthbefore=new Date(new Date(fromdate).setMonth(fromdate.getMonth()-1)); 
    $('#fromdate').jqxDateTimeInput('setDate', new Date(onemonthbefore));
	
	$('#todate').on('change', function (event) {
		var fromdate=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		var todate=new Date($('#todate').jqxDateTimeInput('getDate'));
		if(fromdates>todates){
			$.messager.alert('Message','To Date Less Than From Date  ','warning');   
			return false;
		}   
	});
	
	$('#account').dblclick(function(){
		$('#accountwindow').jqxWindow('open');
		$('#accountwindow').jqxWindow('focus');
		accountSearchContent('accountSearch.jsp');
	});
	$('#regno').dblclick(function(){
		$('#regnowindow').jqxWindow('open');
		$('#regnowindow').jqxWindow('focus');
		regnoSearchContent('regnoSearchGrid.jsp?id=1');
	});
});

function getAccount(event){
	var x= event.keyCode;
    if(x==114){
    	$('#accountwindow').jqxWindow('open');
		$('#accountwindow').jqxWindow('focus');
		accountSearchContent('accountSearch.jsp');
    }
    else{
    }
}
function getRegno(event){
	var x= event.keyCode;
    if(x==114){
    	$('#regnowindow').jqxWindow('open');
		$('#regnowindow').jqxWindow('focus');
		regnoSearchContent('regnoSearchGrid.jsp?id=1');
    }
    else{
    }
}
function accountSearchContent(url) {
	$.get(url).done(function (data) {
	    $('#accountwindow').jqxWindow('setContent', data);
	}); 
}
function regnoSearchContent(url) {
	$.get(url).done(function (data) {
	    $('#regnowindow').jqxWindow('setContent', data);
	}); 
}
function funClearData(){
	$('#fromdate,#todate').jqxDateTimeInput('setDate',new Date());
	var fromdate=new Date($('#fromdate').jqxDateTimeInput('getDate'));
	var onemonthbefore=new Date(new Date(fromdate).setMonth(fromdate.getMonth()-1)); 
    $('#fromdate').jqxDateTimeInput('setDate', new Date(onemonthbefore));
	$('#todate').val(new Date());
	$('input[type=text],[type=hidden]').val('');
}
	
function funreload(event){
	var fromdate=new Date($('#fromdate').jqxDateTimeInput('getDate'));
	var todate=new Date($('#todate').jqxDateTimeInput('getDate'));
	if(fromdate>todate){
		$.messager.alert('Message','To Date Less Than From Date','warning');   
		return false;
	} 
	else{
		var branch = document.getElementById("cmbbranch").value;
		fromdate = $('#fromdate').val();
		todate = $('#todate').val();
		var acno=$('#acno').val();
		var regno=$('#regno').val();
		$("#overlay, #PleaseWait").show();
		$('#invoicelistgriddiv').load('invoiceListGrid.jsp?branch='+branch+'&fromdate='+fromdate+'&todate='+todate+'&id=1&acno='+acno+'&regno='+regno);
	}
}

function funExportBtn(){
	$("#invoiceListGrid").excelexportjs({
		containerid: "invoiceListGrid",
		datatype: 'json',
		dataset: null,
		gridId: "invoiceListGrid",
		columns: getColumns("invoiceListGrid"),
		worksheetName: "Invoice List"
	});
}

function funPrint(){
	var invno=$('#invno').val();
	var invbrhid=$('#invbrhid').val();
	if(invno=='' || invno==null || invno=='undefined'){
		$.messager.alert('Warning','Please select a valid Document');
	}
	else{
		var url=document.URL;
        var reurl=url.split("com");
        var win= window.open(reurl[0]+"WSInvoicePrintActionpal.action?&docno="+document.getElementById("invno").value+"&header=1&branch="+invbrhid+"&type="+1+"&jobcarddocno="+$('#jobdocno').val(),"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
        //alert(reurl[0]+"WSInvoicePrintAction.action?&docno="+document.getElementById("invno").value+"&header=1&branch="+invbrhid);
        win.focus();
	}
}
</script>
<style>
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
	
     
      

</style>

</head>
<body onload="getBranch();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%"  >
	<jsp:include page="../../heading.jsp"></jsp:include>
		
	<tr><td colspan="2">&nbsp;</td></tr>
    <tr>
	 <td align="right"><label class="branch">From</label></td>
     <td align="left"><div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div></td></tr> 
	<tr>
	<td align="right"><label class="branch">To</label></td>
    <td align="left"><div id="todate" name="todate" value='<s:property value="todate"/>'></div></td>
	</tr>
	<tr>
	<td align="right"><label class="branch">Reg No</label></td>
    <td align="left"><input type="text" name="regno" id="regno" readonly placeholder="Press F3 to Search" style="height:18px;" onkeydown="getRegno(event);"></td>
	</tr>
	<tr>
	<td align="right"><label class="branch">Account</label></td>
    <td align="left"><input type="text" name="account" id="account" readonly placeholder="Press F3 to Search" style="height:18px;" onkeydown="getAccount(event);"></td>
	</tr>
	<input type="hidden" name="acno" id="acno" >
	<tr>
		<td colspan="2"><input type="text" name="accountname" id="accountname" style="width:100%;height:18px;" readonly disabled></td>
	</tr>
	
	<tr><td align="center"><input type="button" name="btninvoiceprint" id="btninvoiceprint" class="myButton" value="Print" onclick="funPrint();"></td>
	<td align="center"><input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funClearData();"></td></tr> 
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr> 
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr> 
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
    <tr><td colspan="2"> <input type="hidden" name="invno" id="invno" value='<s:property value="invno"/>'>
     <input type="hidden" name="invbrhid" id="invbrhid" value='<s:property value="invbrhid"/>'>
      <input type="hidden" name="jobdocno" id="jobdocno" value='<s:property value="jobdocno"/>'></td></tr> 
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="invoicelistgriddiv"><jsp:include page="invoiceListGrid.jsp"></jsp:include></div></td>
		</tr>
	</table>
</tr>
</table>
</div>
<div id="accountwindow">
	<div></div>
</div>
<div id="regnowindow">
	<div></div>
</div>
</div> 
</body>
</html>