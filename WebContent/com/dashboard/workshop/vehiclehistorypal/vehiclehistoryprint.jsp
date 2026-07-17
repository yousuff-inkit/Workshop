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


<table width="95%"  align="center">
<tr><td>
<fieldset><legend><b>Customer details</b></legend>
<table width="100%" >
<tr><td width="20%">Customer Name
</td>
<td width="5%">:
</td>
<td width="75%"><label id="lblcustname" name="lblcustname"><s:property value="lblcustname"/></label>
</td>
</tr>
<tr><td></td></tr>
<tr><td width="20%">Address
</td>
<td width="5%">:
</td>
<td width="75%"><label id="lblAddress" name="lblAddress"><s:property value="lblAddress"/></label>
</td>
</tr>
<tr><td></td></tr>
<tr><td width="20%">Mobile No.
</td>
<td width="5%">:
</td>
<td width="75%"><label id="lblphone" name="lblphone"><s:property value="lblphone"/></label>
</td>
</tr>
<tr><td></td></tr>
<tr><td width="20%">Email.
</td>
<td width="5%">:
</td>
<td width="75%"><label id="lblemail" name="lblemail"><s:property value="lblemail"/></label>
</td>
</tr>
<tr><td width="20%">
</td>
<td width="5%">
</td>
<td width="75%">&nbsp;
</td>
</tr>
</table>
</fieldset>
</td>
<td>
<fieldset><legend><b>vehicle details </b></legend>
<table width="100%" >
<tr><td width="20%">Reg No.
</td>
<td width="5%">:
</td>
<td width="75%"><label id="lblregno" name="lblregno"><s:property value="lblregno"/></label>
</td>
</tr>
<tr><td></td></tr>
<tr><td width="20%">Chassis No.
</td>
<td width="5%">:
</td>
<td width="75%"><label id="lblchassis" name="lblchassis"><s:property value="lblchassis"/></label>
</td>
</tr>
<tr><td></td></tr>
<tr><td width="20%">Brand.
</td>
<td width="5%">:
</td>
<td width="75%"><label id="lblbrandn" name="lblbrand"><s:property value="lblbrand"/></label>
</td>
</tr>
<tr><td></td></tr>
<tr><td width="20%">Model.
</td>
<td width="5%">:
</td>
<td width="75%"><label id="lblmodel" name="lblmodel"><s:property value="lblmodel"/></label>
</td>
</tr>
<tr><td></td></tr>
<tr><td width="20%">YOM.
</td>
<td width="5%">:
</td>
<td width="75%"><label id="lblyom" name="lblyom"><s:property value="lblyom"/></label>
</td>
</tr>
</table>
</fieldset>
</td>
</tr>
</table>

<table width="95%" align="center">
<tr>
<td>
<fieldset><legend><b>Services </b></legend>
<table width="100%" align="center" >
<tr>
<td>
<table width="95%" class=tablereceipt align="center">
<tr height="25" style="background-color: #F6CECE;">
<td width="10%" align="center" class=tablereceipt><b>Sr. No.</b></td>
    <td width="15%" align="center" class=tablereceipt><b>Job Card No.</b></td>
    <td width="20%" align="center" class=tablereceipt><b>Date</b></td>
    <!-- <td width="6%" align="center" class=tablereceipt><b>User Name </b></td>-->
    <td width="30%" align="center" class=tablereceipt><b>Job Type</b></td>
    <td width="25%" align="center" class=tablereceipt><b>Job Description</b></td>
    
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
	<%-- <tr height="20" class=tablereceipt>
		<td  align="right" colspan="8" class=tablereceipt><b>Total </b>&nbsp;</td>
        <td width="8%" align="right" class=tablereceipt><label id="lblcashtotal" name="lblcashtotal"><s:property value="lblcashtotal"/></label></td>
        <td width="8%" align="right" class=tablereceipt><label id="lblcardtotal" name="lblcardtotal"><s:property value="lblcardtotal"/></label></td>
        <td width="8%" align="right" class=tablereceipt><label id="lblchequetotal" name="lblchequetotal"><s:property value="lblchequetotal"/></label></td>
	</tr> --%>
</table>
</td></tr>
</table>
</fieldset>
</td></tr></table>
<br/>
<table width="95%" align="center">
<tr>
<td>
<fieldset><legend><b>Spare Parts </b></legend>
<table width="100%" align="center" >
<tr>
<td>
<table width="95%" class=tablereceipt align="center">
<tr height="25" style="background-color: #F6CECE;">
<td width="10%" align="center" class=tablereceipt><b>Sr. No.</b></td>
    <td width="15%" align="center" class=tablereceipt><b>Job Card No.</b></td>
    <td width="20%" align="center" class=tablereceipt><b>Date</b></td>
    <!-- <td width="6%" align="center" class=tablereceipt><b>User Name </b></td>-->
    <td width="30%" align="center" class=tablereceipt><b>Description</b></td>
    <td width="25%" align="center" class=tablereceipt><b>Quantity</b></td>
    
  </tr>
  
    <s:iterator var="stat" value='#request.printingarray2' >
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
	<%-- <tr height="20" class=tablereceipt>
		<td  align="right" colspan="8" class=tablereceipt><b>Total </b>&nbsp;</td>
        <td width="8%" align="right" class=tablereceipt><label id="lblcashtotal" name="lblcashtotal"><s:property value="lblcashtotal"/></label></td>
        <td width="8%" align="right" class=tablereceipt><label id="lblcardtotal" name="lblcardtotal"><s:property value="lblcardtotal"/></label></td>
        <td width="8%" align="right" class=tablereceipt><label id="lblchequetotal" name="lblchequetotal"><s:property value="lblchequetotal"/></label></td>
	</tr> --%>
</table>
</td></tr>
</table>
</fieldset>
</td></tr></table>
<br/>
<%-- <table width="100%">
<tr>
		<td width="92%" align="right"><b>Net Amount :</b>&nbsp;</td>
        <td width="8%" align="left"><label id="lblnetbalance" name="lblnetbalance"><s:property value="lblnetbalance"/></label></td>
</tr>
</table><br/> --%>

<jsp:include page="../../../common/printFooter.jsp"></jsp:include>
<br/><br/>
</div>
</form>
</div>
</body>
</html>