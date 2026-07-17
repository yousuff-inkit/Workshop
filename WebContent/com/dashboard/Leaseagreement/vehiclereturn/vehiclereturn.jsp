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
	 $('#clientwindow').jqxWindow({ width: '40%', height: '50%',  maxHeight: '50%' ,maxWidth: '40%' , title: 'Client Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	 $('#clientwindow').jqxWindow('close');
	 $('#accountwindow').jqxWindow({ width: '40%', height: '50%',  maxHeight: '50%' ,maxWidth: '40%' , title: 'Account Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	 $('#accountwindow').jqxWindow('close');
	 $('#cmbtype').val('2');
	 setType("2");
	 $('#client').dblclick(function(){
		$('#clientwindow').jqxWindow('open');
		$('#clientwindow').jqxWindow('focus');
		clientSearchContent('masterClientSearch.jsp?id=1', $('#clientwindow'));
	});
	$('#placno').dblclick(function(){
		$('#accountwindow').jqxWindow('open');
		$('#accountwindow').jqxWindow('focus');
		PLAccountSearchContent('PLAccountSearch.jsp?id=1', $('#accountwindow'));
	});
});
function getClient(event){
	var x= event.keyCode;
   	if(x==114){
   		$('#clientwindow').jqxWindow('open');
		$('#clientwindow').jqxWindow('focus');
		clientSearchContent('masterClientSearch.jsp?id=1', $('#clientwindow'));
   	}
   	else{
    }
}

function getPLAccount(event){
	var x= event.keyCode;
   	if(x==114){
   		$('#accountwindow').jqxWindow('open');
		$('#accountwindow').jqxWindow('focus');
		PLAccountSearchContent('PLAccountSearch.jsp?id=1', $('#accountwindow'));
   	}
   	else{
    }
}
function clientSearchContent(url) {
	$.get(url).done(function (data) {
   		$('#clientwindow').jqxWindow('setContent', data);
	}); 
}
function PLAccountSearchContent(url) {
	$.get(url).done(function (data) {
   		$('#accountwindow').jqxWindow('setContent', data);
	}); 
}
function funreload(event)
{
	if($('#cmbbranch').val()=="" || $('#cmbbranch').val()=="a"){
		$.messager.alert('warning','Please select a branch');
		return false;
	}
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
			$('#btnvehreturn,#lblagmt,#agmtno,#lblcurdepr,#curdepr').css('opacity','1');
			
		}
		else{
			$('#btnvehreturn,#lblagmt,#agmtno,#lblcurdepr,#curdepr').css('opacity','0');
		}
	}
	
	function funReturnVeh(){
		if(document.getElementById("agmtno").value==""){
			$.messager.alert('warning','Please select an agreement');
			return false;
		}
		if(document.getElementById("client").value==""){
			$.messager.alert('warning','Please select a client');
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
		var rows=$('#vehReturnCalcGrid').jqxGrid('getrows');
		for(var i=0;i<rows.length;i++){
			arr.push($('#vehReturnCalcGrid').jqxGrid('getcellvalue',i,'acno')+"::"+$('#vehReturnCalcGrid').jqxGrid('getcellvalue',i,'amount'));
		}
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
			{
				var items= x.responseText;
				if(items.trim()=="0")
				{
					$.messager.alert('Message','Successfully Returned');
					$('#vehReturnCalcGrid').jqxGrid('clear');
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
		x.open("GET", "returnVehAJAX.jsp?agmtno="+$("#hidagmtno").val()+"&fleetno="+$("#fleetno").val()+"&branch="+$("#cmbbranch").val()+"&calcarray="+arr+"&date="+$("#periodupto").jqxDateTimeInput("val")+"&branchid="+$("#cmbbranch").val()+"&cldocno="+$('#hidclient').val()+"&salesvalue="+$('#salesvalue').val()+"&stockvehiclestatus="+$('#stockvehiclestatus').val(), true);
		x.send();
	}
	
	function funExportBtn(){
	
			 JSONToCSVCon(vehretrnexcel, 'DeFleet', true);
			
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
	
 <tr><td width="34%" align="right"><label class="branch">Period Upto</label></td><td width="66%"><div id="periodupto"></div></td></tr>
		 <tr><td width="34%" align="right"><label class="branch">Type</label></td>
         <td width="66%"><select name="cmbtype" id="cmbtype" onchange="setType(this.value);">
         		<option value="">--Select--</option>
         		<!-- <option value="1">Agreements Due</option> -->
                <option value="2">Returned Vehicles&nbsp;&nbsp;&nbsp;</option>
                </select>
                </td></tr> 
        <tr>
	  		<td align="right"><label id="lblagmt" class="branch">Agreement/Stock</label></td>
	  		<td align="left"><input type="text" id="agmtno" name="agmtno"  style="height:18px;" readonly></td>
	  	</tr>
	  	<tr>
	  		<td align="right"><label id="lblclient" class="branch">Client</label></td>
	  		<td align="left"><input type="text" id="client" name="client"  style="height:18px;" onkeydown="getClient(event);" readonly placeholder="Press F3 to Search"></td>
	  	</tr>
	  	<input type="hidden" id="hidclient" name="hidclient"  style="height:18px;">
	  	<tr>
	  <td align="right"><label id="lblsiezevalue" class="branch" >Sales Value</label></td>
	  <td align="left"><input type="text" id="salesvalue" name="salesvalue" style="height:18px;text-align:right;" onkeypress="javascript:return isNumber (event,id)" onblur="funRoundAmt(value,id);"></td>
	  </tr>
	  <!-- <tr>
	  <td align="right"><label id="lblplaccount" class="branch" >Profit/Lose Account</label></td>
	  <td align="left"><input type="text" id="placno" name="placno" style="height:18px;" readonly placeholder="Press F3 to Search" onkeydown="getPLAccount(event);"></td>
	  </tr> -->
	  <input type="hidden" id="hidplacno" name="hidplacno" style="height:18px;">
	  	<tr>
	  		<td align="right"><label id="lblcurdepr" class="branch" hidden="true">Current Depr</label></td>
	  		<td align="left"><input type="hidden" id="curdepr" name="curdepr" style="height:18px;"></td>
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
	<tr>
	  <td colspan="2">&nbsp;</td>
	  </tr>
	  <tr>
	  <td colspan="2">&nbsp;</td>
	  </tr>
 <tr>
	  <td colspan="2"><br><br></td>
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
<td width="80%"><table width="100%" height="386" border="0">
  <tr>
    <td height="238"><div id="vehreturndiv"><jsp:include page="vehReturnGrid.jsp"></jsp:include></div></td>
  </tr>
  <tr>
    <td><div id="vehreturncalcdiv"><jsp:include page="vehReturnCalcGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
	</td>
</tr>
</table>
<input type="hidden" name="invgridlength" id="invgridlength"  value='<s:property value="invgridlength"/>'>
			  <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
			  <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
			  <input type="hidden" name="hidagmtno" id="hidagmtno" value='<s:property value="hidagmtno"/>'>
			  <input type="hidden" name="fleetno" id="fleetno" value='<s:property value="fleetno"/>'>
			   <input type="hidden" name="clientacno" id="clientacno" value='<s:property value="clientacno"/>'>
			    <input type="hidden" name="stockvehiclestatus" id="stockvehiclestatus" value='<s:property value="stockvehiclestatus"/>'>
</div>
<div id="clientwindow">
<div></div>
</div>
<div id="accountwindow">
<div></div>
</div>
</div>
</form>
</body>
</html>