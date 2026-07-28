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
	$(document).ready(function () {}); 

 	function loadSearch() {

 		var employeeName=document.getElementById("txtpartyname").value;
 		var empId=document.getElementById("txtpartyid").value;
 		var contactNo=document.getElementById("txtcontactno").value;
 		
		getdata(employeeName,empId,contactNo);
	}
	function getdata(employeeName,empId,contactNo){
		 $("#refreshdiv").load('employeeDetailsSearchGrid.jsp?employeename='+employeeName.replace(/ /g, "%20")+'&empid='+empId+'&contactno='+contactNo);
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
                    Name
                </td>

                <td>

                    <input type="text"
                           class="search-input long-input"
                           name="txtpartyname"
                           id="txtpartyname"
                           value='<s:property value="txtpartyname"/>'>

                </td>

                <td align="center">

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

                <td class="lbl-right">
                    ID#
                </td>

                <td>

                    <input type="text"
                           class="search-input medium-input"
                           name="txtpartyid"
                           id="txtpartyid"
                           value='<s:property value="txtpartyid"/>'>

                </td>

                <td>

                    <table style="border-collapse:collapse;width:100%;">

                        <tr>

                            <td class="lbl-right" style="width:95px;">
                                Contact No.
                            </td>

                            <td>

                                <input type="text"
                                       class="search-input medium-input"
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

                </td>

            </tr>

        </table>

    </div>

    <div class="grid-container">

        <div id="refreshdiv">

            <jsp:include page="employeeDetailsSearchGrid.jsp"></jsp:include>

        </div>

    </div>

</div>

</body>
</html>