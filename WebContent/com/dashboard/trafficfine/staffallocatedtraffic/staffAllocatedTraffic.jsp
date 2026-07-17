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
	-moz-box-shadow:inset 0px -1px 3px 0px #91b8b3;
	-webkit-box-shadow:inset 0px -1px 3px 0px #91b8b3;
	box-shadow:inset 0px -1px 3px 0px #91b8b3;
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #768d87), color-stop(1, #6c7c7c));
	background:-moz-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-webkit-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-o-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-ms-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:linear-gradient(to bottom, #768d87 5%, #6c7c7c 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#768d87', endColorstr='#6c7c7c',GradientType=0);
	background-color:#768d87;
	border:1px solid #566963;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	
	font-size:8pt;
	
	padding:3px 17px;
	text-decoration:none;
	text-shadow:0px -1px 0px #2b665e;
}
.myButtons:hover {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #6c7c7c), color-stop(1, #768d87));
	background:-moz-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-webkit-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-o-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-ms-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:linear-gradient(to bottom, #6c7c7c 5%, #768d87 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#6c7c7c', endColorstr='#768d87',GradientType=0);
	background-color:#6c7c7c;
}
.myButtons:active {
	position:relative;
	top:1px;
}
</style>


<script type="text/javascript">

	$(document).ready(function () {
		 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 $("#date").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 
		 $('#employeeDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Employee Search',position: { x: 250, y: 120 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#employeeDetailsWindow').jqxWindow('close');
		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
		 
		 var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
		 
		 
		  
		  $('#txtempname').dblclick(function(){
			  var branchval = document.getElementById("cmbbranch").value; 
			  var emptype = $('#emptype').val();
		  
		     if(emptype==''){
				 $.messager.alert('Message','Choose an Employee Type.','warning');
				 return 0;
			 }
			  
			  employeeSearchContent('employeeDetailsSearch.jsp?branchval='+branchval+'&emptype='+emptype); 
			});
	});
	
	function funExportBtn(){
		  
		 
		 if(parseInt(window.parent.chkexportdata.value)=="1")
		  {
		  	JSONToCSVCon(data1, 'Staff-Allocated-Traffic', true);
		  }
		 else
		  {
		                 
			 $("#jqxstaffAllocatedTraffic").jqxGrid('exportdata', 'xls', 'Staff-Allocated-Traffic');
		  }
		 
		
		 }
	function clientSearchContent(url) {
	    $('#clientDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#clientDetailsWindow').jqxWindow('setContent', data);
		$('#clientDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function employeeSearchContent(url) {
	 	$('#employeeDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#employeeDetailsWindow').jqxWindow('setContent', data);
		$('#employeeDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function getEmployee(event){
        var x= event.keyCode;
        if(x==114){
        	var emptype = $('#emptype').val();
  		  
  		    if(emptype==''){
  				 $.messager.alert('Message','Choose an Employee Type.','warning');
  				 return 0;
  			 }
        	var branchval = document.getElementById("cmbbranch").value; 
  		    employeeSearchContent('employeeDetailsSearch.jsp?branchval='+branchval+'&emptype='+emptype);
        }
        else{}
        }

	function  funClearData(){
		 $('#emptype').val('');$('#txtempname').val('');$('#txtempid').val('');$('#fromdate').val(new Date());$('#todate').val(new Date());$('#date').val(new Date());
		
		 $('#fromdate').val(new Date());
		 var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	     
		 if (document.getElementById("txtempname").value == "") {
		        $('#txtempname').attr('placeholder', 'Press F3 to Search'); 
		    }
	 }
	 
	function empchange(){
		$('#txtempid').val('');$('#txtempname').val('');
		
		if (document.getElementById("txtempname").value == "") {
	        $('#txtempname').attr('placeholder', 'Press F3 to Search'); 
	    }
	}
	
	function datechange(){
	    var date = $('#date').jqxDateTimeInput('getDate');
		var validdate=funDateInPeriod(date);
		if(validdate==0){
		return 0;	
		}
    }
	
	function funreload(event){
		 var branchval = document.getElementById("cmbbranch").value;
		 var fromdate = $('#fromdate').val();
		 var todate = $('#todate').val();
		 var emptype = $('#emptype').val();
		 var empname = $('#txtempid').val();
		 $("#overlay, #PleaseWait").show();
		 
		 $("#staffAllocatedDiv").load("staffAllocatedTrafficGrid.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&emptype='+emptype+'&empname='+empname);
	}
	
	function funUpdate(event){
		var trafficaccount = $('#txttrafficaccount').val();
		var expenseaccount = $('#txtexpenseaccount').val();
		var rano = $('#txtrano').val();
		var fleetno = $('#txtfleetno').val();
		var amount = $('#txtamount').val();
		var mainbranch = $('#txtmainbranch').val();
		var docno = $('#txtdocno').val();
		var srno = $('#txtsrno').val();
		var amountcount = $('#txtamountcount').val();
		var empid = $('#txtemployeeid').val();
		var ticketno = $('#txtticketno').val();
		var postdate = $('#date').val();
		
		if(docno==''){
			 $.messager.alert('Message','Please Choose a Fleet.','warning');
			 return 0;
		 }
		
		var date = $('#date').jqxDateTimeInput('getDate');
		var validdate=funDateInPeriod(date);
		if(validdate==0){
			return 0;	
		}
		
		    $.messager.confirm('Message', 'Do you want to save changes?', function(r){
			        
		     	if(r==false)
		     	  {
		     		return false; 
		     	  }
		     	else{
		     		 saveGridData(trafficaccount,expenseaccount,rano,fleetno,amount,mainbranch,docno,srno,amountcount,empid,ticketno,postdate);	
		     	}
		 });
	}
	
	function saveGridData(trafficaccount,expenseaccount,rano,fleetno,amount,mainbranch,docno,srno,amountcount,empid,ticketno,postdate){
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText.trim();
				items = items.split('***');
				var val = items[0];
				var jvno = items[1];
				
				$.messager.alert('Message', '  Ticket No: '+$('#txtticketno').val()+' of Fleet No: '+$('#txtfleetno').val()+' is Passed as Journal Voucher No.: '+items[1]+'', function(r){
				});
				
				var traffickaccount = $('#txttrafficaccount').val(' ');
				var expenseaccount = $('#txtexpenseaccount').val(' ');
				var rano = $('#txtrano').val(' ');
				var fleetno = $('#txtfleetno').val(' ');
				var amount = $('#txtamount').val(' ');
				var mainbranch = $('#txtmainbranch').val(' ');
				var docno = $('#txtdocno').val(' ');
				var srno = $('#txtsrno').val(' ');
				var amountcount = $('#txtamountcount').val(' ');
				var empid = $('#txtemployeeid').val(' ');
				var vehinfo = $('#vehinfo').val(' ');
				var ticketno = $('#txtticketno').val(' ');
				$('#date').val(new Date());
				
		      funreload(event); 
		  }
		}
			
	x.open("GET","saveData.jsp?trafficaccount="+trafficaccount+"&expenseaccount="+expenseaccount+"&rano="+rano+"&fleetno="+fleetno+"&amount="+amount+"&mainbranch="+mainbranch+"&docno="+docno+"&srno="+srno+"&amountcount="+amountcount+"&empid="+empid+"&ticketno="+ticketno+"&postdate="+postdate,true);
	x.send();
	}
		
</script>

</head>
<body onload="getBranch();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%"  >
	<jsp:include page="../../heading.jsp"></jsp:include>
		
	<tr><td colspan="2">&nbsp;</td></tr>
    <tr>
	 <td align="right"><label class="branch">From</label></td>
     <td align="left"><div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div></td></tr> 
	<tr>
	<td align="right"><label class="branch">To</label></td>
    <td align="left"><div id="todate" name="todate" value='<s:property value="todate"/>'></div></td>
	</tr>
	<tr><td align="right"><label class="branch">Type</label></td>
     <td align="left"><select id="emptype" name="emptype"   onchange="empchange();" value='<s:property value="emptype"/>'>
     <option value="">--Select--</option><option value="STF">Staff</option><option value="DRV">Driver</option>
     </select></td></tr>
	<tr><td align="right"><label class="branch">Employee</label></td>
	<td align="left"><input type="text" id="txtempname" name="txtempname" style="width:100%;height:20px;" readonly="readonly" placeholder="Press F3 to Search"  onkeydown="getEmployee(event);" value='<s:property value="txtempname"/>'/>
	<input type="hidden" id="txtempid" name="txtempid" style="width:100%;height:20px;" value='<s:property value="txtempid"/>'/></td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2" align="center"><textarea id="vehinfo" style="height:80px;width:200px;font: 10px Tahoma;resize:none" name="vehinfo"  readonly="readonly"  ><s:property value="vehinfo" ></s:property></textarea></td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td align="right"><label class="branch">Posting</label></td>
    <td align="left"><div id="date" name="date" onchange="datechange();" value='<s:property value="date"/>'></div></td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2" align="center"><input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funClearData();">
	<button class="myButton" type="button" id="btnupdate" name="btnupdate" onclick="funUpdate(event);">Update</button></td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
    <tr><td colspan="2"><input type="hidden" id="txttrafficaccount" name="txttrafficaccount" style="width:100%;height:20px;" value='<s:property value="txttrafficaccount"/>'/>
    <input type="hidden" id="txtexpenseaccount" name="txtexpenseaccount" style="width:100%;height:20px;" value='<s:property value="txtexpenseaccount"/>'/>
    <input type="hidden" id="txtrano" name="txtrano" style="width:100%;height:20px;" value='<s:property value="txtrano"/>'/>
    <input type="hidden" id="txtfleetno" name="txtfleetno" style="width:100%;height:20px;" value='<s:property value="txtfleetno"/>'/>
    <input type="hidden" id="txtticketno" name="txtticketno" style="width:100%;height:20px;" value='<s:property value="txtticketno"/>'/>
    <input type="hidden" id="txtamount" name="txtamount" style="width:100%;height:20px;" value='<s:property value="txtamount"/>'/>
    <input type="hidden" id="txtamountcount" name="txtamountcount" style="width:100%;height:20px;" value='<s:property value="txtamountcount"/>'/>
    <input type="hidden" id="txtmainbranch" name="txtmainbranch" style="width:100%;height:20px;" value='<s:property value="txtmainbranch"/>'/>
    <input type="hidden" id="txtdocno" name="txtdocno" style="width:100%;height:20px;" value='<s:property value="txtdocno"/>'/>
    <input type="hidden" id="txtsrno" name="txtsrno" style="width:100%;height:20px;" value='<s:property value="txtsrno"/>'/>
    <input type="hidden" id="txtemployeeid" name="txtemployeeid" style="width:100%;height:20px;" value='<s:property value="txtemployeeid"/>'/></td></tr> 
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="staffAllocatedDiv"><jsp:include page="staffAllocatedTrafficGrid.jsp"></jsp:include></div></td>
		</tr>
	</table>
</tr>
</table>
</div>
<div id="employeeDetailsWindow">
	<div></div><div></div>
</div>
</div> 
</body>
</html>