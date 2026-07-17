
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
	//alert("hgchjh");
	 document.getElementById("mode").value="print";
	document.getElementById("frmManualInvoicePrint").submit(); 
}
</script>
</head>
<body onload=""  style="font-size:12px;background-color:white;">
<div id="mainBG" class="homeContent" data-type="background">
<%-- <s:set name="counter" value="0"></s:set>
<s:set name="salik" value="#lblsalikcount"></s:set>
<s:iterator value='#request.TRIAL' var="#aa" status="arr">
 --%>
<form id="frmManualInvoicePrint" action="printSaleInvoice" autocomplete="off" target="_blank" >
 <jsp:include page="../../../common/printHeader.jsp"></jsp:include> 
<fieldset>
<table width="100%">
  <tr>
    <td width="16%" align="left">Client Name </td>
    <td colspan="3">: <label name="lblclientname" id="lblclientname" ><s:property value="lblclientname"/></label></td>
    <td width="18%" align="left">Doc No </td>
    <td width="20%"> : <label name="lbldocno" id="lbldocno" ><s:property value="lbldocno"/></label></td>
  </tr>
  <tr>
    <td align="left">Client Code </td>
    <td width="18%">: <label name="lblclientcode" id="lblclientcode" ><s:property value="lblclientcode"/></label></td>
    <td width="12%" align="left">&nbsp;</td>
    <td width="16%"></td>
    <td align="left">Date </td>
    <td>: <label name="lbldate" id="lbldate" ><s:property value="lbldate"/></label></td>
  </tr>
  <tr>
    <td align="left">Address </td>
    <td colspan="3">: <label name="lbladdress1" id="lbladdress1" ><s:property value="lbladdress1"/></label></td>
    <td align="left">Mobile </td>
    <td>: <label name="lblphone" id="lblphone" ><s:property value="lblphone"/></label></td>
  </tr>
  <tr>
    <td align="left">&nbsp;</td>
    <td colspan="3">: <label name="lbladdress2" id="lbladdress2" ><s:property value="lbladdress2"/></label></td>
    <td align="left">Phone</td>
    <td>: <label name="lblmobile" id="lblmobile" ><s:property value="lblmobile"/></label></td>
  </tr>
  <tr>
    <td align="left">&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td align="left">Type </td>
    <td>: <label name="lbltype" id="lbltype" ><s:property value="lbltype"/></label></td>
  </tr>
  <tr>
    <td align="left">Description </td>
    <td>: <label name="lbldesc" id="lbldesc" ><s:property value="lbldesc"/></label></td>
    <td align="left">&nbsp;</td>
    <td></td>
    
  </tr>
  
</table>
</fieldset>
<br>

<hr>
<table width="100%">
 <tr>
    <td align="left" width="20%"><b>SI No</b></td>
    <td align="left" width="25%"><b>Fleet</b></td>
    <td align="left" width="35%"><b>Fleet Name</b></td>
    <!-- <td align="left"><b>Dep Posted</b></td> -->
    <td align="right" width="20%"><b>Sales Price</b></td>
    <!-- <td align="right"><b>Pur Value</b></td>
    <td align="right"><b>Acc Dep</b></td>
    <td align="right"><b>Cur Dep</b></td>
    <td align="right"><b>Net Book</b></td>
    <td align="right"><b>Net P/(L)</b></td> -->
  </tr>
  
  
  </tr>
 <s:iterator var="stat1" status="arr" value="%{#request.INVPRINT}" >
	
		<s:iterator status="arr" value="#stat1" var="stat" >
        	<tr>   
				
     				<s:iterator status="arr" value="#stat.split('::')" var="des" begin="0" end="4">
     				<s:if test="#arr.index!=3">
    					<s:if test="#arr.index<=2">  
  							<td  align="left">
  						</s:if>
  						<s:else>
  							<td  align="right">
  						</s:else>
  						
								<s:property value="#des"/>
						</s:if>
							</td>
   					
 					</s:iterator>
			</tr>
		</s:iterator>
	
</s:iterator>

</table>


<hr>
<table width="100%" >
  <tr>
    <td width="197" align="left"><b>Total :</b></td>
    <td width="752">&nbsp;</td>
    <td width="163">&nbsp;</td>
    <td width="146" align="right"><b><label id="lbltotal" name="lbltotal"><s:property value="lbltotal"/></label></b></td>
  </tr>
  
  <tr>
    <td align="left"><b>Amount In Words : </b></td>
    <td colspan="3" align="right"><b><label id="lblamountwords" name="lblamountwords"><s:property value="lblamountwords"/></label></b></td>
    </tr>
</table>

<hr>
<div id="bottompage">
<table width="100%" >
  <tr>
    <td width="13%">Processed By</td>
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
<br/><br/><br/><br/><br/><br/>
<div class="divFooter">
 
<table width="100%">
 <tr>
     <td colspan="3" align="center"><fieldset><font style="color: #D8D8D8;font-size: 11px;">System Generated Document Signature & Stamp Not Required.</font></fieldset></td>
  </tr>
  <tr>
  <td width="47%" style="color: #D8D8D8;" align="left"><i>Printed by <%=session.getAttribute("USERNAME")%> 
  <label id="lblfooter"></label></i></td>
  
  <td width="43%" style="color: #FAFAFA;" align="left">Powered by GATEWAY ERP</td>
  
 <td width="10%" style="color: #D8D8D8;">
    <div id="content"> 
  <div id="pageFooter"></div>
   </div>  
  </td>
  </tr>
</table>

</div>
<input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'/>
 </form>
</div>
 
</body>
</html>
