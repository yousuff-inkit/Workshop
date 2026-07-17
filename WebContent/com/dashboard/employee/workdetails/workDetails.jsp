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
	
	function getWorkType() {
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText;
  				items = items.split('####');
  				var typeItems = items[0].split(",");
  				var typeIdItems = items[1].split(",");
  				var optionstype = '<option value="">--Select--</option>';
  				for (var i = 0; i < typeItems.length; i++) {
  					optionstype += '<option value="' + typeIdItems[i] + '">'
  							+ typeItems[i] + '</option>';
  				}
  				$("select#cmbcorrectiontype").html(optionstype);
  				if ($('#hidcmbcorrectiontype').val() != null) {
  					$('#cmbcorrectiontype').val($('#hidcmbcorrectiontype').val());
  				}
  			} else {
  			}
  		}
  		x.open("GET", "getWorkType.jsp", true);
  		x.send();
  	}
	
	function getProjects() {
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText;
  				items = items.split('####');
  				var projectNameItems = items[0].split(",");
  				var projectIdItems = items[1].split(",");
  				var optionsproject = '<option value="">--Select--</option>';
  				for (var i = 0; i < projectNameItems.length; i++) {
  					optionsproject += '<option value="' + projectIdItems[i] + '">'
  							+ projectNameItems[i] + '</option>';
  				}
  				$("select#cmbproject").html(optionsproject);
  				if ($('#hidcmbproject').val() != null) {
  					$('#cmbproject').val($('#hidcmbproject').val());
  				}
  			} else {
  			}
  		}
  		x.open("GET", "getProjects.jsp", true);
  		x.send();
  	}
	
	function getEmployee(event){
        var x= event.keyCode;
        if(x==114){
        	 var project=$('#cmbproject').val();
			  if(project==""){
	 				 document.getElementById("errormsg").innerText="Choose Project and Search Employee.";
	 				 return 0;
	 			 }
			  employeeSearchContent("employeeDetailsSearchGrid.jsp?project="+project);
        }
        else{}
        }
	
	function funSearchdblclick(){
		  $('#txtemployee').dblclick(function(){
			  var project=$('#cmbproject').val();
			  if(project==""){
	 				 document.getElementById("errormsg").innerText="Choose Project and Search Employee.";
	 				 return 0;
	 			 }
			  employeeSearchContent("employeeDetailsSearchGrid.jsp?project="+project);
			});
	}
	
	function  funClearData(){
		 $('#cmbproject').val('');$('#txtemployee').val('');$('#cmbcorrectiontype').val('');$('#fromdate').val(new Date());$('#todate').val(new Date());
		
		 var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	     
		 if (document.getElementById("txtemployee").value == "") {
		        $('#txtemployee').attr('placeholder', 'Press F3 to Search'); 
		    }
	 }

	function funreload(event){
			 var branchval = document.getElementById("cmbbranch").value;
			 var fromdate = $('#fromdate').val();
			 var todate = $('#todate').val();
			 var project = $('#cmbproject').val();
			 var employee = $('#txtemployee').val();
			 var type = $('#cmbcorrectiontype').val();
			 
			 var check=1;
			 $("#overlay, #PleaseWait").show();
			 
			 $("#workDetailsDiv").load("workDetailsGrid.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&project='+project+'&employee='+employee+'&type='+type+'&check='+check);
	}
		
</script>

</head>
<body onload="getBranch();getProjects();getWorkType();">
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
	<tr><td align="right"><label class="branch">Project</label></td>
	<td align="left"><select id="cmbproject" name="cmbproject" style="width:80%;" value='<s:property value="cmbproject"/>'>
       <option value="">--Select--</option></select>
       <input type="hidden" id="hidcmbproject" name="hidcmbproject" value='<s:property value="hidcmbproject"/>'/></td></tr>
	<tr><td align="right"><label class="branch">Employee</label></td>
	<td align="left"><input type="text" id="txtemployee" name="txtemployee" style="width:100%;height:20px;" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtemployee"/>' ondblclick="funSearchdblclick();" onkeydown="getEmployee(event);"/></td></tr>
	<tr><td align="right"><label class="branch">Type</label></td>
	<td align="left"><select id="cmbcorrectiontype" name="cmbcorrectiontype" style="width:80%;" value='<s:property value="cmbcorrectiontype"/>'>
       <option value="">--Select--</option></select>
       <input type="hidden" id="hidcmbcorrectiontype" name="hidcmbcorrectiontype" value='<s:property value="hidcmbcorrectiontype"/>'/></td></tr>
	<tr><td colspan="2">&nbsp;</td></tr> 
	<tr><td colspan="2" align="center"><input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funClearData();"></td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr> 
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td style="background-color: #F8E0F7;"></td>
	<td align="left"><label class="branch">New Form</label></td></tr>
	<tr><td style="background-color: #FFFFD1;"></td>
	<td align="left"><label class="branch">Modification</label></td></tr>
	<tr><td style="background-color: #FFEBEB;"></td>
	<td align="left"><label class="branch">Correction</label></td></tr>
    <tr><td colspan="2">&nbsp;</td></tr> 
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="workDetailsDiv"><jsp:include page="workDetailsGrid.jsp"></jsp:include></div></td>
		</tr>
	</table>
</tr>
</table>
</div>

<div id="employeeDetailsWindow">
	<div></div><div></div>
</div>

</div> 
</body>
</html>