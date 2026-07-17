
<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>

<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 
<script type="text/javascript">

$(document).ready(function () {
 
	 $("#nonrevenuedate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
    
    
});


function funreload(event)
{

	 var barchval = document.getElementById("cmbbranch").value;
	 var exdate = $('#nonrevenuedate').val();
 
	  $("#nondiv").load("nonrevenueGrid.jsp?barchval="+barchval+'&exdate='+exdate);
	
	
	}
	
function funExportBtn(){
	  //$("#nonmovement").jqxGrid('exportdata', 'xls', 'Non Revenue Movement');
	   
	   
	   if(parseInt(window.parent.chkexportdata.value)=="1")
	    {
	    JSONToCSVCon(expdatass, 'Non Revenue Movement', true);
	    }
	   else
	    {
	    $("#insexpgrid").jqxGrid('exportdata', 'xls', 'Non Revenue Movement');
	    }
	   
	   
	   
	   
	 }



</script>
</head>
<body onload="getBranch();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%"  >
	<jsp:include page="../../heading.jsp"></jsp:include>
		
	 <tr><td colspan="2">&nbsp;</td></tr>
	  <tr>
	<td align="right"><label class="branch">Up To</label></td>
            <td align="left"><div id="nonrevenuedate" name="nonrevenuedate" value='<s:property value="nonrevenuedate"/>'></div></td>
	</tr> 
	 <tr><td colspan="2">&nbsp;</td></tr> 
 <tr><td colspan="2">&nbsp;</td></tr> 
 <tr><td colspan="2">&nbsp;</td></tr> 
 <tr><td colspan="2">&nbsp;</td></tr> 
 <tr><td colspan="2">&nbsp;</td></tr> 
 <tr><td colspan="2">&nbsp;</td></tr> 

<!--  <tr><td colspan="2">&nbsp;</td></tr -->

	<tr>
	<td colspan="2"><div id='pieChart1' style="width: 100% ; align:right; height: 170px;"></div></td>
	</tr>	
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="nondiv"><jsp:include page="nonrevenueGrid.jsp"></jsp:include></div></td>
		</tr>
	</table>
</tr>
</table>

</div>
</div>
</body>
</html>