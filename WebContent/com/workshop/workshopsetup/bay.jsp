


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
		  
		  $("#baydate").jqxDateTimeInput({width : '125px',height : '15px',formatString : "dd.MM.yyyy"});
		  
		 
		  
		  
		$('#txtaccno').dblclick(function(){
	  	$('#accountWindow').jqxWindow('open');
	     var url=document.URL;
		 var reurl=url.split("com/");
	  	 accountSearchContent(reurl[0]+'com/search/accountsearch/accountsEmployee.jsp?dtype='+document.getElementById("formdetailcode").value);
			 }); 
		
		document.getElementById("formdet").innerText="Bay(BAY)";
		document.getElementById("formdetail").value="Bay";
		document.getElementById("formdetailcode").value="BAY";
		window.parent.formCode.value="BAY";
		window.parent.formName.value="Bay";
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
		$('#frmBay input').attr('readonly', true );
		$('#baydate').jqxDateTimeInput({ disabled: true}); 
	}
	
	function funRemoveReadOnly(){
		$('#frmBay input').attr('readonly', false );
		$('#baydate').jqxDateTimeInput({ disabled: false});
		$('#docno').attr('readonly', true);
		
	}
	$(function(){
	    $('#frmBay').validate({
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
		
		document.getElementById("errormsg").innerText="";
		
		  $('#baydate').jqxDateTimeInput({ disabled: false});
		  return 1;
	}
	
	function funChkButton() {
		   /* funReset(); */
		  }
		  
	function setValues() {
		
			if($('#hidbaydate').val()){
				$("#baydate").jqxDateTimeInput('val', $('#hidbaydate').val());
			}
			
			if($('#msg').val()!=""){
				   $.messager.alert('Message',$('#msg').val());
				  }
			 var docno = document.getElementById("docno").value;
			  if(docno>0){
				
	          $("#baydiv").load("bayGrid.jsp?docno="+docno);
			  }
			
	}
	
	function funFocus(){
		document.getElementById("code").focus();
	}
	
	function funSearchLoad(){
		changeContent('bayMainSearchGrid.jsp'); 
	}
	/* function funExcelBtn(){
   	 $("#jqxTECSearch1").jqxGrid('exportdata', 'xls', 'Checkin');
   } */
</script>
</head>
<body onLoad="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmBay" action="saveActionBay"  autocomplete="off" >
<jsp:include page="../../../header.jsp" /><br/> 
<fieldset>
<legend>Bay</legend>
<table width="100%">
  <tr>
    <td width="5%" align="right">Date</td>
    <td width="16%"><div id="baydate" name="baydate" value='<s:property value="baydate"/>'></div></td>
    <td colspan="3" align="right">Doc No.</td>
    <td width="30%"><input type="text" id="docno" name="docno" value='<s:property value="docno"/>' readonly tabindex="-1"></td>
  </tr>
  <tr>
    <td align="right">Code</td>
    <td><input type="text" id="code" name="code" placeholder="Code" value='<s:property value="code"/>' ></td>
    <td width="11%" align="right">Name</td>
    <td width="33%"><input type="text" name="name" id="name" placeholder="Name" value='<s:property value="name"/>' style="width:59%;" ></td>
    </tr>
</table>
</fieldset>
<div id="baydiv"><jsp:include page="bayGrid.jsp"></jsp:include></div>

<input type="hidden" name="hidbaydate" id="hidbaydate" value='<s:property value="hidbaydate"/>'>
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

