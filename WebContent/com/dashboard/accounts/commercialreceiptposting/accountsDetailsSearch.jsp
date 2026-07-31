 <%@ taglib prefix="s" uri="/struts-tags" %>
 <% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />

<script type="text/javascript">
	$(document).ready(function () {}); 
	
	function loadAccountSearch() {
			var accountsno=document.getElementById("txtaccountsno").value;
			var accountsname=document.getElementById("txtaccountsname").value;
			var dates=$('#todate').val();
			var check = 1;
	
			getAccountDetails(accountsno,accountsname,dates,check);
	}
		
	function getAccountDetails(accountsno,accountsname,dates,check){
		 $("#refreshAccountDetailsDiv").load("accountDetailsSearchGrid.jsp?accountno="+accountsno+'&accountname='+accountsname.replace(/ /g, "%20")+'&dates='+dates+'&check='+check);
	}

</script>
<style>
/* =========================================================
   SCOPED UI : MASTER SEARCH UI
========================================================= */
body{
    margin:0 !important;
    background:#ffffff !important;
    font-family:'Segoe UI','Roboto','Arial',sans-serif !important;
}

/* Override project theme */
.modern-ui,
.modern-ui *,
#search,
.search-panel,
.grid-container{
    font-family:'Segoe UI','Roboto','Arial',sans-serif !important;
}

/* Inputs */
.modern-ui input[type="text"],
.modern-ui select{
    width:100%;
    height:24px !important;
    border:1px solid #BDBDBD !important;
    border-radius:3px;
    padding:2px 6px;
    font-size:12px !important;
    color:#333;
    background:#fff !important;
    box-sizing:border-box;
}

.modern-ui input[type="text"]:focus,
.modern-ui select:focus{
    outline:none;
    border-color:#007bff !important;
}

/* Search Panel */
.modern-ui .search-panel{
    background:#fff !important;
    border:1px solid #BDBDBD !important;
    border-radius:4px;
    padding:12px 10px;
    margin-bottom:10px;
    box-sizing:border-box;
}

/* Table */
.modern-ui table{
    width:100%;
    table-layout:fixed;
    border-collapse:separate;
    border-spacing:8px 10px;
}

.modern-ui td{
    vertical-align:middle;
}

/* Labels */
.modern-ui .lbl-right{
    text-align:right;
    font-size:12px !important;
    font-weight:600;
    color:#222;
    white-space:nowrap;
    padding-right:6px;
}

/* Button */
.modern-ui .myButton{
    height:26px !important;
    min-width:95px;
    padding:0 20px;
    background:#0056b3 !important;
    background-image:none !important;
    color:#fff !important;
    border:none !important;
    border-radius:3px;
    font-size:12px !important;
    font-weight:600;
    cursor:pointer;
    box-shadow:none !important;
}

.modern-ui .myButton:hover{
    background:#004494 !important;
}

/* Grid */
.modern-ui .grid-container{
    background:#fff !important;
    border:1px solid #BDBDBD !important;
    overflow:hidden;
}
</style>

<body>

<div id="search" class="modern-ui">

    <div class="search-panel">

        <table>

            <colgroup>
                <col width="15%">
                <col width="65%">
                <col width="20%">
            </colgroup>

            <tr>

                <td class="lbl-right">
                    Account No
                </td>

                <td>
                    <input type="text"
                           name="txtaccountsno"
                           id="txtaccountsno"
                           value='<s:property value="txtaccountsno"/>'>
                </td>

                <td align="center" rowspan="2">
                    <input type="button"
                           name="btnAccountSearch"
                           id="btnAccountSearch"
                           class="myButton"
                           value="Search"
                           onclick="loadAccountSearch();">
                </td>

            </tr>

            <tr>

                <td class="lbl-right">
                    Account Name
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

        <div id="refreshAccountDetailsDiv">
            <jsp:include page="accountDetailsSearchGrid.jsp"></jsp:include>
        </div>

    </div>

</div>

</body>
</html>