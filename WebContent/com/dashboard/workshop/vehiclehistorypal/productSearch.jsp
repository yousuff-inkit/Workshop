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
<style>
 

</style>
	<script type="text/javascript">

	$(document).ready(function () { 
	    
		 
		   
	});   
		   
  	function loadSearchss() { // docnoss prdid prdname
 		
 		var docnoss=document.getElementById("docnoss").value;
 		 
 		var prdid=document.getElementById("prdid").value;
 		var prdname=document.getElementById("prdname").value;
 		
 		 

		
	var aa="yes";
		getdatas(docnoss,prdid,prdname,aa);
 

	}
	function getdatas(docnoss,prdid,prdname,aa){
		
		 
			 $("#refsearch").load('productssubsearch.jsp?docnoss='+docnoss+'&prdid='+prdid+'&prdname='+prdname.replace(/ /g, "%20")+'&aa='+aa);
		

		}  
	
	
 
	

	</script>
<style>
/*==========================
    MASTER SEARCH UI
===========================*/

body{
    margin:0;
    padding:8px;
    background:#ffffff !important;
    font-family:"Segoe UI",Tahoma,Arial,sans-serif;
    font-size:12px;
    color:#333;
}

/* Remove project background */
#search{
    background:#ffffff !important;
    padding:0;
    margin:0;
}

/* Search Panel */
.search-panel{
    background:#ffffff !important;
    border:1px solid #cfcfcf;
    border-radius:4px;
    padding:10px;
    margin-bottom:8px;
}

/* Grid Container */
.grid-container{
    background:#ffffff !important;
    border:1px solid #cfcfcf;
    overflow:hidden;
}

/* Table */
.search-table{
    width:100%;
    border-collapse:separate;
    border-spacing:8px 8px;
    table-layout:fixed;
}

.search-table td{
    vertical-align:middle;
}

/* Labels */
.lbl-right{
    text-align:right;
    font-size:12px;
    font-weight:600;
    white-space:nowrap;
    color:#333;
    padding-right:6px;
}

/* Inputs */
.search-input{
    width:100%;
    height:26px;
    border:1px solid #bdbdbd;
    border-radius:3px;
    padding:2px 6px;
    box-sizing:border-box;
    font-size:12px;
    font-family:"Segoe UI",Tahoma,Arial,sans-serif;
    background:#fff;
}

.search-input:focus{
    outline:none;
    border-color:#2d7ff9;
}

/* Button */
.search-btn{
    min-width:95px;
    height:28px;
    background:#1d63d8;
    color:#fff;
    border:none;
    border-radius:3px;
    font-size:12px;
    font-weight:600;
    cursor:pointer;
}

.search-btn:hover{
    background:#1654bb;
}
</style>

<body>

<div id="search">

    <div class="search-panel">

        <table class="search-table">

            <colgroup>
                <col width="10%">
                <col width="25%">
                <col width="15%">
                <col width="35%">
                <col width="15%">
            </colgroup>

            <tr>

                <td class="lbl-right">
                    Product
                </td>

                <td>
                    <input type="text"
                           class="search-input"
                           name="prdid"
                           id="prdid"
                           value='<s:property value="prdid"/>'>
                </td>

                <td class="lbl-right">
                    Product Name
                </td>

                <td>
                    <input type="text"
                           class="search-input"
                           name="prdname"
                           id="prdname"
                           value='<s:property value="prdname"/>'>
                </td>

                <td align="center">
                    <input type="button"
                           id="searchs"
                           name="searchs"
                           value="Search"
                           class="search-btn"
                           onclick="loadSearchss();">
                </td>

            </tr>

        </table>

        <input type="hidden"
               name="docnoss"
               id="docnoss"
               value='<s:property value="docnoss"/>'>

    </div>

    <div class="grid-container">

        <div id="refsearch">

            <jsp:include page="productssubsearch.jsp"></jsp:include>

        </div>

    </div>

</div>

</body>
</html>