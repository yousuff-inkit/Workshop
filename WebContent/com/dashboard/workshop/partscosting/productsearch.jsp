 <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>

<% String contextPath=request.getContextPath();%>
<%String index=request.getParameter("index")==null?"":request.getParameter("index");%>
<html>

<head>

<style>
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
</style>

<script type="text/javascript">

function loadSearch() {
		var index='<%=index%>';
		
		var partno=document.getElementById("partno").value;
		var prdctnme=document.getElementById("prdctnme").value;
		var stock=document.getElementById("stock").value;
		var unit=document.getElementById("unit").value;
	getdata(partno,prdctnme,stock,unit,index);
}

function getdata(partno,prdctnme,stock,unit,index){
	$("#refreshdiv1").load('partsSearchGrid.jsp?partno='+partno+'&prdctnme='+prdctnme+'&stock='+stock+'&unit='+unit+'&index='+index+'&id=1');

	}
</script>
</head>
<body bgcolor="#E0ECF8">
<div id=search>
<table width="100%" >
  <tr >
   <td>
   <table width="100%">
   <tr>
    <td width="13%" align="right"><label style="font:10px Tahoma;">Part No</label></td>
    <td align="left" width="33%"><input type="text" name="partno" id="partno"  style="height:120%;" value='<s:property value="partno"/>'></td>
    <td width="22%" align="right"><label style="font:10px Tahoma;">Product Name</label></td>
    <td width="29%" align="left"><input type="text" name="prdctnme" id="prdctnme" style="height:120%;" value='<s:property value="prdctnme"/>'></td>
    <td>&nbsp;</td>
    </tr>
    <tr>
    <td align="right"><label style="font:10px Tahoma;">Stock</label></td>
    <td align="left" width="33%"><input type="text" name="stock" id="stock"  style="height:120%;" value='<s:property value="stock"/>'></td>
    <td align="right"><label style="font:10px Tahoma;">Unit</label></td>
    <td align="left"><input type="text" name="unit" id="unit" style="height:120%;" value='<s:property value="unit"/>'></td>
    
    <td width="13%" colspan="2" align="center"><input type="button" name="btnrasearch" id="btnrasearch" class="myButton" value="Search"  onclick="loadSearch();"></td>
    <tr>
    </table>
    </td>
  </tr>
  <tr>
    <td colspan="8" align="right">
    <div id="refreshdiv1">
       <jsp:include page="partsSearchGrid.jsp"></jsp:include> 
    </div>
    </td>
  </tr>

</table>
  </div>
</body>
</html>