<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 
<style type="text/css">
.myButtons {
	display: inline-block;
	margin-right:4px;
	margin-left:4px; 
  margin-bottom: 0;
  font-weight: normal;
  line-height: 1.3;
  text-align: center;
  white-space: nowrap;
  vertical-align: middle;
  -ms-touch-action: manipulation;
      touch-action: manipulation;
  cursor: pointer;
  -webkit-user-select: none;
     -moz-user-select: none;
      -ms-user-select: none;
          user-select: none;
  background-image: none;
  border: 1px solid transparent;
  border-radius: 4px;
  color: #fff;
  background-color: grey;
}
.myButtons:hover {
	  color: #fff;
  background-color: #31b0d5;
  
}
.myButtons:active {
  color: #fff;
  background-color: #31b0d5;
  
}
.myButtons:focus {
  color: #fff;
  background-color: grey;
}
</style>

<script type="text/javascript">

$(document).ready(function () {
	  // setType(null);
	  
	   $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200px;right:750px;'><img src='../../../../icons/31load.gif'/></div>");
	 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $('#clientgroupdiv').hide();
	  $('#brandwindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '80%' ,maxWidth: '50%' , title: 'Brand Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   $('#brandwindow').jqxWindow('close');
	   $('#clientwindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '80%' ,maxWidth: '50%' , title: 'Client Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   $('#clientwindow').jqxWindow('close');
	   $('#modelwindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '80%' ,maxWidth: '50%' , title: 'Model Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   $('#modelwindow').jqxWindow('close');
	   $('#groupwindow').jqxWindow({ width: '50%',height: '60%',  maxHeight: '80%'  ,maxWidth: '50%' , title: 'Group Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   $('#groupwindow').jqxWindow('close');
	   $('#yomwindow').jqxWindow({ width: '50%',height: '60%',  maxHeight: '80%'  ,maxWidth: '50%' , title: 'YOM Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   $('#yomwindow').jqxWindow('close');
	   $('#fleetwindow').jqxWindow({ width: '50%',height: '60%',  maxHeight: '80%'  ,maxWidth: '50%' , title: 'Fleet Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   $('#fleetwindow').jqxWindow('close');
	   
	   var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
       var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
       $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate); 
      
});

function getBrand(){
	 $('#brandwindow').jqxWindow('open');
		$('#brandwindow').jqxWindow('focus');
		 brandSearchContent('brandSearch.jsp?id=1', $('#brandwindow'));

}

function getClient(){
	 $('#clientwindow').jqxWindow('open');
		$('#clientwindow').jqxWindow('focus');
		 clientSearchContent('clientSearch.jsp?id=1', $('#clientwindow'));

}

function getModel(){
	
	 $('#modelwindow').jqxWindow('open');
		$('#modelwindow').jqxWindow('focus');
		 modelSearchContent('modelSearch.jsp?id=1', $('#brandwindow'));

}

function getGroup(event){

	$('#groupwindow').jqxWindow('open');
	$('#groupwindow').jqxWindow('focus');
	 groupSearchContent('groupSearch.jsp?id=1', $('#groupwindow'));

}
function getYom(event){

	 $('#yomwindow').jqxWindow('open');
		$('#yomwindow').jqxWindow('focus');
		 yomSearchContent('yomSearch.jsp?id=1', $('#yomwindow'));
}
function getFleet(event){

	 $('#fleetwindow').jqxWindow('open');
		$('#fleetwindow').jqxWindow('focus');
		 fleetSearchContent('fleetSearch.jsp?id=1', $('#fleetwindow'));
}



function brandSearchContent(url) {
    //alert(url);
      $.get(url).done(function (data) {
//alert(data);
    $('#brandwindow').jqxWindow('setContent', data);

}); 
}


function clientSearchContent(url) {
      $.get(url).done(function (data) {
    $('#clientwindow').jqxWindow('setContent', data);
	}); 
}


function modelSearchContent(url) {
    //alert(url);
      $.get(url).done(function (data) {
//alert(data);
    $('#modelwindow').jqxWindow('setContent', data);

}); 
}

function groupSearchContent(url) {
    //alert(url);
      $.get(url).done(function (data) {
//alert(data);
    $('#groupwindow').jqxWindow('setContent', data);

}); 
}

function yomSearchContent(url) {
    //alert(url);
      $.get(url).done(function (data) {
//alert(data);
    $('#yomwindow').jqxWindow('setContent', data);

}); 
}

function fleetSearchContent(url) {
    //alert(url);
      $.get(url).done(function (data) {
//alert(data);
    $('#fleetwindow').jqxWindow('setContent', data);

}); 
}
function setSearch(){
	var value=$('#searchby').val().trim();
	
	if(value=="brand"){
		getBrand();
	}
	else if(value=="model"){
		getModel();
	}
	else if(value=="group"){
		getGroup();
	}
	else if(value=="yom"){
		getYom();
	}
	else if(value=="fleet"){
		getFleet();
	}
	else if (value=="client"){
		getClient();
	}
	else{
		
	}
}

function setRemove(){
	var value=$('#searchby').val().trim();
	

	 if(value=="brand"){
		document.getElementById("searchdetails").value="";
		document.getElementById("brand").value="";
		document.getElementById("hidbrand").value="";
		
		if(document.getElementById("model").value!=""){
			document.getElementById("searchdetails").value+=document.getElementById("model").value;	
		}
		if(document.getElementById("group").value!=""){
			document.getElementById("searchdetails").value+="\n"+document.getElementById("group").value;	
		}
		if(document.getElementById("yom").value!=""){
			document.getElementById("searchdetails").value+="\n"+document.getElementById("yom").value;	
		}
		if(document.getElementById("fleet").value!=""){
			document.getElementById("searchdetails").value+="\n"+document.getElementById("fleet").value;	
		}
		if(document.getElementById("client").value!=""){
			document.getElementById("searchdetails").value+="\n"+document.getElementById("client").value;	
		}
	}
	else if(value=="model"){
		document.getElementById("searchdetails").value="";
		document.getElementById("model").value="";
		document.getElementById("hidmodel").value="";
		
		if(document.getElementById("brand").value!=""){
			document.getElementById("searchdetails").value+=document.getElementById("brand").value;	
		}
		if(document.getElementById("group").value!=""){
			document.getElementById("searchdetails").value+="\n"+document.getElementById("group").value;	
		}
		if(document.getElementById("yom").value!=""){
			document.getElementById("searchdetails").value+="\n"+document.getElementById("yom").value;	
		}
		if(document.getElementById("fleet").value!=""){
			document.getElementById("searchdetails").value+="\n"+document.getElementById("fleet").value;	
		}
		if(document.getElementById("client").value!=""){
			document.getElementById("searchdetails").value+="\n"+document.getElementById("client").value;	
		}
	}
	else if(value=="group"){
		document.getElementById("searchdetails").value="";
		document.getElementById("group").value="";
		document.getElementById("hidgroup").value="";
		
		if(document.getElementById("brand").value!=""){
			document.getElementById("searchdetails").value+=document.getElementById("brand").value;	
		}
		if(document.getElementById("model").value!=""){
			document.getElementById("searchdetails").value+="\n"+document.getElementById("model").value;	
		}
		if(document.getElementById("yom").value!=""){
			document.getElementById("searchdetails").value+="\n"+document.getElementById("yom").value;	
		}
		if(document.getElementById("fleet").value!=""){
			document.getElementById("searchdetails").value+="\n"+document.getElementById("fleet").value;	
		}
		if(document.getElementById("client").value!=""){
			document.getElementById("searchdetails").value+="\n"+document.getElementById("client").value;	
		}
	}
	else if(value=="yom"){
		document.getElementById("searchdetails").value="";
		document.getElementById("yom").value="";
		document.getElementById("hidyom").value="";
		
		if(document.getElementById("brand").value!=""){
			document.getElementById("searchdetails").value+=document.getElementById("brand").value;	
		}
		if(document.getElementById("model").value!=""){
			document.getElementById("searchdetails").value+="\n"+document.getElementById("model").value;	
		}
		if(document.getElementById("group").value!=""){
			document.getElementById("searchdetails").value+="\n"+document.getElementById("group").value;	
		}
		if(document.getElementById("fleet").value!=""){
			document.getElementById("searchdetails").value+="\n"+document.getElementById("fleet").value;	
		}
		if(document.getElementById("client").value!=""){
			document.getElementById("searchdetails").value+="\n"+document.getElementById("client").value;	
		}
	}
	else if(value=="fleet"){
		document.getElementById("searchdetails").value="";
		document.getElementById("fleet").value="";
		document.getElementById("hidfleet").value="";
		
		if(document.getElementById("brand").value!=""){
			document.getElementById("searchdetails").value+=document.getElementById("brand").value;	
		}
		if(document.getElementById("model").value!=""){
			document.getElementById("searchdetails").value+="\n"+document.getElementById("model").value;	
		}
		if(document.getElementById("group").value!=""){
			document.getElementById("searchdetails").value+="\n"+document.getElementById("group").value;	
		}
		if(document.getElementById("yom").value!=""){
			document.getElementById("searchdetails").value+="\n"+document.getElementById("yom").value;	
		}
		if(document.getElementById("client").value!=""){
			document.getElementById("searchdetails").value+="\n"+document.getElementById("client").value;	
		}
	}
	else if(value=="client"){
		document.getElementById("searchdetails").value="";
		document.getElementById("client").value="";
		document.getElementById("hidclient").value="";
		
		if(document.getElementById("brand").value!=""){
			document.getElementById("searchdetails").value+=document.getElementById("brand").value;	
		}
		if(document.getElementById("model").value!=""){
			document.getElementById("searchdetails").value+="\n"+document.getElementById("model").value;	
		}
		if(document.getElementById("group").value!=""){
			document.getElementById("searchdetails").value+="\n"+document.getElementById("group").value;	
		}
		if(document.getElementById("yom").value!=""){
			document.getElementById("searchdetails").value+="\n"+document.getElementById("yom").value;	
		}
		if(document.getElementById("fleet").value!=""){
			document.getElementById("searchdetails").value+="\n"+document.getElementById("fleet").value;	
		}
	}
}


function funreload(event)
{
	if(document.getElementById("cmbbranch").value==""){
		$.messager.alert('Warning','Please Select Branch');
		return false;
	}
		 var branch=document.getElementById("cmbbranch").value;
	     var fromdate=$('#fromdate').jqxDateTimeInput('val');
	     var todate=$('#todate').jqxDateTimeInput('val');
	     var grpby1=document.getElementById("grpby1").value;
	     var hidbrand=document.getElementById("hidbrand").value;
	     var hidmodel=document.getElementById("hidmodel").value;
	     var hidgroup=document.getElementById("hidgroup").value;
	     var hidyom=document.getElementById("hidyom").value;
	     var gridtype=document.getElementById("gridtype").value;
		var hidfleet=document.getElementById("hidfleet").value;
		var hidclient=document.getElementById("hidclient").value;
	    $("#overlay, #PleaseWait").show();
	    if(document.getElementById("grpby1").value==""){
	    	$('#clientdiv').show();
	    	$('#clientgroupdiv').hide();
	    	$("#clientdiv").load("abcClientGrid.jsp?branch="+branch+"&fromdate="+fromdate+"&todate="+todate+"&hidbrand="+hidbrand+"&hidmodel="+hidmodel+"&hidgroup="+hidgroup+"&hidyom="+hidyom+"&id=1&hidfleet="+hidfleet+"&hidclient="+hidclient);
		}
	    else{
	    	$('#clientdiv').hide();
	    	$('#clientgroupdiv').show();
	    	$("#clientgroupdiv").load("abcClientGroupGrid.jsp?branch="+branch+"&fromdate="+fromdate+"&todate="+todate+"&grpby="+grpby1+"&hidbrand="+hidbrand+"&hidmodel="+hidmodel+"&hidgroup="+hidgroup+"&hidyom="+hidyom+"&id=1&gridtype="+gridtype+"&hidfleet="+hidfleet+"&hidclient="+hidclient);
	    }
	
	}
	

	function setValues(){

		 if($('#msg').val()!=""){
   		   $.messager.alert('Message',$('#msg').val());
   		  }
		
		 
	}
	function funExportBtn(){
		if(document.getElementById("grpby1").value==""){
			$("#abcClientGrid").jqxGrid('exportdata', 'xls', 'ABC Client');	
		}
		else{
			$("#abcClientGroupGrid").jqxGrid('exportdata', 'xls', 'ABC Client Grouping');
		}

	}

	
	function funClearData(){
		$('input[type=text],[type=hidden]').val('');
		$('textarea').val('');
		$('#grpby1').val('');
		$('#searchby').val('');
	}

	
	
</script>
</head>
<body onload="getBranch();setValues();">
<form id="frmSalesInvoiceList" method="post">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%">
<tr>
<td width="23%" align="center">
    <fieldset style="background: #ECF8E0;">
	<table width="100%">
	<jsp:include page="../../heading.jsp"></jsp:include>

 <tr>
   <td width="37%" align="right"><label class="branch">From Date</label></td><td width="63%"><div id="fromdate"></div></td></tr>
 <tr>
   <td align="right"><label class="branch">To Date</label></td>
   <td><div id="todate"></div></td>
 </tr>

 <tr>
   <td align="right"><label class="branch">Grouping 1</label></td>
   <td><select name="grpby1" id="grpby1">
   <option value="">--Select--</option>
   <option value="client">Client</option>
   <option value="brand">Brand</option>
   <option value="model">Model</option>
   <option value="group">Group</option>
   <option value="yom">YOM</option></select></td>
 </tr>
<tr>
	<td align="right">
	 <label class="branch">Search By</label>
    </td>
    <td>
    <select name="searchby" id="searchby">
    <option value="">--Select--</option>
    <option value="brand">Brand</option>
    <option value="model">Model</option>
    <option value="group">Group</option>
    <option value="yom">YOM</option>
    <option value="fleet">Fleet</option>
    <option value="client">Client</option>
    </select>
    &nbsp;&nbsp;<button type="button" name="btnadditem" id="additem" class="myButtons" onClick="setSearch();">+</button>&nbsp;&nbsp;<button  type="button" name="btnremoveitem" id="btnremoveitem" class="myButtons" onclick="setRemove();">-</button>
    </td>
	</tr>
	<tr><td colspan="2"><textarea id="searchdetails" name="searchdetails" style="resize:none;font: 10px Tahoma;" rows="18" cols="50" readonly></textarea></td></tr>
	<tr>
	<td colspan="2" style="border-top:2px solid #DCDDDE;">
	 
	<center><input type="button" name="btnclear" id="btnclear" value="Clear" class="myButtons" onclick="funClearData();"></center>
   <br><br><br>
    </td>
	</tr>
		
	</table>
	</fieldset>
</td>
<td width="77%">
	<table width="100%">
		<tr>
			 <td> <div id="clientdiv"><jsp:include page="abcClientGrid.jsp"></jsp:include></div> 
			   <div id="clientgroupdiv" hidden="true"><jsp:include page="abcClientGroupGrid.jsp"></jsp:include></div> 
			 </td>
			 <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
			  <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
			  <input type="hidden" name="hidgroup" id="hidgroup">
			  <input type="hidden" name="hidmodel" id="hidmodel">
			  <input type="hidden" name="hidyom" id="hidyom">
			  <input type="hidden" name="hidbrand" id="hidbrand">
			  <input type="hidden" name="group" id="group">
			  <input type="hidden" name="model" id="model">
			  <input type="hidden" name="yom" id="yom">
			  <input type="hidden" name="brand" id="brand">
			  <input type="hidden" name="gridtype" id="gridtype">
			  <input type="hidden" name="fleet" id="fleet">
			  <input type="hidden" name="hidfleet" id="hidfleet">
			  <input type="hidden" name="client" id="client">
			  <input type="hidden" name="hidclient" id="hidclient">
			  
		</tr>
	</table>
</tr>
</table>
</div>

</div>
<div id="brandwindow">
<div></div>
</div>
<div id="modelwindow">
<div></div>
</div>
<div id="groupwindow">
<div></div>
</div>
<div id="yomwindow">
<div></div>
</div>
<div id="fleetwindow">
<div></div>
</div>
<div id="clientwindow">
<div></div>
</div>
</form>
</body>
</html>