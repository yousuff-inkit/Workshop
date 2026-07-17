
  <jsp:include page="../../../../includes.jsp"></jsp:include>  
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
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 

<script type="text/javascript">

$(document).ready(function () {
	 $("#fleetdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#curdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value: new Date()});
	 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value: new Date()});
	 $("#fleettime").jqxDateTimeInput({ width: '25%', height: '17px', formatString: 'HH:mm', showCalendarButton: false ,value: new Date()});
	 $("#hiddate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value: new Date()});
	 $("#hidtime").jqxDateTimeInput({ width: '20%', height: '17px', formatString: 'HH:mm', showCalendarButton: false ,value: new Date()});
	 /*  $('#vehiclewindow').jqxWindow({ autoOpen: false,width: '80%', height: '70%',  maxHeight: '70%' ,maxWidth: '80%' , title: 'Vehicle Details' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27, showCloseButton: true,closeButtonAction:'hide'}); */
	 $('#movementwindow').jqxWindow({ autoOpen: false,width: '80%', height: '75%',  maxHeight: '75%' ,maxWidth: '80%' , title: 'Movement Details' ,position: { x:250, y: 60 }, keyboardCloseKey: 27, showCloseButton: true,closeButtonAction:'hide'});
	 document.getElementById("btnUpdate").disabled=true;
	document.getElementById("btnattach").disabled=true;
	document.getElementById("btnmove").disabled=true;
	 $('#clientAttachWindow').jqxWindow({autoOpen: false,width: '70%', height: '58%',  maxHeight: '70%' ,maxWidth: '70%' , title: 'Attach',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true});
	   $('#clientAttachWindow').jqxWindow('close');
	 
});

function getStatus() {
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText;
			items = items.split('***');
			var status = items[0].split(",");
			var statusid = items[1].split(",");
			var optionsstatus = '<option value="">--Select--</option>';
			for (var i = 0; i < status.length; i++) {
				optionsstatus += '<option value="' + statusid[i] + '">'
						+ status[i] + '</option>';
			}
			$("select#cmbstatus").html(optionsstatus);
			if ($('#hidcmbstatus').val() != null) {
				$('#cmbstatus').val($('#hidcmbstatus').val());
			}
		} else {
		}
	}
	x.open("GET", "../../../operations/saleofvehicle/vehiclestatuschange/getStatus.jsp", true);
	x.send();
}
function updateStatus(){
	var testdate= $('#fleetdate').jqxDateTimeInput('getDate');
	var testtime= $('#fleettime').jqxDateTimeInput('getDate');
	var testtime2=$('#fleettime').jqxDateTimeInput('val');
	if(document.getElementById("fleetno").value==""){
		 $.messager.alert('Message',"Please Select Fleet");
		 return false;
	}
	if(document.getElementById("cmbstatus").value==""){
		 $.messager.alert('Message',"Please Select Status");
		 return false;
	}
	var hiddate=$('#hiddate').jqxDateTimeInput('getDate');
	var hidtime=$('#hidtime').jqxDateTimeInput('getDate');
	//alert(testtime.getHours());
	hiddate.setHours(0,0,0,0);
	testdate.setHours(0,0,0,0);
	if(testdate<hiddate){
		 $.messager.alert('Message',"Change Date Cannot be less than Last In Date");
		 return false;
	}
	if(testdate-hiddate==0){
		if(testtime.getHours()<hidtime.getHours()){
			$.messager.alert('Message',"Change Time Cannot be less than Last In Time");
			 return false;	
		}
		if(testtime.getHours()==hidtime.getHours()){
			if(testtime.getMinutes()<hidtime.getMinutes()){
				$.messager.alert('Message',"Change Time Cannot be less than Last In Time");
				 return false;		
			}
		}
	}
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText;
			if(items.trim()=="1"){
					   $.messager.alert('Message',"Successfully Saved");
						
					   funreload(this);
					  
			}
				else{
					$.messager.alert('Message',"Not Saved");
					funreload(this);
						
				}

		} else {
		}
	}
	x.open("GET", "updateStatus.jsp?fleetdate="+testdate+"&fleettime="+testtime2+"&fleetno="+document.getElementById("fleetno").value+"&status="+document.getElementById("cmbstatus").value+"&branch="+document.getElementById("hidbranch").value, true);
	x.send();
}
function funreload(event)
{
	 document.getElementById("btnUpdate").disabled=true;
		document.getElementById("btnattach").disabled=true;
		document.getElementById("btnmove").disabled=true;
 	$('input[type=text],[type=hidden]').val('');
	 //  $('select').find('option').prop("selected", false);
	   $('#fleetdate').jqxDateTimeInput('setDate', new Date());
	   $('#fleettime').jqxDateTimeInput('setDate', new Date());
  	var barchval = document.getElementById("cmbbranch").value;
     
	  $("#fleetdiv").load("unRentableGrid.jsp?branchval="+barchval);
	
	}
	
	
function funExportBtn()
{
	
	 


  if(parseInt(window.parent.chkexportdata.value)=="1")
	    {
	    JSONToCSVCon(ssss, 'Unrentable', true);
	    }
	   else
	    {
		   $("#unRentableGrid").jqxGrid('exportdata', 'xls', 'Unrentable');
	    }
	   
	   


	
	}
function getVehicleMov(){
	if(document.getElementById("fleetno").value==""){
		 $.messager.alert('Message',"Please Select Fleet");
		 return false;
	}
	 var fleetno=document.getElementById("fleetno").value;
	 var vals=0;
	 var ready="ready";
	 $('#movementwindow').jqxWindow('setContent', '');
		$('#movementwindow').jqxWindow('open');	 
		movementSearchContent("<%=contextPath%>/com/dashboard/vehicle/vehiclemovement/vehiclemovementGrid.jsp?fleetno="+fleetno+"&fromdate="+vals+"&todate="+vals+"&ready="+ready);
	}
<%-- function getVehicle(){
	if(document.getElementById("fleetno").value==""){
		 $.messager.alert('Message',"Please Select Fleet");
		 return false;
	}
	$('#vehiclewindow').jqxWindow('setContent', '');
	$('#vehiclewindow').jqxWindow('open');	
	 vehicleSearchContent("<%=contextPath%>/com/controlcentre/masters/vehicle/saveVehicle1.action?mode=view&fleetno="+document.getElementById("fleetno").value);
}
function vehicleSearchContent(url) {
	//$('#vehiclewindow').jqxWindow('open');	
	$('#vehiclewindow').jqxWindow('focus');	
	$.get(url).done(function (data) {
$('#vehiclewindow').jqxWindow('setContent', data);
}); 
} --%>
function movementSearchContent(url) {
	$('#movementwindow').jqxWindow('focus');	
	$.get(url).done(function (data) {
$('#movementwindow').jqxWindow('setContent', data);
}); 
}
function getAttach(){
	if(document.getElementById("fleetno").value==""){
		 $.messager.alert('Message',"Please Select Fleet");
		 return false;
	}
	changeClientAttachContent("<%=contextPath%>/com/common/attachGrid.jsp?formCode=VEH&docno="+document.getElementById("docno").value);  

}
function changeClientAttachContent(url) {
	   $.get(url).done(function (data) {
	        $('#clientAttachWindow').jqxWindow('open');
	     $('#clientAttachWindow').jqxWindow('setContent',data);
	     $('#clientAttachWindow').jqxWindow('bringToFront');
	  }); 
	  }
</script>
</head>
<body onload="getBranch();getStatus();">
<form autocomplete="off">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%">
<tr>
<td width="20%">
    <fieldset style="background: #ECF8E0;">
	<table width="100%" >
	<jsp:include page="../../heading.jsp"></jsp:include>
	
	<!--  <tr><td colspan="2">&nbsp;</td></tr> -->
		 <tr>
	<td colspan="2" ><table width="100%">
	  <tr>
	    <td colspan="3" align="center"><input type="button" name="btnUpdate" id="btnUpdate" value="Update" class="myButton" onClick="updateStatus();"></td>
	    </tr>
	  <tr>
	    <td width="17%" align="right"><label class="branch">Fleet</label></td>
	    <td colspan="2"><input type="text" name="fleetno" id="fleetno" readonly></td>
	    </tr>
	  <tr>
	    <td align="right"><label class="branch">Status</label></td>
	    <td colspan="2"><select name="cmbstatus" id="cmbstatus" style="width:82%;"><option value="">--Select--</option></select></td>
	    </tr>
	  <tr>
	    <td align="right"><label class="branch">Date</label></td>
	    <td colspan="2"><div id="fleetdate" name="fleetdate"></div></td>
	    </tr>
	  <tr>
	    <td align="right"><label class="branch">Time</label></td>
	    <td colspan="2"><div id="fleettime" name="fleettime"></div></td>
	    </tr>
	  <tr>
	    <td colspan="2" align="center"><!-- <input type="button" name="btnvehicle" id="btnvehicle" value="Vehicle" class="myButton" onclick="getVehicle();"> -->
	    <input type="button" name="btnattach" id="btnattach" value="Attach" class="myButton" onclick="getAttach();">
	    </td>
	    <td width="55%" align="center"><input type="button" name="btnmove" id="btnmove" value="Movement" class="myButton" onClick="getVehicleMov();"></td>
	    </tr>
	  <tr>
	    <td colspan="3"><center><div id="hiddate" name="hiddate" hidden="true"></div><div id="hidtime" name="hidtime" hidden="true"></div></center></td>
	    </tr>
	  </table>
	<br><br><br><br><br><br><br><br><br><br><br><br>
	
	
	<%-- <div id="Readygrid"   ><jsp:include page="vehDetailsgrid.jsp"></jsp:include>
	</div> --%></td>
	</tr> 
	<tr>

 
 


	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="fleetdiv"><jsp:include page="unRentableGrid.jsp"></jsp:include></div></td>
		</tr>
	</table>
</tr>
</table>
<div id="curdate" name="curdate" hidden="true"></div>
<div id="fromdate" name="fromdate" hidden="true"></div>
<input type="hidden" name="docno" id="docno">
<!-- <div id="vehiclewindow">
<div></div>
</div> -->
<div id="movementwindow">
<div></div>
</div>
<div id="clientAttachWindow">
   <div></div>
</div>
</div>
</div>
<input type="hidden" name="hidcmbstatus" id="hidcmbstatus">
<label id="trncodeval" hidden="true"></label>
<label id="statusval" hidden="true"></label>
</form>
</body>
</html>