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
  background-color: grey;
}
</style>

<script type="text/javascript">

$(document).ready(function () 
{
	$("#btnExcel").click(function() {
if(parseInt(window.parent.chkexportdata.value)=="1")
		  {
		  	JSONToCSVCon(invoicedata, 'Damage Invoice List', true);
		  }
		 else
		  {
			 $("#DamageInvoiceGrid").jqxGrid('exportdata', 'xls', 'Damage Invoice List');
		  }
			}); 

	 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
	    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200;right:600;'><img src='../../../../icons/31load.gif'/></div>"); 
	 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});

	 $('#clientDetailsWindow').jqxWindow({ width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Client Search' , theme: 'energyblue', position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	 $('#clientDetailsWindow').jqxWindow('close');
	 
	 $('#fleetwindow').jqxWindow({ width: '30%', height: '65%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Fleet Search' , position: { x: 200, y: 60 }, keyboardCloseKey: 27});
	 $('#fleetwindow').jqxWindow('close');	
	 
	 
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
	 	 
	 
	 $('#fleetno').dblclick(function(){
	  	    $('#fleetwindow').jqxWindow('open');
	   
	       fleetSearchContent('fleetsearch.jsp?', $('#fleetwindow')); 
    });
	 
	  $('#txtclientname').dblclick(function(){
		  clientSearchContent('clientDetailsSearchGrid.jsp');
		});
	  
	
});

	function clientSearchContent(url) {
	    $('#clientDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#clientDetailsWindow').jqxWindow('setContent', data);
		$('#clientDetailsWindow').jqxWindow('bringToFront');
	}); 
	}

	
	function getClient(event){
	    var x= event.keyCode;
	    if(x==114){
	    	clientSearchContent('clientDetailsSearchGrid.jsp');
	    }
	    else{}
	    }
	
	
	function fleetSearchContent(url) {
	 	 //alert(url);
	 		 $.get(url).done(function (data) {
	 			 
	 			 $('#fleetwindow').jqxWindow('open');
	 		$('#fleetwindow').jqxWindow('setContent', data);
	 
	 	}); 
	 	} 

	function getfleetdata(event){
		 var x= event.keyCode;
		 if(x==114){
		  $('#fleetwindow').jqxWindow('open');


		  fleetSearchContent('fleetsearch.jsp?', $('#fleetwindow'));     }
		 else{
			 }
		 }

	
	
	
	
/* 	function funSearchdblclick(){
		
	}
	 */
	 function funExportBtn(){
		    

		   JSONToCSVConvertor(damageinvoiceexceldata, 'Damage Invoices List', true);
		   }
		  
		  
		  function JSONToCSVConvertor(JSONData, ReportTitle, ShowLabel) {
	
		      var arrData = typeof JSONData != 'object' ? JSON.parse(JSONData) : JSONData;
		      
		     // alert("arrData");
		      var CSV = '';    
		      //Set Report title in first row or line
		      
		      CSV += ReportTitle + '\r\n\n';

		      //This condition will generate the Label/Header
		      if (ShowLabel) {
		          var row = "";
		          
		          //This loop will extract the label from 1st index of on array
		          for (var index in arrData[0]) {
		              
		              //Now convert each value to string and comma-seprated
		              row += index + ',';
		          }

		          row = row.slice(0, -1);
		          
		          //append Label row with line break
		          CSV += row + '\r\n';
		      }
		      
		      //1st loop is to extract each row
		      for (var i = 0; i < arrData.length; i++) {
		          var row = "";
		          
		          //2nd loop will extract each column and convert it in string comma-seprated
		          for (var index in arrData[i]) {
		              row += '"' + arrData[i][index] + '",';
		          }

		          row.slice(0, row.length - 1);
		          
		          //add a line break after each row
		          CSV += row + '\r\n';
		      }

		      if (CSV == '') {        
		          alert("Invalid data");
		          return;
		      }   
		      
		      //Generate a file name
		      var fileName = "";
		      //this will remove the blank-spaces from the title and replace it with an underscore
		      fileName += ReportTitle.replace(/ /g,"_");   
		      
		      //Initialize file format you want csv or xls
		      var uri = 'data:text/csv;charset=utf-8,' + escape(CSV);
		      
		      // Now the little tricky part.
		      // you can use either>> window.open(uri);
		      // but this will not work in some browsers
		      // or you will not get the correct file extension    
		      
		      //this trick will generate a temp <a /> tag
		      var link = document.createElement("a");    
		      link.href = uri;
		      
		      //set the visibility hidden so it will not effect on your web-layout
		      link.style = "visibility:hidden";
		      link.download = fileName + ".csv";
		      
		      //this part will append the anchor tag and remove it after automatic click
		      document.body.appendChild(link);
		      link.click();
		      document.body.removeChild(link);
		  }

	 
	 function  funClearData(){
		 $('#txtclientname').val('');$('#fleetno').val('');$('#todate').val(new Date());$('#txtcldocno').val('');
		
		 var onemounth=new Date(new Date((new Date())).setMonth(new Date().getMonth()-1)); 
		
		 $('#fromdate').val(onemounth);
           $('#todate').val(new Date());
	     
		 if (document.getElementById("txtclientname").value == "") {
		        $('#txtclientname').attr('placeholder', 'Press F3 to Search'); 
		    }
		 if (document.getElementById("fleetno").value == "") {
		        $('#fleetno').attr('placeholder', 'Press F3 to Search'); 
		    }
	 }
	 
	 
	
	function funreload(event){
		

		  var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
			 
		  // out date
		 	 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
		 	 
		   if(fromdates>todates){
			   
			   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
			 
		   return false;
		  } 
		   else
			   {
			   
			   var docdateval=funDateInPeriod($('#todate').jqxDateTimeInput('getDate'));
				if(docdateval==0){
					$('#todate').jqxDateTimeInput('focus');
					return false;
				}
		
		 var branchval = document.getElementById("cmbbranch").value;
		 var fromdate = $('#fromdate').val();
		 var todate = $('#todate').val();
		 var cldocno = $('#txtcldocno').val();
		 var fleetno = document.getElementById("fleetno").value;
		 $("#overlay, #PleaseWait").show();
		 $("#damageInvoicedDiv").load("damageinvoicelistGrid.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&cldocno='+cldocno+'&fleetno='+fleetno);
			   }
			   }
	
	
	

	
	
</script>

</head>
<body onload="getBranch();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%"  >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%" >
	<jsp:include page="../../heading.jsp"></jsp:include>
		
	<tr><td colspan="2">&nbsp;</td></tr>
    <tr>
	 <td align="right"><label class="branch">From</label></td>
     <td align="left"><div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div></td></tr> 
	<tr>
	<td align="right"><label class="branch">To</label></td>
    <td align="left"><div id="todate" name="todate" value='<s:property value="todate"/>'></div></td>
	</tr>
	<tr><td align="right"><label class="branch">Client</label></td>
	<td align="left"><input type="text" id="txtclientname" name="txtclientname" style="width:71%;height:20px;" readonly="readonly" placeholder="Press F3 to Search"  onkeydown="getClient(event);" value='<s:property value="txtclientname"/>'/>
    <input type="hidden" id="txtcldocno" name="txtcldocno" value='<s:property value="txtcldocno"/>'/></td></tr>
    
     <tr><td align="right"><label class="branch">Fleet</label></td>
	 <td align="left"><input type="text" id="fleetno" style="height:20px;width:71%;" name="fleetno" placeholder="Press F3 To Search" onfocus="this.placeholder = ''" readonly="readonly" value='<s:property value="fleetno"/>' onkeydown="getfleetdata(event);" > </td></tr>
    
    <tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2" align="center"><input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funClearData();">
	
	
	<tr><td colspan="2">&nbsp;</td></tr> 
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr> 
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr> 
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr> 
	<tr><td colspan="2">&nbsp;</td></tr>
	
	</table>
</td>
	</fieldset>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="damageInvoicedDiv"><jsp:include page="damageinvoicelistGrid.jsp"></jsp:include></div></td>
		</tr>
	</table>
</tr>
</table>
</div>

<div id="clientDetailsWindow">
	<div></div><div></div>
</div>
<div id="fleetwindow">
	<div></div><div></div>
</div>
</div> 
</body>
</html>