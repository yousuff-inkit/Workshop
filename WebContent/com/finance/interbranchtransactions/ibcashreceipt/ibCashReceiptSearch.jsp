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
		 $("#refreshAccountSearchDetailsDiv").load("ibCashReceiptSearchGrid.jsp?accountno="+accountsno+'&accountname='+accountsname.replace(/ /g, "%20")+'&currency='+currs+'&atype='+type+'&date='+date+'&check='+check);
	}

</script>
<style>
html,body{
    margin:0;
    padding:0;
    background:#fff !important;
    font-family:'Segoe UI',Tahoma,Verdana,sans-serif;
}

#search{
    padding:10px;
    background:#fff;
}

.search-panel{
    background:#fff;
    border:1px solid #d8d8d8;
    border-radius:4px;
    padding:14px;
    margin-bottom:12px;
}

.search-row{
    display:flex;
    align-items:center;
    gap:12px;
}

.search-row label{
    white-space:nowrap;
    font-size:12px;
    font-weight:600;
    color:#333;
}

.search-row input[type=text]{
    flex:1 1 180px !important;
    width:auto !important;
    min-width:170px !important;
    max-width:none !important;
    height:30px;
    padding:4px 8px;
    border:1px solid #cfcfcf;
    border-radius:3px;
    box-sizing:border-box;
    background:#fff;
}

.grid-container{
    background:#fff;
    border:1px solid #ccc;
    border-radius:4px;
    overflow:hidden;
}
</style>

<body>

<div id="search">

    <div class="search-panel">

        <div class="search-row">

            <label for="txtacctno">Account No</label>

            <input type="text"
                   id="txtacctno"
                   name="txtacctno"
                   value='<s:property value="txtacctno"/>'>

            <label for="txtacctname">Account Name</label>

            <input type="text"
                   id="txtacctname"
                   name="txtacctname"
                   value='<s:property value="txtacctname"/>'>

            <label for="txtacctcurrency">Currency</label>

            <input type="text"
                   id="txtacctcurrency"
                   name="txtacctcurrency"
                   value='<s:property value="txtacctcurrency"/>'>

            <input type="hidden"
                   id="txttypes"
                   name="txttypes"
                   value='<s:property value="txttypes"/>'>

            <input type="hidden"
                   id="txtnewmaindate"
                   name="txtnewmaindate"
                   value='<s:property value="txtnewmaindate"/>'>

            <button
                type="button"
                id="btnAccountSearch"
                onclick="loadAccountSearchGrid();"
                style="
                    width:110px;
                    height:30px;
                    background:#205fd3;
                    color:#fff;
                    border:1px solid #205fd3;
                    border-radius:4px;
                    cursor:pointer;
                    font-size:12px;
                    font-weight:600;">
                Search
            </button>

        </div>

    </div>

    <div class="grid-container">

        <div id="refreshAccountSearchDetailsDiv">

            <jsp:include page="ibCashReceiptSearchGrid.jsp"></jsp:include>

        </div>

    </div>

</div>

</body>
</html>