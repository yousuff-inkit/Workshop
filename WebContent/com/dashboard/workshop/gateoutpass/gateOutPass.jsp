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

/* ===== LEFT SIDEBAR ===== */
.sidebar-filters {
    width: 320px; 
    flex: 0 0 320px; 
    background: #fff;
    border-right: 1px solid #e1e8ed;
    display: flex;
    flex-direction: column;
    height: 90%;
    box-shadow: 2px 0 8px rgba(0,0,0,.05);
    z-index: 10;
     overflow-y: auto;
}

.sidebar-scroll-content {
    flex: 1;
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
    width: 95px;
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

/* Readonly fields override */
input[readonly],
input:disabled {
    background-color: #f3f6f9 !important;
    color: #555;
    border-color: #e1e8ed !important;
    cursor: text;
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

/* Checkboxes & Radios */
.checkbox-row {
    display: flex;
    justify-content: flex-start;
    align-items: center;
    gap: 8px;
    margin-bottom: 10px;
    font-size: 12px;
    font-weight: 600;
    color: #4e5e71;
}

.checkbox-row input[type="checkbox"] {
    margin: 0;
    vertical-align: middle;
}

/* jqx Date Container Mapping Rules */
.filter-table div[id^="fromdate"],
.filter-table div[id^="todate"],
.filter-table div[id^="newDate"],
.filter-table div[id^="time"] {
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
	$('#txtdriver').hide();
	$('#btnDiv').hide();
	 $('#Docno').attr('readonly',true); 
	 $('#clnames').attr('readonly',true);
	 $('#regDocnos').attr('readonly',true);
	 $('#gipDocno').attr('readonly',true);
		$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200px;right:750px;'><img src='../../../../icons/31load.gif'/></div>");
	    
	 $("#time").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"HH:mm",value:new Date(),showCalendarButton:false});  
	 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#newDate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
	 var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
	 $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate);
	 
	 $('#clnames').dblclick(function(){
	  	 	clientSearchContent("clientSearch.jsp");

		});
	 
	 $('#regDocnos').dblclick(function(){
		 gateSearchContent("gateInPassSearch.jsp?check=1");

		});
	 $('#gipDocno').dblclick(function(){
		 gateSearchContent("gateInPassSearch.jsp?check=2");

		});
	 
	 $('#ClientDetailsToWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Client Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 $('#ClientDetailsToWindow').jqxWindow('close');
	 
	 $('#RegnoToWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Gate In Pass Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 $('#RegnoToWindow').jqxWindow('close');
	 
	 
});
function check(){
	if(document.getElementById('chkpassed').checked==true){
		$('#gateOutPassGrid').jqxGrid('showcolumn', 'datetime'); 
	}
	else{
		$('#gateOutPassGrid').jqxGrid('hidecolumn', 'datetime'); 
	}
}
function funreload(event)
{	
	var status="";
	if(document.getElementById('chkpassed').checked==true){
	 status=1;
	}
	else{
		status=2;
		
	}
    var fromdate=$('#fromdate').jqxDateTimeInput('val');
    var todate=$('#todate').jqxDateTimeInput('val');
	var cldocno=$('#cldocnos').val();
	var regno=$('#regDocnos').val();
	var gipno=$('#gipDocno').val();
    var brhid=$('#cmbbranch').val();
    $("#overlay, #PleaseWait").show(); 
    $("#gateoutpassdiv").load("gateOutPassGrid.jsp?fromdate="+fromdate+"&todate="+todate+"&id=1"+"&status="+status+"&cldocno="+cldocno+"&regno="+regno+"&gipno="+gipno+"&brhid="+brhid); 
	
	
}
	function setValues(){

		 if($('#msg').val()!=""){
   		   $.messager.alert('Message',$('#msg').val());
   		  }
	
	}
	
	function funExportBtn(){
		var title="";
		if(document.getElementById('chkpassed').checked==true){
			title="Gate Out Pass Generated";
		}
		else{
			title="Gate Out Pass To Be Generated";
		}
		
		$("#gateOutPassGrid").excelexportjs({
			containerid: "gateOutPassGrid",
			datatype: 'json',
			dataset: null,
			gridId: "gateOutPassGrid",
			columns: getColumns("gateOutPassGrid"),
			worksheetName: title
		});
				
		
		//JSONToCSVCon(exceldata, title, true);
	}
	
	
	function funNotify(){
		
		return 1;
		
	}
	
	function funUpdateGate() {
		var date=$('#newDate').jqxDateTimeInput('val');
		var kilometer=$('#txtkilometer').val();
		var fuel=$('#cmbfuel').val();
		var docno=$('#Docno').val();
		var time=$('#time').val();
		var driver="";
		if(document.getElementById("chkdriver").checked){
			driver=$('#txtdriver').val();
		}else{
			driver=$('#driverid').val();
		}
		console.log($('#jqxInputDriver').val()+"==driver=="+$('#driverid').val());   
		var clientinvpending=$('#clientinvpending').val();
		if(clientinvpending=='1'){
			$.messager.alert('Warning','Client Invoices Pending');
			return false;
		}
		if(docno==""){
			$.messager.alert('Message','Please Select the document');
		}else{
		
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var sts = x.responseText;
					if(sts==1){
						$.messager.alert('Message','Not Updated');
					}
					if(sts==0){
						$.messager.alert('Message','Updated Succesfully');
						funreload(event);
						funClearData();
					}
					funchangedriver();
				}
		}
				
		}
		x.open("GET", "updateGate.jsp?docno="+docno+"&kilometer="+kilometer+"&fuel="+fuel+"&date="+date+"&time="+time+"&driver="+driver,true);  
		x.send();
	}	
	
	function funClearData(){
		$('input[type=text],[type=hidden]').val('');
		$('select').find('option').prop("selected", false);
		$('#fromdate').jqxDateTimeInput('setDate',new Date());
		$('#todate').jqxDateTimeInput('setDate',new Date());
		var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
	    var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
	    $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate); 
	    $('input[type=radio]').prop("checked",false);
	    $('input[type=checkbox]').prop("checked",false);
	    $('#time').jqxDateTimeInput('setDate',new Date());
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
	
	function getGateDetails(event){
	    var x= event.keyCode;
	    if(x==114){
	  	 	gateSearchContent("gateInPassSearch.jsp?check=1");
	    }
	    else{
	     }
	    }
	function gateSearchContent(url) {
	 	$('#RegnoToWindow').jqxWindow('open');
		$.get(url).done(function (data) {
			$('#RegnoToWindow').jqxWindow('setContent', data);
		}); 
	}
	function isNumber(evt,id) {
		//Function to restrict characters and enter number only
			  var iKeyCode = (evt.which) ? evt.which : evt.keyCode
		        if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57))
		         {
		        	 $.messager.alert('Warning','Enter Numbers Only');
		           $("#"+id+"").focus();
		            return false;
		            
		         }
		        
		        return true;
		    }

	 function funPrint(){
		if($('#Docno').val()!='' && $('#Docno').val()!='0'){
			var url=document.URL;
			var reurl=url.split("com");
			var dtype="BGOP";
			var path= "com/dashboard/workshop/gateoutpass/printgateoutpasss.action?Docno="+$('#Docno').val()+"&dtype="+dtype;
			var win= window.open(reurl[0]+path,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");		
			win.focus();		
		 }
		else {
			$.messager.alert('Message','Please Select a jobcard.','warning');
			return;
		}
	} 
	function funchangedriver(){
		$('#txtdriver').val('');
		$('#jqxInputDriver').val('');
		$('#driverid').val('');   
		if(document.getElementById("chkdriver").checked){
			$('#txtdriver').show();
			$('#jqxInputDriver').hide();
		}else{
			$('#txtdriver').hide();
			$('#jqxInputDriver').show();  
		}
	}
	</script>
	
</head>
<body onload="setValues();getBranch();">
<form id="frmWorkGateOutPass" method="post" autocomplete="off"> 
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
                        <td colspan="2">
                            <div class="checkbox-row" style="justify-content: center; margin-top: 5px;">
                                <input type="checkbox" name="chkpassed" id="chkpassed">
                                <label for="chkpassed" style="cursor: pointer;">Gate out pass Generated</label>
                            </div>
                        </td>
                    </tr>
                </table>
            </div>

            <!-- Search Details Card -->
            <div class="filter-card">
                <table class="filter-table">
                    <tr>
                        <td class="label-cell">Client</td>
                        <td>
                            <input type="text" name="clnames" id="clnames" placeholder="Press F3 to Search" onkeydown="getClientDetails(event)">
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Reg No</td>
                        <td>
                            <input type="text" name="regDocnos" id="regDocnos" placeholder="Press F3 to Search" onkeydown="getGateDetails(event)">
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Gate In Pass No</td>
                        <td>
                            <input type="text" name="gipDocno" id="gipDocno" placeholder="Press F3 to Search" onkeydown="getGateDetails(event)">
                        </td>
                    </tr>
                </table>
            </div>

            <!-- Update Details Card -->
            <div class="filter-card">
                <table class="filter-table">
                    <tr>
                        <td class="label-cell">Date</td>
                        <td><div id="newDate" name="newDate"></div></td>
                    </tr>
                    <tr>
                        <td class="label-cell">Start Time</td>
                        <td><div id="time" name="time"></div></td>
                    </tr>
                    <tr>
                        <td class="label-cell">Kilometer</td>
                        <td>
                            <input type="text" name="txtkilometer" id="txtkilometer" onkeypress="javascript:return isNumber (event,id)" onblur="funRoundAmt(value,id);">
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Fuel</td>
                        <td>
                            <select name="cmbfuel" id="cmbfuel" value='<s:property value="cmbfuel"/>'>
                                <option value=0.000 selected>Level 0/8</option>
                                <option value=0.125>Level 1/8</option>
                                <option value=0.250>Level 2/8</option>
                                <option value=0.375>Level 3/8</option>
                                <option value=0.500>Level 4/8</option>
                                <option value=0.625>Level 5/8</option>
                                <option value=0.750>Level 6/8</option>
                                <option value=0.875>Level 7/8</option>
                                <option value=1.000>Level 8/8</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Doc No</td>
                        <td><input type="text" name="Docno" id="Docno"></td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <div class="checkbox-row" style="margin-top: 8px;">
                                <input type="checkbox" name="chkdriver" id="chkdriver" onchange="funchangedriver();">
                                <label for="chkdriver" style="cursor: pointer;">New Driver</label>
                            </div>
                            <div id="drvid" style="margin-bottom: 5px;"><jsp:include page="driverSearch.jsp"></jsp:include></div>
                            <input type="text" name="txtdriver" id="txtdriver">
                        </td>
                    </tr>
                </table>

                <hr style="border: 0; border-top: 1px solid #e1e8ed; margin: 15px 0;">

                <div class="button-group-row">
                    <input type="button" name="btnclear" id="btnclear" value="Clear" class="btn-submit" onclick="funClearData();" style="background:#64748b !important;">
                    <input type="button" name="btnUpdate" id="btnUpdate" value="Update" class="btn-submit" onclick="funUpdateGate();" style="background:#10b981 !important;">
                </div>
                <button type="button" class="btn-submit" id="btnprint" onclick="funPrint();">Print</button>
            </div>

            <!-- Hidden Inputs Maintained Safely Outside Visual Layout -->
            <div style="display:none;">
                <input type="hidden" name="cldocnos" id="cldocnos">
                <input type="hidden" name="driverid" id="driverid">
                <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
                <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
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
            <div id="gateoutpassdiv">
                <jsp:include page="gateOutPassGrid.jsp"></jsp:include>
            </div>
        </div>

    </div>

</div>

<!-- Popups Maintained Outside the Layout Flow -->
<div id="ClientDetailsToWindow">
    <div></div>
</div>

<div id="RegnoToWindow">
    <div></div>
</div>

<div id="gateDocnoToWindow">
    <div></div>
</div>

</div>
</form>
</body>
</html>