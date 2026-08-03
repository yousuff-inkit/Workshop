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
<%--  <script type="text/javascript" src="../../js/dashboard.js"></script>  --%>
<style type="text/css">
.myButtons, .btn-submit {
    height: 30px !important;
    padding: 0 12px !important;
    margin-right: 4px;
    margin-left: 4px;
    background-color: #2563eb !important;
    color: #fff !important;
    border: none !important;
    border-radius: 4px !important;
    font-size: 13px !important;
    font-weight: 600 !important;
    line-height: 30px !important;
    white-space: nowrap;
    text-align: center;
    cursor: pointer;
    -webkit-user-select: none;
       -moz-user-select: none;
        -ms-user-select: none;
            user-select: none;
    box-sizing: border-box;
}
.myButtons:hover, .btn-submit:hover {
    color: #fff;
    background-color: #1d4ed8 !important;
}
.myButtons:active, .btn-submit:active {
    color: #fff;
    background-color: #1d4ed8 !important;
}
.myButtons:focus, .btn-submit:focus {
    color: #fff;
    background-color: #2563eb !important;
}

.headClass    { background-color: #FFEBC2; }
.redClass     { background-color: #FFEBEB; }
.violetClass  { background-color: #fff; }
.yellowClass  { background-color: #FFFFD1; }
.whiteClass   { background-color: #FFF; }
.greenClass   { background-color: #CEFFCE; }

/* ===== MASTER LAYOUT ===== */
html, body, #mainBG, .hidden-scrollbar {
    height: 100%;
    margin: 0;
    overflow: hidden;
    background-color: #f4f7f9;
}
.master-container {
    display: flex;
    width: 100%;
    height: 100%;
}
.sidebar-filters {
    width: 280px;
    flex: 0 0 280px;
    background: #fff;
    height: 100%;
    box-sizing: border-box;
}
.sidebar-scroll-content {
    height: 100%;
    overflow-y: auto;
    padding: 10px;
    box-sizing: border-box;
}
.filter-table {
    width: 100%;
}
.filter-table .label-cell {
    text-align: right;
    font-size: 12px;
    color: #4e5e71;
    font-weight: 600;
    width: 37%;
    padding-right: 6px;
}
.filter-table td { padding: 3px 0; }
.filter-table input[type="text"],
.filter-table select {
    height: 24px !important;
    padding: 2px 8px;
    border-radius: 4px;
    font-size: 12px;
    width: 90% !important;
    box-sizing: border-box;
}
/* jqxDateTimeInput renders its own nested input; target it directly so
   the resize (from 125px/15px) doesn't leave text vertically clipped. */
#Uptodate {
    width: 90% !important;
    height: 24px !important;
}
#Uptodate .jqx-widget,
#Uptodate .jqx-widget-content,
#Uptodate input {
    height: 24px !important;
    line-height: 24px !important;
    font-size: 12px !important;
    color: #333333 !important;
    opacity: 1 !important;
    box-sizing: border-box !important;
}
.hidden-fields { display: none; }

.main-content-wrapper {
    flex: 1 1 auto;
    height: 100%;
    display: flex;
    flex-direction: column;
    box-sizing: border-box;
    min-width: 0;
}
.top-toolbar-container {
    width: 100%;
    padding: 10px 15px;
    background: #ffffff;
    border-bottom: 1px solid #e1e8ed;
    box-sizing: border-box;
    flex-shrink: 0;
}
.scrollable-grid-area {
    flex: 1 1 auto;
    overflow: auto;
    box-sizing: border-box;
    padding: 15px 20px;
}
.content-card {
    margin-bottom: 15px;
}
</style>

<script type="text/javascript">

$(document).ready(function () {
	$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	$("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200px;right:750px;'><img src='../../../../icons/31load.gif'/></div>");
	    
	$("#Uptodate").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"dd.MM.yyyy"});

	$('#accountwindow').jqxWindow({ width: '50%', height: '55%',  maxHeight: '55%' ,maxWidth: '50%' , title: 'Account Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	$('#accountwindow').jqxWindow('close');
	 
	$('#fromaccount').dblclick(function(){
		$('#accountwindow').jqxWindow('open');
		$('#accountwindow').jqxWindow('focus');
		accountSearchContent("accountSearchGrid.jsp?id=1&fromto=1");
	});
	$('#toaccount').dblclick(function(){
		$('#accountwindow').jqxWindow('open');
		$('#accountwindow').jqxWindow('focus');
		accountSearchContent("accountSearchGrid.jsp?id=1&fromto=2");
	});
	$('#btncreatecot').hide();
});
function funExportBtn(){
	JSONToCSVCon(maingriddataexcel, 'Parts Disbursment', true);
}
function funClearData(){
	$('input[type=text],[type=hidden]').val('');
	$('select').find('option').prop("selected", false);
	$('#Uptodate').jqxDateTimeInput('setDate',new Date());
	$("#partsDisbursmentGrid,#cashGrid,#creditGrid").jqxGrid('clear');
}
function funreload(event)
{	
	$("#partsdisbursmentdiv").load("partsDisbursmentGrid.jsp?&id=1");
}
	
function accountSearchContent(url) {
	$.get(url).done(function (data) {
		$('#accountwindow').jqxWindow('setContent', data);
	}); 
}
function getFromAccount(event){
	var x= event.keyCode;
    if(x==114){
    	$('#accountwindow').jqxWindow('open');
		$('#accountwindow').jqxWindow('focus');
		accountSearchContent("accountSearchGrid.jsp?id=1&fromto=1");
    }
    else{
    }
}

function getToAccount(event){
	var x= event.keyCode;
    if(x==114){
    	$('#accountwindow').jqxWindow('open');
		$('#accountwindow').jqxWindow('focus');
		accountSearchContent("accountSearchGrid.jsp?id=1&fromto=2");
    }
    else{
    }
}
function funCreateCot(){
	var jobdocno=$('#jobcarddocno').val();
	var jobvocno=$('#jobcardvocno').val();
	if(jobdocno==''){
		$.messager.alert('Warning','Please select a jobcard');
		return false;
	}
	var selectedrows=$('#cashGrid').jqxGrid('getselectedrowindexes');
	if(selectedrows.length==0){
		$.messager.alert('Warning','Please select any valid documents');
		return false;
	}
	var amount=0.0;
	var rows="";
	for(var i=0;i<selectedrows.length;i++){
		if(i==0){
			rows+=$('#cashGrid').jqxGrid('getcellvalue',selectedrows[i],'rowno')
		}
		else{
			rows+=","+$('#cashGrid').jqxGrid('getcellvalue',selectedrows[i],'rowno')
		}
		amount+=parseFloat($('#cashGrid').jqxGrid('getcellvalue',selectedrows[i],'total'));
	}
	var fromacno=$('#fromacno').val();
	var toacno=$('#toacno').val();
	if(fromacno==''){
		$.messager.alert('Warning','Please select From Account');
		return false;
	}
	if(toacno==''){
		$.messager.alert('Warning','Please select To Account');
		return false;
	}
	funCreateCOTAJAX(jobdocno,amount,fromacno,toacno,jobvocno,rows);
}
	
	function funCreateCOTAJAX(jobdocno,amount,fromacno,toacno,jobvocno,rows){
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText.trim();
				if(items.split("::")[0]=="0"){
					$.messager.alert('Message',items.split("::")[1]);
					funClearData();
					funreload("");
				}
				else{
					$.messager.alert('Warning',items.split("::")[1]);
				}
				} else {
				}
			}
			x.open("GET", "createCOT.jsp?jobdocno="+jobdocno+"&amount="+amount+"&fromacno="+fromacno+"&toacno="+toacno+"&jobvocno="+jobvocno+"&rows="+rows, true);
			x.send();
	}
	
	
	function funServiceUpdate(){  
		
		var jobno=$('#jobcarddocno').val();
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
		{
			var items=x.responseText;
			if(parseInt(items)>=1)
			{
				 $("#partsdisbursmentdiv").load("partsDisbursmentGrid.jsp?&id=1");
				  $("#partflwupgrid").load("partsfllwup.jsp?docno="+jobno+"");
				$.messager.alert('Message', ' Successfully Updated ');
			}
			else
			{
				$.messager.alert('Message', ' Not Updated ');
			}
		}   
		}  
		x.open("GET","saveData.jsp?rowno="+$('#rowsno').val()+"&date="+$('#Uptodate').val()+"&remarks="+$('#txtremarks').val()+"&statusid="+$('#txtstatus').val()+"&jobno="+$('#jobcarddocno').val(),true);    
		x.send();
	}
	
	
	function funConfirmData(){
	var jobdocno=$('#jobcarddocno').val();
	var jobvocno=$('#jobcardvocno').val();
	if(jobdocno==''){
		$.messager.alert('Warning','Please select a jobcard');
		return false;
	}
	var selectedrows=$('#cashGrid').jqxGrid('getselectedrowindexes');
	if(selectedrows.length==0){
		$.messager.alert('Warning','Please select any valid documents');
		return false;
	}
	var amount=0.0;
	var rows="";
	for(var i=0;i<selectedrows.length;i++){
		if(i==0){
			rows+=$('#cashGrid').jqxGrid('getcellvalue',selectedrows[i],'rowno')
		}
		else{
			rows+=","+$('#cashGrid').jqxGrid('getcellvalue',selectedrows[i],'rowno')
		}
		amount+=parseFloat($('#cashGrid').jqxGrid('getcellvalue',selectedrows[i],'total'));
	}
	funConfirmDataAJAX(jobdocno,amount,jobvocno,rows);
}


function funConfirmDataAJAX(jobdocno,amount,jobvocno,rows){
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText.trim();
				if(items.split("::")[0]=="0"){
					$.messager.alert('Message',items.split("::")[1]);
					funClearData();
					funreload("");
				}
				else{
					$.messager.alert('Warning',items.split("::")[1]);
				}
				} else {
				}
			}
			x.open("GET", "confirmData.jsp?jobdocno="+jobdocno+"&amount="+amount+"&jobvocno="+jobvocno+"&rows="+rows, true);
			x.send();
	}
</script> 
	
</head>
<!-- setValues(); -->
<body onload="getBranch();disablepart();">
<!-- <form id="frmWorkQuotationApproval" method="post"> -->
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>

<div class="master-container">

	<div class="sidebar-filters">
		<div class="sidebar-scroll-content">
			<table class="filter-table">
				<tr>
					<td class="label-cell">Status</td>
					<td><select id="txtstatus" name="txtstatus" value='<s:property value="txtstatus"/>'>
						<option value="">--select--</option>
						<option value="Available">Available</option>
						<option value="PartAvail">Partially Available</option>
						<option value="Delayed">Delayed</option>
						<option value="Ordered">Ordered</option>
					</select></td>
				</tr>
				<tr>
					<td class="label-cell">Parts exp.Dt</td>
					<td><div id="Uptodate"></div></td>
				</tr>
				<tr>
					<td class="label-cell">Remarks</td>
					<td><input type="text" name="txtremarks" id="txtremarks" value='<s:property value="txtremarks"/>' ></td>
				</tr>
			</table>
			<div style="text-align:center; margin-top: 15px; border-top:2px solid #DCDDDE; padding-top: 12px;">
				<input type="button" name="btnupdate" id="btnupdate" value="Update" class="myButtons" onclick="funServiceUpdate();">
				<input type="button" name="btncreatecot" id="btncreatecot" value="Create Contra Trans" class="myButtons" onclick="funCreateCot();">
				<input type="button" name="btnconfirm" id="btnconfirm" value="Confirm" class="myButtons" onclick="funConfirmData();">
			</div>
		</div>
	</div>

	<div class="main-content-wrapper">
		<div class="top-toolbar-container">
			<jsp:include page="../../heading.jsp"></jsp:include>
		</div>
		<div class="scrollable-grid-area">

			<fieldset class="violetClass content-card">
				<legend>Parts Disbursment Details </legend>
				<div id="partsdisbursmentdiv"><jsp:include page="partsDisbursmentGrid.jsp"></jsp:include></div>
			</fieldset>

			<fieldset class="violetClass content-card">
				<legend>Cash Details</legend>
				<div id="cashgriddiv"><jsp:include page="cashGrid.jsp"></jsp:include></div>
			</fieldset>

			<fieldset class="violetClass content-card">
				<legend>Credit Details</legend>
				<div id="creditgriddiv"><jsp:include page="creditGrid.jsp"></jsp:include></div>
			</fieldset>

			<fieldset class="violetClass content-card">
				<legend>Parts Followup</legend>
				<div id="partflwupgrid"><jsp:include page="partsfllwup.jsp"></jsp:include></div>
			</fieldset>

		</div>
	</div>

</div>

<div class="hidden-fields">
	<label class="branch">Account From</label>
	<input type="text" name="fromaccount" id="fromaccount" readonly placeholder="Press F3 to Search" onkeydown="getFromAccount();">
	<input type="text" name="fromaccountname" id="fromaccountname" readonly disabled>
	<input type="hidden" name="fromacno" id="fromacno" >
	<label class="branch">Account To</label>
	<input type="text" name="toaccount" id="toaccount" readonly placeholder="Press F3 to Search" onkeydown="getToAccount();">
	<input type="text" name="toaccountname" id="toaccountname" readonly disabled>
	<input type="hidden" name="toacno" id="toacno" >
</div>

</div>

</div>
			  <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
			  <input type="hidden" name="rowsno" id="rowsno" value='<s:property value="rowsno"/>'>
			  <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
			  <input type="hidden" name="jobcarddocno" id="jobcarddocno" value='<s:property value="jobcarddocno"/>'>
			  <input type="hidden" name="cldocno" id="cldocno" value='<s:property value="cldocno"/>'>
			  <input type="hidden" name="jobno" id="jobno" value='<s:property value="jobno"/>'>
			  <input type="hidden" name="techno" id="techno" value='<s:property value="techno"/>'>
			  <input type="hidden" name="bayno" id="techno" value='<s:property value="techno"/>'>
			  <input type="hidden" name="part" id="part" value='<s:property value="part"/>'>
			  <input type="hidden" name="qnty" id="qnty" value='<s:property value="qnty"/>'>
			  <input type="hidden" name="rownum" id="rownum" value='<s:property value="rownum"/>'>
			  <input type="hidden" name="purqty" id="purqty" value='<s:property value="purqty"/>'>
			   <input type="hidden" name="tbpur" id="tbpur" value='<s:property value="tbpur"/>'>
			  <input type="hidden"  id="srvdetmtrno" name="srvdetmtrno" value='<s:property value="srvdetmtrno"/>' >
			  <input type="hidden"  id="chngntb" name="chngntb" value='<s:property value="chngntb"/>' >
			  <input type="hidden"  id="addval" name="addval" value='<s:property value="addval"/>' >
			  <input type="hidden" id="vendorname" name=vendorname value='<s:property value="vendorname"/>'>
			  <input type="hidden" id="vendorid" name=vendorid value='<s:property value="vendorid"/>'>
			  <input type="hidden" id="vendtax" name=vendtax value='<s:property value="vendtax"/>'>
			  <input type="hidden" id="vendacno" name=vendacno value='<s:property value="vendacno"/>'>
			   <input type="hidden" id="raccno" name=raccno value='<s:property value="raccno"/>'>
			     <input type="hidden" id="nettotal" name=nettotal value='<s:property value="nettotal"/>'>
			     <input type="hidden" id="remtrno" name=remtrno value='<s:property value="remtrno"/>'>
			     <input type="hidden" id="hiddesc" name=hiddesc value='<s:property value="hiddesc"/>'>
</form>
<div id="TechnicianWindow">
	<div></div>
	</div>
	<div id="bayWindow">
	<div></div>
	</div>
	<div id="accountwindow">
	<div></div>
	</div>
	<div id="jobCardToWindow">
	<div></div>
	</div>
	<div id="vendorToWindow">
	<div></div>
</div>
</body>
</html>
