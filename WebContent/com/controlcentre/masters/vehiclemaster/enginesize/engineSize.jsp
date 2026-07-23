<%@page import="com.controlcentre.masters.vehiclemaster.enginesize.*" %>
<%ClsEngineSizeDAO coa=new ClsEngineSizeDAO(); %>

<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../../includes.jsp"></jsp:include>

<style>
/* =========================================================
SCOPED UI: Modern Layout (Plain White Background)
========================================================= */
body {
    background: #ffffff;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    color: #222;
    margin: 0;
    padding: 24px 0;
    box-sizing: border-box;
    overflow-y: auto !important;
}

#mainBG {
    background: #ffffff;
    border-radius: 16px;
    padding: 15px;
    max-width: 100%;
    margin: 0 auto;
    border: 1px solid #e2e8f0;
    box-shadow: none;
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

/* Layout Utilities - Tightened Spacing */
.modern-ui .field-row { 
    display: flex;
    align-items: center; 
    gap: 8px;
    margin-bottom: 10px; 
    flex-wrap: wrap;
    justify-content: flex-start;
}

.modern-ui .lbl-right { 
    text-align: right; 
    color: #444;
    font-size: 12px; 
    font-weight: bold;
    white-space: nowrap; 
    padding-right: 5px;
}

/* Middle Section Panels - Reduced Padding */
.modern-ui .middle-panel {
    border: 1px solid #e2e8f0; 
    padding: 18px 10px 10px 10px; 
    background: #ffffff; 
    position: relative; 
    border-radius: 4px; 
    margin-bottom: 12px;
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
    font-size: 13px; 
    border-left: 3px solid #0056b3;
    z-index: 2; 
    line-height: normal; 
    display: flex;
    align-items: center;
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
var data= '<%=coa.getEngineSizeData()%>';
$(document).ready(function () {     
    
        if(document.getElementById("formdet")) {
            document.getElementById("formdet").innerText="Engine Size(ENG)";
            document.getElementById("formdetail").value="Engine Size";
            document.getElementById("formdetailcode").value="ENG";
            window.parent.formCode.value="ENG";
            window.parent.formName.value="Engine Size";
        }
        
    var source =
    {
        datatype: "json",
        datafields: [
                    {name : 'doc_no' , type: 'number' },
                    {name : 'enginesize', type: 'String'  }
         ],
         localdata: data,
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
    
    var dataAdapter = new $.jqx.dataAdapter(source,
             {
                loadError: function (xhr, status, error) {
               // alert(error);   
                }
            }       
    );

    $("#engineSizeGrid").jqxGrid(
            {
                width: '100%',
                height: 315,
                source: dataAdapter,
                showfilterrow: true,
                filterable: true,
                selectionmode: 'singlerow',
                //pagermode: 'default',
                sortable: true,
                //pageable: true,
                altrows:true,
                //Add row method
                columns: [
                    { text: 'Doc No',filtertype: 'number', datafield: 'doc_no', width: '20%' },
                    { text: 'Engine Size',columntype: 'textbox', filtertype: 'input', datafield: 'enginesize', width: '80%' }
                  ]
            });
            
    $('#engineSizeGrid').on('rowdoubleclick', function (event) 
            { 
                var rowindex1=event.args.rowindex;
                 document.getElementById("docno").value= $('#engineSizeGrid').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
                 document.getElementById("enginesize").value = $("#engineSizeGrid").jqxGrid('getcellvalue', rowindex1, "enginesize");                
                 $('#window').jqxWindow('hide');
             }); 
});

function funReadOnly(){
    $('#frmEngineSize input').attr('readonly', true );
}

function funRemoveReadOnly(){
    $('#frmEngineSize input').attr('readonly', false );
    $('#docno').attr('readonly', true);
}

function setValues(){   
     if($('#msg').val()!=""){
           $.messager.alert('Message',$('#msg').val());
      }
}

function funFocus(){
    document.getElementById("enginesize").focus();
}
   
$(function(){
    $('#frmEngineSize').validate({
             rules: {
             enginesize: {
                 required:true,
                 maxlength:45
             }
             },
             messages: {
              enginesize:{
                  required:" *",
                  maxlength:"max 45 chars"
              }
             }
    });
});

function funNotify(){
    return 1;
} 

function funSearchLoad(){
    changeContent('engineSizeSearchGrid.jsp?id=1', $('#window')); 
}

function funExcelBtn(){
    $("#engineSizeGrid").jqxGrid('exportdata', 'xls', 'Engine Size');
}
</script>
</head>
<body onload="setValues();" >
    <div id="mainBG" class="homeContent" data-type="background">
        <form id="frmEngineSize" action="saveEngineSizeAction" autocomplete="off">
            <jsp:include page="../../../../../header.jsp" />

        <div class='modern-ui hidden-scrollbar'>
            <div id="errormsg"></div>

            <div class="middle-panel" style="margin-bottom: 15px;">
                <span class="middle-panel-title">Engine Size Details</span>
                
                <div class="field-row" style="margin-bottom:0;">
                    <label class="lbl-right" style="width:80px;">Engine Size</label>
                    <input type="text" name="enginesize" id="enginesize" value='<s:property value="enginesize"/>' style="flex:1; max-width:250px;">
                    
                    <label class="lbl-right" style="width:80px; margin-left:auto;">Doc No</label>
                    <input type="text" name="docno"  id="docno" readonly="readonly" value='<s:property value="docno"/>' tabindex="-1" style="width:120px;">
                </div>
            </div>

            <!-- Hidden Fields Map -->
            <div style="display:none;">
                <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
                <input type="hidden" id="mode" name="mode"/>
                <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
            </div>

            <!-- Engine Size Grid -->
            <div id="engineSizeGrid" style="margin-top: 15px;"></div>
            
        </div>
        </form>
    </div>
</body>
</html>