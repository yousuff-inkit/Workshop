<% String contextPath=request.getContextPath();%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../includes.jsp"></jsp:include>

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
$(document).ready(function () {     
     /* Set jqxDateTimeInput to 24px height with modern UI theme */
     $("#flmdate").jqxDateTimeInput({width : '125px', height : 24, formatString : "dd.MM.yyyy", theme: 'energyblue'});
    
     /* force internal alignment AFTER render */
     setTimeout(function () {
        $("#flmdate").find("input").css({
            "margin-top": "0px",
            "line-height": "24px",
            "font-size": "12px", 
            "font-family": "Arial, sans-serif", 
            "padding": "0 6px", 
            "box-sizing":"border-box"
        });
        $("#flmdate").find(".jqx-action-button").css({
            "top": "0px",
            "height": "24px"
        });
     }, 0);
    
     document.getElementById("formdet").innerText="Location Master(FLM)";
     document.getElementById("formdetail").value="Location Master";
     document.getElementById("formdetailcode").value="FLM";
     window.parent.formCode.value="FLM";
     window.parent.formName.value="Location Master";
});
    
function funFocus(){
    document.getElementById("flmcode").focus();
}

function funReadOnly() {
    $('#frmloc input').attr('readonly', true);
    $('#flmdate').jqxDateTimeInput({ disabled: true}); 
}

function funRemoveReadOnly() {
    $('#frmloc input').attr('readonly', false);
    $('#flmdate').jqxDateTimeInput({ disabled: false}); 
    $('#docno').attr('readonly', true);
}

function setValues() {
    if($('#hidflmdate').val()){
        $("#flmdate").jqxDateTimeInput('val', $('#hidflmdate').val());
    }
    
    if($('#msg').val()!=""){
        $.messager.alert('Message',$('#msg').val());
    }
}

$(function(){
    $('#frmloc').validate({
             rules: {
             salesmanid: {required:true,maxlength:4},
             salesmanname: {required:true,maxlength:40},
             txtaccname:{required:true},
             telephone:{required:true,digits:true,minlength:12,maxlength:12},
             salesmanmail:{email:true}
             },
             messages: {
              salesmanid:{required:" *",maxlength:"Max 4 Chars."},
              salesmanname:{required:" *",maxlength:"Max 40 Chars."},
              txtaccname:{required:" *"},
              telephone:{required:" *",digits:"Digits only.",minlength:"Min 12 Chars.",maxlength:'Max 12 Chars.'},
              salesmanmail:{email:"Not a valid Email."}
             }
    });
});
    
function funNotify(){
    if(document.getElementById("flmname").value==''){
        document.getElementById("errormsg").innerText="Location Name is Mandatory.";
        return false;
    }
    document.getElementById("errormsg").innerText="";
    return 1;
}

function funChkButton() {
   /* funReset(); */
}
  
function funSearchLoad(){
    changeContent('salesmanSearch.jsp'); 
}
</script>
</head>

<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmloc" action="saveActionloc" method="post" autocomplete="off" >
    <jsp:include page="../../../header.jsp" />

<div class='modern-ui hidden-scrollbar'>
    <div id="errormsg"></div>

    <div class="middle-panel" style="background: #fdfdfd;">
        <span class="middle-panel-title">Location Details</span>
        
        <div class="field-row">
            <label class="lbl-right" style="width:80px;">Date</label>
            <div style="width: 125px;">
                <div id="flmdate" name="flmdate" value='<s:property value="flmdate"/>'></div>
            </div>
            
            <label class="lbl-right" style="width:80px; margin-left:auto;">Doc No.</label>
            <input type="text" id="docno" name="docno" style="width:150px;" value='<s:property value="docno"/>' readonly tabindex="-1">
        </div>

        <div class="field-row" style="margin-bottom:0;">
            <label class="lbl-right" style="width:80px;">Code</label>
            <input type="text" name="flmcode" id="flmcode" style="width:150px;" placeholder="Location Code" value='<s:property value="flmcode"/>'>
            
            <label class="lbl-right" style="width:80px; margin-left:8px;">Name</label>
            <input type="text" name="flmname" id="flmname" style="flex:1;" placeholder="Location Name" value='<s:property value="flmname"/>'>
        </div>
    </div>

    <!-- Location Grid -->
    <div id="locgrid" style="margin-bottom:15px;">
        <jsp:include page="locationGrid.jsp"></jsp:include>
    </div>

    <!-- Hidden Fields -->
    <div style="display:none;">
        <input type="hidden" name="hidflmdate" id="hidflmdate" value='<s:property value="hidflmdate"/>'/>
        <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'/>
        <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
        <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
    </div>
    
</div>
</form>

<div id="jqxSalesmanSearch1"></div>
    
<div id="accountWindow">
    <div></div><div></div>
</div>  
    
</div>
</body>
</html>