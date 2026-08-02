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
		 $("#refreshAccountSearchDetailsDiv").load("creditNoteSearchGrid.jsp?accountno="+accountsno+'&accountname='+accountsname.replace(/ /g, "%20")+'&currency='+currs+'&atype='+type+'&cmbtype='+document.getElementById("cmbtype").value+'&date='+date+'&creditdate='+document.getElementById("jqxCreditNoteDate").value+'&check='+check);
	}

</script>
<style>
/*==================================================
                MASTER SEARCH UI
==================================================*/

body{
    margin:0;
    padding:10px;
    background:#ffffff !important;
    font-family:Arial,sans-serif;
    font-size:11px;
    color:#333;
}

#search{
    margin:0;
    padding:0;
    background:#ffffff !important;
}

.search-panel{
    background:#ffffff;
    border:1px solid #d8d8d8;
    border-radius:3px;
    padding:10px;
    margin-bottom:8px;
}

.grid-container{
    background:#ffffff;
    border:1px solid #d8d8d8;
    overflow:hidden;
}

.search-table{
    width:100%;
    border-collapse:separate;
    border-spacing:8px;
    table-layout:fixed;
}

.search-table td{
    vertical-align:middle;
}

.lbl-right{
    text-align:right;
    font-family:Arial,sans-serif;
    font-size:11px;
    font-weight:bold;
    color:#333;
    white-space:nowrap;
    padding-right:5px;
}

.search-input{
    width:100%;
    height:24px;
    line-height:22px;
    padding:0 6px;
    border:1px solid #c8c8c8;
    border-radius:3px;
    background:#ffffff;
    box-sizing:border-box;
    font-family:Arial,sans-serif;
    font-size:11px;
}

.search-input:focus{
    outline:none;
    border-color:#2563eb;
}

/* MASTER BUTTON */
.myButton, .btn {
    height: 24px !important;
    line-height: 22px !important;
    padding: 0 12px;
    font-family: Arial, sans-serif;
    font-size: 11px;
    font-weight: bold;
    border-radius: 3px;
    cursor: pointer;
    text-shadow: none;
    transition: all 0.2s;
    box-shadow: 0 1px 2px rgba(0, 0, 0, 0.1);
    border: none;
    background: linear-gradient(135deg, #0b45a2 0%, #2563eb 100%);
    color: #ffffff;
    white-space: nowrap;
    display: inline-block;
    box-sizing: border-box;
}
</style>

<body>

<div id="search">

    <div class="search-panel">

        <table class="search-table">

            <colgroup>
                <col width="10%">
                <col width="30%">
                <col width="10%">
                <col width="27%">
                <col width="23%">
            </colgroup>

            <tr>

                <td class="lbl-right">Account No</td>

                <td>
                    <input type="text"
                           id="txtacctno"
                           name="txtacctno"
                           class="search-input"
                           value='<s:property value="txtacctno"/>'>
                </td>

                <td class="lbl-right">Currency</td>

                <td>
                    <input type="text"
                           id="txtacctcurrency"
                           name="txtacctcurrency"
                           class="search-input"
                           style="width:50%;"
                           value='<s:property value="txtacctcurrency"/>'>

                    <input type="hidden"
                           id="txttypes"
                           name="txttypes"
                           value='<s:property value="txttypes"/>'>

                    <input type="hidden"
                           id="txtnewmaindate"
                           name="txtnewmaindate"
                           value='<s:property value="txtnewmaindate"/>'>
                </td>

                <td rowspan="2" align="center">
                    <input type="button"
                           id="btnAccountSearch"
                           name="btnAccountSearch"
                           class="myButton"
                           value="Search"
                           onclick="loadAccountSearchGrid();">
                </td>

            </tr>

            <tr>

                <td class="lbl-right">Account Name</td>

                <td colspan="3">
                    <input type="text"
                           id="txtacctname"
                           name="txtacctname"
                           class="search-input"
                           style="width:80%;"
                           value='<s:property value="txtacctname"/>'>
                </td>

            </tr>

        </table>

    </div>

    <div class="grid-container">

        <div id="refreshAccountSearchDetailsDiv">
            <jsp:include page="creditNoteSearchGrid.jsp"></jsp:include>
        </div>

    </div>

</div>

</body>
</html>