
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
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 
<script type="text/javascript">

$(document).ready(function () {
	
	 $("#uptodate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	
	       
       });
	    
	    
	  

 
 

function funExportBtn(){
	  
	 
	 if(parseInt(window.parent.chkexportdata.value)=="1")
	  {
	  	JSONToCSVCon(dats, 'Traffic Delete', true);
	  }
	 else
	  {
	                 
		 $("#trafficGrid").jqxGrid('exportdata', 'xls', 'Traffic Delete');
	  }
	 
	
	 }

function funreload(event)
{     
 
	  var val ="2";
	  var uptodate=$("#uptodate").val();
	   $("#overlay, #PleaseWait").show();
	  $("#deldiv").load("listGrid.jsp?chval="+val+"&uptodate="+uptodate);
	
	
	}
	
	
	 
function hiddenbrh(){
	
	$("#branchlabel").attr('hidden',true);
	$("#branchdiv").attr('hidden',true);
 
	 
}
		
 
		
</script>
</head>
<body onload="hiddenbrh(); ">
<form id="deletetrafic"   method="post">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%">
    <fieldset style="background: #ECF8E0;">
	<table width="100%">
	<jsp:include page="../../heading.jsp"></jsp:include>
 
	<!--  <tr><td colspan="2">&nbsp;</td></tr> -->

  <tr><td colspan="2">&nbsp;</td></tr> 
   <tr><td colspan="2">&nbsp;</td></tr> 
   
    <tr><td width="20%" align="right"><label class="branch">Up To</label></td><td align="left"><div id='uptodate' name='uptodate' value='<s:property value="uptodate"/>'></div></td></tr> 
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
     <tr><td colspan="2">&nbsp;</td></tr> 
     <tr><td colspan="2">&nbsp;</td></tr> 
     <tr><td colspan="2">&nbsp;</td></tr> 
     <tr><td colspan="2">&nbsp;</td></tr> 

          <tr><td colspan="2"><input type="hidden" id="gridlength" name="gridlength"></td></tr> 
          <tr><td colspan="2"><input type="hidden" id="rentaldoc" name="rentaldoc"></td></tr> 
          <tr><td colspan="2"><input type="hidden" id="leasedoc" name="leasedoc"></td></tr> 
          <tr><td colspan="2"><input type="hidden" id="drdoc" name="drdoc"></td></tr> 
         <tr><td colspan="2"><input type="hidden" id="staffdoc" name="staffdoc"></td></tr> 

	</table>
	
 
 
	 
	
	  
	 <div id="imgdiv" style="position:absolute; z-index: 1;top:200;right:600;"><div hidden="true" id="hidediv"><img  alt="Search User" src="<%=contextPath%>/icons/31load.gif"> </div></div>
	</fieldset>
</td>


<td width="80%">
  
  <div id="deldiv"><jsp:include page="listGrid.jsp"></jsp:include></div></td>
 
		 
  
</tr>
</table>
</div>

 

</div>
</form> 
</body>
</html>