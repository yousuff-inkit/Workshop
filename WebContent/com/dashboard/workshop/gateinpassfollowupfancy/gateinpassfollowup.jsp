
<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>

<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 
<style>
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
	 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	
     $('#clientwindow').jqxWindow({ width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Client Search'  , theme: 'energyblue', position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	   $('#clientwindow').jqxWindow('close');
	   
	   $('#salesmanwindow').jqxWindow({ width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Salesman Search'  , theme: 'energyblue', position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	   $('#salesmanwindow').jqxWindow('close');
	 
	 $("#uptodate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 
	//  var fromdates=new Date($('#uptodate').jqxDateTimeInput('getDate'));
	// var onemounth=new Date(new Date(fromdates).setMonth(fromdates)); 
	  
  //   $('#uptodate').jqxDateTimeInput('setDate', new Date(onemounth));
	
	 
	 $('#clientname').dblclick(function(){
	  	    
		   $('#clientwindow').jqxWindow('open');
		       		clientSearchContent('clientsearch.jsp', $('#clientwindow')); 
	       });
	 $('#salesman').dblclick(function(){
	  	    
		   $('#salesmanwindow').jqxWindow('open');
		       		salesmanSearchContent('salesmansearch.jsp', $('#salesmanwindow')); 
	       });
});


function funExportBtn(){
	JSONToCSVCon(exceldata, 'Gate In Pass Follow Up', true);
	 }
function funreload(event)
{


	   
	

var uptodate= $("#uptodate").val();
 
var cldocno=$("#cldocno").val();
var salid=$("#salid").val();
var test ="10"; 

$("#Readygrid").load("subgrid.jsp?test="+test+"&uptodate="+uptodate+"&cldocno="+cldocno+"&salid="+salid+'&check=1');



  //$("#detlist").load("detailsGrid.jsp?barchval="+barchval+"&fromdate="+fromdate+"&todate="+todate+'&check=1');
 

	
	}
	


function getclinfo(event){
	 var x= event.keyCode;
	if(x==114){
 		$('#clientwindow').jqxWindow('open');
		clientSearchContent('clientsearch.jsp', $('#clientwindow'));    }
	else{}
} 

function clientSearchContent(url) {
	 	$.get(url).done(function (data) {
		$('#clientwindow').jqxWindow('open');
		$('#clientwindow').jqxWindow('setContent', data);
}); 
} 
function getsalesman(event){
	 var x= event.keyCode;
	if(x==114){
		$('#salesmanwindow').jqxWindow('open');
		clientSearchContent('salesmansearch.jsp', $('#salesmanwindow'));    }
	else{}
} 

function salesmanSearchContent(url) {
	 	$.get(url).done(function (data) {
		$('#salesmanwindow').jqxWindow('open');
		$('#salesmanwindow').jqxWindow('setContent', data);
}); 
} 

	  
	

	  function  funcleardata()
	  {
		  $("#userdetails").jqxGrid('clear');
		    $("#userdetails").jqxGrid('addrow', null, {});
	  	document.getElementById("cldocno").value="";
	    	document.getElementById("clientname").value="";
	   	
	  	
	  	 if (document.getElementById("clientname").value == "") {
	  			
	  		 
	  	        $('#clientname').attr('placeholder', 'Press F3 TO Search'); 
	  	    }
	  		  		
	  	}

	/*   function  funPrint()
	  {
		 var client=$('#clientname').val();
		  if(client==''){
				 $.messager.alert('Message','Please Select a Client.','warning');
				 return 0;
			 }
	   			
		 	    if ($("#cldocno").val()!="") {
			        var url=document.URL;
			        var reurl=url.split("clientfollowuplog.jsp");
			        var win= window.open(reurl[0]+"printclientfollowup?&cldocno="+document.getElementById("cldocno").value+'&fromdate='+$("#fromdate").val()+'&todate='+$("#todate").val(),"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
			        win.focus();
			     }
			    else {
					$.messager.alert('Message','Please Select a Client.','warning');
					return;
				}
			   }
	   */
	
	 function hidebutton(){
		   $('#estimate').hide();
		   $('#jobcart').hide();
		  
		   
	   }
	    function getGatePass(){
	
			var gipno = $('#gipnum').val();
			   
			if(gipno==''){
				 $.messager.alert('Message','Select A Document','warning');
				 return 0;
			 }
			
			var url=document.URL;
			var reurl=url.split("com/");
			
			window.parent.formName.value="Gate In-Pass";
			window.parent.formCode.value="GIP";
			
			var detName= "Gate In-Pass";
			var path= "com/workshop/gateinpassmaster/gateinpassviw.action?mode=view&docno="+gipno+"&id=2";
			top.addTab( detName,reurl[0]+""+path);
		}	
	    function getJobcard(){
	    	
			var jobdocno = $('#jobdocno').val();
			   
			if(jobdocno==''){
				 $.messager.alert('Message','Select A Document','warning');
				 return 0;
			 }
			
			var url=document.URL;
			var reurl=url.split("com/");
			
			window.parent.formName.value="Job Card";
			window.parent.formCode.value="JBC";
			
			var detName= "Job Card";
			var path= "com/workshop/wsjobcard_fancy/jobcardFancyView.action?mode=view&docno="+jobdocno+"&id=2";
			top.addTab( detName,reurl[0]+""+path);
		}	
	    function getEstimationadd(){
	    	
			
			
			var url=document.URL;
			var reurl=url.split("com/");
			
			window.parent.formName.value="Estimation";
			window.parent.formCode.value="EST";
			var gipno=$('#gipnum').val();
			var detName= "Estimation";
			var path= "com/workshop/estimationfancy/estimation.jsp?id=3&gipno="+gipno;
			top.addTab( detName,reurl[0]+""+path);
		}	
	    
	    function checkStatusAjax(){
	    	
	    	var docno=$('#gipnum').val();
	    	
	    	var x = new XMLHttpRequest();
	    	x.onreadystatechange = function() {
	    		if (x.readyState == 4 && x.status == 200) {
	    			var sts = x.responseText;
	    				if(sts!=1){
	    					$.messager.alert('Message','Invalid Document');
	    				}else{
	    					getEstimationadd();
	    				}
	    			}
	    	}
	    	x.open("GET", "checkProcessStatus.jsp?docno="+docno, true);
	    	x.send();
	    }
	    
function getEstimation(){
	    	
			var estimno = $('#estimno').val();
			var gipnoo = $('#gipnum').val(); 
			if(estimno==''){
				 $.messager.alert('Message','Select A Document','warning');
				 return 0;
			 }
			
			var url=document.URL;
			var reurl=url.split("com/");
			
			window.parent.formName.value="Estimation";
			window.parent.formCode.value="EST";
			
			var detName= "Estimation";
			var path= "com/workshop/wsestimationfancy/estimationFancyView.action?mode=view&docno="+estimno+"&gipnoo="+gipnoo+"&id=2";
			top.addTab( detName,reurl[0]+""+path);
		}
function getJobcardadd(){
	
	
	
	var url=document.URL;
	var reurl=url.split("com/");
	
	window.parent.formName.value="Job Card";
	window.parent.formCode.value="JBC";
	
	var detName= "Job Card";
	var path= "com/workshop/jobcard/jobCard.jsp?id=3";
	top.addTab( detName,reurl[0]+""+path);
}	
 </script>
</head>
<body onload="getBranch();hidebutton();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%">
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table  width="100%"  >
	<jsp:include page="../../heading.jsp"></jsp:include>

	<!--  <tr><td colspan="2">&nbsp;</td></tr> -->
<!--  <tr><td colspan="2" align="center"><label class="branch">Detail</label><input type="checkbox" id="det_chk"  name="det_chk" value="0"   onclick="funsetaval()" >
 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td></tr>  -->
	  <tr width="100%">
	  <td align="right" width="40%" ><label class="branch">Upto Date</label></td>
	  <td align="left" width="40%"><div id='uptodate' name='uptodate' value='<s:property value="uptodate"/>'></div>
                    </td></tr>
   <tr><td align="right"><label class="branch">Client</label></td><td align="left"><input type="text" name="clientname" id="clientname" placeholder="Press F3 To Search" readonly="readonly" onKeyDown="getclinfo(event);" onclick="this.placeholder='' "  style="height:20px;width:90%;" value='<s:property value="clientname"/>'></td></tr>                 
		
	<tr><td align="right"><label class="branch">Salesman</label></td><td align="left"><input type="text" name="salesman" id="salesman" placeholder="Press F3 To Search" readonly="readonly" onKeyDown="getsalesman(event);" onclick="this.placeholder='' "  style="height:20px;width:90%;" value='<s:property value="salesman"/>'></td></tr>
		 <tr>
	<td colspan="2" ><div id="Readygrid"><jsp:include page="subgrid.jsp"></jsp:include>
	</div></td>
	</tr> 
<tr><td colspan="2">&nbsp;</td></tr>
<tr>
<td colspan="2">	
	
	</td>
	</tr>
	<tr><td colspan="2">
	<fieldset width="100%"><legend>View</legend>
	<table >
	<tr>
	 <td  align="left"><input type="button" class="myButton" name="viewgatepass" id="viewgatepass"  value="Gate In Pass" onclick="getGatePass();"></td>
	 <td align="right">
	 
	 <input type="button" class="myButton" name="viewjobcart" id="viewjobcart"  value="Job Card" onclick="getJobcard();"></td>
	 </tr>
	 <tr>
	 <td colspan="2" align="center"><input type="button" class="myButton" name="viewestimation" id="viewestimation"  value="Estimation" onclick="getEstimation();"></td>
	 </tr>
	</table>	
	</fieldset>
	</td>
	</tr>

	</table>
	</fieldset>
	<input type="hidden" name="cldocno" id="cldocno" style="height:20px;width:70%;" value='<s:property value="cldocno"/>' >
    <input type="hidden" name="gipnum" id="gipnum" style="height:20px;width:70%;" value='<s:property value="gipnum"/>' >
    <input type="hidden" name="estimno" id="estimno" style="height:20px;width:70%;" value='<s:property value="estimno"/>' >
   <input type="hidden" name="jobdocno" id="jobdocno" style="height:20px;width:70%;" value='<s:property value="jobdocno"/>' >
    <input type="hidden" name="salid" id="salid" style="height:20px;width:70%;" value='<s:property value="salid"/>' >
</td>
<td width="80%">
<div  >
	<table width="100%" id="grid1">
	 
		<tr>
			  <td ><div  id="fleetdiv"><jsp:include page="detailsgrid.jsp"></jsp:include></div> 
			</td></tr>
	</table>
</div>
<div >
	<!-- <table width="100%" id="chart">
		<tr>
			 <td width="50%">
			<div id='fleetStatus1' style="width: 100%; height: 250px;"></div>
			  <div id='sec1' style="width: 100%; height: 250px;"></div>
			   </td><td>  <div id='thr1' style="width: 100%; height: 250px;"></div>
			   <div id='four1' style="width: 100%; height: 250px;"></div></td></tr>
	</table> -->
</div>
</tr>
</table>
  
</div>
<div id="clientwindow">
   <div></div>
</div>
<div id="salesmanwindow">
   <div></div>
</div>
</div>

</body>
</html>
