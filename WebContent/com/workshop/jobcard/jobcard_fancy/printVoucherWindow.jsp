 <%@ taglib prefix="s" uri="/struts-tags" %>
 <% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<jsp:include page="../../../includes.jsp"></jsp:include>
<title>GatewayERP(i)</title>
<link rel="stylesheet" href="../../../css/body.css">
<script type="text/javascript">
$(document).ready(function(){
	$('#btnjobcardprint').click(function(){
		var url=document.URL;
		 var reurl=url.split("printVoucherWindow.jsp");
		 var docno='<%=request.getParameter("docno")%>'; 
		 var addition=$('#cmbprintaddition').val();
		// alert(reurl[0]+"WSJobCardPrintFancyAction.action");
	   var win= window.open(reurl[0]+"WSJobCardPrintFancyAction.action?docno="+docno+"&addition="+addition,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
	   win.focus();
	   win_voucher.close();

	});
	
});
	
</script>

<body >
<div id=search style="position:absolute;top:50%;left:50%;transform:translate(-50%,-50%);">

<table width="100%">
  <tr>
  	<td>Choose Addition</td>
  	<td>
  		<select id="cmbprintaddition" name="cmbprintaddition">
  			<option value="All">All</option>
  			<option value="0">Main</option>
  			<option value="1">1</option>
  			<option value="2">2</option>
  			<option value="3">3</option>
  			<option value="4">4</option>
  			<option value="5">5</option>
  			<option value="6">6</option>
  			<option value="7">7</option>
  			<option value="8">8</option>
  			<option value="9">9</option>
  			<option value="10">10</option>
  		</select>
  	</td>
  	<td><button type="button" id="btnjobcardprint" class="myButton">Print</button></td>
  </tr>
 </table>
</div>
</body>
</html>