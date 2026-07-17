<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
	
<style type="text/css">
.icon1 {
	width: 2.5em;
	height: 2em;
	border: none;
	background-color: #f0f0f0;
}
</style>
</head>
<body>
<div width="100%">
        <fieldset>
        <legend>Traffic Fines</legend>
        <fieldset><legend>Fines Invoiced</legend>
		<jsp:include page="finesInvoiced.jsp"></jsp:include><br/>
		<!-- <table width="100%">
   		 <tr>
   			 <td width="15%" align="right">Service Charge</td>
    		 <td width="18%"><input type="text" name="invoicedServiceCharge" style="width:80%"></td>
    		 <td width="13%" align="right">Total Invoiced</td>
    		 <td width="18%"><input type="text" name="totalInvoiced" style="width:80%"></td>
    		 <td width="17%" align="right"><button class="icon1" id="btnInvoicedPrint" title="Print Traffic Fine Details">
							<img alt="printDocument" src="../../../../icons/print_new.png">
						</button></td>
		 </tr></table>  -->
		</fieldset><fieldset><legend>Fines Not Invoiced</legend>
		<jsp:include page="finesNotInvoiced.jsp"></jsp:include><br/>
		<!-- <table width="100%">
            <tr>
	        <td width="24%" align="right">Service Charge</td>
            <td width="28%"><input type="text" name="notInvoicedServiceCharge" style="width:80%"></td>
            <td width="21%" align="right">Total Not Invoiced</td>
            <td width="27%"><input type="text" name="totalNotInvoiced" style="width:80%"></td>    		 
          </tr></table>  -->
		</fieldset>
		</fieldset>
</div>
</body>
</html>