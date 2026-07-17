
<%@page import="javax.servlet.http.HttpSession.*"%>
<%@page import="javax.servlet.http.HttpServletRequest.*"%>
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
   <jsp:include page="../../../../includes.jsp"></jsp:include>  
<style media="print">
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
table tr td{
	page-break-inside:avoid;
}

 table.print-friendly tr td, table.print-friendly tr th {
        page-break-inside: avoid;
    }
#pageFooter {
    display: table-footer-group;
}

#pageFooter:after {
      counter-increment: page;
      counter-reset: pages 1;
      content: "Page " counter(page) " / " counter(pages);
}

</style> 
<script>
$(document).ready(function () {

});
function getPrint(){
	//alert("hgchjh");
	 document.getElementById("mode").value="print";
	document.getElementById("frmSaleInvoicePrint").submit(); 
}
</script>
</head>
<body onload="" style="font-size:12px;background-color:white;">
<div id="mainBG" class="homeContent" data-type="background">

<form id="frmSaleInvoicePrint" action="printSaleInvoice" autocomplete="off" target="_blank">
 <jsp:include page="../../../common/printHeader.jsp"></jsp:include> 
<fieldset>
<table width="100%">
  <tr>
    <td width="7%">Client</td>
    <td colspan="3">: <label name="lblclientcode" id="lblclientcode" ><s:property value="lblclientcode"/></label>&nbsp;&nbsp;&nbsp;&nbsp;
    <label name="lblclientname" id="lblclientname" ><s:property value="lblclientname"/></label>
    </td>
    <td width="8%">&nbsp;</td>
    <td width="8%">Doc No</td>
    <td width="11%">: <label name="lbldocno" id="lbldocno" ><s:property value="lbldocno"/></label></td>
  </tr>
  <tr>
    <td>Description</td>
    <td width="52%">: <label name="lbldesc" id="lbldesc" ><s:property value="lbldesc"/></label></td>
    <td width="6%">Type</td>
    <td width="8%">: <label name="lbltype" id="lbltype" ><s:property value="lbltype"/></label></td>
    <td>&nbsp;</td>
    <td>Date</td>
    <td>:<label name="lbldate" id="lbldate" ><s:property value="lbldate"/></label> </td>
  </tr>
</table>
</fieldset>
<hr>
<table width="100%">
 <tr>
    <td align="left">SI No</td>
    <td align="left">Fleet</td>
    <td align="left">Fleet Name</td>
    <td align="left">Dep Posted</td>
    <td align="right">Sales Price</td>
    <td align="right">Pur Value</td>
    <td align="right">Acc Dep</td>
    <td align="right">Cur Dep</td>
    <td align="right">Net Book</td>
    <td align="right">Net P/(L)</td>
  </tr>
  
  
  </tr>
 <s:iterator var="stat1" status="arr" value="%{#request.INVPRINT}" >
	
		<s:iterator status="arr" value="#stat1" var="stat">
        	<tr>   
				
     				<s:iterator status="arr" value="#stat.split('::')" var="des">
    					<s:if test="#arr.index<=3">  
  							<td  align="left">
  						</s:if>
  						<s:else>
  							<td  align="right">
  						</s:else>
								<s:property value="#des"/>
							</td>
   					
 					</s:iterator>
			</tr>
		</s:iterator>
	
</s:iterator>

</table>
<hr>
<table width="100%" class="print-friendly">
	<tr >
    	<td  align="left">Sr No</th>
      	<td  align="left">Type</th>
      	<td  align="left">Account</th>
      	<td  align="left">Account Name</th>
      	<td  align="right">Debit</th>
      	<td  align="right">Credit</th>
      	<td  align="right">Base Amt</th>
      	<td  align="left">Description</th>
	</tr>
    <s:iterator var="statsalik" status="arr" value='#request.JVPRINT' >
      						
								<s:iterator status="arr" value="#statsalik" var="statsalik2"> 
									<tr style="page-break-inside: avoid;">
									
 										<s:iterator status="arr" value="#statsalik2.split('::')" var="dessalik"> 
											<s:if test="#arr.index<=3">
												<td align="left" style="page-break-inside: avoid;">
											</s:if>
											<s:elseif test="#arr.index==7">
												<td align="left" style="page-break-inside: avoid;">
											</s:elseif>
											<s:else>
												<td align="right" style="page-break-inside: avoid;">
											</s:else>
  											<s:property value="#dessalik"/></td>
  										</s:iterator>
  									</tr>	
  								</s:iterator>
  							
  							
  						</s:iterator>
</table>

</form>
</div>
</body>
</html>
