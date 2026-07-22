<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>

<!DOCTYPE html>
<html>
<head>
<s:head/>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>
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
.modern-ui input[type="email"],
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
.modern-ui input[type="email"]:focus,
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
    border: 1px solid #e2e8f0; 
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

.style1 {
    color: #FF0000;
    font-weight: bold;
}
</style>

<script type="text/javascript">
    $(document).ready(function () {
        getBranchLimit();  
        
        // Date Pickers initialized to match 24px height
        $("#branchaccdate1").jqxDateTimeInput({ width: '100%', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'}); 
        $("#branchaccdate2").jqxDateTimeInput({ width: '100%', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
         
        /* force internal alignment AFTER render */
        setTimeout(function () {
             $("#branchaccdate1, #branchaccdate2").find("input").css({
                 "margin-top": "0px",
                 "line-height": "24px",
                 "font-size": "12px", 
                 "font-family": "Arial, sans-serif", 
                 "padding": "0 6px", 
                 "box-sizing":"border-box"
             });
             $("#branchaccdate1, #branchaccdate2").find(".jqx-action-button").css({
                 "top": "0px",
                 "height": "24px"
             });
        }, 0);
          
         document.getElementById("datediv").style.display="none";
         document.getElementById("formdet").innerText="Branch(BRH)";
         document.getElementById("formdetail").value="Branch";
         document.getElementById("formdetailcode").value="BRH";
         window.parent.formCode.value="BRH"; 
         window.parent.formName.value="Branch";
     });
     
    function funSearchLoad(){
        changeContent('branchSearch.jsp', $('#window')); 
     }
     
    function funReadOnly(){
        $('#frmBranch input').attr('readonly', true );
        $('#frmBranch select').attr('disabled', true );
        $('#branchaccdate1').jqxDateTimeInput({ disabled: true});
        $('#branchaccdate2').jqxDateTimeInput({ disabled: true});
    }
    
    function funRemoveReadOnly(){
        $('#frmBranch input').attr('readonly', false );
        $('#frmBranch select').attr('disabled', false );
        $('#branchaccdate1').jqxDateTimeInput({ disabled: false});
        $('#branchaccdate2').jqxDateTimeInput({ disabled: false});
    }
    
    function getCurrency(){
        var x=new XMLHttpRequest();
        x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200) {
                items= x.responseText;
                items=items.split('***');
                var currItems=items[0].split(",");
                var curridItems=items[1].split(",");
                    var optionscurr = '<option value="">--Select--</option>';
                for ( var i = 0; i < currItems.length; i++) {
                   optionscurr += '<option value="' + curridItems[i] + '">' + currItems[i] + '</option>';
                }
                 $("select#cmbbranchcurr").html(optionscurr);
             $('#cmbbranchcurr').val($('#hidcmbbranchcurr').val()) ;
            }
         }
          x.open("GET","getCurrency.jsp",true);
         x.send();
        
       }
       
    function getCompany() {
        var x=new XMLHttpRequest();
        x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200) {
                items= x.responseText;
                items=items.split('***');
                 var compidItems=items[1].split(",");
                var compItems=items[0].split(",");
                 var optionscomp = '<option value="">--Select--</option>';
                for ( var i = 0; i < compItems.length; i++) {
                   optionscomp += '<option value="' + compidItems[i] + '">' + compItems[i] + '</option>';
                }
                 $("select#cmbcompname").html(optionscomp);
             $('#cmbbranchcurr').val($('#hidcmbbranchcurr').val()) ;
             $('#cmbcompname').val($('#hidcmbcompname').val()) ;
            }
         }
          x.open("GET","getCompany.jsp",true);
         x.send();  
    }

     function getBranchLimit() {
        var x=new XMLHttpRequest();
        x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200) {
                items= x.responseText;
                items=items.split('***');
                 var brLimit=items[0];
                 if(brLimit>10){
                    $("#btnCreate").attr('disabled', true );
                    document.getElementById("errormsg").innerText="Branch Count Exceeds Limit,Contact Administrator!!!";
                 }
            }
         }
          x.open("GET","getBrlimit.jsp",true);
         x.send();  
    }

    function verify(){
         //alert($('#chqfollowhr').val());
    }
    
    function setValues(){   
     if($('#msg').val()!=""){
           $.messager.alert('Message',$('#msg').val());
          }
    }
    
    function checkBranchid(value){
        var x=new XMLHttpRequest();
        x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200) {
                var items=x.responseText;
                if(items.trim()!='undefine'){
                    document.getElementById("txtbranchid").focus();
                    document.getElementById("errormsg").innerText="Branch ID Already Exists";
                }
                else{
                    document.getElementById("errormsg").innerText="";
                }
            }
         }
          x.open("GET","checkBranchid.jsp?code="+value+"&doc="+document.getElementById("docno").value,true);
         x.send();
    }
    
    function funFocus(){
        document.getElementById("cmbcompname").focus();
    }
   
    $(function(){
        $('#frmBranch').validate({
                 rules: {
                 txtbranchid: {
                     required:true,
                     maxlength:5
                 },
                txtbranchname:"required",
                cmbcompname:"required",
                cmbbranchcurr:"required"
                 },
                 messages: {
                  txtbranchid:{
                      required:" *",
                      maxlength:'max 5 chars'
                  },
                  txtbranchname:" *",
                  cmbcompname:" *",
                  cmbbranchcurr:" *"
                 }
        });});
        
     function funNotify(){
         var date1 = $('#branchaccdate1').jqxDateTimeInput('getDate');
        var date2 = $('#branchaccdate2').jqxDateTimeInput('getDate');
    
            if(date1>date2){
                document.getElementById("errormsg").innerText="";
                document.getElementById("errormsg").innerText="Accounting To Date Cannot be less than From Date";
                $('#branchaccdate1').jqxDateTimeInput('focus');
                return 0;
            }   
            document.getElementById("errormsg").innerText="";
            return 1;
    } 
</script>
</head>
<body onLoad="getCurrency();getCompany();setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmBranch" action="saveActionBranch" autocomplete="off">
    <jsp:include page="../../../../header.jsp" />
    
<div class='modern-ui hidden-scrollbar'>
    <div id="errormsg"></div>

    <div class="middle-panel">
        <span class="middle-panel-title">Branch Info</span>
        
        <div class="field-row">
            <label class="lbl-right" style="width:120px;">Company</label>
            <select name="cmbcompname" id="cmbcompname" value='<s:property value="cmbcompname"/>' style="flex:1;">
                <option></option>
            </select>
            <input type="hidden" name="hidcmbcompname" id="hidcmbcompname" value='<s:property value="hidcmbcompname"/>'>
        </div>

        <div class="field-row">
            <label class="lbl-right" style="width:120px;">Branch</label>
            <input type="text" id="txtbranchid" name="txtbranchid" style="width:100px;" value='<s:property value="txtbranchid"/>' onblur="checkBranchid(this.value);">
            
            <label class="lbl-right" style="width:60px; margin-left:15px;">Name</label>
            <input type="text" id="txtbranchname" name="txtbranchname" value='<s:property value="txtbranchname"/>' style="flex:1;">
        </div>

        <div class="field-row">
            <label class="lbl-right" style="width:120px;">Address</label>
            <input type="text" id="txtaddress" name="txtaddress" style="flex:1;" value='<s:property value="txtaddress"/>'/>
        </div>

        <div class="field-row">
            <label class="lbl-right" style="width:120px;">P.B.No</label>
            <input type="text" id="txtpbno" name="txtpbno" style="width:200px;" value='<s:property value="txtpbno"/>'>
        </div>

        <div class="field-row">
            <label class="lbl-right" style="width:120px;">Tel</label>
            <input type="text" id="txttel1" name="txttel1" style="width:200px;" value='<s:property value="txttel1"/>'>
            
            <label class="lbl-right" style="width:60px; margin-left:15px;">Tel</label>
            <input type="text" id="txttel2" name="txttel2" style="width:200px;" value='<s:property value="txttel2"/>'>
        </div>

        <div class="field-row">
            <label class="lbl-right" style="width:120px;">Fax</label>
            <input type="text" id="txtfax1"  name="txtfax1" style="width:200px;" value='<s:property value="txtfax1"/>'>
            
            <label class="lbl-right" style="width:60px; margin-left:15px;">Fax</label>
            <input type="text" id="txtfax2" name="txtfax2" style="width:200px;" value='<s:property value="txtfax2"/>'>
        </div>

        <div class="field-row">
            <label class="lbl-right" style="width:120px;">Email</label>
            <input type="email" id="txtemail1" name="txtemail1" style="width:300px;" value='<s:property value="txtemail1"/>'>
        </div>

        <div class="field-row">
            <label class="lbl-right" style="width:120px;">Website</label>
            <input type="text"  id="txtwebsite" name="txtwebsite" style="width:300px;" value='<s:property value="txtwebsite"/>'>
        </div>
        
        <div class="field-row">
            <label class="lbl-right" style="width:120px;">Tin No.</label>
            <input type="text"  id="txttinno" name="txttinno" style="width:200px;" value='<s:property value="txttinno"/>'>
            
            <label class="lbl-right" style="width:80px; margin-left:15px;">STC No.</label>
            <input type="text"  id="txtstcno" name="txtstcno" style="width:200px;" value='<s:property value="txtstcno"/>'>
        </div>
        
        <div class="field-row">
            <label class="lbl-right" style="width:120px;">CST No</label>
            <input type="text"  id="txtcstno" name="txtcstno" style="width:200px;" value='<s:property value="txtcstno"/>'>
            
            <label style="display:flex; align-items:center; gap:5px; margin-left:15px; font-size:12px; font-weight:bold; color:#444; cursor:pointer;">
                <input type="checkbox" id="chckfollowhr" name="chckfollowhr" onChange="verify();" value='<s:property value="chckfollowhr"/>'/>
                Follows Company HR Calendar
            </label>
        </div>
        
        <div class="field-row" style="margin-bottom:0;">
            <label class="lbl-right" style="width:120px;">Account Period</label>
            <div style="width:125px;">
                <div id="branchaccdate1" name="branchaccdate1" value='<s:property value="branchaccdate1"/>'></div>
            </div>
            <input type="hidden" id="hidbranchaccdate1" name="hidbranchaccdate1" value='<s:property value="hidbranchaccdate1"/>'/>
            
            <label class="lbl-right" style="width:30px; margin-left:8px;">To</label>
            <div style="width:125px;">
                <div id="branchaccdate2" name="branchaccdate2" value='<s:property value="branchaccdate2"/>'></div>
            </div>
            <input type="hidden" id="hidbranchaccdate2" name="hidbranchaccdate2" value='<s:property value="hidbranchaccdate2"/>'/>
            
            <label class="lbl-right" style="width:80px; margin-left:15px;">Currency</label>
            <select id="cmbbranchcurr" name="cmbbranchcurr" value='<s:property value="cmbbranchcurr"/>' style="width:120px;">
                <option></option>
            </select>
            <input type="hidden" id="hidcmbbranchcurr" name="hidcmbbranchcurr" value='<s:property value="hidcmbbranchcurr"/>'/>
        </div>
    </div>
    
    <div class="style1" id="datediv" style="margin-left: 130px; margin-top: 5px;">
        Please select a valid Date
    </div>

    <!-- Hidden Fields Map -->
    <div style="display:none;">
        <input type="hidden" id="docno" name="docno" value='<s:property value="docno"/>'>
        <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
        <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'>
        <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>
    </div>
</div>

</form>
</div>                                  
</body>
</html>