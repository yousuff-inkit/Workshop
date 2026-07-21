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
	$(document).ready(function () {
		
	   document.getElementById("txtatypes").value=document.getElementById("cmbacctype").value;

	}); 
	
	function loadClientAccountSearch() {
			var clientaccountno=document.getElementById("accountsno").value;
			var clientaccountname=document.getElementById("accountsname").value;
			var clientmobile=document.getElementById("clientmobileno").value;
			var curr=document.getElementById("txtcurrencies").value;
			var accounttype=document.getElementById("txtatypes").value;
			var checked = 1;
	
			getClientAccountDetails(clientaccountno,clientaccountname,clientmobile,curr,accounttype,checked);
	}
		
	function getClientAccountDetails(clientaccountno,clientaccountname,clientmobile,curr,accounttype,checked){
		 $("#refreshClientAccountDiv").load("clientAccountDetailsSearchGrid.jsp?accountno="+clientaccountno+'&accountname='+clientaccountname.replace(/ /g, "%20")+'&mobile='+clientmobile+'&currency='+curr+'&atype='+accounttype+'&check='+checked);
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
                    Account No
                </td>

                <td>
                    <input type="text"
                           class="search-input medium-input"
                           name="accountsno"
                           id="accountsno"
                           value='<s:property value="accountsno"/>'>
                </td>

                <td class="lbl-right">
                    Currency
                </td>

                <td>

                    <input type="text"
                           class="search-input"
                           name="txtcurrencies"
                           id="txtcurrencies"
                           value='<s:property value="txtcurrencies"/>'>

                    <input type="hidden"
                           name="txtatypes"
                           id="txtatypes"
                           value='<s:property value="txtatypes"/>'>

                    <input type="hidden"
                           name="txtdocumenttypes"
                           id="txtdocumenttypes"
                           value='<s:property value="txtdocumenttypes"/>'>

                </td>

                <td class="lbl-right">
                    Mobile
                </td>

                <td>

                    <input type="text"
                           class="search-input medium-input"
                           name="clientmobileno"
                           id="clientmobileno"
                           value='<s:property value="clientmobileno"/>'>

                    <input type="hidden"
                           name="txtcreditdebit"
                           id="txtcreditdebit"
                           value='<s:property value="txtcreditdebit"/>'>

                </td>

            </tr>

            <tr>

                <td class="lbl-right">
                    Account Name
                </td>

                <td colspan="4">

                    <input type="text"
                           class="search-input long-input"
                           name="accountsname"
                           id="accountsname"
                           value='<s:property value="accountsname"/>'>

                </td>

                <td align="center">

                    <button
                        type="button"
                        id="btnClientAccountSearch"
                        onclick="loadClientAccountSearch();"
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

        </table>

    </div>

    <div class="grid-container">

        <div id="refreshClientAccountDiv">

            <jsp:include page="clientAccountDetailsSearchGrid.jsp"></jsp:include>

        </div>

    </div>

</div>

</body>
</html>