<%@page import="com.dashboard.vehicle.ClsvehicleDAO" %>
<% ClsvehicleDAO cvd=new ClsvehicleDAO();%>
<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>

<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 
<script type="text/javascript">

$(document).ready(function () {
  $("#chart").show();
  $("#branchwisediv").hide();
  $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
  $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	
	  
	  $("#grid1").hide();
	
	  $("#grid2").hide();
	 var data  =<%=cvd.firstchart()%>;
     
     var dataStatCounter = data;
 
     var charts = [
         { title: '', label: 'Stat', dataSource: dataStatCounter }
     ];
     for (var i = 0; i < charts.length; i++) {
         var chartSettings = {
             source: charts[i].dataSource,
             title: 'On Hire',
             description: charts[i].title,
             enableAnimations: false,
             showLegend: true,
             showBorderLine: true,
             padding: { left: 5, top: 30, right: 5, bottom: 5 },
             titlePadding: { left: 0, top: 0, right: 0, bottom: 20 },
             colorScheme: 'scheme07',
             seriesGroups: [
                 {
                     type: 'pie',
                     showLegend: true,
                     enableSeriesToggle: true,
                     series:
                         [
                             {
                                 dataField: 'per',
                                 displayText: 'tran_code',
                                 showLabels: true,
                                 labelRadius: 200,
                                 labelLinesEnabled: true,
                                 labelLinesAngles: true,
                                 labelsAutoRotate: false,
                                 initialAngle: 0,
                                 radius: 180,
                                 minAngle: 0,
                                 maxAngle: 180,
                                 centerOffset: 0,
                                 offsetY: 180,
                                 formatFunction: function (value, itemIdx, serieIndex, groupIndex) {
                                     if (isNaN(value))
                                         return value;
                                     return value + '%';
                                 }
                             }
                         ]
                 }
             ]
         };
         var selector = '#fleetStatus' + (i + 1);
         $(selector).jqxChart(chartSettings); 
     }
 var data1  =<%=cvd.Secondchart()%>;
     
     var dataStatCounter1 = data1;
 
     var charts = [
         { title: '', label: 'Stat', dataSource: dataStatCounter1 }
     ];
     for (var i = 0; i < charts.length; i++) {
    	 var chartSettings = {
                 source: charts[i].dataSource,
                 title: 'Available',
                 description: charts[i].title,
                 enableAnimations: false,
                 showLegend: true,
                 showBorderLine: true,
                 padding: { left: 5, top: 30, right: 5, bottom: 5 },
                 titlePadding: { left: 0, top: 0, right: 0, bottom: 20 },
                 colorScheme: 'scheme05',
                 seriesGroups: [
                     {
                         type: 'pie',
                         showLegend: true,
                         enableSeriesToggle: true,
                         series:
                             [
                                 {
                                     dataField: 'per',
                                     displayText: 'tran_code',
                                     showLabels: true,
                                     labelRadius: 200,
                                     labelLinesEnabled: true,
                                     labelLinesAngles: true,
                                     labelsAutoRotate: false,
                                     initialAngle: 0,
                                     radius: 180,
                                     minAngle: 0,
                                     maxAngle: 180,
                                     centerOffset: 0,
                                     offsetY: 180,
                                  formatFunction: function (value, itemIdx, serieIndex, groupIndex) {
                                     if (isNaN(value))
                                         return value;
                                     return value + '%';
                                 }
                             }
                         ]
                 }
             ]
         };
         var selector = '#sec' + (i + 1);
         $(selector).jqxChart(chartSettings); 
     }
 var data2  =<%=cvd.Thirdchart()%>;
     
     var dataStatCounter2 = data2;
 
     var charts = [
         { title: '', label: 'Stat', dataSource: dataStatCounter2 }
     ];
     for (var i = 0; i < charts.length; i++) {
         var chartSettings = {
             source: charts[i].dataSource,
             title: 'Garage',
             description: charts[i].title,
             enableAnimations: false,
             showLegend: true,
             showBorderLine: true,
             padding: { left: 5, top: 30, right: 5, bottom: 5 },
             titlePadding: { left: 0, top: 0, right: 0, bottom: 20 },
             colorScheme: 'scheme02',
             seriesGroups: [
                 {
                     type: 'pie',
                     showLegend: true,
                     enableSeriesToggle: true,
                     series:
                         [
                             {
                                 dataField: 'per',
                                 displayText: 'tran_code',
                                 showLabels: true,
                                 labelRadius: 200,
                                 labelLinesEnabled: true,
                                 labelLinesAngles: true,
                                 labelsAutoRotate: false,
                                 initialAngle: 0,
                                 radius: 180,
                                 minAngle: 0,
                                 maxAngle: 180,
                                 centerOffset: 0,
                                 offsetY: 180,
                                 formatFunction: function (value, itemIdx, serieIndex, groupIndex) {
                                     if (isNaN(value))
                                         return value;
                                     return value + '%';
                                 }
                             }
                         ]
                 }
             ]
         };
         var selector = '#thr' + (i + 1);
         $(selector).jqxChart(chartSettings); 
     }
     var data4=<%=cvd.Fourthchart()%>;
     
     var dataStatCounter4 = data4;
 
     var charts = [
         { title: '', label: 'Stat', dataSource: dataStatCounter4 }
     ];
     for (var i = 0; i < charts.length; i++) {
         var chartSettings = {
             source: charts[i].dataSource,
             title: 'All',
             description: charts[i].title,
             enableAnimations: false,
             showLegend: true,
             showBorderLine: true,
             padding: { left: 5, top: 30, right: 5, bottom: 5 },
             titlePadding: { left: 0, top: 0, right: 0, bottom: 20 },
             colorScheme: 'scheme01',
             seriesGroups: [
                 {
                     type: 'pie',
                     showLegend: true,
                     enableSeriesToggle: true,
                     series:
                         [
                             {
                                 dataField: 'per',
                                 displayText: 'tran_code',
                                 showLabels: true,
                                 labelRadius: 200,
                                 labelLinesEnabled: true,
                                 labelLinesAngles: true,
                                 labelsAutoRotate: false,
                                 initialAngle: 0,
                                 radius: 180,
                                 minAngle: 0,
                                 maxAngle: 180,
                                 centerOffset: 0,
                                 offsetY: 180,
                                 formatFunction: function (value, itemIdx, serieIndex, groupIndex) {
                                     if (isNaN(value))
                                         return value;
                                     return value + '%';
                                 }
                             }
                         ]
                 }
             ]
         };
         var selector = '#four' + (i + 1);
         $(selector).jqxChart(chartSettings); 
     }
   
});

function funreload(event)
{
	
	  $("#chart").show();
	  $("#grid1").hide();
	  $("#grid2").hide();

	 var barchval = document.getElementById("cmbbranch").value;
	$('#chart').hide();
	$('#branchwisediv').show();
	  $("#Readygrid").load("vehDetailsgrid.jsp?barchval="+barchval);
	  $("#branchwisediv").load("branchwiseGrid.jsp?check=1");
	}
	

	
function funExportBtn()
{
	
	
  	if(document.getElementById("chkgrid").value=="chkgrids")
	
	
		{
		 JSONToCSVConvertor(vehicleexceldata, 'Availability', true);
		}
	else
		{  
	 	 
		
	 	JSONToCSVConvertor(exceldata, 'Availability', true);
		
		  }
	  
	
	 
	
	
	
	
	}
	
	function funsetaval()
	{
		  if (document.getElementById('det_chk').checked) {
		
		document.getElementById("chkdatails").value="search";
		   $('#jqxFleetGrid').jqxGrid('showcolumn', 'empid');
		   $('#jqxFleetGrid').jqxGrid('showcolumn', 'empname');
		   

		   $('#vehiclelist').jqxGrid('showcolumn', 'rdocno');
		   $('#vehiclelist').jqxGrid('showcolumn', 'empname');
		  }
		  else
			  {
			  document.getElementById("chkdatails").value="";
			   $('#jqxFleetGrid').jqxGrid('hidecolumn', 'empid');
			   $('#jqxFleetGrid').jqxGrid('hidecolumn', 'empname');
			   
			   $('#vehiclelist').jqxGrid('hidecolumn', 'rdocno');
			   $('#vehiclelist').jqxGrid('hidecolumn', 'empname');
			  }
		  
		  
		 /*    if(document.getElementById("chkdatails").value=="search")
			{
			   $('#vehdetails').jqxGrid('showcolumn', 'rdocno');
			   $('#vehdetails').jqxGrid('showcolumn', 'empname');
			}
		else
			{
		   $('#vehdetails').jqxGrid('hidecolumn', 'rdocno');
		   $('#vehdetails').jqxGrid('hidecolumn', 'empname');

			} */
	}
	
	function JSONToCSVConvertor(JSONData, ReportTitle, ShowLabel) {
		
	    var arrData = typeof JSONData != 'object' ? JSON.parse(JSONData) : JSONData;
	    
	   // alert("arrData");
	    var CSV = '';    
	    //Set Report title in first row or line
	    
	    CSV += ReportTitle + '\r\n\n';

	    //This condition will generate the Label/Header
	    if (ShowLabel) {
	        var row = "";
	        
	        //This loop will extract the label from 1st index of on array
	        for (var index in arrData[0]) {
	            
	            //Now convert each value to string and comma-seprated
	            row += index + ',';
	        }

	        row = row.slice(0, -1);
	        
	        //append Label row with line break
	        CSV += row + '\r\n';
	    }
	    
	    //1st loop is to extract each row
	    for (var i = 0; i < arrData.length; i++) {
	        var row = "";
	        
	        //2nd loop will extract each column and convert it in string comma-seprated
	        for (var index in arrData[i]) {
	            row += '"' + arrData[i][index] + '",';
	        }

	        row.slice(0, row.length - 1);
	        
	        //add a line break after each row
	        CSV += row + '\r\n';
	    }

	    if (CSV == '') {        
	        alert("Invalid data");
	        return;
	    }   
	    
	    //Generate a file name
	    var fileName = "";
	    //this will remove the blank-spaces from the title and replace it with an underscore
	    fileName += ReportTitle.replace(/ /g,"_");   
	    
	    //Initialize file format you want csv or xls
	    var uri = 'data:text/csv;charset=utf-8,' + escape(CSV);
	    
	    // Now the little tricky part.
	    // you can use either>> window.open(uri);
	    // but this will not work in some browsers
	    // or you will not get the correct file extension    
	    
	    //this trick will generate a temp <a /> tag
	    var link = document.createElement("a");    
	    link.href = uri;
	    
	    //set the visibility hidden so it will not effect on your web-layout
	    link.style = "visibility:hidden";
	    link.download = fileName + ".csv";
	    
	    //this part will append the anchor tag and remove it after automatic click
	    document.body.appendChild(link);
	    link.click();
	    document.body.removeChild(link);
	}
 
</script>
</head>
<body onload="getBranch();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%">
<tr>
<td width="20%">
    <fieldset style="background: #ECF8E0;">
	<table width="100%" >
	<jsp:include page="../../heading.jsp"></jsp:include>
	
	<!--  <tr><td colspan="2">&nbsp;</td></tr> -->
 <tr><td colspan="2" align="center"><label class="branch">Detail</label><input type="checkbox" id="det_chk"  name="det_chk" value="0"   onclick="funsetaval()" >
 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td></tr> 

		 <tr>
	<td colspan="2" ><div id="Readygrid"><jsp:include page="vehDetailsgrid.jsp"></jsp:include>
	</div></td>
	</tr> 


	</table>
	</fieldset>
</td>
<td width="80%">
<div  >
	<table width="100%" id="grid1">
		<tr>
			 <td ><div  id="fleetdiv"><jsp:include page="readyToRentGrid.jsp"></jsp:include></div>
			</td></tr>
	</table>
		<table width="100%" id="grid2">
		<tr>
			 <td ><div  id="fleetdiv1"><jsp:include page="vehiclelistgrid.jsp"></jsp:include></div>
			</td></tr>
	</table>
</div>
<div >
	<table width="100%" id="chart">
		<tr>
			 <td width="50%">
			<div id='fleetStatus1' style="width: 100%; height: 250px;"></div>
			  <div id='sec1' style="width: 100%; height: 250px;"></div>
			   </td><td>  <div id='thr1' style="width: 100%; height: 250px;"></div>
			   <div id='four1' style="width: 100%; height: 250px;"></div></td></tr>
	</table>
	<div id="branchwisediv"><jsp:include page="branchwiseGrid.jsp"></jsp:include></div>
</div>
</tr>
</table>

<input type="hidden" id="chkgrid" name="chkgrid" value='<s:property value="chkgrid"/>'>

 <input type="hidden" id="chkdatails" name="chkdatails" value='<s:property value="chkdatails"/>'>
  <input type ="hidden" id="emptype" value='<s:property value="chkdatails"/>'>
   <input type ="hidden" id="empname"  value='<s:property value="chkdatails"/>'>
</div>
</div>

</body>
</html>
