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
<style>

.icons {
	width: 3em;
	height: 3em;
	border: none;
	background-color: #ECF8E0;
}
.iconss {
	width: 3em;
	height: 3em;
	border: none;
	background-color: #ECF8E0;
}
</style>
<script type="text/javascript">

$(document).ready(function () {
 
	
	
	// $('#vehiclewindow1').jqxWindow({ autoOpen: false,width: '80%', height: '80%',  maxHeight: '80%' ,maxWidth: '80%' , title: 'Vehicle Details' ,position: { x: 240, y: 15 }, keyboardCloseKey: 27, showCloseButton: true,closeButtonAction:'hide'});
	  $('#movementwindow').jqxWindow({ autoOpen: false,width: '77%', height: '74%',  maxHeight: '70%' ,maxWidth: '78%' , title: 'Movement Details' ,position: { x: 280, y: 15 }, keyboardCloseKey: 27, showCloseButton: true,closeButtonAction:'hide'}); 
	  $('#clientreview').click(function(){
	  	   var url=document.URL;
	  		var reurl=url.split("com");
	  		  window.parent.formName.value="Client Review";
	  		  window.parent.formCode.value="CRW";

	   top.addTab("Client Review",reurl[0]+"com/operations/clientrelations/clientreview/clientReview.jsp");

      }); 
	    $('#rabutton').click(function(){
	  	   var url=document.URL;
	  		var reurl=url.split("com");
	  		  window.parent.formName.value="Rental Agreement Create";
	  		  window.parent.formCode.value="RAG";

	   top.addTab("Rental Agreement",reurl[0]+"com/operations/agreement/rentalagreement/rentalAgreement.jsp");

	   });  
	   
	    $('#bookingbtn').click(function(){
		  	   var url=document.URL;
		  		var reurl=url.split("com");
		  		  window.parent.formName.value="Booking";
		  		  window.parent.formCode.value="VBR";

		   top.addTab("Booking",reurl[0]+"com/operations/marketing/booking/booking.jsp");

		   });  
		   
	  //rabutton bookingbtn
});

function funreload(event)  
{     
	document.getElementById("fleetno").value="";
	document.getElementById("brach").value="";
	document.getElementById("grp").value="";
	 disitems();
	 
	 
	 var barchval = document.getElementById("cmbbranch").value;
     
	 $("#fleetdiv").load("readyToRentGrid.jsp?brchval="+barchval);
	 
	 $("#maintariffGrid").jqxGrid('clear');
	 $("#jqxgridtarifrr").jqxGrid('clear');
	
	}
	
	
function funExportBtn()
{
	
//	$("#jqxFleetGrid").jqxGrid('exportdata', 'xls', 'ReadyToRent');
	
	
	
	 if(parseInt(window.parent.chkexportdata.value)=="1")
	 {
	 JSONToCSVCon(sssss, 'ReadyToRent', true);
	 }
 else
	 {
	   $("#jqxFleetGrid").jqxGrid('exportdata', 'xls', 'ReadyToRent');
	 }
	
	
	
	}
	
function disitems()
{
	 $('#btnvehicle').attr("disabled",true);
	 $('#btnmove').attr("disabled",true);
	 $('#btnclient').attr("disabled",true);
	 
}
	
 function getVehicleMov(){
	  var fleetno=document.getElementById("fleetno").value;
	  var vals=0;
	  var ready="ready";
	  $('#movementwindow').jqxWindow('setContent', '');
	  $('#movementwindow').jqxWindow('open');  
	  movementSearchContent("<%=contextPath%>/com/dashboard/vehicle/vehiclemovement/vehiclemovementGrid.jsp?fleetno="+fleetno+"&fromdate="+vals+"&todate="+vals+"&ready="+ready);
	 }
 
 function movementSearchContent(url) {
	 //$('#vehiclewindow').jqxWindow('open'); 
	 $('#movementwindow').jqxWindow('focus'); 
	 $.get(url).done(function (data) {
	$('#movementwindow').jqxWindow('setContent', data);
	}); 
	 
 }
 function changeClientAttachContent(url) {
		$.get(url).done(function (data) {
			    $('#windowattach').jqxWindow('open');
				$('#windowattach').jqxWindow('setContent',data);
				$('#windowattach').jqxWindow('bringToFront');
	}); 
	}
 function funClientAttach(){
	
	 
		if ($("#docno").val()!="") {
			  $("#windowattach").jqxWindow('setTitle',"VEH - "+document.getElementById("docno").value);
			changeClientAttachContent("<%=contextPath%>/com/common/attachGrid.jsp?formCode=VEH&docno="+document.getElementById("docno").value);		
		} else {
			$.messager.alert('Message','Select Fleet....!','warning');
			return;
		}
	}
 function openclientreview()
 {
	   var url=document.URL;
		var reurl=url.split("com");
		  window.parent.formName.value="Client Review";
		  window.parent.formCode.value="CRW";

 top.addTab("Client Review",reurl[0]+"com/operations/clientrelations/clientreview/clientReview.jsp");

 }
 /* function getRentalAgreement(){
	  var docno = $('#txtdocno').val();
	  
	  if(docno==''){
	    $.messager.alert('Message','Choose an Agreement.','warning');
	    return 0;
	   }
	  
	  var url=document.URL;
	  var reurl=url.split("com");
	  
	  window.parent.formName.value="Client Review";
	  window.parent.formCode.value="CRW";
	  
	  var detName= "Client Review";
	  var path= "com/operations/clientrelationsclientreviewDetails.action?mode=view&docno="+docno;
	  top.addTab( detName,reurl[0]+""+path);
	 }
  */
<%--  function getVehicle(){
	 $('#vehiclewindow1').jqxWindow('setContent', '');
	 $('#vehiclewindow1').jqxWindow('open'); 
	  vehicleSearchContent("<%=contextPath%>/com/controlcentre/masters/vehicle/saveVehicle1.action?mode=view&fleetno="+document.getElementById("fleetno").value);
	}
	function vehicleSearchContent(url) {
		 //$('#vehiclewindow').jqxWindow('open'); 
		 $('#vehiclewindow1').jqxWindow('focus'); 
		 $.get(url).done(function (data) {
		$('#vehiclewindow1').jqxWindow('setContent', data);
		}); 
		}
		  --%>
	

</script>
</head>
  
<body onload="getBranch();disitems();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%">
<tr>
<td width="20%">
    <fieldset style="background: #ECF8E0;">
	<table width="100%" >
	<jsp:include page="../../heading.jsp"></jsp:include>
	
	<!--  <tr><td colspan="2">&nbsp;</td></tr> -->
 <tr><td colspan="2">&nbsp;</td></tr> 
<tr><td align="right"><label class="branch">Fleet</label></td><td><input type="text" name="fleetno" id="fleetno" style="height:20px;width:60%;" readonly="readonly" value='<s:property value="fleetno"/>' ></td></tr>
<!-- <tr><td colspan="2">&nbsp;</td></tr> -->
<tr><td colspan="2" align="center"><input type="button" name="btnvehicle" id="btnvehicle" value="Attach" class="myButton" onclick="funClientAttach();">
<input type="button" name="btnmove" id="btnmove" value="Movement" class="myButton" onClick="getVehicleMov();">
</td></tr>
<tr><td colspan="2" align="center">

<button type="button"  title="Rental Agreement"  class="icons" id="rabutton"  value='<s:property value="rabutton"/>'> 
					 <img alt="Rental Agreement" src="<%=contextPath%>/icons/openra.png"> 
					</button>&nbsp;&nbsp;&nbsp;&nbsp;
					<button type="button"  title="Booking"  class="icons" id="bookingbtn"  value='<s:property value="bookingbtn"/>'>
					 <img alt="Booking" src="<%=contextPath%>/icons/openbk.png"> 
					</button>&nbsp;&nbsp;&nbsp;&nbsp;
					<button type="button"  title="Client Review"  class="icons" id="clientreview"  value='<s:property value="clientreview"/>'>
					 <img alt="Client Review" src="<%=contextPath%>/icons/openclientreview.png"> 
					</button>


<!-- <input type="button" name="btnclient" id="btnclient" value="Client Review" class="myButton" onClick="openclientreview();"></td> --></tr>
 <tr>
	<td colspan="2" align="center"><div id="mastertariff"><jsp:include page="masterTariffgrid.jsp"></jsp:include>
	</div></td>
	</tr> 
	<tr>
<tr>
	<td colspan="2" ></td> 
	</tr> 
	<tr>
	</table>
	</fieldset>
	
<input type="hidden" name="brach" id="brach" style="height:20px;width:60%;" readonly="readonly" value='<s:property value="brach"/>' >
<input type="hidden" name="grp" id="grp" style="height:20px;width:60%;" readonly="readonly" value='<s:property value="grp"/>' >

<input type="hidden" name="docno" id="docno" style="height:20px;width:60%;" readonly="readonly" value='<s:property value="docno"/>' >
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="fleetdiv"><jsp:include page="readyToRentGrid.jsp"></jsp:include></div></td>
			 
			 </tr>
			 
			
			 
			 <tr>
			 <td><div id="tariffdiv"><jsp:include page="tariffShowgrid.jsp"></jsp:include></div></td>
			
		</tr>
	</table>
</tr>
</table>
</div>

<label hidden="true" id="trncodeval"></label>
 <label  hidden="true" id="statusval"></label>
<div id="movementwindow">
<div></div>
</div> 

</div>


</body>
</html>