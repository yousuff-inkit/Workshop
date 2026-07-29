<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<% String contextPath=request.getContextPath();%>
<html>
<head>
<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
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
    height: calc(100vh - 80px);
    padding-right: 5px;
}
.hidden-scrollbar::-webkit-scrollbar { width: 6px; }
.hidden-scrollbar::-webkit-scrollbar-thumb { background: #c5d3e0; border-radius: 3px; }

form label.error { color:red; font-weight:bold; }
#errormsg { color:red; font-weight:bold; text-align:center; margin-bottom: 10px; }
</style>

<script type="text/javascript">
$(document).ready(function () {  
    $('#btnvaluechange').hide();
    
    $("#masterdate").jqxDateTimeInput({  width: '125px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
    
    setTimeout(function () {
        $("#masterdate").find("input").css({
            "margin-top": "0px", "line-height": "24px", "font-size": "12px", 
            "font-family": "Arial, sans-serif", "padding": "0 6px", "box-sizing":"border-box"
        });
        $("#masterdate").find(".jqx-action-button").css({"top": "0px", "height": "24px"});
    }, 0);
    
    $('#accountSearchwindow').jqxWindow({ width: '50%', height: '62%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Account Search' ,position: { x: 150, y: 60 }, keyboardCloseKey: 27, theme: 'energyblue'});
    $('#accountSearchwindow').jqxWindow('close');
    $('#searchwndow').jqxWindow({ width: '50%', height: '55%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Product Search' , position: { x: 250, y: 120 }, keyboardCloseKey: 27, theme: 'energyblue'});
    $('#searchwndow').jqxWindow('close');  
    $('#sidesearchwndow').jqxWindow({  width: '55%', height: '90%', maxHeight: '90%' ,maxWidth: '80%' ,title: 'Product Search ' , position: { x: 600, y: 0 }, keyboardCloseKey: 27, theme: 'energyblue'});
    $('#sidesearchwndow').jqxWindow('close');   
    
    $('#searchwindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '75%' ,maxWidth: '50%' , title: ' Search' ,position: { x: 500, y: 60 }, keyboardCloseKey: 27, theme: 'energyblue'});
    $('#searchwindow').jqxWindow('close'); 
    
    $('#refnosearchwindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '75%' ,maxWidth: '50%' , title: ' Search' ,position: { x: 500, y: 60 }, keyboardCloseKey: 27, theme: 'energyblue'});
    $('#refnosearchwindow').jqxWindow('close'); 
    
    $('#importwindow').jqxWindow({ width: '30%', height: '24.4%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Import Options' , position: { x: 500, y: 200 }, theme: 'energyblue', showCloseButton: false});
    $('#importwindow').jqxWindow('close');   
    
    $('#locationwindow').jqxWindow({ width: '30%', height: '55%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Location Search' ,position: { x: 200, y: 70 }, keyboardCloseKey: 27, theme: 'energyblue'});
    $('#locationwindow').jqxWindow('close');  
       
    $('#itemdocno').dblclick(function(){
        if($("#mode").val() == "A" || $("#mode").val() == "E") {
            $('#searchwindow').jqxWindow('open');
            if(document.getElementById("itemtype").value=="1") {
                refsearchContent1('costCodeSearchGrid.jsp?docno='+document.getElementById("itemtype").value); 	
            } else if(document.getElementById("itemtype").value=="6") {
                refsearchContent1('fleetGrid.jsp?'); 	
            } else {
                refsearchContent1('costunitsearch.jsp?docno='+document.getElementById("itemtype").value); 	
            }
        }
    }); 
          
    $('#txtlocation').dblclick(function(){
        if($("#mode").val() == "A" || $("#mode").val() == "E") {
            $('#locationwindow').jqxWindow('open');
            locationsearchContent('searchlocation.jsp?'); 
        }
    }); 
       
    $('#rrefno').dblclick(function(){
        if($("#mode").val() == "A") {
            $('#refnosearchwindow').jqxWindow('open');
            refsearchContent('refsearch.jsp?'); 
        }
    }); 
       
    $('#masterdate').on('change', function (event) {
        var maindate = $('#masterdate').jqxDateTimeInput('getDate');
        if ($("#mode").val() == "A" || $("#mode").val() == "E" ) {   
            funDateInPeriodchk(maindate);
        }
    });
});

function getitem(event){
    var x= event.keyCode;
    if(x==114){
        $('#searchwindow').jqxWindow('open');
        if(document.getElementById("itemtype").value=="1") {
            refsearchContent1('costCodeSearchGrid.jsp?docno='+document.getElementById("itemtype").value); 	
        } else if(document.getElementById("itemtype").value=="6") {
            refsearchContent1('fleetGrid.jsp?'); 	
        } else {
            refsearchContent1('costunitsearch.jsp?docno='+document.getElementById("itemtype").value); 	
        }
    }
}  

function refsearchContent1(url) {
    $.get(url).done(function (data) {
        $('#searchwindow').jqxWindow('setContent', data);
    }); 
}

function productSearchContent(url) {
    $.get(url).done(function (data) {
        $('#sidesearchwndow').jqxWindow('open');
        $('#sidesearchwndow').jqxWindow('setContent', data);
    }); 
} 

function getloc(event){
    var x= event.keyCode;
    if(x==114){
        $('#locationwindow').jqxWindow('open');
        locationsearchContent('searchlocation.jsp?');   
    }
}  

function locationsearchContent(url) {
    $.get(url).done(function (data) {
        $('#locationwindow').jqxWindow('setContent', data);
    }); 
}

function getrefDetails(event){
    var x= event.keyCode;
    if(x==114){
        $('#refnosearchwindow').jqxWindow('open');
        refsearchContent('refsearch.jsp?'); 
    }
}  

function refsearchContent(url) {
    $.get(url).done(function (data) {
        $('#refnosearchwindow').jqxWindow('setContent', data);
    }); 
}

function funReset(){
    //$('#frmgir')[0].reset(); 
}

function funReadOnly(){
    $('#frmgir input').attr('readonly', true );
    $('#frmgir select').attr('disabled', true );
    $('#masterdate').jqxDateTimeInput({ disabled: true});
    $("#serviecGrid").jqxGrid({ disabled: true});
    $('#rrefno').attr('disabled', true);
    $('#type').attr('disabled', true);
    $('#itemtype').attr('disabled', true);
    $('#btnvaluechange').hide();
}

function funRemoveReadOnly(){
    chkmultiqty();
    document.getElementById("editdata").value="";
    $('#frmgir input').attr('readonly', false );
    $('#frmgir select').attr('disabled', false );
    $('#btnvaluechange').hide();
    
    $('#txtlocation').attr('readonly', true);
    $('#rrefno').attr('disabled', true);
    $('#itemdocno').attr('readonly', true);
    $('#itemname').attr('readonly', true);
    $('#clientname').attr('readonly', true);
    $('#site').attr('readonly', true);
    
    $('#masterdate').jqxDateTimeInput({ disabled: false});
    $('#docno').attr('readonly', true);
    $("#serviecGrid").jqxGrid({ disabled: false});

    if ($("#mode").val() == "A") {
        $('#masterdate').val(new Date());
        $('#rrefno').attr('disabled', true);
        $("#serviecGrid").jqxGrid('clear');
        $("#serviecGrid").jqxGrid('addrow', null, {});
        $('#itemname').attr('readonly', true);
        $('#clientname').attr('readonly', true);
        $('#site').attr('readonly', true);
        if(document.getElementById('reftype').value=="DIR") {
            $('#serviecGrid').jqxGrid('showcolumn', 'cost_price'); 
        } else {
            $('#serviecGrid').jqxGrid('hidecolumn', 'cost_price');
        } 
    }
    
    if ($("#mode").val() == "E") {
        $('#btnvaluechange').show();
        $("#serviecGrid").jqxGrid({ disabled: true});
        
        if($('#reftype').val()=="DIR") {
            $('#type').attr('disabled', false);
            $('#itemtype').attr('disabled', false);
        } else {
            $('#type').attr('disabled', true);
            $('#itemtype').attr('disabled', true);
        }
    }  
}

function funcheckaccinvendor() {
    if(document.getElementById("puraccid").value=="") {
        document.getElementById("errormsg").innerText="Search Vendor";  
        document.getElementById("puraccid").focus();
        return 0;
    }
}

function funFocus(){
    $('#masterdate').jqxDateTimeInput('focus'); 	    		
}

function funDateInPeriodchk(value){
    var styear = new Date(window.parent.txtaccountperiodfrom.value);
    var edyear = new Date(window.parent.txtaccountperiodto.value);
    var mclose = new Date(window.parent.monthclosed.value);
    mclose.setHours(0,0,0,0);
    edyear.setHours(0,0,0,0);
    styear.setHours(0,0,0,0);
    var currentDate = new Date(new Date());
 
    if(value>currentDate){
        document.getElementById("errormsg").innerText="Future Date, Transaction Restricted. ";
        return 0;
    } 
    document.getElementById("errormsg").innerText="";
    return 1;
}

function funNotify(){	
    var maindate = $('#masterdate').jqxDateTimeInput('getDate');
    var validdate=funDateInPeriodchk(maindate);
    if(validdate==0){
        return 0; 
    }
       
    if(document.getElementById("txtlocation").value=="") {
        document.getElementById("errormsg").innerText="Search Location";  
        document.getElementById("txtlocation").focus();
        return 0;
    } else {
        document.getElementById("errormsg").innerText="";
    }

    if($('#reftype').val()=="DIR") {
        var rows = $("#serviecGrid").jqxGrid('getrows');
        for(var i=0 ; i < rows.length ; i++){
            if(parseInt(rows[i].prodoc)>0) {
                if(rows[i].cost_price=="" ||typeof(rows[i].cost_price)=="undefined"||typeof(rows[i].cost_price)=="NaN") {
                    document.getElementById("errormsg").innerText="Cost Has Been Entered";  
                    return 0;
                }
            } 
        }
    }
     
    var rows = $("#serviecGrid").jqxGrid('getrows');
    $('#serviecGridlength').val(rows.length);
    for(var i=0 ; i < rows.length ; i++){
        newTextBox = $(document.createElement("input"))  
            .attr("type", "dil")
            .attr("id", "sertest"+i)
            .attr("name", "sertest"+i)
            .attr("hidden", "true");         
        newTextBox.val(rows[i].psrno+"::"+rows[i].prodoc+" :: "+rows[i].unitdocno+" :: "+rows[i].qty+" :: "  
                   +rows[i].saveqty+" :: "+rows[i].checktype+" :: "+rows[i].specid+" :: "+rows[i].foc+" ::"
                   +rows[i].cost_price+" ::"+rows[i].savecost_price+"::"+rows[i].stkid+"::"+rows[i].rdocno+"::"+rows[i].detdocno);
        newTextBox.appendTo('form');
    }   
    
    $("#serviecGrid").jqxGrid({ disabled: false});
    $('#frmgir input').attr('disabled', false );	   
    $('#frmgir select').attr('disabled', false );	   
    
    return 1;
} 

function funwarningopen(){
    $.messager.confirm('Confirm', 'Transaction Will Affect Already Inserted Values.', function(r){
        if (r){
            document.getElementById("editdata").value="Editvalue";
            $("#serviecGrid").jqxGrid({ disabled: false});
            $("#serviecGrid").jqxGrid('addrow', null, {});
        }
    });
}

function funChkButton() {}

function funSearchLoad(){
    changeContent('mainsearch.jsp'); 
}

function getCurrencyIds(){}
function getRatevalue(angel){}

function combochange() {
    if($('#reftypeval').val()!="") {
        $('#reftype').val($('#reftypeval').val());
    }
    if($('#reftypeval').val()=="GIS") {
        $('#rrefno').attr('disabled', false);
        $('#rrefno').attr('readonly', true);
        $('#serviecGrid').jqxGrid('hidecolumn', 'cost_price');
    }
}

function setValues() {
    if($('#hidmasterdate').val()){
        $("#masterdate").jqxDateTimeInput('val', $('#hidmasterdate').val());
    }
    
    var dis=document.getElementById("masterdoc_no").value;
    if(dis>0) {     
        funchkforedit();
        var indexval1 = document.getElementById("masterdoc_no").value;   
        var locationid=document.getElementById("txtlocationid").value;
        var reftype=document.getElementById("reftypeval").value;
        var refmasterdoc_no=document.getElementById("refmasterdoc_no").value;
        $("#sevdesc").load("serviecgrid.jsp?purdoc="+indexval1+"&locationid="+locationid+"&reftype="+reftype+"&reqdoc="+refmasterdoc_no);
    } 

    if($('#msg').val()!=""){
        $.messager.alert('Message',$('#msg').val());
    } 
    
    combochange();
    document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
} 

function funPrintBtn(){
    if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
        var url=document.URL;
        var reurl=url.split("saveActionginsreturn");
        $("#docno").prop("disabled", false);                
        var dtype=$('#formdetailcode').val();
        var win= window.open(reurl[0]+"printGIR?docno="+document.getElementById("masterdoc_no").value+"&dtype="+dtype,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
        win.focus();
    } else {
        $.messager.alert('Message','Select a Document....!','warning');
        return false;
    }
}

$(function(){
    $('#frmgir').validate({
        rules: { 
            delterms:{maxlength:200},
            purdesc:{maxlength:200},
            payterms:{maxlength:200},
            puraccid:{required:true}
        },
        messages: {
            delterms: {maxlength:"  Max 200 chars"},
            purdesc: {maxlength:"  Max 200 chars"},
            payterms: {maxlength:"  Max 200 chars"},
            puraccid: {required:" *"}
        }
    });
});

function isNumber(evt) {
    var iKeyCode = (evt.which) ? evt.which : evt.keyCode
    if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57)) {
        document.getElementById("errormsg").innerText=" Enter Numbers Only";  
        return false;
    }
    document.getElementById("errormsg").innerText="";  
    return true;
}

function funchkforedit() {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText.trim();	
            if(parseInt(items)>0) {
                $("#btnEdit").attr('disabled', true );
                $("#btnDelete").attr('disabled', true ); 
            }
        }
    }
    x.open("GET", "linkchk.jsp?masterdoc_no="+document.getElementById("masterdoc_no").value, true);
    x.send();
}
 
function removemsg() {
    document.getElementById("errormsg").innerText="";
}

function gettype(){ 
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200) {
            items= x.responseText;
            items=items.split('####');
            var docno=items[0].split(",");
            var type=items[1].split(",");
            var optionstype = '<option></option>';
            for ( var i = 0; i < type.length; i++) {
                optionstype += '<option value="' + docno[i] + '">' + type[i] + '</option>';
            }
            $("select#type").html(optionstype); 	
            if($('#hidtype').val()!="") {
                $('#type').val($('#hidtype').val());   
            }
        }
    }
    x.open("GET","gettype.jsp?",true);
    x.send();
}

function getitemtype(){ 
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200) {
            items= x.responseText;
            items=items.split('####');
            var docno=items[0].split(",");
            var type=items[1].split(",");
            var optionstype = '<option></option>';
            for ( var i = 0; i < type.length; i++) {
                optionstype += '<option value="' + docno[i] + '">' + type[i] + '</option>';
            }
            $("select#itemtype").html(optionstype); 	
            if($('#hideitemtype').val()!="") {
                $('#itemtype').val($('#hideitemtype').val());   
            }
        }
    }
    x.open("GET","getitem.jsp?",true);
    x.send();
}
 
function cleardata() {
    document.getElementById("itemdocno").value="";
    document.getElementById("itemname").value="";
    document.getElementById("clientname").value="";
    document.getElementById("cldocno").value="";
    document.getElementById("siteid").value="";
    document.getElementById("site").value="";
}

function funrefdisslno() {
    if(document.getElementById('reftype').value=="DIR") {
        $('#rrefno').attr('disabled', true);
        $('#rrefno').attr('readonly', true);
        $('#type').attr('disabled', false);
        $('#itemtype').attr('disabled', false);
        document.getElementById("rrefno").value="";
        document.getElementById("refmasterdoc_no").value="";
        $("#serviecGrid").jqxGrid('clear');
        $("#serviecGrid").jqxGrid('addrow', null, {});
        document.getElementById("errormsg").innerText="";
        $('#serviecGrid').jqxGrid('showcolumn', 'cost_price');
    } else {
        $('#rrefno').attr('disabled', false);
        $('#rrefno').attr('readonly', true);
        document.getElementById("rrefno").value="";
        document.getElementById("refmasterdoc_no").value="";
        $("#serviecGrid").jqxGrid('clear');
        $("#serviecGrid").jqxGrid('addrow', null, {});
        $('#type').attr('disabled', true);
        $('#itemtype').attr('disabled', true);
        $('#serviecGrid').jqxGrid('hidecolumn', 'cost_price');
    }
}
</script>
</head>
<body onLoad="setValues();gettype();getitemtype();">

<div id="mainBG" class="homeContent" data-type="background">
<form id="frmgir" action="saveActionginsreturn" method="post" autocomplete="off">  
<jsp:include page="../../../../header.jsp" />   
<jsp:include page="multiqty.jsp"></jsp:include>

<div class="modern-ui hidden-scrollbar">
    <div id="errormsg"></div>

    <!-- General Details Panel -->
    <div class="middle-panel">
        <span class="middle-panel-title">GIR Details</span>
        
        <div class="field-row">
            <label class="lbl-right" style="width:100px;">Date</label>
            <div style="width: 125px;">
                <div id="masterdate" name="masterdate" value='<s:property value="masterdate"/>'></div>
            </div>
            <input type="hidden" name="hidmasterdate" id="hidmasterdate" value='<s:property value="hidmasterdate"/>'>
            
            <label class="lbl-right" style="width:100px; margin-left:auto;">Doc No</label>
            <input type="text" name="docno" id="docno" style="width:150px;" tabindex="-1" value='<s:property value="docno"/>' readonly="readonly">
            
            <label class="lbl-right" style="width:100px; margin-left:auto;">Ref No</label>
            <input type="text" name="refno" id="refno" style="width:150px;" value='<s:property value="refno"/>'>
        </div>

        <div class="field-row">
            <label class="lbl-right" style="width:100px;">Ref Type</label>
            <select id="reftype" name="reftype" style="width:125px;" onchange="funrefdisslno();">
                <option value="DIR">DIR</option>
                <option value="GIS">GIS</option>
            </select>
            
            <div class="input-search-container" style="width:150px; margin-left:10px;">
                <input type="text" id="rrefno" name="rrefno" placeholder="Press F3" value='<s:property value="rrefno"/>' onKeyDown="getrefDetails(event);">
                <svg class="magnifier-icon" onclick="$('#rrefno').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
            </div>
            <input type="hidden" id="reqmasterdocno" name="reqmasterdocno" value='<s:property value="reqmasterdocno"/>'>
            
            <label class="lbl-right" style="width:100px; margin-left:auto;">Location</label>
            <div class="input-search-container" style="flex:1; max-width:250px;">
                <input type="text" id="txtlocation" name="txtlocation" placeholder="Press F3 to Search" value='<s:property value="txtlocation"/>' onkeydown="getloc(event);">
                <svg class="magnifier-icon" onclick="$('#txtlocation').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
            </div>
            <input type="hidden" id="txtlocationid" name="txtlocationid" value='<s:property value="txtlocationid"/>'>
        </div>

        <div class="field-row">
            <label class="lbl-right" style="width:100px;">Type</label>
            <select id="type" name="type" style="width:125px;">
                <option></option>
            </select>
            
            <label class="lbl-right" style="width:100px; margin-left:auto;">Item Info</label>
            <select id="itemtype" name="itemtype" style="width:125px;" onchange="cleardata()">
                <option></option>
            </select>
            
            <div class="input-search-container" style="width:150px; margin-left:10px;">
                <input type="text" id="itemdocno" name="itemdocno" placeholder="Press F3" value='<s:property value="itemdocno"/>'>
                <svg class="magnifier-icon" onclick="$('#itemdocno').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
            </div>
            <input type="text" id="itemname" name="itemname" style="flex:1; max-width:250px;" value='<s:property value="itemname"/>' onkeydown="getitem(event);">
        </div>

        <div class="field-row">
            <label class="lbl-right" style="width:100px;">Client</label>
            <input type="text" id="clientname" name="clientname" style="width:285px;" value='<s:property value="clientname"/>'>
            <input type="hidden" id="cldocno" name="cldocno" value='<s:property value="cldocno"/>'>
            
            <label class="lbl-right" style="width:60px; margin-left:15px;">Site</label>
            <input type="text" name="site" id="site" style="flex:1; max-width:250px;" value='<s:property value="site"/>'>
            <input type="hidden" name="siteid" id="siteid" value='<s:property value="siteid"/>'>
        </div>

        <div class="field-row" style="margin-bottom:0;">
            <label class="lbl-right" style="width:100px;">Description</label>
            <input type="text" name="purdesc" id="purdesc" style="flex:1;" value='<s:property value="purdesc"/>'>
            <button class="myButton" type="button" id="btnvaluechange" name="btnvaluechange" onclick="funwarningopen();" style="margin-left: 10px;">Value Change</button>
        </div>
    </div>
    
    <!-- Grid Panel -->
    <div class="middle-panel">
        <span class="middle-panel-title">Service Details Grid</span>
        <div class="grid-container">
            <div id="sevdesc"><jsp:include page="serviecgrid.jsp"></jsp:include></div>
        </div>
    </div>
    
    <!-- Hidden Elements -->
    <div style="display:none;">
        <input type="hidden" name="gridtext" id="gridtext" value='<s:property value="gridtext"/>'/>   
        <input type="hidden" name="gridtext1" id="gridtext1" value='<s:property value="gridtext1"/>'/>  
        <input type="hidden" name="productTotal" readonly="readonly" id="productTotal" value='<s:property value="productTotal"/>'>
        <input type="hidden" name="prddiscount" id="prddiscount" value='<s:property value="prddiscount"/>'>
        <input type="hidden" name="netTotaldown" readonly="readonly" id="netTotaldown" value='<s:property value="netTotaldown"/>'>
        <input type="hidden" id="costtr_no" name="costtr_no" value='<s:property value="costtr_no"/>'/> 
        <input type="hidden" id="hideitemtype" name="hideitemtype" value='<s:property value="hideitemtype"/>'/> 
        <input type="hidden" id="hidetype" name="hidetype" value='<s:property value="hidetype"/>'/>
        <input type="hidden" id="masterdoc_no" name="masterdoc_no" value='<s:property value="masterdoc_no"/>'/>
        <input type="hidden" id="refmasterdoc_no" name="refmasterdoc_no" value='<s:property value="refmasterdoc_no"/>'/>
        <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
        <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>   
        <input type="hidden" id="rowval" name="rowval" value='<s:property value="rowval"/>'/> 
        <input type="hidden" id="accdocno" name="accdocno" value='<s:property value="accdocno"/>'/>  
        <input type="hidden" id="descgridlenght" name="descgridlenght" value='<s:property value="descgridlenght"/>'/>    
        <input type="hidden" id="cmbcurrval" name="cmbcurrval" value='<s:property value="cmbcurrval"/>'/>    
        <input type="hidden" id="acctypeval" name="acctypeval" value='<s:property value="acctypeval"/>'/>  
        <input type="hidden" id="reftypeval" name="reftypeval" value='<s:property value="reftypeval"/>'/>  
        <input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
        <input type="hidden" id="acctypegrid" name="acctypegrid" value='<s:property value="acctypegrid"/>'/>
        <input type="hidden" id="serviecGridlength" name="serviecGridlength" value='<s:property value="serviecGridlength"/>'/>  
        <input type="hidden" id="hidelocation" name="hidelocation" value='<s:property value="hidelocation"/>'/>
        <input type="hidden" id="editdata" name="editdata" value='<s:property value="editdata"/>'/>
    </div>
</div>
</form>

<!-- Dialog Windows -->
<div id="refnosearchwindow"><div></div></div>
<div id="searchwindow"><div></div></div>
<div id="accountSearchwindow"><div></div></div>
<div id="sidesearchwndow"><div></div></div>
<div id="importwindow"><div></div></div>
<div id="searchwndow"><div></div></div>
<div id="locationwindow"><div></div></div>

</div>
</body>
</html>