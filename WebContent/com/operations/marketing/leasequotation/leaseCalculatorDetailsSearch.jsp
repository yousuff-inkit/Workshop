<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<style>
body{
background: #E0ECF8 !important;
}
</style>
<script>
	$(document).ready(function(e) {
		$("#leasecalcdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null});    
	});

	function loadsearchcalc(){
		
		var date=$('#leasecalcdate').jqxDateTimeInput('val');
		var docno=document.getElementById("leasecalcdocno").value;
		var leasecalcreqdocno=document.getElementById("leasecalcdocno").value;
		var leasecalcclient=document.getElementById("leasecalcclient").value;
		var leasecalcmobile=document.getElementById("leasecalcmobile").value;
		
		$('#refreshdiv').load('leaseCalculatorDetailsSearchGrid.jsp?docno='+docno+'&leasecalcreqdocno='+leasecalcreqdocno+'&date='+date+'&client='+leasecalcclient+'&mobile='+leasecalcmobile+'&id=1');
	}
	
</script>

</head>
<body>
<div id=search>
<table width="100%">
  <tr>
    <td width="8%" align="right">Date</td>
    <td width="25%" align="left"><div id="leasecalcdate"></div></td>
    <td width="15%" align="right">Lease Req Doc</td>
    <td width="18%" align="left"><input type="text" name="leasecalcreqdocno" id="leasecalcreqdocno"></td>
    <td width="15%" align="right">Doc No</td>
    <td width="19%" align="left"><input type="text" name="leasecalcdocno" id="leasecalcdocno"></td>
  </tr>
  <tr>
    <td align="right">Client</td>
    <td><input type="text" name="leasecalcclient" id="leasecalcclient"></td>
    <td align="right">Mobile</td>
    <td align="left"><input type="text" name="leasecalcmobile" id="leasecalcmobile"></td>
    <td>&nbsp;</td>
    <td><button type="button" name="btnleasecalcsearch" id="btnleasecalcsearch" onclick="loadsearchcalc();" class="myButton">Search</button></td>
  </tr>
  <tr>
    <td colspan="6"><div id="refreshdiv"><jsp:include page="lqtMainSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
</div>
</body>
</html>