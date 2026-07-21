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
		document.getElementById("txtnewmaindate").value=$('#maindate').val();
	}); 
	
	function loadAccountSearchGrid() {
			var accountsno=document.getElementById("txtacctno").value;
			var accountsname=document.getElementById("txtacctname").value;
			var currs=document.getElementById("txtacctcurrency").value;
			var type=document.getElementById("txttypes").value;
			var date=document.getElementById("txtnewmaindate").value;
			var check = 1;
	
			getAccountDetails(accountsno,accountsname,currs,type,date,check);
	}
		
	function getAccountDetails(accountsno,accountsname,currs,type,date,check){
		 $("#refreshAccountSearchDetailsDiv").load("ibJournalVoucherSearchGrid.jsp?accountno="+accountsno+'&accountname='+accountsname.replace(/ /g, "%20")+'&currency='+currs+'&atype='+type+'&date='+date+'&check='+check);
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

body[bgcolor]{
    background:#ffffff !important;
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
    margin-bottom:12px;
}

.search-panel table{
    width:100%;
    border-collapse:collapse;
}

.search-panel td{
    padding:6px 8px;
    vertical-align:middle;
}

.lbl-right{
    text-align:right;
    white-space:nowrap;
    font-size:12px;
    font-weight:600;
    color:#333;
}

.search-panel input[type="text"]{
    width:100% !important;
    height:30px;
    border:1px solid #cfcfcf;
    border-radius:3px;
    padding:2px 8px;
    box-sizing:border-box;
    background:#fff;
    font-size:12px;
}

.grid-container{
    background:#fff;
    border:1px solid #cccccc;
    border-radius:4px;
    overflow:hidden;
}
.search-panel input[type=text],
.search-panel input[type=password],
.search-panel .searchTextbox{

    width:100% !important;
    min-width:180px !important;
    max-width:none !important;

    height:30px !important;

    padding:3px 8px !important;

    box-sizing:border-box !important;
}

.search-panel table td{

    white-space:nowrap;
}

.search-panel table td:nth-child(even){

    width:1%;
}

.search-panel table{

    table-layout:auto !important;
}
</style>

<body>

<div id="search">

    <!-- Search Panel -->

    <div class="search-panel">

        <table>

            <!-- Row 1 -->

            <tr>

                <td class="lbl-right">
                    Account No
                </td>

                <td>
                    <input type="text"
                           name="txtacctno"
                           id="txtacctno"
                           value='<s:property value="txtacctno"/>'>
                </td>

                <td class="lbl-right">
                    Currency
                </td>

                <td>
                    <input type="text"
                           name="txtacctcurrency"
                           id="txtacctcurrency"
                           value='<s:property value="txtacctcurrency"/>'>

                    <input type="hidden"
                           name="txttypes"
                           id="txttypes"
                           value='<s:property value="txttypes"/>'>

                    <input type="hidden"
                           name="txtnewmaindate"
                           id="txtnewmaindate"
                           value='<s:property value="txtnewmaindate"/>'>
                </td>

                <td rowspan="2" align="center">

                    <button
                        type="button"
                        id="btnAccountSearch"
                        onclick="loadAccountSearchGrid();"
                        style="
                            width:110px;
                            height:30px;
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

            <!-- Row 2 -->

            <tr>

                <td class="lbl-right">
                    Account Name
                </td>

                <td colspan="3">

                    <input type="text"
                           name="txtacctname"
                           id="txtacctname"
                           value='<s:property value="txtacctname"/>'>

                </td>

            </tr>

        </table>

    </div>

    <!-- Search Grid -->

    <div class="grid-container">

        <div id="refreshAccountSearchDetailsDiv">

            <jsp:include page="ibJournalVoucherSearchGrid.jsp"></jsp:include>

        </div>

    </div>

</div>

</body>
</html>