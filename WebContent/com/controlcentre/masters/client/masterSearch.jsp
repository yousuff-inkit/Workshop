 <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
 
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<%--   <jsp:include page="../../../../includes.jsp"></jsp:include>   --%> 
<style>
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />

</style>

	<script type="text/javascript">
	$(document).ready(function () {
	
	}); 

 	function mainloadSearch() {
 		
 		var sclname=document.getElementById("SCl_name").value.replace(" ","%20");
 		var smob=document.getElementById("Sl_mob").value;
 		var rno=document.getElementById("rno").value;
 		var contact=document.getElementById("contact").value;

 	
 		
		getdata(sclname,smob,rno,contact);
 

	}
	  function getdata(sclname,smob,rno,contact){
		  
		
		 $("#srefreshdiv").load('submainSearch.jsp?sclname='+sclname+'&smob='+smob+'&rno='+rno+'&contact='+contact);
		 

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
                           name="SCl_name"
                           id="SCl_name"
                           value='<s:property value="SCl_name"/>'>
                </td>

                <td class="lbl-right">
                    MOB
                </td>

                <td>
                    <input type="text"
                           class="search-input medium-input"
                           name="Sl_mob"
                           id="Sl_mob"
                           value='<s:property value="Sl_mob"/>'>
                </td>

            </tr>

            <tr>

                <td class="lbl-right">
                    Doc No
                </td>

                <td>
                    <input type="text"
                           class="search-input"
                           name="rno"
                           id="rno"
                           value='<s:property value="rno"/>'>
                </td>

                <td class="lbl-right">
                    Contact
                </td>

                <td>

                    <input type="text"
                           class="search-input long-input"
                           name="contact"
                           id="contact"
                           value='<s:property value="contact"/>'>

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