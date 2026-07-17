 <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
 
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<%--   <jsp:include page="../../../../includes.jsp"></jsp:include>   --%> 
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
<style>
.textdetail {
	color: black;
	background-color: #E0ECF8;
	width: 100%;
	font-family: Tahoma;
	font-size: 10px;
}
</style>

	<script type="text/javascript">
	$(document).ready(function () {
	
	}); 

 	function mainloadSearch() {
 		
 		var client=document.getElementById("searchname").value;
 		var mobile=document.getElementById("searchmobile").value;
 		var regno=document.getElementById("searchregno").value;
 		var fleetno=document.getElementById("searchfleetno").value;
 		var mrano=document.getElementById("searchmrano").value;
		var docno=document.getElementById("searchdocno").value;
 		var branch=document.getElementById("cmbbranch").value;

	
		getdata(client,mobile,docno,mrano,fleetno,regno,branch);

	}
	 function getdata(client,mobile,docno,mrano,fleetno,regno,branch){
		 $("#agmtdiv").load('agmtSearchGrid.jsp?client='+client+'&mobile='+mobile+'&docno='+docno+'&mrano='+mrano+'&fleetno='+fleetno+'&regno='+regno+'&branch='+branch+'&id=1');
		}
 
	</script>
<body bgcolor="#E0ECF8">
<div id=search>
<table width="100%" border="0">
  <tr>
    <td width="7%" align="right"><label class="textdetail">Name</label></td>
    <td colspan="3"><input type="text" name="searchname" id="searchname" style="width:95%;height:18px;"></td>
    <td width="9%" align="right"><label class="textdetail">Mobile</label></td>
    <td width="19%"><input type="text" name ="searchmobile" id="searchmobile" style="height:18px;"></td>
    <td width="8%" align="right"><label class="textdetail">MRA No</label></td>
    <td width="15%"><input type="text" name="searchmrano" id="searchmrano" style="height:18px;"></td>
  </tr>
  <tr>
    <td align="right"><label class="textdetail">Doc No</label></td>
    <td width="16%"><input type="text" id="searchdocno" name="searchdocno" style="height:18px;"></td>
    <td width="8%" align="right"><label class="textdetail">Reg No</label></td>
    <td width="18%"><input type="text" id="searchregno" name="searchregno" style="height:18px;"></td>
    <td align="right"><label class="textdetail">Fleet No</label></td>
    <td><input type="text" id="searchfleetno" name="searchfleetno" style="height:18px;"></td>
    <td>&nbsp;</td>
    <td><button type="button" name="btnsearchagmt" id="btnsearchagmt" class="myButton" onClick="mainloadSearch();">Search</button></td>
  </tr>
  <tr>
    <td colspan="8"><div id="agmtdiv"><jsp:include page="agmtSearchGrid.jsp"></jsp:include></div></td>
    </tr>
</table>
  </div>
</body>
</html>