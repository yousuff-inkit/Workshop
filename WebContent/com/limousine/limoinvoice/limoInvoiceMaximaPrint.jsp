<%@page import="javax.servlet.http.HttpSession.*"%>
<%@page import="javax.servlet.http.HttpServletRequest.*"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../includes.jsp"></jsp:include>
<link href="https://fonts.googleapis.com/css?family=Mada:700" rel="stylesheet">
<!-- media="print" -->
<style>
body{
	background-color:#fff !important;
}
 .hidden-scrollbar {
  overflow: auto;
  height: 800px;
} 
fieldSet {
  -webkit-border-radius: 8px;
  -moz-border-radius: 8px;
  border-radius: 8px;
  border: 1px solid rgb(139,136,120);
}
.saliktable{
 border:1px solid;
 border-collapse:collapse;
 }
table:last-of-type {
    page-break-after: auto
}
#pageFooter {
    display: table-footer-group;
}
#pageFooter:after {
      counter-increment: page;
      counter-reset: pages 1;
      content: "Page " counter(page) " / " counter(pages);
}
h1{
font-family: 'Mada', sans-serif;
}
</style> 
<script>
$(document).ready(function () {
	
});
function getPrint(){
	/* //alert("hgchjh");
	 document.getElementById("mode").value="print";
	document.getElementById("frmManualInvoicePrint").submit();  */
}
</script>
</head>
<body onload="" style="font-size:12px">
	<!--<div id="mainBG" class="homeContent" data-type="background">
		<form id="frmLimoInvoicePrint" action="printLimoInvoice" autocomplete="off" target="_blank">
 			<jsp:include page="../../common/printHeader.jsp"></jsp:include> 
			
		</form>
	</div>-->
	<%-- <table style="width:100%;">
		<tr>
			<td><jsp:include page="../../common/printHeader.jsp"></jsp:include></td>
		</tr>
	</table> --%>
	<form id="frmLimoInvoicePrint" action="printLimoInvoice" autocomplete="off" target="_blank">
	<div style="margin-top:150px;"></div>
	<h1 style="text-align:center;"><s:property value="lblprintname"/></h1>
    <fieldset>
		<table width="100%" border="0">
              <tr>
                <td width="11%">Client</td>
                <td colspan="3">:&nbsp;<label name="lblclient" id="lblclient"><s:property value="lblclient"/></label>
                </td>
                <td width="17%">Invoice</td>
                <td width="17%">:&nbsp;<label name="lblvocno" id="lblvocno"><s:property value="lblvocno"/></label></td>
              </tr>
              <tr>
                <td width="11%">Code</td>
                <td colspan="3">:&nbsp;<label name="lblcode" id="lblcode"><s:property value="lblcldocno"/></label></td>
				<td>Date</td>
                <td>:&nbsp;<label name="lbldate" id="lbldate"><s:property value="lbldate"/></label></td>
				
              </tr>
              <tr>
                <td width="11%">Address</td>
                <td colspan="3">:&nbsp;<label name="lbladdress" id="lbladdress"><s:property value="lbladdress"/></label>
                </td>
              </tr>
              <tr>
                <td width="11%">&nbsp;</td>
                <td colspan="3">:&nbsp;<label name="lbladdressother" id="lbladdressother"><s:property value="lbladdressother"/></label>
                </td>
              </tr>
              <tr>
                <td width="11%">Mobile No</td>
                <td colspan="3">:&nbsp;<label name="lblmobileno" id="lblmobileno"><s:property value="lblmobileno"/></label>
                </td>
              </tr>
              <tr>
                <td width="11%">Mail</td>
                <td colspan="3">:&nbsp;<label name="lblmail" id="lblmail"><s:property value="lblmail"/></label>
                <td>Event</td>
                <td>:&nbsp;<label name="lblevent" id="lblevent"><s:property value="lblevent"/></label></td>
                </td>
              </tr>
              <%-- <tr>
                <td>Details</td>
                <td colspan="3">:&nbsp;<label name="lbldetails" id="lbldetails"><s:property value="lbldetails"/></label></td>
              </tr> --%>
              <tr>
                <td>From Date</td>
                <td width="21%">:&nbsp;<label name="lblfromdate" id="lblfromdate"><s:property value="lblfromdate"/></label></td>
                <td width="17%">&nbsp;</td>
                <td width="17%">&nbsp;</td>
                <td>LPO No</td>
                <td>:&nbsp;<label name="lbllpo" id="lbllpo"><s:property value="lbllpo"/></label></td>
              </tr>
              <tr>
                <td>To Date</td>
                <td>:&nbsp;<label name="lbltodate" id="lbltodate"><s:property value="lbltodate"/></label></td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>Currency</td>
                <td>:&nbsp;<label name="lblcurrencycode" id="lblcurrencycode"><s:property value="lblcurrencycode"/></label></td>
              </tr>
              <!--<tr>
                <td>Details</td>
                <td colspan="3">:</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
              </tr>
				<label name="lblguest" id="lblguest"><s:property value="lblguest"/></label>
              <tr>
                <td>Booked By</td>
                <td colspan="2">:&nbsp;<label name="lblbookedby" id="lblbookedby"><s:property value="lblbookedby"/></label></td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
              </tr>-->
        </table>
      </fieldset>
      <br>
      <fieldset>
      	<table width="100%" border="0">
          <tr>
            <td width="5%"><b>SL No</b></td>
            <td width="6%"><b>Book No</b></td>
            <td width="10%"><b>Pickup Date</b></td>
            <td width="8%"><b>Time</b></td>
            <td width="12%"><b>Vehicle</b></td>
            <td width="17%"><b>Pickup Loc</b></td>
            <td width="13%"><b>Dropoff Loc</b></td>
            <td width="9%"><b>Srvc Type</b></td>
            <td width="11%"><b>Total</b></td>
          </tr>
        <s:iterator var="stat1" status="arr" value="%{#request.INVDETAIL}" >
		  	<s:iterator status="arr" value="#stat1" var="stat">    
				<tr>   
					<s:iterator status="arr" value="#stat.split('::')" var="des">
						<td><s:property value="#des"/></td>
					</s:iterator>
				</tr>
			</s:iterator>
		</s:iterator>
       </table>
      </fieldset>
      <hr>
	<table width="100%" >
	  <tr>
	    <td width="197" align="left">Total :</td>
	    <td width="752">&nbsp;</td>
	    <td width="163">&nbsp;</td>
	    <td width="146" align="right"><b><label id="lbltotal" name="lbltotal"><s:property value="lbltotal"/></label></b></td>
	  </tr>
	  <!--<tr>
	    <td align="left"><b>Net Amount :</b></td>
	    <td>&nbsp;</td>
	    <td>&nbsp;</td>
	    <td align="right"><b><label id="lblnetamount" name="lblnetamount"><s:property value="lblnetamount"/></label><b></td>
	  </tr>-->
	  <tr>
	    <td align="left"><b>Amount In Words : </b></td>
	    <td colspan="3" align="right"><b><label id="lblamountwords" name="lblamountwords"><s:property value="lblamountwords"/></label></b></td>
	    </tr>
	</table>
      <div id="bottompage" style="margin-top:60px;">
<table width="100%" >
  <tr>
    <td width="13%">Processed By</td>
    <td width="20%"><label id="lblcheckedby" name="lblcheckedby"><s:property value="lblcheckedby"/></label></td>
    <td width="13%">Checked By</td>
    <td width="22%"><label id="lblrecievedby" name="lblrecievedby"><s:property value="lblrecievedby"/></label></td>
    <td width="12%">Recieved By</td>
    <td width="21%">&nbsp;</td>
    
   
    </tr>
  <tr>
    <td colspan="4" height="85px">&nbsp;</td>
    <td width="6%">Date</td>
    <td width="21%"><!-- <label id="lblfinaldate" name="lblfinaldate" style="padding-top:30px;"><s:property value="lblfinaldate"/></label> --></td>
    
    </tr>
</table>
</div>
</form>
</body>
</html>
