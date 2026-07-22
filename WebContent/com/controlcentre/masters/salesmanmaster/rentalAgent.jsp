<%@page import="com.controlcentre.masters.salesmanmaster.rentalagent.ClsRentalAgentDAO" %>
<%ClsRentalAgentDAO crad =new ClsRentalAgentDAO(); %>

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
      $('#accountWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
      $('#accountWindow').jqxWindow('close');

      // Date Setup
      $("#rentalagentdate").jqxDateTimeInput({width: '100%', height: 24, formatString: "dd.MM.yyyy", theme: 'energyblue'});
      
      /* force internal alignment AFTER render */
      setTimeout(function () {
           $("#rentalagentdate").find("input").css({
               "margin-top": "0px",
               "line-height": "24px",
               "font-size": "12px", 
               "font-family": "Arial, sans-serif", 
               "padding": "0 6px", 
               "box-sizing":"border-box"
           });
           $("#rentalagentdate").find(".jqx-action-button").css({
               "top": "0px",
               "height": "24px"
           });
      }, 0);
              
      $('#txtaccno').dblclick(function(){
            $('#accountWindow').jqxWindow('open');
            var url=document.URL;
            var reurl=url.split("com/");
            accountSearchContent(reurl[0]+'com/search/accountsearch/accountsEmployee.jsp?dtype='+document.getElementById("formdetailcode").value);
         }); 
            
      if(document.getElementById("formdet")) {
          document.getElementById("formdet").innerText="Service Advisor(WSA)";
          document.getElementById("formdetail").value="Service Advisor";
          document.getElementById("formdetailcode").value="WSA";
          window.parent.formCode.value="WSA";
          window.parent.formName.value="Service Advisor";
      }
      
      var data='<%=crad.searchDetails()%>';
       var source =
         {
             datatype: "json",
             datafields: [
                            {name : 'doc_no' , type: 'int' },
                            {name : 'name', type: 'String'  },
                            {name : 'mail', type: 'String'  },
                            {name : 'acno',type:'string'},
                            {name : 'description',type:'String'},
                            {name : 'mobile',type:'string'},
                            {name : 'code',type:'string'},
                            {name :'date',type:'date'},
                            {name : 'acdoc',type:'String'},
                            {name : 'active',type:'String'}
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
         $("#jqxRentalagentSearch1").jqxGrid(
                 {
                    width: '100%',
                    height:310,
                     source: dataAdapter,
                     showfilterrow: true,
                     filterable: true,
                     selectionmode: 'singlerow',
                     sortable: true,
                     altrows:true,
                     //Add row method
                     columns: [
                        { text: 'Doc No',filtertype: 'number', datafield: 'doc_no', width: '10%' },
                        { text: 'Code',datafield: 'code', width: '10%',hidden:true },
                        { text: 'Date',columntype: 'textbox', filtertype: 'input', datafield: 'date', width: '10%',cellsformat:'dd.MM.yyyy' },
                        { text: 'Name', datafield: 'name', width: '20%' },
                        { text: 'Account',columntype: 'textbox', filtertype: 'input', datafield: 'description', width: '30%' },
                        { text: 'Account No',columntype: 'textbox', filtertype: 'input', datafield: 'acno', width: '50%' ,hidden:true},
                        { text: 'Email',columntype: 'textbox', filtertype: 'input', datafield: 'mail', width: '15%' },
                        { text: 'Mobile',columntype: 'textbox', filtertype: 'input', datafield: 'mobile', width: '15%' },
                        { text: 'Ac No',columntype: 'textbox', filtertype: 'input', datafield: 'acdoc', width: '15%',hidden:true },
                        { text: 'Active',columntype: 'textbox', filtertype: 'input', datafield: 'active', width: '15%',hidden:true },
                      ]
                 });

            $('#jqxRentalagentSearch1').on('rowdoubleclick', function (event) 
                    { 
                        var rowindex1=event.args.rowindex;
                        document.getElementById("docno").value= $('#jqxRentalagentSearch1').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
                        document.getElementById("code").value = $("#jqxRentalagentSearch1").jqxGrid('getcellvalue', rowindex1, "code");
                        document.getElementById("name").value = $("#jqxRentalagentSearch1").jqxGrid('getcellvalue', rowindex1, "name");
                        document.getElementById("mail").value = $("#jqxRentalagentSearch1").jqxGrid('getcellvalue', rowindex1, "mail");
                        document.getElementById("mobile").value = $("#jqxRentalagentSearch1").jqxGrid('getcellvalue', rowindex1, "mobile");
                        $("#rentalagentdate").jqxDateTimeInput('val', $("#jqxRentalagentSearch1").jqxGrid('getcellvalue', rowindex1, "date")); 
                        document.getElementById("txtaccno").value = $("#jqxRentalagentSearch1").jqxGrid('getcellvalue', rowindex1, "acno");
                        document.getElementById("txtaccname").value = $("#jqxRentalagentSearch1").jqxGrid('getcellvalue', rowindex1, "description");
                     document.getElementById("hidacno").value = $("#jqxRentalagentSearch1").jqxGrid('getcellvalue', rowindex1, "acdoc");
                  document.getElementById("cmbactive").value = $("#jqxRentalagentSearch1").jqxGrid('getcellvalue', rowindex1, "active");
                     }); 
            
   });
    
     function getAcc(event){
         var x= event.keyCode;
         if(x==114){
          $('#accountWindow').jqxWindow('open');
            var url=document.URL;
             var reurl=url.split("com/");
                  accountSearchContent(reurl[0]+'com/search/accountsearch/accountsEmployee.jsp?dtype='+document.getElementById("formdetailcode").value);
         }
         else{}
     }

 function accountSearchContent(url) {
         $.get(url).done(function (data) {
        $('#accountWindow').jqxWindow('setContent', data);
    }); 
    }

function funSearchLoad(){
    changeContent('rentalAgentSearch.jsp'); 
 }

function funReadOnly(){
    $('#frmRentalAgent input').attr('readonly', true );
    $('#rentalagentdate').jqxDateTimeInput({ disabled: true}); 
}

function funRemoveReadOnly(){
    $('#frmRentalAgent input').attr('readonly', false );
    $('#rentalagentdate').jqxDateTimeInput({ disabled: false}); 
    $('#docno').attr('readonly', true);
    $('#txtaccno').attr('readonly', true);
    $('#txtaccname').attr('readonly', true);
}

function setValues() {
    if($('#hidrentalagentdate').val()){
        $("#rentalagentdate").jqxDateTimeInput('val', $('#hidrentalagentdate').val());
    }

    if($('#msg').val()!=""){
           $.messager.alert('Message',$('#msg').val());
          }
    
    if($('#hidactive').val()!=""){
        document.getElementById("cmbactive").value=$('#hidactive').val();
    }
}

function funFocus(){
    document.getElementById("code").focus();
}

function funNotify(){
    if(document.getElementById("txtaccno").value==''){
        document.getElementById("errormsg").innerText="Account is Mandatory.";
        return 0;
    }
    document.getElementById("errormsg").innerText="";
    return 1;
}

$(function(){
    $('#frmRentalAgent').validate({
        rules: {
            code: {required:true,maxlength:10},
            name:{required:true,maxlength:40},
            txtaccname:{required:true},
            mobile:{required:true,digits:true,minlength:12,maxlength:12},
            mail:{email:true}
            },
            messages: {
             code:{required:" *",maxlength:"Max 10 Chars."},
             name:{required:" *",maxlength:"Max 40 Chars."},
             txtaccname:{required:" *"},
             mobile:{required:" *",digits:"Digits only.",minlength:"Min 12 Chars.",maxlength:'Max 12 Chars.'},
             mail:{email:"Not a valid Email"}
            }
   });});

function funExcelBtn(){
     $("#jqxRentalagentSearch1").jqxGrid('exportdata', 'xls', 'Rental Agents');
  }
</script>
</head>
<body onLoad="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmRentalAgent" action="saveActionRentalAgent"  autocomplete="off">
<jsp:include page="../../../../header.jsp" />

<div class='modern-ui hidden-scrollbar'>
    <div id="errormsg"></div>

    <div class="middle-panel" style="margin-bottom: 15px;">
        <span class="middle-panel-title">Service Advisor Details</span>
        
        <div class="field-row">
            <label class="lbl-right" style="width:80px;">Date</label>
            <div style="flex:1; max-width:125px;">
                <div id="rentalagentdate" name="rentalagentdate" value='<s:property value="rentalagentdate"/>'></div>
            </div>
            
            <label class="lbl-right" style="width:60px; margin-left:15px;">Active</label>
            <select name="cmbactive" id="cmbactive" style="width:100px;" value='<s:property value="cmbactive"/>' >
                <option value="1" >Active</option>
                <option value="0" >Inactive</option>
            </select>
            
            <label class="lbl-right" style="width:80px; margin-left:auto;">Doc No.</label>
            <input type="text" id="docno" name="docno" value='<s:property value="docno"/>' style="width:120px;" readonly tabindex="-1">
        </div>

        <div class="field-row">
            <label class="lbl-right" style="width:80px;">Code</label>
            <input type="text" id="code" name="code" placeholder="Code" value='<s:property value="code"/>' style="width:100px;">
            
            <label class="lbl-right" style="width:60px; margin-left:15px;">Name</label>
            <input type="text" name="name" id="name" placeholder="Code Name" value='<s:property value="name"/>' style="flex:1;">
            
            <label class="lbl-right" style="width:60px; margin-left:15px;">Email</label>
            <input type="email" name="mail" id="mail" style="flex:1; max-width:250px;" placeholder="someone@example.com" value='<s:property value="mail"/>'>
        </div>

        <div class="field-row" style="margin-bottom:0;">
            <label class="lbl-right" style="width:80px;">Account</label>
            <div class="input-search-container" style="flex:1; max-width:150px;">
                <input type="text" name="txtaccno" id="txtaccno" value='<s:property value="txtaccno"/>' onKeyDown="getAcc(event);" readonly placeholder="Press F3">
                <svg class="magnifier-icon" onclick="$('#txtaccno').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
            </div>
            
            <input type="text" name="txtaccname" id="txtaccname" value='<s:property value="txtaccname"/>' style="flex:1; margin-left:8px;" readonly>
            
            <label class="lbl-right" style="width:60px; margin-left:15px;">Mobile</label>
            <input type="text" name="mobile" id="mobile" value='<s:property value="mobile"/>' style="flex:1; max-width:250px;">
        </div>
    </div>

    <!-- Service Advisor Search Grid Displayed Automatically -->
    <div id="jqxRentalagentSearch1" style="margin-top: 15px;"></div>

    <!-- Hidden Fields Map -->
    <div style="display:none;">
        <input type="hidden" name="hidrentalagentdate" id="hidrentalagentdate" value='<s:property value="hidrentalagentdate"/>'>
        <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
        <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'>
        <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
        <input type="hidden" name="hidacno" id="hidacno" value='<s:property value="hidacno"/>'>
        <input type="hidden" name="hidactive" id="hidactive" value='<s:property value="hidactive"/>'>
    </div>
</div>
</form>

<!-- Popup Windows -->
<div id="accountWindow">
    <div></div><div></div>
</div>  

</div>
</body>
</html>