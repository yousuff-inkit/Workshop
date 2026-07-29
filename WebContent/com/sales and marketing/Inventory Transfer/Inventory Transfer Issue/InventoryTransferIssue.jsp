<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i)</title>
 <jsp:include page="../../../../includes.jsp"></jsp:include> 
<script type="text/javascript">
 
$(document).ready(function() {
	 getfrmBranch(2);
	$("#date").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
	$('#sidesearchwndow').jqxWindow({ width: '30%', height: '90%',  maxHeight: '90%' ,maxWidth: '80%' ,title: 'Search ' , position: { x: 943, y: 0 }, keyboardCloseKey: 27});
	$('#sidesearchwndow').jqxWindow('close'); 
	 $('#branchwindow').jqxWindow({
			width : '25%',
			height : '58%',
			maxHeight : '70%',
			maxWidth : '45%',
			title : 'Branch Search',
			position : {
				x : 420,
				y : 87
			},
			theme : 'energyblue',
			showCloseButton : true,
			keyboardCloseKey : 27
		});
		$('#branchwindow').jqxWindow('close');
	
		
		 $('#locationwindow').jqxWindow({
				width : '25%',
				height : '58%',
				maxHeight : '70%',
				maxWidth : '45%',
				title : 'Location Search',
				position : {
					x : 420,
					y : 87
				},
				theme : 'energyblue',
				showCloseButton : true,
				keyboardCloseKey : 27
			});
			$('#locationwindow').jqxWindow('close');
		
			$( "#brchName" ).change(function() {
				   if(document.getElementById("mode").value=="A"){
					   
					   getfrmBranch(1);
					
				   }
				 });
			
			$( "#cmbreftype" ).change(function() {
				   if(document.getElementById("mode").value=="A"){
					   
					   if(document.getElementById("cmbreftype").value=="ILT"){
					   
					   document.getElementById("txttobranch").value= document.getElementById("txtfrmbranch").value;
						document.getElementById("branchtoid").value=document.getElementById("branchfrmid").value;
					   }
					   else{
						   document.getElementById("txttobranch").value="";
						   document.getElementById("branchtoid").value="";
					   }
					   
				   }
				 });
			
			$('#txttobranch').dblclick(function(){
				if ($("#mode").val() == "view") {
					
					return 0;
					
				}
				if($("#cmbreftype").val()==""){
					document.getElementById("errormsg").innerText="Select an inventory Recept Type";
					return 0;
				}
				else{
					document.getElementById("errormsg").innerText="";
				}
				 if(document.getElementById("cmbreftype").value=="IBT"){
				var branchfrmid=document.getElementById("branchfrmid").value;
			    branchSearchContent('branchSearch.jsp?branchfrmid='+branchfrmid);
				 }
				
			 });
			
			$('#txtfrmlocation').dblclick(function(){
if ($("#mode").val() == "view") {
					
					return 0;
					
				}
				if($("#cmbreftype").val()==""){
					document.getElementById("errormsg").innerText="Select an inventory Recept Type";
					return 0;
				}
				else{
					document.getElementById("errormsg").innerText="";
				}
				var branchid=document.getElementById("branchfrmid").value;
				var searchtype="1";
				locationSearchContent('locationSearch.jsp?branchid='+branchid+'&searchtype='+searchtype);
				
			 });
			
			
			$('#txttolocation').dblclick(function(){
if ($("#mode").val() == "view") {
					
					return 0;
					
				}  
				if($("#cmbreftype").val()==""){
					document.getElementById("errormsg").innerText="Select an inventory Recept Type";
					return 0;
				}
				else{
					document.getElementById("errormsg").innerText="";
				}
				var branchid=document.getElementById("branchtoid").value;
				var searchtype="2";
				locationSearchContent('locationSearch.jsp?branchid='+branchid+'&searchtype='+searchtype+'&cmbreftype='+$("#cmbreftype").val()+'&frmlocation='+document.getElementById("locationfrmid").value);
				
			 });
			
			$('#rrefno').dblclick(function(){
if ($("#mode").val() == "view") {
					
					return 0;
					
				}
				if($("#cmbreftype").val()==""){
					document.getElementById("errormsg").innerText="Select an inventory Recept Type";
					return 0;
				}
				else{
					document.getElementById("errormsg").innerText="";
				}
				$('#refnosearchwindow').jqxWindow('open');
				refsearchContent('refnosearch.jsp');
					
				 
			 });
	
	
	});
	
function productSearchContent(url) {
 	 //alert(url);
 		 $.get(url).done(function (data) {
 			 
 			 $('#sidesearchwndow').jqxWindow('open');
 		$('#sidesearchwndow').jqxWindow('setContent', data);
 
 	}); 
 	} 
	
	
	
function getLocation(event,searchtype){
	if ($("#mode").val() == "view") {
		
		return 0;
		
	}
	if(searchtype=="1"){
		var branchid=document.getElementById("branchfrmid").value;
	}
	if(searchtype=="2"){
		var branchid=document.getElementById("branchtoid").value;
	}
	
	 var x= event.keyCode;
	 if(x==114){
		 locationSearchContent('locationSearch.jsp?branchid='+branchid+'&searchtype='+searchtype+'&cmbreftype='+$("#cmbreftype").val()+'&frmlocation='+document.getElementById("locationfrmid").value);  	 }
	 else{
		 }
    	 }
    	 
function locationSearchContent(url) {
	$('#locationwindow').jqxWindow('open');
	$.get(url).done(function(data) {
		$('#locationwindow').jqxWindow('setContent', data);
		$('#locationwindow').jqxWindow('bringToFront');
	});
}


function getBranch(event,searchtype){
	if ($("#mode").val() == "view") {
		
		return 0;
		
	}
	if($("#cmbreftype").val()==""){
		document.getElementById("errormsg").innerText="Select an inventory Issue Type";
		return 0;
	}
	else{
		document.getElementById("errormsg").innerText="";
	}
	
	 document.getElementById("txttobranch").value="";
	 document.getElementById("branchtoid").value="";
	 //document.getElementById("cmbreftype").value="bt";
	 
	 if(document.getElementById("cmbreftype").value=="IBT"){
		 
	 
	var branchfrmid=document.getElementById("branchfrmid").value;
	 var x= event.keyCode;
	 if(x==114){
		 branchSearchContent('branchSearch.jsp?branchfrmid='+branchfrmid);  	 }
	 else{
		 }
	 }
	 else{
		 document.getElementById("txttobranch").value=document.getElementById("txtfrmbranch").value;
		 document.getElementById("branchtoid").value=document.getElementById("branchfrmid").value;
	 }
	 
   	 }
   	 
function branchSearchContent(url) {
	$('#branchwindow').jqxWindow('open');
	$.get(url).done(function(data) {
		$('#branchwindow').jqxWindow('setContent', data);
		$('#branchwindow').jqxWindow('bringToFront');
	});
}


function funReadOnly(){

	$('#frminventoryissue input').attr('readonly', true );
	
	$('#frminventoryissue select').attr('disabled', true );
	$('#date').jqxDateTimeInput({disabled: true});
	$("#jqxInvIssueGrid").jqxGrid({ disabled: true});
	//$("#jqxserviceGrid").jqxGrid({ disabled: true});

}

function funNotify(){	
	
	
	if($("#cmbreftype").val()==""){
		document.getElementById("errormsg").innerText="Select an inventory Issue Type";
		document.getElementById("cmbreftype").focus();
		return 0;
	}
	
	if($("#txtfrmbranch").val()==""){
		document.getElementById("errormsg").innerText=" Branch Should not be Blank";
		document.getElementById("txtfrmbranch").focus();
		return 0;
	}
	else if($("#txtfrmlocation").val()==""){
		document.getElementById("errormsg").innerText=" Location Should not be Blank";
		document.getElementById("txtfrmlocation").focus();
		return 0;
	}
	else if($("#txttobranch").val()==""){
		document.getElementById("errormsg").innerText=" Branch Should not be Blank";
		document.getElementById("txttobranch").focus();
		return 0;
	}
	else if($("#txttolocation").val()==""){
		document.getElementById("errormsg").innerText=" Location Should not be Blank";
		document.getElementById("txttolocation").focus();
		return 0;
	}
	else{
		document.getElementById("errormsg").innerText="";
	}
	  
	  var rows = $("#jqxInvIssueGrid").jqxGrid('getrows');
	  
	   $('#gridlength').val(rows.length);
	   
	  for(var i=0 ; i < rows.length ; i++){ 
		  
		 
	   newTextBox = $(document.createElement("input"))
	      .attr("type", "dil")
	      .attr("id", "prodg"+i)
	      .attr("name", "prodg"+i)
	      .attr("hidden", "true");
	   //alert(rows[i].prodoc+"::"+rows[i].unitdocno+"::"+rows[i].qty+"::"+rows[i].totwtkg+"::"+rows[i].kgprice+"::"+rows[i].unitprice+"::"+rows[i].total+"::"+rows[i].discper+"::"+rows[i].dis+"::"+rows[i].netotal+"::"+rows[i].specid+"::"+rows[i].outqty+"::"+rows[i].stkid+"::"+rows[i].oldqty+"::"+rows[i].foc+"::");
	   
	  newTextBox.val(rows[i].prodoc+"::"+rows[i].unitdocno+"::"+rows[i].qty+"::"+rows[i].totwtkg+"::"+rows[i].kgprice+"::"+rows[i].unitprice+"::"+rows[i].total+"::"+rows[i].discper+"::"+rows[i].dis+"::"+rows[i].netotal+"::"+rows[i].specid+"::"+rows[i].outqty+"::"+rows[i].stkid+"::"+rows[i].oldqty+"::"+rows[i].foc+"::");
	  newTextBox.appendTo('form');
		    
	  }
	  
	  
  	return 1;
	}


function funRemoveReadOnly(){
	$('#date').jqxDateTimeInput({disabled: false});
	$("#jqxInvIssueGrid").jqxGrid({ disabled: false});
	//$("#jqxserviceGrid").jqxGrid({ disabled: false});
	$('#frminventoryissue select').attr('disabled', false );
		$('#txtremark').attr('readonly', false );
		$('#txtrefno').attr('readonly', false );
		$('#gridtext').attr('readonly', false );
		$('#gridtext1').attr('readonly', false );
		if ($("#mode").val() == "E") {
			$("#roundOf").val("0.0");
			$("#jqxInvIssueGrid").jqxGrid({ disabled: false});
			$("#jqxInvIssueGrid").jqxGrid('addrow', null, {});
		 
		  }
		
		if ($("#mode").val() == "A") {
			$("#prodsearchtype").val("0");
			 getfrmBranch(1);
			$("#orderValue").val("0.0");
			$("#nettotal").val("0.0");
			$("#roundOf").val("0.0");
			$("#orderValue").val("0.0");
			$('#date').val(new Date());
	 
			$("#jqxInvIssueGrid").jqxGrid('clear'); 
			$("#jqxInvIssueGrid").jqxGrid('addrow', null, {});
		}
		
	}

function getfrmBranch(type)
	{
	
	var brchid=$('#brchName').val();
	
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
	if (x.readyState==4 && x.status==200)
	 {
	   var items= x.responseText.trim();
	   var item = items.split('####');
		var branchid  = item[0];
		var branchname = item[2];

		document.getElementById("txtfrmbranch").value=branchname;
		document.getElementById("branchfrmid").value=branchid;
	   
	   }}
	x.open("GET","getFrmBranch.jsp?brchid="+brchid+"&type="+type,true);
	x.send();
	  
	}

function funChkButton(){
	
}

function funFocus (){
	
}

function funSearchLoad(){
	 changeContent('Mastersearch.jsp'); 
}

function setValues() {

	  if($('#hiddate').val()){
			 $("#date").jqxDateTimeInput('val', $('#hiddate').val());
		  }

	var masterdoc_no=$('#masterdoc_no').val().trim();
	var refmasterdocno=0;
	
	 if(masterdoc_no>0){
		 
 
	 if ($('#hidcmbreftype').val() != "" || $('#hidcmbreftype').val() !=null) {
			$('#cmbreftype').val($('#hidcmbreftype').val());
		}
	if($('#msg').val()!=""){
		   $.messager.alert('Message',$('#msg').val());
		  }
		  
		  $("#InvTransIssueGrid").load("InvTransIssueGrid.jsp?qotdoc="+masterdoc_no+"&enqdoc="+refmasterdocno+"&cond=2");
		  
	 }
	 funchkforedit();
}


function set()
{
document.getElementById("errormsg").innerText="";
}

function funPrintBtn(){
	   if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
	  
	   var url=document.URL;

      var reurl=url.split("savetransferIssue");
      
     // $("#docno").prop("disabled", false);                
      

var win= window.open(reurl[0]+"printtransissueAction?docno="+document.getElementById("masterdoc_no").value,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
   
win.focus();
	   } 
	  
	   else {
	    	      $.messager.alert('Message','Select a Document....!','warning');
	    	      return false;
	    	     }
	    	
	}
 

function funchkforedit()
{



	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText.trim();	
			if(parseInt(items)>0)
				{
				
				 $("#btnEdit").attr('disabled', true );
				 $("#btnDelete").attr('disabled', true ); 
				 
				 
				 
				}
			else
				{
				 
				}
		  
			
			
			
		} else {
		}
	}
	x.open("GET", "linkchk.jsp?masterdoc_no="+document.getElementById("masterdoc_no").value, true);
	x.send();    


}

</script>

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

#frminventoryissue input[type="text"],
#frminventoryissue select,
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

#frminventoryissue input[type="text"]:focus,
#frminventoryissue select:focus,
.textbox:focus { 
    border-color: #007bff; 
}

#frminventoryissue input[readonly],
#frminventoryissue input:disabled,
#frminventoryissue select:disabled,
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

</head>
<body onload="setValues();">

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
<form id="frminventoryissue" action="savetransferIssue" method="post" autocomplete="off">
    <jsp:include page="../../../../header.jsp"></jsp:include> 

    <div class='modern-ui hidden-scrollbar'>
        
        <!-- General Info -->
        <div class="middle-panel">
            <span class="middle-panel-title">General Info</span>
            
            <div class="field-row" style="margin-bottom:0;">
                <label class="lbl-right" style="width:80px; flex-shrink:0;">Date</label>
                <div style="width: 125px; flex-shrink:0;">
                    <div id="date" name="date" value='<s:property value="date"/>'></div>
                    <input type="hidden" id="hiddate" name="hiddate" value='<s:property value="hiddate"/>'/>
                </div>
                
                <label class="lbl-right" style="width:80px; flex-shrink:0; margin-left: 15px;">Ref. No.</label>
                <input type="text" id="txtrefno" name="txtrefno" value='<s:property value="txtrefno"/>' style="width:150px; flex-shrink:0;">
                
                <label class="lbl-right" style="width:80px; flex-shrink:0; margin-left: auto;">Doc No.</label>
                <input type="text" id="docno" name="docno" value='<s:property value="docno"/>' tabindex="-1" readonly style="width:150px; flex-shrink:0;">
            </div>
        </div>

        <!-- Dual Panel: Transfer From & Transfer To -->
        <div style="display: flex; gap: 15px; margin-bottom: 15px;">
            
            <!-- Left Panel: Inventory Transfer From -->
            <div class="middle-panel" style="flex: 1; margin-bottom: 0;">
                <span class="middle-panel-title">Inventory Transfer From</span>
                
                <div class="field-row">
                    <label class="lbl-right" style="width:80px; flex-shrink:0;">Type</label>
                    <select id="cmbreftype" name="cmbreftype" onchange="set()" value='<s:property value="cmbreftype"/>' style="width:150px; flex-shrink:0;">
                        <option value="">--select--</option>
                        <option value="IBT">Branch Trasfer</option>
                        <option value="ILT">Location Transfer</option>
                    </select>
                </div>
                
                <div class="field-row">
                    <label class="lbl-right" style="width:80px; flex-shrink:0;">Branch</label>
                    <input type="text" id="txtfrmbranch" name="txtfrmbranch" placeholder="Press F3 to Search" value='<s:property value="txtfrmbranch"/>' style="flex:1; min-width:0;" readonly/>
                </div>
                
                <div class="field-row" style="margin-bottom:0;">
                    <label class="lbl-right" style="width:80px; flex-shrink:0;">Location</label>
                    <div class="input-search-container" style="flex:1; min-width:0;">
                        <input type="text" id="txtfrmlocation" name="txtfrmlocation" placeholder="Press F3" onkeydown="getLocation(event,1);" value='<s:property value="txtfrmlocation"/>'/>
                        <svg class="magnifier-icon" onclick="if($('#mode').val()!='view' && $('#cmbreftype').val()!=''){ locationSearchContent('locationSearch.jsp?branchid='+$('#branchfrmid').val()+'&searchtype=1'); }" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                    </div>
                </div>
            </div>
            
            <!-- Right Panel: Inventory Transfer To -->
            <div class="middle-panel" style="flex: 1; margin-bottom: 0;">
                <span class="middle-panel-title">Inventory Transfer To</span>
                
                <div class="field-row">
                    <label class="lbl-right" style="width:80px; flex-shrink:0;">Branch</label>
                    <div class="input-search-container" style="flex:1; min-width:0;">
                        <input type="text" id="txttobranch" name="txttobranch" placeholder="Press F3" onkeydown="getBranch(event,2);" value='<s:property value="txttobranch"/>'/>
                        <svg class="magnifier-icon" onclick="if($('#mode').val()!='view' && $('#cmbreftype').val()!=''){ if($('#cmbreftype').val()=='IBT') { branchSearchContent('branchSearch.jsp?branchfrmid='+$('#branchfrmid').val()); } }" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                    </div>
                </div>
                
                <div class="field-row">
                    <label class="lbl-right" style="width:80px; flex-shrink:0;">Location</label>
                    <div class="input-search-container" style="flex:1; min-width:0;">
                        <input type="text" id="txttolocation" name="txttolocation" placeholder="Press F3" onkeydown="getLocation(event,2);" value='<s:property value="txttolocation"/>'/>
                        <svg class="magnifier-icon" onclick="if($('#mode').val()!='view' && $('#cmbreftype').val()!=''){ locationSearchContent('locationSearch.jsp?branchid='+$('#branchtoid').val()+'&searchtype=2&cmbreftype='+$('#cmbreftype').val()+'&frmlocation='+$('#locationfrmid').val()); }" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                    </div>
                </div>
                
                <div class="field-row" style="margin-bottom:0;">
                    <label class="lbl-right" style="width:80px; flex-shrink:0;">Remarks</label>
                    <input type="text" id="txtremark" name="txtremark" value='<s:property value="txtremark"/>' style="flex:1; min-width:0;">
                </div>
            </div>
        </div>

        <!-- Details Grid -->
        <div class="middle-panel">
            <span class="middle-panel-title">Issue Details</span>
            <div id="InvTransIssueGrid" class="grid-container">
                <jsp:include page="InvTransIssueGrid.jsp"></jsp:include>
            </div> 
        </div>

        <!-- Hidden Inputs -->
        <div style="display:none;">
            <input type="text" name="gridtext" id="gridtext" value='<s:property value="gridtext"/>' />   
            <input type="text" name="gridtext1" id="gridtext1" value='<s:property value="gridtext1"/>' />
            <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>
            <input type="hidden" id="clientid" name="clientid" value='<s:property value="clientid"/>'/>
            <input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
            <input type="hidden" id="nettotal" name="nettotal" value='<s:property value="nettotal"/>'/>
            <input type="hidden" name="txtdiscount" id="txtdiscount" value='<s:property value="txtdiscount"/>'>
            <input type="hidden" name="txtnettotal" id="txtnettotal" value='<s:property value="txtnettotal"/>'>
            <input type="hidden" id="orderValue" name="orderValue" value='<s:property value="orderValue"/>'/>
            <input type="hidden" name="txtproductamt" id="txtproductamt" value='<s:property value="txtproductamt"/>'>
            <input type="hidden" name="descPercentage" id="descPercentage" value='<s:property value="descPercentage"/>'>
            <input type="hidden" name="prddiscount" id="prddiscount" value='<s:property value="prddiscount"/>'>
            <input type="hidden" name="roundOf" id="roundOf" value='<s:property value="roundOf"/>'>
            <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
            <input type="hidden" id="masterdoc_no" name="masterdoc_no" value='<s:property value="masterdoc_no"/>'/>
            <input type="hidden" id="refmasterdocno" name="refmasterdocno" value='<s:property value="refmasterdocno"/>'/>
            <input type="hidden" id="gridlength" name="gridlength"/>
            <input type="hidden" id="servgridlen" name="servgridlen" value='<s:property value="servgridlen"/>'/>
            <input type="hidden" id="prodsearchtype" name="prodsearchtype" value='<s:property value="prodsearchtype"/>'/>
            <input type="hidden" id="branchfrmid" name="branchfrmid" value='<s:property value="branchfrmid"/>'/>
            <input type="hidden" id="locationfrmid" name="locationfrmid" value='<s:property value="locationfrmid"/>'/>
            <input type="hidden" id="branchtoid" name="branchtoid" value='<s:property value="branchtoid"/>'/>
            <input type="hidden" id="locationtoid" name="locationtoid" value='<s:property value="locationtoid"/>'/>
            <input type="hidden" id="hidcmbreftype" name="hidcmbreftype" value='<s:property value="hidcmbreftype"/>'/>
        </div>

    </div>
</form>
    
<div id="branchwindow"><div></div></div>    
<div id="locationwindow"><div></div></div>
<div id="sidesearchwndow"><div></div></div> 
    
</div>
</body>
</html>