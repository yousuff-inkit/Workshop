<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page pageEncoding="utf-8" %> 
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i)</title>
<link href="https://fonts.googleapis.com/css?family=Lobster" rel="stylesheet">
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
table{
border-collapse: collapse;
/* cell-padding:0;
cell-spacing:0; */
}
 
 hr { 
   border-top: 1px solid #e1e2df  ;
    
    }
body,p{
text-decoration:none;
}
.scriptfont{
	font-family: 'Lobster', cursive;
}
</style> 
</head>
<body style="font-size:12px;background-color:#fff;">
	<div id="mainBG" class="homeContent" data-type="background">
		<form id="frmDeFleetPrint" action="printDeFleet" autocomplete="off" target="_blank"><br/> 
			<div style="background-color:white;">
				<table width="100%">
  					<tr>
						<td><jsp:include page="../../../common/printHeader.jsp"></jsp:include></td>
					</tr>
                    <tr>
                    	<td>
                        	<fieldset>
                                <table width="100%" border="0">
                                    <tr>
                                        <td width="10%">Invoice No</td>
                                        <td width="20%">:&nbsp;<label id="lblinvoicedoc" name="lblinvoicedoc"><s:property value="lblinvoicedoc"/></label></td>
                                        <td width="42%">&nbsp;</td>
                                        <td width="13%">Date</td>
                                        <td width="15%">:&nbsp;<label id="lbldate" name="lbldate"><s:property value="lbldate"/></label></td>
                                    </tr>
                                    <tr>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td>Customer</td>
                                        <td colspan="2">:&nbsp;<label id="lblclient" name="lblclient"><s:property value="lblclient"/></label></td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td>P.O.Box</td>
                                        <td>:&nbsp;<label id="lblpobox" name="lblpobox"><s:property value="lblpobox"/></label></td>
                                        <td>&nbsp;</td>
                                        <td>Telephone #</td>
                                        <td>:&nbsp;<label id="lbltelephone" name="lbltelephone"><s:property value="lbltelephone"/></label></td>
                                    </tr>
                                    <tr>
                                        <td>Address</td>
                                        <td>:&nbsp;<label id="lbladdress" name="lbladdress"><s:property value="lbladdress"/></label></td>
                                        <td>&nbsp;</td>
                                        <td>Fax #</td>
                                        <td>:&nbsp;<label id="lblfax" name="lblfax"><s:property value="lblfax"/></label></td>
                                    </tr>
                                 </table>
                              </fieldset>

                        </td>
                    </tr>
                    <tr>
                    	<td>
                    		<fieldset>
                        	<table width="100%" border="0">
                              <tr>
                                <td width="9%" align="center" style="border-bottom:1px solid rgb(139,136,120);">Qty</td>
                                <td colspan="2"  align="center"style="border-bottom:1px solid rgb(139,136,120);">Description</td>
                                <td width="17%"  align="center"style="border-bottom:1px solid rgb(139,136,120);">VSB No</td>
                                <td width="17%"  align="center"style="border-bottom:1px solid rgb(139,136,120);">Amount</td>
                              </tr>
                              <tr>
                                <td align="center">1</td>
                                <td width="21%">Vehicle</td>
                                <td width="36%">&nbsp;<label id="lblvehicle" name="lblvehicle"><s:property value="lblvehicle"/></label></td>
                                <td>&nbsp;<label id="lblvin" name="lblvin"><s:property value="lblvin"/></label></td>
                                <td align="right">&nbsp;<label id="lblamount" name="lblamount"><s:property value="lblamount"/></label></td>
                              </tr>
                              <tr>
                                <td>&nbsp;</td>
                                <td>Model Year</td>
                                <td>&nbsp;<label id="lblyear" name="lblyear"><s:property value="lblyear"/></label></td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                              </tr>
                              <tr>
                                <td>&nbsp;</td>
                                <td>Chassis No</td>
                                <td>&nbsp;<label id="lblchassis" name="lblchassis"><s:property value="lblchassis"/></label></td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                              </tr>
                              <tr>
                                <td>&nbsp;</td>
                                <td>Engine No</td>
                                <td>&nbsp;<label id="lblengine" name="lblengine"><s:property value="lblengine"/></label></td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                              </tr>
                              <tr>
                                <td>&nbsp;</td>
                                <td>Color</td>
                                <td>&nbsp;<label id="lblcolor" name="lblcolor"><s:property value="lblcolor"/></label></td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                              </tr>
                              <tr>
                                <td>&nbsp;</td>
                                <td>Vehicle Mileage</td>
                                <td>&nbsp;<label id="lblmileage" name="lblmileage"><s:property value="lblmileage"/></label></td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                              </tr>
                              <tr>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                              </tr>
                              
                            </table>
                            </fieldset>
                            </td>
                            </tr>
                            <tr>
                            <td>
<%--                                 	<td>Total Amount Due</td>
                                	<td align="right">&nbsp;<label id="lblamount" name="lblamount"><s:property value="lblamount"/></label></td> --%>
                            <!-- <table width="1214">
                            	<tr>
                            		<td width="9%" align="center">Qty</td>
                                	<td colspan="2"  align="center">Description</td>
                                	<td width="17%"  align="center"style="border-bottom:1px solid #000;">VSB No</td>
                                	<td width="17%"  align="center"style="border-bottom:1px solid #000;">Amount</td>
                            		<td>&nbsp;</td>
                                	<td>&nbsp;</td>
                                	<td>&nbsp;</td>
                           
                            	</tr>
                            </table> -->
                            </td>
                            </tr>
                            <tr>
                            	<td>
                            	<br>
                            	<table width="100%" border="0">
                            	  <tr>
                            	    <td width="9%">&nbsp;</td>
                            	    <td width="21%">&nbsp;</td>
                            	    <td width="36%">&nbsp;</td>
                            	    <td width="17%"><span style="font-weight:bold;text-transform:uppercase;">Total Amount Due</span></td>
                            	    <td width="17%" align="right">&nbsp;<label id="lblamount"  name="lblamount"><span style="font-weight:bold;"><s:property value="lblamount"/></span></label></td>
                          	    </tr>
                          	  </table></td>
                            </tr>
                            <tr>
                            	<td>
                                	<table width="100%" border="0">
                                      <tr>
                                        <td>We hereby certify the invoice to be true and correct.<br><br><br><br><br><br><br><br></td>
                                      </tr>
                                      <tr>
                                        <td>Authorized Signature</td>
                                      </tr>
                                      <tr>
                                        <td align="center">Please make cheque payable at Tajeer Auto Leasing</td>
                                      </tr>
                                      <tr>
                                        <td align="center"><span class="scriptfont">Thank you for your business!.</span></td>
                                      </tr>
                                    </table>
                                    </td>
                                    </tr>

 </table>
 </div>
 </form>
 </div>
 </body>
 </html>