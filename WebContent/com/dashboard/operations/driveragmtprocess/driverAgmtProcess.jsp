<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<script type="text/javascript">
$(document).ready(function () {
	$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
	$("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200;right:600;'><img src='../../../../icons/31load.gif'/></div>");    
	$("#uptodate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	$("#closedate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	document.getElementById("rdoinvoice").checked=true;
	setModeChanges("Invoice");
	if(document.getElementById("rdoinvoice").checked==true){
		$('#closedate').jqxDateTimeInput({disabled:true});
	}
	else{
		$('#closedate').jqxDateTimeInput({disabled:false});
	}
	
	$('#closedate').on('change', function (event) 
			{  
			    var jsDate = event.args.date; 
			    var type = event.args.type; // keyboard, mouse or null depending on how the date was selected.
			 	if(document.getElementById("rdoclose").checked==true){
					var dateval=funDateInPeriod($('#closedate').jqxDateTimeInput('getDate'));
					
				 	$('#totalrate').val('');
			 		if(dateval!=1){
			 			return false;
			 		}
			 	}
			}); 
});

function funreload(event)
{
	$('#agmtno,#docno,#hidclient,#normalovertime,#holidayovertime,#totalrate,#totalnormalovertime,#totalholidayovertime').val('');
	$('#uptodate').jqxDateTimeInput('val',new Date());
	$('#closedate').jqxDateTimeInput('val',new Date());
	var branch=$('#cmbbranch').val();
	if(branch=="a" || branch==""){
		$.messager.alert('warning','Please Select specific branch');
		return false;
	}
	if(document.getElementById("rdoinvoice").checked==false && document.getElementById("rdoclose").checked==false){
		$.messager.alert('warning','Please Select Any Valid Option');
		return false;
	}
	var type="";
	if(document.getElementById("rdoinvoice").checked==true){
		type="invoice";
	}
	else if(document.getElementById("rdoclose").checked==true){
		type="close";
	}
	$('#driveragmtdiv').load('driverAgmtProcessGrid.jsp?id=1'+'&branch='+branch+'&date='+$('#uptodate').jqxDateTimeInput('val')+'&type='+type);
}

function setValues(){

	if($('#msg').val()!=""){
		$.messager.alert('Message','<center>'+$('#msg').val()+'</center>');
		setModeChanges("");
	}
	
}
function isNumber(evt,id) {
	//Function to restrict characters and enter number only
		  var iKeyCode = (evt.which) ? evt.which : evt.keyCode
	        if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57))
	         {
	        	 $.messager.alert('Warning','Enter Numbers Only');
	           $("#"+id+"").focus();
	            return false;
	            
	         }
	        
	        return true;
	    }

function setModeChanges(value){
	if(value=="Invoice"){
		$('#mode').val("Invoice");
		$('#btninvoice').show();
		$('#btnagmtclose').hide();
		$('#closedate').jqxDateTimeInput({disabled:true});
		
	}
	else if(value=="Close"){
		$('#mode').val("Close");
		$('#btninvoice').hide();
		$('#btnagmtclose').show();
		$('#closedate').jqxDateTimeInput({disabled:false});
	}
	else{
		$('#btnagmtclose').hide();
		$('#agmtno,#docno,#hidclient,#normalovertime,#holidayovertime,#totalrate,#totalnormalovertime,#totalholidayovertime').val('');
		$('#uptodate').jqxDateTimeInput('val',new Date());
		$('#closedate').jqxDateTimeInput('val',new Date());
		$('#closedate').jqxDateTimeInput({disabled:true});
	}
}

function funCalculate(){
	if(document.getElementById("rdoinvoice").checked==false && document.getElementById("rdoclose").checked==false){
		$.messager.alert('warning','Please Select Any Valid Option');
		return false;
	}
	
	if($('#normalovertime').val()==""){
		$.messager.alert('warning','Normal Overtime Hours is mandatory');
		document.getElementById("normalovertime").focus();
		return false;
	}
	var type="";
	if(document.getElementById("rdoinvoice").checked==true){
		type="invoice";
	}
	else if(document.getElementById("rdoclose").checked==true){
		type="close";
		var dateval=funDateInPeriod($('#closedate').jqxDateTimeInput('getDate'));
		if(dateval!=1){
			return false;
		}
	}
	calculateAJAX(type);
}
function calculateAJAX(type){
	var agmtno=$('#agmtno').val();
	var normalovertime=$('#normalovertime').val();
	var holidayovertime=$('#holidayovertime').val();
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText.trim();
			items = items.split('::');
			$('#totalnormalovertime').val(items[0]);
			$('#totalholidayovertime').val(items[1]);
			$('#totalrate').val(items[2]);
			$('#invpendingstatus').val(items[3]);
			if(document.getElementById("rdoclose").checked==true){
				if($('#invpendingstatus').val()=="1"){
					$.messager.alert('warning','Invoices Pending');
				}				
			}

		} else {
		}
	}
	x.open("GET", "calculateAJAX.jsp?agmtno="+agmtno+"&normalovertime="+normalovertime+"&holidayovertime="+holidayovertime+"&closedate="+$('#closedate').jqxDateTimeInput('val')+"&type="+type, true);
	x.send();
}


function funCloseAgmt(){
	var errorstatus=0;
	$('#closedate').jqxDateTimeInput({disabled:false});
	var dateval=funDateInPeriod($('#closedate').jqxDateTimeInput('getDate'));
	if(dateval==1){
		if(document.getElementById("agmtno").value==""){
			$.messager.alert('warning','Please select an Agreement');
			errorstatus=1;
			return false;
		}
		else{
			errorstatus=0;
		}
		if(errorstatus==0){
			document.getElementById("mode").value="close";
			document.getElementById("frmDriverAgmtProcess").submit();		
		}		
	}


}
function funInvoice(){
	var errorstatus=0;
	if(document.getElementById("totalrate").value==""){
		$.messager.alert('warning','Please Calculate Amount');
		errorstatus=1;
		return false;
	}
	else{
		errorstatus=0;
	}
	if(errorstatus==0){
		document.getElementById("mode").value="Invoice";
		document.getElementById("frmDriverAgmtProcess").submit();		
	}

}
</script>
</head>
<body onload="getBranch();setValues();">
	<form id="frmDriverAgmtProcess" action="saveDriverAgmtProcess" method="post" autocomplete="off">
		<div id="mainBG" class="homeContent" data-type="background"> 
			<div class='hidden-scrollbar'>
				<table width="100%">
                    <tr>
                    <td width="20%">
                        <fieldset style="background: #ECF8E0;">
                        	<table width="100%">
                        			<tr><td colspan="2"><jsp:include page="../../heading.jsp"></jsp:include></td></tr>
                        			<tr>
                        			  <td colspan="2" align="center"><input type="radio" name="rdotype" id="rdoinvoice" value="Invoice" onchange="setModeChanges(value);"><label for="rdoinvoice" class="branch">Invoice</label>&nbsp;&nbsp;<input type="radio" name="rdotype" id="rdoclose" value="Close" onchange="setModeChanges(value);"><label for="rdoclose" class="branch">Close Agreement</label>
                                      </td>
                      			  </tr>
				                    <tr><td align="right"><label class="branch">Upto Date</label></td><td align="left"><div id="uptodate" name="uptodate"></div></td></tr>
                    				<tr>
                    				  <td align="right"><label class="branch">Agreement</label></td>
                    				  <td align="left"><input type="text" name="agmtno" id="agmtno" placeholder="Press F3 to Search" readonly onKeyDown="getAgmtno();" style="height:18px;" value='<s:property value="agmtno"/>'></td>
                  				  </tr>
                    				 <tr>
                                        <td align="right"><label class="branch">Normal OT Hrs</label></td>
                                        <td><input type="text" name="normalovertime" id="normalovertime" value='<s:property value="normalovertime"/>' onkeypress="javascript:return isNumber (event,id)" style="height:18px;"></td>
                                    </tr> 
                                     <tr>
                                        <td align="right"><label class="branch">Holiday OT Hrs</label></td>
                                        <td><input type="text" name="holidayovertime" id="holidayovertime" value='<s:property value="holidayovertime"/>' onkeypress="javascript:return isNumber (event,id)" style="height:18px;"></td>
                                    </tr>
                                     <tr>
                                        <td align="right"><label class="branch">Close Date</label></td>
                                        <td><div id="closedate" name="closedate" value='<s:property value="closedate"/>'></div></td>
                                    </tr>
                                     <tr>
                                       <td align="right"><label class="branch">Total Rate</label></td>
                                       <td align="left"><input type="text" name="totalrate" id="totalrate" readonly style="height:18px;"></td>
                                     </tr>
                                     <tr>
										<td align="right"><label class="branch">Total Normal OT</label></td>
                                        <td align="left"><input type="text" name="totalnormalovertime" id="totalnormalovertime" style="height:18px;" readonly>
									</tr>
                                     <tr>
										<td align="right"><label class="branch">Total Holiday OT</label></td>
                                        <td align="left"><input type="text" name="totalholidayovertime" id="totalholidayovertime" style="height:18px;" readonly></td>
									</tr>
                                     <tr>
                                       <td colspan="2" align="center">
                                       <button type="button" id="btnagmtclose" name="btnagmtclose" class="myButton" onclick="funCloseAgmt();">Close Agreement</button>
                                       <button type="button" id="btninvoice" name="btninvoice" class="myButton" onclick="funInvoice();">Generate Invoice</button>
                                       </td>
                                     </tr> 
									
									<tr>
										<td colspan="2">&nbsp;</td>
									</tr><tr>
										<td colspan="2">&nbsp;</td>
									</tr><tr>
										<td colspan="2">&nbsp;</td>
									</tr>	<tr>
										<td colspan="2">&nbsp;</td>
									</tr><tr>
										<td colspan="2">&nbsp;</td>
									</tr>
								</table>
							</fieldset>
					  </td>
						<td width="80%">
							<table width="100%">
								<tr>
			 						<td><div id="imgdiv" style="position:absolute; z-index: 1;top:200;right:600;display:none;">
										<img id="imgloading" alt="" src="../../../../icons/29load.gif"/></div> <div id="driveragmtdiv"><jsp:include page="driverAgmtProcessGrid.jsp"></jsp:include></div> </td>
			 
								</tr>
							</table>
                        </td>
					</tr>
				</table>
                <input type="hidden" name="hidclient" id="hidclient" value='<s:property value="hidclient"/>'>
                <input type="hidden" name="hiddriver" id="hiddriver" value='<s:property value="hiddriver"/>'>
                <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
				<input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
                <input type="hidden" name="docno" id="docno" value='<s:property value="docno"/>'>
                <input type="hidden" name="invpendingstatus" id="invpendingstatus" value='<s:property value="invpendingstatus"/>'>
			</div>
			<div id="clientwindow">
				<div></div>
			</div>
			<div id="driverwindow">
				<div></div>
			</div>
		</div>
	</form>
</body>
</html>