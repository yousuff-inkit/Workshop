 <%@ taglib prefix="s" uri="/struts-tags" %>
 <% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
<title>GatewayERP(i)</title>

	<script type="text/javascript">
	$(document).ready(function () {
	 $("#refunddate").jqxDateTimeInput({ width: '110px', height: '15px',formatString:"dd.MM.yyyy",value:null});
	}); 

 	function loadSearch() {

 		var accountName=document.getElementById("txtaccountname").value;
 		var srNo=document.getElementById("txtdocumentsrno").value;
 		var date=document.getElementById("refunddate").value;
 		var total=document.getElementById("txtamounttotal").value;
 		var refNo=document.getElementById("txtreferenceno").value;
	
		getdata(accountName,srNo,date,total,refNo);
	}
	function getdata(accountName,srNo,date,total,refNo){
		 $("#refreshdiv").load('rrpMainSearchGrid.jsp?accountName='+accountName.replace(/ /g, "%20")+'&srNo='+srNo+'&date='+date+'&total='+total+'&refNo='+refNo);
		}

	</script>
<body>
<div id=search>
<table width="100%">
  <tr>
    <td width="7%" align="right">RR No</td>
    <td width="19%"><input type="text" name="txtdocumentsrno" id="txtdocumentsrno" autocomplete="off" value='<s:property value="txtdocumentsrno"/>'></td>
    <td width="10%" align="right">A/C Name</td>
    <td colspan="3"><input type="text" name="txtaccountname" id="txtaccountname" autocomplete="off" style="width:80%" value='<s:property value="txtaccountname"/>'></td>
    <td width="13%" align="center"><input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search"  onclick="loadSearch();"></td>
  </tr>
  <tr>
    <td align="right">Date</td>
    <td><div id="refunddate" name="refunddate"  value='<s:property value="refunddate"/>'></div>
        <input type="hidden" name="hidrefunddate" id="hidrefunddate" value='<s:property value="hidrefunddate"/>'></td>
    <td align="right">Total</td>
    <td width="23%"><input type="text" name="txtamounttotal" id="txtamounttotal" autocomplete="off" value='<s:property value="txtamounttotal"/>'></td>
    <td width="6%" align="right">Ref. No</td>
    <td colspan="2"><input type="text" id="txtreferenceno" name="txtreferenceno" autocomplete="off" value='<s:property value="txtreferenceno"/>'></td>
  </tr>
  <tr>
    <td colspan="7"><div id="refreshdiv"><jsp:include  page="rrpMainSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
</div>
</body>
</html>