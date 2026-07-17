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
<%
 String cldocno = request.getParameter("cldocno")==null?"0":request.getParameter("cldocno");
%>
	<script type="text/javascript">
	
	$(document).ready(function () {}); 

 	function loadSearch() {
 		
 		var regno=document.getElementById("regno").value;
 		var id=1;
 		var cldocno='<%=cldocno%>';
		getdata(regno,cldocno,id);
	}
 	
	function getdata(regno,cldocno,id){
		 $("#regrefreshdiv").load('RegisterDetailsSearch.jsp?id='+id+'&regno='+regno.replace(/ /g, "%20")+'&cldocno='+cldocno);
		}

	</script>
<body>
<div id=search>
<table width="100%">
  <tr>
    
     <td width="6%" align="right" style="font-size:9px;">Reg No</td>
    <td width="45%"><input type="text" name="regno" id="regno" style="width:100%;height:20px;" value='<s:property value="regno"/>'>
    </td>
  <td width="9%" align="center"><input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search"  onclick="loadSearch();"></td>
  </tr>
  <tr>
    <td colspan="5"><div id="regrefreshdiv"><jsp:include page="RegisterDetailsSearch.jsp"></jsp:include></div></td>
  </tr>
</table>
  </div>
</body>
</html>