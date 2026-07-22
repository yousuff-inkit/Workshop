<%@page import="com.controlcentre.masters.vehiclemaster.leasecdw.*" %>
<%ClsLeaseCDWDAO cdwdao=new ClsLeaseCDWDAO(); %>

<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<%String contextPath=request.getContextPath();%>
<head>
<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
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

form label.error {
    color:red;
    font-weight:bold;
}
#errormsg { color:red; font-weight:bold; text-align:center; margin-bottom: 10px; }

.custom-checkbox{
	width: 15px !important; 
	height: 15px !important;
	border: 1px solid #aaa;
    background: #f8f8f8;
    border-radius: 5px;
    box-shadow: inset 0 1px 3px rgba(0,0,0,.3);
    transition: all .2s;
    margin: 0 !important;
    vertical-align: middle;
}
</style>
<script type="text/javascript">
	$(document).ready(function () {    
	    $("#date").jqxDateTimeInput({ width: '125px', height: 24, formatString: "dd.MM.yyyy", theme: 'energyblue' });
	    
	    /* force internal alignment AFTER render */
		 setTimeout(function () {
		 	$("#date").find("input").css({
		 		"margin-top": "0px",
		 		"line-height": "24px",
		 		"font-size": "12px", 
		 		"font-family": "Arial, sans-serif", 
		 		"padding": "0 6px", 
		 		"box-sizing":"border-box"
		 	});
		 	$("#date").find(".jqx-action-button").css({
		 		"top": "0px",
		 		"height": "24px"
		 	});
		 }, 0);
	    
	    document.getElementById("formdet").innerText="Lease CDW(LCDW)";
		document.getElementById("formdetail").value="Lease";
		document.getElementById("formdetailcode").value="LCDW";
		window.parent.formCode.value="LCDW";
		window.parent.formName.value="Lease CDW";
		
        });
	function funSearchLoad(){
		changeContent('leaseCDWSearch.jsp', $('#window')); 
	 }
	/* function funReset() {
		$(this).closest('form').find("input[type=text]").val("");
		//$('#frmBrand').trigger("reset");
		//document.getElementById("frmBrand").reset();
		//document.getElementById("docno").value="";
		//document.getElementById("brand").value="";
	} */
	
	
	function funReadOnly() {
		$('#frmLeaseCDW input').attr('readonly', true);
		$('#chkreplace').attr('disabled', true);
		$('#chkexscdw').attr('disabled', true);
		$('#date').jqxDateTimeInput({ disabled: true});
	}
	
	
	function funRemoveReadOnly() {
		$('#frmLeaseCDW input').attr('readonly', false);
		$('#date').jqxDateTimeInput({ disabled: false});
		$('#chkreplace').attr('disabled', false);
		$('#chkexscdw').attr('disabled', false);
		$('#docno').attr('readonly', true);
		SetReplaceValue();
		 SetExcseecdwValue()
	}
	function setValues() {
		 if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
		  }
		 if(document.getElementById("hidchkreplace").value=="1"){
			 document.getElementById("chkreplace").checked=true;
		 }
		 else{
			 document.getElementById("chkreplace").checked=false;
		 }
		 
		 
		  if(document.getElementById("hidchkexscdw").value=="1"){
			 document.getElementById("chkexscdw").checked=true;
		 }
		 else{
			 document.getElementById("chkexscdw").checked=false;
		 } 

		$('#leasecdwdiv').load('leaseCDWGrid.jsp');
	}
	
	 $(function(){
	        $('#frmLeaseCDW').validate({
	                 rules: {
	                 name: {
	                	 required:true,
	                	 maxlength:100
	                 }
	                 },
	                 messages: {
	                  name: {
	                	  required:" *",
	                	  maxlength:"max 100 only"
	                  } 
	                 }
	        });});
	     function funNotify(){
	    
	    		return 1;
		} 
	     function funFocus(){
	    	 document.getElementById("name").focus();
	     }
	  function funExcelBtn(){
		 
	  }
	  function SetReplaceValue(){
		  if(document.getElementById("chkreplace").checked==true){
			  document.getElementById("hidchkreplace").value="1";
			 
		  }
		  else{
			  document.getElementById("hidchkreplace").value="0";
		  }
		  
		 
		
	  }
	  function SetExcseecdwValue(){
		
		  if(document.getElementById("chkexscdw").checked==true){
			  document.getElementById("hidchkexscdw").value="1";
			   
		  }
		  else{
			  document.getElementById("hidchkexscdw").value="0";
		  }
		  }
</script>  
 
</head>
<body onLoad="setValues();" >
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmLeaseCDW" action="saveLeaseCDW" method="get" autocomplete="off">
	<jsp:include page="../../../../header.jsp" />
	
	<div class='modern-ui hidden-scrollbar'>
        <div id="errormsg"></div>

        <div class="middle-panel">
            <span class="middle-panel-title">Lease CDW Details</span>
            
            <div class="field-row">
                <label class="lbl-right" style="width:80px;">Date</label>
                <div style="width: 125px;">
                    <div id="date" name="date" value='<s:property value="date"/>'></div>
                </div>
                
                <label class="lbl-right" style="width:80px; margin-left:auto;">Doc No</label>
                <input type="text" name="docno" id="docno" style="width:125px;" value='<s:property value="docno"/>' readonly tabindex="-1">
            </div>

            <div class="field-row">
                <label class="lbl-right" style="width:80px;">Name</label>
                <input type="text" name="name" id="name" style="width:250px;" value='<s:property value="name"/>'>
                
                <div style="display: flex; align-items: center; gap: 20px; margin-left: auto; padding-right: 10px;">
                    <label style="display: flex; align-items: center; gap: 5px; cursor: pointer; font-size: 12px; font-weight: bold; color: #444;">
                        <input type="checkbox" name="chkexscdw" id="chkexscdw" class="custom-checkbox" onchange="SetExcseecdwValue();">
                        Excess CDW
                    </label>
                    
                    <label style="display: flex; align-items: center; gap: 5px; cursor: pointer; font-size: 12px; font-weight: bold; color: #444;">
                        <input type="checkbox" name="chkreplace" id="chkreplace" class="custom-checkbox" onchange="SetReplaceValue();">
                        Replacement
                    </label>
                </div>
            </div>

            <div class="field-row">
                <label class="lbl-right" style="width:80px;">Description</label>
                <input type="text" name="description" id="description" style="flex:1;" value='<s:property value="description"/>'>
            </div>

            <div class="field-row" style="margin-bottom:0;">
                <label class="lbl-right" style="width:80px;">Remarks</label>
                <input type="text" name="remarks" id="remarks" style="flex:1;" value='<s:property value="remarks"/>'>
            </div>
        </div>

        <div class="middle-panel">
            <span class="middle-panel-title">Details</span>
            <div id="leasecdwdiv" class="grid-container">
                <jsp:include page="leaseCDWGrid.jsp"></jsp:include>
            </div>
        </div>

        <!-- Hidden Logic Fields -->
        <div style="display:none;">
            <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>
            <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
            <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/> 
            <input type="hidden" name="hidchkreplace" id="hidchkreplace" value='<s:property value="hidchkreplace"/>'/>
            <input type="hidden" name="hidchkexscdw" id="hidchkexscdw" value='<s:property value="hidchkexscdw"/>'/>
        </div>
	</div>
</form>
</div>
</body>
</html>