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
.custompanel1{  
      border:1px solid #ccc;
      float: left;
      display: inline-block;
      margin-top: 10px; 
      margin-right: 10px;
      padding-right: 10px;
      padding-left: 10px;
      padding-top: 10px;
      padding-bottom: 10px;
      border-radius: 8px;
    }
    .tabheight{
    height:515px;
    }
    
</style>

<script type="text/javascript">

$(document).ready(function () {
	    
	
	    document.getElementById('sumrdo').checked=true;
	    funchangerdo();
	    
		document.getElementById("branchlabel").style.display="none";
		document.getElementById("branchdiv").style.display="none";
		  
		$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200px;right:750px;'><img src='../../../../icons/31load.gif'/></div>");
	    $('#clientwindow').jqxWindow({ width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Client Search'  , theme: 'energyblue', position: { x: 250, y: 120 }, keyboardCloseKey: 27});
		$('#clientwindow').jqxWindow('close');
	    
	    $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	    $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	    var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
	    var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1)); 
	    $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate);
		 getCategory();
	    
	    $('#clientname').dblclick(function(){
	  	    
		   $('#clientwindow').jqxWindow('open');
		       		clientSearchContent('clientsearch.jsp', $('#clientwindow')); 
		       		
		       
		     	
	       });
});


	function funreload(event)
	{
		var load=$('#type').val();
		var cmbcategory=$('#cmbcategory').val();
		var datetype=$('#txttype').val();
		var clnt=$('#cldocno').val();
	    var fromdate=$('#fromdate').jqxDateTimeInput('val');
	    var todate=$('#todate').jqxDateTimeInput('val');
	    $("#overlay, #PleaseWait").show();
	    if(document.getElementById('sumrdo').checked){
	    	$("#gipdetdiv").load("summarydetailsGrid.jsp?froms="+fromdate+"&tdt="+todate+"&datetype="+datetype+"&cldocno="+clnt+"&cmbcategory="+cmbcategory+"&type="+load+"&check=1");
	    }else
	    	{
	    	$("#gateinpassdiv").load("gateInPassListGrid.jsp?froms="+fromdate+"&tdt="+todate+"&datetype="+datetype+"&cldocno="+clnt+"&cmbcategory="+cmbcategory+"&type="+load+"&check=1");
	    	}
	}
	
	

	function setValues(){

		 if($('#msg').val()!=""){
   		   $.messager.alert('Message',$('#msg').val());
   		  }
	
	}
	
	function funExportBtn(){
		if(document.getElementById('sumrdo').checked){
			$("#gipdetdiv").excelexportjs({
				containerid: "gipdetdiv",
				datatype: 'json',
				dataset: null,
				gridId: "jqxdetailGrid",
				columns: getColumns("jqxdetailGrid"),
				worksheetName: "GIP-SUMMARY"
			});
			
			
		}else{
			$("#gateinpassdiv").excelexportjs({
				containerid: "gateinpassdiv",
				datatype: 'json',
				dataset: null,
				gridId: "jqxFleetGrid",
				columns: getColumns("jqxFleetGrid"),
				worksheetName: "GIP-DETAIL"
			});
		}
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
	
	function getCategory() {
		 
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var categoryItems = items[0].split(",");
				var categoryIdItems = items[1].split(",");
				var optionscategory = '<option value="">--Select--</option>';
				for (var i = 0; i < categoryItems.length; i++) {
					optionscategory += '<option value="' + categoryIdItems[i] + '">'
							+ categoryItems[i] + '</option>';
				}
				$("select#cmbcategory").html(optionscategory);
				
			} else {
			}
			//alert("=========="+$('#hidcmbcategory').val());
			if ($('#hidcmbcategory').val() != null) {
				$('#cmbcategory').val($('#hidcmbcategory').val());
			}
		}
		x.open("GET", "getCategory.jsp", true);
		x.send();
	}


		
	
	function funClearData(){
		/* $('input[type=text],[type=hidden]').val('');
		$('select').find('option').prop("selected", false); */
		$('#fromdate').jqxDateTimeInput('setDate',new Date());
		$('#todate').jqxDateTimeInput('setDate',new Date());
		var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
	    var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
	    $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate); 
	 	document.getElementById("txttype").value="";
		document.getElementById("clientname").value="";
		document.getElementById("cldocno").value="";
		document.getElementById("type").value="";
		document.getElementById("cmbcategory").value="";
		
		
	
	}
	
	function funLoadData(){
	
	  	document.getElementById("txttype").value="";
		document.getElementById("clientname").value="";
	}
	function funchangerdo(){  
		if(document.getElementById('sumrdo').checked){
			$('.detailz').hide();
			$('.summaryz').show();
		}else{
			$('.detailz').show();
			$('.summaryz').hide();
		} 
	}
	
		
	</script>
	
</head>
<body onload="setValues();">
<form id="frmReplaceList" method="post">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%">
<tr>
<td width="23%" align="center">
    <fieldset style="background: #ECF8E0;" class="tabheight">
	<table width="100%">
	<jsp:include page="../../heading.jsp"></jsp:include>
<tr>
	
   <td width="37%" align="right"><label class="branch">Date Type</label></td>            
         <td >
         	<select id="txttype" name="txttype" style="width:75%;height:20px;" value='<s:property value="txttype"/>'>   
      			<option value="GIP">Gate In Pass</option>
      			<option value="EST">Estimation</option>
      			<option value="JC">Job Card</option>
      			<option value="JCC">Job Card Complete</option>
      			
      			<option value="INV">Invoice</option>
      		</select>
  </tr>

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
	
   <td width="37%" align="right"><label class="branch">Type</label></td>            
         <td ><select id="type" name="type" style="width:75%;height:20px;" value='<s:property value="type"/>'>   
      <option value="">--select--</option><option value="open">open</option><option value="close">close</option></select>
  </tr>
 <tr>
    <td width="37%" align="right"><label class="branch">Client Category</label></td>
    <td><select id="cmbcategory" name="cmbcategory"  style="width:75%;height:20px;" value='<s:property value="cmbcategory"/>'>
      <option value="">--Select--</option></select>
      <input type="hidden" id="hidcmbcategory" name="hidcmbcategory" value='<s:property value="hidcmbcategory"/>'/></td>
   </tr>
   <tr>
       <td width="48%" align="center"><input type="radio"  id="sumrdo" name="rdo" onchange="funchangerdo();" ><label for="rdsummary" class="branch">Summary</label></td>
       <td width="52%" align="center"><input type="radio" id="detrdo" name="rdo" onchange="funchangerdo();" ><label for="rddetailed" class="branch">Detail</label></td>
      </tr>
     
 <tr>
	<td colspan="2" style="border-top:2px solid #DCDDDE;">
	<div style="text-align:center;">
	<input type="button" name="btnclear" id="btnclear" value="Clear" class="myButtons" onclick="funClearData();"><!-- &nbsp;&nbsp;
	<input type="button" name="btnrepprint" id="btnrepprint" value="Print" class="myButtons" onclick="funPrintData();"> -->
	</div>
    </td>
	</tr>
<tr ><td colspan="2"><!-- <textarea id="agmtdetails" name="agmtdetails" readonly style="resize:none;" rows="10" cols="35"></textarea> -->
	<br><br><br><br><br><br><br><br>
    <br><br><br><br><br><br><br>
    </td></tr>

	
	</table>
	</fieldset>
</td>
<td width="77%">
	<table width="100%">
		<tr class="detailz">
			 <td><div id="gateinpassdiv"><jsp:include page="gateInPassListGrid.jsp"></jsp:include></div></td>
		 </tr>
		<tr class="summaryz">
			 <td><div id="gipdetdiv"><jsp:include page="summarydetailsGrid.jsp"></jsp:include></div></td>
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