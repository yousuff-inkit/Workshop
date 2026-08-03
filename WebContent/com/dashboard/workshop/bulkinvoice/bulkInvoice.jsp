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
<style type="text/css">/* ===== MASTER LAYOUT ===== */
html, body, #mainBG, .hidden-scrollbar {
    height: 100%;
    margin: 0;
    overflow: hidden;
    background-color: #f4f7f9;
}

.master-container {
    display: flex;
    width: 100%;
    height: 100vh;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
}

/* ===== LEFT SIDEBAR ===== */
.sidebar-filters {
    width: 300px; 
    flex: 0 0 300px; 
    background: #fff;
    border-right: 1px solid #e1e8ed;
    display: flex;
    flex-direction: column;
    height: 100%;
    box-shadow: 2px 0 8px rgba(0,0,0,.05);
    z-index: 10;
}

.sidebar-scroll-content {
    flex: 1;
    overflow-y: auto;
    padding: 15px 15px 25px; 
}

/* Cards Layout Rules */
.filter-card {
    background: #f8fafc;
    border: 1px solid #e3e8ee;
    border-radius: 12px;
    padding: 15px;
    margin-bottom: 12px;
}

/* Internal Presentation Tables */
.filter-table {
    width: 100%;
    border-spacing: 0 10px;
}

.filter-table .label-cell {
    text-align: right;
    padding-right: 10px;
    font-size: 12px;
    color: #4e5e71;
    font-weight: 600;
    width: 90px;
}

/* ===== UNIFORM 24px INPUTS & SELECTS ===== */
input[type="text"], select,
.filter-table input[type="text"],
.filter-table select {
    width: 100%;
    height: 24px !important;             
    padding: 2px 8px !important;         
    border: 1px solid #ccd6e0 !important;
    border-radius: 4px !important;       
    font-size: 12px !important;          
    background-color: #ffffff;
    box-sizing: border-box;
    color: #333;
    outline: none;
}

/* jqx Date Container Mapping Rules */
.filter-table div[id^="periodupto"] {
    width: 100%;
}

/* Select2 overrides to match 24px height */
.select2-container .select2-selection--single {
    height: 24px !important;
    border: 1px solid #ccd6e0 !important;
    border-radius: 4px !important;
}
.select2-container--default .select2-selection--single .select2-selection__rendered {
    line-height: 22px !important;
    font-size: 12px !important;
    padding-left: 8px !important;
}
.select2-container--default .select2-selection--single .select2-selection__arrow {
    height: 22px !important;
}

/* ===== MASTER 30px BUTTON SYSTEM ===== */
.btn-submit {
    width: 100%;
    height: 30px !important;            
    padding: 0 12px !important;
    background: #2563eb !important;
    color: #fff !important;
    border: none !important;
    border-radius: 4px !important;
    font-size: 13px !important;
    font-weight: 600 !important;
    cursor: pointer;
    line-height: 30px !important;
    white-space: nowrap;
    text-align: center;
    transition: all 0.2s ease;
    box-shadow: none !important;
    display: inline-block;
    box-sizing: border-box;
    margin-bottom: 8px;
}

.btn-submit:hover {
    background: #1d4ed8 !important;
}

/* ===== RIGHT CONTENT AREA (Horizontally Aligned Heading) ===== */
.main-content-wrapper {
    flex: 1; 
    display: flex;
    flex-direction: column;
    background: #ffffff;
    height: 100%;
    overflow: hidden;
}

.top-toolbar-container {
    width: 100%;
    padding: 10px 15px;
    background: #ffffff;
    border-bottom: 1px solid #e1e8ed;
    box-sizing: border-box;
}

.scrollable-grid-area {
    flex: 1;
    padding: 15px 20px;
    overflow: auto; 
    box-sizing: border-box;
    position: relative;
}</style>
<link href="../../../../vendors/select2/css/select2.min.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="../../../../vendors/select2/js/select2.min.js"></script>
<script type="text/javascript">

$(document).ready(function () {
	$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
	$("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200;right:600;'><img src='../../../../icons/31load.gif'/></div>");    
	$("#periodupto").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	$('#periodupto').on('change', function (event) 
	{  
		var docdateval=funDateInPeriod($('#periodupto').jqxDateTimeInput('getDate'));
		if(docdateval==0){
			$('#periodupto').jqxDateTimeInput('focus');
			return false;
		}
	});
	$.get("getInitData.jsp", function(data, status){
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
	});
	$('#btninvoiceconfirm').click(function(){
		var rowsCount = $('#amountGrid').jqxGrid('getrows').length;
		for(var i=0;i<rowsCount;i++){
    		var invno=parseInt($('#amountGrid').jqxGrid('getcellvalue',i,'invno'));
    		if(invno>0){
    			
		    }
		    else{
		    	$.messager.alert('Warning','Invoice Not Generated , Confirmation Restricted');
    			return 0;
		    }
    	}
    	funConfirm();
	});
});

function funreload(event)
{
	
	if(document.getElementById("cmbbranch").value=="" || document.getElementById("cmbbranch").value=='a'){
		$.messager.alert('Warning','Please Select Branch');
		return false;
	}
	if(document.getElementById("cmbclient").value=="" || document.getElementById("cmbclient").value=='a'){
		$.messager.alert('Warning','Please Select Client');
		return false;
	}
	var dateval=funDateInPeriod($('#periodupto').jqxDateTimeInput('getDate'));
	if(dateval==1){
		$("#overlay, #PleaseWait").show();
		var branch=document.getElementById("cmbbranch").value;
		var date=$('#periodupto').jqxDateTimeInput('val');
		var cldocno=$('#cmbclient').val();
		$("#amountgriddiv").load("amountGrid.jsp?branch="+branch+"&id=1&cldocno="+cldocno);
	}
}

	function funNotify(){
		//var jobcarddocno=$('#jobcarddocno').val();
		var cldocno=$('#cmbclient').val();
		var docdateval=funDateInPeriod($('#periodupto').jqxDateTimeInput('getDate'));
		if(docdateval==0){
			$('#periodupto').jqxDateTimeInput('focus');
			return false;
		}
		var branch=$('#cmbbranch').val();
		var selectedrows=$('#amountGrid').jqxGrid('getselectedrowindexes');
		if(selectedrows.length==0){
			$.messager.alert('Warning','Please select any document');
			return false;
		}
		var invoicedate=$('#periodupto').jqxDateTimeInput('val');
		$.messager.confirm('Confirm', 'Do you want to generate invoice?', function(r){
			if (r){
				var invoicearray=new Array();
				for(var i=0;i<selectedrows.length;i++){
					var rowno=$('#amountGrid').jqxGrid('getcellvalue',selectedrows[i],'rowno');
					var insurstatus=$('#amountGrid').jqxGrid('getcellvalue',selectedrows[i],'insurstatus');
					var billtoacno=$('#amountGrid').jqxGrid('getcellvalue',selectedrows[i],'billtoacno');
					var claimno=$('#amountGrid').jqxGrid('getcellvalue',selectedrows[i],'claimno');
					var description=$('#amountGrid').jqxGrid('getcellvalue',selectedrows[i],'description');
					var amount=$('#amountGrid').jqxGrid('getcellvalue',selectedrows[i],'amount');
					var discount=$('#amountGrid').jqxGrid('getcellvalue',selectedrows[i],'discount');
					var net=$('#amountGrid').jqxGrid('getcellvalue',selectedrows[i],'net');
					var vat=$('#amountGrid').jqxGrid('getcellvalue',selectedrows[i],'vat');
					var total=$('#amountGrid').jqxGrid('getcellvalue',selectedrows[i],'total');
					var excess=$('#amountGrid').jqxGrid('getcellvalue',selectedrows[i],'excess');
					var roundoff=$('#amountGrid').jqxGrid('getcellvalue',selectedrows[i],'roundoff');
					var netbill=$('#amountGrid').jqxGrid('getcellvalue',selectedrows[i],'netbill');
					var jobdocno=$('#amountGrid').jqxGrid('getcellvalue',selectedrows[i],'jobdocno');
					//alert(rowno+"::"+insurstatus+"::"+billtoacno+"::"+claimno+"::"+description+"::"+amount+"::"+discount+"::"+net+"::"+vat+"::"+total+"::"+excess+"::"+roundoff+"::"+netbill);
					invoicearray.push(rowno+" :: "+insurstatus+" :: "+billtoacno+" :: "+claimno+" :: "+description+" :: "+amount+" :: "+discount+" :: "+net+" :: "+vat+" :: "+total+" :: "+excess+" :: "+roundoff+" :: "+netbill+" :: "+jobdocno);
				}
				var x = new XMLHttpRequest();
				x.onreadystatechange = function() {
					if (x.readyState == 4 && x.status == 200) {
						var items = x.responseText.trim();
						if(items.split("::")[0]=="0"){
							$.messager.alert('Message','Invoice No(s) '+items.split("::")[1]+' Generated');
							$('#amountGrid').jqxGrid('clear');	
						}
						else{
							$.messager.alert('Message','Invoice Not Generated');
							return false;
						}
					} else {
					}
				}
				x.open("GET", "generateInv.jsp?invoicedate="+invoicedate+"&cldocno="+cldocno+"&invoicearray="+invoicearray+"&branch="+branch, true);
				x.send();
			}
		});
	}
	function setValues(){
		if($('#msg').val()!=""){
   			$.messager.alert('Message','<center>'+$('#msg').val()+'</center>');
   		}
	}
	function funExportBtn(){
		if(parseInt(window.parent.chkexportdata.value)=="1")
		{
			JSONToCSVCon(invoicedata, 'Rental Invoice', true);
		}
		else
		{
			 $("#rentalInvoiceGrid").jqxGrid('exportdata', 'xls', 'Rental Invoice');
		}
	}
	
	function funConfirm(){
		$.messager.confirm('Confirm', 'Do you want to confirm invoice?', function(r){
			if (r){
				var jobcarddocno=$('#jobcarddocno').val();
				var x = new XMLHttpRequest();
				x.onreadystatechange = function() {
					if (x.readyState == 4 && x.status == 200) {
						var items = x.responseText.trim();
						if(items=="0"){
							$.messager.alert('Message','Invoice Confirmed');
							funreload("");
						}
						else{
							$.messager.alert('Warning','Not Confirmed');
							return false;
						}
					} else {
					}
				}
				x.open("GET", "confirmInvoice.jsp?jobdocno="+jobcarddocno, true);
				x.send();
			}
		});
	}
	
	function funPrint(){
		var invno=$('#invno').val();
		var invbrhid=$('#invbrhid').val();
		if(invno=='' || invno==null || invno=='undefined'){
			$.messager.alert('Warning','Please select a valid Document');
		}
		else{
			var url=document.URL;
	        var reurl=url.split("com");
	        var win= window.open(reurl[0]+"com/workshop/invoice/WSInvoicePrintAction.action?&docno="+document.getElementById("invno").value+"&header=1&branch="+invbrhid,"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
	        //alert(reurl[0]+"WSInvoicePrintAction.action?&docno="+document.getElementById("invno").value+"&header=1&branch="+invbrhid);
	        win.focus();
		}
	}
</script>
</head>
<body onload="getBranch();setValues();">
<form id="frmWSBulkInvoice" action="saveWSBulkInvoice" method="post">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>

<div class="master-container">

    <!-- ================= LEFT PANEL (SIDEBAR) ================= -->
    <div class="sidebar-filters">
        <div class="sidebar-scroll-content">

            <!-- Primary Filters Card -->
            <div class="filter-card">
                <table class="filter-table">
                    <tr>
                        <td class="label-cell">Client</td>
                        <td>
                            <select name="cmbclient" id="cmbclient" style="width:100%;">
                                <option value="">--Select--</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Invoice Date</td>
                        <td>
                            <div id="periodupto"></div>
                        </td>
                    </tr>
                </table>
            </div>

            <!-- Action Buttons Card -->
            <div class="filter-card">
                <input type="button" name="btninvoicesave" id="btninvoicesave" class="btn-submit" value="Generate" onclick="funNotify();">
                <!-- <input hidden="true" type="button" name="btninvoiceprint" id="btninvoiceprint" class="btn-submit" value="Print" onclick="funPrint();"> -->
            </div>

            <!-- Hidden Inputs Maintained Safely Outside Visual Layout -->
            <div style="display:none;">
                <input type="hidden" name="gridlength" id="gridlength" >
                <input type="hidden" name="invgridlength" id="invgridlength" >
                <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
                <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
                <input type="hidden" name="hidchkmultiple" id="hidchkmultiple" value='<s:property value="hidchkmultiple"/>'>
                <input type="hidden" name="jobcarddocno" id="jobcarddocno" value='<s:property value="jobcarddocno"/>'>
                <input type="hidden" name="invno" id="invno" value='<s:property value="invno"/>'>
            </div>

        </div>
    </div>

    <!-- ================= RIGHT PANEL (WORKSPACE GRIDS) ================= -->
    <div class="main-content-wrapper">
        
        <!-- Horizontally Aligned Heading Toolbar -->
        <div class="top-toolbar-container">
            <jsp:include page="../../heading.jsp"></jsp:include>
        </div>

        <div class="scrollable-grid-area">
            <div id="imgdiv" style="position:absolute; z-index: 1; top:200px; right:600px;">
                <img id="imgloading" alt="" src="../../../../icons/29load.gif"/>
            </div>
            
            <div id="amountgriddiv">
                <jsp:include page="amountGrid.jsp"></jsp:include>
            </div>
        </div>

    </div>

</div>

</div>
</div>
</form>
</body>
</html>