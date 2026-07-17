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
</style>

<script type="text/javascript">

$(document).ready(function () {
	//document.getElementById("btninvoicesave").style.display="none";
	 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
	    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200;right:600;'><img src='../../../../icons/31load.gif'/></div>");    
	 $("#periodupto").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $('#clientwindow').jqxWindow({ width: '62%', height: '65%',  maxHeight: '85%' ,maxWidth: '80%' , title: 'Client Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   $('#clientwindow').jqxWindow('close');
	   $('#client').dblclick(function(){
		    $('#clientwindow').jqxWindow('open');
		$('#clientwindow').jqxWindow('focus');
		 clientSearchContent('clientINgridsearch.jsp', $('#clientwindow'));
		});
	   $('#periodupto').on('change', function (event) 
				{  
					var docdateval=funDateInPeriod($('#periodupto').jqxDateTimeInput('getDate'));
					if(docdateval==0){
						$('#periodupto').jqxDateTimeInput('focus');
						return false;
					}
				});	 
			document.getElementById("chkall").checked=true;
			setAll();
			$('#cmbbranch option').eq(1).prop('selected', true);
			setKm();
	  setFuel();
			
});
function getClient(event){
	 var x= event.keyCode;
    if(x==114){
    	  $('#clientwindow').jqxWindow('open');
  		$('#clientwindow').jqxWindow('focus');
  		 clientSearchContent('clientINgridsearch.jsp', $('#clientwindow'));
    }
    else{
     }
}
function clientSearchContent(url) {
    //alert(url);
      $.get(url).done(function (data) {
//alert(data);
    $('#clientwindow').jqxWindow('setContent', data);

}); 
}
function funreload(event)
{
	if(document.getElementById("cmbbranch").value=="" || document.getElementById("cmbbranch").value=='a'){
		$.messager.alert('Warning','Please Select Branch');
		return false;
	}
	var dateval=funDateInPeriod($('#periodupto').jqxDateTimeInput('getDate'));
	//alert(dateval);
	if(dateval==1){
	 var branch = document.getElementById("cmbbranch").value;
     	 var date1= $('#periodupto').jqxDateTimeInput('val');
     		 var client=document.getElementById("hidclient").value;
     		$('#extraKmGrid').jqxGrid('clear');
     		$("#extraKmGrid").jqxGrid("addrow", null, {});	
     		//document.getElementById("btninvoicesave").style.display="none";
     		$("#overlay, #PleaseWait").show();
	  $("#invoicediv").load("extrakmGrid.jsp?branch="+branch+"&date1="+date1+"&client="+client+"&temp=1");
	}
	}



	function funNotify(){
		
		var docdateval=funDateInPeriod($('#periodupto').jqxDateTimeInput('getDate'));
		if(docdateval==0){
			$('#periodupto').jqxDateTimeInput('focus');
			return false;
		}
		var z=0;
		
		var rows = $("#extraKmGrid").jqxGrid('getrows');                    
    	if(rows.length>0 && (rows[0].agmtno=="undefined" || rows[0].agmtno==null || rows[0].agmtno=="")){
    		return false;
    	}
    			    var selectedRecords = new Array();
                    var selectedrows=$("#extraKmGrid").jqxGrid('selectedrowindexes');
        
		if(selectedrows.length==0){
			$.messager.alert('Warning','Select an Invoice');
			return false;
		}
		   $.messager.confirm('Confirm', 'Do you want to Generate Invoice?', function(r){
	 			if (r){
	 				
	 				var i=0;
                    $('#invgridlength').val(selectedrows.length);
    			    for (i = 0; i < rows.length; i++) {
						for(var j=0;j<selectedrows.length;j++){
							if(selectedrows[j]==i){
	
								newTextBox = $(document.createElement("input"))
							    .attr("type", "dil")
							    .attr("id", "exkminvoice"+z)
							    .attr("name", "exkminvoice"+z)
							    .attr("hidden","true");
								
							newTextBox.val(rows[i].agmtno+"::"+rows[i].agmttype+"::"+rows[i].fromdate+"::"+rows[i].todate+"::"+rows[i].acno+"::"+rows[i].acname+"::"+rows[i].cldocno+"::"+rows[i].excesskm+"::"+rows[i].exkmrte+"::"+rows[i].excesskmamt+"::"+rows[i].excessfuel+"::"+rows[i].fuelrate+"::"+rows[i].excessfuelamt+"::"+rows[i].branchid+"::"+rows[i].currencyid);
							
							newTextBox.appendTo('form');
							z++;
							//alert("ddddd"+$("#testinvoice"+z).val());
							}
						}
						if(i==rows.length-1){
							 document.getElementById("mode").value='A';
							 $("#overlay, #PleaseWait").show();
							 document.getElementById("frmExtraKm").submit();
						}
			}
    			 
    		 			}
    		 	 		});
		
	}
	function setValues(){
		$('#cmbbranch option:eq(1)').attr('selected', 'selected');
		 if($('#msg').val()!=""){
   		   $.messager.alert('Message',$('#msg').val());
   		  }
		 
	}
	function funExportBtn(){
	if(parseInt(window.parent.chkexportdata.value)=="1")
		  {
		  	JSONToCSVCon(exkmdata, 'Extra KM', true);
		  }
		 else
		  {
			 $("#extraKmGrid").jqxGrid('exportdata', 'xls', 'Extra KM');
		  }
		
			
	}
	
 	function setKm(){
		
 		if(document.getElementById("chkkm").checked==true){
			document.getElementById("hidchkkm").value="1";
			document.getElementById("hidchkexkm").value="0";
			document.getElementById("chkall").checked=false;
 		}
 		if(document.getElementById("chkexkm").checked==true){
			document.getElementById("hidchkexkm").value="1";
			document.getElementById("hidchkkm").value="0";
			document.getElementById("chkall").checked=false;
 		} 
	}
	
	function setFuel(){
		
		if(document.getElementById("chkfuel").checked==true){
			document.getElementById("hidchkfuel").value="1";
			document.getElementById("hidchkexfuel").value="0";
			document.getElementById("chkall").checked=false;
		}
		if(document.getElementById("chkexfuel").checked==true){
			document.getElementById("hidchkexfuel").value="1";
			document.getElementById("hidchkfuel").value="0";
			document.getElementById("chkall").checked=false;
		}
		}
	
	 function setAll(){
		 if(document.getElementById("chkall").checked==true){
			 document.getElementById("hidchkall").value="1";
			 $('#chkkm').removeAttr('checked');
			 $('#chkexkm').removeAttr('checked');
			 $('#chkfuel').removeAttr('checked');
			 $('#chkexfuel').removeAttr('checked');
			 document.getElementById("hidchkkm").value="0";
			 document.getElementById("hidchkexkm").value="0";
			 document.getElementById("hidchkfuel").value="0";
			 document.getElementById("hidchkexfuel").value="0";
		 }
		 else{
			 document.getElementById("hidchkall").value="0";
			
		 }
	 }
	 function funClearData(){
		 setAll();
		 document.getElementById("client").value="";
		 document.getElementById("hidclient").value="";
		 $('#periodupto').jqxDateTimeInput('setDate',new Date());
	 }
</script>
</head>
<body onload="getBranch();setValues();">
<form id="frmExtraKm" action="saveExtraKm" method="post">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%">
<tr>
<td width="20%">
    <fieldset style="background: #ECF8E0;">
	<table width="100%">
	<jsp:include page="../../heading.jsp"></jsp:include>

 <tr><td><label class="branch">Period Upto</label></td><td><div id="periodupto"></div></td></tr>
<tr><td><label class="branch">Client</label></td><td><input type="text" name="client" id="client" onkeydown="getClient(event);" readonly 
value='<s:property value="client"/>' style="width:90%;"></td></tr>
<tr>
  <td colspan="2" align="center"><label class="branch" for="chkall">All</label><input type="checkbox" name="chkall" id="chkall" onchange="setAll();"></td>
  <td width="28%" rowspan="3" align="left">&nbsp;</td>
</tr>
   
 
<input type="hidden" name="hidclient" id="hidclient" >
		 <tr>
	<td colspan="2">&nbsp;</td>
	</tr> 
	
	<tr>
  <td colspan="2" align="left"><fieldset><legend>Separate Invoice</legend>
    <div align="center">
      <input type="radio" name="chkkm" id="chkkm" onChange="setKm();">&nbsp;<label class="branch">KM</label>&nbsp;&nbsp;
      <input type="radio" name="chkfuel" id="chkfuel" onchange="setFuel();">&nbsp;<label class="branch">Fuel</label>
      </div>
  </fieldset></td>
  </tr> 
 
  <tr>
  <td colspan="2" align="left"><fieldset><legend>Not To Be Invoiced</legend>
    <div align="center">
      <input type="radio" name="chkkm" id="chkexkm" onChange="setSalik();">&nbsp;<label class="branch">KM</label>&nbsp;&nbsp;
      <input type="radio" name="chkfuel" id="chkexfuel" onchange="setFuel();">&nbsp;<label class="branch">Fuel</label>
      </div>
  </fieldset></td>
  </tr>
  <tr>
	<td colspan="2"><center>
	<input type="button" name="btnclear" id="btnclear" class="myButtons" value="Clear" onclick="funClearData();">&nbsp;&nbsp;
	<input type="button" name="btninvoicesave" id="btninvoicesave" class="myButton" value="Generate" onclick="funNotify();"></center></td>
	</tr>
	<tr>
	<td colspan="2"><br><br><br><br><br><br></td>
	</tr>	
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="invoicediv"><jsp:include page="extrakmGrid.jsp"></jsp:include></div> </td>
			 <input type="hidden" name="gridlength" id="gridlength" >
			  <input type="hidden" name="invgridlength" id="invgridlength" >
			  <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
			  <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
			   <input type="hidden" name="hidchkall" id="hidchkall" value='<s:property value="hidchkall"/>'>
  <input type="hidden" name="hidchkkm" id="hidchkkm" value='<s:property value="hidchkkm"/>'>
  <input type="hidden" name="hidchkfuel" id="hidchkfuel" value='<s:property value="hidchkfuel"/>'>
   <input type="hidden" name="hidchkexkm" id="hidchkexkm" value='<s:property value="hidchkexkm"/>'>
  <input type="hidden" name="hidchkexfuel" id="hidchkexfuel" value='<s:property value="hidchkexfuel"/>'>
		</tr>
	</table>
</tr>
</table>
</div>
<div id="clientwindow">
<div></div>
</div>
</div>
</form>
</body>
</html>