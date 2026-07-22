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
<script type="text/javascript" src="<%=contextPath%>/js/ajaxfileupload.js"></script> 

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
    margin-bottom: 8px; 
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
         document.getElementById("formdet").innerText="Location(LOC)";
         document.getElementById("formdetail").value="Location";
         document.getElementById("formdetailcode").value="LOC";
         window.parent.formCode.value="LOC";
         window.parent.formName.value="Location";
      });
      
        function funReadOnly(){
           $('#frmLocation input').attr('readonly', true );
           $('#frmLocation select').attr('disabled', true );
        }
        function funRemoveReadOnly(){
           $('#frmLocation input').attr('readonly', false );
           $('#frmLocation select').attr('disabled', false );
        }
      
        function funSearchLoad(){
            changeContent('locationSearch.jsp', $('#window')); 
         }
         
        function getBranch()
        {
            var x=new XMLHttpRequest();
            x.onreadystatechange=function(){
            if (x.readyState==4 && x.status==200)
                {
                    items= x.responseText;
                    items=items.split('***');
                     var branchidItems=items[1].split(",");
                    var branchItems=items[0].split(",");
                     var optionsbranch = '<option value="">--Select--</option>';
                    for ( var i = 0; i < branchItems.length; i++) {
                       optionsbranch += '<option value="' + branchidItems[i] + '">' + branchItems[i] + '</option>';
                    }
                    $("select#cmbbranchname").html(optionsbranch);
                    $('#cmbbranchname').val($('#hidcmbbranchname').val()) ;
                }
             }
              x.open("GET","getBranch.jsp",true);
             x.send();  
        }
        
        function setValues(){
             if($('#msg').val()!=""){
                   $.messager.alert('Message',$('#msg').val());
              }
        }
        
        function funFocus()
        {
            document.getElementById("cmbbranchname").focus();
        }
        
        $(function(){
            $('#frmLocation').validate({
                     rules: {
                   cmbbranchname: "required",
                    txtloccode:"required",
                    txtlocname:"required"
                     },
                     messages: {
                      cmbbranchname: " *",
                      txtloccode:" *",
                      txtlocname:" *"
                     }
            });});
            
         function funNotify(){
            return 1;
        }
        
         function checkLocCode(value){
             var x=new XMLHttpRequest();
                x.onreadystatechange=function(){
                if (x.readyState==4 && x.status==200)
                    {
                        var items=x.responseText;
                        if(items.trim()!='undefine'){
                            document.getElementById("txtloccode").focus();
                            document.getElementById("errormsg").innerText="Location ID Already Exists";
                        }
                        else{
                            document.getElementById("txtlocname").focus();
                            document.getElementById("errormsg").innerText="";
                        }
                    }
                 }
                  x.open("GET","checkLocCode.jsp?code="+value+"&doc="+document.getElementById("docno").value,true);
                 x.send();
         }
</script>
</head>
<body onload="getBranch();funReadOnly();setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmLocation" action="saveActionLocation" autocomplete="off" >

    <jsp:include page="../../../../header.jsp" />

<div class='modern-ui hidden-scrollbar'>
    <div id="errormsg"></div>

    <div class="middle-panel">
        <span class="middle-panel-title">Location Info</span>
        
        <div class="field-row">
            <label class="lbl-right" style="width:100px;">Branch</label>
            <select id="cmbbranchname" name="cmbbranchname" style="width:250px;" value='<s:property value="cmbbranchname"/>'>
                <option></option>
            </select>
        </div>

        <div class="field-row">
            <label class="lbl-right" style="width:100px;">Location Code</label>
            <input type="text" id="txtloccode" name="txtloccode" style="width:120px;" value='<s:property value="txtloccode"/>' onblur="checkLocCode(this.value);">
            
            <label class="lbl-right" style="width:60px; margin-left:15px;">Name</label>
            <input type="text" id="txtlocname" name="txtlocname" style="width:250px;" value='<s:property value="txtlocname"/>'>
        </div>

        <div class="field-row">
            <label class="lbl-right" style="width:100px;">Address</label>
            <input type="text" id="txtaddress" name="txtaddress" style="width:455px;" value='<s:property value="txtaddress"/>' />
        </div>

        <div class="field-row">
            <label class="lbl-right" style="width:100px;">P.B.No</label>
            <input type="text" id="txtpbno" name="txtpbno" style="width:120px;" value='<s:property value="txtpbno"/>'>
        </div>

        <div class="field-row">
            <label class="lbl-right" style="width:100px;">Tel 1</label>
            <input type="text" id="txttel1" name="txttel1" style="width:120px;" value='<s:property value="txttel1"/>'>
            
            <label class="lbl-right" style="width:60px; margin-left:15px;">Tel 2</label>
            <input type="text" id="txttel2" name="txttel2" style="width:120px;" value='<s:property value="txttel2"/>'>
        </div>

        <div class="field-row">
            <label class="lbl-right" style="width:100px;">Fax 1</label>
            <input type="text" id="txtfax1"  name="txtfax1" style="width:120px;" value='<s:property value="txtfax1"/>'>
            
            <label class="lbl-right" style="width:60px; margin-left:15px;">Fax 2</label>
            <input type="text" id="txtfax2" name="txtfax2" style="width:120px;" value='<s:property value="txtfax2"/>'>
        </div>

        <div class="field-row">
            <label class="lbl-right" style="width:100px;">Email</label>
            <input type="email" id="txtemail1" name="txtemail1" style="width:250px;" value='<s:property value="txtemail1"/>'>
        </div>

        <div class="field-row" style="margin-bottom:0;">
            <label class="lbl-right" style="width:100px;">Website</label>
            <input type="text"  id="txtwebsite" name="txtwebsite" style="width:250px;" value='<s:property value="txtwebsite"/>'>
        </div>
        
    </div>

    <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'>
    <input type="hidden" id="hidcmbbranchname" name="hidcmbbranchname" value='<s:property value="hidcmbbranchname"/>'>
    <input type="hidden" name="docno" id="docno" value='<s:property value="docno"/>'>
    <input type="text" name="deleted" id="deleted" value='<s:property value="deleted"/>' hidden="true"/>
    <input type="hidden" id="mode" name="mode"/>
</div>
</form>

</div>                                  
</body>
</html>