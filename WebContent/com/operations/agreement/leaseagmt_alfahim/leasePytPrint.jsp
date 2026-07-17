<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page pageEncoding="utf-8" %> 
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>
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
 .tablereceipt {
    border: 1px solid black;
    border-collapse: collapse;
}
 
 hr { 
   border-top: 1px solid #e1e2df  ;
    
    }
.bottomline{
	border-bottom:1px solid black;
}
.topline{
	border-top:1px solid black;
}
table{
 border-collapse: collapse;
}
</style> 

 <script type="text/javascript">

</script>
</head>
<body style="font-size:12px;background-color:#fff !important;">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmLeasePytPrint" action="leasePytPrint" autocomplete="off" target="_blank">
<table width="100%" border="0">
  <tr>
    <td><jsp:include page="../../../common/printHeader.jsp"></jsp:include></td>
  </tr>
</table>
<fieldset>
<table width="100%" border="0">
  <tr>
    <td width="10%">Date</td>
    <td width="24%">: <label name="lblpytdate" id="lblpytdate"><s:property value="lblpytdate"/></label></td>
    <td width="33%">&nbsp;</td>
    <td width="14%">Doc No</td>
    <td width="19%">: <label name="lblpytdocno" id="lblpytdocno"><s:property value="lblpytdocno"/></label></td>
  </tr>
  <tr>
    <td>Client</td>
    <td colspan="2">: <label name="lblpytclient" id="lblpytclient"><s:property value="lblpytclient"/></label></td>
    <td>Mobile</td>
    <td>: <label name="lblpytmobile" id="lblpytmobile"><s:property value="lblpytmobile"/></label></td>
  </tr>
  <tr>
    <td>Address</td>
    <td colspan="2">: <label name="lblpytaddress" id="lblpytaddress"><s:property value="lblpytaddress"/></label></td>
    <td>Lease Start Date</td>
    <td>: <label name="lblpytleasestartdate" id="lblpytleasestartdate"><s:property value="lblpytleasestartdate"/></label></td>
  </tr>
</table>
</fieldset>
<br>
<fieldset>

<table width="100%">
	<tr height="25px;">
		<td width="10%" class="bottomline"><b>Sr No</b></td>
		<td width="20%" class="bottomline"><b>Date</b></td>
		<td width="20%" class="bottomline"><b>Cheque No</b></td>
		<td width="20%" class="bottomline"><b>Reciept No</b></td>
		<td width="30%" align="right" class="bottomline"><b>Amount</b></td>
	</tr>
	<s:iterator var="stat1" status="arr" value="%{#request.PYTPRINT}" >
		<s:iterator status="arr" value="#stat1" var="stat">    
			<tr height="25px;">   
		    	<s:iterator status="arr" value="#stat.split('::')" var="des">
					<s:if test="#arr.index<4">
						<td >
							<s:property value="#des"/>
  						</td>
					</s:if>
					<s:else>
						<td align="right">
							<s:property value="#des"/>
  						</td>
					</s:else>
				</s:iterator>
			</tr>
		</s:iterator>
	</s:iterator>
	<tr height="25px;">
		<td class="topline">&nbsp;</td>
		<td class="topline">&nbsp;</td>
		<td class="topline">&nbsp;</td>
		<td  class="topline" align="right"><b>Total</b></td>
		<td  class="topline" align="right">:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<label name="lblpytchequetotal" id="lblpytchequetotal"><s:property value="lblpytchequetotal"/></label>
</table>
</fieldset>
</form>
</div>
</body>
</html>