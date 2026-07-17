
<!DOCTYPE html>
<html>
<head>
<%@ taglib prefix="s" uri="/struts-tags" %>
 <s:head/>
 <% String contextPath=request.getContextPath();%>
 
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<jsp:include page="../../../../includes.jsp"></jsp:include>
<style>
form label.error {
color:red;
font-weight:bold;

                }
</style>
<script type="text/javascript">
$(document).ready(function() {
	$("#compdate").jqxDateTimeInput({
		width : '125px',
		height : '15px',
		formatString : "dd.MM.yyyy"
	});
	  $('#jobwindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Jobs Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
  	  $('#jobwindow').jqxWindow('close');
	
		document.getElementById("formdet").innerText="Service Package(WSP)";
		document.getElementById("formdetail").value="Service Package";
		document.getElementById("formdetailcode").value="WSP";
		window.parent.formCode.value="WSP";
window.parent.formName.value="Service Package";
    
            
});
  </script>

<script type="text/javascript">
function jobsSearchContent(url) {
 	$('#jobwindow').jqxWindow('open');
	$.get(url).done(function (data) {
	$('#jobwindow').jqxWindow('setContent', data);
	$('#jobwindow').jqxWindow('bringToFront');
}); 
}
function getJobs(rownindex){
 	  $('#jobwindow').jqxWindow('open');
 	 jobsSearchContent('jobMasterSearchGrid.jsp?rownindex='+rownindex); 
  }
	
function funReadOnly(){
	$('#frmcomplaint input').attr('readonly', true );
	 $('#compdate').jqxDateTimeInput({ disabled: true}); 
}
function funRemoveReadOnly(){
	$('#frmcomplaint input').attr('readonly', false );
	//$('#jqxDateTimeInput').jqxDateTimeInput({ disabled: false});
		 $('#compdate').jqxDateTimeInput({ disabled: false}); 
	$('#docno').attr('readonly', true);
	if($('#mode').val()=='A'){
		$("#servicePackageGrid").jqxGrid('clear');		
	}
	$("#servicePackageGrid").jqxGrid('addrow', null, {});
}
function funFocus()
{
	document.getElementById("code").focus();
		
}
function funSearchLoad(){
	changeContent('servicepackageSearch.jsp'); 
 }
function funNotify(){
	 $('#compdate').jqxDateTimeInput({ disabled: false}); 	
	 

 	var rows = $("#servicePackageGrid").jqxGrid('getrows');
	    $('#gridlength').val(rows.length);
	  
	   for(var i=0 ; i < rows.length ; i++){
	
	    newTextBox = $(document.createElement("input"))
	       .attr("type", "dil")
	       .attr("id", "test"+i)
	       .attr("name", "test"+i)
	       .attr("hidden", "true"); 
	 
	    newTextBox.val(rows[i].jobdocno+" :: ");
	    newTextBox.appendTo('form');
	    
	   }
 	
	return 1;
} 

    
    $(function(){
	    $('#frmcomplaint').validate({
	             rules: {
	             code: {required:true,maxlength:10},
				 name:{required:true,maxlength:50},
	             amount:{required:true,digits:true}
	             },
	             messages: {
	            	 code:{required:" *",maxlength:"Max 10 Chars."},
	                 name:{required:" *",maxlength:"Max 50 Chars."},
	                 mobile:{required:" *",digits:"Digits only."}
	             }
	    });});
    
function setValues()
{
	if($('#compdatehidden').val()){
		$("#compdate").jqxDateTimeInput('val', $('#compdatehidden').val());
	}
   	//$('#prevdate').val($('#prevdatehidden').val()) ;
	if($('#msg').val()!=""){
		   $.messager.alert('Message',$('#msg').val());
		  }
	$('#servicepackagegriddiv').load('servicePackageGrid.jsp?docno='+document.getElementById("docno").value);
	}
	
	 function isNumber(evt,id) {
		//Function to restrict characters and enter number only
			  var iKeyCode = (evt.which) ? evt.which : evt.keyCode
		        if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57))
		         {
		        	 $.messager.alert('Warning','Enter Numbers Only');
		           $("#"+id+"").focus();
		            return false;
		            
		         }
		        
		        return true;
		    }
</script>

</head>
<body onload="setValues();"><div id="mainBG" class="homeContent" data-type="background">
<form id="frmcomplaint" action="saveServicePackage" autocomplete="off" method="post">
<jsp:include page="../../../../header.jsp" /><br/> 
<fieldset><legend>Service Package Details</legend>
<table width="100%" >
  <tr>
    <td width="12%"><div align="right">Date</div></td> 
    <td colspan="3"><div id="compdate" name="compdate" value='<s:property value="compdate"/>'></div></td>
    <input type="hidden" name="compdatehidden" id="compdatehidden" value='<s:property value="compdatehidden"/>'>
    <td width="9%"><div align="right">Doc No</div></td>
    <td width="24%">
      <input type="text" name="docno" readonly="readonly" id="docno" value='<s:property value="docno"/>'>
   </td>
  </tr>                   
  <tr>
    <td><div align="right">Code</div></td>
    <td><input type="text" name="code" id="code" value='<s:property value="code"/>'></td>	
    <td><div align="right">Name</div></td>
    <td><input type="text" name="name" style="width:90%;" id="name" value='<s:property value="name"/>'></td>
    <td><div align="right">Amount</div></td>
    <td ><input type="text" name="amount" id="amount" value='<s:property value="amount"/>' style="text-align:right;" onkeypress="javascript:return isNumber (event,id)" onblur="funRoundAmt(value,id);"></td>
    
  </tr>

</table>
<input type="hidden" id="mode" name="mode"/>
          <input type="text" name="deleted" id="deleted" value='<s:property value="deleted"/>' hidden="true"/>
          	 <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
          	 <input type="hidden" id="gridlength" name="gridlength"  value='<s:property value="gridlength"/>'/>
          
</fieldset>

			    <table width="100%">
                  <tr>
                    <td width="20%">&nbsp;</td>
                     
                    <td width="60%"><div id="servicepackagegriddiv" style="position:relative;"><jsp:include page="servicePackageGrid.jsp"></jsp:include></div>
</td>
                    <td width="20%">&nbsp;</td>
                  </tr>
                </table>
               
         
</form>


<div id="jobwindow">
   <div></div>
</div>
</div>
</body>
</html>