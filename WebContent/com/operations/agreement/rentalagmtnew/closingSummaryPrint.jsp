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
fieldset {
  -webkit-border-radius: 8px;
  -moz-border-radius: 8px;
  border-radius: 8px;
  border: 1px solid rgb(139,136,120);

 }
 
 legend
    {
        border-style:none;
        background-color:#FFF;
        padding-left:1px;
    }
    
.tablereceipt {
    border: 1px solid black;
    border-collapse: collapse;
}
</style>

</head>
<body bgcolor="white" style="font-size:10px;">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmRAClosingSummary" action="printRAClosingSummary" method="post" autocomplete="off" target="_blank">

<div style="background-color:white;">
<table width="100%">
  <tr>
    <td width="18%" rowspan="6"><img src="<%=contextPath%>/icons/epic.jpg" width="100" height="91"  alt=""/></td>
    <td width="57%" rowspan="2">&nbsp;</td>
    <td width="25%"><font size="3"><label id="companyname" name="companyname"><s:property value="companyname"/></label></font></td>
  </tr>
  <tr>
    <td><b><label id="address" name="address"><s:property value="address"/></label></b></td>
  </tr>
  <tr>
    <td rowspan="2"  align="center"><b><font size="5">Closing Summary</font></b></td>
    <td align="left"><b>Tel :</b>&nbsp;<label id="mobileno" name="mobileno"><s:property value="mobileno"/></label></td>
  </tr>
  <tr>
    <td align="left"><b>Fax :</b>&nbsp;<label id="fax" name="fax"><s:property value="fax"/></label></td>
  </tr>
  <tr>
    <td rowspan="2">&nbsp;</td>
    <td align="left"><b>Branch :</b>&nbsp;<label id="branchname" name="branchname"><s:property value="branchname"/></label></td>
  </tr>
  <tr>
    <td align="left"><b>Location :</b>&nbsp;<label id="location" name="location"><s:property value="location"/></label></td>
  </tr>
  <tr>
    <td colspan="3"><hr noshade size=1 width="100%"></td>
  </tr>
</table>
<table width="100%">
  <tr>
    <td width="6%" align="right"><b>Client :</b></td>
    <td width="40%"><label id="lblclientname" name="lblclientname"><s:property value="lblclientname"/></label></td>
    <td width="8%" align="right"><b>Vehicle :</b></td>
    <td width="46%"><label id="lblfleetno" name="lblfleetno"><s:property value="lblfleetno"/></label>&nbsp;&nbsp;
    <label id="lblfleetname" name="lblfleetname"><s:property value="lblfleetname"/></label></td>
  </tr>
</table><br/>
<table width="100%">
<tr><td width="50%">
<fieldset><legend><b>Out Details</b></legend>
<table width="100%"> 
  <tr>
    <td width="18%" align="left"><b>Date :</b></td>
    <td width="36%"><label id="lbldateout" name="lbldateout"><s:property value="lbldateout"/></label></td>
 
    <td width="20%" align="left"><b>Time&nbsp;:</b></td>
    <td width="26%"><label id="lbltimeout" name="lbltimeout"><s:property value="lbltimeout"/></label></td>
    </tr>
       <tr>
    <td align="left"><b>KM&nbsp;&nbsp;:</b></td>
    <td ><label id="lblkmout" name="lblkmout"><s:property value="lblkmout"/></label></td>
 
    <td  align="left"><b>Fuel  :</b></td>
    <td><label id="lblfuelout" name="lblfuelout"><s:property value="lblfuelout"/></label></td>
    </tr>
     </table></fieldset></td>
<td width="50%">
<fieldset><legend><b>In Details</b></legend>
 <table width="100%"> 
  <tr>
    <td width="18%" align="left"><b>Date :</b></td>
    <td width="36%"><label id="lbldatein" name="lbldatein"><s:property value="lbldatein"/></label></td>
 
    <td width="20%" align="left"><b>Time&nbsp;:</b></td>
    <td width="26%"><label id="lbltimein" name="lbltimein"><s:property value="lbltimein"/></label></td>
    </tr>
       <tr>
    <td align="left"><b>KM&nbsp;&nbsp;:</b></td>
    <td ><label id="lblkmin" name="lblkmin"><s:property value="lblkmin"/></label></td>
 
    <td  align="left"><b>Fuel  :</b></td>
    <td><label id="lblfuelin" name="lblfuelin"><s:property value="lblfuelin"/></label></td>
    </tr>
 </table></fieldset></td></tr></table>
 
 <s:if test="#request.printingreplacementarray!=null" >
 <h2><u>Replacement</u></h2>
 <table width="99%" class=tablereceipt align="center">
 <tr style="background-color: #CEECF5;">
    <td height="20" align="center" class=tablereceipt><b>In Fleet</b></td>
    <td align="center" class=tablereceipt><b>In Date</b></td>
    <td align="center" class=tablereceipt><b>In Time</b></td>
    <td align="center" class=tablereceipt><b>Out Fleet</b></td>
    <td align="center" class=tablereceipt><b>Out Date</b></td>
    <td align="center" class=tablereceipt><b>Out Time</b></td>
  </tr>
  
    <s:iterator var="stat" value='#request.printingreplacementarray' >
	<tr class=tablereceipt>   
    	<s:iterator status="arr" value="#stat.split('::')" var="des">   
    	<td class=tablereceipt align="center">
		    <s:property value="#des"/>
    	</td>
 		</s:iterator>
	</tr>
	</s:iterator>
</table>
</s:if>

<h2><u>Account Info</u></h2>
<s:if test="#request.printingotherreceiptarray!=null" >
<table width="99%" class=tablereceipt align="center">
  <tr style="background-color: #F6CECE;">
    <td width="8%" height="20" align="center" class=tablereceipt><b>Date</b></td>
    <td width="9%" align="center" class=tablereceipt><b>Type</b></td>
    <td width="8%" align="center" class=tablereceipt><b>Doc No</b></td>
    <td width="52%" align="center" class=tablereceipt><b>Description</b></td>
    <td width="12%"  align="right" class=tablereceipt><b>Debit</b></td>
    <td width="11%"  align="right" class=tablereceipt><b>Credit</b></td>
  </tr>
  
    <s:iterator var="stat" value='#request.printingotherreceiptarray' >
	<tr class=tablereceipt>   
		<%int i=0; %>
    	<s:iterator status="arr" value="#stat.split('::')" var="des">   
    	<% if(i==3){%>
    	<td class=tablereceipt align="left">
		    <s:property value="#des"/>
    	</td>
     	<%} else if(i>3){%>
  		<td class=tablereceipt align="right">
		    <s:property value="#des"/>
  			</td>
   		<%} else{ %>
  		<td class=tablereceipt align="center">
		  <s:property value="#des"/>
  		</td>
  		<% } i++;  %>
 		</s:iterator>
	</tr>
	</s:iterator>
	
	<tr>
    	<td colspan="4" class="tablereceipt" height="22" align="left"><b>Total</b></td>
    	<td class="tablereceipt" align="right"><b><label id="lblsumotherdebit" name="lblsumotherdebit"><s:property value="lblsumotherdebit"/></label></b></td>
    	<td class="tablereceipt" align="right"><b><label id="lblsumothercredit" name="lblsumothercredit"><s:property value="lblsumothercredit"/></label></b></td>
  	</tr>
</table><br/>
</s:if>

<s:if test="#request.printingcashreceiptarray!=null" >
<table width="99%" class=tablereceipt align="center">
  <tr style="background-color: #F6CECE;">
    <td width="8%" height="20" align="center" class=tablereceipt><b>Date</b></td>
    <td width="9%" align="center" class=tablereceipt><b>Type</b></td>
    <td width="8%" align="center" class=tablereceipt><b>Doc No</b></td>
    <td width="52%" align="center" class=tablereceipt><b>Description</b></td>
    <td width="12%"  align="right" class=tablereceipt><b>Debit</b></td>
    <td width="11%"  align="right" class=tablereceipt><b>Credit</b></td>
  </tr>
  
    <s:iterator var="stat" value='#request.printingcashreceiptarray' >
	<tr class=tablereceipt>   
		<%int i=0; %>
    	<s:iterator status="arr" value="#stat.split('::')" var="des">   
    	<% if(i==3){%>
    	<td class=tablereceipt align="left">
		    <s:property value="#des"/>
    	</td>
     	<%} else if(i>3){%>
  		<td class=tablereceipt align="right">
		    <s:property value="#des"/>
  			</td>
   		<%} else{ %>
  		<td class=tablereceipt align="center">
		  <s:property value="#des"/>
  		</td>
  		<% } i++;  %>
 		</s:iterator>
	</tr>
	</s:iterator>
	
	<tr>
    	<td colspan="4" class="tablereceipt" height="22" align="left"><b>Total</b></td>
    	<td class="tablereceipt" align="right"><b><label id="lblsumcrvdebit" name="lblsumcrvdebit"><s:property value="lblsumcrvdebit"/></label></b></td>
    	<td class="tablereceipt" align="right"><b><label id="lblsumcrvcredit" name="lblsumcrvcredit"><s:property value="lblsumcrvcredit"/></label></b></td>
  	</tr>
</table><br/>
</s:if>

<table width="100%">
<tr>
		<td width="92%" align="right" style="font-family: Myriad Pro;font-size: 12px;font-weight: bold;">Balance :&nbsp;</td>
        <td width="8%" align="left"><b><label id="lblnetbalance" name="lblnetbalance"><s:property value="lblnetbalance"/></label></b></td>
</tr>
</table><br/><br/>
<!-- <table width="100%">
  <tr>
    <td style="color: #D8D8D8;"><b><center>Powered by GATEWAY ERP</center></b></td>
  </tr>
</table> --><br/><br/><br/><br/>
</div>
</form>
</div>
</body>
</html>
