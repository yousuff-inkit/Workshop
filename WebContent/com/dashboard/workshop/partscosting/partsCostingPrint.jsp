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

.verticalLine {
    border-left: 1px solid black;
}
</style>

</head>
<body bgcolor="white" style="font-size:10px;">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmOutstandingsStatement" action="printOutstandingsStatement" method="post" autocomplete="off" target="_blank">

<div style="background-color:white;">

<jsp:include page="../../../common/printHeaderCarfareWorkshop.jsp"></jsp:include>

<table width="100%">
  <tr>
    <td width="7%" align="left"><b>Job No</b></td>
    <td width="41%" align="left"><b>:</b>&nbsp;<label id="lbljobno" name="lbljobno"><s:property value="lbljobno"/></label></td>
<!--     <td width="12%" align="left"><h5>Vehicle Details</h5></td> -->
<%--     <td width="40%" align="left">&nbsp;<label id="lblvehicledetails" name="lblvehicledetails"><s:property value="lblvehicledetails"/></label></td> --%>
  </tr>
  <tr>
    <td align="left"><b>Date</b></td>
    <td align="left"><b>:</b>&nbsp;<label id="lbldate" name="lbldate"><s:property value="lbldate"/></label></td>
    <td align="left"><b>Reg No</b></td>
    <td align="left"><b>:</b>&nbsp;<label id="lblregno" name="lblregno"><s:property value="lblregno"/></label></td>
  </tr>
  <tr>
    <td align="left"><b>Customer</b></td>
    <td align="left"><b>:</b>&nbsp;<label id="lblcustomer" name="lblcustomer"><s:property value="lblcustomer"/></label></td>
    <td align="left"><b>Brand</b></td>
    <td align="left"><b>:</b>&nbsp;<label id="lblbrand" name="lblbrand"><s:property value="lblbrand"/></label></td>
  </tr>
  <tr>
    <td>Client TRN</td>
    <td><b>:</b>&nbsp;<label id="lblclienttrn" name="lblclienttrn"><s:property value="lblclienttrn"/></label></td>
    <td align="left"><b>Model</b></td>
    <td align="left"><b>:</b>&nbsp;<label id="lblmodel" name="lblmodel"><s:property value="lblmodel"/></label></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td align="left"><b>YOM</b></td>
    <td align="left"><b>:</b>&nbsp;<label id="lblyom" name="lblyom"><s:property value="lblyom"/></label></td>
  </tr>
</table><br/>

<table width="95%" class="tablereceipt">
<thead>
  <tr class="tablereceipt" height="28">
    <th class="tablereceipt" colspan="5" align="center" height="28" style="background-color: #F6CECE;"><b>Estimation</b></th>
    <th class="tablereceipt" colspan="3" align="center" height="28" style="background-color: #F6CECE;"><b>Purchase</b></th>
   <!--  <th width="13%" class="tablereceipt" style="background-color: #A4A4A4;">&nbsp;</th> -->
  </tr>
  <tr height="28" style="background-color: #D8D8D8;" class="tablereceipt" align="center">
    <th width="5%" align="center" class="tablereceipt">SI No</th>
    <th width="21%" align="left" class="tablereceipt">Description</th>
    <th width="9%" align="right" class="tablereceipt">Qouted&nbsp;</th>
    <th width="6%" align="right" class="tablereceipt">Qty&nbsp;</th>
    <th width="10%" align="right" class="tablereceipt">Amount&nbsp;</th>
    <th width="15%" align="left" class="tablereceipt">Product Master</th>
    <th width="10%" align="right" class="tablereceipt">Best Price&nbsp;</th>
    <th width="11%" align="left" class="tablereceipt">Vendor</th>
    <!-- <th class="tablereceipt" align="left">Remarks</th> -->
  </tr>
  </thead>
  <tbody>
  <s:iterator var="stat" value='#request.printspares' >
	<tr height="20" class="tablereceipt">   
			<s:iterator status="arr" value="#stat.split('::')" var="des">   
			 <s:if test="#arr.index==2||#arr.index==3">
	    			<td  align="right" class="tablereceipt">
						<s:property value="#des"/>
					</td>
	    		</s:if>
  				<s:elseif test="#arr.index==3">
	    			<td  align="right" class="tablereceipt">
						<s:property value="#des"/>
					</td>
	    		</s:elseif>
  			<s:elseif test="#arr.index==4">
	    			<td  align="right" class="tablereceipt">
						<s:property value="#des"/>
					</td>
	    		</s:elseif>
  			<s:elseif test="#arr.index==6">
	    			<td  align="right" class="tablereceipt">
						<s:property value="#des"/>
					</td>
	    		</s:elseif>
  			
  				<s:else>
  					<td  align="left" class="tablereceipt">
	  					<s:property value="#des"/>
	  				</td>
  				</s:else>  <%-- 
    		 <td class='taleveh' align="left">
		   <s:property value="#des"/> 
  		</td>  --%>
  		</s:iterator>
	</tr>
	</s:iterator>
  </tbody>
  <tr height="25">
    <td class="tablereceipt"  colspan="4" align="right" ><b>Total</b>&nbsp;</td>
    <td class="tablereceipt" align="right"><label id="lblestimationtotal" name="lblestimationtotal"><s:property value="lblestimationtotal"/></label></td>
    <td class="tablereceipt" colspan="2" align="right"><label id="lblpurchasetotal" name="lblpurchasetotal"><s:property value="lblpurchasetotal"/></label></td>
    <td class="tablereceipt"  colspan="2" align="center" style="background-color: #A4A4A4;">&nbsp;</td>
  </tr>
</table><br/>

<table width="100%">
<tr>
		<td width="70%" align="right"><b>Profit :</b>&nbsp;</td>
		<td width="15%" align="left"><label id="lblprofitamount" name="lblprofitamount"><s:property value="lblprofitamount"/></label></td>
        <td width="15%" align="left"><label id="lblprofitperc" name="lblprofitperc"><s:property value="lblprofitperc"/></label></td>
</tr>
</table><br/><br/><br/><br/><br/><br/><br/>

<table width="100%">
  <tr>
    <td align="left"><b>Signature</b></td>
    <td align="center"><b>Signature</b></td>
    <td align="center"><b>Signature</b></td>
    <td align="center"><b>Signature</b></td>
  </tr>
</table>

<jsp:include page="../../../common/printFooter.jsp"></jsp:include>
<br/><br/>

</div>
</form>
</div>
</body>
</html>