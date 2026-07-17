 <%@ taglib prefix="s" uri="/struts-tags" %>
 <% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1"> 
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
<title>GatewayERP(i)</title>

<script type="text/javascript">
$(document).ready(function() {
    var bulkconfig=0;
    //$("#bulkconfig").val();
    if(parseInt(bulkconfig)!=1){
    	$("#btnbulk").hide();  
    }else{
    	$("#btnbulk").show();   
    }
});
   function funbulkinvoicePrint(){   
		var url=document.URL;
		var reurl=url.split("com/");
		var path= "invoicePrintActionV3.action?docno="+$('#invno').val()+"&header="+1+"&branch="+$('#invbrhid').val()+"&jobcarddocno="+$('#jobcarddocno').val()+"&type="+3;              
		var win= window.open(reurl[0]+path,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");		
		win.focus();
	}   
	
 	function funinsurancePrint(){ 
 		var url=document.URL;
		var reurl=url.split("com/");
		var path= "invoicePrintActionV3.action?docno="+$('#invno').val()+"&header="+1+"&branch="+$('#invbrhid').val()+"&jobcarddocno="+$('#jobcarddocno').val()+"&type="+1;            
		var win= window.open(reurl[0]+path,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");		
		win.focus();
 	}    

 	function funcustomerPrint(){          
 		var url=document.URL;
		var reurl=url.split("com/");
		var path= "invoicePrintActionV3.action?docno="+$('#invno').val()+"&header="+1+"&branch="+$('#invbrhid').val()+"&jobcarddocno="+$('#jobcarddocno').val()+"&type="+2;            
		var win= window.open(reurl[0]+path,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");		
		win.focus();  	
	}
</script>

<body>
<div id=search>
<br/><br/><br/><br/><br/><br/>     
<table width="100%">
  <tr>
    <td align="center"><input type="button" name="btnbulk" id="btnbulk" class="myButton" value="Bulk Invoice"  onclick="funbulkinvoicePrint();"></td>
    <td align="center"><input type="button" name="btnjobdetails" id="btnjobdetails" class="myButton" value="Insurance Invoice"  onclick="funinsurancePrint();"></td>
    <td align="center"><input type="button" name="btnwithoutjobdetails" id="btnwithoutjobdetails" class="myButton" value="Customer Invoice"  onclick="funcustomerPrint()"></td>
  </tr>
</table>
<br/><br/><br/><br/><br/><br/>
  </div>
</body>
</html>