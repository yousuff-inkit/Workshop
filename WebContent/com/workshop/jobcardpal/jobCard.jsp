<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Job Card</title>
<jsp:include page="../../../includes.jsp"></jsp:include>
<style>
/* =========================================================
SCOPED UI: Modern Layout (Plain White & Blue Headings)
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

/* Middle Section Panels - Plain White with Blue Title */
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
<%
String id=request.getParameter("id")==null?"":request.getParameter("id");
String estdocno=request.getParameter("estdocno")==null?"":request.getParameter("estdocno");
String gatedocno=request.getParameter("gatedocno")==null?"":request.getParameter("gatedocno");
String brhid=request.getParameter("brhid")==null?"":request.getParameter("brhid");
%>
<script type="text/javascript">

$(document).ready(function() {
    $("#btnEdit").attr('disabled', true );
    
    // Date Setup
    $("#date").jqxDateTimeInput({  width:'100%', height: 24, formatString : "dd.MM.yyyy", maxDate:new Date(), theme: 'energyblue' });
    $("#promdate").jqxDateTimeInput({  width:'100%', height: 24, formatString : "dd.MM.yyyy", minDate:new Date(), value:new Date(), theme: 'energyblue' });
    $("#promtime").jqxDateTimeInput({  width:'100%', height: 24, formatString : "HH:mm", showCalendarButton:false, value:new Date(), theme: 'energyblue' });
    
    /* force internal alignment AFTER render */
    setTimeout(function () {
         $("#date, #promdate, #promtime").find("input").css({
             "margin-top": "0px",
             "line-height": "24px",
             "font-size": "12px", 
             "font-family": "Arial, sans-serif", 
             "padding": "0 6px", 
             "box-sizing":"border-box"
         });
         $("#date, #promdate, #promtime").find(".jqx-action-button").css({
             "top": "0px",
             "height": "24px"
         });
    }, 0);
    
    $('#searchwindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
    $('#searchwindow').jqxWindow('close'); 
     $('#printWindow').jqxWindow({width: '51%', height: '40%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Print',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
     $('#printWindow').jqxWindow('close');
    $('#refno').dblclick(function(){

        var reftype=document.getElementById("cmbreftype").value;
        if(reftype=="GIP" || reftype=="EST"){
            SearchContent("refnoSearch.jsp?reftype="+reftype+"&branch="+$('#brchName').val());
        }
        else{
        }
    });
    getDocDateConfig(); getOtherDetailsPrintConfig();
    var estdocno='<%=estdocno%>';
    if(estdocno!="" && estdocno!="undefined" && estdocno!=null && typeof(estdocno)!="undefined"){
        var ajaxbrhid='<%=brhid%>';
        if(ajaxbrhid!="" && ajaxbrhid!=null && ajaxbrhid!="undefined"){
            $('#brchName').val(ajaxbrhid);  
        }
        
        getRefData(estdocno);
    }

});

function getRefData(estdocno){
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText.trim().split("::");
            $('#cmbreftype').val("EST");
            $('#refno').val(items[0]);
            $('#hidrefno').val(items[1]);
            $('#regno').val(items[2]);
            $('#vehicledetails').val(items[3]);
            $('#userdetails').val(items[4]);
            $('#cldocno').val(items[5]);
            if($('#cmbreftype').val()=="EST"){
                $('#sparediv').load('sparepartsGrid.jsp?docno='+$('#hidrefno').val()+'&id=1');
                $('#labourdiv').load('labourcostGrid.jsp?docno='+$('#hidrefno').val()+'&id=1');
                $('#labourcostGrid,#sparepartsGrid').jqxGrid({disabled:false});
            }
        }
        else{
            }
        }
    
    x.open("GET", "getRefData.jsp?estdocno="+estdocno, true);
    x.send();
}
function JobCardPrintContent(url) {
            $('#printWindow').jqxWindow('open');
            $.get(url).done(function (data) {
            $('#printWindow').jqxWindow('setContent', data);
            $('#printWindow').jqxWindow('bringToFront');
        }); 
 }
function funPrintBtn() {
    
    if (($("#mode").val() == "view") && $("#docno").val()!="") {
        JobCardPrintContent('printVoucherWindow.jsp');   
      }
    else {
            $.messager.alert('Message','Select a Document....!','warning');
            return;
        }
      }
 function SearchContent(url) {
    $('#searchwindow').jqxWindow('open');
    $.get(url).done(function (data) {
    $('#searchwindow').jqxWindow('setContent', data);
    $('#searchwindow').jqxWindow('bringToFront');
}); 
}
    
function funReadOnly() {
    
    $('#frmjobcard input').attr('readonly',true);
    $('#frmjobcard select').attr('disabled',true);
var id='<%=id%>';
     if(id=="3"){
        var ajaxbrhid='<%=brhid%>';
        if(ajaxbrhid!="" && ajaxbrhid!=null && ajaxbrhid!="undefined"){
            $('#brchName').val(ajaxbrhid);  
        }
      funCreateBtn();
     }
    
}
function funRemoveReadOnly() {
    $('#frmjobcard input').attr('readonly',false);
    $('#frmjobcard select').attr('disabled',false);
    var id='<%=id%>';
    var est
    if(id=="3"){
        $('#sparediv').load('../../../com/workshop/jobcard/sparepartsGrid.jsp?docno='+$('#hidrefno').val()+'&id=1');
        $('#labourdiv').load('../../../com/workshop/jobcard/labourcostGrid.jsp?docno='+$('#hidrefno').val()+'&id=1');
    }
    getDocDateConfig(); getOtherDetailsPrintConfig();
}
function setValues() {
    if($('#msg').val()!=""){
           $.messager.alert('Message',$('#msg').val());
     }
    if($('#hidcmbreftype').val()!=""){
        $('#cmbreftype').val($('#hidcmbreftype').val());
     }
        if($('#hidpromtime').val()!=""){
        $('#promtime').val($('#hidpromtime').val());
     }
     if($('#lblgipno').val()!=""){
        $('#lblgipno').val($('#lblgipno').val());
     }
     if($('#hidrefno').val()!=''){
            $('#sparediv').load('sparepartsGrid.jsp?docno='+$('#hidrefno').val()+'&id=1');
            $('#labourdiv').load('labourcostGrid.jsp?docno='+$('#hidrefno').val()+'&id=1');       
     }
     var ajaxbrhid='<%=brhid%>';
        if(ajaxbrhid!="" && ajaxbrhid!=null && ajaxbrhid!="undefined"){
            $('#brchName').val(ajaxbrhid);  
        }
    
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
        if(currentdate.getTime()!=docdate.getTime()){
            $.messager.alert('Warning','Document Date should be Current Date');
            $('#date').jqxDateTimeInput('focus');
            return 0;
        }
        else{
            
        }
    }
    var outstanding=parseFloat(document.getElementById("outstandingamt").value);
    var exceedstatus=document.getElementById("exceedstatus").value;
    var creditlimit=parseFloat(document.getElementById("creditlimit").value);
    if(outstanding>creditlimit && exceedstatus=="1"){
        document.getElementById("errormsg").innerText="";
        document.getElementById("errormsg").innerText="Outstanding Balance is "+outstanding;
        return 0;
    }
    else{
        document.getElementById("errormsg").innerText="";
    }
    return 1;
}

 function funFocus(){
    document.getElementById("cmbreftype").focus();
} 

function getRefno(event){
    var x= event.keyCode;
    if(x==114){
        var reftype=document.getElementById("cmbreftype").value;
        if(reftype=="GIP" || reftype=="EST"){
            SearchContent("refnoSearch.jsp?reftype="+reftype+"&branch="+$('#brchName').val());
        }
        else{
        }
    }
}
function funSearchLoad(){
    changeContent('masterSearch.jsp', $('#window'));
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

function getOtherDetailsPrintConfig(){  
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            items = x.responseText.trim();
            $('#otherdetailsconfig').val(items);
        } else {
        }
    }
    x.open("GET", "getOtherDetailsPrintConfig.jsp", true);
    x.send();
}

</script>

</head>
<body onLoad="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
    <form id="frmWSJobCardPal" action="saveWSJobCardPal">
        <jsp:include page="../../../header.jsp" />
        <script type="text/javascript">
            var ajaxbrhid='<%=brhid%>';
            var id='<%=id%>';
            if(id=="3"){
                $('#brchName').val(ajaxbrhid);  
            }
        </script>

        <div class="modern-ui hidden-scrollbar">
            <div id="errormsg"></div>

            <!-- Top Header info -->
            <div class="middle-panel">
                <span class="middle-panel-title">Job Card Details</span>
                
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
                    <select name="cmbreftype" id="cmbreftype" value='<s:property value="cmbreftype"/>' style="width:125px;">
                        <option value="">--Select--</option>
                        <option value="EST">Estimation</option>
                    </select>
                    <input type="hidden" name="hidcmbreftype" id="hidcmbreftype" value='<s:property value="hidcmbreftype"/>'>
                    
                    <label class="lbl-right" style="width:60px; margin-left:15px;">Ref No</label>
                    <div class="input-search-container" style="flex:1; max-width:150px;">
                        <input type="text" name="refno" id="refno" value='<s:property value="refno"/>' placeholder="Press F3" onkeydown="getRefno(event)" readonly class="readonly">
                        <svg class="magnifier-icon" onclick="$('#refno').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                    </div>
                    <input type="hidden" name="hidrefno" id="hidrefno" value='<s:property value="hidrefno"/>'>
                </div>

                <div class="field-row">
                    <label class="lbl-right" style="width:80px;">Promise Date</label>
                    <div style="flex:1; max-width:125px;">
                        <div id="promdate" name="promdate" value='<s:property value="promdate"/>'></div>
                    </div>
                    
                    <label class="lbl-right" style="width:80px; margin-left:15px;">Promise Time</label>
                    <div style="width:80px;">
                        <div id="promtime" name="promtime" value='<s:property value="promtime"/>'></div>
                    </div>
                </div>
                
                <div class="field-row">
                    <label class="lbl-right" style="width:80px;">Reg no</label>
                    <input type="text" name="regno" id="regno" value='<s:property value="regno"/>' style="width:125px;" readonly class="readonly">
                    
                    <label class="lbl-right" style="width:80px; margin-left:15px;">Veh.Details</label>
                    <input type="text" name="vehicledetails" id="vehicledetails" value='<s:property value="vehicledetails"/>' style="flex:1;" readonly class="readonly">
                </div>

                <div class="field-row">
                    <label class="lbl-right" style="width:80px;">Client</label>
                    <input type="text" name="cldocno" id="cldocno" value='<s:property value="cldocno"/>' style="width:125px;" readonly class="readonly">
                    
                    <label class="lbl-right" style="width:80px; margin-left:15px;">Client Details</label>
                    <input type="text" name="userdetails" id="userdetails" value='<s:property value="userdetails"/>' style="flex:1;" readonly class="readonly">
                </div>

                <div class="field-row" style="margin-bottom:0;">
                    <label class="lbl-right" style="width:80px;">Description</label>
                    <input type="text" name="jobdesc" id="jobdesc" value='<s:property value="jobdesc"/>' style="flex:1;">
                </div>
            </div>

            <!-- Services -->
            <div class="middle-panel">
                <span class="middle-panel-title">Services</span>
                <div id="labourdiv">
                    <jsp:include page="labourcostGrid.jsp"></jsp:include>
                </div>
            </div>

            <!-- Spares Details -->
            <div class="middle-panel" style="margin-bottom:0;">
                <span class="middle-panel-title">Spares Details</span>
                <div id="sparediv">
                    <jsp:include page="sparepartsGrid.jsp"></jsp:include>
                </div>
            </div>

            <!-- Hidden Properties -->
            <div style="display:none;">
                <input type="hidden" name="estdocno" id="estdocno" value='<s:property value="estdocno"/>'>
                <input type="hidden" name="docno" id="docno" value='<s:property value="docno"/>'>
                <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>
                <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
                <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
                <input type="hidden" name="hidpromtime" id="hidpromtime" value='<s:property value="hidpromtime"/>'/>
                <input type="hidden" name="lblgipno" id="lblgipno" value='<s:property value="lblgipno"/>'/>
                <input type="hidden" name="outstandingamt" id="outstandingamt" value='<s:property value="outstandingamt"/>'/>
                <input type="hidden" name="exceedstatus" id="exceedstatus" value='<s:property value="exceedstatus"/>'/>
                <input type="hidden" name="creditlimit" id="creditlimit" value='<s:property value="creditlimit"/>'/>
                <input type="hidden" name="docdateconfig" id="docdateconfig" value='<s:property value="docdateconfig"/>'/>
                <input type="hidden" name="otherdetailsconfig" id="otherdetailsconfig" value='<s:property value="otherdetailsconfig"/>'/>
            </div>
            
        </div>
    </form>
</div>

<!-- Popup Windows -->
<div id="searchwindow">
    <div></div>
</div>
<div id="printWindow">
    <div></div><div></div>
</div> 
</body>
</html>