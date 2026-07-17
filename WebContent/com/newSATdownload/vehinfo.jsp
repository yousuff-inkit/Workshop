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

 	function loadSearchs() {
 
 		var fleetno=document.getElementById("fleetno").value;
 		var regno=document.getElementById("regno").value;
 		var flnames=document.getElementById("flname").value;
 		var stag=document.getElementById("stag").value;
 		var pcode=document.getElementById("plcode").value;
 	
 		var flname = flnames.replace(/ /g, "%20");
		
	var aa="yes";
		getdata(fleetno,regno,flname,stag,pcode,aa);
 

	}
	function getdata(fleetno,regno,flname,stag,pcode,aa){
		
		 $("#refreshdivs").load('subperfleetSearch.jsp?fleetno='+fleetno+'&regno='+regno+'&flname='+flname+'&stag='+stag+'&pcode='+pcode+'&aa='+aa);

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
    <td align="left" ><input type="text" name="fleetno" id="fleetno"  style="width:90%;" value='<s:property value="fleetno"/>'></td>
    <td align="right" width="14%">Reg No</td>
    <td align="left"><input type="text" name="regno" id="regno" value='<s:property value="regno"/>'></td>
    
   <td align="right"  width="14%">Name</td>
    <td align="left"  width="30%"><input type="text" name="flname" style="width:90%;" id="flname" value='<s:property value="flname"/>'></td>
    
    <tr>
    </table>
    </td>
  </tr>
  <tr>
  <td>
  <table >
  <tr>
   <td align="right" width="6%">SALIK TAG</td>
    <td align="left" ><input type="text" name="stag"  style="width:90%;" id="stag" value='<s:property value="stag"/>'>
    <td align="right" width="14%">PLATE CODE</td>
    <td align="left"><input type="text" name="plcode" id="plcode" value='<s:property value="plcode"/>'></td>
    <td align="right"  width="14%">&nbsp;</td>
    <td align="left"  width="30%"><input type="button" name="btnrasearch" id="btnrasearch" class="myButton" value="Search"  onclick="loadSearchs();"></td>
  </tr>
  </table>
  </td>

  <tr>
    <td colspan="8" align="right">
    
    <div id="refreshdivs">
      
   <jsp:include  page="subperfleetSearch.jsp"></jsp:include> 
   
   </div>
    </td>
  </tr>
</table>
  </div>
</body>
</html>