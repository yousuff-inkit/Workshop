
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<script type="text/javascript">
$(document).ready(function() {
$("#searchfleetdate").jqxDateTimeInput({  width:'125px',height : '15px', formatString : "dd.MM.yyyy",value:null});
$('#btnsearchfleet').click(function(){

	var fleetno=$('#searchfleetno').val();
	var regno=$('#searchfleetregno').val();
	var date=$('#searchfleetdate').jqxDateTimeInput('val');
	var fleetname=$('#searchfleetname').val();
	$('#searchfleetdiv').load('fleetSearchGrid.jsp?fleetno='+fleetno+'&regno='+regno+'&date='+date+'&fleetname='+fleetname+'&id=1');
});
});


</script>
</head>	
<body>
	<table width="100%" border="0">
  		<tr>
            <td align="right">Fleet No</td>
            <td><input type="text" name="searchfleetno" id="searchfleetno"></td>
            <td align="right">Reg No</td>
            <td><input type="text" name="searchfleetregno" id="searchfleetregno"></td>
            <td align="right">Date</td>
            <td><div id="searchfleetdate" name="searchfleetdate"></div></td>
  		</tr>
  		<tr>
            <td align="right">Fleet Name</td>
            <td colspan="4"><input type="text" name="searchfleetname" id="searchfleetname" style="width:99%;"></td>
            <td align="center"><button type="button" name="btnsearchfleet" id="btnsearchfleet" class="myButton">Search</button></td>
  		</tr>
  		<tr>
    		<td colspan="6"><div id="searchfleetdiv"><jsp:include page="fleetSearchGrid.jsp"></jsp:include></div></td>
    	</tr>
	</table>
</body>
</html>