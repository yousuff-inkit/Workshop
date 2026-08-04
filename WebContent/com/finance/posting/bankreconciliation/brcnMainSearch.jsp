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
	 $("#reconciledate").jqxDateTimeInput({ width: '110px', height: '15px',formatString:"dd.MM.yyyy",value:null});
	}); 

 	function loadSearch() {
 		var account=document.getElementById("txtpartyname").value;
 		var docNo=document.getElementById("txtdocumentno").value;
 		var currency=document.getElementById("txtcurrency").value;
 		var description=document.getElementById("txtdesc").value;
 		var reconcileDt=document.getElementById("reconciledate").value;
	    var check = 1;
	    
		getdata(account,docNo,currency,description,reconcileDt,check);
	}
	function getdata(account,docNo,currency,description,reconcileDt,check){
		 $("#refreshdiv").load('brcnMainSearchGrid.jsp?account='+account+'&docNo='+docNo+'&currency='+currency+'&description='+description.replace(/ /g, "%20")+'&reconcileDt='+reconcileDt+'&check='+check);
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

/* EXACT MASTER BUTTON */
.myButton,
.btn{
    height:24px !important;
    line-height:22px !important;
    padding:0 12px;
    font-family:Arial,sans-serif;
    font-size:11px;
    font-weight:bold;
    border-radius:3px;
    cursor:pointer;
    text-shadow:none;
    transition:all .2s;
    box-shadow:0 1px 2px rgba(0,0,0,.1);
    border:none;
    background:linear-gradient(135deg,#0b45a2 0%,#2563eb 100%);
    color:#ffffff;
    white-space:nowrap;
    display:inline-block;
    box-sizing:border-box;
}
</style>

<body>

<div id="search">

    <div class="search-panel">

        <table>

            <tr>

                <td class="lbl-right">
                    Account Name
                </td>

                <td colspan="3">

                    <input type="text"
                           class="search-input long-input"
                           name="txtpartyname"
                           id="txtpartyname"
                           value='<s:property value="txtpartyname"/>'>

                </td>

                <td class="lbl-right">
                    Doc No
                </td>

                <td>

                    <input type="text"
                           class="search-input medium-input"
                           name="txtdocumentno"
                           id="txtdocumentno"
                           value='<s:property value="txtdocumentno"/>'>

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

                <td class="lbl-right">
                    Currency
                </td>

                <td>

                    <input type="text"
                           class="search-input"
                           name="txtcurrency"
                           id="txtcurrency"
                           value='<s:property value="txtcurrency"/>'>

                </td>

                <td class="lbl-right">
                    Description
                </td>

                <td colspan="2">

                    <input type="text"
                           class="search-input long-input"
                           id="txtdesc"
                           name="txtdesc"
                           value='<s:property value="txtdesc"/>'>

                </td>

                <td class="lbl-right">
                    Reconcile Date
                </td>

                <td>

                    <div id="reconciledate"
                         name="reconciledate"
                         value='<s:property value="reconciledate"/>'>
                    </div>

                    <input type="hidden"
                           name="hidreconciledate"
                           id="hidreconciledate"
                           value='<s:property value="hidreconciledate"/>'>

                </td>

            </tr>

        </table>

    </div>

    <div class="grid-container">

        <div id="refreshdiv">
            <jsp:include page="brcnMainSearchGrid.jsp"></jsp:include>
        </div>

    </div>

</div>

</body>
</html>