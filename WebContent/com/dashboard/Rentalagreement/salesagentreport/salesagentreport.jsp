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
	 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	 $('#agentWindow').jqxWindow({ width: '30%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Sales Agent Search' , theme: 'energyblue', position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	 $('#agentWindow').jqxWindow('close');
	 
	 $('#agreementDetailsWindow').jqxWindow({width: '50%', height: '58%',  maxHeight: '70%' ,maxWidth: '50%' , title: 'Agreement Search',position: { x: 250, y: 120 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 $('#agreementDetailsWindow').jqxWindow('close');
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
	  
});

	function agentSearchContent(url) {
	    $('#agentWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#agentWindow').jqxWindow('setContent', data);
		$('#agentWindow').jqxWindow('bringToFront');
	}); 
	}
	
	    
	function getrental()
	{

		 $('#agreementDetailsWindow').jqxWindow('open');
			$('#agreementDetailsWindow').jqxWindow('focus');
			agreementSearchContent('agreementDetailsSearch.jsp', $('#agreementDetailsWindow'));
		
		}

	function getsalesagent()
	{

		 $('#agentWindow').jqxWindow('open');
			$('#agentWindow').jqxWindow('focus');
			agentSearchContent('salesagentSearch.jsp', $('#agentWindow'));
		
		}

	function agreementSearchContent(url) {
	 	$('#agreementDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#agreementDetailsWindow').jqxWindow('setContent', data);
		$('#agreementDetailsWindow').jqxWindow('bringToFront');
	}); 
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
		
		 var branchval = document.getElementById("cmbbranch").value;
		 var fromdate = $('#fromdate').val();
		 var todate = $('#todate').val();
		 
		 var clstatuss = document.getElementById("clstatuss").value; 
		 var hidrag = document.getElementById("hidrag").value;
		 var hidsag = document.getElementById("hidsag").value;
		 
		 var type = document.getElementById("type").value; 
			if(type=="summary")
				{
		   $("#overlay, #PleaseWait").show();
		 $("#summarydiv").load("summarygrid.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&type='+type+"&hidrag="+hidrag+"&hidsag="+hidsag+"&clstatuss="+clstatuss);
			   
				}
			else
				{
				
				
				 $("#overlay, #PleaseWait").show();
				 $("#detaildiv").load("detailsgrid.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&type='+type+"&hidrag="+hidrag+"&hidsag="+hidsag+"&clstatuss="+clstatuss);
				
				}
			
			
			
			   }
			   }
	 
	function funClearData(){
		$('input[type=text],[type=hidden]').val('');
		$('input[type=radio]').prop("checked", false);
		$('textarea').val('');
		$('#type').val('summary');
		
		
		$('#clstatuss').val('');
		$('#searchby').val('');
		 
	} 
	function changegrid()
	{
		 var type = document.getElementById("type").value;
		if(type=="summary")
			{
			  $("#detaildiv").hide();
			  $("#summarydiv").show(); 
			   
			  
			  $("#detailgrid").jqxGrid('clear');
		      $("#detailgrid").jqxGrid('addrow', null, {});
		      
			  
			   $("#summarygrid").jqxGrid('clear');
		      $("#summarygrid").jqxGrid('addrow', null, {});
		      
		      
			}
		else
			{
		
			  $("#detaildiv").show();
			  $("#summarydiv").hide(); 
			   
			  
			  $("#detailgrid").jqxGrid('clear');
		      $("#detailgrid").jqxGrid('addrow', null, {});
		      
			  
			   $("#summarygrid").jqxGrid('clear');
		      $("#summarygrid").jqxGrid('addrow', null, {});
			}
		
		}

	function setSearch(){
		var value=$('#searchby').val().trim();
 
		 
         if(value=="RAG"){     
			getrental();
		}
		else if(value=="SAG"){
			getsalesagent();
		}
		 
		 
		
		else{
			
		}



	}
	
	function setRemove(){
		var value=$('#searchby').val().trim();
		 
		if(value=="RAG"){  
			
			document.getElementById("searchdetails").value="";
			document.getElementById("rag").value="";
			document.getElementById("hidrag").value="";
			
		}
		if(value=="SAG"){
			document.getElementById("searchdetails").value="";
			document.getElementById("sag").value="";
			document.getElementById("hidsag").value="";
		}
		
	 
		 
		
		if(document.getElementById("rag").value!=""){
			
		var	text = document.getElementById("rag").value.split("::").join("\n");
			
			document.getElementById("searchdetails").value+="\n\n"+text;	
		}
		if(document.getElementById("sag").value!=""){
			
			
			var	text = document.getElementById("sag").value.split("::").join("\n");
			
			document.getElementById("searchdetails").value+="\n\n"+text;	
			 
		}
		
		
 
	
 
	}
	function funExportBtn(){
		
		 var type = document.getElementById("type").value;
			if(type=="summary")
				{
				
				
				 
		   $("#summarygrid").jqxGrid('exportdata', 'xls', 'Sales Agent Report ');
		 
		
				}
			else
				{
				
				 JSONToCSVConvertor(exceldata, 'Sales Agent Report ', true);
				
				 
				}
		     
		  /*  

		   JSONToCSVConvertor(invoiceexceldata, 'Invoices List', true); */
		   }
		  
		  
	  function JSONToCSVConvertor(JSONData, ReportTitle, ShowLabel) {
 
		      var arrData = typeof JSONData != 'object' ? JSON.parse(JSONData) : JSONData;
		   
		      var CSV = '';    
		  
		      
		      CSV += ReportTitle + '\r\n\n';

		 
		      if (ShowLabel) {
		          var row = "";
		          
		          
		          for (var index in arrData[0]) {
		              
		            
		              row += index + ',';
		          }

		          row = row.slice(0, -1);
		          
		          
		          CSV += row + '\r\n';
		      }
		      
 
		      for (var i = 0; i < arrData.length; i++) {
		          var row = "";
		      
		          for (var index in arrData[i]) {
		              row += '"' + arrData[i][index] + '",';
		          }

		          row.slice(0, row.length - 1);
		       
		          CSV += row + '\r\n';
		      }

		      if (CSV == '') {        
		          alert("Invalid data");
		          return;
		      }   
		      
		 
		      var fileName = "";
	 
		      fileName += ReportTitle.replace(/ /g,"_");   
		      
		      
		      var uri = 'data:text/csv;charset=utf-8,' + escape(CSV);
		      
		    
		      var link = document.createElement("a");    
		      link.href = uri;
		      
		      
		      link.style = "visibility:hidden";
		      link.download = fileName + ".csv";
		 
		      document.body.appendChild(link);
		      link.click();
		      document.body.removeChild(link);
		  }
	
	  
	
	
	
	
	

</script>
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

</head>
<body onload="getBranch();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%"  >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table  >
	<jsp:include page="../../heading.jsp"></jsp:include>
		
	<tr><td colspan="2">&nbsp;</td></tr>
    <tr>
	 <td align="right"><label class="branch">From</label></td>
     <td align="left"><div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div></td></tr> 
	<tr>
	<td align="right"><label class="branch">To</label></td>
    <td align="left"><div id="todate" name="todate" value='<s:property value="todate"/>'></div></td>
	</tr>
	
	 <tr><td align="right"> <label class="branch">Type</label></td> <td ><select id="type" onchange="changegrid()">
 <option value="summary">Summary</option>
 <option value="detail">Detail</option>
 
 </select> </td></tr>  
	   <tr><td align="right"><label class="branch">Status</label></td>
     <td align="left"><select id="clstatuss" name="clstatuss"  value='<s:property value="clstatuss"/>'>
     <option value="">--Select--</option><option value=0>Open</option><option value=1>Close</option>
     </select></td></tr>
		<tr >
	  <td align="right"><label class="branch">Filter</label></td>
	  <td  align="left"><select name="searchby" id="searchby" style="width:50%;">    
     <option value="">--Select--</option>
    <option value="RAG">Rental Agreement</option>  
     <option value="SAG">Sales Agent</option>
 
    </select>&nbsp;<button type="button" name="btnadditem" id="additem" class="myButtons" onClick="setSearch();">+</button>&nbsp;&nbsp;<button  type="button" name="btnremoveitem" id="btnremoveitem" class="myButtons" onclick="setRemove();">-</button></td>
	  </tr>
	<tr >
	  <td colspan="2"
      align="right" ><textarea id="searchdetails" name="searchdetails" style="resize:none;font: 10px Tahoma;" rows="18" cols="45" readonly></textarea></td>
	  </tr>
	<tr >
	<td colspan="2"  ><center><input type="button" name="btnclear" id="btnclear" value="Clear" class="myButtons" onclick="funClearData();"></center>
    </td>
	</tr>
 
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%"> 
		<tr>
			 <td><div id="summarydiv" ><jsp:include page="summarygrid.jsp"></jsp:include></div>
			 
			 
			  <div id="detaildiv" hidden="true"><jsp:include page="detailsgrid.jsp"></jsp:include></div>
		
			 </td>
		</tr>
	</table>
</tr>
</table>
</div>

	  <input type="hidden" name="hidrag" id="hidrag">
			   <input type="hidden" name="hidsag" id="hidsag">
			 
			  	  <input type="hidden" name="rag" id="rag">
			  <input type="hidden" name="sag" id="sag">
			 



<div id="agentWindow">
	<div></div><div></div>
</div>
<div id="agreementDetailsWindow">
	<div></div><div></div>
</div>
</div> 
</body>
</html>