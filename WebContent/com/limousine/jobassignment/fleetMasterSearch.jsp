<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>

<script>
$(document).ready(function() {
    funCheckAllFleets();
	getBrand();
	getGroup();
	
});
function funCheckAllFleets(){
	if(document.getElementById("chkallfleets").checked==true){

		$('#cmbsearchbrand').attr('disabled',false);
		$('#cmbsearchmodel').attr('disabled',false);
		$('#cmbsearchgroup').attr('disabled',false);
		$('#searchfleetno').attr('disabled',false);
		$('#searchfleetname').attr('disabled',false);
		
		$('#regnosearch').attr('disabled',false);
	}
	else{
		$('#cmbsearchbrand').attr('disabled',true);
		$('#cmbsearchmodel').attr('disabled',true);
		$('#cmbsearchgroup').attr('disabled',true);
		$('#searchfleetno').attr('disabled',true);
		$('#searchfleetname').attr('disabled',true);
		
		$('#regnosearch').attr('disabled',true);
		
	}
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
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			items = x.responseText;
			items = items.split('####');
			var modelItems = items[0].split(",");
			var modelidItems = items[1].split(",");
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
function funFleetSearch(){
	
	if(document.getElementById("chkallfleets").checked==true){
		var fleetno=document.getElementById("searchfleetno").value;
		var fleetname=document.getElementById("searchfleetname").value;
		var brand=document.getElementById("cmbsearchbrand").value;
		var model=document.getElementById("cmbsearchmodel").value;
		var group=document.getElementById("cmbsearchgroup").value;
		
		var regno=document.getElementById("regnosearch").value;
		
		$('#fleetsearchdiv').load('fleetSearchGrid.jsp?fleetno='+fleetno+'&fleetname='+fleetname+'&brand='+brand+'&model='+model+'&group='+group+'&allfleets=1&id=1'+'&regno='+regno);
	}
	else{
		var gridrowindex='<%=request.getParameter("gridrowindex")==null?"0":request.getParameter("gridrowindex")%>';
		var gridbrand=$('#bookDetailGrid').jqxGrid('getcellvalue',gridrowindex,'brandid');
		var gridmodel=$('#bookDetailGrid').jqxGrid('getcellvalue',gridrowindex,'modelid');
		$('#fleetsearchdiv').load('fleetSearchGrid.jsp?gridbrandid='+gridbrand+'&gridmodelid='+gridmodel+'&allfleets=0&id=1');
	}
}
</script>
</head>
<body>
<table width="100%">
  <tr>
    <td width="9%" align="right">Fleet No</td>
    <td width="10%"><input type="text" name="searchfleetno" id="searchfleetno"></td>
    <td width="10%" align="right">Fleet Name</td>
    <td width="15%"><input type="text" name="searchfleetname" id="searchfleetname" style="width:100%;"></td>
    
    <td width="17%" align="right">Reg No</td>
    <td><input type="text" name="regnosearch" id="regnosearch" style="width:100%;"></td>
    
    <td width="14%" align="center"><input type="checkbox" name="chkallfleets" id="chkallfleets" onChange="funCheckAllFleets();"><label for="chkallfleets" >All Fleets</label></td>
  </tr>
  <tr>
    <td align="right">Brand</td>
    <td><select name="cmbsearchbrand" id="cmbsearchbrand" style="width:100%;" onchange="getModel(this.value);"><option value="">--Select--</option></select></td>
    <td align="right">Model</td>
    <td width="14%"><select name="cmbsearchmodel" id="cmbsearchmodel" style="width:100%;"><option value="">--Select--</option></select></td>
    <td width="12%" align="right">Group</td>
    <td width="13%"><select name="cmbsearchgroup" id="cmbsearchgroup" style="width:100%;"><option value="">--Select--</option></select></td>
    <td align="center"><button type="button" name="btnfleetsearch" id="btnfleetsearch" class="myButton" onClick="funFleetSearch();">Search</button></td>
  </tr>
  <tr>
    <td colspan="7"><div id="fleetsearchdiv"><jsp:include page="fleetSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
</body>
</html>