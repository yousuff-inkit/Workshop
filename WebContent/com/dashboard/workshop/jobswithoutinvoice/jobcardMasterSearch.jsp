 <%@ taglib prefix="s" uri="/struts-tags" %>
 <%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <% String contextPath=request.getContextPath(); 
 %>
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
	$(document).ready(function () {	 
		$("#searchjobcarddate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null});
		$('#btnsearchjobcard').click(function(e) {
            var jobcardno=$('#searchjobcardno').val();
			var jobcarddate=$('#searchjobcarddate').jqxDateTimeInput('val');
			var estdocno=$('#searchestno').val();
			var gipdocno=$('#searchgipno').val();
			var cldocno=$('#searchcldocno').val();
			var clientname=$('#searchclient').val();
			loadSearchGrid(jobcardno,jobcarddate,estdocno,gipdocno,cldocno,clientname);
        });
	}); 
	
	function loadSearchGrid(jobcardno,jobcarddate,estdocno,gipdocno,cldocno,clientname) {	
		 $("#overlay, #PleaseWait").show(); 
		$('#jobcardsearchdiv').load('jobCardSearchGrid.jsp?jobcardno='+jobcardno+'&jobcarddate='+jobcarddate+'&estdocno='+estdocno+'&gipdocno='+gipdocno+'&cldocno='+cldocno+'&clientname='+clientname+'&id=1');
	}
</script>
<body>
<div id=search>
<table width="100%">
  <tr>
    <td width="14%" align="right" style="font-size:9px;">Job Card #</td>
    <td width="18%"><input type="text" name="searchjobcardno" id="searchjobcardno" style="height:18px;"></td>
    <td width="6%" align="right" style="font-size:9px;">Date</td>
    <td width="15%" align="left"><div id="searchjobcarddate" name="searchjobcarddate"></div></td>
    <td width="7%" align="right" style="font-size:9px;">Est No</td>
    <td width="18%" align="left"><input type="text" name="searchestno" id="searchestno" style="height:18px;"></td>
    <td width="8%" align="right" style="font-size:9px;">GIP No</td>
    <td width="14%" align="left"><input type="text" name="searchgipno" id="searchgipno" style="height:18px;"></td>
    </tr>
  <tr>
    <td align="right" style="font-size:9px;">Client #</td>
    <td><input type="text" name="searchcldocno" id="searchcldocno" style="height:18px;"></td>
    <td align="right" style="font-size:9px;"> Name</td>
    <td colspan="4"><input type="text" name="searchclient" id="searchclient" style="height:18px; width:99%;"></td>
    <td align="center"><button type="button" name="btnsearchjobcard" id="btnsearchjobcard" class="myButton">Search</button></td>
    
  </tr>
  <tr>
    <td colspan="10"><div id="jobcardsearchdiv"><jsp:include page="jobCardSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
  </div>
</body>
</html>