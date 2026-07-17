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
<script type="text/javascript">

$(document).ready(function () {
	$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
	$("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200;right:600;'><img src='../../../../icons/31load.gif'/></div>");    
	$("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	$("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	$('#rdosummary').prop('checked',true);
	setType();
	$('#agmtwindow').jqxWindow({ width: '62%', height: '65%',  maxHeight: '85%' ,maxWidth: '80%' , title: 'Agreement Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   $('#agmtwindow').jqxWindow('close');
	   $('#agmtno').dblclick(function(){
		   $('#agmtwindow').jqxWindow('open');
	 		$('#agmtwindow').jqxWindow('focus');
	 		 agmtSearchContent('masterAgmtSearch.jsp', $('#agmtwindow'));
		});
	var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
    var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
    $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate); 
});
function getAgmtno(event){
	 var x= event.keyCode;
   if(x==114){
   	  $('#agmtwindow').jqxWindow('open');
 		$('#agmtwindow').jqxWindow('focus');
 		 agmtSearchContent('masterAgmtSearch.jsp', $('#agmtwindow'));
   }
   else{
    }
}
function agmtSearchContent(url) {
   //alert(url);
     $.get(url).done(function (data) {
//alert(data);
   $('#agmtwindow').jqxWindow('setContent', data);

}); 
}
function funreload(event)
{
	var fromdate=$('#fromdate').jqxDateTimeInput('val');
	var todate=$('#todate').jqxDateTimeInput('val');
	var branch=$('#cmbbranch').val();
	if(document.getElementById("rdosummary").checked==true){
		$('#summarydiv').load('leaseAgmtSummaryGrid.jsp?id=1&fromdate='+fromdate+'&todate='+todate+'&branch='+branch);
	}
	else if(document.getElementById("rdodetail").checked==true){
		if($('#hidagmtno').val()==''){
			$.messager.alert('warning','Please select an agreement');
			return false;
		}
		$('#detaildiv').load('leaseAgmtDetailGrid.jsp?id=1&agmtno='+$('#hidagmtno').val());
	}
}
function setValues(){
	
}
function setType(){
	if(document.getElementById("rdosummary").checked==true) {
		$('#detaildiv').hide();
		$('#summarydiv').show();
		$('#agmtdetails,#agmtno').attr('disabled',true);
	}
	else if(document.getElementById("rdodetail").checked==true){
		$('#summarydiv').hide();
		$('#detaildiv').show();
		$('#agmtdetails,#agmtno').attr('disabled',false);
	}
}

function funExportBtn(){
	var name="";
	if(document.getElementById("rdosummary").checked==true){
		name="Lease Agreement Detail Summary";
		
		JSONToCSVCon(summaryexceldata, name, true);
	}
	else if(document.getElementById("rdodetail").checked==true){
		name="Lease Agreement Detail Detail";
		
		JSONToCSVCon(detailexceldata, name, true);
	}
	/* if(parseInt(window.parent.chkexportdata.value)=="1")
 	{
 		
 	}
	else
 	{
		$("#assignListGrid").jqxGrid('exportdata', 'xls', name);
 	} */
}
</script>
</head>
<body onload="getBranch();setValues();">
	<form id="frmLeaseAgmtDetail" action="saveLeaseAgmtDetail" method="post">
		<div id="mainBG" class="homeContent" data-type="background"> 
			<div class='hidden-scrollbar'>
				<table width="100%">
					<tr>
						<td width="20%">
						    <fieldset style="background: #ECF8E0;">
								<table width="100%">
									<jsp:include page="../../heading.jsp"></jsp:include>
						 			<tr><td width="27%" align="right"><label class="branch">From date</label></td><td width="73%"><div id="fromdate"></div></td></tr>
                                    <tr><td  align="right"><label class="branch">To date</label></td><td><div id="todate"></div></td></tr>
									<tr><td colspan="2" align="center">
											<input type="radio" id="rdosummary" name="rdotype" onChange="setType();">
											<label for="rdosummary" class="branch">Summary</label>&nbsp;&nbsp;
											<input type="radio" id="rdodetail" name="rdotype"  onChange="setType();">
											<label class="branch" for="rdodetail">Detail</label>
										</td>
									</tr>
									<tr>
										<td align="right"><label class="branch">Agreement No</label></td>
										<td><input type="text" id="agmtno" name="agmtno" onkeydown="getAgmtno(event);" readonly="readonly" style="height:18px;"></td>
									</tr>
									<tr><td colspan="2"><textarea id="agmtdetails" readonly="readonly" rows="10" cols="30" style="resize:none;"></textarea>	</td></tr>
									<tr><td colspan="2" align="center"><button type"button" name="btnclear" id="btnclear" class="myButton">CLEAR</button></td></tr>
									<tr><td colspan="2"><br><br><br><br><br></td></tr>
								</table>
							</fieldset>
						</td>
						<td width="80%">
							<table width="100%">
								<tr>
									<td>
										<div id="summarydiv"><jsp:include page="leaseAgmtSummaryGrid.jsp"></jsp:include></div>
										<div id="detaildiv"><jsp:include page="leaseAgmtDetailGrid.jsp"></jsp:include></div>
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</div>
			<input type="hidden" name="hidagmtno" id="hidagmtno">
			<div id="agmtwindow">
				<div></div>
			</div>
		</div>
	</form>
</body>
</html>