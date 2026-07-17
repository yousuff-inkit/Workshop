 <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
 
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
 <%--  <jsp:include page="../../../../includes.jsp"></jsp:include>   --%>
<style>
<%-- <link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
 --%>
</style>

	<script type="text/javascript">
	$(document).ready(function () {
		$("#searchdate").jqxDateTimeInput({ width: '100%', height: '15px',formatString:"dd.MM.yyyy",value:null});
		/* document.body.scroll = "no";
		document.body.style.overflow = 'hidden';
		//document.height = window.innerHeight; */
	}); 

 	function mainloadSearch() {
 		
 		if(document.getElementById("searchagmtno").value!=""){
 			if(document.getElementById("searchcmbagmttype").value==""){
 				document.getElementById("errormsg").innerText="";
 				document.getElementById("errormsg").innerText="Agreement Type is Mandatory";
 				return false;
 			}
 		}
 		document.getElementById("errormsg").innerText="";
 		var client=document.getElementById("searchclient").value;
 		var cmbagmttype=document.getElementById("searchcmbagmttype").value;
 		var agmtno=document.getElementById("searchagmtno").value;
 		var docno=document.getElementById("searchdocno").value;
 		var searchdate=$('#searchdate').jqxDateTimeInput('val');
 		document.getElementById("brchName").disabled=false;
 		var searchbranch=$('#brchName').val();
		getdata(client,cmbagmttype,agmtno,docno,searchdate,searchbranch);
 

	}
	 function getdata(client,cmbagmttype,agmtno,docno,searchdate,searchbranch){
		
		 $("#srefreshdiv").load('subMainSearch.jsp?client='+client+'&cmbagmttype='+cmbagmttype+'&agmtno='+agmtno+'&docno='+docno+'&searchdate='+searchdate+'&branch='+searchbranch);
		 

		}
 
	</script>
<body bgcolor="#E0ECF8">
<div id=search>

<table width="100%" >
  <tr>
    <td width="6%" align="right">Client</td>
    <td width="24%" align="left"><input type="text" name="searchclient" id="searchclient"  style="width:96.5%;" value='<s:property value="searchclient"/>'></td>
    <td width="15%" align="right">Ref Type</td>
    <td width="15%" align="left"><select name="searchcmbagmttype" id="searchcmbagmttype"  style="width:99%;"><option value="">--Select--</option>
    <option value="RAG">Rental</option><option value="LAG">Lease</option></select></td>
    <td width="16%" align="right">Agmt No</td>
    <td width="24%" align="left"><input type="text" name="searchagmtno" id="searchagmtno"  value='<s:property value="searchagmtno"/>'></td>
  </tr>
  <tr>
    <td align="right">Date</td>
    <td align="left"><div id="searchdate" name="searchdate"></div></td>
    <td align="right">Doc No</td>
    <td align="left"><input type="text" name="searchdocno" id="searchdocno" value='<s:property value="searchdocno"/>'></td>
    <td align="center">&nbsp;</td>
    <td align="left"><input type="button" name="btninvsearch" id="btninvsearch" class="myButton" value="Search"  onClick="mainloadSearch();"></td>
    
  </tr>
  <tr>
    <td colspan="6" align="right"> 
    <div id="srefreshdiv">
      
   <jsp:include  page="subMainSearch.jsp"></jsp:include> 
   
   </div></td>
    </tr>
</table>

  </div>
</body>
</html>