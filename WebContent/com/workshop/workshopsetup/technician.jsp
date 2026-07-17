


<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../includes.jsp"></jsp:include>

<script type="text/javascript">
	$(document).ready(function () {     
		
		  $('#accountWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		  $('#accountWindow').jqxWindow('close');
		  
		  $("#techniciandate").jqxDateTimeInput({width : '125px',height : '15px',formatString : "dd.MM.yyyy"});
		  
		  
		  
		$('#txtaccno').dblclick(function(){
	  	$('#accountWindow').jqxWindow('open');
	     var url=document.URL;
		 var reurl=url.split("com/");
	  	 accountSearchContent(reurl[0]+'com/search/accountsearch/accountsEmployee.jsp?dtype='+document.getElementById("formdetailcode").value);
			 }); 
		
		document.getElementById("formdet").innerText="Technician(TEC)";
		document.getElementById("formdetail").value="Technician";
		document.getElementById("formdetailcode").value="TEC";
		window.parent.formCode.value="TEC";
		window.parent.formName.value="Technician";
	});
	
	function getAcc(event){
		 var x= event.keyCode;
		 if(x==114){
		  $('#accountWindow').jqxWindow('open');
	     var url=document.URL;
		     var reurl=url.split("com/");
		     accountSearchContent(reurl[0]+'com/search/accountsearch/accountsEmployee.jsp?dtype='+document.getElementById("formdetailcode").value);
		 }
		 else{
			 
		 }
		 }
	
	function accountSearchContent(url) {
			 $.get(url).done(function (data) {
			$('#accountWindow').jqxWindow('setContent', data);
		}); 
		}
	
	function funReadOnly(){
		$('#frmTecnition input').attr('readonly', true );
		$('#techniciandate').jqxDateTimeInput({ disabled: true}); 
	}
	
	function funRemoveReadOnly(){
		$('#frmTecnition input').attr('readonly', false );
		$('#techniciandate').jqxDateTimeInput({ disabled: false});
		$('#docno').attr('readonly', true);
		$('#txtaccno').attr('readonly', true);
		$('#txtaccname').attr('readonly', true);
	}
	
	$(function(){
	    $('#frmTecnition').validate({
	             rules: {
	             code: {required:true,maxlength:10},
				 name:{required:true,maxlength:40},
				 txtaccname:{required:true},
	             mobile:{required:true,digits:true,minlength:12,maxlength:12},
	             mail:{email:true}
	             },
	             messages: {
	            	 code:{required:" *",maxlength:"Max 10 Chars."},
	                 name:{required:" *",maxlength:"Max 40 Chars."},
	                 txtaccname:{required:" *"},
	                 mobile:{required:" *",digits:"Digits only.",minlength:"Min 12 Chars.",maxlength:'Max 12 Chars.'},
	                 mail:{email:"Not a valid Email."}
	             }
	    });});
	    
	function funNotify(){
		if(document.getElementById("txtaccno").value==''){
			document.getElementById("errormsg").innerText="Account is Mandatory.";
			return false;
		}
		document.getElementById("errormsg").innerText="";
		
		  $('#techniciandate').jqxDateTimeInput({ disabled: false});
		  return 1;
	}
	
	function funChkButton() {
		   /* funReset(); */
		  }
		  
	function setValues() {
		
			if($('#hidtechniciandate').val()){
				$("#techniciandate").jqxDateTimeInput('val', $('#hidtechniciandate').val());
			}
			
			if($('#msg').val()!=""){
				   $.messager.alert('Message',$('#msg').val());
				  }
			 var docno = document.getElementById("docno").value;
			  if(docno>0){
				
	          $("#technitiondiv").load("technitionGrid.jsp?docno="+docno);
			  }
	}
	
	function funFocus(){
		document.getElementById("code").focus();
	}
	
	function funSearchLoad(){
		changeContent('technitionMainSearchGrid.jsp'); 
	}
	/* function funExcelBtn(){
   	 $("#jqxTECSearch1").jqxGrid('exportdata', 'xls', 'Checkin');
   } */
</script>
</head>
<body onLoad="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmTecnition" action="saveActionTecnician"  autocomplete="off" >
<jsp:include page="../../../header.jsp" /><br/> 

<fieldset>
<legend>Technician</legend>
<table width="100%">
  <tr>
    <td width="5%" align="right">Date</td>
    <td width="16%"><div id="techniciandate" name="techniciandate" value='<s:property value="techniciandate"/>'></div></td>
    <td colspan="3" align="right">Doc No.</td>
    <td width="30%"><input type="text" id="docno" name="docno" value='<s:property value="docno"/>' readonly tabindex="-1"></td>
  </tr>
  <tr>
    <td align="right">Code</td>
    <td><input type="text" id="code" name="code" placeholder="Code" value='<s:property value="code"/>' ></td>
    <td width="11%" align="right">Name</td>
    <td width="33%"><input type="text" name="name" id="name" placeholder="Code Name" value='<s:property value="name"/>' style="width:59%;" ></td>
    <td width="5%" align="right">Email</td>
    <td><input type="email" name="email" id="email" style="width:80%;" placeholder="someone@example.com" value='<s:property value="email"/>'></td>
  </tr>
  <tr>
    <td align="right">Account</td>
    <td><input type="text" name="txtaccno" id="txtaccno" value='<s:property value="txtaccno"/>' onKeyDown="getAcc(event);" readonly placeholder="Press F3 to Search"></td>
    <td colspan="2"><input type="text" name="txtaccname" id="txtaccname" value='<s:property value="txtaccname"/>'  style="width:70%;" readonly></td>
    <td align="right">Mobile</td>
    <td><input type="text" name="mobile" id="mobile" value='<s:property value="mobile"/>'></td>
  </tr>
</table>
</fieldset>
<div id="technitiondiv"><jsp:include page="technitionGrid.jsp"></jsp:include></div>

<input type="hidden" name="hidtechniciandate" id="hidtechniciandate" value='<s:property value="hidtechniciandate"/>'>
<input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<input type="hidden" name="hidacno" id="hidacno" value='<s:property value="hidacno"/>'/>
</form>
<div id="accountWindow">
	<div >
</div>
</div>
</div>
</body>
</html>

