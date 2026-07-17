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
	 $('#branchlabel,#branchdiv').hide();
	 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	$('#btndownload').click(function(){
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				items = x.responseText;
				items=items.trim();
				//alert(items);
				if(parseInt(items)>0){
					$('#docno').val(parseInt(items));
					$('#overlay,PleaseWait').show();
					$('#gpsdiv').load('gpsGrid.jsp?docno='+items+'&id=1');
				}
				else{
					$.messager.alert('Warning','Download Not Completed');
					return false;
				}
				} else {
			}
		}
		x.open("GET", "getXMLData.jsp", true);
		x.send();
		
	});
	
	$('#btnupdate').click(function(){
		var rows=$('#gpsGrid').jqxGrid('getrows');
		if(rows.length==0){
			$.messager.alert('Warning','Please Download Data');
			return false;
		}
		else{
			document.getElementById("mode").value="A";
			document.getElementById("frmGPS").submit();
		}
		
	});
});

function funreload(event)
{
	var fromdate=$('#fromdate').jqxDateTimeInput('val');
	var todate=$('#todate').jqxDateTimeInput('val');
	$('#gpsdiv').load('gpsGrid.jsp?id=1&fromdate='+fromdate+'&todate='+todate);
}
function funNotify(){

}
function setValues(){

	if($('#msg').val()!=""){
  		$.messager.alert('Message','<center>'+$('#msg').val()+'</center>');
  	}
	if($('#docno').val()!=''){
		$('#gpsdiv').load('gpsGrid.jsp?docno='+$('#docno').val()+'&id=1');		
	}
}
 function funExportBtn(){
	 
	 /* if(parseInt(window.parent.chkexportdata.value)=="1")
	  {
	  	JSONToCSVCon(damagedata, 'Damages', true);
	  }
	 else
	  {
		 $("#damageInvGrid").jqxGrid('exportdata', 'xls', 'Damages');
	  }
	   */
	  }
</script>
</head>
<body onload="getBranch();setValues();">
<form id="frmGPS" action="saveGPS">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%">
<tr>
<td width="20%">
    <fieldset style="background: #ECF8E0;">
	<table width="100%">
	<jsp:include page="../../heading.jsp"></jsp:include>
	
	<tr><td colspan="2">&nbsp;</td></tr>
    <tr>
	 <td align="right"><label class="branch">From</label></td>
     <td align="left"><div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div></td></tr> 
	<tr>
	<td align="right"><label class="branch">To</label></td>
    <td align="left"><div id="todate" name="todate" value='<s:property value="todate"/>'></div></td>
	</tr>
 
<tr><td><!-- <label class="branch">Client</label> --></td><td><%-- <input type="text" name="client" id="client" onkeydown="getClient(event);" readonly value='<s:property value="client"/>'> --%></td></tr> 
<!-- <input type="hidden" name="hidclient" id="hidclient" > -->
		 <tr>
	<td colspan="2"> <%-- <div id="Readygrid" ><jsp:include page="invnoGrid.jsp"></jsp:include>
	</div> --%> </td>
	</tr> 
	<tr>
	<td colspan="2"><center><input type="button" name="btndownload" id="btndownload" class="myButton" value="Download">&nbsp;&nbsp;<input type="button" name="btnupdate" id="btnupdate" class="myButton" value="Update"></center></td>
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
	  <td colspan="2">&nbsp;</td>
	  </tr>
	
	<tr>
	<td colspan="2"><br><br><br><br><br></td>
	</tr>	
	</table>
	</fieldset>
</td>
<td width="80%">
<div id="gpsdiv"><jsp:include page="gpsGrid.jsp"></jsp:include></div>
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