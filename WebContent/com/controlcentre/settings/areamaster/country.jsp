<%@page import="com.controlcentre.settings.areamaster.country.ClsCountryDAO"%>
<%ClsCountryDAO DAO= new ClsCountryDAO();%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<%
String contextPath=request.getContextPath();
%> 
<head>
<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
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
</style>
<script type="text/javascript">
      $(document).ready(function () {          
    	  $("#date_coun").jqxDateTimeInput({ width : '125px', height : 24, formatString : "dd.MM.yyyy", theme: 'energyblue' });  
       	
          /* force internal alignment AFTER render */
 		 setTimeout(function () {
 		 	$("#date_coun").find("input").css({
 		 		"margin-top": "0px",
 		 		"line-height": "24px",
 		 		"font-size": "12px", 
 		 		"font-family": "Arial, sans-serif", 
 		 		"padding": "0 6px", 
 		 		"box-sizing":"border-box"
 		 	});
 		 	$("#date_coun").find(".jqx-action-button").css({
 		 		"top": "0px",
 		 		"height": "24px"
 		 	});
 		 }, 0);

         var data= '<%=DAO.searchDetails()  %>';
        // var data;
               var num = 0; 
              var source =
              {
                  datatype: "json",
                  datafields: [
                            	{name : 'doc_no' , type: 'int' },
                            	{name : 'country_name',type:'String'},
                            	{name : 'country_code',type:'String'},
       						    {name : 'date', type: 'String'  },
                            	{name : 'region', type: 'String'  },
                            	{name : 'reg_id' , type: 'String' }
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
      


              $("#jqxCountrySearch1").jqxGrid(
                      {
                      	width: '100%',
                          height: 350,
                          source: dataAdapter,
                          showfilterrow: true,
                          filterable: true,
                          selectionmode: 'singlerow',
                        //  pagermode: 'default',
                          sortable: true,
                          //pageable: true,
                          altrows:true,
                          //Add row method
                          columns: [
          					{ text: 'Doc No',filtertype: 'number', datafield: 'doc_no', width: '5%' },
          					{ text: 'Date',columntype: 'textbox',filtertype: 'input',datafield:'date',width: '15%'},
          					{ text: 'Country',columntype: 'textbox', filtertype: 'input', datafield: 'country_name', width: '35%' },
          					{ text: 'Country Code',columntype: 'textbox', filtertype: 'input', datafield: 'country_code', width: '10%' },
          					{ text: 'Region id', datafield: 'reg_id' } ,
          					{ text: 'Region',columntype: 'textbox', filtertype: 'input', datafield: 'region', width: '35%' }
          					/* { text: 'Region id',columntype: 'number', datafield: 'reg_id', width: '5%' } */
          					

          	              ]
                      });

              $('#jqxCountrySearch1').on('rowdoubleclick', function (event) 
              		{
  		            	var rowindex1=event.args.rowindex;
  		                document.getElementById("docno").value= $('#jqxCountrySearch1').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
  		                document.getElementById("country").value = $("#jqxCountrySearch1").jqxGrid('getcellvalue', rowindex1, "country_name");
  		                document.getElementById("contry_code").value = $("#jqxCountrySearch1").jqxGrid('getcellvalue', rowindex1, "country_code");
  		                document.getElementById("region").value = $("#jqxCountrySearch1").jqxGrid('getcellvalue', rowindex1, "reg_id");
  		              $('#frmModel select').attr('disabled', false);
  		    		$('#date_coun').jqxDateTimeInput({disabled: false});
  		                $("#date_coun").jqxDateTimeInput('val',$("#jqxCountrySearch1").jqxGrid('getcellvalue', rowindex1, "date"));
  		               // $('#brandid').val($("#jqxModelSearch").jqxGrid('getcellvalue', rowindex1, "brandid")) ;
  		              //  $('#region').val($("#jqxCountrySearch1").jqxGrid('getcellvalue', rowindex1, "region")) ;
  		              $('#frmModel select').attr('disabled', true);
  		    		$('#date_coun').jqxDateTimeInput({disabled: true});
              		 }); 
              $("#jqxCountrySearch1").jqxGrid('hidecolumn', 'reg_id'); 
              //$("#jqxModelSearch").jqxGrid('hidecolumn', 'brandid'); 

          });
    
      function funSearchLoad(){
			changeContent('countrySearch.jsp', $('#window')); 
		 }

	function funReset() {
		document.getElementById("frmCountry").reset();
		//getRegion();
	}
	function funReadOnly() {
		$('#frmCountry input').attr('readonly', true);
		$('#frmCountry select').attr('disabled', true);
		$('#date_coun').jqxDateTimeInput({disabled: true});
		/* $('#jqxDateTimeInput').jqxDateTimeInput({ disabled: true}); */
		
	}
	function funRemoveReadOnly() {
		 $('#frmCountry input').attr('readonly', false);
		$('#frmCountry select').attr('disabled', false);
		$('#date_coun').jqxDateTimeInput({disabled: false});
		$('#docno').attr('readonly', true);
		if(document.getElementById("mode").value=='A'){
			$('#jqxCountrySearch1').jqxGrid({ disabled: true});
		}
		 
	}

	 function getRegion() {
		 
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
				/* alert("ssss"+optionsbrand); */
				$("select#region").html(optionsbrand);
				$('#region').val($('#reg_id').val());
				} else {
			}
		}
		x.open("GET", "getRegion.jsp", true);
		x.send();
	} 
	
	function funFocus(){
		document.getElementById("region").focus();
	}
	 $(function(){
	        $('#frmCountry').validate({
	                 rules: {
	                	 region:{
	                	 required:true
	                 },
	                 country:{
	                	 required:true,
	                	 maxlength:45
	                 }
	                 },
	                 messages: {
	                	 region:{
	                	  required:" *"
	                  },
	                  country:{
	                	  required:" *",
	                	  maxlength:"max 45 chars"
	                  }
	                 }
	        });});
	     function funNotify(){
	    	
	    		return 1;
		} 
	     
	function setValues() {
		//$('#region').val($('#brandid').val());
if ($('#reg_id').val() != null) {
	//alert("ghcj");
			$('#region').val($('#reg_id').val());
}
if($('#msg').val()!=""){
	   $.messager.alert('Message',$('#msg').val());
	  }
document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
	}
</script>
</head>
<body onLoad="getRegion();funReadOnly();setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmCountry" action="saveCountry" autocomplete="off">
    <script>
        window.parent.formName.value="Country";
        window.parent.formCode.value="COU";
    </script> 
    <jsp:include page="../../../../header.jsp" />
    
    <div class='modern-ui hidden-scrollbar'>
        <div id="errormsg"></div>

        <div class="middle-panel">
            <span class="middle-panel-title">Country Details</span>
            
            <div class="field-row">
                <label class="lbl-right" style="width:80px;">Date</label>
                <div style="width: 125px;">
                    <div id="date_coun" name="date_coun" value='<s:property value="date_coun"/>'></div>
                </div>
                
                <label class="lbl-right" style="width:80px; margin-left:auto;">Doc No</label>
                <input type="text" name="docno" value='<s:property value="docno"/>' id="docno" style="width:125px;" readonly="readonly" tabindex="-1">
            </div>

            <div class="field-row">
                <label class="lbl-right" style="width:80px;">Region</label>
                <select name="region" id="region" style="width:250px;">
                </select>
            </div>

            <div class="field-row" style="margin-bottom:0;">
                <label class="lbl-right" style="width:80px;">Country</label>
                <input type="text" name="country" id="country" style="width:250px;" value='<s:property value="country"/>'>
                
                <label class="lbl-right" style="width:100px; margin-left:auto;">Country Code</label>
                <input type="text" name="contry_code" id="contry_code" style="width:125px;" value='<s:property value="contry_code"/>'>
            </div>
        </div>

        <div class="middle-panel">
            <span class="middle-panel-title">Details</span>
            <div id="jqxCountrySearch1" class="grid-container"></div>
        </div>

        <!-- Hidden Logic Fields -->
        <div style="display:none;">
            <input type="text" id="reg_id" name="reg_id" value='<s:property value="reg_id"/>' hidden="true">
            <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>
            <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
            <input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
        </div>
    </div>
</form>
</div>
</body>
</html>