<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page import="com.controlcentre.masters.vehiclemaster.leasecdw.*" %>
<% 
    String contextPath = request.getContextPath();
    ClsLeaseCDWDAO cdwdao = new ClsLeaseCDWDAO(); 
%>
<!DOCTYPE html>
<html>
<head>
<title>GatewayERP(i) - Vehicle Master</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<jsp:include page="../../../../includes.jsp"></jsp:include>

<script type="text/javascript">
	$(document).ready(function() {
		$('#branchid').val(window.parent.branchid.value);
		
		// Dynamic Lease CDW visibility logic
		$('#leasecdwdiv').hide();
		var cdwstatus = '<%=cdwdao.getActiveStatus()%>';
		if(cdwstatus == "1") {
			$('#leasecdwdiv').show();
		} else {
			$('#leasecdwdiv').hide();
		}
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
   SCOPED UI: Vehicle Master Navigation
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
        <h3>Vehicle Master</h3>
        <hr>
    </div>
    
    <div class="nav-buttons">
        <div class="nav-item"><input type="button" name="btnbrand" class="myButton" value="Brand" onclick='document.getElementById("iframe1").src="<%=contextPath%>/com/controlcentre/masters/vehiclemaster/brand.jsp";'></div>
        <div class="nav-item"><input type="button" id="btnenginesize" name="btnenginesize" class="myButton" value="Engine Size" onclick='document.getElementById("iframe1").src="<%=contextPath%>/com/controlcentre/masters/vehiclemaster/enginesize/engineSize.jsp";'></div>
        <div class="nav-item"><input type="button" name="btnmodel" class="myButton" value="Model" onclick='document.getElementById("iframe1").src="<%=contextPath%>/com/controlcentre/masters/vehiclemaster/model.jsp";'></div>
        <div class="nav-item"><input type="button" name="btnauthority" class="myButton" value="Authority" onclick='document.getElementById("iframe1").src="<%=contextPath%>/com/controlcentre/masters/vehiclemaster/authority.jsp";'></div>
        <div class="nav-item"><input type="button" name="btnplatecode" class="myButton" value="Plate Code" onclick='document.getElementById("iframe1").src="<%=contextPath%>/com/controlcentre/masters/vehiclemaster/plateCode.jsp";'></div>
        <div class="nav-item"><input type="button" name="btngroup" class="myButton" value="Group" onclick='document.getElementById("iframe1").src="<%=contextPath%>/com/controlcentre/masters/vehiclemaster/group.jsp";'></div>
        <div class="nav-item"><input type="button" name="btndealer" class="myButton" value="Dealer" onclick='document.getElementById("iframe1").src="<%=contextPath%>/com/controlcentre/masters/vehiclemaster/dealer.jsp";'></div>
        <div class="nav-item"><input type="button" name="btnfinance" class="myButton" value="Financier" onclick='document.getElementById("iframe1").src="<%=contextPath%>/com/controlcentre/masters/vehiclemaster/financier.jsp";'></div>
        <div class="nav-item"><input type="button" name="btninsurance" class="myButton" value="Insurance" onclick='document.getElementById("iframe1").src="<%=contextPath%>/com/controlcentre/masters/vehiclemaster/insurance.jsp";'></div>
        <div class="nav-item"><input type="button" name="btncolor" class="myButton" value="Color" onclick='document.getElementById("iframe1").src="<%=contextPath%>/com/controlcentre/masters/vehiclemaster/color.jsp";'></div>
        <div class="nav-item"><input type="button" name="btnunit" class="myButton" value="Unit" onclick='document.getElementById("iframe1").src="<%=contextPath%>/com/controlcentre/masters/vehiclemaster/unit.jsp";'></div>
        <div class="nav-item"><input type="button" name="btnspecs" class="myButton" value="Specification" onclick='document.getElementById("iframe1").src="<%=contextPath%>/com/controlcentre/masters/vehiclemaster/specification.jsp";'></div>
        <div class="nav-item"><input type="button" id="btnproject" name="btnproject" class="myButton" value="Project" onclick='document.getElementById("iframe1").src="<%=contextPath%>/com/controlcentre/masters/vehiclemaster/project.jsp";'></div>
        
        <!-- Dynamically hidden/shown via jQuery -->
        <div class="nav-item" id="leasecdwdiv">
            <input type="button" id="btnleasecdw" name="btnleasecdw" class="myButton" value="Lease CDW" onclick='document.getElementById("iframe1").src="<%=contextPath%>/com/controlcentre/masters/vehiclemaster/leasecdw.jsp";'>
        </div>
    </div>
</div>

<div id="comiframe">
    <iframe id="iframe1" frameborder="0" src="<%=contextPath%>/com/controlcentre/masters/vehiclemaster/brand.jsp"></iframe>
</div>

<div style="display:none;">
    <input type="hidden" id="formName" name="formName" value='000'/>
    <input type="hidden" id="formCode" name="formCode" value='veh'/>
    <input type="hidden" id="branchid" name="branchid" value=''/>
    <input type="hidden" id="mode" name="mode" />
</div>

</body>
</html>