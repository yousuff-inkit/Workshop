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
	 var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
	 var onemounth=new Date(new Date(fromdates).setMonth(fromdates.getMonth()-1)); 
     $('#fromdate').jqxDateTimeInput('setDate', new Date(onemounth));
	getStatus();
});


function getStatus(){
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			items = x.responseText;
			items = items.split('::');
			var statusItems = items[0].split(",");
			var statusidItems = items[1].split(",");
			var optionsstatus = '<option value="">--Select--</option>';
			for (var i = 0; i < statusItems.length; i++) {
				optionsstatus += '<option value="' + statusidItems[i] + '">'
						+ statusItems[i] + '</option>';
			}
			$("select#cmbstatus").html(optionsstatus);
			
		} else {
		}
	}
	x.open("GET", "getStatus.jsp", true);
	x.send();
}
function funExportBtn(){
	JSONToCSVCon(Jobstatusexcel, 'Job Status', true);
	 }
function funreload(event)
{
	var status=$('#cmbstatus').val();
	var fromdate=$('#fromdate').jqxDateTimeInput('val');
	var todate=$('#todate').jqxDateTimeInput('val');
	var branch=$('#cmbbranch').val();
	$('#jobstatuscountdiv').load('jobStatusCountGrid.jsp?status='+status+'&fromdate='+fromdate+'&todate='+todate+'&branch='+branch+'&id=1');
	// $('#jobstatusdiv').load('jobStatusGrid.jsp?status='+status+'&fromdate='+fromdate+'&todate='+todate+'&branch='+branch+'&id=1');
}

function setValues(){

	 if($('#msg').val()!=""){
		 $.messager.alert('Message','<center>'+$('#msg').val()+'</center>');
	}
	 
}
</script>
</head>
<body onload="getBranch();setValues();">
<form id="frmJobStatus" method="post">
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
   <td align="right"><label class="branch">Status</label></td>
   <td><select name="cmbstatus" id="cmbstatus" style="width:95%;">
   <option value="">--Select--</option>
   </select></td>
 </tr>
 <tr>
   <td align="right">&nbsp;</td>
   <td>&nbsp;</td>
 </tr>
 <tr>
   <td colspan="2" align="right"><div id="jobstatuscountdiv"><jsp:include page="jobStatusCountGrid.jsp"></jsp:include></div></td>
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
   <td colspan="2" align="center"><br><br></td>
   </tr>
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td rowspan="2"><div id="jobstatusdiv"><jsp:include page="jobStatusGrid.jsp"></jsp:include></div></td>
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