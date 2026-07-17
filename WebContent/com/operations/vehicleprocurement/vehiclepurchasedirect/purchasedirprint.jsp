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

</style> 
  <%-- <style type="text/css">
    @media screen {
        div.divFooter {
            display: none;
        }
    }
    @media print {
        div.divFooter {
            position: fixed;
            bottom: 0;
        }
    }
 </style>  --%>
 
<%--  
 <style> --%>

<STYLE TYPE="text/css">
     H2 {page-break-before: always}
</STYLE>

<!-- @media print {
    footer {page-break-after: always;}
} -->
<%-- </style> --%>
 
<script>



/* function hidedata()
{
	 
	var first=document.getElementById("firstarray").value;


	if(parseInt(first)==1)
		{
		   $("#firstdiv").prop("hidden", false);
		}
	else
		{
		$("#firstdiv").prop("hidden", true);
		}
	
	
	
	
	}
 */
</script>
</head>
<body style="font-size:10px;"  bgcolor="white" onload="hidedata();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="fmnq" action="priInvoices" autocomplete="off" target="_blank">
<%-- <jsp:include page="../../../../../header.jsp"></jsp:include> --%> <br/> 

 <div style="background-color:white;">
<table width="100%">
  <tr>

  <td><jsp:include page="../../../common/printHeader.jsp"></jsp:include></td>
    
  </tr>
</table>
<fieldset>
<!-- <table width="100%">
<tr>
<td width="60%">


 -->
  
<table width="100%" > 
  <tr>
    <td width="10%" align="left">Date </td>
    <td width="25%" align="left">: <label id="lbldate" name="lbldate"><s:property value="lbldate"/></label></td> 
 
     <td width="8%" align="left">Vendor</td>
    <td width="45%" align="left">: <label id="lblvendoeacc" name="lblvendoeacc"><s:property value="lblvendoeacc"/></label> 
    &nbsp; <label id="lblvendoeaccName" name="lblvendoeaccName"><s:property value="lblvendoeaccName"/></label>
    </td> 

    <td width="8%" align="left">Doc No</td>
    <td   align="left">: <label id="lbldoc" name="lbldoc"><s:property value="lbldoc"/></label></td>
    </tr>
    <tr>
    <td width="10%" align="left">Purchase Date</td>
    <td width="25%" align="left">: <label id="lblpurchaseDate" name="lblpurchaseDate"><s:property value="lblpurchaseDate"/></label></td> 
       <td width="8%" align="left">Inv No </td>
    <td width="35%" align="left">: <label id="lblinvno" name="lblinvno"><s:property value="lblinvno"/></label></td> 
             
    </tr>
    
    
    <tr>
        <td width="10%" align="left">Description</td>
    <td  width="10%" align="left">: <label name="lbldesc1" id="lbldesc1" ><s:property value="lbldesc1"/></label></td>
  </tr>

 
   </table>

</fieldset>
<br>  






 <fieldset>  
<table style="border-collapse: collapse;" width="100%"  >

 <tr height="25" style="background-color: #D8D8D8;border-collapse: collapse;">
    <td align="left" style="border-collapse: collapse;"><b>Sl No</b></td>
    <td align="left" style="border-collapse: collapse;"><b>Fleet</b></td>
<td align="left" style="border-collapse: collapse;"><b>Reg No</b></td>
    
    <td align="left" style="border-collapse: collapse;"><b>Brand</b></td>
    <td align="left" style="border-collapse: collapse;"><b>Model</b></td>
    <td align="left" style="border-collapse: collapse;"><b>Color</b></td>
    <td align="left" style="border-collapse: collapse;"><b>Chassis No</b></td>
    <td align="left" style="border-collapse: collapse;"><b>Engine No</b></td>
    <td align="left" style="border-collapse: collapse;"><b>Purchase Cost</b></td>
    <td align="left" style="border-collapse: collapse;"><b>Additional Cost</b></td>
     <td align="left" style="border-collapse: collapse;"><b>Price</b></td>
 
  </tr>

<s:iterator var="stat" value='#request.details' >
<tr>   
<%int i=0; %>
    <s:iterator status="arr" value="#stat.split('::')" var="des">   
    <%
    if(i>1){%>
    
  <td  align="left" >
  <s:property value="#des"/>
  </td>
   <%} else{ %>
    
  <td  align="left" >
  <s:property value="#des"/>
  </td>
  <% } i++;  %>
 </s:iterator>
</tr>
</s:iterator>
 <tr >
    <td >&nbsp;</td>
    <td>&nbsp;</td>
    <td >&nbsp;</td>
    <td >&nbsp;</td>
    <td >&nbsp;</td>
    <td >&nbsp;</td>
    <td  >&nbsp;</td>
     <td  >&nbsp;</td>
     <td  >&nbsp;</td>
       <td  >&nbsp;</td>
 
  </tr>
 <tr >
    <td ><b></b></td>
    <td><b></b></td>
    <td ><b></b></td>
    <td ><b></b></td>
    <td ><b></b></td>
    <td ><b></b></td>
    <td align="left" ><b>Total</b></td>
     <td align="left" ><label id="lbltotal"><s:property value="lbltotal"/></label></td>
      <td  >&nbsp;</td>
<td  >&nbsp;</td>
 
 
<%--   </tr>
  
  <tr><td>&nbsp;&nbsp;</td> <td>&nbsp;&nbsp;</td><td>&nbsp;&nbsp;</td><td width="50%" colspan="7"><b> Amount in words:</b> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <label id="amountinwords"><s:property value="amountinwords"/></label></td>
  </tr> --%>
  
</table>
<table width="100%">
 
  
  <tr><td>&nbsp;&nbsp;</td> <td>&nbsp;&nbsp;</td><td>&nbsp;&nbsp;</td><td width="50%" colspan="7"><b> Amount in words:</b> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <label id="amountinwords"><s:property value="amountinwords"/></label></td>
  </tr> 
  
</table>


 </fieldset> 
 

 <input type="hidden" id="firstarray" name="firstarray" value='<s:property value="firstarray"/>'>  

  <div class="divFooter">
  


  </div>
   
<br>
<jsp:include page="../../../common/printFooter.jsp"></jsp:include>
<br>


</div>
</form>
</div>
</body>
</html>
