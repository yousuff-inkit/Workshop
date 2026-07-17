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
<style>
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />

</style>

	<script type="text/javascript">
	$(document).ready(function () {
		$("#msearchdate").jqxDateTimeInput({
			width : '125px',
			height : '15px',
			formatString : "dd.MM.yyyy",value:null
		});
	}); 

 	function mainDocSearch() {
 		
 		var docno=document.getElementById("msearchdocno").value;
 		var date=$('#msearchdate').jqxDateTimeInput('val');
 		var vendor=document.getElementById("msearchvendor").value;
 		var fleetno=document.getElementById("msearchfleetno").value;
 		var regno=document.getElementById("msearchregno").value;
 		var mobile=document.getElementById("msearchmobile").value;
		var branch=document.getElementById("brchName").value;
 		
 		getmaindata(docno,date,vendor,fleetno,regno,mobile,branch);
 

	}
	 function getmaindata(docno,date,vendor,fleetno,regno,mobile,branch){
		
		
		 $("#srefreshdivmain").load('subMainSearch.jsp?docno='+docno+'&date='+date+'&vendor='+vendor+'&fleetno='+fleetno+'&regno='+regno+'&mobile='+mobile+'&branch='+branch+'&id=1');
		 

		}
 
	</script>
<body bgcolor="#E0ECF8">
<div id=search>
<table width="100%">
  <tr>
    <td width="9%" align="right">Doc No</td>
    <td width="15%" align="left"><input type="text" name="msearchdocno" id="msearchdocno" ></td>
    <td width="10%" align="right">Date</td>
    <td width="17%" align="left"><div id="msearchdate" ></div></td>
    <td width="10%" align="right">Vendor</td>
    <td width="29%" align="left"><input type="text" name="msearchvendor" id="msearchvendor"></td>
    <td width="10%" rowspan="2" align="center"><input type="button" name="searchbtn" id="searchbtn" class="myButton" value="Search"  onclick="mainDocSearch();"></td>
  </tr>
  <tr>
    <td align="right">Fleet</td>
    <td align="left"><input type="text" name="msearchfleetno" id="msearchfleetno"></td>
    <td align="right">Reg No</td>
    <td align="left"><input type="text" name="msearchregno" id="msearchregno"></td>
    <td align="right">Mobile</td>
    <td align="left"><input type="text" name="msearchmobile" id="msearchmobile"></td>
    </tr>
  <tr>
    <td colspan="7" align="right"><div id="srefreshdivmain"><jsp:include page="subMainSearch.jsp"></jsp:include></div></td>
    </tr>

</table>



  </div>
</body>
</html>