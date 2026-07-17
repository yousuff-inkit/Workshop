<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
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
</style>

<script type="text/javascript">

	$(document).ready(function () {
		 $("#branchlabel").css("opacity","0");$("#branchdiv").css("opacity","0");
		
		 $("#uptodate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 
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
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%">
	<jsp:include page="../../heading.jsp"></jsp:include>
	 
	 <tr><td align="right"><label class="branch">Up To</label></td>
     <td align="left"><div id="uptodate" name="uptodate" value='<s:property value="uptodate"/>'></div>
     <input type="hidden" id="hiduptodate" name="hiduptodate" style="width:60%;height:20px;" readonly="readonly" value='<s:property value="hiduptodate"/>'/></td></tr>
     <tr><td align="right"><label class="branch">Type</label></td>
	 <td align="left"><select id="cmbtype" name="cmbtype" style="width:40%;" value='<s:property value="cmbtype"/>'>
     <option value="AR" selected>AR</option><option value="AP">AP</option></select>
     <input type="hidden" id="hidcmbtype" name="hidcmbtype" style="width:60%;height:20px;" readonly="readonly" value='<s:property value="hidcmbtype"/>'/></td></tr>
     <tr><td colspan="2">
	  <fieldset><legend><b><label class="branch">Report Type</label></b></legend>
	   <table width="100%">
       <tr>
       <td width="52%" align="center"><input type="radio" id="rdcurrentageing" name="rdo" onclick="radioClick();" value="rdcurrentageing"><label for="rdcurrentageing" class="branch">Current Ageing</label></td>
       <td width="48%" align="center"><input type="radio" id="rdageing" name="rdo" onclick="radioClick();" value="rdageing"><label for="rdageing" class="branch">Ageing</label></td>
       </tr>
       </table>
	  </fieldset>
	 </td></tr>  
	 <tr><td colspan="2">&nbsp;</td></tr> 
	 <tr><td colspan="2" align="center"><input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funClearInfo();">
	 <button class="myButton" type="button" id="btnRemoveApplying" name="btnRemoveApplying" onclick="funNotify();">Remove</button></td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;<i><b><label id="lblaccountno"  name="lblaccountno"   style="font-size: 13px;font-family: Tahoma; color:#6000FC;"><s:property value="lblaccountno"/></label></b></i></td></tr>
     <tr><td colspan="2" height="70px">&nbsp;<i><b><label id="lblaccountname"  name="lblaccountname"   style="font-size: 13px;font-family: Tahoma; color:#6000FC;"><s:property value="lblaccountname"/></label></b></i></td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2"><input type="hidden" name="mode" id="mode" style="width:100%;height:20px;" value='<s:property value="mode"/>'>
	<input type="hidden" name="msg" id="msg" style="width:100%;height:20px;" value='<s:property value="msg"/>'>
	<input type="hidden" id="gridlength" name="gridlength" style="width:100%;height:20px;"/></td></tr>
	 </table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr><td><div id="ageingVerificationDiv"><jsp:include page="ageingVerificationGrid.jsp"></jsp:include></div><br/></td></tr>
		<tr><td><div id="ageingDifferenceDiv"><jsp:include page="ageingDifferenceGrid.jsp"></jsp:include></div></td></tr>
	</table>
</tr>
</table>
</div>
<div id="accountDetailsWindow">
	<div></div><div></div>
</div>
</div> 
</form> 
</body>
</html>