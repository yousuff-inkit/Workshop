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

<script type="text/javascript">

$(document).ready(function () {
	$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
    $("#overlay, #PleaseWait").hide();
	 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:new Date()});
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:new Date()});
	
	 $('#clientDetailsWindow').jqxWindow({ width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Client Search' , theme: 'energyblue', position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	 $('#clientDetailsWindow').jqxWindow('close');
	
	 $('#fromdate').on('change', function (event) 
				{  
					var docdateval=funDateInPeriod($('#fromdate').jqxDateTimeInput('getDate'));
					if(docdateval==0){
						$('#fromdate').jqxDateTimeInput('focus');
						return false;
					}
				});
	 $('#todate').on('change', function (event) 
				{  
					var docdateval=funDateInPeriod($('#todate').jqxDateTimeInput('getDate'));
					if(docdateval==0){
						$('#todate').jqxDateTimeInput('focus');
						return false;
					}
				});
	 	$("#btnExcel").click(function() {
		
 		 if(parseInt(window.parent.chkexportdata.value)=="1")
   		  {
   		  	JSONToCSVCon(data1, 'To Be Invoiced Sailk', true);
   		  }
   		 else
   		  {
   			$("#jqxNotInvoiced").jqxGrid('exportdata', 'xls', 'To Be Invoiced Sailk');
   		  }
   		
 		
		}); 
	 /* var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
     $('#fromdate').jqxDateTimeInput('setDate', new Date(oneyearbackdate)); */
     if(document.getElementById("mode").value==""){

         var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
         var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
         $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate); 
     } 
    
     $('#txtclientname').dblclick(function(){
		  clientSearchContent('clientDetailsSearchGrid.jsp');
		});
});

	function clientSearchContent(url) {
	    $('#clientDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#clientDetailsWindow').jqxWindow('setContent', data);
		$('#clientDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function getClient(event){
	    var x= event.keyCode;
	    if(x==114){
	    	clientSearchContent('clientDetailsSearchGrid.jsp');
	    }
	    else{}
	    }

	function  funClearData(){
		 $('#txtclientname').val('');$('#agmtvocno').val('');$('#txtcldocno').val('');$('#rentaltype').val('');$('#txtagreementno').val('');$('#fromdate').val(new Date());$('#todate').val(new Date());
		$('#cmbtype').val('');
		 var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
         var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
         $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate); 
	     
		 if (document.getElementById("txtclientname").value == "") {
		        $('#txtclientname').attr('placeholder', 'Press F3 to Search'); 
		    }
		
	 }
	
	function funreload(event){
		if(document.getElementById("cmbbranch").value=="" || document.getElementById("cmbbranch").value=='a'){
			$.messager.alert('Warning','Please Select a Single Branch');
			return false;
		}
		var docdateval1=funDateInPeriod($('#fromdate').jqxDateTimeInput('getDate'));
		if(docdateval1==0){
			$('#fromdate').jqxDateTimeInput('focus');
			return false;
		}
		var docdateval=funDateInPeriod($('#todate').jqxDateTimeInput('getDate'));
			if(docdateval==0){
				$('#todate').jqxDateTimeInput('focus');
				return false;
			}
		 var branchval =document.getElementById("cmbbranch").value.trim();
		 var fromdate = $('#fromdate').val();
		 var todate = $('#todate').val();
		 var cldocno = $('#txtcldocno').val();
		 var rentaltype = $('#rentaltype').val();
		 var type=$('#cmbtype').val();
		 $("#overlay, #PleaseWait").show();
		 $("#notInvoicedDiv").load('notInvoicedGrid.jsp?branchval='+branchval+'&fromdate='+fromdate+'&todate='+todate+'&cldocno='+cldocno+'&rentaltype='+rentaltype+'&type='+type);
	}
	
	function funSalikInvoicePrint(){
        var url=document.URL;
        var reurl=url.split("notInvoiced.jsp");
        var cldocno = $('#txtcldocno').val();
		 var rentaltype = $('#rentaltype').val();
		 var agmtno = $('#txtagreementno').val();
        var win= window.open(reurl[0]+"printSalikToBeInvoiced?&branch="+document.getElementById("cmbbranch").value+'&fromDate='+document.getElementById("fromdate").value+'&toDate='+$("#todate").val()+'&agmtno='+agmtno+'&rentaltype='+rentaltype+'&cldocno='+cldocno,"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
        win.focus();
   }
	
	function setValues(){
		 if($('#msg').val()!=""){
	   		   $.messager.alert('Message','<center>'+$('#msg').val()+'</center>');
	   		  }
	}
	
	function funGenerate(){
		var docdateval1=funDateInPeriod($('#fromdate').jqxDateTimeInput('getDate'));
		if(docdateval1==0){
			$('#fromdate').jqxDateTimeInput('focus');
			return false;
		}
	var docdateval=funDateInPeriod($('#todate').jqxDateTimeInput('getDate'));
			if(docdateval==0){
				$('#todate').jqxDateTimeInput('focus');
				return false;
			}
		var rows=$('#jqxNotInvoiced').jqxGrid('getrows');
		if(document.getElementById("cmbbranch").value=="" || document.getElementById("cmbbranch").value=='a'){
			$.messager.alert('Warning','Please Select a Single Branch');
			return false;
		}
		
		if(rows.length==0){
			$.messager.alert('Message','Not Valid Data','warning');
			return false;
		}
		else{
			 $.messager.confirm('Confirm', 'Do you want to Generate Invoice?', function(r){
		 			if (r){
		 				document.getElementById("mode").value="A";
		 				$("#overlay, #PleaseWait").show();
		 				
		 				document.getElementById("frmNotInvoicedSalikEasy").submit();
		 				funClearData();
		 			}
			 });
		}
	}
</script>

</head>
<body onload="getBranch();setValues();">
<form id="frmNotInvoicedSalikEasy" action="saveNotInvoicedSalikEasy" method="post">
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
	<td align="left"><input type="text" id="txtclientname" name="txtclientname" style="width:100%;height:20px;" readonly placeholder="Press F3 to Search"  onkeydown="getClient(event);" value='<s:property value="txtclientname"/>'/>
    <input type="hidden" id="txtcldocno" name="txtcldocno" value='<s:property value="txtcldocno"/>'/></td></tr>
	<tr><td align="right"><label class="branch">Type</label></td>
     <td align="left"><select id="rentaltype" name="rentaltype"  value='<s:property value="rentaltype"/>'>
     <option value="">--Select--</option><option value="RAG">Rental</option><option value="LAG">Lease</option>
     </select></td></tr>
	<%-- <tr><td align="right"><label class="branch">Agreement</label></td>
	<td align="left"><input type="text" name="agmtvocno" id="agmtvocno" value='<s:property value="agmtvocno"/>' style="width:100%;height:20px;" readonly placeholder="Press F3 to Search" onkeydown="getAgreement(event);"></td></tr> --%>
	<tr><td align="right"><label class="branch">Type</label></td><td><select name="cmbtype" id="cmbtype">
	<option value="">--Select--</option>
	<option value="Daily">Daily</option>
	<option value="Weekly">Weekly</option>
	<option value="Monthly">Monthly</option>
	<option value="Lease">Lease</option>
	</select></td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
    <tr><td colspan="2" align="center"><input type="button" name="btngenerate"  id="btngenerate" value="Generate" class="myButton" onclick="funGenerate();"></td></tr>
	<tr><td colspan="2" align="center"><input type="button" class="clearButton" name="clear" id="clear"  value="Clear" onclick="funClearData();">
	<button class="myButton" type="button" id="btnSalikInvoicePrint" name="btnSalikInvoicePrint" onclick="funSalikInvoicePrint();">Print</button></td></td></tr> 
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
			 <td><div id="notInvoicedDiv"><jsp:include page="notInvoicedGrid.jsp"></jsp:include></div></td>
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
<input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
<input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
</form> 
</body>
</html>