 <%@ taglib prefix="s" uri="/struts-tags" %>
 <% String contextPath=request.getContextPath(); %>
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
	$(document).ready(function () {}); 

 	function loadSearch() {

 		var clientname=document.getElementById("txtclname").value;
 		var cldocno=document.getElementById("txtcldocno").value;
 		var chk = 1;
 		
		getdata(clientname,cldocno,chk);
	}
	function getdata(clientname,cldocno,chk){
		 $("#clientSearchDiv").load('clientSearchGrid.jsp?clientname='+clientname.replace(/ /g, "%20")+'&cldocno='+cldocno+'&chk='+chk);
		}

	</script>
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

/* Search Button */
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

/* Grid Container */
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

            <colgroup>
                <col width="12%">
                <col width="68%">
                <col width="20%">
            </colgroup>

            <tr>

                <td class="lbl-right">
                    Name
                </td>

                <td>
                    <input type="text"
                           name="txtclname"
                           id="txtclname"
                           value='<s:property value="txtclname"/>'>

                    <input type="hidden"
                           name="txtcldocno"
                           id="txtcldocno"
                           value='<s:property value="txtcldocno"/>'>
                </td>

                <td align="center">
                    <input type="button"
                           name="btnsearchClient"
                           id="btnsearchClient"
                           class="myButton"
                           value="Search"
                           onclick="loadSearch();">
                </td>

            </tr>

        </table>

    </div>

    <div class="grid-container">

        <div id="clientSearchDiv">
            <jsp:include page="clientSearchGrid.jsp"></jsp:include>
        </div>

    </div>

</div>

</body>
</html>