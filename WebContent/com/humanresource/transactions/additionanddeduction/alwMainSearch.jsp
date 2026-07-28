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
	 $("#alwdate").jqxDateTimeInput({ width: '110px', height: '15px',formatString:"dd.MM.yyyy",value:null});
	 getAlwYear();getAlwMonth();
	}); 
	
	function getAlwYear() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var yearItems = items[0].split(",");
				var yearIdItems = items[1].split(",");
				var optionsyear = '<option value="">--Select--</option>';
				for (var i = 0; i < yearItems.length; i++) {
					optionsyear += '<option value="' + yearIdItems[i] + '">'
							+ yearItems[i] + '</option>';
				}
				$("select#cmbalwyear").html(optionsyear);
			} else {
			}
		}
		x.open("GET", "getYear.jsp", true);
		x.send();
	}
	
	function getAlwMonth() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var monthItems = items[0].split(",");
				var monthIdItems = items[1].split(",");
				var optionsmonth = '<option value="">--Select--</option>';
				for (var i = 0; i < monthItems.length; i++) {
					optionsmonth += '<option value="' + monthIdItems[i] + '">'
							+ monthItems[i] + '</option>';
				}
				$("select#cmbalwmonth").html(optionsmonth);
			} else {
			}
		}
		x.open("GET", "getMonth.jsp", true);
		x.send();
	}

 	function loadSearch() {

 		var date=document.getElementById("alwdate").value;
 		var docNo=document.getElementById("txtdocno").value;
 		var year=document.getElementById("cmbalwyear").value;
 		var month=document.getElementById("cmbalwmonth").value;
 		var description=document.getElementById("txtalwdescription").value;
	
		getdata(date,docNo,year,month,description);
	}
 	
	function getdata(date,docNo,year,month,description){
		 $("#refreshdiv").load('alwMainSearchGrid.jsp?date='+date+'&docNo='+docNo+'&year='+year+'&month='+month+'&description='+description.replace(/ /g, "%20"));
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

.medium-select{
    width:170px !important;
    height:28px !important;
    border:1px solid #cfcfcf;
    border-radius:3px;
    font-size:12px;
    background:#fff;
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

                <td class="lbl-right">Date</td>

                <td>

                    <div id="alwdate"
                         name="alwdate"
                         value='<s:property value="alwdate"/>'>
                    </div>

                    <input type="hidden"
                           name="hidalwdate"
                           id="hidalwdate"
                           value='<s:property value="hidalwdate"/>'>

                </td>

                <td class="lbl-right">Doc No</td>

                <td>

                    <input type="text"
                           class="search-input medium-input"
                           name="txtdocno"
                           id="txtdocno"
                           value='<s:property value="txtdocno"/>'>

                </td>

                <td class="lbl-right">Year</td>

                <td>

                    <select id="cmbalwyear"
                            name="cmbalwyear"
                            class="medium-select">

                        <option value="">--Select--</option>

                    </select>

                </td>

                <td rowspan="2" align="center">

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

                <td class="lbl-right">Month</td>

                <td>

                    <select id="cmbalwmonth"
                            name="cmbalwmonth"
                            class="medium-select">

                        <option value="">--Select--</option>

                    </select>

                </td>

                <td class="lbl-right">Description</td>

                <td colspan="3">

                    <input type="text"
                           class="search-input long-input"
                           name="txtalwdescription"
                           id="txtalwdescription"
                           value='<s:property value="txtalwdescription"/>'>

                </td>

            </tr>

        </table>

    </div>

    <div class="grid-container">

        <div id="refreshdiv">

            <jsp:include page="alwMainSearchGrid.jsp"></jsp:include>

        </div>

    </div>

</div>

</body>
</html>