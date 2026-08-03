<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 
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

/* ===== LEFT SIDEBAR ===== */
.sidebar-filters {
    width: 300px; 
    flex: 0 0 300px; 
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
    width: 80px;
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

/* Readonly fields override */
input[readonly],
input:disabled {
    background-color: #f3f6f9 !important;
    color: #555;
    border-color: #e1e8ed !important;
    cursor: text;
}

/* jqx Date Container Mapping Rules */
.filter-table div[id^="fromdate"],
.filter-table div[id^="todate"],
.filter-table div[id^="estdate"],
.filter-table div[id^="esttime"] {
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
		document.getElementById("branchlabel").style.display="none";
		document.getElementById("branchdiv").style.display="none";
		  
		$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200px;right:750px;'><img src='../../../../icons/31load.gif'/></div>");
	    $('#clientwindow').jqxWindow({ width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Client Search'  , theme: 'energyblue', position: { x: 250, y: 120 }, keyboardCloseKey: 27});
		$('#clientwindow').jqxWindow('close');
	    
	    $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	    $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	    $("#estdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	    $("#esttime").jqxDateTimeInput({ width: '80px', height: '15px',formatString:"HH:mm",showCalendarButton:false,value:new Date()});
	    var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
	    var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1)); 
	    $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate);
	    $('#clientname').dblclick(function(){
	  	    
		   $('#clientwindow').jqxWindow('open');
		       		clientSearchContent('clientsearch.jsp', $('#clientwindow')); 
	       });
});


	function funreload(event)
	{
		var load=$('#txttype').val();
		var clnt=$('#cldocno').val();
	    var fromdate=$('#fromdate').jqxDateTimeInput('val');
	    var todate=$('#todate').jqxDateTimeInput('val');
	    $("#overlay, #PleaseWait").show();
	    $("#gateinpassdiv").load("gipUpdateGrid.jsp?froms="+fromdate+"&tdt="+todate+"&ldtype="+load+"&cldocno="+clnt+"&check=1");
	   	
	}
	
	

	function setValues(){

		 if($('#msg').val()!=""){
   		   $.messager.alert('Message',$('#msg').val());
   		  }
	
	}
	
	function funExportBtn(){
		JSONToCSVCon(repexceldata, 'Replacement List', true);
		 }
	
	function getclinfo(event){
		 var x= event.keyCode;
		if(x==114){
	 		$('#clientwindow').jqxWindow('open');
			clientSearchContent('clientsearch.jsp', $('#clientwindow'));    }
		else{}
	} 

	function clientSearchContent(url) {
		 	$.get(url).done(function (data) {
			$('#clientwindow').jqxWindow('open');
			$('#clientwindow').jqxWindow('setContent', data);
	}); 
	} 
		
	
	function funClearData(){
		$('#fromdate,#estdate,#esttime').jqxDateTimeInput('setDate',new Date());
		$('#todate').jqxDateTimeInput('setDate',new Date());
		var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
	    var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
	    $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate); 
	 	document.getElementById("txttype").value="";
		document.getElementById("clientname").value="";
		document.getElementById("cldocno").value="";
		$('#jqxFleetGrid').jqxGrid('clear');
		$('#lblgip').text('');
		$('#gipdocno,#gipvocno,#estkm').val('');
	
	}
	
	function funLoadData(){
	
	  	document.getElementById("txttype").value="";
		document.getElementById("clientname").value="";
	}
	
	function funSaveData(){
		if($('#gipdocno').val()==''){
			$.messager.alert('Warning','Please select a valid document');
			return false;
		}
		if($('#estdate').jqxDateTimeInput('getDate')==null){
			$.messager.alert('Warning','Please select a valid date');
			return false;
		}
		if($('#esttime').jqxDateTimeInput('getDate')==null){
			$.messager.alert('Warning','Please select a valid time');
			return false;
		}
		if($('#estkm').val()==''){
			$.messager.alert('Warning','Km is Mandatory');
			return false;
		}
		var gipdocno=$('#gipdocno').val();
		var estdate=$('#estdate').jqxDateTimeInput('val');
		var esttime=$('#esttime').jqxDateTimeInput('val');
		var estkm=$('#estkm').val();
		funUpdateData(gipdocno,estdate,esttime,estkm);
	}
	
	function funUpdateData(gipdocno,estdate,esttime,estkm){
		$("#overlay, #PleaseWait").show(); 
 		var x = new XMLHttpRequest();
 		x.onreadystatechange = function() {
 			if (x.readyState == 4 && x.status == 200) {
 				var items = x.responseText.trim();
 				if(items=="0"){
 					$.messager.alert('Message','Successfully Updated');
 					funClearData();
 					funreload("");
 				}
 				else{	
 					$.messager.alert('Warning','Not Updated');
 				}
 		
 				$("#overlay, #PleaseWait").hide(); 
 			
 			}
 			else {
 			}
 		}
 		x.open("GET", "updateData.jsp?gipdocno="+gipdocno+"&estdate="+estdate+"&esttime="+esttime+"&estkm="+estkm, true);
 		x.send();
  	}
	function isNumber(evt) {
	    evt = (evt) ? evt : window.event;
	    var charCode = (evt.which) ? evt.which : evt.keyCode;
	    if (charCode > 31 && (charCode < 48 || charCode > 57)) {
	        return false;
	    }
	    return true;
	}
	</script>
	
</head>
<body onload="setValues();">
<form id="frmReplaceList" method="post">
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
                        <td class="label-cell">From Date</td>
                        <td><div id="fromdate"></div></td>
                    </tr>
                    <tr>
                        <td class="label-cell">To Date</td>
                        <td><div id="todate"></div></td>
                    </tr>
                    <tr>
                        <td class="label-cell">Client</td>
                        <td>
                            <input type="text" name="clientname" id="clientname" placeholder="Press F3 To Search" readonly="readonly" onKeyDown="getclinfo(event);" onclick="this.placeholder=''" value='<s:property value="clientname"/>'>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Type</td>            
                        <td>
                            <select id="txttype" name="txttype" value='<s:property value="txttype"/>'>   
                                <option value="">--select--</option>
                                <option value="open">open</option>
                                <option value="close">close</option>
                            </select>
                        </td>
                    </tr>
                </table>
            </div>

            <!-- GIP Label Container -->
            <div style="text-align: center; font-weight: bold; margin-bottom: 12px; color: blue;">
                <label id="lblgip"></label>
            </div>

            <!-- Estimation & Update Card -->
            <div class="filter-card">
                <table class="filter-table">
                    <tr>
                        <td class="label-cell">Est.Date</td>
                        <td><div id="estdate"></div></td>
                    </tr>
                    <tr>
                        <td class="label-cell">Est.Time</td>
                        <td><div id="esttime"></div></td>
                    </tr>
                    <tr>
                        <td class="label-cell">Km</td>
                        <td>
                            <input type="text" name="estkm" id="estkm" onkeypress="return isNumber(event);">
                        </td>
                    </tr>
                </table>

                <hr style="border: 0; border-top: 1px solid #e1e8ed; margin: 15px 0;">

                <div class="button-group-row">
                    <input type="button" name="btnclear" id="btnclear" value="Clear" class="btn-submit" onclick="funClearData();" style="background:#64748b !important;">
                    <input type="button" name="btnsave" id="btnsave" value="Update" class="btn-submit" onclick="funSaveData();">
                </div>
            </div>

            <!-- Hidden Inputs Maintained Safely Outside Visual Layout -->
            <div style="display:none;">
                <input type="hidden" name="cldocno" id="cldocno" value='<s:property value="cldocno"/>' >
                <input type="hidden" name="gipdocno" id="gipdocno" value='<s:property value="gipdocno"/>'>
                <input type="hidden" name="gipvocno" id="gipvocno" value='<s:property value="gipvocno"/>'>
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
            <div id="gateinpassdiv">
                <jsp:include page="gipUpdateGrid.jsp"></jsp:include>
            </div>
        </div>

    </div>

</div>

<!-- Popups Maintained Outside the Layout -->
<div id="clientwindow">
   <div></div>
</div>
<div id="agmtnowindow">
    <div></div>
</div>

</div>
</div>
</form>
</body>
</html>