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
    font-size: 9px;
}
</style>

</head>
<body bgcolor="white" style="font-size:10px;">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmassignmentlist" action="printAssignmentList" method="post" autocomplete="off" target="_blank">

<div style="background-color:white;">

<jsp:include page="../../../common/printHeader.jsp"></jsp:include>

<%-- <table  width="65%" align="center" >
    <tr><td>
  	
   <fieldset><legend><b>Driver Details</b></legend>
   
        <table  width="98%"  align="center" cellspacing="3">
        
    <tr>
      <td width="10%" align="left"><b>Code</b></td>
    <td width="10%" colspan="4" ><b>: </b><s:property value="lblcode"/></td>
    <td width="10%">&nbsp;</td>
      <td width="12%" align="left"><b>Name </b></td>
      
    <td width="30%" colspan="4"><b>: </b><s:property value="lblname"/> </td>
    
    </tr>    
        
    <tr>
        <td  width="10%" align="left"><b>License No </b></td>
    <td width="10%" colspan="4" ><b>: </b><s:property value="lbllicno"/></td>
   <td width="10%">&nbsp;</td>
   <td width="12%" align="left"><b>License Exp</b></td>
    <td width="30%" colspan="4" ><b>: </b><s:property value="lbllicexp"/></td>
    </tr>
    <tr>
     <td align="left"><b>Authority</b></td>
    <td colspan="4"><b>:</b> <s:property value="lblauth"/></td>
    </tr>
    <tr>
    <td width="10%" align="left"><b>Mob No </b></td>
    <td width="10%" colspan="4"><b>: </b><s:property value="lblmobno"/></td>
   
	<td width="10%">&nbsp;</td>
    <td width="12%" align="left"><b>Mail </b></td>
    <td width="30%" colspan="4"><b>: </b><s:property value="lblmail"/></td>
    </tr>
    
    </table>
 </fieldset>
</td>
    </tr>
    
    </table>
</br> --%>

<table width="98%" class=taledrv align="center">
<tr height="25" style="background-color: #F6CECE;">
    <td width="5%" align="left" class=taledrv><b>SL#</b></td>
    <td width="5%" align="left" class=taledrv><b>Job Name</b></td>
    <td width="10%" align="left" class=taledrv><b>Driver</b></td>
    <td width="6%" align="left" class=taledrv><b>Fleet</b></td>
    <td width="4%" align="left" class=taledrv><b>Reg No</b></td>
    <td width="6%" align="left" class=taledrv><b>Client</b></td>
    <td width="5%" align="left" class=taledrv><b>Guest</b></td>
    <td width="6%" align="left" class=taledrv><b>Type</b></td>
    <td width="6%" align="left" class=taledrv><b>Block Hrs</b></td>
    <td width="5%" align="left" class=taledrv><b>Pickup Date</b></td>
    <td width="6%" align="left" class=taledrv><b>Pickup Time</b></td>
    <td width="5%" align="left" class=taledrv><b>Pickup Location</b></td>
    <td width="6%" align="left" class=taledrv><b>Pickup Address</b></td>
    <td width="6%" align="left" class=taledrv><b>Dropoff Location</b></td>
    <td width="6%" align="left" class=taledrv><b>Dropoff Address</b></td>
  </tr>
  
  <s:iterator var="stat" value='#request.printingarray' >
	<tr height="20" class=taledrv>   
			<s:iterator status="arr" value="#stat.split('::')" var="des">   
    		<td class=taledrv align="left">
		  <s:property value="#des"/>
  		</td>
  		</s:iterator>
	</tr>
	</s:iterator>
 
 </table>
 
 
<%--  <br/><br/>
<fieldset width="98%"><legend><b>Summary</b></legend>
<table width="100%" class=taledrv align="center">
<tr height="25" style="background-color: #F6CECE;">
    <td width="15%" align="left" class=taledrv><b>Type</b></td>
    <td width="30%" align="left" class=taledrv><b>Tran Code</b></td>
    <td width="15%" align="left" class=taledrv><b>Total Hours</b></td>
    <td width="15%" align="left" class=taledrv><b>Total Fuel</b></td>
    <td width="15%" align="left" class=taledrv><b>Total Km</b></td>
    </tr>
  
  <s:iterator var="stat1" value='#request.drvsumarray' >
	<tr height="20" class=taledrv>   
			<s:iterator status="arr" value="#stat1.split('::')" var="des1">   
    		<td class=taledrv align="left">
		  <s:property value="#des1"/>
  		</td>
  		</s:iterator>
	</tr>
	</s:iterator>
 
 </table>
 </fieldset>
 
 
 
 
 
 
 <br/>

<br/>
 --%>
<jsp:include page="../../../common/printFooter.jsp"></jsp:include>
<br/><br/>
</div>
</form>
</div>
</body>
</html>