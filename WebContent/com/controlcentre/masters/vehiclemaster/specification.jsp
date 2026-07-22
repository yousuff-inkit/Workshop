<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>

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
</style>

<script type="text/javascript">
$(document).ready(function() {
	
	document.getElementById("formdet").innerText="Specification(SPC)";
	document.getElementById("formdetail").value="Specification";
	document.getElementById("formdetailcode").value="SPC";
	window.parent.formCode.value="SPC";
	window.parent.formName.value="Specification";
	
});

function funNotify(){
	return 1;
}
function funReadOnly(){
	$('#frmSpecification input').attr('readonly', true );
}
function funRemoveReadOnly(){
	$('#frmSpecification input').attr('readonly', false );

}
function funSearchLoad(){
	changeContent('specificationSearch.jsp', $('#window')); 
 }
function chkButton(){
	
}
function funFocus(){
	document.getElementById("specname").focus();
}
function setValues(){
	 if($('#msg').val()!=""){
		   $.messager.alert('Message',$('#msg').val());
		  }

}
function funExcelBtn(){
				  $("#specGrid").jqxGrid('exportdata', 'xls', 'Specifications');
			  }
</script>
</head>
<body onload="setValues();">

<div id="mainBG" class="homeContent" data-type="background"> 
<form id="frmSpecification" action="saveSpecification" method="post" autocomplete="off">
    <jsp:include page="../../../../header.jsp" />

    <div class='modern-ui hidden-scrollbar'>
        <div id="errormsg"></div>

        <div class="middle-panel">
            <span class="middle-panel-title">Specification Info</span>
            
            <div class="field-row">
                <label class="lbl-right" style="width:80px;">Name</label>
                <input type="text" name="specname" id="specname" style="width:250px;" value='<s:property value="specname"/>' placeholder="Spec Name" />
                
                <label class="lbl-right" style="width:80px; margin-left:auto;">Doc No</label>
                <input type="text" name="docno" id="docno" style="width:125px;" tabindex="-1" readonly value='<s:property value="docno"/>'/>
            </div>
            
            <div class="field-row" style="margin-bottom:0;">
                <label class="lbl-right" style="width:80px;">Details</label>
                <input type="text" name="specdetails" id="specdetails" style="flex:1;" value='<s:property value="specdetails"/>' placeholder="Spec Details"/>
            </div>
        </div>

        <div class="middle-panel">
            <span class="middle-panel-title">Details</span>
            <div class="grid-container">
                <jsp:include page="specGrid.jsp"></jsp:include>
            </div>
        </div>

        <!-- Hidden Logic Fields -->
        <div style="display:none;">
            <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
            <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'/>
            <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
        </div>

    </div>
</form>
</div>

</body>
</html>