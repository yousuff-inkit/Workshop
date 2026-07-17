<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>
<%
 String doc_no=request.getParameter("doc_no")==null?"":request.getParameter("doc_no");
 String brhid=request.getParameter("brhid")==null?"":request.getParameter("brhid");
%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
<title>GatewayERP(i)</title>

<script type="text/javascript">
	
	var doc_no=<%=doc_no%>;
	var brhid=<%=brhid%>; 
	
 	function printVoucher(header) {
 		var url=document.URL;
		
		var reurl=url.split("com/");
 		var win= window.open(reurl[0]+"com/finance/transactions/contratrans/printContraTrans?docno="+doc_no+"&branch="+brhid+"&header="+header,"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
	    win.focus();
	    $('#printWindow').jqxWindow('close');
 	}
 	
</script>

<body>
<div id=search>
<br/><br/><br/><br/><br/><br/>
<table width="100%">
  <tr>
    <td align="center"><input type="button" id="btnvoucherhead" class="myButton" value="With Header"  onclick="printVoucher(1);"></td>
    <td align="center"><input type="button" id="btnvoucherwithouthead" class="myButton" value="Without Header"  onclick="printVoucher(0);"></td>
  </tr>
</table>
<br/><br/><br/><br/><br/><br/>
  </div>
</body>
</html>