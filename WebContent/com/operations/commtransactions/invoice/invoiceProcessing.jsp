<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>

<script type="text/javascript">
     $(document).ready(function () {  
	    /* Date */
    	$("#jqxInvoiceDate").jqxDateTimeInput({ width: '40%', height: '15px',formatString:"dd.MM.yyyy"});        
     });
 
    function funReset(){
		$('#frmInvoiceProcessing')[0].reset(); 
	}
	function funReadOnly(){
		$('#frmInvoiceProcessing input').attr('readonly', true );
		$('#frmInvoiceProcessing select').attr('disabled', true);
		$('#chckclient').attr('disabled', true );
		$('#chckrental').attr('disabled', true );
		$('#chcksalik').attr('disabled', true );
		$('#chcktraffic').attr('disabled', true );
		$('#btngenerate').attr('disabled', true );
		$('#btnprint').attr('disabled', true );
		$('#btnclear').attr('disabled', true );
		$('#btnemployee').attr('disabled', true );
	    $('#jqxInvoiceDate').jqxDateTimeInput({ disabled: true});
	}
	
	function funRemoveReadOnly(){
		$('#frmInvoiceProcessing input').attr('readonly', false );
		$('#frmInvoiceProcessing select').attr('disabled', false);
		$('#chckclient').attr('disabled', false );
		$('#chckrental').attr('disabled', false );
		$('#chcksalik').attr('disabled', false );
		$('#chcktraffic').attr('disabled', false );
		$('#btngenerate').attr('disabled', false );
		$('#btnprint').attr('disabled', false );
		$('#btnclear').attr('disabled', false );
		$('#btnemployee').attr('disabled', false );
		$('#jqxInvoiceDate').jqxDateTimeInput({ disabled: false});
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
<form id="frmInvoiceProcessing" action="saveInvoiceProcessing" >
<jsp:include page="../../../../header.jsp"></jsp:include><br/>

<div class='hidden-scrollbar'>
<fieldset>
<table width="100%">
<tr><td width="50%">
<table width="100%">
  <tr>
    <td width="8%" align="right">Date</td>
    <td colspan="2"><div id="jqxInvoiceDate" name="jqxInvoiceDate" value='<s:property value="jqxInvoiceDate"/>'></div>
        <input type="hidden" id="hidjqxInvoiceDate" name="hidjqxInvoiceDate" value='<s:property value="hidjqxInvoiceDate"/>'/></td>
    <td width="14%" align="right">Branch</td>
    <td width="9%"><select id="cmbbranch" name="cmbbranch" value='<s:property value="cmbbranch"/>'>
                   <option>--Select--</option></select>
                   <input type="hidden" id="hidcmbbranch" name="hidcmbbranch" value='<s:property value="hidcmbbranch"/>'/></td>
    <td width="35%"><input type="text" id="txtbranchname" name="txtbranchname" style="width:90%;" value='<s:property value="txtbranchname"/>'/></td>
  </tr>
  <tr>
     <td align="right">UpTo</td>
    <td colspan="2"><select id="cmbinvoiceprocessingupto" name="cmbinvoiceprocessingupto" value='<s:property value="cmbinvoiceprocessingupto"/>'>
     				<option>--Select--</option></select>
                    <input type="hidden" id="hidcmbinvoiceprocessingupto" name="hidcmbinvoiceprocessingupto" value='<s:property value="hidcmbinvoiceprocessingupto"/>'/></td>
    <td align="right">Inv. Mode</td>
    <td colspan="2"><select id="cmbinvoiceprocessingmode" name="cmbinvoiceprocessingmode" value='<s:property value="cmbinvoiceprocessingmode"/>'>
         <option>--Select--</option></select>
         <input type="hidden" id="hidcmbinvoiceprocessingmode" name="hidcmbinvoiceprocessingmode" value='<s:property value="hidcmbinvoiceprocessingmode"/>'/></td>
  </tr>
  <tr>
     <td align="right"><input type="checkbox" id="chckclient" name="chckclient" value="client">Client</td>
    <td width="9%"><select id="cmbinvoiceprocessingclient" name="cmbinvoiceprocessingclient" value='<s:property value="cmbinvoiceprocessingclient"/>'>
         <option>--Select--</option></select>
         <input type="hidden" id="hidcmbinvoiceprocessingclient" name="hidcmbinvoiceprocessingclient" value='<s:property value="hidcmbinvoiceprocessingclient"/>'/></td>
    <td width="25%"><input type="text" id="txtinvoiceprocessingclientname" name="txtinvoiceprocessingclientname" style="width:100%;" value='<s:property value="txtinvoiceprocessingclientname"/>'/></td>
    <td align="right">Agmt No.</td>
    <td colspan="2"><select id="cmbinvoiceprocessingagmtno" name="cmbinvoiceprocessingagmtno" value='<s:property value="cmbinvoiceprocessingagmtno"/>'>
         <option>--Select--</option></select>
         <input type="hidden" id="hidcmbinvoiceprocessingagmtno" name="hidcmbinvoiceprocessingagmtno" value='<s:property value="hidcmbinvoiceprocessingagmtno"/>'/></td>
  </tr>
</table>
</td>
<td width="10%">
<fieldset  width="50%">
<table>
  <tr>
    <td><input type="checkbox" id="chckrental" name="chckrental" value="rental">Rental</td>
  </tr>
  <tr>
    <td><input type="checkbox" id="chcksalik" name="chcksalik" value="salik">Salik</td>
  </tr>
  <tr>
    <td><input type="checkbox" id="chcktraffic" name="chcktraffic" value="traffic">Traffic</td>
  </tr>
</table>
</fieldset>
</td>
<td width="40%">
<table width="10%" align="center">
  <tr>
    <td><button class="myButton" type="button" id="btngenerate" style="width:92%" onclick="">Generate</button></td>
  </tr>
  <tr>
    <td><button class="myButton" type="button" id="btnprint" style="width:92%" onclick="">Print</button></td>
  </tr>
  <tr>
    <td><button class="myButton" type="button" id="btnclear" style="width:92%" onclick="">Clear</button></td>
  </tr>
  <tr>
    <td><button class="myButton" type="button" id="btnemployee" style="width:92%" onclick="">Employee</button></td>
  </tr>
</table>
</td></tr>
</table>
</fieldset>
<input type="hidden" id="mode" name="mode"/>
<input type="text" name="delete" id="delete" value='<s:property value="delete"/>' hidden="true"/>
</div>
</form>
</div>
</body>
</html>