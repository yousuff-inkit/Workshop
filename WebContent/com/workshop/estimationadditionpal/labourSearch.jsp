
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
	var jobtypename=$('#searchjobtypename').val();
	var gatedocno=$('#gatedocno').val();
	$('#laboursearchdiv').load('labourSearchGrid.jsp?jobdocno='+jobdocno+'&date='+date+'&jobtype='+jobtype.replace(/ /g, "%20")+'&jobtypename='+jobtypename.replace(/ /g, "%20")+'&id=1&labourindex='+labourindex+'&gatedocno='+gatedocno);
});
});


</script>
</head>	
<body>
	<table width="100%" border="0">
  		<tr>
  			<td>Job Type</td>
			<td><input type="text" name="searchjobtypename" id="searchjobtypename"></td>
            <td width="10%" align="right">Doc No</td>
            <td width="19%"><input type="text" name="searchjobdocno" id="searchjobdocno"></td>
            <td width="9%" align="right">Date</td>
            <td width="19%"><div id="searchjobdate"></div></td>
  		</tr>
 		<tr>
 			<td width="8%" align="right">Job Desc</td>
            <td width="19%" colspan="4"><input type="text" name="searchjobtype" id="searchjobtype" style="width:99%;"></td>
            <td width="16%" align="center"><input type="button" name="btnjobsearch" id="btnjobsearch" value="Search" class="myButton"></td>
 		</tr> 
 		 
  		<tr>
  		  <td colspan="6" align="right"><div id="laboursearchdiv"><jsp:include page="labourSearchGrid.jsp"></jsp:include></div></td>
	  </tr>
	</table>
</body>
</html>