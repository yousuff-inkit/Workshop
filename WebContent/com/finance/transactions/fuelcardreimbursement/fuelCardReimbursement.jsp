<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>

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

.modern-ui input[type="checkbox"] {
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
    $("#jqxFuelCardReimbursementDate").jqxDateTimeInput({ width: '125px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
    $("#maindate").jqxDateTimeInput({ width: '125px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
    
    /* force internal alignment AFTER render */
    setTimeout(function () {
        $("#jqxFuelCardReimbursementDate, #maindate").find("input").css({
            "margin-top": "0px",
            "line-height": "24px",
            "font-size": "12px", 
            "font-family": "Arial, sans-serif", 
            "padding": "0 6px", 
            "box-sizing":"border-box"
        });
        $("#jqxFuelCardReimbursementDate, #maindate").find(".jqx-action-button").css({
            "top": "0px",
            "height": "24px"
        });
    }, 0);
    
    var popupConfig = {height: '58%', maxHeight: '70%', maxWidth: '51%', title: 'Search', position: { x: 300, y: 87 }, theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27};
    $('#accountDetailsFromWindow').jqxWindow($.extend({}, popupConfig, {width: '51%', title: 'Accounts Search'})).jqxWindow('close');  
    $('#fuelCardReimbursementGridWindow').jqxWindow($.extend({}, popupConfig, {width: '51%'})).jqxWindow('close');
    $('#costTypeSearchGridWindow').jqxWindow($.extend({}, popupConfig, {width: '25%', maxWidth: '25%', title: 'Cost Type Search', position: { x: 420, y: 87 }})).jqxWindow('close');
    $('#costCodeSearchWindow').jqxWindow($.extend({}, popupConfig, {width: '25%', maxWidth: '25%', title: 'Cost Code Search', position: { x: 420, y: 87 }})).jqxWindow('close');
    
    $('#jqxFuelCardReimbursementDate').on('change', function (event) {
        var paydate = $('#jqxFuelCardReimbursementDate').jqxDateTimeInput('getDate');
        funDateInPeriod(paydate);
    });
    
    $('#txtaccid').dblclick(function(){
        var date = $('#jqxFuelCardReimbursementDate').jqxDateTimeInput('getDate');
        $("#maindate").jqxDateTimeInput('val', date);
        accountSearchContent("<%=contextPath+"/"%>com/finance/accountsDetailsSearch.jsp?date="+date);
    });
});
	
function FuelCardReimbursementSearchContent(url) {
    $('#fuelCardReimbursementGridWindow').jqxWindow('open');
    $.get(url).done(function (data) {
        $('#fuelCardReimbursementGridWindow').jqxWindow('setContent', data);
        $('#fuelCardReimbursementGridWindow').jqxWindow('bringToFront');
    }); 
} 
	
function accountSearchContent(url) {
    $('#accountDetailsFromWindow').jqxWindow('open');
    $.get(url).done(function (data) {
        $('#accountDetailsFromWindow').jqxWindow('setContent', data);
        $('#accountDetailsFromWindow').jqxWindow('bringToFront');
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
	
function getCurrencyIds(date){
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200) {
            items= x.responseText;
            items=items.split('####');
            var curidItems=items[0];
            var curcodeItems=items[1];
            var currateItems=items[2];
            var curtypeItems=items[3];
            var multiItems=items[4];
            var optionscurr = '';
            
            if(curcodeItems.indexOf(",")>=0){
                var currencyid=curidItems.split(",");
                var currencycode=curcodeItems.split(",");
                var currencyrate=currateItems.split(",");
                var currencytype=curtypeItems.split(",");
                multiItems.split(",");
                for ( var i = 0; i < currencycode.length; i++) {
                    optionscurr += '<option value="' + currencyid[i] + '">' + currencycode[i] + '</option>';
                }
                $("select#cmbcurrency").html(optionscurr);
                if ($('#hidcmbcurrency').val() != null && $('#hidcmbcurrency').val() != "") {
                    $('#cmbcurrency').val($('#hidcmbcurrency').val()) ;
                } 
                if($('#mode').val()=="A"){
                    funRoundRate(currencyrate[0],"txtrate");
                    $('#hidcurrencytype').val(currencytype[0]);
                }
            } else{
                optionscurr += '<option value="' + curidItems + '"selected>' + curcodeItems + '</option>';
                $("select#cmbcurrency").html(optionscurr);
                if ($('#hidcmbcurrency').val() != null && $('#hidcmbcurrency').val() != "") {
                    $('#cmbcurrency').val($('#hidcmbcurrency').val()) ;
                }
                if($('#mode').val()=="A"){
                    funRoundRate(currateItems,"txtrate");
                    $('#hidcurrencytype').val(curtypeItems);
                }
            }
        }
    }
    x.open("GET", "getCurrencyId.jsp?date="+date,true);
    x.send();
}
	
function getRates(a,date){
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200) {
            var items= x.responseText;
            items = items.split('####');
            var ratesItems  = items[0].split(",");
            var typesItems = items[1].split(",");
            funRoundRate(ratesItems,"txtrate");
            $('#hidcurrencytype').val(typesItems);
            getBaseAmount();
        }
    }
    x.open("GET", "getRate.jsp?currs="+a+"&date="+date,true);
    x.send();
}
	
function getBaseAmount(){
    var fromrate = $('#txtrate').val(); 
    var fromamount = $('#txtamount').val();
    var currencytype = $('#hidcurrencytype').val().trim();
    
    if(!isNaN(fromamount)){
        if(currencytype=="M"){
            var result = parseFloat(fromamount) * parseFloat(fromrate);
            funRoundAmt(result,"txtbaseamount");
        }else{
            var result = parseFloat(fromamount) / parseFloat(fromrate);
            funRoundAmt(result,"txtbaseamount");
        }
    } else if(isNaN(fromamount)){
        $('#txtbaseamount').val(0.00);
        $('#txtamount').val(0.00);
    }
}
	
function funwarningopen(){
    $.messager.confirm('Confirm', 'Transaction will affect Links to the applied Bank Reconcilations & Prepayments.', function(r){
        if (r){
            $("#mode").val("EDIT");
            $('#txtaccid').attr('readonly', true);
            $('#txtaccname').attr('readonly', true);
            $('#txtamount').attr('readonly', false);
            $('#txtdescription').attr('readonly', false);
            $('#txtrate').attr('readonly', false);
            $('#txtbaseamount').attr('readonly', true);
            $('#frmFuelCardReimbursement select').attr('disabled', false);
            $("#jqxFuelCardReimbursement").jqxGrid({ disabled: false});  
        }
    });
}
	
function funReadOnly(){
    $('#frmFuelCardReimbursement input').attr('readonly', true );
    $('#frmFuelCardReimbursement select').attr('disabled', true);
    $('#jqxFuelCardReimbursementDate').jqxDateTimeInput({disabled: true});
    $("#jqxFuelCardReimbursement").jqxGrid({ disabled: true});
    $("#btnvaluechange").hide();
}
	 
function funRemoveReadOnly(){
    $('#frmFuelCardReimbursement input').attr('readonly', false );
    $('#frmFuelCardReimbursement select').attr('disabled', false);
    
    $('#txtaccid, #txtaccname, #txtamount, #docno').attr('readonly', true );
    $('#jqxFuelCardReimbursementDate').jqxDateTimeInput({disabled: false});
    $("#jqxFuelCardReimbursement").jqxGrid({ disabled: false});
    
    var date = $('#jqxFuelCardReimbursementDate').val();
    getCurrencyIds(date);
    
    if ($("#mode").val() == "E") {
        $("#btnvaluechange").show();
        $('#frmFuelCardReimbursement input').attr('readonly', true );
        $('#frmFuelCardReimbursement select').attr('disabled', true);
        $("#jqxFuelCardReimbursement").jqxGrid({ disabled: true});
        $('#txtrefno, #txtdescription').attr('readonly', false );
        $("#jqxFuelCardReimbursement").jqxGrid('addrow', null, {"costtype": "6","costgroup": "Fleet","costcode": "","reg_no": "","amount1": "","baseamount1": "","description": ""});
    } else{
        $("#btnvaluechange").hide();
    } 
    
    if ($("#mode").val() == "A") {
        $('#jqxFuelCardReimbursementDate').val(new Date());
        $("#jqxFuelCardReimbursement").jqxGrid('clear'); 
        $("#jqxFuelCardReimbursement").jqxGrid('addrow', null, {"costtype": "6","costgroup": "Fleet","costcode": "","reg_no": "","amount1": "","baseamount1": "","description": ""});
    }
}
	 
function funSearchLoad(){
    changeContent('fcrMainSearch.jsp');  
}
	
function funChkButton() {}

function funFocus(){
    $('#jqxFuelCardReimbursementDate').jqxDateTimeInput('focus'); 	    		
}
	 
$(function(){
    $('#frmFuelCardReimbursement').validate({
        rules: {
            txtaccid:"required",
            txtamount:{"required":true,number:true},
            txtdescription:{maxlength:500}
        },
        messages: {
            txtaccid:" *",
            txtamount:{required:" *",number:"Invalid"},
            txtdescription: {maxlength:"    Max 500 chars"}
        }
    });
});
	   
function funNotify(){	
    var paydate = $('#jqxFuelCardReimbursementDate').jqxDateTimeInput('getDate');
    var validdate=funDateInPeriod(paydate);
    if(validdate==0){ return 0; }
    
    currency=document.getElementById("cmbcurrency").value;
    if(currency==""){
        document.getElementById("errormsg").innerText="Currency & Rate is Mandatory.";
        return 0;
    }
    
    document.getElementById("errormsg").innerText=""; 
    
    var rows = $("#jqxFuelCardReimbursement").jqxGrid('getrows');
    var length=0;
    for(var i=0 ; i < rows.length ; i++){
        var chk=rows[i].costcode;
        if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){
            newTextBox = $(document.createElement("input"))
            .attr("type", "dil")
            .attr("id", "test"+length)
            .attr("name", "test"+length)
            .attr("hidden", "true");
            length=length+1;
            
            newTextBox.val(rows[i].costtype+":: "+rows[i].costcode+":: "+rows[i].amount1+"::"+rows[i].baseamount1+"::"+rows[i].description);
            newTextBox.appendTo('form');
        }
    }
    $('#gridlength').val(length);
    return 1;
} 
	  
function setValues(){
    $('#jqxFuelCardReimbursementDate').jqxDateTimeInput({disabled: false});
    var date = $('#jqxFuelCardReimbursementDate').val();
    getCurrencyIds(date);
    $('#jqxFuelCardReimbursementDate').jqxDateTimeInput({disabled: true});
    
    if($('#hidjqxFuelCardReimbursementDate').val()){
        $("#jqxFuelCardReimbursementDate").jqxDateTimeInput('val', $('#hidjqxFuelCardReimbursementDate').val());
    }
    
    if($('#hidmaindate').val()){
        $("#maindate").jqxDateTimeInput('val', $('#hidmaindate').val());
    }
    
    if($('#msg').val()!=""){
        $.messager.alert('Message',$('#msg').val());
    }
    
    document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
    funSetlabel();
    
    var indexVal = document.getElementById("docno").value;
    if(indexVal>0){
        var check = 1;
        $("#fuelCardReimbursementDiv").load("fuelCardReimbursementGrid.jsp?txtfuelcardreimbursementdocno2="+indexVal+'&check='+check);
    }
}
	  
function getDrTotal(){
    var amount = $('#txtbaseamount').val();
    if(!isNaN(amount)){
        $('#txtdrtotal').val(amount);
    } else if(isNaN(amount)){
        $('#txtdrtotal').val(0.00);
        $('#txtamount').val(0.00);
    }
}
	  
function getAcc(event){
    var x= event.keyCode;
    if(x==114){
        var date = $('#jqxFuelCardReimbursementDate').jqxDateTimeInput('getDate');
        $("#maindate").jqxDateTimeInput('val', date);
        accountSearchContent("<%=contextPath+"/"%>com/finance/accountsDetailsSearch.jsp?date="+date);
    }
}
	  
function funPrintBtn() {
    if (($("#mode").val() == "view") && $("#docno").val()!="") {
        var url=document.URL;
        var reurl=url.split("saveFuelCardReimbursement");
        $("#docno").prop("disabled", false); 
        
        $.messager.confirm('Confirm', 'Do you want to have header?', function(r){
            if (r){
                var win= window.open(reurl[0]+"printFuelCardReimbursement?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
                win.focus();
            } else{
                var win= window.open(reurl[0]+"printFuelCardReimbursement?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=0","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
                win.focus();
            }
        });
    } else {
        $.messager.alert('Message','Select a Document....!','warning');
        return;
    }
}
	  
function datechange(){
    var date = $('#jqxFuelCardReimbursementDate').jqxDateTimeInput('getDate');
    $("#maindate").jqxDateTimeInput('val', date);
}
</script>

</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background" >
<form id="frmFuelCardReimbursement" action="saveFuelCardReimbursement" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include>

<div class='modern-ui hidden-scrollbar'>
    <div id="errormsg"></div>
    
    <div class="middle-panel" style="background: #fdfdfd;">
        <span class="middle-panel-title">Fuel Card Reimbursement Details</span>
        
        <div class="field-row">
            <label class="lbl-right" style="width:80px;">Date</label>
            <div style="width: 125px;">
                <div id="jqxFuelCardReimbursementDate" name="jqxFuelCardReimbursementDate" onchange="datechange();" value='<s:property value="jqxFuelCardReimbursementDate"/>'></div>
            </div>
            <input type="hidden" id="hidjqxFuelCardReimbursementDate" name="hidjqxFuelCardReimbursementDate" value='<s:property value="hidjqxFuelCardReimbursementDate"/>'/>
            
            <label class="lbl-right" style="width:80px; margin-left:auto;">Ref. No.</label>
            <input type="text" id="txtrefno" name="txtrefno" style="width:125px;" value='<s:property value="txtrefno"/>'/>
            
            <label class="lbl-right" style="width:80px;">Doc No.</label>
            <input type="text" id="docno" name="txtfuelcardreimbursementdocno" style="width:125px;" value='<s:property value="txtfuelcardreimbursementdocno"/>' tabindex="-1" readonly/>
            
            <button class="myButton" type="button" id="btnvaluechange" name="btnvaluechange" onclick="funwarningopen();" style="margin-left: 10px;">Value Change</button>
        </div>
        
        <div class="field-row">
            <label class="lbl-right" style="width:80px;">Card</label>
            <div class="input-search-container" style="width: 150px;">
                <input type="text" id="txtaccid" name="txtaccid" placeholder="Press F3" value='<s:property value="txtaccid"/>' onkeydown="getAcc(event);"/>
                <svg class="magnifier-icon" onclick="$('#txtaccid').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
            </div>
            <input type="text" id="txtaccname" name="txtaccname" style="flex:1;" value='<s:property value="txtaccname"/>' tabindex="-1" readonly/>
            <input type="hidden" id="txtdocno" name="txtdocno" value='<s:property value="txtdocno"/>'/>
        </div>
        
        <div class="field-row">
            <label class="lbl-right" style="width:80px;">Currency</label>
            <select id="cmbcurrency" name="cmbcurrency" style="width:150px;" value='<s:property value="cmbcurrency"/>' onload="getRates(this.value,$('#jqxFuelCardReimbursementDate').val());" onchange="getRates(this.value,$('#jqxFuelCardReimbursementDate').val());">
                <option></option>
            </select>
            <input type="hidden" id="hidcmbcurrency" name="hidcmbcurrency" value='<s:property value="hidcmbcurrency"/>'/>
            <input type="hidden" id="hidcurrencytype" name="hidcurrencytype" value='<s:property value="hidcurrencytype"/>'/>
            
            <label class="lbl-right" style="width:80px; margin-left:auto;">Rate</label>
            <input type="text" id="txtrate" name="txtrate" style="width:120px; text-align:right;" value='<s:property value="txtrate"/>' tabindex="-1" readonly/>
        </div>
        
        <div class="field-row">
            <label class="lbl-right" style="width:80px;">Amount</label>
            <input type="text" id="txtamount" name="txtamount" style="width:150px; text-align:right;" value='<s:property value="txtamount"/>' readonly onblur="funRoundAmt(this.value,this.id);" tabindex="-1"/>
            
            <label class="lbl-right" style="width:80px; margin-left:auto;">Base Amount</label>
            <input type="text" id="txtbaseamount" name="txtbaseamount" style="width:120px; text-align:right;" readonly value='<s:property value="txtbaseamount"/>' tabindex="-1"/>
        </div>
        
        <div class="field-row" style="margin-bottom:0;">
            <label class="lbl-right" style="width:80px;">Description</label>
            <input type="text" id="txtdescription" name="txtdescription" style="flex:1;" value='<s:property value="txtdescription"/>'/>
        </div>
    </div>

    <div class="middle-panel">
        <span class="middle-panel-title">Details</span>
        <div id="fuelCardReimbursementDiv" class="grid-container">
            <jsp:include page="fuelCardReimbursementGrid.jsp"></jsp:include>
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
        <input type="hidden" id="txttrno" name="txttrno" value='<s:property value="txttrno"/>'/>
        <input type="hidden" id="txttranid" name="txttranid" value='<s:property value="txttranid"/>'/>
    </div>

</div>
</form>
	
<!-- Search Windows -->
<div id="fuelCardReimbursementGridWindow"><div></div><div></div></div>  
<div id="accountDetailsFromWindow"><div></div><div></div></div>  
<div id="costTypeSearchGridWindow"><div></div><div></div></div> 
<div id="costCodeSearchWindow"><div></div><div></div></div> 
	
</div>
</body>
</html>