
<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>

<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 
<style>
.myButtons {
  display: inline-block;
  margin-right:4px;
  margin-left:4px; 
  margin-bottom: 0;
  font-weight: normal;
  line-height: 1.3;
  text-align: center;
  white-space: nowrap;
  vertical-align: middle;
  -ms-touch-action: manipulation;
  touch-action: manipulation;
  cursor: pointer;
  -webkit-user-select: none;
  -moz-user-select: none;
  -ms-user-select: none;
  user-select: none;
  background-image: none;
  border: 1px solid transparent;
  border-radius: 4px;
  color: #fff;
  background-color: grey;
}
.myButtons:hover {
  color: #fff;
  background-color: #31b0d5;
}
.myButtons:active {
  color: #fff;
  background-color: #31b0d5;
}
.myButtons:focus {
  color: #fff;
  background-color: grey;
}

</style>

<script type="text/javascript">

$(document).ready(function () {
	 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#followupdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 /* var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
	 var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
	 $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate); */
	 
});

function funreload(event)
{

//var fromdate= $("#fromdate").jqxDateTimeInput('val');
var todate= $("#todate").jqxDateTimeInput('val'); 
$("#overlay, #PleaseWait").show();
var branch=$('#cmbbranch').val(); 
$("#pendingdiv").load("pendingInvoicesGrid.jsp?todate="+todate+"&id=1&branch="+branch);

}
	

function  funClearData()
{
	$('#frmPendingInvoices input,textarea').val('');
	$('#pendingInvoicesGrid,#followupGrid').jqxGrid('clear');
	$('#followupdate').jqxDateTimeInput('setDate',new Date());
	/* var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
	var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
	$('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate) */;
   		
}

function funUpdate(){
	if(document.getElementById("jobcarddocno").value==""){
		$.messager.alert('Warning','Please Select Valid Document','Warning');
		return false;
	}
	else{
		$.messager.confirm('Confirm', 'Do you want to save changes?', function(r){
			if (r){
				funUpdateAJAX();
			}
		});
	}
}
function funUpdateAJAX(){
	var remarks=$('#remarks').val();
	var followupdate=$('#followupdate').jqxDateTimeInput('val');
	var jobcarddocno=$('#jobcarddocno').val();
	var cmbstatus=$('#cmbstatus').val();
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText.trim();
			if(items=="0"){
				$.messager.alert('Message','Follow Up Completed Succesfully','info');
				funreload(1);
				$('#followupdiv').load('followupGrid.jsp?jobcarddocno='+jobcarddocno+'&id=1');
			}
			else if(items==1){
				$.messager.alert('Message','Follow Up Completion Failed','warning');
			}
			
		}
		else{
			}
		}
	
	x.open("GET", "followup.jsp?jobcarddocno="+jobcarddocno+"&remarks="+remarks.replace(/\n/g, " ").replace(/ /g,"%20")+"&followupdate="+followupdate+"&cmbstatus="+cmbstatus, true);
	x.send();
}
function funExportBtn(){
	//JSONToCSVCon(pendingexceldata, 'Pending Invoices', true);
	$("#pendingdiv").excelexportjs({
		containerid: "pendingdiv",
		datatype: 'json',
		dataset: null,
		gridId: "pendingInvoicesGrid",
		columns: getColumns("pendingInvoicesGrid") ,
		worksheetName:"Pending Invoices"
	});
}
function funPrintBtn(){
	 if($('#docno').val()!='' && $('#docno').val()!='0'){
		 
		var url=document.URL;
		var reurl=url.split("com");
		var save=$('#savestatus').val();
		//alert(save);
		if(save=='0'){
			$.messager.alert('message','please save the form','warning');
		}
		else
			{       
		/* var path= "com/dashboard/workshop/quotationapproval/printQuotationAproval.action?estDocno="+estdocno; */
		var path= "com/dashboard/workshop/jobcardcompletenewpal/printWSJobCardCompleteNewPal.action?docno="+$('#jobcarddocno').val();
		var win= window.open(reurl[0]+path,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");		
		win.focus();		
			}	
    }
		
}

 </script>
</head>
<body onload="getBranch();">
	<div id="mainBG" class="homeContent" data-type="background"> 
		<form id="frmPendingInvoices" method="POST">
			<div class='hidden-scrollbar'>
				<table width="100%">
					<tr>
						<td width="20%" >
						    <fieldset style="background: #ECF8E0;">
								<table  width="100%"  >
									<jsp:include page="../../heading.jsp"></jsp:include>
								  	<%-- <tr width="100%">
								  		<td align="right" width="40%" ><label class="branch">From Date</label></td>
								  		<td align="left" width="40%"><div id='fromdate' name='fromdate' value='<s:property value="fromdate"/>'></div></td>
								  	</tr>  --%> 
								  	<tr width="100%">
								  		<td align="right" width="40%" ><label class="branch">Up To Date</label></td>
								  		<td align="left" width="40%"><div id='todate' name='todate' value='<s:property value="todate"/>'></div></td>
								  	</tr>  
								  	<tr width="100%">
								  		<td align="right" width="40%" ><label class="branch">FollowUp Date</label></td>
								  		<td align="left" width="40%"><div id='followupdate' name='followupdate' value='<s:property value="followupdate"/>'></div></td>
								  	</tr>
								  	<tr width="100%">
								  		<td align="right" width="40%" ><label class="branch">Change Status</label></td>
								  		<td align="left" width="40%"><select name="cmbstatus" id="cmbstatus" style="width:125px;"><option value="">--Select--</option><option value="WIP">WIP</option></select></td>
								  	</tr>
								  	<tr width="100%">
								  		<td align="right" width="40%" ><label class="branch">Remarks</label></td>
								  		<td align="left" width="40%"><textarea id="remarks" name="remarks" rows="17"></textarea></td>
								  	</tr>
								  	<tr><td colspan="2"><hr></td></tr>
								  	<tr><td colspan="2" align="center"><button type="button" class="myButtons" id="btnupdate" onclick="funUpdate();">Update</button>&nbsp;&nbsp;<button type="button" class="myButtons" id="btnclear" onclick="funClearData();">Clear</button></td></tr>
									<tr><td colspan="2" align="center">&nbsp;<input type="button" class="myButtons"  name="btnPrint" id="btnPrint" value="Print" class="myButtons" onclick="funPrintBtn();"></td></tr>
									
								</table>
							</fieldset>
						</td>
						<td width="80%">
							<table width="100%">
								<tr><td><div id="pendingdiv"><jsp:include page="pendingInvoicesGrid.jsp"></jsp:include></div></td></tr>
								<tr><td><div id="followupdiv"><jsp:include page="followupGrid.jsp"></jsp:include></div></td></tr>
							</table>
						</td>
					</tr>
				</table>
			</div>
			<input type="hidden" name="jobcarddocno" id="jobcarddocno">
		</form>
	</div>

</body>
</html>
