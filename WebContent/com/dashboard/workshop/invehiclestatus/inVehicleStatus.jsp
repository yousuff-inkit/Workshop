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
.myButtons {
	display: inline-block;
	margin-right:4px;
	margin-left:4px; 
  margin-bottom: 0;
  font-weight: normal;
  line-height: 1.3;
  text-align: center;
  white-space: nowrap;
  vertical-align: middle;
  -ms-touch-action: manipulation;
      touch-action: manipulation;
  cursor: pointer;
  -webkit-user-select: none;
     -moz-user-select: none;
      -ms-user-select: none;
          user-select: none;
  background-image: none;
  border: 1px solid transparent;
  border-radius: 4px;
  color: #fff;
  background-color: grey;
}
.myButtons:hover {
	  color: #fff;
  background-color: #31b0d5;
  
}
.myButtons:active {
  color: #fff;
  background-color: #31b0d5;
  
}
.myButtons:focus {
  color: #fff;
  background-color: grey;
}
 
select{
    height:15px;
}
</style>

<script type="text/javascript">

$(document).ready(function () {
		
	$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200px;right:750px;'><img src='../../../../icons/31load.gif'/></div>");
    $('#clientwindow').jqxWindow({ width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Client Search'  , theme: 'energyblue', position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	$('#clientwindow').jqxWindow('close');
	$('#gipwindow').jqxWindow({ width: '30%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Gate In Pass Search'  , theme: 'energyblue', position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	$('#gipwindow').jqxWindow('close');
	$("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	$('#client').dblclick(function(){
		$('#clientwindow').jqxWindow('open');
		clientSearchContent('clientsearch.jsp?id=1', $('#clientwindow')); 
	});
	$('#gipvocno,#regno').dblclick(function(){
		$('#gipwindow').jqxWindow('open');
		gipSearchContent('gipSearch.jsp?id=1', $('#gipwindow')); 
	});
});


function getClientInfo(event){
	 var x= event.keyCode;
	if(x==114){
		$('#clientwindow').jqxWindow('open');
		clientSearchContent('clientsearch.jsp?id=1', $('#clientwindow'));
	}
	else{}
} 
function getGipInfo(event){
	 var x= event.keyCode;
	if(x==114){
		$('#gipwindow').jqxWindow('open');
		gipSearchContent('gipSearch.jsp?id=1', $('#gipwindow'));
	}
	else{}
} 
function clientSearchContent(url) {
	 	$.get(url).done(function (data) {
		$('#clientwindow').jqxWindow('open');
		$('#clientwindow').jqxWindow('setContent', data);
}); 
} 
function gipSearchContent(url) {
 	$.get(url).done(function (data) {
	$('#gipwindow').jqxWindow('open');
	$('#gipwindow').jqxWindow('setContent', data);
}); 
} 
function funreload(event)
{
	
    var todate=$('#todate').jqxDateTimeInput('val');
	var branch=$('#cmbbranch').val();
	var cldocno=$('#cldocno').val();
	var gipdocno=$('#gipdocno').val();
	var regno=$('#regno').val();
    $("#overlay, #PleaseWait").show();
   	$("#countdiv").load("countGrid.jsp?todate="+todate+"&id=1&branch="+branch+"&cldocno="+cldocno+"&gipdocno="+gipdocno+"&regno="+regno);
   	
}
	
	

	function setValues(){

		 if($('#msg').val()!=""){
   		   $.messager.alert('Message',$('#msg').val());
   		  }
	
	}
	
	function funExportBtn(){
		//JSONToCSVCon(repexceldata, 'Replacement List', true);
		 }
	
		
	
	function funClearData(){
		$('input[type=text],[type=hidden]').val('');
		$('select').find('option').prop("selected", false);
		$('#todate').jqxDateTimeInput('setDate',new Date());
	
	}
	function funExportBtn(){
		JSONToCSVCon(detailexceldata,"Analysis of "+document.getElementById("docstatus").value, true);
	}
	
	</script>
	
</head>
<body onload="setValues();getBranch();">
<form id="frmICGateInPass" method="post" autocomplete="off">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%">
<tr>
<td width="23%" align="center">
    <fieldset style="background: #ECF8E0;">
	<table width="100%">
	<jsp:include page="../../heading.jsp"></jsp:include>

 <tr>
   <td width="37%" align="right"><label class="branch">Up To Date</label></td>
   <td width="63%"><div id="todate"></div></td>
 </tr>
 <tr>
   <td align="right"><label class="branch">Client</label></td>
   <td><input type="text" name="client" id="client" value='<s:property value="client"/>' onkeydown="getClientInfo(event);"></td>
 	<input type="hidden" name="cldocno" id="cldocno" value='<s:property value="cldocno"/>'>
 </tr>
 <tr>
   <td align="right"><label class="branch">GIP No</label></td>
   <td><input type="text" name="gipvocno" id="gipvocno" value='<s:property value="gipvocno"/>' onkeydown="getGipInfo(event);"></td>
 	<input type="hidden" name="gipdocno" id="gipdocno" value='<s:property value="gipdocno"/>'>
 </tr>
 <tr>
   <td align="right"><label class="branch">Reg No</label></td>
   <td><input type="text" name="regno" id="regno" value='<s:property value="regno"/>'  onkeydown="getGipInfo(event);"></td>
 </tr>
 <tr>
   <td colspan="2" >&nbsp;</td>
 </tr>
 <tr>
   <td colspan="2" style="border-top:2px solid #DCDDDE;">&nbsp;</td>
 </tr>
 
 <tr>
 <td colspan="2">
 	<div id="countdiv"><jsp:include page="countGrid.jsp"></jsp:include></div>
 </td>
 <tr >
	<td colspan="2" style="border-top:2px solid #DCDDDE;">
	<div style="text-align:center;">
	<input type="button" name="btnclear" id="btnclear" value="Clear" class="myButtons" onclick="funClearData();"><!-- &nbsp;&nbsp;
	<input type="button" name="btnrepprint" id="btnrepprint" value="Print" class="myButtons" onclick="funPrintData();"> -->
	</div>
    </td>
	</tr>
<tr ><td colspan="2">&nbsp;
</td></tr>
	</table>
	</fieldset>
</td>
<td width="77%">
	<table width="100%">
		<tr>
			 <td><div id="detaildiv"><jsp:include page="detailGrid.jsp"></jsp:include></div></td>
			  <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
			  <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
			  <input type="hidden" name="printdocno" id="printdocno" value='<s:property value="printdocno"/>'>
			  <input type="hidden" name="docstatus" id="docstatus" value='<s:property value="docstatus"/>'>
			
		</tr>
	</table>
</tr>
</table>
</div>
<div id="clientwindow">
<div></div>
</div>
<div id="gipwindow">
<div></div>
</div>
</div>
</form>
</body>
</html>