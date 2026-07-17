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
.myButtons {
	display: inline-block;
	margin-right:4px;
	margin-left:4px; 
  margin-bottom: 0;
  font-weight: normal;
  line-height: 1.3;
  text-align: center;
  white-space: nowrap;
  vertical-align: middle;
  -ms-touch-action: manipulation;
      touch-action: manipulation;
  cursor: pointer;
  -webkit-user-select: none;
     -moz-user-select: none;
      -ms-user-select: none;
          user-select: none;
  background-image: none;
  border: 1px solid transparent;
  border-radius: 4px;
  color: #fff;
  background-color: grey;
}
.myButtons:hover {
	  color: #fff;
  background-color: #31b0d5;
  
}
.myButtons:active {
  color: #fff;
  background-color: #31b0d5;
  
}
.myButtons:focus {
  color: #fff;
  background-color: grey;
}
 
select{
    height:15px;
}
 input[type="text"] {
  	width:'40%';
    height:20px !important;
    font-size:10px;
}
</style>

<script type="text/javascript">

$(document).ready(function () {
		document.getElementById("branchlabel").style.display="none";
		document.getElementById("branchdiv").style.display="none";
		   $("#btnExcel").click(function() {
				JSONToCSVCon(nrmexceldata, 'Movement List', true);
				//$("#vehiclelist").jqxGrid('exportdata', 'xls', 'vehiclelist');
			});
		$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:210px;right:525px;'><img src='../../../../icons/31load.gif'/></div>");
	    $('#fleetwindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '80%' ,maxWidth: '50%' , title: 'Fleet Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		$('#fleetwindow').jqxWindow('close');
		$('#employeewindow').jqxWindow({ width: '50%', height: '50%',  maxHeight: '50%' ,maxWidth: '50%' , title: 'Employee Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		$('#employeewindow').jqxWindow('close');
		$('#garagewindow').jqxWindow({ width: '50%', height: '50%',  maxHeight: '50%' ,maxWidth: '50%' , title: 'Garage Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		$('#garagewindow').jqxWindow('close');
	 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
	    var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
	    $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate);
	
	    
	    $('#fleet').dblclick(function(){
		
			 $('#fleetwindow').jqxWindow('open');
				$('#fleetwindow').jqxWindow('focus');
				 fleetSearchContent('masterFleetSearch.jsp');
			});
	    $('#employee').dblclick(function(){
			if(document.getElementById("cmbemptype").value==""){
				$.messager.alert('Warning','Please Select Employee Type');
				return false;
			}
			 $('#employeewindow').jqxWindow('open');
				$('#employeewindow').jqxWindow('focus');
				 employeeSearchContent('employeeSearch.jsp?emptype='+document.getElementById("cmbemptype").value);
			});
	    $('#garage').dblclick(function(){
			
			 $('#garagewindow').jqxWindow('open');
				$('#garagewindow').jqxWindow('focus');
				 garageSearchContent('garageSearch.jsp');
			});
	    
	    
	    
});


function getFleet(event){
	var x= event.keyCode;
	if(x==114){
		
		 $('#fleetwindow').jqxWindow('open');
			$('#fleetwindow').jqxWindow('focus');
			 fleetSearchContent('masterFleetSearch.jsp');			 
	}
}
function getEmployee(event){
	if(document.getElementById("cmbemptype").value==""){
		$.messager.alert('Warning','Please Select Employee Type');
		return false;
	}
	var x= event.keyCode;
	if(x==114){
		
		 $('#employeewindow').jqxWindow('open');
			$('#employeewindow').jqxWindow('focus');
			employeeSearchContent('employeeSearch.jsp?emptype='+document.getElementById("cmbemptype").value);			 
	}
}

function getGarage(event){
	var x= event.keyCode;
	if(x==114){
		
		 $('#garagewindow').jqxWindow('open');
			$('#garagewindow').jqxWindow('focus');
			 garageSearchContent('garageSearch.jsp');			 
	}
}


function fleetSearchContent(url) {
    $.get(url).done(function (data) {
    	$('#fleetwindow').jqxWindow('setContent', data);
	}); 
}
function employeeSearchContent(url) {
   $.get(url).done(function (data) {
   		$('#employeewindow').jqxWindow('setContent', data);
	}); 
}
function garageSearchContent(url) {
    $.get(url).done(function (data) {
    	$('#garagewindow').jqxWindow('setContent', data);
	}); 
}
function funreload(event)
{
    var fromdate=$('#fromdate').jqxDateTimeInput('val');
    var todate=$('#todate').jqxDateTimeInput('val');
    $("#overlay, #PleaseWait").show();
    var fleet=document.getElementById("fleet").value;
    var movtype=document.getElementById("cmbtype").value;
    var emptype=document.getElementById("cmbemptype").value;
    var employee=document.getElementById("hidemployee").value;
    var garage=document.getElementById("hidgarage").value;
    var status=document.getElementById("cmbstatus").value;
   	$("#nrmdiv").load("nrmListGrid.jsp?fromdate="+fromdate+"&todate="+todate+"&fleet="+fleet+"&movtype="+movtype+"&emptype="+emptype+"&employee="+employee+"&garage="+garage+"&status="+status+"&id=1");
   	
}
	
	function getCmbtype(){
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText.trim();
				items = items.split('***');
				
				var typeIdItems  = items[1].split(",");
				var typeItems = items[0].split(",");
				var optionsbranch = '<option value="">--Select--</option>';
				for (var i = 0; i < typeItems.length;i++){
					optionsbranch += '<option value="' + typeIdItems[i]+ '">'
							+ typeItems[i] + '</option>';
				}
				$("select#cmbtype").html(optionsbranch);

			} else {

			}
		}
		x.open("GET","getCmbtype.jsp", true);
		x.send();
	}

	function setValues(){

		 if($('#msg').val()!=""){
   		   $.messager.alert('Message',$('#msg').val());
   		  }
		getCmbtype();
	}
	function funExportBtn(){

	}
	
		
	
	function funClearData(){
		$('input[type=text],[type=hidden]').val('');
		$('select').find('option').prop("selected", false);
		$('#fromdate').jqxDateTimeInput('setDate',new Date());
		$('#todate').jqxDateTimeInput('setDate',new Date());
		var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
	    var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
	    $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate); 
	
	}

	</script>
	
</head>
<body onload="setValues();">
<form id="frmNrmList" method="post">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%">
<tr>
<td width="20%" align="center">
    <fieldset style="background: #ECF8E0;">
	<table width="100%">
	<jsp:include page="../../heading.jsp"></jsp:include>

 <tr>
   <td width="23%" align="right"><label class="branch">From Date</label></td><td width="63%"><div id="fromdate"></div></td></tr>
 <tr>
   <td align="right"><label class="branch">To Date</label></td>
   <td><div id="todate"></div></td>
 </tr>
 <tr>
   <td align="right"><label class="branch">Fleet</label></td>
   <td><input type="text" name="fleet" id="fleet" readonly placeholder="Press F3 to Search"></td>
 </tr>
 <tr>
   <td align="right"><label class="branch">Type</label></td>
   <td><select name="cmbtype" id="cmbtype" style="width:72%;"><option value="">--Select--</option></select></td>
 </tr>
 <tr>
   <td align="right"><label class="branch">Emp Type</label></td>
   <td><select name="cmbemptype" id="cmbemptype" style="width:72%;"><option value="">--Select--</option><option value="stf">Staff</option><option value="drv">Driver</option></select></td>
 </tr>
 <tr>
   <td align="right"><label class="branch">Employee</label></td>
   <td><input type="text" name="employee" id="employee" readonly placeholder="Press F3 to Search"></td>
 	<input type="hidden" name="hidemployee" id="hidemployee">
 </tr>
 <tr>
   <td align="right"><label class="branch">Garage</label></td>
   <td><input type="text" name="garage" id="garage" readonly placeholder="Press F3 to Search"></td>
   <input type="hidden" name="hidgarage" id="hidgarage">
 </tr>
 <tr>
   <td align="right"><label class="branch">Mov status</label></td>
   <td><select name="cmbstatus" id="cmbstatus" style="width:72%;"><option value="">--Select--</option><option value="0">Open</option><option value="1">Closed</option></select></td>
   <input type="hidden" name="hidgarage" id="hidgarage">
 </tr>
 <tr>
	<td colspan="2" style="border-top:2px solid #DCDDDE;">
	<div style="text-align:center;">
	<input type="button" name="btnclear" id="btnclear" value="Clear" class="myButtons" onclick="funClearData();">
	</div>
    </td>
	</tr>
<tr ><td colspan="2"><!-- <textarea id="agmtdetails" name="agmtdetails" readonly style="resize:none;" rows="10" cols="35"></textarea> -->
	<br><br><br><br><br><br><br><br><br><br><br>

</td></tr>

<tr colspan="2"><td>&nbsp;</td></tr>
	
		
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="nrmdiv"><jsp:include page="nrmListGrid.jsp"></jsp:include></div></td>
			  <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
			  <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
		
		</tr>
	</table>
</tr>
</table>
</div>
<div id="fleetwindow">
<div></div>
</div>
<div id="employeewindow">
<div></div>
</div>
<div id="garagewindow">
<div></div>
</div>
</div>
</form>
</body>
</html>