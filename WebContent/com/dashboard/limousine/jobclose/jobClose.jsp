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
<style>
input[type="text"] {
    height:20px !important;
}
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
	 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
	 $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200;right:600;'><img src='../../../../icons/31load.gif'/></div>");    
	 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $('#bookSearchWindow').jqxWindow({width: '50%', height: '55%',  maxHeight: '55%' ,maxWidth: '50%' , title: 'Booking Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 $('#bookSearchWindow').jqxWindow('close');
	 var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
	 var onemounth=new Date(new Date(fromdates).setMonth(fromdates.getMonth()-1)); 
     $('#fromdate').jqxDateTimeInput('setDate', new Date(onemounth));
	 funreadonly("1");
	 
	/*  $('#bookdocnowindow').jqxWindow({ width: '62%', height: '65%',  maxHeight: '85%' ,maxWidth: '80%' , title: 'Client Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	 $('#bookdocnowindow').jqxWindow('close');
	 
	 $('#bookdocno').dblclick(function(){
		$('#bookdocnowindow').jqxWindow('open');
		$('#bookdocnowindow').jqxWindow('focus');
		bookdocnoSearchContent('bookdocnoSearch.jsp', $('#bookdocnowindow'));
	}); */
	
	$('#btnbookadd').click(function(){
		var branch=$('#cmbbranch').val();
		var fromdate=$('#fromdate').jqxDateTimeInput('val');
		var todate=$('#todate').jqxDateTimeInput('val');
		$('#bookSearchWindow').jqxWindow('open');
		$('#bookSearchWindow').jqxWindow('focus');
		bookSearchContent('bookSearchMaster.jsp?branch='+branch+'&fromdate='+fromdate+'&todate='+todate);
	});
	
});

function bookSearchContent(url) {
	 $.get(url).done(function (data) {
		$('#bookSearchWindow').jqxWindow('setContent', data);

}); 
} 	

function funCalculate(){
	document.getElementById("tempjobdocno").value="";
	document.getElementById("tempbookdocno").value="";
	 var calcrows=$('#calculationGrid').jqxGrid('getrows');
	 for(var i=0;i<calcrows.length;i++){
		 funDetailCalculate(calcrows,i);	 
	 }
	 
	 
}
function funDetailCalculate(calcrows,i){
	
	var bookdocno=calcrows[i].bookdocno;
	var jobname=calcrows[i].jobname;
	var jobdocno=calcrows[i].jobdocno;
	var startdate=calcrows[i].startdate;
	var starttime=new Date(calcrows[i].starttime);
	starttime=(starttime.getHours()<10?'0'+starttime.getHours():starttime.getHours())+":"+(starttime.getMinutes()<10?'0':'') + starttime.getMinutes();
	var startkm=calcrows[i].startkm;
	var enddate=calcrows[i].enddate;
	var endtime=new Date(calcrows[i].endtime);
	endtime=(endtime.getHours()<10?'0'+endtime.getHours():endtime.getHours())+":"+(endtime.getMinutes()<10?'0':'') + endtime.getMinutes();
	var endkm=calcrows[i].endkm;
	var fuelchg=calcrows[i].fuelchg;
	var parkingchg=calcrows[i].parkingchg;
	var otherchg=calcrows[i].otherchg;
	var greetchg=calcrows[i].greetchg;
	var vipchg=calcrows[i].vipchg;
	var boquechg=calcrows[i].boquechg;
	var tarifdetaildocno=calcrows[i].tarifdetaildocno;
	var tarifdocno=calcrows[i].tarifdocno;
	
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText.trim();
			if(document.getElementById("tempbookdocno").value==""){
				document.getElementById("tempbookdocno").value=bookdocno;
			}
			else{
				document.getElementById("tempbookdocno").value+=","+bookdocno;
			}
			if(document.getElementById("tempjobdocno").value==""){
				document.getElementById("tempjobdocno").value=jobdocno;
			}
			else{
				document.getElementById("tempjobdocno").value+=","+jobdocno;
			}
			/* if(parseInt(calcrows.length)-1==parseInt(i)){ */
				$('#amountdiv').load('amountGrid2.jsp?jobdocno='+document.getElementById('tempjobdocno').value+'&bookdocno='+document.getElementById('tempbookdocno').value+'&id=1');
			/* }		
			 */
		} else {
		}
	}
	x.open("GET", "calculate2.jsp?tarifdocno="+tarifdocno+"&tarifdetaildocno="+tarifdetaildocno+"&bookdocno="+bookdocno+"&jobdocno="+jobdocno+"&jobname="+jobname+"&startdate="+startdate+"&starttime="+starttime+"&startkm="+startkm+"&enddate="+enddate+"&endtime="+endtime+"&endkm="+endkm+"&fuelchg="+fuelchg+"&parkingchg="+parkingchg+"&otherchg="+otherchg+"&greetchg="+greetchg+"&vipchg="+vipchg+"&boquechg="+boquechg, true);
	x.send();
}
function funreload(event)
{
	if($('#cmbbranch').val()=="" || $('#cmbbranch').val()=="a"){
		$.messager.alert('Message','<center>'+'Branch is Mandatory'+'</center>');
		document.getElementById("cmbbranch").focus();
		return false;
	}
	var fromdate=$('#fromdate').jqxDateTimeInput('val');
	var todate=$('#todate').jqxDateTimeInput('val');
	var bookdocno=$('#bookdocno').val();
	
$('#jobdiv').load('jobGrid.jsp?branch='+$('#cmbbranch').val()+'&fromdate='+fromdate+'&todate='+todate+'&bookdocno='+bookdocno+'&id=1');
}

function setValues(){

	 if($('#msg').val()!=""){
		 $.messager.alert('Message','<center>'+$('#msg').val()+'</center>');
	}
	 
}
function funreadonly(value){

}


function funClearData(){
	var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
	var onemounth=new Date(new Date(fromdates).setMonth(fromdates.getMonth()-1)); 
    $('#fromdate').jqxDateTimeInput('setDate', new Date(onemounth));
	document.getElementById("bookdocno").value="";
	document.getElementById("bookdocnodetails").value="";
}
function funUpdate(){
	var rows=$('#amountGrid').jqxGrid('getrows');
	if(rows.length==0){
		$.messager.alert('warning','Please enter valid data');
		return false;
	}
/* 	var status=0;
	var z=0;
   	for(var i=0;i<rows.length;i++){
		var jobname=rows[i].jobname;
		var jobstartdate=rows[i].startdate;
		var jobstarttime=rows[i].starttime;
		var jobstartkm=rows[i].startkm;
		var jobenddate=rows[i].enddate;
		var jobendtime=rows[i].endtime;
		var jobendkm=rows[i].endkm;
		if(jobname=="" || jobname=="undefined" || typeof(jobname)=="undefined" || jobname==null || jobstartdate=="" || jobstartdate=="undefined" || typeof(jobstartdate)=="undefined" || jobstartdate==null || jobstarttime=="" || jobstarttime=="undefined" || typeof(jobstarttime)=="undefined" || jobstarttime==null || jobstartkm=="" || jobstartkm=="undefined" || typeof(jobstartkm)=="undefined" || jobstartkm==null || jobenddate=="" || jobenddate=="undefined" || typeof(jobenddate)=="undefined" || jobenddate==null || jobendtime=="" || jobendtime=="undefined" || typeof(jobendtime)=="undefined" || jobendtime==null || jobendkm=="" || jobendkm=="undefined" || typeof(jobendkm)=="undefined" || jobendkm==null){
			$.messager.alert('warning','Please enter mandatory fields');
			status=1;
			break;
		}
		else{
			newTextBox = $(document.createElement("input"))
		    .attr("type", "dil")
		    .attr("id", "testclose"+z)
		    .attr("name", "testclose"+z)
		    .attr("hidden","true");
			newTextBox.val(rows[i].bookdocno+"::"+rows[i].jobdocno+"::"+rows[i].jobtype+"::"+rows[i].total);
			newTextBox.appendTo('form');
			z++;
		}
	}
   	if(status==1){
   		return false;
   	}
   	else{
   	 document.getElementById("mode").value='A';
   	 document.getElementById("gridlength").value=rows.length;
   	 $("#overlay, #PleaseWait").show();
   	 
   	 document.getElementById("frmLimoJobClose").submit();   		
   	 
   	}

   	 */
   	var z=0;
    for(var i=0;i<rows.length;i++){
		newTextBox = $(document.createElement("input"))
	    .attr("type", "dil")
	    .attr("id", "testclose"+z)
	    .attr("name", "testclose"+z)
	    .attr("hidden","true");
		newTextBox.val(rows[i].bookdocno+"::"+rows[i].jobdocno+"::"+rows[i].jobtype+"::"+rows[i].total);
		newTextBox.appendTo('form');
		z++;
    }
	 document.getElementById("mode").value='A';
   	 document.getElementById("gridlength").value=rows.length;
   	 $("#overlay, #PleaseWait").show();
   	 document.getElementById("frmLimoJobClose").submit();   
}
</script>
</head>
<body onload="getBranch();setValues();" style="font: 10px Tahoma;">
<form id="frmLimoJobClose" method="post" action="saveLimoJobClose">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%">
<tr>
<td width="20%" rowspan="4">
    <fieldset style="background: #ECF8E0;">
	<table width="100%">
	<jsp:include page="../../heading.jsp"></jsp:include>

 <tr>
 <td width="34%" align="right"><label class="branch">From Date</label></td>
 <td width="66%" colspan="2" ><div id="fromdate"></div></td>
 </tr>
 <tr>
   <td align="right"><label class="branch">To Date</label></td>
   <td><div id="todate"></div></td>
 	
 </tr>
 
 <tr>
   <td align="right"><span class="branch">Booking</span></td>
   <td><button type="button" name="btnbookadd" id="btnbookadd" class="myButtons">+</button>&nbsp;&nbsp;<button type="button" name="btnbookremove" id="btnbookremove" class="myButtons">-</button></td>

 </tr>
 <tr>
   <td colspan="2" align="right"><textarea id="bookdocnodetails" name="bookdocnodetails" style="width:100%;resize:none;height:150px;"></textarea></td>
 </tr>
 <tr>
   <td colspan="2" align="center"><button type="button" name="btnclear" id="btnclear" class="myButton" onclick="funClearData();">Clear</button>&nbsp;&nbsp;<button type="button" name="btnupdate" id="btnupdate" class="myButton" onclick="funUpdate();">Update</button></td>
 </tr>
 <tr>
   <td align="right">&nbsp;</td>
   <td>&nbsp;</td>
 </tr>
 <tr>
   <td colspan="2" align="center">&nbsp;</td>
   </tr>
    <tr>
   <td colspan="2" align="center">&nbsp;</td>
   </tr>
   <tr>
   <td colspan="2" align="center"><br><br><br><br><br><br><br></td>
   </tr>
	</table>
	</fieldset>
</td>
<td width="80%" height="116"><div id="jobdiv"><jsp:include page="jobGrid.jsp"></jsp:include></div></td></tr>
<tr>
  <td height="110"><div id="calcdiv"><jsp:include page="calculationGrid.jsp"></jsp:include></div></td>
</tr>
<tr>
  <td><div id="amountdiv"><jsp:include page="amountGrid2.jsp"></jsp:include></div></td>
</tr>
</table>
</div>
<input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
<input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
<input type="hidden" name="bookdocno" id="bookdocno">
<input type="text" name="tempbookdocno" id="tempbookdocno">
<input type="text" name="tempjobdocno" id="tempjobdocno">
<input type="hidden" name="gridlength" id="gridlength">
</div>
<div id="bookSearchWindow">
	<div></div><div></div>
</div>
</form>
</body>
</html>