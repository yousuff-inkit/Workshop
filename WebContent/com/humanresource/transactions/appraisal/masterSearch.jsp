<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>

<style>
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
</style>

<script type="text/javascript">
	$(document).ready(function () {}); 

 	function mainloadSearch() {
 		
 		var empnames=document.getElementById("empnames").value;
 		var empids=document.getElementById("empids").value;
 		var docnoss=document.getElementById("docnoss").value;
 		var mobnos=document.getElementById("mobnos").value;	
 		var empns = empnames.replace(/ /g, "%20");

 		getdata(empns,empids,docnoss,mobnos);
	}
 	
	function getdata(empns,empids,docnoss,mobnos){
		 $("#srefreshdiv").load('submainSearch.jsp?empns='+empns+'&empids='+empids+'&docnoss='+docnoss+'&mobnos='+mobnos);
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
}

.long-input{
    width:260px !important;
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
                    Name
                </td>

                <td>
                    <input type="text"
                           class="search-input long-input"
                           name="empnames"
                           id="empnames"
                           value='<s:property value="empnames"/>'>
                </td>

                <td class="lbl-right">
                    Emp ID
                </td>

                <td>
                    <input type="text"
                           class="search-input medium-input"
                           name="empids"
                           id="empids"
                           value='<s:property value="empids"/>'>
                </td>

            </tr>

            <tr>

                <td class="lbl-right">
                    Doc No
                </td>

                <td>
                    <input type="text"
                           class="search-input medium-input"
                           name="docnoss"
                           id="docnoss"
                           value='<s:property value="docnoss"/>'>
                </td>

                <td class="lbl-right">
                    Mobile
                </td>

                <td>
                    <input type="text"
                           class="search-input medium-input"
                           name="mobnos"
                           id="mobnos"
                           value='<s:property value="mobnos"/>'>
                </td>

                <td align="center">

                    <button
                        type="button"
                        id="mbtnrasearch"
                        onclick="mainloadSearch();"
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

        <div id="srefreshdiv">

            <jsp:include page="submainSearch.jsp"></jsp:include>

        </div>

    </div>

</div>

</body>
</html>