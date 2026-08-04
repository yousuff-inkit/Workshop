
<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>

<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 
<style>/* ===== MASTER LAYOUT ===== */
html, body, #mainBG, .hidden-scrollbar {
    height: 100%;
    margin: 0;
    overflow: hidden;
    background-color: #f4f7f9;
}

.master-container {
    display: flex;
    width: 100%;
    height: 100vh;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
}

/* ===== LEFT SIDEBAR ===== */
.sidebar-filters {
    width: 320px; 
    flex: 0 0 320px; 
    background: #fff;
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
    padding: 15px 15px 25px; 
}

/* Cards Layout Rules */
.filter-card {
    background: #f8fafc;
    border: 1px solid #e3e8ee;
    border-radius: 12px;
    padding: 15px;
    margin-bottom: 12px;
}

/* Internal Presentation Tables */
.filter-table {
    width: 100%;
    border-spacing: 0 10px;
}

.filter-table .label-cell {
    text-align: right;
    padding-right: 10px;
    font-size: 12px;
    color: #4e5e71;
    font-weight: 600;
    width: 100px;
}

/* ===== UNIFORM 24px INPUTS & SELECTS ===== */
input[type="text"], select,
.filter-table input[type="text"],
.filter-table select {
    width: 100%;
    height: 24px !important;             
    padding: 2px 8px !important;         
    border: 1px solid #ccd6e0 !important;
    border-radius: 4px !important;       
    font-size: 12px !important;          
    background-color: #ffffff;
    box-sizing: border-box;
    color: #333;
    outline: none;
}

/* Textarea standardization */
textarea {
    width: 100%;
    border: 1px solid #ccd6e0;
    border-radius: 4px;
    padding: 8px;
    font-family: inherit;
    font-size: 12px;
    resize: vertical;
    box-sizing: border-box;
    outline: none;
}

/* Select specific styling */
select {
    padding: 2px 24px 2px 8px !important; 
    font-family: inherit;
    cursor: pointer;
    appearance: none;
    -webkit-appearance: none;
    background-image: url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' stroke='%234e5e71' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3e%3cpolyline points='6 9 12 15 18 9'%3e%3c/polyline%3e%3c/svg%3e");
    background-repeat: no-repeat;
    background-position: right 6px center;
    background-size: 12px;
}

/* jqx Date Container Mapping Rules */
.filter-table div[id^="todate"],
.filter-table div[id^="followupdate"] {
    width: 100%;
}

/* ===== MASTER 30px BUTTON SYSTEM ===== */
.btn-submit {
    width: 100%;
    height: 30px !important;            
    padding: 0 12px !important;
    background: #2563eb !important;
    color: #fff !important;
    border: none !important;
    border-radius: 4px !important;
    font-size: 13px !important;
    font-weight: 600 !important;
    cursor: pointer;
    line-height: 30px !important;
    white-space: nowrap;
    text-align: center;
    transition: all 0.2s ease;
    box-shadow: none !important;
    display: inline-block;
    box-sizing: border-box;
    margin-bottom: 8px;
}

.btn-submit:hover {
    background: #1d4ed8 !important;
}

/* Button Group Styling */
.button-group-row {
    display: flex;
    gap: 8px;
    margin-bottom: 8px;
}

.button-group-row .btn-submit {
    flex: 1;
    margin-bottom: 0;
}

/* ===== RIGHT CONTENT AREA (Horizontally Aligned Heading) ===== */
.main-content-wrapper {
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

.scrollable-grid-area {
    flex: 1;
    padding: 15px 20px;
    overflow: auto; 
    box-sizing: border-box;
}</style>

<script type="text/javascript">

$(document).ready(function () {
	 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#followupdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 /* var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
	 var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
	 $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate); */
	 
});

function funreload(event)
{

//var fromdate= $("#fromdate").jqxDateTimeInput('val');
var todate= $("#todate").jqxDateTimeInput('val'); 
$("#overlay, #PleaseWait").show();
var branch=$('#cmbbranch').val(); 
$("#pendingdiv").load("pendingInvoicesGrid.jsp?todate="+todate+"&id=1&branch="+branch);

}
	

function  funClearData()
{
	$('#frmPendingInvoices input,textarea').val('');
	$('#pendingInvoicesGrid,#followupGrid').jqxGrid('clear');
	$('#followupdate').jqxDateTimeInput('setDate',new Date());
	/* var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
	var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
	$('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate) */;
   		
}

function funUpdate(){
	if(document.getElementById("jobcarddocno").value==""){
		$.messager.alert('Warning','Please Select Valid Document','Warning');
		return false;
	}
	else{
		$.messager.confirm('Confirm', 'Do you want to save changes?', function(r){
			if (r){
				funUpdateAJAX();
			}
		});
	}
}
function funUpdateAJAX(){
	var remarks=$('#remarks').val();
	var followupdate=$('#followupdate').jqxDateTimeInput('val');
	var jobcarddocno=$('#jobcarddocno').val();
	var cmbstatus=$('#cmbstatus').val();
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText.trim();
			if(items=="0"){
				$.messager.alert('Message','Follow Up Completed Succesfully','info');
				funreload(1);
				$('#followupdiv').load('followupGrid.jsp?jobcarddocno='+jobcarddocno+'&id=1');
			}
			else if(items==1){
				$.messager.alert('Message','Follow Up Completion Failed','warning');
			}
			
		}
		else{
			}
		}
	
	x.open("GET", "followup.jsp?jobcarddocno="+jobcarddocno+"&remarks="+remarks.replace(/\n/g, " ").replace(/ /g,"%20")+"&followupdate="+followupdate+"&cmbstatus="+cmbstatus, true);
	x.send();
}
function funExportBtn(){
	//JSONToCSVCon(pendingexceldata, 'Pending Invoices', true);
	$("#pendingdiv").excelexportjs({
		containerid: "pendingdiv",
		datatype: 'json',
		dataset: null,
		gridId: "pendingInvoicesGrid",
		columns: getColumns("pendingInvoicesGrid") ,
		worksheetName:"Pending Invoices"
	});
}
function funPrintBtn(){
	 if($('#docno').val()!='' && $('#docno').val()!='0'){
		 
		var url=document.URL;
		var reurl=url.split("com");
		var save=$('#savestatus').val();
		//alert(save);
		if(save=='0'){
			$.messager.alert('message','please save the form','warning');
		}
		else
			{       
		/* var path= "com/dashboard/workshop/quotationapproval/printQuotationAproval.action?estDocno="+estdocno; */
		var path= "com/dashboard/workshop/jobcardcompletenewpal/printWSJobCardCompleteNewPal.action?docno="+$('#jobcarddocno').val();
		var win= window.open(reurl[0]+path,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");		
		win.focus();		
			}	
    }
		
}

 </script>
</head>
<body onload="getBranch();">
	<div id="mainBG" class="homeContent" data-type="background"> 
		<form id="frmPendingInvoices" method="POST">
			<div class='hidden-scrollbar'>

                <div class="master-container">

                    <!-- ================= LEFT PANEL (SIDEBAR) ================= -->
                    <div class="sidebar-filters">
                        <div class="sidebar-scroll-content">

                            <!-- Primary Filters Card -->
                            <div class="filter-card">
                                <table class="filter-table">
                                    <tr>
                                        <td class="label-cell">Up To Date</td>
                                        <td><div id='todate' name='todate' value='<s:property value="todate"/>'></div></td>
                                    </tr>  
                                </table>
                            </div>

                            <!-- Followup Details Card -->
                            <div class="filter-card">
                                <table class="filter-table">
                                    <tr>
                                        <td class="label-cell">FollowUp Date</td>
                                        <td><div id='followupdate' name='followupdate' value='<s:property value="followupdate"/>'></div></td>
                                    </tr>
                                    <tr>
                                        <td class="label-cell">Change Status</td>
                                        <td>
                                            <select name="cmbstatus" id="cmbstatus">
                                                <option value="">--Select--</option>
                                                <option value="WIP">WIP</option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <label class="branch" style="display:block; margin-bottom: 5px;">Remarks</label>
                                            <textarea id="remarks" name="remarks" rows="10"></textarea>
                                        </td>
                                    </tr>
                                </table>

                                <hr style="border: 0; border-top: 1px solid #e1e8ed; margin: 15px 0;">

                                <div class="button-group-row">
                                    <button type="button" class="btn-submit" id="btnupdate" onclick="funUpdate();">Update</button>
                                    <button type="button" class="btn-submit" id="btnclear" onclick="funClearData();" style="background:#64748b !important;">Clear</button>
                                </div>
                                <button type="button" class="btn-submit" id="btnPrint" onclick="funPrintBtn();" style="background:#10b981 !important;">Print</button>
                            </div>

                        </div>
                    </div>

                    <!-- ================= RIGHT PANEL (WORKSPACE GRIDS) ================= -->
                    <div class="main-content-wrapper">
                        
                        <!-- Horizontally Aligned Heading Toolbar -->
                        <div class="top-toolbar-container">
                            <jsp:include page="../../heading.jsp"></jsp:include>
                        </div>

                        <div class="scrollable-grid-area">
                            <div id="pendingdiv" style="margin-bottom: 20px;">
                                <jsp:include page="pendingInvoicesGrid.jsp"></jsp:include>
                            </div>
                            
                            <div id="followupdiv">
                                <jsp:include page="followupGrid.jsp"></jsp:include>
                            </div>
                        </div>

                    </div>

                </div>

			</div>
			<input type="hidden" name="jobcarddocno" id="jobcarddocno">
		</form>
	</div>

</body>
</html>