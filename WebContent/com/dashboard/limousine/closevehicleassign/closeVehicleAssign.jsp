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
<style>
input[type="text"] {
    
}
body{

}
</style>

<script type="text/javascript">

$(document).ready(function () {
	 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
	 $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200;right:600;'><img src='../../../../icons/31load.gif'/></div>");    
	 $("#date").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null});
	 $("#time").jqxDateTimeInput({ width: '50px', height: '17px', formatString: 'HH:mm', showCalendarButton: false ,value:null});
	 $("#outdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null});
	 $("#outtime").jqxDateTimeInput({ width: '50px', height: '17px', formatString: 'HH:mm', showCalendarButton: false ,value:null});
	 funreadonly("1");
});

function funreload(event)
{
	
	if(document.getElementById("cmbbranch").value=="" || document.getElementById("cmbbranch").value=="a"){
		$.messager.alert('warning','Please select a specific Branch');
		return false;
	}
	$('#closevehassigndiv').load('closeVehAssignGrid.jsp?branch='+$('#cmbbranch').val()+'&id=1');
}

function setValues(){

	 if($('#msg').val()!=""){
		 $.messager.alert('Message','<center>'+$('#msg').val()+'</center>');
	}
	 
}
function funreadonly(value){
if(value=="1"){
	$('#fleetno,#cmbfuel,#fleetdetails,#km').attr('disabled',true);
	$('#date').jqxDateTimeInput({disabled:true});
	$('#time').jqxDateTimeInput({disabled:true});
}
else if(value=="2"){
	$('#fleetno,#cmbfuel,#fleetdetails,#km').attr('disabled',false);
	$('#date').jqxDateTimeInput({disabled:false});
	$('#time').jqxDateTimeInput({disabled:false});
}
	
}



function funUpdate(){
	if(document.getElementById("cmbbranch").value=="" || document.getElementById("cmbbranch").value=="a"){
		$.messager.alert('warning','Please select a specific Branch');
		return false;
	}
	if(document.getElementById("fleetno").value==""){
		$.messager.alert('warning','Please select a valid fleet');
		return false;
	}
	if($('#date').jqxDateTimeInput('getDate')==null){
		$.messager.alert('warning','Date is mandatory');
		return false;
	}
	if($('#time').jqxDateTimeInput('getDate')==null){
		$.messager.alert('warning','Time is mandatory');
		return false;
	}
	if($('#km').val()==""){
		$.messager.alert('warning','Km is mandatory');
		return false;
	}
	if($('#cmbfuel').val()==""){
		$.messager.alert('warning','Fuel is madatory');
		return false;
	}
	
	var outdate=new Date($('#outdate').jqxDateTimeInput('getDate'));
	outdate.setHours(0,0,0,0);
	var outtime=new Date($('#outtime').jqxDateTimeInput('getDate'));
	var outkm=document.getElementById("outkm").value;
	var closedate=new Date($('#date').jqxDateTimeInput('getDate'));
	closedate.setHours(0,0,0,0);
	var closetime=new Date($('#time').jqxDateTimeInput('getDate'));
	var closekm=document.getElementById("km").value;
	
	if(closedate<outdate){
		$.messager.alert('warning','Close date cannot be less than out date');
		return false;
	}
	else if(closedate-outdate==0){
		if(closetime.getHours()<outtime.getHours()){
			$.messager.alert('warning','Close time cannot be less than out time');
			return false;
		}
		else if(closetime.getHours()==outtime.getHours()){
			if(closetime.getMinutes()<outtime.getMinutes()){
				$.messager.alert('warning','Close time cannot be less than out time');
				return false;
			}
		}
	}
	
	if(parseFloat(closekm)<parseFloat(outkm)){
		$.messager.alert('warning','Close km cannot be less than out km');
		return false;
	}
	
	funCloseAssign();
}

function funCloseAssign(){
	var date=$('#date').jqxDateTimeInput('val');
	var time=$('#time').jqxDateTimeInput('val');
	var km=$('#km').val();
	var fuel=$('#cmbfuel').val();
	var assignno=$('#assignno').val();
	var movdocno=$('#movdocno').val();
	var branch=document.getElementById("cmbbranch").value;
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText.trim();
			if(items=="1"){
				$.messager.alert('message','Successfully Updated');
				funreload("1");
				funClearData();
			}
			else{
				$.messager.alert('message','Not Updated');
			}
		} else {
		}
	}
	x.open("GET", "closeVehicle.jsp?date="+date+"&time="+time+"&km="+km+"&fuel="+fuel+"&assignno="+assignno+"&movdocno="+movdocno+"&branch="+branch, true);
	x.send();
	
}

function funClearData(){
	$('input[type="text"]').val('');
	document.getElementById("fleetdetails").innerText="";
	$('#cmbfuel').val('');
	$('#date').jqxDateTimeInput('setDate',null);
	$('#time').jqxDateTimeInput('setDate',null);
	$('#outdate').jqxDateTimeInput('setDate',null);
	$('#outtime').jqxDateTimeInput('setDate',null);
	
}
function funExportBtn(){
	JSONToCSVCon(CloseVehexcel, 'Closevehicle Assign', true);
	 }

</script>
</head>
<body onload="getBranch();setValues();" style="font: 10px Tahoma;">
<form id="frmCloseVehicleAssign" method="post">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%">
<tr>
<td width="20%" rowspan="2">
    <fieldset style="background: #ECF8E0;">
	<table width="100%">
	<jsp:include page="../../heading.jsp"></jsp:include>

 <tr>
 <td width="26%" align="right"><label class="branch">Fleet No</label></td>
 <td width="74%" colspan="2" ><input type="text" name="fleetno" id="fleetno" placeholder="Press F3 to Search" style="height:18px !important;"></td>
 </tr>
 <tr>
   <td align="right"><label class="branch">Fleet Details</label></td>
   <td><textarea name="fleetdetails" id="fleetdetails" style="width:91%;height:85px;font:10px Tahoma;"></textarea></td>
 </tr>
 <tr>
   <td align="right"><label class="branch">Date</label></td>
   <td><div id="date"></div></td>
 </tr>
 <tr>
   <td align="right"><label class="branch">Time</label></td>
   <td><div id="time"></div></td>
 </tr>
 <tr>
   <td align="right"><label class="branch">KM</label></td>
   <td><input type="text" name="km" id="km" style="height:18px !important;"></td>
 </tr>
 <tr>
   <td align="right"><label class="branch">Fuel</label></td>
   <td><select name="cmbfuel" id="cmbfuel" style="width:76%;">
   <option value="">--Select--</option>
   <option value=0.000>Level 0/8</option>
   <option value=0.125>Level 1/8</option>
   <option value=0.250>Level 2/8</option>
   <option value=0.375>Level 3/8</option>
   <option value=0.500>Level 4/8</option>
   <option value=0.625>Level 5/8</option>
   <option value=0.750>Level 6/8</option>
   <option value=0.875>Level 7/8</option>
   <option value=1.000>Level 8/8</option>
   </select></td>
 </tr>

 <tr>
   <td colspan="2" align="center"><button type="button" name="btnupdate" id="btnupdate" class="myButton" onclick="funUpdate();">Update</button></td>
   </tr>
 <tr>
   <td align="right">&nbsp;</td>
   <td>&nbsp;</td>
 </tr>
 <tr>
   <td colspan="2" align="center">&nbsp;</td>
   </tr>
    <tr>
   <td colspan="2" align="center">&nbsp;</td>
   </tr>
   <tr>
   <td colspan="2" align="center"><br><br><br><br><br></td>
   </tr>
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td rowspan="2"><div id="closevehassigndiv"><jsp:include page="closeVehAssignGrid.jsp"></jsp:include></div></td>
		</tr>
	</table>
</tr>
</table>
</div>
<input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
<input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
<input type="hidden" name="assignno" id="assignno" value='<s:property value="assignno"/>'>
<div id="outdate" hidden="true"></div>
<div id="outtime" hidden="true"></div>
<input type="hidden" name="outkm" id="outkm" value='<s:property value="outkm"/>'>
<input type="hidden" name="outfuel" id="outfuel" value='<s:property value="outfuel"/>'>
<input type="hidden" name="movdocno" id="movdocno" value='<s:property value="movdocno"/>'>
</div>
</form>
</body>
</html>