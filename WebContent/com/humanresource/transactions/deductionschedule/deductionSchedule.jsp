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
          /* Set jqxDateTimeInput to 24px height with modern UI theme */
          $("#deductionScheduleDate").jqxDateTimeInput({ width: '125px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
          $("#startDate").jqxDateTimeInput({ width: '125px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
          
          /* force internal alignment AFTER render */
          setTimeout(function () {
             $("#deductionScheduleDate, #startDate").find("input").css({
                 "margin-top": "0px",
                 "line-height": "24px",
                 "font-size": "12px", 
                 "font-family": "Arial, sans-serif", 
                 "padding": "0 6px", 
                 "box-sizing":"border-box"
             });
             $("#deductionScheduleDate, #startDate").find(".jqx-action-button").css({
                 "top": "0px",
                 "height": "24px"
             });
          }, 0);
          
          /* Searching Window */
         $('#employeeDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Employees Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
         $('#employeeDetailsWindow').jqxWindow('close');
        
         $('#txtemployeedetails').dblclick(function(){
            employeeSearchContent("employeeDetailsSearch.jsp");
          });
        
      }); 
      
      function employeeSearchContent(url) {
            $('#employeeDetailsWindow').jqxWindow('open');
            $.get(url).done(function (data) {
            $('#employeeDetailsWindow').jqxWindow('setContent', data);
            $('#employeeDetailsWindow').jqxWindow('bringToFront');
        }); 
        }
      
      function getEmployeeDetails(event){
          var x= event.keyCode;
          if(x==114){
              employeeSearchContent("employeeDetailsSearch.jsp");
          }
          else{}
          }
      
      function funInstAmount(){
         var amount=$('#txtamount').val();
         var instno=$('#txtinstnos').val();
        
        if(amount==""){ 
            document.getElementById("errormsg").innerText="Amount is Mandatory.";
             return 0;  
        }
        
         if(instno==""){ 
                document.getElementById("errormsg").innerText="Installment number is Mandatory.";
                 return 0;  
         }
        
        if(instno=="0"){ 
            document.getElementById("errormsg").innerText="Installment number is Invalid.";
             return 0;  
       }
        
        document.getElementById("errormsg").innerText="";
        
         if(!isNaN(amount)){
             var result = amount / instno;
             $('#txtinstamt').val(result);
             }
             else if(isNaN(amount)){
                 $('#txtinstamt').val(0.0);
             }
     }
      
      function deductionGridLoading(){
          var startdate = $('#startDate').jqxDateTimeInput('getText');
          var chngdate=startdate;
          var saldate = document.getElementById("hidsaldate").value;
          var amount = document.getElementById("txtamount").value;
          var instno = document.getElementById("txtinstnos").value;
          var instamt = document.getElementById("txtinstamt").value;
          
        var fromdate = chngdate.split('.');
        chngdate = new Date();
        var caldateyear=fromdate[2];
        var caldatemonth=fromdate[1];
        var caldateday=fromdate[0];
        var todate = saldate.split('.');
        saldate = new Date();
        var caltodateyear=todate[2];
        var caltodatemonth=todate[1];
        var caltodateday=todate[0];
        
        if(caldateyear==caltodateyear && caldatemonth==caltodatemonth && caldateday==caltodateday){
            $.messager.alert('Warning','Salary Processed,Please Choose Another Date ');
             return false;
        }
        else if(caldateyear<caltodateyear && caldatemonth==caltodatemonth && caldateday==caltodateday){
            $.messager.alert('Warning','Salary Processed,Please Choose Another Date ');
             return false;
        }
        else if(caldateyear==caltodateyear && caldatemonth<caltodatemonth && caldateday==caltodateday){
            $.messager.alert('Warning','Salary Processed,Please Choose Another Date ');
             return false;
        }
        else if(caldateyear==caltodateyear && caldatemonth==caltodatemonth && caldateday<caltodateday){
            $.messager.alert('Warning','Salary Processed,Please Choose Another Date ');
             return false;
        }
      else{
          $("#deductionScheduleDiv").load('deductionScheduleGrid.jsp?startdate='+startdate+'&amount='+amount+'&instno='+instno+'&instamt='+instamt);
          }
    }
      
      $(function(){
            $('#frmDeductionSchedule').validate({
                    rules: {
                        txtemployeedetails:"required",
                     },
                     messages: {
                         txtemployeedetails:" *",
                     }
            });});
    
     function funReadOnly(){
            $('#frmDeductionSchedule input').attr('readonly', true );
            $('#frmDeductionSchedule select').attr('disabled', true);
            $('#deductionScheduleDate').jqxDateTimeInput({disabled: true});
            $('#startDate').jqxDateTimeInput({disabled: true});
            $('#btnDistributionSubmit').attr('disabled', true);
            
            $("#deductionScheduleGridID").jqxGrid({ disabled: true});
     }
    
     function funRemoveReadOnly(){
            $('#frmDeductionSchedule input').attr('readonly', false );
            $('#frmDeductionSchedule select').attr('disabled', false);
            $('#deductionScheduleDate').jqxDateTimeInput({disabled: false});
            $('#startDate').jqxDateTimeInput({disabled: false});
            $('#txtemployeedetails').attr('readonly', true );
            $('#docno').attr('readonly', true);
            $('#btnDistributionSubmit').attr('disabled', false);
            
            $("#deductionScheduleGridID").jqxGrid({ disabled: false});
            
            if ($("#mode").val() == "A") {
                     $('#deductionScheduleDate').val(new Date());
                    
                     $("#deductionScheduleGridID").jqxGrid('clear'); 
                     $("#deductionScheduleGridID").jqxGrid('addrow', null, {});
            }
     }
    
     function funNotify(){  
         /* Deduction Schedule Grid  Saving*/
          var rows = $("#deductionScheduleGridID").jqxGrid('getrows');
          var length=0;
             for(var i=0 ; i < rows.length ; i++){
                var chk=rows[i].amount;
                if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){
                    length=length+1;
                        newTextBox = $(document.createElement("input"))
                        .attr("type", "hidden")
                        .attr("id", "test"+i)
                        .attr("name", "test"+i)
                        .attr("hidden", "true");
                    
                    newTextBox.val(rows[i].sr_no+"::"+rows[i].date+"::"+rows[i].amount+"::"+rows[i].posted+"::"+rows[i].rowno+"::"+rows[i].postedtrno);
                    newTextBox.appendTo('form');
                    }
                }
                 $('#gridlength').val(length);
                /*Deduction Schedule Grid  Saving Ends*/  
        
            return 1;       
        } 
    
     function funSearchLoad(){
             changeContent('dscMainSearch.jsp'); 
         }
    
     function funFocus(){
        $('#deductionScheduleDate').jqxDateTimeInput('focus');          
     }
    
     function setValues(){
        
             if($('#hiddeductionScheduleDate').val()){
                 $("#deductionScheduleDate").jqxDateTimeInput('val', $('#hiddeductionScheduleDate').val());
              }
            
             if($('#hidstartDate').val()){
                 $("#startDate").jqxDateTimeInput('val', $('#hidstartDate').val());
              }
            
             if($('#msg').val()!=""){
                   $.messager.alert('Message',$('#msg').val());
                  }
            
             document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
             funSetlabel();
            
             var indexVal = document.getElementById("docno").value;
             if(indexVal>0){
                 $("#deductionScheduleDiv").load("deductionScheduleGrid.jsp?docno="+indexVal);
             }
        }
    
     function funChkButton() {
            /* funReset(); */
        }
    
     function clearempl(){
         document.getElementById("txtemployeedetails").value="";
     }
    
</script>

</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmDeductionSchedule" action="saveDeductionSchedule" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include>

<div class='modern-ui hidden-scrollbar'>
    <div id="errormsg"></div>

    <div class="middle-panel" style="background: #fdfdfd;">
        <span class="middle-panel-title">Deduction Schedule Info</span>
        
        <div class="field-row">
            <label class="lbl-right" style="width:80px;">Date</label>
            <div style="width: 125px;">
                <div id="deductionScheduleDate" name="deductionScheduleDate" onchange="clearempl();" value='<s:property value="deductionScheduleDate"/>'></div>
            </div>
            <input type="hidden" id="hiddeductionScheduleDate" name="hiddeductionScheduleDate" value='<s:property value="hiddeductionScheduleDate"/>'/>
            
            <label class="lbl-right" style="width:80px; margin-left:auto;">Ref. No.</label>
            <input type="text" id="txtemployeerefno" name="txtemployeerefno" style="width:150px;" value='<s:property value="txtemployeerefno"/>'/>

            <label class="lbl-right" style="width:80px; margin-left:auto;">Doc No</label>
            <input type="text" id="docno" name="txtdeductionscheduledocno" style="width:150px;" tabindex="-1" value='<s:property value="txtdeductionscheduledocno"/>'/>
        </div>

        <div class="field-row" style="margin-bottom:0;">
            <label class="lbl-right" style="width:80px;">Employee</label>
            <div class="input-search-container" style="flex:1;">
                <input type="text" id="txtemployeedetails" name="txtemployeedetails" placeholder="Press F3" onkeydown="getEmployeeDetails(event);" value='<s:property value="txtemployeedetails"/>'/>
                <svg class="magnifier-icon" onclick="$('#txtemployeedetails').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
            </div>
            <input type="hidden" id="txtemployeedocno" name="txtemployeedocno" value='<s:property value="txtemployeedocno"/>'/>
        </div>
    </div>

    <div style="display:flex; gap:15px;">
        <!-- Setup Panel -->
        <div class="middle-panel" style="background: #fdfdfd; flex:0 0 35%;">
            <span class="middle-panel-title">Setup</span>
            
            <div class="field-row">
                <label class="lbl-right" style="width:80px;">Amount</label>
                <input type="text" id="txtamount" name="txtamount" style="width:100px; text-align:right;" onblur="funRoundAmt(this.value,this.id);funInstAmount();" value='<s:property value="txtamount"/>'/>
            </div>
            
            <div class="field-row">
                <label class="lbl-right" style="width:80px;">Inst. Nos</label>
                <input type="text" id="txtinstnos" name="txtinstnos" style="width:60px;" onblur="funInstAmount();" value='<s:property value="txtinstnos"/>'/>
                <input type="hidden" id="txtinstamt" name="txtinstamt" value='<s:property value="txtinstamt"/>'/>
                <input type="hidden" id="txtinstamttotal" name="txtinstamttotal" value='<s:property value="txtinstamttotal"/>'/>
            </div>
            
            <div class="field-row">
                <label class="lbl-right" style="width:80px;">Start Date</label>
                <div style="width: 125px;">
                    <div id="startDate" name="startDate" value='<s:property value="startDate"/>'></div>
                </div>
                <input type="hidden" id="hidstartDate" name="hidstartDate" value='<s:property value="hidstartDate"/>'/>
            </div>
            
            <div class="field-row">
                <label class="lbl-right" style="width:80px;">Description</label>
                <input type="text" id="txtdescription" name="txtdescription" style="flex:1;" value='<s:property value="txtdescription"/>'/>
            </div>

            <div class="field-row" style="justify-content:center; margin-top:20px; margin-bottom:0;">
                <button class="myButton" type="button" id="btnDistributionSubmit" name="btnDistributionSubmit" onclick="deductionGridLoading();">Submit</button>
            </div>
        </div>
        
        <!-- Schedule Grid Panel -->
        <div style="flex:1;">
            <div id="deductionScheduleDiv" style="margin-top:12px;">
                <jsp:include page="deductionScheduleGrid.jsp"></jsp:include>
            </div>
        </div>
    </div>

    <!-- Hidden Fields -->
    <div style="display:none;">
        <input type="hidden" id="mode" name="mode"/>
        <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
        <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
        <input type="hidden" id="txtvalidation" name="txtvalidation" value='<s:property value="txtvalidation"/>'/>
        <input type="hidden" id="gridlength" name="gridlength"/>
        <input type="hidden" id="hidsaldate" name="hidsaldate"/>
    </div>
</div>
</form>

<div id="employeeDetailsWindow">
   <div></div><div></div>
</div>

</div>
</body>
</html>