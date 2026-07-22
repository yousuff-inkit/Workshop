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
.fullwidth{ width:100%; }
</style>

<script type="text/javascript">
      $(document).ready(function () {          
          $("#date").jqxDateTimeInput({ width : '125px', height : 24, formatString : "dd.MM.yyyy", theme: 'energyblue' });  
         
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

          document.getElementById("formdet").innerText="Job Master(WJM)";
          document.getElementById("formdetail").value="Job Master";
          document.getElementById("formdetailcode").value="WJM";
          window.parent.formCode.value="WJM";
          window.parent.formName.value="Job Master";
          getJob();
          $('#jobdescdiv').load('jobDescGrid.jsp?id=1');
      });
    
      function funSearchLoad(){
            changeContent('jobMasterSearchGrid.jsp?id=1', $('#window')); 
      }

    function funReadOnly() {
        $('#frmJobMaster input').attr('readonly', true);
        $('#frmJobMaster select').attr('disabled', true);
        $('#date').jqxDateTimeInput({disabled: true});
        
    }
    
    function funRemoveReadOnly() {
        $('#frmJobMaster input').attr('readonly', false);
        $('#frmJobMaster select').attr('disabled', false);
        $('#date').jqxDateTimeInput({disabled: false});
        $('#docno').attr('readonly', true);
        if($("#mode").val()=="A"){
            $('#date').jqxDateTimeInput('setDate',new Date());
            $('#jobDescGrid').jqxGrid('clear');
             $("#jobDescGrid").jqxGrid("addrow", null, {});
        }
        if($("#mode").val()=="E"){
             $("#jobDescGrid").jqxGrid("addrow", null, {});
        }
    }

    function funFocus(){}
    
     function funNotify(){
         if($('#description').val()==''){
             document.getElementById("errormsg").innerText="";
             document.getElementById("errormsg").innerText="Enter Description";
            return 0;
         }
        
         if($('#cmbjobtype').val()==''){
             document.getElementById("errormsg").innerText="";
             document.getElementById("errormsg").innerText="Select Job Type";
            return 0;
         } 
         if($('#stdhr').val()==''){
             document.getElementById("errormsg").innerText="";
             document.getElementById("errormsg").innerText="Enter STD HR";
            return 0;
         }
        
         if($('#stdrateperhr').val()==''){
             document.getElementById("errormsg").innerText="";
             document.getElementById("errormsg").innerText="Enter STD Rate / HR";
            return 0;
         }
        
         /*   Job Grid  Saving*/
             var rows1 = $("#jobDescGrid").jqxGrid('getrows');
             var length1=0;
                 for(var i=0 ; i < rows1.length ; i++){
                    
                    var chk1=rows1[i].desc;
                    if(typeof(chk1) != "undefined" && typeof(chk1) != "NaN" && chk1 != ""){
                        newTextBox = $(document.createElement("input"))
                        .attr("type", "hidden")
                        .attr("id", "jobgriddesc"+length1)
                        .attr("name", "jobgriddesc"+length1)
                        .attr("hidden", "true");
                        length1=length1+1;
                        
                newTextBox.val(chk1+":: ");
                newTextBox.appendTo('form');
                 }
                }
             $('#jobgridlength').val(length1);
            
           /*    Job Grid Saving Ends */ 
           
        $('#date').jqxDateTimeInput({disabled: false});
           
            return 1;
        } 
     
    function setValues() {
        if($('#msg').val()!=""){
            $.messager.alert('Message',$('#msg').val());
        }
        if($('#docno').val()>0){
            $('#jobdescdiv').load('jobDescGrid.jsp?id=1&docno='+$('#docno').val());
        }
        if($('#hidcmbjobtype').val()!=''){
            document.getElementById('cmbjobtype').value=$('#hidcmbjobtype').val();
        }
    }
    
     function funExcelBtn(){}
    
     function getJob() {
            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    var items = x.responseText;
                    items = items.split('####');
                    var salesagentItems = items[0].split(",");
                    
                    var salesagentIdItems = items[1].split(",");
                    var optionssalesagent = '<option value="">--Select--</option>';
                    for (var i = 0; i < salesagentItems.length; i++) {
                        optionssalesagent += '<option value="' + salesagentIdItems[i] + '">'
                                + salesagentItems[i] + '</option>';
                    }
                    $("select#cmbjobtype").html(optionssalesagent);
                    if ($('#hidcmbjobtype').val() != null) {
                        $('#cmbjobtype').val($('#hidcmbjobtype').val());
                    }
                } else {
                }
            }
            x.open("GET", "getJob.jsp", true);
            x.send();
        }
  
</script>
</head>

<body onLoad="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmJobMaster" action="saveJobMaster" autocomplete="off">
<jsp:include page="../../../../header.jsp" />

<div class='modern-ui hidden-scrollbar'>
    <div id="errormsg"></div>

    <div class="middle-panel" style="background: #fdfdfd;">
        <span class="middle-panel-title">Job Master Details</span>
        
        <div class="field-row">
            <label class="lbl-right" style="width:80px;">Date</label>
            <div style="width: 125px;">
                <div id="date" name="date" value='<s:property value="date"/>'></div>
            </div>
            
            <label class="lbl-right" style="width:80px; margin-left:auto;">Doc No</label>
            <input type="text" name="docno" style="width:150px;" value='<s:property value="docno"/>' id="docno" readonly tabindex="-1">
        </div>

        <div class="field-row">
            <label class="lbl-right" style="width:80px;">Job Type</label>
            <select name="cmbjobtype" id="cmbjobtype" style="width:150px;">
                <option value="">--Select--</option>
            </select>
            
            <label class="lbl-right" style="width:80px; margin-left:15px;">Description</label>
            <input name="description" type="text" id="description" style="flex:1;" value='<s:property value="description"/>'>
        </div>

        <div class="field-row" style="margin-bottom:0;">
            <label class="lbl-right" style="width:80px;">STD HR</label>
            <input name="stdhr" type="text" id="stdhr" style="width:150px;" value='<s:property value="stdhr"/>'>

            <label class="lbl-right" style="width:100px; margin-left:15px;">STD RATE /HR</label>
            <input name="stdrateperhr" type="text" id="stdrateperhr" style="width:150px;" value='<s:property value="stdrateperhr"/>'>
        </div>
    </div>

    <!-- Check list -->
    <div class="middle-panel" style="background: #fdfdfd; margin-bottom:15px;">
        <span class="middle-panel-title">Check list</span>
        <div id="jobdescdiv">
            <jsp:include page="jobDescGrid.jsp"></jsp:include>
        </div>
    </div>

    <!-- Hidden Fields -->
    <div style="display:none;">
        <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
        <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>' />
        <input type="hidden" name="hidcmbjobtype" id="hidcmbjobtype" value='<s:property value="hidcmbjobtype"/>'/>
        <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>    
        <input type="hidden" name="jobgridlength" id="jobgridlength" value='<s:property value="jobgridlength"/>'/>
    </div>
</div>
</form>
</div>
</body>
</html>