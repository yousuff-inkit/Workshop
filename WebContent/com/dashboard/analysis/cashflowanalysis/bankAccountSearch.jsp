 <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />

<script type="text/javascript">
	
	$(document).ready(function () {
	 
	 $( "#btnok_bank" ).click(function() {
  	   
        	var rows = $("#bankAccountSearchGridID").jqxGrid('selectedrowindexes');
        
        	if(rows!="") {
     	 	
        		if(document.getElementById("searchdetails").value=="") {
	           		document.getElementById("searchdetails").value="Bank";	
	           		document.getElementById("txtbank").value="Bank";
	           	}
	           	else{
	           		document.getElementById("searchdetails").value+="\n\nBank";
	           		document.getElementById("txtbank").value+="\nBank";
	           	}
           }
       
        	
           document.getElementById("hidtxtbank").value="";
        	
           for(var i=0;i<rows.length;i++){
        		var dummy=$('#bankAccountSearchGridID').jqxGrid('getcellvalue',rows[i],'description');
        		var docno=$('#bankAccountSearchGridID').jqxGrid('getcellvalue',rows[i],'doc_no');
        		document.getElementById("searchdetails").value+="\n"+dummy;
        		document.getElementById("txtbank").value+="\n"+dummy;
        		if(i==0){
        			document.getElementById("hidtxtbank").value=docno;
        		}
        		else{
        			document.getElementById("hidtxtbank").value+=","+docno;
        		}
        	}
        	$('#bankAccountSearchWindow').jqxWindow('close');
	});


	$( "#btncancel_bank" ).click(function() {
		$('#bankAccountSearchWindow').jqxWindow('close');
	});
	
	
	}); 

 	function loadBankSearch() {
 		var partyname=document.getElementById("txtbankpartyname").value;
 		var accountno=document.getElementById("txtbankaccountno").value;
 		
 		getbankdata(partyname,accountno);
	}	
 	
	function getbankdata(partyname,accountno) {
		 $("#refreshbankdiv").load('bankAccountSearchGrid.jsp?partyname='+partyname.replace(/ /g, "%20")+'&accNo='+accountno+'&den=305&chk=1');
	
	}

	</script>
<body bgcolor="#E0ECF8">
<div id="search">
<table width="100%">
  <tr>
    <td width="6%" align="right" style="font-size:9px;">Name</td>
    <td width="66%"><input type="text" name="txtbankpartyname" id="txtbankpartyname" style="width:80%;height:20px;" value='<s:property value="txtbankpartyname"/>'></td>
    <td colspan="2" align="center"><input type="button" name="btnbanksearch" id="btnbanksearch" class="myButton" value="Search"  onClick="loadBankSearch();"></td>
  </tr>
  <tr>
    <td align="right" style="font-size:9px;">Account</td>
    <td><input type="text" name="txtbankaccountno" id="txtbankaccountno" style="width:50%;height:20px;" value='<s:property value="txtbankaccountno"/>'></td>
    <td width="14%" align="center"><button type="button" id="btnok_bank" name="btnok" class="myButton">&nbsp;&nbsp;&nbsp;OK&nbsp;&nbsp;&nbsp;</button></td>
    <td width="14%" align="center"><button type="button" id="btncancel_bank" name="btncancel" class="myButton" >Cancel</button></td>
  </tr>
  <tr>
    <td colspan="4"><div id="refreshbankdiv"><jsp:include page="bankAccountSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
</div>
</body>
</html>