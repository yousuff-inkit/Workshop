<%@page import="com.controlcentre.masters.vehiclemaster.model.ClsModelAction" %>
<%ClsModelAction cma=new ClsModelAction(); %>
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
</style>

<script type="text/javascript">
      $(document).ready(function () { 
          $('#accountDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
          $('#accountDetailsWindow').jqxWindow('close');
          
          $('#jobmasterWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Job Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
          $('#jobmasterWindow').jqxWindow('close');
          
          $('#accountno').dblclick(function(){
              accountsSearchContent('accountsDetailsSearch.jsp');
          });
          
          /* Set jqxDateTimeInput to 24px height with modern UI theme */
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

            document.getElementById("formdet").innerText="Technician (WTC)";
            document.getElementById("formdetail").value="Technician";
            document.getElementById("formdetailcode").value="WTC";
            window.parent.formCode.value="WTC";
            window.parent.formName.value="Technician";
          
          });
    
      function funSearchLoad(){
            changeContent('technicianSearch.jsp?id=1', $('#window')); 
         }

    function funReadOnly() {
        $('#frmWorkTechnician input').attr('readonly', true);
        $('#frmWorkTechnician select').attr('disabled', true);
        $('#date').jqxDateTimeInput({disabled: true});
        
    }
    function funRemoveReadOnly() {
        $('#frmWorkTechnician input').attr('readonly', false);
        $('#frmWorkTechnician select').attr('disabled', false);
        $('#date').jqxDateTimeInput({disabled: false});
        $('#docno').attr('readonly', true);
        $('#accountno').attr('readonly', true);
        $('#accountname').attr('readonly', true);
        if(!($('#docno').val()>0)){
            $('#jobMasterGrid').jqxGrid('clear');
             $("#jobMasterGrid").jqxGrid("addrow", null, {});
        }
        
        if($("#mode"=="A")){
            $('#date').jqxDateTimeInput('setDate',new Date());
        }
    }

    function funFocus(){
        document.getElementById("accountno").focus();
    }
     $(function(){
        $('#frmWorkTechnician').validate({
                 rules: {
                 brand:{
                     required:true
                 },
                 model:{
                     required:true,
                     maxlength:20
                 }
                 },
                 messages: {
                  brand:{
                      required:" *"
                  },
                  model:{
                      required:" *",
                      maxlength:"max 20 chars"
                  }
                 }
        });});
        
     function funNotify(){
         if($('#accountno').val()==''){
             document.getElementById("errormsg").innerText="";
             document.getElementById("errormsg").innerText="Select Account";
            return 0;
         }
        
          if($('#actualstdcost').val()==''){
             document.getElementById("errormsg").innerText="";
             document.getElementById("errormsg").innerText="Enter Actual Cost";
            return 0;
         }
         if($('#name').val()==''){
             document.getElementById("errormsg").innerText="";
             document.getElementById("errormsg").innerText="Enter Name";
            return 0;
         }
        
         if($('#mobile').val()==''){
             document.getElementById("errormsg").innerText="";
             document.getElementById("errormsg").innerText="Enter Mobile No";
            return 0;
         }
        
         if($('#email').val()==''){
             document.getElementById("errormsg").innerText="";
             document.getElementById("errormsg").innerText="Enter Email";
            return 0;
         }
        
         /*  Tech Job Grid  Saving*/
             var rows1 = $("#jobMasterGrid").jqxGrid('getrows');
             var length1=0;
                 for(var i=0 ; i < rows1.length ; i++){
                    
                    var chk1=rows1[i].jobtypeid;
                    if(typeof(chk1) != "undefined" && typeof(chk1) != "NaN" && chk1 != ""){
                        newTextBox = $(document.createElement("input"))
                        .attr("type", "hidden")
                        .attr("id", "jobgidid"+length1)
                        .attr("name", "jobgidid"+length1)
                        .attr("hidden", "true");
                        length1=length1+1;
                        
                newTextBox.val(chk1+":: ");
                newTextBox.appendTo('form');
                 }
                }
             $('#technicianJoblength').val(length1);
            
           /*   Tech Job Grid Saving Ends */    
        
            return 1;
        } 
     
    function setValues() {
        if($('#msg').val()!=""){
            $.messager.alert('Message',$('#msg').val());
        }
        if($('#docno').val()>0){
            $('#jobmasterdiv').load('jobMasterGrid.jsp?id=1&docno='+$('#docno').val());
        }
    }
    
    function accountsSearchContent(url) {
        $('#accountDetailsWindow').jqxWindow('open');
        $.get(url).done(function (data) {
        $('#accountDetailsWindow').jqxWindow('setContent', data);
        $('#accountDetailsWindow').jqxWindow('bringToFront');
    }); 
    }
    
    function getAccType(event){
        var x= event.keyCode;
        if(x==114){
          if($('#cmbtype').length && $('#cmbtype').val()==''){
                 $.messager.alert('Message','Please Choose Account Type.','warning');
                 return 0;
          }
          accountsSearchContent('accountsDetailsSearch.jsp');
        }
    }
    
    function jobmasterSearchContent(url) {
        $('#jobmasterWindow').jqxWindow('open');
        $.get(url).done(function (data) {
        $('#jobmasterWindow').jqxWindow('setContent', data);
        $('#jobmasterWindow').jqxWindow('bringToFront');
    }); 
    }
    
    function funExcelBtn(){}
</script>
</head>

<body onLoad="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmWorkTechnician" action="saveWorkTechnician" autocomplete="off">
<jsp:include page="../../../../header.jsp" />

<div class='modern-ui hidden-scrollbar'>
    <div id="errormsg"></div>

    <div class="middle-panel" style="background: #fdfdfd;">
        <span class="middle-panel-title">Technician Details</span>
        
        <div class="field-row">
            <label class="lbl-right" style="width:80px;">Date</label>
            <div style="width: 125px;">
                <div id="date" name="date" value='<s:property value="date"/>'></div>
            </div>
            
            <label class="lbl-right" style="width:80px; margin-left:auto;">Doc No</label>
            <input type="text" name="docno" style="width:150px;" value='<s:property value="docno"/>' id="docno" readonly tabindex="-1">
        </div>

        <div class="field-row">
            <label class="lbl-right" style="width:80px;">Account</label>
            <div class="input-search-container" style="width:125px;">
                <input type="text" name="accountno" id="accountno" value='<s:property value="accountno"/>' readonly placeholder="Press F3" onkeydown="getAccType(event);">
                <svg class="magnifier-icon" onclick="$('#accountno').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
            </div>
            
            <input name="accountname" type="text" id="accountname" style="flex:1; margin-left:8px;" value='<s:property value="accountname"/>' readonly tabindex="-1">
            
            <label class="lbl-right" style="width:120px; margin-left:15px;">Actual Std Cost/ Hr</label>
            <input type="text" name="actualstdcost" id="actualstdcost" style="width:150px;" value='<s:property value="actualstdcost"/>'>
        </div>

        <div class="field-row">
            <label class="lbl-right" style="width:80px;">Name</label>
            <input type="text" name="name" id="name" style="flex:1;" value='<s:property value="name"/>'>
            
            <label class="lbl-right" style="width:80px; margin-left:15px;">Mobile</label>
            <input type="text" name="mobile" id="mobile" style="width:150px;" value='<s:property value="mobile"/>'>
        </div>

        <div class="field-row" style="margin-bottom:0;">
            <label class="lbl-right" style="width:80px;">Email</label>
            <input type="text" name="email" id="email" style="flex:1;" value='<s:property value="email"/>'>
        </div>
    </div>

    <!-- Job Master Details Grid -->
    <div class="middle-panel" style="background: #fdfdfd; margin-bottom:15px;">
        <span class="middle-panel-title">Job Master Details</span>
        <div id="jobmasterdiv">
            <jsp:include page="jobMasterGrid.jsp"></jsp:include>
        </div>
    </div>

    <!-- Hidden Fields -->
    <div style="display:none;">
        <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
        <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>
        <input type="hidden" id="hidaccdocno" name="hidaccdocno" value='<s:property value="hidaccdocno"/>'/>
        <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
        <input type="hidden" name="technicianJoblength" id="technicianJoblength" value='<s:property value="technicianJoblength"/>'/>
    </div>
</div>
</form>

<div id="accountDetailsWindow">
    <div></div><div></div>
</div>
<div id="jobmasterWindow">
    <div></div><div></div>
</div>

</div>
</body>
</html>