<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  

<style type="text/css">
/* ===== MASTER LAYOUT (Modern Flexbox) ===== */
html, body, #mainBG {
    height: 100%;
    margin: 0;
    overflow: hidden;
    background-color: #f4f7f9;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

.master-container {
    display: flex;
    width: 100%;
    height: 100vh;
}

/* ===== LEFT SIDEBAR ===== */
.sidebar-filters {
    width: 300px; 
    flex: 0 0 300px; 
    background: #f4f7f9;
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
    padding: 12px; 
}

/* Cards */
.filter-card {
    background: #ffffff;
    border: 1px solid #e2e8f0;
    border-radius: 6px;
    padding: 15px;
    margin-bottom: 12px;
}

/* Tables & Spacing */
.release-filter-table {
    width: 100%;
    border-collapse: collapse;
}

.release-filter-table td {
    padding: 6px 2px; 
    vertical-align: middle;
}

.release-filter-table .label-cell {
    text-align: right;
    padding-right: 10px;
    font-size: 12px !important; 
    color: #4b5563;
    font-weight: normal;
    width: 60px; 
}

/* ===== UNIFORM INPUTS & SELECTS (Fixes pink background & text styling) ===== */
input[type="text"], select, textarea,
.release-filter-table input[type="text"],
.release-filter-table select,
.release-filter-table textarea {
    width: 100%;
    height: 24px;             
    padding: 2px 6px;         
    border: 1px solid #cbd5e1 !important;
    border-radius: 3px;       
    font-size: 12px !important; 
    background-color: #ffffff !important; 
    color: #333333 !important; 
    box-sizing: border-box;
    font-family: inherit;
    outline: none;
}

select:focus, input[type="text"]:focus, textarea:focus {
    border-color: #3b82f6 !important;
    box-shadow: 0 0 0 1px rgba(59, 130, 246, 0.1);
}

.release-filter-table textarea {
    height: 60px; /* Adjusted specifically for this client name area */
    resize: none;
    margin-top: 4px;
}

/* Readonly / disabled look */
input[readonly], input:disabled, textarea[readonly],
.release-filter-table input[readonly], .release-filter-table select:disabled {
    background-color: #f8fafc !important;
    color: #6b7280 !important;
    border-color: #e2e8f0 !important;
}

/* ===== BUTTONS ===== */
.release-actions {
    margin-top: 15px;
    display: flex;
    flex-direction: column;
    gap: 8px;
    border-top: 1px solid #e3e8ee;
    padding-top: 15px;
}

.btn-submit {
    width: 100%;
    height: 32px;            
    background: #2563eb;
    color: #ffffff;
    border: none;
    border-radius: 4px;      
    font-size: 12px !important;
    font-weight: 600;
    cursor: pointer;
    transition: background 0.2s;
}

.btn-submit:hover {
    background: #1d4ed8;
}

.btn-submit:disabled {
    background: #9ca3af;
    cursor: not-allowed;
}

/* ===== RIGHT CONTENT AREA ===== */
.main-content-area {
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

.grid-content-container {
    flex: 1;
    padding: 15px;
    overflow: auto; 
    box-sizing: border-box;
}
</style>

<script type="text/javascript">

$(document).ready(function () {
    $('#userwindow').jqxWindow({ width: '30%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'User Search' ,position: { x: 250, y: 120 }, keyboardCloseKey: 27});
    $('#userwindow').jqxWindow('close');
	
    $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200;right:600;'><img src='../../../../icons/31load.gif'/></div>");    
	
    $('#btnblock').attr("disabled",true);
	 
    $('#user').dblclick(function(){
        $('#userwindow').jqxWindow('open');
        userSearchContent('usersearch.jsp?', $('#userwindow')); 
    });
});

function getuser(event){
    var x = event.keyCode;
    if(x == 114){
        $('#userwindow').jqxWindow('open');
        userSearchContent('usersearch.jsp?', $('#userwindow'));    
    }
} 

function userSearchContent(url) {
    $.get(url).done(function (data) {
        $('#userwindow').jqxWindow('open');
        $('#userwindow').jqxWindow('setContent', data);
    }); 
} 

function funreload(event)
{
    var branch=$('#cmbbranch').val();
    var doc_no=$('#docno').val();
    
    $('#overlay,#PleaseWait').show();
    $("#userblockdiv").load("userblockGrid.jsp?doc_no="+doc_no+"&branch="+branch+"&check=1");
}

function funExportBtn(){
    /* 
    if(parseInt(window.parent.chkexportdata.value)=="1") {
        JSONToCSVCon(invoicedata, 'Rental Invoice', true);
    } else {
        $("#rentalInvoiceGrid").jqxGrid('exportdata', 'xls', 'Rental Invoice');
    }
    */
}

function funBlock()
{
    if(document.getElementById("bdocno").value==""){
        $.messager.alert('Message',"Please Select user");
        return false;
    }

    var doc_no = document.getElementById("bdocno").value;

    $.messager.confirm('Message', 'Do you want to Block?', function(r){
        if(r==false)
        {
            return false; 
        }
        else{
            savegriddata(doc_no);
        }
    });
}

function savegriddata(doc_no)
{
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200)
        {
            var items=x.responseText;
            if(items==1) 
            {
                document.getElementById("bdocno").value="";
                $.messager.alert('Message', '  Blocked Successfully ');
                funreload(event);
            }
            else{
                $.messager.alert('Message', 'Not Updated ');
                $("#fleetdetailsgrid").jqxGrid('clear');
            }		
        }
    }
    x.open("GET","userblockdata.jsp?doc_no="+doc_no,true);
    x.send();
}
</script>
</head>
<body onload="getBranch();">

<div id="mainBG" class="homeContent" data-type="background"> 
    <div class="master-container">

        <!-- Sidebar / Filter Section -->
        <div class="sidebar-filters">
            <div class="sidebar-scroll-content">
                <div class="filter-card">
                    <table class="release-filter-table">
                        <tr>
                            <td class="label-cell">User</td>
                            <td>
                                <input type="text" name="user" id="user" readonly="readonly" placeholder="Press F3 To Search" onkeydown="getuser(event)" onclick="this.placeholder=''" value='<s:property value="user"/>'>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="padding-top: 8px;">
                                <textarea id="txtclientname" name="txtclientname" readonly="readonly"><s:property value="txtclientname"></s:property></textarea>
                            </td>
                        </tr>
                    </table>

                    <div class="release-actions">
                        <button type="button" name="btnblock" id="btnblock" class="btn-submit" onclick="funBlock();">Block</button>
                    </div>

                    <!-- Hidden Fields -->
                    <input type="hidden" name="docno" id="docno" value='<s:property value="docno"/>'>
                    <input type="hidden" name="bdocno" id="bdocno" value='<s:property value="bdocno"/>'>
                </div>
            </div>
        </div>

        <!-- Main Grid / Data Section -->
        <div class="main-content-area">
            
            <div class="top-toolbar-container">
                <jsp:include page="../../heading.jsp"></jsp:include>
            </div>

            <div class="grid-content-container">
                <div id="userblockdiv"><jsp:include page="userblockGrid.jsp"></jsp:include></div>
            </div>

        </div>

    </div>

    <!-- Modals -->
    <div id="userwindow">
        <div></div>
    </div>
</div>
</body>
</html>