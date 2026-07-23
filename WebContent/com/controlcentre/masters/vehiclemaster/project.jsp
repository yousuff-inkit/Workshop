<%@page import="com.controlcentre.masters.vehiclemaster.project.ClsProjectDAO" %>
<%ClsProjectDAO cpd=new ClsProjectDAO(); %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>

<style>
/* =========================================================
SCOPED UI: Modern Layout (Matches Client Master)
========================================================= */
body {
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    color: #222;
    margin: 0;
    padding: 24px 0;
    box-sizing: border-box;
    overflow-y: auto !important;
}

#mainBG {
    background: #fff;
    border-radius: 16px;
    padding: 15px;
    max-width: 100%;
    margin: 0 auto;
    box-shadow: 0 4px 24px rgba(0,0,0,0.06);
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

/* Layout Utilities */
.modern-ui .field-row { 
    display: flex;
    align-items: center; 
    gap: 8px;
    margin-bottom: 10px; 
    flex-wrap: wrap;
}

.modern-ui .lbl-right { 
    text-align: right; 
    color: #444;
    font-size: 12px; 
    font-weight: bold;
    white-space: nowrap; 
    padding-right: 5px;
}

/* Middle Section Panels */
.modern-ui .middle-panel {
    border: 1px solid #c5d3e0; 
    padding: 20px 10px 10px 10px; 
    background: #ffffff; 
    position: relative; 
    border-radius: 4px; 
    margin-bottom: 15px;
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
    font-size: 14px; 
    border-left: 3px solid #0056b3;
    z-index: 2; 
    line-height: normal; 
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
}
.modern-ui .myButton:hover { background: linear-gradient(135deg, #083a8a 0%, #1d4ed8 100%); }

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

/* Grid Wrappers */
.modern-ui .grid-container {
    border: 1px solid #c5d3e0;
    border-radius: 4px;
    background: #fff;
    overflow: hidden;
}

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
</style>

<script type="text/javascript">

$(document).ready(function () {
	 $("#projectDate").jqxDateTimeInput({ width: '125px', height: 24 ,formatString : "dd.MM.yyyy", theme: 'energyblue' });
	 
	 /* force internal alignment AFTER render */
	 setTimeout(function () {
	 	$("#projectDate").find("input").css({
	 		"margin-top": "0px",
	 		"line-height": "24px",
	 		"font-size": "12px", 
	 		"font-family": "Arial, sans-serif", 
	 		"padding": "0 6px", 
	 		"box-sizing":"border-box"
	 	});
	 	$("#projectDate").find(".jqx-action-button").css({
	 		"top": "0px",
	 		"height": "24px"
	 	});
	 }, 0);
	
	 $('#clientDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Client Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 $('#clientDetailsWindow').jqxWindow('close');
	 
	 $("#btnExcel").click(function() {
			$("#jqxProjectSearch1").jqxGrid('exportdata', 'xls', 'Project');
		});
	 
	    document.getElementById("formdet").innerText="Project(PRJ)";
		document.getElementById("formdetail").value="Project";
		document.getElementById("formdetailcode").value="PRJ";
	 	window.parent.formCode.value="PRJ";
			window.parent.formName.value="Project";
	 var data= '<%=cpd.projectDetailsLoading() %>';
	           
	 var source =
	            {
	                datatype: "json",
	                datafields: [
	                          	{name : 'doc_no' , type: 'number' },
	                          	{name : 'date', type: 'date'  },
	                          	{name : 'refname', type: 'String'  },
	                          	{name : 'project_name', type: 'String'  }
	                 ],
	               localdata: data,
	                
	                pager: function (pagenum, pagesize, oldpagenum) {
	                    // callback called when a page or page size is changed.
	                }
	            };
	            var dataAdapter = new $.jqx.dataAdapter(source,
	            		 {
	                		loadError: function (xhr, status, error) {
		                    }
			            }		
	            );
	    
	            $("#jqxProjectSearch1").jqxGrid(
	                    {
	                    	width: 850,
	                        source: dataAdapter,
	                        showfilterrow: true,
	                        filterable: true,
	                        selectionmode: 'multiplecellsextended',
	                        //Add row method
	                        columns: [
	        					{ text: 'Doc No',filtertype: 'number', datafield: 'doc_no', width: '10%' },
	        					{ text: 'Date',columntype: 'textbox', filtertype: 'input', datafield: 'date', width: '20%',cellsformat:'dd.MM.yyyy' },
	        					{ text: 'Client Name',columntype: 'textbox', filtertype: 'input', datafield: 'refname', width: '30%' },
	        					{ text: 'Project Name',columntype: 'textbox', filtertype: 'input', datafield: 'project_name', width: '40%' }
	        	              ]
	                    });
	            $('#jqxProjectSearch1').on('rowdoubleclick', function (event) {
	                var rowindex1=event.args.rowindex;
	                document.getElementById("docno").value= $('#jqxProjectSearch1').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
	                document.getElementById("txtprojectname").value = $("#jqxProjectSearch1").jqxGrid('getcellvalue', rowindex1, "project_name");
	                $("#projectDate").jqxDateTimeInput('val', $("#jqxProjectSearch1").jqxGrid('getcellvalue', rowindex1, "date"));
	                document.getElementById("txtclientname").value = $("#jqxProjectSearch1").jqxGrid('getcellvalue', rowindex1, "refname");
	            }); 
	            
	            
	            
	            $('#txtclientname').dblclick(function(){
	            	clientSearchContent('clientDetailsGrid.jsp');
	       		});
          });

function clientSearchContent(url) {
    $('#clientDetailsWindow').jqxWindow('open');
	$.get(url).done(function (data) {
	$('#clientDetailsWindow').jqxWindow('setContent', data);
	$('#clientDetailsWindow').jqxWindow('bringToFront');
}); 
}

function funReadOnly(){
	$('#frmProject input').attr('readonly', true );
	$('#projectDate').jqxDateTimeInput({disabled: true});
}

function funRemoveReadOnly(){
	$('#frmProject input').attr('readonly', false );
	$('#projectDate').jqxDateTimeInput({disabled: false});
	$('#txtclientname').prop('readonly', true);
	$('#docno').prop('readonly', true);
}

function setValues(){	
   
	 if($('#msg').val()!=""){
		   $.messager.alert('Message',$('#msg').val());
		  }

}

function funFocus(){
	$('#projectDate').jqxDateTimeInput('focus'); 
}
   
    /* Validations */
	   $(function(){
	        $('#frmProject').validate({
	                rules: {
	                txtclientname:"required",
	                txtprojectname:"required"
	                 },
	                 messages: {
	                 txtclientname:" *",
	                 txtprojectname:" *"
	                 }
	        });});
     
function funNotify(){
   return 1;
} 

function funSearchLoad(){
    changeContent('projectSearch.jsp');
}
     
function getClient(event){
  var x= event.keyCode;
  if(x==114){
	  clientSearchContent('clientDetailsGrid.jsp');
  }
  else{
   }
}
function funExcelBtn(){
	  $("#jqxProjectSearch1").jqxGrid('exportdata', 'xls', 'Project');
}
</script>
</head>
<body onload="setValues();" >
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmProject" action="saveActionProject" autocomplete="off">
<jsp:include page="../../../../header.jsp" />

<div class='modern-ui hidden-scrollbar'>
    <div id="errormsg"></div>

    <div class="middle-panel">
        <span class="middle-panel-title">Project Details</span>
        
        <div class="field-row">
            <label class="lbl-right" style="width:80px;">Date</label>
            <div style="width: 125px;">
                <div id="projectDate" name="projectDate" value='<s:property value="projectDate"/>'></div>
            </div>
            <input type="hidden" id="hidprojectDate" name="hidprojectDate" value='<s:property value="hidprojectDate"/>'/>
            
            <label class="lbl-right" style="width:80px; margin-left:auto;">Doc No</label>
            <input type="text" id="docno" name="txtprojectdocno" style="width:125px;" value='<s:property value="txtprojectdocno"/>' tabindex="-1" readonly/>
        </div>
        
        <div class="field-row" style="margin-bottom:0;">
            <label class="lbl-right" style="width:80px;">Client</label>
            <div class="input-search-container" style="width: 250px;">
                <input type="text" name="txtclientname" id="txtclientname" placeholder="Press F3" value='<s:property value="txtclientname"/>' onkeydown="getClient(event);" readonly/>
                <svg class="magnifier-icon" onclick="$('#txtclientname').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
            </div>
            <input type="hidden" id="txtcldocno" name="txtcldocno" value='<s:property value="txtcldocno"/>'/>
            
            <label class="lbl-right" style="width:100px; margin-left:auto;">Project Name</label>
            <input type="text" name="txtprojectname" id="txtprojectname" style="width:250px;" value='<s:property value="txtprojectname"/>'>
        </div>
    </div>

    <div class="middle-panel">
        <span class="middle-panel-title">Details</span>
        <div id="jqxProjectSearch1" class="grid-container"></div>
    </div>

    <!-- Hidden Logic Fields -->
    <div style="display:none;">
        <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
        <input type="hidden" id="mode" name="mode"/>
        <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
    </div>

</div>
</form>

<div id="clientDetailsWindow">
	<div></div><div></div>
</div>

</div>
</body>
</html>