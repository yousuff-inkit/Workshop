<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
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

.modern-ui input[type="checkbox"],
.modern-ui input[type="radio"] {
    width: 14px !important;
    height: 14px !important;
    margin: 0;
    cursor: pointer;
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
    display: inline-flex;
    align-items: center;
    justify-content: center;
    gap: 4px;
}
.modern-ui .myButton:hover { background: linear-gradient(135deg, #083a8a 0%, #1d4ed8 100%); }

.modern-ui .btn-remove {
    background: linear-gradient(135deg, #ef4444 0%, #dc2626 100%);
}
.modern-ui .btn-remove:hover {
    background: linear-gradient(135deg, #dc2626 0%, #b91c1c 100%);
}

.modern-ui .btn-update {
    background: linear-gradient(135deg, #ffab23 0%, #ffec64 100%);
    color: #333;
}
.modern-ui .btn-update:hover {
    background: linear-gradient(135deg, #e5991f 0%, #ffab23 100%);
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

/* Radio Button Group Styling */
.radio-group {
    display: flex;
    gap: 15px;
    align-items: center;
}
.radio-group label {
    display: flex;
    align-items: center;
    gap: 5px;
    font-size: 12px;
    font-weight: bold;
    color: #444;
    cursor: pointer;
}

</style>

<script type="text/javascript">
    $(document).ready(function(){
        
         $('#btnCreate').attr('disabled', true );$('#btnClose').attr('disabled', true );
         $('#btnEdit').attr('disabled', true );$('#btnDelete').attr('disabled', true );
         $('#btnSearch').attr('disabled', true );$('#btnExcel').attr('disabled', true );
         $('#btnPrint').attr('disabled', true );
         $('#btnHeaderUpdate').hide();
         $('#btnHeaderDelete').hide();
        
         $('#btnFooterUpdate').hide();
         $('#btnFooterDelete').hide();
        
         // Date Setup
         $("#jqxItacDate").jqxDateTimeInput({ width: '100%', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
        
         /* force internal alignment AFTER render */
         setTimeout(function () {
             $("#jqxItacDate").find("input").css({
                 "margin-top": "0px",
                 "line-height": "24px",
                 "font-size": "12px", 
                 "font-family": "Arial, sans-serif", 
                 "padding": "0 6px", 
                 "box-sizing":"border-box"
             });
             $("#jqxItacDate").find(".jqx-action-button").css({
                 "top": "0px",
                 "height": "24px"
             });
         }, 0);
        
         $('#dtypeDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: ' Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
         $('#dtypeDetailsWindow').jqxWindow('close');
        
         $('#txthdoctype').click(function(){
                document.getElementById("rheader").checked = true;
                document.getElementById("rfooter").checked = false; 
                $("#rheader").click();
         });
         
         $('#txtfdoctype').click(function(){
                document.getElementById("rheader").checked = false;
                document.getElementById("rfooter").checked = true;
                 $("#rfooter").click();
         });
        
         $('#txthdoctype').dblclick(function(){
             dtypeSearchContent('docTypeGrid.jsp?dtype=1');
         });
        
         $('#txtfdoctype').dblclick(function(){
             dtypeSearchContent('docTypeGrid.jsp?dtype=2');
         });
        
         $("#rheader").click(function() {
                $('#txtfdoctype').attr('disabled', true);
                $('#txthdoctype').attr('disabled', false);
                $('#txtfheaderdescription').attr('disabled', true);
                $("#txtfooterdescription").val('');$("#jqxFooter").jqxGrid({ disabled: true});$("#jqxHeader").jqxGrid({ disabled: false});
                $('#txtfooterdescription').attr('disabled', true);$('#btnFooterAdd').attr('disabled', true);$('#btnFooterUpdate').attr('disabled', true);
                $('#btnFooterDelete').attr('disabled', true);$('#txtheaderdescription').attr('disabled', false);$('#btnHeaderAdd').attr('disabled', false);
                $('#btnHeaderUpdate').attr('disabled', false);$('#btnHeaderDelete').attr('disabled', false);
                document.getElementById("rheader").checked = true;
                document.getElementById("rfooter").checked = false;
                
                $("#txtfdoctype").val('');
                $("#txtfheaderdescription").val('');
            });
        
         $("#rfooter").click(function() {
                $('#txthdoctype').attr('disabled', true);
                $('#txtfdoctype').attr('disabled', false);
                $('#txtfheaderdescription').attr('disabled', false);
                $("#txtheaderdescription").val('');$("#jqxHeader").jqxGrid({ disabled: true});$("#jqxFooter").jqxGrid({ disabled: false});
                $('#txtheaderdescription').attr('disabled', true);$('#btnHeaderAdd').attr('disabled', true);$('#btnHeaderUpdate').attr('disabled', true);
                $('#btnHeaderDelete').attr('disabled', true);$('#txtfooterdescription').attr('disabled', false);$('#btnFooterAdd').attr('disabled', false);
                $('#btnFooterUpdate').attr('disabled', false);$('#btnFooterDelete').attr('disabled', false);
                document.getElementById("rheader").checked = false;
                document.getElementById("rfooter").checked = true;
                $("#txthdoctype").val('');
            });
        
         $('#txtfheaderdescription').dblclick(function(){
                var dtype=$("#txtfdoctype").val();
             dtypeSearchContent('headerSearchGrid.jsp?dtype='+dtype);
         });
    });
    
    function dtypeSearchContent(url) {
        $('#dtypeDetailsWindow').jqxWindow('open');
        $.get(url).done(function (data) {
        $('#dtypeDetailsWindow').jqxWindow('setContent', data);
        $('#dtypeDetailsWindow').jqxWindow('bringToFront');
    }); 
    }
    
    function headercheck(){
        $("#hidrheader").val(1);$("#hidrfooter").val('0');$("#txtfooterdescription").val('');$("#jqxFooter").jqxGrid({ disabled: true});$("#jqxHeader").jqxGrid({ disabled: false});
        $('#txtfooterdescription').attr('disabled', true)    ;$('#btnFooterAdd').attr('disabled', true);$('#btnFooterUpdate').attr('disabled', true);
        $('#btnFooterDelete').attr('disabled', true);$('#txtheaderdescription').attr('disabled', false);$('#btnHeaderAdd').attr('disabled', false);
        $('#btnHeaderUpdate').attr('disabled', false);$('#btnHeaderDelete').attr('disabled', false);
        
        $("#txtfdoctype").val('');
        $("#txtfheaderdescription").val('');
    }
    
    function footercheck(){
        $("#hidrfooter").val(2);$("#hidrheader").val('0');$("#txtheaderdescription").val('');$("#jqxHeader").jqxGrid({ disabled: true});$("#jqxFooter").jqxGrid({ disabled: false});
        $('#txtheaderdescription').attr('disabled', true);$('#btnHeaderAdd').attr('disabled', true);$('#btnHeaderUpdate').attr('disabled', true);
        $('#btnHeaderDelete').attr('disabled', true);$('#txtfooterdescription').attr('disabled', false);$('#btnFooterAdd').attr('disabled', false);
        $('#btnFooterUpdate').attr('disabled', false);$('#btnFooterDelete').attr('disabled', false);
        $("#txthdoctype").val('');
    }
    
    function getDtype(event,dtype){
        var x= event.keyCode;
        if(x==114){
            dtypeSearchContent('docTypeGrid.jsp?dtype='+dtype);
        }
    }
    
    function getHdtype(event){
        var dtype=$("#txtfdoctype").val();
        var x= event.keyCode;
        if(x==114){
            dtypeSearchContent('headerSearchGrid.jsp?dtype='+dtype);
        }
    }
    
    function funReadOnly(){}
    
     function funRemoveReadOnly(){
            if ($("#mode").val() == "A") {
                $("#jqxHeader").jqxGrid('clear'); 
                $("#jqxHeader").jqxGrid('addrow', null, {});
                $("#jqxFooter").jqxGrid('clear');
                $("#jqxFooter").jqxGrid('addrow', null, {});
            }
     }
    
     function funSearchLoad(){}
        
     function funChkButton() {}
    
     function funFocus(){
        $('#jqxItacDate').jqxDateTimeInput('focus');            
     }
 
  function funNotify(){
         var rows = $("#jqxHeader").jqxGrid('getrows');
         var frows = $("#jqxFooter").jqxGrid('getrows');
        
           $('#headergridlen').val(rows.length);
           
          for(var i=0 ; i < rows.length ; i++){ 
              var mand=0;
              var priono=0;
              
           newTextBox = $(document.createElement("input"))
              .attr("type", "hidden")
              .attr("id", "hdrs"+i)
              .attr("name", "hdrs"+i);
           
           if (rows[i].mand == true) {
               mand=1;
            }
            priono=rows[i].priono;
            
           if((priono=="" || typeof(priono)=="undefined" || typeof(priono)=="NaN"))
              {
               priono=i+1;
              }
           
          newTextBox.val(rows[i].header+" :: "+rows[i].voc_no+" :: "+mand+" :: "+priono);
          newTextBox.appendTo('form');
          }
          
          $('#footergridlen').val(frows.length);
         
          for(var i=0 ; i < frows.length ; i++){ 
              var mand=0;
              var priono=0;
              
           newTextBox = $(document.createElement("input"))
              .attr("type", "hidden")
              .attr("id", "fdrs"+i)
              .attr("name", "fdrs"+i);
           
           if (frows[i].mand == true) {
               mand=1;
            }
           priono=frows[i].priono;
            
           if((priono=="" || typeof(priono)=="undefined" || typeof(priono)=="NaN"))
              {
               priono=i+1;
              }
            
          newTextBox.val(frows[i].footer+" :: "+mand+" :: "+priono);
          newTextBox.appendTo('form');
          }
          
         document.getElementById("errormsg").innerText="";      
         return 1;
    } 
  
  function setValues(){
      if($('#msg').val()!=""){
           $.messager.alert('Message',$('#msg').val());
          }
      
        document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
        funSetlabel();
         var headVal =0;
          headVal = $("#headergridlen").val();
         var indexVal = $("#indexval").val();
         
                 var hdtype = $("#txthdoctype").val();
            $("#headerGridDiv").load("headerGrid.jsp?dtype="+hdtype);
            
                 var fdtype = $("#txtfdoctype").val();
                 var fhdesc = $("#headerid").val();
                
            $("#footerGridDiv").load("footerGrid.jsp?dtype="+fdtype+"&fhdesc="+fhdesc);
            
       }
    
</script>

</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background" >
<form id="frmTermsNConditions" action="saveTermsNConditions" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include>

<div class='modern-ui hidden-scrollbar'>
    <div id="errormsg"></div>

    <div class="middle-panel" style="background: #fdfdfd; padding: 12px 10px;">
        <div class="field-row" style="margin-bottom:0;">
            <label class="lbl-right" style="width:80px;">Date</label>
            <div style="flex:1; max-width:125px;">
                <div id="jqxItacDate" name="jqxItacDate" value='<s:property value="jqxItacDate"/>'></div>
            </div>
            <input type="hidden" id="hidjqxItacDate" name="hidjqxItacDate" value='<s:property value="hidjqxItacDate"/>'/>
            
            <div class="radio-group" style="margin-left:auto;">
                <label>
                    <input type="radio" id="rheader" name="rcheck" value='<s:property value="0"/>' > Terms
                </label>
                <label>
                    <input type="radio" id="rfooter" name="rcheck" value='<s:property value="1"/>' > Description
                </label>
            </div>
            <input type="hidden" id="hidrheader" name="hidrheader" value='<s:property value="hidrheader"/>'/>
            <input type="hidden" id="hidrfooter" name="hidrfooter" value='<s:property value="hidrfooter"/>'/>
        </div>
    </div>

    <div style="display:flex; gap:15px;">
        
        <!-- Header (Terms) Section -->
        <div style="flex: 1;" id="headerdiv">
            <div class="middle-panel">
                <span class="middle-panel-title">Terms Configuration</span>
                
                <div class="field-row">
                    <label class="lbl-right" style="width:80px;">Doc. Type</label>
                    <div class="input-search-container" style="flex:1;">
                        <input type="text" id="txthdoctype" name="txthdoctype" readonly="readonly" placeholder="Press F3" onkeydown="getDtype(event,1);" value='<s:property value="txthdoctype"/>'/>
                        <svg class="magnifier-icon" onclick="$('#txthdoctype').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                    </div>
                </div>
                
                <div class="field-row" style="margin-top:12px; margin-bottom:12px; justify-content:center;">
                    <button class="myButton" type="button" id="btnHeaderAdd" name="btnHeaderAdd" onclick="$('#mode').val('A');$('#btnSave').mousedown();">
                        <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="12" y1="5" x2="12" y2="19"></line><line x1="5" y1="12" x2="19" y2="12"></line></svg> Add
                    </button>
                    <button class="myButton btn-update" type="button" id="btnHeaderUpdate" name="btnHeaderUpdate" onclick="$('#mode').val('E');$('#btnSave').mousedown();">
                        <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="1 4 1 10 7 10"></polyline><polyline points="23 20 23 14 17 14"></polyline><path d="M20.49 9A9 9 0 0 0 5.64 5.64L1 10m22 4l-4.64 4.36A9 9 0 0 1 3.51 15"></path></svg> Update
                    </button>
                    <button class="myButton btn-remove" type="button" id="btnHeaderDelete" name="btnHeaderDelete" onclick="$('#btnDelete').mousedown();">
                        <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="18" y1="6" x2="6" y2="18"></line><line x1="6" y1="6" x2="18" y2="18"></line></svg> Delete
                    </button>
                </div>
                
                <div id="headerGridDiv">
                    <jsp:include page="headerGrid.jsp"></jsp:include>
                </div>
            </div>
        </div>
        
        <!-- Footer (Description) Section -->
        <div style="flex: 1;" id="footerdiv">
            <div class="middle-panel">
                <span class="middle-panel-title">Description Configuration</span>
                
                <div class="field-row">
                    <label class="lbl-right" style="width:80px;">Doc. Type</label>
                    <div class="input-search-container" style="flex:1;">
                        <input type="text" id="txtfdoctype" name="txtfdoctype" readonly="readonly" placeholder="Press F3" onkeydown="getDtype(event,2);" value='<s:property value="txtfdoctype"/>'/>
                        <svg class="magnifier-icon" onclick="$('#txtfdoctype').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                    </div>
                    
                    <label class="lbl-right" style="width:50px; margin-left:15px;">Terms</label>
                    <div class="input-search-container" style="flex:1.5;">
                        <input type="text" id="txtfheaderdescription" readonly="readonly" name="txtfheaderdescription" placeholder="Press F3" onkeydown="getHdtype(event);" value='<s:property value="txtfheaderdescription"/>'/>
                        <svg class="magnifier-icon" onclick="$('#txtfheaderdescription').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                    </div>
                </div>
                
                <input type="hidden" id="txtfooterdescription" name="txtfooterdescription" value='<s:property value="txtfooterdescription"/>'/>
                
                <div class="field-row" style="margin-top:12px; margin-bottom:12px; justify-content:center;">
                    <button class="myButton" type="button" id="btnFooterAdd" name="btnFooterAdd" onclick="$('#mode').val('A');$('#btnSave').mousedown();">
                        <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="12" y1="5" x2="12" y2="19"></line><line x1="5" y1="12" x2="19" y2="12"></line></svg> Add
                    </button>
                    <button class="myButton btn-update" type="button" id="btnFooterUpdate" name="btnFooterUpdate" onclick="$('#mode').val('E');$('#btnSave').mousedown();">
                        <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="1 4 1 10 7 10"></polyline><polyline points="23 20 23 14 17 14"></polyline><path d="M20.49 9A9 9 0 0 0 5.64 5.64L1 10m22 4l-4.64 4.36A9 9 0 0 1 3.51 15"></path></svg> Update
                    </button>
                    <button class="myButton btn-remove" type="button" id="btnFooterDelete" name="btnFooterDelete" onclick="$('#btnDelete').mousedown();">
                        <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="18" y1="6" x2="6" y2="18"></line><line x1="6" y1="6" x2="18" y2="18"></line></svg> Delete
                    </button>
                </div>
                
                <div id="footerGridDiv">
                    <jsp:include page="footerGrid.jsp"></jsp:include>
                </div>
            </div>
            
            <input type="hidden" id="docno" name="txthidtermsnconditiondocno" value='<s:property value="txthidtermsnconditiondocno"/>'/>
        </div>
        
    </div>
</div>

<!-- Hidden Fields Map -->
<div style="display:none;">
    <input type="hidden" id="headerid" name="headerid"  value='<s:property value="headerid"/>'/>
    <input type="hidden" id="indexval" name="indexval"  value='<s:property value="indexval"/>'/>
    <input type="hidden" id="headergridlen" name="headergridlen"  value='<s:property value="headergridlen"/>'/>
    <input type="hidden" id="footergridlen" name="footergridlen"  value='<s:property value="footergridlen"/>'/>
    <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>       
    <input type="hidden" id="deleted" name="deleted"  value='<s:property value="deleted"/>'/>
    <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>' />
</div>

</form>
</div>
<div id="dtypeDetailsWindow">
    <div></div><div></div>
</div>
</body>
</html>