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
	 getTransferBranch();
	 var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
	 var onemounth=new Date(new Date(fromdates).setMonth(fromdates.getMonth()-1)); 
     $('#fromdate').jqxDateTimeInput('setDate', new Date(onemounth));
});

function funreload(event)
{
	var branch=document.getElementById("cmbbranch").value;
	var fromdate=$('#fromdate').jqxDateTimeInput('val');
	var todate=$('#todate').jqxDateTimeInput('val');
	var transferbranch=document.getElementById("cmbtransferbranch").value;
	$('#jobtransferdiv').load('jobTransferGrid.jsp?branch='+branch+'&fromdate='+fromdate+'&todate='+todate+'&transferbranch='+transferbranch+'&id=1');
	}
	
function getTransferBranch() {
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			items = x.responseText;
			items = items.split('####');
			var branchItems = items[1].split(",");
			var branchidItems = items[0].split(",");
			var optionsbranch = '<option value="">--Select--</option>';
			for (var i = 0; i < branchItems.length; i++) {
				optionsbranch += '<option value="' + branchidItems[i] + '">'
						+ branchItems[i] + '</option>';
			}
			$("select#cmbtransferbranch").html(optionsbranch);
			} else {
		}
	}
	x.open("GET", "getTransferBranch.jsp", true);
	x.send();
}
function funExportBtn(){
	JSONToCSVCon(Jobtransferexcel, 'Job Transfer', true);
	 }	
function setValues(){

	 if($('#msg').val()!=""){
		 $.messager.alert('Message','<center>'+$('#msg').val()+'</center>');
	}
	 
}


</script>
</head>
<body onload="getBranch();setValues();">
<form id="frmLimoVehicleUpdate" action="saveLimoVehicleUpdate" method="post">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%">
<tr>
<td width="20%" rowspan="2">
    <fieldset style="background: #ECF8E0;">
	<table width="100%">
	<jsp:include page="../../heading.jsp"></jsp:include>

 <tr>
 <td width="41%" align="right"><label class="branch">From Date</label></td>
 <td colspan="2" ><div id="fromdate" name="fromdate"></div></td>
 </tr>
 <tr>
   <td align="right"><label class="branch">To Date</label></td>
   <td><div id="todate" name="todate"></div></td>
 </tr>
 
 <tr>
   <td align="right"><label class="branch">Current Branch</label></td>
   <td><select name="cmbtransferbranch" id="cmbtransferbranch" style="width:95%;"><option value="">--Select--</option></select></td>
 </tr>
 <tr>
   <td align="right">&nbsp;</td>
   <td>&nbsp;</td>
 </tr>
 <tr>
   <td align="right">&nbsp;</td>
   <td>&nbsp;</td>
 </tr>
 <tr>
   <td align="right">&nbsp;</td>
   <td>&nbsp;</td>
 </tr>
 <tr>
   <td align="right">&nbsp;</td>
   <td>&nbsp;</td>
 </tr>
 <tr>
   <td align="right">&nbsp;</td>
   <td>&nbsp;</td>
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
   <td colspan="2" align="center"><br><br><br><br><br><br><br></td>
   </tr>
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td rowspan="2"><div id="jobtransferdiv"><jsp:include page="jobTransferGrid.jsp"></jsp:include></div></td>
		</tr>
	</table>
</tr>
</table>
</div>
<input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
<input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
</div>
</form>
</body>
</html>