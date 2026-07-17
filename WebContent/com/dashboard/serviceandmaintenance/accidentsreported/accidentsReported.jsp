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
	 	
	
	  
});

function funreload(event)
{
	 var branchval = document.getElementById("cmbbranch").value;
	 $("#overlay, #PleaseWait").show();
	 $("#accidentsrepdiv").load("accidentsRepGrid.jsp?branchval="+branchval);
	
	}
	function funNotify(){
	
	    	
	}
	function setValues(){

		 if($('#msg').val()!=""){
   		   $.messager.alert('Message',$('#msg').val());
   		  }
		
	}
	 function funExportBtn(){
		 $("#accidentsRepGrid").jqxGrid('exportdata', 'xls', 'Damages');
	}
</script>
</head>
<body onload="getBranch();setValues();">
<form id="frmDashboardAccidentsReported" action="saveDashboardAccidentsReported">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%">
<tr>
<td width="20%">
    <fieldset style="background: #ECF8E0;">
	<table width="100%">
	<jsp:include page="../../heading.jsp"></jsp:include>
	
	<!--  <tr><td colspan="2">&nbsp;</td></tr> -->

<tr><td></td><td><%-- <input type="text" name="client" id="client" onkeydown="getClient(event);" readonly value='<s:property value="client"/>'> --%></td></tr> 
<!-- <input type="hidden" name="hidclient" id="hidclient" > -->
		 <tr>
	<td colspan="2"> <%-- <div id="Readygrid" ><jsp:include page="invnoGrid.jsp"></jsp:include>
	</div> --%> </td>
	</tr> 
	<tr>
	<td colspan="2"></td>
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
	  <td colspan="2">&nbsp;</td>
	  </tr>
	<tr>
	<td colspan="2"><br><br><br><br><br></td>
	</tr>	
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td> <div id="accidentsrepdiv"><jsp:include page="accidentsRepGrid.jsp"></jsp:include></div> </td>
			 <input type="hidden" name="gridlength" id="gridlength"  value='<s:property value="gridlength"/>'>
			  <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
			  <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
		</tr>
	</table>
</tr>
</table>
</div>

</div>
</form>
</body>
</html>