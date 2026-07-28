<%@page import="com.controlcentre.masters.vehiclemaster.model.ClsModelDAO" %>
<%ClsModelDAO cma=new ClsModelDAO(); %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>
<% String contextPath=request.getContextPath(); %>

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
        $("#modeldate").jqxDateTimeInput({ width: '100%', height: 24, formatString: "dd.MM.yyyy", theme: 'energyblue'});  
        
        /* force internal alignment AFTER render */
        setTimeout(function () {
             $("#modeldate").find("input").css({
                 "margin-top": "0px",
                 "line-height": "24px",
                 "font-size": "12px", 
                 "font-family": "Arial, sans-serif", 
                 "padding": "0 6px", 
                 "box-sizing":"border-box"
             });
             $("#modeldate").find(".jqx-action-button").css({
                 "top": "0px",
                 "height": "24px"
             });
        }, 0);
        
        $('#groupinfowindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true});
        $('#groupinfowindow').jqxWindow('close');
          
        if(document.getElementById("formdet")) {
            document.getElementById("formdet").innerText="Model(MOD)";
            document.getElementById("formdetail").value="Model";
            document.getElementById("formdetailcode").value="MOD";
            window.parent.formCode.value="MOD";
            window.parent.formName.value="Model";
        }
            
        $('#txtgroup').dblclick(function(){
            groupSearchContent('modelgroupGrid.jsp');
        });

        var data= '<%=cma.getSearchDetails()%>';
        var num = 0; 
        var source =
         {
             datatype: "json",
             datafields: [
                        {name : 'doc_no' , type: 'int' },
                        {name : 'vtype', type: 'String'  },
                        {name : 'date', type: 'date'  },
                        {name : 'brand_name',type:'String'},
                        {name : 'brandid',type:'String'},
                        {name : 'gname',type:'String'},
                        {name : 'groupid',type:'String'},
                        {name : 'enginesize',type:'string'},
                        {name : 'enginesizedocno',type:'string'}
               ],
               localdata: data,
              
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
      
         $("#jqxModelSearch1").jqxGrid(
                 {
                    width: '100%',
                      height: 350,
                      source: dataAdapter,
                      showfilterrow: true,
                      filterable: true,
                      selectionmode: 'singlerow',
                      sortable: true,
                      altrows:true,
                      //Add row method
                      columns: [
                        { text: 'Doc No',filtertype:'number', datafield: 'doc_no', width: '10%' },
                        { text: 'Model', columntype: 'textbox', filtertype: 'input',datafield: 'vtype', width: '40%' },
                        { text: 'Date',columntype: 'textbox', filtertype: 'input', datafield: 'date', width: '10%',cellsformat:'dd.MM.yyyy' },
                        { text: 'Brand',columntype: 'textbox', filtertype: 'input',datafield:  'brand_name',width:'20%'},
                        { text: 'Brand ID',columntype: 'textbox', filtertype: 'input',datafield:  'brandid',width:'5%',hidden:true},
                        { text: 'Group',columntype: 'textbox', filtertype: 'input',datafield:  'gname',width:'10%'},
                        { text: 'Group ID',columntype: 'textbox', filtertype: 'input',datafield:  'groupid',width:'5%',hidden:true},
                        { text: 'Engine Size',columntype: 'textbox', filtertype: 'input',datafield:  'enginesize',width:'10%'},
                        { text: 'Engine Size Doc No',columntype: 'textbox', filtertype: 'input',datafield:  'enginesizedocno',width:'5%',hidden:true} 
                      ]
                  });

    $('#jqxModelSearch1').on('rowdoubleclick', function (event) 
    {
        var rowindex1=event.args.rowindex;
        document.getElementById("docno").value= $('#jqxModelSearch1').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
        document.getElementById("model").value = $("#jqxModelSearch1").jqxGrid('getcellvalue', rowindex1, "vtype");
        $('#frmModel select').attr('disabled', false);
        $('#modeldate').jqxDateTimeInput({disabled: false});
        $("#modeldate").jqxDateTimeInput('val',$("#jqxModelSearch1").jqxGrid('getcellvalue', rowindex1, "date"));
        $('#brand').val($("#jqxModelSearch1").jqxGrid('getcellvalue', rowindex1, "brandid")) ;
        $('#frmModel select').attr('disabled', true);
        $('#modeldate').jqxDateTimeInput({disabled: true});
        $('#cmbenginesize').val($("#jqxModelSearch1").jqxGrid('getcellvalue', rowindex1, "enginesizedocno"));
    }); 
    $("#jqxModelSearch1").jqxGrid('hidecolumn', 'brandid'); 
});

    function getGroup(event){  
        var x= event.keyCode;
        if(x==114){
            groupSearchContent('modelgroupGrid.jsp');
        }
        else{
        }
    }
   
      function groupSearchContent(url) {
        $('#groupinfowindow').jqxWindow('open');
            $.get(url).done(function (data) {
            $('#groupinfowindow').jqxWindow('setContent', data);
            $('#groupinfowindow').jqxWindow('bringToFront');
        }); 
        }
    
      function funSearchLoad(){
            changeContent('modelSearch.jsp', $('#window')); 
         }

    function funReadOnly() {
        $('#frmModel input').attr('readonly', true);
        $('#frmModel select').attr('disabled', true);
        $('#modeldate').jqxDateTimeInput({disabled: true});
        $('#txtgroup').attr('readonly', true);
    }
    
    function funRemoveReadOnly() {
        $('#frmModel input').attr('readonly', false);
        $('#frmModel select').attr('disabled', false);
        $('#modeldate').jqxDateTimeInput({disabled: false});
        $('#docno').attr('readonly', true);
        $('#txtgroup').attr('readonly', true);
    }

    function getBrand() {
        var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {
                items = x.responseText;
                items = items.split('***');
                var brandItems = items[0].split(",");
                var brandidItems = items[1].split(",");
                var optionsbrand = '<option value="">--Select--</option>';
                for (var i = 0; i < brandItems.length; i++) {
                    optionsbrand += '<option value="' + brandidItems[i] + '">'
                            + brandItems[i] + '</option>';
                }
                $("select#brand").html(optionsbrand);
                $('#brand').val($('#brandid').val());
                } else {
            }
        }
        x.open("GET", "getBrand.jsp", true);
        x.send();
    }
    
    function funFocus(){
        document.getElementById("brand").focus();
    }
    
     $(function(){
        $('#frmModel').validate({
                 rules: {
                 brand:{
                     required:true
                 },
                 model:{
                     required:true,
                     maxlength:50
                 }
                 },
                 messages: {
                  brand:{
                      required:" *"
                  },
                  model:{
                      required:" *",
                      maxlength:"max 50 chars"
                  }
                 }
        });});
        
     function funNotify(){
            return 1;
        } 
     
    function setValues() {
        if ($('#brandid').val() != null) {
            $('#brand').val($('#brandid').val());
        }
        if($('#msg').val()!=""){
            $.messager.alert('Message',$('#msg').val());
        }
        $.get('getEngineSize.jsp',function(data){
            data=JSON.parse(data);
            var htmldata='';
            $.each(data.enginedata,function(index,value){
                htmldata+='<option value="'+value.docno+'">'+value.enginesize+'</option>';
            });
            $('#cmbenginesize').html($.parseHTML(htmldata));
            if($('#hidcmbenginesize').val()!='' && $('#hidcmbenginesize').val()!='0'){
                $('#cmbenginesize').val($('#hidcmbenginesize').val());
            }
        });
    }
    
     function funExcelBtn(){
         $("#jqxModelSearch1").jqxGrid('exportdata', 'xls', 'Model');
     }
</script>
</head>
<body onLoad="getBrand();setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmModel" action="saveActionModel"  autocomplete="off">
    <jsp:include page="../../../../header.jsp" />

<div class='modern-ui hidden-scrollbar'>
    <div id="errormsg"></div>

    <div class="middle-panel" style="margin-bottom: 15px;">
        <span class="middle-panel-title">Model Details</span>
        
        <div class="field-row">
            <label class="lbl-right" style="width:80px;">Date</label>
            <div style="flex:1; max-width:125px;">
                <div id="modeldate" name="modeldate" value='<s:property value="modeldate"/>'></div>
            </div>
            
            <label class="lbl-right" style="width:80px; margin-left:auto;">Doc No.</label>
            <input type="text" name="docno" id="docno" value='<s:property value="docno"/>' readonly="readonly" tabindex="-1" style="width:120px;">
        </div>

        <div class="field-row" style="margin-bottom:0;">
            <label class="lbl-right" style="width:80px;">Brand</label>
            <select name="brand" id="brand" style="width:150px;"></select>
            
            <label class="lbl-right" style="width:60px; margin-left:15px;">Model</label>
            <input type="text" name="model" id="model" value='<s:property value="model"/>' style="flex:1;">
            
            <label class="lbl-right" style="width:60px; margin-left:15px;">Group</label>
            <div class="input-search-container" style="width:150px;">
                <input type="text" name="txtgroup" id="txtgroup" onkeydown="getGroup(event);" readonly placeholder="Press F3" required value='<s:property value="txtgroup"/>'>
                <svg class="magnifier-icon" onclick="$('#txtgroup').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
            </div>
            
            <label class="lbl-right" style="width:80px; margin-left:15px;">Engine Size</label>
            <select name="cmbenginesize" id="cmbenginesize" style="width:150px;">
                <option value="">--Select--</option>
            </select>
        </div>
    </div>

    <!-- Hidden Fields Map -->
    <div style="display:none;">
        <input type="text" id="brandid" name="brandid" value='<s:property value="brandid"/>' hidden="true">
        <input type="hidden" name="txtgroupid" id="txtgroupid"   value='<s:property value="txtgroupid"/>'>
        <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
        <input type="hidden" id="hidcmbenginesize" name="hidcmbenginesize" value='<s:property value="hidcmbenginesize"/>'/>
        <input type="hidden" id="mode" name="mode"/>
        <input type="text" name="deleted" id="deleted" value='<s:property value="deleted"/>' hidden="true"/>
    </div>

    <!-- Model Search Grid -->
    <div id="jqxModelSearch1" style="margin-top: 15px;"></div>
    
</div>
</form>

<div id="groupinfowindow">  
    <div></div><div></div>
</div>          
    
</div>
</body>
</html>