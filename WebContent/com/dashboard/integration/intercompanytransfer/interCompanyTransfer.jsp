<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<script type="text/javascript" src="<%=contextPath%>/js/ajaxfileupload.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/resample.js"></script>
<style type="text/css">
.account {
	color: black;
	background-color: #E0ECF8;
	width: 100%;
	height: 28px;
	font-family: Myriad Pro;
	font-weight: bold;
}
.accname {
	color: black;
	background-color: #E0ECF8;
	width: 100%;
	font-family: comic sans ms;
}
.textbox {
    border: 0;
    height: 25px;
    width: 20%;
    border-radius: 5px;
    -moz-border-radius: 5px;
    -webkit-border-radius: 5px;
    box-shadow: 1px 1px 0 0 #E0ECF8, 5px 5px 40px 2px #E0ECF8 inset;
    -moz-box-shadow: 1px 1px 0 0 #E0ECF8, 5px 5px 40px 2px #E0ECF8 inset;
    -webkit-box-shadow: 1px 1px 0 0 #E0ECF8, 5px 5px 40px 2px #E0ECF8 inset;
    -webkit-background-clip: padding-box;
    outline: 0;
}

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
		 $("#date").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy", enableBrowserBoundsDetection: true});
		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	     
		 $('#accountDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailsWindow').jqxWindow('close');
		 
		 $('#txtmainaccount').dblclick(function(){
			  $('#txtcheckaccount').val('1');
			  accountsSearchContent('accountsDetailsSearch.jsp');
	     });
		 
		 $('#txtsubaccount').dblclick(function(){
			  if($('#txtmainaccountdocno').val()==''){
        		 $.messager.alert('Message','Choose Main Account and Search Sub Account.','warning');
    			 return 0;
        	  }
			  $('#txtcheckaccount').val('0');
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
	
	function funExportBtn(){
        	JSONToCSVCon(dataExcelExport, 'AccountsStatementGL', true);
	} 
	
	function datechange(){
	    var date = $('#date').jqxDateTimeInput('getDate');
		var validdate=funDateInPeriod(date);
		if(validdate==0){
			return 0;	
		}
    }
	
	function getMainAccount(event){
        var x= event.keyCode;
        if(x==114){
        	$('#txtcheckaccount').val('1');
      		accountsSearchContent('accountsDetailsSearch.jsp');
        }
        else{}
        }
	
	function getSubAccount(event){
        var x= event.keyCode;
        if(x==114){
        	if($('#txtmainaccountdocno').val()==''){
        		 $.messager.alert('Message','Choose Main Account and Search Sub Account.','warning');
    			 return 0;
        	}
        	$('#txtcheckaccount').val('0');
      		accountsSearchContent('accountsDetailsSearch.jsp');
        }
        else{}
        }
	
	function funClearData(){
		$('#uptodate').val(new Date());
		$('#date').val(new Date());
		$('#txtmainaccountdocno').val('');
		$('#txtmainaccount').val('');
		$('#txtmainaccountname').val('');
		$('#txtsubaccountdocno').val('');
		$('#txtsubaccount').val('');
		$('#txtsubaccountname').val('');
		$('#txtsubaccountcurid').val('');
		$('#txtsubaccountrate').val('');
		$('#txtsubaccountcurtype').val('');
		$('#txtcheckaccount').val('0');
		$('#txtnetamount').val('');
		document.getElementById("lblaccountname").innerText="";
		$("#interCompanyTransferGridID").jqxGrid('clear');
		
		if (document.getElementById("txtmainaccount").value == "") {
	        $('#txtmainaccount').attr('placeholder', 'Press F3 to Search'); 
	    }
		
		if (document.getElementById("txtsubaccount").value == "") {
	        $('#txtsubaccount').attr('placeholder', 'Press F3 to Search'); 
	    }
	}
	
	function funreload(event){
		
		 var branchval = document.getElementById("cmbbranch").value;
		 var uptodate = $('#uptodate').val();
		 var accdocno = $('#txtsubaccountdocno').val();
		 
		 if(accdocno==''){
			 $.messager.alert('Message','Sub Account is Mandatory.','warning');
			 return 0;
		 }

		 $("#overlay, #PleaseWait").show();
		 
		 document.getElementById("lblaccountname").innerText=$('#txtsubaccountname').val(); 
		 $("#interCompanyTransferDiv").load("interCompanyTransferGrid.jsp?branchval="+branchval+'&uptodate='+uptodate+'&accdocno='+accdocno+'&check=1');
		}
	
	function funPost(event){

		 var acc = $('#txtsubaccount').val();
		 var accdocno = $('#txtsubaccountdocno').val();
		 var acccurid = $('#txtsubaccountcurid').val();
		 var accrate = $('#txtsubaccountrate').val();
		 var acccurtype = $('#txtsubaccountcurtype').val();
		 
		 if(accdocno==''){
			 $.messager.alert('Message','Sub Account is Mandatory.','warning');
			 return 0;
		 }
		 
		 var selectedrows=$("#interCompanyTransferGridID").jqxGrid('selectedrowindexes');
		 selectedrows = selectedrows.sort(function(a,b){return a - b});
		
		 if(selectedrows.length==0){
			$("#overlay, #PleaseWait").hide();
			$.messager.alert('Warning','Select Items to be Calculated.');
			return false;
		 }
		 
		 var temp="";
		 var gridarray=new Array();
		 for(var i=0;i<selectedrows.length;i++){
			var acno=$('#txtmainaccountdocno').val();
			var accurid=$('#txtmainaccountcurid').val();
			var acrate=$('#txtmainaccountrate').val();
			var amount=$('#interCompanyTransferGridID').jqxGrid('getcellvalue',selectedrows[i],'ldramount');
			var description=$('#interCompanyTransferGridID').jqxGrid('getcellvalue',selectedrows[i],'description');
			var transtype=$('#interCompanyTransferGridID').jqxGrid('getcellvalue',selectedrows[i],'transtype');
			var transno=$('#interCompanyTransferGridID').jqxGrid('getcellvalue',selectedrows[i],'transno');
			
			if(i==0){
				temp=$('#interCompanyTransferGridID').jqxGrid('getcellvalue',selectedrows[i],'tr_no');
			} else {
				temp=temp+","+$('#interCompanyTransferGridID').jqxGrid('getcellvalue',selectedrows[i],'tr_no');
			}
			
			gridarray.push(acno+":: "+amount+":: "+description+":: "+transtype+":: "+transno+":: "+accurid+":: "+acrate);
			
		 }
		    
		 	var postingdate=$('#date').val();
		 	$('#txtselectedtrno').val(temp);
		 	var selectedtrno = $('#txtselectedtrno').val();
		 	
		 	if(postingdate==''){
				 $.messager.alert('Message','Please Enter Posting Date.','warning');
				 return 0;
			}
		 	
		 	var date = $('#date').jqxDateTimeInput('getDate');
			var validdate=funDateInPeriod(date);
			if(validdate==0){
				return 0;	
			}
		 	
		    $.messager.confirm('Message', 'Do you want to save changes?', function(r){
			        
		     	if(r==false)
		     	  {
		     		return false; 
		     	  }
		     	else {
		     		 saveGridData(acc,accdocno,acccurid,accrate,acccurtype,postingdate,selectedtrno,gridarray);	
		     	}
		 });
	}
	
	function saveGridData(acc,accdocno,acccurid,accrate,acccurtype,postingdate,selectedtrno,gridarray) {
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText;
				items = items.split('***');
				var val = items[0];
				var jvno = items[1];
				
				$.messager.alert('Message', ' JV No.: '+items[1]+' is Generated Successfully.', function(r){
				});
				
				var mainaccountdocno = $('#txtmainaccountdocno').val('');
				var mainaccount = $('#txtmainaccount').val('');
				var mainaccountname = $('#txtmainaccountname').val('');
				var subaccountdocno = $('#txtsubaccountdocno').val('');
				var subaccount = $('#txtsubaccount').val('');
				var subaccountname = $('#txtsubaccountname').val('');
				var subacccurid = $('#txtsubaccountcurid').val('');
				var subaccrate = $('#txtsubaccountrate').val('');
				var subacccurtype = $('#txtsubaccountcurtype').val('');
				var checkingaccount = $('#txtcheckaccount').val('0');
				var netamount = $('#txtnetamount').val('');
				$('#uptodate').val(new Date());
				$('#date').val(new Date());
				document.getElementById("lblaccountname").innerText="";
				$("#interCompanyTransferGridID").jqxGrid('clear');
				
				if (document.getElementById("txtmainaccount").value == "") {
			        $('#txtmainaccount').attr('placeholder', 'Press F3 to Search'); 
			    }
				
				if (document.getElementById("txtsubaccount").value == "") {
			        $('#txtsubaccount').attr('placeholder', 'Press F3 to Search'); 
			    }
		  }
		}
			
		
	x.open("GET","saveData.jsp?acc="+acc+"&accdocno="+accdocno+"&acccurid="+acccurid+"&accrate="+accrate+"&acccurtype="+acccurtype+"&postingdate="+postingdate+"&selectedtrno="+selectedtrno+"&gridarray="+gridarray,true);
	x.send();
	}
	
</script>
</head>
<body onload="getBranch();">
<div id="mainBG" class="homeContent" data-type="background"> 
<form id="frmAccountStatementType" action="saveAccountStatementType" method="post" autocomplete="off">
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%"  >
	<jsp:include page="../../heading.jsp"></jsp:include>
		
	 <tr><td colspan="2">&nbsp;</td></tr> 
	<tr>
	<td align="right"><label class="branch">UpTo</label></td>
    <td align="left"><div id="uptodate" name="uptodate" value='<s:property value="uptodate"/>'></div></td>
	</tr>  
	<tr><td colspan="2">&nbsp;</td></tr> 
    <tr><td align="right"><label class="branch">Main</label></td>
	<td align="left"><input type="text" id="txtmainaccount" name="txtmainaccount" style="width:60%;height:20px;" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtmainaccount"/>' onkeydown="getMainAccount(event);"/></td></tr> 
	<tr><td>&nbsp;</td>
	<td><input type="text" id="txtmainaccountname" name="txtmainaccountname" style="width:100%;height:20px;" readonly="readonly" value='<s:property value="txtmainaccountname"/>' tabindex="-1"/>
    <input type="hidden" id="txtmainaccountdocno" name="txtmainaccountdocno" value='<s:property value="txtmainaccountdocno"/>'/></td></tr> 
	<tr><td align="right"><label class="branch">Sub</label></td>
	<td align="left"><input type="text" id="txtsubaccount" name="txtsubaccount" style="width:60%;height:20px;" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtsubaccount"/>' onkeydown="getSubAccount(event);"/></td></tr> 
	<tr><td>&nbsp;</td>
	<td><input type="text" id="txtsubaccountname" name="txtsubaccountname" style="width:100%;height:20px;" readonly="readonly" value='<s:property value="txtsubaccountname"/>' tabindex="-1"/>
    <input type="hidden" id="txtsubaccountdocno" name="txtsubaccountdocno" value='<s:property value="txtsubaccountdocno"/>'/></td></tr>
    <tr><td align="right"><label class="branch">Posting</label></td>
    <td align="left"><div id="date" name="date" onchange="datechange();" value='<s:property value="date"/>'></div></td></tr>
    <tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2" align="center"><input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funClearData();">
	<button class="myButton" type="button" id="btnPost" name="btnPost" onclick="funPost(event);">Post</button></td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
	    <tr><td><label class="account">Account :&nbsp;</label><label class="accname" name="lblaccountname" id="lblaccountname"></label></td></tr> 
		<tr>
			 <td><div id="interCompanyTransferDiv"><jsp:include page="interCompanyTransferGrid.jsp"></jsp:include></div></td>
		</tr>
	</table>
</tr>
</table>
<table width="100%">
<tr>
		<td width="92%" align="right" style="font-family: Myriad Pro;font-size: 12px;font-weight: bold;">Net Amount :&nbsp;</td>
        <td width="8%" align="left"><input type="text" class="textbox" id="txtnetamount" name="txtnetamount" style="width:80%;text-align: right;" value='<s:property value="txtnetamount"/>'/></td>
</tr>
</table>

<input type="hidden" id="txtmainaccountcurid" name="txtmainaccountcurid" style="width:10%;height:20px;" value='<s:property value="txtmainaccountcurid"/>'/>
<input type="hidden" id="txtmainaccountrate" name="txtmainaccountrate" style="width:10%;height:20px;" value='<s:property value="txtmainaccountrate"/>'/>
<input type="hidden" id="txtmainaccountcurtype" name="txtmainaccountcurtype" style="width:10%;height:20px;" value='<s:property value="txtmainaccountcurtype"/>'/>
<input type="hidden" id="txtcheckaccount" name="txtcheckaccount" style="width:10%;height:20px;" value='<s:property value="txtcheckaccount"/>'/>
<input type="hidden" id="txtsubaccountcurid" name="txtsubaccountcurid" style="width:10%;height:20px;" value='<s:property value="txtsubaccountcurid"/>'/>
<input type="hidden" id="txtsubaccountrate" name="txtsubaccountrate" style="width:10%;height:20px;" value='<s:property value="txtsubaccountrate"/>'/>
<input type="hidden" id="txtsubaccountcurtype" name="txtsubaccountcurtype" style="width:10%;height:20px;" value='<s:property value="txtsubaccountcurtype"/>'/>
<input type="hidden" id="txtselectedtrno" name="txtselectedtrno" style="width:10%;height:20px;" value='<s:property value="txtselectedtrno"/>'/>

</div>
</form>
<div id="accountDetailsWindow">
	<div></div><div></div>
</div>
</div> 
</body>
</html>