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
	 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
	 $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200;right:600;'><img src='../../../../icons/31load.gif'/></div>");   
	 $("#periodupto").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#returndate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 setType("0");
	  
});

function funreload(event)
{
	if($('#cmbtype').val()==""){
		$.messager.alert('warning','Please select a type');
		return false;
	}
	var docdateval=funDateInPeriod($('#periodupto').jqxDateTimeInput('getDate'));
	if(docdateval==0){
		$('#periodupto').jqxDateTimeInput('focus');
		return false;
	}
	var branch=$('#cmbbranch').val();
	var type=$('#cmbtype').val();
	var periodupto=$('#periodupto').val();
	$('#overlay,#PleaseWait').show();
	$("#vehreturndiv").load("vehReturnGrid.jsp?branch="+branch+"&periodupto="+periodupto+"&type="+type+"&id=1");	
	
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
	
	function setType(value){
		$('#agmtno').val('');
		$('#curdepr').val('');
		$('#vehReturnGrid').jqxGrid('clear');
		if(value=="2"){
			$('#btnvehreturn,#lblagmt,#agmtno,#returndate,#curdepr,#remarks,#lblremarks,#lblreturndate').css('opacity','1');
			
		}
		else{
			$('#btnvehreturn,#lblagmt,#agmtno,#returndate,#curdepr,#remarks,#lblremarks,#lblreturndate').css('opacity','0');
		}
	}
	
	function funReturnVeh(){
		if(document.getElementById("agmtno").value==""){
			$.messager.alert('warning','Please select an agreement');
			return false;
		}
		/* if($('#deprstatus').val()=="1"){
			$.messager.confirm('Confirm', 'Are you Sure?', function(r){
				if (r){
					returnVehAJAX();
				}
		 		});
		}
		else{
			$.messager.alert('warning', 'Please complete vehicle depreciation');
			return false;
		} */
		$.messager.confirm('Confirm', 'Are you Sure?', function(r){
			if (r){
				returnVehAJAX();
			}
	 		});
	}

	function returnVehAJAX(){
		var arr=new Array();
		/* var rows=$('#vehReturnCalcGrid').jqxGrid('getrows');
		for(var i=0;i<rows.length;i++){
			arr.push($('#vehReturnCalcGrid').jqxGrid('getcellvalue',i,'acno')+"::"+$('#vehReturnCalcGrid').jqxGrid('getcellvalue',i,'amount'));
		} */
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
			{
				var items= x.responseText;
				if(items.trim()=="0")
				{
					$.messager.alert('Message','Successfully Returned');
					funreload(1);
				}
				else
				{
					$.messager.alert('Message','Not Returned');
				}
		}
		else
		{
			   
		}
		}
		x.open("GET", "returnVehAJAX.jsp?agmtno="+$("#hidagmtno").val()+"&fleetno="+$("#fleetno").val()+"&branch="+$("#cmbbranch").val()+"&calcarray="+arr+"&returndate="+$('#returndate').jqxDateTimeInput('val')+"&returnremarks="+$('#remarks').val()+"&stockvehiclestatus="+$('#stockvehiclestatus').val(), true);
		x.send();
	}
function funExportBtn(){
		 JSONToCSVCon(vehretrnexcel, 'LA Vehicle Return', true);
		
	}
</script>
</head>
<body onload="getBranch();setValues();">
<form id="frmDashboardVehicleReturnNew" action="saveDashboardVehicleReturnNew">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%">
<tr>
<td width="20%">
    <fieldset style="background: #ECF8E0;">
	<table width="100%">
	<jsp:include page="../../heading.jsp"></jsp:include>
	
 <tr><td width="34%" align="right"><label class="branch">Period Upto</label></td><td width="66%"><div id="periodupto"></div></td></tr>
		 <tr><td width="34%" align="right"><label class="branch">Type</label></td>
         <td width="66%"><select name="cmbtype" id="cmbtype" onchange="setType(this.value);">
         		<option value="">--Select--</option>
         		<option value="1">Agreements Due</option>
                <option value="2">Vehicle to be returned&nbsp;&nbsp;&nbsp;</option>
                </select>
                </td></tr> 
        <tr>
	  		<td align="right"><label id="lblagmt" class="branch">Agreement/Stock</label></td>
	  		<td align="left"><input type="text" id="agmtno" name="agmtno"  style="height:18px;"></td>
	  	</tr>
	  	<tr>
	  		<td align="right"><label id="lblreturndate" class="branch">Return Date</label></td>
	  		<td align="left"><div id="returndate" name="returndate" value='<s:property value="returndate"/>'></div></td>
	  	</tr>
	  	<tr>
	  		<td align="right"><label id="lblremarks" class="branch">Remarks</label></td>
	  		<td align="left"><input type="text" id="remarks" name="remarks" value='<s:property value="remarks"/>' style="height:80px;"></td>
	  	</tr>
	  	<tr>
	  <td colspan="2">&nbsp;</td>
	  </tr>
	<tr>
	<td colspan="2"><center><input type="button" name="btnvehreturn" id="btnvehreturn" class="myButton" value="Return" onclick="funReturnVeh();"></center></td>
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

	</table>
	</fieldset>
</td>
<!--<tr>
			 <td><div id="vehreturndiv"><jsp:include page="vehReturnGrid.jsp"></jsp:include></div></td>
		</tr>
        <tr>
        	<td><div id="vehreturncalcdiv"><jsp:include page="vehReturnCalcGrid.jsp"></jsp:include></div></td>
        </tr>-->
<td width="80%"><div id="vehreturndiv"><jsp:include page="vehReturnGrid.jsp"></jsp:include></div></td>
</tr>
</table>
<input type="hidden" name="invgridlength" id="invgridlength"  value='<s:property value="invgridlength"/>'>
			  <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
			  <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
			  <input type="hidden" name="hidagmtno" id="hidagmtno" value='<s:property value="hidagmtno"/>'>
			  <input type="hidden" name="fleetno" id="fleetno" value='<s:property value="fleetno"/>'>
			  <input type="hidden" name="stockvehiclestatus" id="stockvehiclestatus" value='<s:property value="stockvehiclestatus"/>'>
</div>

</div>
</form>
</body>
</html>