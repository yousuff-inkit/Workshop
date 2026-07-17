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
$("#searchdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null});    
$("body").css("background","#E0ECF8");
});
function loadsearch(){
	var date=$('#searchdate').jqxDateTimeInput('val');
	var docno=document.getElementById("searchdocno").value;
	var leasereqdocno=document.getElementById("searchreqdocno").value;
	var searchclient=document.getElementById("searchclient").value;
	var searchmobile=document.getElementById("searchmobile").value;
	$('#calcsearchdiv').load('leaseCalcSearch.jsp?docno='+docno+'&leasereqdocno='+leasereqdocno+'&date='+date+'&client='+searchclient+'&mobile='+searchmobile+'&id=1');
}
</script>

</head>
<body style="background-color:#E0ECF8;">
<table width="100%">
  <tr>
    <td width="8%" align="right">Date</td>
    <td width="25%" align="left"><div id="searchdate"></div></td>
    <td width="15%" align="right">Lease Req Doc No</td>
    <td width="18%" align="left"><input type="text" name="searchreqdocno" id="searchreqdocno"></td>
    <td width="15%" align="right">Doc No</td>
    <td width="19%" align="left"><input type="text" name="searchdocno" id="searchdocno"></td>
  </tr>
  <tr>
    <td align="right">Client</td>
    <td><input type="text" name="searchclient" id="searchclient"></td>
    <td align="right">Mobile</td>
    <td align="left"><input type="text" name="searchmobile" id="searchmobile"></td>
    <td>&nbsp;</td>
    <td><button type="button" name="btncalcsearch" id="btncalcsearch" onclick="loadsearch();" class="myButton">Search</button></td>
  </tr>
  <tr>
    <td colspan="6"><div id="calcsearchdiv"><jsp:include page="leaseCalcSearch.jsp"></jsp:include></div></td>
  </tr>
</table>
</body>
</html>