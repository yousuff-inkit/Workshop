<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<% String contextPath=request.getContextPath();%>
<!--<link rel="stylesheet" type="text/css" href="../../../css/body.css">-->
<script type="text/javascript">
$(document).ready(function(e) {
    getGroup();
	getBrand();
	getModel($('#cmbsearchbrand').val());
});
function funSearchFleet(){
	var fleetno=$('#searchfleetno').val();
	var fleetname=$('#searchfleetname').val();
	var regno=$('#searchregno').val();
	var brand=$('#cmbsearchbrand').val();
	var model=$('#cmbsearchmodel').val();
	var group=$('#cmbsearchgroup').val();
	var gridrowindex='<%=request.getParameter("gridrowindex")==null?"0":request.getParameter("gridrowindex")%>';
	$('#searchfleetdiv').load('fleetSearchGrid.jsp?fleetno='+fleetno+'&fleetname='+fleetname+'&regno='+regno+'&brand='+brand+'&model='+model+'&group='+group+'&id=1&gridrowindex='+gridrowindex);
	
}

function getGroup() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var groupItems = items[0].split(",");
				var groupIdItems = items[1].split(",");
			
				var optionsgroup = '<option value="">--Select--</option>';
				for (var i = 0; i < groupItems.length; i++) {
					optionsgroup += '<option value="' + groupIdItems[i] + '">'
							+ groupItems[i] + '</option>';
				}
		
				$("select#cmbsearchgroup").html(optionsgroup);
				
				
			} else {
			}
		}
		x.open("GET", "../../controlcentre/masters/vehiclemaster/getGroup.jsp", true);
		x.send();
	}
	function getBrand() {
		
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				items = x.responseText;
				items = items.split('***');
				var brandItems = items[0].split(",");
				var brandidItems = items[1].split(",");
				var optionsbrand = '<option value="">--Select--</option>';
				for (var i = 0; i < brandItems.length; i++) {
					optionsbrand += '<option value="' + brandidItems[i] + '">'
							+ brandItems[i] + '</option>';
				}
				$("select#cmbsearchbrand").html(optionsbrand);
				
			} else {
			}
		}
		x.open("GET", "../../controlcentre/masters/vehiclemaster/getBrand.jsp", true);
		x.send();
	}
	function getModel(value) {
		//document.getElementById("fleetname").value="";
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				items = x.responseText;
				//alert("Response"+x.responseText);
				items = items.split('####');
				var modelItems = items[0].split(",");
				//alert("=="+modelItems+"==");
				var modelidItems = items[1].split(",");
				//alert("=="+modelidItems+"==");
				var optionsmodel = '<option value="">--Select--</option>';
				if(modelItems!=''){
				for (var i = 0; i < modelItems.length; i++) {
					optionsmodel += '<option value="' + modelidItems[i] + '">'
							+ modelItems[i] + '</option>';
				}
				}
				$("select#cmbsearchmodel").html(optionsmodel);
				
			} else {
			}
		}
		x.open("GET", "../../controlcentre/masters/vehiclemaster/getModel.jsp?id="+value, true);
		x.send();
	}
</script>
</head>
<body>
<table width="100%">
  <tr>
    <td width="13%" align="right">Fleet No</td>
    <td width="17%"><input type="text" name="searchfleetno" id="searchfleetno"></td>
    <td width="7%" align="right">Reg No</td>
    <td width="17%"><input type="text" name="searchregno" id="searchregno"></td>
    <td width="10%" align="right">Fleet Name</td>
    <td colspan="3"><input type="text" name="searchfleetname" id="searchfleetname" style="width:99%;"></td>
  </tr>
  <tr>
    <td align="right">Brand</td>
    <td><select name="cmbsearchbrand" id="cmbsearchbrand" style="width:97%;" onchange="getModel(this.value);"><option value="">--Select--</option></select></td>
    <td align="right">Model</td>
    <td><select name="cmbsearchmodel" id="cmbsearchmodel" style="width:97%;"><option value="">--Select--</option></select></td>
    <td align="right">Group</td>
    <td width="17%"><select name="cmbsearchgroup" id="cmbsearchgroup" style="width:97%;"><option value="">--Select--</option></select></td>
    <td width="9%" align="center">&nbsp;</td>
    <td width="10%" align="center"><button type="button" id="btnsearchfleet" name="btnsearchfleet" class="myButton" onClick="funSearchFleet();">Search</button></td>
  </tr>
  <tr>
    <td colspan="8"><div id="searchfleetdiv"><jsp:include page="fleetSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
</body>
</html>