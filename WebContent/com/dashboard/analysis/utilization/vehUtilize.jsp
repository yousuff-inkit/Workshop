<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@page import="com.dashboard.analysis.utilization.*" %>
<%ClsVehUtilizationDAO utilizedao=new ClsVehUtilizationDAO(); %>
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
</style>

<script type="text/javascript">

$(document).ready(function () {
	  // setType(null);
	  
	   $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200px;right:750px;'><img src='../../../../icons/31load.gif'/></div>");
	$('#vehdetaildiv').hide();
	 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $('#brandwindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '80%' ,maxWidth: '50%' , title: 'Brand Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   $('#brandwindow').jqxWindow('close');
	   $('#modelwindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '80%' ,maxWidth: '50%' , title: 'Model Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   $('#modelwindow').jqxWindow('close');
	   $('#groupwindow').jqxWindow({ width: '50%',height: '60%',  maxHeight: '80%'  ,maxWidth: '50%' , title: 'Group Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   $('#groupwindow').jqxWindow('close');
	   $('#yomwindow').jqxWindow({ width: '50%',height: '60%',  maxHeight: '80%'  ,maxWidth: '50%' , title: 'YOM Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   $('#yomwindow').jqxWindow('close');
	   
	 
	   $('#fleetwindow').jqxWindow({ width: '50%',height: '60%',  maxHeight: '80%'  ,maxWidth: '50%' , title: 'Fleet Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   $('#fleetwindow').jqxWindow('close');
	   
	   var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
       var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
       $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate); 
});

function getFleet(){

	 $('#fleetwindow').jqxWindow('open');
		$('#fleetwindow').jqxWindow('focus');
		 $("#loadingImage").css({ "display": "block", "left":280, "top": 200});
		fleetSearchContent('fleetSearch.jsp?id=1', $('#fleetwindow'));
	
}

function getBrand(){
	 $('#brandwindow').jqxWindow('open');
		$('#brandwindow').jqxWindow('focus');
		 $("#loadingImage").css({ "display": "block", "left":280, "top": 200});
		 brandSearchContent('brandSearch.jsp?id=1', $('#brandwindow'));

}


function getModel(){
	
	 $('#modelwindow').jqxWindow('open');
		$('#modelwindow').jqxWindow('focus');
		 $("#loadingImage").css({ "display": "block", "left":280, "top": 200});
		 modelSearchContent('modelSearch.jsp?id=1', $('#brandwindow'));

}

function getGroup(event){

	$('#groupwindow').jqxWindow('open');
	$('#groupwindow').jqxWindow('focus');
	 $("#loadingImage").css({ "display": "block", "left":280, "top": 200});
	 groupSearchContent('groupSearch.jsp?id=1', $('#groupwindow'));

}
function getYom(event){

	 $('#yomwindow').jqxWindow('open');
		$('#yomwindow').jqxWindow('focus');
		 $("#loadingImage").css({ "display": "block", "left":280, "top": 200});
		 yomSearchContent('yomSearch.jsp?id=1', $('#yomwindow'));
}


function brandSearchContent(url) {
    //alert(url);
      $.get(url).done(function (data) {
//alert(data);
    $('#brandwindow').jqxWindow('setContent', data);

}); 
}

function modelSearchContent(url) {
    //alert(url);
      $.get(url).done(function (data) {
//alert(data);
    $('#modelwindow').jqxWindow('setContent', data);

}); 
}

function groupSearchContent(url) {
    //alert(url);
      $.get(url).done(function (data) {
//alert(data);
    $('#groupwindow').jqxWindow('setContent', data);

}); 
}

function yomSearchContent(url) {
    //alert(url);
      $.get(url).done(function (data) {
//alert(data);
    $('#yomwindow').jqxWindow('setContent', data);

}); 
}

function fleetSearchContent(url) {
    //alert(url);
      $.get(url).done(function (data) {
//alert(data);
    $('#fleetwindow').jqxWindow('setContent', data);

}); 
}
function funreload(event)
{
	if(document.getElementById("cmbbranch").value==""){
		$.messager.alert('Warning','Please Select Branch');
		return false;
	}
	
		 var branch=document.getElementById("cmbbranch").value;
	     var fromdate=$('#fromdate').jqxDateTimeInput('val');
	     var todate=$('#todate').jqxDateTimeInput('val');
	     var hidbrand=document.getElementById("hidbrand").value;
	     var hidmodel=document.getElementById("hidmodel").value;
	     var hidgroup=document.getElementById("hidgroup").value;
	     var hidyom=document.getElementById("hidyom").value;
	     var grpby1=document.getElementById("grpby1").value;
		 var hidfleet=document.getElementById("hidfleet").value;
	     var hidduration;
	     if(document.getElementById("rdohours").checked==true){
		  hidduration="hours";
	  }
	     else if(document.getElementById("rdodays").checked==true){
	    	 hidduration="days";
	     }
	    	
	     $("#overlay, #PleaseWait").show();
	    $("#vehutilizediv").load("vehUtilizeGrid.jsp?branch="+branch+"&fromdate="+fromdate+"&todate="+todate+"&fleet="+hidfleet+"&id=1&duration="+hidduration+"&grpby1="+grpby1+"&hidbrand="+hidbrand+"&hidmodel="+hidmodel+"&hidgroup="+hidgroup+"&hidyom="+hidyom);   	 
	
	}
	

	function setValues(){

		 if($('#msg').val()!=""){
   		   $.messager.alert('Message',$('#msg').val());
   		  }
	document.getElementById("rdohours").checked=true;
	
		 
	}
	function funExportBtn(){
		 /* $("#vehUtilizeGrid").jqxGrid('exportdata', 'xls', 'Vehicle Utilization'); */
			 if(parseInt(window.parent.chkexportdata.value)=="1")
		  {
		  	JSONToCSVCon(utilizedataexcel, 'Vehicle Utilization', true);
		  }
		 else
		  {
			 $("#vehUtilizeGrid").jqxGrid('exportdata', 'xls', 'Vehicle Utilization');
		  }
		
	}

	
	function funClearData(){
		$('input[type=text],[type=hidden], textarea').val('');
		$('select').find('option').prop("selected", false);
		$('#fromdate').jqxDateTimeInput('setDate',new Date());
		$('#todate').jqxDateTimeInput('setDate',new Date());
		   
		var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
	    var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
	    $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate);
	    $('input:checkbox').removeAttr('checked');
	    $('input[type=radio]').prop("checked", false);
	    document.getElementById("rdohours").checked=true;
	    $('#cmbbranch').val('a');
	}
	function setSearch(){
		var value=$('#searchby').val().trim();
		
		if(value=="brand"){
			getBrand();
		}
		else if(value=="model"){
			getModel();
		}
		else if(value=="group"){
			getGroup();
		}
		else if(value=="yom"){
			getYom();
		}
		else if(value=="fleet"){
			getFleet();
		}
		else{
			
		}



	}
	
	
	
	function setRemove(){
		var value=$('#searchby').val().trim();
		 if(value=="brand"){
			document.getElementById("searchdetails").value="";
			document.getElementById("brand").value="";
			document.getElementById("hidbrand").value="";
			document.getElementById("searchdetails").value=document.getElementById("model").value;	
		
					if(document.getElementById("group").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("group").value;	
			}
			if(document.getElementById("yom").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("yom").value;	
			}
			if(document.getElementById("fleet").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("fleet").value;	
			}
		}
		else if(value=="model"){
			document.getElementById("searchdetails").value="";
			document.getElementById("model").value="";
			document.getElementById("hidmodel").value="";
			document.getElementById("searchdetails").value=document.getElementById("brand").value;
			
			if(document.getElementById("group").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("group").value;	
			}
			if(document.getElementById("yom").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("yom").value;	
			}
			if(document.getElementById("fleet").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("fleet").value;	
			}
		}
		else if(value=="group"){
			document.getElementById("searchdetails").value="";
			document.getElementById("group").value="";
			document.getElementById("hidgroup").value="";
			document.getElementById("searchdetails").value=document.getElementById("brand").value;
		
		
			if(document.getElementById("model").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("model").value;	
			}
			if(document.getElementById("yom").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("yom").value;	
			}
			if(document.getElementById("fleet").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("fleet").value;	
			}
		}
		else if(value=="yom"){
			document.getElementById("searchdetails").value="";
			document.getElementById("yom").value="";
			document.getElementById("hidyom").value="";
			document.getElementById("searchdetails").value=document.getElementById("brand").value;
			
			
			if(document.getElementById("model").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("model").value;	
			}
			if(document.getElementById("group").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("group").value;	
			}
			if(document.getElementById("fleet").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("fleet").value;	
			}
		}
		else if(value=="fleet"){
			document.getElementById("searchdetails").value="";
			document.getElementById("fleet").value="";
			document.getElementById("hidfleet").value="";
			document.getElementById("searchdetails").value=document.getElementById("brand").value;
			
			
			if(document.getElementById("model").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("model").value;	
			}
			if(document.getElementById("group").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("group").value;	
			}
			if(document.getElementById("yom").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("yom").value;	
			}
		}
	}
	function setDetail(){
		if(document.getElementById("chkdetail").checked==true){
			$('#vehUtilizeGrid').jqxGrid('setColumnproperty','transfer','hidden',false);
			$('#vehUtilizeGrid').jqxGrid('setColumnproperty','delivery','hidden',false);
			$('#vehUtilizeGrid').jqxGrid('setColumnproperty','others','hidden',false);
			$('#vehUtilizeGrid').jqxGrid('setColumnproperty','custody','hidden',false);
		}
		else if(document.getElementById("chkdetail").checked==false){
			$('#vehUtilizeGrid').jqxGrid('setColumnproperty','transfer','hidden',true);
			$('#vehUtilizeGrid').jqxGrid('setColumnproperty','delivery','hidden',true);
			$('#vehUtilizeGrid').jqxGrid('setColumnproperty','others','hidden',true);
			$('#vehUtilizeGrid').jqxGrid('setColumnproperty','custody','hidden',true);
		}
	}
</script>
</head>
<body onload="getBranch();setValues();">
<form id="frmSalesInvoiceList" method="post">
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
   <td align="center" colspan="2">
   <!-- <input type="checkbox" name="chkdetail" id="chkdetail" onchange="setDetail();" hidden="true"><label for="chkdetail" class="branch" hidden="true">Detail</label>&nbsp;&nbsp; -->
   <input type="radio" name="duration" id="rdohours" value="days"><label class="branch" for="rdohours">Hours</label>&nbsp;&nbsp;
   <input type="radio" name="duration" id="rdodays" value="days"><label class="branch" for="rdodays">Days</label>
   </td>
 </tr>
<tr>
  <td align="right"><label class="branch">Grouping 1</label></td>
  <td align="left"><select name="grpby1" id="grpby1">
    <option value="">--Select--</option>
  
    <option value="brand">Brand</option>
    <option value="model">Model</option>
    <option value="group">Group</option>
    <option value="yom">YOM</option>
    </select>
    </td>
    </tr>
<tr >
	  <td align="right"><label class="branch">Search By</label></td>
	  <td  align="left"><select name="searchby" id="searchby">
	<option value="">--Select--</option>
	
    <option value="brand">Brand</option>
    <option value="model">Model</option>
    <option value="group">Group</option>
    <option value="yom">YOM</option>
    <option value="fleet">Fleet</option>
    </select>&nbsp;&nbsp;<button type="button" name="btnadditem" id="additem" class="myButtons" onClick="setSearch();">+</button>&nbsp;&nbsp;<button  type="button" name="btnremoveitem" id="btnremoveitem" class="myButtons" onclick="setRemove();">-</button></td>
	  </tr>
	<tr >
	  <td colspan="2"
      align="right" ><textarea id="searchdetails" name="searchdetails" style="resize:none;font: 10px Tahoma;" rows="18" cols="50" readonly></textarea>
      
      </td>
	  </tr>
 	
	<tr>
	<td colspan="2" style="border-top:2px solid #DCDDDE;">
	 
	<center><input type="button" name="btnclear" id="btnclear" value="Clear" class="myButtons" onclick="funClearData();"></center>
   
    </td>
	</tr>
	<tr><td colspan="2">&nbsp;</td></tr>	
	</table>
	</fieldset>
</td>
<td width="77%">
	<table width="100%">
		<tr>
			 <td> <div id="vehutilizediv"> <jsp:include page="vehUtilizeGrid.jsp"></jsp:include> </div> 		
			 </td>
			   <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
			  <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
			  <input type="hidden" name="hidgroup" id="hidgroup">
			  <input type="hidden" name="hidmodel" id="hidmodel">
			  <input type="hidden" name="hidyom" id="hidyom">
			  <input type="hidden" name="hidbrand" id="hidbrand">
			  <input type="hidden" name="group" id="group">
			  <input type="hidden" name="model" id="model">
			  <input type="hidden" name="yom" id="yom">
			  <input type="hidden" name="brand" id="brand">
			  <input type="hidden" name="hidfleet" id="hidfleet">
			  <input type="hidden" name="fleet" id="fleet">
		</tr>
	</table>
</tr>
</table>
</div>

</div>
<div id="fleetwindow">
<div><img id="loadingImage" src="../../../../icons/31load.gif" style="position: absolute;vertical-align:middle;text-align:center;top:50%;left:50%;" /></div>
</div>
<div id="brandwindow">
<div><img id="loadingImage" src="../../../../icons/31load.gif" style="position: absolute;vertical-align:middle;text-align:center;top:50%;left:50%;" /></div>
</div>
<div id="modelwindow">
<div><img id="loadingImage" src="../../../../icons/31load.gif" style="position: absolute;vertical-align:middle;text-align:center;top:50%;left:50%;" /></div>
</div>
<div id="groupwindow">
<div><img id="loadingImage" src="../../../../icons/31load.gif" style="position: absolute;vertical-align:middle;text-align:center;top:50%;left:50%;" /></div>
</div>
<div id="yomwindow">
<div><img id="loadingImage" src="../../../../icons/31load.gif" style="position: absolute;vertical-align:middle;text-align:center;top:50%;left:50%;" /></div>
</div>
</form>
</body>
</html>