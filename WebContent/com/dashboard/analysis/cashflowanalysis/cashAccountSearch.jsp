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
	 
	 $( "#btnok_cash" ).click(function() {
  	   
        	var rows = $("#cashAccountSearchGridID").jqxGrid('selectedrowindexes');
        
        	if(rows!="") {
     	 	
        		if(document.getElementById("searchdetails").value=="") {
	           		document.getElementById("searchdetails").value="Cash";	
	           		document.getElementById("txtcash").value="Cash";
	           	}
	           	else{
	           		document.getElementById("searchdetails").value+="\n\nCash";
	           		document.getElementById("txtcash").value+="\nCash";
	           	}
           }
       
        	
           document.getElementById("hidtxtcash").value="";
        	
           for(var i=0;i<rows.length;i++){
        		var dummy=$('#cashAccountSearchGridID').jqxGrid('getcellvalue',rows[i],'description');
        		var docno=$('#cashAccountSearchGridID').jqxGrid('getcellvalue',rows[i],'doc_no');
        		document.getElementById("searchdetails").value+="\n"+dummy;
        		document.getElementById("txtcash").value+="\n"+dummy;
        		if(i==0){
        			document.getElementById("hidtxtcash").value=docno;
        		}
        		else{
        			document.getElementById("hidtxtcash").value+=","+docno;
        		}
        	}
        	$('#cashAccountSearchWindow').jqxWindow('close');
	});


	$( "#btncancel_cash" ).click(function() {
		$('#cashAccountSearchWindow').jqxWindow('close');
	});
	
	
	}); 

 	function loadCashSearch() {
 		var partyname=document.getElementById("txtcashpartyname").value;
 		var accountno=document.getElementById("txtcashaccountno").value;
 		
 		getcashdata(partyname,accountno);
	}	
 	
	function getcashdata(partyname,accountno) {
		 $("#refreshcashdiv").load('cashAccountSearchGrid.jsp?partyname='+partyname.replace(/ /g, "%20")+'&accNo='+accountno+'&den=604&chk=1');
	
	}

	</script>
<body bgcolor="#E0ECF8">
<div id="search">
<table width="100%">
  <tr>
    <td width="6%" align="right" style="font-size:9px;">Name</td>
    <td width="66%"><input type="text" name="txtcashpartyname" id="txtcashpartyname" style="width:80%;height:20px;" value='<s:property value="txtcashpartyname"/>'></td>
    <td colspan="2" align="center"><input type="button" name="btncashsearch" id="btncashsearch" class="myButton" value="Search"  onClick="loadCashSearch();"></td>
  </tr>
  <tr>
    <td align="right" style="font-size:9px;">Account</td>
    <td><input type="text" name="txtcashaccountno" id="txtcashaccountno" style="width:50%;height:20px;" value='<s:property value="txtcashaccountno"/>'></td>
    <td width="14%" align="center"><button type="button" id="btnok_cash" name="btnok" class="myButton">&nbsp;&nbsp;&nbsp;OK&nbsp;&nbsp;&nbsp;</button></td>
    <td width="14%" align="center"><button type="button" id="btncancel_cash" name="btncancel" class="myButton" >Cancel</button></td>
  </tr>
  <tr>
    <td colspan="4"><div id="refreshcashdiv"><jsp:include page="cashAccountSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
</div>
</body>
</html>