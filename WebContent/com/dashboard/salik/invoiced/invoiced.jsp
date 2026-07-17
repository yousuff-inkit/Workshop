<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  

<style type="text/css">
.myButtons {
	-moz-box-shadow:inset 0px -1px 3px 0px #91b8b3;
	-webkit-box-shadow:inset 0px -1px 3px 0px #91b8b3;
	box-shadow:inset 0px -1px 3px 0px #91b8b3;
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #768d87), color-stop(1, #6c7c7c));
	background:-moz-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-webkit-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-o-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-ms-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:linear-gradient(to bottom, #768d87 5%, #6c7c7c 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#768d87', endColorstr='#6c7c7c',GradientType=0);
	background-color:#768d87;
	border:1px solid #566963;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	
	font-size:8pt;
	
	padding:3px 17px;
	text-decoration:none;
	text-shadow:0px -1px 0px #2b665e;
}
.myButtons:hover {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #6c7c7c), color-stop(1, #768d87));
	background:-moz-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-webkit-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-o-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-ms-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:linear-gradient(to bottom, #6c7c7c 5%, #768d87 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#6c7c7c', endColorstr='#768d87',GradientType=0);
	background-color:#6c7c7c;
}
.myButtons:active {
	position:relative;
	top:1px;
}
</style>

<script type="text/javascript">

$(document).ready(function () {
	 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});

	 $('#clientDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Client Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 $('#clientDetailsWindow').jqxWindow('close');
	 
	 $('#agreementDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Agreement Search',position: { x: 250, y: 120 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 $('#agreementDetailsWindow').jqxWindow('close');
	 
	 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	 
	 var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
     $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	 
	 
	   $("#btnExcel").click(function() {
		 if(parseInt(window.parent.chkexportdata.value)=="1")
		  {
		  	JSONToCSVCon(exceldata, 'Salik-Invoiced', true);
		  }
		 else
		  {
			$("#jqxInvoiced").jqxGrid('exportdata', 'xls', 'Salik-Invoiced');
		  }
		
		
	});            
     
});

	function clientSearchContent(url) {
	    $('#clientDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#clientDetailsWindow').jqxWindow('setContent', data);
		$('#clientDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function agreementSearchContent(url) {
	 	$('#agreementDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#agreementDetailsWindow').jqxWindow('setContent', data);
		$('#agreementDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function getClient(event){
        var x= event.keyCode;
        if(x==114){
        	clientSearchContent('clientDetailsSearch.jsp');
        }
        else{}
        }
	
	function getAgreement(event){
        var x= event.keyCode;
        if(x==114){
        	if($('#rentaltype').val()==""){
   	         $.messager.alert('Message','Choose a Type.','warning');   
   	         return false;
   	        }
        	var branchval = document.getElementById("cmbbranch").value; 
  		    agreementSearchContent('agreementDetailsSearch.jsp?branchval='+branchval);
        }
        else{}
        }
	
	function funSearchdblclick(){
		  $('#txtclientname').dblclick(function(){
			  clientSearchContent('clientDetailsSearch.jsp');
			});
		  
		  $('#txtagreementvoucherno').dblclick(function(){
			  if($('#rentaltype').val()==""){
			         $.messager.alert('Message','Choose a Type.','warning');   
			         return false;
			        }
			  var branchval = document.getElementById("cmbbranch").value; 
			  agreementSearchContent('agreementDetailsSearch.jsp?branchval='+branchval); 
			});
	}

	function  funClearData(){
		 $('#txtclientname').val('');$('#txtcldocno').val('');$('#rentaltype').val('');$('#txtagreementvoucherno').val('');$('#txtagreementno').val('');$('#fromdate').val(new Date());$('#todate').val(new Date());
		
		 $('#fromdate').val(new Date());
		 var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	     
		 if (document.getElementById("txtclientname").value == "") {
		        $('#txtclientname').attr('placeholder', 'Press F3 to Search'); 
		    }
		 if (document.getElementById("txtagreementvoucherno").value == "") {
		        $('#txtagreementvoucherno').attr('placeholder', 'Press F3 to Search'); 
		    }
	 }
	
	function funSalikInvoicePrint(){
	        var url=document.URL;
	        var reurl=url.split("invoiced.jsp");
			var cldocno = $('#txtcldocno').val();
			 var rentaltype = $('#rentaltype').val();
			 var agmtno = $('#txtagreementno').val();
	        var win= window.open(reurl[0]+"printSalikInvoice?&branch="+document.getElementById("cmbbranch").value+'&fromDate='+document.getElementById("fromdate").value+'&toDate='+$("#todate").val()+'&cldocno='+cldocno+'&rentaltype='+rentaltype+'&agmtno='+agmtno,"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
	        win.focus();
	   }
	
	function funreload(event){
			 var branchval = document.getElementById("cmbbranch").value;
			 var fromdate = $('#fromdate').val();
			 var todate = $('#todate').val();
			 var cldocno = $('#txtcldocno').val();
			 var rentaltype = $('#rentaltype').val();
			 var agmtno = $('#txtagreementno').val();
			 $("#overlay, #PleaseWait").show();
			 
			 $("#invoicedDiv").load("invoicedGrid.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&cldocno='+cldocno+'&rentaltype='+rentaltype+'&agmtno='+agmtno);
	}
	
</script>

</head>
<body onload="getBranch();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%"  >
	<jsp:include page="../../heading.jsp"></jsp:include>
		
    <tr><td colspan="2">&nbsp;</td></tr>
	<tr>
	 <td align="right"><label class="branch">From</label></td>
     <td align="left"><div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div></td></tr> 
	<tr>
	<td align="right"><label class="branch">To</label></td>
    <td align="left"><div id="todate" name="todate" value='<s:property value="todate"/>'></div></td>
	</tr>
	<tr><td align="right"><label class="branch">Client</label></td>
	<td align="left"><input type="text" id="txtclientname" name="txtclientname" style="width:100%;height:20px;" readonly="readonly" placeholder="Press F3 to Search" ondblclick="funSearchdblclick();" onkeydown="getClient(event);" value='<s:property value="txtclientname"/>'/>
    <input type="hidden" id="txtcldocno" name="txtcldocno" value='<s:property value="txtcldocno"/>'/></td></tr>
	<tr><td align="right"><label class="branch">Type</label></td>
     <td align="left"><select id="rentaltype" name="rentaltype"  value='<s:property value="rentaltype"/>'>
     <option value="">--Select--</option><option value="RAG">Rental</option><option value="LAG">Lease</option>
     </select></td></tr>
	<tr><td align="right"><label class="branch">Agreement</label></td>
	<td align="left"><input type="text" id="txtagreementvoucherno" name="txtagreementvoucherno" style="width:100%;height:20px;" readonly="readonly" placeholder="Press F3 to Search" ondblclick="funSearchdblclick();" onkeydown="getAgreement(event);" value='<s:property value="txtagreementvoucherno"/>'/>
	<input type="hidden" id="txtagreementno" name="txtagreementno" style="width:100%;height:20px;" value='<s:property value="txtagreementno"/>'/></td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2" align="center"><input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funClearData();">
	<button class="myButton" type="button" id="btnSalikInvoicePrint" name="btnSalikInvoicePrint" onclick="funSalikInvoicePrint();">Print</button></td></tr> 
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr> 
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr> 
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
    <tr><td colspan="2">&nbsp;</td></tr> 
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="invoicedDiv"><jsp:include page="invoicedGrid.jsp"></jsp:include></div></td>
		</tr>
	</table>
</tr>
</table>
</div>
<div id="clientDetailsWindow">
	<div></div><div></div>
</div>
<div id="agreementDetailsWindow">
	<div></div><div></div>
</div>
</div> 
</body>
</html>