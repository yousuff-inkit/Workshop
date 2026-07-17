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
		$("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		$("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 
		$('#employeeDetailsWindow').jqxWindow({width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Employee Search',position: { x: 250, y: 120 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	    $('#employeeDetailsWindow').jqxWindow('close');
	    
	    $('#userDetailsWindow').jqxWindow({width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'User Search',position: { x: 250, y: 120 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	    $('#userDetailsWindow').jqxWindow('close');
	    
	    $('#supportDetailsWindow').jqxWindow({width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Support Search',position: { x: 250, y: 120 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	    $('#supportDetailsWindow').jqxWindow('close');
	     
		$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	    
	     var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	});
	
	function employeeSearchContent(url) {
	    $('#employeeDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#employeeDetailsWindow').jqxWindow('setContent', data);
		$('#employeeDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function userSearchContent(url) {
		$('#userDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#userDetailsWindow').jqxWindow('setContent', data);
		$('#userDetailsWindow').jqxWindow('bringToFront');
	}); 
	} 
	
	function supportSearchContent(url) {
		$('#supportDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#supportDetailsWindow').jqxWindow('setContent', data);
		$('#supportDetailsWindow').jqxWindow('bringToFront');
	}); 
	} 
	
	function getCompany() {
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText;
  				items = items.split('####');
  				var companyItems = items[0].split(",");
  				var companyIdItems = items[1].split(",");
  				var optionstype = '<option value="">--Select--</option>';
  				for (var i = 0; i < companyItems.length; i++) {
  					optionstype += '<option value="' + companyIdItems[i] + '">'
  							+ companyItems[i] + '</option>';
  				}
  				$("select#cmbcompany").html(optionstype);
  				if ($('#hidcmbcompany').val() != null) {
  					$('#cmbcompany').val($('#hidcmbcompany').val());
  				}
  			} else {
  			}
  		}
  		x.open("GET", "getCompany.jsp", true);
  		x.send();
  	}
	
	function getIssueCategory() {
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText;
  				items = items.split('####');
  				var IssueNameItems = items[0].split(",");
  				var IssueIdItems = items[1].split(",");
  				var optionsproject = '<option value="">--Select--</option>';
  				for (var i = 0; i < IssueNameItems.length; i++) {
  					optionsproject += '<option value="' + IssueIdItems[i] + '">'
  							+ IssueNameItems[i] + '</option>';
  				}
  				$("select#cmbissuecategory").html(optionsproject);
  				if ($('#hidcmbissuecategory').val() != null) {
  					$('#cmbissuecategory').val($('#hidcmbissuecategory').val());
  				}
  			} else {
  			}
  		}
  		x.open("GET", "getIssueCategory.jsp", true);
  		x.send();
  	}
	
	function getEmployee(event){
        var x= event.keyCode;
        if(x==114){
			  employeeSearchContent("employeeDetailsSearchGrid.jsp");
        }
        else{}
        }
	
	function getUserName(event){
        var x= event.keyCode;
        if(x==114){
      	  var company=$('#cmbcompany').val();
			  if(company==""){
	 				 $.messager.alert('Message','Choose Company and Search User.','warning');
	 				 return 0;
	 			 }
			  userSearchContent("userDetailsSearchGrid.jsp?company="+company);
        }
        else{
         }
        }
	
	function getSupportName(event){
        var x= event.keyCode;
        if(x==114){
      	  supportSearchContent("supportDetailsSearchGrid.jsp");
        }
        else{
         }
        }
	
	function funSearchdblclick(){
		  $('#txtemployee').dblclick(function(){
			  employeeSearchContent("employeeDetailsSearchGrid.jsp");
			});
		  
		  $('#txtusername').dblclick(function(){
			  var company=$('#cmbcompany').val();
			  if(company==""){
				     $.messager.alert('Message','Choose Company and Search User.','warning');
	 				 return 0;
	 			 }
			  userSearchContent("userDetailsSearchGrid.jsp?company="+company);
			  });
		  
		  	 $('#txtsupportname').dblclick(function(){
			  supportSearchContent("supportDetailsSearchGrid.jsp");
			  });
	}
	
	function  funClearData(){
		 $('#fromdate').val(new Date());$('#todate').val(new Date());$('#cmbcompany').val('');$('#hidcmbcompany').val('');$('#txtusername').val('');
		 $('#txtuserid').val('');$('#txtemployee').val('');$('#txtempid').val('');$('#cmbstatus').val('');$('#hidcmbstatus').val('');$('#cmbissuecategory').val('');
		 $('#hidcmbissuecategory').val('');$('#txtsupportname').val('');$('#txtsupportid').val('');
		 
		 var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	     
		 if (document.getElementById("txtusername").value == "") {
		        $('#txtusername').attr('placeholder', 'Press F3 to Search'); 
		    }
		 
		 if (document.getElementById("txtemployee").value == "") {
		        $('#txtemployee').attr('placeholder', 'Press F3 to Search'); 
		    }
		 
		 if (document.getElementById("txtsupportname").value == "") {
		        $('#txtsupportname').attr('placeholder', 'Press F3 to Search'); 
		    }
	 }

	function funreload(event){
			 var branchval = document.getElementById("cmbbranch").value;
			 var fromdate = $('#fromdate').val();
			 var todate = $('#todate').val();
			 var company = $('#cmbcompany').val();
			 var userid = $('#txtuserid').val();
			 var action = $('#txtempid').val();
			 var status = $('#cmbstatus').val();
			 var category = $('#cmbissuecategory').val();
			 var support = $('#txtsupportid').val();
			 
			 var check=1;
			 $("#overlay, #PleaseWait").show();
			 
			 $("#supportDetailsDiv").load("supportDetailsGrid.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&company='+company+'&userid='+userid+'&action='+action+'&status='+status+'&category='+category+'&support='+support+'&check='+check);
	}
		
</script>

</head>
<body onload="getBranch();getCompany();getIssueCategory();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%"  >
	<jsp:include page="../../heading.jsp"></jsp:include>
		
    <tr><td colspan="2">&nbsp;</td></tr>
    <tr><td align="right"><label class="branch">Period</label></td>
        <td align="left"><div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div></td></tr> <tr>
	<tr><td align="right"><label class="branch">To</label></td>
    <td align="left"><div id="todate" name="todate" value='<s:property value="todate"/>'></div></td></tr>  
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td align="right"><label class="branch">Company</label></td>
	<td align="left"><select id="cmbcompany" name="cmbcompany" style="width:80%;" value='<s:property value="cmbcompany"/>'>
       <option value="">--Select--</option></select>
       <input type="hidden" id="hidcmbcompany" name="hidcmbcompany" value='<s:property value="hidcmbcompany"/>'/></td></tr>
    <tr><td align="right"><label class="branch">User</label></td>
	<td align="left"><input type="text" id="txtusername" name="txtusername" style="width:100%;height:20px;" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtusername"/>' ondblclick="funSearchdblclick();" onkeydown="getUserName(event);"/>
	<input type="hidden" id="txtuserid" name="txtuserid" value='<s:property value="txtuserid"/>'/></td></tr>
	<tr><td align="right"><label class="branch">Action</label></td>
	<td align="left"><input type="text" id="txtemployee" name="txtemployee" style="width:100%;height:20px;" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtemployee"/>' ondblclick="funSearchdblclick();" onkeydown="getEmployee(event);"/>
	<input type="hidden" id="txtempid" name="txtempid" value='<s:property value="txtempid"/>'/></td></tr>
	<tr><td  align="right"><label class="branch">Status</label></td>
    <td align="left"><select id="cmbstatus" name="cmbstatus" value='<s:property value="cmbstatus"/>'>
      <option value="">--Select--</option><option value=1>Open</option><option value=2>Pending</option><option value=0>Closed</option></select>
      <input type="hidden" id="hidcmbstatus" name="hidcmbstatus" value='<s:property value="hidcmbstatus"/>'/></td></tr>
	<tr><td align="right"><label class="branch">Category</label></td>
	<td align="left"><select id="cmbissuecategory" name="cmbissuecategory" style="width:80%;" value='<s:property value="cmbissuecategory"/>'>
       <option value="">--Select--</option></select>
       <input type="hidden" id="hidcmbissuecategory" name="hidcmbissuecategory" value='<s:property value="hidcmbissuecategory"/>'/></td></tr>
	<tr><td align="right"><label class="branch">Support</label></td>
	<td align="left"><input type="text" id="txtsupportname" name="txtsupportname" style="width:100%;height:20px;" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtsupportname"/>' ondblclick="funSearchdblclick();" onkeydown="getSupportName(event);"/>
	<input type="hidden" id="txtsupportid" name="txtsupportid" value='<s:property value="txtsupportid"/>'/></td></tr>
	<tr><td colspan="2">&nbsp;</td></tr> 
	<tr><td colspan="2" align="center"><input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funClearData();"></td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td style="background-color: #FFEBEB;"></td>
	<td align="left"><label class="branch">Open</label></td></tr>
	<tr><td style="background-color: #FFFFD1;"></td>
	<td align="left"><label class="branch">Pending</label></td></tr>
	<tr><td style="background-color: #D8F6CE;"></td>
	<td align="left"><label class="branch">Closed</label></td></tr>
    <tr><td colspan="2">&nbsp;</td></tr> 
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="supportDetailsDiv"><jsp:include page="supportDetailsGrid.jsp"></jsp:include></div></td>
		</tr>
	</table>
</tr>
</table>
</div>

<div id="employeeDetailsWindow">
	<div></div><div></div>
</div>
<div id="userDetailsWindow">
	<div></div><div></div>
</div>  
<div id="supportDetailsWindow">
	<div></div><div></div>
</div>  

</div> 
</body>
</html>