 <%@ taglib prefix="s" uri="/struts-tags" %>
 <% String contextPath=request.getContextPath(); %>
  <%String iid = request.getParameter("id")==null?"0":request.getParameter("id");%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
<title>GatewayERP(i)</title>

<style type="text/css">
#search {
    background-color: #E0ECF8;
}
</style>

	<script type="text/javascript">
	var idd='<%=iid%>';
	var id;
	$(document).ready(function () {}); 

 	function loadSearch() {
 		if(idd==1){
 			id=1;
 		}
 		else if(idd==2){
 			id=2;
 		}
 		var clientsname=document.getElementById("txtclientsname").value;
 		var docno=document.getElementById("txtdocno").value;
 		var mobile=document.getElementById("txtmobile").value;
 		var email=document.getElementById("txtemail").value;
 		
		getdata(clientsname,docno,mobile,email,id);
	}
 	
	function getdata(clientsname,docno,mobile,email,id){
		 $("#refreshdiv").load('clientDetailsSearchGrid.jsp?id='+id+'&clientname='+clientsname.replace(/ /g, "%20")+'&mobile='+mobile+'&email='+email+'&docno='+docno+'&check=1');
		}

	</script>
<body>
<div id=search>
<table width="100%">
  <tr>
    
    <td width="17%" align="right" style="font-size:9px;">Doc No.</td>
    <td width="23%"><input type="text" name="txtdocno" id="txtdocno" style="width:90%;height:20px;" value='<s:property value="txtdocno"/>'></td>
    <td width="6%" align="right" style="font-size:9px;">Name</td>
    <td width="45%"><input type="text" name="txtclientsname" id="txtclientsname" style="width:100%;height:20px;" value='<s:property value="txtclientsname"/>'></td>
   </tr>
   <tr>
    <td width="17%" align="right" style="font-size:9px;">Mobile No.</td>
    <td width="23%"><input type="text" name="txtmobile" id="txtmobile" style="width:90%;height:20px;" value='<s:property value="txtmobile"/>'></td>
    <td width="6%" align="right" style="font-size:9px;">Email</td>
    <td width="45%"><input type="text" name="txtemail" id="txtemail" style="width:100%;height:20px;" value='<s:property value="txtemail"/>'></td>
   
  <td width="9%" align="center"><input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search"  onclick="loadSearch();"></td>
  </tr>
  <tr>
    <td colspan="5"><div id="refreshdiv"><jsp:include page="clientDetailsSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
  </div>
</body>
</html>