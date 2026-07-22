<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />

<style type="text/css">
/* =========================================================
   SCOPED UI: Group Code Search Panel (Side-by-Side)
========================================================= */

body {
    margin: 0;
    padding: 12px;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    background-color: #f5f7fa;
    color: #333333;
}

#search {
    background-color: #ffffff;
    border: 1px solid #c5d3e0;
    border-radius: 8px;
    padding: 16px;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.04);
}

.search-inline-container {
    display: flex;
    align-items: flex-end;
    gap: 12px;
    margin-bottom: 15px;
}

.form-group {
    display: flex;
    flex-direction: column;
    gap: 5px;
    width: 250px; /* Fixed or max width for the input field */
}

.form-group label {
    font-size: 11px;
    font-weight: 700;
    color: #4b5563;
    text-transform: uppercase;
    letter-spacing: 0.5px;
}

.form-control {
    height: 32px;
    padding: 0 10px;
    font-size: 13px;
    font-family: inherit;
    border: 1px solid #c5d3e0;
    border-radius: 4px;
    background-color: #ffffff;
    transition: border-color 0.2s ease, box-shadow 0.2s ease;
    box-sizing: border-box;
    width: 100%;
}

.form-control:focus {
    border-color: #0b45a2;
    outline: none;
    box-shadow: 0 0 0 2px rgba(11, 69, 162, 0.15);
}

.myButton {
    font-family: inherit;
    font-weight: 600;
    font-size: 13px;
    height: 32px;
    padding: 0 22px;
    background: linear-gradient(135deg, #0b45a2 0%, #2563eb 100%);
    color: #ffffff;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    transition: all 0.2s ease;
    box-shadow: 0 2px 4px rgba(11, 69, 162, 0.2);
    white-space: nowrap;
}

.myButton:hover {
    background: linear-gradient(135deg, #083680 0%, #1d4ed8 100%);
    box-shadow: 0 3px 6px rgba(11, 69, 162, 0.3);
}

#srefreshdiv {
    width: 100%;
    margin-top: 12px;
    border-top: 1px solid #e2e8f0;
    padding-top: 12px;
}
</style>

<script type="text/javascript">
	$(document).ready(function () {}); 

	function mainloadSearch() {
		var stype = document.getElementById("stype").value;
		getdata(stype);
	}

	function getdata(stype) {
		$("#srefreshdiv").load('submainSearch.jsp?stype=' + encodeURIComponent(stype));
	}
</script>
</head>

<body>
<div id="search">
    <div class="search-inline-container">
        <div class="form-group">
            <label for="stype">Group Code</label>
            <input type="text" class="form-control" name="stype" id="stype" value='<s:property value="stype"/>'>
        </div>

        <div>
            <input type="button" name="mbtnrasearch" id="mbtnrasearch" class="myButton" value="Search" onclick="mainloadSearch();">
        </div>
    </div>

    <div id="srefreshdiv">
        <jsp:include page="submainSearch.jsp"></jsp:include>
    </div>
</div>
</body>
</html>