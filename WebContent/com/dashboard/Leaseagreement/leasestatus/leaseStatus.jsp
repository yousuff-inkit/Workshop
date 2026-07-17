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
#btnvehreturn{
opacity:0;
}
</style>
<script type="text/javascript">

$(document).ready(function () {

	 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
	 $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200;right:600;'><img src='../../../../icons/31load.gif'/></div>");    
	 $('#lblreqdocno,#reqdocno,#btndrop,#lblreason,#reason').css('opacity','0');  
});

function funreload(event)
{
/* 	if($('#cmbtype').val()==""){
		$.messager.alert('warning','Please select a type');
		return false;
	}
	var docdateval=funDateInPeriod($('#periodupto').jqxDateTimeInput('getDate'));
	if(docdateval==0){
		$('#periodupto').jqxDateTimeInput('focus');
		return false;
	} */
	var branch=$('#cmbbranch').val();
	var fromdate=$('#fromdate').jqxDateTimeInput('val');
	var todate=$('#todate').jqxDateTimeInput('val');
	$('#countdiv').load('countGrid.jsp?branch='+branch+'&fromdate='+fromdate+'&todate='+todate+'&id=1');
	
	
}
	function funNotify(){
	var docdateval=funDateInPeriod($('#periodupto').jqxDateTimeInput('getDate'));
		if(docdateval==0){
			$('#periodupto').jqxDateTimeInput('focus');
			return false;
		}
	}
	function setValues(){

		 if($('#msg').val()!=""){
   		  $.messager.alert('Message','<center>'+$('#msg').val()+'</center>');
   		  }
		
	}
	function funExportBtn(){
		
	}
	
	function funDropReq(){
		if(document.getElementById("reqdocno").value==""){
			$.messager.alert('warning','Please Select a document');
			return false;
		}
		funDropAJAX();
	}
	
	function funDropAJAX(){
		
		var reqdocno=document.getElementById("reqdocno").value;
		var reason=document.getElementById("reason").value;
		var branch=document.getElementById("reqbranch").value;
		var reqsrno=document.getElementById("reqsrno").value;
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				if(items.trim()=="1"){
					$.messager.alert('warning','Declined Successfully');
					$('#leaseStatusGrid').jqxGrid('clear');
					$('#countdiv').load('countGrid.jsp');
				}
				else{
					$.messager.alert('warning','Not Declined');
				}
			} else {
			}
		}
		x.open("GET", "dropRequestAJAX.jsp?reqdocno="+reqdocno+"&reqsrno="+reqsrno+"&reason="+reason.replace(/ /g, "%20")+"&branch="+branch, true);
		x.send();
	}
</script>
</head>
<body onload="getBranch();setValues();">
<form id="frmDashboardVehicleReturn" action="saveDashboardVehicleReturn">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%">
	<tr>
		<td width="20%">
    		<fieldset style="background: #ECF8E0;">
				<table width="100%">
					<jsp:include page="../../heading.jsp"></jsp:include>
						<tr>
                        	<td width="34%" align="right"><label class="branch">From Date</label></td>
                            <td width="66%"><div id="fromdate"></div></td>
                        </tr>
		 				<tr>
                        	<td width="34%" align="right"><label class="branch">To Date</label></td>
         					<td width="66%"><div id="todate"></div></td>
                        </tr> 
        				<tr>
	  						<td align="right" colspan="2"><div id="countdiv"><jsp:include page="countGrid.jsp"></jsp:include></div></td>
	  					</tr>
	  					<tr>
	  						<td colspan="2">&nbsp;</td>
	  					</tr>
						<tr>
							<td align="right"><label class="branch" id="lblreqdocno"> Req Doc No</label></td>
                            <td><input type="text" name="reqdocno" id="reqdocno" readonly style="height:18px;"></td>
						</tr>
						<tr>
	  						<td align="right"><label class="branch" id="lblreason">Reason</label></td>
	  						<td><input type="text" name="reason" id="reason" value='<s:property value="reason"/>' style="height:18px;"></td>
	  					</tr>
                        <tr>
                          <td colspan="2"><center><input type="button" name="btndrop" id="btndrop" class="myButton" value="Decline" onclick="funDropReq();"></center></td>
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
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="leasestatusdiv"><jsp:include page="leaseStatusGrid.jsp"></jsp:include></div></td>
			 <input type="hidden" name="invgridlength" id="invgridlength"  value='<s:property value="invgridlength"/>'>
			  <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
			  <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
			  <input type="hidden" name="reqsrno" id="reqsrno" value='<s:property value="reqsrno"/>'>
			  <input type="hidden" name="reqbranch" id="reqbranch" value='<s:property value="reqbranch"/>'>
			  <div id="fromdate"></div>
			  <div id="todate"></div>
			  
		</tr>
	</table>
</tr>
</table>
</div>

</div>
</form>
</body>
</html>