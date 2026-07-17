<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>

<script type="text/javascript">
      $(document).ready(function () {          
          $("#jqxLeaseAgreement").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
      });

	 function change1()
	 {
		document.getElementById("m3").value=parseInt(document.getElementById("m2").value)+1;

	 }
	 function change2()
	 {
		document.getElementById("m5").value=parseInt(document.getElementById("m4").value)+1;

	 }
	 function change3()
	 {
		document.getElementById("m7").value=parseInt(document.getElementById("m6").value)+1;

	 }
	 function change4()
	 {
		document.getElementById("m9").value=parseInt(document.getElementById("m8").value)+1;

	 }
     //document.getElementById("m9").value=document.getElementById("m8").value+1;

     function funReset(){
				$('#frmLeaseAgreement')[0].reset(); 
			}
			function funReadOnly(){
				$('#frmLeaseAgreement input').attr('readonly', true );
				$('#frmLeaseAgreement textarea').attr('readonly', true );
				$('#frmLeaseAgreement select').attr('disabled', true);
			    $('#jqxLeaseAgreement').jqxDateTimeInput({ disabled: true});
			    $("#jqxDrivers").jqxGrid({ disabled: true});
			}
			function funRemoveReadOnly(){
				$('#frmLeaseAgreement input').attr('readonly', false );
				$('#frmLeaseAgreement textarea').attr('readonly', false );
				$('#frmLeaseAgreement select').attr('disabled', false);
				$('#jqxLeaseAgreement').jqxDateTimeInput({ disabled: false});
			    $("#jqxDrivers").jqxGrid({ disabled: false});
				$('#txtleasedocno').attr('readonly', true);
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
				   	$('#jqxLeaseAgreement').jqxDateTimeInput('focus'); 	    		
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
<form id="frmLeaseAgreement" action="saveLeaseAgreement" >
<jsp:include page="../../../../header.jsp"></jsp:include><br/>

<div class='hidden-scrollbar'>
<fieldset>
<table width="100%">
  <tr>
    <td colspan="3" ><fieldset>
      <legend>Client Info</legend>
      <table width="100%">
        <tr>
          <td align="right">Date</td>
          <td colspan="3"><div id='jqxLeaseAgreement' name='jqxLeaseAgreement' value='<s:property value="jqxLeaseAgreement"/>'></div>
                   <input type="hidden" id="hidjqxLeaseAgreement" name="hidjqxLeaseAgreement" value='<s:property value="hidjqxLeaseAgreement"/>'/></td>
          <td align="right">RA No</td>
          <td><input type="text" id="txtrano" name="txtrano" style="width:60%;" value='<s:property value="txtrano"/>'/></td>
          <td align="right">Doc No</td>
          <td><input type="text" id="txtleasedocno" name="txtleasedocno" style="width:60%;" tabindex="-1" value='<s:property value="txtleasedocno"/>'/></td>
        </tr>
        <tr>
          <td align="right">Client</td>
          <td><select id="cmbclientno" name="cmbclientno" value='<s:property value="cmbclientno"/>'>
              <option value="-1">--Select--</option></select>
              <input type="hidden" id="hidcmbclientno" name="hidcmbclientno" value='<s:property value="hidcmbclientno"/>'/>
              <input type="text" id="txtclientname" name="txtclientname" style="width:58%;" value='<s:property value="txtclientname"/>'/></td>
          <td><div align="right">Sales Agent</div></td>
          <td colspan="5"><select id="cmbsaleagentno" name="cmbsaleagentno" value='<s:property value="cmbsaleagentno"/>'>
              <option value="-1">--Select--</option></select>
              <input type="hidden" id="hidcmbsaleagentno" name="hidcmbsaleagentno" value='<s:property value="hidcmbsaleagentno"/>'/>
              <input type="text" id="txtsaleagent" name="txtsaleagent" style="width:18%;" value='<s:property value="txtsaleagent"/>'/></td>
        </tr>
        <tr>
          <td align="right">Address</td>
          <td><textarea id="txtaddress" name="txtaddress" style="resize:none;width:81%;" value='<s:property value="txtaddress"/>'></textarea></td>
          <td align="right">Address 2</td>
          <td colspan="5"><textarea id="txtaddress2" name="txtaddress2" style="resize:none;width:26%;" value='<s:property value="txtaddress2"/>'></textarea></td>
        </tr>
        <tr>
          <td align="right">Telephone 1</td>
          <td><input type="number" id="txttelephone" name="txttelephone" style="width:40%;" value='<s:property value="txttelephone"/>'/></td>
          <td align="right">Telephone 2</td>
          <td><input type="number" id="txttelephone2" name="txttelephone2" style="width:40%;" value='<s:property value="txttelephone2"/>'/></td>
          <td align="right">Fax</td>
          <td><input type="number" id="txtfax" name="txtfax" style="width:60%;" value='<s:property value="txtfax"/>'/></td>
          <td align="right">Email 1</td>
          <td><input type="email" id="txtemail1" name="txtemail1" style="width:60%;" value='<s:property value="txtemail1"/>'/></td>
        </tr>
        <tr>
          <td align="right">Contact</td>
          <td><select id="cmbcontact" name="cmbcontact" value='<s:property value="cmbcontact"/>'>
              <option value="-1">--Select--</option></select>
               <input type="hidden" id="hidcmbcontact" name="hidcmbcontact" value='<s:property value="hidcmbcontact"/>'/></td>
          <td align="right">Ext No</td>
          <td><input type="text" id="txtextno" name="txtextno" style="width:40%;" value='<s:property value="txtextno"/>'/></td>
          <td align="right">Mobile</td>
          <td><input type="number" id="txtmobile" name="txtmobile" style="width:60%;" value='<s:property value="txtmobile"/>'/></td>
          <td align="right">Email 2</td>
          <td><input type="email" id="txtemail2" name="txtemail2" style="width:60%;" value='<s:property value="txtemail2"/>'/></td>
        </tr>
      </table>
    </fieldset></td>
  </tr>
  <tr>
    <td colspan="3"><fieldset>
      <legend>Contract Info</legend>
      <table width="100%">
        <tr>
          <td width="9%" align="right">Period</td>
          <td width="22%"><select id="cmbperiod" name="cmbperiod" value='<s:property value="cmbperiod"/>'>
              <option value="-1">----</option></select>
              <input type="hidden" id="hidcmbperiod" name="hidcmbperiod" value='<s:property value="hidcmbperiod"/>'/>
              <select id="cmbperiodtype" name="cmbperiodtype" value='<s:property value="cmbperiodtype"/>'>
              <option value="-1">--Select--</option></select>
              <input type="hidden" id="hidcmbperiodtype" name="hidcmbperiodtype" value='<s:property value="hidcmbperiodtype"/>'/></td>
          <td width="6%" align="right">Brand</td>
          <td width="13%"><select id="cmbbrand" name="cmbbrand" value='<s:property value="cmbbrand"/>'>
              <option value="-1">--Select--</option></select>
              <input type="hidden" id="hidcmbbrand" name="hidcmbbrand" value='<s:property value="hidcmbbrand"/>'/></td>
          <td width="6%" align="right">Group</td>
          <td width="44%"><select id="cmbgroup" name="cmbgroup" value='<s:property value="cmbgroup"/>'>
              <option value="-1">--Select--</option></select>
              <input type="hidden" id="hidcmbgroup" name="hidcmbgroup" value='<s:property value="hidcmbgroup"/>'/></td>
        </tr>
      </table>
    </fieldset></td>
  </tr>
  <tr>
    <td style="width:33.33%;">
    <fieldset>
      <legend>Rate Info</legend>
      <table width="100%">
        <tr>
          <td width="41%" align="right">Rent</td>
          <td width="59%"><input type="text" id="txtrent" name="txtrent" style="width:57%;" value='<s:property value="txtrent"/>'/></td>
        </tr>
        <tr>
          <td align="right">CDW</td>
          <td><input type="text" id="txtcdw" name="txtcdw" style="width:57%;" value='<s:property value="txtcdw"/>'/></td>
        </tr>
        <tr>
          <td align="right">PAI</td>
          <td><input type="text" id="txtpai" name="txtpai" style="width:57%;" value='<s:property value="txtpai"/>'/></td>
        </tr>
        <tr>
          <td align="right">Salik Service Charge</td>
          <td><input type="text" id="txtsaliksrvchg" name="txtsaliksrvchg" style="width:57%;" value='<s:property value="txtsaliksrvchg"/>'/></td>
        </tr>
        <tr>
          <td align="right">Traffic fine charge</td>
          <td><input type="text" id="txttrafficfine" name="txttrafficfine" style="width:57%;" value='<s:property value="txttrafficfine"/>'/></td>
        </tr>
        <tr>
          <td align="right">Km Resticted</td>
          <td><input type="text" id="txtkmrestrict" name="txtkmrestrict" style="width:57%;" value='<s:property value="txtkmrestrict"/>'/></td>
        </tr>
        <tr>
          <td align="right">Extra Km Charge</td>
          <td><input type="text" id="txtexkmchg" name="txtexkmchg" style="width:57%;" value='<s:property value="txtexkmchg"/>'/></td>
        </tr>
        <tr>
          <td align="right">Delivery Charge</td>
          <td><input type="text" id="txtdeliverychg" name="txtdeliverychg" style="width:57%;" value='<s:property value="txtdeliverychg"/>'/></td>
        </tr>
      </table>
    </fieldset></td>
    <td style="width:33.33%;">
    <fieldset>
      <legend>Termination Clauses Info</legend>
      <br/><br/>
      <table width="100%">
        <tr>
          <td width="50%" align="right"><input type="text" name="m1" id="m1" value="0" readonly="readonly" style="width:20%;text-align: center;">&nbsp;to&nbsp;<input type="text" name="m2"  id="m2"value="12" style="width:20%;text-align: center;" onblur="change1();"></td>
          <td width="50%" align="left">
            <input type="text" id="within12" name="within12" style="width:57%;" value='<s:property value="within12"/>'/>
          </td>
        </tr>
        <tr>
          <td align="right"><input type="text" name="m3" id="m3" value="12" readonly="readonly" style="width:20%;text-align: center;">&nbsp;to&nbsp;<input type="text" name="m4" id="m4" value="24" style="width:20%;text-align: center;" onblur="change2();"></td>
          <td align="left">
            <input type="text" id="12to24" name="12to24" style="width:57%;" value='<s:property value="12to24"/>'/>
          </td>
        </tr>
        <tr>
          <td align="right"><input type="text" name="m5" id="m5" value="24" readonly="readonly" style="width:20%;text-align: center;">&nbsp;to&nbsp;<input type="text" name="m6" id="m6" value="36" style="width:20%;text-align: center;"onblur="change3();"></td>
          <td align="left">
            <input type="text" id="24to36" name="24to36" style="width:57%;" value='<s:property value="24to36"/>'/>
          </td>
        </tr>
        <tr>
          <td align="right"><input type="text" name="m7" id="m7" value="36" readonly="readonly" style="width:20%;text-align: center;">&nbsp;to&nbsp;<input type="text"  value="48" name="m8" id="m8" style="width:20%;text-align: center;" onblur="change4();"></td>
          <td align="left">
            <input type="text" id="36to48" name="36to48" style="width:57%;" value='<s:property value="36to48"/>'/>
          </td>
        </tr>
        <tr>
          <td align="right"><input type="text" name="m9" id="m9" value="48" style="width:20%;text-align: center;">&nbsp;to&nbsp;<input type="text" name="m10"  id="m10" value="60" style="width:20%;text-align: center;"></div></td>
          <td align="left">
            <input type="text" id="48to60" name="48to60" style="width:57%;" value='<s:property value="48to60"/>'/>
          </td>
        </tr>
      </table>
      <br/><br/><br/><br/>
    </fieldset></td>
    <td style="width:33.33%;">
    <fieldset>
    <legend>Payment Info</legend>
    <table width="100%">
      <tr>
        <td align="right">Invoicing</td>
        <td><select id="cmbinvoicing2" name="cmbinvoicing2" style="width:57%;" value='<s:property value="cmbinvoicing2"/>'>
          <option value="-1">--Select--</option></select>
          <input type="hidden" id="hidcmbinvoicing2" name="hidcmbinvoicing2" value='<s:property value="hidcmbinvoicing2"/>'/></td>
      </tr>
      <tr>
        <td align="right">Invoice Mode</td>
        <td><select id="cmbmode2" name="cmbmode2" style="width:57%;" value='<s:property value="cmbmode2"/>'>
          <option value="-1">--Select--</option></select>
          <input type="hidden" id="hidcmbmode2" name="hidcmbmode2" value='<s:property value="hidcmbmode2"/>'/></td>
      </tr>
      <tr>
        <td align="right">Invoice Type</td>
        <td><select id="cmbtype2" name="cmbtype2" style="width:57%;" value='<s:property value="cmbtype2"/>'>
          <option value="-1">--Select--</option></select>
          <input type="hidden" id="hidcmbtype2" name="hidcmbtype2" value='<s:property value="hidcmbtype2"/>'/></td>
      </tr>
      <tr>
        <td align="right">Advance</td>
        <td><input type="text" id="txtadvance2" name="txtadvance2" style="width:57%;" value='<s:property value="txtadvance2"/>'/></td>
      </tr>
      <tr>
        <td align="right">A.Code</td>
        <td><input type="text" id="txtacode2" name="txtacode2" style="width:57%;" value='<s:property value="txtacode2"/>'/></td>
      </tr>
      <tr>
        <td align="right">Card No</td>
        <td><input type="text" id="txtcardno2" name="txtcardno2" style="width:57%;" value='<s:property value="txtcardno2"/>'/></td>
      </tr>
      
      <tr>
        <td align="right">Not Invoiced</td>
        <td><input type="text" id="txtfinesnotinvoiced2" name="txtfinesnotinvoiced2" style="width:57%;" value='<s:property value="txtfinesnotinvoiced2"/>'/></td>
      </tr>
      <tr>
        <td align="right">Net Balance</td>
        <td><input type="text" id="txtnetbalance2" name="txtnetbalance2" style="width:57%;" value='<s:property value="txtnetbalance2"/>'/></td>
      </tr>
    </table><br/>
    </fieldset></td>
  </tr>
  <tr>
    <td colspan="3">
    <fieldset>
      <legend>Payment Info</legend>
      <table width="100%">
        <tr>
          <td align="right">Invoicing</td>
          <td><select id="cmbinvoicing" name="cmbinvoicing" value='<s:property value="cmbinvoicing"/>'>
              <option value="-1">--Select--</option></select>
               <input type="hidden" id="hidcmbinvoicing" name="hidcmbinvoicing" value='<s:property value="hidcmbinvoicing"/>'/></td>
          <td align="right">Invoice Mode</td>
          <td><select id="cmbmode" name="cmbmode" value='<s:property value="cmbmode"/>'>
              <option value="-1">--Select--</option></select>
               <input type="hidden" id="hidcmbmode" name="hidcmbmode" value='<s:property value="hidcmbmode"/>'/></td>
          <td align="right">Invoice Type</td>
          <td><select id="cmbtype" name="cmbtype" value='<s:property value="cmbtype"/>'>
              <option value="-1">--Select--</option></select>
               <input type="hidden" id="hidcmbtype" name="hidcmbtype" value='<s:property value="hidcmbtype"/>'/></td>
          <td align="right">Advance</td>
          <td><input type="text" id="txtadvance" name="txtadvance" style="width:65%;" value='<s:property value="txtadvance"/>'/></td>
          <td align="right">A.Code</td>
          <td colspan="2"><input type="text" id="txtacode1" name="txtacode1" style="width:65%;" value='<s:property value="txtacode1"/>'/></td>
          <td align="right">Card No</td>
          <td><input type="text" id="txtcardno1" name="txtcardno1" style="width:65%;" value='<s:property value="txtcardno1"/>'/></td>
        </tr>
        <tr>
          <td colspan="9" align="right">Fines Not Invoiced</td>
          <td align="left"><input type="text" id="txtfinesnotinvoiced" name="txtfinesnotinvoiced" style="width:65%;" value='<s:property value="txtfinesnotinvoiced"/>'/></td>
          <td colspan="2" align="right">Net Balance</td>
          <td><input type="text" id="txtnetbalance" name="txtnetbalance" style="width:65%;" value='<s:property value="txtnetbalance"/>'/></td>
        </tr>
      </table>
    </fieldset></td>
  </tr>
  <tr>
    <td colspan="3"><fieldset>
      <legend>Delivery Info</legend>
      <table width="100%">
        <tr>
          <td width="12%" align="right">Temperory Vehicle</td>
          <td width="39%"><select id="cmbtempvehicle2" name="cmbtempvehicle2" value='<s:property value="cmbtempvehicle2"/>'>
              <option value="-1">--Select--</option></select>
              <input type="hidden" id="hidcmbtempvehicle2" name="hidcmbtempvehicle2" value='<s:property value="hidcmbtempvehicle2"/>'/></td>
          <td width="20%" align="right">Permanent Vehicle</td>
           <td><select id="cmbpermvehicle2" name="cmbpermvehicle2" value='<s:property value="cmbpermvehicle2"/>'>
              <option value="-1">--Select--</option></select>
              <input type="hidden" id="hidcmbpermvehicle2" name="hidcmbpermvehicle2" value='<s:property value="hidcmbpermvehicle2"/>'/></td>
       </tr>
       <tr>
       <td colspan="4"><jsp:include page="drivers.jsp"></jsp:include></td>
       </tr>
      </table>
      <input type="hidden" id="mode" name="mode" />
      <input type="text" name="delete" id="delete" value='<s:property value="delete"/>' hidden="true"/>
    </fieldset></td>
  </tr>
</table>
</fieldset>
</div>
</form>
</div>
</body>
</html>
