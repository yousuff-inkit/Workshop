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
.modern-ui .myButton:disabled { background: #cccccc; color: #888888; cursor: not-allowed; box-shadow: none; }

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
    $("#jqxmcpdate").jqxDateTimeInput({ width: '125px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
    $("#maindate").jqxDateTimeInput({ width: '125px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
    
    /* force internal alignment AFTER render */
    setTimeout(function () {
        $("#jqxmcpdate, #maindate").find("input").css({
            "margin-top": "0px",
            "line-height": "24px",
            "font-size": "12px", 
            "font-family": "Arial, sans-serif", 
            "padding": "0 6px", 
            "box-sizing":"border-box"
        });
        $("#jqxmcpdate, #maindate").find(".jqx-action-button").css({
            "top": "0px",
            "height": "24px"
        });
    }, 0);

    $('#txtforsearch').val(2);
    
    var popupConfig = {height: '58%', maxHeight: '70%', maxWidth: '51%', title: 'Search', position: { x: 300, y: 87 }, theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27};
    $('#productSearchwindow').jqxWindow($.extend({}, popupConfig, {width: '50%', height: '62%', maxWidth: '50%', title: 'Product Search', position: { x: 100, y: 60 }})).jqxWindow('close');
    $('#accountDetailsFromWindow').jqxWindow($.extend({}, popupConfig, {width: '51%', title: 'Accounts Search'})).jqxWindow('close');  
    $('#McpGridWindow').jqxWindow($.extend({}, popupConfig, {width: '51%'})).jqxWindow('close');
    $('#costTypeSearchGridWindow').jqxWindow($.extend({}, popupConfig, {width: '25%', maxWidth: '25%', title: 'Cost Type Search', position: { x: 420, y: 87 }})).jqxWindow('close');
    $('#costCodeSearchWindow').jqxWindow($.extend({}, popupConfig, {width: '25%', maxWidth: '25%', title: 'Cost Code Search', position: { x: 420, y: 87 }})).jqxWindow('close');
    $('#vendorinfowindow').jqxWindow($.extend({}, popupConfig, {width: '25%', maxWidth: '25%', title: 'Vendor Search', position: { x: 420, y: 87 }})).jqxWindow('close');
    
    $('#jqxmcpdate').on('change', function (event) {
        var paydate = $('#jqxmcpdate').jqxDateTimeInput('getDate');
        var validdate=funDateInPeriod(paydate);
        if(parseInt(validdate)==0){
            document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
            return 0;	
        }
    });
    
    $('#txtaccid').dblclick(function(){
        var date = $('#jqxmcpdate').jqxDateTimeInput('getDate');
        $("#maindate").jqxDateTimeInput('val', date);
        accountSearchContent("<%=contextPath+"/"%>com/finance/accountsDetailsSearch.jsp?date="+date);
        $('#txtforsearch').val(2);
    });
});
	
function VendorSearchContent(url) {
    $('#vendorinfowindow').jqxWindow('open');
    $.get(url).done(function (data) {
        $('#vendorinfowindow').jqxWindow('setContent', data);
        $('#vendorinfowindow').jqxWindow('bringToFront');
    }); 
} 
	
function McpSearchContent(url) {
    $('#McpGridWindow').jqxWindow('open');
    $.get(url).done(function (data) {
        $('#McpGridWindow').jqxWindow('setContent', data);
        $('#McpGridWindow').jqxWindow('bringToFront');
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
            $('#txtaccid').attr('readonly', true);$('#txtaccname').attr('readonly', true);$('#txtamount').attr('readonly', false);
            $('#txtdescription').attr('readonly', false);$('#txtrate').attr('readonly', false);$('#txtbaseamount').attr('readonly', true);
            $('#frmMultipleCashPurchase select').attr('disabled', false);$("#jqxPettyCash").jqxGrid({ disabled: false});  
        }
    });
}
	
function funReadOnly(){
    $('#frmMultipleCashPurchase input').attr('readonly', true );
    $('#frmMultipleCashPurchase select').attr('disabled', true);
    $('#jqxmcpdate').jqxDateTimeInput({disabled: true});
    $("#jqxMultipleCashPurchase").jqxGrid({ disabled: true});
    $("#btnvaluechange").hide();
    $("#btnunpost").attr('disabled', true );
    $("#btnpost").attr('disabled', true );
}
	 
function funRemoveReadOnly(){  
    $("#btnunpost").attr('disabled', true );
    $("#btnpost").attr('disabled', true );
    document.getElementById("errormsg").innerText="";
    $('#txtforsearch').val(2);
    $('#frmMultipleCashPurchase input').attr('readonly', false );
    $('#frmMultipleCashPurchase select').attr('disabled', false);
    
    $("#btnpost").hide();
    $('#txtaccid').attr('readonly', true );
    $('#txtaccname').attr('readonly', true );
    $('#txtamount').attr('readonly', true );
    $('#txtbaseamount').attr('readonly', true );
    $('#jqxmcpdate').jqxDateTimeInput({disabled: false});
    $('#docno').attr('readonly', true);
    $("#jqxMultipleCashPurchase").jqxGrid({ disabled: false});
    
    var date = $('#jqxmcpdate').val();
    getCurrencyId(date);
    
    if ($("#mode").val() == "E") {
        $("#btnvaluechange").show();
        $('#frmMultipleCashPurchase input').attr('readonly', true );
        $('#frmMultipleCashPurchase select').attr('disabled', false);
        $("#jqxMultipleCashPurchase").jqxGrid({ disabled: false});
        $('#txtrefno').attr('readonly', false );
        $('#txtdescription').attr('readonly', false);
        $('#txtroundoff').attr('readonly', false );
        $("#jqxMultipleCashPurchase").jqxGrid('addrow', null, {"type": "","accounts": "","accountname1": "","currency": "","rate": "","amount1": "","description": ""});
    } else{
        $("#btnvaluechange").hide();
    } 
    
    if ($("#mode").val() == "A") {
        $('#jqxmcpdate').val(new Date());
        $("#jqxMultipleCashPurchase").jqxGrid('clear'); 
        $("#jqxMultipleCashPurchase").jqxGrid('addrow', null, {"type": "","accounts": "","accountname1": "","currency": "","rate": "","amount1": "","description": ""});
    }
}
	 
function funSearchLoad(){
    changeContent('mcpMainSearch.jsp');  
}
	
function funChkButton() {}

function funFocus(){
    $('#jqxmcpdate').jqxDateTimeInput('focus'); 	    		
}
 
$(function(){
    $('#frmMultipleCashPurchase').validate({
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
    docno=document.getElementById("txtdocno").value;
    if(docno==""){
        document.getElementById("errormsg").innerText="Select cash account.";
        return 0;	
    }
    var summ= $("#jqxMultipleCashPurchase").jqxGrid('getcolumnaggregateddata', 'amount1', ['sum'],true);
    var sum1=summ.sum.replace(/,/g,'');
    if(sum1==0){
        document.getElementById("errormsg").innerText="Enter amount value.";
        return 0;
    }
    var paydate = $('#jqxmcpdate').jqxDateTimeInput('getDate');
    var validdate=funDateInPeriod(paydate);
    if(parseInt(validdate)==0){
        document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
        return 0;	
    }
    
    currency=document.getElementById("cmbcurrency").value;
    if(currency==""){
        document.getElementById("errormsg").innerText="Currency & Rate is Mandatory.";
        return 0;
    }
    
    document.getElementById("errormsg").innerText=""; 
    
    var rows = $("#jqxMultipleCashPurchase").jqxGrid('getrows');
    var length=0;
    for(var i=0 ; i < rows.length ; i++){
        var chk=rows[i].docno;
        if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){
            newTextBox = $(document.createElement("input"))
            .attr("type", "dil")
            .attr("id", "test"+length)
            .attr("name", "test"+length)
            .attr("hidden", "true");
            length=length+1;
            
            newTextBox.val(rows[i].docno+"::"+rows[i].currencyid+"::"+rows[i].rate+"::true::"+rows[i].amount1+"::"+rows[i].description+"::"+rows[i].baseamount1+"::0:: "+rows[i].costtype+":: "+rows[i].costcode+"::"+rows[i].vendorid+"::"+rows[i].tinno+"::"+rows[i].invno+"::"+rows[i].hidinvdate+"::"+rows[i].taxamt+"::"+rows[i].total+"::"+rows[i].rowno+"::"+rows[i].srvtaxper+"::"+rows[i].psrno+"::"+rows[i].qty+"::"+rows[i].unitprice);
            newTextBox.appendTo('form');
        }
    }
    $('#gridlength').val(length);
    return 1;
} 
	  
function setValues(){
    $('#jqxmcpdate').jqxDateTimeInput({disabled: false});
    var date = $('#jqxmcpdate').val();
    getCurrencyId(date);
    $('#jqxmcpdate').jqxDateTimeInput({disabled: true});
    
    if($('#hidjqxmcpdate').val()){
        $("#jqxmcpdate").jqxDateTimeInput('val', $('#hidjqxmcpdate').val());
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
        $("#divMCPGrid").load("multipleCashPurchaseGrid.jsp?txtpettycashdocno2="+indexVal+"&check="+check);
    }
    if(document.getElementById("docno").value!=""){
        getPostingdetails(); 
    }
}
		
function getPostingdetails(){
    var mode=$("#mode").val();
    var docno=document.getElementById("docno").value;
    var trno=document.getElementById("txttrno").value;
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText.trim();
            if(parseInt(items)>0){
                $("#posted").val(parseInt(items));
                document.getElementById("errormsg").innerText="Account Is Not Posted Please Post The Account .";
                $("#btnpost").attr('disabled', false );
                $("#btnunpost").attr('disabled', true );
                return 0;
            } else{
                document.getElementById("errormsg").innerText="Document Already Posted.";
                $("#btnEdit").attr('disabled', true );
                $("#btnDelete").attr('disabled', true );
                $("#btnpost").attr('disabled', true );
                $("#btnunpost").attr('disabled', false );  
            }
        }
    }
    x.open("GET", "getPostingDetails.jsp?docno="+docno+"&trno="+trno+"&mode="+mode, true);
    x.send();
}

function funchkinv(){
    var list= new Array();
    var docno=document.getElementById("docno").value;
    var rows = $("#jqxMultipleCashPurchase").jqxGrid('getrows');
    var length=0;
    for(var i=0 ; i < rows.length ; i++){
        var chk=rows[i].docno;
        if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){
            list.push(rows[i].vendoracno+" :: "+rows[i].invno);
        }
    }
    var x =new XMLHttpRequest();
    x.onreadystatechange=function() {
        if(x.readyState==4 && x.status==200) {
            var items=x.responseText;
            var chk=items.split("::");
            if(parseInt(chk[0])==1) {
                document.getElementById("errormsg").innerText="Inv No Already Exists-"+chk[1]+"";  
                return 0;
            } else {
                document.getElementById("errormsg").innerText="";
                funPost();
            }
        }
    }
    x.open("GET","checkinvno.jsp?chklist="+list+'&masterdocno='+document.getElementById("docno").value);
    x.send();
}
	  
function funPost(){
    var brhid=$("#brchName").val();   
    $.messager.confirm('Confirm', 'Do you want to Post?', function(r){
        if (r){
            $("#overlay, #PleaseWait").show();
            var mode=$("#mode").val();
            var docno=document.getElementById("docno").value;
            var vendorid=document.getElementById("vendorid").value;
            var vendor=document.getElementById("vendor").value;
            var trno=document.getElementById("txttrno").value;
            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    var items = x.responseText.trim();
                    if(parseInt(items)>0){ 
                        $("#overlay, #PleaseWait").hide();
                        $("#btnpost").attr('disabled', true );
                        $("#btnunpost").attr('disabled', false ); 
                        $("#btnEdit").attr('disabled', true );
                        $("#btnDelete").attr('disabled', true );  
                        $.messager.alert('Message','Account is Posted.','warning');
                        document.getElementById("errormsg").innerText="Document Already Posted.";
                    }else{
                        $("#overlay, #PleaseWait").hide();  
                        $.messager.alert('Message','Account not Posted.','warning');  
                    }
                } 
            }  
            x.open("GET", "getPostingDone.jsp?docno="+docno+"&mode="+mode+"&vendorid="+vendorid+"&vendor="+vendor+"&trno="+trno+"&brhid="+brhid, true);     
            x.send();
        } 
    });
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
	  
function isNumberKey(evt){
    var charCode = (evt.which) ? evt.which : event.keyCode
    if (charCode > 31 && ((charCode < 48) || (charCode > 57)))          
        return false;
    return true;
}
	  
function getAcc(event){
    var x= event.keyCode;
    if(x==114){
        var date = $('#jqxmcpdate').jqxDateTimeInput('getDate');
        $("#maindate").jqxDateTimeInput('val', date);
        accountSearchContent("<%=contextPath+"/"%>com/finance/accountsDetailsSearch.jsp?date="+date);
        $('#txtforsearch').val(2);
    }
}
	  
function funPrintBtn() {
    if (($("#mode").val() == "view") && $("#docno").val()!="") {
        var url=document.URL;
        var reurl=url.split("saveMultipleCashPurchase");
        $("#docno").prop("disabled", false); 
        
        $.messager.confirm('Confirm', 'Do you want to have header?', function(r){
            if (r){
                var win= window.open(reurl[0]+"printMultipleCashPurchase?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
                win.focus();
            } else{
                var win= window.open(reurl[0]+"printMultipleCashPurchase?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=0","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
                win.focus();
            }
        });
    } else {
        $.messager.alert('Message','Select a Document....!','warning');
        return;
    }
}
	  
function datechange(){
    var date = $('#jqxmcpdate').jqxDateTimeInput('getDate');
    var validdate=funDateInPeriod(date);
    if(parseInt(validdate)==0){
        document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
        return 0;	
    }
    $("#maindate").jqxDateTimeInput('val', date);
}
	
function funwarningopen(){
    $.messager.confirm('Confirm', 'Transaction will affect Links to the applied Bank Reconcilations & Prepayments.', function(r){
        if (r){
            $("#mode").val("EDIT");
            $('#txtaccid').attr('readonly', true);$('#txtaccname').attr('readonly', true);$('#txtamount').attr('readonly', false);
            $('#txtdescription').attr('readonly', false);$('#txtrate').attr('readonly', false);$('#txtbaseamount').attr('readonly', true);
            $('#frmMultipleCashPurchase select').attr('disabled', false);$("#jqxPettyCash").jqxGrid({ disabled: false});  
        }
    });
}
function getproductdetails(event){
    if($('#mode').val()!= "view") {
        $('#productSearchwindow').jqxWindow('open');
        productSearchContent('productSearchGrid.jsp');  
    } 
}
function productSearchContent(url) {
    $.get(url).done(function (data) {
        $('#productSearchwindow').jqxWindow('setContent', data);
    }); 
}
	  
function funcalc(){  
    var grandtot=document.getElementById("grandtot").value;   
    var roundoff=document.getElementById("txtroundoff").value;   
    var rate = $('#txtrate').val(); 
    if(isNaN(roundoff) || roundoff==""){  
        roundoff=0.0;
    }
    if(isNaN(grandtot) || grandtot==""){  
        grandtot=0.0;
    } 
    if(isNaN(rate) || rate==""){  
        rate=0.0;  
    }
    var totalamt=0.0,basetot=0.0;
    basetot=parseFloat(grandtot)+parseFloat(roundoff);
    if(isNaN(basetot) || basetot==""){   
        basetot=0.0;  
    }
    document.getElementById("txtbaseamount").value=basetot.toFixed(2);
    totalamt = (parseFloat(grandtot)+parseFloat(roundoff)) * parseFloat(rate);   
    funRoundAmt(totalamt,"txtamount");     
}
	  
function unPost(){  
    var trno=document.getElementById("txttrno").value;
    $.messager.confirm('Confirm', 'Do you want to unpost the document?', function(r){  
        if (r){
            $("#overlay, #PleaseWait").show();
            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    var items = x.responseText.trim();
                    if(parseInt(items)>0){
                        document.getElementById("errormsg").innerText="";  
                        $("#overlay, #PleaseWait").hide(); 
                        $("#btnunpost").attr('disabled', true ); 
                        $("#btnpost").attr('disabled', false );
                        $.messager.alert('Message','Successfully Unposted.','warning');
                    }else{
                        $("#overlay, #PleaseWait").hide(); 
                        $.messager.alert('Message','Not Unposted.','warning');  
                    }  
                }
            }
            x.open("GET", "unpost.jsp?trno="+trno, true);            
            x.send();
        }
    });
}   
</script>
</head>

<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background" >
<form id="frmMultipleCashPurchase" action="saveMultipleCashPurchase" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include>

<div class='modern-ui hidden-scrollbar'>
    <div id="errormsg"></div>

    <div class="middle-panel" style="background: #fdfdfd;">
        <span class="middle-panel-title">Multiple Cash Purchase Details</span>
        
        <div class="field-row">
            <label class="lbl-right" style="width:80px;">Date</label>
            <div style="width: 125px;">
                <div id="jqxmcpdate" name="jqxmcpdate" onchange="datechange();" onblur="datechange();" value='<s:property value="jqxmcpdate"/>'></div>
            </div>
            <input type="hidden" id="hidjqxmcpdate" name="hidjqxmcpdate" value='<s:property value="hidjqxmcpdate"/>'/>
            
            <label class="lbl-right" style="width:80px; margin-left:auto;">Ref. No.</label>
            <input type="text" id="txtrefno" name="txtrefno" onkeypress="return isNumberKey(event)" style="width:125px;" value='<s:property value="txtrefno"/>'/>
            
            <label class="lbl-right" style="width:80px;">Doc No.</label>
            <input type="text" id="docno" name="txtpettycashdocno" style="width:125px;" value='<s:property value="txtpettycashdocno"/>' tabindex="-1" readonly/>
            
            <div style="display:flex; gap:8px; margin-left: 10px;">
                <button id="btnpost" class="myButton" type="button" onclick="funchkinv()">Post</button>
                <button id="btnunpost" class="myButton" type="button" onclick="unPost();">Unpost</button>
                <button class="myButton" type="button" id="btnvaluechange" name="btnvaluechange" onclick="funwarningopen();">Value Change</button>
            </div>
        </div>
        
        <div class="field-row">
            <label class="lbl-right" style="width:80px;">Cash</label>
            <div class="input-search-container" style="width: 150px;">
                <input type="text" id="txtaccid" name="txtaccid" placeholder="Press F3" value='<s:property value="txtaccid"/>' onkeydown="getAcc(event);"/>
                <svg class="magnifier-icon" onclick="$('#txtaccid').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
            </div>
            <input type="text" id="txtaccname" name="txtaccname" style="flex:1; margin-left:8px;" value='<s:property value="txtaccname"/>' tabindex="-1" readonly/>
            <input type="hidden" id="txtdocno" name="txtdocno" value='<s:property value="txtdocno"/>'/>
        </div>
        
        <div class="field-row">
            <label class="lbl-right" style="width:80px;">Currency</label>
            <select id="cmbcurrency" name="cmbcurrency" style="width:150px;" value='<s:property value="cmbcurrency"/>' onload="getRatevalue(this.value,$('#jqxmcpdate').val());" onchange="getRatevalue(this.value,$('#jqxmcpdate').val());">
                <option></option>
            </select>
            <input type="hidden" id="hidcmbcurrency" name="hidcmbcurrency" value='<s:property value="hidcmbcurrency"/>'/>
            <input type="hidden" id="hidcurrencytype" name="hidcurrencytype" value='<s:property value="hidcurrencytype"/>'/>
            
            <label class="lbl-right" style="width:80px; margin-left:auto;">Rate</label>
            <input type="text" id="txtrate" name="txtrate" style="width:120px; text-align:right;" value='<s:property value="txtrate"/>' onblur="funRoundAmt(this.value,this.id);" tabindex="-1" readonly/>
        </div>
        
        <div class="field-row">
            <label class="lbl-right" style="width:80px;">Round Off</label>
            <input type="text" id="txtroundoff" name="txtroundoff" style="width:150px; text-align:right;" value='<s:property value="txtroundoff"/>' onblur="funRoundAmt(this.value,this.id);" onchange="funcalc();"/>
            <input type="hidden" id="grandtot" name="grandtot" value='<s:property value="grandtot"/>'/>       
            
            <label class="lbl-right" style="width:80px; margin-left:auto;">Amount</label>
            <input type="text" id="txtamount" name="txtamount" style="width:120px; text-align:right;" value='<s:property value="txtamount"/>' readonly onblur="funRoundAmt(this.value,this.id);" tabindex="-1"/>
            
            <label class="lbl-right" style="width:80px;">Base Amount</label>
            <input type="text" id="txtbaseamount" name="txtbaseamount" style="width:120px; text-align:right;" readonly value='<s:property value="txtbaseamount"/>' tabindex="-1"/>
        </div>
        
        <div class="field-row" style="margin-bottom:0;">
            <label class="lbl-right" style="width:80px;">Description</label>
            <input type="text" id="txtdescription" name="txtdescription" style="flex:1;" value='<s:property value="txtdescription"/>'/>
        </div>
    </div>

    <div class="middle-panel">
        <span class="middle-panel-title">Details</span>
        <div id="divMCPGrid" class="grid-container">
            <jsp:include page="multipleCashPurchaseGrid.jsp"></jsp:include>
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
        <input type="hidden" name="txtforsearch" id="txtforsearch" value='<s:property value="txtforsearch"/>'>
        <input type="hidden" id="txttrno" name="txttrno" value='<s:property value="txttrno"/>'/>
        <input type="hidden" id="txttranid" name="txttranid" value='<s:property value="txttranid"/>'/>
        <input type="hidden" id="vendorid" name="vendorid" value='<s:property value="vendorid"/>'/>
        <input type="hidden" id="vendor" name="vendor" value='<s:property value="vendor"/>'/>
        <input type="hidden" id="txtvndortotal" name="txtvndortotal" value='<s:property value="txtvndortotal"/>'/>
        <input type="hidden" id="taxchk" name="taxchk" value='<s:property value="taxchk"/>'/>
        <input type="hidden" id="trno" name="trno" value='<s:property value="trno"/>'/>
        <input type="hidden" id="posted" name="posted" value='<s:property value="posted"/>'/>   
        <input type="hidden" id="prdsetrowno" name="prdsetrowno" value='<s:property value="prdsetrowno"/>'/>
    </div>
    
</div>
</form>  

<!-- Search Windows -->
<div id="productSearchwindow"><div></div></div>	
<div id="McpGridWindow"><div></div><div></div></div>  
<div id="accountDetailsFromWindow"><div></div><div></div></div>  
<div id="costTypeSearchGridWindow"><div></div><div></div></div> 
<div id="costCodeSearchWindow"><div></div><div></div></div> 
<div id="vendorinfowindow"><div></div><div></div></div>  
	
</div>
</body>
</html>