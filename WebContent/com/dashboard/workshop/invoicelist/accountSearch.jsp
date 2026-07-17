 <%@ taglib prefix="s" uri="/struts-tags" %>
 <% String contextPath=request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
<title>GatewayERP(i)</title>

<style type="text/css">
#search {
    background-color: #E0ECF8;
}
</style>

	<script type="text/javascript">
	
	$(document).ready(function () {}); 

 	function loadSearch() {
 		var type=document.getElementById("cmbaccounttype").value;
 		var clientsname=document.getElementById("txtclientsname").value;
 		var docno=document.getElementById("txtdocno").value;
 		
		getAccountData(clientsname,docno,type);
	}
 	
	function getAccountData(clientsname,docno,type){
		clientsname=clientsname.replace(/ /g, "%20");
		$('#accountsearchgriddiv').load('accountSearchGrid.jsp?type='+type+'&clientname='+clientsname+'&docno='+docno+'&id=1');
	}

	</script>
<body>
<div id=search>
<table width="100%">
  <tr>
    
    <td width="10%" align="right" style="font-size:9px;">Account #</td>
    <td width="20%"><input type="text" name="txtdocno" id="txtdocno" style="width:90%;height:20px;" value='<s:property value="txtdocno"/>'></td>
    <td width="8%" align="right" style="font-size:9px;">Account Name</td>
    <td width="43%" ><input type="text" name="txtclientsname" id="txtclientsname" style="width:100%;height:20px;" value='<s:property value="txtclientsname"/>'></td>
   	<td width="10%" align="right"  style="font-size:9px;">Type</td>
   	<td width="10%"><select name="cmbaccounttype" id="cmbaccounttype">
   			<option value="">--Select--</option>
   			<option value="1">Client</option>
   			<option value="2">Insur.Company</option>
   		</select>
   	</td>
  <td width="9%" align="center"><input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search"  onclick="loadSearch();"></td>
   </tr>
  <tr>
    <td colspan="7"><div id="accountsearchgriddiv"><jsp:include page="accountSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
  </div>
</body>
</html>