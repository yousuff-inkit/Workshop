
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<script type="text/javascript">
$(document).ready(function() {
	$("#searchgatedate").jqxDateTimeInput({  width:'125px',height : '15px', formatString : "dd.MM.yyyy",value:null});
	$('#btnsearchdoc').click(function(){
		var gatedocno=$('#searchgatedocno').val();
		var jobdocno=$('#jobsearchjobdocno').val();
		var date=$('#searchgatedate').jqxDateTimeInput('val');
		var cldocno=$('#searchcldocno').val();
		var clientname=$('#searchclientname').val();
		var brhid=$('#brchName').val();
		$('#gateinpassdiv').load('gateInPassSearchGrid.jsp?gatedocno='+gatedocno+'&jobdocno='+jobdocno+'&date='+date+'&cldocno='+cldocno+'&clientname='+clientname+'&id=1&brhid='+brhid);
	});
});


</script>
</head>	
<body>
	<table width="100%" border="0">
  		<tr>
            <td width="11%" align="right">Doc No</td>
            <td width="20%"><input type="text" name="jobsearchjobdocno" id="jobsearchjobdocno"></td>
            <td width="20%" align="right">GIP No</td>
            <td width="29%"><input type="text" name="searchgatedocno" id="searchgatedocno"></td>
            <td width="7%" align="right">Date</td>
            <td width="13%"><div id="searchgatedate" name="searchgatedate"></div></td>
  		</tr>
  		<tr>
            <td align="right">Client</td>
            <td><input type="text" name="searchcldocno" id="searchcldocno" placeholder="Client Doc No"></td>
            <td colspan="3"><input type="text" name="searchclientname" id="searchclientname" placeholder="Client Name" style="width:100%;"></td>
            <td align="center"><button type="button" name="btnsearchdoc" id="btnsearchdoc" class="myButton">Search</button></td>
  		</tr>
  		<tr>
    		<td colspan="6"><div id="gateinpassdiv"><jsp:include page="gateInPassSearchGrid.jsp"></jsp:include></div></td>
    	</tr>
	</table>
</body>
</html>