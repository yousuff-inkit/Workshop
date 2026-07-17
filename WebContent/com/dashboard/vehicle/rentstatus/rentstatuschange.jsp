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
 
	
	
	// $('#vehiclewindow1').jqxWindow({ autoOpen: false,width: '80%', height: '80%',  maxHeight: '80%' ,maxWidth: '80%' , title: 'Vehicle Details' ,position: { x: 240, y: 15 }, keyboardCloseKey: 27, showCloseButton: true,closeButtonAction:'hide'});
	  $('#movementwindow').jqxWindow({ autoOpen: false,width: '77%', height: '74%',  maxHeight: '70%' ,maxWidth: '78%' , title: 'Movement Details' ,position: { x: 280, y: 15 }, keyboardCloseKey: 27, showCloseButton: true,closeButtonAction:'hide'}); 
 
});

function funreload(event)  
{     
	document.getElementById("fleetno").value="";
	document.getElementById("brach").value="";
	document.getElementById("grp").value="";
	 document.getElementById("docno").value="";
	 document.getElementById("rentaltype").value="";
	 document.getElementById("typeingrid").value="";
	
	 disitems();
		 var barchval = document.getElementById("cmbbranch").value;
     
	 $("#fleetdiv").load("vehlistshowgrid.jsp?brchval="+barchval);
	 
	
	}
	
 	
function disitems()
{
	 $('#btnvehicle').attr("disabled",true);
	 $('#btnmove').attr("disabled",true);
	 $('#btnupdate').attr("disabled",true);
	 $('#rentaltype').attr("disabled",true);
	 $('#fleetno').attr("disabled",true);
	 
	  
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

	
 function funsamechk()
 {
	 
	 if(document.getElementById("rentaltype").value==document.getElementById("typeingrid").value)
	 {
		 $.messager.alert('Message','Rent Type Is Same','warning');   
		 document.getElementById("rentaltype").focus();
					 
		 return 0;
	 }
	 
 }
 
 
 
		  function funupdate()
		  
			{

			  
			  if(document.getElementById("rentaltype").value=="")
				 {
					 $.messager.alert('Message','Select Rent Type ','warning');   
								 
					 return 0;
				 }
				
			  if(document.getElementById("rentaltype").value==document.getElementById("typeingrid").value)
				 {
					 $.messager.alert('Message','Rent Type Is Same','warning');   
					 document.getElementById("rentaltype").focus();
								 
					 return 0;
				 }
			  var fleetno=document.getElementById("fleetno").value;
			  
			  var renttype=document.getElementById("rentaltype").value;
			  
			  savegriddata(fleetno,renttype);
			 
			}	
				
	
		
			function savegriddata(fleetno,renttype)
			{
				
				var x=new XMLHttpRequest();
				x.onreadystatechange=function(){
				if (x.readyState==4 && x.status==200)
					{
					
						var items=x.responseText;
						 document.getElementById("rentaltype").value="";
						 document.getElementById("fleetno").value="";
						 document.getElementById("brach").value="";
						 document.getElementById("grp").value="";
						 document.getElementById("docno").value="";
						 document.getElementById("typeingrid").value="";
						  
			              $.messager.alert('Message', '  Record Successfully Updated ', function(r){
					 		   
					     });
						 funreload(event); 
						 
						 disitems();
						 
						
						}
					
				}
					
			x.open("GET","saverenttype.jsp?fleet="+fleetno+"&renttype="+renttype,true);

			x.send();
					
			}
			
			
			function funExportBtn(){
				
				   
				   
				   
				   
				   
					 if(parseInt(window.parent.chkexportdata.value)=="1")
					 {
					 JSONToCSVCon(sssss, 'Rent Status', true);
					 }
				 else
					 {
					   $("#jqxFleetGrid").jqxGrid('exportdata', 'xls', 'Rent Status');
					 }
					   
					
				   
				 }			
			
			
			
			
			
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
<tr> <td  align="right"><label class="branch">RentType</label></td><td align="left">
<select name="rentaltype" id="rentaltype" style="width:60%;" value='<s:property value="rentaltype"/>' onchange="funsamechk()">
  <option value="" selected>--Select--</option>
  <option value="R" selected>Rental</option>
		     <option value="L">Lease</option>
		     <option value="LM">Limousine</option>
		     <option value="A">All</option>
</select></td></tr> 
 <tr><td colspan="2" ></td></tr> 
<tr><td colspan="2" align="center"><input type="button" name="btnupdate" id="btnupdate" value="Update" class="myButton" onclick="funupdate();"></td></tr>
 <tr><td colspan="2" ></td></tr> 
 <tr><td colspan="2" ></td></tr> 
  <tr><td colspan="2" ></td></tr> 
   <tr><td colspan="2" ></td></tr> 
<tr><td colspan="2" align="center"><input type="button" name="btnvehicle" id="btnvehicle" value="Attach" class="myButton" onclick="funClientAttach();">
<input type="button" name="btnmove" id="btnmove" value="Movement" class="myButton" onClick="getVehicleMov();"></td></tr>

 <tr><td colspan="2" ></td></tr>  <tr><td colspan="2" ></td></tr>  <tr><td colspan="2" ></td></tr>  <tr><td colspan="2" ></td></tr> 
 <tr><td colspan="2" ></td></tr> 
 <tr><td colspan="2" ></td></tr> 
 <tr><td colspan="2" ></td></tr> 
 <tr><td colspan="2" ></td></tr> 
  <tr><td colspan="2" ></td></tr> 
   <tr><td colspan="2" ></td></tr> 
    <tr><td colspan="2" ></td></tr> 
     <tr><td colspan="2" ></td></tr> 
     
<tr>
	<td colspan="2"><div id='pieChart1' style="width: 100% ; align:right; height: 170px;"></div></td>
	</tr>
	</table>
	</fieldset>
	
<input type="hidden" name="brach" id="brach" style="height:20px;width:60%;" readonly="readonly" value='<s:property value="brach"/>' >
<input type="hidden" name="grp" id="grp" style="height:20px;width:60%;" readonly="readonly" value='<s:property value="grp"/>' >

<input type="hidden" name="docno" id="docno" style="height:20px;width:60%;" readonly="readonly" value='<s:property value="docno"/>' >
<input type="hidden" name="typeingrid" id="typeingrid" style="height:20px;width:60%;" readonly="readonly" value='<s:property value="typeingrid"/>' >
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="fleetdiv"><jsp:include page="vehlistshowgrid.jsp"></jsp:include></div></td>
			 
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