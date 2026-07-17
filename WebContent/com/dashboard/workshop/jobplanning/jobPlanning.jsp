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
	    
	 $("#Uptodate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 
	 $('#bayWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Bay Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 $('#bayWindow').jqxWindow('close');
	 
	 $('#TechnicianWindow').jqxWindow({ width: '50%', height: '55%',  maxHeight: '55%' ,maxWidth: '50%' , title: 'Technician Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	 $('#TechnicianWindow').jqxWindow('close');
	 
	 $('#sparePartWindow').jqxWindow({ width: '50%', height: '55%',  maxHeight: '55%' ,maxWidth: '50%' , title: 'Spare Part Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	 $('#sparePartWindow').jqxWindow('close');
	 
	 $('#availWindow').jqxWindow({ width: '50%', height: '55%',  maxHeight: '55%' ,maxWidth: '50%' , title: 'Technician Availability' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	 $('#availWindow').jqxWindow('close');
	 
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
	    $("#jobPlanningGrid,#bayGrid,#serviceTeamGrid").jqxGrid('clear');
	   
	}
	
	
	function funreload(event)
	{	
		var date=$('#Uptodate').jqxDateTimeInput('val');
	    var jobcard=document.getElementById("jobcard").value;
	    var brhid=$('#cmbbranch').val();
	    $("#jobPlanningGrid,#bayGrid,#serviceTeamGrid").jqxGrid('clear');
	    $("#overlay, #PleaseWait").show();
	    $("#jobplanninggriddiv").load("jobPlanningGrid.jsp?uptodate="+date+"&id=1"+"&jobcard="+jobcard+"&brhid="+brhid); 
	}
	
	 function SearchContent(url,id) {
	 $('#'+id).jqxWindow('open');
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
	//JSONToCSVConvertor(jobexceldata, 'Job List', true);
	$("#jobPlanningGrid").excelexportjs({
		containerid: "jobPlanningGrid",
		datatype: 'json',
		dataset: null,
		gridId: "jobPlanningGrid",
		columns: getColumns("jobPlanningGrid"),
		worksheetName: "Job List"
	});
		
}

function funUpdateData(){
	if($('#jobdocno').val()==''){
		$.messager.alert('Warning','Please select a valid document');
		return false;
	}
	var bayrows=$('#bayGrid').jqxGrid('getselectedrowindexes');
	if(bayrows.length==0){
		$.messager.alert('Warning','Please select atleast 1 bay');
		return false;
	}
	for(var i=0;i<bayrows.length;i++){
		var seqno=$('#bayGrid').jqxGrid('getcellvalue',bayrows[i],'seqno');
		if(seqno=="" || seqno==null || seqno=="undefined" || typeof(seqno)=="undefined"){
			$.messager.alert('Warning','Please fill Seq No of selected bays');
			return false;
		}
		for(var j=0;j<bayrows.length;j++){
			var dupseqno=$('#bayGrid').jqxGrid('getcellvalue',bayrows[j],'seqno');
			if(i!=j && seqno==dupseqno){
				$.messager.alert('Warning','Duplicate Sequence number not allowed');
				return false;
			}
		}
	}
	
	 $.messager.confirm('Confirm', 'Do you want to Save Changes?', function(r){
    	if (r){ 
      		funUpdateDataAjax();
  		}
 	});
	
}
function funUpdateDataAjax(){
	var jobdocno=$('#jobdocno').val();
	var bayarray=new Array();
	var teamarray=new Array();
	var bayrows=$('#bayGrid').jqxGrid('getselectedrowindexes');
	var teamrows=$('#serviceTeamGrid').jqxGrid('getselectedrowindexes');
	for(var i=0;i<bayrows.length;i++){
		bayarray.push($('#bayGrid').jqxGrid('getcellvalue',bayrows[i],'doc_no')+"::"+$('#bayGrid').jqxGrid('getcellvalue',bayrows[i],'seqno'));
	}
	for(var i=0;i<teamrows.length;i++){
		teamarray.push($('#serviceTeamGrid').jqxGrid('getcellvalue',teamrows[i],'docno'));
	}
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200){
			var items=x.responseText;
			if(parseInt(items)=="0")  
			{	
				$.messager.alert('Message', '  Record Successfully Updated ');
				funreload("");
				
			}
			else
			{
				$.messager.alert('Message', '  Not Updated  ');
			}
		}
	}
	x.open("GET","updateData.jsp?jobdocno="+jobdocno+"&bayarray="+bayarray+"&teamarray="+teamarray+"&baylength="+bayrows.length+"&teamlength="+teamrows.length,true);	 		
	x.send();
} 

function funCheckAvail(){
	SearchContent('checkAvailGrid.jsp?id=1','availWindow');
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
	<input type="button" name="btnupdate" id="btnupdate" value="Save" class="myButtons" onclick="funUpdateData();"> &nbsp;
	</div>
    </td>
	</tr>
	<tr><td align="center" colspan="2"><input type="button" name="btncheckavail" id="btncheckavail" value="Check Availability" class="myButtons" onclick="funCheckAvail();"></td></tr>
	
<tr colspan="2"><td><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br></td></tr>
	
		
	</table>
	</fieldset>
</td>
<td width="80%">
	<fieldset>
	<legend>Job Details </legend>
	    <table width="100%" border="0">
		  <tr>
	   		<td colspan="2"><div id="jobplanninggriddiv"><jsp:include page="jobPlanningGrid.jsp"></jsp:include></div></td>
	   	  </tr>
	   	  <tr>
	   		<td width="50%">
	   			<fieldset class="redClass">
					<legend>Bay Details </legend>
					<div id="baygriddiv"><jsp:include page="bayGrid.jsp"></jsp:include></div>
				</fieldset>	
			</td>
			<td width="50%">
	   			<fieldset class="violetClass">
					<legend>Service Team Details </legend>
					<div id="serviceteamgriddiv"><jsp:include page="serviceTeamGrid.jsp"></jsp:include></div>
				</fieldset>	
			</td>
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
	<div id="availWindow">
		<div></div>
	</div>
	
</body>
</html>