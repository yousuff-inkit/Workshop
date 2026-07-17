
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
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 
<script type="text/javascript">

 
function funExportBtn(){
	   $("#listGridID").jqxGrid('exportdata', 'xls', 'Cost Sheet');
	   hiddenbrh();
	 }

function funreload(event)
{

	/*   var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		 
	  // out date
	 	 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
	 	 
	   if(fromdates>todates){
		   
		   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
		 
	   return false;
	  } 
	   else
		   {
		
	
     var fromdate= $("#fromdate").val();
	 var todate= $("#todate").val();  */
	 var check = 1;
	  $("#detlist").load("listgrid.jsp?check="+check);
	
		 //  }
	}

function hiddenbrh(){
	
	$("#branchlabel").attr('hidden',true);
	$("#branchdiv").attr('hidden',true);
	 
}


</script>




</head>
<body onload="getBranch();hiddenbrh();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%" >
	<jsp:include page="../../heading.jsp"></jsp:include>
	   <tr>
	<td colspan="2" ><br>  </td></tr>
  
    
		 <tr>
	<td colspan="2" ><div id="sidegrid"><jsp:include page="listsidegrid.jsp"></jsp:include>
	</div></td>
	</tr>                  
                           
          <tr> 
	<td colspan="2" ><br>  </td></tr>                        
        <tr> 
	<td colspan="2" ><br>  </td></tr>     
  
    <tr>
	<td colspan="2" ><br>  </td></tr>
                       
	</table>
	</fieldset>
	
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="detlist"><jsp:include page="listgrid.jsp"></jsp:include></div></td>
		</tr>
	</table>
</tr>
</table>

</div>

</div>
</body>
</html>
	 