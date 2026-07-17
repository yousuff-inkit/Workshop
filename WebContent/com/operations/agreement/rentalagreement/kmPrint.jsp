<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
 <%@ page pageEncoding="utf-8" %>
<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<% String contextPath=request.getContextPath();%>
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>
  
<style>
	body{
		background-color:#fff !important;
		font:12px Tahoma;
	}
	fieldSet {
  -webkit-border-radius: 8px;
  -moz-border-radius: 8px;
  border-radius: 8px;
  border: 1px solid rgb(139,136,120);

 }
</style>
<script>
	$(document).ready(function(){
		var clstatus=document.getElementById("lblclstatus").innerText;
		if(clstatus=="1"){
			$('#calc').show();
		}
		else{
			$('#calc').hide();
		}
	});
</script>
</head>
<body>
<form action="printKmDetails" tartget="_blank">
<table width="100%" border="0">
  <tr>
    <td><jsp:include page="../../../../com/common/printHeader.jsp"></jsp:include></td>
  </tr>
</table>
<fieldset>
<table width="100%" border="0">
  <tr>
    <td width="7%">Client</td>
    <td><label name="kmclient"><s:property value="kmclient"/></label></td>
    <td width="13%">Agreement No</td>
    <td width="14%"><label name="kmagmtno"><s:property value="kmagmtno"/></label></td>
  </tr>
  <tr>
    <td>Driver</td>
    <td><label name="kmdriver"><s:property value="kmdriver"/></label></td>
    <td>MRA No</td>
    <td><label name="kmmrano"><s:property value="kmmrano"/></label></td>
  </tr>
  <tr>
    <td>Vehicle</td>
    <td><label name="kmvehicle"><s:property value="kmvehicle"/></label></td>
    <td>Date</td>
    <td><label name="kmdate"><s:property value="kmdate"/></label></td>
  </tr>
</table>

</fieldset>
<br>
<fieldset>
<table width="100%" border="0">
	<tr>
        <td>Fleet No</td>
        <td>Reg No</td>
        <td>Fleet Name</td>
        <td>Date Out</td>
        <td>Time Out</td>
        <td>Km Out</td>
        <td>Date In</td>
        <td>Time In</td>
        <td>Km In</td>
        <td>Used Km</td>
  	</tr>
	<s:iterator var="stat1" status="arr" value="%{#request.KMPRINT}" >
		<s:iterator status="arr" value="#stat1" var="stat">    
			<tr>
		    	<s:iterator status="arr" value="#stat.split('::')" var="des">
						<td >
							<s:property value="#des"/>
						</td>
				</s:iterator>
			</tr>
		</s:iterator>
	</s:iterator>
</table>
</fieldset>
<br>
<fieldset id="calc">
<table width="100%" border="0">
  <tr>
    <td width="15%">Total Allowed Km</td>
    <td width="18%"><label name="lbltotalallowedkm"><s:property value="lbltotalallowedkm"/></label></td>
    <td width="30%">&nbsp;</td>
    <td width="21%">Rate per Km</td>
    <td width="16%"><label name="lblrateperkm"><s:property value="lblrateperkm"/></label></td>
  </tr>
  <tr>
    <td>Total Used Km</td>
    <td><label name="lbltotalusedkm"><s:property value="lbltotalusedkm"/></label></td>
    <td>&nbsp;</td>
    <td>Total Excess Km Rate</td>
    <td><label name="lbltotalexcesskmrate"><s:property value="lbltotalexcesskmrate"/></label></td>
  </tr>
  <tr>
    <td>Total Excess Km</td>
    <td><label name="lbltotalexcesskm"><s:property value="lbltotalexcesskm"/></label></td>
    <td>&nbsp;</td>
    <td colspan="2"><b><label name="lbltotalexcesskmratewords"><s:property value="lbltotalexcesskmratewords"/></label></b></td>
    </tr>
</table>

</fieldset>
<label name="lblclstatus" hidden="true" id="lblclstatus"><s:property value="lblclstatus"/></label>
</form>

</body>
</html>