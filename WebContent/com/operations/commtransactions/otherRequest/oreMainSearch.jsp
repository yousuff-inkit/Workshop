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
	 		$("#requestdate").jqxDateTimeInput({ width: '110px', height: '15px',formatString:"dd.MM.yyyy",value:null});
	}); 

 	function loadSearch() {

 		var partyname=document.getElementById("txtpartyname").value;
 		var docNo=document.getElementById("txtdocno").value;
 		var date=document.getElementById("requestdate").value;
 		var raType=document.getElementById("cmbrenttype").value;
 		var raNo=document.getElementById("txtaggno").value;
	    var branch=document.getElementById("brchName").value;
	    
		getdata(partyname,docNo,date,raType,raNo,branch);
	}
	function getdata(partyname,docNo,date,raType,raNo,branch){
		 $("#refreshdiv").load('oreMainSearchGrid.jsp?partyname='+partyname.replace(/ /g, "%20")+'&docNo='+docNo+'&date='+date+'&raType='+raType+'&raNo='+raNo+'&branch='+branch);
		}

	</script>
<body>
<div id=search>
<table width="100%">
  <tr>
    <td width="6%" align="right">Date</td>
    <td width="17%"><div id="requestdate" name="requestdate"  value='<s:property value="requestdate"/>'></div>
        <input type="hidden" name="hidrequestdate" id="hidrequestdate" value='<s:property value="hidrequestdate"/>'></td>
    <td width="20%"  align="right">RA Type</td>
    <td width="14%"><select id="cmbrenttype" name="cmbrenttype" style="width:80%;" value='<s:property value="cmbrenttype"/>'>
      <option value="">--Select--</option><option value="RAG">Rental</option><option value="LAG">Lease</option></select>
      <input type="hidden" id="hidcmbrenttype" name="hidcmbrenttype" value='<s:property value="hidcmbrenttype"/>'/></td>
    <td width="21%" align="right">Agg. No.</td>
    <td width="22%"><input type="text" name="txtaggno" id="txtaggno" style="width:100%" value='<s:property value="txtaggno"/>'></td>
  </tr>
  <tr>
    <td align="right">Name</td>
    <td colspan="2"><input type="text" name="txtpartyname" id="txtpartyname" style="width:100%" value='<s:property value="txtpartyname"/>'></td>
    <td align="right">Doc No</td>
    <td><input type="text" id="txtdocno" name="txtdocno" style="width:100%" value='<s:property value="txtdocno"/>'></td>
    <td align="center"><input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search"  onclick="loadSearch();"></td>
  </tr>
  <tr>
    <td colspan="6"><div id="refreshdiv"><jsp:include page="oreMainSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
  </div>
</body>
</html>