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
<style>
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
	 $("#fromdate").jqxDateTimeInput({ width: '109px', height: '22px',formatString:"dd.MM.yyyy"});
	 $("#todate").jqxDateTimeInput({ width: '109px', height: '22px',formatString:"dd.MM.yyyy"});
	 $("#date").jqxDateTimeInput({ width: '109px', height: '22px',formatString:"dd.MM.yyyy"});
	 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	 $('#clientDetailsWindow').jqxWindow({ width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Client Search' , theme: 'energyblue', position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	 $('#clientDetailsWindow').jqxWindow('close');
	 
	 var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
	 var onemounth=new Date(new Date(fromdates).setMonth(fromdates.getMonth()-1)); 
	    
     $('#fromdate').jqxDateTimeInput('setDate', new Date(onemounth));
	 $('#todate').on('change', function (event) {
			
		   var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		 
		  // out date
		 	 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
		 	 
		   if(fromdates>todates){
			   
			   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
			 
		   return false;
		  }   
	 });
	  $('#txtclientname').dblclick(function(){
		  clientSearchContent('clientDetailsSearchGrid.jsp');
		});
});

	function clientSearchContent(url) {
	    $('#clientDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#clientDetailsWindow').jqxWindow('setContent', data);
		$('#clientDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function getClient(event){
	    var x= event.keyCode;
	    if(x==114){
	    	clientSearchContent('clientDetailsSearchGrid.jsp');
	    }
	    else{}
	    }
	
	function funExportBtn(){
		  // $("#rentalInvoiceGrid").jqxGrid('exportdata', 'xls', 'Invoices List');
		 }

	function  funClearData(){
		 $('#txtclientname').val('');$('#txtcldocno').val('');$('#txtdesc').val('');
		 var onemounth=new Date(new Date((new Date())).setMonth(new Date().getMonth()-1)); 
		 $('#fromdate').val(onemounth);
         $('#todate').val(new Date());
         $('#date').val(new Date());
		 if (document.getElementById("txtclientname").value == "") {
		        $('#txtclientname').attr('placeholder', 'Press F3 to Search'); 
		    }
		 $("#jqxEvaluationGrid").jqxGrid('clear');    
	}
	
	function funreload(event){
		  var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
			 
		  // out date
		 	 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
		 	 
		   if(fromdates>todates){
			   
			   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
			 
		   return false;
		  } 
		   else
			   {
	     var cldocno = $('#txtcldocno').val();  
	     if(cldocno==""){
			   $.messager.alert('Message',' Please select Evaluated For ','warning');      
		       return false;
		  } 
		 var branchval = document.getElementById("cmbbranch").value;
		 var fromdate = $('#fromdate').val();
		 var todate = $('#todate').val();
		 $("#overlay, #PleaseWait").show();
		 $("#evlDiv").load("evaluationGrid.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&cldocno='+cldocno+'&id='+1);
		}
	}
	$("#evlDiv").excelexportjs({
		containerid: "evlDiv",
		datatype: 'json',
		dataset: null,
		gridId: "jqxEvaluationGrid",
		columns: getColumns("jqxEvaluationGrid"),
		worksheetName: "Evaluation Processing"                         
	});
	function funUpdate(){       
		var rows = $("#jqxEvaluationGrid").jqxGrid('getrows');

		var selectedrows=$("#jqxEvaluationGrid").jqxGrid('selectedrowindexes');
		selectedrows = selectedrows.sort(function(a,b){return a - b});

		if(selectedrows.length==0){
		$("#overlay, #PleaseWait").hide();
		$.messager.alert('Warning','Select documents.');
		return false;
		}

		var i=0;
		var temptrno="";            
		var j=0;
		for (i = 0; i < selectedrows.length; i++) {

		if(i==0){      
		var accdocno= $('#jqxEvaluationGrid').jqxGrid('getcellvalue', selectedrows[i], "doc_no").split(' ');
		temptrno=accdocno;   
		}  
		else{  
		var accdocno= $('#jqxEvaluationGrid').jqxGrid('getcellvalue', selectedrows[i], "doc_no").split(' ');    
		temptrno=temptrno+","+accdocno;
		}
		temptrno1=temptrno+","; 
		j++; 
		}
		$('#accdocno').val(temptrno1);
		saveData($('#accdocno').val());	   
		} 
	function saveData(gridarray){
		$("#overlay, #PleaseWait").show();
		var desc=$("#txtdesc").val(); 
		desc=desc.replace(/\n/g, " ");
	    var x=new XMLHttpRequest();
	 		x.onreadystatechange=function(){
	 			if (x.readyState==4 && x.status==200)    
	 			{  
	 				var items=x.responseText.trim().split('::');
	 				if(parseInt(items[1])>0){                                     
	 					 $.messager.alert('Message','SRS -'+items[0]+' Successfully generated ','success');    
	 					 $("#overlay, #PleaseWait").hide();  
	 					 funClearData();
	 				}
	 				else{
	 					 $.messager.alert('Message',' Not generated ','warning');       
	 					 $("#overlay, #PleaseWait").hide();  
	 				}   
	 			}
	 			else    
	 			{       
	 			}                
	 		}
	 		x.open("GET","saveData.jsp?gridarray="+encodeURIComponent(gridarray)+"&date="+$("#date").val()+"&desc="+encodeURIComponent(desc),true);                                     
	 		x.send();          
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
    <tr>
	 <td align="right"><label class="branch">From</label></td>
     <td align="left"><div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div></td></tr> 
	<tr>
	<td align="right"><label class="branch">To</label></td>
    <td align="left"><div id="todate" name="todate" value='<s:property value="todate"/>'></div></td>
	</tr>
	<tr><td align="right"><label class="branch">Evaluated For</label></td>
	<td align="left"><input type="text" id="txtclientname" name="txtclientname" style="width:100%;height:20px;" readonly="readonly" placeholder="Press F3 to Search"  onkeydown="getClient(event);" value='<s:property value="txtclientname"/>'/>
    <input type="hidden" id="txtcldocno" name="txtcldocno" value='<s:property value="txtcldocno"/>'/>
    <input type="hidden" id="accdocno" name="accdocno" value='<s:property value="accdocno"/>'/></td></tr>
    <tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>              
    <tr><td colspan="2">&nbsp;</td></tr> 
	<tr>
	 <td align="right"><label class="branch">Date</label></td>
     <td align="left"><div id="date" name="date"></div></td></tr>      
     <tr>
	 <td align="right"><label class="branch">Description</label></td>  
     <td align="left"><textarea id="txtdesc" name="txtdesc" style="width:100%;height:50px;"></textarea></td></tr>     
     <tr><td  colspan="2" align="center"><input type="button"  class="myButton" name="btncreate" id="btncreate"  value="Generate" onclick="funUpdate();"></td></tr>
	 <tr><td colspan="2" align="center"><input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funClearData();"></td></tr>
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
		<tr>
			 <td><div id="evlDiv"><jsp:include page="evaluationGrid.jsp"></jsp:include></div></td>
		</tr>
	</table>
</tr>
</table>
</div>

<div id="clientDetailsWindow">
	<div></div><div></div>
</div>
</div> 
</body>
</html>