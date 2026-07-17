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
 
 		
 		var formdetailcode=document.getElementById("formdetailcode").value;
 		
 
 		
 		var seachdoc=document.getElementById("seachdoc").value;
 		var fleetnoss=document.getElementById("fleetnoss").value;
 		var flnames=document.getElementById("flnamess").value;
 		var regnoss=document.getElementById("regnoss").value;
 	
 	
 		var flname = flnames.replace(/ /g, "%20");
		
	    var aa="yes";
		getdatas(seachdoc,fleetnoss,flname,regnoss,aa,formdetailcode);
 

	}
	function getdatas(seachdoc,fleetnoss,flname,regnoss,aa,formdetailcode){ 
 
		 $("#submastersearchs").load('submastersearch.jsp?fleetnoss='+fleetnoss+'&seachdoc='+seachdoc+'&flnames='+flname+'&regnoss='+regnoss+'&aa='+aa+"&formdetailcode="+formdetailcode);

		}

	</script>
<body bgcolor="#E0ECF8">
<div id=search>

   <table width="100%"  >
   <tr>
    <td align="right" width="6%">Doc NO</td> 
    <td align="left" ><input type="text" name="seachdoc" id="seachdoc"  style="width:60%;" value='<s:property value="seachdoc"/>'></td> 
   
    <td align="right" width="6%">Fleet</td> 
    <td align="left" ><input type="text" name="fleetnoss" id="fleetnoss"  style="width:60%;" value='<s:property value="fleetnoss"/>'></td>
    </tr>
    <tr>
    
    <td align="right" width="14%">Reg No</td>
    <td align="left"><input type="text" name="regnoss" style="width:60%;" id="regnoss" value='<s:property value="regnoss"/>'></td>
    
   <td align="right"  width="14%">Name</td>
    <td align="left"  width="30%"><input type="text" name="flnamess" style="width:90%;" id="flnamess" value='<s:property value="flnamess"/>'></td>
   <td width="14%" ><input type="button" id="searchdata" value="Search" class="myButton" onclick="loadSearchs();"> </td>
    <tr>
    </table>
    
 
    
    <div id="submastersearchs">
      
   <jsp:include  page="submastersearch.jsp"></jsp:include> 
   
   </div>
     
  </div>
</body>
</html>