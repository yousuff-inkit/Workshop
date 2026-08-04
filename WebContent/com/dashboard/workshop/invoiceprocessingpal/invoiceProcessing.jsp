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
    width: 250px; 
    flex: 0 0 250px; 
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
    white-space: nowrap;
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

/* Select specific styling */
select {
    padding: 2px 24px 2px 8px !important; 
    font-family: inherit;
    cursor: pointer;
    appearance: none;
    -webkit-appearance: none;
    background-image: url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' stroke='%234e5e71' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3e%3cpolyline points='6 9 12 15 18 9'%3e%3c/polyline%3e%3c/svg%3e");
    background-repeat: no-repeat;
    background-position: right 6px center;
    background-size: 12px;
}

/* jqx Date Container Mapping Rules */
.filter-table div[id^="periodupto"],
.filter-table div[id^="podate"] {
    width: 100%;
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

/* Image Buttons specific to Calculation row */
.img-action-btn {
    background: transparent;
    border: none;
    cursor: pointer;
    padding: 2px 5px;
    vertical-align: middle;
}

.img-action-btn img {
    width: 24px;
    height: 24px;
    transition: transform 0.2s ease;
}

.img-action-btn:hover img {
    transform: scale(1.1);
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
}

/* Vertical spacing for stacked grids */
.grid-stack-container {
    margin-bottom: 15px;
}

/* Internal Calculation Form Grid */
.calc-grid-table {
    width: 100%;
    border-spacing: 5px;
}
.calc-grid-table td {
    padding: 2px;
}</style>
<script type="text/javascript">

$(document).ready(function () {
	$.get("getInitData.jsp", function(data){
    	data=JSON.parse(data);
    	$('#insurtypeconfig').val(data.insurtypeconfig);
		//$('#insurtypeconfig').val(data.trim());
    	//alert(data);
    	if($('#insurtypeconfig').val()=='1'){
    		$('.insurtypetd').show();
    	}
    	else{
    		$('.insurtypetd').hide();
    	}
  	});
	$('.insurtypetd').hide();
	$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
	$("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200;right:600;'><img src='../../../../icons/31load.gif'/></div>");    
	$("#periodupto").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	$("#podate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	$('#insurtypewindow').jqxWindow({ width: '60%', height: '55%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Insurance Type Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
    $('#insurtypewindow').jqxWindow('close');
    $('#printWindow').jqxWindow({width: '51%', height: '28%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Print',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	$('#printWindow').jqxWindow('close');
	$('#chkmultiple').trigger('click');
	setMultiple();
	$('#periodupto').on('change', function (event) 
	{  
		var docdateval=funDateInPeriod($('#periodupto').jqxDateTimeInput('getDate'));
		if(docdateval==0){
			$('#periodupto').jqxDateTimeInput('focus');
			return false;
		}
	});
	$('#btninvsave').click(function(){
		var rowsCount = $('#amountGrid').jqxGrid('getrows').length;
    	for(var i=0;i<rowsCount;i++){
    		var invno=parseInt($('#amountGrid').jqxGrid('getcellvalue',i,'invno'));
    		/* var billtoacno=parseInt($('#amountGrid').jqxGrid('getcellvalue',i,'billtoacno'));
    		if(billtoacno==""){
    			$.messager.alert('Warning','Select Bill To');
    			return 0;
    		} */
    		if(invno>0){
    			$.messager.alert('Warning','Invoice Generated , Changes Restricted');
    			return 0;
		    }
    		
    	}
		var jobcarddocno=$('#jobcarddocno').val();
		var chkmultiple=$('#hidchkmultiple').val();
		var excess=$('#excess').val();
		var claimno=$('#claimno').val();
		var pono=$('#pono').val();
		var podate=$('#podate').jqxDateTimeInput('val');
		var vattype=$('#cmbvattype').val();
		var rows=$('#estimationGrid').jqxGrid('getrows');
		for(var j=0;j<rows.length;j++){
			var insurtype=$('#estimationGrid').jqxGrid('getcellvalue',j,'insurtypedocno');
			//alert(insurtype);
			if(insurtype=="" || insurtype=="undefined" || insurtype==null || typeof(insurtype)=="undefined"){
				$.messager.alert('Warning','Select Insurance Type');
    			return 0;
			}
		}
		var estarray=new Array();
		for(var i=0;i<rows.length;i++){
			var arrestno=$('#estimationGrid').jqxGrid('getcellvalue',i,'estno');
			var arrlabourtotal=$('#estimationGrid').jqxGrid('getcellvalue',i,'labourtotal');
			var arrsparetotal=$('#estimationGrid').jqxGrid('getcellvalue',i,'sparetotal');
			var arrnettotal=$('#estimationGrid').jqxGrid('getcellvalue',i,'nettotal');
			var arrchkclaim=$('#estimationGrid').jqxGrid('getcellvalue',i,'chkclaim');
			var arrclaimno=$('#estimationGrid').jqxGrid('getcellvalue',i,'claimno');
			var arrexcess=$('#estimationGrid').jqxGrid('getcellvalue',i,'excess');
			var arrpono=$('#estimationGrid').jqxGrid('getcellvalue',i,'pono');
			var arrpodate=$('#estimationGrid').jqxGrid('getcelltext',i,'podate');
			var arrvattype=$('#estimationGrid').jqxGrid('getcellvalue',i,'vattype');
			var addition=$('#estimationGrid').jqxGrid('getcellvalue',i,'addition');
			var insurtypedocno=$('#estimationGrid').jqxGrid('getcellvalue',i,'insurtypedocno');
			if(arrestno!="" && arrestno!="undefined" && arrestno!=null && typeof(arrestno)!="undefined"){
				estarray.push(arrestno+"::"+arrlabourtotal+"::"+arrsparetotal+"::"+arrnettotal+"::"+arrchkclaim+"::"+arrclaimno+"::"+arrexcess+"::"+arrpono+"::"+arrpodate+"::"+arrvattype+"::"+addition+"::"+insurtypedocno);
			}
		}
		// alert(jobcarddocno+"::"+chkmultiple+"::"+excess+"::"+claimno+"::"+pono+"::"+vattype);
		saveEstDataAJAX(jobcarddocno,chkmultiple,excess,claimno,pono,podate,vattype,estarray);
	});
	
	$('#btninvcalculate').click(function(){
		var rowsCount = $('#amountGrid').jqxGrid('getrows').length;
		for(var i=0;i<rowsCount;i++){
    		var invno=parseInt($('#amountGrid').jqxGrid('getcellvalue',i,'invno'));
    		if(invno>0){
    			$.messager.alert('Warning','Invoice Generated , Changes Restricted');
    			return 0;
		    }
    	}
		var jobcarddocno=$('#jobcarddocno').val();
		calculateDataAJAX(jobcarddocno);
	});
	
	$('#btninvoiceconfirm').click(function(){
		var rowsCount = $('#amountGrid').jqxGrid('getrows').length;
		if(rowsCount>0){
			for(var i=0;i<rowsCount;i++){
	    		var invno=parseInt($('#amountGrid').jqxGrid('getcellvalue',i,'invno'));
	    		if(invno>0){
	    			
			    }
			    else{
			    	$.messager.alert('Warning','Invoice Not Generated , Confirmation Restricted');
	    			return false;
			    }
	    	}
	    	funConfirm();	
		}
		else{
			$.messager.alert('Warning','Invoice Not Generated , Confirmation Restricted');
	    	return false;
		}
		
	});
});

function insurtypeSearchContent(url) {
	$.get(url).done(function (data) {
    	$('#insurtypewindow').jqxWindow('setContent', data);
    }); 
}
function calculateDataAJAX(jobcarddocno){
	//alert(jobcarddocno);
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText.trim();
			if(items=="0"){
				$('#amountgriddiv').load('amountGrid.jsp?id=1&jobdocno='+jobcarddocno);	
			}
			else{
				$.messager.alert('Warning','Not Calculated');
			}
			
			} else {
			}
		}
		x.open("GET", "calculateAJAX.jsp?jobdocno="+jobcarddocno, true);
		x.send();
 }
 function saveEstDataAJAX(jobcarddocno,chkmultiple,excess,claimno,pono,podate,vattype,estarray){
	var cmbinsurtype=$('#cmbinsurtype').val();
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText.trim();
			if(items=="0"){
				$.messager.alert('Message','Saving Successfull,Please Calculate');
			}
			else{
				$.messager.alert('Warning','Not Saved');
				return false;
			}
			} else {
			}
		}
		x.open("GET", "saveEstDataAJAX.jsp?cmbinsurtype="+cmbinsurtype+"&jobcarddocno="+jobcarddocno+"&chkmultiple="+chkmultiple+"&excess="+excess+"&claimno="+claimno+"&pono="+pono+"&podate="+podate+"&vattype="+vattype+"&estarray="+estarray, true);
		x.send();
 }
function funreload(event)
{
	$('#amountGrid,#estimationGrid').jqxGrid('clear');
	/*if($('#chkmultiple').is(':checked')==true){
		$('#chkmultiple').trigger('click');
	}*/
	$('#excess').val("0.0");
	$('#claimno').val("");
	$('#pono').val("");
	$('#cmbvattype').val("");
	/*if(document.getElementById("cmbbranch").value=='a'){
		document.getElementById("cmbbranch").value="1";
		//return false;
	}*/
	if(document.getElementById("cmbbranch").value=="" || document.getElementById("cmbbranch").value=='a'){
		$.messager.alert('Warning','Please Select Branch');
		return false;
	}
	var dateval=funDateInPeriod($('#periodupto').jqxDateTimeInput('getDate'));
	if(dateval==1){
		$("#overlay, #PleaseWait").show();
		var branch=document.getElementById("cmbbranch").value;
		var date=$('#periodupto').jqxDateTimeInput('val');
		$("#invoiceprocessinggriddiv").load("invoiceProcessingGrid.jsp?branch="+branch+"&todate="+date+"&id=1");
	}
}

	function funNotify(){
		var jobcarddocno=$('#jobcarddocno').val();
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
		$.messager.confirm('Confirm', 'Do you want to generate invoice?', function(r){
			if (r){
				var invdate=$('#periodupto').jqxDateTimeInput('val');
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
					var remarks=$('#amountGrid').jqxGrid('getcellvalue',selectedrows[i],'remarks');
					var discountpercent=$('#amountGrid').jqxGrid('getcellvalue',selectedrows[i],'discountpercent');
					
					//alert(rowno+"::"+insurstatus+"::"+billtoacno+"::"+claimno+"::"+description+"::"+amount+"::"+discount+"::"+net+"::"+vat+"::"+total+"::"+excess+"::"+roundoff+"::"+netbill);
					invoicearray.push(rowno+" :: "+insurstatus+" :: "+billtoacno+" :: "+claimno+" :: "+description+" :: "+amount+" :: "+discount+" :: "+net+" :: "+vat+" :: "+total+" :: "+excess+" :: "+roundoff+" :: "+netbill+" :: "+remarks+" :: "+discountpercent);
				}
				var x = new XMLHttpRequest();
				x.onreadystatechange = function() {
					if (x.readyState == 4 && x.status == 200) {
						var items = x.responseText.trim();
						if(items.split("::")[0]=="0"){
							$.messager.alert('Message','Invoice No(s) '+items.split("::")[1]+' Generated');
							$('#amountgriddiv').load('amountGrid.jsp?id=1&jobdocno='+jobcarddocno);	
						}
						else{
							$.messager.alert('Message','Invoice Not Generated');
							return false;
						}
					} else {
					}
				}
				x.open("GET", "generateInv.jsp?invdate="+invdate+"&jobdocno="+jobcarddocno+"&invoicearray="+encodeURIComponent(invoicearray)+"&branch="+branch, true);
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
	
	function setMultiple(){
		$('#estimationGrid,#amountGrid').jqxGrid('clear');
		if(document.getElementById("chkmultiple").checked==true){
			document.getElementById("hidchkmultiple").value="1";
		}
		else{
			document.getElementById("hidchkmultiple").value="0";
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
			/*var url=document.URL;
	        var reurl=url.split("com");
	        var win= window.open(reurl[0]+"com/workshop/invoice/WSInvoicePrintAction.action?&docno="+document.getElementById("invno").value+"&header=1&branch="+invbrhid,"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
	        //alert(reurl[0]+"WSInvoicePrintAction.action?&docno="+document.getElementById("invno").value+"&header=1&branch="+invbrhid);
	        win.focus();*/
	        invoicePrintContent('printVoucherWindow.jsp'); 
		}
	}
	function invoicePrintContent(url) {
		$('#printWindow').jqxWindow('open');
		$.get(url).done(function (data) {
			$('#printWindow').jqxWindow('setContent', data);
			$('#printWindow').jqxWindow('bringToFront');
		}); 
	}
	function funMovetoJCC(){
		if($('#jobcarddocno').val()==''){
			$.messager.alert('Warning','Please Select a jobcard');
			return false;
		}
		$.get('checkInvoiced.jsp',{jobdocno:$('#jobcarddocno').val()},function(data, status){
			data=JSON.parse(data);
			if(parseInt(data.invstatus)<=0){
				$.messager.confirm('Confirm', 'Do you want to move back to Job Card Complete?', function(r){
					if (r){
						$.post('moveToJCC.jsp',{jobdocno:$('#jobcarddocno').val(),brhid:$('#cmbbranch').val()},function(maindata, mainstatus){
							maindata=JSON.parse(maindata);
							if(maindata.errorstatus=="0"){
								$.messager.alert('Message','Updated Successfully');
								funreload("");
							}
							else{
								$.messager.alert('Message','Not Updated');
								return false;
							}
						});			
					}
				});
			}
			else{
				$.messager.alert('Warning','Job Card Already Invoiced');
				return false;	
			}
		});
		//Checking JobCard is invoiced;
		
	}
</script>
</head>
<body onload="getBranch();setValues();">
<form id="frmWSInvoiceProcessing" action="saveWSInvoiceProcessing" method="post">
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
                        <td class="label-cell" style="width:70px;">Period Upto</td>
                        <td><div id="periodupto"></div></td>
                    </tr>
                </table>
            </div>

            <!-- Action Buttons Card -->
            <div class="filter-card">
                <input type="button" name="btninvoicesave" id="btninvoicesave" class="btn-submit" value="Generate" onclick="funNotify();">
                <input type="button" name="btninvoiceconfirm" id="btninvoiceconfirm" class="btn-submit" value="Confirm">
                <input type="button" name="btninvoiceprint" id="btninvoiceprint" class="btn-submit" value="Print" onclick="funPrint();">
                <input type="button" name="btnmovetojcc" id="btnmovetojcc" class="btn-submit" value="Move to JobCard" onclick="funMovetoJCC();">
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
                <input type="hidden" name="insurtypeconfig" id="insurtypeconfig" value='<s:property value="insurtypeconfig"/>'>
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
            
            <div id="imgdiv" style="position:absolute; z-index: 10; top:20px; right:40%;">
                <img id="imgloading" alt="" src="../../../../icons/29load.gif"/>
            </div>
            
            <div class="grid-stack-container">
                <div id="invoiceprocessinggriddiv"><jsp:include page="invoiceProcessingGrid.jsp"></jsp:include></div>
            </div>

            <!-- Intermediary Form Elements Row -->
            <div class="filter-card" style="margin-bottom: 15px;">
                <div style="margin-bottom: 10px; display:flex; align-items:center;">
                    <input type="checkbox" name="chkmultiple" id="chkmultiple" onchange="setMultiple();">
                    <label class="branch" style="margin-left: 5px; font-weight:600; font-size:12px;" for="chkmultiple">Multiple</label>
                </div>
                
                <div class="grid-stack-container">
                    <div id="estimationgriddiv"><jsp:include page="estimationGrid.jsp"></jsp:include></div>
                </div>

                <table class="calc-grid-table">
                    <tr>
                        <td align="right"><label class="branch">Excess</label></td>
                        <td><input type="text" name="excess" id="excess"></td>
                        <td align="right"><label class="branch">Claim No</label></td>
                        <td><input type="text" name="claimno" id="claimno"></td>
                        <td align="right"><label class="branch">PO No</label></td>
                        <td><input type="text" name="pono" id="pono"></td>
                        <td align="right"><label class="branch">PO Date</label></td>
                        <td><div id="podate"></div></td>
                    </tr>
                    <tr>
                        <td align="right"><label class="branch">VAT Type</label></td>
                        <td>
                            <select name="cmbvattype" id="cmbvattype">
                                <option value="">--Select--</option>
                                <option value="1">Shared</option>
                                <option value="2">Insur.Company</option>
                            </select>
                        </td>
                        <td class="insurtypetd" align="right"><label class="branch">Type</label></td>
                        <td class="insurtypetd">
                            <select name="cmbinsurtype" id="cmbinsurtype">
                                <option value="">--Select--</option>
                            </select>
                        </td>
                        <td colspan="4" align="right">
                            <button type="button" class="img-action-btn" id="btninvsave" name="btninvsave" title="Save">
                                <img src="../../../../icons/tarifsave.png"/>
                            </button>
                            <button type="button" class="img-action-btn" id="btninvcalculate" name="btninvcalculate" title="Calculate">
                                <img src="../../../../icons/btnbookreload.png"/>
                            </button>
                        </td>
                    </tr>
                </table>
            </div>

            <div class="grid-stack-container">
                <div id="amountgriddiv"><jsp:include page="amountGrid.jsp"></jsp:include></div>
            </div>

        </div>

    </div>

</div>

<!-- Popups Maintained Outside the Layout Flow -->
<div id="insurtypewindow">
   <div></div>
</div>
<div id="clientwindow">
    <div></div>
</div>
<div id="printWindow">
    <div></div>
</div>

</div>
</div>
</form>
</body>
</html>