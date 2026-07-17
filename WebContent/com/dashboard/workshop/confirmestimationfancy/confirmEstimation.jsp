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
<% String contextPath=request.getContextPath();%>
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
 
select{
    height:15px;
}
</style>

<script type="text/javascript">

$(document).ready(function () {
		
		$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200px;right:750px;'><img src='../../../../icons/31load.gif'/></div>");
	 
	    $('#additionWindow').jqxWindow({width: '30%', height: '19%',  maxHeight: '50%' ,maxWidth: '40%' , title: 'Print',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	    $('#additionWindow').jqxWindow('close');
	    
	 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
	 var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
	 $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate);
	 $('#clientSearchWindow').jqxWindow({width: '50%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Client Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 $('#clientSearchWindow').jqxWindow('close');
	 
	 
	 $("#clientname").dblclick(function(){
			
		 clientSearchContent(<%=contextPath+"/"%>+"com/dashboard/workshop/confirmestimation/clientSearch.jsp");

		});
	 
});

function searchClient(){
	var x= event.keyCode;
	if(x==114){
			clientSearchContent(<%=contextPath+"/"%>+"com/dashboard/workshop/confirmestimation/clientSearch.jsp");
	
	
	}
}


function clientSearchContent(url) {
 	$('#clientSearchWindow').jqxWindow('open');
	$.get(url).done(function (data) {
	$('#clientSearchWindow').jqxWindow('setContent', data);
	$('#clientSearchWindow').jqxWindow('bringToFront');
}); 
}


function funreload(event)
{
	
    var fromdate=$('#fromdate').jqxDateTimeInput('val');
    var todate=$('#todate').jqxDateTimeInput('val');
    var cldocno=$('#cldocno').val();
    
    
    document.getElementById("docno").value ='';
    
    document.getElementById("insuretype").value =1;
    

    $("#overlay, #PleaseWait").show();
   	$("#confirmestimationdiv").load("confirmEstimationGrid.jsp?id=1&fromdate="+fromdate+"&todate="+todate+"&cldocno="+cldocno);
   	
}
	
	

	function setValues(){

		 if($('#msg').val()!=""){
   		   $.messager.alert('Message',$('#msg').val());
   		  }
	
	}
	
	function funExportBtn(){
		//JSONToCSVCon(repexceldata, 'Replacement List', true);
		 }
	
		
	
	function funClearData(){
		$('input[type=text],[type=hidden]').val('');
		$('select').find('option').prop("selected", false);
		$('#fromdate').jqxDateTimeInput('setDate',new Date());
		$('#todate').jqxDateTimeInput('setDate',new Date());
		var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
	    var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
	    $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate); 
	
	}
	
	
	
	function viewEstimation(event){
		var docno = $('#docno').val();
		var gipno = $('#hidgipno').val();
		
		if(docno==''){
			 $.messager.alert('Message','Choose a document','warning');
			 return 0;
		 }
		
		var url=document.URL;
		var reurl=url.split("com/");
		
	     var labaddition=$('#hidlabaddition').val();
		 var spaddition=$('#hidspaddition').val();
		 
		 if(labaddition==0&&spaddition==0){
		    window.parent.formName.value="Estimation";
			window.parent.formCode.value="WE";
			
			var detName= "Estimation";
			var path= "com/workshop/wsestimationnew/estimationNewView.action?mode=view&docno="+docno+"&gipnoo="+gipno+"&id=2";
			top.addTab( detName,reurl[0]+""+path);
		 }
		 else{
			 var maxaddition;
			 var jobno=$('#hidjobno').val();
			 if($('#hidlabadditionmax').val()>$('#hidspadditionmax').val()){
				 maxaddition=$('#hidlabadditionmax').val()
			 }
			 else{
				 maxaddition=$('#hidspadditionmax').val();
			 }
			 window.parent.formName.value="Additional Estimation";
				window.parent.formCode.value="WE";
				
				var detName= "Additional Estimation";
				var path= "com/workshop/estimationadditionfancy/estimationAdditionFancyView.action?mode=view&docno="+docno+"&jcno="+jobno+"&addition="+maxaddition+"&id=2";
				top.addTab( detName,reurl[0]+""+path);
		}
	}
	
	function addEstmContent(url) {
		$('#additionWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#additionWindow').jqxWindow('setContent', data);
		$('#additionWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function funConfirm(){
		var docno=$('#docno').val();
		var brhid=$('#brhid').val();
		var labaddition=$('#hidlabaddition').val();
		var spareaddition=$('#hidspaddition').val();
		if(labaddition=='' || labaddition=='undefined' || labaddition==null){
			labaddition = 0;
		}
		if(spareaddition=='' || spareaddition=='undefined' || spareaddition==null){
			spareaddition = 0;
		}
		var insuretype=$('#insuretype').val();
		if(docno==''){
			 $.messager.alert('Message','Choose a document','warning');
			 return false;
		}
		//alert("confirmation.jsp?docno="+docno+"&brhid="+brhid+"&labaddition="+labaddition+"&insuretype="+insuretype+"&spareaddition="+spareaddition);
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText.trim();
// 				alert(items);
				if(items=="0"){
					
					$.messager.alert('Message','Confirmed Succesfully','info');
				}
				else{
					$.messager.alert('Message','Confirmation Failed','warning');
				}
				funreload(event);
				
			}
			else{
				}
			}
		
		x.open("GET", "confirmation.jsp?docno="+docno+"&brhid="+brhid+"&labaddition="+labaddition+"&insuretype="+insuretype+"&spareaddition="+spareaddition, true);
		x.send();
	}
	function funExportBtn(){
		JSONToCSVConvertor(estexceldata, 'CONFIRM ESTIMATION', true);
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
<body onload="setValues();getBranch();">
<form id="frmWorkConfirmEstimation" method="post">
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
    <td width="37%" align="right"><label class="branch">Client Name</label></td>
    <td width="63%" align="left"><input type="text" name="clientname" id="clientname" placeholder="Press F3 to search" style="height: 20px;" onkeydown="searchClient(event);"></td>
  </tr>
  
  <tr>
  	<td colspan="2" style="border-top:2px solid #DCDDDE;">
  		<div style="text-align:center;">&nbsp;&nbsp;
  		<label class="branch"></label>
  		<input type="hidden" name = "docno" id = "docno" readonly="readonly">
  		<input type="hidden" name="brhid" id="brhid">
  		</div>
  	</td>
  </tr>
  
  
  
  
  
   
  
  <td align="right"><label class="branch" >Insurance Type</label></td>
    <td align="left" width="10%" ><select name="insuretype" id="insuretype" style="width:40%;"  value='<s:property value="insuretype"/>'>
      <option value="1" >Own</option>
      <option value="2" >Third Party</option>
    </select></td> 
  
  
  
  
  
  

<tr >
	<td colspan="2" style="border-top:2px solid #DCDDDE;">
	<div style="text-align:center;">
		<input type="button" name="btnclear" id="btnclear" value="Clear" class="myButtons" onclick="funClearData();">&nbsp;
		<input type="button" name="btnView" id="btnView" value="View" class="myButtons" onclick="viewEstimation(event);">
		<input type="button" name="btnConfirm" id="btnConfirm" value="Confirm" class="myButtons" onclick="funConfirm();">
	</div>
    </td>
</tr>
<br/><br/>	

	
	
	
<tr ><td colspan="2"><!-- <textarea id="agmtdetails" name="agmtdetails" readonly style="resize:none;" rows="10" cols="35"></textarea> -->
	<br><br>
<br><br><br><br><br><br><br><br><br>
</td></tr>

<tr colspan="2"><td>&nbsp;</td></tr>
	
		
	</table>
	</fieldset>
	
	 
	
</td>
<td width="77%">
	<table width="100%">
		<tr>
			 <td><div id="confirmestimationdiv"><jsp:include page="confirmEstimationGrid.jsp"></jsp:include></div></td>
			  <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
			  <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
		
		</tr>
	</table>
</tr>
</table>
</div>

</div>


<div id="clientSearchWindow">
	<div></div>
</div>
<div id="additionWindow">
	<div></div>
</div>

<input type="hidden" name="cldocno" id="cldocno"/>
<input type="hidden" name="brhid" id="brhid"/>
<input type="hidden" name="hidgipno" id="hidgipno"/>
<input type="hidden" name="hidjobno" id="hidjobno"/>
<input type="hidden" name="hidlabaddition" id="hidlabaddition"/>
<input type="hidden" name="hidspaddition" id="hidspaddition"/>
<input type="hidden" name="hidlabadditionmax" id="hidlabadditionmax"/>
<input type="hidden" name="hidspadditionmax" id="hidspadditionmax"/>
</form>



</body>
</html>