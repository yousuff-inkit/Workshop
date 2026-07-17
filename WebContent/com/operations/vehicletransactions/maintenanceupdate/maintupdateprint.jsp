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
<%--   <style type="text/css">
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
<script type="text/javascript">

function hidedata()
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

</script>
</head>
<body bgcolor="white" style="font-size:10px;" onload="hidedata();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="fmnq" action="priInvoice" autocomplete="off" target="_blank">
<%-- <jsp:include page="../../../../../header.jsp"></jsp:include> --%> <br/> 

 <div style="background-color:white;">
<table width="100%">
  <tr>

  <td><jsp:include page="..\..\..\common\printHeader.jsp"></jsp:include></td>
    
  </tr>
</table>
<fieldset>
<table width="100%">
<tr>
<td width="60%">



  
<table width="100%" > 
  <tr>
    <td width="25%" align="left">Fleet</td>
    <td >: <label id="lblfleetno" name="lblfleetno"><s:property value="lblfleetno"/></label>&nbsp;&nbsp;<label id="lblfleetname" name="lblfleetname"><s:property value="lblfleetname"/></label></td>
    </tr>
    <tr>
    <td align="left">Type </td>
    <td >: <label name="lblservtype" id="lblservtype" ><s:property value="lblservtype"/></label></td>
  </tr>
  <tr>
   
    <td align="left">Current KM </td>
    <td>: <label name="lblcurrkm" id="lblcurrkm" ><s:property value="lblcurrkm"/></label></td>
  </tr>
  <tr>

    <td align="left">Next Ser.Due KM</td>
    <td>: <label name="lblnextserkm" id="lblnextserkm" ><s:property value="lblnextserkm"/></label></td>
  </tr>
 
     
</table>
</td>

<td width="40%">
<table width="100%" >
<tr>
    <td align="left">Reg No</td>
    <td>: <label id="lblreg_no" name="lblreg_no"><s:property value="lblreg_no"/></label></td>
  </tr>
   
  <tr>
    <td width="20%" align="left">Doc No</td>
    <td >: <label id="docvals" name="docvals"><s:property value="docvals"/></label></td>
    </tr>
    <tr>
    <td align="left">Date </td>
    <td >: <label name="lbldate" id="lbldate" ><s:property value="lbldate"/></label></td>
  </tr>

<%--   <tr>

    <td align="left">Garage</td>
     <td >: <label name="lblgarage" id="lblgarage" ><s:property value="lblgarage"/></label></td>
  </tr>
   <tr> --%>
<tr>

    <td align="left">Garage</td>
     <td >: <label name="lblgarage" id="lblgarage" ><s:property value="lblgarage"/></label></td>
  </tr>
     
</table>


</td>
</tr>


</table>

</fieldset>
<br>
<%-- <fieldset>
  <table width="100%" >
    <tr>
      <td width="15%" align="right"> Contract Vehicle  </td>
      <td width="85%">: <label name="lblcontractvehicle" id="lblcontractvehicle" >
        <s:property value="lblcontractvehicle"/>
      </label></td>
    </tr>
  
  </table>
</fieldset> --%>
  <div id="firstdiv" hidden="true" >
<fieldset> 
<table style="border-collapse: collapse;" width="100%"  >

 <tr height="25" style="background-color: #D8D8D8;border-collapse: collapse;">
    <td align="left" style="border-collapse: collapse;"><b>Sl No</b></td>
    <td align="left" style="border-collapse: collapse;"><b>Type</b></td>
    <td align="left" style="border-collapse: collapse;"><b>Description</b></td>
    <td align="left" style="border-collapse: collapse;"><b>Remarks</b></td>
    <td align="right" style="border-collapse: collapse;"><b>Labor Cost</b></td>
    <td align="right" style="border-collapse: collapse;"><b>Parts Cost</b></td>
    <td align="right" style="border-collapse: collapse;"><b>Total</b></td>

 
  </tr>

<s:iterator var="stat" value='#request.details' >
<tr>   
<%int i=0; %>
    <s:iterator status="arr" value="#stat.split('::')" var="des">   
    <%
    if(i>3){%>
    
  <td  align="right" >
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
 <tr style="border-collapse: collapse;">
     <td align="right" style="border-collapse: collapse;" colspan="4"> <b>Total</b></td> 
    <td align="right" style="border-collapse: collapse;"><label id="lblnettotallabour" name="lblnettotallabour"><s:property value="lblnettotallabour"/></label></td>
      <td align="right" style="border-collapse: collapse;"><label id="lblnettotalparts" name="lblnettotalparts"><s:property value="lblnettotalparts"/></label></td>
        <td align="right" style="border-collapse: collapse;"><label id="lblnettotalamount" name="lblnettotalamount"><s:property value="lblnettotalamount"/></label></td>
</table>
</fieldset>
</div> 
<br>
<jsp:include page="..\..\..\common\printFooter.jsp"></jsp:include>
<input type="hidden" id="firstarray" name="firstarray" value='<s:property value="firstarray"/>'>  
</div>
</form>
</div>
</body>
</html>
