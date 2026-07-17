
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



#pageFooter {
    display: table-footer-group;
}

#pageFooter:after {
      counter-increment: page;
      counter-reset: pages 1;
      content: "Page " counter(page) " / " counter(pages);
}
       
  /* /* tr.saliktable:nth-child(even) {background: #fff } 
tr.saliktable:nth-child(odd) {background: #fdf5e6} */ */
/* #salikdiv{
break-before: always;
}  */
/* div.salikdiv
      {
        page-break-after: always;
        page-break-inside: avoid;
      } */
</style> 
<script>
$(document).ready(function () {
	//document.getElementById("salikdiv").style.display="none";
	//alert(document.getElementById("lblsalikcount").value);
	/* if(document.getElementById("lblsalikcount").value=="0"){
		document.getElementById("salikdiv").style.display="none";
	}
	else{
		document.getElementById("salikdiv").style.display="block";
	} */
});
function getPrint(){
	 document.getElementById("mode").value="print";
	document.getElementById("frmManualInvoicePrint").submit(); 
}
</script>
</head>
<body onload="" bgcolor="white"  style="font-size:12px">
<div id="mainBG" class="homeContent" data-type="background">
<s:set name="counter" value="0"></s:set>
<s:set name="salik" value="#lblsalikcount"></s:set>
<%-- <s:iterator value='#request.TRIAL' var="#aa" status="arr"> --%>

<%-- <jsp:include page="../../../../../header.jsp"></jsp:include> --%> <br/> 
	<header style="padding-left:20px;padding-right:20px;background-color:#f7efde;">
<!-- 		<div style="width:100%;  float:left; text-align:center;">
			<h1>&nbsp;QUOTATION</h1>
		</div> -->
		<!-- <div style="width:35%; height:100px; float:left;text-align:right;">
			<h2 style="padding:0;margin-bottom:0;">AUTO FIT CENTER LLC</h2><br>
			<a style="padding-top:0;">Sk Zayed Road, Dubai, UAE</a>
		</div> -->
	</header>
		<div style="background-color:white;">
	           <table width="100%" border="0">
				  <tr>
				    <td width="33%"><img src="<%=contextPath%>/icons/epic.jpg" width="100%" height="130" alt=""/></td>
				    <td width="38%" align="center">&nbsp;</td>
				    <td width="29%">&nbsp;</td>
				  </tr> 
				  <tr>
				    <td width="33%">&nbsp;</td>
				    <td width="38%" align="center"><font size="3"><b><label id="lblprintname" name="lblprintname" ><s:property value="lblprintname"/></label></b></font></td>
				    <td width="29%">TRN:&nbsp;<label id="lblcomptrn" name="lblcomptrn"><s:property value="lblcomptrn"/></label></td>
				  </tr>
				</table>
		</div>		
	 <div style="background-color:white;">
	 <form action="printQuotationAproval" method="get">
		<fieldset>
		<table width="100%" border="0">
		  <tr>
		    <td colspan="6">
		    <fieldset>
			    <table width="100%" border="0">
			      <tr>
			        <td width="10%"><strong>Est.No</strong></td>
			        <td width="19%">: <label id="lblEstNo" name="lblEstNo"><s:property value="lblEstNo"/></td>
			        <td width="12%"><strong>GIP</strong></td>
			        <td width="40%">: <label id="lblGipNo" name="lblGipNo"><s:property value="lblGipNo"/></td>
			        <td width="6%"><strong>Date</strong></td>
			        <td width="13%">: <label id="lblDate" name="lblDate"><s:property value="lblDate"/></td>
			      </tr>
			    </table>
		    </fieldset>
		    </td>
		  </tr>
		  <tr>
		  	<td><strong>Client</strong></td>
		  	<td colspan="5">: <label id="lblClient" name="lblClient"><s:property value="lblClient"/></td>
		  </tr>
		  <tr>
		    <td width="10%"><strong>Reg.No</strong></td>
		    <td width="19%">: <label id="lblRegNo" name="lblRegNo"><s:property value="lblRegNo"/></td>
		    <td width="12%"><strong>Brand</strong></td>
		    <td width="24%">: <label id="lblBrand" name="lblBrand"><s:property value="lblBrand"/>&nbsp;</td>
		    <td width="10%"><strong>Model</strong></td>
		    <td width="25%"  style="vertical-align:top">: <label id="lblModel" name="lblModel"><s:property value="lblModel"/>
		    <%-- <label id="lblRemarks" name="lblRemarks"><s:property value="lblRemarks"/> --%></td>
		  </tr>
		  <tr>
		    <td><strong>YOM</strong></td>
		    <td>: <label id="lblYom" name="lblYom"><s:property value="lblYom"/><%-- <label id="lblUserName" name="lblUserName"><s:property value="lblUserName"/> --%></td>
		    <td><strong>Chassis No</strong></td>
		    <td>: <label id="lblOthers" name="lblOthers"><s:property value="lblOthers"/></label></td>
		    <td><strong>Km</strong></td>
		    <td>: <label id="lblkm" name="lblkm"><s:property value="lblkm"/></label></td>
		  </tr>
		  <tr><td><strong>User</strong></td><td colspan="3">: <label id="lblUserName" name="lblUserName"><s:property value="lblUserName"/></label></td></tr>
		  <tr>
		    <td><strong>Claim#</strong></td>
		    <td>: <label id="lblClaim" name="lblClaim"><s:property value="lblClaim"/></label></td>
		    <td><strong>LPO#</strong></td>
		    <td>: <label id="lblLpo" name="lblLpo"><s:property value="lblLpo"/></label></td>
		    <td width="10%">&nbsp;</td>
		  </tr>
		  
		  <tr>
		    <td><strong>LPO Amt</strong></td>
		    <td>: <label id="lblLpoAmt" name="lblLpoAmt"><s:property value="lblLpoAmt"/></td>
		    <td><strong>Excess Amt</strong></td>
		    <td>: <label id="lblExcessAmt" name="lblExcessAmt"><s:property value="lblExcessAmt"/></td>
		    <td width="10%">&nbsp;</td>
		  </tr>
		  <tr><td><strong>Remarks</strong></td><td colspan="3">: <label id="lblRemarks" name="lblRemarks"><s:property value="lblRemarks"/></label></td></tr>
		</table>
	</fieldset>
	
	<div>
		<h3><u>Estimation Details</u></h3>
		
		<table width="100%" border="1" cellpadding="6" style="border-collapse: collapse">
		<thead>
		  <tr >
		    <th colspan="5" scope="col" Style="border-width: 2px;">Spare Parts</th>
		  </tr>
		  <tr>
		    <td width="5%"><strong>S#</strong></td>
		    <td width="66%"><strong>Description</strong></td>
		    <td width="9%"><strong>Qty</strong></td>
		    <td width="10%"><strong>Rate</strong></td>
		    <td width="10%"><strong>Approved Value</strong></td>
		  </tr>
		  </thead>
		  <tbody>
		    <s:iterator var="sparearray" status="arr" value='#request.ALICESPAREPRINT' >
      						
								<s:iterator status="arr" value="#sparearray" var="sparerow"> 
									<tr>
									
 										<s:iterator status="arr" value="#sparerow.split('::')" var="sparepart"> 
											<s:if test="#arr.index>2">
												<td align="right"><s:property value="#sparepart"/></td>	
											</s:if>
											<s:else>
												<td><s:property value="#sparepart"/></td>
											</s:else>
  											
  										</s:iterator>
  									</tr>	
  								</s:iterator>
  			</s:iterator>					
		  
		  </tbody>
		</table>
		<br><br><br>
		<table width="100%" border="1" cellpadding="6" style="border-collapse: collapse">
		<thead>
		  <tr >
		    <th colspan="4" scope="col" Style="border-width: 2px;">Services</th>
		  </tr>
		  <tr>
		    <td width="9%"><strong>S#</strong></td>
		    <td width="45%"><strong>Job Type</strong></td>
		    <td width="46%"><strong>Details</strong></td>
		    <%-- <td width="9%"><strong>Hrs.</strong></td>
		    <td width="10%"><strong>Rate</strong></td>
		    <td width="11%"><strong>Total</strong></td> 
		    <td width="17%">&nbsp;</td>--%>
		  </tr>
		  </thead>
		  <tbody>
		    <s:iterator var="jbcostarray" status="arr" value='#request.JBCOSTPRINT' >
      						
								<s:iterator status="arr" value="#jbcostarray" var="jbcostrow"> 
									<tr>
									
 										<s:iterator status="arr" value="#jbcostrow.split('::')" var="jbcost"> 
											<s:if test="#arr.index>3">
												<td align="right"><s:property value="#jbcost"/></td>
											</s:if>
											<s:else>
												<td><s:property value="#jbcost"/></td>
											</s:else>
  											
  										</s:iterator>
  									</tr>	
  								</s:iterator>
  			</s:iterator>					
		  
		  </tbody>
		</table>
		<br><br><br>
		<table width="100%" border="1" border="1" cellpadding="6" style="border-collapse: collapse">
		<thead>
		  <tr>
		        <th colspan="4" Style="border-width: 2px;">Customer Complaints</th>
		  </tr>
		  <tr>
		    <th style="text-align:left;" width="9%">S#</th>
		    <th style="text-align:left;" width="45%">Complaint</th> 
		    <th style="text-align:left;" width="46%">Details</th>
		    <!-- <th style="text-align:left;" width="14%">Complaint ID</th> -->
		  </tr>
		  </thead>
		  <tbody>
		  		<s:iterator var="jblistarray" status="arr" value='#request.JBLISTPRINT' >
      						
								<s:iterator status="arr" value="#jblistarray" var="jblistrow"> 
									<tr>
									
 										<s:iterator status="arr" value="#jblistrow.split('::')" var="jblist"> 
											
  											<td><s:property value="#jblist"/></td>
  										</s:iterator>
  									</tr>	
  								</s:iterator>
  			</s:iterator>
		  
		  </tbody>
		</table>
	<br><br><br>
	
		<table width="100%" border="1" style="border-collapse: collapse">
		  <tr>
		    <td width="15%" align="right"><strong>Spare Parts</strong></td>
		    <td width="15%" align="right"><strong>Services</strong></td>
		    <td width="15%" align="right"><strong>VAT</strong></td>
		    <td width="55%" align="center"><strong>Total</strong></td>
		  </tr>
		  <tr>
		    <td align="right"><label id="lblSparePartsTotal" name="lblSparePartsTotal"><s:property value="lblSparePartsTotal"/></td>
		    <td align="right"><label id="lblLabourTotal" name="lblLabourTotal"><s:property value="lblLabourTotal"/></td>
		    <td align="right"><label id="lblvat" name="lblvat"><s:property value="lblvat"/></td>
		    <td align="center">
		    	<label id="lblEstimation" name="lblEstimation"><s:property value="lblEstimation"/> &nbsp;
		    	<label id="lblvattotal" name="lblvattotal"><s:property value="lblvattotal"/>
		    </td>
		  </tr>
	 </table>
			
	</div>
	<br><br>
	<jsp:include page="../../../common/printFooter.jsp"></jsp:include>
	</form>
</div>
</div>
</body>
</html>
