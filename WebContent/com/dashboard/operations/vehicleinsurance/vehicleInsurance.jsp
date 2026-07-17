<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  

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
input[type=text]{
	height:18px;
}
</style>
<jsp:include page="../../../../includes.jsp"></jsp:include>    
<script type="text/javascript">
$(document).ready(function () {
	$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	$("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200px;right:750px;'><img src='../../../../icons/31load.gif'/></div>");
	$("#uptodate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	$("#insuruptodate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	$("#postdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	$("#insurfromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	$("#insurtodate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	$("#invdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	$('#vendorwindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '80%' ,maxWidth: '50%' , title: 'Vendor Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	$('#vendorwindow').jqxWindow('close');
	
	$('#singlevendor,#multiplevendor').dblclick(function(){
		var type="";
		if(document.getElementById("rdosingle").checked==true){
			type="1";
		}
		else if(document.getElementById("rdomultiple").checked==true){
			type="2";
		}
		else{
			$.messager.alert('Warning','Please select any valid option');
			return false;
		}
		$('#vendorwindow').jqxWindow('open');
		$('#vendorwindow').jqxWindow('focus');
		SearchContent('vendorSearchGrid.jsp?id=1&type='+type,'vendorwindow');
	});
	$('#branchlabel,#branchdiv').hide();
	document.getElementById("rdosingle").checked=true;
	setType("1");
});

function getVendor(){
	var type="";
	if(document.getElementById("rdosingle").checked==true){
		type="1";
	}
	else if(document.getElementById("rdomultiple").checked==true){
		type="2";
	}
	else{
		$.messager.alert('Warning','Please select any valid option');
		return false;
	}
	$('#vendorwindow').jqxWindow('open');
	$('#vendorwindow').jqxWindow('focus');
	SearchContent('vendorSearchGrid.jsp?id=1&type='+type,'vendorwindow');
}
function SearchContent(url,windowid) {
	$.get(url).done(function (data) {
		$('#'+windowid).jqxWindow('setContent', data);
	}); 
}
function funreload(event)
{
	
	$('#vehicleInsurGrid').jqxGrid('clear');
	$('#multipleVehicleInsurGrid').jqxGrid('clear');
	$('#insurHistoryGrid').jqxGrid('clear');
    $('#insurhistorydiv').hide();
    $('#vehicleInsurGrid').jqxGrid({height:500});
    $('#multipleVehicleInsurGrid').jqxGrid({height:500});
	$("#overlay, #PleaseWait").show();
    var uptodate=$('#uptodate').jqxDateTimeInput('val');
    var branch=$('#cmbbranch').val();
    var type="";
    if(document.getElementById("rdosingle").checked==true){
    	type="1";
    }
    else{
    	type="2";
    }
    $('#invoicediv').load('invoiceGrid.jsp?uptodate='+uptodate+'&id=1&branch='+branch+'&type='+type);
/*    	$("#replacediv").load("replaceGrid.jsp?fromdate="+fromdate+"&todate="+todate+"&repstatus="+repstatus+"&repreason="+repreason+"&reptype="+reptype+"&agmttype="+agmttype+"&agmtbranch="+agmtbranch+"&agmtno="+agmtno+"&rentaltype="+rentaltype+"&agmtstatus="+agmtstatus+"&id=1");
 */   	
}
	
	

	function setValues(){

		 if($('#msg').val()!=""){
   		   $.messager.alert('Message',$('#msg').val());
   		  }
	getBranch();
	}
	
	function funExportBtn(){
	/* 	JSONToCSVCon(repexceldata, 'Replacement List', true); */
		if(document.getElementById("rdosingle").checked==true){
			if(parseInt(window.parent.chkexportdata.value)=="1")
			{
				JSONToCSVCon(insurexceldata, 'Vehicle Insurance', true);
			}
			else
			{
				$("#vehicleInsurGrid").jqxGrid('exportdata', 'xls', 'Vehicle Insurance');
			}	
		}
		else{
			if(parseInt(window.parent.chkexportdata.value)=="1")
			{
				JSONToCSVCon(insurmultipleexceldata, 'Vehicle Insurance', true);
			}
			else
			{
				$("#multipleVehicleInsurGrid").jqxGrid('exportdata', 'xls', 'Vehicle Insurance');
			}
		}
		 
		 }
	
		
	
	function funClearData(){
 		$('input[type=text],[type=hidden]').val('');
		$('select').find('option').prop("selected", false);
	    $('#uptodate').jqxDateTimeInput('setDate', new Date());
	    $('#invdate').jqxDateTimeInput('setDate', new Date());
	    $('#insurfromdate').jqxDateTimeInput('setDate', new Date());
	    $('#insurtodate').jqxDateTimeInput('setDate', new Date());
	
	}
	 function isNumber(evt,id) {
		//Function to restrict characters and enter number only
		  var iKeyCode = (evt.which) ? evt.which : evt.keyCode
		if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57))
		 {
			 $.messager.alert('Warning','Enter Numbers Only');
		   $("#"+id+"").focus();
			return false;
			
		 }
		
		return true;
	}
	 
	function funPost(){
		
		var type="";
		if(document.getElementById("rdosingle").checked==true){
			type="1";
		}
		else{
			type="2";
		}
		if(type=="1"){
			if($('#agmtno,#invno,#invamount,#singlevendor').val()==''){
				$.messager.alert('warning','All fields are mandatory');
				return false;
			}
			if($('#insurfromdate').jqxDateTimeInput('getDate')==null){
				$.messager.alert('warning','All fields are mandatory');
				return false;
			}
			if($('#insurtodate').jqxDateTimeInput('getDate')==null){
				$.messager.alert('warning','All fields are mandatory');
				return false;
			}
			if($('#invdate').jqxDateTimeInput('getDate')==null){
				$.messager.alert('warning','All fields are mandatory');
				return false;
			}
			var invdateval=funDateInPeriod($('#invdate').jqxDateTimeInput('getDate'));
			if(invdateval==0){
				$('#invdate').jqxDateTimeInput('focus');
				return false;
			}
		}
		else if(type=="2"){
			if($('#multiplevendor,#percentage').val()==''){
				$.messager.alert('warning','All fields are mandatory');
				return false;
			}
			if($('#insuruptodate').jqxDateTimeInput('getDate')==null){
				$.messager.alert('warning','All fields are mandatory');
				return false;
			}
			if($('#postdate').jqxDateTimeInput('getDate')==null){
				$.messager.alert('warning','All fields are mandatory');
				return false;
			}
			var postdateval=funDateInPeriod($('#postdate').jqxDateTimeInput('getDate'));
			if(postdateval==0){
				$('#postdate').jqxDateTimeInput('focus');
				return false;
			}
			var selectedrows=$('#multipleVehicleInsurGrid').jqxGrid('getselectedrowindexes');
			if(selectedrows.length==0){
				$.messager.alert('Warning','Please Select Valid Documents');
				return false;
			}
		}
		if(type=="1"){
			$.messager.confirm('Confirm', 'Do you want to Generate Invoice?', function(r){
	 			if (r){
					postAJAX();
	 			}
 	 		});
		}
		else if(type=="2"){
			$.messager.confirm('Confirm', 'Do you want to Generate Invoice?', function(r){
	 			if (r){
					postMultipleAJAX();
	 			}
 	 		});
	 	}
		
	} 
	
	function postMultipleAJAX(){
		var percentage=$('#percentage').val();
		var insuruptodate=$('#insuruptodate').jqxDateTimeInput('val');
		var postdate=$('#postdate').jqxDateTimeInput('val');
		var selectedrows=$('#multipleVehicleInsurGrid').jqxGrid('getselectedrowindexes');
		var multiplearray=new Array();
		for(var i=0;i<selectedrows.length;i++){
			var agmtno=$('#multipleVehicleInsurGrid').jqxGrid('getcellvalue',selectedrows[i],'doc_no');
			var outdate=$('#multipleVehicleInsurGrid').jqxGrid('getcelltext',selectedrows[i],'outdate');
			var purchasecost=$('#multipleVehicleInsurGrid').jqxGrid('getcellvalue',selectedrows[i],'prch_cost');
			multiplearray.push(agmtno+"///"+outdate+"///"+purchasecost);
		}
		var vendoracno=$('#multiplevendoracno').val();
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = parseInt(x.responseText.trim());
				if(items>0){
					$.messager.alert('Message','Successfully Saved of JV '+items);
					funreload("");
				}
				else{
					$.messager.alert('Message','Not Saved');
				}
			} else {

			}
		}
		x.open("GET","postMultipleAJAX.jsp?multiplearray="+multiplearray+"&percentage="+percentage+"&insuruptodate="+insuruptodate+"&postdate="+postdate+"&vendoracno="+vendoracno, true);
		x.send();
	}
	function postAJAX(){
		var agmtno=$('#hidagmtno').val();
		// var vendor=$('#hidvendor').val();
		var invno=$('#invno').val();
		var invamount=$('#invamount').val();
		var invdate=$('#invdate').jqxDateTimeInput('val');
		var insurfromdate=$('#insurfromdate').jqxDateTimeInput('val');
		var insurtodate=$('#insurtodate').jqxDateTimeInput('val');
		var vendoracno=$('#singlevendoracno').val();
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = parseInt(x.responseText.trim());
				if(items>0){
					$.messager.alert('Message','Successfully Saved of JV '+items);
					$('#invoiceGrid').jqxGrid('clear');
					$('#vehicleInsurGrid').jqxGrid('clear');
				}
				else{
					$.messager.alert('message','Not Saved');
				}
			} else {

			}
		}
		x.open("GET","postAJAX.jsp?agmtno="+agmtno+"&invno="+invno+"&invamount="+invamount+"&invdate="+invdate+"&insurfromdate="+insurfromdate+"&insurtodate="+insurtodate+"&vendoracno="+vendoracno, true);
		x.send();
	}
	
	function setType(value){
		$('#vehicleinsurdiv,#multiplevehicleinsurdiv,#insurhistorydiv').attr('hidden',true);
		$('#singlevendor,#singlehidvendor,#singlevendoracno,#multiplevendor,#multiplehidvendor,#multiplevendoracno').val('');
		$('#invoiceGrid,#vehicleInsurGrid,#multipleVehicleInsurGrid,#insurHistoryGrid').jqxGrid('clear');
		
		if(value=="1"){
			//Single Type
			$('#percentage').attr('disabled',true);
			$('#vehicleInsurGrid').jqxGrid({height:500});
			$('#vehicleinsurdiv').attr('hidden',false);
			$('#multiplevehicleinsurdiv').attr('hidden',true);
			$('#singlediv').attr('hidden',false);
			$('#multiplediv').attr('hidden',true);
			
		}
		else if(value=="2"){
			//Multiple Type 
			$('#percentage').attr('disabled',false);
			$('#multipleVehicleInsurGrid').jqxGrid({height:500});
			$('#vehicleinsurdiv').attr('hidden',true);
			$('#multiplevehicleinsurdiv').attr('hidden',false);
			$('#singlediv').attr('hidden',true);
			$('#multiplediv').attr('hidden',false);
			setAutomaticInsurAccount();
		}
	}
	
	function setAutomaticInsurAccount(){
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText.trim();
				var temp=items.split("###");
				if(temp[0]=="1"){
					$('#multiplevendor').val(temp[3]);
        		    $('#multiplevendoracno').val(temp[1]);    	
				}
			} else {

			}
		}
		x.open("GET","setAutoInsurAccount.jsp", true);
		x.send();
	}
	</script>
	
</head>
<body onload="setValues();">
<form id="frmVehicleInsurance" method="post">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%">
<tr>
<td width="23%" align="center">
    <fieldset style="background: #ECF8E0;">
	<table width="100%">
	<jsp:include page="../../heading.jsp"></jsp:include>

 <tr>
   <td width="37%" align="right"><label class="branch">Upto Date</label></td><td width="63%"><div id="uptodate"></div></td></tr>
 <tr>
 	<td colspan="2" align="center"><div id="invoicediv"><jsp:include page="invoiceGrid.jsp"></jsp:include></div></td>
 </tr>
 <tr>
 	<td colspan="2" align="center"><input type="radio" id="rdosingle" name="rdotype" value="1" onchange="setType(value);"><label for="rdosingle" class="branch">Single</label>&nbsp;&nbsp;
 	<input type="radio" id="rdomultiple" name="rdotype"value="2" onchange="setType(value);"><label for="rdomultiple" class="branch">Multiple</label></td>
 </tr>
 <tr>
   <td colspan="2">
   <table width="100%" border="0">
  <tr>
    <td width="43%" align="right"><label class="branch">Agreement No</label></td>
    <td width="57%"><input type="text" name="agmtno" id="agmtno"  style="height:18px;"></td>
    <input type="hidden" name="hidagmtno" id="hidagmtno"> 
  </tr>
</table>
   </td>
   </tr>
 <tr>
   <td colspan="2" ><fieldset id="singlediv"><legend><label class="branch">Invoice Posting</label></legend>
   <table width="100%" border="0">
  <tr>
    <td width="44%" align="right"><label class="branch">Account</label></td>
    <td width="56%"><input type="text" name="singlevendor" id="singlevendor" readonly placeholder="Press F3 to Search" style="height:18px;"></td>
	<input type="hidden" name="singlehidvendor" id="singlehidvendor">
	<input type="hidden" name="singlevendoracno" id="singlevendoracno">
  </tr>
  <tr>
    <td align="right"><label class="branch">Inv No</label></td>
    <td><input type="text" name="invno" id="invno"  style="height:18px;"></td>
  </tr>
  <tr>
    <td align="right"><label class="branch">Inv Date</label></td>
    <td><div id="invdate" name="invdate"></div></td>
  </tr>
  <tr>
    <td align="right"><label class="branch">Inv Amount</label></td>
    <td><input type="text" name="invamount" id="invamount" style="text-align:right;height:18px;" onkeypress="javascript:return isNumber (event,id)" onblur="funRoundAmt(value,id);"></td>
  </tr>
  <tr>
    <td align="right"><label class="branch">Insured From Date</label></td>
    <td><div id="insurfromdate" name="insurfromdate"></div></td>
  </tr>
  <tr>
    <td align="right"><label class="branch">Insured To Date</label></td>
    <td><div id="insurtodate" name="insurtodate"></div></td>
  </tr>
   </table>
</fieldset>
<fieldset id="multiplediv"><legend><label class="branch">Invoice Posting</label></legend>
   <table width="100%" border="0">
  <tr>
    <td width="44%" align="right"><label class="branch">Account</label></td>
    <td width="56%"><input type="text" name="multiplevendor" id="multiplevendor" readonly placeholder="Press F3 to Search" style="height:18px;"></td>
	<input type="hidden" name="multiplehidvendor" id="multiplehidvendor">
	<input type="hidden" name="multiplevendoracno" id="multiplevendoracno">
  </tr>
  <tr>
    <td align="right"><label class="branch">Enter Percentage</label></td>
    <td><input type="text" name="percentage" id="percentage"  style="height:18px;"></td>
  </tr>
  <tr>
    <td align="right"><label class="branch">Insur Uptodate</label></td>
    <td><div id="insuruptodate" name="insuruptodate"></div></td>
  </tr>
  <tr>
    <td align="right"><label class="branch">Post Date</label></td>
    <td><div id="postdate" name="postdate"></div></td>
  </tr>
   </table>
</fieldset>
   </td>
 </tr>
<tr>
    <td colspan="2" align="center"><button type="button" name="btnpost" id="btnpost" class="myButton" onclick="funPost();">Save</button></td>
    </tr>
 <tr >
	<td colspan="2" style="border-top:2px solid #DCDDDE;">
	<div style="text-align:center;">
	<input type="button" name="btnclear" id="btnclear" value="Clear" class="myButton" onclick="funClearData();">
	</div>
    </td>
	</tr>
<tr ><td colspan="2"><!-- <textarea id="agmtdetails" name="agmtdetails" readonly style="resize:none;" rows="10" cols="35"></textarea> -->
</td></tr>

<tr colspan="2"><td>&nbsp;<br><br></td></tr>
	
		
	</table>
	</fieldset>
</td>
<td width="77%">
	<table width="100%">
		<tr>
			 <td><div id="vehicleinsurdiv"><jsp:include page="vehicleInsurGrid.jsp"></jsp:include></div>
			 <div id="multiplevehicleinsurdiv"><jsp:include page="multipleVehicleInsurGrid.jsp"></jsp:include></div>
			 	<div id="insurhistorydiv" hidden="true"><jsp:include page="insurHistoryGrid.jsp"></jsp:include></div>
			 </td>
			  <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
			  <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
		
		</tr>
	</table>
</tr>
</table>
</div>
<div id="vendorwindow">
<div></div>
</div>
</div>
</form>
</body>
</html>