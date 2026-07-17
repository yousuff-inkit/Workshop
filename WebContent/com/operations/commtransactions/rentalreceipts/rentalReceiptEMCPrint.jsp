<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<%@ page pageEncoding="utf-8" %>
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>

<style type="text/css">
.tablereceipt {
    border: 1px solid black;
    border-collapse: collapse;
}

P.breakhere {page-break-before: always}

</style>

<script type="text/javascript">

	function hidedata(){
		
		var first=document.getElementById("firstarray").value;
		
		if(parseInt(first)==1){
			   $("#firstdiv").prop("hidden", false);
			   $("#firstdupdiv").prop("hidden", false);
			}
		else{
			$("#firstdiv").prop("hidden", true);
			$("#firstdupdiv").prop("hidden", true);
			}
		
		}

</script>

</head>
<body bgcolor="white" style="font-size:10px;" onload="hidedata();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmReceiptVoucher" action="printRentalReceipt" method="post" autocomplete="off" target="_blank">

<div style="background-color:white;">

<%-- <table width="100%">
  <tr>
    <td colspan="2" align="center">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="<%=contextPath%>/icons/Mercedes_Logo.jpg" width="40%" height="75"  alt=""/></td>
  </tr>
  <tr>
    <td width="55%"  height="53" align="center" valign="bottom">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font size="3"><b>سند قبض</b></font></td>
    <td width="45%"  rowspan="2"><img src="<%=contextPath%>/icons/EMC_Logo.jpg" width="100%" height="90"  alt=""/></td>
  </tr>
  <tr>
    <td height="59" align="center" valign="top"><font size="3"><b>Receipt Voucher</b></font></td>
  </tr>
  <tr>
    <td colspan="2"><hr noshade size=1 width="100%"></td>
  </tr>
</table> --%>
<table width="100%">
  <tr>
    <td colspan="2" align="center" style="text-align:center;"><img src="<%=contextPath%>/icons/Mercedes_Logo.jpg" width="40%" height="75" style="padding-left:200px;" alt=""/></td>
  </tr>
  <tr>
    <td width="55%"  height="53" align="center" valign="bottom"><font size="3"><b>سند قبض</b></font></td>
    <td width="45%"  rowspan="2"><img src="<%=contextPath%>/icons/EMC_Logo.jpg" width="100%" height="90"  alt=""/></td>
  </tr>
  <tr>
    <td height="59" align="center" valign="top"><font size="3"><b>Receipt Voucher</b></font></td>
  </tr>
  <tr>
    <td colspan="2"><hr noshade size=1 width="100%"></td>
  </tr>
</table>

<table width="99%">
  <tr>
    <td width="31%"><b>Received with Thanks From</b></td>
    <td width="19%" align="right"><b>تم الإستلام مشكوراً من</b></td>
    <td width="17%" align="right"><b>Receipt No :</b></td>
    <td width="10%"><label id="receiptno" name="receiptno"><s:property value="receiptno"/></label></td>
    <td width="10%">&nbsp;<label id="receiptinfomore" name="receiptinfomore"><s:property value="receiptinfomore"/></label></td>
    <td width="1%" align="right"><b>:</b></td>
    <td width="12%" align="right"><b>رقم الإيصال</b></td>
  </tr>
  <tr>
    <td colspan="2"><font size="1"><label id="receivedfrom" name="receivedfrom"><s:property value="receivedfrom"/></label></font></td>
    <td align="right"><b>Receipt Date :</b></td>
    <td colspan="2"><label id="receiptdate" name="receiptdate"><s:property value="receiptdate"/></label></td>
    <td align="right"><b>:</b></td>
    <td align="right"><b>تاريخ الإيصال</b></td>
  </tr>
  <tr>
    <td><b>Client</b></td>
    <td align="right"><b>العميل</b></td>
    <td align="right"><b>Currency :</b></td>
    <td colspan="2">&nbsp;AED</td>
    <td align="right"><b>:</b></td>
    <td align="right"><b>العمله</b></td>
  </tr>
  <tr>
    <td colspan="7"><font size="2"><label id="clientinfo" name="clientinfo"><s:property value="clientinfo"/></label></font></td>
  </tr>
</table><br/>

<table width="100%" class=tablereceipt>
  <tr class=tablereceipt style="background-color: #F6CECE;">
    <td class=tablereceipt height="25" colspan="3" align="center"><b>التفاصيل</b></td>
    <td class=tablereceipt align="center"><b>طريقة الدفع</b></td>
    <td class=tablereceipt align="right"><b>القيمه</b></td>
  </tr>
  <tr class=tablereceipt style="background-color: #F6CECE;">
    <td class=tablereceipt height="25" colspan="3" align="center"><b>Description</b></td>
    <td class=tablereceipt width="14%" align="center"><b>Payment Mode</b></td>
    <td class=tablereceipt width="16%" align="right"><b>Amount</b></td>
  </tr>
  <tr class=tablereceipt>
    <td colspan="3" class=tablereceipt>
  <table width="100%">
       <tr>
	    <td colspan="5"><label id="lbladvancesecurity" name="lbladvancesecurity"><s:property value="lbladvancesecurity"/></label></td>
	  </tr>
	  <tr>
	    <td colspan="5"><label id="lbldescription" name="lbldescription"><s:property value="lbldescription"/></label></td>
	  </tr>
	  <tr>
	    <td width="19%" align="left"><b>CARD NO</b></td>
	    <td width="57%"><b>:</b>&nbsp;&nbsp;<label id="cardno" name="cardno"><s:property value="cardno"/></label></td>
        <td width="2%" align="right"><b>:</b></td>
	    <td width="22%" align="right"><b>رقم البطاقة</b></td>
	  </tr>
	  <tr>
	    <td align="left"><b>CARD EXPIRY</b></td>
	    <td><b>:</b>&nbsp;&nbsp;<label id="cardexp" name="cardexp"><s:property value="cardexp"/></label></td>
        <td align="right"><b>:</b></td>
	    <td align="right"><b>تاريخ انتهاء البطاقة</b></td>
  </tr>
  <tr>
	    <td align="left"><b>CHEQUE NO</b></td>
	    <td><b>:</b>&nbsp;&nbsp;<label id="chqno" name="chqno"><s:property value="chqno"/></label></td>
        <td align="right"><b>:</b></td>
	    <td align="right"><b>رقم الشيك</b></td>
	  </tr>
	  <tr>
	    <td align="left"><b>CHEQUE DATE</b></td>
	    <td><b>:</b>&nbsp;&nbsp;<label id="chqdate" name="chqdate"><s:property value="chqdate"/></label></td>
        <td align="right"><b>:</b></td>
	    <td align="right"><b>تاريخ الشيك</b></td>
  </tr>  
</table>
    
    </td>
    <td align="center" class=tablereceipt><label id="paymode" name="paymode"><s:property value="paymode"/></label></td>
    <td align="right" class=tablereceipt><label id="amount" style="text-align: right;" name="amount"><s:property value="amount"/></label></td>
  </tr>
  <tr class=tablereceipt>
    <td width="14%" align="right"><b>Amount in Words&nbsp;&nbsp;</b></td>
    <td width="34%">&nbsp;</td>
    <td width="22%" align="right"><b>القيمه الإجماليه بالحروف</b></td>
    <td align="right"><b>Total</b></td>
    <td align="right"><b>الإجمالى</b></td>
  </tr>
  <tr class=tablereceipt height="25">
    <td colspan="3" class=tablereceipt><label id="amtinwords" name="amtinwords"><s:property value="amtinwords"/></label></td>
    <td colspan="2" align="right"><label id="total" style="text-align: right;" name="total"><s:property value="total"/></label></td>
  </tr>
</table><br/><br/>

<div id="firstdiv" hidden="true">
<table width="99%" class="tablereceipt" align="center">
<tr>
    <td colspan="10" class="tablereceipt" height="26" style="background-color: #CEECF5;"><b>Applying</b></td>
  </tr>
  <tr height="25">
    <td width="4%" class="tablereceipt" align="center">Sr.No</td>
    <td width="6%" class="tablereceipt" align="center">Doc No.</td>
    <td width="7%" class="tablereceipt" align="center">Doc Type</td>
    <td width="8%" class="tablereceipt" align="center">Date</td>
    <td width="7%" class="tablereceipt" align="center">Ref Type</td>
    <td width="7%" class="tablereceipt" align="center">Ref No.</td>
    <td width="31%" class="tablereceipt" align="center">Remarks</td>
    <td width="10%" class="tablereceipt" align="right">Amount</td>
    <td width="10%" class="tablereceipt" align="right">Applying</td>
    <td width="10%" class="tablereceipt" align="right">Balance</td>
  </tr>
  
  <%int j=0,k=0; %>
  <s:iterator var="stat" value='#request.printapplyingsarray' >
  <%j=0;k=k+1;%>
	<tr height="25" class=tablereceipt>   
	    <td class="tablereceipt" width="4%" align="center"><%=k%></td>
    	<s:iterator status="arr" value="#stat.split('::')" var="des">
    	<%j=j+1;%>
    	<% if(j==1){%>
    	<td class=tablereceipt width="6%" align="center">
		    <s:property value="#des"/>
    	</td>
        <%} else if(j==2){%>
    	<td class=tablereceipt width="7%" align="center">
		    <s:property value="#des"/>
    	</td>
    	
    	<%} else if(j==3){%>
    	<td class=tablereceipt width="8%" align="center">
		    <s:property value="#des"/>
    	</td> 
     	<%}else if(j==4){%>
    	<td class=tablereceipt width="7%" align="center">
		    <s:property value="#des"/>
    	</td>
    	<%}else if(j==5){%>
    	<td class=tablereceipt width="7%" align="center">
		    <s:property value="#des"/>
    	</td>
    	<%}else if(j==6){%>
    	<td class=tablereceipt width="31%" align="left">
		    <s:property value="#des"/>
    	</td>
    	<%}else if(j==7){%>
    	<td class=tablereceipt width="10%" align="right">
		    <s:property value="#des"/>
    	</td>
    	<%}else if(j==8){%>
    	<td class=tablereceipt width="10%" align="right">
		    <s:property value="#des"/>
    	</td>
    	<%}else if(j==9){%>
    	<td class=tablereceipt width="10%" align="right">
		    <s:property value="#des"/>
    	</td>
   		<%} else{ %>
  		<td class=tablereceipt  width="4%" align="center">
		  <s:property value="#des"/>
  		</td>
  		<% } %>
 		</s:iterator>
	</tr>
	</s:iterator>
	
</table><br/><br/>
</div>

<table width="100%">
  <tr>
    <td colspan="3" align="left"><b>أعدت بواسطة</b></td>
    <td align="right"><b>العميل</b></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td width="11%" align="left"><b>Prepared by :</b></td>
    <td width="25%"><label id="preparedby" name="preparedby"><s:property value="preparedby"/></label></td>
    <td width="21%">&nbsp;</td>
    <td width="16%" align="right"><b>Customer :</b></td>
    <td width="27%"><hr style="border:0;border-bottom: 1px dashed #ccc;" size=1 width="100%"></td>
  </tr>
</table>

<P CLASS="breakhere">

<jsp:include page="../../../common/printFooter.jsp"></jsp:include>

								              <!-- Page 2 -->

<table width="100%">
  <tr>
    <td colspan="2" align="center">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="<%=contextPath%>/icons/Mercedes_Logo.jpg" width="40%" height="75"  alt=""/></td>
  </tr>
  <tr>
    <td width="55%"  height="53" align="center" valign="bottom">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font size="3"><b>سند قبض</b></font></td>
    <td width="45%"  rowspan="2"><img src="<%=contextPath%>/icons/EMC_Logo.jpg" width="100%" height="90"  alt=""/></td>
  </tr>
  <tr>
    <td height="59" align="center" valign="top"><font size="3"><b>Receipt Voucher</b></font></td>
  </tr>
  <tr>
    <td colspan="2"><hr noshade size=1 width="100%"></td>
  </tr>
</table>

<table width="99%">
  <tr>
    <td width="31%"><b>Received with Thanks From</b></td>
    <td width="19%" align="right"><b>تم الإستلام مشكوراً من</b></td>
    <td width="17%" align="right"><b>Receipt No :</b></td>
    <td width="10%"><label id="receiptno" name="receiptno"><s:property value="receiptno"/></label></td>
    <td width="10%">&nbsp;<label id="receiptinfomore" name="receiptinfomore"><s:property value="receiptinfomore"/></label></td>
    <td width="1%" align="right"><b>:</b></td>
    <td width="12%" align="right"><b>رقم الإيصال</b></td>
  </tr>
  <tr>
    <td colspan="2"><font size="1"><label id="receivedfrom" name="receivedfrom"><s:property value="receivedfrom"/></label></font></td>
    <td align="right"><b>Receipt Date :</b></td>
    <td colspan="2"><label id="receiptdate" name="receiptdate"><s:property value="receiptdate"/></label></td>
    <td align="right"><b>:</b></td>
    <td align="right"><b>تاريخ الإيصال</b></td>
  </tr>
  <tr>
    <td><b>Client</b></td>
    <td align="right"><b>العميل</b></td>
    <td align="right"><b>Currency :</b></td>
    <td colspan="2">&nbsp;AED</td>
    <td align="right"><b>:</b></td>
    <td align="right"><b>العمله</b></td>
  </tr>
  <tr>
    <td colspan="7"><font size="2"><label id="clientinfo" name="clientinfo"><s:property value="clientinfo"/></label></font></td>
  </tr>
</table><br/>

<table width="100%" class=tablereceipt>
  <tr class=tablereceipt style="background-color: #F6CECE;">
    <td class=tablereceipt height="25" colspan="3" align="center"><b>التفاصيل</b></td>
    <td class=tablereceipt align="center"><b>طريقة الدفع</b></td>
    <td class=tablereceipt align="right"><b>القيمه</b></td>
  </tr>
  <tr class=tablereceipt style="background-color: #F6CECE;">
    <td class=tablereceipt height="25" colspan="3" align="center"><b>Description</b></td>
    <td class=tablereceipt width="14%" align="center"><b>Payment Mode</b></td>
    <td class=tablereceipt width="16%" align="right"><b>Amount</b></td>
  </tr>
  <tr class=tablereceipt>
    <td colspan="3" class=tablereceipt>
  <table width="100%">
       <tr>
	    <td colspan="5"><label id="lbladvancesecurity" name="lbladvancesecurity"><s:property value="lbladvancesecurity"/></label></td>
	  </tr>
	  <tr>
	    <td colspan="5"><label id="lbldescription" name="lbldescription"><s:property value="lbldescription"/></label></td>
	  </tr>
	  <tr>
	    <td width="19%" align="left"><b>CARD NO</b></td>
	    <td width="57%"><b>:</b>&nbsp;&nbsp;<label id="cardno" name="cardno"><s:property value="cardno"/></label></td>
        <td width="2%" align="right"><b>:</b></td>
	    <td width="22%" align="right"><b>رقم البطاقة</b></td>
	  </tr>
	  <tr>
	    <td align="left"><b>CARD EXPIRY</b></td>
	    <td><b>:</b>&nbsp;&nbsp;<label id="cardexp" name="cardexp"><s:property value="cardexp"/></label></td>
        <td align="right"><b>:</b></td>
	    <td align="right"><b>تاريخ انتهاء البطاقة</b></td>
  </tr>
  <tr>
	    <td align="left"><b>CHEQUE NO</b></td>
	    <td><b>:</b>&nbsp;&nbsp;<label id="chqno" name="chqno"><s:property value="chqno"/></label></td>
        <td align="right"><b>:</b></td>
	    <td align="right"><b>رقم الشيك</b></td>
	  </tr>
	  <tr>
	    <td align="left"><b>CHEQUE DATE</b></td>
	    <td><b>:</b>&nbsp;&nbsp;<label id="chqdate" name="chqdate"><s:property value="chqdate"/></label></td>
        <td align="right"><b>:</b></td>
	    <td align="right"><b>تاريخ الشيك</b></td>
  </tr>  
</table>
    
    </td>
    <td align="center" class=tablereceipt><label id="paymode" name="paymode"><s:property value="paymode"/></label></td>
    <td align="right" class=tablereceipt><label id="amount" style="text-align: right;" name="amount"><s:property value="amount"/></label></td>
  </tr>
  <tr class=tablereceipt>
    <td width="14%" align="right"><b>Amount in Words&nbsp;&nbsp;</b></td>
    <td width="34%">&nbsp;</td>
    <td width="22%" align="right"><b>القيمه الإجماليه بالحروف</b></td>
    <td align="right"><b>Total</b></td>
    <td align="right"><b>الإجمالى</b></td>
  </tr>
  <tr class=tablereceipt height="25">
    <td colspan="3" class=tablereceipt><label id="amtinwords" name="amtinwords"><s:property value="amtinwords"/></label></td>
    <td colspan="2" align="right"><label id="total" style="text-align: right;" name="total"><s:property value="total"/></label></td>
  </tr>
</table><br/><br/>

<div id="firstdupdiv" hidden="true">
<table width="99%" class="tablereceipt" align="center">
<tr>
    <td colspan="10" class="tablereceipt" height="26" style="background-color: #CEECF5;"><b>Applying</b></td>
  </tr>
  <tr height="25">
    <td width="4%" class="tablereceipt" align="center">Sr.No</td>
    <td width="6%" class="tablereceipt" align="center">Doc No.</td>
    <td width="7%" class="tablereceipt" align="center">Doc Type</td>
    <td width="8%" class="tablereceipt" align="center">Date</td>
    <td width="7%" class="tablereceipt" align="center">Ref Type</td>
    <td width="7%" class="tablereceipt" align="center">Ref No.</td>
    <td width="31%" class="tablereceipt" align="center">Remarks</td>
    <td width="10%" class="tablereceipt" align="right">Amount</td>
    <td width="10%" class="tablereceipt" align="right">Applying</td>
    <td width="10%" class="tablereceipt" align="right">Balance</td>
  </tr>
  
  <%int x=0,y=0; %>
  <s:iterator var="stats" value='#request.printapplyingsarray' >
  <%x=0;y=y+1;%>
	<tr height="25" class=tablereceipt>   
	    <td class="tablereceipt" width="4%" align="center"><%=y%></td>
    	<s:iterator status="arr" value="#stats.split('::')" var="desc">
    	<%x=x+1;%>
    	<% if(x==1){%>
    	<td class=tablereceipt width="6%" align="center">
		    <s:property value="#desc"/>
    	</td>
        <%} else if(x==2){%>
    	<td class=tablereceipt width="7%" align="center">
		    <s:property value="#desc"/>
    	</td>
    	
    	<%} else if(x==3){%>
    	<td class=tablereceipt width="8%" align="center">
		    <s:property value="#desc"/>
    	</td> 
     	<%}else if(x==4){%>
    	<td class=tablereceipt width="7%" align="center">
		    <s:property value="#desc"/>
    	</td>
    	<%}else if(x==5){%>
    	<td class=tablereceipt width="7%" align="center">
		    <s:property value="#desc"/>
    	</td>
    	<%}else if(x==6){%>
    	<td class=tablereceipt width="31%" align="left">
		    <s:property value="#desc"/>
    	</td>
    	<%}else if(x==7){%>
    	<td class=tablereceipt width="10%" align="right">
		    <s:property value="#desc"/>
    	</td>
    	<%}else if(x==8){%>
    	<td class=tablereceipt width="10%" align="right">
		    <s:property value="#desc"/>
    	</td>
    	<%}else if(x==9){%>
    	<td class=tablereceipt width="10%" align="right">
		    <s:property value="#desc"/>
    	</td>
   		<%} else{ %>
  		<td class=tablereceipt  width="4%" align="center">
		  <s:property value="#desc"/>
  		</td>
  		<% } %>
 		</s:iterator>
	</tr>
	</s:iterator>
	
</table><br/><br/>
</div>

<table width="100%">
  <tr>
    <td colspan="3" align="left"><b>أعدت بواسطة</b></td>
    <td align="right"><b>العميل</b></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td width="11%" align="left"><b>Prepared by :</b></td>
    <td width="25%"><label id="preparedby" name="preparedby"><s:property value="preparedby"/></label></td>
    <td width="21%">&nbsp;</td>
    <td width="16%" align="right"><b>Customer :</b></td>
    <td width="27%"><hr style="border:0;border-bottom: 1px dashed #ccc;" size=1 width="100%"></td>
  </tr>
</table>

<input type="hidden" id="firstarray" name="firstarray" value='<s:property value="firstarray"/>'> 
</div>
</form>
</div>
</body>
</html>