
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
	
	// $("#insuexpdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
 

   
});


function funExportBtn(){
	   $("#jqxfleetsearch").jqxGrid('exportdata', 'xls', 'Availability List');
	 }

 
function funreload(event)
{
	 var barchval = document.getElementById("cmbbranch").value;
	/*  var exdate = $('#insuexpdate').val();
  */
  
     var chk="load";  
	  $("#insuexp").load("listgrid.jsp?chk="+chk+"&barchval="+barchval);
	
	
	}


 

</script>
</head>
<body onload="getBranch(); ">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%"  >
	<jsp:include page="../heading.jsp"></jsp:include>
		
	 <tr><td colspan="2">&nbsp;</td></tr>
 
<%-- 	<td align="right"><label class="branch">Up To</label></td>
            <td align="left"><div id="insuexpdate" name="insuexpdate" value='<s:property value="insuexpdate"/>'></div></td> --%>

	   <tr><td colspan="2">&nbsp;</td></tr> 
 <tr><td colspan="2">&nbsp;</td></tr> 
 <tr><td colspan="2">&nbsp;</td></tr> 
 <tr >
 
 <td style="background-color: #ACF6CB;" width="5%" ></td> <td align="left"><label class="branch">&nbsp;&nbsp;Available</label></td>	</tr>
  <tr>
 <tr><td colspan="2">&nbsp;</td></tr> 
 <tr><td style="background-color: #ff6347;" width="5%"></td> <td align="left"><label class="branch">&nbsp;&nbsp;Not Available</label></td>	</tr>
   <tr><td colspan="2">&nbsp;</td></tr> 
  <tr   >

 <td style="background-color: #eedd82;" width="5%"></td> <td align="left"><label class="branch">&nbsp;&nbsp;Due Date Expired</label></td>	</tr>
 
 
 

 <tr><td colspan="2">&nbsp;</td></tr> 
 <tr><td colspan="2">&nbsp;</td></tr> 
	<tr>
	<td colspan="2"><div id='pieChart1' style="width: 100% ; align:right; height: 170px;"></div></td>
	</tr>	
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="insuexp"><jsp:include page="listgrid.jsp"></jsp:include></div></td>
		</tr>
	</table>
</tr>
</table>
</div>
	 <div id="invcomSearchwindow">
	   <div></div>
	</div> 
	
</div>
</body>
</html>