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
    display: flex;
    align-items: center;
}

/* Custom UI Buttons matching 24px height */
.modern-ui .myButton,
.modern-ui .myButtons,
.modern-ui .myProcessCalcButton,
.modern-ui .mySaveButton,
.modern-ui .myConfirmButton {
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
    white-space: nowrap;
}

/* Override custom buttons to match modern blue gradient standard unless specific colors needed */
.modern-ui .myButton, .modern-ui .myButtons, .modern-ui .myProcessCalcButton {
    background: linear-gradient(135deg, #0b45a2 0%, #2563eb 100%);
    color: #ffffff;
}
.modern-ui .myButton:hover, .modern-ui .myButtons:hover, .modern-ui .myProcessCalcButton:hover { 
    background: linear-gradient(135deg, #083a8a 0%, #1d4ed8 100%); 
}

.modern-ui .mySaveButton {
    background: linear-gradient(135deg, #5cb811 0%, #77d42a 100%);
    color: #ffffff;
}
.modern-ui .mySaveButton:hover { background: linear-gradient(135deg, #4da30e 0%, #5cb811 100%); }

.modern-ui .myConfirmButton {
    background: linear-gradient(135deg, #ffab23 0%, #ffec64 100%);
    color: #333;
}
.modern-ui .myConfirmButton:hover { background: linear-gradient(135deg, #e5991f 0%, #ffab23 100%); }

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

.bounce {
    color: #f35626;
    background-image: -webkit-linear-gradient(92deg,#f35626,#feab3a);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    -webkit-animation: hue 60s infinite linear,bounce 2s infinite; 
}

@-webkit-keyframes bounce {
  0%, 20%, 50%, 80%, 100% { transform: translateX(0); }
  40% { transform: translateX(-30px); }
  60% { transform: translateX(-15px); }
} 
@-webkit-keyframes hue {
  from { -webkit-filter: hue-rotate(0deg); }
  to { -webkit-filter: hue-rotate(-360deg); }
}

.flex-btn-container {
    display: flex;
    justify-content: center;
    gap: 8px;
    margin-top: 10px;
}
</style>

<script type="text/javascript">
      $(document).ready(function () {
          $('#btnClose').attr('disabled', true );$('#btnCreate').attr('disabled', true );$('#btnEdit').attr('disabled', true );
          $('#btnDelete').attr('disabled', true );$('#btnSearch').attr('disabled', true );$('#btnAttach').attr('disabled', true );
         
          /* Date - Modern UI Sizing - using 100% to fill flex parent */
          $("#payrollDate").jqxDateTimeInput({ width: '100%', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
          $("#payrollPrintDate").jqxDateTimeInput({ width: '100%', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
          
          /* force internal alignment AFTER render */
          setTimeout(function () {
             $("#payrollDate, #payrollPrintDate").find("input").css({
                 "margin-top": "0px",
                 "line-height": "24px",
                 "font-size": "12px", 
                 "font-family": "Arial, sans-serif", 
                 "padding": "0 6px", 
                 "box-sizing":"border-box"
             });
             $("#payrollDate, #payrollPrintDate").find(".jqx-action-button").css({
                 "top": "0px",
                 "height": "24px"
             });
          }, 0);
          
          /* Searching Window */
         $('#employeeDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Employee Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
         $('#employeeDetailsWindow').jqxWindow('close');
        
         $('#txtemployeeid').dblclick(function(){
            employeeSearchContent("employeeDetailsSearch.jsp");
          });
        
         $('#txtprintemployeeid').dblclick(function(){
            employeeSearchContent("employeeDetailsSearch.jsp");
         });
        
         $(".chckpayrollprocessprint").click(function() {
            selectedBox = this.id;
            $(".chckpayrollprocessprint").each(function() {
                if ( this.id == selectedBox ) {
                    this.checked = true;
                } else {
                    this.checked = false;
                };      
            });
         }); 
        
         if($('#docno').val().trim()==''){
            $('#mode').val('view');$('#docno').val('0');
         } else if(parseInt($('#docno').val().trim())==0){
            $('#mode').val('A'); 
         } else if(parseInt($('#docno').val().trim())>0){
            $('#mode').val('E'); 
         } else {
            $('#mode').val('view');
         }
        
         $('#txtemployeeid').attr('readonly', true);
         $('#txtemployeename').attr('readonly', true);
         $('#txtprintemployeeid').attr('readonly', true);
         $('#txtprintemployeename').attr('readonly', true);
         $('#payrollDate').jqxDateTimeInput('focus'); 
         $("#monthlyPayrollGridID").jqxGrid('clear');
         $("#monthlyPayrollGridID").jqxGrid('addrow', null, {});
         $("#monthlyPayrollGridID").jqxGrid({ disabled: true});
         $('#btnSavePayRoll').attr('disabled', true );$('#btnConfirmed').attr('disabled', true );
         document.getElementById("lblcurrentstatus").innerText="";
         $('#hidchckpayrollprocess').val(1);document.getElementById("chckpayrollprocess").checked = true;
         $('#hidchckpayrollprint').val(0);document.getElementById("chckpayrollprint").checked = false;
         $('#hidchckpayslip').val(0);document.getElementById("chckpayslip").checked = false;

         $('#payrollPrintDate').jqxDateTimeInput({disabled: true});
         $('#cmbempprintcategory').attr('disabled', true);
         $('#txtprintemployeeid').attr('disabled', true);
         $('#txtprintemployeename').attr('disabled', true);
         $('#chckpayslip').attr('disabled', true);
         $('#btnPayrollPrint').attr('disabled', true );
         $('#btnView').attr('disabled', true );
         $('#clearPrint').attr('disabled', true );
        
         var date = $('#payrollDate').val();
         getPayrollDate(date);getPayrollCategory();getLeaveType();getAllowanceType();
        
         $('#payrollDate').focusout(function(){
             var date = $('#payrollDate').val();
             getPayrollDate(date);getPayrollDocNo(date);
         });
         $('#payrollDate').on('close', function (event) { 
             var date = $('#payrollDate').val();
             getPayrollDate(date);getPayrollDocNo(date);
         }); 
         $('#payrollPrintDate').focusout(function(){
             var date = $('#payrollPrintDate').val();
             getPayrollPrintDate(date);getPayrollPrintDocNo(date);
         });
        
      }); 
      
      function employeeSearchContent(url) {
            $('#employeeDetailsWindow').jqxWindow('open');
            $.get(url).done(function (data) {
            $('#employeeDetailsWindow').jqxWindow('setContent', data);
            $('#employeeDetailsWindow').jqxWindow('bringToFront');
        }); 
        }
      
     function getPayrollDate(date){
            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    var items = x.responseText;
                    $('#payrollDate').val(items);
            }
            }
            x.open("GET", "getPayrollDate.jsp?date="+date, true);
            x.send();
     }
     
     function getPayrollPrintDate(date){
            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    var items = x.responseText;
                    $('#payrollPrintDate').val(items);
            }
            }
            x.open("GET", "getPayrollDate.jsp?date="+date, true);
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
                $("select#cmbempcategory").html(optionspayrollcategory);
                $("select#cmbempprintcategory").html(optionspayrollcategory);
                if ($('#hidcmbempcategory').val() != null) {
                    $('#cmbempcategory').val($('#hidcmbempcategory').val());
                }
                if ($('#hidcmbempprintcategory').val() != null) {
                    $('#cmbempprintcategory').val($('#hidcmbempprintcategory').val());
                }
            }
        }
        x.open("GET", "getPayrollCategory.jsp", true);
        x.send();
    }
    
    function getLeaveType() {
        var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {
                var items = x.responseText;
                items = items.split('####');
                var leavetypeItems = items[0].split(",");
                var leavetypeIdItems = items[1].split(",");
                var leavetypeCountItems = items[2].split(",");
                
                for (var i = 0; i < leavetypeItems.length; i++) {
                    if(i==0) $('#txtleavetype1').val(leavetypeItems[i]);
                    else if(i==1) $('#txtleavetype2').val(leavetypeItems[i]);
                    else if(i==2) $('#txtleavetype3').val(leavetypeItems[i]);
                    else if(i==3) $('#txtleavetype4').val(leavetypeItems[i]);
                    else if(i==4) $('#txtleavetype5').val(leavetypeItems[i]);
                    else if(i==5) $('#txtleavetype6').val(leavetypeItems[i]);
                    else if(i==6) $('#txtleavetype7').val(leavetypeItems[i]);
                    else if(i==7) $('#txtleavetype8').val(leavetypeItems[i]);
                    else if(i==8) $('#txtleavetype9').val(leavetypeItems[i]);
                    else $('#txtleavetype10').val(leavetypeItems[i]);
                                                        
                    $('#txtleavetypecount').val(leavetypeCountItems[i]);
                }
            }
        }
        x.open("GET", "getLeaveType.jsp", true);
        x.send();
    }
    
    function getAllowanceType() {
        var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {
                var items = x.responseText;
                items = items.split('####');
                var allowancetypeItems = items[0].split(",");
                var allowancetypeIdItems = items[1].split(",");
                var allowancetypeCountItems = items[2].trim();

                for (var i = 0; i < allowancetypeItems.length; i++) {
                    if(i==0) $('#txtallowancetype1').val(allowancetypeItems[i]);
                    else if(i==1) $('#txtallowancetype2').val(allowancetypeItems[i]);
                    else if(i==2) $('#txtallowancetype3').val(allowancetypeItems[i]);
                    else if(i==3) $('#txtallowancetype4').val(allowancetypeItems[i]);
                    else if(i==4) $('#txtallowancetype5').val(allowancetypeItems[i]);
                    else if(i==5) $('#txtallowancetype6').val(allowancetypeItems[i]);
                    else if(i==6) $('#txtallowancetype7').val(allowancetypeItems[i]);
                    else if(i==7) $('#txtallowancetype8').val(allowancetypeItems[i]);
                    else if(i==8) $('#txtallowancetype9').val(allowancetypeItems[i]);
                    else $('#txtallowancetype10').val(allowancetypeItems[i]);
                }
                $('#txtallowancetypecount').val(allowancetypeCountItems);
            }
        }
        x.open("GET", "getAllowanceType.jsp", true);
        x.send();
    }
    
    function getLastPayrollDate(payrolldate){
        var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {
                var items = x.responseText;
                 items = items.split('***');
                 $('#txtchkgridload').val(items[0]);
                 document.getElementById("errormsg").innerText="Payroll Processed till "+items[1]+".";
                 
                 if(parseInt($('#txtchkgridload').val())==1){
                      $("#overlay, #PleaseWait").show();
                      $('#txtchkgridload').val('');
                      document.getElementById("lblcurrentstatus").innerText="Payroll to be Saved.";
                      funLoadGrid();
                 } else if(parseInt($('#txtchkgridload').val())==0) {
                      $.messager.alert('Message','Payroll Process Pending for Last-Month.','warning');
                      $("#monthlyPayrollGridID").jqxGrid('clear'); 
                      $("#monthlyPayrollGridID").jqxGrid('addrow', null, {});
                      $("#monthlyPayrollGridID").jqxGrid({ disabled: true});
                      document.getElementById("lblcurrentstatus").innerText="Pending for Last-Month.";
                      $('#mode').val('view');
                      return;
                 } else if(parseInt($('#txtchkgridload').val())==2) {
                      $.messager.alert('Message','Already Payroll Processed.','warning');
                      $("#monthlyPayrollGridID").jqxGrid('clear'); 
                      $("#monthlyPayrollGridID").jqxGrid('addrow', null, {});
                      $("#monthlyPayrollGridID").jqxGrid({ disabled: true});
                      document.getElementById("lblcurrentstatus").innerText="Already Processed.";
                      $('#mode').val('E');
                      return;
                 } else if(parseInt($('#txtchkgridload').val())==3) {
                      $.messager.alert('Message','Enter Attendance & Process Payroll','warning');
                      $("#monthlyPayrollGridID").jqxGrid('clear'); 
                      $("#monthlyPayrollGridID").jqxGrid('addrow', null, {});
                      $("#monthlyPayrollGridID").jqxGrid({ disabled: true});
                      document.getElementById("lblcurrentstatus").innerText="";
                      $('#mode').val('view');
                      document.getElementById("errormsg").innerText="";
                      return;
                 } else if(parseInt($('#txtchkgridload').val())==4) {
                      document.getElementById("lblcurrentstatus").innerText="Payroll Processed.";
                      $('#mode').val('E');
                      $("#overlay, #PleaseWait").show();
                      funLoadGrid();
                 } else if(parseInt($('#txtchkgridload').val())==5) {
                      $("#overlay, #PleaseWait").show();
                      document.getElementById("lblcurrentstatus").innerText="Payroll Confirmed.";
                      $('#mode').val('view');
                      funLoadGrid();
                 }
            }
        }
        x.open("GET", "getLastPayrolledDate.jsp?payrolldate="+payrolldate, true);
        x.send();
    }
    
    function getPayrollDocNo(payrolldate){
        var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {
                var items = x.responseText;
                $('#docno').val(items);
              
                if(items.trim()==''){
                    $('#mode').val('view');$('#docno').val('0');
                } else if(parseInt(items.trim())==0){
                    $('#mode').val('A'); 
                } else if(parseInt(items.trim())>0){
                    $('#mode').val('E'); 
                } else {
                    $('#mode').val('view');
                }
        }
        }
        x.open("GET", "getPayrollDocNo.jsp?payrolldate="+payrolldate, true);
        x.send();
    }
    
    function getPayrollPrintDocNo(payrolldate){
        var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {
                var items = x.responseText;
                $('#docno').val(items);
              
                if(items.trim()==''){
                    $('#docno').val('0');
                }
        }
        }
        x.open("GET", "getPayrollDocNo.jsp?payrolldate="+payrolldate, true);
        x.send();
    }
    
    function getEmployeeId(event){
        var x= event.keyCode;
        if(x==114){
            employeeSearchContent("employeeDetailsSearch.jsp");
        }
    }

    function funExcelBtn(){
         if(parseInt(window.parent.chkexportdata.value)=="1") {
             JSONToCSVCon(data, 'MonthlyPayroll', true);
         } else {
             $("#monthlyPayrollGridID").jqxGrid('exportdata', 'xls', 'MonthlyPayroll');
         }
     }
    
     function funLoadGrid() {
          var mode = $('#mode').val();
          var docno = $('#docno').val().trim(); 
          var date = $('#payrollDate').jqxDateTimeInput('val');
          var category = $('#cmbempcategory').val();
          var empid = $('#txtemployeedocno').val();
          
          $("#payrollDiv").load("monthlyPayrollGrid.jsp?mode="+mode+"&docno="+docno+"&date="+date+"&category="+category+"&empid="+empid+"&check=1");
          $("#monthlyPayrollGridID").jqxGrid({ disabled: false});
          $('#btnSavePayRoll').attr('disabled', false );$('#btnConfirmed').attr('disabled', true );
          
          if(mode=='E'){
             $('#btnConfirmed').attr('disabled', false ); 
          }
          if(mode=='view'){
            $('#btnSavePayRoll').attr('disabled', true );$('#btnConfirmed').attr('disabled', true ); 
          }
    }
    
     function funLoadPrintGrid() {
          var date = $('#payrollPrintDate').val();
          var category = $('#cmbempprintcategory').val();
          var empid = $('#txtprintemployeedocno').val();
          
          $("#overlay, #PleaseWait").show();
          
          $("#payrollPrintDiv").load("monthlyPayrollPrintGrid.jsp?date="+date+"&category="+category+"&empid="+empid+"&check=1");
          $('#btnPayrollPrint').attr('disabled', false );
     }
    
    function funReadOnly(){} 
    function funRemoveReadOnly(){}
    function funSearchLoad(){}
    function funChkButton(){}
    
     function funNotify(){
                /* Monthly Payroll Grid  Saving*/
                var rows = $("#monthlyPayrollGridID").jqxGrid('getrows');
                var length=0;
                     for(var i=0 ; i < rows.length ; i++){
                        var chk=rows[i].employeedocno;
                        if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){
                            newTextBox = $(document.createElement("input"))
                            .attr("type", "hidden")
                            .attr("id", "test"+length)
                            .attr("name", "test"+length)
                            .attr("hidden", "true");
                            length=length+1;
                                
                    newTextBox.val(rows[i].employeedocno+":: "+rows[i].dates+":: "+rows[i].totaldays+":: "+rows[i].leave1+":: "+rows[i].leave2+":: "+rows[i].leave3+":: "+rows[i].leave4+":: "+rows[i].leave5+":: "+rows[i].leave6+":: "+rows[i].leave7+":: "+rows[i].leave8+":: "+rows[i].leave9+":: "+rows[i].leave10+":: "+rows[i].basic+":: "+rows[i].allowance1+":: "+rows[i].allowance2+":: "+rows[i].allowance3+":: "+rows[i].allowance4+":: "+rows[i].allowance5+":: "+rows[i].allowance6+":: "+rows[i].allowance7+":: "+rows[i].allowance8+":: "+rows[i].allowance9+":: "+rows[i].allowance10+":: "+rows[i].totalsalary+":: "+rows[i].ot+":: "+rows[i].hot+":: "+rows[i].overtime+":: "+rows[i].leavedeductions+":: "+rows[i].grosssalary+":: "+rows[i].additions+":: "+rows[i].deductions+":: "+rows[i].loan+":: "+rows[i].netsalary+":: "+rows[i].remarks+":: "+rows[i].earnbasic+":: "+rows[i].earnallowance1+":: "+rows[i].earnallowance2+":: "+rows[i].earnallowance3+":: "+rows[i].earnallowance4+":: "+rows[i].earnallowance5+":: "+rows[i].earnallowance6+":: "+rows[i].earnallowance7+":: "+rows[i].earnallowance8+":: "+rows[i].earnallowance9+":: "+rows[i].earnallowance10+":: "+rows[i].totalearnedsalary+":: "+rows[i].rowno);
                    newTextBox.appendTo('form');
                 }
                }
                $('#gridlength').val(length);
         return 1;
        } 
    
     function funFocus(){
         $('#payrollDate').jqxDateTimeInput('focus'); 
      }
    
     function setValues(){
             checkPaySlip();checkPayrollPrint();checkPayrollProcess();
        
             if($('#msg').val()!=""){
                   $.messager.alert('Message',$('#msg').val());
                  }
            
             document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
             funSetlabel();
            
             var indexVal = document.getElementById("docno").value;
             if(indexVal> 0){
                 $("#payrollDiv").load("monthlyPayrollGrid.jsp?docno="+indexVal+"&date="+$('#payrollDate').val());
             } 
        }
    
     function  funClearInfo(){
            
            $('#payrollDate').val(new Date());
            document.getElementById("cmbempcategory").value="";
            document.getElementById("txtemployeeid").value="";
            document.getElementById("txtemployeedocno").value="";
            document.getElementById("txtemployeename").value="";
            document.getElementById("txtchkgridload").value="";
            document.getElementById("lblcurrentstatus").innerText="";
            $("#monthlyPayrollGridID").jqxGrid('clear');
            $("#monthlyPayrollGridID").jqxGrid({ disabled: true});
            $('#btnSavePayRoll').prop('disabled', true);$('#btnConfirmed').prop('disabled', true);
            
             if (document.getElementById("txtemployeeid").value == "") {
                    $('#txtemployeeid').attr('placeholder', 'Press F3'); 
                    $('#txtemployeename').attr('placeholder', 'Employee Name');
                }
             
             $('#payrollDate').jqxDateTimeInput('focus'); 
             document.getElementById("errormsg").innerText="";
    }
    
     function  funClearPrintInfo(){
            
            $('#payrollPrintDate').val(new Date());
            document.getElementById("cmbempprintcategory").value="";
            document.getElementById("txtprintemployeeid").value="";
            document.getElementById("txtprintemployeedocno").value="";
            document.getElementById("txtprintemployeename").value="";
            document.getElementById("lblcurrentstatus").innerText="";
            $("#monthlyPayrollPrintGridID").jqxGrid('clear');
            $("#monthlyPayrollPrintGridID").jqxGrid({ disabled: true});
            $('#btnView').prop('disabled', false);$('#clearPrint').prop('disabled', false);$('#btnPayrollPrint').prop('disabled', true);
            $('#hidchckpayslip').val(0);document.getElementById("chckpayslip").checked = false;
            
             if (document.getElementById("txtprintemployeeid").value == "") {
                    $('#txtprintemployeeid').attr('placeholder', 'Press F3'); 
                    $('#txtprintemployeename').attr('placeholder', 'Employee Name');
                }
             
             $('#payrollPrintDate').jqxDateTimeInput('focus'); 
             document.getElementById("errormsg").innerText="";
    }
    
     function funProcessGrid(){
         var date = $('#payrollDate').val();
         getLastPayrollDate(date);
     }
    
     function funSaveGrid(){
         $('#btnSavePayRoll').attr('disabled', false );$('#btnConfirmed').attr('disabled', false );$('#btnSave').mousedown();
     }
    
     function funConfirm(){
         var alreadyProcessed = $('#txtpayrollalreadyprocessed').val();
         var payrollRows = $("#monthlyPayrollGridID").jqxGrid('getrows');
         if(parseInt(alreadyProcessed)!=parseInt(payrollRows.length)){
             $.messager.alert('Message','Payroll Saving Pending For Some Employee(s).','warning');
             return;
         }
        
         $.messager.confirm('Confirm', 'Do you want to Post?', function(r){
                if (r){
                    /* Monthly Payroll Grid  Saving*/
                    var rows = $("#monthlyPayrollGridID").jqxGrid('getrows');
                    var length=0;
                         for(var i=0 ; i < rows.length ; i++){
                            var chk=rows[i].employeedocno;
                            if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){
                                newTextBox = $(document.createElement("input"))
                                .attr("type", "hidden")
                                .attr("id", "test"+length)
                                .attr("name", "test"+length)
                                .attr("hidden", "true");
                                length=length+1;
                                    
                        newTextBox.val(rows[i].employeedocno+":: "+rows[i].dates+":: "+rows[i].totaldays+":: "+rows[i].leave1+":: "+rows[i].leave2+":: "+rows[i].leave3+":: "+rows[i].leave4+":: "+rows[i].leave5+":: "+rows[i].leave6+":: "+rows[i].leave7+":: "+rows[i].leave8+":: "+rows[i].leave9+":: "+rows[i].leave10+":: "+rows[i].basic+":: "+rows[i].allowance1+":: "+rows[i].allowance2+":: "+rows[i].allowance3+":: "+rows[i].allowance4+":: "+rows[i].allowance5+":: "+rows[i].allowance6+":: "+rows[i].allowance7+":: "+rows[i].allowance8+":: "+rows[i].allowance9+":: "+rows[i].allowance10+":: "+rows[i].totalsalary+":: "+rows[i].ot+":: "+rows[i].hot+":: "+rows[i].overtime+":: "+rows[i].leavedeductions+":: "+rows[i].grosssalary+":: "+rows[i].additions+":: "+rows[i].deductions+":: "+rows[i].loan+":: "+rows[i].netsalary+":: "+rows[i].remarks);
                        newTextBox.appendTo('form');
                     }
                    }
                    $('#gridlength').val(length);
                    
                    $('#mode').val('EDIT');
                    $("#overlay, #PleaseWait").show();
                    document.getElementById("frmMonthlyPayroll").submit();
                }
           });
     }
    
     function funCheckPayrollProcess(){
         $('#payrollDate').val(new Date());document.getElementById("cmbempcategory").value="";document.getElementById("txtemployeeid").value="";
         document.getElementById("txtemployeedocno").value="";document.getElementById("txtemployeename").value="";document.getElementById("txtchkgridload").value="";
         document.getElementById("lblcurrentstatus").innerText="";$("#monthlyPayrollGridID").jqxGrid({ disabled: true});document.getElementById("errormsg").innerText="";
         $('#txtemployeeid').attr('placeholder', 'Press F3'); $('#txtemployeename').attr('placeholder', 'Employee Name');
         $('#payrollPrintDate').val(new Date());document.getElementById("cmbempprintcategory").value="";document.getElementById("txtprintemployeeid").value="";
         document.getElementById("txtprintemployeedocno").value="";document.getElementById("txtprintemployeename").value="";
         $("#monthlyPayrollPrintGridID").jqxGrid({ disabled: true});$('#txtprintemployeeid').attr('placeholder', 'Press F3'); $('#txtprintemployeename').attr('placeholder', 'Employee Name');
                
         if(document.getElementById("chckpayrollprocess").checked == true){
             $('#payrollDate').jqxDateTimeInput('focus'); $('#hidchckpayrollprocess').val(1);$('#hidchckpayrollprint').val(0);$('#payrollDate').jqxDateTimeInput({disabled: false});
             $('#cmbempcategory').attr('disabled', false);$('#txtemployeeid').attr('disabled', false);$('#txtemployeename').attr('disabled', false);$("#payrollDiv").prop("hidden", false);
             $("#payrollPrintDiv").prop("hidden", true);$('#clear').attr('disabled', false);$('#btnProcess').attr('disabled', false );$('#btnSavePayRoll').attr('disabled', true );$('#btnConfirmed').attr('disabled', true );
                 $('#payrollPrintDate').jqxDateTimeInput({disabled: true});$('#cmbempprintcategory').attr('disabled', true);$('#txtprintemployeeid').attr('disabled', true);$('#txtprintemployeename').attr('disabled', true);
                 $('#chckpayslip').attr('disabled', true);$('#btnPayrollPrint').attr('disabled', true );$('#btnView').attr('disabled', true );$('#clearPrint').attr('disabled', true );
          } 
      }
    
     function funCheckPayrollPrint(){
          $('#payrollDate').val(new Date());document.getElementById("cmbempcategory").value="";document.getElementById("txtemployeeid").value="";
          document.getElementById("txtemployeedocno").value="";document.getElementById("txtemployeename").value="";document.getElementById("txtchkgridload").value="";
          document.getElementById("lblcurrentstatus").innerText="";$("#monthlyPayrollGridID").jqxGrid({ disabled: true});document.getElementById("errormsg").innerText="";
          $('#txtemployeeid').attr('placeholder', 'Press F3');$('#txtemployeename').attr('placeholder', 'Employee Name');
          $('#payrollPrintDate').val(new Date());document.getElementById("cmbempprintcategory").value="";document.getElementById("txtprintemployeeid").value="";
          document.getElementById("txtprintemployeedocno").value="";document.getElementById("txtprintemployeename").value="";$("#monthlyPayrollPrintGridID").jqxGrid({ disabled: true});
          $('#txtprintemployeeid').attr('placeholder', 'Press F3'); $('#txtprintemployeename').attr('placeholder', 'Employee Name');
          
          if(document.getElementById("chckpayrollprint").checked == true){
             $('#payrollPrintDate').jqxDateTimeInput('focus');$('#hidchckpayrollprint').val(1);$('#hidchckpayrollprocess').val(0);$('#payrollPrintDate').jqxDateTimeInput({disabled: false});
                 $('#cmbempprintcategory').attr('disabled', false);$('#txtprintemployeeid').attr('disabled', false);$('#txtprintemployeename').attr('disabled', false);$('#chckpayslip').attr('disabled', false);
                 $('#btnPayrollPrint').attr('disabled', true );$('#payrollDate').jqxDateTimeInput({disabled: true});$('#cmbempcategory').attr('disabled', true);$('#txtemployeeid').attr('disabled', true);
                 $('#txtemployeename').attr('disabled', true);$("#payrollDiv").prop("hidden", true); $("#payrollPrintDiv").prop("hidden", false);$('#clear').attr('disabled', true);$('#btnProcess').attr('disabled', true );
                 $('#btnSavePayRoll').attr('disabled', true );$('#btnConfirmed').attr('disabled', true );$('#btnView').attr('disabled', false );$('#clearPrint').attr('disabled', false );
                 
          } 
      }
     
     function checkPayrollProcess(){
         if(document.getElementById("hidchckpayrollprocess").value==1){
             document.getElementById("chckpayrollprocess").checked = true;
         }
         else if(document.getElementById("hidchckpayrollprocess").value==0){
            document.getElementById("chckpayrollprocess").checked = false;
          }
         }
     
     function funCheckPaySlip(){
          if(document.getElementById("chckpayslip").checked == true){
                 $('#hidchckpayslip').val(1);
          } else{
              $('#hidchckpayslip').val(0);  
          }
      }
    
     function checkPayrollPrint(){
         if(document.getElementById("hidchckpayrollprint").value==1){
             document.getElementById("chckpayrollprint").checked = true;
         }
         else if(document.getElementById("hidchckpayrollprint").value==0){
            document.getElementById("chckpayrollprint").checked = false;
          }
         }
     
    function checkPaySlip(){
         if(document.getElementById("hidchckpayslip").value==1){
             document.getElementById("chckpayslip").checked = true;
         }
         else if(document.getElementById("hidchckpayslip").value==0){
            document.getElementById("chckpayslip").checked = false;
          }
    }
    
    function payrollprintdatechange(){
         var date = $('#payrollPrintDate').val();
         getPayrollPrintDate(date);getPayrollPrintDocNo(date);
    }

     function funPayrollPrint() {
           
        if($("#hidchckpayrollprint").val()=="1") {
            
        var rows=$("#monthlyPayrollPrintGridID").jqxGrid("getrows");
        var selectedrows=$("#monthlyPayrollPrintGridID").jqxGrid('selectedrowindexes');
        selectedrows = selectedrows.sort(function(a,b){return a - b});
        
        var i=0;j=0;k=0;tempemps="";
        for (i = 0; i < rows.length; i++) {
                if(selectedrows[j]==i){
                   if(k==0){
                     tempemps=rows[i].employeedocno;
                     k=1;
                   } else{
                    tempemps=tempemps+","+rows[i].employeedocno;
                 }
               j++; 
            }
         }
        
         $('#txtselectedemployees').val(tempemps);
        
         if($("#hidchckpayslip").val()=="0") {
            
             var url=document.URL;
             var reurl=url.split("monthlypayroll");
            
             $("#docno").prop("disabled", false);
            
                   $.messager.confirm('Confirm', 'Do you want to have header?', function(r){
                    if (r){
                         var win= window.open(reurl[0]+"monthlypayroll/printMonthlyPayroll?docno="+$("#docno").val()+"&branch="+document.getElementById("brchName").value+"&header=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
                         win.focus();
                     }
                    else{
                        var win= window.open(reurl[0]+"monthlypayroll/printMonthlyPayroll?docno="+$("#docno").val()+"&branch="+document.getElementById("brchName").value+"&header=0","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
                        win.focus();
                    }
                   });
                   
          } else if($("#hidchckpayslip").val()=="1") {
               if(selectedrows.length==0){
                    $("#overlay, #PleaseWait").hide();
                    $.messager.alert('Warning','Select Employee(s) to be Printed.');
                    return false;
                }
               
                var url=document.URL;
                var reurl=url.split("monthlypayroll");
                
                var win= window.open(reurl[0]+"monthlypayroll/printPaySlipViewer?employeedocno="+$("#txtselectedemployees").val()+"&branch="+document.getElementById("brchName").value+"&date="+document.getElementById("payrollPrintDate").value+"&allowancecount="+document.getElementById("txtallowancetypecount").value+"&docno="+document.getElementById("docno").value,"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
                win.focus();
                
          }
         }
        }
    
</script>
</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmMonthlyPayroll" action="saveMonthlyPayroll" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include>

<div class='modern-ui hidden-scrollbar'>
    <div id="errormsg"></div>

    <div style="display:flex; gap:15px;">
        
        <!-- Left Column: Process & Print Setup -->
        <div style="flex: 0 0 25%; display:flex; flex-direction:column; gap:10px;">
            
            <!-- Process Panel -->
            <div class="middle-panel" style="margin-bottom:0;">
                <span class="middle-panel-title">
                    <label style="cursor:pointer; display:flex; align-items:center; gap:5px;">
                        <input type="checkbox" id="chckpayrollprocess" name="chckpayrollprocess" class="chckpayrollprocessprint" onclick="funCheckPayrollProcess();"> Process
                    </label>
                    <input type="hidden" id="hidchckpayrollprocess" name="hidchckpayrollprocess" value='<s:property value="hidchckpayrollprocess"/>'/>
                </span>
                
                <div class="bounce" style="text-align:center; font-weight:bold; margin-bottom:4px; font-size:11px;">
                    <label id="lblcurrentstatus" name="lblcurrentstatus"><s:property value="lblcurrentstatus"/></label>
                </div>
                
                <div class="field-row">
                    <label class="lbl-right" style="width:70px;">Date</label>
                    <div style="flex:1; margin-left:8px;">
                        <div id="payrollDate" name="payrollDate" value='<s:property value="payrollDate"/>'></div>
                    </div>
                    <input type="hidden" id="hidpayrollDate" name="hidpayrollDate" value='<s:property value="hidpayrollDate"/>'/>
                </div>
                
                <div class="field-row">
                    <label class="lbl-right" style="width:70px;">Category</label>
                    <select id="cmbempcategory" name="cmbempcategory" style="flex:1; margin-left:8px;" value='<s:property value="cmbempcategory"/>'>
                        <option value="">--Select--</option>
                    </select>
                    <input type="hidden" id="hidcmbempcategory" name="hidcmbempcategory" value='<s:property value="hidcmbempcategory"/>'/>
                </div>
                
                <div class="field-row">
                    <label class="lbl-right" style="width:70px;">Employee</label>
                    <div class="input-search-container" style="flex:1; margin-left:8px;">
                        <input type="text" id="txtemployeeid" name="txtemployeeid" placeholder="Press F3" value='<s:property value="txtemployeeid"/>' onkeydown="getEmployeeId(event);"/>
                        <svg class="magnifier-icon" onclick="$('#txtemployeeid').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                    </div>
                    <input type="hidden" id="txtemployeedocno" name="txtemployeedocno" value='<s:property value="txtemployeedocno"/>'/>
                </div>
                
                <div class="field-row">
                    <label class="lbl-right" style="width:70px;"></label>
                    <input type="text" id="txtemployeename" name="txtemployeename" placeholder="Employee Name" style="flex:1; margin-left:8px;" tabindex="-1" value='<s:property value="txtemployeename"/>'/>
                </div>
                
                <div class="flex-btn-container" style="margin-top:8px;">
                    <input type="button" class="myButton" name="clear" id="clear" value="Clear" onclick="funClearInfo();">
                    <input type="button" class="myProcessCalcButton" id="btnProcess" name="btnProcess" value="Process & Calc" onclick="funProcessGrid();">
                </div>
                
                <div class="flex-btn-container" style="margin-top:8px;">
                    <input type="button" class="mySaveButton" id="btnSavePayRoll" name="btnSavePayRoll" value="Save" onclick="funSaveGrid();">
                    <input type="button" class="myConfirmButton" id="btnConfirmed" name="btnConfirmed" value="Confirm" onclick="funConfirm();">
                </div>
            </div>
            
            <!-- Print Panel -->
            <div class="middle-panel" style="margin-bottom:0;">
                <span class="middle-panel-title">
                    <label style="cursor:pointer; display:flex; align-items:center; gap:5px;">
                        <input type="checkbox" id="chckpayrollprint" name="chckpayrollprint" class="chckpayrollprocessprint" onclick="funCheckPayrollPrint();"> Print
                    </label>
                    <input type="hidden" id="hidchckpayrollprint" name="hidchckpayrollprint" value='<s:property value="hidchckpayrollprint"/>'/>
                </span>
                
                <div class="field-row" style="margin-top:10px;">
                    <label class="lbl-right" style="width:70px;">Date</label>
                    <div style="flex:1; margin-left:8px;">
                        <div id="payrollPrintDate" name="payrollPrintDate" onchange="payrollprintdatechange();" value='<s:property value="payrollPrintDate"/>'></div>
                    </div>
                    <input type="hidden" id="hidpayrollPrintDate" name="hidpayrollPrintDate" value='<s:property value="hidpayrollPrintDate"/>'/>
                </div>
                
                <div class="field-row">
                    <label class="lbl-right" style="width:70px;">Category</label>
                    <select id="cmbempprintcategory" name="cmbempprintcategory" style="flex:1; margin-left:8px;" value='<s:property value="cmbempprintcategory"/>'>
                        <option value="">--Select--</option>
                    </select>
                    <input type="hidden" id="hidcmbempprintcategory" name="hidcmbempprintcategory" value='<s:property value="hidcmbempprintcategory"/>'/>
                </div>
                
                <div class="field-row">
                    <label class="lbl-right" style="width:70px;">Employee</label>
                    <div class="input-search-container" style="flex:1; margin-left:8px;">
                        <input type="text" id="txtprintemployeeid" name="txtprintemployeeid" placeholder="Press F3" value='<s:property value="txtprintemployeeid"/>' onkeydown="getEmployeeId(event);"/>
                        <svg class="magnifier-icon" onclick="$('#txtprintemployeeid').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                    </div>
                    <input type="hidden" id="txtprintemployeedocno" name="txtprintemployeedocno" value='<s:property value="txtprintemployeedocno"/>'/>
                </div>
                
                <div class="field-row">
                    <label class="lbl-right" style="width:70px;"></label>
                    <input type="text" id="txtprintemployeename" name="txtprintemployeename" placeholder="Employee Name" style="flex:1; margin-left:8px;" tabindex="-1" value='<s:property value="txtprintemployeename"/>'/>
                </div>
                
                <div class="field-row" style="justify-content:center;">
                    <label style="display:flex; align-items:center; gap:5px; font-size:12px; font-weight:bold; color:#444; cursor:pointer;">
                        <input type="checkbox" id="chckpayslip" name="chckpayslip" onclick="funCheckPaySlip();"> Pay Slip
                    </label>
                    <input type="hidden" id="hidchckpayslip" name="hidchckpayslip" value='<s:property value="hidchckpayslip"/>'/>
                </div>
                
                <div class="flex-btn-container" style="flex-wrap:wrap; margin-top:8px;">
                    <input type="button" class="myButton" name="clearPrint" id="clearPrint" value="Clear" onclick="funClearPrintInfo();">
                    <input type="button" class="myProcessCalcButton" id="btnView" name="btnView" value="View" onclick="funLoadPrintGrid();">
                    <input type="button" class="myProcessCalcButton" id="btnPayrollPrint" name="btnPayrollPrint" value="Print" onclick="funPayrollPrint();">
                </div>
            </div>
            
        </div>
        
        <!-- Right Column: Grids -->
        <div style="flex: 1;">
            <div id="payrollDiv">
                <jsp:include page="monthlyPayrollGrid.jsp"></jsp:include>
            </div>
            <div id="payrollPrintDiv" hidden="true">
                <jsp:include page="monthlyPayrollPrintGrid.jsp"></jsp:include>
            </div>
        </div>
        
    </div>

    <!-- Hidden Fields -->
    <div style="display:none;">
        <input type="hidden" id="mode" name="mode"/>
        <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
        <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
        <input type="hidden" id="docno" name="txtmonthlypayrolldocno" value='<s:property value="txtmonthlypayrolldocno"/>'/>
        <input type="hidden" id="txtselectedemployees" name="txtselectedemployees" value='<s:property value="txtselectedemployees"/>'/>
        <input type="hidden" id="txtvalidation" name="txtvalidation" value='<s:property value="txtvalidation"/>'/>
        <input type="hidden" id="txtleavetype1" name="txtleavetype1" value='<s:property value="txtleavetype1"/>'/>
        <input type="hidden" id="txtleavetype2" name="txtleavetype2" value='<s:property value="txtleavetype2"/>'/>
        <input type="hidden" id="txtleavetype3" name="txtleavetype3" value='<s:property value="txtleavetype3"/>'/>
        <input type="hidden" id="txtleavetype4" name="txtleavetype4" value='<s:property value="txtleavetype4"/>'/>
        <input type="hidden" id="txtleavetype5" name="txtleavetype5" value='<s:property value="txtleavetype5"/>'/>
        <input type="hidden" id="txtleavetype6" name="txtleavetype6" value='<s:property value="txtleavetype6"/>'/>
        <input type="hidden" id="txtleavetype7" name="txtleavetype7" value='<s:property value="txtleavetype7"/>'/>
        <input type="hidden" id="txtleavetype8" name="txtleavetype8" value='<s:property value="txtleavetype8"/>'/>
        <input type="hidden" id="txtleavetype9" name="txtleavetype9" value='<s:property value="txtleavetype9"/>'/>
        <input type="hidden" id="txtleavetype10" name="txtleavetype10" value='<s:property value="txtleavetype10"/>'/>
        <input type="hidden" id="txtleavetypecount" name="txtleavetypecount" value='<s:property value="txtleavetypecount"/>'/>
        <input type="hidden" id="txtallowancetype1" name="txtallowancetype1" value='<s:property value="txtallowancetype1"/>'/>
        <input type="hidden" id="txtallowancetype2" name="txtallowancetype2" value='<s:property value="txtallowancetype2"/>'/>
        <input type="hidden" id="txtallowancetype3" name="txtallowancetype3" value='<s:property value="txtallowancetype3"/>'/>
        <input type="hidden" id="txtallowancetype4" name="txtallowancetype4" value='<s:property value="txtallowancetype4"/>'/>
        <input type="hidden" id="txtallowancetype5" name="txtallowancetype5" value='<s:property value="txtallowancetype5"/>'/>
        <input type="hidden" id="txtallowancetype6" name="txtallowancetype6" value='<s:property value="txtallowancetype6"/>'/>
        <input type="hidden" id="txtallowancetype7" name="txtallowancetype7" value='<s:property value="txtallowancetype7"/>'/>
        <input type="hidden" id="txtallowancetype8" name="txtallowancetype8" value='<s:property value="txtallowancetype8"/>'/>
        <input type="hidden" id="txtallowancetype9" name="txtallowancetype9" value='<s:property value="txtallowancetype9"/>'/>
        <input type="hidden" id="txtallowancetype10" name="txtallowancetype10" value='<s:property value="txtallowancetype10"/>'/>
        <input type="hidden" id="txtallowancetypecount" name="txtallowancetypecount" value='<s:property value="txtallowancetypecount"/>'/>
        <input type="hidden" id="txtchkgridload" name="txtchkgridload" value='<s:property value="txtchkgridload"/>'/>
        <input type="hidden" id="txtpayrollalreadyprocessed" name="txtpayrollalreadyprocessed" value='<s:property value="txtpayrollalreadyprocessed"/>'/>
        <input type="hidden" id="gridlength" name="gridlength"/>
    </div>
</div>
</form>

<div id="employeeDetailsWindow">
   <div></div><div></div>
</div>
</div>
</body>
</html>