<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<s:head/>

<meta name="viewport" content="width=device-width, initial-scale=1.0">
<jsp:include page="../../../../includes.jsp"></jsp:include>
<script type="text/javascript" src="<%=contextPath%>/js/ajaxfileupload.js"></script>

<style>
/* =========================================================
SCOPED UI: Modern Layout (Matches Client Master)
========================================================= */
body {
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    color: #222;
    margin: 0;
    padding: 24px 0;
    box-sizing: border-box;
    overflow-y: auto !important;
}

#mainBG {
    background: #fff;
    border-radius: 16px;
    padding: 15px;
    max-width: 100%;
    margin: 0 auto;
    box-shadow: 0 4px 24px rgba(0,0,0,0.06);
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
.modern-ui input[type="file"],
.modern-ui select { 
    height: 24px !important; 
    border: 1px solid #b8c6d8; 
    border-radius: 3px; 
    padding: 2px 6px;
    font-size: 12px;
    box-sizing: border-box; 
    background-color: #fff; 
    color: #333;
    width: 100%;
}

.modern-ui input[type="text"]:focus,
.modern-ui select:focus { 
    border-color: #007bff; 
    outline: none;
}

.modern-ui input[readonly],
.modern-ui input:disabled,
.modern-ui select:disabled { 
    background-color: #f8f9fa; 
    color: #6b7280;
}

.modern-ui input[type="checkbox"],
.modern-ui input[type="radio"] {
    width: 14px !important;
    height: 14px !important;
    margin: 0;
    cursor: pointer;
}

/* Layout Utilities */
.modern-ui .field-row { 
    display: flex;
    align-items: center; 
    gap: 8px;
    margin-bottom: 10px; 
    flex-wrap: wrap;
}

.modern-ui .lbl-right { 
    text-align: right; 
    color: #444;
    font-size: 12px; 
    font-weight: bold;
    white-space: nowrap; 
    padding-right: 5px;
}

/* Middle Section Panels */
.modern-ui .middle-panel {
    border: 1px solid #c5d3e0; 
    padding: 20px 10px 10px 10px; 
    background: #ffffff; 
    position: relative; 
    border-radius: 4px; 
    margin-bottom: 15px;
    margin-top: 12px;
}

.modern-ui .middle-panel-title { 
    position: absolute; 
    top: -12px;
    left: 10px; 
    background: #ffffff; 
    padding: 0 8px; 
    color: #0056b3;
    font-weight: bold; 
    font-size: 14px; 
    border-left: 3px solid #0056b3;
    z-index: 2; 
    line-height: normal; 
}

/* Custom UI Buttons matching 24px height */
.modern-ui .myButton {
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
    box-shadow: 0 1px 2px rgba(0,0,0,0.1);
    border: none;
    background: linear-gradient(135deg, #0b45a2 0%, #2563eb 100%);
    color: #ffffff;
    white-space: nowrap;
}
.modern-ui .myButton:hover { background: linear-gradient(135deg, #083a8a 0%, #1d4ed8 100%); }

/* Icon Button (Excel Import) */
.modern-ui .icon-button {
    background: none;
    border: none;
    cursor: pointer;
    padding: 0;
    margin: 0;
    display: inline-flex;
    align-items: center;
    justify-content: center;
}
.modern-ui .icon-button img {
    height: 24px;
    width: 24px;
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
.modern-ui .magnifier-icon:hover { color: #2563eb; }

/* Grid Wrappers */
.modern-ui .grid-container {
    border: 1px solid #c5d3e0;
    border-radius: 4px;
    background: #fff;
    overflow: hidden;
}

/* Scrollbar Logic */
.hidden-scrollbar {
    overflow-y: auto;
    height: calc(100vh - 120px);
    padding-right: 5px;
}
.hidden-scrollbar::-webkit-scrollbar { width: 6px; }
.hidden-scrollbar::-webkit-scrollbar-thumb { background: #c5d3e0; border-radius: 3px; }

form label.error { color:red; font-weight:bold; }
#errormsg { color:red; font-weight:bold; text-align:center; margin-bottom: 10px; }
</style>

<script type="text/javascript">
$(document).ready(function() {
    $("#btnvaluechange").hide();
    
    /* Formatted jqxDateTimeInput heights to match modern UI 24px */
    $("#jqxIbJournalVouchersDate").jqxDateTimeInput({ width: '125px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
    $("#maindate").jqxDateTimeInput({ width: '125px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
    
    /* force internal alignment AFTER render */
    setTimeout(function () {
        $("#jqxIbJournalVouchersDate, #maindate").find("input").css({
            "margin-top": "0px",
            "line-height": "24px",
            "font-size": "12px", 
            "font-family": "Arial, sans-serif", 
            "padding": "0 6px", 
            "box-sizing":"border-box"
        });
        $("#jqxIbJournalVouchersDate, #maindate").find(".jqx-action-button").css({
            "top": "0px",
            "height": "24px"
        });
    }, 0);

    var popupConfig = {height: '58%', maxHeight: '70%', maxWidth: '51%', title: 'Search', position: { x: 300, y: 87 }, theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27};
    $('#ibJournalVoucherGridWindow').jqxWindow($.extend({}, popupConfig, {width: '51%', title: 'Accounts Search'})).jqxWindow('close');
    $('#branchSearchWindow').jqxWindow($.extend({}, popupConfig, {width: '25%', maxWidth: '25%', title: 'Branch Search'})).jqxWindow('close');
    $('#costTypeSearchGridWindow').jqxWindow($.extend({}, popupConfig, {width: '25%', maxWidth: '25%', title: 'Cost Type Search', position: { x: 420, y: 87 }})).jqxWindow('close');
    $('#costCodeSearchWindow').jqxWindow($.extend({}, popupConfig, {width: '25%', maxWidth: '25%', title: 'Cost Code Search', position: { x: 420, y: 87 }})).jqxWindow('close');
    
    $('#jqxIbJournalVouchersDate').on('change', function (event) {
        var ibjournaldate = $('#jqxIbJournalVouchersDate').jqxDateTimeInput('getDate');
        funDateInPeriod(ibjournaldate);
    });
    
    $('#txtdescription').keydown(function (evt) {
        if (evt.keyCode==9) {
            evt.preventDefault();
            $('#jqxIbJournalVoucher').jqxGrid('selectcell',0, 'branch');
            $('#jqxIbJournalVoucher').jqxGrid('focus',0, 'branch');
        }
    });
});
	
function BranchSearchContent(url) {
    $('#branchSearchWindow').jqxWindow('open');
    $.get(url).done(function (data) {
        $('#branchSearchWindow').jqxWindow('setContent', data);
        $('#branchSearchWindow').jqxWindow('bringToFront');
    }); 
} 
	
function AccountSearchContent(url) {
    $('#ibJournalVoucherGridWindow').jqxWindow('open');
    $.get(url).done(function (data) {
        $('#ibJournalVoucherGridWindow').jqxWindow('setContent', data);
        $('#ibJournalVoucherGridWindow').jqxWindow('bringToFront');
    }); 
} 
	
function costTypeSearchContent(url) {
    $('#costTypeSearchGridWindow').jqxWindow('open');
    $.get(url).done(function (data) {
        $('#costTypeSearchGridWindow').jqxWindow('setContent', data);
        $('#costTypeSearchGridWindow').jqxWindow('bringToFront');
    }); 
}
	
function costCodeSearchContent(url) {
    $('#costCodeSearchWindow').jqxWindow('open');
    $.get(url).done(function (data) {
        $('#costCodeSearchWindow').jqxWindow('setContent', data);
        $('#costCodeSearchWindow').jqxWindow('bringToFront');
    }); 
}
	
function funwarningopen(){
    $.messager.confirm('Confirm', 'Transaction will affect Links to the applied Bank Reconcilations & Prepayments.', function(r){
        if (r){
            $("#mode").val("EDIT");
            $('#txtrefno').attr('readonly', false );
            $('#txtdescription').attr('readonly', false );
            $('#txtdrtotal').attr('readonly', true );
            $('#txtcrtotal').attr('readonly', true );
            $("#jqxIbJournalVoucher").jqxGrid({ disabled: false});
            $('#docno').attr('readonly', true);  
        }
    });
}
	
function funReadOnly(){
    $("#btnvaluechange").hide();
    $('#frmIbJournalVoucher input').attr('readonly', true );
    $('#jqxIbJournalVouchersDate').jqxDateTimeInput({disabled: true});
    $("#jqxIbJournalVoucher").jqxGrid({ disabled: true});
    $('#fileexcelimport').attr('hidden', true );
    $('#btnsearch').attr('hidden', true );
}

function funRemoveReadOnly(){
    $('#frmIbJournalVoucher input').attr('readonly', false );
    $('#txtdrtotal').attr('readonly', true );
    $('#txtcrtotal').attr('readonly', true );
    $('#jqxIbJournalVouchersDate').jqxDateTimeInput({disabled: false});
    $('#docno').attr('readonly', true);
    $("#jqxIbJournalVoucher").jqxGrid({ disabled: false}); 
    $('#fileexcelimport').attr('hidden', false );
    $('#btnsearch').attr('hidden', false );
    
    if ($("#mode").val() == "E") {
        $("#btnvaluechange").show();
        $('#frmIbJournalVoucher input').attr('readonly', true );
        $("#jqxIbJournalVoucher").jqxGrid({ disabled: true});
        $('#txtrefno').attr('readonly', false );
        $('#txtdescription').attr('readonly', false );
        $("#jqxIbJournalVoucher").jqxGrid('addrow', null, {});
        $('#fileexcelimport').attr('disabled', true );
        $('#btnsearch').attr('disabled', true );
    } else{
        $("#btnvaluechange").hide();
    }
    
    if ($("#mode").val() == "A") {
        document.getElementById("lblformposted").innerText="";
        $('#btnEdit').attr('disabled', false );
        $("#jqxIbJournalVoucher").jqxGrid('clear');
        $("#jqxIbJournalVoucher").jqxGrid('addrow', null, {});
    }
}
	 
function funSearchLoad(){
    changeContent('ijvMainSearch.jsp');  
}
	
function funChkButton() {}

function funFocus(){
    $('#jqxIbJournalVouchersDate').jqxDateTimeInput('focus'); 	    		
}
 
$(function(){
    $('#frmIbJournalVoucher').validate({
        rules: {
            txtdescription:{maxlength:500}
        },
        messages: {
            txtdescription: {maxlength:"    Max 500 chars"}
        }
    });
}); 
   
function funNotify(){	
    var ibjournaldate = $('#jqxIbJournalVouchersDate').jqxDateTimeInput('getDate');
    var validdate=funDateInPeriod(ibjournaldate);
    if(validdate==0){
        return 0;	
    }
    
    exceltypevalid=document.getElementById("txtexceltypevalidation").value;
    if(exceltypevalid!=0){
        document.getElementById("errormsg").innerText="Invalid Account-Type !!!";
        return 0;
    }
    
    excelaccvalid=document.getElementById("txtexcelaccvalidation").value;
    if(excelaccvalid!=0){
        document.getElementById("errormsg").innerText="Invalid Account !!!";
        return 0;
    }
    
    excelgrtypevalid=document.getElementById("txtexcelgrtypevalidation").value;
    if(excelgrtypevalid!=0){
        document.getElementById("errormsg").innerText="Invalid Cost-Type and Cost-Code !!!";
        return 0;
    }
    
    excelcostvalid=document.getElementById("txtexcelcostvalidation").value;
    if(excelcostvalid!=0){
        document.getElementById("errormsg").innerText="Invalid Cost-Type and Cost-Code !!!";
        return 0;
    }
    
    excelbranchvalid=document.getElementById("txtexcelbranchvalidation").value;
    if(excelbranchvalid!=0){
        document.getElementById("errormsg").innerText="Invalid Branch !!!";
        return 0;
    }
    
    valid=document.getElementById("txtvalidation").value;
    if(valid==1){
        document.getElementById("errormsg").innerText="Invalid Transaction !!!";
        return 0;
    }
  
    var drtot = document.getElementById("txtdrtotal").value;
    var crtot = document.getElementById("txtcrtotal").value;
    if(drtot>crtot || drtot<crtot){
        document.getElementById("errormsg").innerText="Invalid Transaction !!! Credit and Debit should be Equal.";
        return 0;
    }
    
    if(drtot=="" || crtot=="" || drtot=="NaN" || crtot=="NaN" || drtot==0 || crtot==0 || drtot==0.0 || crtot==0.0 || drtot==0.00 || crtot==0.00){
        document.getElementById("errormsg").innerText="Invalid Transaction !!! Credit and Debit should not be Zero.";
        return 0;
    }
    
    document.getElementById("errormsg").innerText="";
    
    var rows = $("#jqxIbJournalVoucher").jqxGrid('getrows');
    var length=0;
    for(var i=0 ; i < rows.length ; i++){
        var chk=rows[i].docno;
        if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){
            newTextBox = $(document.createElement("input"))
            .attr("type", "dil")
            .attr("id", "test"+i)
            .attr("name", "test"+i)
            .attr("hidden", "true");
            length=length+1;
            
            var amount,baseamount,id;
            if((rows[i].debit!=null) && (rows[i].debit!='undefined') && (rows[i].debit!='NaN') && (rows[i].debit!="") && (rows[i].debit!=0)){
                amount=rows[i].debit;
                baseamount=rows[i].baseamount;
                id=1;
            }
            if((rows[i].credit!=null) && (rows[i].credit!='undefined') &&  (rows[i].credit!='NaN') && (rows[i].credit!="") && (rows[i].credit!=0)){
                amount=rows[i].credit*-1;
                baseamount=rows[i].baseamount*-1;
                id=-1;
            }

            newTextBox.val(rows[i].docno+"::"+rows[i].description+"::"+rows[i].currencyid+"::"+rows[i].rate+"::"+amount+"::"+baseamount+"::"+id+":: "+rows[i].costtype+":: "+rows[i].costcode+"::"+rows[i].brhid);
            newTextBox.appendTo('form');
        }
    }
    $('#gridlength').val(length);
    return 1;
} 
  
function setValues(){
    if($('#hidjqxIbJournalVouchersDate').val()){
        $("#jqxIbJournalVouchersDate").jqxDateTimeInput('val', $('#hidjqxIbJournalVouchersDate').val());
    }
    
    if($('#hidmaindate').val()){
        $("#maindate").jqxDateTimeInput('val', $('#hidmaindate').val());
    }
    
    if($('#msg').val()!=""){
        $.messager.alert('Message',$('#msg').val());
    }
    
    document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
    funSetlabel();
    
    if(document.getElementById("lblformposted").innerText.trim()!=""){
        $('#btnEdit').attr('disabled', true );$('#btnDelete').attr('disabled', true );
    } else {
        $('#btnEdit').attr('disabled', false );$('#btnDelete').attr('disabled', false );
    }
    
    var indexVal = document.getElementById("docno").value;
    if(indexVal>0){
        var check = 1;
        $("#jqxJournalVoucherGrid").load("ibJournalVoucherGrid.jsp?txtjournalvouchersdocno2="+indexVal+"&check="+check); 
    }
}
  
function funPrintBtn() {
    if (($("#mode").val() == "view") && $("#docno").val()!="") {
        var url="";
        var reurl="";
        if ($("#msg").val().trim() == "") {
            url=document.URL;
            if( url.indexOf('saveIbJournalVoucher') >= 0){
                reurl=url.split("saveIbJournalVoucher");
            }else {
                reurl=url.split("ibJournalVoucher.jsp");
            }
        }else if ($("#msg").val().trim() != "") {
            url=document.URL;
            reurl=url.split("saveIbJournalVoucher");
        }
        $("#docno").prop("disabled", false);  
     
        $.messager.confirm('Confirm', 'Do you want to have header?', function(r){
            if (r){
                var win= window.open(reurl[0]+"printIbJournalVoucher?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
                win.focus();
            } else{
                var win= window.open(reurl[0]+"printIbJournalVoucher?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=0","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
                win.focus();
            }
        });
    } else {
        $.messager.alert('Message','Select a Document....!','warning');
        return;
    }
}
  
function datechange(){
    var date = $('#jqxIbJournalVouchersDate').jqxDateTimeInput('getDate');
    var validdate=funDateInPeriod(date);
    if(validdate==0){
        return 0;	
    }
    $("#maindate").jqxDateTimeInput('val', date);
}
  
function saveExcelDataData(docNo){
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200) {
            var items=x.responseText.trim();
            if(items==1){
                $("#jqxJournalVoucherGrid").load("ibJournalVoucherGrid.jsp?docNo="+docNo+'&date='+$('#maindate').val());
                $.messager.alert('Message', ' Successfully Imported.', function(r){
                });
            }
        }
    }
    x.open("GET","saveData.jsp?docNo="+docNo,true);
    x.send();
}

function getAttachDocumentNo(){
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200) {
            var items=x.responseText.trim();
            if(items>0){
                var path=document.getElementById("fileexcelimport").value;
                var fsize = $('#fileexcelimport')[0].files[0].size;
                var extn = path.substring(path.lastIndexOf(".") + 1, path.length);
                
                if((extn=='xls') || (extn=='csv')){ 
                    ajaxFileUpload(items);	
                }else{
                    $.messager.show({title:'Message',msg: 'File of xlsx Format is not Supported.',showType:'show',
                        style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
                    }); 
                    return;
                } 
            }
        }
    }
    x.open("GET","getAttachDocumentNo.jsp",true);
    x.send();
}

function upload(){
    $('#txtexcelvalidation').val(1);
    getAttachDocumentNo();
}

function ajaxFileUpload(docNo) {  
    var jvtdate = $("#jqxIbJournalVouchersDate").val();
    var newDate = jvtdate.split('.');
    jvtdate = newDate[0] + "-" + newDate[1] + "-" + newDate[2];
  
    if (window.File && window.FileReader && window.FileList && window.Blob) {
        var fsize = $('#fileexcelimport')[0].files[0].size;
        if(fsize>1048576) {
            $.messager.show({title:'Message',msg: fsize +' bytes too big ! Maximum Size 1 MB.',showType:'show',
                style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
            }); 
            return;
        }
    } else {
        $.messager.show({title:'Message',msg:'Please upgrade your browser, because your current browser lacks some new features we need!',showType:'show',
            style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
        }); 
        return;
    }
    
    $.ajaxFileUpload({  
        url:'fileAttachAction.action?formCode=IJVE&doc_no='+docNo+'&descpt=Excel Import' ,
        secureuri:false,  
        fileElementId:'fileexcelimport',   
        dataType: 'json', 
        success: function (data, status) {  
            if(status=='success'){
                saveExcelDataData(docNo);
                $.messager.show({title:'Message',msg:'Successfully Uploaded',showType:'show',
                    style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
                }); 
            }
            if(typeof(data.error) != 'undefined') {  
                if(data.error != '') {  
                    $.messager.show({title:'Message',msg: data.error,showType:'show',
                        style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
                    }); 
                } else {  
                    $.messager.show({title:'Message',msg: data.message,showType:'show',
                        style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
                    }); 
                }  
            }  
        },  
        error: function (data, status, e){  
            $.messager.alert('Message',e);
        }  
    });  
    return false;  
}
</script>

</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmIbJournalVoucher" action="saveIbJournalVoucher" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include>

<div class='modern-ui hidden-scrollbar'>
    <div id="errormsg"></div>

    <div class="middle-panel" style="background: #fdfdfd;">
        <span class="middle-panel-title">Inter-Branch Journal Voucher Details</span>
        
        <div class="field-row">
            <label class="lbl-right" style="width:80px;">Date</label>
            <div style="width: 125px;">
                <div id="jqxIbJournalVouchersDate" name="jqxIbJournalVouchersDate" onchange="datechange();" value='<s:property value="jqxIbJournalVouchersDate"/>'></div>
            </div>
            <input type="hidden" id="hidjqxIbJournalVouchersDate" name="hidjqxIbJournalVouchersDate" value='<s:property value="hidjqxIbJournalVouchersDate"/>'/>
            
            <div style="display:flex; align-items:center; margin-left:auto;">
                <input type="file" id="fileexcelimport" name="file" style="width:200px; padding:0;"/>
                <button class="icon-button" id="btnsearch" name="btnsearch" title="Import Excel" type="button" onclick="return upload();" style="margin-left: 8px;">
                    <img alt="Import Excel" src="<%=contextPath%>/icons/import_excel.png">
                </button>
            </div>
            
            <label class="lbl-right" style="width:80px; margin-left:auto;">Doc No</label>
            <input type="text" id="docno" name="txtibjournalvouchersdocno" style="width:125px;" value='<s:property value="txtibjournalvouchersdocno"/>' tabindex="-1" readonly/>
            
            <button class="myButton" type="button" id="btnvaluechange" name="btnvaluechange" onclick="funwarningopen();" style="margin-left:10px;">Value Change</button>
        </div>
        
        <div class="field-row" style="margin-bottom:0;">
            <label class="lbl-right" style="width:80px;">Ref. No.</label>
            <input type="text" id="txtrefno" name="txtrefno" style="width:125px;" onblur="fungridfocus();" value='<s:property value="txtrefno"/>'/>
            
            <label class="lbl-right" style="width:80px; margin-left:auto;">Description</label>
            <input type="text" id="txtdescription" name="txtdescription" style="flex:1;" value='<s:property value="txtdescription"/>'/>
            
            <i style="margin-left: 15px;"><b><label id="lblformposted" name="lblformposted" style="font-size: 13px; font-family: Tahoma; color:#6000FC"><s:property value="lblformposted"/></label></b></i>
        </div>
    </div>

    <div class="middle-panel">
        <span class="middle-panel-title">Details</span>
        <div id="jqxJournalVoucherGrid" class="grid-container">
            <jsp:include page="ibJournalVoucherGrid.jsp"></jsp:include>
        </div>
        
        <div class="field-row" style="justify-content:flex-end; margin-top:15px; margin-bottom:0;">
            <label class="lbl-right" style="width:80px;">Dr. Total</label>
            <input type="text" id="txtdrtotal" name="txtdrtotal" style="width:150px; text-align:right; font-weight:bold; color:#0b45a2;" value='<s:property value="txtdrtotal"/>' tabindex="-1" readonly/>
            
            <label class="lbl-right" style="width:80px; margin-left:20px;">Cr. Total</label>
            <input type="text" id="txtcrtotal" name="txtcrtotal" style="width:150px; text-align:right; font-weight:bold; color:#0b45a2;" value='<s:property value="txtcrtotal"/>' tabindex="-1" readonly/>
        </div>
    </div>

    <!-- Hidden Logic Fields -->
    <div style="display:none;">
        <input type="hidden" id="mode" name="mode"/>
        <input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
        <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
        <input type="hidden" id="gridlength" name="gridlength"/>
        <div id="maindate" name="maindate" value='<s:property value="maindate"/>'></div>
        <input type="hidden" id="hidmaindate" name="hidmaindate" value='<s:property value="hidmaindate"/>'/>
        <input type="hidden" id="txtexceltypevalidation" name="txtexceltypevalidation" value='<s:property value="txtexceltypevalidation"/>'/>
        <input type="hidden" id="txtexcelaccvalidation" name="txtexcelaccvalidation" value='<s:property value="txtexcelaccvalidation"/>'/>
        <input type="hidden" id="txtexcelgrtypevalidation" name="txtexcelgrtypevalidation" value='<s:property value="txtexcelgrtypevalidation"/>'/>
        <input type="hidden" id="txtexcelcostvalidation" name="txtexcelcostvalidation" value='<s:property value="txtexcelcostvalidation"/>'/>
        <input type="hidden" id="txtexcelbranchvalidation" name="txtexcelbranchvalidation" value='<s:property value="txtexcelbranchvalidation"/>'/>
        <input type="hidden" id="txttrno" name="txttrno" value='<s:property value="txttrno"/>'/>
        <input type="hidden" id="txtvalidation" name="txtvalidation" value='<s:property value="txtvalidation"/>'/>
    </div>

</div>
</form>

<!-- Search Windows -->
<div id="ibJournalVoucherGridWindow"><div></div><div></div></div>
<div id="branchSearchWindow"><div></div><div></div></div>
<div id="costTypeSearchGridWindow"><div></div><div></div></div> 
<div id="costCodeSearchWindow"><div></div><div></div></div> 

</div>
</body>
</html>