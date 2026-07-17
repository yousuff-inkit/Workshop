
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<script type="text/javascript">
$(document).ready(function() {
$("#searchjobdate").jqxDateTimeInput({  width:'125px',height : '15px', formatString : "dd.MM.yyyy",value:null});
$('#btnjobsearch').click(function(){
	var labourindex='<%=request.getParameter("labourindex")==null?"":request.getParameter("labourindex")%>';
	var jobdocno=$('#searchjobdocno').val();
	var date=$('#searchjobdate').jqxDateTimeInput('val');
	var jobtype=$('#searchjobtype').val();
	$('#laboursearchdiv').load('labourSearchGrid.jsp?jobdocno='+jobdocno+'&date='+date+'&jobtype='+jobtype+'&id=1&labourindex='+labourindex);
});
});


</script>
</head>	
<body>
	<table width="100%" border="0">
  		<tr>
            <td width="10%" align="right">Doc No</td>
            <td width="19%"><input type="text" name="searchjobdocno" id="searchjobdocno"></td>
            <td width="9%" align="right">Date</td>
            <td width="19%"><div id="searchjobdate"></div></td>
            <td width="8%" align="right">Job Type</td>
            <td width="19%"><input type="text" name="searchjobtype" id="searchjobtype"></td>
            <td width="16%" align="center"><input type="button" name="btnjobsearch" id="btnjobsearch" value="Search" class="myButton"></td>
  		</tr>
  		<tr>
  		  <td colspan="7" align="right"><div id="laboursearchdiv"><jsp:include page="labourSearchGrid.jsp"></jsp:include></div></td>
	  </tr>
	</table>
</body>
</html>