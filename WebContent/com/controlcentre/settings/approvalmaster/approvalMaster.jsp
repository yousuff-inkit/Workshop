<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>

<style>
/* =========================================================
SCOPED UI: Modern Layout (Plain White Background)
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

/* Layout Utilities - Tightened Spacing */
.modern-ui .field-row { 
    display: flex;
    align-items: center; 
    gap: 8px;
    margin-bottom: 8px; 
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

/* Middle Section Panels - Reduced Padding */
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
    color: #0056b3;
    font-weight: bold; 
    font-size: 13px; 
    border-left: 3px solid #0056b3;
    z-index: 2; 
    line-height: normal; 
    display: flex;
    align-items: center;
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
    display: inline-flex;
    align-items: center;
    justify-content: center;
    gap: 4px;
}
.modern-ui .myButton:hover { background: linear-gradient(135deg, #083a8a 0%, #1d4ed8 100%); }

.modern-ui .btn-remove {
    background: linear-gradient(135deg, #ef4444 0%, #dc2626 100%);
}
.modern-ui .btn-remove:hover {
    background: linear-gradient(135deg, #dc2626 0%, #b91c1c 100%);
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

/* Override jqxTabs background to be clean white */
#jqxTabs .jqx-tabs-content-element { background: #ffffff !important; padding: 15px; }
#jqxTabs .jqx-widget-header { background: #f8f9fa !important; border-bottom: 1px solid #e2e8f0; }

</style>
<script type="text/javascript">
$(document).ready(function () {
    document.getElementById("txtuserdoc").value="0";
    
    $('#userWindow').jqxWindow({ width: '50%', height: '55%',  maxHeight: '55%' ,maxWidth: '55%' ,theme: 'energyblue',title: 'User Search' , position: { x: 150, y: 100 }, keyboardCloseKey: 27});
    $('#userWindow').jqxWindow('close');
    
    $('#userinfoWindow').jqxWindow({ width: '50%', height: '58%',  maxHeight: '75%' ,maxWidth: '50%' ,theme: 'energyblue',title: 'Type Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
    $('#userinfoWindow').jqxWindow('close');
    
    $('#jqxTabs').jqxTabs({ height:"auto", width: '100%',theme: 'energyblue',animationType: 'fade' });
    
    $('#doctype').dblclick(function(){
        if ($("#mode").val() == "A") {       
            $('#userinfoWindow').jqxWindow('open');
            changeContent2('doctypesearch.jsp');
        }
    });
});
     
function funReset(){
    //$('#frmApprovalMaster')[0].reset(); 
}

function funReadOnly(){
    $("#main *").attr("disabled",true);
    $("#lev1 *").attr("disabled",true);
    $("#lev2 *").attr("disabled",true);
    $("#lev3 *").attr("disabled",true);
    $('#frmApprovalMaster input').attr('readonly', true );
    $("#jqxTabs").attr("disabled",false);
}

function funRemoveReadOnly(){
    $('#frmApprovalMaster input').attr('readonly', false );
    $("#main *").attr("disabled",false);
    $("#lev1 *").attr("disabled",false);
    $("#lev2 *").attr("disabled",false);
    $("#lev3 *").attr("disabled",false);
    document.getElementById("txtuserdoc").value="0";
    
    $("#txtfinal_user1, #txtfinal_userfull1").attr("readonly",true);
    $("#txtfinal_user2, #txtfinal_userfull2").attr("readonly",true);
    $("#txtfinal_user3, #txtfinal_userfull3").attr("readonly",true);
    $("#txtfinal_user4, #txtfinal_userfull4").attr("readonly",true);
    $("#txtfinal_user5, #txtfinal_userfull5").attr("readonly",true);
    
    $("#txtsecond_user1, #txtsecond_userfull1").attr("readonly",true);
    $("#txtsecond_user2, #txtsecond_userfull2").attr("readonly",true);
    $("#txtsecond_user3, #txtsecond_userfull3").attr("readonly",true);
    $("#txtsecond_user4, #txtsecond_userfull4").attr("readonly",true);
    $("#txtsecond_user5, #txtsecond_userfull5").attr("readonly",true);
    
    $("#txtfirst_user1, #txtfirst_userfull1").attr("readonly",true);
    $("#txtfirst_user2, #txtfirst_userfull2").attr("readonly",true);
    $("#txtfirst_user3, #txtfirst_userfull3").attr("readonly",true);
    $("#txtfirst_user4, #txtfirst_userfull4").attr("readonly",true);
    $("#txtfirst_user5, #txtfirst_userfull5").attr("readonly",true);
    
    $('#docno').attr('readonly', true);
    $('#doctype').attr('readonly', true);
    $('#doctypename').attr('readonly', true);
    
    document.getElementById("txtfinal_minapproval").value="0";
    document.getElementById("txtsecond_minapproval").value="0";
    document.getElementById("txtfirst_minapproval").value="0";
    
    if($('#mode').val()=="A") {
        view();
    }
}

var user1 = 0;
var j = 0;
var k = 0;  

//Tab1
function addUser1(){    
    if(document.getElementById("doctype").value==""){
        document.getElementById("errormsg").innerText="Search Doc Type";
        document.getElementById("doctype").focus();
        return 0;
    }
    
    if($('#mode').val()=="E"){
        if(parseInt(document.getElementById("txtfinal_userdoc1").value)>0) user1=1;
        if(parseInt(document.getElementById("txtfinal_userdoc2").value)>0) user1=2;
        if(parseInt(document.getElementById("txtfinal_userdoc3").value)>0) user1=3;
        if(parseInt(document.getElementById("txtfinal_userdoc4").value)>0) user1=4;
    }
    
    user1++;
    if(user1==1) $("#user1").show();      
    if(user1==2) $("#user2").show();
    if(user1==3) $("#user3").show();
    if(user1==4) $("#user4").show();
    if(user1==5) $("#user5").show();
}

//Tab2
function addUsr1(){ 
    if(document.getElementById("doctype").value==""){
        document.getElementById("errormsg").innerText="Search Doc Type";
        document.getElementById("doctype").focus();
        return 0;
    }
    if($('#mode').val()=="E"){
        if(parseInt(document.getElementById("txtsecond_userdoc1").value)>0) j=1;
        if(parseInt(document.getElementById("txtsecond_userdoc2").value)>0) j=2;
        if(parseInt(document.getElementById("txtsecond_userdoc3").value)>0) j=3;
        if(parseInt(document.getElementById("txtsecond_userdoc4").value)>0) j=4;
    }
    
    j++;        
    if(j==1) $("#usr1").show();         
    if(j==2) $("#usr2").show();
    if(j==3) $("#usr3").show();
    if(j==4) $("#usr4").show();
    if(j==5) $("#usr5").show();
}
 
//Tab3
function addUsers1(){
    if(document.getElementById("doctype").value==""){
        document.getElementById("errormsg").innerText="Search Doc Type";
        document.getElementById("doctype").focus();
        return 0;
    }
    if($('#mode').val()=="E"){
        if(parseInt(document.getElementById("txtfirst_userdoc1").value)>0) k=1;
        if(parseInt(document.getElementById("txtfirst_userdoc2").value)>0) k=2;
        if(parseInt(document.getElementById("txtfirst_userdoc3").value)>0) k=3;
        if(parseInt(document.getElementById("txtfirst_userdoc4").value)>0) k=4;
    }
    k++;        
    if(k==1) $("#new_user1").show();          
    if(k==2) $("#new_user2").show();
    if(k==3) $("#new_user3").show();
    if(k==4) $("#new_user4").show();
    if(k==5) $("#new_user5").show();
}

function view(){    
    if(parseInt(document.getElementById("txtfinal_userdoc1").value)>0) $("#user1").show(); else $("#user1").hide(); 
    if(parseInt(document.getElementById("txtfinal_userdoc2").value)>0) $("#user2").show(); else $("#user2").hide(); 
    if(parseInt(document.getElementById("txtfinal_userdoc3").value)>0) $("#user3").show(); else $("#user3").hide(); 
    if(parseInt(document.getElementById("txtfinal_userdoc4").value)>0) $("#user4").show(); else $("#user4").hide(); 
    if(parseInt(document.getElementById("txtfinal_userdoc5").value)>0) $("#user5").show(); else $("#user5").hide(); 
    
    if(parseInt(document.getElementById("txtsecond_userdoc1").value)>0) $("#usr1").show(); else $("#usr1").hide(); 
    if(parseInt(document.getElementById("txtsecond_userdoc2").value)>0) $("#usr2").show(); else $("#usr2").hide(); 
    if(parseInt(document.getElementById("txtsecond_userdoc3").value)>0) $("#usr3").show(); else $("#usr3").hide(); 
    if(parseInt(document.getElementById("txtsecond_userdoc4").value)>0) $("#usr4").show(); else $("#usr4").hide(); 
    if(parseInt(document.getElementById("txtsecond_userdoc5").value)>0) $("#usr5").show(); else $("#usr5").hide(); 
    
    if(parseInt(document.getElementById("txtfirst_userdoc1").value)>0) $("#new_user1").show(); else $("#new_user1").hide(); 
    if(parseInt(document.getElementById("txtfirst_userdoc2").value)>0) $("#new_user2").show(); else $("#new_user2").hide(); 
    if(parseInt(document.getElementById("txtfirst_userdoc3").value)>0) $("#new_user3").show(); else $("#new_user3").hide(); 
    if(parseInt(document.getElementById("txtfirst_userdoc4").value)>0) $("#new_user4").show(); else $("#new_user4").hide(); 
    if(parseInt(document.getElementById("txtfirst_userdoc5").value)>0) $("#new_user5").show(); else $("#new_user5").hide(); 
} 

function getUser(event){
    var x= event.keyCode;
    if(x==114){
        if ($("#mode").val() == "A") {   
            $('#userinfoWindow').jqxWindow('open');
            changeContent2('doctypesearch.jsp');
        }
    }
}
        
function changeContent2(url) {
    $.get(url).done(function (data) {
        $('#userinfoWindow').jqxWindow('setContent', data);
    }); 
}
  
function funSearchBtn11(count,levels){
    var txtuserdoc=document.getElementById("txtuserdoc").value;
    $('#userWindow').jqxWindow('open');
    changeContent1('apprUserSearch.jsp?count='+count+'&levels='+levels+'&txtuserdoc='+txtuserdoc, $('#userWindow'));
}

function funFocus(){}

function funSearchLoad(){
    changeContent('approveSearch.jsp'); 
}
  
function changeContent1(url,fname) {
    $.get(url).done(function (data) {
        $(fname).jqxWindow('setContent', data);
    }); 
}

function funResetbtn1(tab,resets) {
    var resetlevel=resets;
    if(resetlevel=="final") {
        document.getElementById('txtfinal_user'+tab).value='';
        document.getElementById('txtfinal_userfull'+tab).value='';
        document.getElementById('txtfinal_userdoc'+tab).value='';
    }
    if(resetlevel=="second") {
        document.getElementById('txtsecond_user'+tab).value='';
        document.getElementById('txtsecond_userdoc'+tab).value='';            
        document.getElementById('txtsecond_userfull'+tab).value='';
    }
    if(resetlevel=="first") {
        document.getElementById('txtfirst_user'+tab).value='';
        document.getElementById('txtfirst_userdoc'+tab).value='';
        document.getElementById('txtfirst_userfull'+tab).value='';
    }
}

function funChkButton(){
    frmApprovalMaster.submit(); 
}

function funNotify(){
    if(document.getElementById("doctype").value==""){
        document.getElementById("errormsg").innerText="Search Doc Type";
        document.getElementById("doctype").focus();
        return 0;
    }
    return 1;   
}

function setValues() {
    if(parseInt($('#chckfinalmodifyval').val())==1) document.getElementById("chckfinalmodify").checked=true;
    if(parseInt($('#chcksecondmodifyval').val())==1) document.getElementById("chcksecondmodify").checked=true;
    if(parseInt($('#chckfirstmodifyval').val())==1) document.getElementById("chckfirstmodify").checked=true;

    if($('#msg').val()!=""){
        $.messager.alert('Message',$('#msg').val());
    } 
    funSetlabel();
}
</script>
</head>

<body onload="view();setValues();" class='default'>
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmApprovalMaster" action="saveApprovalMaster" method="post" autocomplete="off" > 
<jsp:include page="../../../../header.jsp"></jsp:include>

<div class='modern-ui hidden-scrollbar'>
    <div id="errormsg"></div>

    <div class="middle-panel" id="main">
        <span class="middle-panel-title">Approval Master</span>
        
        <div class="field-row">
            <label class="lbl-right" style="width:80px;">Doc Type</label>
            <div class="input-search-container" style="width:150px;">
                <input type="text" id="doctype" name="doctype" placeholder="Press F3" value='<s:property value="doctype"/>' required="required" onKeyDown="getUser(event);" readonly/>
                <svg class="magnifier-icon" onclick="$('#doctype').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
            </div>
            
            <input type="text" id="doctypename" name="doctypename" style="flex:1; margin-left:8px;" value='<s:property value="doctypename"/>' readonly /> 
            
            <label class="lbl-right" style="width:80px; margin-left:15px;">Doc No</label>
            <input type="text" id="docno" name="docno" tabindex="-1" style="width:150px;" value='<s:property value="docno"/>' readonly/>
        </div>
    </div>

    <div id="jqxTabs">
        <ul>
            <li>Final Level</li>
            <li>Second Level</li>
            <li>First Level</li>
        </ul>
 
        <!-- Tab 1: Final Level -->
        <div id="level1">
            <div class="field-row" style="margin-top:15px; margin-bottom:15px;" id="lev1">
                <button type="button" class="myButton" id="addUser" name="addUser" onclick="addUser1();">Add User</button>
                
                <label style="display:flex; align-items:center; gap:5px; margin-left:15px; cursor:pointer;">
                    <input type="checkbox" id="chckfinalmodify" name="chckfinalmodify" value="0" onclick="$(this).attr('value', this.checked ? 1 : 0)" /> Modify
                </label>
                
                <label class="lbl-right" style="width:100px; margin-left:auto;">Min. Approval</label>
                <input type="text" id="txtfinal_minapproval" name="txtfinal_minapproval" style="width:80px;" value='<s:property value="txtfinal_minapproval"/>'/>
            </div>
            
            <div id="users">
                <!-- User 1 -->
                <div id="user1">
                    <div class="field-row">
                        <label class="lbl-right" style="width:60px;">User</label>
                        <input type="text" id="txtfinal_user1" name="txtfinal_user1" style="width:120px;" value='<s:property value="txtfinal_user1"/>'/>
                        <input type="hidden" name="txtfinal_userdoc1" id="txtfinal_userdoc1" value='<s:property value="txtfinal_userdoc1"/>'>
                        
                        <input type="text" id="txtfinal_userfull1" name="txtfinal_userfull1" style="flex:1; margin-left:8px;" value='<s:property value="txtfinal_userfull1"/>'/>
                        
                        <button type="button" class="myButton" id="final_btnSearch1" title="Search" onclick="funSearchBtn11(1,'level1')" style="margin-left:15px;">
                            <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg> Search
                        </button>
                        <button type="button" class="myButton btn-remove" id="final_btnCancel1" title="Remove" onclick="funResetbtn1(1,'final')">
                            <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="18" y1="6" x2="6" y2="18"></line><line x1="6" y1="6" x2="18" y2="18"></line></svg> Remove
                        </button>
                    </div>
                </div>
                
                <!-- User 2 -->
                <div id="user2">
                    <div class="field-row">
                        <label class="lbl-right" style="width:60px;">User</label>
                        <input type="text" id="txtfinal_user2" name="txtfinal_user2" style="width:120px;" value='<s:property value="txtfinal_user2"/>'/>
                        <input type="hidden" name="txtfinal_userdoc2" id="txtfinal_userdoc2" value='<s:property value="txtfinal_userdoc2"/>'>
                        
                        <input type="text" id="txtfinal_userfull2" name="txtfinal_userfull2" style="flex:1; margin-left:8px;" value='<s:property value="txtfinal_userfull2"/>'/>
                        
                        <button type="button" class="myButton" id="final_btnSearch2" title="Search" onclick="funSearchBtn11(2,'level1')" style="margin-left:15px;">
                            <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg> Search
                        </button>
                        <button type="button" class="myButton btn-remove" id="final_btnCancel2" title="Remove" onclick="funResetbtn1(2,'final')">
                            <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="18" y1="6" x2="6" y2="18"></line><line x1="6" y1="6" x2="18" y2="18"></line></svg> Remove
                        </button>
                    </div>
                </div>
                
                <!-- User 3 -->
                <div id="user3">
                    <div class="field-row">
                        <label class="lbl-right" style="width:60px;">User</label>
                        <input type="text" id="txtfinal_user3" name="txtfinal_user3" style="width:120px;" value='<s:property value="txtfinal_user3"/>'/>
                        <input type="hidden" name="txtfinal_userdoc3" id="txtfinal_userdoc3" value='<s:property value="txtfinal_userrole3"/>'>
                        
                        <input type="text" id="txtfinal_userfull3" name="txtfinal_userfull3" style="flex:1; margin-left:8px;" value='<s:property value="txtfinal_userfull3"/>'/>
                        
                        <button type="button" class="myButton" id="final_btnSearch3" title="Search" onclick="funSearchBtn11(3,'level1')" style="margin-left:15px;">
                            <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg> Search
                        </button>
                        <button type="button" class="myButton btn-remove" id="final_btnCancel3" title="Remove" onclick="funResetbtn1(3,'final')">
                            <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="18" y1="6" x2="6" y2="18"></line><line x1="6" y1="6" x2="18" y2="18"></line></svg> Remove
                        </button>
                    </div>
                </div>
                
                <!-- User 4 -->
                <div id="user4">
                    <div class="field-row">
                        <label class="lbl-right" style="width:60px;">User</label>
                        <input type="text" id="txtfinal_user4" name="txtfinal_user4" style="width:120px;" value='<s:property value="txtfinal_user4"/>'/>
                        <input type="hidden" name="txtfinal_userdoc4" id="txtfinal_userdoc4" value='<s:property value="txtfinal_userdoc4"/>'>
                        
                        <input type="text" id="txtfinal_userfull4" name="txtfinal_userfull4" style="flex:1; margin-left:8px;" value='<s:property value="txtfinal_userfull4"/>'/>
                        
                        <button type="button" class="myButton" id="final_btnSearch4" title="Search" onclick="funSearchBtn11(4,'level1')" style="margin-left:15px;">
                            <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg> Search
                        </button>
                        <button type="button" class="myButton btn-remove" id="final_btnCancel4" title="Remove" onclick="funResetbtn1(4,'final')">
                            <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="18" y1="6" x2="6" y2="18"></line><line x1="6" y1="6" x2="18" y2="18"></line></svg> Remove
                        </button>
                    </div>
                </div>
                
                <!-- User 5 -->
                <div id="user5">
                    <div class="field-row">
                        <label class="lbl-right" style="width:60px;">User</label>
                        <input type="text" id="txtfinal_user5" name="txtfinal_user5" style="width:120px;" value='<s:property value="txtfinal_user5"/>'/>
                        <input type="hidden" name="txtfinal_userdoc5" id="txtfinal_userdoc5" value='<s:property value="txtfinal_userdoc5"/>'>
                        
                        <input type="text" id="txtfinal_userfull5" name="txtfinal_userfull5" style="flex:1; margin-left:8px;" value='<s:property value="txtfinal_userfull5"/>'/>
                        
                        <button type="button" class="myButton" id="final_btnSearch5" title="Search" onclick="funSearchBtn11(5,'level1')" style="margin-left:15px;">
                            <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg> Search
                        </button>
                        <button type="button" class="myButton btn-remove" id="final_btnCancel5" title="Remove" onclick="funResetbtn1(5,'final')">
                            <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="18" y1="6" x2="6" y2="18"></line><line x1="6" y1="6" x2="18" y2="18"></line></svg> Remove
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Tab 2: Second Level -->
        <div id="level2">
            <div class="field-row" style="margin-top:15px; margin-bottom:15px;" id="lev2">
                <button type="button" class="myButton" id="addUsr" name="addUsr" onclick="addUsr1();">Add User</button>
                
                <label style="display:flex; align-items:center; gap:5px; margin-left:15px; cursor:pointer;">
                    <input type="checkbox" id="chcksecondmodify" name="chcksecondmodify" value="0" onclick="$(this).attr('value', this.checked ? 1 : 0)" /> Modify
                </label>
                
                <label class="lbl-right" style="width:100px; margin-left:auto;">Min. Approval</label>
                <input type="text" id="txtsecond_minapproval" name="txtsecond_minapproval" style="width:80px;" value='<s:property value="txtsecond_minapproval"/>'/>
            </div>
            
            <div id="usrs">
                <!-- Usr 1 -->
                <div id="usr1">
                    <div class="field-row">
                        <label class="lbl-right" style="width:60px;">User</label>
                        <input type="text" id="txtsecond_user1" name="txtsecond_user1" style="width:120px;" value='<s:property value="txtsecond_user1"/>'/>
                        <input type="hidden" name="txtsecond_userdoc1" id="txtsecond_userdoc1" value='<s:property value="txtsecond_userdoc1"/>'>
                        
                        <input type="text" id="txtsecond_userfull1" name="txtsecond_userfull1" style="flex:1; margin-left:8px;" value='<s:property value="txtsecond_userfull1"/>'/>
                        
                        <button type="button" class="myButton" id="second_btnSearch1" title="Search" onclick="funSearchBtn11(1,'level2')" style="margin-left:15px;">
                            <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg> Search
                        </button>
                        <button type="button" class="myButton btn-remove" id="second_btnCancel1" title="Remove" onclick="funResetbtn1(1,'second')">
                            <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="18" y1="6" x2="6" y2="18"></line><line x1="6" y1="6" x2="18" y2="18"></line></svg> Remove
                        </button>
                    </div>
                </div>
                
                <!-- Usr 2 -->
                <div id="usr2">
                    <div class="field-row">
                        <label class="lbl-right" style="width:60px;">User</label>
                        <input type="text" id="txtsecond_user2" name="txtsecond_user2" style="width:120px;" value='<s:property value="txtsecond_user2"/>'/>
                        <input type="hidden" name="txtsecond_userdoc2" id="txtsecond_userdoc2" value='<s:property value="txtsecond_userdoc2"/>'>
                        
                        <input type="text" id="txtsecond_userfull2" name="txtsecond_userfull2" style="flex:1; margin-left:8px;" value='<s:property value="txtsecond_userfull2"/>'/>
                        
                        <button type="button" class="myButton" id="second_btnSearch2" title="Search" onclick="funSearchBtn11(2,'level2')" style="margin-left:15px;">
                            <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg> Search
                        </button>
                        <button type="button" class="myButton btn-remove" id="second_btnCancel2" title="Remove" onclick="funResetbtn1(2,'second')">
                            <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="18" y1="6" x2="6" y2="18"></line><line x1="6" y1="6" x2="18" y2="18"></line></svg> Remove
                        </button>
                    </div>
                </div>
                
                <!-- Usr 3 -->
                <div id="usr3">
                    <div class="field-row">
                        <label class="lbl-right" style="width:60px;">User</label>
                        <input type="text" id="txtsecond_user3" name="txtsecond_user3" style="width:120px;" value='<s:property value="txtsecond_user3"/>'/>
                        <input type="hidden" name="txtsecond_userdoc3" id="txtsecond_userdoc3" value='<s:property value="txtsecond_userdoc3"/>'>
                        
                        <input type="text" id="txtsecond_userfull3" name="txtsecond_userfull3" style="flex:1; margin-left:8px;" value='<s:property value="txtsecond_userfull3"/>'/>
                        
                        <button type="button" class="myButton" id="second_btnSearch3" title="Search" onclick="funSearchBtn11(3,'level2')" style="margin-left:15px;">
                            <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg> Search
                        </button>
                        <button type="button" class="myButton btn-remove" id="second_btnCancel3" title="Remove" onclick="funResetbtn1(3,'second')">
                            <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="18" y1="6" x2="6" y2="18"></line><line x1="6" y1="6" x2="18" y2="18"></line></svg> Remove
                        </button>
                    </div>
                </div>
                
                <!-- Usr 4 -->
                <div id="usr4">
                    <div class="field-row">
                        <label class="lbl-right" style="width:60px;">User</label>
                        <input type="text" id="txtsecond_user4" name="txtsecond_user4" style="width:120px;" value='<s:property value="txtsecond_user4"/>'/>
                        <input type="hidden" name="txtsecond_userdoc4" id="txtsecond_userdoc4" value='<s:property value="txtsecond_userdoc4"/>'>
                        
                        <input type="text" id="txtsecond_userfull4" name="txtsecond_userfull4" style="flex:1; margin-left:8px;" value='<s:property value="txtsecond_userfull4"/>'/>
                        
                        <button type="button" class="myButton" id="second_btnSearch4" title="Search" onclick="funSearchBtn11(4,'level2')" style="margin-left:15px;">
                            <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg> Search
                        </button>
                        <button type="button" class="myButton btn-remove" id="second_btnCancel4" title="Remove" onclick="funResetbtn1(4,'second')">
                            <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="18" y1="6" x2="6" y2="18"></line><line x1="6" y1="6" x2="18" y2="18"></line></svg> Remove
                        </button>
                    </div>
                </div>
                
                <!-- Usr 5 -->
                <div id="usr5">
                    <div class="field-row">
                        <label class="lbl-right" style="width:60px;">User</label>
                        <input type="text" id="txtsecond_user5" name="txtsecond_user5" style="width:120px;" value='<s:property value="txtsecond_user5"/>'/>
                        <input type="hidden" name="txtsecond_userdoc5" id="txtsecond_userdoc5" value='<s:property value="txtsecond_userdoc5"/>'>
                        
                        <input type="text" id="txtsecond_userfull5" name="txtsecond_userfull5" style="flex:1; margin-left:8px;" value='<s:property value="txtsecond_userfull5"/>'/>
                        
                        <button type="button" class="myButton" id="second_btnSearch5" title="Search" onclick="funSearchBtn11(5,'level2')" style="margin-left:15px;">
                            <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg> Search
                        </button>
                        <button type="button" class="myButton btn-remove" id="second_btnCancel5" title="Remove" onclick="funResetbtn1(5,'second')">
                            <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="18" y1="6" x2="6" y2="18"></line><line x1="6" y1="6" x2="18" y2="18"></line></svg> Remove
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Tab 3: First Level -->
        <div id="level3">
            <div class="field-row" style="margin-top:15px; margin-bottom:15px;" id="lev3">
                <button type="button" class="myButton" id="addUsers" name="addUsers" onclick="addUsers1();">Add User</button>
                
                <label style="display:flex; align-items:center; gap:5px; margin-left:15px; cursor:pointer;">
                    <input type="checkbox" id="chckfirstmodify" name="chckfirstmodify" value="0" onclick="$(this).attr('value', this.checked ? 1 : 0)" /> Modify
                </label>
                
                <label class="lbl-right" style="width:100px; margin-left:auto;">Min. Approval</label>
                <input type="text" id="txtfirst_minapproval" name="txtfirst_minapproval" style="width:80px;" value='<s:property value="txtfirst_minapproval"/>'/>
            </div>
            
            <div id="new_users">
                <!-- New User 1 -->
                <div id="new_user1">
                    <div class="field-row">
                        <label class="lbl-right" style="width:60px;">User</label>
                        <input type="text" id="txtfirst_user1" name="txtfirst_user1" style="width:120px;" value='<s:property value="txtfirst_user1"/>'/>
                        <input type="hidden" name="txtfirst_userdoc1" id="txtfirst_userdoc1" value='<s:property value="txtfirst_userdoc1"/>'>
                        
                        <input type="text" id="txtfirst_userfull1" name="txtfirst_userfull1" style="flex:1; margin-left:8px;" value='<s:property value="txtfirst_userfull1"/>'/>
                        
                        <button type="button" class="myButton" id="first_btnSearch1" title="Search" onclick="funSearchBtn11(1,'level3')" style="margin-left:15px;">
                            <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg> Search
                        </button>
                        <button type="button" class="myButton btn-remove" id="first_btnCancel1" title="Remove" onclick="funResetbtn1(1,'first')">
                            <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="18" y1="6" x2="6" y2="18"></line><line x1="6" y1="6" x2="18" y2="18"></line></svg> Remove
                        </button>
                    </div>
                </div>
                
                <!-- New User 2 -->
                <div id="new_user2">
                    <div class="field-row">
                        <label class="lbl-right" style="width:60px;">User</label>
                        <input type="text" id="txtfirst_user2" name="txtfirst_user2" style="width:120px;" value='<s:property value="txtfirst_user2"/>'/>
                        <input type="hidden" name="txtfirst_userdoc2" id="txtfirst_userdoc2" value='<s:property value="txtfirst_userdoc2"/>'>
                        
                        <input type="text" id="txtfirst_userfull2" name="txtfirst_userfull2" style="flex:1; margin-left:8px;" value='<s:property value="txtfirst_userfull2"/>'/>
                        
                        <button type="button" class="myButton" id="first_btnSearch2" title="Search" onclick="funSearchBtn11(2,'level3')" style="margin-left:15px;">
                            <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg> Search
                        </button>
                        <button type="button" class="myButton btn-remove" id="first_btnCancel2" title="Remove" onclick="funResetbtn1(2,'first')">
                            <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="18" y1="6" x2="6" y2="18"></line><line x1="6" y1="6" x2="18" y2="18"></line></svg> Remove
                        </button>
                    </div>
                </div>
                
                <!-- New User 3 -->
                <div id="new_user3">
                    <div class="field-row">
                        <label class="lbl-right" style="width:60px;">User</label>
                        <input type="text" id="txtfirst_user3" name="txtfirst_user3" style="width:120px;" value='<s:property value="txtfirst_user3"/>'/>
                        <input type="hidden" name="txtfirst_userdoc3" id="txtfirst_userdoc3" value='<s:property value="txtfirst_userdoc3"/>'>
                        
                        <input type="text" id="txtfirst_userfull3" name="txtfirst_userfull3" style="flex:1; margin-left:8px;" value='<s:property value="txtfirst_userfull3"/>'/>
                        
                        <button type="button" class="myButton" id="first_btnSearch3" title="Search" onclick="funSearchBtn11(3,'level3')" style="margin-left:15px;">
                            <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg> Search
                        </button>
                        <button type="button" class="myButton btn-remove" id="first_btnCancel3" title="Remove" onclick="funResetbtn1(3,'first')">
                            <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="18" y1="6" x2="6" y2="18"></line><line x1="6" y1="6" x2="18" y2="18"></line></svg> Remove
                        </button>
                    </div>
                </div>
                
                <!-- New User 4 -->
                <div id="new_user4">
                    <div class="field-row">
                        <label class="lbl-right" style="width:60px;">User</label>
                        <input type="text" id="txtfirst_user4" name="txtfirst_user4" style="width:120px;" value='<s:property value="txtfirst_user4"/>'/>
                        <input type="hidden" name="txtfirst_userdoc4" id="txtfirst_userdoc4" value='<s:property value="txtfirst_userdoc4"/>'>
                        
                        <input type="text" id="txtfirst_userfull4" name="txtfirst_userfull4" style="flex:1; margin-left:8px;" value='<s:property value="txtfirst_userfull4"/>'/>
                        
                        <button type="button" class="myButton" id="first_btnSearch4" title="Search" onclick="funSearchBtn11(4,'level3')" style="margin-left:15px;">
                            <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg> Search
                        </button>
                        <button type="button" class="myButton btn-remove" id="first_btnCancel4" title="Remove" onclick="funResetbtn1(4,'first')">
                            <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="18" y1="6" x2="6" y2="18"></line><line x1="6" y1="6" x2="18" y2="18"></line></svg> Remove
                        </button>
                    </div>
                </div>
                
                <!-- New User 5 -->
                <div id="new_user5">
                    <div class="field-row">
                        <label class="lbl-right" style="width:60px;">User</label>
                        <input type="text" id="txtfirst_user5" name="txtfirst_user5" style="width:120px;" value='<s:property value="txtfirst_user5"/>'/>
                        <input type="hidden" name="txtfirst_userdoc5" id="txtfirst_userdoc5" value='<s:property value="txtfirst_userdoc5"/>'>
                        
                        <input type="text" id="txtfirst_userfull5" name="txtfirst_userfull5" style="flex:1; margin-left:8px;" value='<s:property value="txtfirst_userfull5"/>'/>
                        
                        <button type="button" class="myButton" id="first_btnSearch5" title="Search" onclick="funSearchBtn11(5,'level3')" style="margin-left:15px;">
                            <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg> Search
                        </button>
                        <button type="button" class="myButton btn-remove" id="first_btnCancel5" title="Remove" onclick="funResetbtn1(5,'first')">
                            <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="18" y1="6" x2="6" y2="18"></line><line x1="6" y1="6" x2="18" y2="18"></line></svg> Remove
                        </button>
                    </div>
                </div>
            </div>
        </div>

    </div>

    <!-- Hidden Fields Map -->
    <div style="display:none;">
        <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>      
        <input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
        <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>' />
        <input type="hidden" id="chckfinalmodifyval" name="chckfinalmodifyval" value='<s:property value="chckfinalmodifyval"/>'/>  
        <input type="hidden" id="chcksecondmodifyval" name="chcksecondmodifyval" value='<s:property value="chcksecondmodifyval"/>'/> 
        <input type="hidden" id="chckfirstmodifyval" name="chckfirstmodifyval" value='<s:property value="chckfirstmodifyval"/>'/>  
        <input type="hidden" id="chckfinal_mandatory1val" name="chckfinal_mandatory1val" value='<s:property value="chckfinal_mandatory1val"/>'/>  
        <input type="hidden" id="chckfinal_mandatory2val" name="chckfinal_mandatory2val" value='<s:property value="chckfinal_mandatory2val"/>'/>  
        <input type="hidden" id="chckfinal_mandatory3val" name="chckfinal_mandatory3val" value='<s:property value="chckfinal_mandatory3val"/>'/>  
        <input type="hidden" id="chckfinal_mandatory4val" name="chckfinal_mandatory4val" value='<s:property value="chckfinal_mandatory4val"/>'/>  
        <input type="hidden" id="chckfinal_mandatory5val" name="chckfinal_mandatory5val" value='<s:property value="chckfinal_mandatory5val"/>'/>
        <input type="hidden" id="txtuserdoc" name="txtuserdoc" value='<s:property value="txtuserdoc"/>'/>
        <input type="hidden" id="chcksecond_mandatory1val" name="chcksecond_mandatory1val" value='<s:property value="chcksecond_mandatory1val"/>'/>  
        <input type="hidden" id="chcksecond_mandatory2val" name="chcksecond_mandatory2val" value='<s:property value="chcksecond_mandatory2val"/>'/>  
        <input type="hidden" id="chcksecond_mandatory3val" name="chcksecond_mandatory3val" value='<s:property value="chcksecond_mandatory3val"/>'/>  
        <input type="hidden" id="chcksecond_mandatory4val" name="chcksecond_mandatory4val" value='<s:property value="chcksecond_mandatory4val"/>'/>  
        <input type="hidden" id="chcksecond_mandatory5val" name="chcksecond_mandatory5val" value='<s:property value="chcksecond_mandatory5val"/>'/>  
        <input type="hidden" id="chckfirst_mandatory1val" name="chckfirst_mandatory1val" value='<s:property value="chckfirst_mandatory1val"/>'/>  
        <input type="hidden" id="chckfirst_mandatory2val" name="chckfirst_mandatory2val" value='<s:property value="chckfirst_mandatory2val"/>'/>   
        <input type="hidden" id="chckfirst_mandatory3val" name="chckfirst_mandatory3val" value='<s:property value="chckfirst_mandatory3val"/>'/>   
        <input type="hidden" id="chckfirst_mandatory4val" name="chckfirst_mandatory4val" value='<s:property value="chckfirst_mandatory4val"/>'/>     
        <input type="hidden" id="chckfirst_mandatory5val" name="chckfirst_mandatory5val" value='<s:property value="chckfirst_mandatory5val"/>'/>    
    </div>

</div>
</form>

<div id="userWindow"><div></div><div></div></div>
<div id="userinfoWindow"><div></div><div></div></div>

</div>
</body>
</html>