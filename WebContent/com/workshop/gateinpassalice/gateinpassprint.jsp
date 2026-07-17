<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<!-- <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8"> -->
<title>GatewayERP(i)</title>
<%-- <jsp:include page="../../../../includes.jsp"></jsp:include> --%>
<style>
 /* .hidden-scrollbar {
  overflow: auto;
  height: 800px;
}  */
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
<script>

</script>
</head>
<body style="font-size:10px;" bgcolor="white">
<div id="mainBG" class="homeContent" data-type="background">
<form id="fmnq" action="priInvoice" autocomplete="off" target="_blank">
<%-- <jsp:include page="../../../../../header.jsp"></jsp:include> --%> <br/> 

 <div style="background-color:white;">
<table width="100%">
  <tr>

  <td><jsp:include page="../../common/printHeader.jsp"></jsp:include></td>
    
  </tr>
</table>
<table width="100%" >
<tr>
<td width="80%">
<fieldset>
<table width="100%"   > 
  <tr>
    <td colspan="6" width="100%" align="center"> <u><h3><b><label id="lblcompanyname" name="lblcompanyname"><s:property value="lblcompanyname"/></label></b></h3></u></td>   
  </tr>
  <tr >
  <td width="5%" align="right"></td>
  <td width="15%"></td><td width="20%"></td>
  <td width="30%"></td>
  <td width="15%" align="right">Date</td>
  <td  width="15%" align="left"> :<label id="lbldate" name="lbldate"><s:property value="lbldate"/></label></td>
  
  </tr>
  <tr>
  <td>&nbsp;</td></tr>
 
<tr >
<td width="5%" align="right"></td>
  <td width="18%"><b>Release Vehicle No.</b></td><td  align="left"> :<label id="lblrvehicleno" name="lblrvehicleno"><s:property value="lblrvehicleno"/></label></td>
  <td width="30%" align="right"><b>job No.&nbsp;&nbsp;&nbsp;:</b></td>
  <td width="15%" align="left"> <label id="lbljobno" name="lbljobno"><s:property value="lbljobno"/></label></td>
  <td width="15%" align="center"></td> 
  
  </tr>
  
  <tr>
  <td>&nbsp;</td></tr>
  
  
  <tr >
<td width="5%" align="right"></td>
  <td width="15%"><b>Type</b></td><td  align="left"> :<label id="lbltype" name="lbltype"><s:property value="lbltype"/></label></td>
  <td width="30%" align="right">:</td>
  <td width="15%" align="left"><b>Without Payment</b> </td>
  <td width="15%" align="center"></td> 
  
  </tr>
  
  <tr>
  <td>&nbsp;</td></tr>
   
  <tr >
<td width="5%" align="right"></td>
  <td width="15%"><b>Customer</b></td><td  align="left"> :<label id="lblcustomer" name="lblcustomer"><s:property value="lblcustomer"/></label></td>
  <td width="30%" align="right"><b>person&nbsp;&nbsp;&nbsp;:</b></td>
  <td width="15%" align="left"> <label id="lblperson" name="lblperson"><s:property value="lblperson"/></label></td>
  <td width="15%" align="center"></td> 
  
  </tr>
  
  <tr>
  <td>&nbsp;&nbsp;</td></tr>
   
  <tr >
<td width="5%" align="right"></td>
  <td width="15%"><b>Chasis No.</b></td><td  align="left"> :<label id="lblchasisno" name="lblchasisno"><s:property value="lblchasisno"/></label></td>
  <td width="30%" align="right"><b>Engine No.&nbsp;&nbsp;&nbsp;:</b></td>
  <td width="15%" align="left"> <label id="lblengineno" name="lblengineno"><s:property value="lblengineno"/></label></td>
  <td width="15%" align="center"></td> 
  
  </tr>
 <td>&nbsp;&nbsp;</td></tr>
   <tr >
<td width="5%" align="right"></td>
  <td width="15%"><b>Model</b></td><td  align="left"> :<label id="lblmodel" name="lblmodel"><s:property value="lblmodel"/></label></td>
  <td width="30%" align="right"><b></b></td>
  <td width="15%" align="left"> </td>
  <td width="15%" align="center"></td> 
  
  </tr>
  </table>
  </fieldset>
  </td></tr>
</table>
  <table width="100%" >
  <tr>
  <td>
 <pre>
 
 
 </pre>
 </td>
  </tr>
  <tr>
  <td>
 <pre>
 
 
 </pre>
 </td>
  </tr>
  <tr>
  <td>
 <pre>
 

 </pre>
 </td>
  </tr>
  <tr>
  <td>
 <pre>
 
 
 </pre>
 </td>
  </tr>
  <tr>
  <td>
 <pre>
 
 
 </pre>
 
 </td>
  </tr>
  <tr>
  <td>
 <pre>
 
 
 </pre>
 </td>
  </tr>
  <tr>
  <td>
 <pre>
 
 
 </pre>
 </td>
  </tr>
  <tr>
  <td>
 <pre>
 
 
 </pre>
 </td>
  </tr>
   <tr >
<td width="5%" align="right"></td>
  <td width="15%"><b>Released By</b></td><td  align="left"> :<label id="lblreleasedby" name="lblreleasedby"><s:property value="lblreleasedby"/></label></td>
  <td width="30%" align="right"></td>
  <td width="15%" align="right">Date&nbsp;&nbsp;&nbsp;: </td>
  <td width="15%" align="left"><label id="lbltodat" name="lbltodat"><s:property value="lbltodat"/></label></td> 
  </tr>
</table>
<jsp:include page="../../common/printFooter.jsp"></jsp:include>
<!-- <div class="divFooter"  >
<table width="100%" >
  <tr>
   <td width="40%">&nbsp;</td> <td width="80%" style="color: #D8D8D8;" align="left"><b>  &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;Powered by GATEWAY ERP
 &nbsp;&nbsp;&nbsp;&nbsp;</b></td>
  </tr>
</table>
</div>  -->


</div>
</form>
</div>
</body>
</html>
