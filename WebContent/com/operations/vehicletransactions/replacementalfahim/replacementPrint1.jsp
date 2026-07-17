<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>

<style type="text/css">
.tablereceipt {
    border: 1px solid black;
    border-collapse: collapse;
}

  fieldSet
    {
       
      /*   margin-left: 10px; */
      
      
     /*     border-width: 1px; border-color: rgb(205,205,193);  */
      
       border-width: 1px; border-color: rgb(250,235,215);  
        /*   border-width: 1px; border-color: rgb(160,160,255);  */
        margin:0;
    }

    legend
    {

        border-style:none;
        background-color:#FFF;
        padding-left:1px;

    }

</style>

</head>
<body bgcolor="white" style="font-size:10px;" >
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmprintrep" action="printrep" method="post" autocomplete="off" target="_blank">

<div style="background-color:white;">

 <table width="100%" >
  <tr>
    <td width="18%" rowspan="6"><img src="<%=contextPath%>/icons/epic.jpg" width="100" height="91"  alt=""/></td> 
    <td width="57%" rowspan="2">&nbsp;</td>
    <td width="25%"><font size="3"><label id="companyname" name="companyname"><s:property value="companyname"/></label></font></td>
  </tr>
  <tr>
    <td><b><label id="address" name="address"><s:property value="address"/></label></b></td>
  </tr>
  <tr>
    <td rowspan="2"  align="center"><b><font size="5">Vehicle Replacement</font></b></td>
    <td align="left"><b>Tel :</b>&nbsp;<label id="mobileno" name="mobileno"><s:property value="mobileno"/></label></td>
  </tr>
  <tr>
    <td align="left"><b>Fax :</b>&nbsp;<label id="fax" name="fax"><s:property value="fax"/></label></td>
  </tr>
  <tr>
    <td rowspan="2"  align="center">&nbsp;</td>
    <td align="left"><b>Branch :</b>&nbsp;<label id="barnchval" name="barnchval"><s:property value="barnchval"/></label></td>
  </tr>
  <tr>
    <td align="left"><b>Location :</b>&nbsp;<label id="location" name="location"><s:property value="location"/></label></td>
  </tr>
  <tr>
    <td colspan="3"><hr noshade size=1 width="100%"></td>
  </tr>
</table>

<fieldset>
<legend><b>Opening Details</b></legend>

<table width="100%" >
<tr>
<td width="50%">
<table width="100%"  >
<tr>
<td align="left" width="15%">Branch</td ><td colspan="3" align="left" width="90%"><label id="brwithcompany" name="brwithcompany"><s:property value="brwithcompany"/></label></td>
</tr>
<tr>
<td align="left" width="15%">VRA NO</td><td align="left" width="35%"><label id="vrano" name="vrano"><s:property value="vrano"/></label></td>
<td align="left" width="15%">Time</td><td align="left" width="35%"><label id="mtime" name="mtime"><s:property value="mtime"/></label></td>

</tr>
<tr>
<td align="left">Fleet NO </td><td align="left"><label id="pfleetno" name="pfleetno"><s:property value="pfleetno"/></label></td>
<td align="left">KM </td><td align="left"><label id="pkm" name="pkm"><s:property value="pkm"/></label></td>

</tr>
<tr>
<td align="left">Date Out </td><td align="left"><label id="poutdate" name="poutdate"><s:property value="poutdate"/></label></td>
<td align="left">Fuel Out </td><td align="left"><label id="pfuel" name="pfuel"><s:property value="pfuel"/></label></td>

</tr>
<tr>
<td align="left">Opened</td><td colspan="3" align="left"><label id="popened" name="popened"><s:property value="popened"/></label></td>
</tr>
<tr>
<td align="left">Rep Type</td><td colspan="3" align="left"><label id="reptype" name="reptype"><s:property value="reptype"/></label></td>
</tr>
</table>

</td>

<td width="50%">

<table width="100%" >
<tr>
<td align="left" width="15%">Agreement </td ><td colspan="3" align="left" width="90%"><label id="agmt" name="agmt"><s:property value="agmt"/></label></td>
</tr>
<tr>
<td align="left" width="15%">Doc NO </td><td align="left" width="35%"><label id="pdocno" name="pdocno"><s:property value="pdocno"/></label></td>
<td align="left" width="15%">Date</td><td align="left" width="35%"><label id="pdate" name="pdate"><s:property value="pdate"/></label></td>

</tr>
<tr>
<td align="left">Reg NO</td><td align="left"><label id="pregno" name="pregno"><s:property value="pregno"/></label></td>
<td align="left">Delivery</td><td align="left"><label id="pdelivery" name="pdelivery"><s:property value="pdelivery"/></label></td>

</tr>
<tr>
<td align="left">VRA Date</td><td align="left"><label id="vradate" name="vradate"><s:property value="vradate"/></label></td>
<td align="left">Time</td><td align="left"><label id="dtimes" name="dtimes"><s:property value="dtimes"/></label></td>

</tr>
<tr>
<td align="left">Replaced</td><td colspan="3" align="left"><label id="replaced" name="replaced"><s:property value="replaced"/></label></td>
</tr>
<tr>
<td align="left">Client</td><td colspan="3" align="left"><label id="clientacno" name="clientacno"><s:property value="clientacno"/></label>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<label id="pclient" name="pclient"><s:property value="pclient"/></label></td>
</tr>
</table>

</td>
</table>
</fieldset>
<br>
<fieldset >
<legend><b>Vehicle In Details</b></legend> 
<table width="100%" >
<tr>
<td width="50%">
<table width="100%">
<tr>
<td align="left" width="15%">Branch</td ><td colspan="3" align="left" width="90%"><label id="inbrwithcompany" name="inbrwithcompany"><s:property value="inbrwithcompany"/></label></td>
</tr>
<tr>
<td align="left" width="15%">Date</td><td align="left" width="35%"><label id="invehdate" name="invehdate"><s:property value="invehdate"/></label></td>
<td align="left" width="15%">Time</td><td align="left" width="35%"><label id="invehtime" name="invehtime"><s:property value="invehtime"/></label></td>

</tr>
<tr>
<td align="left">KM</td><td align="left"><label id="invehkm" name="invehkm"><s:property value="invehkm"/></label></td>
<td align="left">Fuel </td><td align="left"><label id="invehfuel" name="invehfuel"><s:property value="invehfuel"/></label></td>
</tr>
</table>
</td>
<td width="50%">
<table width="100%">
<tr>
<td align="left" width="15%">Reason</td ><td colspan="3" align="left" width="90%"><label id="invehreason" name="invehreason"><s:property value="invehreason"/></label></td>
</tr>
<tr>
<td align="left" width="15%">&nbsp;</td><td align="left" width="35%"></td>
<td align="left" width="15%">&nbsp;</td><td align="left" width="35%"></td>

</tr>
<tr>
<td align="left">&nbsp;</td><td align="left"></td>
<td align="left">&nbsp;</td><td align="left"></td>

</tr>
</table>
</td>
</table>
</fieldset>
<br>
<fieldset>
<legend><b>New Vehicle Out Details</b></legend> 
<table width="100%">
<tr>
<td width="50%">
<table width="100%">
<tr>
<td align="left" width="15%">Branch</td ><td colspan="3" align="left" width="90%"><label id="newbrwithcompany" name="newbrwithcompany"><s:property value="newbrwithcompany"/></label></td>
</tr>
<tr>
<td align="left" width="15%">Date</td><td align="left" width="35%"><label id="newvehoutdate" name="newvehoutdate"><s:property value="newvehoutdate"/></label></td>
<td align="left" width="15%">Time</td><td align="left" width="35%"><label id="newvehouttime" name="newvehouttime"><s:property value="newvehouttime"/></label></td>
</tr>
<tr>
<td align="left">Fleet NO</td><td align="left"><label id="newvehfleet" name="newvehfleet"><s:property value="newvehfleet"/></label></td>
<td align="left">Reg NO</td><td align="left"><label id="newvehregno" name="newvehregno"><s:property value="newvehregno"/></label></td>
</tr>
</table>
</td>
<td width="50%">

<table width="100%" >
<tr>
<td align="left" width="15%"> </td ><td colspan="3" align="left" width="90%">&nbsp;</td>
</tr>
<tr>
<td align="left" width="15%">KM</td><td align="left" width="35%"><label id="newvehkm" name="newvehkm"><s:property value="newvehkm"/></label></td>
<td align="left" width="15%">&nbsp;</td><td align="left" width="35%">&nbsp;</td>
</tr>
<tr>
<td align="left">Fuel</td><td align="left"><label id="newvehfuel" name="newvehfuel"><s:property value="newvehfuel"/></label></td>
<td align="left">&nbsp;</td><td align="left"></td>
</tr>
</table>
</td>
</table>
</fieldset>
<br>
<fieldset>
<legend><b>Delivery Details</b></legend>
<table width="100%">
<tr>
<td width="50%">
<table width="100%">
<tr>
<td align="left" width="15%">Branch</td ><td colspan="3" align="left" width="90%"><label id="delbrwithcompany" name="delbrwithcompany"><s:property value="delbrwithcompany"/></label></td>
</tr>
<tr>
<td align="left" width="15%">Date</td><td align="left" width="35%"><label id="deldate" name="deldate"><s:property value="deldate"/></label></td>
<td align="left" width="15%">Time</td><td align="left" width="35%"><label id="deltime" name="deltime"><s:property value="deltime"/></label></td>
</tr>
<tr>
<td align="left">Fleet NO</td><td align="left"><label id="delfleet" name="delfleet"><s:property value="delfleet"/></label></td>
<td align="left">Reg NO</td><td align="left"><label id="delregno" name="delregno"><s:property value="delregno"/></label></td>
</tr>
</table>
</td>
<td width="50%">

<table width="100%" >
<tr>
<td align="left" width="15%"> </td ><td colspan="3" align="left" width="90%">&nbsp;</td>
</tr>
<tr>
<td align="left" width="15%">KM</td><td align="left" width="35%"><label id="delkm" name="delkm"><s:property value="delkm"/></label></td>
<td align="left" width="15%">&nbsp;</td><td align="left" width="35%">&nbsp;</td>
</tr>
<tr>
<td align="left">Fuel</td><td align="left"><label id="delfuel" name="delfuel"><s:property value="delfuel"/></label></td>
<td align="left">&nbsp;</td><td align="left"></td>
</tr>
</table>
</td>
</table>
</fieldset>
<br>
<fieldset>
<legend><b>Collection Details</b></legend> 
<table width="100%">
<tr>
<td width="50%">
<table width="100%">
<tr>
<td align="left" width="15%">Branch</td ><td colspan="3" align="left" width="90%"><label id="colbrwithcompany" name="colbrwithcompany"><s:property value="colbrwithcompany"/></label></td>
</tr>
<tr>
<td align="left" width="15%">Date</td><td align="left" width="35%"><label id="coldate" name="coldate"><s:property value="coldate"/></label></td>
<td align="left" width="15%">Time</td><td align="left" width="35%"><label id="coltime" name="coltime"><s:property value="coltime"/></label></td>
</tr>
<tr>
<td align="left">Fleet NO</td><td align="left"><label id="colfleet" name="colfleet"><s:property value="colfleet"/></label></td>
<td align="left">Reg NO</td><td align="left"><label id="colregno" name="colregno"><s:property value="colregno"/></label></td>
</tr>
</table>
</td>
<td width="50%">

<table width="100%" >
<tr>
<td align="left" width="15%"> </td ><td colspan="3" align="left" width="90%">&nbsp;</td>
</tr>
<tr>
<td align="left" width="15%">KM</td><td align="left" width="35%"><label id="colkm" name="colkm"><s:property value="colkm"/></label></td>
<td align="left" width="15%">&nbsp;</td><td align="left" width="35%">&nbsp;</td>
</tr>
<tr>
<td align="left">Fuel</td><td align="left"><label id="colfuel" name="colfuel"><s:property value="colfuel"/></label></td>
<td align="left">&nbsp;</td><td align="left"></td>
</tr>
</table>
</td>
</table>
</fieldset>
<br><br><br><br><br><br><br>
</div>
</form>
</div>
</body>
</html>
