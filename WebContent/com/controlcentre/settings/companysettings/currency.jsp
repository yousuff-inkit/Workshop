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
    gap: 6px;
    margin-bottom: 8px; 
    flex-wrap: wrap;
    justify-content: flex-start; /* Ensures items stay close together */
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
       $(document).ready(function () {  
           document.getElementById("formdet").innerText="Currency(CUR)";
           document.getElementById("formdetail").value="Currency";
           document.getElementById("formdetailcode").value="CUR";
           window.parent.formCode.value="CUR";
           window.parent.formName.value="Currency";
        });
        
       function funSearchLoad(){
            changeContent('currencySearch.jsp', $('#window')); 
         }
         
       function funReset(){
           $('#frmCurrency')[0].reset(); 
        }
        
        function funReadOnly(){
           $('#frmCurrency input').attr('readonly', true );
        }
        
        function funRemoveReadOnly(){
           $('#frmCurrency input').attr('readonly', false );
           $('#docno').attr('readonly', true);
        }
        
        function funFocus()
        {
            document.getElementById("txtcode").focus();
        }
        
        $(function(){
            $('#frmCurrency').validate({
                         rules: {
                             txtcode: {
                                 required:true,
                                 maxlength:3
                             },
                            txtcodename:{
                                required:true,
                                maxlength:15
                            },
                                txtcountry:"required",
                                txtfraction:"required",
                                txtdecimal:{
                                required:true,
                                number:true
                                }
                            },
                             
                             messages: {
                              txtcode:{
                                  required:" *",
                                  maxlength:"Max 3 chars"
                              },
                              txtcodename:{
                                  required:" *",
                                  maxlength:"Max 15 chars"
                              },
                              txtcountry:" *",
                              txtfraction:" *",
                              txtdecimal:{
                                  required:" *",
                                  number:"Invalid Decimal"
                              }
                             }
            });});
            
        function funNotify(){
            return 1;
        }
        
        function setValues(){   
             if($('#msg').val()!=""){
                   $.messager.alert('Message',$('#msg').val());
              }
        }
        
        function checkCurrency(value){
            var x=new XMLHttpRequest();
            x.onreadystatechange=function(){
            if (x.readyState==4 && x.status==200)
                {
                    var items=x.responseText;
                    if(items.trim()!='undefine'){
                        document.getElementById("txtcode").focus();
                        document.getElementById("errormsg").innerText="Currency Code Already Exists";
                    }
                    else{
                        document.getElementById("errormsg").innerText="";
                    }
                }
             }
              x.open("GET","checkCurrency.jsp?code="+value+"&doc="+document.getElementById("docno").value,true);
             x.send();
        }
</script>
</head>
<body onLoad="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmCurrency" action="saveActionCurrency" autocomplete="off">
    <jsp:include page="../../../../header.jsp" />

<div class='modern-ui hidden-scrollbar'>
    <div id="errormsg"></div>

    <div class="middle-panel">
        <span class="middle-panel-title">Currency Details</span>
        
        <div class="field-row">
            <label class="lbl-right" style="width:100px;">Doc No</label>
            <input type="text" id="docno" name="docno" style="width:150px;" value='<s:property value="docno"/>' readonly="readonly" tabindex="-1"/>
        </div>

        <div class="field-row">
            <label class="lbl-right" style="width:100px;">Code</label>
            <input type="text" id="txtcode" name="txtcode" style="width:100px;" value='<s:property value="txtcode"/>' onblur="checkCurrency(this.value);"/>
            
            <label class="lbl-right" style="width:50px; margin-left:15px;">Name</label>
            <input type="text" id="txtcodename" name="txtcodename" style="width:250px;" value='<s:property value="txtcodename"/>' />
        </div>

        <div class="field-row">
            <label class="lbl-right" style="width:100px;">Country</label>
            <input type="text" id="txtcountry" name="txtcountry" style="width:300px;" value='<s:property value="txtcountry"/>' />
        </div>

        <div class="field-row">
            <label class="lbl-right" style="width:100px;">Fraction</label>
            <input type="text" id="txtfraction" name="txtfraction" style="width:200px;" value='<s:property value="txtfraction"/>' />
        </div>

        <div class="field-row" style="margin-bottom:0;">
            <label class="lbl-right" style="width:100px;">Price Decimals</label>
            <input type="text" id="txtdecimal" name="txtdecimal" style="width:100px;" value='<s:property value="txtdecimal"/>' />
        </div>
    </div>

    <!-- Hidden Fields Map -->
    <div style="display:none;">
        <input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'>
        <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'>
        <input type="hidden" id="mode" name="mode"/>
    </div>
</div>
</form>
</div>
</body>
</html>