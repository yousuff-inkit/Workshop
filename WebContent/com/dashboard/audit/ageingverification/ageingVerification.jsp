<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  

<style type="text/css">
/* ===== MASTER LAYOUT (Modern Flexbox) ===== */
html, body, #mainBG {
    height: 100%;
    margin: 0;
    overflow: hidden;
    background-color: #f4f7f9;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

.master-container {
    display: flex;
    width: 100%;
    height: 100vh;
}

/* ===== LEFT SIDEBAR ===== */
.sidebar-filters {
    width: 300px; 
    flex: 0 0 300px; 
    background: #f4f7f9;
    border-right: 1px solid #e1e8ed;
    display: flex;
    flex-direction: column;
    height: 100%;
    box-shadow: 2px 0 8px rgba(0,0,0,.05);
    z-index: 10;
}

.sidebar-scroll-content {
    flex: 1;
    overflow-y: auto;
    padding: 12px; 
}

/* Cards */
.filter-card {
    background: #ffffff;
    border: 1px solid #e2e8f0;
    border-radius: 6px;
    padding: 15px;
    margin-bottom: 12px;
}

/* Tables & Spacing */
.release-filter-table {
    width: 100%;
    border-collapse: collapse;
}

.release-filter-table td {
    padding: 6px 2px; 
    vertical-align: middle;
}

.release-filter-table .label-cell {
    text-align: right;
    padding-right: 10px;
    font-size: 12px !important; 
    color: #4b5563;
    font-weight: normal;
    width: 80px; 
}

/* ===== UNIFORM INPUTS & SELECTS (Fixes pink background & text styling) ===== */
input[type="text"], select, textarea,
.release-filter-table input[type="text"],
.release-filter-table select,
.release-filter-table textarea {
    width: 100%;
    height: 24px;             
    padding: 2px 6px;         
    border: 1px solid #cbd5e1 !important;
    border-radius: 3px;       
    font-size: 12px !important; 
    background-color: #ffffff !important; 
    color: #333333 !important; 
    box-sizing: border-box;
    font-family: inherit;
    outline: none;
}

select:focus, input[type="text"]:focus, textarea:focus {
    border-color: #3b82f6 !important;
    box-shadow: 0 0 0 1px rgba(59, 130, 246, 0.1);
}

.release-filter-table textarea {
    height: auto;
    resize: none;
    margin-top: 4px;
}

/* Readonly / disabled look */
input[readonly], input:disabled, textarea[readonly],
.release-filter-table input[readonly], .release-filter-table select:disabled {
    background-color: #f8fafc !important;
    color: #6b7280 !important;
    border-color: #e2e8f0 !important;
}

/* jqx date/time containers */
.release-filter-table div[id^="uptodate"] {
    width: 100% !important;
    height: 24px !important;
}

/* Checkbox and Radio layout */
.radio-group, .checkbox-group {
    display: flex;
    align-items: center;
    gap: 12px;
    font-size: 12px !important;
    color: #333;
    height: 24px;
    flex-wrap: wrap;
}
.radio-group label, .checkbox-group label {
    display: flex;
    align-items: center;
    cursor: pointer;
    margin: 0;
}
.radio-group input[type="radio"], .checkbox-group input[type="checkbox"] {
    margin: 0 4px 0 0;
    padding: 0;
}

/* ===== BUTTONS ===== */
.release-actions {
    margin-top: 15px;
    display: flex;
    flex-direction: column;
    gap: 8px;
    border-top: 1px solid #e3e8ee;
    padding-top: 15px;
}

.btn-submit {
    width: 100%;
    height: 32px;            
    background: #2563eb;
    color: #ffffff;
    border: none;
    border-radius: 4px;      
    font-size: 12px !important;
    font-weight: 600;
    cursor: pointer;
    transition: background 0.2s;
}

.btn-submit:hover {
    background: #1d4ed8;
}

.btn-submit:disabled {
    background: #9ca3af;
    cursor: not-allowed;
}

/* Labels specifically requested */
#lblaccountno, #lblaccountname {
    font-size: 12px !important;
    font-family: inherit;
    color: #3b82f6; /* Modern primary blue instead of old purple */
    font-weight: 600;
    word-wrap: break-word;
}

/* ===== RIGHT CONTENT AREA ===== */
.main-content-area {
    flex: 1;
    display: flex;
    flex-direction: column;
    background: #ffffff;
    height: 100%;
    overflow: hidden;
}

.top-toolbar-container {
    width: 100%;
    padding: 10px 15px;
    background: #ffffff;
    border-bottom: 1px solid #e1e8ed;
    box-sizing: border-box;
}

.grid-content-container {
    flex: 1;
    padding: 15px;
    overflow: auto; 
    box-sizing: border-box;
    display: flex;
    flex-direction: column;
    gap: 15px;
}
</style>

<script type="text/javascript">

	$(document).ready(function () {
		 $("#branchlabel").css("opacity","0");$("#branchdiv").css("opacity","0");
		
		 $("#uptodate").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"dd.MM.yyyy"});
		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	     
	     document.getElementById("rdcurrentageing").checked=true;
	     document.getElementById("lblaccountno").innerText="";
		 document.getElementById("lblaccountname").innerText="";
		 $('#btnRemoveApplying').attr('disabled',true);
	     $('#uptodate').jqxDateTimeInput({disabled: true});
	     $("#ageingDifferenceGridID").jqxGrid({ disabled: true});
	     
	});
	
	function radioClick(){
		 if(document.getElementById("rdageing").checked==true){
			 $('#uptodate').jqxDateTimeInput({disabled: false});
		 } else{
			 $('#uptodate').jqxDateTimeInput({disabled: true});
		 }	 
	 }
	
	function  funClearInfo(){
	    $('#uptodate').val(new Date());
		document.getElementById("cmbtype").value="AR";
		document.getElementById("rdcurrentageing").checked=true;
		document.getElementById("lblaccountno").innerText="";
		document.getElementById("lblaccountname").innerText="";
		$('#btnRemoveApplying').attr('disabled',true);
		$('#uptodate').jqxDateTimeInput({disabled: true});
		$("#ageingVerificationGridID").jqxGrid('clear');
		$("#ageingDifferenceGridID").jqxGrid('clear');
	    $("#ageingDifferenceGridID").jqxGrid({ disabled: true});
	}
		
	function funreload(event){
		 var uptodate = $('#uptodate').val();
		 var atype = $('#cmbtype').val();
		 
		 if($('#cmbtype').val()==''){
			 $.messager.alert('Message','Please Choose Account Type.','warning');
			 return 0;
		 }
		 
		 var check = "1";
		 
		 document.getElementById("lblaccountno").innerText="";document.getElementById("lblaccountname").innerText="";$('#btnRemoveApplying').attr('disabled',true);
		 $("#ageingDifferenceGridID").jqxGrid('clear');$("#ageingDifferenceGridID").jqxGrid({ disabled: true});

		 $("#overlay, #PleaseWait").show();
		 
		 if(document.getElementById("rdageing").checked==true){
		 	$("#ageingVerificationDiv").load("ageingVerificationGrid.jsp?rpttype=2&atype="+atype+'&uptodate='+uptodate+'&check='+check);
		 } else {
			$('#uptodate').jqxDateTimeInput({disabled: false});
			uptodate = $('#uptodate').val();
			$("#ageingVerificationDiv").load("ageingVerificationGrid.jsp?rpttype=1&atype="+atype+'&uptodate='+uptodate+'&check='+check);
			$('#uptodate').jqxDateTimeInput({disabled: true});
		 }
	}
	
	function setValues(){
		  if($('#hiduptodate').val()){
				 $("#uptodate").jqxDateTimeInput('val', $('#hiduptodate').val());
		  }
		  
		  if($('#msg').val()!=""){
			 $.messager.alert('Message',$('#msg').val());
			 document.getElementById("cmbtype").value=document.getElementById("hidcmbtype").value;
			 funreload(event);
		  }
	}
	
	function funNotify(){
		
		  var rows = $("#ageingDifferenceGridID").jqxGrid('getrows');                    
     	  if(rows.length==0){
     		 $.messager.alert('Warning','Nothing to Remove.');
     		 document.getElementById("lblaccountno").innerText="";document.getElementById("lblaccountname").innerText="";$('#btnRemoveApplying').attr('disabled',true);
   		     $("#ageingDifferenceGridID").jqxGrid('clear');$("#ageingDifferenceGridID").jqxGrid({ disabled: true});
     		 return false;
     	  }
     	  
		   $.messager.confirm('Confirm', 'Do you want to Remove?', function(r){
	  	 		if (r){
	  	 				
		    	/* Ageing Difference Grid Removing */
		    	 var rows = $("#ageingDifferenceGridID").jqxGrid('getrows');
		    	 var length=0;
				 for(var i=0 ; i < rows.length ; i++){
					var chk=rows[i].tranid;
					if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){
						newTextBox = $(document.createElement("input"))
					    .attr("type", "dil")
					    .attr("id", "test"+length)
					    .attr("name", "test"+length)
					    .attr("hidden", "true");
						length=length+1;
						
					
						newTextBox.val(rows[i].tranid+"::"+rows[i].acno+"::"+rows[i].out_amount+"::"+rows[i].applied+"::"+rows[i].id+"::"+rows[i].brhid+"::"+rows[i].currency);
						newTextBox.appendTo('form');
					}
				 }
				 $('#gridlength').val(length);
				 /* Ageing Difference Grid Removing Ends */
		 		 
				 $('#uptodate').jqxDateTimeInput({disabled: false});
				 $('#mode').val('A');$("#overlay, #PleaseWait").show();
				 document.getElementById("frmDashboardAgeingVerification").submit();
				 
	  	 		 }
	  	 		});	
	}
	
</script>
</head>
<body onload="setValues();">
<form id="frmDashboardAgeingVerification" action="saveDashboardAgeingVerification" method="post">
<div id="mainBG" class="homeContent" data-type="background"> 
    <div class="master-container">

        <!-- Sidebar / Filter Section -->
        <div class="sidebar-filters">
            <div class="sidebar-scroll-content">
                <div class="filter-card">
                    <table class="release-filter-table">
                        <tr>
                            <td class="label-cell">Up To</td>
                            <td>
                                <div id="uptodate" name="uptodate" value='<s:property value="uptodate"/>'></div>
                                <input type="hidden" id="hiduptodate" name="hiduptodate" value='<s:property value="hiduptodate"/>'/>
                            </td>
                        </tr>
                        <tr>
                            <td class="label-cell">Type</td>
                            <td>
                                <select id="cmbtype" name="cmbtype" value='<s:property value="cmbtype"/>'>
                                    <option value="AR" selected>AR</option>
                                    <option value="AP">AP</option>
                                </select>
                                <input type="hidden" id="hidcmbtype" name="hidcmbtype" value='<s:property value="hidcmbtype"/>'/>
                            </td>
                        </tr>
                        <tr>
                            <td class="label-cell">Report Type</td>
                            <td>
                                <div class="radio-group">
                                    <label><input type="radio" id="rdcurrentageing" name="rdo" onclick="radioClick();" value="rdcurrentageing">Current Ageing</label>
                                    <label><input type="radio" id="rdageing" name="rdo" onclick="radioClick();" value="rdageing">Ageing</label>
                                </div>
                            </td>
                        </tr>
                    </table>

                    <div class="release-actions">
                        <button type="button" class="btn-submit" name="clear" id="clear" onclick="funClearInfo();">Clear</button>
                        <button type="button" class="btn-submit" id="btnRemoveApplying" name="btnRemoveApplying" onclick="funNotify();">Remove</button>
                    </div>

                    <!-- Selected Account Information display -->
                    <div style="margin-top: 20px; padding: 10px; background: #f8fafc; border: 1px dashed #cbd5e1; border-radius: 4px;">
                        <div style="min-height: 20px;"><label id="lblaccountno" name="lblaccountno"><s:property value="lblaccountno"/></label></div>
                        <div style="min-height: 20px; margin-top: 5px;"><label id="lblaccountname" name="lblaccountname"><s:property value="lblaccountname"/></label></div>
                    </div>

                    <!-- Hidden Elements -->
                    <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
                    <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
                    <input type="hidden" id="gridlength" name="gridlength" />
                </div>
            </div>
        </div>

        <!-- Main Grid / Data Section -->
        <div class="main-content-area">
            
            <div class="top-toolbar-container">
                <jsp:include page="../../heading.jsp"></jsp:include>
            </div>

            <div class="grid-content-container">
                <div id="ageingVerificationDiv" style="flex: 1; min-height: 300px;"><jsp:include page="ageingVerificationGrid.jsp"></jsp:include></div>
                <div id="ageingDifferenceDiv" style="flex: 1; min-height: 200px;"><jsp:include page="ageingDifferenceGrid.jsp"></jsp:include></div>
            </div>

        </div>

        <!-- Modals -->
        <div id="accountDetailsWindow">
            <div></div><div></div>
        </div>

    </div> 
</div> 
</form> 
</body>
</html>