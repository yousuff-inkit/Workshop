<link href="../../../../css/css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<%--  <script type="text/javascript" src="../../js/dashboard.js"></script>  --%>
<style type="text/css">/* ===== MASTER LAYOUT ===== */
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

.filter-card {
    background: #f8fafc;
    border: 1px solid #e3e8ee;
    border-radius: 12px;
    padding: 15px;
    margin-bottom: 12px;
}

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


.radio-group {
    display: flex;
    justify-content: center;
    gap: 15px;
    margin-top: 10px;
    margin-bottom: 10px;
    font-size: 12px;
    font-weight: 600;
    color: #4e5e71;
}

.radio-group label {
    display: flex;
    align-items: center;
    cursor: pointer;
}

.radio-group input[type="radio"],
input[type="checkbox"] {
    margin: 0 5px 0 0;
    vertical-align: middle;
}

/* jqx Date Container Mapping Rules */
.filter-table div[id^="todate"] {
    width: 100%;
}

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
	
	$('#btnDiv1').hide();
	$('#btnDiv2').hide();
	 $('#estDocno').attr('readonly',true); 
	 $('#clnames').attr('readonly',true);
		$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200px;right:750px;'><img src='../../../../icons/31load.gif'/></div>");
	    
	 //$("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	// $("#podate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null});
	 /* var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
	 var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
	 $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate); */
	 document.getElementById("tobeapproved").checked=true;
	 $('#clnames').dblclick(function(){
	  	 	clientSearchContent("clientSearch.jsp");

		});
	 
	 $('#ClientDetailsToWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '60%' ,maxWidth: '51%' , title: 'Client Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 $('#ClientDetailsToWindow').jqxWindow('close');
	 
	 
	 
	 
	 
});

function setApprov(){
	
	if(document.getElementById("approved").checked){
		document.getElementById("approval").value="approved";
		$('#btnDiv1').hide();
		$('#btnDiv2').show();
	}
	else if(document.getElementById("tobeapproved").checked){
		document.getElementById("approval").value="tobeapproved";
		$('#btnDiv1').show();
		$('#btnDiv2').hide();
		
	}
	else{
		document.getElementById("gender").value="not selected";
	}
	
}

function funreload(event)
{	
	funNotify();
	setApprov();
    //var fromdate=$('#fromdate').jqxDateTimeInput('val');
    var todate=$('#todate').jqxDateTimeInput('val');
	var aprv=$('#approval').val();
	var docnos=$('#cldocnos').val();
     $("#overlay, #PleaseWait").show(); 
    $("#quotationapprovaldiv").load("quotationAprovalGrid.jsp?todate="+todate+"&id=1"+"&aprv="+aprv+"&docnos="+docnos+"&branch="+$('#cmbbranch').val()); 
	
	$('input[type=text],[type=hidden]').val('');
	//$('select').find('option').prop("selected", false);
	//$('#fromdate').jqxDateTimeInput('setDate',new Date());
	$('#todate').jqxDateTimeInput('setDate',new Date());
	/* var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
    var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
    $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate); */
   	
}
	
function funSetApprv(action) {
	var excess=0;
	var estdocno=$('#estDocno').val();
	var hid=$('#brhid').val();
	var poNo=$('#pono').val();
	var poDate=0;
	var desc=$('#description').val();
	var examt=$('#excessamt').val();
	var gipNos=$('#gipnos').val();
	var waveoffreason="";
	var addition=$('#addition').val();
	var estvocno=$('#estvocno').val();
	if(action=="2" || action=="3"){
		waveoffreason=$('#waveoffreason').val();
	}
	if ($('#chkexcess').is(":checked"))
	{
	   excess=1;
	}
	
	
	if(estdocno==""){
		$.messager.alert('Message','Please Select the document');
		return false;
	}else{
		$.messager.confirm('Confirm', 'Do you want to save changes of EST #'+estvocno+'?', function(r){
			if (r){
				var x = new XMLHttpRequest();
				x.onreadystatechange = function() {
					if (x.readyState == 4 && x.status == 200) {
						var sts = x.responseText;
						if(sts==1){
							$.messager.alert('Message','Not Approved');
						}
						if(sts==0){
							if(action=="2"){
								$.messager.alert('Message','Waved Off Succesfully');
							}
							else if(action=="3"){
								$.messager.alert('Message','Cancelled Succesfully');	
							}
							else{
								$.messager.alert('Message','Approved Succesfully');	
							}
							funreload(event);
						}
					}
				}
	
				x.open("GET", "setApproval.jsp?addition="+addition+"&estDocno="+estdocno+"&brhid="+hid+"&pono="+poNo+"&podate="+poDate+"&excess="+excess+"&desc="+desc+"&excessamt="+examt+"&gipno="+gipNos+"&tobe=1&action="+action+"&waveoffreason="+waveoffreason, true);
				x.send();
			}
		});
	}
}	

function funUpdateApprv() {
	var excess=0;
	var estdocno=$('#estDocno').val();
	var estvocno=$('#estvocno').val();
	var hid=$('#brhid').val();
	var poNo=$('#pono').val();
	var poDate=0;
	var desc=$('#description').val();
	var examt=$('#excessamt').val();
	var gipNos=$('#gipnos').val();
	
	if ($('#chkexcess').is(":checked"))
	{
	   excess=1;
	}
	
	
	if(estdocno==""){
		$.messager.alert('Message','Please Select the document');
		return false;
	}else{
		$.messager.confirm('Confirm', 'Do you want to save changes of EST #'+estvocno+'?', function(r){
			if (r){
				var x = new XMLHttpRequest();
				x.onreadystatechange = function() {
					if (x.readyState == 4 && x.status == 200) {
						var sts = x.responseText;
							if(sts==1){
								$.messager.alert('Message','Not updated');
							}
							if(sts==0){
								$.messager.alert('Message','Updated Succesfully');
								funreload(event);
							}
						}
				}
						
				}
				x.open("GET", "setApproval.jsp?estDocno="+estdocno+"&brhid="+hid+"&pono="+poNo+"&podate="+poDate+"&excess="+excess+"&desc="+desc+"&excessamt="+examt+"&gipno="+gipNos+"&tobe=2", true);
				x.send();			
		});
	
	}
}


	function setValues(){

		 if($('#msg').val()!=""){
   		   $.messager.alert('Message',$('#msg').val());
   		  }
	
	}
	
	function funExportBtn(){
		//JSONToCSVCon(repexceldata, 'Replacement List', true);
		var exceltitle='';
		if($('#approved').is(':checked')){
			exceltitle='Quotation Approved List';
		}
		else{
			exceltitle='Quotation To Be Approved List';
		}
		$("#quotationApprovalGrid").excelexportjs({
			containerid: "quotationApprovalGrid",
			datatype: 'json',
			dataset: null,
			gridId: "quotationApprovalGrid",
			columns: getColumns("quotationApprovalGrid"),
			worksheetName: exceltitle
		});
					
	}
	
	function funPrintData() {
		var estdocno=$('#estvocno').val();
		if(estdocno=='' || estdocno=='0'){
   		 $.messager.alert('Warning','Select a Document');
		}
		else{
			 console.log("==="+$('#estprintconfig').val());  
			 if($('#estprintconfig').val()=='1'){           
						var url=document.URL;
						var reurl=url.split("com");
						var docno=$('#estDocno').val();
						var gatedoc=$('#gipdocno').val();
						var path= "com/workshop/wsestimationpal/printEstimation1.action?estDocno="+estdocno+"&docno="+docno+"&gatedocno="+gatedoc+"&branch="+$('#brhid').val()+"&addition="+0+"&withvat="+0;     
						var win= window.open(reurl[0]+path,"_blank","top=250,left=310,Width=700,Height=600,location=no,scrollbars=yes,toolbar=yes");	          	
						win.focus();	   	
			 }else{   
				    	var url=document.URL;
				 		var reurl=url.split("quotationApproval.jsp");  
				 		var docno=$('#estDocno').val();
						var gatedoc=$('#gipdocno').val();
				    	var path= "printQuotationAproval.action?estDocno="+estdocno+"&docno="+docno+"&gatedocno="+gatedoc+"&branch="+$('#brhid').val(); 
				        var win= window.open(reurl[0]+path,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");		
				        win.focus();  	
			 }
		 }
    	} 
	function funNotify(){
		if(!document.getElementById("approved").checked && !document.getElementById("tobeapproved").checked){
			$.messager.alert('Message','please select document type');
		}
		else{
		return 1;
		}
	}
	
		
	
	function funClearData(){
		$('input[type=text],[type=hidden]').val('');
		$('select').find('option').prop("selected", false);
		$('#todate').jqxDateTimeInput('setDate',new Date());
		/* $('#fromdate').jqxDateTimeInput('setDate',new Date());
		var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
	    var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
	    $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate);  */
	    $('input[type=radio]').prop("checked",false);
	    $('input[type=checkbox]').prop("checked",false);
	}
	
	function getClientDetails(event){
	    var x= event.keyCode;
	    if(x==114){
	  	 	clientSearchContent("clientSearch.jsp");
	    }
	    else{
	     }
	    }
	function clientSearchContent(url) {
	 	$('#ClientDetailsToWindow').jqxWindow('open');
		$.get(url).done(function (data) {
			$('#ClientDetailsToWindow').jqxWindow('setContent', data);
		}); 
	}
	
	function getEstPrintConfig(){       
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				items = x.responseText.trim();
				$("#estprintconfig").val(items);               
			} else {
			}
		}
		x.open("GET", "getEstPrintConfig.jsp", true);       
		x.send();
	}
	</script>
	
</head>
<body onload="setValues();getBranch();getEstPrintConfig();">
<form id="frmWorkQuotationApproval" method="post">
<div id="mainBG" class="homeContent" data-type="background"> 
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
                        <td><div id="todate"></div></td>
                    </tr>
                    <tr>
                        <td class="label-cell">Client</td>
                        <td>
                            <input type="text" name="clnames" id="clnames" placeholder="Press F3 to Search" onkeydown="getClientDetails(event)">
                        </td>
                    </tr>
                </table>
                
                <div class="radio-group">
                    <label>
                        <input type="radio" name="approv" id="approved">
                        Approved
                    </label>
                    <label>
                        <input type="radio" name="approv" id="tobeapproved">
                        To Be Approved
                    </label>
                </div>
            </div>

            <!-- Details Card -->
            <div class="filter-card">
                <table class="filter-table">
                    <tr>
                        <td class="label-cell">PO No</td>
                        <td><input type="text" name="pono" id="pono"></td>
                    </tr>
                    <tr>
                        <td class="label-cell">Description</td>
                        <td><input type="text" name="description" id="description"></td>
                    </tr>
                    <tr>
                        <td class="label-cell">Excess Amount</td>
                        <td>
                            <div style="display:flex; align-items:center; gap: 5px;">
                                <input type="checkbox" name="chkexcess" id="chkexcess">
                                <input type="text" name="excessamt" id="excessamt">
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Wave Off/Cancel Reason</td>
                        <td><input type="text" name="waveoffreason" id="waveoffreason"></td>
                    </tr>
                    <tr>
                        <td class="label-cell">Addition</td>
                        <td><input type="text" name="addition" id="addition" value='<s:property value="addition"/>' readonly/></td>
                    </tr>
                </table>
            </div>

            <!-- Action Buttons Card -->
            <div class="filter-card">
                <div id="btnDiv1">
                    <button type="button" name="btnApprove" id="btnApprove" class="btn-submit" onclick="funSetApprv(1)">Approve</button>
                    <div class="button-group-row">
                        <button type="button" name="btnWaveoff" id="btnWaveoff" class="btn-submit" onclick="funSetApprv(2)">Waveoff</button>
                        <button type="button" name="btnCancel" id="btnCancel" class="btn-submit" onclick="funSetApprv(3)">Cancel</button>
                    </div>
                </div>
                
                <div id="btnDiv2">
                    <button type="button" name="btnUpdateApprove" id="btnUpdateApprove" class="btn-submit" onclick="funUpdateApprv()">Update</button>
                </div>

                <hr style="border: 0; border-top: 1px solid #e1e8ed; margin: 12px 0;">

                <div class="button-group-row">
                    <button type="button" name="btnclear" id="btnclear" class="btn-submit" onclick="funClearData();" style="background:#64748b !important;">Clear</button>
                    <button type="button" name="btnrepprint" id="btnrepprint" class="btn-submit" onclick="funPrintData();" style="  background: #2563eb !important;">Print</button>
                </div>
            </div>

            <!-- Hidden Inputs Maintained Safely Outside Visual Layout -->
            <div style="display:none;">
                <input type="hidden" name="cldocnos" id="cldocnos">
                <input type="hidden" id="approval" name="approval" value='<s:property value="approval"/>'>
                <input type="hidden" name="estDocno" id="estDocno">
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
            
            <div id="quotationapprovaldiv">
                <jsp:include page="quotationAprovalGrid.jsp"></jsp:include>
            </div>

            <!-- Hidden Output Bindings -->
            <div style="display:none;">
                <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
                <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
                <input type="hidden" name="brhid" id="brhid" value='<s:property value="brhid"/>'>
                <input type="hidden" name="gipnos" id="gipnos" value='<s:property value="gipno"/>'>
                <input type="hidden" name="estvocno" id="estvocno" value='<s:property value="estvocno"/>'>
                <input type="hidden" name="estDocno" id="estDocno" value='<s:property value="estDocno"/>'>
                <input type="hidden" name="gipdocno" id="gipdocno" value='<s:property value="gipdocno"/>'>
                <input type="hidden" name="estprintconfig" id="estprintconfig" value='<s:property value="estprintconfig"/>'/>
            </div>

        </div>

    </div>

</div>

<div id="ClientDetailsToWindow">
    <div></div>
</div>

</div>
</form>
</body>
</html>