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
input[type=text]{
	height:18px;
} 
select{
    height:15px;
}
</style>

<script type="text/javascript">

$(document).ready(function () {
		/* document.getElementById("branchlabel").style.display="none";
		document.getElementById("branchdiv").style.display="none"; */
		  /*  $("#btnExcel").click(function() {
				JSONToCSVCon(repexceldata, 'Replacement List', true);
				//$("#vehiclelist").jqxGrid('exportdata', 'xls', 'vehiclelist');
			}); */
		$('#btnprint').attr('disabled',true);
		$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200px;right:750px;'><img src='../../../../icons/31load.gif'/></div>");
	    $('#technicianwindow').jqxWindow({ width: '40%', height: '50%',  maxHeight: '50%' ,maxWidth: '40%' , title: 'Technician Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		$('#technicianwindow').jqxWindow('close');
		$('#baywindow').jqxWindow({ width: '40%', height: '50%',  maxHeight: '50%' ,maxWidth: '40%' , title: 'Bay Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		$('#baywindow').jqxWindow('close');
		$('#partssearchwindow').jqxWindow({ width: '50%', height: '50%',  maxHeight: '50%' ,maxWidth: '50%' , title: 'Product Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		$('#partssearchwindow').jqxWindow('close');
	 	$("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 	$("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 	$("#estimateddate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 	$("#estimatedtime").jqxDateTimeInput({  width:'55px',height : '15px', formatString : "HH:mm",showCalendarButton:false,value:new Date() });
	 	var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
	    var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
	    $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate);
	    getSrvcAdvisorConfig();
	    $('#technician').dblclick(function(){
		    $('#technicianwindow').jqxWindow('open');
			$('#technicianwindow').jqxWindow('focus');
		 	searchContent('technicianSearchGrid.jsp?id=1', 'technicianwindow');
		});
	    $('#bay').dblclick(function(){
		    $('#baywindow').jqxWindow('open');
			$('#baywindow').jqxWindow('focus');
		 	searchContent('baySearchGrid.jsp?id=1', 'baywindow');
		});
});

function getSrvcAdvisorConfig(){
	var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText.trim();
				$('#srvcadvisorconfig').val(items);
			}
		}
		x.open("GET", "getSrvcAdvisorConfig.jsp", true);
		x.send();
}
function getTechnician(event){
	var x= event.keyCode;
   	if(x==114){
   		$('#technicianwindow').jqxWindow('open');
		$('#technicianwindow').jqxWindow('focus');
	 	searchContent('technicianSearchGrid.jsp?id=1', 'technicianwindow');
   }
   else{
   }
}

function getBay(event){
	var x= event.keyCode;
   	if(x==114){
   		$('#baywindow').jqxWindow('open');
		$('#baywindow').jqxWindow('focus');
	 	searchContent('baySearchGrid.jsp?id=1', 'baywindow');
   }
   else{
   }
}

function searchContent(url,windowid) {
	$.get(url).done(function (data) {
		$('#'+windowid).jqxWindow('setContent', data);
	}); 
}

function funreload(event)
{
    $("#overlay, #PleaseWait").show();
    var fromdate=$('#fromdate').jqxDateTimeInput('val');
    var todate=$('#todate').jqxDateTimeInput('val');
    $('#gateinpassdiv').load('gateInPassGrid.jsp?fromdate='+fromdate+'&todate='+todate+'&id=1&srvcadvisorconfig='+$('#srvcadvisorconfig').val());
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
		$('#fromdate').jqxDateTimeInput('setDate',new Date());
		$('#todate').jqxDateTimeInput('setDate',new Date());
		var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
	    var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
	    $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate); 
	
	}
	
	function funNotify(){
		if(document.getElementById("processstatus").value=="2"){
			$.messager.alert('Warning','Already Saved');
			return false;
		}
		if(document.getElementById("gateinpassdocno").value==""){
			$.messager.alert('Warning','Please Select a valid Document');
			return false;
		}
		if(document.getElementById("technician").value==""){
			$.messager.alert('Warning','Please Select Technician');
			return false;
		}
		if(document.getElementById("bay").value==""){
			$.messager.alert('Warning','Please Select Bay');
			return false;
		}
		var partrows=$('#partsGrid').jqxGrid('getrows');
		for(var i=0;i<partrows.length;i++){
			var qty=parseInt($('#partsGrid').jqxGrid('getcellvalue',partrows[i],'qty'));
			var stock=parseInt($('#partsGrid').jqxGrid('getcellvalue',partrows[i],'balqty'));
			if(qty>stock){
				$.messager.alert('Warning','Please Make Sure Stock is Available');
				return false;
			}
		}
		var z=0;
		for(var i=0;i<partrows.length;i++){
			var partno=$('#partsGrid').jqxGrid('getcellvalue',i,'partno');
			if(partno!="undefined" && partno!="" && partno!=null){
				newTextBox = $(document.createElement("input"))
			    .attr("type", "dil")
			    .attr("id", "partsgrid"+z)
			    .attr("name", "partsgrid"+z)
			    .attr("hidden","true");
				z++;
				newTextBox.val($('#partsGrid').jqxGrid('getcellvalue',i,'partdocno')+"::"+$('#partsGrid').jqxGrid('getcellvalue',i,'qty'));
			
				newTextBox.appendTo('form');				
			}
		}
		var maintenancerows=$('#maintenanceGrid').jqxGrid('selectedrowindexes');
		for(var i=0;i<maintenancerows.length;i++){
			newTextBox = $(document.createElement("input"))
		    .attr("type", "dil")
		    .attr("id", "maintenancegrid"+i)
		    .attr("name", "maintenancegrid"+i)
		    .attr("hidden","true");
			
			newTextBox.val($('#maintenanceGrid').jqxGrid('getcellvalue',maintenancerows[i],'maintenancedocno'));
		
			newTextBox.appendTo('form');
			
		}
		$('#maintenancegridlength').val(maintenancerows.length);
		$('#partsgridlength').val(partrows.length-1);
		$('#mode').val('A');
		document.getElementById("frmServiceAdvisor").submit();		
	}
	
	
function funPrint(){
		  
		  var dtype='BWSA';
		  var url=document.URL;
	      var actionstatus=url.includes("saveServiceAdvisor");
	      var reurl='';
	      if(actionstatus==true){
	    	  reurl=url.split("saveServiceAdvisor");
	      }
	      else{
	    	  reurl=url.split("serviceAdvisor.jsp");
	      }
	        
	        var gateindoc=$('#gateinpassdocno').val();   
	        var regno=$('#regno').val();
	        var fleetno=$('#fleetno').val();
	        var fleetname=$('#fleetname').val();
	        var indatetime=$('#indatetime').val();
	        $('#btnprint').attr('disabled',true);
	        var win= window.open(reurl[0]+"printserviceadvisordetails?dtype="+dtype+"&gateindoc="+gateindoc+"&regno="+regno+"&fleetno="+fleetno+"&fleetname="+fleetname+"&indatetime="+indatetime,"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
		 // var win= window.open(reurl[0]+"../../../../com/dashboard/presale/venuereceiptionreg/ClsVenuReceiptionRegAction/printVenuReceiption?dtype="+dtype,"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
	        win.focus();
	  }
	
	</script>
	
</head>
<body onload="setValues();getBranch();">
<form id="frmServiceAdvisor" method="post" action="saveServiceAdvisor">
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
   <td align="right"><label class="branch">Technician</label></td>
   <td><input type="text" name="technician" id="technician" value='<s:property value="technician"/>' readonly onkeydown="getTechnician(event);" placeholder="Press F3 to Search" style="height:18px;"></td>
   <input type="hidden" name="hidtechnician" id="hidtechnician" value='<s:property value="hidtechnician"/>'>
 </tr>
 <tr>
   <td align="right"><label class="branch">Bay</label></td>
   <td><input type="text" name="bay" id="bay" value='<s:property value="bay"/>'  readonly onkeydown="getBay(event);" placeholder="Press F3 to Search"  style="height:18px;"></td>
   <input type="hidden" name="hidbay" id="hidbay" value='<s:property value="hidbay"/>'>
 </tr>
 <tr>
   <td align="right"><label class="branch">Estimated Date</label></td>
   <td><div id="estimateddate" name="estimateddate"></div></td>
 </tr>
 <tr>
   <td align="right"><label class="branch">Estimated Time</label></td>
   <td><div id="estimatedtime" name="estimatedtime"></div></td>
 </tr>
 
 <tr >
	<td colspan="2" style="border-top:2px solid #DCDDDE;">
	<div style="text-align:center;">
	<input type="button" name="btnclear" id="btnclear" value="Clear" class="myButtons" onclick="funClearData();">&nbsp;&nbsp;
	<input type="button" name="btnsave" id="btnsave" value="Save" class="myButtons" onclick="funNotify();">
	</div>
    </td>
	</tr>
<tr>
		<td colspan="2" align="center"><button class="myButton" type="button" id="btnprint" name="btnprint" onclick="funPrint();" > Print </button></td>
		</tr>

<tr ><td colspan="2"><!-- <textarea id="agmtdetails" name="agmtdetails" readonly style="resize:none;" rows="10" cols="35"></textarea> -->
	<br><br><br><br><br><br><br><br><br><br>

</td></tr>

	
		
	</table>
	</fieldset>
</td>
<td width="77%">
	<table width="100%" border="0">
  		<tr>
    		<td colspan="2"><div id="gateinpassdiv"><jsp:include page="gateInPassGrid.jsp"></jsp:include></div></td>
    		<td width="23%"><div id="complaintsdiv"><jsp:include page="complaintsGrid.jsp"></jsp:include></div></td>
  		</tr>
  		<tr>
    		<td width="50%"><div id="partsdiv"><jsp:include page="partsGrid.jsp"></jsp:include></div></td>
    		<td colspan="2"><div id="maintenancediv"><jsp:include page="maintenanceGrid.jsp"></jsp:include></div></td>
    	</tr>
	</table>
</td>
<input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
<input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
<input type="hidden" name="gateinpassdocno" id="gateinpassdocno" value='<s:property value="gateinpassdocno"/>'>	
<input type="hidden" name="processstatus" id="processstatus" value='<s:property value="processstatus"/>'>	
<input type="hidden" name="partsgridlength" id="partsgridlength" value='<s:property value="partsgridlength"/>'>	
<input type="hidden" name="maintenancegridlength" id="maintenancegridlength" value='<s:property value="maintenancegridlength"/>'>	

<input type="hidden" name="regno" id="regno" value='<s:property value="regno"/>'>
<input type="hidden" name="fleetno" id="fleetno" value='<s:property value="fleetno"/>'>
<input type="hidden" name="fleetname" id="fleetname" value='<s:property value="fleetname"/>'>
<input type="hidden" name="indatetime" id="indatetime" value='<s:property value="indatetime"/>'>
<input type="hidden" name="srvcadvisorconfig" id="srvcadvisorconfig" value='<s:property value="srvcadvisorconfig"/>'>
</tr>
</table>
</div>
<div id="technicianwindow">
	<div></div>
</div>
<div id="baywindow">
	<div></div>
</div>
<div id="partssearchwindow">
	<div></div>
</div>
</div>
</form>
</body>
</html>