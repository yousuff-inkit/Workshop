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
	$("#date").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	$("#checkindate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	$("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	$('#clientwindow').jqxWindow({ width: '62%', height: '55%',  maxHeight: '60%' ,maxWidth: '80%' , title: 'Client Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	$('#clientwindow').jqxWindow('close');
	$('#driverwindow').jqxWindow({ width: '62%', height: '55%',  maxHeight: '60%' ,maxWidth: '80%' , title: 'Driver Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	$('#driverwindow').jqxWindow('close');
	/* $('#checkinwindow').jqxWindow({ width: '62%', height: '55%',  maxHeight: '60%' ,maxWidth: '80%' , title: 'Check In Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	$('#checkinwindow').jqxWindow('close'); */
	 
	$('#client').dblclick(function(){
		$('#clientwindow').jqxWindow('open');
		$('#clientwindow').jqxWindow('focus');
	 	clientSearchContent('masterClientSearch.jsp', $('#clientwindow'));
	});
	
	$('#driver').dblclick(function(){
		$('#driverwindow').jqxWindow('open');
		$('#driverwindow').jqxWindow('focus');
	 	driverSearchContent('driverSearchGrid.jsp?id=1', $('#driverwindow'));
	});
	
	/* $('#checkin').dblclick(function(){
		$('#checkinwindow').jqxWindow('open');
		$('#checkinwindow').jqxWindow('focus');
	 	checkinSearchContent('checkinSearchGrid.jsp?id=1', $('#checkinwindow'));
	}); */
	document.getElementById("rdoadd").checked=true;
	setModeChanges("A");
});

function getClient(event){
	var x= event.keyCode;
	if(x==114){
		$('#clientwindow').jqxWindow('open');
		$('#clientwindow').jqxWindow('focus');
	 	clientSearchContent('masterClientSearch.jsp', $('#clientwindow'));
   }
   else{
   }
}
function funExportBtn(){
    JSONToCSVCon(dataExcelExport, 'Driver Agreement', true);
} 
 
function getDriver(event){
	var x= event.keyCode;
	if(x==114){
		$('#driverwindow').jqxWindow('open');
		$('#driverwindow').jqxWindow('focus');
	 	driverSearchContent('driverSearchGrid.jsp?id=1', $('#driverwindow'));
   }
   else{
   }
}

/* function getCheckin(event){
	var x= event.keyCode;
	if(x==114){
		$('#checkinwindow').jqxWindow('open');
		$('#checkinwindow').jqxWindow('focus');
	 	checkinSearchContent('checkinSearchGrid.jsp?id=1', $('#checkinwindow'));
   }
   else{
   }
} */

function clientSearchContent(url) {
	$.get(url).done(function (data) {
    	$('#clientwindow').jqxWindow('setContent', data);
	}); 
}

function driverSearchContent(url) {
	$.get(url).done(function (data) {
    	$('#driverwindow').jqxWindow('setContent', data);
	}); 
}
/* function checkinSearchContent(url) {
	$.get(url).done(function (data) {
    	$('#checkinwindow').jqxWindow('setContent', data);
	}); 
} */
function funreload(event)
{
	var branch=$('#cmbbranch').val();
	$('#driveragmtdiv').load('driverAgmtCreateGrid.jsp?id=1'+'&branch='+branch);
}

function setValues(){

	if($('#msg').val()!=""){
		$.messager.alert('Message','<center>'+$('#msg').val()+'</center>');
	}
	if($('#msg').val()=="Successfully Created" || $('#msg').val()=="Updated Successfully"){
		setModeChanges("");
		var branch=$('#cmbbranch').val();
		$('#driveragmtdiv').load('driverAgmtCreateGrid.jsp?id=1'+'&branch='+branch);
	}
}

function funCreateAgmt(){
	if($('#cmbbranch').val()=="" || $('#cmbbranch').val()=="a"){
		$.messager.alert("warning","Please select specific branch");
		return false;
	}
	if(document.getElementById("rdoadd").checked==false && document.getElementById("rdoedit").checked==false){
		$.messager.alert("warning","Please select an option");
		document.getElementById("rdoadd").focus();
		return false;
	}
	if(document.getElementById("rdoadd").checked==true){
		document.getElementById("mode").value="A";
	}
	else if(document.getElementById("rdoedit").checked==true){
		document.getElementById("mode").value="E";
	}
	document.getElementById("frmDriverAgmtCreate").submit();
}
function fundriveragmtPrint(){
	if($('#docno').val()=="" || $('#docno').val()=="Null"){
		$.messager.alert("warning","Please select Driver");
		return false;
	}
    var url=document.URL;
    if($('#msg').val()==''){
        var reurl=url.split("driverAgmtCreate.jsp");
        var win= window.open(reurl[0]+"printdriveragmt?&branch="+document.getElementById("cmbbranch").value+'&Docno='+document.getElementById("docno").value,"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
        win.focus();
    	
    }
    else{
        var reurl=url.split("saveDriverAgmtCreate");
        var win= window.open(reurl[0]+"printdriveragmt?&branch="+document.getElementById("cmbbranch").value+'&Docno='+document.getElementById("docno").value,"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
        win.focus();

    }
}
function setModeChanges(value){
	if(value=="A"){
		$('#btnagmtcreate').show();
		$('#btnagmtedit').hide();
		$('#date,#checkindate').jqxDateTimeInput('val',new Date());
		$('#fromdate').jqxDateTimeInput('val',new Date());
		$('#client,#hidclient,#driver,#hiddriver,#rate,#normalovertime,#holidayovertime,#cmbcontracttype,#cmbinvoicetype').val("");
		
	}
	else if(value=="E"){
		$('#btnagmtcreate').hide();
		$('#btnagmtedit').show();
	}
	else{
		$('#btnagmtcreate').hide();
		$('#btnagmtedit').hide();
		$('#date,#checkindate').jqxDateTimeInput('val',new Date());
		$('#fromdate').jqxDateTimeInput('val',new Date());
		$('#client,#hidclient,#driver,#hiddriver,#rate,#normalovertime,#holidayovertime,#cmbcontracttype,#cmbinvoicetype').val("");
	}
}
</script>
</head>
<body onload="getBranch();setValues();">
	<form id="frmDriverAgmtCreate" action="saveDriverAgmtCreate" method="post" autocomplete="off">
		<div id="mainBG" class="homeContent" data-type="background"> 
			<div class='hidden-scrollbar'>
				<table width="100%">
                    <tr>
                    <td width="20%">
                        <fieldset style="background: #ECF8E0;">
                        	<table width="100%">
                        			<tr><td colspan="2"><jsp:include page="../../heading.jsp"></jsp:include></td></tr>
				                    <tr><td colspan="2" align="center">
				                    		<input type="radio" id="rdoadd" name="rdomode" value="A" onchange="setModeChanges(value);"><label class="branch" for="rdoadd">Add</label>&nbsp;&nbsp;
				                    		<input type="radio" id="rdoedit" name="rdomode" value="E" onchange="setModeChanges(value);"><label class="branch" for="rdoedit">Edit</label>
				                    		</td></tr>
				                    <tr><td align="right"><label class="branch">Date</label></td><td align="left"><div id="date" name="date"></div></td></tr>
                    				<tr><td align="right"><label class="branch">Client</label></td><td align="left"><input type="text" name="client" id="client" onkeydown="getClient(event);" readonly value='<s:property value="client"/>' style="height:18px;" placeholder="Press F3 to Search"></td></tr>
                    				<tr>
                        				<td align="right"><label class="branch">Driver</label></td>
                        				<td align="left"><input type="text" name="driver" id="driver" onkeydown="getDriver(event);" readonly value='<s:property value="driver"/>' style="height:18px;" placeholder="Press F3 to Search"></td>
                                    </tr>
                                    <tr>
                                        <td align="right"><label class="branch">Contract Type</label></td>
                                        <td align="left"><select name="cmbcontracttype" id="cmbcontracttype" style="width:73%;">
                                        <option value="">--Select--</option>
                                        <option value="Daily">Daily</option>
                                        <option value="Monthly">Monthly</option>
                                        </select></td>
                                    </tr> 
                                    <tr>
                                        <td align="right"><label class="branch">Rate</label></td>
                                        <td align="left"><input type="text" name="rate" id="rate" value='<s:property value="rate"/>'  style="height:18px;" onkeypress="javascript:return isNumber (event,id)" onblur="funRoundAmt(value,id);"></td>
                                    </tr> 
                                    
                                    <tr>
                                        <td align="right"><label class="branch">Normal Overtime/Hr</label></td>
                                        <td><input type="text" name="normalovertime" id="normalovertime" value='<s:property value="normalovertime"/>' style="height:18px;"></td>
                                    </tr> 
                                     <tr>
                                        <td align="right"><label class="branch">Holiday Overtime/Hr</label></td>
                                        <td><input type="text" name="holidayovertime" id="holidayovertime" value='<s:property value="holidayovertime"/>' style="height:18px;"></td>
                                    </tr>
                                    <tr>
                                        <td align="right"><label class="branch"> Over Time Rate</label></td>
                                        <td align="left"><input type="text" name="overrate" id="overrate" value='<s:property value="overrate"/>'  style="height:18px;" onkeypress="javascript:return isNumber (event,id)" onblur="funRoundAmt(value,id);"></td>
                                    </tr>
                                     <tr>
                                        <td align="right"><label class="branch">From date</label></td>
                                        <td><div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div></td>
                                    </tr>
                                     <tr>
                                        <td align="right"><label class="branch">LPO No.</label></td>
                                        <td><input type="text" name="lpono" id="lpono" value='<s:property value="lpono"/>' style="height:18px;"></td>
                                    </tr>
                                     <tr>
                                        <td align="right"><label class="branch">Invoice Type</label></td>
                                        <td align="left"><select name="cmbinvoicetype" id="cmbinvoicetype"  style="width:73%;">
                                        <option value="">--Select--</option>
                                        <option value="1">Month End</option>
                                        <option value="2">Period</option>
                                        </select></td>
                                    </tr>
                                    <tr>
                                        <td align="right"><label class="branch">Check In</label></td>
                                        <td><div id="checkindate" name="checkindate"></div></td>
                                    </tr>
                                     <tr>
                                       <td>&nbsp;</td>
                                       <td>&nbsp;</td>
                                     </tr>
                                     <tr>
                                       <td colspan="2" align="center"><button type="button" id="btnagmtcreate" name="btnagmtcreate" class="myButton" onclick="funCreateAgmt();">Create Agreement</button>
                                       <button type="button" id="btnagmtedit" name="btnagmtedit" class="myButton" onclick="funCreateAgmt();">Update Agreement</button>
                                       <button class="myButton" type="button" id="btndriveragmtPrint" name="btndriveragmtPrint" onclick="fundriveragmtPrint();">Print</button></td></tr>
                                       </td>
                                     </tr> 
									<tr>
										<td colspan="2">&nbsp;</td>
									</tr>
									<tr>
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
										<img id="imgloading" alt="" src="../../../../icons/29load.gif"/></div> <div id="driveragmtdiv"><jsp:include page="driverAgmtCreateGrid.jsp"></jsp:include></div> </td>
			 
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
			</div>
			<div id="clientwindow">
				<div></div>
			</div>
			<div id="driverwindow">
				<div></div>
			</div>
			<!-- <div id="checkinwindow">
				<div></div>
			</div> -->
		</div>
	</form>
</body>
</html>