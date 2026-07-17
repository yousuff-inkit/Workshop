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
	$("#date").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	$('#brandwindow').jqxWindow({ width: '40%', height: '55%',  maxHeight: '60%' ,maxWidth: '80%' , title: 'Brand Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	$('#brandwindow').jqxWindow('close');
	$('#modelwindow').jqxWindow({ width: '50%', height: '55%',  maxHeight: '60%' ,maxWidth: '80%' , title: 'Model Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	$('#modelwindow').jqxWindow('close');
	$('#yomwindow').jqxWindow({ width: '50%', height: '55%',  maxHeight: '60%' ,maxWidth: '80%' , title: 'YOM Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	$('#yomwindow').jqxWindow('close');
	$('#branchlabel,#branchdiv').hide();
	$('#brand').dblclick(function(){
		if(document.getElementById("rdoadd").checked==false && document.getElementById("rdoview").checked==false){
			$.messager.alert('warning','Please Select any valid Option');
			return false;
		}
		$('#brandwindow').jqxWindow('open');
		$('#brandwindow').jqxWindow('focus');
	 	brandSearchContent('brandSearch.jsp?id=1', $('#brandwindow'));
	});
	$('#model').dblclick(function(){
		if(document.getElementById("rdoadd").checked==false && document.getElementById("rdoview").checked==false){
			$.messager.alert('warning','Please Select any valid Option');
			return false;
		}
		if(document.getElementById("rdoadd").checked==true){
			if($('#brand').val()==''){
				$.messager.alert('warning','Please Select Brand');
				return false;
			}
		}
		$('#modelwindow').jqxWindow('open');
		$('#modelwindow').jqxWindow('focus');
	 	modelSearchContent('modelSearch.jsp?id=1&brand='+$('#hidbrand').val(), $('#modelwindow'));
	});
	$('#yom').dblclick(function(){
		if(document.getElementById("rdoadd").checked==false && document.getElementById("rdoview").checked==false){
			$.messager.alert('warning','Please Select any valid Option');
			return false;
		}
		if(document.getElementById("rdoadd").checked==true){
			if($('#model').val()==''){
				$.messager.alert('warning','Please Select Model');
				return false;
			}
		}
		$('#yomwindow').jqxWindow('open');
		$('#yomwindow').jqxWindow('focus');
	 	yomSearchContent('yomSearch.jsp?id=1', $('#yomwindow'));
	});
});

function getBrand(event){
	if(document.getElementById("rdoadd").checked==false && document.getElementById("rdoview").checked==false){
		$.messager.alert('warning','Please Select any valid Option');
		return false;
	}
	var x= event.keyCode;
	if(x==114){
		
		$('#brandwindow').jqxWindow('open');
		$('#brandwindow').jqxWindow('focus');
		brandSearchContent('brandSearch.jsp?id=1', $('#brandwindow'));
   }
   else{
   }
}

function getModel(event){
	if(document.getElementById("rdoadd").checked==false && document.getElementById("rdoview").checked==false){
		$.messager.alert('warning','Please Select any valid Option');
		return false;
	}
	if(document.getElementById("rdoadd").checked==true){
		if($('#brand').val()==''){
			$.messager.alert('warning','Please Select Brand');
			return false;
		}
	}
	var x= event.keyCode;
	if(x==114){
		$('#modelwindow').jqxWindow('open');
		$('#modelwindow').jqxWindow('focus');
		modelSearchContent('modelSearch.jsp?id=1&brand='+$('#hidbrand').val(), $('#modelwindow'));
   }
   else{
   }
}

function getYom(event){
	if(document.getElementById("rdoadd").checked==false && document.getElementById("rdoview").checked==false){
		$.messager.alert('warning','Please Select any valid Option');
		return false;
	}
	if(document.getElementById("rdoadd").checked==true){
		if($('#model').val()==''){
			$.messager.alert('warning','Please Select Model');
			return false;
		}
	}
	var x= event.keyCode;
	if(x==114){
		$('#yomwindow').jqxWindow('open');
		$('#yomwindow').jqxWindow('focus');
		yomSearchContent('yomSearch.jsp?id=1', $('#yomwindow'));
   }
   else{
   }
}

function brandSearchContent(url) {
	$.get(url).done(function (data) {
    	$('#brandwindow').jqxWindow('setContent', data);
	}); 
}

function modelSearchContent(url) {
	$.get(url).done(function (data) {
    	$('#modelwindow').jqxWindow('setContent', data);
	}); 
}

function yomSearchContent(url) {
	$.get(url).done(function (data) {
    	$('#yomwindow').jqxWindow('setContent', data);
	}); 
}
function funreload(event)
{
	if(document.getElementById("rdoadd").checked==false && document.getElementById("rdoview").checked==false){
		$.messager.alert('warning','Please Select any valid Option');
		return false;
	}
	if(document.getElementById("rdoadd").checked==true){
		if($('#brand').val()==''){
			$.messager.alert('warning','Brand is mandatory');
			return false;
		}
		if($('#model').val()==''){
			$.messager.alert('warning','Model is mandatory');
			return false;
		}
		if($('#yom').val()==''){
			$.messager.alert('warning','Yom is mandatory');
			return false;
		}
	}
	var branch=$('#cmbbranch').val();
	var brandid=$('#hidbrand').val();
	var modelid=$('#hidmodel').val();
	var brand=$('#brand').val();
	var model=$('#model').val();
	var yomid=$('#hidyom').val();
	var yom=$('#yom').val();
	var type="";
	if(document.getElementById("rdoadd").checked==true){
		type="Add";
	}
	else if(document.getElementById("rdoview").checked==true){
		type="View";
	}
	
	$('#residualvaluediv').load('residualValueGrid.jsp?id=1'+'&branch='+branch+'&type='+type+'&brand='+brand.replace(/ /g, "%20")+'&model='+model.replace(/ /g, "%20")+'&yom='+yom+'&brandid='+brandid+'&modelid='+modelid+'&yomid='+yomid);
}

function setValues(){

	if($('#msg').val()!=""){
		$.messager.alert('Message','<center>'+$('#msg').val()+'</center>');
	}
	
}

function funSaveChanges(){
	var rows=$('#residualValueGrid').jqxGrid('getrows');
	var z=0;
	for(var i=0;i<rows.length;i++){
		if(rows[i].residualvalue!="undefined" && rows[i].residualvalue!="" && typeof(rows[i].residualvalue)!="undefined" && typeof(rows[i].residualvalue)!="NaN"){
			newTextBox = $(document.createElement("input"))
	    		.attr("type", "dil")
	    		.attr("id", "test"+z)
	    		.attr("name", "test"+z)
	    		.attr("hidden","true");
				
				newTextBox.val(rows[i].brandid+"::"+rows[i].modelid+"::"+rows[i].yomid+"::"+rows[i].residualdocno+"::"+rows[i].months+"::"+rows[i].km+"::"+rows[i].residualvalue);
				newTextBox.appendTo('form');
				z++;
		}
	}
	document.getElementById("gridlength").value=z;
	
	document.getElementById("mode").value="Add";
	document.getElementById("frmResidualValueMaster").submit();
}
</script>
</head>
<body onload="getBranch();setValues();">
	<form id="frmResidualValueMaster" action="saveResidualValueMaster" method="post" autocomplete="off">
		<div id="mainBG" class="homeContent" data-type="background"> 
			<div class='hidden-scrollbar'>
				<table width="100%">
                    <tr>
                    <td width="20%">
                        <fieldset style="background: #ECF8E0;">
                        	<table width="100%">
                        			<tr><td colspan="2"><jsp:include page="../../heading.jsp"></jsp:include></td></tr>
                        			<tr>
                        			  <td colspan="2" align="center"><input type="radio" name="rdotype" id="rdoadd" value="Add"><label for="rdoadd" class="branch">Add</label>&nbsp;&nbsp;<input type="radio" name="rdotype" id="rdoview" value="View" ><label for="rdoview" class="branch">View</label>
                                      </td>
                      			  </tr>
				                    <tr><td width="32%" align="right"><label class="branch">Date</label></td><td width="68%" align="left"><div id="date" name="date"></div></td></tr>
				                    <tr>
				                      <td align="right"><label class="branch">Brand</label></td>
				                      <td align="left"><input type="text" name="brand" id="brand" readonly placeholder="Press F3 to Search" onKeyDown="getBrand(event);" style="height:18px;"></td>
                                      <input type="hidden" name="hidbrand" id="hidbrand">
		                      </tr>
				                    <tr>
				                      <td align="right"><label class="branch">Model</label></td>
				                      <td align="left"><input type="text" name="model" id="model" readonly placeholder="Press F3 to Search" onKeyDown="getModel(event);" style="height:18px;"></td>
                                      <input type="hidden" name="hidmodel" id="hidmodel">
		                      </tr>
				                    <tr>
				                      <td align="right"><label class="branch">YOM</label></td>
				                      <td align="left"><input type="text" name="yom" id="yom" readonly placeholder="Press F3 to Search" onKeyDown="getYom(event);" style="height:18px;"></td>
                                      <input type="hidden" name="hidyom" id="hidyom">
		                      </tr>
				                    <tr>
				                      <td align="right">&nbsp;</td>
				                      <td align="left">&nbsp;</td>
		                      </tr>
				                    <tr>
				                      <td align="center" colspan="2"><button type="button" class="myButton" id="btnsave" onclick="funSaveChanges();">Save Changes</button></td>
		                      </tr>
				              <tr>
				              		<td align="center" colspan="2">&nbsp;</td>
		                      </tr>
		                      <tr>
				              		<td align="center" colspan="2">&nbsp;</td>
		                      </tr>
		                      <tr>
				              		<td align="center" colspan="2">&nbsp;</td>
		                      </tr>
		                      <tr>
				              		<td align="center" colspan="2">&nbsp;</td>
		                      </tr>
		                      <tr>
				              		<td align="center" colspan="2">&nbsp;</td>
		                      </tr>
		                      <tr>
				              		<td align="center" colspan="2">&nbsp;</td>
		                      </tr>
		                      <tr>
				              		<td align="center" colspan="2">&nbsp;</td>
		                      </tr>
		                      <tr>
				              		<td align="center" colspan="2">&nbsp;</td>
		                      </tr>
		                      <tr>
				              		<td align="center" colspan="2">&nbsp;</td>
		                      </tr>
								</table>
							</fieldset>
					  </td>
						<td width="80%">
							<table width="100%">
								<tr>
			 						<td><div id="imgdiv" style="position:absolute; z-index: 1;top:200;right:600;display:none;">
										<img id="imgloading" alt="" src="../../../../icons/31load.gif"/></div> <div id="residualvaluediv"><jsp:include page="residualValueGrid.jsp"></jsp:include></div> </td>
			 
								</tr>
							</table>
                        </td>
					</tr>
				</table>
                <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
				<input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
                <input type="hidden" name="gridlength" id="gridlength" value='<s:property value="gridlength"/>'>
			</div>
		</div>
        <div id="brandwindow">
			<div></div>
		</div>
        <div id="modelwindow">
			<div></div>
		</div>
        <div id="yomwindow">
			<div></div>
		</div>        
	</form>
</body>
</html>