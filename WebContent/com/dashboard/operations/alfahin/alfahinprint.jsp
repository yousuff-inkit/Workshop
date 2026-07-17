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
    font-size: 9px;
}
</style>

</head>
<body bgcolor="white" style="font-size:10px;">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmalfahin" action="printalfahin" method="post" autocomplete="off" target="_blank">

<div style="background-color:white;">

<jsp:include page="../../../common/printHeader.jsp"></jsp:include>

<table width="95%" class=tablereceipt align="center">
<tr height="25" style="background-color: #F6CECE;">
    <td width="12%" align="center" class=tablereceipt><b>Branch</b></td>
    <td width="6%" align="center" class=tablereceipt><b>Doc No</b></td>
    <!-- <td width="6%" align="center" class=tablereceipt><b>User Name </b></td>-->
    <td width="8%" align="center" class=tablereceipt><b>Date</b></td>
    <td width="7%" align="center" class=tablereceipt><b>Doc Type</b></td>
    <td width="8%" align="center" class=tablereceipt><b>RRV No</b></td>
    <td width="20%" align="center" class=tablereceipt><b>Client</b></td>
    <td width="8%" align="center" class=tablereceipt><b>Paid As</b></td>
    <td width="7%" align="center" class=tablereceipt><b>Agreement</b></td>
    <td width="7s%" align="right" class=tablereceipt><b>Cash</b></td>
    <td width=7%" align="right" class=tablereceipt><b>Card</b></td>
    <td width="7%" align="right" class=tablereceipt><b>Cheque total</b></td>
  </tr>
  
    <s:iterator var="stat" value='#request.printingarray' >
	<tr height="20" class=tablereceipt>   
		<%int i=0; %>
    	<s:iterator status="arr" value="#stat.split('::')" var="des">   
    	<% if(i==5){%>
    	<td class=tablereceipt align="left">&nbsp;
		    <s:property value="#des"/>
    	</td>
     	<%} else if(i==8){%>
  		<td class=tablereceipt align="right">
		    <s:property value="#des"/>
  			</td>
  	   <%} else if(i==9){%>
  		<td class=tablereceipt align="right">
		    <s:property value="#des"/>
  			</td>
  		<%} else if(i==10){%>
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
	<tr height="20" class=tablereceipt>
		<td  align="right" colspan="8" class=tablereceipt><b>Total </b>&nbsp;</td>
        <td width="8%" align="right" class=tablereceipt><label id="lblcashtotal" name="lblcashtotal"><s:property value="lblcashtotal"/></label></td>
        <td width="8%" align="right" class=tablereceipt><label id="lblcardtotal" name="lblcardtotal"><s:property value="lblcardtotal"/></label></td>
        <td width="8%" align="right" class=tablereceipt><label id="lblchequetotal" name="lblchequetotal"><s:property value="lblchequetotal"/></label></td>
	</tr>
</table><br/>

<table width="100%">
<tr>
		<td width="92%" align="right"><b>Net Amount :</b>&nbsp;</td>
        <td width="8%" align="left"><label id="lblnetbalance" name="lblnetbalance"><s:property value="lblnetbalance"/></label></td>
</tr>
</table><br/>

<jsp:include page="../../../common/printFooter.jsp"></jsp:include>
<br/><br/>
</div>
</form>
</div>
</body>
</html>