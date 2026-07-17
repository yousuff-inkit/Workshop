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
				<td><input type="text" name="detsearchproduct" id="detsearchproduct">
				<td><label class="branch" style="background-color:transparent;">Product Name</label></td>
				<td><input type="text" name="detsearchproductname" id="detsearchproductname">
				<td><button type="button" name="detsearchproductbtn" id="detsearchproductbtn" class="myButton">Search</button></td>
			</tr>
			<tr>
				<td colspan="6"><div id="detsearchproductdiv"><jsp:include page="productSearchdet.jsp"></jsp:include></div></td>
			</tr>
		</table>
	</div>
	
	<script type="text/javascript">
		$(document).ready(function(){
			$('#detsearchproductbtn').click(function(){
				var product=$('#detsearchproduct').val();
				var productname=$('#detsearchproductname').val();
				//var productbrand=$('#detsearchproductbrand').val();
				product=encodeURIComponent(product);
				productname=encodeURIComponent(productname);
				//productbrand=encodeURIComponent(productbrand);
				$('#detsearchproductdiv').load('productSearchdet.jsp?product='+product+'&productname='+productname+'&id=1');
			});
		});
	</script>
</body>
</html>