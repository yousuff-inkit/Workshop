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

<style type="text/css">
.icon1 {
	width: 2.5em;
	height: 2em;
	border: none;
	background-color: #ECF8E0;
}
</style>

<script type="text/javascript">
	$(document).ready(function() {
		 $('#btnEdit').attr('disabled', true );
		 
		 $("#jqxOtherRequestDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 $("#maindate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 
		 $('#clientDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Client Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#clientDetailsWindow').jqxWindow('close');
		 
		 $('#agreementDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Agreement Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#agreementDetailsWindow').jqxWindow('close');
		 
		 $('#driverDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Driver Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#driverDetailsWindow').jqxWindow('close');
		 
		 $('#nationalityWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Nation Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
 		 $('#nationalityWindow').jqxWindow('close');
 		 
    	 $('#stateWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'State Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
 		 $('#stateWindow').jqxWindow('close');
 		 
 		 $('#serviceWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Extra Service Request Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#serviceWindow').jqxWindow('close');
		 
	});
	
	function clientSearchContent(url) {
	 	$('#clientDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#clientDetailsWindow').jqxWindow('setContent', data);
		$('#clientDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function agreementSearchContent(url) {
	 	$('#agreementDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#agreementDetailsWindow').jqxWindow('setContent', data);
		$('#agreementDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function driverSearchContent(url) {
	 	$('#driverDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#driverDetailsWindow').jqxWindow('setContent', data);
		$('#driverDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function nationalitySearchContent(url) {
	 	$('#nationalityWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#nationalityWindow').jqxWindow('setContent', data);
		$('#nationalityWindow').jqxWindow('bringToFront');
	}); 
	}
  
  function stateSearchContent(url) {
	 	$('#stateWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#stateWindow').jqxWindow('setContent', data);
		$('#stateWindow').jqxWindow('bringToFront');
	}); 
	}
  
  function serviceSearchContent(url) {
	 	$('#serviceWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#serviceWindow').jqxWindow('setContent', data);
		$('#serviceWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function funSearchdblclick(){
		 
		  $('#txtclientname').dblclick(function(){
			  var date = $('#jqxOtherRequestDate').jqxDateTimeInput('getDate');
			  $("#maindate").jqxDateTimeInput('val', date);
			  clientSearchContent(<%=contextPath+"/"%>+"com/operations/clientAccountDetailsSearch.jsp?atype=AR"+"&date="+date);
			  $('#txtforsearch').val(2);
			  });
		  
		  $('#txtravocher').dblclick(function(){
			  agreementSearchContent('agreementSearch.jsp?clientId='+$('#txtclientdocno').val());
			  });
	}
	
	function getClient(event){
        var x= event.keyCode;
        if(x==114){
        	var date = $('#jqxOtherRequestDate').jqxDateTimeInput('getDate');
			$("#maindate").jqxDateTimeInput('val', date);
			clientSearchContent(<%=contextPath+"/"%>+"com/operations/clientAccountDetailsSearch.jsp?atype=AR"+"&date="+date);
			$('#txtforsearch').val(2);
        }
       }
	
	function getAgreement(event){
        var x= event.keyCode;
        if(x==114){
        	agreementSearchContent('agreementSearch.jsp');
        }
       }
	
	function funReadOnly(){
		$('#frmOtherRequest input').attr('readonly', true );
		$('#frmOtherRequest select').attr('disabled', true);
		$('#jqxOtherRequestDate').jqxDateTimeInput({disabled: true});
		$("#btnAdditionalDriverSearch").prop("disabled", true);
 		$("#btnAdditionalDriverAdd").prop("disabled", true);
		$("#jqxOtherRequest").jqxGrid({ disabled: true});
		$("#jqxDriver").jqxGrid({ disabled: true});
		
  }
	
 function funRemoveReadOnly(){
		$('#frmOtherRequest input').attr('readonly', false);
		$('#frmOtherRequest select').attr('disabled', false);
		$('#jqxOtherRequestDate').jqxDateTimeInput({disabled: false});
		$("#btnAdditionalDriverSearch").prop("disabled", true);
 		$("#btnAdditionalDriverAdd").prop("disabled", true);
		$("#jqxOtherRequest").jqxGrid({ disabled: false});
		$("#jqxDriver").jqxGrid({ disabled: true});
		$('#docno').attr('readonly', true);
		$('#txtamount').attr('readonly', true);
 		$('#txtdescription').attr('readonly', true);
		$('#txtclientname').attr('readonly', true);
		$('#txtravocher').attr('readonly', true);
		
		if ($("#mode").val() == "A") {
			$('#jqxOtherRequestDate').val(new Date());
			$("#jqxOtherRequest").jqxGrid('clear');
			$("#jqxOtherRequest").jqxGrid('addrow', null, {});
			$("#jqxDriver").jqxGrid('clear');
		}
 }
 
 function funSearchLoad(){
     changeContent('oreMainSearch.jsp');  
 }
	
 function funChkButton() {
		/* funReset(); */
	}
 
 function funFocus(){
    	$('#jqxOtherRequestDate').jqxDateTimeInput('focus'); 	    		
    }
 
 /* Validations */
     $(function(){
        $('#frmOtherRequest').validate({
        	    rules: {
                cmbratype:"required",
                txtamount:{number:true},
                txtdescription:{maxlength:400},
                txtremarks:{maxlength:400}
                 },
                 messages: {
                 cmbratype:" *",
                 txtamount:{number:"Invalid"},
                 txtdescription: {maxlength:"    Max 400 chars"},
                 txtremarks: {maxlength:"    Max 400 chars"}
                 }
        });}); 
   
  function funNotify(){	 
	  
	  if($('#txtrano').val()==""){
		  document.getElementById("errormsg").innerText="Choose an Agreement.";
		  return 0;
	  }
	  
	  /* Other Request Grid  Saving*/
		 var rows = $("#jqxOtherRequest").jqxGrid('getrows');
		 var length=0;
			 for(var i=0 ; i < rows.length ; i++){
				var chk=rows[i].amount;
				var chks=rows[i].typeid;
				if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){
				  if(typeof(chks) != "undefined" && typeof(chks) != "NaN" && chks != ""){
					newTextBox = $(document.createElement("input"))
				    .attr("type", "dil")
				    .attr("id", "test"+length)
				    .attr("name", "test"+length)
					.attr("hidden", "true");
					length=length+1;
					
		    newTextBox.val(rows[i].type+"::"+rows[i].remarks+"::"+rows[i].amount+"::"+rows[i].typeid);
			newTextBox.appendTo('form');
			  }
			 }
			}
		 $('#gridlength').val(length);
		 
		 var rows = $("#jqxDriver").jqxGrid('getrows');
		 var length1=0;
			 for(var i=0 ; i < rows.length ; i++){
				var chk=rows[i].name;
				if(typeof(chk) != "undefined"){
					length1=length1+1;
					newTextBox = $(document.createElement("input"))
				    .attr("type", "dil")
				    .attr("id", "tested"+i)
				    .attr("name", "tested"+i)
				    .attr("hidden", "true");
			
			newTextBox.val(rows[i].name+" :: "+rows[i].hiddob+":: "+rows[i].nation1+":: "+rows[i].mobno+":: "+rows[i].passport_no+":: "+rows[i].hidpassexp+":: "+rows[i].dlno+":: "+rows[i].hidissdate+":: "+rows[i].issfrm+":: "+rows[i].hidled+":: "+rows[i].ltype+":: "+rows[i].visano+":: "+rows[i].hidvisaexp+"::"+rows[i].dr_id);
			newTextBox.appendTo('form');
			 }
			}
 		 $('#drivergridlength').val(length1);
	   /* Other Request Grid  Saving Ends*/
	   
	   
	   if($('#gridlength').val()==0 && $("#adddriverintickval").val()==0){
			  document.getElementById("errormsg").innerText="Choose an Service Type or Additional Driver.";
			  return 0;
		  }
	   
	   if($('#gridlength').val()==0 && $("#adddriverintickval").val()==1){
		   if($('#drivergridlength').val()==0){
			  document.getElementById("errormsg").innerText="Enter Atleast One Additional Driver.";
			  return 0;
		   }
	  }
	   
	   if($('#drivergridlength').val()==0 && $("#adddriverintickval").val()==1){
				  document.getElementById("errormsg").innerText="Enter Atleast One Additional Driver.";
				  return 0;
		  }
	   
		$('#jqxOtherRequestDate').jqxDateTimeInput({disabled: false});
    	return 1;
	} 
  
  function setValues(){
	  
	  document.getElementById("cmbratype").value=document.getElementById("hidcmbratype").value;
	  
	  if($('#hidjqxOtherRequestDate').val()){
			 $("#jqxOtherRequestDate").jqxDateTimeInput('val', $('#hidjqxOtherRequestDate').val());
		  }

	  if(document.getElementById("adddriverintickval").value==1){
			 document.getElementById("chkadddriver").checked = true;
		 }
		 else if(document.getElementById("adddriverintickval").value==0){
			document.getElementById("chkadddriver").checked = false;
		 }
	  
	   if($('#msg').val()!=""){
		   $.messager.alert('Message',$('#msg').val());
		  }
	   
	   document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
	   funSetlabel();
	   
	   var indexVal = document.getElementById("docno").value;
	   var indexVal1 = document.getElementById("txtclientdocno").value;
	   if(indexVal>0){
      		$("#otherRequestGridDiv").load("otherRequestGrid.jsp?txtotherrequestdocno2="+indexVal);
      		
      		$("#DriverDiv").load("driver.jsp?docNo="+indexVal+"&clientId="+indexVal1);
	   }
	   
	}
  
  function funPrintBtn() {
		
		if (($("#mode").val() == "view") && $("#docno").val()!="") {
	        var url=document.URL;
	        var reurl=url.split("saveOtherRequest");
	        $("#docno").prop("disabled", false);  
	     
			var win= window.open(reurl[0]+"printExtraServiceRequest?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value,"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
		    win.focus();
	     }
	    else {
			$.messager.alert('Message','Select a Document....!','warning');
			return;
		}
    }
  
  function checkAdditionalDriver(){
  	if(document.getElementById("chkadddriver").checked==true){
  		$('#txtamount').attr('readonly', false);
  		$('#txtdescription').attr('readonly', false);
  		$("#btnAdditionalDriverSearch").prop("disabled", false);
  		$("#btnAdditionalDriverAdd").prop("disabled", false);
  		$("#jqxDriver").jqxGrid({ disabled: true});
  		document.getElementById("adddriverintickval").value=1;	
  		}
  	else{
  		 $("#btnAdditionalDriverSearch").prop("disabled", true);
  		 $("#btnAdditionalDriverAdd").prop("disabled", true);
  		 $('#txtamount').attr('readonly', true);
  		 $('#txtdescription').attr('readonly', true);
  		 $("#jqxDriver").jqxGrid({ disabled: true});
  		 document.getElementById("adddriverintickval").value=0;	
  		}
  	}
  
  function funAdditionalDriverSearch(){
	  var indexVal = document.getElementById("adddriverintickval").value;
	  var indexVal1 = document.getElementById("txtclientdocno").value;
	  var indexVal2 = document.getElementById("cmbratype").value;
	  var indexVal3 = document.getElementById("txtrano").value;
		 
	     if(indexVal1==''){
			 $.messager.alert('Message','Client is Mandatory.','warning');
			 return 0;
		 }
	  
		if(indexVal2==''){
			 $.messager.alert('Message','Please Choose RA Type.','warning');
			 return 0;
		 }
		 
		 if(indexVal3==''){
			 $.messager.alert('Message','Agreement No. is Mandatory.','warning');
			 return 0;
		 }
		 
	   if(indexVal==1){
		   if(indexVal1>0 && indexVal3!=""){
			   driverSearchContent("clientDriverSearch.jsp?clientId="+indexVal1+"&raType="+indexVal2+"&raNo="+indexVal3);
		   }
	   }  
  }
  
  function funAdditionalDriverAdd(){
	  var rows = $('#jqxDriver').jqxGrid('getrows');
  	  var rowlength= rows.length;
  	  var rowindex1 = rowlength - 1;
	  var driverId=$("#jqxDriver").jqxGrid('getcellvalue', rowindex1, "dr_id");
	  if(typeof(driverId) != "undefined"){
	  	$("#jqxDriver").jqxGrid({ disabled: false});
	  	$("#jqxDriver").jqxGrid('addrow', null, {});
	  }
  }
  
  function datechange(){
	  var date = $('#jqxOtherRequestDate').jqxDateTimeInput('getDate');
	  $("#maindate").jqxDateTimeInput('val', date);
  }
  
  function clearAgreement(){
	    document.getElementById("txtravocher").value="";
		document.getElementById("txtrano").value="";
		
		 if (document.getElementById("txtravocher").value == "") {
		        $('#txtravocher').attr('placeholder', 'Press F3 to Search'); 
		    }
   }
			 
</script>

<style>
.hidden-scrollbar {
  overflow: auto;
  height: 530px;
}
</style>

</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmOtherRequest" action="saveOtherRequest" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include><br/>

<div  class='hidden-scrollbar'>
<fieldset>
<table width="100%">
  <tr>
    <td width="6%" align="right">Date</td>
    <td width="18%"><div id="jqxOtherRequestDate" name="jqxOtherRequestDate" onchange="datechange();" value='<s:property value="jqxOtherRequestDate"/>'></div>
    <input type="hidden" id="hidjqxOtherRequestDate" name="hidjqxOtherRequestDate" value='<s:property value="hidjqxOtherRequestDate"/>'/></td>
    <td width="14%" align="right">Ref. No.</td>
    <td colspan="2"><input type="text" id="txtrefno" name="txtrefno" style="width:50%;" value='<s:property value="txtrefno"/>'/></td>
    <td colspan="2" align="right">Doc No.</td>
    <td width="14%"><input type="text" id="docno" name="txtotherrequestdocno" style="width:70%;" value='<s:property value="txtotherrequestdocno"/>' tabindex="-1"/>
  </tr>
  <tr>
    <td align="right">Client</td>
    <td colspan="2"><input type="text" id="txtclientname" name="txtclientname" placeholder="Press F3 to Search" style="width:70%;" value='<s:property value="txtclientname"/>' ondblclick="funSearchdblclick();" onkeydown="getClient(event);"/>
    <input type="hidden" id="txtclientdocno" name="txtclientdocno" value='<s:property value="txtclientdocno"/>'/></td>
    
    <td width="7%" align="right">RA Type</td>
    <td width="13%"><select id="cmbratype" name="cmbratype" style="width:50%;" onchange="clearAgreement();" value='<s:property value="cmbratype"/>'>
      <option value="RAG">Rental</option><option value="LAG">Lease</option></select>
      <input type="hidden" id="hidcmbratype" name="hidcmbratype" value='<s:property value="hidcmbratype"/>'/></td>
    <td width="6%" align="right">RA No.</td>
    <td colspan="2"><input type="text" id="txtravocher" name="txtravocher" placeholder="Press F3 to Search" style="width:27%;" value='<s:property value="txtravocher"/>' ondblclick="funSearchdblclick();" onkeydown="getAgreement(event);"/>
    <input type="hidden" id="txtrano" name="txtrano" value='<s:property value="txtrano"/>'/></td>
  </tr>
  <tr>
    <td align="right">Remarks</td>
    <td colspan="7"><input type="text" id="txtremarks" name="txtremarks" style="width:72%;" value='<s:property value="txtremarks"/>'/></td>
  </tr>
</table>
</fieldset><br/>

<div id="otherRequestGridDiv"><jsp:include page="otherRequestGrid.jsp"></jsp:include></div>

<fieldset style="background-color:#ECF8E0;"><legend><input type="checkbox" id="chkadddriver" name="chkadddriver" onchange="checkAdditionalDriver();"><b>Additional Driver</b></legend>
<input type="hidden" id="adddriverintickval" name="adddriverintickval" value='<s:property value="adddriverintickval"/>'>
<table width="100%">
  <tr>
    <td width="7%" align="center"><button type="button" class="icon1" id="btnAdditionalDriverSearch" title="Search Additional Driver" onclick="funAdditionalDriverSearch();">
							<img alt="Search Additional Driver" src="<%=contextPath%>/icons/driverSearch.png">
						</button></td>
    <td width="7%" align="left"><button type="button" class="icon1" id="btnAdditionalDriverAdd" title="Add Additional Driver" onclick="funAdditionalDriverAdd();">
							<img alt="Add Additional Driver" src="<%=contextPath%>/icons/driverAdd.png">
						</button></td>
    <td width="6%" align="right">Amount</td>
    <td width="19%"><input type="text" id="txtamount" name="txtamount" style="width:70%;text-align: right;" value='<s:property value="txtamount"/>' onblur="funRoundAmt(this.value,this.id);" /></td>
    <td width="8%" align="right">Description</td>
    <td width="53%"><input type="text" id="txtdescription" name="txtdescription" style="width:65%;" value='<s:property value="txtdescription"/>'/></td>
  </tr>
</table>
<div id="DriverDiv"><jsp:include page="driver.jsp"></jsp:include></div><br/>

</fieldset>

<input type="hidden" id="mode" name="mode"/>
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<div hidden="true" id="maindate" name="maindate" value='<s:property value="maindate"/>'></div>
<input type="hidden" id="hidmaindate" name="hidmaindate" value='<s:property value="hidmaindate"/>'/>
<input type="hidden" name="txtforsearch" id="txtforsearch" value='<s:property value="txtforsearch"/>'/>
<input type="hidden" id="gridlength" name="gridlength"/>
<input type="hidden" id="drivergridlength" name="drivergridlength"/>
</div>
</form>
<div id="clientDetailsWindow">
	<div></div><div></div>
</div> 
<div id="agreementDetailsWindow">
	<div></div><div></div>
</div>
<div id="driverDetailsWindow">
	<div></div><div></div>
</div>
<div id="nationalityWindow">
   <div></div>
</div>
<div id="stateWindow">
   <div></div>
</div>
<div id="serviceWindow">
   <div></div>
</div>

</div>
</body>
</html>