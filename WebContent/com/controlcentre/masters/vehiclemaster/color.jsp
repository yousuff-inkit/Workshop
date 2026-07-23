<%@page import="com.controlcentre.masters.vehiclemaster.color.ClsColorAction" %>
<%ClsColorAction coa=new ClsColorAction(); %>

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

/* Grid Wrappers */
.modern-ui .grid-container {
    border: 1px solid #c5d3e0;
    border-radius: 4px;
    background: #fff;
    overflow: hidden;
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
var data= '<%=coa.searchDetails() %>';
$(document).ready(function () { 	
    
    	document.getElementById("formdet").innerText="Color(CLR)";
		document.getElementById("formdetail").value="Color";
		document.getElementById("formdetailcode").value="CLR";
		window.parent.formCode.value="CLR";
		window.parent.formName.value="Color";
		
     var num = 0; 
    var source =
    {
        datatype: "json",
        datafields: [
                  	{name : 'DOC_NO' , type: 'number' },
						{name : 'color', type: 'String'  }
                  	
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

    $("#jqxColorSearch1").jqxGrid(
            {
            	width: '70%',
                height: 315,
                source: dataAdapter,
                showfilterrow: true,
                filterable: true,
                selectionmode: 'multiplecellsextended',
                //pagermode: 'default',
                sortable: true,
                //pageable: true,
                altrows:true,
                //Add row method
                columns: [
					{ text: 'Doc No',filtertype: 'number', datafield: 'DOC_NO', width: '40%' },
					{ text: 'Color',columntype: 'textbox', filtertype: 'input', datafield: 'color', width: '60%' }
	              ]
            });
    $('#jqxColorSearch1').on('rowdoubleclick', function (event) 
    		{ 
    			var rowindex1=event.args.rowindex;
      		 	 document.getElementById("docno").value= $('#jqxColorSearch1').jqxGrid('getcellvalue', rowindex1, "DOC_NO"); 
       			 document.getElementById("color").value = $("#jqxColorSearch1").jqxGrid('getcellvalue', rowindex1, "color");                
    	 		 $('#window').jqxWindow('hide');
    		 }); 
});
function funReadOnly(){
	$('#frmColor input').attr('readonly', true );
	/* $('#jqxDateTimeInput').jqxDateTimeInput({ disabled: true}); */
}
function funRemoveReadOnly(){
	$('#frmColor input').attr('readonly', false );
	//$('#jqxDateTimeInput').jqxDateTimeInput({ disabled: false});
	$('#docno').attr('readonly', true);
}
function setValues(){	
   
	 if($('#msg').val()!=""){
		   $.messager.alert('Message',$('#msg').val());
		  }

	}
    function funFocus()
    {
    	document.getElementById("color").focus();
    		
    }
   
    $(function(){
    	
        $('#frmColor').validate({
                 rules: {
                 color: {
                	 required:true,
                	 maxlength:45
                 }
                 
                 
                 },
                 messages: {
                  color:{
                	  required:" *",
                	  maxlength:"max 45 chars"
                  }
                  
                  
                 }
        });});
     function funNotify(){
    	
    		return 1;
	} 
     function funSearchLoad(){
			changeContent('colorSearch.jsp', $('#window')); 
		 }
     function funExcelBtn(){
		  $("#jqxColorSearch1").jqxGrid('exportdata', 'xls', 'Color');
	  }
</script>
</head>
<body onload="setValues();" >
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmColor" action="saveActionColor" autocomplete="off">
    <jsp:include page="../../../../header.jsp" />
    
    <div class='modern-ui hidden-scrollbar'>
        <div id="errormsg"></div>

        <div class="middle-panel">
            <span class="middle-panel-title">Color Details</span>
            
            <div class="field-row" style="margin-bottom:0;">
                <label class="lbl-right" style="width:80px;">Color</label>
                <input type="text" name="color" id="color" style="width:250px;" value='<s:property value="color"/>'>
                
                <label class="lbl-right" style="width:80px; margin-left:auto;">Doc No</label>
                <input type="text" name="docno" id="docno" style="width:125px;" readonly="readonly" value='<s:property value="docno"/>' tabindex="-1">
            </div>
        </div>  

        <div class="middle-panel">
            <span class="middle-panel-title">Details</span>
            <div id="jqxColorSearch1" class="grid-container"></div>
        </div>

        <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
        <input type="hidden" id="mode" name="mode"/>
        <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>

    </div>
</form>

    <%-- <div id="window">
            <div id="windowHeader" class="windowHead">
                <span> <img src="../../../../icons/search_new.png" alt=""
                    style="margin-right: 15px" />Search
                </span>
            </div>
            <div id="windowContent" class="windowCont" style="overflow: hidden;">
                <jsp:include page="colorSearch.jsp"></jsp:include>
            </div>
        </div> --%>
</div>
</body>
</html>