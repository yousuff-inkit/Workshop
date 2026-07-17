<%@ taglib prefix="s" uri="/struts-tags" %>
 
<!DOCTYPE html>
<html>
<head>
<s:head/>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>GatewayERP(i)</title>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
 <jsp:include page="../../../../includes.jsp"></jsp:include>
<!-- <link rel="stylesheet" type="text/css" href="../css/body.css"> -->
<script type="text/javascript">
$(document).ready(function() {
	$("#fleetstatusdate").jqxDateTimeInput({
		width : '125px',
		height : '15px',
		formatString : "dd.MM.yyyy"
	});
	$("#hiddate").jqxDateTimeInput({
		width : '125px',
		height : '15px',
		formatString : "dd.MM.yyyy"
	});
	getStatus();
	$('#btnEdit').attr('disabled',true);
	 $('#fleetwindow').jqxWindow({ width: '60%', height: '58%',  maxHeight: '58%' ,maxWidth: '50%' , title: 'Fleet Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   $('#fleetwindow').jqxWindow('close');
	$("#fleetstatustime").jqxDateTimeInput({ width: '50%', height: '15px', formatString: 'HH:mm', showCalendarButton: false,value:new Date() });
	$("#hidtime").jqxDateTimeInput({ width: '50%', height: '15px', formatString: 'HH:mm', showCalendarButton: false,value:new Date() });
	  $('#fleetno').dblclick(function(){
		  
		  if(document.getElementById("mode").value=="view"){
			  return false;
		  }
		  datereset();
		    $('#fleetwindow').jqxWindow('open');
		$('#fleetwindow').jqxWindow('focus');
		fleetnoSearchContent('masterFleetSearch.jsp?', $('#fleetwindow'));
		});
});
function fleetnoSearchContent(url) {
    //alert(url);
      $.get(url).done(function (data) {
//alert(data);
    $('#fleetwindow').jqxWindow('setContent', data);

}); 
}
function getFleet(event){
	   	//alert("Here");
     var x= event.keyCode;
     if(x==114){
    	 if(document.getElementById("mode").value=="view"){
			  return false;
		  }
    	 datereset();
   	   $('#fleetwindow').jqxWindow('open');
  		$('#fleetwindow').jqxWindow('focus');
  		 fleetnoSearchContent('masterFleetSearch.jsp?', $('#fleetwindow'));
     }
     else{
      }
     }
function funReset(){
	//$('#frmFleetStatusChange')[0].reset(); 
}
function datereset(){
	$('#fleetstatusdate').jqxDateTimeInput('setDate', new Date());
	   $('#fleetstatustime').jqxDateTimeInput('setDate', new Date());
	   
}
function funFocus(){
	document.getElementById("fleetno").focus();
}
function funReadOnly(){
	$('#frmFleetStatusChange input').attr('readonly', true );
	 $('#fleetstatusdate').jqxDateTimeInput({ disabled: true}); 
	 $('#fleetstatustime').jqxDateTimeInput({ disabled: true}); 
	 $('#frmFleetStatusChange select').attr('disabled', true );
	 $('#frmFleetStatusChange textarea').attr('readonly', true );
}
function funRemoveReadOnly(){
	$('#frmFleetStatusChange input').attr('readonly', false );
	 $('#fleetstatusdate').jqxDateTimeInput({ disabled: false}); 
	 $('#fleetstatustime').jqxDateTimeInput({ disabled: false}); 
	 $('#frmFleetStatusChange select').attr('disabled', false );
	 $('#frmFleetStatusChange textarea').attr('readonly', false );
	$('#docno').attr('readonly', true);
	$('#fleetno').attr('readonly', true);
	$('#fleetname').attr('readonly', true);
	$('#currentstatus').attr('readonly', true);
	if(document.getElementById("mode").value=="A"){
		datereset();
	}

}
function getStatus() {
	//alert("Here");
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText;
			items = items.split('***');
			//alert(items);
			var status = items[0].split(",");
			var statusid = items[1].split(",");
			var optionsstatus = '<option value="">--Select--</option>';
			for (var i = 0; i < status.length; i++) {
				optionsstatus += '<option value="' + statusid[i] + '">'
						+ status[i] + '</option>';
			}
			$("select#cmbchangestatus").html(optionsstatus);
			if ($('#hidcmbchangestatus').val() != null) {
				$('#cmbchangestatus').val($('#hidcmbchangestatus').val());
			}
		} else {
		}
	}
	x.open("GET", "getStatus.jsp", true);
	x.send();
}
function setValues()
{
	funSetlabel();

	if($('#hidfleetstatustime').val()){
		$("#fleetstatustime").jqxDateTimeInput('val', $('#hidfleetstatustime').val());
	}
	 if($('#msg').val()!=""){
		   $.messager.alert('Message',$('#msg').val());
		  }
	 if ($('#hidcmbchangestatus').val() != null) {
			$('#cmbchangestatus').val($('#hidcmbchangestatus').val());
		}
	

	}
	function funNotify(){
		var temp=document.getElementById("cmbchangestatus").value;
		var statusdate= $('#fleetstatusdate').jqxDateTimeInput('getDate');
		var statustime= $('#fleetstatustime').jqxDateTimeInput('getDate');
		var hiddate=$('#hiddate').jqxDateTimeInput('getDate');
		var hidtime=$('#hidtime').jqxDateTimeInput('getDate');
		statusdate.setHours(0,0,0,0);
		hiddate.setHours(0,0,0,0);
		if(document.getElementById("cmbchangestatus").value==""){
			document.getElementById("errormsg").innerText="Select a Status";
			return 0;
		}
		if(document.getElementById("hidcurrentstatus").value==temp){
			document.getElementById("errormsg").innerText="Cannot Select Same Status";
			return 0;
		}
		//checking status change date with last in date
		if(statusdate<hiddate){
			 document.getElementById("errormsg").innerText="";
			 document.getElementById("errormsg").innerText="Change Date Cannot be less than Last In Date";
			 return 0;
		}
		if(statusdate-hiddate==0){
			if(statustime.getHours()<hidtime.getHours()){
				document.getElementById("errormsg").innerText="";
				document.getElementById("errormsg").innerText="Change Time Cannot be less than Last In Time";
				 return 0;	
			}
			if(statustime.getHours()==hidtime.getHours()){
				if(statustime.getMinutes()<hidtime.getMinutes()){
					document.getElementById("errormsg").innerText="";
					document.getElementById("errormsg").innerText="Change Time Cannot be less than Last In Time";
					 return 0;		
				}
			}
		}
		document.getElementById("errormsg").innerText="";
		return 1;
	}
	function funSearchLoad(){
		 changeContent('fleetStatusSearch.jsp', $('#window')); 
	}
</script>
</head>
<body onload="funReadOnly();setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmFleetStatusChange" action="saveActionFleetStatusChange" autocomplete="off">
<%-- <script>
			window.parent.formName.value="Vehicle Status Change";
			window.parent.formCode.value="VSC";
	</script> --%>
	<jsp:include page="../../../../header.jsp" />
	<br/> 
<fieldset><legend>Fleet Status Change Info</legend>
<table width="100%">
  <tr>
    <td width="8%" align="right">Date</td>
    <td width="8%" align="left"><div id="fleetstatusdate" name="fleetstatusdate" value='<s:property value="fleetstatusdate"/>'></div></td>
    <input type="hidden" name="hidcmbsalesman" id="hidcmbsalesman" value='<s:property value="hidcmbsalesman"/>'>
    <td width="9%" align="right">Time</td>
    <td width="9%" align="left"><div id="fleetstatustime" name="fleetstatustime" value='<s:property value="fleetstatustime"/>'></div></td>
    <input type="hidden" name="hidfleetstatusdate" id="hidfleetstatusdate" value='<s:property value="hidfleetstatusdate"/>'>
    <td width="11%" align="right">&nbsp;</td>
    <td width="5%" align="right">Doc No</td>
    <input type="hidden" name="hidfleetstatustime" id="hidfleetstatustime" value='<s:property value="hidfleetstatustime"/>'>
    <td width="8%" align="left"><input type="text" name="docno" id="docno" value='<s:property value="docno"/>' readonly></td>
    <td colspan="3" align="left">&nbsp;</td>
  </tr>
  
  <tr>
    <td align="right">Fleet</td>
    <td align="left"><input type="text" name="fleetno" id="fleetno" value='<s:property value="fleetno"/>' readonly onkeydown="getFleet(event);"> </td>
    <td colspan="5" align="left"><input type="text" name="fleetname" id="fleetname" value='<s:property value="fleetname"/>' style="width:99.5%;" readonly></td>
    <td width="34%" align="left">&nbsp;</td>
    <td width="8%" colspan="2" align="left">&nbsp;</td>
  </tr>
  <tr>
    <td align="right">Current Status</td>
    <td align="left"><input type="text" name="currentstatus" id="currentstatus" value='<s:property value="currentstatus"/>' readonly></td>
    <td align="right">Change to Status</td>
    <td align="left"><select name="cmbchangestatus" id="cmbchangestatus" ><option value="">--Select--</option></select></td>
    <input type="hidden" name="hidcmbchangestatus" id="hidcmbchangestatus" value='<s:property value="hidcmbchangestatus"/>' readonly>
    <td align="left">&nbsp;</td>
    <td align="left">&nbsp;</td>
    <td align="left">&nbsp;</td>
    <td align="left">&nbsp;</td>
    <td colspan="2" align="left">&nbsp;</td>
  </tr>
  <tr>
    <td align="right">Reason</td>
    <td colspan="6" align="left"> 
      <textarea id="reason" name="reason" style="resize:none;width:99.5%;" ><s:property value="reason"/>
      </textarea>
    </td>
    <input type="hidden" name="hidcurrentstatus" id="hidcurrentstatus" value='<s:property value="hidcurrentstatus"/>'>
    <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
     <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
      <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'>
      <div id="hiddate" name="hiddate" hidden="true"></div>
      <div id="hidtime" name="hidtime" hidden="true"></div>
    <td align="left">&nbsp;</td>
    <td colspan="2" align="left">&nbsp;</td>
  </tr>
</table>
</fieldset>
</form>
<div id="fleetwindow">
   <div ></div>
</div>
</div>
</body>
</html>