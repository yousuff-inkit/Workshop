<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<style>
.dfont{
	font-size:12px;
	font-family: Tahoma;
}
</style>
<script>
$(document).ready(function() {
	$("#searchclientdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null});
    $('#btnclientsearch').click(function(e) {
        var cldocno=$('#searchclientdocno').val();
		var clientname=$('#searchclientname').val();
		var clientmobile=$('#searchclientmobile').val();
		var clientmail=$('#searchclientmail').val();
		var clientdate=$('#searchclientdate').jqxDateTimeInput('val');
		$('#clientsearchdiv').load('clientSearchGrid.jsp?cldocno='+cldocno+'&clientname='+clientname+'&clientmobile='+clientmobile+'&clientmail='+clientmail+'&id=1&clientdate='+clientdate);
    });
});
</script>
</head>
<body>
<table width="100%" border="0">
  <tr>
    <td width="13%" align="right"><span class="dfont">Doc No</span></td>
    <td width="15%"><input type="text" name="searchclientdocno" id="searchclientdocno" style="height:18px;"></td>
    <td width="11%" align="right"><span class="dfont">Name</span></td>
    <td colspan="4"><input type="text" name="searchclientname" id="searchclientname" style="height:18px;width:100%;"></td>
  </tr>
  <tr>
    <td align="right"><span class="dfont">Mobile</span></td>
    <td><input type="text" name="searchclientmobile" id="searchclientmobile" style="height:18px;"></td>
    <td align="right"><span class="dfont">Email</span></td>
    <td width="16%"><input type="text" name="searchclientmail" id="searchclientmail" style="height:18px;"></td>
    <td width="12%" align="right"><span class="dfont">Date</span></td>
    <td width="22%"><div id="searchclientdate"></div></td>
    <td width="11%" align="center"><button type="button" name="btnclientsearch" id="btnclientsearch" class="myButton" onClick="funSearchClients();">Search</button></td>
  </tr>
  <tr>
    <td colspan="7"><div id="clientsearchdiv"><jsp:include page="clientSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>

</body>
</html>