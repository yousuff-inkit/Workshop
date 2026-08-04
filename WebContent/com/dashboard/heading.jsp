<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%
	String contextPath=request.getContextPath();
 %>
 <link rel="stylesheet" type="text/css" href="../../../../css/body.css">
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"/>

<style>
/* ===== NEW HORIZONTAL LAYOUT ===== */
.dashboard-header-wrapper {
    --primary: #2563eb;
    --text-main: #1e293b;
    --text-muted: #64748b;
    
    font-family: 'Inter', 'Poppins', sans-serif;
    padding: 10px 24px;
    background: linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%);
    overflow-y: hidden;
    
    /* Flexbox settings for horizontal alignment */
    display: flex;
    flex-direction: row;
    align-items: center;
    justify-content: space-between;
    gap: 15px;
    flex-wrap: wrap;
    border: 1px solid #dee2e6;
    border-radius: 8px;
    margin-bottom: 20px;
}

.dashboard-header-wrapper .header-container {
    padding: 0;
    background: transparent; 
    border: none;
    box-shadow: none;
    margin-bottom: 0; 
    text-align: left;
    font-size: 18px;
    font-weight: 700;
    color: var(--text-main);
    white-space: nowrap;
}

/* Groups the buttons and dropdown together on the right */
.dashboard-header-wrapper .actions-container {
    display: flex;
    align-items: center;
    gap: 20px;
    flex-wrap: wrap;
}

.dashboard-header-wrapper .btn-grid {
    display: flex;
    flex-direction: row;
    justify-content: center;
    gap: 6px;
    margin: 0; 
}

.dashboard-header-wrapper .branch-section {
    background: transparent; 
    border: none;
    padding: 0;
    margin-bottom: 0; 
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 8px;
}

#btnSubmit {
    margin: 0;
}

/* ===== EXISTING BUTTON & ICON STYLES ===== */
.dashboard-header-wrapper .nbtn {
    flex: 0 0 auto;
    max-width: 90px;
    height: 36px;
    border-radius: 8px;
    background: #ffffff;
    border: 1px solid #e2e8f0;
    color: var(--text-main);
    font-size: 11px;
    font-weight: 600;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 6px;
    cursor: pointer;
    transition: all 0.2s;
}

.dashboard-header-wrapper .btn-primary {
    background: var(--primary);
    color: white;
    border: none;
}

#btnSendingEmail {
    opacity: 1 !important;
    cursor: pointer !important;
    pointer-events: auto !important;
}

.dashboard-header-wrapper .styled-select {
    width: 150px;
    background: #ffffff;
    border: 1px solid #cbd5e1;
    border-radius: 6px;
    height: 36px;                
    padding: 0 8px;              
    display: flex;
    align-items: center;          
}

.dashboard-header-wrapper .styled-select select {
    border: none !important;
    outline: none !important;
    box-shadow: none !important;
    width: 100%;
    font-size: 13px;
    height: 100%;
    padding: 0;                    
    background: transparent;
    box-sizing: border-box;
    -webkit-appearance: auto; /* Keeps the native dropdown arrow */
}
#btnGuideline svg, 
#btnCalculate svg {
    width: 15px;  
    height: 15px; 
    stroke-width: 2.5px; 
}

/* ===== BLUE ICON STYLE ===== */
.nbtn svg {
    width: 16px;
    height: 16px;
    stroke: #005c97;      
    fill: none;
    stroke-width: 2;
}

/* Solid-fill icons (if any) */
.nbtn svg path[fill] {
    fill: #005c97;
}

/* Hover effect */
.nbtn:hover svg {
    stroke: #2563eb;
}

/* ===== BUTTON HOVER EFFECT ===== */
.dashboard-header-wrapper .nbtn {
    border: 1.5px solid #e2e8f0;        
    transition: 
        transform 0.2s ease,
        border-color 0.2s ease,
        box-shadow 0.2s ease;
}

.dashboard-header-wrapper .nbtn:hover {
    border-color: #2563eb;                
    transform: scale(1.08);                
    box-shadow: 0 6px 16px rgba(37, 99, 235, 0.25);
    z-index: 2;                            
}
</style>

<script type="text/javascript">
$(document).ready(function () {
    $("body").prepend('<div id="overlay1" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
    $("body").prepend("<div id='PleaseWait1' style='display: none;position:absolute; z-index: 1;top:200px;right:750px;'><img src='../../../../icons/31load.gif'/></div>");
        
    <%String main2=request.getParameter("main")==null?"":request.getParameter("main");%>
    <%String name2=request.getParameter("name")==null?"":request.getParameter("name");%>
    <%String docno=request.getParameter("docno")==null?"":request.getParameter("docno");%>
    
    if($('#detailname').val()==""){
        document.getElementById("lbldetailname").innerText='<%=name2%>';
        document.getElementById("lbldetail").innerText='<%=main2.equalsIgnoreCase("0")?"Workshop":main2%>';
        $('#detailname').val(document.getElementById("lbldetail").innerText);
        document.getElementById("txtdetailpermissiondocno").value='<%=docno%>';
    }
    else{
        document.getElementById("lbldetailname").innerText=$('#detailname').val();
        document.getElementById("lbldetail").innerText=$('#detail').val();
        document.getElementById("txtdetailpermissiondocno").value='<%=docno%>';
    }
    
    $('#windowattach').jqxWindow({width: '51%', height: '61%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Attach',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true});
    $('#windowattach').jqxWindow('close');
    
    $('#windowguideline').jqxWindow({width: '78%', height: '85%',  maxHeight: '85%' ,maxWidth: '78%' , title: 'Guideline',position: { x: 280, y: 10 } , theme: 'energyblue', showCloseButton: true, showCollapseButton: true});
    $('#windowguideline').jqxWindow('close');
        
    $("input").click(function (evt) {
        this.placeholder = '' ;
    });
    
    funChkHeaderButton();
});

function funDateInPeriod(value){
    var styear = new Date(window.parent.txtaccountperiodfrom.value);
    var edyear = new Date(window.parent.txtaccountperiodto.value);
    var mclose = new Date(window.parent.monthclosed.value);
    mclose.setHours(0,0,0,0);
    edyear.setHours(0,0,0,0);
    styear.setHours(0,0,0,0);
    var currentDate = new Date(new Date());
    if(value<styear || value>edyear){
        $.messager.alert('Warning',"Transaction prior or after Account Period is not valid.");
        $('#txtvalidation').val(1);
        return 0;
    }
    if(value>currentDate){
        $.messager.alert('Warning',"Future Date, Transaction Restricted. ");
        $('#txtvalidation').val(1);
        return 0;
    } 
    if(value<=mclose){
        $.messager.alert('Warning',"Closing Done, Transaction Restricted. ");
        $('#txtvalidation').val(1);
        return 0;
    }
    
    $('#txtvalidation').val(0);
    return 1;
}
 
function JSONToCSVCon(JSONData, ReportTitle, ShowLabel) {
    var arrData = typeof JSONData != 'object' ? JSON.parse(JSONData) : JSONData;
    var CSV = '';    
    
    //Set Report title in first row or line
    CSV += ReportTitle + '\r\n\n';

    //This condition will generate the Label/Header
    if (ShowLabel) {
        var row = "";
        //This loop will extract the label from 1st index of on array
        for (var index in arrData[0]) {
            //Now convert each value to string and comma-seprated
            row += index + ',';
        }

        row = row.slice(0, -1);
        //append Label row with line break
        CSV += row + '\r\n';
    }
    
    //1st loop is to extract each row
    for (var i = 0; i < arrData.length; i++) {
        var row = "";
        //2nd loop will extract each column and convert it in string comma-seprated
        for (var index in arrData[i]) {
            row += '"' + arrData[i][index] + '",';
        }

        row.slice(0, row.length - 1);
        //add a line break after each row
        CSV += row + '\r\n';
    }

    if (CSV == '') {        
        alert("Invalid data");
        return;
    }   
    
    //Generate a file name
    var fileName = "";
    //this will remove the blank-spaces from the title and replace it with an underscore
    fileName += ReportTitle.replace(/ /g,"_");   
    
    //Initialize file format you want csv or xls
    var uri = 'data:text/csv;charset=utf-8,' + escape(CSV);
    
    //this trick will generate a temp <a /> tag
    var link = document.createElement("a");    
    link.href = uri;
    
    //set the visibility hidden so it will not effect on your web-layout
    link.style = "visibility:hidden";
    link.download = fileName + ".csv";
    
    //this part will append the anchor tag and remove it after automatic click
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
}

function funDateInPeriodNew(value){
    //Date Validation Method without Future date Validation
    var styear = new Date(window.parent.txtaccountperiodfrom.value);
    var edyear = new Date(window.parent.txtaccountperiodto.value);
    var mclose = new Date(window.parent.monthclosed.value);
    mclose.setHours(0,0,0,0);
    edyear.setHours(0,0,0,0);
    styear.setHours(0,0,0,0);
    var currentDate = new Date(new Date());
    if(value<styear || value>edyear){
        $.messager.alert('Warning',"Transaction prior or after Account Period is not valid.");
        $('#txtvalidation').val(1);
        return 0;
    }
    
    if(value<=mclose){
        $.messager.alert('Warning',"Closing Done, Transaction Restricted. ");
        $('#txtvalidation').val(1);
        return 0;
    }
    
    $('#txtvalidation').val(0);
    return 1;
}
 
function funIBDateInPeriod(date,branch){
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText;
             items = items.split('***');
             var monthCloseDate = items[0];
             var monthClose = items[1];
             var Date = items[2].trim();
           
           if(parseInt(monthClose)==1){
                 $.messager.alert('Message','Closing Done on '+Date+' For Inter-Branch, Transaction Restricted. ','warning');
                 $('#txtibvalidation').val(1);$('#txtibbranchid').val('');$('#txtibbranch').val('');
                
                 if (document.getElementById("txtibbranch").value == "") {
                        $('#txtibbranch').attr('placeholder', 'Press F3 to Search'); 
                  }
                 
                 return 0;
           }
           
             $('#txtibvalidation').val(0);
             return 1;
       }
    }
    x.open("GET", "<%=contextPath%>/com/dashboard/getIBMonthClose.jsp?date="+date+"&branch="+branch, true);
    x.send();
}

function funChkHeaderButton() {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText.trim();
            items = items.split('##');
                
            var email  = items[0].split(",");
            var excel  = items[1].split(",");

            if(parseInt(email)==0) {
                $("#btnSendingEmail").attr('disabled', true );
            } else {
                 $("#btnSendingEmail").attr('disabled', false );
            }

            if(parseInt(excel)==0) {
                $("#btnExcel").attr('disabled', true );
            } else {
                $("#btnExcel").attr('disabled', false );
            }
         } else {}
    }
    
    x.open("GET","<%=contextPath%>/com/dashboard/chkheaderbuttons.jsp?docno="+$('#txtdetailpermissiondocno').val().trim(),true);
    x.send();
}

function getMessengerCount() {
    var x=new XMLHttpRequest();
    var msgcnt;
    var user;
    x.onreadystatechange=function(){
        
        if (x.readyState==4 && x.status==200) {
            items= x.responseText;
            items=items.trim().split('####');
            user=items[0];
            msgcnt=items[1];

            if(msgcnt>0){
                window.parent.document.getElementById("iconnm").style.display = 'none';
                window.parent.document.getElementById("iconym").style.display = 'inline-block';
            }
            else{
                window.parent.document.getElementById("iconym").style.display = 'none';
                window.parent.document.getElementById("iconnm").style.display = 'inline-block';
            }
        }
    }
    x.open("GET",<%=contextPath+"/"%>+"com/messenger/getMsgCount.jsp",true);
    x.send();
}

function changeDashBoardAttachContent(url) {
    $.get(url).done(function (data) {
        $('#windowattach').jqxWindow('open');
        $('#windowattach').jqxWindow('setContent',data);
        $('#windowattach').jqxWindow('bringToFront');
    }); 
}

function changeDashBoardGuidelineContent(url) {
     $('#windowguideline').jqxWindow('focus'); 
     $.get(url).done(function (data) {
        $('#windowguideline').jqxWindow('setContent', data);
    }); 
}

function getBranch() {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText;
            items = items.split('####');
            var branchIdItems  = items[0].split(",");
            var branchItems = items[1].split(",");
            var perm = items[2];
            var optionsbranch;
            if(perm==0){
             optionsbranch = '<option value="a" selected>All</option>';
            }
            else{
            }
            for (var i = 0; i < branchItems.length; i++) {
                optionsbranch += '<option value="' + branchIdItems[i].trim() + '">'
                        + branchItems[i] + '</option>';
            }
            $("select#cmbbranch").html(optionsbranch);
            /* if ($('#hidcmbbranch').val() != null) {
                $('#cmbbranch').val($('#hidcmbbranch').val());
            } */
        } else {
            //alert("Error");
        }
    }
    x.open("GET","<%=contextPath%>/com/dashboard/getBranch.jsp", true);
    x.send();
}

function funRoundAmt(value,id){
    var res=parseFloat(value).toFixed(window.parent.amtdec.value);
    var res1=(res=='NaN'?"0":res);
    document.getElementById(id).value=res1;  
}
   
function funRoundRate(value,id){
    var res=parseFloat(value).toFixed(window.parent.curdec.value);
    var res1=(res=='NaN'?"0":res);
    document.getElementById(id).value=res1;  
}
 
function funGuideline() {
     $('#windowguideline').jqxWindow('setContent', '');
     $('#windowguideline').jqxWindow('open'); 
    
     changeDashBoardGuidelineContent("<%=contextPath%>/com/dashboard/viewDashBoardGuideline.action?formDetail="+document.getElementById("lbldetail").innerText+"&formDetailName="+document.getElementById("lbldetailname").innerText);
}

function funMclose(value){
    if(value=="a"){
        window.parent.monthclosed.value=window.parent.txtaccountperiodfrom.value;
        return 0;
    }

    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText.trim();
            if(items!='null'){
                window.parent.monthclosed.value=items;
            }
            else{
                window.parent.monthclosed.value=window.parent.txtaccountperiodfrom.value;   
            }

        } else {
            //alert("Error");
        }
    }
    x.open("GET","<%=contextPath%>/com/dashboard/getMclose.jsp?branch="+value, true);
    x.send();
}
 
function getformbranch(){
    $('#cmbbranch').attr('disabled',false);
    var branchval=document.getElementById('cmbbranch').value;
    if($('#cmbbranch').val()!=null && $('#cmbbranch').val()!='a'){
        window.parent.branchid.value=$('#cmbbranch').val();    
    }
    
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200) {
            var items= x.responseText.trim();
            if(parseInt(items)==0) {
                $.messager.confirm('Confirm', 'Your Secure Session Has Expired ,Please Login Again.....!', function(r){
                    if (r){
                        window.parent.location.href=<%=contextPath+"/"%>+"login.jsp";
                    }
                });
                Exit();
                return 0;
            }
        }
    }
    x.open("GET", "<%=contextPath%>/com/dashboard/sessionset.jsp?sessionbrch="+branchval,true);
    x.send();
}
</script>
</head>

<body onclick="getformbranch();getMessengerCount();">
<div class="dashboard-header-wrapper">
    
    <div class="header-container">
        <label id="lbldetail"></label>
        <span class="separator"> - </span>
        <label id="lbldetailname"></label>
    </div>

    <div class="actions-container">
        <div class="btn-grid">
            <button type="button" class="nbtn" id="btnGuideline" title="Guideline" onclick="funGuideline();">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"></circle><line x1="12" y1="16" x2="12" y2="12"></line><line x1="12" y1="8" x2="12.01" y2="8"></line></svg>
                Guideline
            </button>
            <button type="button" class="nbtn" id="btnSendingEmail" title="Send Email" onclick="funSendingEmail();">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"/><polyline points="22,6 12,13 2,6"/></svg>
                Email
            </button>
            <button type="button" class="nbtn" id="btnExcel" title="Export current Document to Excel" onclick="funExportBtn();">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/><polyline points="14 2 14 8 20 8"/><line x1="16" y1="13" x2="8" y2="13"/><line x1="16" y1="17" x2="8" y2="17"/><line x1="10" y1="9" x2="8" y2="9"/></svg>
                Export
            </button>
            <button type="button" class="nbtn" id="btnCalculate" title="Calculate" onclick="funCalculate();">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="4" y="2" width="16" height="20" rx="2"/><line x1="8" y1="6" x2="16" y2="6"/><line x1="16" y1="14" x2="16" y2="18"/><path d="M16 10h.01"/><path d="M12 10h.01"/><path d="M8 10h.01"/><path d="M12 14h.01"/><path d="M8 14h.01"/><path d="M12 18h.01"/><path d="M8 18h.01"/></svg>
                Calculate
            </button>
        </div>

        <div class="branch-section">
            <div class="branch-label-wrapper">
                <label id="branchlabel">Branch</label>
            </div>
            <div class="branch-select-wrapper">
                <div class="styled-select" id="branchdiv">
                    <select id="cmbbranch" name="cmbbranch" value='<s:property value="cmbbranch"/>' onchange="funMclose(this.value);getformbranch();">
                        <option value="">--Select--</option>
                    </select>
                </div>
            </div>
            <input type="hidden" id="hidcmbbranch" name="hidcmbbranch" value='<s:property value="hidcmbbranch"/>'/>
        </div>

        <button type="button" class="nbtn btn-primary" id="btnSubmit" title="Submit" onclick="funreload(event);">
            Submit
        </button>
    </div>

    <!-- Hidden Fields -->
    <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'/>
    <input type="hidden" name="detail" id="detail" value="<s:property value="detail"/>" />
    <input type="hidden" name="detailname" id="detailname" value="<s:property value="detailname"/>" />
    <input type="hidden" name="txtdetailpermissiondocno" id="txtdetailpermissiondocno" value="<s:property value="txtdetailpermissiondocno"/>" />
    
    <!-- Modals -->
    <div id="windowattach"><div></div></div>
    <div id="windowguideline"><div></div></div>
</div>
</body>
</html>