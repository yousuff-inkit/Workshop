<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Gateway ERP</title>
</head>
<style>
/* =========================================================
   SCOPED UI: Segoe UI Font & Clean White Search Panel
========================================================= */
body{
    margin:0;
    background:#fff;
    font-family:'Segoe UI','Roboto','Arial',sans-serif;
}

.modern-ui{
    font-size:12px;
    color:#333;
    padding:10px;
    width:100%;
    box-sizing:border-box;
}

/* Master Input Styles */
.modern-ui input[type="text"],
.modern-ui select{
    width:100%;
    height:24px !important;
    border:1px solid #BDBDBD;
    border-radius:3px;
    padding:2px 6px;
    box-sizing:border-box;
    font-size:12px;
    font-family:'Segoe UI','Roboto','Arial',sans-serif;
    background:#fff;
    color:#333;
}

.modern-ui input[type="text"]:focus,
.modern-ui select:focus{
    border-color:#007bff;
    outline:none;
}

/* Search Panel */
.modern-ui .search-panel{
    background:#fff;
    border:1px solid #BDBDBD;
    border-radius:4px;
    padding:12px 10px;
    margin-bottom:10px;
    width:100%;
    box-sizing:border-box;
}

/* Table */
.modern-ui table{
    width:100%;
    border-collapse:separate;
    border-spacing:8px 10px;
    table-layout:fixed;
}

.modern-ui td{
    vertical-align:middle;
}

.modern-ui .lbl-right{
    text-align:right;
    font-weight:600;
    color:#222;
    font-size:12px;
    white-space:nowrap;
    padding-right:6px;
}

/* Button */
.modern-ui .myButton{
    height:26px;
    padding:0 20px;
    background:#0056b3;
    color:#fff;
    border:none;
    border-radius:3px;
    cursor:pointer;
    font-size:12px;
    font-weight:600;
    font-family:'Segoe UI','Roboto','Arial',sans-serif;
    transition:all .2s;
}

.modern-ui .myButton:hover{
    background:#004494;
}

/* Grid */
.modern-ui .grid-container{
    border:1px solid #BDBDBD;
    background:#fff;
    overflow:hidden;
    width:100%;
}
</style>

<body style="background:#fff;margin:0;">

<div id="search" class="modern-ui">

    <div class="search-panel">

        <table border="0" cellspacing="0" cellpadding="0">

            <!-- 3 Label-Field pairs + Search Button -->
            <colgroup>
                <col width="10%">
                <col width="20%">

                <col width="10%">
                <col width="20%">

                <col width="10%">
                <col width="20%">

                <col width="10%">
            </colgroup>

            <tr>

                <td class="lbl-right">
                    Product Code
                </td>

                <td>
                    <input type="text"
                           name="sumsearchproduct"
                           id="sumsearchproduct">
                </td>

                <td class="lbl-right">
                    Product Name
                </td>

                <td>
                    <input type="text"
                           name="sumsearchproductname"
                           id="sumsearchproductname">
                </td>

                <td class="lbl-right">
                    Brand
                </td>

                <td>
                    <input type="text"
                           name="sumsearchproductbrand"
                           id="sumsearchproductbrand">
                </td>

                <td align="center">
                    <input type="button"
                           name="sumsearchproductbtn"
                           id="sumsearchproductbtn"
                           class="myButton"
                           value="Search">
                </td>

            </tr>

        </table>

    </div>

    <div class="grid-container">

        <div id="sumsearchproductdiv">

            <jsp:include page="productSearch.jsp"></jsp:include>

        </div>

    </div>

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