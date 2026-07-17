<link href="../../../../css/css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
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
 
select{
    height:18px;
}
	  
</style>

<script type="text/javascript">

$(document).ready(function () {
	
	$('#btnDiv').hide();
	 $('#estDocno').attr('readonly',true); 
	 $('#clnames').attr('readonly',true);
		$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200px;right:750px;'><img src='../../../../icons/31load.gif'/></div>");
	    
	 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#podate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null});
	 var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
	 var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
	 $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate);
	 document.getElementById("tobeapproved").checked=true;
	 $('#clnames').dblclick(function(){
	  	 	clientSearchContent("clientSearch.jsp");

		});
	 
	 $('#ClientDetailsToWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Client Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 $('#ClientDetailsToWindow').jqxWindow('close');
	 
	 
	 
	 
	 
});

function setApprov(){
	
	if(document.getElementById("approved").checked){
		document.getElementById("approval").value="approved";
		$('#btnDiv').hide();
	}
	else if(document.getElementById("tobeapproved").checked){
		document.getElementById("approval").value="tobeapproved";
		$('#btnDiv').show();
		
	}
	else{
		document.getElementById("gender").value="not selected";
	}
	
}

function funreload(event)
{	funNotify();
	setApprov();
    var fromdate=$('#fromdate').jqxDateTimeInput('val');
    var todate=$('#todate').jqxDateTimeInput('val');
	var aprv=$('#approval').val();
	var docnos=$('#cldocnos').val();
	/* alert(aprv); */
     $("#overlay, #PleaseWait").show(); 
    $("#quotationapprovaldiv").load("quotationAprovalGrid.jsp?fromdate="+fromdate+"&todate="+todate+"&id=1"+"&aprv="+aprv+"&docnos="+docnos); 
   	
}
	
function funSetApprv() {
	var excess=0;
	var estdocno=$('#estDocno').val();
	var hid=$('#brhid').val();
	var poNo=$('#pono').val();
	var poDate=$('#podate').val();
	var desc=$('#description').val();
	var examt=$('#excessamt').val();
	var gipNos=$('#gipnos').val();
	
	if ($('#chkexcess').is(":checked"))
	{
	   excess=1;
	}
	
	
	if(estdocno==""){
		$.messager.alert('Message','Please Select the document');
	}else{
	
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var sts = x.responseText;
				if(sts==1){
					$.messager.alert('Message','Not Approved');
				}
				if(sts==0){
					$.messager.alert('Message','Approved Succesfully');
					funreload(event);
				}
			}
	}
			
	}
	x.open("GET", "setApproval.jsp?estDocno="+estdocno+"&brhid="+hid+"&pono="+poNo+"&podate="+poDate+"&excess="+excess+"&desc="+desc+"&excessamt="+examt+"&gipno="+gipNos, true);
	x.send();
}	

	function setValues(){

		 if($('#msg').val()!=""){
   		   $.messager.alert('Message',$('#msg').val());
   		  }
	
	}
	
	function funExportBtn(){
		//JSONToCSVCon(repexceldata, 'Replacement List', true);
		 }
	
	function funPrintData() {
    	
		var estdocno=document.getElementById("estDocno").value;
		if(estdocno=='' || estdocno=='0'){
   		 $.messager.alert('Warning','Select a Document');
		}
		else{
		
	    	var url=document.URL;
	    	// alert("url ="+url); 
	 		var reurl=url.split("quotationApproval.jsp");
	    	// alert("reurl ="+reurl[0]);
	    	 /* var path= "com/dashboard/workshop/quotationapproval/printQuotationAproval.action?estDocno="+estdocno; */
	    	 var path= "printQuotationAproval.action?estDocno="+estdocno;
	         var win= window.open(reurl[0]+path,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");		
	         win.focus();		
		 }
    	}
	function funNotify(){
		if(!document.getElementById("approved").checked && !document.getElementById("tobeapproved").checked){
			$.messager.alert('Message','please select document type');
		}
		else{
		return 1;
		}
	}
	
		
	
	function funClearData(){
		$('input[type=text],[type=hidden]').val('');
		$('select').find('option').prop("selected", false);
		$('#fromdate').jqxDateTimeInput('setDate',new Date());
		$('#todate').jqxDateTimeInput('setDate',new Date());
		var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
	    var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
	    $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate); 
	    $('input[type=radio]').prop("checked",false);
	    $('input[type=checkbox]').prop("checked",false);
	}
	
	function getClientDetails(event){
	    var x= event.keyCode;
	    if(x==114){
	  	 	clientSearchContent("clientSearch.jsp");
	    }
	    else{
	     }
	    }
	function clientSearchContent(url) {
	 	$('#ClientDetailsToWindow').jqxWindow('open');
		$.get(url).done(function (data) {
			$('#ClientDetailsToWindow').jqxWindow('setContent', data);
		}); 
	}
	
	</script>
	
</head>
<body onload="setValues();getBranch();">
<form id="frmWorkQuotationApproval" method="post">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%">
<tr>
<td width="23%" align="center">
    <fieldset style="background: #ECF8E0;">
	<table width="100%">
	<jsp:include page="../../heading.jsp"></jsp:include>

 <tr>
   <td width="37%" align="right"><label class="branch">From Date</label></td><td width="63%"><div id="fromdate"></div></td></tr>
 <tr>
   <td align="right"><label class="branch">To Date</label></td>
   <td><div id="todate"></div></td>
 </tr>
 <tr>
	<td align="right"><label class="branch">Client</label></td>
	<td>
		<input type="text" name="clnames" id="clnames" style="height:18px; margine:1px;" placeholder="Press F3 to Search" onkeydown="getClientDetails(event)">
		<input type="hidden" name="cldocnos" id="cldocnos">
	</td>
</tr>
<tr>
	<td  colspan="2" align="center"><label class="branch">Approved</label>
	<input type="radio" name="approv" id="approved">
		<label class="branch">To Be Approved</label>
		<input type="radio" name="approv" id="tobeapproved">
		<input type="hidden" id="approval" name="approval" value='<s:property value="approval"/>'>
	</td>
</tr>

<tr>
	<td align="right"><label class="branch">PO No</label></td>
	<td><input type="text" name="pono" id="pono" style="height:18px; margine:1px;"></td>
</tr>
<tr>
	<td align="right"><label class="branch">PO Date</label></td>
	<td><div id="podate" name="podate"></div></td>
</tr>
<tr>
	<td align="right"><label class="branch">Description</label></td>
	<td><input type="text" name="description" id="description" style="height:18px; margine:1px;"></td>
</tr>
<tr>
	<td align="right"><label class="branch">Excess</label></td>
	<td><input type="checkbox" name="chkexcess" id="chkexcess" style="height:18px; margine:1px;"></td>
</tr>
<tr>
	<td align="right"><label class="branch">Excess Amount</label></td>
	<td><input type="text" name="excessamt" id="excessamt" style="height:18px; margine:1px;"></td>
</tr>
<tr>
	<td align="right"><label class="branch">Doc No</label></td>
	<td><input type="text" name="estDocno" id="estDocno" style="height:18px; margine:1px;"></td>
</tr>
<tr>
	<td colspan="2">
		<div id="btnDiv" style="text-align:center;">
			<input type="button" name="btnApprove" id="btnApprove" value="Approve" class="myButtons" onclick="funSetApprv()">
		</div>
		
	</td>
</tr>
 <tr >
	<td colspan="2" style="border-top:2px solid #DCDDDE;">
	<div style="text-align:center;">
	<input type="button" name="btnclear" id="btnclear" value="Clear" class="myButtons" onclick="funClearData();"> &nbsp;&nbsp;
	<input type="button" name="btnrepprint" id="btnrepprint" value="Print" class="myButtons" onclick="funPrintData();"> 
	</div>
    </td>
	</tr>
<tr ><td colspan="2"><!-- <textarea id="agmtdetails" name="agmtdetails" readonly style="resize:none;" rows="10" cols="35"></textarea> -->
	<br><br><br><br>
<br><br>
</td></tr>

<tr colspan="2"><td>&nbsp;</td></tr>
	
		
	</table>
	</fieldset>
</td>
<td width="77%">
	<table width="100%">
		<tr>
			 <td><div id="quotationapprovaldiv"><jsp:include page="quotationAprovalGrid.jsp"></jsp:include></div></td>
			  <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
			  <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
			  <input type="hidden" name="brhid" id="brhid" value='<s:property value="brhid"/>'>
			  <input type="hidden" name="gipnos" id="gipnos" value='<s:property value="gipno"/>'>
		
		</tr>
	</table>
</tr>
</table>
</div>

</div>
</form>
<div id="ClientDetailsToWindow">
	<div></div>
	</div>
</body>
</html>