<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
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
		document.getElementById("branchlabel").style.display="none";
		document.getElementById("branchdiv").style.display="none";
		  
		$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200px;right:750px;'><img src='../../../../icons/31load.gif'/></div>");
	    
	 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
	 var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
	 $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate);
	 $('#btndownload').click(function(){
	 	$('#overlay,#PleaseWait').show();
	 	var gatedocno=$('#gatedocno').val();
		if(gatedocno==''){
			return false;
		}
		var assessmentno=$('#assessmentno').val();
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				items = x.responseText;
				items=items.trim();
				//alert(items);
				if(parseInt(items)>0){
				$('#overlay,#PleaseWait').hide();
					$('#assessmentrepairdiv').load('assessmentRepairGrid.jsp?gatedocno='+$('#gatedocno').val()+'&id=1');
					$('#assessmentsparediv').load('assessmentSpareGrid.jsp?gatedocno='+$('#gatedocno').val()+'&id=1');
				}
				else{
					$('#overlay,#PleaseWait').hide();
					$.messager.alert('Warning','Download Not Completed');
					return false;
				}
				} else {
			}
		}
		x.open("GET", "getXMLData.jsp?gatedocno="+gatedocno+"&assessmentno="+assessmentno, true);
		x.send();
		
	});
	
	
	$('#btncreateest').click(function(){
		$('#overlay,#PleaseWait').show();
	 	var gatedocno=$('#gatedocno').val();
		if(gatedocno==''){
			return false;
		}
		var labourrows=$('#assessmentRepairGrid').jqxGrid('getrows');
		var labourarray=new Array();
		$('#labourarraylength').val(labourrows.length);
		for(var i=0;i<labourrows.length;i++){
			newTextBox = $(document.createElement("input"))
		    .attr("type", "dil")
		    .attr("id", "labourarray"+i)
		    .attr("name", "labourarray"+i)
		    .attr("hidden","true");
			
			newTextBox.val(labourrows[i].jobid+" :: "+labourrows[i].hrs+" :: "+labourrows[i].rate+" :: "+labourrows[i].markuppercent+" :: "+labourrows[i].total+" :: "+labourrows[i].remarks+" :: "+labourrows[i].chkexcess);
			newTextBox.appendTo('form');
		}
		
		var partrows = $("#sparePartsNewGrid").jqxGrid('getrows');
		$('#partarraylength').val(partrows.length);
		var partarray=new Array();
		for(var i=0;i<partrows.length;i++){
			newTextBox = $(document.createElement("input"))
		    .attr("type", "dil")
		    .attr("id", "partarray"+i)
		    .attr("name", "partarray"+i)
		    .attr("hidden","true");
			
			newTextBox.val(partrows[i].description+" :: "+partrows[i].qty+" :: "+partrows[i].genuinerate+" :: "+partrows[i].marketrate+" :: "+partrows[i].usedrate+" :: "+partrows[i].genuinetotal+" :: "+partrows[i].markettotal+" :: "+partrows[i].usedtotal+" :: "+partrows[i].approval+" :: "+partrows[i].approvedvalue+" :: "+partrows[i].chkexcess);
			newTextBox.appendTo('form');
		}
		 document.getElementById("mode").value='A';
		 $("#overlay, #PleaseWait").show();
		 document.getElementById("frmAudatex").submit();

	});
});


function funreload(event)
{
	
    var fromdate=$('#fromdate').jqxDateTimeInput('val');
    var todate=$('#todate').jqxDateTimeInput('val');

    $("#overlay, #PleaseWait").show();
   	$("#assessmentdiv").load("assessmentGrid.jsp?fromdate="+fromdate+"&todate="+todate+"&id=1");
   	
}
	
	

	function setValues(){

		 if($('#msg').val()!=""){
   		   $.messager.alert('Message',$('#msg').val());
   		  }
		$('#mode').val('view');
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
	
	function funAttachData(){
		var dtype="ADT";
		var formname="Audatex Assessment";
		var brhid='<%=session.getAttribute("BRANCHID").toString()%>';
		if($('#gatedocno').val()=="" || $('#assessmentno').val()==""){
			$.messager.alert("Warning","Please update document");
			return false;
		}
		var  myWindow= window.open("<%=contextPath%>/com/common/Attachmaster.jsp?formCode="+dtype+"&docno="+document.getElementById("docno").value+"&brchid="+brhid+"&frmname="+formname,"_blank","top=180,left=310,Width=800,Height=430,location=no,scrollbars=no,toolbar=no,resizable=no,meanubar=no,titlebar=no");
		myWindow.focus();
		
	}
	
	<%--  function funAttachData(){
		
		if($("#txtdocno").val()!="")
		{
			var fcode="PPC";
			var fname="Prospective Assignment";
			 var  myWindow= window.open("<%=contextPath%>/com/common/Attachmaster.jsp?formCode="+fcode+"&docno="+document.getElementById("txtdocno").value+"&brchid="+document.getElementById("txtbranch").value+"&frmname="+fname,"_blank","top=180,left=310,Width=800,Height=430,location=no,scrollbars=no,toolbar=no,resizable=no,meanubar=no,titlebar=no");
			 myWindow.focus();
		}
		else {
				$.messager.alert('Message','Select a Document....!','warning');
				return;
			}
	
	}
	 --%> 
	function funUpdateData(){
		if($('#gatedocno').val()==""){
			$.messager.alert("Warning","Please Select a document");
			return false;
		}
		if($('#assessmentno').val()==""){
			$.messager.alert("Warning","Please Select a document");
			return false;
		}
		var gatedocno=$('#gatedocno').val();
		var assessmentno=$('#assessmentno').val();
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				items = x.responseText;
				items=items.trim();
				if(parseInt(items)==0){
				$('#overlay,#PleaseWait').hide();
					$.messager.alert('Warning','Successfully Updated');
					$('#processstatus').val('1');
				}
				else{
					$('#overlay,#PleaseWait').hide();
					$.messager.alert('Warning','Not Updated');
					return false;
				}
				} else {
			}
		}
		x.open("GET", "updateAssessment.jsp?gatedocno="+gatedocno+"&assessmentno="+assessmentno, true);
		x.send();
	}
	</script>
	
</head>
<body onload="setValues();getBranch();">
<form id="frmAudatex" method="post" action="saveAudatex" method="post">
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
   <td align="right"><label class="branch">Assessment No</label></td>
   <td><input type="text" name="assessmentno" id="assessmentno" ></td>
 </tr>
 <tr >
	<td colspan="2" style="border-top:2px solid #DCDDDE;">
	<div style="text-align:center;">
	<input type="button" name="btnupdate" id="btnupdate" value="Update" class="myButtons" onclick="funUpdateData();">
	<input type="button" name="btnattach" id="btnattach" value="Attach" class="myButtons" onclick="funAttachData();">
	<input type="button" name="btndownload" id="btndownload" value="Download" class="myButtons" onclick="funDownloadData();">
	<input type="button" name="btnclear" id="btnclear" value="Clear" class="myButtons" onclick="funClearData();">
	<input type="button" name="btncreateest" id="btncreateest" value="Create Est." class="myButtons" ><!-- &nbsp;&nbsp;
	<input type="button" name="btnrepprint" id="btnrepprint" value="Print" class="myButtons" onclick="funPrintData();"> -->
	</div>
    </td>
	</tr>
<tr ><td colspan="2"><!-- <textarea id="agmtdetails" name="agmtdetails" readonly style="resize:none;" rows="10" cols="35"></textarea> -->
	<br><br><br><br><br><br><br><br>
<br><br><br><br><br><br>
</td></tr>

<tr colspan="2"><td>&nbsp;</td></tr>
	
		
	</table>
	</fieldset>
</td>
<td width="77%">
	<table width="100%">
		<tr>
			 <td><div id="assessmentdiv"><jsp:include page="assessmentGrid.jsp"></jsp:include></div>
			 	<div id="assessmentrepairdiv"><jsp:include page="assessmentRepairGrid.jsp"></jsp:include></div>
			 	<div id="assessmentsparediv"><jsp:include page="assessmentSpareGrid.jsp"></jsp:include></div>
			 </td>
			 <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
			 <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
			 <input type="hidden" name="gatedocno" id="gatedocno" value='<s:property value="gatedocno"/>'>
			 <input type="hidden" name="processstatus" id="processstatus" value='<s:property value="processstatus"/>'>
			 <input type="hidden" name="brchid" id="brchid" value='<s:property value="brchid"/>'>
			 <input type="hidden" name="docno" id="docno" value='<s:property value="docno"/>'>
			 <input type="hidden" name="formdetailcode" id="formdetailcode" value='<s:property value="formdetailcode"/>'>
			 <input type="hidden" name="genuinetotal" id="genuinetotal" value='<s:property value="genuinetotal"/>'/>
      		 <input type="hidden" name="markettotal" id="markettotal" value='<s:property value="markettotal"/>'/>
      		 <input type="hidden" name="usedtotal" id="usedtotal" value='<s:property value="usedtotal"/>'/>
      		 <input type="hidden" name="approvedtotal" id="approvedtotal" value='<s:property value="approvedtotal"/>'/>
      		 <input type="hidden" name="labourarraylength" id="labourarraylength" value='<s:property value="labourarraylength"/>'/>
      		 <input type="hidden" name="partarraylength" id="partarraylength" value='<s:property value="partarraylength"/>'/>
		</tr>
	</table>
</tr>
</table>
</div>
</div>
</form>
</body>
</html>