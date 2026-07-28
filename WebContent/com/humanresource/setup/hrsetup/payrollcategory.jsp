<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
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

.custom-checkbox {
    width: 14px !important; 
    height: 14px !important;
    margin: 0 !important;
    vertical-align: middle;
    cursor: pointer;
}
</style>

<%@page import="com.humanresource.setup.hrsetup.payrollcategory.ClsPayrollcategoryDAO"%>
<% ClsPayrollcategoryDAO showDAO = new ClsPayrollcategoryDAO();%> 

<script type="text/javascript">
	$(document).ready(function () {    
	    document.getElementById("formdet").innerText="Payroll Category(PCT)";
		document.getElementById("formdetail").value="Payroll Category";
		document.getElementById("formdetailcode").value="PCT";
		window.parent.formCode.value="PCT";
		window.parent.formName.value="Payroll Category";
	    
		$("#parrolldate").jqxDateTimeInput({ width: '125px', height: 24, formatString : "dd.MM.yyyy", theme: 'energyblue'});
 
		/* force internal alignment AFTER render */
		 setTimeout(function () {
		 	$("#parrolldate").find("input").css({
		 		"margin-top": "0px",
		 		"line-height": "24px",
		 		"font-size": "12px", 
		 		"font-family": "Arial, sans-serif", 
		 		"padding": "0 6px", 
		 		"box-sizing":"border-box"
		 	});
		 	$("#parrolldate").find(".jqx-action-button").css({
		 		"top": "0px",
		 		"height": "24px"
		 	});
		 }, 0);

		var catdata='<%=showDAO.searchcategory()%>';
         
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'number' },
     						{name : 'category', type: 'String'  },
                          	{name : 'date', type: 'date'  },
                          	{name : 'remarks', type: 'String'  },
                        	{name : 'timesheet', type: 'Int'  },
                 ],
                 localdata: catdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
    
            $("#categorygrid").jqxGrid(
                    {
                    	width: "100%",
                        source: dataAdapter,
                        showfilterrow: true,
                        filterable: true,
                        selectionmode: 'singlerow',
                        
                        columns: [
		        					{ text: 'Doc No',filtertype: 'number', datafield: 'doc_no', width: '10%' },
		        					{ text: 'Date',columntype: 'textbox', filtertype: 'input', datafield: 'date', width: '12%',cellsformat:'dd.MM.yyyy' },
		        					{ text: 'Category',columntype: 'textbox', filtertype: 'input', datafield: 'category', width: '38%' },
		        					{ text: 'Remarks',columntype: 'textbox', filtertype: 'input', datafield: 'remarks', width: '40%' },
		        					{ text: 'timesheet',filtertype: 'number', datafield: 'timesheet', width: '10%',hidden:true },
        	              ]
                    });

            $('#categorygrid').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
 
                document.getElementById("docno").value= $('#categorygrid').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
                document.getElementById("category").value = $("#categorygrid").jqxGrid('getcellvalue', rowindex1, "category");
                $("#parrolldate").jqxDateTimeInput('val', $("#categorygrid").jqxGrid('getcellvalue', rowindex1, "date"));
                document.getElementById("remarks").value = $("#categorygrid").jqxGrid('getcellvalue', rowindex1, "remarks");
                
                $('#timesheet').attr('disabled', false);
                
                var timesheet=$("#categorygrid").jqxGrid('getcellvalue', rowindex1, "timesheet");
	            if(parseInt(timesheet)==1) {
	            	 document.getElementById("timesheet").checked = true;
	       		     document.getElementById("timesheet").value=1;
	            	} else {
	           	     document.getElementById("timesheet").checked = false;
	       		     document.getElementById("timesheet").value=0;
	            	}
	            
	            if ($("#mode").val() == "view") {
	            	$('#timesheet').attr('disabled', true);
	            }

	            /// parrolldate category
            });  
        });

	function funSearchLoad(){
		 changeContent('payrollcategorysearch.jsp'); 
	 }
 
	function funReadOnly() {
		$('#frmpayrollcategory input').attr('readonly', true);
		$('#timesheet').attr('disabled', true);
		$('#parrolldate').jqxDateTimeInput({ disabled: true});
		 
		/* 	$('#jqxDateTimeInput').jqxDateTimeInput({ disabled: true}); */
	}
	
	function funRemoveReadOnly() {
		$('#frmpayrollcategory input').attr('readonly', false);
		$('#timesheet').attr('disabled', false);
		$('#parrolldate').jqxDateTimeInput({ disabled: false});
		$('#docno').attr('readonly', true);
		
		if ($("#mode").val() == "A") {
			 $('#parrolldate').val(new Date());
		}
	}
 
	function setValues() {
		if($('#datehidden').val()){
			$("#parrolldate").jqxDateTimeInput('val', $('#datehidden').val());
		}
		 if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }

		 //document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		var hidtimesheet=$('#hidtimesheet').val();
		if(parseInt(hidtimesheet)==1) {
       	 	document.getElementById("timesheet").checked = true;
  		    document.getElementById("timesheet").value=1;
       	} else {
      	    document.getElementById("timesheet").checked = false;
  		    document.getElementById("timesheet").value=0;
       	}
	}
 
	     function funNotify(){
	        	if(document.getElementById("category").value=="") {
        			document.getElementById("errormsg").innerText=" Enter Category";
        			document.getElementById("category").focus();
        			return 0;
        		}
	    		return 1;
		} 

	     function funFocus(){
	    	 $('#parrolldate').jqxDateTimeInput('focus');
	     }
	  
</script>   
 
</head>
<body onLoad="setValues();" >

<div id="mainBG" class="homeContent" data-type="background">
<form id="frmpayrollcategory" action="savePayrollcategory" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp" />

<div class='modern-ui hidden-scrollbar'>
    <div id="errormsg"></div>

    <div class="middle-panel">
        <span class="middle-panel-title">Payroll Category Details</span>
        
        <div class="field-row">
            <label class="lbl-right" style="width:80px;">Date</label>
            <div style="width: 125px;">
                <div id="parrolldate" name="parrolldate" value='<s:property value="parrolldate"/>'> </div>
            </div>
            
            <label class="lbl-right" style="width:80px;">Category</label>
            <input type="text" name="category" id="category" style="width:250px;" placeholder="Category" value='<s:property value="category"/>'>
            
            <label style="display:flex; align-items:center; gap:5px; cursor:pointer; font-size:12px; font-weight:bold; color:#444; margin-left: 15px;">
                <input type="checkbox" id="timesheet" name="timesheet" value="0" onclick="$(this).attr('value', this.checked ? 1 : 0)" class="custom-checkbox">
                Time Sheet
            </label>
            
            <label class="lbl-right" style="width:80px; margin-left:auto;">Doc No</label>
            <input type="text" name="docno" id="docno" style="width:125px;" value='<s:property value="docno"/>' readonly="readonly" tabindex="-1">
        </div>
        
        <div class="field-row" style="margin-bottom:0;">
            <label class="lbl-right" style="width:80px;">Remarks</label>
            <input type="text" name="remarks" id="remarks" style="flex:1;" placeholder="Remarks" value='<s:property value="remarks"/>' >
        </div>
    </div>

    <div class="middle-panel">
        <span class="middle-panel-title">Details</span>
        <div id="categorygrid" class="grid-container"></div>
    </div>

    <!-- Hidden Logic Fields -->
    <div style="display:none;">
        <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>' />
        <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/> 
        <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/> 
        <input type="hidden" id="datehidden" name="datehidden" value='<s:property value="datehidden"/>'/> 
        <input type="hidden" id="hidtimesheet" name="hidtimesheet" value='<s:property value="hidtimesheet"/>'/> 
    </div>

</div>
</form>

</div>
</body>
</html>