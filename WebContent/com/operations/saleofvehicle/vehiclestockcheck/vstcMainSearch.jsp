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
	 $("#stockdate").jqxDateTimeInput({ width: '110px', height: '15px',formatString:"dd.MM.yyyy",value:null});
	}); 

 	function loadSearch() {

 		var username=document.getElementById("txtusername").value;
 		var docNo=document.getElementById("txtdocno").value;
 		var date=document.getElementById("stockdate").value;
	
		getdata(username,docNo,date);
	}
	function getdata(username,docNo,date){
		 $("#refreshdiv").load('vstcMainSearchGrid.jsp?username='+username+'&docNo='+docNo+'&date='+date);
		}

	</script>
<body>
<div id=search>
<table width="100%">
  <tr>
    <td width="5%" align="right">Date</td>
    <td width="28%"><div id="stockdate" name="stockdate"  value='<s:property value="stockdate"/>'></div>
        <input type="hidden" name="hidpaydate" id="hidpaydate" value='<s:property value="hidpaydate"/>'></td>
    <td width="32%" align="right">Doc No</td>
    <td width="35%"><input type="text" name="txtdocno" id="txtdocno" value='<s:property value="txtdocno"/>'></td>
   
  </tr>
  <tr>
    <td align="right">Name</td>
    <td colspan="2"><input type="text" name="txtusername" id="txtusername" style="width:100%" value='<s:property value="txtusername"/>'></td>
     <td width="35%" align="center"><input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search"  onclick="loadSearch();"></td>
  </tr>
  <tr>
    <td colspan="4"><div id="refreshdiv"><jsp:include page="vstcMainSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
  </div>
</body>
</html>