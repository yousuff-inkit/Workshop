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

#frmFloor input[type="text"],
#frmFloor select,
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

#frmFloor input[type="text"]:focus,
#frmFloor select:focus,
.textbox:focus { 
    border-color: #007bff; 
}

#frmFloor input[readonly],
#frmFloor input:disabled,
#frmFloor select:disabled,
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
</style>
<script type="text/javascript">
      $(document).ready(function () {  
          $("#floorDate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"}); 
	      
	      document.getElementById("formdet").innerText="Floor(FLR)";
		  document.getElementById("formdetail").value="Floor";
		  document.getElementById("formdetailcode").value="FLR";
		  window.parent.formCode.value="FLR";
      });
  
      function getFloorIDAlreadyExists(value){
  		var x=new XMLHttpRequest();
  		x.onreadystatechange=function(){
  		if (x.readyState==4 && x.status==200)
  			{
  			 	var items=x.responseText;
  			 	if(items.trim()!='undefine'){
  			 		document.getElementById("txtfloorcode").focus();
  			 		document.getElementById("errormsg").innerText="Floor Code Already Exists";
  			 	}
  			 	else{
  			 		document.getElementById("errormsg").innerText="";
  			 	  }
  			    }
  		       else
  			      {}
        }
        x.open("GET","getFloorIDAlreadyExists.jsp?code="+value+"&doc="+document.getElementById("docno").value,true);
        x.send();
      }
      
  function funFocus()
  {
	  document.getElementById("txtfloorcode").focus(); 	    		
  }
  
  $(function(){
      $('#frmFloor').validate({
      	 rules: {
      				txtfloorcode:{"required":true,maxlength:5},
      				txtfloorname:"required"
	                 },
	                 messages: {
	                 txtfloorcode:{required:" *",maxlength:"Max 5 chars"},
	                 txtfloorname:" *"
	                 }
      });});
  
   function funNotify(){
  		return 1;
	} 
   
   
   function funSearchLoad(){
		changeContent('floorMainSearch.jsp');
   }
 
	function funReadOnly(){
		 $('#frmFloor input').attr('readonly', true );
		 $('#floorDate').jqxDateTimeInput({ disabled: true}); 
	}
	
	function funRemoveReadOnly(){
		$('#frmFloor input').attr('readonly', false );
		$('#floorDate').jqxDateTimeInput({ disabled: false}); 
		$('#docno').attr('readonly', true);
		
		if ($("#mode").val() == "A") {
			$('#floorDate').val(new Date());
		}
	}
	
    function setValues(){
    	 if($('#hidfloorDate').val()){
			 $("#floorDate").jqxDateTimeInput('val', $('#hidfloorDate').val());
		  }
	  
	  if($('#msg').val()!=""){
		   $.messager.alert('Message',$('#msg').val());
		  }
	  
	  	document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
	  	funSetlabel();

    }
 </script> 
</head>
<body onload="setValues();">

<!-- JQX input alignment fix -->
<script type="text/javascript">
    $(document).ready(function() {
         setTimeout(function () {
             $("#floorDate").find("input").css({
                 "margin-top": "0px",
                 "line-height": "24px",
                 "font-size": "12px", 
                 "font-family": "Arial, sans-serif", 
                 "padding": "0 6px", 
                 "box-sizing":"border-box"
             });
             $("#floorDate").find(".jqx-action-button").css({
                 "top": "0px",
                 "height": "24px"
             });
         }, 0);
         
         $("#floorDate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
    });
</script>

<div id="mainBG" class="homeContent" data-type="background">
<form id="frmFloor" action="saveActionFloor" autocomplete="off">
    <jsp:include page="../../../../header.jsp" />

    <div class='modern-ui hidden-scrollbar'>
        
        <!-- Floor Details -->
        <div class="middle-panel">
            <span class="middle-panel-title">Floor Details</span>
            
            <div class="field-row">
                <label class="lbl-right" style="width:80px; flex-shrink:0;">Date</label>
                <div style="width: 125px; flex-shrink:0;">
                    <div id="floorDate" name="floorDate" value='<s:property value="floorDate"/>'></div>
                    <input type="hidden" id="hidfloorDate" name="hidfloorDate" value='<s:property value="hidfloorDate"/>'/>
                </div>
                
                <label class="lbl-right" style="width:80px; flex-shrink:0; margin-left: auto;">Doc No.</label>
                <input type="text" id="docno" name="txtfloordocno" value='<s:property value="txtfloordocno"/>' readonly tabindex="-1" style="width:150px; flex-shrink:0;">
            </div>

            <div class="field-row" style="margin-bottom:0;">
                <label class="lbl-right" style="width:80px; flex-shrink:0;">Code</label>
                <input type="text" id="txtfloorcode" name="txtfloorcode" onblur="getFloorIDAlreadyExists(this.value);" value='<s:property value="txtfloorcode"/>' style="width:150px; flex-shrink:0;">
                
                <label class="lbl-right" style="width:80px; flex-shrink:0; margin-left: 15px;">Name</label>
                <input type="text" id="txtfloorname" name="txtfloorname" value='<s:property value="txtfloorname"/>' style="flex:1; min-width:0;">
            </div>
        </div>

        <!-- Hidden Inputs -->
        <div style="display:none;">
            <input type="hidden" id="mode" name="mode"/>
            <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'>
            <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'>
        </div>

    </div>
</form>
</div>
</body>
</html>