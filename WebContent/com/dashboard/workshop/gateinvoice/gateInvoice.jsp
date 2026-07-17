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
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 
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
    height:15px;
}
</style>

<script type="text/javascript">

$(document).ready(function () {
		/* document.getElementById("branchlabel").style.display="none";
		document.getElementById("branchdiv").style.display="none";
		   */
		$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200px;right:750px;'><img src='../../../../icons/31load.gif'/></div>");
	    $('#clientwindow').jqxWindow({ width: '55%', height: '55%',  maxHeight: '55%' ,maxWidth: '55%' , title: 'Client Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		$('#clientwindow').jqxWindow('close');
		
	 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 
	 var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
	 var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
	 $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate);
	 
	 $('#client').dblclick(function(){
	    $('#clientwindow').jqxWindow('open');
		$('#clientwindow').jqxWindow('focus');
	 	searchContent('clientMasterSearch.jsp?id=1', 'clientwindow');
	 });
	 
});

function getClient(event){
	var x= event.keyCode;
   	if(x==114){
   		$('#clientwindow').jqxWindow('open');
		$('#clientwindow').jqxWindow('focus');
		searchContent('clientMasterSearch.jsp?id=1', 'clientwindow');
   }
   else{
   }
}

function searchContent(url,windowid) {
	$.get(url).done(function (data) {
		$('#'+windowid).jqxWindow('setContent', data);
	}); 
}
function funreload(event)
{
	/* if($('#hidclient').val()==''){
		$.messager.alert('Warning','Client is Mandatory');
		return false;
	} */
	if($('#cmbbranch').val()=='' || $('#cmbbranch').val()=='a'){
		$.messager.alert('Warning','Branch is Mandatory');
		return false;
	}
	
    var fromdate=$('#fromdate').jqxDateTimeInput('val');
    var todate=$('#todate').jqxDateTimeInput('val');
	var client=$('#hidclient').val();
	var branch=$('#cmbbranch').val();
    $("#overlay, #PleaseWait").show();
   	$("#gateinvoicediv").load("gateInvoiceGrid.jsp?fromdate="+fromdate+"&todate="+todate+"&id=1&client="+client+"&cmbbranch="+branch);
   	
}
	
	

	function setValues(){

		 if($('#msg').val()!=""){
   		   $.messager.alert('Message',$('#msg').val());
   		  }
	
	}
	
	function funExportBtn(){
		JSONToCSVCon(gateinvoiceexceldata, 'Gate Invoice List of '+$('#client').val(), true);
		 }
	
		
	
	function funClearData(){
		$('input[type=text],[type=hidden]').val('');
		$('select').find('option').prop("selected", false);
		$('#fromdate').jqxDateTimeInput('setDate',new Date());
		$('#todate').jqxDateTimeInput('setDate',new Date());
		var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
	    var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
	    $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate); 
	    $('#client,#hidclient').val('');
	    
	}
	
	function funNotify(){
		if($('#hidclient').val()==''){
			$.messager.alert('Warning','Please Select Client');
			return false;
		}
		
		var rows=$('#gateInvoiceGrid').jqxGrid('getselectedrowindexes');
		if(rows.length==0){
			$.messager.alert('Warning','Please Select Valid Documents');
			return false;
		}
		else{
			var gatedocno='';
			var invamount=0.0;
			for(var i=0;i<rows.length;i++){
				if(i==0){
					gatedocno=$('#gateInvoiceGrid').jqxGrid('getcellvalue',rows[i],'doc_no');
				}
				else{
					gatedocno+=','+$('#gateInvoiceGrid').jqxGrid('getcellvalue',rows[i],'doc_no');
				}
				invamount+=$('#gateInvoiceGrid').jqxGrid('getcellvalue',rows[i],'invamount');
			}
			$('#hidgatedocno').val(gatedocno);
			$('#invamount').val(invamount);
		}
		$.messager.confirm('Confirm', 'Do you want to Invoice?', function(r){
			if (r){
				$('#mode').val('A');
				document.getElementById("frmGateInvoice").submit();
				//funSaveAJAX(gatedocno);
			}
		});
	}
	
	function funSaveAJAX(gatedocno){
		
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				items = x.responseText.trim();
				if(parseInt(items)>0){
					$.messager.alert('Message','Successfully Generated');
					funClearData();
					//$("#gateoutpassdiv").load("gateOutPassGrid.jsp?fromdate="+$('#fromdate').jqxDateTimeInput('val')+"&todate="+$('#todate').jqxDateTimeInput('val')+"&id=1");	
				}
				else{
					$.messager.alert('Message','Not Generated');
				}
				
			} else {
			}
		}
		x.open("GET", "invoiceAJAX.jsp?client="+$('#hidclient').val()+"&gatedocno="+$('#hidgatedocno').val()+"&amount="+$('#invamount').val()+'&fromdate='+$('#fromdate').jqxDateTimeInput('val')+'&todate='+$('#todate').jqxDateTimeInput('val'), true);
		x.send();
	}
	</script>
	
</head>
<body onload="getBranch();setValues();">
<form id="frmGateInvoice" action="saveGateInvoice" method="post">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%">
<tr>
<td width="23%" align="center">
    <fieldset style="background: #ECF8E0;">
	<table width="100%">
	<jsp:include page="../../heading.jsp"></jsp:include>

 <tr>
   <td width="37%" align="right"><label class="branch">From Date</label></td><td width="63%"><div id="fromdate" name="fromdate"></div></td></tr>
 <tr>
   <td align="right"><label class="branch">To Date</label></td>
   <td><div id="todate" name="todate"></div></td>
 </tr>
 <tr>
   <td align="right"><label class="branch">Client</label></td>
   <td><input type="text" name="client" id="client" placeholder="Press F3 to Search" style="height:18px;" onkeydown="getClient(event);"></td>
 </tr>
 <tr>
	<td colspan="2" style="border-top:2px solid #DCDDDE;">
	<div style="text-align:center;">
	<input type="button" name="btnclear" id="btnclear" value="Clear" class="myButtons" onclick="funClearData();"> &nbsp;&nbsp;
	<input type="button" name="btnsave" id="btnsave" value="Save" class="myButtons" onclick="funNotify();">
	</div>
    </td>
	</tr>
<tr ><td colspan="2"><!-- <textarea id="agmtdetails" name="agmtdetails" readonly style="resize:none;" rows="10" cols="35"></textarea> -->
	<br><br><br><br><br><br><br><br>
<br><br><br><br><br>

</td></tr>

<tr colspan="2"><td>&nbsp;</td></tr>
	
		
	</table>
	</fieldset>
</td>
<td width="77%">
	<table width="100%">
		<tr>
			 <td><div id="gateinvoicediv"><jsp:include page="gateInvoiceGrid.jsp"></jsp:include></div></td>
			  <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
			  <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
			  <input type="hidden" name="hidgatedocno" id="hidgatedocno" value='<s:property value="hidgatedocno"/>'>
			  <input type="hidden" name="hidclient" id="hidclient" value='<s:property value="hidclient"/>'>
			  <input type="hidden" name="invamount" id="invamount" value='<s:property value="invamount"/>'>
		
		</tr>
	</table>
</tr>
</table>
</div>
<div id="clientwindow">
	<div></div>
</div>
</div>
</form>
</body>
</html>