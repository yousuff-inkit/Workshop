
<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>

<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<script type="text/javascript" src="<%=contextPath%>/js/ajaxfileupload.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/resample.js"></script>
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 
<script type="text/javascript">

$(document).ready(function () {
	 
	 
	
	     $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	     $("body").prepend('<div id="overlaysub" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWaitsub' style='display: none;position:absolute; z-index: 1;top:230px;left:120px;'><img src='../../../../icons/31load.gif'/></div>");
	     $('#accountWindow').jqxWindow({ width: '25%', height: '70%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Account Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		 $('#accountWindow').jqxWindow('close');
	 	$("#branchlabel").css("opacity","0");$("#branchdiv").css("opacity","0");
});

function funreload(event)
{
	 var barchval = document.getElementById("cmbbranch").value;
  $("#overlaysub, #PleaseWaitsub").show();
 $("#accountControlReg").load("accountControlRegGrid.jsp?&id=1");
	}
	
function getAccount(rowBoundIndex){
	  $('#accountWindow').jqxWindow('open');

    accountSearch('accountsSearchGL.jsp?rowBoundIndex='+rowBoundIndex);
 	 }
	 
function accountSearch(url) {
	//alert(url);
		 $.get(url).done(function (data) {
		//	 alert(data);
	$('#accountWindow').jqxWindow('setContent', data);
		 }); 
	}
function funExportBtn(){
	JSONToCSVCon(accountexcel, 'Accounts Setup', true);
}  
function funupdate(codename,acno){
	  $.messager.confirm('Message', 'Do you want to save changes?', function(r){
	     	  
		        
	     	if(r==false)
	     	  {
	     		return false; 
	     	  }
	     	else{
	     		 updatedata(codename,acno);	
	     	}
		     });
	
	
	
}
function updatedata(codename,acno)
{
	
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
	if (x.readyState==4 && x.status==200)
		{
		
     			
			var items=x.responseText;
			 if(items==1){		
			 
			  $.messager.alert('Message', '  Record Successfully Updated ', function(r){
				  var barchval = document.getElementById("cmbbranch").value;
				  $("#overlaysub, #PleaseWaitsub").show();
				 $("#accountControlReg").load("accountControlRegGrid.jsp?&id=1");
				  
		 		 
			     
		     });
			 funreload(event); 
			 }
			}
	}
		
x.open("GET","savedata.jsp?codename="+codename+"&acno="+acno,true);

x.send();
		
}

</script>
</head>
<body onload="setval()">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%"  >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%" >
	<jsp:include page="../../heading.jsp"></jsp:include>
	  </table> 
	  <div style="display: table; height: 170px; width:100%; overflow: hidden; ">
  		 <div style="display: table-cell; vertical-align: middle;">
<table>
	 <tr><td>&nbsp;</td></tr>
	  <tr><td>&nbsp;</td></tr>
	 <tr><td>&nbsp;</td></tr>
	 <tr><td>&nbsp;</td></tr>
	 <tr><td>&nbsp;</td></tr>
	 <tr><td>&nbsp;</td></tr>
	 <tr><td>&nbsp;</td></tr>
	 <tr><td>&nbsp;</td></tr>
	 <tr><td>&nbsp;</td></tr>
	 <tr><td>&nbsp;</td></tr>
	 <tr><td>&nbsp;</td></tr>
	 <tr><td>&nbsp;</td></tr>
	 <tr><td>&nbsp;</td></tr>
	 <tr><td>&nbsp;</td></tr>
	 <tr><td>&nbsp;</td></tr>
	 <tr><td>&nbsp;</td></tr>
	 <tr><td>&nbsp;</td></tr>
	 <tr><td>&nbsp;</td></tr>
 </table>

</div>
</div>
<input type="hidden" name="hidocno" id="hidocno" style="height:20px;width:70%;" value='<s:property value="hidocno"/>' >
<input type="hidden" name="chkvalue" id="chkvalue" style="height:20px;width:70%;" value='<s:property value="chkvalue"/>' >
	</fieldset>

</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="accountControlReg"><jsp:include page="accountControlRegGrid.jsp"></jsp:include></div></td>
		</tr>
	</table>
</tr>

</table>

</div>
 <div id="accountWindow">
   <div></div>
</div>
</div>
</body>
</html>