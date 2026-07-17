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
<style>
 .hidden-scrollbar {
  overflow: auto;
  height: 800px;
} 

body { counter-reset: page 0;}
 fieldSet {
  -webkit-border-radius: 8px;
  -moz-border-radius: 8px;
  border-radius: 8px;
  border: 1px solid rgb(139,136,120);
 }
 
    @media screen {
        .footer1 {
            display: none;
        }
    }
    @page { counter-increment: page }
#content{
display:table;
counter-reset: page 0;

}
#pageFooter {
    display: table-footer-group;
}

/* 
#pageFooter:before {
     counter-increment: page 1;
	content: counter(page, decimal);
}  
     */
</style> 
<script>
$(document).ready(function(){
	/* var head = $('#pagebreak');
	$("tbody tr:nth-child(10n)").after(head.clone());
	$("tbody tr:nth-child(10n)").css("background-color", "yellow"); */
	//$("tbody tr:nth-child(10n+10)").css("page-break-before", "always");
	//$('tbody tr:nth-child(10n)').nextAll().remove();
	/* $('tbody tr:nth-child(10n)').after($('tbody tr:nth-child(10n)').css('page-break-before','always'));  */
/* 	if($('tbody tr').find('nth-child(42)')){   
		$('tbody tr:nth-child(40n)').after('<br>');
		var head = $('table thead tr');
		$('tbody tr:nth-child(42n)').after(head.clone());
	}
	else{
		$('tbody tr:nth-child(50n)').after('<br>');	
	}
	 */
/* 	 
	if($( "#detailtable tbody tr:eq(40)")){
		alert("hi");
	    var head = $('<tr><td><br/></td></tr>');
	   // var check=$('#check');
	    $( "tbody tr:eq(39)").after(head.clone());
	  //  $( "tbody tr:nth-child(15)").after(check.clone());
	   } 
	   
	else if($( "#detailtable tbody tr:gt(40)")){
	    alert("hinjnj");
		var head = $('<tr><td><br/></td></tr>');
	  //  $( "tbody tr:nth-child(55n)").after(head.clone());
	//    var check=$('#check');
//	    $( "tbody tr:nth-child(60n)").after(check.clone());
	   }
	  */ var height=$(document).height();
	  var total=Math.round(height/842);
	  if(total%1!=0){
		  total=parseInt(total)+1;
	  }
	//document.getElementById("pageFooter").innerText="Pages "+total;
	/*   var head = $('#detailtable thead tr');
	$( "#detailtable tbody tr:nth-child(41)").before(head.clone()); */
});
</script>
</head>
<body onload="" style="background-color:white;">
<!-- <div id="mainBG" class="homeContent" data-type="background"> -->
<s:set name="counter" value="0"></s:set>
<s:set name="salik" value="#lblsalikcount"></s:set>
<s:iterator value='#request.TRIAL' var="#aa">
<form id="frmGroupedInvoicePrint" action="printGroupedInvoice" autocomplete="off" target="_blank">
<table width="100%" class="normaltable">
  <tr>
    <td width="27%" rowspan="6"><img src="<%=contextPath%>/icons/epic.jpg" width="100%" height="auto"  alt=""/></td>
    <td width="41%" rowspan="2">&nbsp;</td>
    <td width="32%"><font size="3"><label id="lblcompname" name="lblcompname" ><s:property value="lblcompname"/></label></font></td>
  </tr>
  <tr>
    <td><b><label id="lblcompaddress" name="lblcompaddress"><s:property value="lblcompaddress"/></label></b></td>
  </tr>
  <tr>
    <td rowspan="2"  align="center"><b><font size="5"><label id="lblprintname" name="lblprintname"><s:property value="lblprintname"/></label></font></b></td>
    <td align="left"><b>Tel :</b>&nbsp;<label id="lblcomptel" name="lblcomptel"><s:property value="lblcomptel"/></label></td>
  </tr>
  <tr>
    <td align="left"><b>Fax :</b>&nbsp;<label name="lblcompfax" id="lblcompfax" ><s:property value="lblcompfax"/></label></td>
  </tr>
  <tr>
    <td rowspan="2">&nbsp;</td>
    <%-- <label id="lblbranch" name="lblbranch" ><s:property value="lblbranch"/></label> --%>
    <td align="left">&nbsp;</td>
  </tr>
  <tr>
  <%-- <label id="lbllocation" name="lbllocation" ><s:property value="lbllocation"/></label> --%>
    <td align="left"><b></b>&nbsp;</td>
  </tr>
  <tr>
    <td colspan="3"><hr noshade size=1 width="100%"></td>
  </tr>
   <tr>
    <td colspan="3"></td></tr></table>
<fieldset>
<table width="100%">
  <tr>
    <td width="16%" align="left">Customer Name </td>
    <td colspan="3">: <label id="lblclient" name="lblclient"><s:property value="lblclient"/></label></td>
    <!-- <td width="22%">&nbsp;</td> -->
    <td width="12%" align="left">INV No </td>
    <td width="20%">: <label name="lblinvno" id="lblinvno" ><s:property value="lblinvno"/></label></td>
  <%-- <label name="lblbranchcode" id="lblbranchcode" ><s:property value="lblbranchcode"/>/</label><label name="lbldateyear" id="lbldateyear" ><s:property value="lbldateyear"/>/</label><label name="lblinvno" id="lblinvno" ><s:property value="lblinvno"/></label> --%>
  </tr>
  <tr>
    <td align="left">Customer Code </td>
    <td width="18%">: <label id="lblaccount" name="lblaccount" ><s:property value="lblaccount"/></label></td>
    <td width="12%" align="left">&nbsp;</td>
    <td></td>
    <td align="left">Date </td>
    <td>: <%-- <label name="lbldate" id="lbldate" ><s:property value="lbldate"/></label> --%><label name="lblinvto" id="lblinvto" ><s:property value="lblinvto"/></label></td>
  </tr>
  <tr>
    <td align="left">Address </td>
    <td colspan="3" align="left">: <label name="lbladdress1" id="lbladdress1" ><s:property value="lbladdress1"/></label></td>
     <td align="left"> Phone </td>
    <td>: <label name="lblphone" id="lblphone" ><s:property value="lblphone"/></label></td>
   <%--  <td align="left">RA No </td>
    <td>: <label name="lblrano" id="lblrano" ><s:property value="lblrano"/></label></td> --%>
  </tr>
  <tr>
    <td align="left">&nbsp;</td>
    <td>: <label name="lbladdress2" id="lbladdress2" ><s:property value="lbladdress2"/></label></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
     <td align="left">Mobile </td>
    <td>: <label name="lblmobile" id="lblmobile" ><s:property value="lblmobile"/></label></td>
<%--     <td align="left">LPO No</td>
    <td>: <label name="lbllpono" id="lbllpono" ><s:property value="lbllpono"/></label></td>
 --%>  </tr>
  
  <%-- <td align="left">MRA No </td>
    <td>: <label name="lblmranno" id="lblmrano" ><s:property value="lblmrano"/></label></td> --%>
   <%-- <td align="left">Type </td>
    <td>: <label name="lblratype" id="lblratype" ><s:property value="lblratype"/></label></td> --%>
    <%-- <td align="left">Contract Start </td>
    <td>: <label id="lblcontractstart" name="lblcontractstart"><s:property value="lblcontractstart"/></label></td> --%>


    
  <tr>
    <td align="left"> </td>
    <td colspan="3"><%-- : <label id="lbldriven" name="lbldriven" ><s:property value="lbldriven"/></label> --%></td>
    <td align="left">Currency</td>
    <td align="left">: <label id="lblcurrency" name="lblcurrency" ><s:property value="lblcurrency"/></label></td>
    
    </tr>
     
</table>
</fieldset>
<br>

<hr>

<table width="100%" id="detailtable">
 <thead>
 <tr class="head">
    <th align="left"><b>SI No</b></th>
    <th align="left"><b>Ref Date</b></th>
    <th align="left"><b>Ref Type</b></th>
    <th align="left"><b>Ref No</b></th>
    <th align="left"><b>Agmt No</b></th>
    <th align="left"><b>MRA No</b></th>
    <th align="left"><b>Org.Reg No</b></th>
    <th align="left"><b>Cur.Reg No</b></th>
    <th align="left"><b>From Date</b></th>
    <th align="left"><b>To Date</b></th>
    <th align="right"><b>Total</b></th>
  </tr>
  </thead>
  <tbody>
 <%-- <s:set name="i" value="0"></s:set> --%>
 <s:iterator var="stat1" status="arr" value="%{#request.INVPRINT}" >

		 <%-- <s:set name="i" value="#i+1"></s:set>
		 <s:if test="#arr5.index>30"> 
		 	<s:set name="i" value="0"></s:set>
		 </s:if>--%>
		 <s:if test="#arr.index==#counter">
		
		    <s:iterator status="arr" value="#stat1" var="stat">  
		<%--     <s:if test="#arr.index==40">
	<div style="page-break-before:always"></div>
</s:if>  --%> 
<tr>   
<%int i=0; %>
    <s:iterator status="arr" value="#stat.split('::')" var="des">   
    <%
    if(i>1){%>
    <s:if test="#arr.index<=9">
  		<td  align="left">  
    </s:if>
    <s:else>
  <td  align="right">  
    </s:else>
  
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
</tbody>
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

<hr>
<div id="bottompage">
<table width="100%" >
  <tr>
    <td width="13%">Checked By</td>
    <td width="20%"><label id="lblcheckedby" name="lblcheckedby"><s:property value="lblcheckedby"/></label></td>
    <td width="13%">Recieved By</td>
    <td width="29%"><label id="lblrecievedby" name="lblrecievedby"><s:property value="lblrecievedby"/></label></td>
    <td width="4%">Date</td>
    <td width="21%"><label id="lblfinaldate" name="lblfinaldate"><s:property value="lblfinaldate"/></label></td>
    </tr>
  <tr>
    <td colspan="6">&nbsp;</td>
    </tr>
</table>
</div>

 <div class="divFooter">
 

</div> 
<!-- </div> -->
<input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'/>
</form>

</s:iterator>
<%-- <div width="135%" style="border:1px solid black;"><jsp:include page="../../../common/printFooter.jsp"></jsp:include></div> --%>
<!-- </div> -->
<table style="width:100%;" class="footer1">
 <tr>
     <td colspan="3" align="center"><fieldset><font style="color: #D8D8D8;font-size: 11px;">System Generated Document Signature & Stamp Not Required.</font></fieldset></td>
  </tr>
  <tr>
  <td width="47%" style="color: #D8D8D8;" align="left"><i>Printed by <%=session.getAttribute("USERNAME")%> 
  <label id="lblfooter"></label></i></td>
  
  <td width="43%" style="color: #FAFAFA;" align="left">Powered by GATEWAY ERP</td>
  
 <td width="10%" style="color: #D8D8D8;">
    <div id="content"> 
  <label id="pageFooter"></label>
   </div>  
  </td>
  </tr>
</table>

</body>
</html>


<%-- 
  <jsp:include page="../../../../css/printtable.css"></jsp:include> 
 <jsp:include page="../../../../js/printTable.js"></jsp:include>  --%>



<%-- 
<fieldset>
  <table width="100%" >
    <tr>
      <td width="15%" align="right"> Contract Vehicle  </td>
      <td width="85%">: <label name="lblcontractvehicle" id="lblcontractvehicle" >
        <s:property value="lblcontractvehicle"/>
      </label></td>
    </tr>
  
  </table>
</fieldset> --%>



<%-- 
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
  
</table> --%>
