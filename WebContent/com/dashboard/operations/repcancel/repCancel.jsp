<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
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
  background-color: #31b0d5;
}
</style>

<script type="text/javascript">

	$(document).ready(function () {
		$('#btneditrep').hide();
		$("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 $("#canceldate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null});
		 $("#canceltime").jqxDateTimeInput({width: '25%', height: '17px', formatString: 'HH:mm', showCalendarButton: false ,value:null});
		 $("#outdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null});
		 $("#outtime").jqxDateTimeInput({width: '80%', height: '17px', formatString: 'HH:mm', showCalendarButton: false ,value:null});
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
		 var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	});
		function funreload(event){
			var branch=document.getElementById("cmbbranch").value;
			var fromdate=$('#fromdate').jqxDateTimeInput('val');
			var todate=$('#todate').jqxDateTimeInput('val');
			var agmttype=document.getElementById("cmbagmttype").value;
			var agmtno=document.getElementById("txtagmtno").value;
			var fleetno=document.getElementById("txtfleetno").value;
			$("#overlay, #PleaseWait").show();
			$('#replacediv').load('repCancelGrid.jsp?branch='+branch+'&fromdate='+fromdate+'&todate='+todate+'&agmttype='+agmttype+'&agmtno='+agmtno+'&fleetno='+fleetno+'&mode=1&branch='+branch);
		}
	
	function funOpenRep(){
		var docno=document.getElementById("temprepno").value;
		var url=document.URL;
		  var reurl=url.split("com");
		  window.parent.formName.value="Replacement";
		  window.parent.formCode.value="RPL";
		  var detName= "Replacement";
		  var path= "com/operations/vehicletransactions/replacement/saveReplacement.action?mode=view&docno="+docno;
		  top.addTab( detName,reurl[0]+""+path);
	}
	
	function funCancelRep(){
		if(document.getElementById("cmbbranch").value==""){
			$.messager.alert('warning','Branch is Mandatory');
		}
		var canceldate=$('#canceldate').jqxDateTimeInput('getDate');
		var canceltime=$('#canceltime').jqxDateTimeInput('getDate');
		var cancelkm=document.getElementById("cancelkm").value;
		var cancelfuel=document.getElementById("cmbcancelfuel").value;
		var cancelbranch=document.getElementById("cmbcancelbranch").value;
		var cancelloc=document.getElementById("cmbcancelloc").value;
		var fleetno=document.getElementById("txtfleetno").value;
		if(canceldate==null){
			$.messager.alert('warning','Cancel Date is Mandatory');
			return false;
		}
		if(canceltime==null){
			$.messager.alert('warning','Cancel Time is Mandatory');
			return false;
		}
		canceldate=new Date($('#canceldate').jqxDateTimeInput('getDate'));
		canceltime=new Date($('#canceltime').jqxDateTimeInput('getDate'));
		canceldate.setHours(0,0,0,0);
		 	var repno=document.getElementById("temprepno").value;
			var outdate=new Date($('#outdate').jqxDateTimeInput('getDate'));
			var outtime=new Date($('#outtime').jqxDateTimeInput('getDate'));
			var outkm=document.getElementById("outkm").value;
			var outfuel=document.getElementById("outfuel").value;
			var outbranch=document.getElementById("outbrch").value;
			var outlocation=document.getElementById("outloc").value;
		outdate.setHours(0,0,0,0);
		if(repno=="" || repno==null || typeof(repno)=="undefined"){
			$.messager.alert('warning','Please Select a valid Replacement');
			return false;
			
		}
		
		if(canceldate<outdate){
			$.messager.alert('warning','Cancel Date cannnot be less than Out Date');
			return false;
		}
		
		if(canceldate-outdate==0){
			if(canceltime.getHours()<outtime.getHours()){
				$.messager.alert('warning','Cancel Time cannot be less than Out Time');
				return false;
			}
			else if(canceltime.getHours()==outtime.getHours()){
				if(canceltime.getMinutes()<outtime.getMinutes()){
					$.messager.alert('warning','Cancel Time cannot be less than Out Time');
					return false;
				}
			}
		}
		
		if(cancelkm=="" || cancelkm==null || cancelkm=="undefined"){
			$.messager.alert('warning','Cancel Km is Mandatory');
			return false;
		}
		
		if(cancelfuel==""){
			$.messager.alert('warning','Cancel Fuel is Mandatory');
			return false;
			
		}
		if(cancelbranch==""){
			$.messager.alert('warning','Cancel Branch is Mandatory');
			return false;
		}
		if(cancelloc==""){
			$.messager.alert('warning','Cancel Fuel is Mandatory');
			return false;
		}
		if(cancelkm<outkm){
			$.messager.alert('warning','Cancel KM cannot be less than Out KM');
		}
		$("#overlay, #PleaseWait").show(); 
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
				{
		       var items= x.responseText.trim();
		       if(parseInt(items)>0){
					$("#overlay, #PleaseWait").hide(); 
					$.messager.alert('Message','Successfully Saved');
					funClearData();
					funreload("");
		       }
				else{
					$("#overlay, #PleaseWait").hide(); 
					$.messager.alert('Message','Not Saved');
				}
				}
			else{
				
			}
			}
		x.open("GET","saveData.jsp?cancelbranch="+cancelbranch+"&cancelloc="+cancelloc+"&canceldate="+$('#canceldate').jqxDateTimeInput('val')+"&canceltime="+$('#canceltime').jqxDateTimeInput('val')+"&cancelkm="+cancelkm+"&cancelfuel="+cancelfuel+"&repno="+repno+"&fleet_no="+fleetno,true);
		x.send();
	}
	
	
	function getLocation(value)
	{
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
	        items= x.responseText.trim();
	        items=items.split("***");
	        var locItems = items[0].split(",");
			var locIdItems = items[1].split(",");
			var optionsloc = '<option value="">--Select--</option>';
			for (var i = 0; i < locItems.length; i++) {
				optionsloc += '<option value="' + locIdItems[i] + '">'
						+ locItems[i] + '</option>';
			}
			$("select#cmbcancelloc").html(optionsloc);
			
	        }
		else
			{
			}
	}
	x.open("GET","getLocation.jsp?branch="+value,true);
	x.send();
}

	function getBrch()
	{
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
			items= x.responseText.trim();
	        items=items.split("***");
	        var BrchItems = items[0].split(",");
			var BrchIdItems = items[1].split(",");
			var optionsBrch = '<option value="">--Select--</option>';
			for (var i = 0; i < BrchItems.length; i++) {
				optionsBrch += '<option value="' + BrchIdItems[i] + '">' + BrchItems[i] + '</option>';
				}
			$("select#cmbcancelbranch").html(optionsBrch);
			
	        }
		else
			{
			}
	}
	x.open("GET","getBrch.jsp",true);
	x.send();
}
	function setValues(){
		getBrch();
		if(document.getElementById("cmbcancelbranch").value!=""){
			getLocation(document.getElementById("cmbcancelbranch").value);	
		}
		
	}
	
	function funClearData(){
		 var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	     document.getElementById("cmbagmttype").value="";
	     document.getElementById("txtagmtno").value="";
	     document.getElementById("txtagmtvocno").value="";
	     document.getElementById("txtfleetno").value="";
	     $('#canceldate').jqxDateTimeInput('setDate',null);
	     $('#canceltime').jqxDateTimeInput('setDate',null);
	     document.getElementById("cancelkm").value="";
	     document.getElementById("cmbcancelfuel").value="";
	     document.getElementById("cmbcancelbranch").value="";
	     document.getElementById("cmbcancelloc").value="";
	}
	
	
	function setMode(){
		if(document.getElementById("rdoedit").checked==true){
			/* document.getElementById("btncancelrep").style.display="none";
			document.getElementById("btneditrep").style.display="block"; */
			$('#btncancelrep').hide();
			$('#btneditrep').show();
			document.getElementById("cmbcancelbranch").disabled=true;
		    document.getElementById("cmbcancelloc").disabled=true;
			
		}
		else if(document.getElementById("rdocancel").checked==true){
			/* document.getElementById("btneditrep").style.display="none";
			document.getElementById("btncancelrep").style.display="block"; */
			$('#btneditrep').hide();
			$('#btncancelrep').show();
			document.getElementById("cmbcancelbranch").disabled=false;
		    document.getElementById("cmbcancelloc").disabled=false;
			
		}
	}
	
	function funEditRep(){
		$("#overlay, #PleaseWait").show(); 
	    var cancelkm=document.getElementById("cancelkm").value;
		var cancelfuel=document.getElementById("cmbcancelfuel").value;
		var fleetno=document.getElementById("txtfleetno").value;
		var repno=document.getElementById("temprepno").value;
	    var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
				{
				$("#overlay, #PleaseWait").hide(); 
				 items=x.responseText.trim();
		    		if(items==-1){
		    			$.messager.alert('warning','Not Updated');
		    		}
		    		else if(items==1){
		    			$.messager.alert('warning','Date cannot be less than last vehicle date');
		    		}
		    		else if(items==2){
		    			$.messager.alert('warning','Time cannot be less than last vehicle time');
		    		}
		    		else if(items==3){
		    			$.messager.alert('warning','KM cannot be less than last vehicle Km');
		    		}
		    		else if(items==5){
		    			$.messager.alert('warning','Updated Successfully');
		    			funClearData();
						funreload("");
		    			
		    		}
		    		else{
		    			$.messager.alert('warning','Not Updated');
		    		}
				}
			
			else
				{
				}
			}
		x.open("GET","editRep.jsp?canceldate="+$('#canceldate').jqxDateTimeInput('val')+"&canceltime="+$('#canceltime').jqxDateTimeInput('val')+"&cancelkm="+cancelkm+"&cancelfuel="+cancelfuel+"&repno="+repno+"&fleet_no="+fleetno,true);
		x.send();
	}
	
	function funExportBtn(){
		 if(parseInt(window.parent.chkexportdata.value)=="1") {
		  	JSONToCSVCon(data, 'Cancel Replacements', true);
		 } else {
			 $("#repCancelGrid").jqxGrid('exportdata', 'xls', 'Cancel Replacements');
		 }
	 }
</script>

</head>
<body onload="getBranch();setValues();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%"  >
	<jsp:include page="../../heading.jsp"></jsp:include>
	
    <tr>
	 <td width="35%" align="right"><label class="branch">From</label></td>
     <td width="65%" align="left"><div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div></td></tr> 
	<tr>
	<td align="right"><label class="branch">To</label></td>
    <td align="left"><div id="todate" name="todate" value='<s:property value="todate"/>'></div></td>
	</tr>
	<tr>
	<td align="center" colspan="2">
	<input type="radio" name="rdomode" id="rdocancel" checked onchange="setMode();"><label class="branch" for="rdocancel">Cancel</label>&nbsp;&nbsp;&nbsp;
	<input type="radio" name="rdomode" id="rdoedit" onchange="setMode();"><label class="branch" for="rdoedit">Edit</label>
	</td>
	</tr>
	<tr>
		<td align="right"><label class="branch">Agmt Type</label></td>
		<td align="left"><select name="cmbagmttype" id="cmbagmttype" style="width:65%;"><option value="">--Select--</option><option value="RAG">Rental</option><option value="LAG">Lease</option></select></td>
	</tr>
	<tr>
		<td align="right"><label class="branch">Agmt No</label></td>
		<td align="left"><input type="hidden" name="txtagmtno" id="txtagmtno" placeholder="Press F3 to Search" readonly style="height:16px;">
		<input type="text" name="txtagmtvocno" id="txtagmtvocno" placeholder="Press F3 to Search" readonly style="height:16px;">
		</td>
	</tr>
	<tr>
		<td align="right"><label class="branch">Fleet No</label></td>
		<td align="left"><input type="text" name="txtfleetno" id="txtfleetno" placeholder="Press F3 to Search" readonly style="height:16px;"></td>
	</tr>
	<tr>
		<td colspan="2"><fieldset>
		<table width="243">
		<tr>
			<td width="53" align="right">
				<label class="branch">Date</label>
			</td>
			<td width="178" align="left">
				<div id="canceldate" name="canceldate"></div>
			</td>
		</tr>
		<tr>
			<td align="right">
				<label class="branch">Time</label>
			</td>
			<td align="left">
				<div id="canceltime" name="canceltime"></div>
			</td>
		</tr>
		<tr>
			<td align="right">
				<label class="branch">KM</label>
			</td>
			<td align="left">
				<input type="text" name="cancelkm" id="cancelkm" style="height:16px;">
			</td>
		</tr>
		<tr>
			<td align="right">
				<label class="branch">Fuel</label>
			</td>
			<td align="left">
				<select name="cmbcancelfuel" id="cmbcancelfuel"  style="width:70%;">
					<option value="">-Select-</option>
					<option value=0.000>Level 0/8</option>
					<option value=0.125>Level 1/8</option>
					<option value=0.250>Level 2/8</option>
					<option value=0.375>Level 3/8</option>
					<option value=0.500>Level 4/8</option>
    				<option value=0.625>Level 5/8</option>
    				<option value=0.750>Level 6/8</option>
    				<option value=0.875>Level 7/8</option>
    				<option value=1.000>Level 8/8</option>
    			</select>
			</td>
		</tr>
		<tr>
			<td align="right">
				<label class="branch">Branch</label>
			</td>
			<td align="left">
				<select name="cmbcancelbranch" id="cmbcancelbranch" onchange="getLocation(this.value);"  style="width:70%;"><option value="">--Select--</option></select>
			</td>
		</tr>
		<tr>
			<td align="right">
				<label class="branch">Location</label>
			</td>
			<td align="left">
				<select name="cmbcancelloc" id="cmbcancelloc"  style="width:70%;"><option value="">--Select--</option></select>
			</td>
		</tr>
		</table>
		</fieldset></td>
	</tr>
	<tr>
		<td colspan="2" align="center">
			<button type="button" name="btncancelrep" id="btncancelrep" class="myButtons" onclick="funCancelRep();">Cancel Rep</button>
			<button type="button" name="btneditrep" id="btneditrep" class="myButtons" onclick="funEditRep();">Edit Rep</button>&nbsp;&nbsp;
			<button type="button" name="btnopenrep" id="btnopenrep" class="myButtons" onclick="funOpenRep();">Open Rep</button>&nbsp;&nbsp;
			<button type="button" name="btnclear" id="btnclear" class="myButtons" onclick="funClearData();">Clear</button>
			
		</td>
	</tr>
	<tr>
		<td colspan="2" align="center">
		<br><br><br><br>
		</td>
	</tr>
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="replacediv"><jsp:include page="repCancelGrid.jsp"></jsp:include></div></td>
		</tr>
	</table>
</tr>
</table>
</div>
</div> 
<input type="hidden" name="outkm" id="outkm">
<input type="hidden" name="outfuel" id="outfuel">
<input type="hidden" name="outbrch" id="outbrch">
<input type="hidden" name="outloc" id="outloc">
<div id="outdate" hidden="true"></div>
<div id="outtime" hidden="true"></div>
</body>
</html>