<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../../includes.jsp"></jsp:include>

<script type="text/javascript">
     $(document).ready(function () {  
	    /* Date */
    	$("#jqxInvoiceDate").jqxDateTimeInput({ width: '40%', height: '15px',formatString:"dd.MM.yyyy"}); 
        $("#jqxInvoiceDateOut").jqxDateTimeInput({ width: '60%', height: '15px',formatString:"dd.MM.yyyy"});
        $("#jqxInvoiceDateIn").jqxDateTimeInput({ width: '60%', height: '15px',formatString:"dd.MM.yyyy"});
        $("#jqxInvoiceCDate").jqxDateTimeInput({ width: '60%', height: '15px',formatString:"dd.MM.yyyy"});
        $("#jqxInvoicePeriodForm").jqxDateTimeInput({ width: '50%', height: '15px',formatString:"dd.MM.yyyy"});
        $("#jqxInvoicePeriodTo").jqxDateTimeInput({ width: '60%', height: '15px',formatString:"dd.MM.yyyy"});       
     });
 
    function funReset(){
		$('#frmManualInvoice')[0].reset(); 
	}
	function funReadOnly(){
		$('#frmManualInvoice input').attr('readonly', true );
		$('#frmManualInvoice select').attr('disabled', true);
		$('#frmManualInvoice textarea').attr('readonly', true );
	    $('#jqxInvoiceDate').jqxDateTimeInput({ disabled: true});
	    $("#jqxInvoiceDateOut").jqxDateTimeInput({ disabled: true});
        $("#jqxInvoiceDateIn").jqxDateTimeInput({ disabled: true});
        $("#jqxInvoiceCDate").jqxDateTimeInput({ disabled: true});
        $("#jqxInvoicePeriodForm").jqxDateTimeInput({ disabled: true});
        $("#jqxInvoicePeriodTo").jqxDateTimeInput({ disabled: true});  
	    $("#jqxManualInvoice").jqxGrid({ disabled: true});
	}
	
	function funRemoveReadOnly(){
		$('#frmManualInvoice input').attr('readonly', false );
		$('#frmManualInvoice select').attr('disabled', false);
		$('#frmManualInvoice textarea').attr('readonly', false );
		$('#jqxInvoiceDate').jqxDateTimeInput({ disabled: false});
		$("#jqxInvoiceDateOut").jqxDateTimeInput({ disabled: false});
        $("#jqxInvoiceDateIn").jqxDateTimeInput({ disabled: false});
        $("#jqxInvoiceCDate").jqxDateTimeInput({ disabled: false});
        $("#jqxInvoicePeriodForm").jqxDateTimeInput({ disabled: false});
        $("#jqxInvoicePeriodTo").jqxDateTimeInput({ disabled: false});  
		$("#jqxManualInvoice").jqxGrid({ disabled: false});
		$('#txtinvoicedocno').attr('readonly', true);
	}
	
	function funNotify(){	
		return 1;
     } 
	
	 function funChkButton() {
			/* funReset(); */
		}
	
	function funSearchLoad(){
			/* changeContent('cpvMainSearch.jsp', $('#window')); */ 
	}
			
    function funFocus(){
		   	$('#jqxInvoiceDate').jqxDateTimeInput('focus'); 	    		
	 }

</script>  
<style>
.hidden-scrollbar {
overflow: auto;
height: 530px;
}
</style>
</head>
<body onload="funReadOnly();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmManualInvoice" action="saveManualInvoice" >
<jsp:include page="../../../../../header.jsp"></jsp:include><br/>

<div class='hidden-scrollbar'>
<fieldset>
    <legend>Document Details</legend>
<table width="100%">
  <tr>
    <td width="6%" align="right">Date</td>
    <td width="21%"><div id="jqxInvoiceDate" name="jqxInvoiceDate" value='<s:property value="jqxInvoiceDate"/>'></div>
        <input type="hidden" id="hidjqxInvoiceDate" name="hidjqxInvoiceDate" value='<s:property value="hidjqxInvoiceDate"/>'/></td>
    <td width="8%" align="right">Branch</td>
    <td width="9%"><select id="cmbbranch" name="cmbbranch" value='<s:property value="cmbbranch"/>'>
                      <option>--Select--</option></select>
                      <input type="hidden" id="hidcmbbranch" name="hidcmbbranch" value='<s:property value="hidcmbbranch"/>'/></td>
    <td width="34%"><input type="text" id="txtbranchname" name="txtbranchname" style="width:70%" value='<s:property value="txtbranchname"/>'/></td>
    <td width="6%" align="right">Doc No</td>
    <td width="16%"><input type="text" id="txtinvoicedocno" name="txtinvoicedocno" tabindex="-1" value='<s:property value="txtinvoicedocno"/>'/></td>
  </tr>
</table>
</fieldset>

<fieldset>
    <legend>Leasing Details</legend>
<table width="100%">
  <tr>
    <td width="6%" align="right">Type</td>
    <td width="10%"><select id="cmbtype" name="cmbtype" value='<s:property value="cmbtype"/>'>
                      <option>--Select--</option></select>
                      <input type="hidden" id="hidcmbtype" name="hidcmbtype" value='<s:property value="hidcmbtype"/>'/></td>
    <td width="6%" align="right">RA</td>
    <td width="9%"><select id="cmbra" name="cmbra" value='<s:property value="cmbra"/>'>
                      <option>--Select--</option></select>
                      <input type="hidden" id="hidcmbra" name="hidcmbra" value='<s:property value="hidcmbra"/>'/></td>
    <td width="7%" align="right">R Type</td>
    <td width="14%"><input type="text" id="txtrtype" name="txtrtype" style="width:53%" value='<s:property value="txtrtype"/>'/></td>
    <td width="8%" align="right">Dt. Out</td>
    <td width="15%"><div id="jqxInvoiceDateOut" name="jqxInvoiceDateOut" value='<s:property value="jqxInvoiceDateOut"/>'></div>
        <input type="hidden" id="hidjqxInvoiceDateOut" name="hidjqxInvoiceDateOut" value='<s:property value="hidjqxInvoiceDateOut"/>'/></td>
    <td width="10%" align="right">Dt. In</td>
    <td width="15%"><div id="jqxInvoiceDateIn" name="jqxInvoiceDateIn" value='<s:property value="jqxInvoiceDateIn"/>'></div>
        <input type="hidden" id="hidjqxInvoiceDateIn" name="hidjqxInvoiceDateIn" value='<s:property value="hidjqxInvoiceDateIn"/>'/></td>
  </tr>
  <tr>
    <td align="right">Client</td>
    <td><select id="cmbclient" name="cmbclient" value='<s:property value="cmbclient"/>'>
            <option>--Select--</option></select>
            <input type="hidden" id="hidcmbclient" name="hidcmbclient" value='<s:property value="hidcmbclient"/>'/></td>
    <td colspan="6"><input type="text" id="txtclientname" name="txtclientname" style="width:50%" value='<s:property value="txtclientname"/>'/></td>
    <td align="right">CIN</td>
    <td><input type="text" id="txtcin" name="txtcin" style="width:60%" value='<s:property value="txtcin"/>'/></td>
  </tr>
  <tr>
    <td align="right">Driver</td>
    <td><select id="cmbdriver" name="cmbdriver" value='<s:property value="cmbdriver"/>'>
          <option>--Select--</option></select>
          <input type="hidden" id="hidcmbdriver" name="hidcmbdriver" value='<s:property value="hidcmbdriver"/>'/></td>
    <td colspan="6"><input type="text" id="txtdrivername" name="txtdrivername" style="width:50%" value='<s:property value="txtdrivername"/>'/></td>
    <td align="right">CDate</td>
    <td><div id="jqxInvoiceCDate" name="jqxInvoiceCDate" value='<s:property value="jqxInvoiceCDate"/>'></div>
        <input type="hidden" id="hidjqxInvoiceCDate" name="hidjqxInvoiceCDate" value='<s:property value="hidjqxInvoiceCDate"/>'/></td>
  </tr>
</table>
</fieldset>
<fieldset>
 <legend>Invoice Details</legend>
<table width="100%">
  <tr>
    <td width="9%" align="right">Inv. Type</td>
    <td width="9%"><select id="cmbinvoicetype" name="cmbinvoicetype" value='<s:property value="cmbinvoicetype"/>'>
                      <option>--Select--</option></select>
                      <input type="hidden" id="hidcmbinvoicetype" name="hidcmbinvoicetype" value='<s:property value="hidcmbinvoicetype"/>'/></td>
    <td width="10%" align="right">Pay Type</td>
    <td width="11%"><select id="cmbpaytype" name="cmbpaytype" value='<s:property value="cmbpaytype"/>'>
                      <option>--Select--</option></select>
                      <input type="hidden" id="hidcmbpaytype" name="hidcmbpaytype" value='<s:property value="hidcmbpaytype"/>'/></td>
    <td width="7%" align="right">Card</td>
    <td width="10%"><select id="cmbcard" name="cmbcard" value='<s:property value="cmbcard"/>'>
                      <option>--Select--</option></select>
                      <input type="hidden" id="hidcmbcard" name="hidcmbcard" value='<s:property value="hidcmbcard"/>'/></td>
    <td width="10%" align="right">Period Form</td>
    <td width="16%"><div id="jqxInvoicePeriodForm" name="jqxInvoicePeriodForm" value='<s:property value="jqxInvoicePeriodForm"/>'></div>
        <input type="hidden" id="hidjqxInvoicePeriodForm" name="hidjqxInvoicePeriodForm" value='<s:property value="hidjqxInvoicePeriodForm"/>'/></td>
    <td width="3%" align="right">To</td>
    <td width="15%"><div id="jqxInvoicePeriodTo" name="jqxInvoicePeriodTo" value='<s:property value="jqxInvoicePeriodTo"/>'></div>
        <input type="hidden" id="hidjqxInvoicePeriodTo" name="hidjqxInvoicePeriodTo" value='<s:property value="hidjqxInvoicePeriodTo"/>'/></td>
  </tr>
  <tr>
    <td align="right">Ledger Note</td>
    <td colspan="9"><input type="text" id="txtledgernote" name="txtledgernote" style="width:71.5%" value='<s:property value="txtledgernote"/>'/></td>
  </tr>
  <tr>
    <td align="right">Inv. Note</td>
  <td colspan="9"><textarea id="txtinvoicenote" name="txtinvoicenote" style="width:71.5%;resize: none;" value='<s:property value="txtinvoicenote"/>'></textarea>  </tr>
</table>
</fieldset>
<br/>
<jsp:include page="invoiceGrid.jsp"></jsp:include><br/>
<fieldset>
<table width="100%">
  <tr>
    <td width="9%" align="right">Grand Total</td>
    <td width="16%"><input type="text" id="txtgrandtotal" name="txtgrandtotal" value='<s:property value="txtgrandtotal"/>'/></td>
    <td width="21%" align="right">Discount</td>
    <td width="27%"><input type="text" id="txtdiscount" name="txtdiscount" value='<s:property value="txtdiscount"/>'/></td>
    <td width="9%" align="right">Net Amoumt</td>
    <td width="18%"><input type="text" id="txtnetamount" name="txtnetamount" value='<s:property value="txtnetamount"/>'/></td>
  </tr>
</table>
</fieldset>
</div>
</form>
<input type="hidden" id="mode" name="mode"/>
<input type="text" name="delete" id="delete" value='<s:property value="delete"/>' hidden="true"/>
</div>
</body>
</html>