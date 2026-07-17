<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Package Master</title>
<jsp:include page="../../../includes.jsp"></jsp:include>
<style>
	.hidden-scrollbar {
	  /* // overflow: auto; */
	  	height: 530px;
	    overflow-x: hidden;
	 }
</style>

<script type="text/javascript">

$(document).ready(function() {

	$("#date").jqxDateTimeInput({  width:'125px',height : '15px', formatString : "dd.MM.yyyy",maxDate:new Date() });
	$("#fromdate,#todate").jqxDateTimeInput({  width:'125px',height : '15px', formatString : "dd.MM.yyyy",value:new Date() });
	$('#searchwindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	$('#searchwindow').jqxWindow('close');
	$('#partssearchwindow').jqxWindow({ width: '50%', height: '55%',  maxHeight: '55%' ,maxWidth: '50%' , title: 'Product Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	$('#partssearchwindow').jqxWindow('close');
	$('#laboursearchwindow').jqxWindow({ width: '50%', height: '55%',  maxHeight: '55%' ,maxWidth: '50%' , title: 'Service Type Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	$('#laboursearchwindow').jqxWindow('close');
	funInitData(); 
	$('#refno').dblclick(function(){

	    var reftype=document.getElementById("cmbreftype").value;
	    if(reftype=="GIP" || reftype=="EST"){
	    	SearchContent("refnoSearch.jsp?reftype="+reftype+"&branch="+$('#brchName').val());
	    }
	    else{
	    }
	});
	
	$('#searchproductid,#searchproductname').dblclick(function(){
		//$('ul[data-type="product"]').css('display','none');
		//$(this).closest('td').find('ul[data-type="product"]').css('display','block');
		$('#partssearchwindow').jqxWindow('open');
		$('#partssearchwindow').jqxWindow('focus');
		SearchContent('prodectnamesearch.jsp?partindex=0&mode=3', 'partssearchwindow');
	});
});

function getRefData(estdocno){
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText.trim().split("::");
			$('#cmbreftype').val("EST");
			$('#refno').val(items[0]);
            $('#hidrefno').val(items[1]);
            $('#regno').val(items[2]);
            $('#vehicledetails').val(items[3]);
            $('#userdetails').val(items[4]);
            $('#cldocno').val(items[5]);
            if($('#cmbreftype').val()=="EST"){
            	$('#sparediv').load('sparepartsGrid.jsp?docno='+$('#hidrefno').val()+'&id=1');
            	$('#labourdiv').load('labourcostGrid.jsp?docno='+$('#hidrefno').val()+'&id=1');
            	$('#labourcostGrid,#sparepartsGrid').jqxGrid({disabled:false});
            }
		}
		else{
			}
		}
	
	x.open("GET", "getRefData.jsp?estdocno="+estdocno, true);
	x.send();
}
 function SearchContent(url) {
 	$('#searchwindow').jqxWindow('open');
	$.get(url).done(function (data) {
	$('#searchwindow').jqxWindow('setContent', data);
	$('#searchwindow').jqxWindow('bringToFront');
}); 
}
	
function funReadOnly() {	
	$('#frmPackageMasterV2 input').attr('readonly',true);
	$('#frmPackageMasterV2 select').attr('disabled',true);
}
function funRemoveReadOnly() {
	$('#frmPackageMasterV2 input').attr('readonly',false);
	$('#frmPackageMasterV2 select').attr('disabled',false);
	if($('#mode').val()=='A'){
		$('#sparePartsNewGrid,#labourcostGrid').jqxGrid('clear');
		$('#sparePartsNewGrid,#labourcostGrid').jqxGrid({disabled:false});
		$("#sparePartsNewGrid,#labourcostGrid").jqxGrid("addrow", null, {});
		$('#date,#fromdate,#todate').jqxDateTimeInput('setDate',new Date());
		$('#amount').val(0);
		$('#jobtypeinputdiv').load('jobtypeinput.jsp?id=1');
	}
	else if($('#mode').val()=='E'){
		$('#sparePartsNewGrid,#labourcostGrid').jqxGrid({disabled:false});
		$("#sparePartsNewGrid,#labourcostGrid").jqxGrid("addrow", null, {});
		
	}
	
}
function setValues() {
	if($('#msg').val()!=""){
		   $.messager.alert('Message',$('#msg').val());
	 }
	if($('#docno').val()!=''){
		$('#sparediv').load('../../../com/workshop/packagemaster/sparePartsNewGrid.jsp?docno='+$('#docno').val()+'&id=1');
	}
	if($('#docno').val()!=''){
		$('#labourdiv').load('../../../com/workshop/packagemaster/labourcostGrid.jsp?docno='+$('#docno').val()+'&id=1');		
	}
}
function funNotify(){
	var docdateval=funDateInPeriod($('#date').jqxDateTimeInput('getDate'));
	if(docdateval==0){
		$('#date').jqxDateTimeInput('focus');
		return 0;
	}
	var labourrows = $("#labourcostGrid").jqxGrid('getrows');
	var labourgridlength=0;
	for(var i=0;i<labourrows.length;i++){
		if(labourrows[i].jobid!="" && labourrows[i].jobid!=null && labourrows[i].jobid!="undefined" && typeof(labourrows[i].jobid)!="undefined"){
			var j=labourgridlength;
			newTextBox = $(document.createElement("input"))
			.attr("type", "dil")
			.attr("id", "labourarray"+j)
			.attr("name", "labourarray"+j)
			.attr("hidden",true);
				
			newTextBox.val(labourrows[i].jobid+" :: "+labourrows[i].hrs+" :: "+labourrows[i].remarks+" :: "+labourrows[i].jobtype+" :: "+labourrows[i].jobdesc+" :: "+labourrows[i].seqno);
			
			newTextBox.appendTo('form');
			labourgridlength++;
		}
	}
	$('#labourlength').val(labourgridlength);
	var partrows = $("#sparePartsNewGrid").jqxGrid('getrows');
	var partgridlength=0;
	for(var i=0;i<partrows.length;i++){
		if(partrows[i].description!="" && partrows[i].description!=null && partrows[i].description!="undefined" && typeof(partrows[i].description)!="undefined"){
			var j=partgridlength;
			newTextBox = $(document.createElement("input"))
			.attr("type", "dil")
			.attr("id", "sparearray"+j)
			.attr("name", "sparearray"+j)
			.attr("hidden",true);
			newTextBox.val(partrows[i].description+" :: "+partrows[i].qty+" :: "+partrows[i].psrno+" :: "+partrows[i].seqno);
			//console.log(partrows[i].description+" :: "+partrows[i].qty+" :: "+partrows[i].psrno+" :: "+partrows[i].seqno);
			newTextBox.appendTo('form');
			partgridlength++ 
		}
	}
	$('#sparelength').val(partgridlength);
	
	
	return 1;
}

 function funFocus(){
	document.getElementById("packagename").focus();
} 

function getRefno(event){
    var x= event.keyCode;
    if(x==114){
    	var reftype=document.getElementById("cmbreftype").value;
	    if(reftype=="GIP" || reftype=="EST"){
	    	SearchContent("refnoSearch.jsp?reftype="+reftype+"&branch="+$('#brchName').val());
	    }
	    else{
	    }
    }
}
function SearchContent(url,id) {
    $.get(url).done(function (data) {
  		$('#'+id).jqxWindow('setContent', data);
	}); 
}
function funSearchLoad(){
	changeContent('masterSearch.jsp', $('#window'));
 }
 
function funPrintBtn(){
	 if($('#docno').val()!='' && $('#docno').val()!='0'){
		var url=document.URL;
		var reurl=url.split("com");
		/* var path= "com/dashboard/workshop/quotationapproval/printQuotationAproval.action?estDocno="+estdocno; */
		var path= "com/workshop/jobcard/printVoucherWindow.jsp?docno="+$('#docno').val();
		var win= window.open(reurl[0]+path,"_blank","top=250,left=310,Width=400,Height=200,location=no,scrollbars=no,toolbar=yes");		
		win.focus();		
	 }
}   
function funInitData(){
	$.get('getInitData.jsp',function(data){
		data=JSON.parse(data);
		var htmldata='<option value="">--Select--</option>';
		$.each(data.enginedata,function(index,value){
			htmldata+='<option value="'+value.docno+'">'+value.enginesize+'</option>';
		});
		$('#cmbenginesize,#msearchenginesize').html($.parseHTML(htmldata));
		if($('#hidcmbenginesize').val()!=''){
			$('#cmbenginesize').val($('#hidcmbenginesize').val());
		}
		/*$('#cmbbrand,#msearchbrand').html($.parseHTML(htmldata));
		if($('#hidcmbbrand').val()!=''){
			$('#cmbbrand').val($('#hidcmbbrand').val());
			getModel($('#cmbbrand').val());
		}*/
	});
}
function getModel(value){
	$.get('getModel.jsp',{'brdid':value},function(data){
		data=JSON.parse(data);
		var htmldata='<option value="">--Select--</option>';
		$.each(data.modeldata,function(index,value){
			htmldata+='<option value="'+value.docno+'">'+value.refname+'</option>';
		});
		$('#cmbmodel').html($.parseHTML(htmldata));
		if($('#hidcmbmodel').val()!=''){
			$('#cmbmodel').val($('#hidcmbmodel').val());
		}
	});
}
function getMSearchModel(value){
	$.get('getModel.jsp',{'brdid':value},function(data){
		data=JSON.parse(data);
		var htmldata='<option value="">--Select--</option>';
		$.each(data.modeldata,function(index,value){
			htmldata+='<option value="'+value.docno+'">'+value.refname+'</option>';
		});
		$('#msearchmodel').html($.parseHTML(htmldata));
	});
}
function isNumber(evt,id) {
	//Function to restrict characters and enter number only
  	var iKeyCode = (evt.which) ? evt.which : evt.keyCode
    if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57))
    {
    	$.messager.alert('Warning','Enter Numbers Only');
       	$("#"+id+"").focus();
        return false;
    }
    return true;
}

function funAddSpare(){
		if($('#mode').val()=='A' || $('#mode').val()=='E'){
			if($('#searchproductid').val()!=''){
				var labourrows=$('#sparePartsNewGrid').jqxGrid('getrows');
				var labourindex=(labourrows.length)-1;
				
		        $('#sparePartsNewGrid').jqxGrid('setcellvalue',labourindex,'description',$('#searchproductname').val());
		        $('#sparePartsNewGrid').jqxGrid('setcellvalue',labourindex,'psrno',$('#searchproductpsrno').val());
		        $('#sparePartsNewGrid').jqxGrid('setcellvalue',labourindex,'qty',$('#searchproductqty').val());
		        $('#sparePartsNewGrid').jqxGrid('setcellvalue',labourindex,'seqno',labourrows.length);
		        $("#sparePartsNewGrid").jqxGrid("addrow", null, {});
		        
				$('#searchproductid,#searchproductname,#searchproductqty').val('');
				$('#searchproductid').focus();
			}
		}
	}
</script>

</head>
<body onLoad="setValues();">
<div>
<form id="frmPackageMasterV2" action="savePackageMasterV2" autocomplete="off">
	<jsp:include page="../../../header.jsp" />
	<br>
	<div class='hidden-scrollbar'>
	
	<table width="100%" border="0" >
      <tr>
        <td width="13%" height="31" align="right">Date</td>
        <td width="14%"><div id="date" name="date" value='<s:property value="date"/>'></div></td>
        <td colspan="4">&nbsp;</td>
        <td width="6%" align="right">Doc No</td>
        <td width="14%"><input type="text" name="docno" id="docno" value='<s:property value="docno"/>'></td>
      </tr>
      <tr>
        <td align="right">Package Name</td>
        <td ><input type="text" name="packagename" id="packagename" style="width:95%;" value='<s:property value="packagename"/>'></td>
        <td width="6%" align="right">Valid From</td>
        <td width="12%"><div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div></td>
        <td width="6%" align="right">Valid To</td>
        <td><div id="todate" name="todate" value='<s:property value="todate"/>'></div></td>
      </tr>
      <tr>
        <%-- <td align="right">Brand</td>
        <td><select name="cmbbrand" id="cmbbrand" style="width:95%;" onchange="getModel(value);"><option value="">--Select--</option></select>
        	<input type="hidden" name="hidcmbbrand" id="hidcmbbrand" value='<s:property value="hidcmbbrand"/>'/>
        </td>
        <td align="right">Model</td>
        <td><select name="cmbmodel" id="cmbmodel" style="width:95%;"><option value="">--Select--</option></select>
        	<input type="hidden" name="hidcmbmodel" id="hidcmbmodel" value='<s:property value="hidcmbmodel"/>'/>
        </td> --%>
        <td align="right">Engine Size</td>
        <td><select name="cmbenginesize" id="cmbenginesize" style="width:95%;"><option value="">--Select--</option></select>
        	<input type="hidden" name="hidcmbenginesize" id="hidcmbenginesize" value='<s:property value="hidcmbenginesize"/>'/>
        </td>
        <td align="right">Amount</td>
        <td ><input type="text" name="amount" id="amount" value='<s:property value="amount"/>' onBlur="funRoundAmt(value,id);" style="text-align:right;" onKeyPress="javascript:return isNumber (event,id)"></td>
      	<td align="right">Max Usage</td>
      	<td><input type="text" name="maxusage" id="maxusage" value='<s:property value="maxusage"/>' style="text-align:right;" onKeyPress="javascript:return isNumber (event,id)"></td>
      </tr>
      <tr>
        <td align="right">Description</td>
        <td colspan="7"><input type="text" name="description" id="description" value='<s:property value="description"/>' style="width:95%;"></td>
      </tr>
    </table>
    
    <fieldset class="redClass">
		<legend>Services </legend>
	    	<table width="100%" border="0">
		  		<tr>
    				<td align="right">Job Type</td>
    				<td><div id="jobtypeinputdiv"><jsp:include page="jobtypeinput.jsp"></jsp:include></div></td>
    				<td align="right">Description</td>
    				<td width="20%"><input type="text" name="jobdescription" id="jobdescription" style="width:90%;">
    					<input type="hidden" name="jobhrs" id="jobhrs">
    				</td>
    				<td align="right">Qty/Hrs</td>
    				<td><input type="text" name="jobqty" id="jobqty" onKeyPress="javascript:return isNumber (event,id)"></td>
    				<td align="right">Remarks</td>
    				<td><input type="text" name="jobremarks" id="jobremarks" style="width:90%;"></td>
	    
    				<td><input type="button" id="btnaddjob" name="btnaddjob" value="Add" onclick="funAddJob();"></td>
    			</tr>
		  		<tr>
	   				<td colspan="10"><div id="labourdiv"><jsp:include page="labourcostGrid.jsp"></jsp:include></div></td>
	   	  		</tr>
			</table>
	</fieldset>
	<fieldset class="violetClass">
		<legend>Spares Details </legend>
	    	<table width="100%" border="0">
	    		<tr>
	    			<td align="right">Product Id</td>
			    	<td><input type="text" name="searchproductid" id="searchproductid" /> <!-- onkeydown="funFilterList(this);" -->
			    		<ul class="list-group" data-type="product" style="display:none;max-height:250px;overflow-y:auto;"></ul>
			    	</td>
			    	<td align="right">Product Name</td>
			    	<td><input type="text" name="searchproductname" id="searchproductname" />  <!-- onkeydown="funFilterList(this);" -->
			    		<ul class="list-group"  data-type="product" style="display:none;max-height:250px;overflow-y:auto;"></ul>
			    		<input type="hidden" name="searchproductpsrno" id="searchproductpsrno" />
			    		
			    	</td>
			    	<td align="right">Qty</td>
			    	<td><input type="text" name="searchproductqty" id="searchproductqty"/>
			    	</td>
			    	<td><input type="button" id="btnaddspare" name="btnaddspare" value="Add" onclick="funAddSpare();"></td>
	    		</tr>
		  		<tr>
	   				<td colspan="10"><div id="sparediv"><jsp:include page="sparePartsNewGrid.jsp"></jsp:include></div></td>
	   	  		</tr>
			</table>
	</fieldset>
	
			<input type="hidden" name="vocno" id="vocno" value='<s:property value="vocno"/>'>
      		<input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>
		    <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
      		<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
      		<input type="hidden" id="sparelength" name="sparelength"  value='<s:property value="sparelength"/>'/>
      		<input type="hidden" name="labourlength" id="labourlength" value='<s:property value="labourlength"/>'/>
			<input type="hidden" name="docdateconfig" id="docdateconfig" value='<s:property value="docdateconfig"/>'/>
		</div>
	</form>
	<div id="searchwindow">
		<div></div>
	</div>
	<div id="partssearchwindow">
   		<div><img id="loadingImage" src="../../../icons/31load.gif" style="position: absolute;vertical-align:middle;text-align:center;margin-right:50%;margin-left:60%;margin-top:25%;" /></div>
	</div>
	<div id="laboursearchwindow">
   		<div><img id="loadingImage" src="../../../icons/31load.gif" style="position: absolute;vertical-align:middle;text-align:center;margin-right:50%;margin-left:60%;margin-top:25%;" /></div>
	</div>
</div>
</body>
</html>