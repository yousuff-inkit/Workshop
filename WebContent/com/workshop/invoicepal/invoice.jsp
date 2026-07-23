<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>

<jsp:include page="../../../includes.jsp"></jsp:include>
<link href="../../../../vendors/select2/css/select2.min.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="../../../../vendors/select2/js/select2.min.js"></script>

<style>
/* =========================================================
SCOPED UI: Modern Layout (Plain White & Monochrome)
========================================================= */
body {
    background: #ffffff;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    color: #222;
    margin: 0;
    padding: 24px 0;
    box-sizing: border-box;
    overflow-y: auto !important;
}

#mainBG {
    background: #ffffff;
    border-radius: 16px;
    padding: 15px;
    max-width: 100%;
    margin: 0 auto;
    border: 1px solid #e2e8f0;
    box-shadow: none;
}

.modern-ui {
    font-family: Arial, sans-serif; 
    color: #333;
    font-size: 12px; 
    padding: 5px 15px;
    box-sizing: border-box;
    width: 100%;
}

/* Master Input Heights - Forced to 24px */
.modern-ui input[type="text"],
.modern-ui input[type="email"],
.modern-ui select { 
    height: 24px !important; 
    border: 1px solid #cbd5e1; 
    border-radius: 3px; 
    padding: 2px 6px;
    font-size: 12px;
    box-sizing: border-box; 
    background-color: #fff; 
    color: #333;
    width: 100%;
}

.modern-ui input[type="text"]:focus,
.modern-ui input[type="email"]:focus,
.modern-ui select:focus { 
    border-color: #64748b; 
    outline: none;
}

.modern-ui input[readonly],
.modern-ui input:disabled,
.modern-ui select:disabled,
.readonly { 
    background-color: #f8f9fa !important; 
    color: #6b7280;
}

.modern-ui input[type="checkbox"] {
    width: 14px !important;
    height: 14px !important;
    margin: 0;
    cursor: pointer;
}

/* Select2 overrides for 24px height */
.select2-container--default .select2-selection--single {
    height: 24px !important;
    border: 1px solid #cbd5e1 !important;
    border-radius: 3px !important;
}
.select2-container--default .select2-selection--single .select2-selection__rendered {
    line-height: 22px !important;
    font-size: 12px !important;
    padding-left: 6px !important;
    color: #333 !important;
}
.select2-container--default .select2-selection--single .select2-selection__arrow {
    height: 22px !important;
}

/* Layout Utilities - Tightened Spacing */
.modern-ui .field-row { 
    display: flex;
    align-items: center; 
    gap: 8px;
    margin-bottom: 10px; 
    flex-wrap: wrap;
    justify-content: flex-start;
}

.modern-ui .lbl-right { 
    text-align: right; 
    color: #444;
    font-size: 12px; 
    font-weight: bold;
    white-space: nowrap; 
    padding-right: 5px;
}

/* Middle Section Panels - Plain White */
.modern-ui .middle-panel {
    border: 1px solid #e2e8f0; 
    padding: 18px 10px 10px 10px; 
    background: #ffffff; 
    position: relative; 
    border-radius: 4px; 
    margin-bottom: 12px;
    margin-top: 12px;
}

.modern-ui .middle-panel-title { 
    position: absolute; 
    top: -12px;
    left: 10px; 
    background: #ffffff; 
    padding: 0 8px; 
    color: #333333;
    font-weight: bold; 
    font-size: 13px; 
    border-left: 3px solid #333333;
    z-index: 2; 
    line-height: normal; 
    display: flex;
    align-items: center;
}

/* Custom UI Buttons matching 24px height - Monochrome */
.modern-ui .myButton,
.modern-ui input[type="button"] {
    height: 24px !important;
    line-height: 22px !important;
    padding: 0 12px;
    font-family: Arial, sans-serif;
    font-size: 11px;
    font-weight: bold;
    border-radius: 3px;
    cursor: pointer;
    text-shadow: none;
    transition: all 0.2s;
    box-shadow: 0 1px 2px rgba(0,0,0,0.05);
    border: 1px solid #cbd5e1;
    background: #f8fafc;
    color: #0f172a;
    white-space: nowrap;
    display: inline-flex;
    align-items: center;
    justify-content: center;
}
.modern-ui .myButton:hover,
.modern-ui input[type="button"]:hover { 
    background: #e2e8f0; 
}

/* Search Icon Wrapper */
.modern-ui .input-search-container {
    position: relative;
    display: flex;
}
.modern-ui .input-search-container input {
    padding-right: 25px !important;
}
.modern-ui .magnifier-icon {
    position: absolute;
    right: 6px; 
    top: 50%;
    transform: translateY(-50%);
    cursor: pointer;
    color: #64748b; 
    z-index: 10;
}
.modern-ui .magnifier-icon:hover { color: #333; }

/* Scrollbar Logic */
.hidden-scrollbar {
    overflow-x: hidden;
    overflow-y: auto;
    height: calc(100vh - 120px);
    padding-right: 5px;
}
.hidden-scrollbar::-webkit-scrollbar { width: 6px; }
.hidden-scrollbar::-webkit-scrollbar-thumb { background: #c5d3e0; border-radius: 3px; }

form label.error { color: #dc2626; font-weight:bold; }
#errormsg { color: #dc2626; font-weight:bold; text-align:center; margin-bottom: 10px; }
</style>

<script>

$(document).ready(function() {
    $("#date").jqxDateTimeInput({  width:'100%', height: 24, formatString : "dd.MM.yyyy", theme: 'energyblue' });
    
    /* force internal alignment AFTER render */
    setTimeout(function () {
         $("#date").find("input").css({
             "margin-top": "0px",
             "line-height": "24px",
             "font-size": "12px", 
             "font-family": "Arial, sans-serif", 
             "padding": "0 6px", 
             "box-sizing":"border-box"
         });
         $("#date").find(".jqx-action-button").css({
             "top": "0px",
             "height": "24px"
         });
    }, 0);
    
    $('#searchWindow').jqxWindow({width: '50%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
    $('#searchWindow').jqxWindow('close');
    $('#printWindow').jqxWindow({width: '51%', height: '28%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Print',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
    $('#printWindow').jqxWindow('close'); 
    $('#mailWindow').jqxWindow({width: '51%', height: '28%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Send Mail',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
    $('#mailWindow').jqxWindow('close'); 
    $("#refno").dblclick(function(){
        var reftype = $("#cmbreftype").val();
        if(reftype=="JC"){
             searchContent("jobCardSearch.jsp?reftype="+reftype);
        }
    });
    $("#excessamountaccount").dblclick(function(){
        searchContent("accountSearchGrid.jsp?id=1");
    });
    
    $( "#total,#excessamount,#discount,#taxpercent" ).on('change blur',function() {
        if($('#mode').val()=='A' || $('#mode').val()=='E'){
            var total=parseFloat($('#total').val());
            var excess=parseFloat($('#excessamount').val());
            var discount=parseFloat($('#discount').val());
            var nettotal=(total)-discount;
            $('#nettotal').val(nettotal);
            var taxpercent=parseFloat($('#taxpercent').val());
            var taxvalue=taxpercent/100;
            var taxamount=nettotal*taxvalue;
            taxamount=funCustomRound(taxamount);
            $('#taxamount').val(taxamount);
            var taxtotal=parseFloat(taxamount)+parseFloat(nettotal);
            taxtotal=funCustomRound(taxtotal);
            $('#taxtotal').val(taxtotal);
        }
        
    });
    setSaperateInvoice();
    getDocDateConfig();
    if($('#discount').val()=="" || isNaN($('#discount').val())){
            $('#discount').val(0);
        }
        if($('#total').val()=="" || isNaN($('#total').val())){
            $('#total').val(0);
        }
        if($('#excessamount').val()=="" || isNaN($('#excessamount').val())){
            $('#excessamount').val(0);
        }
        if($('#nettotal').val()=="" || isNaN($('#nettotal').val())){
            $('#nettotal').val(0);
        }
        if($('#taxpercent').val()=="" || isNaN($('#taxpercent').val())){
            $('#taxpercent').val(0);
        }
        if($('#taxamount').val()=="" || isNaN($('#taxamount').val())){
            $('#taxamount').val(0);
        }
        if($('#taxtotal').val()=="" || isNaN($('#taxtotal').val())){
            $('#taxtotal').val(0);
        }
        if($('#roundamt').val()=="" || isNaN($('#roundamt').val())){
            $('#roundamt').val(0);
        }
});

function searchContent(url) {
    $('#searchWindow').jqxWindow('open');
    $.get(url).done(function (data) {
    $('#searchWindow').jqxWindow('setContent', data);
    $('#searchWindow').jqxWindow('bringToFront');
}); 
}

function funrefno(){
    if((document.getElementById('cmbreftype').value=="")||(document.getElementById('cmbreftype').value=="DIR"))
     {
        $("#refno").attr('disabled',true);
        $("#refno").attr('readonly',true);
     }
    else{
        $("#refno").attr('disabled',false);
        $("#refno").attr('readonly',true);
    }
    
}
function invoicePrintContent(url) {
    $('#printWindow').jqxWindow('open');
    $.get(url).done(function (data) {
    $('#printWindow').jqxWindow('setContent', data);
    $('#printWindow').jqxWindow('bringToFront');
}); 
}

function invoiceMailContent(url) {
    $('#mailWindow').jqxWindow('open');
    $.get(url).done(function (data) {
        $('#mailWindow').jqxWindow('setContent', data);
        $('#mailWindow').jqxWindow('bringToFront');
    }); 
}
function getRefno(event){
    var x= event.keyCode;
    var reftype = $("#cmbreftype").val();
    if(x==114){
        if(reftype=="JC"){
            searchContent("jobCardSearch.jsp?reftype="+reftype);
        }
    }
}
function getAccount(event){
    var x= event.keyCode;
    if(x==114){
        searchContent("accountSearchGrid.jsp?id=1");
    }
}



function funSearchLoad(){
    changeContent('masterSearch.jsp', $('#window'));
}

function funReadOnly(){
    $('#frmWSInvoicepal input').attr('readonly', true);
    $('#frmWSInvoicepal select').attr('disabled', true);
    $('#refno').attr('disabled',true);
    
}

function funRemoveReadOnly(){
    $('#frmWSInvoicepal input').attr('readonly', false);
    $('#frmWSInvoicepal select').attr('disabled', false);
    $('#vocno').attr('readonly',true);
    $('#refno').attr('disabled',true);
    if($('#mode').val()=="A"){
        $('#invoiceGrid,#invoiceDetailGrid').jqxGrid('clear');
        $('#date').jqxDateTimeInput('setDate',new Date());
        setSaperateInvoice();
        getDocDateConfig();
    }
    if($('#mode').val()=="A" || $('#mode').val()=="E"){
        $('#invoiceGrid').jqxGrid('addrow',null,{});
        if($('#discount').val()=="" || isNaN($('#discount').val())){
            $('#discount').val(0);
        }
        if($('#total').val()=="" || isNaN($('#total').val())){
            $('#total').val(0);
        }
        if($('#excessamount').val()=="" || isNaN($('#excessamount').val())){
            $('#excessamount').val(0);
        }
        if($('#nettotal').val()=="" || isNaN($('#nettotal').val())){
            $('#nettotal').val(0);
        }
        if($('#taxpercent').val()=="" || isNaN($('#taxpercent').val())){
            $('#taxpercent').val(0);
        }
        if($('#taxamount').val()=="" || isNaN($('#taxamount').val())){
            $('#taxamount').val(0);
        }
        if($('#taxtotal').val()=="" || isNaN($('#taxtotal').val())){
            $('#taxtotal').val(0);
        }
        if($('#roundamt').val()=="" || isNaN($('#roundamt').val())){
            $('#roundamt').val(0);
        }
    }
    if($('#mode').val()=='E'){
        $('#excessamount').attr('disabled',true);
    }
    getDocDateConfig();
}

function setValues(){
    if($('#msg').val()!=''){
        $.messager.alert('Message',$('#msg').val());
    }
    if(document.getElementById("formdet")) {
        document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
    }
    funSetlabel();
    if($('#docno').val()!=''){
        $('#invoicediv').load('invoiceGrid.jsp?docno='+$('#docno').val()+'&id=1');
        $('#detaildiv').load('detailGrid.jsp?jobcarddocno='+$('#hidrefno').val()+'&id=1&docno='+$('#docno').val());
        if(document.getElementById("hidchksaperateinvoice").value=="1"){
            document.getElementById("chksaperateinvoice").checked=true;
        }
        else{
            document.getElementById("chksaperateinvoice").checked=false;
        }
        var docno=$('#docno').val();
        $.get('getLogDetails.jsp',{'docno':docno},function(data){
            data=JSON.parse(data);
            document.getElementById("errormsg").innerText=data.msg;
        });
    }
    if($('#hidcmbreftype').val()!=''){
        $('#cmbreftype').val($('#hidcmbreftype').val());
    }
}

function funFocus()
{
    document.getElementById("cmbreftype").focus();
}

function funNotify(){
    var docdateval=funDateInPeriod($('#date').jqxDateTimeInput('getDate'));
    if(docdateval==0){
        $('#date').jqxDateTimeInput('focus');
        return 0;
    }
    var docdateconfig=$('#docdateconfig').val();
    if(docdateconfig=="1"){
        var currentdate=new Date();
        currentdate.setHours(0,0,0,0);
        var docdate=new Date($('#date').jqxDateTimeInput('getDate'));
        docdate.setHours(0,0,0,0);
        if(currentdate.getTime()!=docdate.getTime() && $('#mode').val()=='A'){
            $.messager.alert('Warning','Document Date should be Current Date');
            $('#date').jqxDateTimeInput('focus');
            return 0;
        }
        else{
            
        }
    }
    if(document.getElementById("cmbreftype").value==""){
        document.getElementById("errormsg").innerText="";
        document.getElementById("errormsg").innerText="Ref Type is Mandatory";
         return 0;
    }
     if(document.getElementById("refno").value==""){
         document.getElementById("errormsg").innerText="";
        document.getElementById("errormsg").innerText="Ref No is Mandatory";
        return 0;
    }
    if(parseFloat($('#total').val())<parseFloat($('#esttotal').val()) && $('#esttotal').val()!=""){
            $.messager.alert('Warning','Cannot be less than estimated total');
            return 0;
        }
    var rows = $("#invoiceGrid").jqxGrid('getrows');
    var gridlength=0;
    for(var i=0;i<rows.length;i++){
        if(rows[i].amount!="" && rows[i].amount!=null && rows[i].amount!="undefined" && typeof(rows[i].amount)!="undefined"){
            gridlength++;
            newTextBox = $(document.createElement("input"))
            .attr("type", "hidden")
            .attr("id", "invoicearray"+i)
            .attr("name", "invoicearray"+i);
                
            newTextBox.val(rows[i].desc1+"::"+rows[i].amount);
            
            newTextBox.appendTo('form');
            
        }
    }
    $('#gridlength').val(gridlength);
    if($('#mode').val()=='E'){
        $('#refno,#excessamount').attr('disabled',false);
    }
    return 1;
}
function isNumber(evt,id) {
    //Function to restrict characters and enter number only
          var iKeyCode = (evt.which) ? evt.which : evt.keyCode
        if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57))
         {
             $.messager.alert('Warning','Enter Numbers Only');
           $("#"+id+"").focus();
            return false;
            
         }
        
        return true;
    }
function getTax(cldocno,date,hidrefno){
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            items = x.responseText.trim();
            $('#taxpercent').val(items);
            $('#taxpercent,#taxamount').attr('readonly',true);
        } else {
        }
    }
    x.open("GET", "getTax.jsp?cldocno="+cldocno+"&date="+date+"&hidrefno="+hidrefno, true);
    x.send();
}

function funPrintBtn(){
     if($('#docno').val()!='' && $('#docno').val()!='0'){  
         getBulkConfig();    
         invoicePrintContent('printVoucherWindow.jsp');         
     }
}
function funSendmail(){
    if($('#docno').val()!='' && $('#docno').val()!='0'){  
         getBulkConfig();    
         invoiceMailContent('mailVoucherWindow.jsp');           
     }
}
function funCustomRound(value){
    var res=parseFloat(value).toFixed(window.parent.amtdec.value);
    var res1=(res=='NaN'?"0":res);
    return res1;  
}

function setSaperateInvoice(){
    if(document.getElementById("chksaperateinvoice").checked==true){
        document.getElementById("hidchksaperateinvoice").value="1";
    }
    else{
        document.getElementById("hidchksaperateinvoice").value="0";
    }
}


function getDocDateConfig(){
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            items = x.responseText.trim();
            $('#docdateconfig').val(items);
        } else {
        }
    }
    x.open("GET", "getDocDateConfig.jsp", true);
    x.send();
}

function getBulkConfig(){ 
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            items = x.responseText.trim();
            $('#bulkconfig').val(items);   
        } else {
        }
    }
    x.open("GET", "getPrintBulkConfig.jsp", true);
    x.send();
}
</script>
</head>

<body onload="funReadOnly();setValues();getBulkConfig();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmWSInvoicepal" action="saveWSInvoicepal" autocomplete="off" class="form-inline">
<jsp:include page="../../../header.jsp" />

<div class="modern-ui hidden-scrollbar">
    <div id="errormsg"></div>

    <!-- Top Header info -->
    <div class="middle-panel">
        <span class="middle-panel-title">Invoice Details</span>
        
        <div class="field-row">
            <label class="lbl-right" style="width:80px;">Date</label>
            <div style="flex:1; max-width:125px;">
                <div id="date" name="date" value='<s:property value="date"/>'></div>
            </div>
            
            <label class="lbl-right" style="width:80px; margin-left:auto;">Doc No</label>
            <input type="text" name="vocno" id="vocno" value='<s:property value="vocno"/>' readonly tabindex="-1" class="readonly" style="width:120px;">
        </div>

        <div class="field-row">
            <label class="lbl-right" style="width:80px;">Ref Type</label>
            <select name="cmbreftype" id="cmbreftype" onchange="funrefno();" value='<s:property value="cmbreftype"/>' style="width:100px;">
                <option value="">--Select--</option>
                <option value="DIR">DIR</option>
                <option value="JC">Job Card</option>
            </select>
            
            <label class="lbl-right" style="width:60px; margin-left:15px;">Ref No</label>
            <div class="input-search-container" style="flex:1; max-width:150px;">
                <input name="refno" type="text" id="refno" placeholder="Press F3" onkeydown="getRefno(event);" value='<s:property value="refno"/>'>
                <svg class="magnifier-icon" onclick="$('#refno').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
            </div>
            
            <label style="display:none; align-items:center; gap:5px; margin-left:15px; font-weight:bold; font-size:12px; color:#444; cursor:pointer;">
                <input type="checkbox" name="chksaperateinvoice" id="chksaperateinvoice" onChange="setSaperateInvoice();"> Saperate Invoice
            </label>
            <input name="hidchksaperateinvoice" type="hidden" id="hidchksaperateinvoice" value='<s:property value="hidchksaperateinvoice"/>'>
            <input name="hidrefno" type="hidden" id="hidrefno" value='<s:property value="hidrefno"/>'>
        </div>

        <div class="field-row">
            <label class="lbl-right" style="width:80px;">Vehicle</label>
            <input type="text" name="regno" id="regno" value='<s:property value="regno"/>' style="width:100px;" readonly class="readonly">
            
            <label class="lbl-right" style="width:60px; margin-left:15px;">Details</label>
            <input name="vehicledetails" type="text" id="vehicledetails" value='<s:property value="vehicledetails"/>' style="flex:1;" readonly class="readonly">
        </div>

        <div class="field-row">
            <label class="lbl-right" style="width:80px;">Client</label>
            <input type="text" name="cldocno" id="cldocno" value='<s:property value="cldocno"/>' style="width:100px;" readonly class="readonly">
            
            <label class="lbl-right" style="width:60px; margin-left:15px;">Details</label>
            <input name="userdetails" type="text" id="userdetails" value='<s:property value="userdetails"/>' style="flex:1;" readonly class="readonly">
        </div>

        <div class="field-row">
            <label class="lbl-right" style="width:80px;">Inv. Account</label>
            <input type="text" name="tempinvoicetoaccount" id="tempinvoicetoaccount" value='<s:property value="tempinvoicetoaccount"/>' style="width:100px;" readonly class="readonly">
            
            <label class="lbl-right" style="width:60px; margin-left:15px;">Acc. Name</label>
            <input type="text" name="tempinvoicetoacname" id="tempinvoicetoacname" value='<s:property value="tempinvoicetoacname"/>' style="flex:1;" readonly class="readonly">
        </div>
        
        <input type="text" name="tempinvoicetoacno" id="tempinvoicetoacno" value='<s:property value="tempinvoicetoacno"/>' readonly hidden="true">
        <input type="text" name="invoicetoaccount" id="invoicetoaccount" value='<s:property value="invoicetoaccount"/>' readonly hidden="true">
        <input type="text" name="invoicetoacname" id="invoicetoacname" value='<s:property value="invoicetoacname"/>' readonly hidden="true">

        <div class="field-row" style="margin-bottom:0;">
            <label class="lbl-right" style="width:80px;">Remarks</label>
            <input type="text" name="remarks" id="remarks" value='<s:property value="remarks"/>' style="flex:1;">
        </div>
    </div>

    <!-- Invoice Grid and Calculations -->
    <div class="middle-panel">
        <span class="middle-panel-title">Invoice Items</span>
        <div id="invoicediv">
            <jsp:include page="invoiceGrid.jsp"></jsp:include>
        </div>
        
        <div class="field-row" style="margin-top:15px; justify-content: flex-end;">
            <label class="lbl-right">Total</label>
            <input type="text" name="total" id="total" value='<s:property value="total"/>' style="width:100px; text-align:right;" onKeyPress="javascript:return isNumber (event,id)" onBlur="funRoundAmt(value,id);">
            
            <label class="lbl-right" style="margin-left:15px;">Discount</label>
            <input type="text" name="discount" id="discount" value='<s:property value="discount"/>' style="width:100px; text-align:right;" onKeyPress="javascript:return isNumber (event,id)" onBlur="funRoundAmt(value,id);">
            
            <label class="lbl-right" style="margin-left:15px;">Sub Total</label>
            <input type="text" name="nettotal" id="nettotal" value='<s:property value="nettotal"/>' style="width:120px; text-align:right;" onKeyPress="javascript:return isNumber (event,id)" onBlur="funRoundAmt(value,id);">
            
            <label class="lbl-right" style="margin-left:15px;">Excess Amt</label>
            <input type="text" name="excessamount" id="excessamount" value='<s:property value="excessamount"/>' style="width:100px; text-align:right;" onKeyPress="javascript:return isNumber (event,id)" onBlur="funRoundAmt(value,id);">
        </div>
        
        <div class="field-row" style="margin-bottom:0; justify-content: flex-end;">
            <label class="lbl-right">Tax %</label>
            <input type="text" name="taxpercent" id="taxpercent" value='<s:property value="taxpercent"/>' style="width:100px; text-align:right;" onKeyPress="javascript:return isNumber (event,id)" >
            
            <label class="lbl-right" style="margin-left:15px;">Tax Amount</label>
            <input type="text" name="taxamount" id="taxamount" value='<s:property value="taxamount"/>' style="width:100px; text-align:right;" onKeyPress="javascript:return isNumber (event,id)" onBlur="funRoundAmt(value,id);">
            
            <label class="lbl-right" style="margin-left:15px;">Total (Incl. Tax)</label>
            <input type="text" name="taxtotal" id="taxtotal" value='<s:property value="taxtotal"/>' style="width:120px; text-align:right;" onKeyPress="javascript:return isNumber (event,id)" onBlur="funRoundAmt(value,id);">
            
            <label class="lbl-right" style="margin-left:15px;">Round Off</label>
            <input type="text" name="roundamt" id="roundamt" value='<s:property value="roundamt"/>' style="width:100px; text-align:right;" onKeyPress="javascript:return isNumber (event,id)" onBlur="funRoundAmt(value,id);">
        </div>
    </div>

    <!-- Invoice Detail Grid -->
    <div class="middle-panel" style="margin-bottom:0;">
        <span class="middle-panel-title">Details</span>
        <div id="detaildiv">
            <jsp:include page="detailGrid.jsp"></jsp:include>
        </div>
    </div>

    <!-- Hidden Properties -->
    <div style="display:none;">
        <input type="hidden" id="insuracno" name="insuracno" value='<s:property value="insuracno"/>'>
        <input type="hidden" id="clientacno" name="clientacno" value='<s:property value="clientacno"/>'>
        <input type="hidden" id="docno" name="docno" value='<s:property value="docno"/>'>
        <input type="hidden" id="invoicetoacno" name="invoicetoacno" value='<s:property value="invoicetoacno"/>' >
        <input type="hidden" id="excessamountacno" name="excessamountacno" value='<s:property value="excessamountacno"/>'>  
        <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>
        <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
        <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
        <input type="hidden" name="esttotal" id="esttotal" value='<s:property value="esttotal"/>'>
        <input type="hidden" name="gridlength" id="gridlength" value='<s:property value="gridlength"/>'>
        <input type="hidden" name="hidcmbreftype" id="hidcmbreftype" value='<s:property value="hidcmbreftype"/>'/>
        <input type="hidden" name="docdateconfig" id="docdateconfig" value='<s:property value="docdateconfig"/>'/>
        <input type="hidden" name="bulkconfig" id="bulkconfig" value='<s:property value="bulkconfig"/>'/> 
    </div>
</div>
</form>

<div id="searchWindow">
    <div></div>
</div> 
<div id="printWindow">
    <div></div>
</div>
<div id="mailWindow">
    <div></div>
</div>

</body>
</html>