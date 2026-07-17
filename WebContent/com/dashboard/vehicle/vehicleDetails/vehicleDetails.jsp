
<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>

<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 
<style type="text/css">

       .icon {
   width: 2.5em;
   height: 3em;
   border: none;
   background-color: #E0ECF8;
  }
</style>
<script type="text/javascript">
$(document).ready(function () {
	$("#excelExport").click(function() {
		//alert("1");
		$("#vehicledetails").jqxGrid('exportdata', 'xls', 'vehicledetails');
	});
});




</script>
</head>
<body>
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<%-- <button type="button" class="icon" id="excelExport"  title="Export current Document to Excel">
 <img alt="excelDocument" src="<%=contextPath%>/icons/excel_new.png">
</button>
 --%>	<table width="100%">
		<tr>
			 <td><div id="fleetdiv"><jsp:include page="vehicleDetailsgrid.jsp"></jsp:include></div></td>
		</tr>
	</table>

</div>
</div>
</body>
</html>