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
 	function funWithVatPrint(){      
 		var url=document.URL;
		var reurl=url.split("com/");
		var docno=$('#docno').val();   
		var gatedoc=$('#gatedocno').val();
		var printchk=$('#printchk').val(); 
		
		var path= "com/workshop/estimationv3/printEstimationv3.action?estDocno="+$('#vocno').val()+"&docno="+docno+"&gatedocno="+gatedoc+"&branch="+$('#brchName').val()+"&addition="+$('#addition').val()+"&withvat="+1+"&printchk="+printchk;       
		console.log(reurl[0]+" = "+path);
		var win= window.open(reurl[0]+path,"_blank","top=250,left=310,Width=700,Height=600,location=no,scrollbars=yes,toolbar=yes");	          	
		win.focus();
 	}    

 	function funWithoutVatPrint(){      
 		var url=document.URL;
		var reurl=url.split("com/");
		var docno=$('#docno').val();   
		var gatedoc=$('#gatedocno').val(); 
		var printchk=$('#printchk').val(); 
		var path= "com/workshop/estimationv3/printEstimationv3.action?estDocno="+$('#vocno').val()+"&docno="+docno+"&gatedocno="+gatedoc+"&branch="+$('#brchName').val()+"&addition="+$('#addition').val()+"&withvat="+0+"&printchk="+printchk;       
		console.log(reurl[0]+" = "+path);
		var win= window.open(reurl[0]+path,"_blank","top=250,left=310,Width=700,Height=600,location=no,scrollbars=yes,toolbar=yes");	          	
		win.focus();    	
	}
 	function funWithVatPrintLine(){      
 		var url=document.URL;
		var reurl=url.split("com/");
		var docno=$('#docno').val();   
		var gatedoc=$('#gatedocno').val();
		var printchk=$('#printchk').val(); 
		
		var path= "com/workshop/estimationv3/printEstimationv3.action?estDocno="+$('#vocno').val()+"&docno="+docno+"&gatedocno="+gatedoc+"&branch="+$('#brchName').val()+"&addition="+$('#addition').val()+"&withvat="+3+"&printchk="+printchk;       
		console.log(reurl[0]+" = "+path);
		var win= window.open(reurl[0]+path,"_blank","top=250,left=310,Width=700,Height=600,location=no,scrollbars=yes,toolbar=yes");	          	
		win.focus();
 	}    

 	function funWithoutVatPrintLine(){            
 		var url=document.URL;
		var reurl=url.split("com/");
		var docno=$('#docno').val();   
		var gatedoc=$('#gatedocno').val(); 
		var printchk=$('#printchk').val(); 
		var path= "com/workshop/estimationv3/printEstimationv3.action?estDocno="+$('#vocno').val()+"&docno="+docno+"&gatedocno="+gatedoc+"&branch="+$('#brchName').val()+"&addition="+$('#addition').val()+"&withvat="+4+"&printchk="+printchk;       
		console.log(reurl[0]+" = "+path);
		var win= window.open(reurl[0]+path,"_blank","top=250,left=310,Width=700,Height=600,location=no,scrollbars=yes,toolbar=yes");	          	
		win.focus();    	
	}	
	$(document).ready(function(){
		var htmldata='';
		if(rawconfig.estPrintDropdown.method=="1"){
			//Client Comes First
			htmldata+='<option value="1">Client</option>';
		    htmldata+='<option value="2">Insurance Company</option>';
		}
		else{
			//Insurance Comp. Comes First
			htmldata+='<option value="2">Insurance Company</option>';
			htmldata+='<option value="1">Client</option>';
		}
		$('#printchk').html($.parseHTML(htmldata));
	});
</script>

<body>
<div id=search>
<br/><br/><br/><br/><br/><br/>     
<table width="100%">
<tr>
<td align="center" colspan=2><select name="printchk" id="printchk" value='<s:property value="printchk"/>'>
           
            
            <option value=2>Insurance Company</option>
           <option value=1>Client</option>
        </select></td>
</tr>
<tr>
	<td align="center"><input type="button" name="btnjobdetails" id="btnjobdetails" class="myButton" value="With Vat Line Discount"  onclick="funWithVatPrint();"></td>
	<td align="center"><input type="button" name="btnwithoutjobdetails" id="btnwithoutjobdetails" class="myButton" value="Without Vat Line Discount"  onclick="funWithoutVatPrint()"></td>
  	<td align="center"><input type="button" name="btnjobdetails" id="btnjobdetails" class="myButton" value="With Vat "  onclick="funWithVatPrintLine();"></td>  
  	<td align="center"><input type="button" name="btnwithoutjobdetails" id="btnwithoutjobdetails" class="myButton" value="Without Vat"  onclick="funWithoutVatPrintLine()"></td>
  </tr>
</table>
<br/><br/><br/><br/><br/><br/>
  </div>
</body>
</html>