
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
	 $("#date").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#time").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"HH:mm",value:null,showCalendarButton:false});
	 $("#licenseexpiry").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
     var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
     $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate);
     $('#clientwindow').jqxWindow({ width: '60%', height: '50%',  maxHeight: '50%' ,maxWidth: '60%' , title: 'Client Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	 $('#clientwindow').jqxWindow('close');
	 $('#client').dblclick(function(){
	 	$('#clientwindow').jqxWindow('open');
		$('#clientwindow').jqxWindow('focus');
		clientSearchContent('clientMasterSearch.jsp', $('#clientwindow'));
	 });
});
function getClient(event){
	var x= event.keyCode;
	if(x==114){
		$('#clientwindow').jqxWindow('open');
 		$('#clientwindow').jqxWindow('focus');
 		clientSearchContent('clientMasterSearch.jsp', $('#clientwindow'));
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
	if($('#cmbbranch').val()=='a' || $('#cmbbranch').val()==''){
		$.messager.alert('warning','Please select a valid branch');
		return false;
	}
	if($('#hidclient').val()==''){
		$.messager.alert('warning','Please select client');
		return false;
	}
	var fromdate=$('#fromdate').jqxDateTimeInput('val');
	var todate=$('#todate').jqxDateTimeInput('val');
	var branch=$('#cmbbranch').val();
	var client=$('#hidclient').val();
	$("#countdiv").load("countGrid.jsp?fromdate="+fromdate+"&todate="+todate+"&branch="+branch+"&id=1&client="+client);
}
function setValues(){
	
	if($('#msg').val()!=""){
		$.messager.alert('Message','<center>'+$('#msg').val()+'</center>');
	}
}
function funExportBtn(){

/* 		 if(parseInt(window.parent.chkexportdata.value)=="1")
	  {
	  	JSONToCSVCon(invoicedata, 'Rental Invoice', true);
	  }
	 else
	  {
		 $("#rentalInvoiceGrid").jqxGrid('exportdata', 'xls', 'Rental Invoice');
	  }
*/
	
	
}
function funSave(){
	if($('#cmbbranch').val()=='a' || $('#cmbbranch').val()==''){
		$.messager.alert('warning','Please select a valid branch');
		return false;
	}
	if(document.getElementById("agmtno").value==""){
		$.messager.alert('warning','Please select a valid document');
		return false;
	}
	if($('#date').jqxDateTimeInput('getDate')==null){
		$.messager.alert('warning','Date is Mandatory');
		$('#date').jqxDateTimeInput('focus');
		return false;
	}
	if($('#time').jqxDateTimeInput('getDate')==null){
		$.messager.alert('warning','Time is Mandatory');
		$('#time').jqxDateTimeInput('focus');
		return false;
	}
	if($('#km').val()==''){
		$.messager.alert('warning','Km is Mandatory');
		document.getElementById("km").focus();
		return false;
	}
	if($('#cmbfuel').val()==''){
		$.messager.alert('warning','Fuel is Mandatory');
		document.getElementById("cmbfuel").focus();
		return false;
	}
	var desc=$('#desc').val();
	var rowindex=$('#detailrowindex').val();
	if(desc=="IN"){
		var movdate=new Date($('#detailGrid').jqxGrid('getcellvalue',rowindex,'movdate'));
		var movtime=new Date($('#detailGrid').jqxGrid('getcellvalue',rowindex,'movtime'));
		var movkm=$('#detailGrid').jqxGrid('getcellvalue',rowindex,'movkm');
		var date=new Date($('#date').jqxDateTimeInput('getDate'));
		var time=new Date($('#time').jqxDateTimeInput('getDate'));
		var km=$('#km').val();
		movdate.setHours(0,0,0,0);
		date.setHours(0,0,0,0);
		if(date<movdate){
			$.messager.alert('warning','Vehicle date cannot be less than last in date');
			return false;
		}
		else if(date-movdate==0){
			if(time.getHours()<movtime.getHours()){
				$.messager.alert('warning','Vehicle time cannot be less than last in time');
				return false;
			}
			else if(time.getHours()==movtime.getHours()){
				if(time.getMinutes()<movtime.getMinutes()){
					$.messager.alert('warning','Vehicle time cannot be less than last in time');
					return false;
				}
			}
		}
		if(km<movkm){
			$.messager.alert('warning','Vehicle Km cannot be less than last in Km');
			return false;
		}
		if($('#detailGrid').jqxGrid('getcellvalue',rowindex,'closedate')!=null && $('#detailGrid').jqxGrid('getcellvalue',rowindex,'closedate')!="undefined"){
			var closedate=new Date($('#detailGrid').jqxGrid('getcellvalue',rowindex,'closedate'));
			var closetime=new Date($('#detailGrid').jqxGrid('getcellvalue',rowindex,'closetime'));
			var closekm=$('#detailGrid').jqxGrid('getcellvalue',rowindex,'closekm');
			closedate.setHours(0,0,0,0);
			if(date<closedate){
				$.messager.alert('warning','Vehicle date cannot be less than last in date');
				return false;
			}
			else if(date-closedate==0){
				if(time.getHours()<closetime.getHours()){
					$.messager.alert('warning','Vehicle time cannot be less than in time');
					return false;
				}
				else if(time.getHours()==closetime.getHours()){
					if(time.getMinutes()<closetime.getMinutes()){
						$.messager.alert('warning','Vehicle time cannot be less than last in time');
						return false;
					}
				}
			}
			if(km<closekm){
				$.messager.alert('warning','Vehicle Km cannot be less than last in Km');
				return false;
			}
		}
	}
	else if(desc=="OUT"){
		var opendate=new Date($('#detailGrid').jqxGrid('getcellvalue',rowindex,'opendate'));
		var opentime=new Date($('#detailGrid').jqxGrid('getcellvalue',rowindex,'opentime'));
		var openkm=$('#detailGrid').jqxGrid('getcellvalue',rowindex,'openkm');
		var date=new Date($('#date').jqxDateTimeInput('getDate'));
		var time=new Date($('#time').jqxDateTimeInput('getDate'));
		var km=$('#km').val();
		opendate.setHours(0,0,0,0);
		date.setHours(0,0,0,0);
		if(date<opendate){
			$.messager.alert('warning','Vehicle Date cannot be less than last in Date');
			return false;
		}
		else if(date-opendate==0){
			if(time.getHours()<opentime.getHours()){
				$.messager.alert('warning','Vehicle time cannot be less than last in time');
				return false;
			}
			else if(time.getHours()==opentime.getHours()){
				if(time.getMinutes()<opentime.getMinutes()){
					$.messager.alert('warning','Vehicle time cannot be less than last in time');
					return false;
				}
			}
		}
		if(km<openkm){
			$.messager.alert('warning','Vehicle Km cannot be less than last in Km');
			return false;
		}
	}
	
	var agmtno=$('#agmtno').val();
	var date=$('#date').jqxDateTimeInput('val');
	var timetemp=new Date($('#time').jqxDateTimeInput('getDate'));
	var time=timetemp.getHours()+":"+(timetemp.getMinutes()<10?"0"+timetemp.getMinutes():timetemp.getMinutes());
	var km=$('#km').val();
	var fuel=$('#cmbfuel').val();
	var client=$('#hidclient').val();
	var driver=$('#driver').val();
	var mobile=$('#mobile').val();
	var licenseno=$('#licenseno').val();
	var licenseexp=$('#licenseexpiry').jqxDateTimeInput('val');
	var idno=$('#idno').val();
	
	var fleetno=$('#fleetno').val();
	var branch=$('#cmbbranch').val();
	var clientmovdocno=$('#clientmovdocno').val();
	saveDataAJAX(agmtno,date,time,km,fuel,client,driver,mobile,licenseno,licenseexp,idno,desc,fleetno,branch,clientmovdocno);
	
}

function saveDataAJAX(agmtno,date,time,km,fuel,client,driver,mobile,licenseno,licenseexp,idno,desc,fleetno,branch,clientmovdocno){
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText.trim();
			if(items=="1"){
				$.messager.alert('warning','Successfully Saved');
				funClearData();
			}
			else{
				$.messager.alert('warning','Not Saved');
			}
		} else {
		}
	}
	x.open("GET", "saveDataAJAX.jsp?agmtno="+agmtno+"&date="+date+"&time="+time+"&km="+km+"&fuel="+fuel+"&client="+client+"&driver="+driver.replace(/ /g, "%20")+"&mobile="+mobile+"&licenseno="+licenseno+"&licenseexp="+licenseexp+"&idno="+idno+"&desc="+desc+"&fleetno="+fleetno+"&branch="+branch+"&clientmovdocno="+clientmovdocno, true);
	x.send();
}

function funClearData(){
	$('#driver,#mobile,#licenseno,#idno,#km,#cmbfuel,#client,#hidclient').val('');
	$('#licenseexpiry,#date,#time').jqxDateTimeInput('setDate',null);
	$('#countGrid').jqxGrid('clear');
	$('#detailGrid').jqxGrid('clear');
	$('#fromdate').jqxDateTimeInput('setDate', new Date());
	$('#fromdate').jqxDateTimeInput('setDate', new Date());
	var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
    var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
    $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate);
}
</script>
</head>
<body onload="getBranch();setValues();">
<form id="frmClientVehicleMovement" action="saveclientVehicleMovement" method="post">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%">
<tr>
<td width="20%">
    <fieldset style="background: #ECF8E0;">
	<table width="100%">
	<jsp:include page="../../heading.jsp"></jsp:include>

 <tr><td width="26%" align="right"><label class="branch">From Date</label></td><td width="74%"><div id="fromdate" name="fromdate"></div></td></tr>
 <tr><td align="right"><label class="branch">To Date</label></td><td ><div id="todate" name="todate"></div></td></tr>
 <tr>
   <td align="right"><label class="branch">Client</label></td>
   <td><input type="text" name="client" id="client" style="height:18px;" readonly placeholder="Press F3 to Search"></td>
   <input type="hidden" name="hidclient" id="hidclient">
 </tr>
 <tr><td colspan="2"><div id="countdiv" ><jsp:include page="countGrid.jsp"></jsp:include></div></td></tr>
  <tr>
   <td align="right"><label class="branch">Driver</label></td>
   <td><input type="text" name="driver" id="driver" style="height:18px;"></td>
 </tr>
 <tr>
   <td align="right"><label class="branch">Mobile</label></td>
   <td><input type="text" name="mobile" id="mobile"  style="height:18px;"></td>
 </tr>
 <tr>
   <td align="right"><label class="branch">License No</label></td>
   <td><input type="text" name="licenseno" id="licenseno" style="height:18px;"></td>
 </tr>
 <tr>
   <td align="right"><label class="branch">License Exp</label></td>
   <td><div id="licenseexpiry" name="licenseexpiry"></div></td>
 </tr>
 <tr>
   <td align="right"><label class="branch">ID No</label></td>
   <td><input type="text" name="idno" id="idno" style="height:18px;"></td>
 </tr>
 <tr>
   <td align="right"><label class="branch">Date</label></td>
   <td><div id="date" name="date"></div></td>
 </tr>
 <tr>
   <td align="right"><label class="branch">time</label></td>
   <td><div id="time" name="time"></div></td>
 </tr>
  <tr>
   <td align="right"><label class="branch">Km</label></td>
   <td><input type="text" name="km" id="km" style="height:18px;"></td>
 </tr>
  <tr>
   <td align="right"><label class="branch">Fuel</label></td>
   <td><select name="cmbfuel" id="cmbfuel" style="width:75%;">
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
	<td colspan="2">&nbsp;</td>
	</tr> 
	<tr>
	<td colspan="2"><center><input type="button" name="btnsave" id="btnsave" class="myButton" value="Save" onclick="funSave();"></center></td>
	</tr>
	<tr>
	<td colspan="2"></td>
	</tr>	
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td> <!-- <div id="imgdiv" style="position:absolute; z-index: 1;top:200;right:600;">
<img id="imgloading" alt="" src="../../../../icons/29load.gif"/></div> --> <div id="detaildiv"><jsp:include page="detailGrid.jsp"></jsp:include></div> </td>
			 <input type="hidden" name="gridlength" id="gridlength" >
			  <input type="hidden" name="invgridlength" id="invgridlength" >
			  <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
			  <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
			  <input type="hidden" name="agmtno" id="agmtno" value='<s:property value="agmtno"/>'>
			  <input type="hidden" name="fleetno" id="fleetno" value='<s:property value="fleetno"/>'>
			  
		</tr>
	</table>
</tr>
</table>
</div>
<div id="clientwindow">
<div></div>
</div>
</div>
</form>
</body>
</html>