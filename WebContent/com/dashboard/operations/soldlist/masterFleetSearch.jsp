<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head> 
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
<style>
.formfont {
	font: 10px Tahoma;
	color: #404040;
	background: transparent;
	overflow:hidden;
}
</style>
<script type="text/javascript">
$(document).ready(function(){
	$("#fleetdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null});
	getGroup();
	getColor();
});

function getColor(){
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText;
			items = items.split('####');
			var colorItems = items[0].split(",");
			var colorIdItems = items[1].split(",");
			var optionscolor = '<option value="">--Select--</option>';
			for (var i = 0; i < colorItems.length; i++) {
				optionscolor += '<option value="' + colorIdItems[i] + '">'
						+ colorItems[i] + '</option>';
			}
			$("select#cmbcolor").html(optionscolor);
		 	
		} else {
		}
	}
	x.open("GET", "getColor.jsp", true);
	x.send();

}
function getGroup(){
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
			$("select#cmbgroup").html(optionsgroup);
		 	
		} else {
		}
	}
	x.open("GET", "getGroup.jsp", true);
	x.send();

}
function loadFleets(){
	var fleetname=document.getElementById("fleetname").value;
	var regno=document.getElementById("regno").value;
	var color=document.getElementById("cmbcolor").value;
	var fleet=document.getElementById("fleet_no").value;
	var fleetdocno=document.getElementById("fleetdocno").value;
	var fleetdate=$('#fleetdate').jqxDateTimeInput('val');
	var group=document.getElementById("cmbgroup").value;
	$("#overlay, #PleaseWait").show();
	$('#fleetdiv').load('fleetSearch.jsp?fleetname='+fleetname+'&regno='+regno+'&color='+color+'&fleet='+fleet+'&fleetdocno='+fleetdocno+'&fleetdate='+fleetdate+'&group='+group+'&id=1');
}


</script>
</head>
<body style="background-color:#E0ECF8;">
<table width="100%">
  <tr>
    <td width="10%" align="right"><label class="formfont">Fleet Name</label></td>
    <td colspan="3" align="left"><input type="text" name="fleetname" id="fleetname" style="width:99%;height:18px;"></td>
    <td width="8%" align="right"><label class="formfont">Reg No</label></td>
    <td width="13%" align="left"><input type="text" name="regno" id="regno" style="height:18px;"></td>
    <td width="9%" align="right"><label class="formfont">Color</label></td>
    <td width="15%" align="left"><select name="cmbcolor" id="cmbcolor" style="width:120px;"><option value="">--Select--</option></select></td>
    
    <td width="13%">&nbsp;</td>
  </tr>
  <tr>
    <td align="right"><label class="formfont">Fleet No</label></td>
    <td width="13%" align="left"><input type="text" name="fleet_no" id="fleet_no" style="height:18px;"></td>
    <td width="7%" align="right"><label class="formfont">Doc No</label></td>
    <td width="12%" align="left"><input type="text" name="fleetdocno" id="fleetdocno" style="height:18px;"></td>
    <td align="right"><label class="formfont">Date</label></td>
    <td align="left"><div id="fleetdate"></div></td>
    <td align="right"><label class="formfont">Group</label></td>
    <td align="left"><select name="cmbgroup" id="cmbgroup" style="width:120px;"><option value="">--Select--</option></select></td>
    
    <td align="center"><button type="button" name="btnfleetsearch" id="btnfleetsearch" class="myButtons" onclick="loadFleets();">Search</button></td>
  </tr>
  <tr>
    <td colspan="11"><div id="fleetdiv"><jsp:include page="fleetSearch.jsp"></jsp:include></div></td>
  </tr>
</table>

</body>
</html>