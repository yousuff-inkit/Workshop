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

.icon1 {
	width: 2.5em;
	height: 2em;
	border: none;
	background-color: #ECF8E0;
}
</style>

<script type="text/javascript">

	$(document).ready(function () {
		 
		 $('#clientDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Client Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#clientDetailsWindow').jqxWindow('close');
		 
		 $('#nationalityWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Nation Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
 		 $('#nationalityWindow').jqxWindow('close');
 		 
    	 $('#stateWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'State Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
 		 $('#stateWindow').jqxWindow('close');
		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
		 
	     $('#txtclientname').dblclick(function(){
			  clientSearchContent('clientDetailsSearch.jsp');
		 });
	     
	     document.getElementById("rddriverlist").checked=true;
	     $('#btnadd').attr('disabled', true );$('#btndelete').attr('disabled', true );
	     document.getElementById("mode").value="A";
	     //$('#txtadddriver').val(1);
	});
	
	function clientSearchContent(url) {
	    $('#clientDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#clientDetailsWindow').jqxWindow('setContent', data);
		$('#clientDetailsWindow').jqxWindow('bringToFront');
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
	
	function getIDPDetails(){
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
			    $('#idpdetailsallowed').val(items);
		}
		}
		x.open("GET", "getIDPDetailsAllowed.jsp", true);
		x.send();
    }
	
	function getVisaNoAlreadyExists(visano,docno,mode){
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText.trim();

  				if(parseInt(items)==1){
  					$.messager.alert('Message','ID# Already Exists.','warning');
  					 return 0;
  				 }
  			   
  		}
	}
	x.open("GET", "getVisaNoAlreadyExists.jsp?visano="+visano+"&docno="+docno+"&mode="+mode, true);
	x.send();
	}
  
  function getPassportNoAlreadyExists(passportno,docno,mode){
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText.trim();

  				if(parseInt(items)==1){
  					$.messager.alert('Message','Passport# Already Exists.','warning');
  					 return 0;
  				 }
  			   
  		}
	}
	x.open("GET", "getPassportNoAlreadyExists.jsp?passportno="+passportno+"&docno="+docno+"&mode="+mode, true);
	x.send();
	}
	
	function getClient(event){
	      var x= event.keyCode;
	      if(x==114){
	    	  clientSearchContent('clientDetailsSearch.jsp');
	      } else{}
	}
	
	function funreload(event) {
		
		var branchval = document.getElementById("cmbbranch").value;
		var cldocno = $('#txtcldocno').val();
		 
		if(document.getElementById("rddriverlist").checked==true) {
			$("#overlay, #PleaseWait").show();
		 	$("#driverListDiv").load("driverListGrid.jsp?branchval="+branchval+"&cldocno="+cldocno+'&check=1');
		} else if(document.getElementById("rdadditionaldriver").checked==true) {
			 if(cldocno==''){
				 $.messager.alert('Message','Choose a Client and Add Driver.','warning');
				 return 0;
			 }
			 
			 var row = $("#addDriverGridID").jqxGrid('getrows');
			 if(row.length>=1){
				if(typeof(row[0].name) == "undefined" || typeof(row[0].name) == "NaN" || row[0].name.trim()==""){
					 $.messager.alert('Message','Please Enter Driver Informations and Add.','warning');
					 return 0;
				 }
			 }
				
		} else if(document.getElementById("rddeletedriver").checked==true) {
			if(cldocno==''){
				 $.messager.alert('Message','Choose a Client and Remove Driver.','warning');
				 return 0;
			 }
			$("#overlay, #PleaseWait").show();$('#btndelete').attr('disabled', false );
		 	$("#deleteDriverDiv").load("deleteDriverGrid.jsp?branchval="+branchval+"&cldocno="+cldocno+'&check=1');
		}
		
	}
	
	function funAdd(event){
		var cldocno = $('#txtcldocno').val();
		var branch = $('#cmbbranch').val();
		
		if(branch=='a'){
			 branch='1';
		 }
		
		if(cldocno==''){
			 $.messager.alert('Message','Client is Mandatory.','warning');
			 return 0;
		 }
		
		var row = $("#addDriverGridID").jqxGrid('getrows');
		if(row.length>=1){
			if(typeof(row[0].name) == "undefined" || typeof(row[0].name) == "NaN" || row[0].name.trim()==""){
				 $.messager.alert('Message','Please Enter Driver Informations and Add.','warning');
				 return 0;
			 }
		}
		
		    $.messager.confirm('Message', 'Do you want to save changes?', function(r){
			        
		     	if(r==false)
		     	  {
		     		return false; 
		     	  }
		     	else{
		     		var rows = $("#addDriverGridID").jqxGrid('getrows');	
		     		var gridlength = rows.length-2;
				    for (var i = 0; i < rows.length; i++) {
				    	var chk=rows[i].name;
						if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk.trim()!=""){
				    		saveGridData(cldocno,rows[i].name,rows[i].hiddob,rows[i].nation1,rows[i].mobno,rows[i].passport_no,rows[i].hidpassexp,rows[i].dlno,rows[i].hidissdate,rows[i].issfrm,rows[i].hidled,rows[i].ltype,rows[i].visano,rows[i].hidvisaexp,rows[i].dr_id,rows[i].hcdlno,rows[i].hidhcissdate,rows[i].hidhcled,branch,i,gridlength);
						}
				    }
		     	}
		 });
	}
	
	function funDelete(event){
		var cldocno = $('#txtcldocno').val();
		var branch = $('#cmbbranch').val();
		
		if(branch=='a'){
			 branch='1';
		 }
		
		if(cldocno==''){
			 $.messager.alert('Message','Client is Mandatory.','warning');
			 return 0;
		 }
		
		var selectedrows=$("#deleteDriverGridID").jqxGrid('selectedrowindexes');
		selectedrows = selectedrows.sort(function(a,b){return a - b});
		
		if(selectedrows.length==0){
			$("#overlay, #PleaseWait").hide();
			$.messager.alert('Warning','Select Drivers to be Removed.');
			return false;
		}
		
		    $.messager.confirm('Message', 'Do you want to remove?', function(r){
			        
		     	if(r==false)
		     	  {
		     		return false; 
		     	  }
		     	else {
		     		
		     		var rows = $("#deleteDriverGridID").jqxGrid('getrows');
		     		var i=0;var j=0;var k=0;var tempdrid="";
		    	    for (i = 0; i < rows.length; i++) {
		    				if(selectedrows[j]==i){
		    					if(k==0){
		    						tempdrid=rows[i].dr_id;
		    						k=1;
		    					} else{
		    						tempdrid=tempdrid+","+rows[i].dr_id;
		    					}
		    				j++; 
		    			  }
		                }
		    	    $('#txtselecteddrivers').val(tempdrid);
		    	    
		    	    removeGridData(cldocno,$('#txtselecteddrivers').val(),branch);
		     	}
		 });
	}
	
	function saveGridData(cldocno,drivername,dob,nation,mobno,passportno,passexp,dlno,issdate,issfrm,led,ltype,visano,visaexp,drid,hcdlno,hcissdate,hcled,branch,i,gridlength) {
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText.trim();
				
				var cldocno = $('#txtcldocno').val('');
				var clientname = $('#txtclientname').val(''); 
				
				 if(items==gridlength){
					$.messager.alert('Message', '  Record Successfully Inserted ', function(r){
			  		});
				 }

				 $('#cmbbranch').val('a');document.getElementById("rddriverlist").checked=true;
				 $("#driverListGridID").jqxGrid('clear');$("#addDriverGridID").jqxGrid('clear');
				 $("#deleteDriverGridID").jqxGrid('clear');$('#txtselecteddrivers').val('');
				 $("#driverListDiv").prop("hidden", false);$("#addDriverDiv").prop("hidden", true);$("#deleteDriverDiv").prop("hidden", true);
				 
				 if (document.getElementById("txtclientname").value == "") {
				        $('#txtclientname').attr('placeholder', 'Press F3 to Search'); 
				 }
		   }
		}
			
	x.open("GET","saveData.jsp?cldocno="+cldocno+"&drivername="+drivername+"&dob="+dob+"&nation="+nation+"&mobno="+mobno+"&passportno="+passportno+"&passexp="+passexp+"&dlno="+dlno+"&issdate="+issdate+"&issfrm="+issfrm+"&led="+led+"&ltype="+ltype+"&visano="+visano+"&visaexp="+visaexp+"&drid="+drid+"&hcdlno="+hcdlno+"&hcissdate="+hcissdate+"&hcled="+hcled+"&branch="+branch+"&index="+i,true);
	x.send();
	}
	
	function removeGridData(cldocno,selecteddrivers,branch) {
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText.trim();
				
				var cldocno = $('#txtcldocno').val('');
				var clientname = $('#txtclientname').val(''); 
				
				 if(items.trim()=='1'){
					$.messager.alert('Message', '  Driver is in an Agreement. ', function(r){
			  		});
				 } else {
					 $.messager.alert('Message', '  Record Successfully Removed ', function(r){
				  	 }); 
				 }

				 $('#cmbbranch').val('a');document.getElementById("rddriverlist").checked=true;
				 $("#driverListGridID").jqxGrid('clear');$("#addDriverGridID").jqxGrid('clear');
				 $("#deleteDriverGridID").jqxGrid('clear');$('#txtselecteddrivers').val(''); 
				 $("#driverListDiv").prop("hidden", false);$("#addDriverDiv").prop("hidden", true);$("#deleteDriverDiv").prop("hidden", true);
				 
				 if (document.getElementById("txtclientname").value == "") {
				        $('#txtclientname').attr('placeholder', 'Press F3 to Search'); 
				 }
		   }
		}
			
	x.open("GET","removeData.jsp?cldocno="+cldocno+"&selecteddrivers="+selecteddrivers+"&branch="+branch,true);
	x.send();
	}
	
	function  funClearData() {
		$('#cmbbranch').val('a');$('#txtselecteddrivers').val('');
		$('#txtcldocno').val('');$('#txtclientname').val('');
		document.getElementById("rddriverlist").checked=true;
		$('#btnadd').attr('disabled', true );$('#btndelete').attr('disabled', true );
		$("#driverListDiv").prop("hidden", false);$("#addDriverDiv").prop("hidden", true);$("#deleteDriverDiv").prop("hidden", true);
		$("#driverListGridID").jqxGrid('clear');$("#addDriverGridID").jqxGrid('clear');$("#deleteDriverGridID").jqxGrid('clear');
		
		if (document.getElementById("txtclientname").value == "") {
	        $('#txtclientname').attr('placeholder', 'Press F3 to Search'); 
	    }
	 }
	 
	function radioClick() {
		if(document.getElementById("rddriverlist").checked==true){
			 $('#btnadd').attr('disabled', true );$('#btndelete').attr('disabled', true);
			 $('#txtcldocno').val('');$('#txtclientname').val('');
			 $("#driverListDiv").prop("hidden", false);$("#addDriverDiv").prop("hidden", true);$("#deleteDriverDiv").prop("hidden", true);
			 $("#driverListGridID").jqxGrid('clear');$("#addDriverGridID").jqxGrid('clear');$("#deleteDriverGridID").jqxGrid('clear'); 
			 if (document.getElementById("txtclientname").value == "") {
			        $('#txtclientname').attr('placeholder', 'Press F3 to Search'); 
			 }
		} else if(document.getElementById("rdadditionaldriver").checked==true){
			 $('#btnadd').attr('disabled', false );$('#btndelete').attr('disabled', true );
			 $('#txtcldocno').val('');$('#txtclientname').val('');
			 $("#driverListDiv").prop("hidden", true);$("#addDriverDiv").prop("hidden", false);$("#deleteDriverDiv").prop("hidden", true);
			 $("#driverListGridID").jqxGrid('clear');$("#addDriverGridID").jqxGrid('clear');$("#deleteDriverGridID").jqxGrid('clear'); 
			 $("#addDriverGridID").jqxGrid('addrow', null, {});
			 if (document.getElementById("txtclientname").value == "") {
			        $('#txtclientname').attr('placeholder', 'Press F3 to Search'); 
			 }
		} else if(document.getElementById("rddeletedriver").checked==true){
			 $('#btnadd').attr('disabled', true );$('#btndelete').attr('disabled', true );
			 $('#txtcldocno').val('');$('#txtclientname').val('');
			 $("#driverListDiv").prop("hidden", true);$("#addDriverDiv").prop("hidden", true);$("#deleteDriverDiv").prop("hidden", false);
			 $("#driverListGridID").jqxGrid('clear');$("#addDriverGridID").jqxGrid('clear');$("#deleteDriverGridID").jqxGrid('clear');
			 if (document.getElementById("txtclientname").value == "") {
			        $('#txtclientname').attr('placeholder', 'Press F3 to Search'); 
			 }
		}
	}
	
	 function funExportBtn(){
		 if(parseInt(window.parent.chkexportdata.value)=="1") {
		  	JSONToCSVCon(data, 'DriverList', true);
		 } else {
			 $("#driverListGridID").jqxGrid('exportdata', 'xls', 'DriverList');
		 }
	}
	
</script>
</head>
<body onload="getBranch();getIDPDetails();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%"  >
	<jsp:include page="../../heading.jsp"></jsp:include>
		
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">
	  <fieldset><legend><b><label class="branch">Report Type</label></b></legend>
	   <table width="100%">
       <tr>
       <td width="48%" align="center"><input type="radio" id="rddriverlist" name="rdo" onchange="radioClick();" value="rddriverlist"><label for="rddriverlist" class="branch">Driver List</label></td>
       <td width="52%" align="center"><input type="radio" id="rddeletedriver" name="rdo" onchange="radioClick();" value="rddeletedriver"><label for="rddeletedriver" class="branch">Delete Driver</label></td>
       </tr>
       <tr>
       <td colspan="2" align="center"><input type="radio" id="rdadditionaldriver" name="rdo" onchange="radioClick();" value="rdadditionaldriver"><label for="rdadditionaldriver" class="branch">Add Additional Driver</label></td>
       </tr>
       </table>
	  </fieldset>
	</td></tr> 
	<tr><td align="right"><label class="branch">Client Name</label></td>
	<td align="left"><input type="text" id="txtclientname" name="txtclientname" style="width:100%;height:20px;" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtclientname"/>' onkeydown="getClient(event);"/>
    <input type="hidden" id="txtcldocno" name="txtcldocno" style="width:100%;height:20px;" value='<s:property value="txtcldocno"/>'/></td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td align="left"><input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funClearData();"></td>
		<td align="center"><button type="button" class="icon1" id="btnadd" title="Add Additional Driver" onclick="funAdd(event);">
					<img alt="Add Additional Driver" src="<%=contextPath%>/icons/driverAdd.png">
			</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<button type="button" class="icon1" id="btndelete" title="Delete Driver" onclick="funDelete(event);">
					<img alt="Delete Driver" src="<%=contextPath%>/icons/driverDelete.png">
			</button>			
			</td></tr>
    <tr><td colspan="2">&nbsp;</td></tr>
    <tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2"><input type="hidden" name="mode" id="mode" style="height:20px;width:70%;" value='<s:property value="mode"/>'>
	<input type="hidden" name="txtselecteddrivers" id="txtselecteddrivers" style="height:20px;width:70%;" value='<s:property value="txtselecteddrivers"/>'>
	<input type="hidden" name="docno" id="docno" style="height:20px;width:70%;" value='<s:property value="docno"/>'>
	<input type="hidden" id="idpdetailsallowed" name="idpdetailsallowed" style="height:20px;width:70%;"></td></tr>
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="driverListDiv"><jsp:include page="driverListGrid.jsp"></jsp:include></div>
			 <div id="addDriverDiv" hidden="true"><jsp:include page="addDriverGrid.jsp"></jsp:include></div>
			 <div id="deleteDriverDiv" hidden="true"><jsp:include page="deleteDriverGrid.jsp"></jsp:include></div>
			 </td>
		</tr>
	</table>
</tr>
</table>
</div>
<div id="clientDetailsWindow">
	<div></div>
</div>
<div id="nationalityWindow">
   <div></div>
</div>
<div id="stateWindow">
   <div></div>
</div>
</div> 
</body>
</html>