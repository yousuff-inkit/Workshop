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
  height: 530px;
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
	    
	 $("#Uptodate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 
	 $('#bayWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Bay Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 $('#bayWindow').jqxWindow('close');
	 
	 $('#TechnicianWindow').jqxWindow({ width: '50%', height: '55%',  maxHeight: '55%' ,maxWidth: '50%' , title: 'Technician Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	 $('#TechnicianWindow').jqxWindow('close');
	 
	 $('#sparePartWindow').jqxWindow({ width: '50%', height: '55%',  maxHeight: '55%' ,maxWidth: '50%' , title: 'Spare Part Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	 $('#sparePartWindow').jqxWindow('close');
	 
	 $('#jobcard').dblclick(function(){
		 jobCardSearchContent("jobCardSearch.jsp");

		});
	 $('#jobCardToWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Job Card Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 $('#jobCardToWindow').jqxWindow('close');
	 
});


	

	function funNotify(){
		
		return 1;
		
	}
	
		
	
	function funClearData(){
		$('input[type=text],[type=hidden]').val('');
		$('select').find('option').prop("selected", false);
		$('#Uptodate').jqxDateTimeInput('setDate',new Date());
	    $('input[type=radio]').prop("checked",false);
	    $('input[type=checkbox]').prop("checked",false);
	    $("#servicegrid2").jqxGrid('clear');
	    $("#partsgrid3").jqxGrid('clear');
	    $("#jobgrid1").jqxGrid('clear');
	}
	
	
	function funreload(event)
	
	{	
	    var date=$('#Uptodate').jqxDateTimeInput('val');
	    var jobcard=document.getElementById("jobcard").value;
	     $("#overlay, #PleaseWait").show();  
	    $("#jobexecutiongrid1div").load("jobGrid.jsp?uptodate="+date+"&id=1"+"&jobcard="+jobcard); 
	    /* alert("inside"); */
	   	
	}
	
	 function SearchContent(url,id) {
	    $.get(url).done(function (data) {
	  $('#'+id).jqxWindow('setContent', data);
	}); 
	}
	 
function funUpdateDetails()
		{
		
	      var selectedrows=$("#partsgrid3").jqxGrid('selectedrowindexes');
		    
			if(selectedrows.length==0){
				$.messager.alert('Warning','Product Is Mandatory');
				return false;
			}
			
			  $.messager.confirm('Confirm', 'Do you want to Save Changes?', function(r){
	 			if (r){	
					var estimationrequestarray=new Array();
					var purchaserequestarray=new Array();
					var selectedrows=$("#partsgrid3").jqxGrid('selectedrowindexes');
					selectedrows = selectedrows.sort(function(a,b){return a - b});  
			
		 
			
				  for(var i=0 ; i < selectedrows.length ; i++){
					 
			 
						
						var unitdocno=	$("#partsgrid3").jqxGrid('getcellvalue',selectedrows[i],'unitdocno');
						var psrno=$("#partsgrid3").jqxGrid('getcellvalue',selectedrows[i],'psrno');
						
						/* var prodoc=	$("#partsgrid3").jqxGrid('getcellvalue',selectedrows[i],'prodoc'); */
						
						var purqty=$("#partsgrid3").jqxGrid('getcellvalue',selectedrows[i],'toberequested');
						var specid=$("#partsgrid3").jqxGrid('getcellvalue',selectedrows[i],'specid');
						 
						var aa=0;
						purchaserequestarray.push(psrno+"::"+psrno+"::"+unitdocno+"::"+purqty+"::"+"0"+"::"+aa+"::"+specid+"::"+aa+"::"+"0"+" :: "+"0");
						
						/*  newTextBox.val(rows[i].psrno+"::"+rows[i].prodoc+" :: "+rows[i].unitdocno+" :: "+rows[i].qty+" :: "  
								   +rows[i].saveqty+" :: "+rows[i].checktype+" :: "+rows[i].specid+" :: "+rows[i].foc+" ::"+"0"+" :: "+"0" ); */
					 
						  }
				  openPurchase(purchaserequestarray);
				  
	 			}
	 	 		});
		} 
		
function openPurchase(purchaserequestarray)
{
	/* var btn="request";
	var conttrno=$('#contracttrno').val(); 
	var contocno=$('#contractdocno').val();*/
	var cldocno=$('#cldocno').val();
	var jobno=$('#jobno').val(); 
	
	

	 
	
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200){
	     			
				var items=x.responseText;
				if(parseInt(items)=="1")  
				{	
				
				$.messager.alert('Message', '  Record Successfully Updated ');
			
				disablepart();
				//sparepartload(event);
				}
				else
				{
				$.messager.alert('Message', '  Not Updated  ');
				}
				}
		}
    x.open("GET","saveData.jsp?purchaserequestarray="+purchaserequestarray+"&cldocno="+cldocno+"&jobno="+jobno,true);	 		
	x.send();
			
	  
	
}
function funServiceUpdate()
{

//   var selectedrows=$("#servicegrid2").jqxGrid('selectedrowindexes');
    
// 	if(selectedrows.length==0){
// 		$.messager.alert('Warning','please Select');
// 		return false;
// 	}
	
// 	  $.messager.confirm('Confirm', 'Do you want to Save Changes?', function(r){
// 			if (r){	
// 	var servicearray=new Array();
// 	var selectedrows=$("#servicegrid2").jqxGrid('selectedrowindexes');
// 	selectedrows = selectedrows.sort(function(a,b){return a - b});  
	
 
	
// 		  for(var i=0 ; i < selectedrows.length ; i++){
			 
	 
				
// 				var technician=	$("#servicegrid2").jqxGrid('getcellvalue',selectedrows[i],'technician');
// 				var bay=$("#servicegrid2").jqxGrid('getcellvalue',selectedrows[i],'bay');
// 				var completed=$("#servicegrid2").jqxGrid('getcellvalue',selectedrows[i],'completed');
// 				var execdetails=$("#servicegrid2").jqxGrid('getcellvalue',selectedrows[i],'execdetails');
// 				var rowno=$("#servicegrid2").jqxGrid('getcellvalue',selectedrows[i],'rowno');
// 				var bayno=$("#servicegrid2").jqxGrid('getcellvalue',selectedrows[i],'bayno');
// 				var techno=$("#servicegrid2").jqxGrid('getcellvalue',selectedrows[i],'techno');
				 
// 				/* var aa=0; */
				
// 				servicearray.push(completed+"::"+execdetails+"::"+rowno+"::"+bayno+"::"+techno);
			 
// 				  }
// 		  openService(servicearray);
		  
// 			}
// 	 		});
	var rows = $('#servicegrid2').jqxGrid('getrows');
    var result = "";
    if(rows.length==0){
     $.messager.alert('Message','Choose a document','warning');
    }
    else{
 $.messager.confirm('Confirm', 'Do you want to Save Changes?', function(r){
    if (r){ 
      var gridarray=new Array();
       for(var i = 0; i < rows.length; i++)
       {
           var row = rows[i];
           gridarray[i]=(rows[i].completed+"::"+rows[i].execdetails+"::"+rows[i].rowno+"::"+rows[i].bayno+"::"+rows[i].techno);
         //  result += row.firstname + " " + row.lastname + " " + row.productname + " " + row.date + " " + row.quantity + " " + row.price + "\n";        
       }
       openService(gridarray);
       
  }
 });
    }

} 

function openService(servicearray)
{
	

/* var techno=$('#techno').val(); 
var bayno=$('#bayno').val(); */

 var jcDocno=$('#jcDocno').val();






var x=new XMLHttpRequest();
x.onreadystatechange=function(){
if (x.readyState==4 && x.status==200){
 			
		var items=x.responseText;
		if(parseInt(items)=="1")  
		{	
		
		$.messager.alert('Message', '  Record Successfully Updated ');
	
		disableservice();
		//serviceload(event);
		}
		else
		{
		$.messager.alert('Message', '  Not Updated  ');
		}
		}
}
x.open("GET","updateServiceData.jsp?servicearray="+servicearray+"&docno="+jcDocno,true);	 		
x.send();
	


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

function disablepart(){
	
	$("#partsgrid3").jqxGrid('clear');
	 $("#partsgrid3").jqxGrid({ disabled: true});
	 
}

function disableservice(){
	
	$("#servicegrid2").jqxGrid('clear');
	 $("#servicegrid2").jqxGrid({ disabled: true});
	 
}
function funExportBtn(){
	//alert("inside Export");
	JSONToCSVConvertor(jobexceldata, 'Job List', true);
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
   <td width="37%" align="right"><label class="branch">Upto</label></td><td width="63%"><div id="Uptodate"></div></td>
 </tr>
 <tr>
   <td width="37%" align="right"><label class="branch">Job Card</label></td>
   <td width="63%"><input type="text" name="jobcard" id="jobcard" readonly placeholder="Press F3 to Search" onkeydown="getjobCardDetails(event)"></td>
 </tr>
 <tr >
	<td colspan="2" style="border-top:2px solid #DCDDDE;">
	<div style="text-align:center;">
	<input type="button" name="btnclear" id="btnclear" value="Clear" class="myButtons" onclick="funClearData();"> &nbsp;
	<input type="button" name="btnupdate" id="btnupdate" value="Update" class="myButtons" onclick="funServiceUpdate();"> &nbsp;
	</div>
    </td>
	</tr>
<tr ><td colspan="2"><!-- <textarea id="agmtdetails" name="agmtdetails" readonly style="resize:none;" rows="10" cols="35"></textarea> -->
	<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
	<div style="text-align:center;">
		<input type="button" name="btncreatmr" id="btncreatmr" value="Creat MR" class="myButtons" onclick="funUpdateDetails();">
	</div>
	<br><br><br><br><br><br><br><br><br>

</td></tr>

<tr colspan="2"><td>&nbsp;</td></tr>
	
		
	</table>
	</fieldset>
</td>
<td width="80%">
	<fieldset class="violetClass">
	<legend>Job Details </legend>
	    <table width="100%" border="0">
		  <tr>
	   		<td><div id="jobexecutiongrid1div"><jsp:include page="jobGrid.jsp"></jsp:include></div></td>
	   	  </tr>
		</table>
	</fieldset>
	
	<fieldset class="redClass">
	<legend>Service Details </legend>
	    <table width="100%" border="0">
		  <tr>
	   		<td><div id="jobexecutiongrid2div"><jsp:include page="serviceGrid.jsp"></jsp:include></div></td>
	   	  </tr>
		</table>
	</fieldset>
	
	<fieldset class="violetClass">
	<legend>Parts Details </legend>
	    <table width="100%" border="0">
		  <tr>
	   		<td><div id="jobexecutiongrid3div"><jsp:include page="partsGrid.jsp"></jsp:include></div></td>
	   	  </tr>
		</table>
	</fieldset>
</tr>
</table>
</div>

</div>
			  <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
			  <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
			  <input type="hidden" name="jcDocno" id="jcDocno" value='<s:property value="jcDocno"/>'>
			  <input type="hidden" name="cldocno" id="cldocno" value='<s:property value="cldocno"/>'>
			  <input type="hidden" name="jobno" id="jobno" value='<s:property value="jobno"/>'>
			  <input type="hidden" name="techno" id="techno" value='<s:property value="techno"/>'>
			  <input type="hidden" name="bayno" id="techno" value='<s:property value="techno"/>'>
</form>
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