 <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
 
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
 <%--   <jsp:include page="../../../../includes.jsp"></jsp:include>   --%>   
<style>
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
</style>

	<script type="text/javascript">
	$(document).ready(function () {
	  $("#reqdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null}); 
	}); 

 	function reqloadSearch() {
 		
 		var reqdate=$('#reqdate').jqxDateTimeInput('val');
 		 var reqname=document.getElementById("reqname").value;
 		var reqmob=document.getElementById("reqmob").value;
 		var reqtype=document.getElementById("cmbreqtype").value;
 		var reqdocno=document.getElementById("reqdocno").value; 
 		var reqbranch='<%=request.getParameter("branch")%>';
	
	getdata1(reqname,reqdocno,reqmob,reqdate,reqtype,reqbranch);
 

	}
	function getdata1(reqname,reqdocno,reqmob,reqdate,reqtype,reqbranch){
	
		$("#reqsearchdiv").load('reqSearchGrid.jsp?reqname='+reqname+'&reqdocno='+reqdocno+'&reqmob='+reqmob+'&reqdate='+reqdate+'&reqtype='+reqtype+'&reqbranch='+reqbranch+'&id=1');
		
		}

	</script>
<body bgcolor="#E0ECF8">
<div id=search>
  <table width="100%">
    <tr>
      <td align="right">Doc No</td>
      <td align="left"><input type="text" name="reqdocno" id="reqdocno"></td>
      <td align="right">Name</td>
      <td colspan="2" align="left"><input type="text" name="reqname" id="reqname" style="width:99%;"></td>
      <td align="right">Mobile</td>
      <td align="left"><input type="text" name="reqmob" id="reqmob"></td>
    </tr>
    <tr>
      <td align="right">Date</td>
      <td align="left"><div id="reqdate"></div></td>
      <td align="right">Type</td>
      <td align="left"><select name="cmbreqtype" id="cmbreqtype">
      <option value="">--Select--</option>
      <option value="0">General</option>
      <option value="1">Client</option></select></td>
      <td>&nbsp;</td>
      <td align="center"><button type="button" name="btnreqsearch" id="btnreqsearch" class="myButton" onclick="reqloadSearch();">Search</button></td>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td colspan="7"><div id="reqsearchdiv"><jsp:include page="reqSearchGrid.jsp"></jsp:include></div></td>
    </tr>
  </table>
</div>
</body>
</html>