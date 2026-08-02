 <%@ taglib prefix="s" uri="/struts-tags" %>
 <% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
<title>GatewayERP(i)</title>

	<script type="text/javascript">
	$(document).ready(function () {
	 $("#bankdate").jqxDateTimeInput({ width: '110px', height: '15px',formatString:"dd.MM.yyyy",value:null});
	 $("#chqdate").jqxDateTimeInput({ width: '110px', height: '15px',formatString:"dd.MM.yyyy",value:null});
	}); 

 	function loadSearch() {
 		var partyname=document.getElementById("txtpartyname").value;
 		var docNo=document.getElementById("txtdocno").value;
 		var date=document.getElementById("bankdate").value;
 		var amount=document.getElementById("txtamount").value;
 		var chequeNo=document.getElementById("txtchqno").value;
 		var chequeDt=document.getElementById("chqdate").value;
		var check=1;
		
		getdata(partyname,docNo,date,amount,chequeNo,chequeDt,check);
	}
	function getdata(partyname,docNo,date,amount,chequeNo,chequeDt,check){
		 $("#refreshdiv").load('brvMainSearchGrid.jsp?partyname='+partyname.replace(/ /g, "%20")+'&docNo='+docNo+'&date='+date+'&amount='+amount+'&chequeNo='+chequeNo+'&chequeDt='+chequeDt+'&check='+check);
		}

	</script>
<style>
/*==================================================
                MASTER SEARCH UI
==================================================*/

body{
    margin:0;
    padding:10px;
    background:#ffffff;
    font-family:"Segoe UI",Tahoma,Arial,sans-serif;
    font-size:12px;
    color:#333;
}

#search{
    background:#ffffff;
    padding:0;
    margin:0;
}

.search-panel{
    background:#ffffff;
    border:1px solid #d4d4d4;
    border-radius:4px;
    padding:10px;
    margin-bottom:10px;
}

.grid-container{
    background:#ffffff;
    border:1px solid #d4d4d4;
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
    font-size:12px;
    font-weight:600;
    color:#333;
    white-space:nowrap;
    padding-right:6px;
}

.search-input{
    width:100%;
    height:24px;
    padding:2px 6px;
    border:1px solid #bdbdbd;
    border-radius:3px;
    box-sizing:border-box;
    font:12px "Segoe UI",Tahoma,Arial,sans-serif;
    background:#fff;
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
    box-shadow: 0 1px 2px rgba(0,0,0,.1);
    border: none;
    background: linear-gradient(135deg,#0b45a2 0%,#2563eb 100%);
    color: #fff;
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
                <col width="8%">
                <col width="22%">
                <col width="9%">
                <col width="15%">
                <col width="10%">
                <col width="15%">
                <col width="11%">
                <col width="10%">
            </colgroup>

            <tr>

                <td class="lbl-right">Name</td>

                <td colspan="3">
                    <input type="text"
                           id="txtpartyname"
                           name="txtpartyname"
                           class="search-input"
                           value='<s:property value="txtpartyname"/>'>
                </td>

                <td class="lbl-right">Doc No</td>

                <td>
                    <input type="text"
                           id="txtdocno"
                           name="txtdocno"
                           class="search-input"
                           value='<s:property value="txtdocno"/>'>
                </td>

                <td colspan="2" align="center">
                    <input type="button"
                           id="btnsearch"
                           name="btnsearch"
                           class="myButton"
                           value="Search"
                           onclick="loadSearch();">
                </td>

            </tr>

            <tr>

                <td class="lbl-right">Date</td>

                <td>
                    <div id="bankdate"
                         name="bankdate"
                         value='<s:property value="bankdate"/>'></div>

                    <input type="hidden"
                           id="hidbankdate"
                           name="hidbankdate"
                           value='<s:property value="hidbankdate"/>'>
                </td>

                <td class="lbl-right">Amount</td>

                <td>
                    <input type="text"
                           id="txtamount"
                           name="txtamount"
                           class="search-input"
                           value='<s:property value="txtamount"/>'>
                </td>

                <td class="lbl-right">Cheque No</td>

                <td>
                    <input type="text"
                           id="txtchqno"
                           name="txtchqno"
                           class="search-input"
                           value='<s:property value="txtchqno"/>'>
                </td>

                <td class="lbl-right">Cheque Date</td>

                <td>
                    <div id="chqdate"
                         name="chqdate"
                         value='<s:property value="chqdate"/>'></div>

                    <input type="hidden"
                           id="hidchqdate"
                           name="hidchqdate"
                           value='<s:property value="hidchqdate"/>'>
                </td>

            </tr>

        </table>

    </div>

    <div class="grid-container">

        <div id="refreshdiv">
            <jsp:include page="brvMainSearchGrid.jsp"></jsp:include>
        </div>

    </div>

</div>

</body>
</html>