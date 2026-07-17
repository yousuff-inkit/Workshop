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
    	  $('#accountDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
 		  $('#accountDetailsWindow').jqxWindow('close');
 		 $('#jobmasterWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Job Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		  $('#jobmasterWindow').jqxWindow('close');
 		  
 		  $('#accountno').dblclick(function(){
			  accountsSearchContent('accountsDetailsSearch.jsp');
		  });
 		  
    	  $("#date").jqxDateTimeInput({ width : '125px', height : '15px', formatString : "dd.MM.yyyy" });  
     
    	    document.getElementById("formdet").innerText="Technician (WTC)";
			document.getElementById("formdetail").value="Technician";
			document.getElementById("formdetailcode").value="WTC";
			window.parent.formCode.value="WTC";
			window.parent.formName.value="Technician";
          
          });
    
      function funSearchLoad(){
			changeContent('technicianSearch.jsp?id=1', $('#window')); 
		 }

	function funReadOnly() {
		$('#frmWorkTechnician input').attr('readonly', true);
		$('#frmWorkTechnician select').attr('disabled', true);
		$('#date').jqxDateTimeInput({disabled: true});
		
	}
	function funRemoveReadOnly() {
		$('#frmWorkTechnician input').attr('readonly', false);
		$('#frmWorkTechnician select').attr('disabled', false);
		$('#date').jqxDateTimeInput({disabled: false});
		$('#date').jqxDateTimeInput({disabled: false});
		$('#docno').attr('readonly', true);
		$('#accountno').attr('readonly', true);
		$('#accountname').attr('readonly', true);
		if(!($('#docno').val()>0)){
			$('#jobMasterGrid').jqxGrid('clear');
			 $("#jobMasterGrid").jqxGrid("addrow", null, {});
		}
		
		if($("#mode"=="A")){
			$('#date').jqxDateTimeInput('setDate',new Date());
		}
	}

	function funFocus(){
		document.getElementById("accountno").focus();
	}
	 $(function(){
	        $('#frmWorkTechnician').validate({
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
	    	 
	    	     
	    	 if($('#accountno').val()==''){
	    		 document.getElementById("errormsg").innerText="";
	    		 document.getElementById("errormsg").innerText="Select Account";
	    	 	return 0;
	    	 }
	    	
	    	  if($('#actualstdcost').val()==''){
	    		 document.getElementById("errormsg").innerText="";
	    		 document.getElementById("errormsg").innerText="Enter Actual Cost";
	    	 	return 0;
	    	 }
	    	 if($('#name').val()==''){
	    		 document.getElementById("errormsg").innerText="";
	    		 document.getElementById("errormsg").innerText="Enter Name";
	    	 	return 0;
	    	 }
	    	
	    	 if($('#mobile').val()==''){
	    		 document.getElementById("errormsg").innerText="";
	    		 document.getElementById("errormsg").innerText="Enter Mobile No";
	    	 	return 0;
	    	 }
	    	
	    	 if($('#email').val()==''){
	    		 document.getElementById("errormsg").innerText="";
	    		 document.getElementById("errormsg").innerText="Enter Email";
	    	 	return 0;
	    	 }
	    	
	    	 
	    	 /*  Tech Job Grid  Saving*/
			 var rows1 = $("#jobMasterGrid").jqxGrid('getrows');
			 var length1=0;
				 for(var i=0 ; i < rows1.length ; i++){
					
					var chk1=rows1[i].jobtypeid;
					if(typeof(chk1) != "undefined" && typeof(chk1) != "NaN" && chk1 != ""){
						newTextBox = $(document.createElement("input"))
					    .attr("type", "dil")
					    .attr("id", "jobgidid"+length1)
					    .attr("name", "jobgidid"+length1)
						.attr("hidden", "true");
						length1=length1+1;
						
			    newTextBox.val(chk1+":: ");
				newTextBox.appendTo('form');
				 }
				}
			 $('#technicianJoblength').val(length1);
			 
		   /*   Tech Job Grid Saving Ends */	
	    	
	    		return 1;
		} 
	     
	function setValues() {
		if($('#msg').val()!=""){
	   		$.messager.alert('Message',$('#msg').val());
	  	}
		if($('#docno').val()>0){
			$('#jobmasterdiv').load('jobMasterGrid.jsp?id=1&docno='+$('#docno').val());
		}
	}
	
	function accountsSearchContent(url) {
	    $('#accountDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#accountDetailsWindow').jqxWindow('setContent', data);
		$('#accountDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function getAccType(event){
        var x= event.keyCode;
        if(x==114){
		  if($('#cmbtype').val()==''){
    			 $.messager.alert('Message','Please Choose Account Type.','warning');
    			 return 0;
    	  }
      	  accountsSearchContent('accountsDetailsSearch.jsp');
        }
        else{
         }
        }
	
	function jobmasterSearchContent(url) {
	 	$('#jobmasterWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#jobmasterWindow').jqxWindow('setContent', data);
		$('#jobmasterWindow').jqxWindow('bringToFront');
	}); 
	}
	
	
	 function funExcelBtn(){
		//$("#jqxModelSearch1").jqxGrid('exportdata', 'xls', 'Model');
	 }
</script>
</head>
<body onLoad="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmWorkTechnician" action="saveWorkTechnician"  autocomplete="off">
<jsp:include page="../../../../header.jsp" /><br/> 
<fieldset><legend>Technician Details</legend>
<table width="100%">
<tr>
  <td width="9%"><div align="right">Date</div></td> 
  <td width="12%"><div id="date" name="date" value='<s:property value="date"/>'></div></td>
  <td width="29%"><div align="right"></div></td>
  <td width="12%" align="right">Doc No</td>
  <td width="21%" align="left"><input type="text" name="docno" value='<s:property value="docno"/>' id="docno" readonly  tabindex="-1"></td>
  <td width="17%">&nbsp;</td>
</tr>
<tr><td align="right">Account</td> 
<td><input type="text" name="accountno" id="accountno"  value='<s:property value="accountno"/>' readonly placeholder="Press F3 to Search" ></td><td><input name="accountname" type="text" class="fullwidth" id="accountname" placeholder="Press F3 to Search"  value='<s:property value="accountname"/>' readonly ></td><td align="right">Actual Std Cost/ Hr</td>
<td align="left"><input type="text" name="actualstdcost" id="actualstdcost"  value='<s:property value="actualstdcost"/>' ></td>
<td>&nbsp;</td>
</tr>
<tr>
  <td align="right">Name</td>
  <td colspan="2"><input type="text" name="name" id="name"  value='<s:property value="name"/>' class="fullwidth"></td>
  <td align="right">Mobile</td>
  <td align="left"><input type="text" name="mobile" id="mobile"  value='<s:property value="mobile"/>' ></td>
  <td align="left">&nbsp;</td>
  </tr>
  
  <tr>
  <td align="right">Email</td>
  <td colspan="2"><input type="text" name="email" id="email"  value='<s:property value="email"/>' class="fullwidth"></td>
 <td></td><td></td>
<tr>
  <td colspan="6"><fieldset><legend>Job Master Details</legend>
  	<div id="jobmasterdiv"><jsp:include page="jobMasterGrid.jsp"></jsp:include></div>
    </fieldset>
  </td>
  </tr>
</table> 
</fieldset>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>
<input type="hidden" id="hidaccdocno" name="hidaccdocno"  value='<s:property value="hidaccdocno"/>'/>
<input type="text" name="deleted" id="deleted" value='<s:property value="deleted"/>' hidden="true"/>
<input type="hidden" name="technicianJoblength" id="technicianJoblength" value='<s:property value="technicianJoblength"/>' hidden="false"/>
    
</form>
<br/>
<div id="accountDetailsWindow">
	<div></div>
	<div></div>
</div>
<div id="jobmasterWindow">
	<div></div>
	<div></div>
</div>

</div>
</body>
</html>