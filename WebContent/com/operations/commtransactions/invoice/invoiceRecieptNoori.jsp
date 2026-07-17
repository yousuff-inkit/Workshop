<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
 <link rel="stylesheet" type="text/css" href="../../../../css/body.css">
<%--  <jsp:include page="../../../../../includes.jsp"></jsp:include>  --%>
<style>
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
   #pageFooter {
    display: table-footer-group;
}
 table:last-of-type {
    page-break-after: auto
}
#pageFooter:after {
      counter-increment: page;
      counter-reset: pages 1;
      content: "Page " counter(page) " / " counter(pages);
}
/*    .divFooter
{
    position:absolute;
    left:0;
    bottom:0;
    width:100%;
} */
/*  .divFooter {

  }
  @media print {
thead { display: table-header-group; }
tfoot { display: table-footer-group; }
}
@media screen {
thead { display: block; }
tfoot { display: block; }
} */
#pageFooter:after {
      counter-increment: page;
      counter-reset: pages 1;
      content: "Page " counter(page) " / " counter(pages);
}
</style> 
<script>
function getPrint(){
	//alert("hgchjh");
	 document.getElementById("mode").value="print";
	document.getElementById("frmManualInvoicePrint").submit(); 
}
</script>
</head>
<body onload="" bgcolor="white">
<div id="mainBG" class="homeContent" data-type="background">
<s:set name="counter" value="0"></s:set>
<s:set name="salik" value="#lblsalikcount"></s:set>
<s:iterator value='#request.TRIAL' var="#aa" status="arr">
<form id="frmManualInvoicePrint" action="printManualInvoice" autocomplete="off" target="_blank">
<%-- <jsp:include page="../../../../../header.jsp"></jsp:include> --%> <br/> 

 <div style="background-color:white;">
 <jsp:include page="../../../common/printDrivenHeader.jsp"></jsp:include> 
<fieldset>
<table width="100%">
  <tr>
    <td width="16%" align="left">Customer Name </td>
    <td colspan="2">: <label id="lblclient" name="lblclient"><s:property value="lblclient"/></label></td>
    <td width="22%">&nbsp;</td>
    <td width="12%" align="left">INV No </td>
    <td width="20%">: <label name="lblbranchcode" id="lblbranchcode" ><s:property value="lblbranchcode"/>/</label><label name="lbldateyear" id="lbldateyear" ><s:property value="lbldateyear"/>/</label><label name="lblinvno" id="lblinvno" ><s:property value="lblinvno"/></label></td>
  </tr>
  <tr>
    <td align="left">Customer Code </td>
    <td width="18%">: <label id="lblaccount" name="lblaccount" ><s:property value="lblaccount"/></label></td>
    <td width="12%" align="left">&nbsp;</td>
    <td></td>
    <td align="left">Date </td>
    <td>: <label name="lbldate" id="lbldate" ><s:property value="lbldate"/></label></td>
  </tr>
  <tr>
    <td align="left">Address </td>
    <td>: <label name="lbladdress1" id="lbladdress1" ><s:property value="lbladdress1"/></label></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td align="left">RA No </td>
    <td>: <label name="lblrano" id="lblrano" ><s:property value="lblrano"/></label></td>
  </tr>
  <tr>
    <td align="left">&nbsp;</td>
    <td>: <label name="lbladdress2" id="lbladdress2" ><s:property value="lbladdress2"/></label></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td align="left">LPO No</td>
    <td>: <label name="lbllpono" id="lbllpono" ><s:property value="lbllpono"/></label></td>
  </tr>
  <tr>
    <td align="left">&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td align="left">Branch</td>
    <td>: <label id="lblbranch" name="lblbranch" ><s:property value="lblbranch"/></label></td>
  </tr>
  <tr>
    <td align="left">Mobile </td>
    <td>: <label name="lblmobile" id="lblmobile" ><s:property value="lblmobile"/></label></td>
    <td align="left">&nbsp;</td>
    <td></td>
    <td align="left">Type </td>
    <td>: <label name="lblratype" id="lblratype" ><s:property value="lblratype"/></label></td>
  </tr>
  <tr>
    <td align="left"> Phone </td>
    <td>: <label name="lblphone" id="lblphone" ><s:property value="lblphone"/></label></td>
    <td align="left">&nbsp;</td>
    <td></td>
    <td align="left">Contract Start </td>
    <td>: <label id="lblcontractstart" name="lblcontractstart"><s:property value="lblcontractstart"/></label></td>
  </tr>
  <tr>
    <td align="left">Driven </td>
    <td colspan="3">: <label id="lbldriven" name="lbldriven" ><s:property value="lbldriven"/></label></td>
    <td colspan="2">Inv From : <label name="lblinvfrom" id="lblinvfrom" ><s:property value="lblinvfrom"/></label> To :<label name="lblinvto" id="lblinvto" ><s:property value="lblinvto"/></label></td>
    </tr>
   
     
</table>
</fieldset>
<br>
<fieldset>
  <table width="100%" >
    <tr>
      <td width="15%" align="right"> Contract Vehicle  </td>
      <td width="85%">: <label name="lblcontractvehicle" id="lblcontractvehicle" >
        <s:property value="lblcontractvehicle"/>
      </label></td>
    </tr>
  
  </table>
</fieldset>
<hr>

<table width="100%">
 <tr>
    <td align="left">SI No</td>
    <td align="left">Charge Description</td>
    <td align="right">Units</td>
    <td align="right">Rate</td>
    <td align="right">Total</td>
  </tr>
  
 <s:iterator var="stat1" status="arr" value="%{#request.INVPRINT}" >
		 <s:if test="#arr.index==#counter">
		
		    <s:iterator status="arr" value="#stat1" var="stat">    
<tr>   
<%int i=0; %>
    <s:iterator status="arr" value="#stat.split('::')" var="des">   
    <%
    if(i>1){%>
    
  <td  align="right">
  <s:property value="#des"/>
  </td>
   <%} else{ %>
    
  <td  align="left">
  <s:property value="#des"/>
  </td>
  <% } i++;  %>
 </s:iterator>
</tr>
</s:iterator>
</s:if>
</s:iterator>
</table>
<hr>
<table width="100%" >
  <tr>
    <td width="166" align="left">Total :</td>
    <td width="783">&nbsp;</td>
    <td width="163">&nbsp;</td>
    <td width="146" align="right"><b><label id="lbltotal" name="lbltotal"><s:property value="lbltotal"/></label></b></td>
  </tr>
  <tr>
    <td align="left"><b>Net Amount :</b></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td align="right"><b><label id="lblnetamount" name="lblnetamount"><s:property value="lblnetamount"/></label><b></td>
  </tr>
  <tr>
    <td align="left"><b>Amount In Words : </b></td>
    <td colspan="3" align="right"><b><label id="lblamountwords" name="lblamountwords"><s:property value="lblamountwords"/></label></b></td>
    </tr>
</table>
<hr>
<table width="100%">

   <s:iterator var="stat2" status="arr" value='#request.FLEETPRINT' >
   <s:if test="#arr.index==#counter">
<tr>
 <s:iterator status="arr" value="#stat2" var="des2"> 
<td  align="left"><b>Other Fleets</b></td>
  <td><s:property value="#des2"/> </td>

  </tr>
  </s:iterator>
  </s:if>
  </s:iterator>
  
</table>
<hr>
<div id="bottompage">
<table width="100%" >
  <tr>
    <td width="13%">Checked By</td>
    <td width="20%"><label id="lblcheckedby" name="lblcheckedby"><s:property value="lblcheckedby"/></label></td>
    <td width="13%">Received By</td>
    <td width="29%"><label id="lblrecievedby" name="lblrecievedby"><s:property value="lblrecievedby"/></label></td>
    <td width="4%">Date</td>
    <td width="21%"><label id="lblfinaldate" name="lblfinaldate"><s:property value="lblfinaldate"/></label></td>
    </tr>
  <tr>
    <td colspan="6">&nbsp;</td>
    </tr>
</table>
</div>

<%--  <div class="divFooter">
 
<table width="250%">
<tr>
    <td colspan="3" align="left" style="color: #D8D8D8;">System Generated Document Signataure Not Required.</td>
  </tr>
  <tr>
  <td width="60%" style="color: #D8D8D8;" align="left"><i>Printed by <%=session.getAttribute("USERNAME")%> 
  <label id="lblfooter"></label></i></td>
  
  <td width="30%" style="color: #D8D8D8;" align="left"><b>Powered by GATEWAY ERP</b></td>
  
 <td width="80%" style="color: #D8D8D8;" align="right">
    <div id="content"> 
  <div id="pageFooter" ></div>
   </div>  
  </td>
  </tr>
</table>

</div>  --%>
<!--<table style="width:100%;"><tr><td><jsp:include page="../../../common/printFooter.jsp"></jsp:include></td></tr></table>-->
<s:if test="#arr.index!=#request.TRIAL.size-1">
<DIV style="page-break-after:always"></DIV>
</s:if>
</div>
<input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'/>
</form>
<s:set name="counter" value="%{#counter+1}" />
</s:iterator>
</div>
</body>
</html>
