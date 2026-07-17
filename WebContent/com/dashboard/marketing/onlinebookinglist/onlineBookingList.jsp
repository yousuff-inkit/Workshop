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
</style>
<script type="text/javascript">

$(document).ready(function () {

	 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#currentdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#bookfromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#booktodate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
	 $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200;right:600;'><img src='../../../../icons/31load.gif'/></div>");    
	 $("#currenttime").jqxDateTimeInput({ width: '40%', height: '15px', formatString: 'HH:mm', showCalendarButton: false});
	 var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
     $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	 
});

function funreload(event)
{
	var fromdate=$('#fromdate').jqxDateTimeInput('val');
	var todate=$('#todate').jqxDateTimeInput('val');
	$('#onlinebookingidv').load('onlineBookingListGrid.jsp?fromdate='+fromdate+'&todate='+todate+'&id=1');
}
	function funNotify(){
	}
	function setValues(){

		 if($('#msg').val()!=""){
   		  $.messager.alert('Message','<center>'+$('#msg').val()+'</center>');
   		  }
		
		 $('#fromdate').jqxDateTimeInput('setDate',new Date());
		 $('#todate').jqxDateTimeInput('setDate',new Date());
		 var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	}
	function funExportBtn(){
		
	}
	
	function funGenerateBooking(){
		if(document.getElementById("onlinebookdocno").value==""){
			$.messager.alert('warning','Please Select a valid document');
			return false;
		}
		document.getElementById("mode").value="A";
		document.getElementById("frmOnlineBookingList").submit();
	}
</script>
</head>
<body onload="getBranch();setValues();">
<form id="frmOnlineBookingList" action="saveOnlineBookingList">
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
                          <td colspan="2"><textarea id="details" name="details" style="resize:none;width:100%;" rows="5" ></textarea></td>
                          </tr>
                        <tr>
	  						<td align="right" colspan="2">&nbsp;</td>
	  					</tr>
                        
                        <tr>
                          <td colspan="2"><center><input type="button" name="btngenerate" id="btngenerate" class="myButton" value="Generate Booking" onclick="funGenerateBooking();" ></center></td>
                          </tr>
                        <tr>
                          <td colspan="2">&nbsp;</td>
                          </tr>
                        <tr>
                          <td colspan="2">&nbsp;</td>
                          </tr>
                       <tr>
                          <td colspan="2">&nbsp;</td>
                          </tr>
                          <tr>
                          <td colspan="2">&nbsp;</td>
                          </tr>
                          <tr>
                          <td colspan="2">&nbsp;</td>
                          </tr>
                            <tr>
                          <td colspan="2">&nbsp;</td>
                          </tr>  <tr>
                          <td colspan="2">&nbsp;</td>
                          </tr>  <tr>
                          <td colspan="2">&nbsp;</td>
                          </tr>
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="onlinebookingidv"><jsp:include page="onlineBookingListGrid.jsp"></jsp:include></div></td>
			  <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
			  <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
			  <input type="hidden" name="onlinebookdocno" id="onlinebookdocno" value='<s:property value="onlinebookdocno"/>'>
			  <div id="currentdate" name="currentdate" hidden="true"></div>
			  <div id="currenttime" name="currenttime" hidden="true"></div>
			  <div id="bookfromdate" name="bookfromdate" hidden="true"></div>
			  <div id="booktodate" name="booktodate" hidden="true"></div>
			  <input type="hidden" name="cldocno" id="cldocno" value='<s:property value="cldocno"/>'>
			  <input type="hidden" name="renttype" id="renttype" value='<s:property value="renttype"/>'>
			  <input type="hidden" name="tarifdocno" id="tarifdocno" value='<s:property value="tarifdocno"/>'>
			  <input type="hidden" name="fleetname" id="fleetname" value='<s:property value="fleetname"/>'>
			  <label name="lblclient" id="lblclient" hidden="true"><s:property value="lblclient"/></label>
			  <label name="lblhidclient" id="lblhidclient"  hidden="true"><s:property value="lblhidclient"/></label>
		</tr>
	</table>
</tr>
</table>
</div>

</div>
</form>
</body>
</html>