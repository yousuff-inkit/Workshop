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
<style>
.branchs {
	color: black;
 
	width: 100%;
	font-family: Tahoma;
	font-size: 10px;
}
</style>
	<script type="text/javascript">
	$(document).ready(function () {
	
	}); 

 	function mainloadSearch() {
 		
 		var brc=document.getElementById("branchsss").value;
 		var sclnames=document.getElementById("SCl_name").value;
 		var smob=document.getElementById("Sl_mob").value;
 		var rno=document.getElementById("rno").value;
 		var flno=document.getElementById("flno").value;
 		var sregno=document.getElementById("sregno").value;
 		
 		var sclname = sclnames.replace(/ /g, "%20");
 		
 		getdata(sclname,smob,rno,flno,sregno,brc);
 

	}
	 function getdata(sclname,smob,rno,flno,sregno,brc){
		
		// $("#tariffDivId").load('rateDescription.jsp?txtrentaldocno='+indexVal1+'&revehGroup='+revehGroup);
		
		 $("#ssrefreshdiv").load('lasubmainSearch.jsp?sclname='+sclname+'&smob='+smob+'&rno='+rno+'&flno='+flno+'&sregno='+sregno+'&brc='+brc);
		 

		  
/* x.open("GET", "dissearch.jsp?sclname="+sclname+"&smob="+smob+"&rno="+rno+"&flno="+flno+"&sregno="+sregno+"&smra="+smra, true);
		x.send(); */
		}
	 
	</script>
<body bgcolor="#E0ECF8">
<div id=search>
<table width="100%" >
  <tr >
   <td>
   <table >
   <tr>
    <td align="right" width=""><label class="branchs" >Name</label></td>
    <td align="left" width="57.5%"><input type="text" name="SCl_name" id="SCl_name"  style=height:20px;width:100%;" value='<s:property value="SCl_name"/>'></td>
    <td align="right"  >&nbsp;&nbsp;&nbsp;<label class="branchs" >MOB</label></td>
    <td align="left" width="47%"><input type="text" name="Sl_mob"  style="height:20px;" id="Sl_mob" value='<s:property value="Sl_mob"/>'></td>
    <tr>
    </table>
    </td>
  </tr>
 <tr><td>
		
  <table >
  <tr>
 
<td align="left" width=""><label class="branchs" >Doc NO</label></td>
    <td align="left" width=><input type="text" name="rno" id="rno" style="height:20px;" value='<s:property value="rno"/>'>
    <td width="4%"></td>
    <td align="right"><label class="branchs" >Fleet NO</label></td>
    
    <td align="left" width="20%"><input type="text" name="flno" id="flno" style="height:20px;width:96.5%;" value='<s:property value="flno"/>'></td>
    <td align="right"><label class="branchs" >Reg NO</label></td>
    <td align="left"><input type="text" id="sregno" name="sregno" style="height:20px;width:96%;" value='<s:property value="sregno"/>'></td>
   
    
    <td colspan="2" align="center">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" name="mbtnrasearch" id="mbtnrasearch" class="myButton" value="Search"  onclick="mainloadSearch();"></td>
  </tr>
  </table>
  </td>

  <tr>
    <td colspan="8" align="right">
    
    <div id="ssrefreshdiv">
      
   <jsp:include  page="lasubmainSearch.jsp"></jsp:include> 
   
   </div>
    </td>
  </tr>
</table>
  </div>
</body>
</html>