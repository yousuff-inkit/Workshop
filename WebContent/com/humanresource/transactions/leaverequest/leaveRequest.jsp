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
<script type="text/javascript" src="<%=contextPath%>/js/ajaxfileupload.js"></script> 

<style>
/* =========================================================
SCOPED UI: Modern Layout (Matches Client Master)
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

/* Layout Utilities - Tightened Spacing */
.modern-ui .field-row { 
    display: flex;
    align-items: center; 
    gap: 6px;
    margin-bottom: 5px; 
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

/* Middle Section Panels - Reduced Padding */
.modern-ui .middle-panel {
    border: 1px solid #c5d3e0; 
    padding: 14px 10px 8px 10px; 
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
          /* Date - Modern UI Sizing - using 100% to fill flex parent */
          $("#leaveRequestDate").jqxDateTimeInput({ width: '100%', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
          $("#fromDate").jqxDateTimeInput({ width: '100%', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
          $("#toDate").jqxDateTimeInput({ width: '100%', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
          $("#halfDayDate").jqxDateTimeInput({ width: '100%', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
         
          /* force internal alignment AFTER render */
          setTimeout(function () {
             $("#leaveRequestDate, #fromDate, #toDate, #halfDayDate").find("input").css({
                 "margin-top": "0px",
                 "line-height": "24px",
                 "font-size": "12px", 
                 "font-family": "Arial, sans-serif", 
                 "padding": "0 6px", 
                 "box-sizing":"border-box"
             });
             $("#leaveRequestDate, #fromDate, #toDate, #halfDayDate").find(".jqx-action-button").css({
                 "top": "0px",
                 "height": "24px"
             });
          }, 0);
          
         $('#employeeDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Employee Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
         $('#employeeDetailsWindow').jqxWindow('close');
        
         $('#txtemployeeid').dblclick(function(){
             employeeSearchContent("employeeDetailsSearch.jsp");
         });
         
         getDesignation();getDepartment();getPayrollCategory();getLeaveType();
         
      });
    
    function employeeSearchContent(url) {
        $('#employeeDetailsWindow').jqxWindow('open');
        $.get(url).done(function (data) {
        $('#employeeDetailsWindow').jqxWindow('setContent', data);
        $('#employeeDetailsWindow').jqxWindow('bringToFront');
    }); 
    }
    
    function getDesignation() {
        var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {
                var items = x.responseText;
                items = items.split('####');
                var designationItems = items[0].split(",");
                var designationIdItems = items[1].split(",");
                var optionsdesignation = '<option value="">--Select--</option>';
                for (var i = 0; i < designationItems.length; i++) {
                    optionsdesignation += '<option value="' + designationIdItems[i] + '">'
                            + designationItems[i] + '</option>';
                }
                $("select#cmbempdesignation").html(optionsdesignation);
                if ($('#hidcmbempdesignation').val() != null) {
                    $('#cmbempdesignation').val($('#hidcmbempdesignation').val());
                }
            } else {
            }
        }
        x.open("GET", "getDesignation.jsp", true);
        x.send();
    }
  
  function getDepartment() {
        var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {
                var items = x.responseText;
                items = items.split('####');
                var departmentItems = items[0].split(",");
                var departmentIdItems = items[1].split(",");
                var optionsdepartment = '<option value="">--Select--</option>';
                for (var i = 0; i < departmentItems.length; i++) {
                    optionsdepartment += '<option value="' + departmentIdItems[i] + '">'
                            + departmentItems[i] + '</option>';
                }
                $("select#cmbempdepartment").html(optionsdepartment);
                if ($('#hidcmbempdepartment').val() != null) {
                    $('#cmbempdepartment').val($('#hidcmbempdepartment').val());
                }
            } else {
            }
        }
        x.open("GET", "getDepartment.jsp", true);
        x.send();
    }
  
  function getPayrollCategory() {
        var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {
                var items = x.responseText;
                items = items.split('####');
                var payrollcategoryItems = items[0].split(",");
                var payrollcategoryIdItems = items[1].split(",");
                var optionspayrollcategory = '<option value="">--Select--</option>';
                for (var i = 0; i < payrollcategoryItems.length; i++) {
                    optionspayrollcategory += '<option value="' + payrollcategoryIdItems[i] + '">'
                            + payrollcategoryItems[i] + '</option>';
                }
                $("select#cmbpayrollcategory").html(optionspayrollcategory);
                if ($('#hidcmbpayrollcategory').val() != null) {
                    $('#cmbpayrollcategory').val($('#hidcmbpayrollcategory').val());
                }
            } else {
            }
        }
        x.open("GET", "getPayrollCategory.jsp", true);
        x.send();
    }
  
      function funNoofDaysLeave(){
             
             var leavestartday= $('#fromDate').jqxDateTimeInput('getDate');
             var leaveendday= $('#toDate').jqxDateTimeInput('getDate');
    
             if(leavestartday==null){
                 document.getElementById("errormsg").innerText="From Date is Mandatory.";
                 return 0;
             }
             
             if(leaveendday==null){
                 document.getElementById("errormsg").innerText="To Date is Mandatory.";
                 return 0;
             }
             
             if(leavestartday>leaveendday){
                 document.getElementById("errormsg").innerText="From Date Should be less than To Date.";
                 return 0;
             }
             
             document.getElementById("errormsg").innerText="";
             
             var startdate = $('#fromDate').jqxDateTimeInput('getText');
             var enddate = $('#toDate').jqxDateTimeInput('getText');
             var halfday = $('#hidchckhalfday').val();
             getNumberOfDays(startdate,enddate,halfday);
    }
    
    function getNumberOfDays(startdate,enddate,halfday){
            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    var items = x.responseText;
                    $('#txtnoofdays').val(items.trim());
            }
            }
            x.open("GET", "getNumberOfDays.jsp?startdate="+startdate+'&enddate='+enddate+'&halfday='+halfday, true);
            x.send();
     }
    
    function halfdaycheck(){
             if(document.getElementById("chckhalfday").checked){
                 document.getElementById("hidchckhalfday").value = 1;
                 $('#halfDayDate').jqxDateTimeInput({disabled: false});
             }
             else{
                 document.getElementById("hidchckhalfday").value = 0;
                 $('#halfDayDate').jqxDateTimeInput({disabled: true});
            } 
        }
    
  function getLeaveType() {
        var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {
                var items = x.responseText;
                items = items.split('####');
                var leavetypeItems = items[0].split(",");
                var leavetypeIdItems = items[1].split(",");
                var optionsleavetype = '<option value="">--Select--</option>';
                for (var i = 0; i < leavetypeItems.length; i++) {
                    optionsleavetype += '<option value="' + leavetypeIdItems[i] + '">'
                            + leavetypeItems[i] + '</option>';
                        
                }
                $("select#cmbleavetype").html(optionsleavetype);
                if ($('#hidcmbleavetype').val() != null) {
                    $('#cmbleavetype').val($('#hidcmbleavetype').val());
                }
            } else {
            }
        }
        x.open("GET", "getLeaveType.jsp", true);
        x.send();
    }
  
    function getEmployee(event){
       var x= event.keyCode;
       if(x==114){
        employeeSearchContent("employeeDetailsSearch.jsp");
       } else{}
      }
  
     function funReadOnly(){
            $('#frmLeaveRequest input').attr('readonly', true );
            $('#frmLeaveRequest select').attr('disabled', true);
            $('#leaveRequestDate').jqxDateTimeInput({disabled: true});
            $('#fromDate').jqxDateTimeInput({disabled: true});
            $('#toDate').jqxDateTimeInput({disabled: true});
            $('#halfDayDate').jqxDateTimeInput({disabled: true});
            $('#chckhalfday').attr('disabled', true);
     }
    
     function funRemoveReadOnly(){
            $('#frmLeaveRequest input').attr('readonly', false );
            $('#frmLeaveRequest select').attr('disabled', false);
            $('#leaveRequestDate').jqxDateTimeInput({disabled: false});
            $('#fromDate').jqxDateTimeInput({disabled: false});
            $('#toDate').jqxDateTimeInput({disabled: false});
            $('#chckhalfday').attr('disabled', false);
            $('#docno').attr('readonly', true);
            $('#txtemployeeid').attr('readonly', true);
            $('#txtemployeename').attr('readonly', true);
            $('#txtnoofdays').attr('readonly', true);
            
            if ($("#mode").val() == "A") {
                $('#leaveRequestDate').val(new Date());
                $('#fromDate').val(new Date());
                $('#toDate').val(new Date());
                $('#halfDayDate').val(new Date());
                document.getElementById("chckhalfday").checked=false;
                document.getElementById("hidchckhalfday").value = 0; 
                $('#txtnoofdays').val('1.0');
            }
            
            if ($("#mode").val() == "E") {
                if(document.getElementById("hidchckhalfday").value==1){
                    $('#halfDayDate').jqxDateTimeInput({disabled: false});
                }
            }
            
     }
    
     function funSearchLoad(){
         changeContent('lrqMainSearch.jsp'); 
     }
        
     function funChkButton() {
            /* funReset(); */
        }
    
     function funFocus(){
        $('#leaveRequestDate').jqxDateTimeInput('focus');           
     }
    
        $(function(){
            $('#frmLeaveRequest').validate({
                    rules: {
                    cmbleavetype:"required",
                    txtdescription:{maxlength:500}
                     },
                     messages: {
                     cmbleavetype:" *",
                     txtdescription: {maxlength:"   Max 500 chars"}
                     }
            });}); 
       
      function funNotify(){ 
          
          /* Validation */
          
            empid=document.getElementById("txtemployeedocno").value;
            if(empid==""){
                 document.getElementById("errormsg").innerText="Employee is Mandatory.";
                 return 0;
            }
             
            if(document.getElementById("hidchckhalfday").value==1){
                
                var leavestartday=  new Date($('#fromDate').jqxDateTimeInput('getDate'));
                var leaveendday=  new Date($('#toDate').jqxDateTimeInput('getDate'));
                var halfday=  new Date($('#halfDayDate').jqxDateTimeInput('getDate'));
                 
                leavestartday = leavestartday.setHours(0,0,0,0);
                leaveendday = leaveendday.setHours(0,0,0,0);
                halfday = halfday.setHours(0,0,0,0);
                   
               if(leavestartday==null){
                 document.getElementById("errormsg").innerText="From Date is Mandatory.";
                 return 0;
               }
             
               if(leaveendday==null){
                 document.getElementById("errormsg").innerText="To Date is Mandatory.";
                 return 0;
               }
             
               if(!(halfday==leavestartday || halfday==leaveendday)){
                 document.getElementById("errormsg").innerText="Half Day Date Should be From Date or To Date.";
                 return 0;
              }
          }
            
          noofdays=document.getElementById("txtnoofdays").value;
          if(noofdays=="" || noofdays=="0"){
             document.getElementById("errormsg").innerText="Invalid Request !!!";
             return 0;
          }
            
          document.getElementById("errormsg").innerText="";
            
        /* Validation Ends*/

          return 1;
        } 
    
    
      function setValues(){
          
          if($('#hidleaveRequestDate').val()){
                 $("#leaveRequestDate").jqxDateTimeInput('val', $('#hidleaveRequestDate').val());
              }
          
          if($('#hidfromDate').val()){
                 $("#fromDate").jqxDateTimeInput('val', $('#hidfromDate').val());
              }
          
          if($('#hidtoDate').val()){
                 $("#toDate").jqxDateTimeInput('val', $('#hidtoDate').val());
              }
          
          if($('#hidhalfDayDate').val()){
                 $("#halfDayDate").jqxDateTimeInput('val', $('#hidhalfDayDate').val());
              }

          if(document.getElementById("hidchckhalfday").value==1){
                 document.getElementById("chckhalfday").checked = true;
             }
             else if(document.getElementById("hidchckhalfday").value==0){
                document.getElementById("chckhalfday").checked = false;
             }
          
          if($('#msg').val()!=""){
               $.messager.alert('Message',$('#msg').val());
              }
          
          document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
          funSetlabel();
            
             
        }
       
      function funPrintBtn() {
                
            if (($("#mode").val() == "view") && $("#docno").val()!="") {
                
                 var url=document.URL;
                 var reurl=url.split("saveLeaveRequest");
                 $("#docno").prop("disabled", false);
                
                       $.messager.confirm('Confirm', 'Do you want to have header?', function(r){
                        if (r){
                             /* var win= window.open(reurl[0]+"printCashPayment?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
                             win.focus(); */
                         }
                        else{
                            /* var win= window.open(reurl[0]+"printCashPayment?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=0","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
                            win.focus(); */
                        }
                       });
             }
            else {
                $.messager.alert('Message','Select a Document....!','warning');
                return;
            }
        }
      
      function funHalfDayCheck() {
          if(document.getElementById("hidchckhalfday").value==1){
            var leavestartday=  new Date($('#fromDate').jqxDateTimeInput('getDate'));
            var leaveendday=  new Date($('#toDate').jqxDateTimeInput('getDate'));
            var halfday=  new Date($('#halfDayDate').jqxDateTimeInput('getDate'));
             
             leavestartday = leavestartday.setHours(0,0,0,0);
             leaveendday = leaveendday.setHours(0,0,0,0);
             halfday = halfday.setHours(0,0,0,0);
             
             if(leavestartday==null){
                 document.getElementById("errormsg").innerText="From Date is Mandatory.";
                 return 0;
             }
             
             if(leaveendday==null){
                 document.getElementById("errormsg").innerText="To Date is Mandatory.";
                 return 0;
             }
             
             if(!(halfday==leavestartday || halfday==leaveendday)){
                 document.getElementById("errormsg").innerText="Half Day Date Should be From Date or To Date.";
                 return 0;
             }
             
             document.getElementById("errormsg").innerText="";
          }
      }
      
</script>
</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background" >
<form id="frmLeaveRequest" action="saveLeaveRequest" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include>

<div class='modern-ui hidden-scrollbar'>
    <div id="errormsg"></div>

    <div class="middle-panel">
        <span class="middle-panel-title">Leave Request Details</span>
        
        <div class="field-row">
            <label class="lbl-right" style="width:80px;">Date</label>
            <div style="flex:1; max-width:125px;">
                <div id="leaveRequestDate" name="leaveRequestDate" value='<s:property value="leaveRequestDate"/>'></div>
            </div>
            <input type="hidden" id="hidleaveRequestDate" name="hidleaveRequestDate" value='<s:property value="hidleaveRequestDate"/>'/>
            
            <label class="lbl-right" style="width:80px; margin-left:auto;">Doc No.</label>
            <input type="text" id="docno" name="txtleaverequestdocno" style="width:150px;" value='<s:property value="txtleaverequestdocno"/>' tabindex="-1" readonly/>
        </div>

        <div class="field-row">
            <label class="lbl-right" style="width:80px;">Designation</label>
            <select id="cmbempdesignation" name="cmbempdesignation" style="flex:1;" value='<s:property value="cmbempdesignation"/>'>
                <option value="">--Select--</option>
            </select>
            <input type="hidden" id="hidcmbempdesignation" name="hidcmbempdesignation" value='<s:property value="hidcmbempdesignation"/>'/>
            
            <label class="lbl-right" style="width:80px; margin-left:8px;">Department</label>
            <select id="cmbempdepartment" name="cmbempdepartment" style="flex:1;" value='<s:property value="cmbempdepartment"/>'>
                <option value="">--Select--</option>
            </select>
            <input type="hidden" id="hidcmbempdepartment" name="hidcmbempdepartment" value='<s:property value="hidcmbempdepartment"/>'/>
            
            <label class="lbl-right" style="width:100px; margin-left:8px;">Payroll Category</label>
            <select id="cmbpayrollcategory" name="cmbpayrollcategory" style="width:150px;" value='<s:property value="cmbpayrollcategory"/>'>
                <option value="">--Select--</option>
            </select>
            <input type="hidden" id="hidcmbpayrollcategory" name="hidcmbpayrollcategory" value='<s:property value="hidcmbpayrollcategory"/>'/>
        </div>

        <div class="field-row">
            <label class="lbl-right" style="width:80px;">Employee</label>
            <div class="input-search-container" style="flex:1;">
                <input type="text" id="txtemployeeid" name="txtemployeeid" placeholder="Press F3" value='<s:property value="txtemployeeid"/>' onkeydown="getEmployee(event);"/>
                <svg class="magnifier-icon" onclick="$('#txtemployeeid').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
            </div>
            
            <input type="text" id="txtemployeename" name="txtemployeename" placeholder="Employee Name" style="flex:2; margin-left:8px;" value='<s:property value="txtemployeename"/>' tabindex="-1" readonly/>
            <input type="hidden" id="txtemployeedocno" name="txtemployeedocno" value='<s:property value="txtemployeedocno"/>'/>
        </div>
        
        <div class="field-row">
            <label class="lbl-right" style="width:80px;">From</label>
            <div style="flex:1; max-width:125px;">
                <div id="fromDate" name="fromDate" onchange="funNoofDaysLeave();" value='<s:property value="fromDate"/>'></div>
            </div>
            <input type="hidden" id="hidfromDate" name="hidfromDate" value='<s:property value="hidfromDate"/>'/>
            
            <label class="lbl-right" style="width:80px; margin-left:8px;">To</label>
            <div style="flex:1; max-width:125px;">
                <div id="toDate" name="toDate" onchange="funNoofDaysLeave();" value='<s:property value="toDate"/>'></div>
            </div>
            <input type="hidden" id="hidtoDate" name="hidtoDate" value='<s:property value="hidtoDate"/>'/>
            
            <label style="display:flex; align-items:center; gap:5px; margin-left:15px; font-size:12px; font-weight:bold; color:#444; cursor:pointer;">
                <input type="checkbox" id="chckhalfday" name="chckhalfday" value="" onchange="halfdaycheck();funNoofDaysLeave();" onclick="$(this).attr('value', this.checked ? 1 : 0)">Half Day
            </label>
            <input type="hidden" id="hidchckhalfday" name="hidchckhalfday" value='<s:property value="hidchckhalfday"/>'/>
            
            <div style="flex:1; max-width:125px; margin-left:8px;">
                <div id="halfDayDate" name="halfDayDate" onchange="funHalfDayCheck();" value='<s:property value="halfDayDate"/>'></div>
            </div>
            <input type="hidden" id="hidhalfDayDate" name="hidhalfDayDate" value='<s:property value="hidhalfDayDate"/>'/>
            
            <label class="lbl-right" style="width:80px; margin-left:auto;">No. of Days</label>
            <input type="text" id="txtnoofdays" name="txtnoofdays" placeholder="Days" style="width:100px; text-align:right;" value='<s:property value="txtnoofdays"/>' tabindex="-1" readonly/>
        </div>

        <div class="field-row" style="margin-bottom:0;">
            <label class="lbl-right" style="width:80px;">Leave Type</label>
            <select id="cmbleavetype" name="cmbleavetype" style="flex:1; max-width:200px;" value='<s:property value="cmbleavetype"/>'>
                <option value="">--Select--</option>
            </select>
            <input type="hidden" id="hidcmbleavetype" name="hidcmbleavetype" value='<s:property value="hidcmbleavetype"/>'/>
            
            <label class="lbl-right" style="width:80px; margin-left:15px;">Description</label>
            <input type="text" id="txtdescription" name="txtdescription" placeholder="Description" style="flex:1;" value='<s:property value="txtdescription"/>'/>
        </div>

    </div>

    <!-- Hidden Fields Map -->
    <div style="display:none;">
        <input type="hidden" id="mode" name="mode"/>
        <input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
        <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
    </div>
</div>
</form>

<div id="employeeDetailsWindow">
   <div></div><div></div>
</div>

</div>
</body>
</html>