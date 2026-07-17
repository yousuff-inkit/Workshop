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

fieldSet {
  		-webkit-border-radius: 8px;
  		-moz-border-radius: 8px;
  		border-radius: 8px;
  		border: 1px solid rgb(139,136,120);
  }

legend{
        border-style:none;
        background-color:#FFF;
        padding-left:1px;
    }
    
hr { 
   		border-top: 1px solid #e1e2df  ;
    }

.verticalLine {
    border-left: 1px solid black;
}

</style>



</head>
<body style="font-size:10px;background-color:white;" >
<div id="mainBG" class="homeContent" data-type="background">
<form id="clientfollowup" action="printclientfollowup" method="post" autocomplete="off" target="_blank">

<div style="background-color:white;">

<jsp:include page="printHeader.jsp"></jsp:include>

<table width="96%" align="center">
<tr><td>
<fieldset>
<table width="98%" align="center" >
  <tr>
    <td width="16%" align="left"><b>Doc No</b> </td>
    <td colspan="3"><b>:</b> <label id="lbldocno" name="lbldocno"><s:property value="lbldocno"/></label></td>
    <td width="5%" align="left"><b>Date</b> </td>
    <td width="20%" align="left"> <b>:</b> <label name="lbldate" id="lbldate" ><s:property value="lbldate"/></label></td>
  </tr>
  
  <tr>
    <td align="left"><b>Client</b> </td>
    <td colspan="3"><b>:</b> <label name="lblclient" id="lblclient" ><s:property value="lblclient"/></label></td>
    <td align="left"><b>Lpo No.</b> </td>
    <td colspan="1"><b>:</b> <label name="lbllpo" id=lbllpo ><s:property value="lbllpo"/></label></td></tr>
    <tr>
    <td align="left"><b>Address</b> </td>
    <td colspan="3">: <label name="lbladdress" id="lbladdress" ><s:property value="lbladdress"/></label></td>
    <td align="left"><b>Expected Checkin</b> </td>
    <td colspan="1"><b>:</b> <label name="lblcheckindate" id="lblcheckindate" ><s:property value="lblcheckindate"/></label></td>
  </tr>
   <tr>
    <td align="left"><b>Email.</b> </td>
    <td colspan="3"><b>:</b> <label id="lblmail" name="lblmail" ><s:property value="lblmail"/></label></td>
    <td colspan="2"></td>
    </tr>
  <tr>
    <td align="left"><b>Mobile No.</b> </td>
    <td colspan="3"><b>:</b> <label id="lblmobile" name="lblmobile" ><s:property value="lblmobile"/></label></td>
    <td colspan="2"></td>
    </tr>
    
    <tr><td colspan="3">
    <fieldset><legend><b>Driver Details</b></legend>
    <table  width="100%">
   <tr>
      <td width="10%" align="left"><b>Name&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</b></td>
    <td width="82%" align="left" colspan="3"><label id="lblradrname" name="lblradrname"><s:property value="lblradrname"/></label></td>
      
    </tr>
    </table>
        <table  width="100%"   >
    <tr>
        <td  width="10%" align="left"><b>D\L NO&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</b></td>
    <td width="77%" colspan="3">&nbsp;<label id="lblradlno" name="lblradlno"><s:property value="lblradlno"/></label></td>
    </tr></table>
    <table width="100%" >
    <tr>
   <td width="10%" align="left"><b>Exp Date&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</b></td>
    <td width="77%" colspan="3">&nbsp;<label id="lblaccount" name="licexpdate" ><s:property value="licexpdate"/></label></td>
    </tr></table >
    <table width="100%">
    <tr>
     <td width="10%" align="left"><b>Passport NO&nbsp;:</b></td>
    <td  width="77%" colspan="3">&nbsp;<label name="lblpassno" id="lblpassno" ><s:property value="lblpassno"/></label></td>
    </tr></table>
    <table width="100%" >
    <tr>
    <td width="10%" align="left"><b>Exp Date &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</b></td>
    <td width="30%">&nbsp;<label name="lblpassexpdate" id="lblpassexpdate" ><s:property value="lblpassexpdate"/></label></td>
   

    <td width="15%" align="right"><b>DOB&nbsp;&nbsp;:</b></td>
    <td width="30%">&nbsp;<label name="lbldobdate" id="lbldobdate" ><s:property value="lbldobdate"/></label></td>
    </tr>
    </table>
</fieldset>
    </tr>
    
   
</table>
</fieldset>
</td></tr>
<tr><td>
<fieldset>
<table width="98%" align="center">
  <tr>
    <td width="16%" align="left"><b>CONTRACT TYPE</b> </td>
    <td colspan="3"><b>:</b> <label id="lblcontrcttype" name="lblcontrcttype"><s:property value="lblcontrcttype"/></label></td>
  
    <td width="18%" align="left"><b>CONTRACT START DATE</b> </td>
    <td width="20%"> <b>:</b> <label name="lblstartdate" id="lblstartdate" ><s:property value="lblstartdate"/></label></td>
  </tr>
  
  <tr>
    <td align="left"><b>INVOICE TYPE </b> </td>
    <td colspan="3"><b>:</b> <label name="lblinvoicetype" id="lblinvoicetype" ><s:property value="lblinvoicetype"/></label></td>
    <td width="18%" align="left"><b>CONTRACT CLOSE DATE</b> </td>
    <td width="20%"> <b>:</b> <label name="lblclosedate" id="lblclosedate" ><s:property value="lblclosedate"/></label></td>
  </tr>
    <tr>
    <td align="left"><b>RATE</b> </td>
    <td>: <label name="lblrate" id="lblrate" ><s:property value="lblrate"/></label></td>
  </tr>
  
  <tr>
    <td align="left"><b>NORMAL OVERTIME/HR</b> </td>
    <td ><b>:</b> <label id="lblnormalover" name="lblnormalover" ><s:property value="lblnormalover"/></label></td>
    <td colspan="2"></td>
    <td align="left"><b>HOLIDAY OVERTIME/HR</b> </td>
    <td ><b>:</b> <label id="lblholidayover" name="lblholidayover" ><s:property value="lblholidayover"/></label></td>
    <td colspan="2"></td>
    </tr>
     <tr>
    <td align="left"><b>OVER TIME RATE</b> </td>
    <td ><b>:</b> <label id="lbloverrate" name="lbloverrate" ><s:property value="lbloverrate"/></label></td></tr>
	

</table>
</fieldset>
</td></tr>
</table>
<br/>

<div id="firstdiv" >

</div>


<%-- <table width="100%" style="padding-left:30px;">
  <tr>
    <td width="13%">Processed By</td>
    <td width="20%"><label id="lblcheckedby" name="lblcheckedby"><s:property value="lblcheckedby"/></label></td>
    <td width="13%">Received By</td>
    <td width="29%"><label id="lblrecievedby" name="lblrecievedby"><s:property value="lblrecievedby"/></label></td>
    <td width="4%">Date</td>
    <td width="21%"><label id="lblfinaldate" name="lblfinaldate"><s:property value="lblfinaldate"/></label></td>
   
    </tr>
  <tr>
    <td colspan="6">&nbsp;</td>
    
    </tr>
</table> --%>
<table style="width:100%;">
	<tr>
		<td width="50%"></td>
		<td width="50%">
			<table style="width:100%;">
				<tr>
					<td height="50px" valign="top" width="50%">Customer Signature</td>
					<td height="50px" valign="top" width="50%">Date</td>
				</tr>
				<tr><td colspan="2" style="padding-right:30px;"><hr style="border-top: 0.5px solid #000  ;"></td></tr>
				<tr>
					<td height="50px" valign="top" width="50%">Rental Agent Signature</td>
					<td height="50px" valign="top" width="50%">Date</td>
				</tr>
			</table>
		</td>
</table>
<br>
<table width="95%" align="center">
 <tr>
     <td colspan="3" align="center"><fieldset><font style="color: #D8D8D8;font-size: 11px;">System Generated Document Signature & Stamp Not Required.</font></fieldset></td>
  </tr>
  <tr>
  <td width="47%" style="color: #D8D8D8;" align="left"><i>Printed by <%=session.getAttribute("USERNAME")%> 
  <label id="lblfooter"></label></i></td>
  
  <td width="43%" style="color: #FAFAFA;" align="left">Powered by GATEWAY ERP</td>
  
 <td width="10%" style="color: #D8D8D8;">
    <div id="content"> 
  <div id="pageFooter"></div>
   </div>  
  </td>
  </tr>
</table>
</div>
</form>
</div>
</body>
</html>