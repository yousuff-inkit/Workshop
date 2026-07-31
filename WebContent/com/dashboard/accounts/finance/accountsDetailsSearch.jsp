 <%@ taglib prefix="s" uri="/struts-tags" %>
 <% String contextPath=request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
<title>GatewayERP(i)</title>

<style type="text/css">
#search {
    background-color: #E0ECF8;
}
</style>

	<script type="text/javascript">
	$(document).ready(function () {
 		document.getElementById("txtatype").value=$('#cmbtype').val();
 		if(($('#cmbtype').val()=='GL') || ($('#cmbtype').val()=='HR')){
 			$('#txtcontactno').attr('readonly', true );
 		}
	}); 

 	function loadSearch() {

 		var partyname=document.getElementById("txtpartyname").value;
 		var accNo=document.getElementById("txtaccountno").value;
 		var contactNo=document.getElementById("txtcontactno").value;
 		var atype=document.getElementById("txtatype").value;
 		var chk = 2;
 		
		getdata(atype,partyname,accNo,contactNo,chk);
	}
	function getdata(atype,partyname,accNo,contactNo,chk){
		 $("#refreshdiv").load('accountsDetailsGrid.jsp?atype='+atype+'&partyname='+partyname+'&accNo='+accNo+'&contactNo='+contactNo+'&chk='+chk);
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

/* Remove any project background */
#search,
.modern-ui,
.search-panel,
.grid-container{
    background:#fff !important;
}

/* Master UI */
.modern-ui{
    padding:10px;
    font-size:12px;
    color:#333;
    box-sizing:border-box;
}

/* Search Panel */
.modern-ui .search-panel{
    background:#fff !important;
    border:1px solid #BDBDBD;
    border-radius:4px;
    padding:12px 10px;
    margin-bottom:10px;
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
    font-size:12px;
    font-weight:600;
    color:#222;
    white-space:nowrap;
    padding-right:6px;
}

/* Inputs */
.modern-ui input[type="text"],
.modern-ui select{
    width:100%;
    height:24px !important;
    border:1px solid #BDBDBD;
    border-radius:3px;
    padding:2px 6px;
    font-size:12px;
    font-family:'Segoe UI','Roboto','Arial',sans-serif;
    color:#333;
    background:#fff !important;
    box-sizing:border-box;
}

.modern-ui input[type="text"]:focus,
.modern-ui select:focus{
    outline:none;
    border-color:#007bff;
}

/* Button */
.modern-ui .myButton{
    height:26px;
    min-width:95px;
    padding:0 20px;
    background:#0056b3 !important;
    background-image:none !important;
    color:#fff !important;
    border:none !important;
    border-radius:3px;
    cursor:pointer;
    font-size:12px;
    font-weight:600;
    font-family:'Segoe UI','Roboto','Arial',sans-serif;
    box-shadow:none !important;
}

.modern-ui .myButton:hover{
    background:#004494 !important;
}

/* Grid */
.modern-ui .grid-container{
    background:#fff !important;
    border:1px solid #BDBDBD;
    overflow:hidden;
}
</style>

<body>

<div id="search" class="modern-ui">

    <div class="search-panel">

        <table>

            <colgroup>
                <col width="12%">
                <col width="28%">
                <col width="12%">
                <col width="28%">
                <col width="20%">
            </colgroup>

            <tr>

                <td class="lbl-right">Name</td>

                <td colspan="3">
                    <input type="text"
                           name="txtpartyname"
                           id="txtpartyname"
                           value='<s:property value="txtpartyname"/>'>
                </td>

                <td align="center" rowspan="2">
                    <input type="button"
                           name="btnsearch"
                           id="btnsearch"
                           class="myButton"
                           value="Search"
                           onclick="loadSearch();">
                </td>

            </tr>

            <tr>

                <td class="lbl-right">Account</td>

                <td>
                    <input type="text"
                           name="txtaccountno"
                           id="txtaccountno"
                           value='<s:property value="txtaccountno"/>'>
                </td>

                <td class="lbl-right">Contact No.</td>

                <td>
                    <input type="text"
                           name="txtcontactno"
                           id="txtcontactno"
                           value='<s:property value="txtcontactno"/>'>

                    <input type="hidden"
                           name="txtatype"
                           id="txtatype"
                           value='<s:property value="txtatype"/>'>
                </td>

            </tr>

        </table>

    </div>

    <div class="grid-container">

        <div id="refreshdiv">
            <jsp:include page="accountsDetailsGrid.jsp"></jsp:include>
        </div>

    </div>

</div>

</body>
</html>