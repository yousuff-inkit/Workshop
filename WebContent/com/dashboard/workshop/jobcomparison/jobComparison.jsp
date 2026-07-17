<link href="../../../../css/css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<%--  <script type="text/javascript" src="../../js/dashboard.js"></script>  --%>
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
 
select{
    height:18px;
}
.hidden-scrollbar {
  /* // overflow: auto; */
  height: 600px;
    overflow-x: hidden;
    
}
.headClass
        {
            background-color: #FFEBC2;
        }
        .redClass
        {
            background-color: #FFEBEB;
        }
        .violetClass
        {
            background-color: #EBD6FF;
        }
        .yellowClass
        {
            background-color: #FFFFD1;
        }
        .whiteClass
        {
           background-color: #FFF;
        }
        .greenClass
        {
           background-color: #CEFFCE;
        }	  
</style>

<script type="text/javascript">

$(document).ready(function () {
	
	
		$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200px;right:750px;'><img src='../../../../icons/31load.gif'/></div>");
	    $('#clientwindow').jqxWindow({ width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Client Search'  , theme: 'energyblue', position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	   	$('#clientwindow').jqxWindow('close');
	 	$("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 	$("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 
	 	$('#client').dblclick(function(){
	 		$('#clientwindow').jqxWindow('open');
			clientSearchContent('clientSearchGrid.jsp?id=1', $('#clientwindow')); 
	 	});
	 	var fromdate=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		var onemonthbefore=new Date(new Date(fromdate).setMonth(fromdate.getMonth()-1)); 
    	$('#fromdate').jqxDateTimeInput('setDate', new Date(onemonthbefore));
});

function getClient(event){
	var x= event.keyCode;
	if(x==114){
 		$('#clientwindow').jqxWindow('open');
		clientSearchContent('clientSearchGrid.jsp?id=1', $('#clientwindow'));    }
	else{}
}
function clientSearchContent(url) {
 	$.get(url).done(function (data) {
		$('#clientwindow').jqxWindow('open');
		$('#clientwindow').jqxWindow('setContent', data);
	}); 
}

	function funNotify(){
		
		return 1;
		
	}
	
		
	
	function funClearData(){
		$('input[type=text],[type=hidden]').val('');
		$('select').find('option').prop("selected", false);
		$('#fromdate,#todate').jqxDateTimeInput('setDate',new Date());
	    $('input[type=radio]').prop("checked",false);
	    $('input[type=checkbox]').prop("checked",false);
	    $("#jobComparisonGrid").jqxGrid('clear');
	   	var fromdate=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		var onemonthbefore=new Date(new Date(fromdate).setMonth(fromdate.getMonth()-1)); 
    	$('#fromdate').jqxDateTimeInput('setDate', new Date(onemonthbefore));
	}
	
	
	function funreload(event)
	{	
		var fromdate=$('#fromdate').jqxDateTimeInput('val');
		var todate=$('#todate').jqxDateTimeInput('val');
	    var cldocno=document.getElementById("cldocno").value;
	    $("#jobComparisonGrid").jqxGrid('clear');
	    $("#overlay, #PleaseWait").show();
	    $("#jobcomparisondiv").load("jobComparisonGrid.jsp?fromdate="+fromdate+"&todate="+todate+"&id=1"+"&cldocno="+cldocno); 
	}
	
	 function SearchContent(url,id) {
	    $.get(url).done(function (data) {
	  $('#'+id).jqxWindow('setContent', data);
	}); 
	}
	 

function getjobCardDetails(event){
    var x= event.keyCode;
    if(x==114){
    	jobCardSearchContent("jobCardSearch.jsp");
    }
    else{
     }
    }
function jobCardSearchContent(url) {
 	$('#jobCardToWindow').jqxWindow('open');
	$.get(url).done(function (data) {
		$('#jobCardToWindow').jqxWindow('setContent', data);
	});
}    

function funExportBtn(){
	JSONToCSVConvertor(jobexceldata, 'Job Comparison List', true);
}

function JSONToCSVConvertor(JSONData, ReportTitle, ShowLabel) {

    var arrData = typeof JSONData != 'object' ? JSON.parse(JSONData) : JSONData;
    
   // alert("arrData");
    var CSV = '';    
    //Set Report title in first row or line
    
    CSV += ReportTitle + '\r\n\n';

    //This condition will generate the Label/Header
    if (ShowLabel) {
        var row = "";
        
        //This loop will extract the label from 1st index of on array
        for (var index in arrData[0]) {
            
            //Now convert each value to string and comma-seprated
            row += index + ',';
        }

        row = row.slice(0, -1);
        
        //append Label row with line break
        CSV += row + '\r\n';
    }
    
    //1st loop is to extract each row
    for (var i = 0; i < arrData.length; i++) {
        var row = "";
        
        //2nd loop will extract each column and convert it in string comma-seprated
        for (var index in arrData[i]) {
            row += '"' + arrData[i][index] + '",';
        }

        row.slice(0, row.length - 1);
        
        //add a line break after each row
        CSV += row + '\r\n';
    }

    if (CSV == '') {        
        alert("Invalid data");
        return;
    }   
    
    //Generate a file name
    var fileName = "";
    //this will remove the blank-spaces from the title and replace it with an underscore
    fileName += ReportTitle.replace(/ /g,"_");   
    
    //Initialize file format you want csv or xls
    var uri = 'data:text/csv;charset=utf-8,' + escape(CSV);
    
    // Now the little tricky part.
    // you can use either>> window.open(uri);
    // but this will not work in some browsers
    // or you will not get the correct file extension    
    
    //this trick will generate a temp <a /> tag
    var link = document.createElement("a");    
    link.href = uri;
    
    //set the visibility hidden so it will not effect on your web-layout
    link.style = "visibility:hidden";
    link.download = fileName + ".csv";
    
    //this part will append the anchor tag and remove it after automatic click
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
}

	</script>
	
</head>
<!-- setValues(); -->
<body onload="getBranch();">
<form id="frmWorkQuotationApproval" method="post">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%">
<tr>
<td width="20%" align="center">
    <fieldset style="background: #ECF8E0;">
	<table width="100%">
	<jsp:include page="../../heading.jsp"></jsp:include>

 <tr>
   <td width="37%" align="right"><label class="branch">From Date</label></td><td width="63%"><div id="fromdate"></div></td>
 </tr>
  <tr>
   <td width="37%" align="right"><label class="branch">To Date</label></td><td width="63%"><div id="todate"></div></td>
 </tr>
 <tr>
   <td width="37%" align="right"><label class="branch">Client</label></td>
   <td width="63%"><input type="text" name="client" id="client" readonly placeholder="Press F3 to Search" onkeydown="getClient(event)"></td>
 </tr>
 <tr >
	<td colspan="2" style="border-top:2px solid #DCDDDE;">
	<div style="text-align:center;">
	<input type="button" name="btnclear" id="btnclear" value="Clear" class="myButtons" onclick="funClearData();"> &nbsp;
	</div>
    </td>
	</tr>
	
<tr colspan="2"><td><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br></td></tr>
	
		
	</table>
	</fieldset>
</td>
<td width="80%">
	<fieldset>
	<legend>Job Details </legend>
	    <table width="100%" border="0">
		  <tr>
	   		<td colspan="2"><div id="jobcomparisondiv"><jsp:include page="jobComparisonGrid.jsp"></jsp:include></div></td>
	   	  </tr>
		</table>
	</fieldset>
	
</tr>
</table>
</div>

</div>
			  <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
			  <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
			  <input type="hidden" name="jobdocno" id="jobdocno" value='<s:property value="jobdocno"/>'>
			  <input type="hidden" name="gatedocno" id="gatedocno" value='<s:property value="gatedocno"/>'>
			  <input type="hidden" name="cldocno" id="cldocno" value='<s:property value="cldocno"/>'>
</form>
<div id="clientwindow">
   <div></div>
</div>
<div id="TechnicianWindow">
	<div></div>
	</div>
	<div id="bayWindow">
	<div></div>
	</div>
	<div id="sparePartWindow">
	<div></div>
	</div>
	<div id="jobCardToWindow">
	<div></div>
	</div>
</body>
</html>