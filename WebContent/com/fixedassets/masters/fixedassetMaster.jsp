<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<jsp:include page="../../../includes.jsp"></jsp:include>

<script type="text/javascript">
	$(document).ready(function() {
		$('#branchid').val(window.parent.branchid.value); 
	});

	// Active button styling logic
	document.addEventListener("DOMContentLoaded", function () {
		const buttons = document.querySelectorAll(".myButton");

		buttons.forEach(btn => {
		    btn.addEventListener("click", function () {
		        buttons.forEach(b => b.classList.remove("active"));
		        this.classList.add("active");
		    });
		});

		// Auto-highlight first button on page load
		if (buttons.length > 0) {
		    buttons[0].classList.add("active");
		}
	});
</script>

<style type="text/css">
/* =========================================================
   SCOPED UI: Fixed Asset Master Navigation
========================================================= */

body {
    display: flex;
    margin: 0;
    padding: 0;
    height: 100vh;
    overflow: hidden;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    background-color: #f5f7fa; 
}

/* Sidebar Navigation */
#nav {
    width: 240px; 
    height: 100vh;
    padding: 20px 15px;
    box-sizing: border-box;
    background: #ffffff; 
    border-right: 1px solid #c5d3e0; 
    box-shadow: 2px 0 8px rgba(0,0,0,0.03);
    overflow-y: auto;
    z-index: 10;
}

#nav::-webkit-scrollbar {
    width: 6px;
}
#nav::-webkit-scrollbar-thumb {
    background: #c5d3e0;
    border-radius: 4px;
}

#header h3 {
    font-size: 14px;
    color: #0b45a2; 
    margin: 0 0 12px 0;
    text-transform: uppercase;
    font-weight: 800;
    letter-spacing: 0.5px;
}

#header hr {
    border: 0;
    border-top: 1px solid #e2e8f0;
    margin: 0 0 15px 0;
}

.nav-buttons {
    display: flex;
    flex-direction: column;
    gap: 6px; 
    width: 100%;
}

.nav-item {
    width: 100%;
}

.myButton {
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    font-weight: 600;
    font-size: 13px;
    width: 100%; 
    height: 36px;
    padding: 0 15px;
    background: transparent;
    color: #4b5563;
    border: 1px solid transparent;
    border-radius: 6px;
    cursor: pointer;
    transition: all 0.2s ease;
    text-align: left; 
}

.myButton:hover {
    background: #f1f5f9;
    color: #0b45a2;
}

.myButton.active {
    background: linear-gradient(135deg, #0b45a2 0%, #2563eb 100%);
    color: #ffffff;
    box-shadow: 0 2px 6px rgba(59, 130, 246, 0.3);
    font-weight: 700;
    letter-spacing: 0.3px;
}

/* Content Area */
#comiframe {
    flex-grow: 1;
    height: 100vh;
    background: #f5f7fa; 
}

#comiframe iframe {
    width: 100%;
    height: 100%;
    border: none;
    display: block;
}

body::-webkit-scrollbar {
    width: 0px;
}
</style>
</head>

<body>
<div id="nav">
    <div id="header">
        <h3>Fixed Asset Master</h3>
        <hr>
    </div>
    
    <div class="nav-buttons">
        <div class="nav-item"><input type="button" class="myButton" value="Group Master" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/fixedassets/masters/groupMaster.jsp";'></div>
        <div class="nav-item"><input type="button" class="myButton" value="Loc. Master" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/fixedassets/masters/locationMaster.jsp";'></div>
    </div>
</div>

<div id="comiframe">
    <iframe id="iframe2" frameborder="0" src="<%=contextPath%>/com/fixedassets/masters/groupMaster.jsp"></iframe>
</div>

<div style="display:none;">
    <input type="hidden" id="formName" name="formName" value='000'/>
    <input type="hidden" id="formCode" name="formCode" value='SAP'/>
    <input type="hidden" id="branchid" name="branchid" value=''/>
    <input type="hidden" id="mode" name="mode" />
</div>

</body>
</html>