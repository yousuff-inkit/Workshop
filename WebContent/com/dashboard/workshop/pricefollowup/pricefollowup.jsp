
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
	   
	     $('#gipwindow').jqxWindow({ width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Gate In Pass Search'  , theme: 'energyblue', position: { x: 250, y: 120 }, keyboardCloseKey: 27});
		   $('#gipwindow').jqxWindow('close');
	 
	
		 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
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
		 
	
	 
		 $('#clientname').dblclick(function(){
		  	    
			   $('#clientwindow').jqxWindow('open');
			       		clientSearchContent('clientsearch.jsp', $('#clientwindow')); 
		       });
	 
	 
	 $('#gipno').dblclick(function(){
	  	    
		   $('#gipwindow').jqxWindow('open');
		       		gipSearchContent('gipsearch.jsp', $('#gipwindow')); 
	       });
	 
});


function funreload(event)
{


	   
	

/* var uptodate= $("#uptodate").val(); */
 
var cldocno=$("#cldocno").val();
var fromdate=$("#fromdate").val();
var todate=$("#todate").val();
var gipno=$("#gipno").val();


var check=1;
$("#fleetdiv").load("detailsgrid.jsp?cldocno="+cldocno+"&check="+check+"&froms="+fromdate+"&todate="+todate+"&gipno="+gipno+"&process=2");

	
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

function getipnoinfo(event){
	 var x= event.keyCode;
	if(x==114){
 		$('#gipwindow').jqxWindow('open');
		gipSearchContent('gipsearch.jsp', $('#gipwindow'));    }
	else{}
} 

function gipSearchContent(url) {
	 	$.get(url).done(function (data) {
		$('#gipwindow').jqxWindow('open');
		$('#gipwindow').jqxWindow('setContent', data);
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
	
	
	    function getEstimation(){
	
			var estimno = $('#estimno').val();
			var gipnoo = $('#gipnoo').val(); 
			if(estimno==''){
				 $.messager.alert('Message','Select A Document','warning');
				 return 0;
			 }
			
			var url=document.URL;
			var reurl=url.split("com/");
			
			window.parent.formName.value="Estimation";
			window.parent.formCode.value="EST";
			
			var detName= "Estimation";
			var path= "com/workshop/wsestimationnew/estimiviw.action?mode=view&docno="+estimno+"&gipnoo="+gipnoo+"&id=2";
			top.addTab( detName,reurl[0]+""+path);
		}	
	   
 </script>
</head>
<body onload="getBranch();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%">
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table  width="100%" >
	<jsp:include page="../../heading.jsp"></jsp:include>

	<!--  <tr><td colspan="2">&nbsp;</td></tr> -->
<!--  <tr><td colspan="2" align="center"><label class="branch">Detail</label><input type="checkbox" id="det_chk"  name="det_chk" value="0"   onclick="funsetaval()" >
 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td></tr>  -->
 <tr><td>&nbsp;</td></tr>
	 	  <tr><td  align="right" ><label class="branch">From</label></td><td align="left"><div id='fromdate' name='fromdate' value='<s:property value="fromdate"/>'></div>
                    </td></tr>
                    <tr><td>&nbsp;</td></tr>

                     <tr><td  align="right" ><label class="branch">To</label></td><td align="left"><div id='todate' name='todate' value='<s:property value="todate"/>'></div>
                    </td></tr>
                    <tr><td>&nbsp;</td></tr>
   <tr><td width="20%" align="right"><label class="branch">Client</label></td><td align="left"><input type="text" name="clientname" id="clientname" placeholder="Press F3 To Search" readonly="readonly" onKeyDown="getclinfo(event);" onclick="this.placeholder='' "  style="height:20px;width:90%;" value='<s:property value="clientname"/>'></td></tr>                 
		<tr><td align="right"><label class="branch">GIP No.</label></td><td align="left"><input type="text" name="gipno" id="gipno" placeholder="Press F3 To Search" readonly="readonly" onKeyDown="getipnoinfo(event);" onclick="this.placeholder='' "  style="height:20px;width:90%;" value='<s:property value="gipno"/>'></td></tr>
		<tr><td colspan="2">&nbsp;</td></tr>
<tr><td colspan="2">&nbsp;</td></tr>	

	<tr><td colspan="2">
	<fieldset width="100%"><legend>View</legend>
	<table >
	<tr>
	 <td  align="center"><input type="button" class="myButton" name="viewestimation" id="viewestimation"  value="Estimation" onclick="getEstimation();"></td>
	</tr>
	</table>	
	</fieldset>
	</td>
	</tr>

<tr><td>&nbsp;</td></tr>
<tr><td>&nbsp;</td></tr>
<tr><td>&nbsp;</td></tr>
<tr><td>&nbsp;</td></tr>
<tr><td>&nbsp;</td></tr>
<tr><td>&nbsp;</td></tr>

	</table>
	</fieldset>
	<input type="hidden" name="cldocno" id="cldocno" style="height:20px;width:70%;" value='<s:property value="cldocno"/>' >
    <input type="text" name="estimno" id="estimno" style="height:20px;width:70%;" value='<s:property value="estimno"/>' >
    <input type="text" name="gipnoo" id="gipnoo" style="height:20px;width:70%;" value='<s:property value="gipnoo"/>' >
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
   <div id="gipwindow">
   <div></div>
</div>
</div>

</body>
</html>
