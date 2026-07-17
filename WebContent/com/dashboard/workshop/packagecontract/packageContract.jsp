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
<link href="https://fonts.googleapis.com/css?family=Oswald" rel="stylesheet">
<link href="../../../../vendors/select2/css/select2.min.css" rel="stylesheet">

<script type="text/javascript" src="../../../../vendors/select2/js/select2.min.js"></script>
<style type="text/css">
	#select2-cmbclient-container,#select2-cmbclient-container > span{
		font-size:11px;
	}
	#select2-cmbpackage-container,#select2-cmbpackage-container > span{
		font-size:11px;
	}
	fieldset{
		border-radius:5px;
	}
	
</style>
<script type="text/javascript">

$(document).ready(function () {
	 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
	 $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200;right:600;'><img src='../../../../icons/31load.gif'/></div>");    
	 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
	 var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
	 $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate);
	 getInitData(1);
});

function funreload(event)
{
	$('#packagegriddiv').load('packageGrid.jsp');
}
function funExportBtn(){
	$("#packageGrid").excelexportjs({
		containerid: "packageGrid",
		datatype: 'json',
		dataset: null,
		gridId: "packageGrid",
		columns: getColumns("packageGrid") ,
		worksheetName:'Package Contract List'
	});
}
function setValues(){
	  
}
function getInitData(mode){
	$.get('getInitData.jsp',{'mode':mode},function(data){
		data=JSON.parse(data);
		var htmldata='<option value="">--Select--</option>';
		$.each(data.clientdata,function(index,value){
			htmldata+='<option value="'+value.cldocno+'">'+value.refname+'</option>';
		});
		$('#cmbclient').html($.parseHTML(htmldata));
		$('#cmbclient').select2({
        	placeholder:"Select Client",
        	allowClear:true
        });
        htmldata='<option value="">--Select--</option>';
        $.each(data.packagedata,function(index,value){
			htmldata+='<option value="'+value.docno+'">'+value.name+'</option>';
		});
		$('#cmbpackage').html($.parseHTML(htmldata));
		$('#cmbpackage').select2({
        	placeholder:"Select Package",
        	allowClear:true
        });
        
	});
}

function funSaveData(){
	var cldocno=$('#cmbclient').val();
	var package=$('#cmbpackage').val();
	if(cldocno==''){
		$.messager.alert('Warning','Please select client');
		return false;
	}
	if(package==''){
		$.messager.alert('Warning','Please select Package');
		return false;
	}
	
	var fromdate=new Date($('#fromdate').jqxDateTimeInput('getDate'));
	var todate=new Date($('#todate').jqxDateTimeInput('getDate'));
	if(fromdate==null){
		$.messager.alert('Warning','Please select From Date');
		return false;
	}
	if(todate==null){
		$.messager.alert('Warning','Please select To Date');
		return false;
	}
	fromdate.setHours(0,0,0,0);
	todate.setHours(0,0,0,0);
	if(fromdate>todate){
		$.messager.alert('Warning','From Date must be less than To Date');
		return false;
	}
	fromdate=$('#fromdate').jqxDateTimeInput('val');
	todate=$('#todate').jqxDateTimeInput('val');
	
	var remarks=$('#remarks').val();
	if(remarks!=''){
		if(remarks.length>200){
			$.messager.alert('Warning','Max 200 Chars only for Remarks');
			return false;
		}
	}
	
	$.messager.confirm('Confirm', 'Do you want to save changes?', function(r){
		if (r){
			var brhid=$('#cmbbranch').val();
			$.post('saveData.jsp',{'cldocno':cldocno,'package':package,'fromdate':fromdate,'todate':todate,'remarks':remarks,'brhid':brhid,'mode':1},function(data,status){
				data=JSON.parse(data);
				if(data.errorstatus=="0"){
					$.messager.alert('Message','Successfully Saved');
					$('#cmbclient,#cmbpackage').val('').trigger('change');
					$('#fromdate,#todate').jqxDateTimeInput('setDate',new Date());
					$('#remarks').val('');
					$('#packagegriddiv').load('packageGrid.jsp');
				}
				else{
					$.messager.alert('Message','Not Saved');
					return false;
				}
			});
		}
	});
}
function funClearData(){
	$('#cmbclient,#cmbpackage').val('').trigger('change');
	$('#fromdate,#todate').jqxDateTimeInput('setDate',new Date());
	$('#remarks').val('');
	$('#packageGrid').jqxGrid('clear');
}
</script>
</head>
<body onload="getBranch();setValues();">
	<form id="frmPackageContract" action="" method="post">
		<div id="mainBG" class="homeContent" data-type="background"> 
			<div class='hidden-scrollbar'>
				<table   >
					<tr>
						<td width="20%" style="vertical-align:top">
    						<fieldset style="background: #ECF8E0;">
								<table width="100%">
									<jsp:include page="../../heading.jsp"></jsp:include>
										<tr>
											<td colspan="2">
												<fieldset><legend>Contract Details</legend>
													<table style="width:100%;">
														<tr>
															<td><label class="branch">Client</label></td>
															<td><select name="cmbclient" id="cmbclient" style="max-width:150px;"><option value="">--Select--</option></select></td>
														</tr>
														<tr><td><label class="branch">From Date</label></td><td><div id="fromdate"></div></td></tr>
	 													<tr><td><label class="branch">To Date</label></td><td><div id="todate"></div></td></tr>
														<tr><td><label class="branch">Package</label></td><td><select style="width:150px;max-width:150px;" name="cmbpackage" id="cmbpackage"><option value="">--Select--</option></select></td></tr>
	 													<tr><td><label class="branch">Remarks</label></td><td><input type="text" name="remarks" id="remarks" style="width:150px;height:20px;" placeholder="Enter Remarks"></td></tr>
													</table>
												</fieldset>
											</td>
										</tr>
										<tr><td colspan="2"><hr></td></tr>
										<tr><td colspan="2" align="center"><button class="myButton" type="button" name="btnsave" id="btnsave" onclick="funSaveData();">Save</button>&nbsp;&nbsp;<button class="myButton" type="button" name="btnclear" id="btnclear" onclick="funClearData();">Clear</button></td></tr>
 <tr><td colspan="2">&nbsp;</td></tr>
 <tr><td colspan="2"><br><br><br><br><br><br><br></td></tr>	
	</table>
	</fieldset>
</td>
<td width="80%" style="vertical-align:top">
	<div id="packagegriddiv"><jsp:include page="packageGrid.jsp"></jsp:include></div>
</td>

		
</tr>
</table>
</div>
<input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
<input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
</div>
</form>
</body>
</html>