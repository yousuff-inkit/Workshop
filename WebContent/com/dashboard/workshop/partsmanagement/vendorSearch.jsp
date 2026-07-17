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

 		var vndname=document.getElementById("txtvndname").value;
 		var chk = 1;
 		
		getdata(vndname,chk);
	}
	function getdata(vndname,chk){
		 $("#vndSearchDiv").load('vendorSearchGrid.jsp?vndname='+vndname.replace(/ /g, "%20")+'&chk='+chk);
		}

	</script>
<body>
<div id=search>
<table width="100%">
  <tr>
    <td align="right" style="font-size:9px;">Name</td>
    <td colspan="2"><input type="text" name="txtvndname" id="txtvndname" style="width:100%;height:20px;" value='<s:property value="txtvndname"/>'>
    <td width="49%" align="center"><input type="button" name="btnsearchvnd id="btnsearchvnd" class="myButton" value="Search"  onclick="loadSearch();"></td>
  </tr>
  <tr>
    <td colspan="5"><div id="vndSearchDiv"><jsp:include page="vendorSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
  </div>
</body>
</html>