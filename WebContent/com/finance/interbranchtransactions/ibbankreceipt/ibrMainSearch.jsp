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
 		var check = 1;
	
		getdata(partyname,docNo,date,amount,chequeNo,chequeDt,check);
	}
	function getdata(partyname,docNo,date,amount,chequeNo,chequeDt,check){
		 $("#refreshdiv").load('ibrMainSearchGrid.jsp?partyname='+partyname.replace(/ /g, "%20")+'&docNo='+docNo+'&date='+date+'&amount='+amount+'&chequeNo='+chequeNo+'&chequeDt='+chequeDt+"&check="+check);
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
    width:250px !important;
    min-width:250px !important;
    max-width:250px !important;
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

                <td class="lbl-right">Name</td>

                <td colspan="3">
                    <input type="text"
                           class="search-input long-input"
                           name="txtpartyname"
                           id="txtpartyname"
                           autocomplete="off"
                           value='<s:property value="txtpartyname"/>'>
                </td>

                <td class="lbl-right">Doc No</td>

                <td>
                    <input type="text"
                           class="search-input medium-input"
                           name="txtdocno"
                           id="txtdocno"
                           autocomplete="off"
                           value='<s:property value="txtdocno"/>'>
                </td>

                <td colspan="2" align="center">

                    <button
                        type="button"
                        id="btnsearch"
                        onclick="loadSearch();"
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

                <td class="lbl-right">Date</td>

                <td>

                    <div id="bankdate"
                         name="bankdate"
                         value='<s:property value="bankdate"/>'>
                    </div>

                    <input type="hidden"
                           name="hidbankdate"
                           id="hidbankdate"
                           value='<s:property value="hidbankdate"/>'>

                </td>

                <td class="lbl-right">Amount</td>

                <td>
                    <input type="text"
                           class="search-input"
                           name="txtamount"
                           id="txtamount"
                           autocomplete="off"
                           value='<s:property value="txtamount"/>'>
                </td>

                <td class="lbl-right">Cheque No</td>

                <td>
                    <input type="text"
                           class="search-input"
                           id="txtchqno"
                           name="txtchqno"
                           autocomplete="off"
                           value='<s:property value="txtchqno"/>'>
                </td>

                <td class="lbl-right">Cheque Date</td>

                <td>

                    <div id="chqdate"
                         name="chqdate"
                         value='<s:property value="chqdate"/>'>
                    </div>

                    <input type="hidden"
                           name="hidchqdate"
                           id="hidchqdate"
                           value='<s:property value="hidchqdate"/>'>

                </td>

            </tr>

        </table>

    </div>

    <div class="grid-container">

        <div id="refreshdiv">

            <jsp:include page="ibrMainSearchGrid.jsp"></jsp:include>

        </div>

    </div>

</div>

</body>
</html>