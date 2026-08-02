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
	 $("#creditdate").jqxDateTimeInput({ width: '110px', height: '15px',formatString:"dd.MM.yyyy",value:null});
	}); 

 	function loadSearch() {

 		var docNo=document.getElementById("txtdocumentno").value;
 		var date=document.getElementById("creditdate").value;
 		var accId=document.getElementById("txtaccountid").value;
 		var accName=document.getElementById("txtaccountname").value;
 		var amount=document.getElementById("txtamounts").value;
 		var description=document.getElementById("txtdescriptions").value;
	    var check = 1;
	    
		getdata(docNo,date,accId,accName,amount,description,check);
	}
	function getdata(docNo,date,accId,accName,amount,description,check){
		 $("#refreshdiv").load('cnoMainSearchGrid.jsp?docNo='+docNo+'&date='+date+'&accId='+accId+'&accName='+accName.replace(/ /g, "%20")+'&amount='+amount+'&description='+description.replace(/ /g, "%20")+'&check='+check);
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
    box-sizing:border-box;
    background:#ffffff;
    font-family:Arial,sans-serif;
    font-size:11px;
}

.search-input:focus{
    outline:none;
    border-color:#2563eb;
}

/* EXACT MASTER BUTTON */
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
                <col width="9%">
                <col width="23%">
                <col width="6%">
                <col width="21%">
                <col width="7%">
                <col width="23%">
                <col width="11%">
            </colgroup>

            <tr>

                <td class="lbl-right">Doc No</td>

                <td>
                    <input type="text"
                           id="txtdocumentno"
                           name="txtdocumentno"
                           class="search-input"
                           value='<s:property value="txtdocumentno"/>'>
                </td>

                <td class="lbl-right">Date</td>

                <td>
                    <div id="creditdate"
                         name="creditdate"
                         value='<s:property value="creditdate"/>'></div>

                    <input type="hidden"
                           id="hidcreditdate"
                           name="hidcreditdate"
                           value='<s:property value="hidcreditdate"/>'>
                </td>

                <td class="lbl-right">A/C No.</td>

                <td>
                    <input type="text"
                           id="txtaccountid"
                           name="txtaccountid"
                           class="search-input"
                           value='<s:property value="txtaccountid"/>'>
                </td>

                <td align="center">
                    <input type="button"
                           id="btnsearch"
                           name="btnsearch"
                           class="myButton"
                           value="Search"
                           onclick="loadSearch();">
                </td>

            </tr>

            <tr>

                <td class="lbl-right">A/C Name</td>

                <td>
                    <input type="text"
                           id="txtaccountname"
                           name="txtaccountname"
                           class="search-input"
                           value='<s:property value="txtaccountname"/>'>
                </td>

                <td class="lbl-right">Amount</td>

                <td>
                    <input type="text"
                           id="txtamounts"
                           name="txtamounts"
                           class="search-input"
                           value='<s:property value="txtamounts"/>'>
                </td>

                <td class="lbl-right">Description</td>

                <td colspan="2">
                    <input type="text"
                           id="txtdescriptions"
                           name="txtdescriptions"
                           class="search-input"
                           value='<s:property value="txtdescriptions"/>'>
                </td>

            </tr>

        </table>

    </div>

    <div class="grid-container">

        <div id="refreshdiv">
            <jsp:include page="cnoMainSearchGrid.jsp"></jsp:include>
        </div>

    </div>

</div>

</body>
</html>