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

.myButtons1 {
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
.myButtons1:hover {
	  color: #fff;
  background-color: #31b0d5;
  
}
.myButtons1:active {
  color: #fff;
  background-color: #31b0d5;
  
}
.myButtons1:focus {
  color: #fff;
  background-color: grey;
}
</style>

<script type="text/javascript">

	$(document).ready(function () {
		 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		   
		 $('#clientSearchWindow').jqxWindow({ width: '62%', height: '65%',  maxHeight: '85%' ,maxWidth: '80%' , title: 'Client Search' ,position: { x: 250, y: 60 }, theme: 'energyblue', keyboardCloseKey: 27});
		 $('#clientSearchWindow').jqxWindow('close');
		 
		 $('#clientCategorySearchWindow').jqxWindow({ width: '50%',height: '60%',  maxHeight: '80%'  ,maxWidth: '50%' , title: 'Client Category Search' ,position: { x: 250, y: 60 }, theme: 'energyblue', keyboardCloseKey: 27});
		 $('#clientCategorySearchWindow').jqxWindow('close');
		
		 $('#salesmanSearchWindow').jqxWindow({ width: '50%',height: '60%',  maxHeight: '80%'  ,maxWidth: '50%' , title: 'Salesman Search' ,position: { x: 250, y: 60 }, theme: 'energyblue', keyboardCloseKey: 27});
		 $('#salesmanSearchWindow').jqxWindow('close');
		
		 $('#clientStatusSearchWindow').jqxWindow({ width: '50%',height: '60%',  maxHeight: '80%'  ,maxWidth: '50%' , title: 'Client Status Search' ,position: { x: 250, y: 60 }, theme: 'energyblue', keyboardCloseKey: 27});
		 $('#clientStatusSearchWindow').jqxWindow('close');
		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
		 
		 var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	   
	     /* $(".chcksummary").click(function() {
	 	        selectedBox = this.id;

	 	        $(".chcksummary").each(function() {
	 	            if ( this.id == selectedBox )
	 	            {
	 	                this.checked = true;
	 	            }
	 	            else
	 	            {
	 	                this.checked = false;
	 	            };        
	 	        });
	 	    });     */
	 		 
	     document.getElementById("rdall").checked=true;
	});
	
	function funExportBtn(){
	    JSONToCSVConvertor(data, 'ClientAnalysis', true);
	} 
	
	function JSONToCSVConvertor(JSONData, ReportTitle, ShowLabel) {
		
	    var arrData = typeof JSONData != 'object' ? JSON.parse(JSONData) : JSONData;
	    
	    var CSV = '';    
	    
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
	
	function getGridColumnCalculation(fromdate,todate){
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText;
  				 items = items.split('***');
		          var difference=items[0];
		          var columns=items[1];
		          
		          if(parseInt(columns)==1) {
						$.messager.alert('Message','Period is too Long,Limit Reached.','warning');
						return;
		          }else {
		        	  
		        	  var branchval = document.getElementById("cmbbranch").value;
		        	  var summarytype = $('#cmbsummarytype').val();
		        	  var hidclientcat=document.getElementById("hidclientcat").value;
		        	  var hidclient=document.getElementById("hidclient").value;
		        	  var hidclientslm=document.getElementById("hidclientslm").value;
					  var hidclientstatus=document.getElementById("hidclientstatus").value;
		        	  
		     		  var check=1;
		        	  $("#overlay, #PleaseWait").show();
		     		 
		        	  if(document.getElementById("rdall").checked==true){
		        	  		$("#analysisDiv").load("abcAnalysisGrid.jsp?rptType=1&branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&summarytype='+summarytype+"&hidclientcat="+hidclientcat+"&hidclient="+hidclient+"&hidclientslm="+hidclientslm+"&hidclientstatus="+hidclientstatus+'&check='+check);
		        	  }else if(document.getElementById("rdsummary").checked==true){
		        	  		$("#analysisDiv").load("abcAnalysisGrid.jsp?rptType=2&branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&summarytype='+summarytype+"&hidclientcat="+hidclientcat+"&hidclient="+hidclient+"&hidclientslm="+hidclientslm+"&hidclientstatus="+hidclientstatus+'&check='+check);
		        	  }
		          }
    		}
		}
		x.open("GET", "getGridColumnCalculation.jsp?fromdate="+fromdate+"&todate="+todate, true);
		x.send();
   }
	
	/* function clientcheck(){
		if(document.getElementById("chckclient").checked){
			 document.getElementById("hidchckclient").value = 1;document.getElementById("hidchckcategory").value = 0;
		 }
		 else{
			 document.getElementById("hidchckclient").value = 0;
		 }
	 } */
	
	/* function categorycheck(){
		if(document.getElementById("chckcategory").checked){
			 document.getElementById("hidchckcategory").value = 1;document.getElementById("hidchckclient").value = 0;
		 }
		 else{
			 document.getElementById("hidchckcategory").value = 0;
		 }
	 } */
	
	function summaryDisable(){
		if(document.getElementById("rdall").checked==true){
			$('#cmbsummarytype').attr('disabled', true);
		}else if(document.getElementById("rdsummary").checked==true){
			$('#cmbsummarytype').attr('disabled', false);
		}
	}
	
	function funreload(event){
		 var fromdate = $('#fromdate').val();
		 var todate = $('#todate').val();
		 
		 if(fromdate==todate) {
				$.messager.alert('Message','Not a Valid Period,From Date & To Date are Same.','warning');
				return;
         }
		 
		 if(document.getElementById("rdsummary").checked==true){
		 	if($('#cmbsummarytype').val()=='') {
				$.messager.alert('Message','Please Choose a Summary Type.','warning');
				return;
		 	}
         }
		 
		 getGridColumnCalculation(fromdate,todate);
	}
	
	function clientSearchContent(url) {
	    $('#clientSearchWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#clientSearchWindow').jqxWindow('setContent', data);
		$('#clientSearchWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function clientCategorySearchContent(url) {
	    $('#clientCategorySearchWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#clientCategorySearchWindow').jqxWindow('setContent', data);
		$('#clientCategorySearchWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function salesmanSearchContent(url) {
	    $('#salesmanSearchWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#salesmanSearchWindow').jqxWindow('setContent', data);
		$('#salesmanSearchWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function clientStatusSearchContent(url) {
	    $('#clientStatusSearchWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#clientStatusSearchWindow').jqxWindow('setContent', data);
		$('#clientStatusSearchWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function getClient(){
	 	 clientSearchContent('clientSearch.jsp');
	}

	function getClientCategory(){
		 clientCategorySearchContent('clientCategorySearch.jsp?id=1');
	}
	
	function getClientSalesman(){
		salesmanSearchContent('clientSalesManSearch.jsp?id=2');
	}

	function getClientStatus(){
		clientStatusSearchContent('clientStatusSearch.jsp?id=3');
	}
	
	function setSearch(){
		
		var value=$('#searchby').val().trim();
		
		if(value=="clientcat"){
			getClientCategory();
		}
		else if(value=="client"){
			getClient();
		}
		else if(value=="clientslm"){
			getClientSalesman();
		}
		else if(value=="clientstatus"){
			getClientStatus();
		}
		else{}
	}
	
	function setRemove(){
		
		var value=$('#searchby').val().trim();
		
		if(value=="client"){
			document.getElementById("searchdetails").value="";
			document.getElementById("client").value="";
			document.getElementById("hidclient").value="";
			if(document.getElementById("clientcat").value!=""){
				   document.getElementById("searchdetails").value+=document.getElementById("clientcat").value; 
			} if(document.getElementById("clientslm").value!=""){
				   document.getElementById("searchdetails").value+=document.getElementById("clientslm").value; 
			} if(document.getElementById("clientstatus").value!=""){
				   document.getElementById("searchdetails").value+=document.getElementById("clientstatus").value; 
			}
		} else if(value=="clientcat"){
			document.getElementById("searchdetails").value="";
			document.getElementById("clientcat").value="";
			document.getElementById("hidclientcat").value="";
			if(document.getElementById("client").value!=""){
				   document.getElementById("searchdetails").value+=document.getElementById("client").value; 
			} if(document.getElementById("clientslm").value!=""){
				   document.getElementById("searchdetails").value+=document.getElementById("clientslm").value; 
			} if(document.getElementById("clientstatus").value!=""){
				   document.getElementById("searchdetails").value+=document.getElementById("clientstatus").value; 
			}
		} else if(value=="clientslm"){
			document.getElementById("searchdetails").value="";
			document.getElementById("clientslm").value="";
			document.getElementById("hidclientslm").value="";
			if(document.getElementById("client").value!=""){
				   document.getElementById("searchdetails").value+=document.getElementById("client").value; 
			} if(document.getElementById("clientcat").value!=""){
				   document.getElementById("searchdetails").value+=document.getElementById("clientcat").value; 
			} if(document.getElementById("clientstatus").value!=""){
				   document.getElementById("searchdetails").value+=document.getElementById("clientstatus").value; 
			}
		} else if(value=="clientstatus"){
			document.getElementById("searchdetails").value="";
			document.getElementById("clientstatus").value="";
			document.getElementById("hidclientstatus").value="";
			if(document.getElementById("client").value!=""){
				   document.getElementById("searchdetails").value+=document.getElementById("client").value; 
			} if(document.getElementById("clientcat").value!=""){
				   document.getElementById("searchdetails").value+=document.getElementById("clientcat").value; 
			} if(document.getElementById("clientslm").value!=""){
				   document.getElementById("searchdetails").value+=document.getElementById("clientslm").value; 
			} 
		}
	}
	
	function funClearData(){
		$('#cmbbranch').val('a');
   	    $('#fromdate').val(new Date());
   	    var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	    var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	    var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	    $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	     
		$('#todate').val(new Date());
		
		document.getElementById("rdall").checked=true;		
		document.getElementById("searchdetails").value="";document.getElementById("searchby").value="";document.getElementById("clientcat").value="";
		document.getElementById("hidclientcat").value="";document.getElementById("client").value="";document.getElementById("hidclient").value="";
		document.getElementById("clientslm").value="";document.getElementById("hidclientslm").value="";document.getElementById("clientstatus").value="";
		document.getElementById("hidclientstatus").value="";
		summaryDisable();
	}
	
</script>
</head>
<body onload="getBranch();summaryDisable();">
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
	<tr><td colspan="2">
	  <fieldset><legend><b><label class="branch">Report Type</label></b></legend>
	  <table width="100%">
      <tr>
      <td width="40%" align="left"><input type="radio" id="rdall" name="rdo" onclick="summaryDisable();" value="rdall"><label for="rdall" class="branch">All</label></td>
      <td width="60%">&nbsp;</td>
      </tr>
      <tr>
      <td align="left"><input type="radio" id="rdsummary" name="rdo" onclick="summaryDisable();" value="rdsummary"><label for="rdsummary" class="branch">Summary</label></td>
      <td>
      
      <select id="cmbsummarytype" name="cmbsummarytype" style="width:80%;" onchange="clearAccountInfo();" value='<s:property value="cmbsummarytype"/>'>
      <option value="">--Select--</option><option value="CRM">Client</option><option value="CAT">Client Category</option>
	  <option value="PCASE">Client Status</option><option value="SLM">Salesman</option></select>
      
      <%--<fieldset>
       <table width="100%">
      <tr><td><input type="checkbox" id="chckclient" class="chcksummary" name="chckclient" value="" onchange="clientcheck();" onclick="$(this).attr('value', this.checked ? 1 : 0)" /><label class="branch">Client</label>
              <input type="hidden" id="hidchckclient" name="hidchckclient" value='<s:property value="hidchckclient"/>'/></td>
      </tr>
      <tr><td><input type="checkbox" id="chckcategory" class="chcksummary" name="chckcategory" value="" onchange="categorycheck();" onclick="$(this).attr('value', this.checked ? 1 : 0)" /><label class="branch">Category</label>
              <input type="hidden" id="hidchckcategory" name="hidchckcategory" value='<s:property value="hidchckcategory"/>'/></td>
      </tr>
     </table> 
      </fieldset>--%>
      
      </td>
      </tr>
      </table></fieldset>
	</td></tr>  
	<tr><td colspan="2">
	<table width="100%">
  <tr>
    <td align="right"><label class="branch">Search By</label></td>
    <td align="left"><select name="searchby" id="searchby"><option value="">--Select--</option>
	<option value="client">Client</option><option value="clientcat">Client Category</option>
	<option value="clientstatus">Client Status</option><option value="clientslm">Salesman</option></select></td>
    <td><button type="button" name="btnadditem" id="additem" class="myButtons1" onClick="setSearch();">+</button></td>
    <td><button type="button" name="btnremoveitem" id="btnremoveitem" class="myButtons1" onclick="setRemove();">-</button></td>
  </tr>
  <tr>
    <td colspan="4" align="center"><textarea id="searchdetails" style="height:140px;width:230px;font: 10px Tahoma;resize:none" name="searchdetails" readonly="readonly"><s:property value="searchdetails"></s:property></textarea>
    </td>
  </tr>
</table></td></tr>
	<tr><td colspan="2"><center><input type="button" name="btnclear" id="btnclear" value="Clear" class="myButtons" onclick="funClearData();"></center></td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2"><input type="hidden" name="client" id="client"><input type="hidden" name="hidclient" id="hidclient">
			  <input type="hidden" name="clientcat" id="clientcat"><input type="hidden" name="hidclientcat" id="hidclientcat">
			  <input type="hidden" name="clientstatus" id="clientstatus"><input type="hidden" name="hidclientstatus" id="hidclientstatus">
			  <input type="hidden" name="clientslm" id="clientslm"><input type="hidden" name="hidclientslm" id="hidclientslm"></td></tr>  
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="analysisDiv"><jsp:include page="abcAnalysisGrid.jsp"></jsp:include></div></td>
		</tr>
	</table>
</tr>
</table>
</div>

<div id="clientSearchWindow">
	<div></div><div></div>
</div>
<div id="clientCategorySearchWindow">
	<div></div><div></div>
</div>
<div id="salesmanSearchWindow">
	<div></div><div></div>
</div>
<div id="clientStatusSearchWindow">
	<div></div><div></div>
</div>
</div>
</body>
</html>