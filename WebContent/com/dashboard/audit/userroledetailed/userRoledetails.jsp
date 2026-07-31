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
/* ===== MASTER LAYOUT (Modern Flexbox matching image_55e599.png) ===== */
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
    width: 290px; 
    flex: 0 0 290px; 
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
    width: 85px; 
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

/* Readonly / disabled look */
input[readonly], input:disabled, textarea[readonly],
.release-filter-table input[readonly], .release-filter-table select:disabled {
    background-color: #f8fafc !important;
    color: #6b7280 !important;
    border-color: #e2e8f0 !important;
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
    display: flex;
    flex-direction: column;
    gap: 15px;
}
</style>

<script type="text/javascript">

$(document).ready(function () {
	$("#branchlabel").css("opacity","0");$("#branchdiv").css("opacity","0");
	
	$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
     
    $('#userRoleDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'User-Role Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	$('#userRoleDetailsWindow').jqxWindow('close');
});

function getRole(event){
	document.getElementById("txtusername").value="";
	if (document.getElementById("txtusername").value == "") {
	    $('#txtusername').attr('placeholder', 'Press F3 TO Search'); 
	}
    var x= event.keyCode;
    if(x==114){
  	    userRoleSearchContent('userRoleSearchGrid.jsp');
    }
}

function funSearchdblclick(){
	document.getElementById("txtusername").value="";
	if (document.getElementById("txtusername").value == "") {
	    $('#txtusername').attr('placeholder', 'Press F3 TO Search'); 
	}
	$('#txtrolename').dblclick(function(){
	    userRoleSearchContent('userRoleSearchGrid.jsp');
	});
}

function userRoleSearchContent(url) {
    $('#userRoleDetailsWindow').jqxWindow('open');
	$.get(url).done(function (data) {
	    $('#userRoleDetailsWindow').jqxWindow('setContent', data);
	    $('#userRoleDetailsWindow').jqxWindow('bringToFront');
	}); 
}

function getName(event){
    var x= event.keyCode;
    if(x==114){
  	    userNameSearchContent('userNameSearchGrid.jsp');
    }
}
    
function funExportBtn(){
	JSONToCSVCon(data11, 'Menu Role', true);
	JSONToCSVCon(data13, 'BI Role', true);
}

function funNamedblclick(){
	$('#txtusername').dblclick(function(){
	    userNameSearchContent('userNameSearchGrid.jsp');
	});
}

function userNameSearchContent(url) {
    $('#userRoleDetailsWindow').jqxWindow('open');
	$.get(url).done(function (data) {
	    $('#userRoleDetailsWindow').jqxWindow('setContent', data);
	    $('#userRoleDetailsWindow').jqxWindow('bringToFront');
	}); 
}

function funreload(event){
	var roleid=$('#txtroleid').val();
	var rolleid=$('#txtrolleid').val();
	
	$('#userrolGriddiv').load('userRoleGrid.jsp?roleid='+roleid+'&rolleid='+rolleid+'&id=1');	
	$('#userroldetailsGriddiv').load('userRoledetailsGrid.jsp?roleid='+roleid+'&rolleid='+rolleid+'&id=1');
}

function funReadOnly(){
	$('#frmUserRoleMaster input').attr('readonly', true );
}
	
</script>

</head>
<body onload="funReadOnly();">
    <div id="mainBG" class="homeContent" data-type="background"> 
        <div class="master-container">

            <!-- Sidebar / Filter Section -->
            <div class="sidebar-filters">
                <div class="sidebar-scroll-content">
                    <div class="filter-card">
                        <table class="release-filter-table">
                            <tr>
                                <td class="label-cell">User Role</td>
                                <td>
                                    <input type="text" id="txtrolename" name="txtrolename" placeholder="Press F3 to Search" ondblclick="funSearchdblclick();" onkeydown="getRole(event);" value='<s:property value="txtrolename"/>'/>
                                    <input type="hidden" id="txtroleid" name="txtroleid" value='<s:property value="txtroleid"/>'/>
                                </td>
                            </tr>
                            <tr>
                                <td class="label-cell">User Name</td>
                                <td>
                                    <input type="text" id="txtusername" name="txtusername" placeholder="Press F3 to Search" ondblclick="funNamedblclick();" onkeydown="getName(event);" value='<s:property value="txtusername"/>'/>
                                    <input type="hidden" id="txtrolleid" name="txtrolleid" value='<s:property value="txtrolleid"/>'/>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>

            <!-- Main Grid / Data Section -->
            <div class="main-content-area">
                
                <div class="top-toolbar-container">
                    <jsp:include page="../../heading.jsp"></jsp:include>
                </div>

                <div class="grid-content-container">
                    <div id="userrolGriddiv" style="flex: 1; min-height: 250px;"><jsp:include page="userRoleGrid.jsp"></jsp:include></div> 
                    <div id="userroldetailsGriddiv" style="flex: 1; min-height: 250px;"><jsp:include page="userRoledetailsGrid.jsp"></jsp:include></div> 
                </div>

            </div>

        </div>

        <!-- Modals -->
        <div id="userRoleDetailsWindow">
            <div></div>
        </div>

    </div> 
</body>
</html>