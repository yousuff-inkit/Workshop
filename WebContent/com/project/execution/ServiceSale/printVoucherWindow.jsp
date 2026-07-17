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
	

$(document).ready(function () {
	getbankname();
	document.getElementById("rdheader").checked=true;
});

function getbankname() {
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText;
			items = items.split('####');
			var banknameItems = items[0].split(",");
			var bankIdItems = items[1].split(",");
			var optionsbanknames = '<option value="">--Select--</option>';
			for (var i = 0; i < banknameItems.length; i++) {
				optionsbanknames += '<option value="' + bankIdItems[i] + '">'
						+ banknameItems[i] + '</option>';
			}
			$("select#cmbprintbankname").html(optionsbanknames);
			
		} else {
		}
	}
	x.open("GET", "getBankName.jsp", true);
	x.send();
}
 	function printlogo() {
 		if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
			var url=document.URL;
			var reurl;
			if( url.indexOf('savesrvsale') >= 0){
				reurl=url.split("savesrvsale");
			}else {
				reurl=url.split("serviceSale.jsp");
			}
			$("#docno").prop("disabled", false);                
			var dtype=$('#formdetailcode').val();
			var brhid=$("#brchName").val();
			var bankdocno=$('#cmbprintbankname').val();
			if($('#cmbprintbankname').val()==''){
	 			$.messager.alert('Message','Choose a Bank.','warning');
	 			return 0;
	 		}
			var header=0;
	 		if(document.getElementById("rdheader").checked==true){
	 			header=1;
	 		} else if(document.getElementById("rdnoheader").checked==true){
	 			header=0;
	 		}
			var win= window.open(reurl[0]+"PRINTServiceSale?docno="+document.getElementById("masterdoc_no").value+"&brhid="+brhid+"&dtype="+dtype+"&header="+header+"&bankdocno="+bankdocno,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=yes,toolbar=yes");
			win.focus();
		} 
		else {
			$.messager.alert('Message','Select a Document....!','warning');
			return false;
		}
 		$('#printWindow').jqxWindow('close');
 	}

 	/* function printnologo(){
 		if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
			var url=document.URL;
			var reurl;
			if( url.indexOf('savesrvsale') >= 0){
				reurl=url.split("savesrvsale");
			}else {
				reurl=url.split("serviceSale.jsp");
			}
			$("#docno").prop("disabled", false);                
			var dtype=$('#formdetailcode').val();
			var brhid=$("#brchName").val();
			var win= window.open(reurl[0]+"PRINTServiceSale?docno="+document.getElementById("masterdoc_no").value+"&brhid="+brhid+"&dtype="+dtype+"&header=0","_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=yes,toolbar=yes");
			win.focus();
		} 
		else {
			$.messager.alert('Message','Select a Document....!','warning');
			return false;
		}
 		$('#printWindow').jqxWindow('close');
 	} */
 	

</script>

<body>
<div id=search>
<br/>
<table width="100%">
<tr>
    <td width="20%" align="right">Bank</td>
    <td colspan="2"><select id="cmbprintbankname" name="cmbprintbankname" style="width:65%;" value='<s:property value="cmbprintbankname"/>'>
      <option value="">--Select--</option></select></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td colspan="2" align="left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" id="rdheader" name="rdo" value="rdheader"><label for="rdheader">With Header</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <input type="radio" id="rdnoheader" name="rdo" value="rdnoheader"><label for="rdnoheader">Without Header</label></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td width="57%" align="center"><input type="button" name="btninv" id="btninv" class="myButton" value="Print"  onclick="printlogo();"></td>
    <td width="36%">&nbsp;</td>
  </tr>
<!-- <tr><td colspan="2" align="center"><h2>Choose the print type</h2></td></tr>
  <tr>
    <td align="center"><input type="button" name="btninv" id="btninv" class="myButton" value="With Header"  onclick="printlogo();"></td>
    <td align="center"><input type="button" name="btnfoc" id="btnfoc" class="myButton" value="With Out Header"  onclick="printnologo();"></td>
    
  </tr> -->
</table>
&nbsp;
  </div>
</body>
</html>