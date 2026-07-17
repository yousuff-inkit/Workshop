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
 
select{
    height:15px;
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
	    var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
	    var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1)); 
	    $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate);
	    $('#clientname').dblclick(function(){
	  	    
		   $('#clientwindow').jqxWindow('open');
		       		clientSearchContent('clientsearch.jsp', $('#clientwindow')); 
	       });
});

	function funreload(event)
	{
		var clnt=$('#cldocno').val();
	    var fromdate=$('#fromdate').jqxDateTimeInput('val');
	    var todate=$('#todate').jqxDateTimeInput('val');
	    var brach=$('#cmbbranch').val();
	    $("#overlay, #PleaseWait").show();
	  
	    $("#estimationlistdiv").load("estimationlistGrid.jsp?brach="+brach+"&fromdate="+fromdate+"&tdt="+todate+"&cldocno="+clnt+"&check=1");
	}
	
	

	function setValues(){

		 if($('#msg').val()!=""){
   		   $.messager.alert('Message',$('#msg').val());
   		  }
	
	}
	
	function funExportBtn(){
		$("#estimationlistDiv").excelexportjs({
			containerid: "estimationlistDiv",
			datatype: 'json',
			dataset: null,
			gridId: "estimationlistGrid",
			columns: getColumns("estimationlistGrid") ,
			worksheetName:"Estimation List"
		}); 
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
		
	function funLoadData(){
		
		document.getElementById("clientname").value="";
	    var brach = document.getElementById("cmbbranch").value;
	    var fromdate= $("#fromdate").val();
		var todate= $("#todate").val();

	}

	function funClearData(){
		/* $('input[type=text],[type=hidden]').val('');
		$('select').find('option').prop("selected", false); */
		$('#fromdate').jqxDateTimeInput('setDate',new Date());
		$('#todate').jqxDateTimeInput('setDate',new Date());
		var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
	    var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
	    $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate); 
	 	document.getElementById("cmbbranch").value="";
		document.getElementById("clientname").value="";
		document.getElementById("cldocno").value="";
		
	
	}
function funPrintData(){

    	
	    var estdocno=$('#estvocno').val();
		if(estdocno=='' || estdocno=='0'){
   		 $.messager.alert('Warning','Select a Document');
		}

		else{
		
	    	var url=document.URL;
	    	// alert("url ="+url); 
	 		var reurl=url.split("com/");
	 		var docno=$('#estDocno').val();
			var gatedoc=$('#gipdocno').val();
			var addition=$('#addition').val();
			
			var path= "com/workshop/wsestimationpal/printEstimation1.action?estDocno="+estdocno+"&docno="+docno+"&gatedocno="+gatedoc+"&branch="+$('#brhid').val()+"&addition="+addition+"&withvat="+0;     
	         var win= window.open(reurl[0]+path,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");		
	         win.focus();		
		 }
    	
}
	
	</script>
	
</head>
<body onload="setValues();getBranch();">
<form id="frmestimationlist" method="post">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%">
<tr>
<td width="23%" align="center">
    <fieldset style="background: #ECF8E0;">
	<table width="100%" >
	<jsp:include page="../../heading.jsp"></jsp:include>

 <tr>
   <td width="37%" align="right"><label class="branch">From Date</label></td><td width="63%"><div id="fromdate"></div></td></tr>
 <tr>
   <td align="right"><label class="branch">To Date</label></td>
   <td><div id="todate"></div></td>
 </tr>
 <tr><td align="right"><label class="branch">Client</label></td><td align="left"><input type="text" name="clientname" id="clientname" placeholder="Press F3 To Search" readonly="readonly" onKeyDown="getclinfo(event);" onclick="this.placeholder='' "  style="height:20px;width:90%;" value='<s:property value="clientname"/>'></td>
  <td><input type="hidden" name="cldocno" id="cldocno" style="height:20px;width:70%;" value='<s:property value="cldocno"/>' ></td>
 </tr>
<tr>
	
   <td width="37%" align="right"><label class="branch">Addition</label></td>            
         <td ><select id="addition" name="addition" style="width:75%;height:20px;" value='<s:property value="addition"/>'>   
      <option value="0">0</option><option value="1">1</option><option value="2">2</option><option value="3">3</option><option value="4">4</option><option value="5">5</option></select>
  </tr>
 <tr >
	<td colspan="2" style="border-top:2px solid #DCDDDE;">
	<div style="text-align:center;">
	<input type="button" name="btnclear" id="btnclear" value="Clear" class="myButtons" onclick="funClearData();"> &nbsp;&nbsp;
	<input type="button" name="btnrepprint" id="btnrepprint" value="Print" class="myButtons" onclick="funPrintData();"> 
	</div>
    </td>
	</tr>
<tr ><td colspan="2"><!-- <textarea id="agmtdetails" name="agmtdetails" readonly style="resize:none;" rows="10" cols="35"></textarea> -->
	<br><br><br><br><br><br><br><br>
    <br><br><br><br><br><br><br>
    </td></tr>

<tr colspan="2"><td>&nbsp;</td></tr>
	
		
	</table>
	</fieldset>
</td>
<td>
	<table width="100%" >
		
			 <td><div id="estimationlistdiv"><jsp:include page="estimationlistGrid.jsp"></jsp:include></div></td>
	<tr>	<td>	 <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
			  <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
			  <input type="hidden" name="brhid" id="brhid" value='<s:property value="brhid"/>'>
			  <input type="hidden" name="gipnos" id="gipnos" value='<s:property value="gipnos"/>'>
			  <input type="hidden" name="estvocno" id="estvocno" value='<s:property value="estvocno"/>'>
			  <input type="hidden" name="gipdocno" id="gipdocno" value='<s:property value="gipdocno"/>'>
			 <input type="hidden" name="estDocno" id="estDocno" value='<s:property value="estDocno"/>'></td>
		
		</tr>
	</table>
</tr>
</table>
</div>
<div id="clientwindow">
   <div></div>
</div>
<div id="agmtnowindow">
<div></div>
</div>
</div>
</form>
</body>
</html>