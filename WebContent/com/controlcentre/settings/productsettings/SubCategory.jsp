<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<%@page import="com.controlcentre.settings.productsettings.productmaster.ClsProductMasterDAO"%>
<%ClsProductMasterDAO DAO= new ClsProductMasterDAO(); %>
<jsp:include page="../../../../includes.jsp"></jsp:include>
<style>
/* =========================================================
   SCOPED UI: Modern Layout Adapted for Table Structure
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

#frmsubCategory input[type="text"],
#frmsubCategory select,
.textbox { 
    height: 24px !important; 
    border: 1px solid #b8c6d8; 
    border-radius: 3px; 
    padding: 2px 6px;
    font-size: 12px;
    font-family: Arial, sans-serif;
    box-sizing: border-box; 
    background-color: #fff; 
    color: #333;
    box-shadow: none !important;
    outline: none;
}

#frmsubCategory input[type="text"]:focus,
#frmsubCategory select:focus,
.textbox:focus { 
    border-color: #007bff; 
}

#frmsubCategory input[readonly],
#frmsubCategory input:disabled,
#frmsubCategory select:disabled,
.textbox[readonly] { 
    background-color: #f8f9fa; 
    color: #6b7280;
}

form label.error {
    color: red;
    font-weight: bold;
    font-size: 11px;
    font-family: Arial, sans-serif;
}

.myButton, .btn {
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
    display: inline-block;
    box-sizing: border-box;
}

.myButton:hover, .btn:hover { 
    background: linear-gradient(135deg, #083a8a 0%, #1d4ed8 100%); 
}

.hidden-scrollbar {
    overflow-y: auto;
    height: calc(100vh - 100px);
    padding-right: 5px;
    overflow-x: hidden;
}
.hidden-scrollbar::-webkit-scrollbar { width: 6px; }
.hidden-scrollbar::-webkit-scrollbar-thumb { background: #c5d3e0; border-radius: 3px; }

/* Grid Containers */
.grid-container {
    border: 1px solid #c5d3e0;
    border-radius: 4px;
    background: #fff;
    overflow: hidden;
}

/* JQX Widget Overrides for 24px Alignment */
.jqx-datetimeinput-input { 
    height: 24px !important; 
    line-height: 24px !important; 
    margin-top: 0px !important; 
    padding-top: 0px !important;
    box-sizing: border-box !important;
    font-size: 12px !important;
}
.jqx-action-button {
    height: 24px !important;
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

.modern-ui .field-row { 
    display: flex;
    align-items: center; 
    gap: 8px;
    margin-bottom: 10px; 
    flex-wrap: nowrap; /* Prevent wrapping */
}

.modern-ui .lbl-right { 
    text-align: right; 
    color: #444;
    font-size: 12px; 
    font-weight: bold;
    white-space: nowrap; 
    padding-right: 5px;
    flex-shrink: 0; /* Keep labels from squishing */
}

.modern-ui .input-search-container {
    position: relative;
    display: flex;
    flex-shrink: 0;
}
.modern-ui .input-search-container input {
    padding-right: 25px !important;
    width: 100%;
    box-sizing: border-box;
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
</style>
<script type="text/javascript">
      $(document).ready(function () { 
    	  $('#btnSearch').attr('disabled', true);
    	  $("#date").jqxDateTimeInput({ width : '125px', height : '15px', formatString : "dd.MM.yyyy" });  
     
    	    document.getElementById("formdet").innerText="SubCategory(SCAT)";
			document.getElementById("formdetail").value="SubCateGory";
			document.getElementById("formdetailcode").value="SCAT";
			window.parent.formCode.value="SCAT";
			window.parent.formName.value="SubCateGory";
          var data= '<%=DAO.prdsubcategoryLoad(session) %>';
              
              var num = 0; 
              var source =
              {
                  datatype: "json",
                  datafields: [
                            	{name : 'doc_no' , type: 'int' },
       						{name : 'subcategory', type: 'String'  },
                            	{name : 'date', type: 'date'  },
                            	{name : 'category',type:'String'},
                            	{name : 'catid',type:'String'}
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
      


              $("#jqxCategory").jqxGrid(
                      {
                      	width: '70%',
                          height: 350,
                          source: dataAdapter,
                          showfilterrow: true,
                          filterable: true,
                          selectionmode: 'multiplecellsextended',
                        //  pagermode: 'default',
                          sortable: true,
                          //pageable: true,
                          altrows:true,
                          //Add row method
                          columns: [
          					{ text: 'Doc No',filtertype: 'number', datafield: 'doc_no', width: '15%' },
          					/* { text: 'Brand ID',columntype: 'textbox', filtertype: 'input', datafield: 'brandid', width: '30%' }, */
          					{ text: 'Sub Cateogry',columntype: 'textbox', filtertype: 'input', datafield: 'subcategory', width: '30%' },
          					{ text: 'Date',columntype: 'textbox',filtertype: 'input',datafield:'date',width: '15%',cellsformat:'dd.MM.yyyy'},
          					{ text: 'Category',columntype: 'textbox', filtertype: 'input', datafield: 'category', width: '40%' },

          	              ]
                      });

              $('#jqxCategory').on('rowdoubleclick', function (event) 
              		{
  		            	var rowindex1=event.args.rowindex;
  		                document.getElementById("docno").value= $('#jqxCategory').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
  		                document.getElementById("subcat").value = $("#jqxCategory").jqxGrid('getcellvalue', rowindex1, "subcategory");
  		              $('#frmsubCategory select').attr('disabled', false);
  		    		$('#date').jqxDateTimeInput({disabled: false});
  		                $("#date").jqxDateTimeInput('val',$("#jqxCategory").jqxGrid('getcellvalue', rowindex1, "date"));
  		               // $('#brandid').val($("#jqxModelSearch").jqxGrid('getcellvalue', rowindex1, "brandid")) ;
  		                $('#category').val($("#jqxCategory").jqxGrid('getcellvalue', rowindex1, "catid")) ;
  		              $('#frmsubCategory select').attr('disabled', true);
  		    		$('#date').jqxDateTimeInput({disabled: true});
              		 }); 
              $("#jqxCategory").jqxGrid('hidecolumn', 'brandid'); 
              //$("#jqxModelSearch").jqxGrid('hidecolumn', 'brandid'); 

          });
    
      function funSearchLoad(){
			changeContent('modelSearch.jsp', $('#window')); 
		 }

	function funReadOnly() {
		$('#frmsubCategory input').attr('readonly', true);
		$('#frmsubCategory select').attr('disabled', true);
		$('#date').jqxDateTimeInput({disabled: true});
		/* $('#jqxDateTimeInput').jqxDateTimeInput({ disabled: true}); */
		
	}
	function funRemoveReadOnly() {
		$('#frmsubCategory input').attr('readonly', false);
		$('#frmsubCategory select').attr('disabled', false);
		$('#date').jqxDateTimeInput({disabled: false});
		$('#docno').attr('readonly', true);
		

	}

	function getCategory() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				items = x.responseText;
				items = items.split('####');
				var brandItems = items[0].split(",");
				var brandidItems = items[1].split(",");
				var optionsbrand = '<option value="">--Select--</option>';
				for (var i = 0; i < brandItems.length; i++) {
					optionsbrand += '<option value="' + brandidItems[i] + '">'
							+ brandItems[i] + '</option>';
				}
				$("select#category").html(optionsbrand);
				$('#category').val($('#catid').val());
				} else {
			}
		}
		x.open("GET", "getCategory.jsp", true);
		x.send();
	}
	
	function funFocus(){
		document.getElementById("subcat").focus();
	}
	 $(function(){
	        $('#frmsubCategory').validate({
	                 rules: {
	                 brand:{
	                	 required:true
	                 },
	                 model:{
	                	 required:true,
	                	 maxlength:20
	                 }
	                 },
	                 messages: {
	                  brand:{
	                	  required:" *"
	                  },
	                  model:{
	                	  required:" *",
	                	  maxlength:"max 20 chars"
	                  }
	                 }
	        });});
	     function funNotify(){
	    	
	    		return 1;
		} 
	     
	function setValues() {
		//$('#brand').val($('#brandid').val());
if ($('#brandid').val() != null) {
	//alert("ghcj");
			$('#category').val($('#catid').val());
}
if($('#msg').val()!=""){
	   $.messager.alert('Message',$('#msg').val());
	  }
	}
</script>
</head>
<body onLoad="getCategory();setValues();">

<!-- JQX input alignment fix -->
<script type="text/javascript">
    $(document).ready(function() {
         setTimeout(function () {
             $("#date").find("input").css({
                 "margin-top": "0px",
                 "line-height": "24px",
                 "font-size": "12px", 
                 "font-family": "Arial, sans-serif", 
                 "padding": "0 6px", 
                 "box-sizing":"border-box"
             });
             $("#date").find(".jqx-action-button").css({
                 "top": "0px",
                 "height": "24px"
             });
         }, 0);
         
         $("#date").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
    });
</script>

<div id="mainBG" class="homeContent" data-type="background">
<form id="frmsubCategory" action="savepscmAction" autocomplete="off">
    <jsp:include page="../../../../header.jsp" />

    <div class='modern-ui hidden-scrollbar'>
        
        <!-- Sub Category Details -->
        <div class="middle-panel">
            <span class="middle-panel-title">Sub Category Details</span>
            
            <div class="field-row">
                <label class="lbl-right" style="width:80px; flex-shrink:0;">Date</label>
                <div style="width: 125px; flex-shrink:0;">
                    <div id="date" name="date" value='<s:property value="date"/>'></div>
                </div>
                
                <label class="lbl-right" style="width:80px; flex-shrink:0; margin-left: auto;">Doc No.</label>
                <input type="text" name="docno" id="docno" value='<s:property value="docno"/>' readonly tabindex="-1" style="width:150px; flex-shrink:0;">
            </div>

            <div class="field-row" style="margin-bottom:0;">
                <label class="lbl-right" style="width:80px; flex-shrink:0;">Category</label>
                <select name="category" id="category" style="width:200px; flex-shrink:0;"></select>
                
                <label class="lbl-right" style="width:80px; flex-shrink:0; margin-left: 15px;">Sub Category</label>
                <input type="text" name="subcat" id="subcat" value='<s:property value="subcat"/>' style="flex:1; min-width:0;">
            </div>
        </div>

        <!-- Details Grid -->
        <div class="middle-panel">
            <span class="middle-panel-title">Sub Category Search Results</span>
            <div class="grid-container">
                <div id="jqxCategory"></div>
            </div> 
        </div>

        <!-- Hidden Inputs -->
        <div style="display:none;">
            <input type="hidden" id="catid" name="catid" value='<s:property value="catid"/>'>
            <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>' /> 
            <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>' />
            <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>' />
        </div>

    </div>
</form>
</div>
</body>
</html>