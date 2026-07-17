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

 hr { 
   border-top: 1px solid #e1e2df  ;
    } 
</style>

</head>
<body bgcolor="white" style="font-size:10px;">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmRentalRefundVoucher" action="printRentalRefund" method="post" autocomplete="off" target="_blank">

<div style="background-color:white;">

<jsp:include page="../../../common/printDrivenHeader.jsp"></jsp:include>

<table width="99%">
  <tr>
    <td width="46%"><b>Received with Thanks From</b></td>
    <td width="8%" align="right"><b>RA No. :</b></td>
    <td width="18%"><label id="rentalno" name="rentalno"><s:property value="rentalno"/></label></td>
    <td width="14%" align="right"><b>Receipt No :</b></td>
    <td width="14%"><label id="receiptno" name="receiptno"><s:property value="receiptno"/></label></td>
  </tr>
  <tr>
    <td><label id="receivedfrom" name="receivedfrom"><s:property value="receivedfrom"/></label></td>
    <td align="right"><b>RA Type :</b></td>
    <td><label id="rentaltype" name="rentaltype"><s:property value="rentaltype"/></label></td>
    <td align="right"><b>Receipt Date :</b></td>
    <td><label id="receiptdate" name="receiptdate"><s:property value="receiptdate"/></label></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td align="right"><b>Ref. No. :</b></td>
    <td><label id="refno" name="refno"><s:property value="refno"/></label></td>
    <td align="right"><b>Contract Start :</b></td>
    <td><label id="contractstart" name="contractstart"><s:property value="contractstart"/></label></td>
  </tr>
</table><br/>
<table width="100%" class=tablereceipt>
  <tr class=tablereceipt style="background-color: #F6CECE;">
    <td class=tablereceipt height="25" colspan="2" align="center"><b>Description</b></td>
    <td class=tablereceipt width="21%" align="center"><b>Payment Mode</b></td>
    <td class=tablereceipt width="20%" align="right"><b>Amount</b></td>
  </tr>
  <tr class=tablereceipt>
    <td colspan="2" class=tablereceipt>
 <table width="100%">
       <tr>
	    <td colspan="4"><label id="lbladvancesecurity" name="lbladvancesecurity"><s:property value="lbladvancesecurity"/></label></td>
	  </tr>
	  <tr>
	    <td colspan="4"><label id="lbldescription" name="lbldescription"><s:property value="lbldescription"/></label></td>
	  </tr>
	  <tr>
	    <td width="18%" align="right"><b>Card No. :</b></td>
	    <td width="39%"><label id="cardno" name="cardno"><s:property value="cardno"/></label></td>
	    <td width="23%" align="right"><b>Card Exp. :</b></td>
	    <td width="20%"><label id="cardexp" name="cardexp"><s:property value="cardexp"/></label></td>
	  </tr>
	  <tr>
	    <td align="right"><b>Cheque No. :</b></td>
	    <td><label id="chqno" name="chqno"><s:property value="chqno"/></label></td>
	    <td align="right"><b>Cheque Date :</b></td>
	    <td><label id="chqdate" name="chqdate"><s:property value="chqdate"/></label></td>
	  </tr>
</table>
    
    </td>
    <td align="center" class=tablereceipt><label id="paymode" name="paymode"><s:property value="paymode"/></label></td>
    <td align="right" class=tablereceipt><label id="amount" style="text-align: right;" name="amount"><s:property value="amount"/></label></td>
  </tr>
  <tr class=tablereceipt height="25">
    <td width="18%" align="right"><b>Amount in Words :&nbsp;</b></td>
    <td width="41%"><label id="amtinwords" name="amtinwords"><s:property value="amtinwords"/></label></td>
    <td align="right" class=tablereceipt><b>Total&nbsp;&nbsp;&nbsp;</b></td>
    <td align="right"><label id="total" style="text-align: right;" name="total"><s:property value="total"/></label></td>
  </tr>
</table><br/><br/>
<table width="100%">
  <tr>
    <td width="11%" align="left"><b>Prepared by :</b></td>
    <td width="25%"><label id="preparedby" name="preparedby"><s:property value="preparedby"/></label></td>
    <td width="21%">&nbsp;</td>
    <td width="16%" align="right"><b>Received by :</b></td>
    <td width="27%"><hr style="border:0;border-bottom: 1px dashed #ccc;" size=1 width="100%"></td>
  </tr>
</table><br/><br/>

<jsp:include page="../../../common/printFooter.jsp"></jsp:include>
</div>
</form>
</div>
</body>
</html>
