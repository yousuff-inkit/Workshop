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
    width: 280px; 
    flex: 0 0 280px; 
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

/* Readonly fields override */
input[readonly],
input:disabled {
    background-color: #f3f6f9 !important;
    color: #555;
    border-color: #e1e8ed !important;
    cursor: text;
}

/* jqx Date Container Mapping Rules */
.filter-table div[id^="Uptodate"] {
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
}

/* Color Classes Native to Page */
.headClass { background-color: #FFEBC2; }
.redClass { background-color: #FFEBEB; }
.violetClass { background-color: #EBD6FF; }
.yellowClass { background-color: #FFFFD1; }
.whiteClass { background-color: #FFF; }
.greenClass { background-color: #CEFFCE; }</style>

<script type="text/javascript">

$(document).ready(function () {
	
	
		$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200px;right:750px;'><img src='../../../../icons/31load.gif'/></div>");
	    
	 $("#Uptodate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 
	 $('#bayWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Bay Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 $('#bayWindow').jqxWindow('close');
	 
	 $('#TechnicianWindow').jqxWindow({ width: '50%', height: '55%',  maxHeight: '55%' ,maxWidth: '50%' , title: 'Technician Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	 $('#TechnicianWindow').jqxWindow('close');
	 
	 $('#sparePartWindow').jqxWindow({ width: '50%', height: '55%',  maxHeight: '55%' ,maxWidth: '50%' , title: 'Spare Part Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	 $('#sparePartWindow').jqxWindow('close');
	 
	 $('#availWindow').jqxWindow({ width: '50%', height: '55%',  maxHeight: '55%' ,maxWidth: '50%' , title: 'Technician Availability' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	 $('#availWindow').jqxWindow('close');
	 
	 $('#jobcard').dblclick(function(){
		 jobCardSearchContent("jobCardSearch.jsp");

		});
	 $('#jobCardToWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Job Card Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 $('#jobCardToWindow').jqxWindow('close');
	 
});


	

	function funNotify(){
		
		return 1;
		
	}
	
		
	
	function funClearData(){
		$('input[type=text],[type=hidden]').val('');
		$('select').find('option').prop("selected", false);
		$('#Uptodate').jqxDateTimeInput('setDate',new Date());
	    $('input[type=radio]').prop("checked",false);
	    $('input[type=checkbox]').prop("checked",false);
	    $("#jobPlanningGrid,#bayGrid,#serviceTeamGrid").jqxGrid('clear');
	   
	}
	
	
	function funreload(event)
	{	
		var date=$('#Uptodate').jqxDateTimeInput('val');
	    var jobcard=document.getElementById("jobcard").value;
	    var brhid=$('#cmbbranch').val();
	    $("#jobPlanningGrid,#bayGrid,#serviceTeamGrid").jqxGrid('clear');
	    $("#overlay, #PleaseWait").show();
	    $("#jobplanninggriddiv").load("jobPlanningGrid.jsp?uptodate="+date+"&id=1"+"&jobcard="+jobcard+"&brhid="+brhid); 
	}
	
	 function SearchContent(url,id) {
	 $('#'+id).jqxWindow('open');
	    $.get(url).done(function (data) {
	  $('#'+id).jqxWindow('setContent', data);
	}); 
	}
	 

function getjobCardDetails(event){
    var x= event.keyCode;
    if(x==114){
    	jobCardSearchContent("jobCardSearch.jsp");
    }
    else{
     }
    }
function jobCardSearchContent(url) {
 	$('#jobCardToWindow').jqxWindow('open');
	$.get(url).done(function (data) {
		$('#jobCardToWindow').jqxWindow('setContent', data);
	});
}    

function funExportBtn(){
	//JSONToCSVConvertor(jobexceldata, 'Job List', true);
	$("#jobPlanningGrid").excelexportjs({
		containerid: "jobPlanningGrid",
		datatype: 'json',
		dataset: null,
		gridId: "jobPlanningGrid",
		columns: getColumns("jobPlanningGrid"),
		worksheetName: "Job List"
	});
		
}

function funUpdateData(){
	if($('#jobdocno').val()==''){
		$.messager.alert('Warning','Please select a valid document');
		return false;
	}
	var bayrows=$('#bayGrid').jqxGrid('getselectedrowindexes');
	if(bayrows.length==0){
		$.messager.alert('Warning','Please select atleast 1 bay');
		return false;
	}
	for(var i=0;i<bayrows.length;i++){
		var seqno=$('#bayGrid').jqxGrid('getcellvalue',bayrows[i],'seqno');
		if(seqno=="" || seqno==null || seqno=="undefined" || typeof(seqno)=="undefined"){
			$.messager.alert('Warning','Please fill Seq No of selected bays');
			return false;
		}
		for(var j=0;j<bayrows.length;j++){
			var dupseqno=$('#bayGrid').jqxGrid('getcellvalue',bayrows[j],'seqno');
			if(i!=j && seqno==dupseqno){
				$.messager.alert('Warning','Duplicate Sequence number not allowed');
				return false;
			}
		}
	}
	
	 $.messager.confirm('Confirm', 'Do you want to Save Changes?', function(r){
    	if (r){ 
      		funUpdateDataAjax();
  		}
 	});
	
}
function funUpdateDataAjax(){
	var jobdocno=$('#jobdocno').val();
	var bayarray=new Array();
	var teamarray=new Array();
	var bayrows=$('#bayGrid').jqxGrid('getselectedrowindexes');
	var teamrows=$('#serviceTeamGrid').jqxGrid('getselectedrowindexes');
	for(var i=0;i<bayrows.length;i++){
		bayarray.push($('#bayGrid').jqxGrid('getcellvalue',bayrows[i],'doc_no')+"::"+$('#bayGrid').jqxGrid('getcellvalue',bayrows[i],'seqno'));
	}
	for(var i=0;i<teamrows.length;i++){
		teamarray.push($('#serviceTeamGrid').jqxGrid('getcellvalue',teamrows[i],'docno'));
	}
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200){
			var items=x.responseText;
			if(parseInt(items)=="0")  
			{	
				$.messager.alert('Message', '  Record Successfully Updated ');
				funreload("");
				
			}
			else
			{
				$.messager.alert('Message', '  Not Updated  ');
			}
		}
	}
	x.open("GET","updateData.jsp?jobdocno="+jobdocno+"&bayarray="+bayarray+"&teamarray="+teamarray+"&baylength="+bayrows.length+"&teamlength="+teamrows.length,true);	 		
	x.send();
} 

function funCheckAvail(){
	SearchContent('checkAvailGrid.jsp?id=1','availWindow');
}
</script>
	
</head>
<!-- setValues(); -->
<body onload="getBranch();">
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
                        <td class="label-cell">Upto</td>
                        <td><div id="Uptodate"></div></td>
                    </tr>
                    <tr>
                        <td class="label-cell">Job Card</td>
                        <td>
                            <input type="text" name="jobcard" id="jobcard" readonly placeholder="Press F3 to Search" onkeydown="getjobCardDetails(event)">
                        </td>
                    </tr>
                </table>
            </div>

            <!-- Action Buttons Card -->
            <div class="filter-card">
                <div class="button-group-row">
                    <input type="button" name="btnclear" id="btnclear" value="Clear" class="btn-submit" onclick="funClearData();" style="background:#64748b !important;">
                    <input type="button" name="btnupdate" id="btnupdate" value="Save" class="btn-submit" onclick="funUpdateData();" style="background:#10b981 !important;">
                </div>
                
                <input type="button" name="btncheckavail" id="btncheckavail" value="Check Availability" class="btn-submit" onclick="funCheckAvail();">
            </div>

            <!-- Hidden Inputs Maintained Safely Outside Visual Layout -->
            <div style="display:none;">
                <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
                <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
                <input type="hidden" name="jobdocno" id="jobdocno" value='<s:property value="jobdocno"/>'>
                <input type="hidden" name="gatedocno" id="gatedocno" value='<s:property value="gatedocno"/>'>
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
            
            <fieldset style="border: 1px solid #e1e8ed; border-radius: 8px; padding: 15px; margin-bottom: 15px; background: #fff;">
                <legend style="font-weight: 600; color: #4e5e71; padding: 0 5px;">Job Details</legend>
                
                <!-- Main Grid -->
                <div id="jobplanninggriddiv" style="margin-bottom: 20px;">
                    <jsp:include page="jobPlanningGrid.jsp"></jsp:include>
                </div>
                
                <!-- Side-by-side Grids -->
                <div style="display: flex; gap: 15px;">
                    
                    <div style="flex: 1;">
                        <fieldset class="redClass" style="border: 1px solid #e1e8ed; border-radius: 8px; padding: 15px; height: 100%; box-sizing: border-box;">
                            <legend style="font-weight: 600; color: #4e5e71; padding: 0 5px; background: transparent;">Bay Details</legend>
                            <div id="baygriddiv"><jsp:include page="bayGrid.jsp"></jsp:include></div>
                        </fieldset>	
                    </div>

                    <div style="flex: 1;">
                        <fieldset class="violetClass" style="border: 1px solid #e1e8ed; border-radius: 8px; padding: 15px; height: 100%; box-sizing: border-box;">
                            <legend style="font-weight: 600; color: #4e5e71; padding: 0 5px; background: transparent;">Service Team Details</legend>
                            <div id="serviceteamgriddiv"><jsp:include page="serviceTeamGrid.jsp"></jsp:include></div>
                        </fieldset>	
                    </div>

                </div>
            </fieldset>

        </div>

    </div>

</div>

<!-- Popups Maintained Outside the Layout Flow -->
<div id="TechnicianWindow">
    <div></div>
</div>
<div id="bayWindow">
    <div></div>
</div>
<div id="sparePartWindow">
    <div></div>
</div>
<div id="jobCardToWindow">
    <div></div>
</div>
<div id="availWindow">
    <div></div>
</div>

</div>
</div>
</form>
</body>
</html>