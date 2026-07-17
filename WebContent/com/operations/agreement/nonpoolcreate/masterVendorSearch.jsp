 <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
 
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
  <%-- <jsp:include page="../../../../includes.jsp"></jsp:include> --%>
<style>
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />

</style>

	<script type="text/javascript">
	$(document).ready(function () {
		 $("#vndsearchdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null});
		
	
	}); 


 	function mainloadSearchvnd() {
 		//alert("Inside");
 		//var client=document.getElementById("searchclient").value;
 	//	var reftype=document.getElementById("cmbsearchrtype").value;
 		var searchdate=$('#vndsearchdate').jqxDateTimeInput('val');
 		var docno=document.getElementById("vndsearchdocno").value;
 		var name=document.getElementById("vndsearchname").value;
 		var acno=document.getElementById("vndsearchacno").value;
 		var mobile=document.getElementById("vndsearchmobile").value;
 		//var status=document.getElementById("cmbsearchstatus").value;
		
		getdata(searchdate,docno,name,acno,mobile);
 

	}

	 function getdata(searchdate,docno,name,acno,mobile){
		
		// $("#tariffDivId").load('rateDescription.jsp?txtrentaldocno='+indexVal1+'&revehGroup='+revehGroup);
		
		 $("#srefreshdivvendor").load('vendorSearch.jsp?searchdate='+searchdate+'&docno='+docno+'&name='+name+'&acno='+acno+'&mobile='+mobile+'&id=1');
		 

		  
/* x.open("GET", "dissearch.jsp?sclname="+sclname+"&smob="+smob+"&rno="+rno+"&flno="+flno+"&sregno="+sregno+"&smra="+smra, true);
		x.send(); */
		}
 
	</script>
<body bgcolor="#E0ECF8">
<div id=search>
  <table width="100%" >
    <tr>
    <td width="12%" align="right">Doc No</td>
    <td width="14%" align="left"><input type="text" name="vndsearchdocno" id="vndsearchdocno"></td>
    <td width="7%" align="right">Date</td>
    <td width="13%" align="left"><div id="vndsearchdate" name="vndsearchdate"></div></td>
    <td width="13%" align="right">Mobile</td>
    <td width="15%" align="left"><input type="text" name="vndsearchmobile" id="vndsearchmobile" ></td>
    <td width="12%" align="right">&nbsp;</td>
    <td width="14%" align="left">&nbsp;</td>
    </tr>

  <tr>
    <td align="right">Name</td>
    <td colspan="3" align="left"><input type="text" name="vndsearchname" id="vndsearchname" style="width:99%;"></td>
    <td align="right">A/c No</td>
    <td align="left"><input type="text" name="vndsearchacno" id="vndsearchacno"></td>
    <td align="right">&nbsp;</td>
    <td align="center"><input type="button" name="btnSearchvnd" id="btnSearchvnd" class="myButton" value="Search" onClick="mainloadSearchvnd();"></td>
  </tr>
  <tr>
  <td colspan="8">
   <div id="srefreshdivvendor">
      
   <jsp:include  page="vendorSearch.jsp"></jsp:include> 
   
  </div>
  </td>
  </tr>
 </table>

   
</div>
</body>
</html>