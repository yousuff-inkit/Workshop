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
</style>

<script type="text/javascript">

	$(document).ready(function () {
		 $("#uptodate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 
		 $('#accountDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailsWindow').jqxWindow('close');
		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	  
	     document.getElementById("rdpayment").checked=true;
	     document.getElementById("rdall").checked=true;
	     
		 $('#txtaccid').dblclick(function(){
			 if($('#cmbtype').val()==''){
    			 $.messager.alert('Message','Please Choose Account Type.','warning');
    			 return 0;
    		 }
			  accountsSearchContent('accountsDetailsSearch.jsp');
			});

	});
	
	function accountsSearchContent(url) {
	    $('#accountDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#accountDetailsWindow').jqxWindow('setContent', data);
		$('#accountDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function getAccTypeFrom(event){
        var x= event.keyCode;
        if(x==114){
    		if($('#cmbtype').val()==''){
    			 $.messager.alert('Message','Please Choose Account Type.','warning');
    			 return 0;
    		 }
      		accountsSearchContent('accountsDetailsSearch.jsp');
        }
        else{}
        }
	
	function clearAccountInfo(){
		$('#txtdocno').val('');$('#txtaccid').val('');$('#txtaccname').val('');
		
		if (document.getElementById("txtaccid").value == "") {
	        $('#txtaccid').attr('placeholder', 'Press F3 to Search'); 
	    }

	}
	
	function  funClearInfo(){
		
	    $('#uptodate').val(new Date());
	    
		document.getElementById("rdpayment").checked=true;
		document.getElementById("rdall").checked=true;
		
		$('#cmbbranch').val('a');
	    $('#cmbtype').val('0');
		$('#txtdocno').val('');$('#txtaccid').val('');$('#txtaccname').val('');
		
		$("#pdcOutStandingGridID").jqxGrid('clear');
		$("#pdcOutStandingGridID").jqxGrid('addrow', null, {});
		
		if (document.getElementById("txtaccid").value == "") {
	        $('#txtaccid').attr('placeholder', 'Press F3 to Search'); 
	    }
		
	}

	function funreload(event){
			 var branchval = document.getElementById("cmbbranch").value;
			 var uptodate = $('#uptodate').val();
			 var acctype = $('#cmbtype').val();
			 var accno = $('#txtdocno').val();
			 var reporttype = "";
			 
			 if(document.getElementById("rdall").checked==true){
				 reporttype = $('#rdall').val();
			 }else if(document.getElementById("rdpdc").checked==true){
				 reporttype = $('#rdpdc').val();
			 }else if(document.getElementById("rduncleared").checked==true){
				 reporttype = $('#rduncleared').val();
			 }
			 
			   $("#overlay, #PleaseWait").show();
			 
			   if(document.getElementById("rdreceipt").checked==true){
					  $("#pdcOutStandingDiv").load("pdcOutStandingGrid.jsp?code=FRO&reporttype="+reporttype+'&branchval='+branchval+'&uptodate='+uptodate+'&acctype='+acctype+'&accno='+accno+'&check=1');								 
			   } else {
					  $("#pdcOutStandingDiv").load("pdcOutStandingGrid.jsp?code=FPP&reporttype="+reporttype+'&branchval='+branchval+'&uptodate='+uptodate+'&acctype='+acctype+'&accno='+accno+'&check=1');								 
			   }
			}
	
	function funExportBtn(){
   		if(parseInt(window.parent.chkexportdata.value)=="1") {
   		  	JSONToCSVCon(data, 'PdcOutStanding', true);
   		 } else {
   			 $("#pdcOutStandingGridID").jqxGrid('exportdata', 'xls', 'PdcOutStanding');
   		 }
	}
		
</script>

</head>
<body onload="getBranch();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%"  >
	<jsp:include page="../../heading.jsp"></jsp:include>
		
    <tr><td colspan="2">&nbsp;</td></tr>
    <tr><td align="right"><label class="branch">Up To</label></td>
    <td align="left"><div id="uptodate" name="uptodate" value='<s:property value="uptodate"/>'></div></td></tr> 
    <tr><td colspan="2">&nbsp;</td></tr>
    <tr><td colspan="2">
	  <fieldset><legend><b><label class="branch">Type</label></b></legend>
	   <table width="100%">
       <tr>
       <td width="48%" align="center"><input type="radio" id="rdall" name="rdos" value="rdall"><label for="rdall" class="branch">All</label></td>
       <td width="52%" align="center"><input type="radio" id="rdpdc" name="rdos" value="rdpdc"><label for="rdpdc" class="branch">PDC</label></td>
       </tr>
       <tr>
       <td colspan="2" align="center"><input type="radio" id="rduncleared" name="rdos" value="rduncleared"><label for="rduncleared" class="branch">Uncleared</label></td>
       </tr>
       </table>
	  </fieldset>
	</td></tr>  
	<tr><td colspan="2">
	  <fieldset><legend><b><label class="branch">Report Type</label></b></legend>
	   <table width="100%">
       <tr>
       <td width="48%" align="center"><input type="radio" id="rdpayment" name="rdo" value="FPP"><label for="rdpayment" class="branch">Payment</label></td>
       <td width="52%" align="center"><input type="radio" id="rdreceipt" name="rdo" value="FRO"><label for="rdreceipt" class="branch">Receipt</label></td>
       </tr>
       </table>
	  </fieldset>
	</td></tr>
    <tr><td colspan="2">&nbsp;</td></tr>
 	<tr><td align="right"><label class="branch">Type</label></td>
	<td align="left"><select id="cmbtype" name="cmbtype" style="width:40%;" onchange="clearAccountInfo();" value='<s:property value="cmbtype"/>'>
    <option value="0">--Select--</option><option value="BANK">Bank</option><option value="AP">AP</option><option value="AR">AR</option></select></td></tr>
    <tr><td align="right"><label class="branch">Account</label></td>
	<td align="left"><input type="text" id="txtaccid" name="txtaccid" style="width:60%;height:20px;" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtaccid"/>' onkeydown="getAccTypeFrom(event);"/></td></tr> 
	 <tr><td>&nbsp;</td>
	<td><input type="text" id="txtaccname" name="txtaccname" style="width:100%;height:20px;" readonly="readonly" value='<s:property value="txtaccname"/>' tabindex="-1"/>
    <input type="hidden" id="txtdocno" name="txtdocno" value='<s:property value="txtdocno"/>'/></td></tr>
    <tr><td colspan="2">&nbsp;</td></tr>
    <tr><td colspan="2" align="center"><input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funClearInfo();"></td></tr>
	<tr><td colspan="2">&nbsp;</td></tr><tr><td colspan="2">&nbsp;</td></tr>
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="pdcOutStandingDiv"><jsp:include page="pdcOutStandingGrid.jsp"></jsp:include></div>
		</tr>
	</table>
</tr>
</table>
</div>
<div id="accountDetailsWindow">
	<div></div><div></div>
</div>
</div> 
</body>
</html>