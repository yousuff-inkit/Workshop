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
.myButtons {
	-moz-box-shadow:inset 0px -1px 3px 0px #91b8b3;
	-webkit-box-shadow:inset 0px -1px 3px 0px #91b8b3;
	box-shadow:inset 0px -1px 3px 0px #91b8b3;
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #768d87), color-stop(1, #6c7c7c));
	background:-moz-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-webkit-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-o-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-ms-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:linear-gradient(to bottom, #768d87 5%, #6c7c7c 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#768d87', endColorstr='#6c7c7c',GradientType=0);
	background-color:#768d87;
	border:1px solid #566963;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	
	font-size:8pt;
	
	padding:3px 17px;
	text-decoration:none;
	text-shadow:0px -1px 0px #2b665e;
}
.myButtons:hover {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #6c7c7c), color-stop(1, #768d87));
	background:-moz-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-webkit-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-o-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-ms-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:linear-gradient(to bottom, #6c7c7c 5%, #768d87 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#6c7c7c', endColorstr='#768d87',GradientType=0);
	background-color:#6c7c7c;
}
.myButtons:active {
	position:relative;
	top:1px;
}
.bounce {
	color: #f35626;
    background-image: -webkit-linear-gradient(92deg,#f35626,#feab3a);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    -webkit-animation: hue 60s infinite linear,bounce 2s infinite; 
}

@-webkit-keyframes bounce {
  0%, 20%, 50%, 80%, 100% {
    -moz-transform: translateX(0);
    -ms-transform: translateX(0);
    -webkit-transform: translateX(0);
    transform: translateX(0);
  }
  40% {
    -moz-transform: translateX(-20px);
    -ms-transform: translateX(-20px);
    -webkit-transform: translateX(-20px);
    transform: translateX(-20px);
  }
  60% {
    -moz-transform: translateX(-10px);
    -ms-transform: translateX(-10px);
    -webkit-transform: translateX(-10px);
    transform: translateX(-10px);
  }
} 

@media (min-width: 10px) {
  .mega {
    font-size: 10px;
  }
}

@font-face {
  font-family: 'Roboto',comic sans ms,Tahoma;
  font-style: normal;
  font-weight: 10;
  unicode-range: U+0460-052F, U+20B4, U+2DE0-2DFF, U+A640-A69F;
}
  
@-webkit-keyframes hue {
  from {
    -webkit-filter: hue-rotate(0deg);
  }

  to {
    -webkit-filter: hue-rotate(-360deg);
  }
}
</style>

<script type="text/javascript">

 $(document).ready(function () {
	$("#uptodate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 
	$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");

    var date = $('#uptodate').jqxDateTimeInput('getDate');
	var lastdaydate = new Date(date.getFullYear(), date.getMonth() + 1, 0);
    var lastdaymonthdate=new Date(new Date(lastdaydate).setDate(lastdaydate.getDate()));
    $('#uptodate ').jqxDateTimeInput('setDate', new Date(lastdaymonthdate));
    
    $("#depreciationDetailsGridID").jqxGrid({ disabled: true});$("#depreciationCostRecognizationGridID").jqxGrid({ disabled: true});$('#btnGenerate').attr('disabled', true );
	    
 });

 function getLastMonthDepreciation(date){
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				 items = items.split('***');
			     $('#txtchkgridload').val(items[0]);
			     $('#txtchkdate').val(items[1]);
			     
			     document.getElementById("lbldepreciationstatus").innerText="Depreciation done till "+items[2].trim()+".";
			     
			   if(parseInt($('#txtchkdate').val())==0){
				  if(parseInt($('#txtchkgridload').val())==1){
					  $("#overlay, #PleaseWait").show();
					  $("#depreciationDetailsDiv").load("depreciationDetailsGrid.jsp?branchval="+$('#cmbbranch').val()+'&uptodate='+date);
					  $("#depreciationDetailsGridID").jqxGrid({ disabled: false});
					  $("#depreciationCostRecognizationGridID").jqxGrid({ disabled: true});
					  $('#btnGenerate').attr('disabled', true );
					  $('#txtchkgridload').val('');
					  $('#txtgridload').val(1);
				  } else if(parseInt($('#txtchkgridload').val())==0) {
						$.messager.alert('Message','Depreciation Pending for Last-Month.','warning');
						$("#depreciationDetailsGridID").jqxGrid({ disabled: true});
						$("#depreciationCostRecognizationGridID").jqxGrid({ disabled: true});
						$('#btnGenerate').attr('disabled', true );
						$("#overlay, #PleaseWait").hide();
						return;
					}else if(parseInt($('#txtchkgridload').val())==2) {
						$.messager.alert('Message','Depreciation Already Done.','warning');
						$("#depreciationDetailsGridID").jqxGrid({ disabled: true});
						$("#depreciationCostRecognizationGridID").jqxGrid({ disabled: true});
						$('#btnGenerate').attr('disabled', true );
						$("#overlay, #PleaseWait").hide();
						return;
				}
			  }else {
						$.messager.alert('Message','Depreciation date should be Month-End.','warning');
						$("#depreciationDetailsGridID").jqxGrid({ disabled: true});
						$("#depreciationCostRecognizationGridID").jqxGrid({ disabled: true});
						$('#btnGenerate').attr('disabled', true );
						$("#overlay, #PleaseWait").hide();
						return;
					}
		}
	}
	x.open("GET", "getLastMonthDepreciation.jsp?date="+date+"&branch="+document.getElementById("cmbbranch").value, true);
	x.send();
  }
 
   function datechange() {
	    var date = $('#uptodate').jqxDateTimeInput('getDate');
		var lastdaydate = new Date(date.getFullYear(), date.getMonth() + 1, 0);
	    var lastdaymonthdate=new Date(new Date(lastdaydate).setDate(lastdaydate.getDate()));
	    $('#uptodate ').jqxDateTimeInput('setDate', new Date(lastdaymonthdate));
  }
   
   function funClearInfo(){
  	 	$('#cmbbranch').val('a');
  	 	$('#uptodate').val(new Date());
  	 	
  	    $('#gridlength').val('');$('#mode').val('');$('#msg').val('');
  	    $('#txtgridload').val('');$('#txtchkgridload').val('');$('#txtchkdate').val('');
  	    $('#txtselecteddocs').val('');$('#txtdeprtotal').val('');
  	    document.getElementById("lbldepreciationstatus").innerText="";
  	    $('#btnGenerate').attr('disabled', true );
  	    
  	    $("#depreciationDetailsGridID").jqxGrid('clear');$("#depreciationDetailsGridID").jqxGrid({ disabled: true});
  	    $("#depreciationCostRecognizationGridID").jqxGrid('clear');$("#depreciationCostRecognizationGridID").jqxGrid({ disabled: true});
  	 
	}
 
   function funreload(event) {
	
	   if($('#cmbbranch').val()=='a'){
			 $.messager.alert('Message','Please Choose a Specific Main-Branch.','warning');
			 return 0;
		 }
	   
	    $("#overlay, #PleaseWait").show();
	    var date = $('#uptodate').val();
	    getLastMonthDepreciation(date);
	  
	}

	
	function funExportBtn() {
		 JSONToCSVCon(dataExcelExport, 'DepreciationCostRecognization', true);
	}
	
	function funNotify(){	
		if($('#cmbbranch').val()=='a'){
			 $.messager.alert('Message','Please Choose a Specific Main-Branch.','warning');
			 return 0;
		 }
		
		 var selectedrows=$("#depreciationCostRecognizationGridID").jqxGrid('selectedrowindexes');
		 selectedrows = selectedrows.sort(function(a,b){return a - b});
		 
	  	 if(selectedrows.length==0){
	  		  $.messager.alert('Warning','Select Vehicles to be Depreciatied.');
	  		  return false;
	  	 }
	  	 
	  	$.messager.confirm('Confirm', 'Do you want to Post?', function(r){
  	 		if (r){
  	 			
  	 			var rows = $("#depreciationCostRecognizationGridID").jqxGrid('getrows');
  	 			var i=0;var tempdocs1="",tempdocs="",tempdeprtotal="0";
  	 			var j=0;
  			    for (i = 0; i < rows.length; i++) {
  						if(selectedrows[j]==i){
  							
  							if(i==0){
  								tempdocs=rows[i].fleetno;
  							}
  							else{
  								tempdocs=tempdocs+","+rows[i].fleetno;
  							}
  							tempdocs1=tempdocs+",";
  							tempdeprtotal=parseFloat(tempdeprtotal)+parseFloat(rows[i].depramount);
  						j++; 
  					  }
  		            }
  			  $('#txtselecteddocs').val(tempdocs1);$('#txtdeprtotal').val(tempdeprtotal);
  	 				
	    	/* Grid Saving */
	    	 var length=0; var j=0;
			 for(var i=0 ; i < rows.length ; i++){
				if(selectedrows[j]==i){
					var chk=rows[i].depramount;
					/* if(chk != ""){ */
						
						newTextBox = $(document.createElement("input"))
					    .attr("type", "dil")
					    .attr("id", "test"+length)
					    .attr("name", "test"+length)
					    .attr("hidden", "true");
						length=length+1;
					
						newTextBox.val(rows[i].fleetno+":: "+rows[i].depramount+":: "+rows[i].posteddate+":: "+rows[i].vehiclecost+":: "+rows[i].residual+":: "+rows[i].balance+":: "+rows[i].numberofdays+":: "+rows[i].onedaycharge);
						newTextBox.appendTo('form');
						j++; 
					/*  }  */
				  }
			 }
			 $('#gridlength').val(length);
	 		/* Grid Saving Ends */
	 		
	 		
			 document.getElementById("mode").value='A';
			 $("#overlay, #PleaseWait").show();
			 document.getElementById("frmDepreciationCostRecognization").submit();
			 
  	 		 }
  	 		
  	 		});
  		 
    		return 1;
	}
	
	function setValues(){
		
		 if($('#hiduptodate').val()){
			 $("#uptodate").jqxDateTimeInput('val', $('#hiduptodate').val());
		  }
	  
		if($('#msg').val()!=""){
			 $.messager.alert('Message',$('#msg').val());
			 funClearInfo();
		 }
	}
 
</script>
</head>
<body onload="getBranch();setValues();">
<form id="frmDepreciationCostRecognization" action="saveDepreciationCostRecognization" method="post">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%">
<tr>
<td width="20%">
    <fieldset style="background: #ECF8E0;">
	<table width="100%" >
	<jsp:include page="../../heading.jsp"></jsp:include>
	
	<tr><td colspan="2" class="bounce" style="text-align: center;font-size: 12px;">&nbsp;<b><label id="lbldepreciationstatus"  name="lbldepreciationstatus"><s:property value="lbldepreciationstatus"/></label></b></td></tr>
	<tr><td align="right"><label class="branch">Upto</label></td>
     <td align="left"><div id="uptodate" name="uptodate" onchange="datechange();" value='<s:property value="uptodate"/>'></div>
     <input type="hidden" id="hiduptodate" name="hiduptodate" style="width:60%;height:20px;" readonly="readonly" value='<s:property value="hiduptodate"/>'/></td></tr> 
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2"><div id="depreciationDetailsDiv"><jsp:include page="depreciationDetailsGrid.jsp"></jsp:include></div></td></tr> 
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2" align="center"><input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funClearInfo();">
    <button class="myButton" type="button" id="btnGenerate" name="btnGenerate" onclick="funNotify();">Post</button></td></tr>
	<tr><td colspan="2"><input type="hidden" id="gridlength" name="gridlength" style="width:100%;height:20px;"/>
	<input type="hidden" name="mode" id="mode" style="width:100%;height:20px;" value='<s:property value="mode"/>'>
	<input type="hidden" name="msg" id="msg" style="width:100%;height:20px;" value='<s:property value="msg"/>'>
	<input type="hidden" name="txtdeprtotal" id="txtdeprtotal" style="width:100%;height:20px;" value='<s:property value="txtdeprtotal"/>'>
	<input type="hidden" name="txtselecteddocs" id="txtselecteddocs" style="width:100%;height:20px;" value='<s:property value="txtselecteddocs"/>'>
	<input type="hidden" id="txtgridload" name="txtgridload"  style="width:100%;height:20px;" value='<s:property value="txtgridload"/>'/>
    <input type="hidden" id="txtchkgridload" name="txtchkgridload"  style="width:100%;height:20px;" value='<s:property value="txtchkgridload"/>'/>
    <input type="hidden" id="txtchkdate" name="txtchkdate"  style="width:100%;height:20px;" value='<s:property value="txtchkdate"/>'/></td></tr>
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		 <tr>
		    <td><div id="depreciationCostRecognizationDiv"><jsp:include page="depreciationCostRecognizationGrid.jsp"></jsp:include></div></td>
		 </tr> 
	</table>
</td>
</tr>
</table>

</div>
</div>
</form>
</body>
</html>