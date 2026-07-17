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

	function funReset() {
		$('#frmInvoiceMailing')[0].reset();
	}
	function funReadOnly() {
		$('#frmInvoiceMailing input').attr('readonly', true);
		$('#frmInvoiceMailing select').attr('disabled', true);
		$("#jqxInvoiceMailing").jqxGrid({ disabled: false});
	}
	function funRemoveReadOnly() {
		$('#frmInvoiceMailing input').attr('readonly', false);
		$('#frmInvoiceMailing select').attr('disabled', false);
		$("#jqxInvoiceMailing").jqxGrid({ disabled: false});
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
		   	document.getElementById("cmbbranchid").focus(); 		
	 }
</script>
<style>
.hidden-scrollbar {
overflow: auto;
height: 530px;
}
</style>
</head>
<body>
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmInvoiceMailing" action="saveInvoiceMailing" >
<jsp:include page="../../../../../header.jsp"></jsp:include><br/>

<div class='hidden-scrollbar'>
<fieldset>
<table width="70%">
  <tr>
    <td width="13%" align="right">Branch</td>
    <td width="15%"><select id="cmbbranchid" name="cmbbranchid" style="width:90%" value='<s:property value="cmbbranchid"/>'>
              <option>--Select--</option></select>
              <input type="hidden" id="hidcmbbranchid" name="hidcmbbranchid" value='<s:property value="hidcmbbranchid"/>'/></td>
    <td colspan="4"><input type="text" id="txtbranchname" name="txtbranchname" style="width:55%" value='<s:property value="txtbranchname"/>'/></td>
  </tr>
  <tr>
    <td align="right">Period From</td>
    <td><select id="cmbperiodfrom" name="cmbperiodfrom" style="width:90%" value='<s:property value="cmbperiodfrom"/>'>
              <option>--Select--</option></select>
              <input type="hidden" id="hidcmbperiodfrom" name="hidcmbperiodfrom" value='<s:property value="hidcmbperiodfrom"/>'/></td>
    <td colspan="4">To&nbsp;&nbsp;<select id="cmbperiodto" name="cmbperiodto" style="width:18%" value='<s:property value="cmbperiodto"/>'>
              <option>--Select--</option></select>
              <input type="hidden" id="hidcmbperiodto" name="hidcmbperiodto" value='<s:property value="hidcmbperiodto"/>'/></td>
  </tr>
  <tr>
    <td align="right">Client</td>
    <td><select id="cmbclientid" name="cmbclientid" style="width:90%" value='<s:property value="cmbclientid"/>'>
              <option>--Select--</option></select>
              <input type="hidden" id="hidcmbclientid" name="hidcmbclientid" value='<s:property value="hidcmbclientid"/>'/></td>
    <td width="38%"><input type="text" id="txtclientname" name="txtclientname" style="width:80%" value='<s:property value="txtclientname"/>'/></td>
    <td width="10%" align="right">Mail ID's</td>
    <td width="24%"><input type="text" id="txtmailid" name="txtmailid" style="width:90%" value='<s:property value="txtmailid"/>'/></td>
  </tr>
</table>
</fieldset><br/>
<jsp:include page="invoiceMailGrid.jsp"></jsp:include>
<input type="hidden" id="mode" name="mode"/>
<input type="text" name="delete" id="delete" value='<s:property value="delete"/>' hidden="true"/>
</div>
</form>
</div>
</body>
</html>