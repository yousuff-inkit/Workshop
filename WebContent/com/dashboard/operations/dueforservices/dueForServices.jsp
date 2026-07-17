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
	$('#servicekm,#btnupdate').attr('disabled',true);
	$('#branchlabel,#branchdiv').hide();
	$('#btnupdate').click(function(){
		$.messager.confirm('Confirm', 'Do you want to update service km with '+$('#servicekm').val()+' of fleet '+$('#fleetno').val(), function(r){
			if (r){
				$('#overlay,PleaseWait').show();
				funUpdateKmAJAX($('#fleetno').val(),$('#servicekm').val());
			}
	 		});
	});
});

function funUpdateKmAJAX(fleetno,servicekm){
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			items = x.responseText;
			items=items.trim();
			//alert(items);
			if(parseInt(items)>0){
				$.messager.alert('Message','Successfully Updated');
				$('#servicekm').val('');
				$('#servicekm,#btnupdate').attr('disabled',true);
				$('#dueforservicesdiv').load('dueForServicesGrid.jsp?id=1');
			}
			else{
				$.messager.alert('Warning','Not Updated');
				return false;
			}
			} else {
		}
	}
	x.open("GET", "updateServiceKm.jsp?fleetno="+fleetno+"&servicekm="+servicekm, true);
	x.send();
	
}
function funreload(event)
{	
//Tracker Km Update
    
    var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			items = x.responseText;
			items=items.trim();
			//alert(items);
			/* if(parseInt(items)>0){
				$('#docno').val(parseInt(items));
				$('#overlay,PleaseWait').show();
				$('#gpsdiv').load('gpsGrid.jsp?docno='+items+'&id=1');
			}
			else{
				$.messager.alert('Warning','Download Not Completed');
				return false;
			} */
			} else {
		}
	}
	x.open("GET", "updateTrackerKm.jsp", true);
	x.send();
	
	$('#servicekm').val('');
	$('#dueforservicesdiv').load('dueForServicesGrid.jsp?id=1');
}
function funNotify(){

}
function setValues(){

	if($('#msg').val()!=""){
  		$.messager.alert('Message','<center>'+$('#msg').val()+'</center>');
  	}
}
function funExportBtn(){

	 if(parseInt(window.parent.chkexportdata.value)=="1")
 {
 	JSONToCSVCon(dueexceldata, 'Due For Services', true);
 }
else
 {
	 $("#dueForServicesGrid").jqxGrid('exportdata', 'xls', 'Due For Services');
 }



}

</script>
</head>
<body onload="getBranch();setValues();">
<form id="frmDueForServices" action="saveDueForServices">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%">
<tr>
<td width="20%">
    <fieldset style="background: #ECF8E0;">
	<table width="100%">
	<jsp:include page="../../heading.jsp"></jsp:include>
	
	<tr><td colspan="2">&nbsp;</td></tr>
 
<tr><td width="30%" align="right"><label class="branch">Service Km</label></td><td width="70%"><input type="text" name="servicekm" id="servicekm" style="height:19px;" value='<s:property value="servicekm"/>'></td></tr> 
<input type="hidden" name="fleetno" id="fleetno" >
		 <tr>
	<td colspan="2" align="center"><hr></td>
	</tr> 
	<tr>
	<td colspan="2"  align="center"><button type="button" name="btnupdate" id="btnupdate" class="myButton">Update</button></td>
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
	  </tr>
	<tr>
	  <td colspan="2">&nbsp;</td>
	  </tr>
	<tr>
	  <td colspan="2">&nbsp;</td>
	  </tr>
	
	<tr>
	<td colspan="2"><br><br><br><br><br></td>
	</tr>	
	</table>
	</fieldset>
</td>
<td width="80%">
<div id="dueforservicesdiv"><jsp:include page="dueForServicesGrid.jsp"></jsp:include></div>
</td>
</tr>
</table>
</div>
<input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
<input type="hidden" name="docno" id="docno" value='<s:property value="docno"/>'>
			  <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
</div>
</form>
</body>
</html>