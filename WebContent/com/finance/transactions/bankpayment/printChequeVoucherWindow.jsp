 <%@ taglib prefix="s" uri="/struts-tags" %>
 <% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
<title>GatewayERP(i)</title>

<script type="text/javascript">

	$(document).ready(function() {
		$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
	    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:50%;left:50%;'><img src='../../../../icons/31load.gif'/></div>");
	    
	    $('#txtchqbankname').attr('readonly', true );
	    changeRdo();
	});

	function changeRdo(){
	 
		 if(document.getElementById("rdosingle").checked==true){
		 	//document.getElementById("tono").disabled=true;
		 	document.getElementById("printGridDiv").style.display="none";
		 	document.getElementById("printSingleDiv").style.display="block";
		 	$('.multiprint').attr('hidden',true);
		 	document.getElementById("btnPrintSearch").style.display="none";
		 	 	
		 }
		if(document.getElementById("rdomultiple").checked==true){
		 	//document.getElementById("tono").disabled=false;
		 	document.getElementById("printGridDiv").style.display="block";
		 	document.getElementById("printSingleDiv").style.display="none";
		 	$('.multiprint').attr('hidden',false);
		 	document.getElementById("btnPrintSearch").style.display="block";
		 }
		 <%-- var voc='<%=request.getParameter("voc")%>';
		 if(voc!=""){
			 document.getElementById("fromno").value=voc;
		 } --%>
	 
	 }
</script>

<body onload="changeRdo();">
<div id=search>
<table width="100%">
  <tr>
    <td colspan="2" align="right"><input type="radio" name="rdoprint" id="rdosingle" checked onChange="changeRdo();">
  <label for="rdosingle">Single</label>&nbsp;&nbsp;&nbsp;&nbsp;</td>
    <td colspan="2"><input type="radio" name="rdoprint" id="rdomultiple"  onChange="changeRdo();">
      <label for="rdomultiple">Multiple</label></td>
  </tr>
  <tr>
    <td width="5%" align="right">Bank</td>
    <td width="42%"><input type="text" name="txtchqbankname" id="txtchqbankname" style="width:100%">
    <input type="hidden" name="txtchqbankdocno" id="txtchqbankdocno"></td>
    <td width="45%" align="right">
    <button type="button" name="btnPrintSearch" id="btnPrintSearch" class="myButton" onclick="funPrintGridLoad();">Search</button></td>
     <td width="8%" align="left">
    <button type="button" name="btnGetPrint" id="btnGetPrint" class="myButton" onclick="funGetPrint()">Print</button></td>
  </tr>
  <tr>
    <td colspan="4"><div id="printGridDiv"><jsp:include page="printChequeGrid.jsp"/></div>
    <div id="printSingleDiv"><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/></div></td>
  </tr>
</table>

  </div>
</body>
</html>