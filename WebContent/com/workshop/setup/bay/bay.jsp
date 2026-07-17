<%@page import="com.controlcentre.masters.vehiclemaster.model.ClsModelAction" %>
<%ClsModelAction cma=new ClsModelAction(); %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>
<style>
form label.error {
	color:red;
	font-weight:bold;
}
.fullwidth{
	width:100%;
}
</style>
<script type="text/javascript">
      $(document).ready(function () {          
    	  $("#date").jqxDateTimeInput({ width : '125px', height : '15px', formatString : "dd.MM.yyyy" });  
     
    	    document.getElementById("formdet").innerText="Bay(WBY)";
			document.getElementById("formdetail").value="Bay";
			document.getElementById("formdetailcode").value="WBY";
			window.parent.formCode.value="WBY";
			window.parent.formName.value="Bay";
			
			
			getJob();
			$('#baygriddiv').load('bayGrid.jsp?check=1');
          
          });
    
      function funSearchLoad(){
			changeContent('baySearch.jsp?check=1', $('#window')); 
		 }

	function funReadOnly() {
		$('#frmWorkBay input').attr('readonly', true);
		$('#frmWorkBay select').attr('disabled', true);
		$('#date').jqxDateTimeInput({disabled: true});
		
	}
	function funRemoveReadOnly() {
		$('#frmWorkBay input').attr('readonly', false);
		$('#frmWorkBay select').attr('disabled', false);
		$('#date').jqxDateTimeInput({disabled: false});
		$('#docno').attr('readonly', true);
		
		if($("#mode"=="A")){
			$('#date').jqxDateTimeInput('setDate',new Date());
		}

	}

	function funFocus(){
		//document.getElementById("cmbjobmaster").focus();
	}
	 $(function(){
	        $('#frmWorkBay').validate({
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
	    	 
	    	 if($('#name').val()==''){
	    		 document.getElementById("errormsg").innerText="";
	    		 document.getElementById("errormsg").innerText="Name is Mandatory";
	    	 	return 0;
	    	 }
	    	 if($('#code').val()==''){
	    		 document.getElementById("errormsg").innerText="";
	    		 document.getElementById("errormsg").innerText="Code is Mandatory";
	    	 	return 0;
	    	 }
	    	 if($('#cmbjobtype').val()==''){
	    		 document.getElementById("errormsg").innerText="";
	    		 document.getElementById("errormsg").innerText="Select Job Type";
	    	 	return 0;
	    	 }
	    	
	    	
	    		return 1;
		} 
	     
	function setValues() {
		//funSetLabel();
		if($('#msg').val()!=""){
	   		$.messager.alert('Message',$('#msg').val());
	  	}
		$('#baygriddiv').load('bayGrid.jsp?check=1');
	}
	
	 function funExcelBtn(){
		$("#jqxModelSearch1").jqxGrid('exportdata', 'xls', 'Model');
	 }
	 
	 function getJob() {
			var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
					var items = x.responseText;
					items = items.split('####');
					var salesagentItems = items[0].split(",");
					
					
					var salesagentIdItems = items[1].split(",");
					var optionssalesagent = '<option value="">--Select--</option>';
					for (var i = 0; i < salesagentItems.length; i++) {
						optionssalesagent += '<option value="' + salesagentIdItems[i] + '">'
								+ salesagentItems[i] + '</option>';
					}
					$("select#cmbjobtype").html(optionssalesagent);
					if ($('#hidcmbjobtype').val() != null) {
						$('#cmbjobtype').val($('#hidcmbjobtype').val());
					}
				} else {
				}
			}
			x.open("GET", "getJob.jsp", true);
			x.send();
		}
	
</script>
</head>
<body onLoad="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmWorkBay" action="saveWorkBay"  autocomplete="off">
<jsp:include page="../../../../header.jsp" /><br/> 
<fieldset><legend>Bay Details</legend>
<table width="100%">
<tr>
  <td width="9%"><div align="right">Date</div></td>
  <td width="13%"><div id="date" name="date" value='<s:property value="date"/>'></div></td>
  <td width="18%"><div align="right"></div></td>
  <td width="33%">&nbsp;</td>
  <td width="10%" align="right">Doc No</td>
  <td width="17%"><input type="text" name="docno" value='<s:property value="docno"/>' id="docno" readonly  tabindex="-1"></td>
</tr>
<tr><td><div align="right">Code</div></td>
<td><input type="text" name="code" id="code"  value='<s:property value="code"/>'></td><td><div align="right">Name</div></td><td><input type="text" name="name" id="name" value='<s:property value="name"/>' style="width:100%;"></td>
<td align="right">Job Type</td>
<td><select name="cmbjobtype" id="cmbjobtype"><option value="">--Select--</option></select></td>
</tr>
<tr>
  <td colspan="6"><div id="baygriddiv"><jsp:include page="bayGrid.jsp"></jsp:include></div></td>
  </tr>
</table> 
</fieldset>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>' hidden="true"/> 
<input type="hidden" name="hidcmbjobtype" id="hidcmbjobtype" value='<s:property value="hidcmbjobtype"/>' hidden="true"/>   
</form>
<br/>
</div>
</body>
</html>