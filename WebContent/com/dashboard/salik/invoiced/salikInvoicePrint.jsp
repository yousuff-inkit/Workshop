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

</head>
<body bgcolor="white" style="font-size:10px;">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmSalikInvoicePrint" action="printSalikInvoice" method="post" autocomplete="off" target="_blank">

<div style="background-color:white;">
<jsp:include page="../../../common/printHeader.jsp"></jsp:include>

<table class="print">
<thead>
  <tr style="background-color: #D8D8D8;">
    <th>Sl.No</th>
    <th>Regn. No.</th>
    <th>Tag No.</th>
    <th>Fleet No.</th>
    <th>Transaction#</th>
    <th>Salik Date</th>
    <th>Salik</th>
    <th>RA No.</th>
    <th>INV No.</th>
    <th>INV Amt.</th>
  </tr>
  <tr>
    <th colspan="10"><hr noshade size=1 width="100%"></th>
  </tr>
  </thead>
  
  <%int i=0,l=0; %>
  <s:set var="#first" value=""/>
  <s:set var="#sec" value=""/>
  <s:iterator var="stat" value='#request.printingarray' >
	
	<s:iterator status="arr"  var="#aa" value='key.split("::")' > 
			  <s:if test="#arr.index==0">
			  		<s:set var="#first" value="#aa"/>
			  </s:if>
			  <s:elseif test="#arr.index==1">
			  		<s:set var="#sec" value="#aa"/>
			  </s:elseif>
	</s:iterator>

  <tr style="background-color: #F0EEEE;">
  	 <td colspan="10"><b><font size="2"><s:property value="#first"/></font></b></td>
  </tr>

  <s:iterator var="des1" value="value">
 
  <%l=l+1;i=0;%>
   
	<tr> 
	    <td width="5%" align="center"><%=l%></td>
    	<s:iterator status="arr" value="#des1.split('::')" var="des">
    	<%i=i+1;%>
    	<% if(i==1){%>
    	<td width="12%" align="center">
		    <s:property value="#des"/>
    	</td>
    	<%} else if(i==2){%>
    	<td width="11%" align="center">
		    <s:property value="#des"/>
    	</td>
    	
    	<%} else if(i==3){%>
    	<td width="12%" align="center">
		    <s:property value="#des"/>
    	</td>
    	
    	<%}else if(i==4){%>
    	<td width="9%" align="center">
		    <s:property value="#des"/>
    	</td> 
  	    <%}else if(i==5){%>
    	<td width="11%" align="center">
		    <s:property value="#des"/>
    	</td>
    	<%}else if(i==6){%>
    	<td width="8%" align="center">
		    <s:property value="#des"/>
    	</td>
    	<%}else if(i==7){%>
    	<td width="11%" align="center">
		    <s:property value="#des"/>
    	</td>
    	<%}else if(i==8){%>
    	<td width="10%" align="center">
		    <s:property value="#des"/>
    	</td>
    	<%}else if(i==9){%>
    	<td width="10%" align="right">
		    <s:property value="#des"/>
    	</td>
   		<%} else{ %>
  		<td align="center">
		  <s:property value="#des"/>
  		</td>
  		<% } %>
 		</s:iterator>
	</tr>

	</s:iterator>
	
	<tr>
    <td colspan="10"><hr noshade size=1 width="100%"></td>
  </tr>

  <tr height="20">
    <td colspan="8" align="right"><b>Total</b></td>
    <td colspan="10" align="right"><s:property value="#sec"/></td>
  </tr>
  
  <tr>
    <td colspan="10"><hr noshade size=1 width="100%"></td>
  </tr>
 </tbody>
  
 
  
 </s:iterator>
 </table>
</div>
<div hidden="true">
<jsp:include page="../../../../css/printtable.css"></jsp:include>
<jsp:include page="../../../../js/printTable.js"></jsp:include>
</div>
</form>
</div>
</body>
</html>

