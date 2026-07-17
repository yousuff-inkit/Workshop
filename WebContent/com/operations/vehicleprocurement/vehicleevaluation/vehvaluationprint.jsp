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
 
 
 
 
<script>

</script>
</head>
<body style="font-size:10px;"  bgcolor="white">
<div id="mainBG" class="homeContent" data-type="background">
<form id="fmnq" action="priInvoices" autocomplete="off" target="_blank">
<%-- <jsp:include page="../../../../../header.jsp"></jsp:include> --%> <br/> 

 <div style="background-color:white;">
<table width="100%" >
  <tr>
<pre>




</pre>

    
  </tr>
</table>

   <table align="center" width="83%">
   	<tr>
   		<td>
   			 <table width="100%" > 
 <tr>
   <td width="24%" align="left"><b>Date&nbsp;&nbsp;:</b>
   <label id="lbldate" name="lbldate"><s:property value="lbldate"/></label></td>
  </tr>
  <tr>
  	<td align="left" colspan="2"><b>
      To,The Manager &nbsp; </b> </td>
    </tr>
  <tr>
      <td colspan="2" align="left" ><b> Auto Loan Department-Rak Bank-Dubai-UEA  </b> </td>
    </tr>
    <tr>
      <td  align="left" ><b>Inspection Vehicle In &nbsp;:</b>
   <label id="lblindigonationality" name="lblclient"><s:property value="lblclient"/></label></td>
    </tr>
      <tr>
    <td  align="left"><b> Contact # </b>
    &nbsp;&nbsp;&nbsp;<label id="lblcontact" name="lblcontact"><s:property value="lblcontact"/></label></td>
    </tr>
     <tr>
    <td  align="left" colspan="2"><b><h3>  <u>Subject:&nbsp;Evaluation </u></h3></b></td>
    </tr>
    <tr>
    <td  align="left" colspan="2"><pre><b> <h3> <i>We have evaluated the following vehicle for a price of 
 AED 1,000,000(Darham one million zero Only),<u>the details of which are as follows</u> </i></h3></b></pre></td>
    </tr>
   </table>
   </td>
   </tr>			
   </table> 
<table align="center" width="83%" > 
<tr><td>
<fieldset>
<table align="left" width="100%" > 
  <tr>
    <td width="25%" align="left"><b><h3>Car Maker(Brand)&nbsp;: </h3></b></td>
    <td width="10%" align="left"> <h4> <label id="lblbrand" name="lblbrand"><s:property value="lblbrand"/></label> </h4></td> 
    </tr>
    <tr>
     <td width="15%" align="left"><b><h3>Model &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</h3></b></td>
    <td width="10%" align="left"> <label id="lblmodel" name="lblmodel"><s:property value="lblmodel"/></label></td> 
    </tr>
    <tr>
     <td width="15%"align="left"><b><h3>Year Of Make&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</h3></b></td>
    <td width="10%"> <label name="lblyom" id="lblyom" ><s:property value="lblyom"/></label></td>
    </tr>
    <tr>
    <td width="10%" align="left"><b><h3>Color&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                               &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</h3></b></td>
    <td   align="left">  <label id="lblcolor" name="lblcolor"><s:property value="lblcolor"/></label></td>
    </tr>
    <tr>
    <td align="left"><b><h3>Interior Color&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</h3></b></td>
    <td colspan="7" align="left"> <label name="lblintrcolor" id="lblintrcolor" ><s:property value="lblintrcolor"/></label></td>
    </tr>
    <tr>
    <td align="left"><b><h3>Transmission&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</h3></b></td>
    <td colspan="7" align="left"> <label name="lbltrans" id="lbltrans" ><s:property value="lbltrans"/></label></td>
    </tr>
    <tr>
    <td align="left"><b><h3>Chassis No.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</h3></b></td>
    <td colspan="7" align="left"> <label name="lblchno" id="lblchno" ><s:property value="lblchno"/></label></td>
    </tr>
     <tr>
    <td align="left"><b><h3>Engine No.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</h3></b></td>
    <td colspan="7" align="left"> <label name="lblengineno" id="lblengineno" ><s:property value="lblengineno"/></label></td>
    </tr>
     <tr>
    <td align="left"><b><h3>Odometer(KM).&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</h3></b></td>
    <td colspan="7" align="left"> <label name="lblodo" id="lblodo" ><s:property value="lblodo"/></label></td>
   <td><b> <td colspan="7" align="left"> <label name="lblcond" id="lblcond" ><s:property value="lblcond"/></label></b></td></tr>
    

 
   </table>
</fieldset>
</td>
<tr>
</tr>
</table>
<table>
 <tr>
    <td  align="left" colspan="2"><pre><b><i> <h3> <i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; The above mentioned car details and evaluated price is given on the client request,
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Auto plus will not be responsible if any amendments made.</i></h3></b></pre></td>
    </tr>
<tr>

<tr>
<td align="left">
          <p><i><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
           With regards</b></i></p></td>
</tr>
</table>
<table>
<tr>
<td align="left">
          <p><i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          &nbsp;&nbsp;&nbsp;&nbsp;<b>
           Gulf Automobile Trading Co.(L.L.C) Autoplus</b></i></p></td>
</tr>
</table>
<br>  


<br>
<jsp:include page="../../../common/printFooter.jsp"></jsp:include>


</div>
</form>
</div>
</body>
</html>
