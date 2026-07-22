<%@page import="com.controlcentre.masters.maintenancemaster.complaint.ClsComplaintDAO" %>
<%ClsComplaintDAO ccd=new ClsComplaintDAO(); %>
<!DOCTYPE html>
<html>
<head>
<%@ taglib prefix="s" uri="/struts-tags" %>
 <s:head/>
 <% String contextPath=request.getContextPath();%>
 
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
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

.modern-ui input[type="checkbox"] {
    width: 14px !important;
    height: 14px !important;
    margin: 0;
    cursor: pointer;
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
$(document).ready(function() {
    /* Set jqxDateTimeInput to 24px height with modern UI theme */
    $("#compdate").jqxDateTimeInput({ width : '125px', height : 24, formatString : "dd.MM.yyyy", theme: 'energyblue'});
    
    /* force internal alignment AFTER render */
    setTimeout(function () {
       $("#compdate").find("input").css({
           "margin-top": "0px",
           "line-height": "24px",
           "font-size": "12px", 
           "font-family": "Arial, sans-serif", 
           "padding": "0 6px", 
           "box-sizing":"border-box"
       });
       $("#compdate").find(".jqx-action-button").css({
           "top": "0px",
           "height": "24px"
       });
    }, 0);
    
    document.getElementById("formdet").innerText="Complaint(CMT)";
    document.getElementById("formdetail").value="Complaint";
    document.getElementById("formdetailcode").value="CMT";
    window.parent.formCode.value="CMT";
    window.parent.formName.value="Complaint";
    
    var comdata= '<%=ccd.mainserch() %>';
    var num = 0; 
    var source = {                             
        datatype: "json",
        datafields: [  
            {name : 'doc_no' , type: 'number' },
            {name : 'compname', type: 'String'  },
            {name : 'date', type: 'date'  }
         ],
         localdata: comdata,
         pager: function (pagenum, pagesize, oldpagenum) {
             // callback called when a page or page size is changed.
         }
    };
            
    var dataAdapter = new $.jqx.dataAdapter(source, {
        loadError: function (xhr, status, error) {
            //  alert(error);   
        }
    });
    
    $("#maintearch10").jqxGrid({
        width: '100%',
        height: 315,
        source: dataAdapter,
        sortable: true,
        selectionmode: 'singlerow',
        columns: [
            { text: 'Doc No', datafield: 'doc_no', width: '20%' },
            { text: ' Name', datafield: 'compname', width: '80%' },
            { text: ' Date', datafield: 'date', width: '10%',cellsformat:'dd.MM.yyyy',hidden:true }
        ]
    });
      
    $('#maintearch10').on('rowselect', function (event) {
        var rowindex1=event.args.rowindex;
        document.getElementById("docno").value= $('#maintearch10').jqxGrid('getcellvalue', rowindex1, "doc_no");
        document.getElementById("compliant").value=$('#maintearch10').jqxGrid('getcellvalue', rowindex1, "compname");
        $("#compdate").jqxDateTimeInput('val',$("#maintearch10").jqxGrid('getcellvalue', rowindex1, "date"));
    }); 
            
});
</script>

<script type="text/javascript">

function funReadOnly(){
    $('#frmcomplaint input').attr('readonly', true );
    $('#compdate').jqxDateTimeInput({ disabled: true}); 
}

function funRemoveReadOnly(){
    $('#frmcomplaint input').attr('readonly', false );
    $('#compdate').jqxDateTimeInput({ disabled: false}); 
    $('#docno').attr('readonly', true);
}

function funFocus(){
    document.getElementById("compliant").focus();
}

function funSearchLoad(){
    changeContent('complaintmastersearch.jsp'); 
}

function funNotify(){
     $('#compdate').jqxDateTimeInput({ disabled: false});   
    return 1;
} 
    
$(function(){
    $('#frmcomplaint').validate({
        rules: {
            compliant:{
                required:true,
                maxlength:50
            }
        },
        messages: {
             compliant:{
             required:"  *  required",
              maxlength:"   Max 50 chars"
          }
        }
    });
});
    
function setValues(){
    if($('#compdatehidden').val()){
        $("#compdate").jqxDateTimeInput('val', $('#compdatehidden').val());
    }
    if($('#msg').val()!=""){
        $.messager.alert('Message',$('#msg').val());
    }
}
</script>

</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmcomplaint" action="saveComplaint" autocomplete="off" method="post">
<jsp:include page="../../../../header.jsp" />

<div class='modern-ui hidden-scrollbar'>
    <div id="errormsg"></div>

    <div class="middle-panel" style="background: #fdfdfd;">
        <span class="middle-panel-title">Complaint Details</span>
        
        <div class="field-row">
            <label class="lbl-right" style="width:80px;">Date</label>
            <div style="width: 125px;">
                <div id="compdate" name="compdate" value='<s:property value="compdate"/>'></div>
            </div>
            <input type="hidden" name="compdatehidden" id="compdatehidden" value='<s:property value="compdatehidden"/>'>
            
            <label class="lbl-right" style="width:80px; margin-left:auto;">Doc No</label>
            <input type="text" name="docno" id="docno" style="width:150px;" readonly="readonly" value='<s:property value="docno"/>' tabindex="-1">
        </div>

        <div class="field-row" style="margin-bottom:0;">
            <label class="lbl-right" style="width:80px;">Name</label>
            <input type="text" name="compliant" id="compliant" style="flex:1;" value='<s:property value="compliant"/>'>
        </div>
    </div>
    
    <div style="display:flex; justify-content:center; margin-top:20px;">
        <div style="width:60%;">
             <div id="maintearch10" style="position:relative;"></div>
        </div>
    </div>

    <!-- Hidden Fields -->
    <div style="display:none;">
        <input type="hidden" id="mode" name="mode"/>
        <input type="text" name="deleted" id="deleted" value='<s:property value="deleted"/>' hidden="true"/>
        <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
    </div>
</div>

</form>
</div>
</body>
</html>