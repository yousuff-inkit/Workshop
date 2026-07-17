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
		
		if ($("#txtdoctype").val() == "CPV") {
			$('#btncheque').attr('disabled', true);
		} else {
			$('#btncheque').attr('disabled', false);
		}
			
	});

 	function printVoucher() {

        var url=document.URL;
        var reurl=url.split("saveRentalRefund");
        $("#txtsrno").prop("disabled", false);

        var win= window.open(reurl[0]+"printRentalRefund?srno="+document.getElementById("txtsrno").value+"&branch="+document.getElementById("brchName").value,"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
	    win.focus();
				
 	}
 	
 	function printCheque(){
 		
        var url=document.URL;
        var reurl=url.split("saveRentalRefund");
        $("#docno").prop("disabled", false);  
        
		var win= window.open(reurl[0]+"printRefundCheque?docno="+document.getElementById("docno").value+"&dtype="+document.getElementById("txtdoctype").value+"&branch="+document.getElementById("brchName").value,"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
	    win.focus();
	    
 	}

</script>

<body>
<div id=search>
<br/><br/><br/><br/><br/><br/>
<table width="100%">
  <tr>
    <td align="center"><input type="button" name="btnvoucher" id="btnvoucher" class="myButton" value="Voucher"  onclick="printVoucher();"></td>
    <td align="center"><input type="button" name="btncheque" id="btncheque" class="myButton" value="Cheque"  onclick="printCheque();"></td>
  </tr>
</table>
<br/><br/><br/><br/><br/><br/>
  </div>
</body>
</html>