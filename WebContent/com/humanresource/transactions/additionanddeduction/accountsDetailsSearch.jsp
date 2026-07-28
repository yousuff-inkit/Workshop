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
<% String atype = request.getParameter("atype")==null?"0":request.getParameter("atype"); %>

<script type="text/javascript">
	$(document).ready(function () {
		var atype='<%=atype%>';
		document.getElementById("txttypes").value=atype;
	}); 
	
	function loadAccountSearch() {
			var accountsno=document.getElementById("txtaccountsno").value;
			var accountsname=document.getElementById("txtaccountsname").value;
			var atype=document.getElementById("txttypes").value;
			var check = 1;
			
			getAccountDetails(accountsno,accountsname,atype,check);
	}
		
	function getAccountDetails(accountsno,accountsname,atype,check){
		 $("#refreshAccountDetailsDiv").load("accountDetailsSearchGrid.jsp?accountno="+accountsno+'&accountname='+accountsname.replace(/ /g, "%20")+'&atype='+atype+'&check='+check);
	}

</script>
<style>
/*=========================================================
                MASTER SEARCH UI
=========================================================*/

html,
body{
    margin:0;
    padding:0;
    background:#ffffff !important;
    font-family:'Segoe UI',Tahoma,Verdana,sans-serif;
}

#search{
    background:#ffffff;
    padding:10px;
}

.search-panel{
    background:#ffffff;
    border:1px solid #d8d8d8;
    border-radius:4px;
    padding:12px;
    margin-bottom:10px;
}

.search-panel table{
    width:100%;
    border-collapse:collapse;
}

.search-panel td{
    padding:5px 6px;
    vertical-align:middle;
    white-space:nowrap;
}

.lbl-right{
    text-align:right;
    font-size:12px;
    font-weight:500;
    color:#333;
    padding-right:6px;
}

.search-input{
    width:130px !important;
    min-width:130px !important;
    max-width:130px !important;
    height:26px !important;
    border:1px solid #cfcfcf;
    border-radius:3px;
    padding:2px 6px;
    box-sizing:border-box;
    background:#fff;
    font-size:12px;
}

.medium-input{
    width:170px !important;
    min-width:170px !important;
    max-width:170px !important;
}

.long-input{
    width:260px !important;
    min-width:260px !important;
    max-width:260px !important;
}

.grid-container{
    background:#fff;
    border:1px solid #cccccc;
    border-radius:4px;
    overflow:hidden;
}
</style>

<body>

<div id="search">

    <div class="search-panel">

        <table>

            <tr>

                <td class="lbl-right">
                    Account No.
                </td>

                <td>

                    <input type="text"
                           class="search-input medium-input"
                           name="txtaccountsno"
                           id="txtaccountsno"
                           value='<s:property value="txtaccountsno"/>'>

                    <input type="hidden"
                           name="txttypes"
                           id="txttypes"
                           value='<s:property value="txttypes"/>'>

                </td>

                <td align="center">

                    <button
                        type="button"
                        id="btnAccountSearch"
                        onclick="loadAccountSearch();"
                        style="
                            width:105px;
                            height:28px;
                            background:#205fd3;
                            color:#ffffff;
                            border:1px solid #205fd3;
                            border-radius:4px;
                            font-size:12px;
                            font-weight:600;
                            cursor:pointer;">
                        Search
                    </button>

                </td>

            </tr>

            <tr>

                <td class="lbl-right">
                    Account Name
                </td>

                <td colspan="2">

                    <input type="text"
                           class="search-input long-input"
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