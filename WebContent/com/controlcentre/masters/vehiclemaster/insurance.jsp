<%@page import="com.controlcentre.masters.vehiclemaster.insurance.ClsInsuranceAction" %>
<% ClsInsuranceAction cia =new ClsInsuranceAction();%>
<%@ taglib prefix="s" uri="/struts-tags" %>

<!DOCTYPE html>
<% String contextPath=request.getContextPath();%>

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
          // Date Setup
          $("#insurdate").jqxDateTimeInput({ width: '100%', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'}); 
          
          /* force internal alignment AFTER render */
          setTimeout(function () {
               $("#insurdate").find("input").css({
                   "margin-top": "0px",
                   "line-height": "24px",
                   "font-size": "12px", 
                   "font-family": "Arial, sans-serif", 
                   "padding": "0 6px", 
                   "box-sizing":"border-box"
               });
               $("#insurdate").find(".jqx-action-button").css({
                   "top": "0px",
                   "height": "24px"
               });
          }, 0);
          
          $('#accountWindow').jqxWindow({width: '51%', height: '61%',  maxHeight: '61%' ,maxWidth: '51%' , title: 'Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true});
          $('#accountWindow').jqxWindow('close');
          
          if(document.getElementById("formdet")) {
              document.getElementById("formdet").innerText="Insurance(VIS)";
              document.getElementById("formdetail").value="Insurance";
              document.getElementById("formdetailcode").value="VIS";
              window.parent.formCode.value="VIS";
              window.parent.formName.value="Insurance";
          }
          
          var data1= '<%=cia.searchDetails() %>';
             
             var num = 0; 
             var source =
             {
                 datatype: "json",
                 datafields: [
                                {name : 'doc_no' , type: 'number' },
                                {name : 'inname', type: 'String'  },
                                {name : 'date', type: 'date'  },
                                {name : 'description',type:'String'},
                                {name : 'acc_no',type:'String'}
                                
                  ],
                  localdata: data1,
                 
                 
                 pager: function (pagenum, pagesize, oldpagenum) {
                     // callback called when a page or page size is changed.
                 }
             };
             
             var dataAdapter = new $.jqx.dataAdapter(source,
                     {
                        loadError: function (xhr, status, error) {
                        alert(error);   
                        }
                    }       
             );
        
             $("#jqxInsuranceSearch1").jqxGrid(
                     {
                        width: '100%',
                         height: 350,
                         source: dataAdapter,
                         showfilterrow: true,
                         filterable: true,
                         selectionmode: 'singlerow',
                         //pagermode: 'default',
                         sortable: true,
                        // pageable: true,
                         altrows:true,
                         //Add row method
                         columns: [
                            { text: 'Doc No', datafield: 'doc_no', width: '10%' },
                    { text: 'Insurance', datafield: 'inname', width: '50%' },
                    {text: 'Date',datafield:'date',width:'20%',cellsformat:'dd.MM.yyyy'},
                    {text: 'Account',datafield:'description',width:'20%'},
                    {text: 'Acc No',datafield:'acc_no',width:'20%',hidden:true}
                  ]
                     });
             $('#jqxInsuranceSearch1').on('rowdoubleclick', function (event) 
                    { 
                        var rowindex1=event.args.rowindex;
                        document.getElementById("docno").value= $('#jqxInsuranceSearch1').jqxGrid('getcellvalue', rowindex1, "doc_no");
                        document.getElementById("insurcompany").value=$('#jqxInsuranceSearch1').jqxGrid('getcellvalue', rowindex1, "inname");
                        $("#insurdate").jqxDateTimeInput('val',$("#jqxInsuranceSearch1").jqxGrid('getcellvalue', rowindex1, "date"));
                        document.getElementById("txtaccname").value=$('#jqxInsuranceSearch1').jqxGrid('getcellvalue', rowindex1, "description");
                        document.getElementById("txtaccno").value=$('#jqxInsuranceSearch1').jqxGrid('getcellvalue', rowindex1, "acc_no");
                     }); 
      }); 

             function accountSearchContent(url) {
                  $('#accountWindow').jqxWindow('open');
                 $.get(url).done(function (data) {
                $('#accountWindow').jqxWindow('setContent', data);
            }); 
            }
            function funSearchdblclick(){
                   var url=document.URL;
                 var reurl=url.split("com/");
                      accountSearchContent(reurl[0]+'com/search/accountsearch/accountsSearchAP.jsp?dtype='+document.getElementById("formdetailcode").value);
        }
           function getAcc(event){
            
                var x= event.keyCode;
                if(x==114){
                     var url=document.URL;
                     var reurl=url.split("com/");
                          accountSearchContent(reurl[0]+'com/search/accountsearch/accountsSearchAP.jsp?dtype='+document.getElementById("formdetailcode").value);
                }
                else{
                 }
                }
    function funReadOnly() {
        $('#frmInsurance input').attr('readonly', true);
         $('#insurdate').jqxDateTimeInput({ disabled: true}); 
    }
    function funRemoveReadOnly() {
        $('#frmInsurance input').attr('readonly', false);
        $('#insurdate').jqxDateTimeInput({ disabled: false});
        $('#docno').attr('readonly', true);
        $('#txtaccname').attr('readonly', true);
        $('#insurcompany').attr('readonly', true);
    }
    function setValues() {
         if($('#insurdatehidden').val()){
                $("#insurdate").jqxDateTimeInput('val', $('#insurdatehidden').val());
            }
         if($('#msg').val()!=""){
               $.messager.alert('Message',$('#msg').val());
              }

    }
    function funSearchLoad(){
        changeContent('insuranceSearch.jsp', $('#window')); 
     }
     function funFocus()
    {
        document.getElementById("insurcompany").focus();
            
    }
    $(function(){
        $('#frmInsurance').validate({
                 rules: {
                 insurcompany:{
                     required:true,
                     maxlength:40
                 }, 
                txtaccname:{
                    required:true
                    }
                
                 },
                 messages: {
                  insurcompany:{
                      required:" *",
                      maxlength:"max 40 chars"
                  },
                  txtaccname:{
                      required:" *"
                  }
                 }
        });});
     function funNotify(){
         if(document.getElementById("txtaccname").value==''){
                document.getElementById("errormsg").innerText="A/c is Mandatory";
                return 0;
            }
            else{
                document.getElementById("errormsg").innerText="";
            }
            return 1;
        } 
     function funExcelBtn(){
          $("#jqxInsuranceSearch1").jqxGrid('exportdata', 'xls', 'Insurance');
      }
</script>
</head>
<body onLoad="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmInsurance" action="saveActionInsurance"  autocomplete="off">
    <jsp:include page="../../../../header.jsp" />

<div class='modern-ui hidden-scrollbar'>
    <div id="errormsg"></div>

    <div class="middle-panel" style="margin-bottom: 15px;">
        <span class="middle-panel-title">Insurance Details</span>
        
        <div class="field-row">
            <label class="lbl-right" style="width:80px;">Date</label>
            <div style="flex:1; max-width:125px;">
                <div id="insurdate" name="insurdate" value='<s:property value="insurdate"/>'></div>
            </div>
            
            <label class="lbl-right" style="width:80px; margin-left:auto;">Doc No</label>
            <input type="text" name="docno" id="docno" value='<s:property value="docno"/>' readonly tabindex="-1" style="width:120px;">
        </div>

        <div class="field-row" style="margin-bottom:0;">
            <label class="lbl-right" style="width:80px;">Account</label>
            <div class="input-search-container" style="flex:1; max-width:250px;">
                <input type="text" name="txtaccname" id="txtaccname" value='<s:property value="txtaccname"/>' ondblclick="funSearchdblclick();" onkeydown="getAcc(event);" placeholder="Press F3" required >
                <svg class="magnifier-icon" onclick="$('#txtaccname').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
            </div>
            
            <label class="lbl-right" style="width:60px; margin-left:15px;">Company</label>
            <input type="text" name="insurcompany" id="insurcompany"  value='<s:property value="insurcompany"/>' style="flex:1; max-width:300px;">
        </div>
    </div>

    <!-- Hidden Fields Map -->
    <div style="display:none;">
        <input type="hidden" name="txtaccno" id="txtaccno" value='<s:property value="txtaccno"/>'>
        <input type="hidden" id="mode" name="mode"/>
        <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
        <input type="text" name="deleted" id="deleted" value='<s:property value="deleted"/>' hidden="true"/>
        <input type="hidden" id="insurdatehidden" name="insurdatehidden" value='<s:property value="insurdatehidden"/>'/>
    </div>

    <!-- Insurance Search Grid -->
    <div id="jqxInsuranceSearch1" style="margin-top: 15px;"></div>
    
</div>
</form>

<div id="accountWindow">
    <div></div><div></div>
</div>

</div>
</body>
</html>