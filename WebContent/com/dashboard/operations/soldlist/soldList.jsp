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
		/* document.getElementById("branchlabel").style.display="none";
		document.getElementById("branchdiv").style.display="none"; */
		   $("#btnExcel").click(function() {
				JSONToCSVCon(repexceldata, 'Replacement List', true);
				//$("#vehiclelist").jqxGrid('exportdata', 'xls', 'vehiclelist');
			});
		$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200px;right:750px;'><img src='../../../../icons/31load.gif'/></div>");
	     $('#clientwindow').jqxWindow({ width: '62%', height: '65%',  maxHeight: '85%' ,maxWidth: '80%' , title: 'Client Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		   $('#clientwindow').jqxWindow('close');
		   $('#fleetwindow').jqxWindow({ width: '62%', height: '65%',  maxHeight: '85%' ,maxWidth: '80%' , title: 'Fleet Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		   $('#fleetwindow').jqxWindow('close');
	 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
	    var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
	    $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate);
	
		 $('#client').dblclick(function(){
			 $('#clientwindow').jqxWindow('open');
				$('#clientwindow').jqxWindow('focus');
				 clientSearchContent('masterClientSearch.jsp', $('#clientwindow'));
			}); 
		 $('#fleetno').dblclick(function(){
			 $('#fleetwindow').jqxWindow('open');
				$('#fleetwindow').jqxWindow('focus');
				 fleetSearchContent('masterFleetSearch.jsp', $('#fleetwindow'));
			});
});

function getClient(event){
	 var x= event.keyCode;
   if(x==114){
   	  $('#clientwindow').jqxWindow('open');
 		$('#clientwindow').jqxWindow('focus');
 		 clientSearchContent('masterClientSearch.jsp', $('#clientwindow'));
   }
   else{
    }
}
function clientSearchContent(url) {
   //alert(url);
     $.get(url).done(function (data) {
//alert(data);
   $('#clientwindow').jqxWindow('setContent', data);

}); 
}

function getFleet(event){
	 var x= event.keyCode;
  if(x==114){
  	  $('#clientwindow').jqxWindow('open');
		$('#clientwindow').jqxWindow('focus');
		 fleetSearchContent('masterFleetSearch.jsp', $('#fleetwindow'));
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
	var branch=document.getElementById("cmbbranch").value;
	var fleet=document.getElementById("fleetno").value;
	var client=document.getElementById("hidclient").value;
	var fromdate=$('#fromdate').jqxDateTimeInput('val');
	var todate=$('#todate').jqxDateTimeInput('val');
    $("#overlay, #PleaseWait").show();
   	$("#solddiv").load("soldListGrid.jsp?fromdate="+fromdate+"&todate="+todate+"&branch="+branch+"&fleet="+fleet+"&client="+client+"&id=1");
   	
}
	
	

	function setValues(){

		 if($('#msg').val()!=""){
   		   $.messager.alert('Message',$('#msg').val());
   		  }
	
	}
	function funExportBtn(){

	}
	
		
	
	function funClearData(){
		$('input[type=text],[type=hidden]').val('');
		$('#fromdate').jqxDateTimeInput('setDate',new Date());
		$('#todate').jqxDateTimeInput('setDate',new Date());
		var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
	    var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
	    $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate); 
	
	}

	</script>
	
</head>
<body onload="setValues();getBranch();">
<form id="frmSoldList" method="post">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%">
<tr>
<td width="23%" align="center">
    <fieldset style="background: #ECF8E0;">
	<table width="100%">
	<jsp:include page="../../heading.jsp"></jsp:include>

 <tr>
   <td width="37%" align="right"><label class="branch">From Date</label></td><td width="63%"><div id="fromdate"></div></td></tr>
 <tr>
   <td align="right"><label class="branch">To Date</label></td>
   <td><div id="todate"></div></td>
 </tr>
 <tr>
   <td align="right"><label class="branch">Fleet</label></td>
   <td><input type="text" name="fleetno" id="fleetno" placeholder="Press F3 to Search" readonly style="height:18px;"></td>
 </tr>
 <tr>
   <td align="right"><label class="branch">Client</label></td>
   <td><input type="text" name="client" id="client" placeholder="Press F3 to Search" readonly style="height:18px;"></td>
   <input type="hidden" name="hidclient" id="hidclient">
 </tr>
 <tr >
	<td colspan="2" style="border-top:2px solid #DCDDDE;">
	<div style="text-align:center;">
	<input type="button" name="btnclear" id="btnclear" value="Clear" class="myButtons" onclick="funClearData();">
	</div>
    </td>
	</tr>
<tr ><td colspan="2"><!-- <textarea id="agmtdetails" name="agmtdetails" readonly style="resize:none;" rows="10" cols="35"></textarea> -->
	<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>

</td></tr>

<tr colspan="2"><td>&nbsp;</td></tr>
	
		
	</table>
	</fieldset>
</td>
<td width="77%">
	<table width="100%">
		<tr>
			 <td><div id="solddiv"><jsp:include page="soldListGrid.jsp"></jsp:include></div></td>
			  <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
			  <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
		
		</tr>
	</table>
</tr>
</table>
</div>
<div id="clientwindow">
<div></div>
</div>
<div id="fleetwindow">
<div></div>
</div>
</div>
</form>
</body>
</html>