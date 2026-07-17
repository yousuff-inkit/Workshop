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

 	function loadSearchss() {
 
 		var fleetno=document.getElementById("fleetno1").value;
 		var regno=document.getElementById("regno1").value;
 		var flnames=document.getElementById("flname1").value;
 		var color=document.getElementById("color1").value;
 		var group=document.getElementById("group1").value;
 	
 		var flname = flnames.replace(/ /g, "%20");
		
	var aa="yes";
		getdata(fleetno,regno,flname,color,group,aa);
 

	}
	function getdata(fleetno,regno,flname,color,group,aa){
		
		 $("#refreshdivss").load('subtempfleetsearch.jsp?fleetno='+fleetno+'&regno='+regno+'&flname='+flname+'&color='+color+'&group='+group+'&aa='+aa);
	
		}

	</script>
<body bgcolor="#E0ECF8">
<div id=search>
<table width="100%" >
  <tr >
   <td>
   <table >
   <tr>
    <td align="right" width="6%">Fleet</td> 
    <td align="left" ><input type="text" name="fleetno1" id="fleetno1"  style="width:90%;" value='<s:property value="fleetno1"/>'></td>
    <td align="right" width="14%">Reg No</td>
    <td align="left"><input type="text" name="regno1" id="regno1" value='<s:property value="regno1"/>'></td>
    
   <td align="right"  width="14%">Name</td>
    <td align="left"  width="30%"><input type="text" name="flname1" style="width:90%;" id="flname1" value='<s:property value="flname1"/>'></td>
    
    <tr>
    </table>
    </td>
  </tr>
  <tr>
  <td>
  <table >
  <tr>
   <td align="right" width="6%">Color</td>
    <td align="left" ><input type="text" name="color1"  style="width:90%;" id="color1" value='<s:property value="color1"/>'>
    <td align="right" width="14%">Group</td>
    <td align="left"><input type="text" name="group1" id="group1" value='<s:property value="group1"/>'></td>
    <td align="right"  width="14%">&nbsp;</td>
    <td align="left"  width="30%"><input type="button" name="btnrasearch" id="btnrasearch" class="myButton" value="Search"  onclick="loadSearchss();"></td>
  </tr>
  </table>
  </td>

  <tr>
    <td colspan="8" align="right">
    
    <div id="refreshdivss">
      
   <jsp:include  page="subtempfleetsearch.jsp"></jsp:include> 
   
   </div>
    </td>
  </tr>
</table>
  </div>
</body>
</html>