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

 		var account=document.getElementById("txtaccountsno").value;
 		var accountname=document.getElementById("txtaccountsname").value;
 		
		getdata(account,accountname);
	}
	function getdata(account,accountname){
		 $("#refreshdiv").load('accountDetailsSearchGrid.jsp?accountname='+accountname.replace(/ /g, "%20")+'&account='+account+'&check=1');
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

            <!-- Uniform layout for Account Search -->
            <colgroup>
                <col width="14%">
                <col width="56%">
                <col width="30%">
            </colgroup>

            <!-- Row 1 -->
            <tr>

                <td class="lbl-right">
                    Account
                </td>

                <td>
                    <input type="text"
                           name="txtaccountsno"
                           id="txtaccountsno"
                           value='<s:property value="txtaccountsno"/>'>
                </td>

                <td align="center" rowspan="2">
                    <input type="button"
                           name="btnsearch"
                           id="btnsearch"
                           class="myButton"
                           value="Search"
                           onclick="loadSearch();">
                </td>

            </tr>

            <!-- Row 2 -->
            <tr>

                <td class="lbl-right">
                    Name
                </td>

                <td>
                    <input type="text"
                           name="txtaccountsname"
                           id="txtaccountsname"
                           value='<s:property value="txtaccountsname"/>'>
                </td>

            </tr>

        </table>

    </div>

    <div class="grid-container">

        <div id="refreshdiv">

            <jsp:include page="accountDetailsSearchGrid.jsp"></jsp:include>

        </div>

    </div>

</div>

</body>
</html>