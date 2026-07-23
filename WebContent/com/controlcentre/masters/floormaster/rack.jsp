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

#frmRack input[type="text"],
#frmRack select,
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
    width: 100%;
}

#frmRack input[type="text"]:focus,
#frmRack select:focus,
.textbox:focus { 
    border-color: #007bff; 
}

#frmRack input[readonly],
#frmRack input:disabled,
#frmRack select:disabled,
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
    	 $("#rackDate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"}); 
    	 
    	 $('#floorDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Floor Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#floorDetailsWindow').jqxWindow('close'); 

  		 document.getElementById("formdet").innerText="Rack(RCK)";
		 document.getElementById("formdetail").value="Rack";
		 document.getElementById("formdetailcode").value="RCK";
		 window.parent.formCode.value="RCK"; 
		 
		 $('#txtfloorname').dblclick(function(){
		     FloorSearchContent("floorDetailsSearch.jsp");
		 });
     });
    
    function FloorSearchContent(url) {
		$('#floorDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#floorDetailsWindow').jqxWindow('setContent', data);
		$('#floorDetailsWindow').jqxWindow('bringToFront');
	}); 
	} 
    
    function getRackIDAlreadyExists(value){
  		var x=new XMLHttpRequest();
  		x.onreadystatechange=function(){
  		if (x.readyState==4 && x.status==200)
  			{
  			 	var items=x.responseText;
  			 	if(items.trim()!='undefine'){
  			 		document.getElementById("txtrackcode").focus();
  			 		document.getElementById("errormsg").innerText="Rack Code Already Exists";
  			 	}
  			 	else{
  			 		document.getElementById("errormsg").innerText="";
  			 	  }
  			    }
  		       else
  			      {}
        }
        x.open("GET","getRackIDAlreadyExists.jsp?code="+value+"&doc="+document.getElementById("docno").value,true);
        x.send();
      }
    
    function getFloor(event){
        var x= event.keyCode;
        if(x==114){
        	FloorSearchContent("floorDetailsSearch.jsp");
        }
        else{}
        }
    
  function funFocus()
  {
	  document.getElementById("txtfloorname").focus(); 	    		
  }
  
  $(function(){
      $('#frmRack').validate({
      	 rules: {
      			    txtrackcode:{"required":true,maxlength:5},
      				txtrackname:"required"
	                 },
	                 messages: {
	                 txtrackcode:{required:" *",maxlength:"Max 5 chars"},
	                 txtrackname:" *"
	                 }
      });});
  
   function funNotify(){
	     floor=document.getElementById("txtfloorcode").value;
		 if(floor==""){
			 document.getElementById("errormsg").innerText="Floor is Mandatory.";
			 return 0;
		 }
		 
		document.getElementById("errormsg").innerText="";
  		return 1;
	} 
   
   
   function funSearchLoad(){
		changeContent('rackMainSearch.jsp');
   }
 
	function funReadOnly(){
		 $('#frmRack input').attr('readonly', true );
		 $('#rackDate').jqxDateTimeInput({ disabled: true}); 
	}
	
	function funRemoveReadOnly(){
		$('#frmRack input').attr('readonly', false );
		$('#rackDate').jqxDateTimeInput({ disabled: false});
		$('#docno').attr('readonly', true);
		$('#txtfloorname').attr('readonly', true );
		
		if ($("#mode").val() == "A") {
			$('#rackDate').val(new Date());
		}
	}
	
    function setValues(){
    	 if($('#hidrackDate').val()){
			 $("#rackDate").jqxDateTimeInput('val', $('#hidrackDate').val());
		  }
	  
	  if($('#msg').val()!=""){
		   $.messager.alert('Message',$('#msg').val());
		  }
	  
	  	document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
	  	funSetlabel();

    }
    
</script>
</head>
<body onLoad="setValues();">

<!-- JQX input alignment fix -->
<script type="text/javascript">
    $(document).ready(function() {
         setTimeout(function () {
             $("#rackDate").find("input").css({
                 "margin-top": "0px",
                 "line-height": "24px",
                 "font-size": "12px", 
                 "font-family": "Arial, sans-serif", 
                 "padding": "0 6px", 
                 "box-sizing":"border-box"
             });
             $("#rackDate").find(".jqx-action-button").css({
                 "top": "0px",
                 "height": "24px"
             });
         }, 0);
         
         $("#rackDate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
    });
</script>

<div id="mainBG" class="homeContent" data-type="background">
<form id="frmRack" action="saveActionRack" autocomplete="off">
    <jsp:include page="../../../../header.jsp" />

    <div class='modern-ui hidden-scrollbar'>
        
        <!-- Rack Details -->
        <div class="middle-panel">
            <span class="middle-panel-title">Rack Details</span>
            
            <div class="field-row">
                <label class="lbl-right" style="width:80px; flex-shrink:0;">Date</label>
                <div style="width: 125px; flex-shrink:0;">
                    <div id="rackDate" name="rackDate" value='<s:property value="rackDate"/>'></div>
                    <input type="hidden" id="hidrackDate" name="hidrackDate" value='<s:property value="hidrackDate"/>'/>
                </div>
                
                <label class="lbl-right" style="width:80px; flex-shrink:0; margin-left: auto;">Doc No.</label>
                <input type="text" id="docno" name="txtrackdocno" value='<s:property value="txtrackdocno"/>' tabindex="-1" readonly style="width:150px; flex-shrink:0;">
            </div>

            <div class="field-row">
                <label class="lbl-right" style="width:80px; flex-shrink:0;">Floor</label>
                <div class="input-search-container" style="flex:1; min-width:0; max-width:400px;">
                    <input type="text" id="txtfloorname" name="txtfloorname" placeholder="Press F3" value='<s:property value="txtfloorname"/>' onkeydown="getFloor(event);"/>
                    <svg class="magnifier-icon" onclick="FloorSearchContent('floorDetailsSearch.jsp');" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                </div>
                <input type="hidden" id="txtfloorcode" name="txtfloorcode" value='<s:property value="txtfloorcode"/>'/>
            </div>

            <div class="field-row" style="margin-bottom:0;">
                <label class="lbl-right" style="width:80px; flex-shrink:0;">Code</label>
                <input type="text" id="txtrackcode" name="txtrackcode" onblur="getRackIDAlreadyExists(this.value);" value='<s:property value="txtrackcode"/>' style="width:150px; flex-shrink:0;">
                
                <label class="lbl-right" style="width:80px; flex-shrink:0; margin-left: 15px;">Name</label>
                <input type="text" id="txtrackname" name="txtrackname" value='<s:property value="txtrackname"/>' style="flex:1; min-width:0;">
            </div>
        </div>

        <!-- Hidden Inputs -->
        <div style="display:none;">
            <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>
            <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'>
            <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
        </div>

    </div>
</form>

<div id="floorDetailsWindow"><div></div></div>
</div>
</body>
</html>