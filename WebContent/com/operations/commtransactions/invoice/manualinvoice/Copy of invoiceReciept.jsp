<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<!-- <link rel="stylesheet" type="text/css" href="../../../../css/body.css">  -->
<%--  <jsp:include page="../../../../../includes.jsp"></jsp:include>  --%>
<style>
 .hidden-scrollbar {
  overflow: auto;
  height: 800px;
} 

</style> 
<script>
function getPrint(){
	alert("hgchjh");
	 document.getElementById("mode").value="print";
	document.getElementById("frmManualInvoicePrint").submit(); 
}
</script>
</head>
<body onload="" bgcolor="white" style="font-size:14px;" >
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmManualInvoicePrint" action="printManualInvoice" autocomplete="off" target="_blank">
<%-- <jsp:include page="../../../../../header.jsp"></jsp:include> --%> <br/> 
 <div style="background-color:white;">
  <table width="100%" >
    <tr>
      <td width="23%" rowspan="4"><img src="../../../../../icons/nokia12.gif" width="288" height="91"  alt=""/></td>
      <td width="20%">&nbsp;</td>
      <td width="28%">&nbsp;</td>
      <td width="29%"><b><label id="lblcompname" name="lblcompname" ><s:property value="lblcompname"/></label></b></td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td><label id="lblcompaddress" name="lblcompaddress"><s:property value="lblcompaddress"/></label></td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td align="right">Tel :</td>
      <td><label id="lblcomptel" name="lblcomptel"><s:property value="lblcomptel"/></label></td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td align="right">Fax :</td>
      <td><label name="lblcompfax" id="lblcompfax" ><s:property value="lblcompfax"/></label></td>
    </tr>
    <tr>
      <td>Branch :<label id="lblbranch" name="lblbranch" ><s:property value="lblbranch"/></label></td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
  </table>
<hr>
<center><h3>Invoice</h3></center>
<fieldset>
<table width="100%">
  <tr>
    <td width="9%" align="right">Client :</td>
    <td width="23%"><label id="lblclient" name="lblclient"><s:property value="lblclient"/></label></td>
    <td width="13%">&nbsp;</td>
    <td width="14%">&nbsp;</td>
    <td width="13%" align="right">INV No :</td>
    <td width="28%"><label name="lblinvno" id="lblinvno" ><s:property value="lblinvno"/></label></td>
  </tr>
  <tr>
    <td align="right">A/c No : </td>
    <td><label id="lblaccount" name="lblaccount" ><s:property value="lblaccount"/></label></td>
    <td align="right">MRA No :</td>
    <td><label name="lblmranno" id="lblmrano" ><s:property value="lblmrano"/></label></td>
    <td align="right">Date :</td>
    <td><label name="lbldate" id="lbldate" ><s:property value="lbldate"/></label></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td align="right">RA No :</td>
    <td><label name="lblrano" id="lblrano" ><s:property value="lblrano"/></label></td>
  </tr>
  <tr>
    <td align="right">Mobile :</td>
    <td><label name="lblmobile" id="lblmobile" ><s:property value="lblmobile"/></label></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td align="right">Type :</td>
    <td><label name="lblratype" id="lblratype" ><s:property value="lblratype"/></label></td>
  </tr>
  <tr>
    <td align="right"> Phone :</td>
    <td><label name="lblphone" id="lblphone" ><s:property value="lblphone"/></label></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td align="right">Inv From :</td>
    <td><label name="lblinvfrom" id="lblinvfrom" ><s:property value="lblinvfrom"/></label></td>
  </tr>
  <tr>
    <td align="right">Fax :</td>
    <td><label id="lblfax" name="lblfax" ><s:property value="lblfax"/></label></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td align="right">To :</td>
    <td><label name="lblinvto" id="lblinvto" ><s:property value="lblinvto"/></label></td>
  </tr>
  <tr>
    <td align="right">Driven :</td>
    <td><label id="lbldriven" name="lbldriven" ><s:property value="lbldriven"/></label></td>
    <td align="right">Contract Start :</td>
    <td><label id="lblcontractstart" name="lblcontractstart"><s:property value="lblcontractstart"/></label></td>
    <td align="right">Contract Vehicle :</td>
    <td><label name="lblcontractvehicle" id="lblcontractvehicle" ><s:property value="lblcontractvehicle"/></label></td>
  </tr>
</table>
</fieldset>
<hr>
<table width="100%">
  <tr>
    <td align="center">SI No</td>
    <td align="left">Charge Description</td>
    <td align="center">Units</td>
    <td align="center">Rate</td>
    <td align="center">Total</td>
  </tr>
  <tr>
    <td align="center">1</td>
    <td align="left">RENTAL CHARGES</td>
    <td align="center">&nbsp;</td>
    <td align="center">&nbsp;</td>
    <td align="center">&nbsp;</td>
  </tr>
  <tr>
    <td align="center">2</td>
    <td align="left">ACCESSORIES RENTAL</td>
    <td align="center">&nbsp;</td>
    <td align="center">&nbsp;</td>
    <td align="center">&nbsp;</td>
  </tr>
  <tr>
    <td align="center">3</td>
    <td align="left">CHUFFER CHARGES</td>
    <td align="center">&nbsp;</td>
    <td align="center">&nbsp;</td>
    <td align="center">&nbsp;</td>
  </tr>
  <tr>
    <td align="center">4</td>
    <td align="left">EXTRA KM CHARGES </td>
    <td align="center">&nbsp;</td>
    <td align="center">&nbsp;</td>
    <td align="center">&nbsp;</td>
  </tr>
  <tr>
    <td align="center">5</td>
    <td align="left">EXTRA HOUR CHARGES</td>
    <td align="center">&nbsp;</td>
    <td align="center">&nbsp;</td>
    <td align="center">&nbsp;</td>
  </tr>
  <tr>
    <td align="center">6</td>
    <td align="left">DELIVERY/COLLECTION CHARGES</td>
    <td align="center">&nbsp;</td>
    <td align="center">&nbsp;</td>
    <td align="center">&nbsp;</td>
  </tr>
  <tr>
    <td align="center">7</td>
    <td align="left">EXTRA INSURANCE CHARGES</td>
    <td align="center">&nbsp;</td>
    <td align="center">&nbsp;</td>
    <td align="center">&nbsp;</td>
  </tr>
  <tr>
    <td align="center">8</td>
    <td align="left">SALIK</td>
    <td align="center">&nbsp;</td>
    <td align="center">&nbsp;</td>
    <td align="center">&nbsp;</td>
  </tr>
  <tr>
    <td align="center">9</td>
    <td align="left">TRAFFIC FINE</td>
    <td align="center">&nbsp;</td>
    <td align="center">&nbsp;</td>
    <td align="center">&nbsp;</td>
  </tr>
  <tr>
    <td align="center">10</td>
    <td align="left">DAMAGES</td>
    <td align="center">&nbsp;</td>
    <td align="center">&nbsp;</td>
    <td align="center">&nbsp;</td>
  </tr>
  <tr>
    <td align="center">11</td>
    <td align="left">FUEL CHARGES</td>
    <td align="center">&nbsp;</td>
    <td align="center">&nbsp;</td>
    <td align="center">&nbsp;</td>
  </tr>
  <tr>
    <td align="center">12</td>
    <td align="left">OTHERS</td>
    <td align="center">&nbsp;</td>
    <td align="center">&nbsp;</td>
    <td align="center">&nbsp;</td>
  </tr>
  <tr>
    <td align="center">13</td>
    <td align="left">DISCOUNT</td>
    <td align="center">&nbsp;</td>
    <td align="center">&nbsp;</td>
    <td align="center">&nbsp;</td>
  </tr>
</table>
<hr>
<table width="100%" >
  <tr>
    <td width="141" align="right">Total :</td>
    <td colspan="2">&nbsp;</td>
    <td width="148">&nbsp;</td>
    <td width="161">0.0</td>
  </tr>
  <tr>
    <td align="right">Net Amount :</td>
    <td colspan="2">&nbsp;</td>
    <td>&nbsp;</td>
    <td>0.0</td>
  </tr>
  <tr>
    <td align="right">Amount In Words : </td>
    <td width="308">&nbsp;</td>
    <td colspan="3">&nbsp;</td>
    </tr>
</table>
<hr>
<table width="100%" >
  <tr>
    <td width="33%">Checked By</td>
    <td width="42%">Recieved By</td>
    <td width="25%">Date</td>
    </tr>
  <tr>
    <td colspan="3">&nbsp;</td>
    </tr>
</table>

</div>
<input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'/>
</form>
</div>
</body>
</html>
