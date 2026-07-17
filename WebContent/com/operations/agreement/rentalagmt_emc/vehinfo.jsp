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
 
 		var fleetno=document.getElementById("searchfleetno").value;
 		var regno=document.getElementById("searchregno").value;
 		var flnames=document.getElementById("searchflname").value;
 		var color=document.getElementById("searchcolor").value;
 		var group=document.getElementById("searchgroup").value;
 	
 		var flname = flnames.replace(/ /g, "%20");
		
	var aa="yes";
		getdata(fleetno,regno,flname,color,group,aa);
 

	}
	function getdata(fleetno,regno,flname,color,group,aa){
		
		 $("#refreshdivs").load('subvehinfo.jsp?fleetno='+fleetno+'&regno='+regno+'&flname='+flname+'&color='+color+'&group='+group+'&aa='+aa);

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
    <td align="left" ><input type="text" name="searchfleetno" id="searchfleetno"  style="width:90%;" value='<s:property value="searchfleetno"/>'></td>
    <td align="right" width="14%">Reg No</td>
    <td align="left"><input type="text" name="searchregno" id="searchregno" value='<s:property value="searchregno"/>'></td>
    
   <td align="right"  width="14%">Name</td>
    <td align="left"  width="30%"><input type="text" name="searchflname" style="width:90%;" id="searchflname" value='<s:property value="searchflname"/>'></td>
    
    <tr>
    </table>
    </td>
  </tr>
  <tr>
  <td>
  <table >
  <tr>
   <td align="right" width="6%">Color</td>
    <td align="left" ><input type="text" name="searchcolor"  style="width:90%;" id="searchcolor" value='<s:property value="searchcolor"/>'>
    <td align="right" width="14%">Group</td>
    <td align="left"><input type="text" name="searchgroup" id="searchgroup" value='<s:property value="searchgroup"/>'></td>
    <td align="right"  width="14%">&nbsp;</td>
    <td align="left"  width="30%"><input type="button" name="btnrasearch" id="btnrasearch" class="myButton" value="Search"  onclick="loadSearchs();"></td>
  </tr>
  </table>
  </td>

  <tr>
    <td colspan="8" align="right">
    
    <div id="refreshdivs">
      
   <jsp:include  page="subvehinfo.jsp"></jsp:include> 
   
   </div>
    </td>
  </tr>
</table>
  </div>
</body>
</html>