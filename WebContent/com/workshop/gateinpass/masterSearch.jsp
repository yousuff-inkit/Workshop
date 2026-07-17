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
		$("#searchdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null}); 
    	$("#searchGrid").jqxGrid('clear');

	}); 

 	function loadSearch1() {
 		$("#searchGrid").jqxGrid('clear');
 		var date=document.getElementById("searchdate").value;
 		 var fleetno=document.getElementById("Fleet No").value;
 		var Driver=document.getElementById("Driver").value;
 		var msdocno=document.getElementById("msdocno").value;
 		var regno=document.getElementById("reg_nos").value;
 		var id="1";
	getdata1(fleetno,msdocno,Driver,date,regno,id)
 

	}
	function getdata1(fleetno,msdocno,Driver,date,regno,id){
		 $("#refreshdivmas").load('searchGrid.jsp?fleetno='+fleetno+'&msdocno='+msdocno+'&Driver='+Driver+'&date='+date+'&regno='+regno+'&id='+id);
		
		}

	</script>
<body bgcolor="#E0ECF8">
<div id=search>
<table width="100%" >
  <tr>
   <td>                         
   <table>
   <tr>
   <td align="right">Docno</td>
    <td align="left" width="2%"><input type="text" name="msdocno" id="msdocno"  value='<s:property value="msdocno"/>'></td>
    <td align="right" >Fleet No</td>
    <td align="left" width="70%" ><input type="text" name="Fleet No" id="Fleet No"  style="width:90%;" value='<s:property value="Fleet No"/>'></td>
    <td align="right" >Driver</td>
    <td align="left" width="28%"><input type="text" name="Driver" id="Driver" value='<s:property value="Driver"/>'></td>
   </tr>
   <tr>
    <td width="35" align="right">Date</td>
    <td width="144" align="left"><div id="searchdate" name="searchdate"></div></td>
    <td align="right" >Reg No</td>  
	<td align="left" ><input type="text" name="reg_nos" id="reg_nos"  style="width:90%;" value='<s:property value="reg_nos"/>'></td>
	<td></td>
    <td><input type="button" name="enqbtnrasearch" id="enqbtnrasearch" class="myButton" value="Search"  onclick="loadSearch1()"></td>
    <tr>
    </table>
    </td>
</tr>

  <tr>
    <td colspan="8" align="right">
    
    <div id="refreshdivmas">
      
   <jsp:include  page="searchGrid.jsp"></jsp:include> 
   
   </div>
    </td>
  </tr>
</table>
  </div>
</body>
</html>
