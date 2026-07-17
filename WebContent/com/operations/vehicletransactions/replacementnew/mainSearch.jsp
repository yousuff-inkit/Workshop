 <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
 
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
 <%-- <jsp:include page="../../../../includes.jsp"></jsp:include>  --%> 
<style>
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />

</style>

	<script type="text/javascript">
	$(document).ready(function () {
		 $("#searchdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null});
	}); 

 	function mainloadSearch() {
 		if(document.getElementById("searchagmtno").value!=""){
 			if(document.getElementById("cmbsearchrtype").value==""){
 				document.getElementById("errormsg").innerText="";
 				document.getElementById("errormsg").innerText="Agreement Type is Mandatory";
 				return false;
 			}
 		}
 		var client=document.getElementById("searchclient").value;
 		var reftype=document.getElementById("cmbsearchrtype").value;
 		var searchdate=$('#searchdate').jqxDateTimeInput('val');
 		var agmtno=document.getElementById("searchagmtno").value;
 		var fleetno=document.getElementById("searchfleetno").value;
 		var docno=document.getElementById("searchdocno").value;
	
 		
		getdata(client,reftype,searchdate,agmtno,fleetno,docno);
 

	}
	 function getdata(client,reftype,searchdate,agmtno,fleetno,docno){
		
		// $("#tariffDivId").load('rateDescription.jsp?txtrentaldocno='+indexVal1+'&revehGroup='+revehGroup);
		
		 $("#srefreshdiv").load('subMainSearch.jsp?client='+client+'&reftype='+reftype+'&searchdate='+searchdate+'&agmtno='+agmtno+'&fleetno='+fleetno+'&docno='+docno);
		 

		  
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
    <td align="right" width="">Name</td>
    <td align="left" width="53%"><input type="text" name="searchclient" id="searchclient"  style="width:96.5%;" value='<s:property value="searchclient"/>'></td>
    <td align="right">Type</td>
    <td align="left"><select name="cmbsearchrtype" id="cmbsearchrtype"><option value="">--Select--</option><option value="RAG">Rental</option><option value="LAG">Lease</option></select></td>
      <td align="right">Date</td>
    <td align="left"><div id="searchdate" name="searchdate" value='<s:property value="searchdate"/>'></div></td>
    <tr>
    </table>
    </td>
  </tr>
 
		
  <table >
  <tr>
 
     <td align="left" width="">Agmt NO</td>
    <td align="left" width=><input type="text" name="searchagmtno" id="searchagmtno" value='<s:property value="searchagmtno"/>'>
    <td width="4%"></td>
    <td align="right">Fleet NO</td>
    
    <td align="left" width="20%"><input type="text" name="searchfleetno" id="searchfleetno" style="width:96.5%;" value='<s:property value="searchfleetno"/>'></td>
    <td align="right">Doc No</td>
    <td align="left"><input type="text" id="searchdocno" name="searchdocno" value='<s:property value="searchdocno"/>'></td>
    
    <td colspan="2" align="center">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" name="mbtnrasearch" id="mbtnrasearch" class="myButton" value="Search"  onclick="mainloadSearch();"></td>
  </tr>
  </table>
  </td>

  <tr>
    <td colspan="8" align="right">
    
    <div id="srefreshdiv">
      
   <jsp:include  page="subMainSearch.jsp"></jsp:include> 
   
   </div>
    </td>
  </tr>
</table>
  </div>
</body>
</html>