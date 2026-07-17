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
		 $("#dates").jqxDateTimeInput({ width: '109px', height: '20px', formatString:"dd.MM.yyyy",value:null});
	}); 

 	function loadSearch() {
 		var name=document.getElementById("txtname").value;
 		var date=$("#dates").jqxDateTimeInput('val');
 		var docno=document.getElementById("txtdocno").value;
        name=name.replace(/ /g, "%20");
 		getdata(name,date,docno);
	}
	function getdata(name,date,docno){                                
		
		 $("#refreshdiv").load('evlMainSearchGrid.jsp?name='+encodeURIComponent(name)+'&docno='+docno+'&date='+date+'&id='+1);     
		}

	</script>
<body>
<div id=search>
<table width="100%">
  <tr>
    <td align="right">Date</td>
    <td width="21%"><div id="dates" name="dates"></div></td>
    <td width="7%" align="right">Doc No.</td>
    <td width="10%"><input type="text" name="txtdocno" id="txtdocno" value='<s:property value="txtdocno"/>'></td>
  </tr>
  <tr>
    <td width="10%" align="right">Evaluated For</td>
    <td colspan="2" width="24%"><input type="text" name="txtname" id="txtname" style="width:99%" value='<s:property value="txtname"/>'></td>
    <td width="10%" align="center"><input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search"  onclick="loadSearch();"></td>
  </tr>
  <tr>    
    <td colspan="4"><div id="refreshdiv"><jsp:include  page="evlMainSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
  </div>
</body>
</html>