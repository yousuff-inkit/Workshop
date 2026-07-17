<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
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
		 getConfig();
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
		 $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:380px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
		 $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
		 
		 $('#regwindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Register Number Search'  , theme: 'energyblue', position: { x: 250, y: 120 }, keyboardCloseKey: 27});
		   $('#regwindow').jqxWindow('close');
		 $('#productDetailsWindow').jqxWindow({width: '51%', height: '59%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Products Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		   $('#productDetailsWindow').jqxWindow('close');
			 
			
		 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		 var onemounth=new Date(new Date(fromdates).setMonth(fromdates.getMonth()-1)); 
		  
	     $('#fromdate').jqxDateTimeInput('setDate', new Date(onemounth));
		 $('#todate').on('change', function (event) {
				
			   var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
			 
			  // out date
			 	 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
			 	 
			   if(fromdates>todates){
				   
				   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
				 
			   return false;
			  }   
		 });
		 
		 $('#regno').dblclick(function(){
		  	    
			   $('#regwindow').jqxWindow('open');
			       		regSearchContent('regnosearch.jsp', $('#regwindow')); 
		       });
		 $('#txtpartno').dblclick(function(){
			 productSearchContent('productSearch.jsp', $('#productDetailsWindow'));
		 }); 
		 
	});

	
	
	
	function funreload(event){
		 var branchval = document.getElementById("cmbbranch").value;
		 var psrno=$("#psrno").val();
		 var regno = document.getElementById("regno").value;
		 var pltid = document.getElementById("txtpltid").value;
		 if(regno==''){
				$.messager.alert('Warning','Please Select A Register Number');
				return false;
			}
		    var fromdate=$('#fromdate').jqxDateTimeInput('val');
		    var todate=$('#todate').jqxDateTimeInput('val');
		 
		 $("#overlay, #PleaseWait").show();
		 
		 $("#complaints").load("serviceGrid.jsp?branchval="+branchval+'&regno='+regno+'&pltid='+encodeURIComponent(pltid)+'&fromdate='+fromdate+'&todate='+todate+'&id=1');
		 $("#overlay, #PleaseWait").show();
		 $("#sparesgrid").load("sparepartGrid.jsp?branchval="+branchval+'&regno='+regno+'&pltid='+encodeURIComponent(pltid)+'&fromdate='+fromdate+'&todate='+todate+'&psrno='+psrno+'&id=1');
	}

	
	function getregno(event){
		 var x= event.keyCode;
		if(x==114){
	 		$('#regwindow').jqxWindow('open');
			regSearchContent('regnosearch.jsp', $('#regwindow'));    }
		else{}
	} 
	function productSearchContent(url) {
	    $('#productDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#productDetailsWindow').jqxWindow('setContent', data);
		$('#productDetailsWindow').jqxWindow('bringToFront');
	}); 
	}

	function getProduct(){
		
		 $('#productDetailsWindow').jqxWindow('open');
			$('#productDetailsWindow').jqxWindow('focus');
			 productSearchContent('productSearch.jsp', $('#productDetailsWindow'));

	}
	 function funExportBtn(){
		  
		
				/* JSONToCSVCon(vehisserviceexc, 'Vehicle history Service Reports', true);
				JSONToCSVCon(vehispartsexc, 'Vehicle history Parts Reports', true); */
				
				
		 $("#sparesgrid").excelexportjs({
				containerid: "sparesgrid",   
				datatype: 'json',
				dataset: null,
				gridId: "sparegrid",
				columns: getColumns("sparegrid") ,   
				worksheetName:"Vehicle history Parts Reports"  
			});  
		 $("#complaints").excelexportjs({
				containerid: "complaints",   
				datatype: 'json',
				dataset: null,
				gridId: "complaint",
				columns: getColumns("complaint") ,   
				worksheetName:"Vehicle history Service Reports"  
			});  
		} 

	function regSearchContent(url) {
		 	$.get(url).done(function (data) {
			$('#regwindow').jqxWindow('open');
			$('#regwindow').jqxWindow('setContent', data);
	}); 
	} 
	
	function funPrintalfahin(){
 		var branchval = document.getElementById("cmbbranch").value;
		var cmbrepairtype='';
		if($('#cmbrepairtype option:selected').text().trim()!='All'){
			cmbrepairtype=document.getElementById("cmbrepairtype").value;
		}
		
		 var regno = document.getElementById("regno").value;
		 var pltid = document.getElementById("txtpltid").value;
		 if(regno==''){
				$.messager.alert('Warning','Please Select A Register Number');
				return false;
			}
		 var dtype='BVH';

		    var fromdate=$('#fromdate').jqxDateTimeInput('val');
		    var todate=$('#todate').jqxDateTimeInput('val');
        var url=document.URL;
        var reurl=url.split("vehiclehistory.jsp"); 
        var win= window.open(reurl[0]+"printvehiclehistry?dtype="+dtype+'&branchval='+branchval+'&regno='+regno+'&pltid='+pltid+'&fromdate='+fromdate+'&todate='+todate+'&id=1&cmbrepairtype='+cmbrepairtype,"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
        win.focus();
   
}
	function funPrintpartwise(){
 		var branchval = document.getElementById("cmbbranch").value;
		var cmbrepairtype='';
		if($('#cmbrepairtype option:selected').text().trim()!='All'){
			cmbrepairtype=document.getElementById("cmbrepairtype").value;
		}
		 var psrno=$("#psrno").val();
		 var regno = document.getElementById("regno").value;
		 var pltid = document.getElementById("txtpltid").value;
		 if(regno==''){
				$.messager.alert('Warning','Please Select A Register Number');
				return false;
			}
		 var dtype='BVH';

		    var fromdate=$('#fromdate').jqxDateTimeInput('val');
		    var todate=$('#todate').jqxDateTimeInput('val');
        var url=document.URL;
        var reurl=url.split("vehiclehistory.jsp"); 
        var win= window.open(reurl[0]+"printpartwise?dtype="+dtype+'&branchval='+branchval+'&regno='+regno+'&pltid='+pltid+'&fromdate='+fromdate+'&todate='+todate+'&id=1&psrno='+psrno+'&cmbrepairtype='+cmbrepairtype,"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
        win.focus();
   
}	
	function funPrintRepairType(evt){
		var branchval = document.getElementById("cmbbranch").value;
		var regno = document.getElementById("regno").value;
		var pltid = document.getElementById("txtpltid").value;
		if(regno==''){
			$.messager.alert('Warning','Please Select A Register Number');
			return false;
		}
		var dtype='BVH';
		var fromdate=$('#fromdate').jqxDateTimeInput('val');
		var todate=$('#todate').jqxDateTimeInput('val');
       	var url=document.URL;
       	var reurl=url.split("vehiclehistory.jsp"); 
       	var win= window.open(reurl[0]+"printVehicleHistoryRepairType?dtype="+dtype+'&branchval='+branchval+'&regno='+regno+'&pltid='+pltid+'&fromdate='+fromdate+'&todate='+todate+'&id=1',"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
       	win.focus();
	}
	function getConfig(){   
	    var x=new XMLHttpRequest();
		x.onreadystatechange=function(){  
			if (x.readyState==4 && x.status==200){                     
				var items=x.responseText.trim();  
				if(parseInt(items.split("::")[0])>0){                                          
					document.getElementById('txtalice').value=1;    
				}else{
					document.getElementById('txtalice').value=0;  
				}
				var rawdata=JSON.parse(items.split("::")[1]);
				var htmldata='';
				$.each(rawdata.repairdata, function( index, value ) {
					htmldata+='<option value="'+value.id+'">'+value.name+'</option>';
				});
				$('#cmbrepairtype').html($.parseHTML(htmldata));
			}      
			else   
			{
			}  
		}
		x.open("GET","getConfig.jsp",true);             
		x.send();
	}
	
	function funClear(event){
		 var fromdates=new Date();
		 var onemounth=new Date(new Date(fromdates).setMonth(fromdates.getMonth()-1)); 
		  
	     $('#fromdate').jqxDateTimeInput('setDate', new Date(onemounth));
	     $('#todate').jqxDateTimeInput('setDate', new Date());
		 $('#todate').on('change', function (event) {
				
			   var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
			 
			  // out date
			 	 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
			 	 
			   if(fromdates>todates){
				   
				   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
				 
			   return false;
			  }   
		 });
		 
		 
		 document.getElementById("regno").value='';
		 document.getElementById("txtpltid").value='';
		 getConfig();
		 document.getElementById("clientinfo").value='';
		 document.getElementById("txtpartno").value='';
		 document.getElementById("psrno").value='';
		 document.getElementById("txtproductname").value='';
		 $('#complaint').jqxGrid('clear');
		 $('#sparegrid').jqxGrid('clear');
	}
</script>
</head>
<body onload="getBranch();getConfig();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%">
	<jsp:include page="../../heading.jsp"></jsp:include>
		
	 <tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td width="20%" align="right" ><label class="branch">From</label></td><td align="left"><div id='fromdate' name='fromdate' value='<s:property value="fromdate"/>'></div>
                    </td></tr>
                    <tr><td>&nbsp;</td></tr>

                     <tr><td  align="right" ><label class="branch">To</label></td><td align="left"><div id='todate' name='todate' value='<s:property value="todate"/>'></div>
                    </td></tr>
                    <tr><td>&nbsp;</td></tr>
                    <tr><td align="right"><label class="branch">Reg No.</label></td><td align="left"><input type="text" name="regno" id="regno" placeholder="Press F3 To Search" readonly="readonly" onKeyDown="getregno(event);" onclick="this.placeholder='' "  style="height:20px;width:90%;" value='<s:property value="regno"/>'></td></tr>
                    <tr><td align="right"><label class="branch">Repair Type</label></td><td align="left"><select name="cmbrepairtype" id="cmbrepairtype" style="height:20px;width:90%;"><option value="">--Select--</option></select></td></tr>
     <tr><td colspan="2" align="center"><textarea id="clientinfo" style="height:100px;width:200px;font: 10px Tahoma;resize:none" name="clientinfo"  readonly="readonly"><s:property value="clientinfo" ></s:property></textarea></td></tr>
       <tr><td align="right"><label class="branch">Product</label></td>
	<td align="left"><input type="text" id="txtpartno" name="txtpartno" style="width:60%;height:20px;" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtpartno"/>' onKeyDown="getProduct(event);"/></td></tr>
	<input type="hidden" id="psrno" name="psrno" value='<s:property value="psrno"/>' /> 
	<tr><td>&nbsp;</td>
	<td><input type="text" id="txtproductname" name="txtproductname" style="width:100%;height:20px;" readonly="readonly" value='<s:property value="txtproductname"/>' tabindex="-1"/></td></tr> 
 
     <tr><td colspan="2">&nbsp;</td></tr>
<tr><td colspan="2" align="center"><button class="myButton" type="button" id="btnPrintalfahin" name="btnPrintalfahin" onclick="funPrintalfahin(event);">Print</button>&nbsp;&nbsp;<button class="myButton" type="button" id="btnprinttype" name="btnprinttype" onclick="funPrintRepairType(event);">Print Repair Type</button></td></tr>    
 <tr><td colspan="2" align="center"><button class="myButton" type="button" id="btnclear" name="btnclear" onclick="funClear(event);">Clear</button>&nbsp;&nbsp;<button class="myButton" type="button" id="btnPrintpartwise" name="btnPrintpartwise" onclick="funPrintpartwise(event);">Part Wise</button></td></tr>
 <!-- <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>	
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr> -->
	  <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">
	  <input type="hidden" id="txtalice" name="txtalice" style="width:100%;height:20px;" value='<s:property value="txtalice"/>'/>
     <input type="hidden" id="txtbranch" name="txtbranch" style="width:100%;height:20px;" value='<s:property value="txtbranch"/>'/>
     <input type="hidden" id="txtpltid" name="txtpltid" style="width:100%;height:20px;" value='<s:property value="txtpltid"/>'/>
     <input type="hidden" id="txtdocument" name="txtdocument" style="width:100%;height:20px;" value='<s:property value="txtdocument"/>'/></td></tr>
  </table>
</fieldset>

</td>
<td width="80%" >
<fieldset><legend>Services</legend>
<table width="100%" >
		<tr><td><div id="complaints"><jsp:include page="serviceGrid.jsp"></jsp:include></div><br/></td></tr>
		</table>
</fieldset>
	<fieldset><legend>Spare Parts</legend>
		<table width="100%" >
		<tr><td><div id="sparesgrid"><jsp:include page="sparepartGrid.jsp"></jsp:include></div></td></tr>
	</table>
	</fieldset>
</td></tr></table>
</div>
<div id="regwindow">
   <div></div>
</div>
<div id="productDetailsWindow">
	<div></div><div></div>
</div>
</div>
</body>
