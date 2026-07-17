<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Gateway ERP</title>
</head>
<body>
	<div id="search">
		<table style="width:100%;">
		<tr>
			<td><label class="branch" style="background-color:transparent;">Product Code</label></td>
			<td><input type="text" name="sumsearchproduct" id="sumsearchproduct">
			<td><label class="branch" style="background-color:transparent;">Product Name</label></td>
			<td><input type="text" name="sumsearchproductname" id="sumsearchproductname">
			<td><label class="branch" style="background-color:transparent;">Brand</label></td>
			<td><input type="text" name="sumsearchproductbrand" id="sumsearchproductbrand">
			<td><button type="button" name="sumsearchproductbtn" id="sumsearchproductbtn" class="myButton">Search</button></td>
		</tr>
		<tr>
			<td colspan="7"><div id="sumsearchproductdiv"><jsp:include page="productSearch.jsp"></jsp:include></div></td>
		</tr>
	</table>
	</div>
	
	<script type="text/javascript">
		$(document).ready(function(){
			$('#sumsearchproductbtn').click(function(){
				var brandid='<%=request.getParameter("brandid")==null?"":request.getParameter("brandid")%>';
				var catid='<%=request.getParameter("catid")==null?"":request.getParameter("catid")%>';
				var subcatid='<%=request.getParameter("subcatid")==null?"":request.getParameter("subcatid")%>';
				var product=$('#sumsearchproduct').val();
				var productname=$('#sumsearchproductname').val();
				var productbrand=$('#sumsearchproductbrand').val();
				product=encodeURIComponent(product);
				productname=encodeURIComponent(productname);
				productbrand=encodeURIComponent(productbrand);
				$('#sumsearchproductdiv').load('productSearch.jsp?brandid='+brandid+'&catid='+catid+'&subcatid='+subcatid+'&product='+product+'&productname='+productname+'&productbrand='+productbrand+'&id=1');
			});
		});
	</script>
</body>
</html>