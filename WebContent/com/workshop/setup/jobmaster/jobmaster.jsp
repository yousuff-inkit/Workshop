
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
	width:99%;
}
</style>
<script type="text/javascript">
      $(document).ready(function () {          
    	  $("#date").jqxDateTimeInput({ width : '125px', height : '15px', formatString : "dd.MM.yyyy" });  
     
    	    document.getElementById("formdet").innerText="Job Master(WJM)";
			document.getElementById("formdetail").value="Job Master";
			document.getElementById("formdetailcode").value="WJM";
			window.parent.formCode.value="WJM";
			window.parent.formName.value="Job Master";
			getJob();
			$('#jobdescdiv').load('jobDescGrid.jsp?id=1');
          });
    
      function funSearchLoad(){
			changeContent('jobMasterSearchGrid.jsp?id=1', $('#window')); 
		 }

	function funReadOnly() {
		$('#frmJobMaster input').attr('readonly', true);
		$('#frmJobMaster select').attr('disabled', true);
		$('#date').jqxDateTimeInput({disabled: true});
		
	}
	function funRemoveReadOnly() {
		$('#frmJobMaster input').attr('readonly', false);
		$('#frmJobMaster select').attr('disabled', false);
		$('#date').jqxDateTimeInput({disabled: false});
		$('#docno').attr('readonly', true);
		if($("#mode").val()=="A"){
			$('#date').jqxDateTimeInput('setDate',new Date());
			$('#jobDescGrid').jqxGrid('clear');
			 $("#jobDescGrid").jqxGrid("addrow", null, {});
		}
		if($("#mode").val()=="E"){
			 $("#jobDescGrid").jqxGrid("addrow", null, {});
		}
		if(!($('#docno').val()>0)){
			
		}
		

	}

	function funFocus(){
		//document.getElementById("cmbjobmaster").focus();
	}
	/*  $(function(){
	        $('#frmJobMaster').validate({
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
	        });}); */
	     function funNotify(){
	    	 if($('#description').val()==''){
	    		 document.getElementById("errormsg").innerText="";
	    		 document.getElementById("errormsg").innerText="Enter Description";
	    	 	return 0;
	    	 }
	    	
	    	 if($('#cmbjobtype').val()==''){
	    		 document.getElementById("errormsg").innerText="";
	    		 document.getElementById("errormsg").innerText="Select Job Type";
	    	 	return 0;
	    	 } 
	    	 if($('#stdhr').val()==''){
	    		 document.getElementById("errormsg").innerText="";
	    		 document.getElementById("errormsg").innerText="Enter STD HR";
	    	 	return 0;
	    	 }
	    	
	    	 if($('#stdrateperhr').val()==''){
	    		 document.getElementById("errormsg").innerText="";
	    		 document.getElementById("errormsg").innerText="Enter STD Rate / HR";
	    	 	return 0;
	    	 }
	    	 
	    	 
	    	 /*   Job Grid  Saving*/
			 var rows1 = $("#jobDescGrid").jqxGrid('getrows');
			 var length1=0;
				 for(var i=0 ; i < rows1.length ; i++){
					
					var chk1=rows1[i].desc;
					if(typeof(chk1) != "undefined" && typeof(chk1) != "NaN" && chk1 != ""){
						newTextBox = $(document.createElement("input"))
					    .attr("type", "dil")
					    .attr("id", "jobgriddesc"+length1)
					    .attr("name", "jobgriddesc"+length1)
						.attr("hidden", "true");
						length1=length1+1;
						
			    newTextBox.val(chk1+":: ");
				newTextBox.appendTo('form');
				 }
				}
			 $('#jobgridlength').val(length1);
			 
		   /*    Job Grid Saving Ends */	
		   
	    	$('#date').jqxDateTimeInput({disabled: false});
		   
	    		return 1;
		} 
	     
	function setValues() {
		if($('#msg').val()!=""){
	   		$.messager.alert('Message',$('#msg').val());
	  	}
		//funSetlabel();
		//$('#jobdescdiv').load('jobDescGrid.jsp?id=1');	
		if($('#docno').val()>0){
			$('#jobdescdiv').load('jobDescGrid.jsp?id=1&docno='+$('#docno').val());
		}
		if($('#hidcmbjobtype').val()!=''){
			document.getElementById('cmbjobtype').value=$('#hidcmbjobtype').val();
		}
	}
	
	 function funExcelBtn(){
		//$("#jqxModelSearch1").jqxGrid('exportdata', 'xls', 'Model');
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
<form id="frmJobMaster" action="saveJobMaster"  autocomplete="off">
<jsp:include page="../../../../header.jsp" /><br/> 
<fieldset><legend>Job Master Details</legend>
<table width="100%">
<tr>
  <td width="9%"><div align="right">Date</div></td> 
  <td width="13%"><div id="date" name="date" value='<s:property value="date"/>'></div></td>
  <td width="18%"></td>
  <td width="33%">&nbsp;</td>
  <td width="15%" align="right">Doc No</td> 
  <td width="12%"><input type="text" name="docno" value='<s:property value="docno"/>' id="docno" readonly  tabindex="-1"></td>
</tr>
<tr><td><div align="right">Job Type</div></td>
<td><select name="cmbjobtype" id="cmbjobtype">
  <option value="">--Select--</option>
</select></td>
<td align="right">Description</td><td colspan="3"><input name="description" type="text" class="fullwidth" id="description" value='<s:property value="description"/>' ></td>
</tr>
<tr>
<td align="right">STD HR</td><td><input name="stdhr" type="text" class="fullwidth" id="stdhr" value='<s:property value="stdhr"/>' ></td>

<td align="right">STD RATE /HR</td><td ><input name="stdrateperhr" type="text"  id="stdrateperhr" value='<s:property value="stdrateperhr"/>' ></td>
<td></td>
<td></td>
</tr>

<tr>
  <td colspan="6"><fieldset><legend>Check list</legend>
  	<div id="jobdescdiv"><jsp:include page="jobDescGrid.jsp"></jsp:include></div>
    </fieldset>
    </td>
</tr>
</table> 
</fieldset>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<input type="hidden" id="mode" name="mode"  value='<s:property value="mode"/>' />
<input type="text" name="hidcmbjobtype" id="hidcmbjobtype" value='<s:property value="hidcmbjobtype"/>' hidden="true"/>
<input type="text" name="deleted" id="deleted" value='<s:property value="deleted"/>' hidden="true"/>    
<input type="text" name="jobgridlength" id="jobgridlength" value='<s:property value="jobgridlength"/>' hidden="true"/>

</form>
<br/>
</div>
</body>
</html>