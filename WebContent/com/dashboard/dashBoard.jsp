<%@page import="com.dashboard.ClsDashBoardDAO"%>
<%ClsDashBoardDAO DAO= new ClsDashBoardDAO();%>
<!DOCTYPE html>
<% String contextPath=request.getContextPath();%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../includes.jsp"></jsp:include>

<style>
.redClass {
   color: #FF0000;            
}
.hidden-scrollbar {
  overflow: auto;
  height: 580px;
}
</style>

<script type="text/javascript">
var dashboarddata = JSON.parse('<%=DAO.getDashboardData("1")%>');

/*
function addTab(title, url){
	if ($('../../menu.jsp #tt').tabs('exists', title)){
		$('../../menu.jsp #tt').tabs('select', title);
	} else {
	    var content = '<iframe scrolling="auto" frameborder="0"  src="'+url+'" style="width:100%;height:100%;"></iframe>';
		$('../../menu.jsp #tt').tabs('add',{
			title:title,
			content:content,
			closable:true
		 });
	} 
}
*/

$(document).ready(function () {
    $('#db').hide();
    $("#btnPrevious").hide();
    $("#btnRemove").hide();
    
    console.log('RAW: ' + dashboarddata);

    /* Floor Status Chart Starts */
    var data = dashboarddata.floorstatusdata;
    var floorstatustotal = 0;
    
    $.each(data, function (key, val) {
        floorstatustotal += parseInt(val.per);
    });

    var dataStatCounter = data;

    var charts = [
        { title: '', label: 'Stat', dataSource: dataStatCounter }
    ];
    
    for (var i = 0; i < charts.length; i++) {
        var chartSettings = {
            source: charts[i].dataSource,
            title: 'Floor Status',
            description: charts[i].title,
            enableAnimations: false,
            showLegend: true,
            showBorderLine: true,
            padding: { left: 5, top: 5, right: 5, bottom: 5 },
            titlePadding: { left: 0, top: 0, right: 0, bottom: 10 },
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
                                labelRadius: 140,
                                labelLinesEnabled: true,
                                labelLinesAngles: true,
                                labelsAutoRotate: false,
                                initialAngle: 0,
                                radius: 110,
                                minAngle: 0,
                                maxAngle: 180,
                                centerOffset: 0,
                                offsetY: 110,
                                formatFunction: function (value, itemIdx, serieIndex, groupIndex) {
                                    if (isNaN(value))
                                        return value;
                                    else {
                                        value = (value / floorstatustotal) * 100;
                                        value = value.toFixed(2);
                                    }
                                    return value + '%';
                                }
                            }
                        ]
                }
            ]
        };
        // select container and apply settings
        var selector = '#floorStatus' + (i + 1);
        $(selector).jqxChart(chartSettings);
    } 
    /* Floor Status Chart Ends */
    
    /* Week-Wise Vehicles in Garage Starts */
    var data3 = dashboarddata.floorweekwisedata;
    
    var source = {
        datatype: "json",
        datafields: [
            { name: 'weeks' },
            { name: 'gip' },
            { name: 'est' },
            { name: 'qot' },
            { name: 'job' },
            { name: 'jcc' },
            { name: 'wiv' },
            { name: 'rls' }
        ],
        localdata: data3
    };
        
    var dataAdapter = new $.jqx.dataAdapter(source, {
        async: false,
        autoBind: true,
        loadError: function (xhr, status, error) {
            alert('Error loading "' + source.url + '" : ' + error);
        }
    });
        
    var settings = {
        title: "Week-Wise Vehicles in Garage",
        description: "",
        enableAnimations: true,
        showLegend: true,
        padding: { left: 5, top: 5, right: 5, bottom: 5 },
        titlePadding: { left: 0, top: 0, right: 0, bottom: 10 },
        source: dataAdapter,
        xAxis: {
            dataField: 'weeks',
            tickMarks: { visible: false, color: '#BCBCBC' }, 
            gridLines: { visible: false, color: '#BCBCBC' } 
        },
        colorScheme: 'scheme04',
        seriesGroups: [
            {
                type: 'stackedcolumn',
                columnsGapPercent: 15,
                seriesGapPercent: 10,
                columnsMaxWidth: 20,
                columnsMinWidth: 1,
                valueAxis: {
                    visible: true,
                    minValue: 0,
                    description: 'No. of Vehicles',
                },
                series: [
                        { dataField: 'gip', displayText: 'GIP' },
                        { dataField: 'est', displayText: 'EST' },
                        { dataField: 'qot', displayText: 'QOT' },
                        { dataField: 'job', displayText: 'JOB' },
                        { dataField: 'jcc', displayText: 'JCC' },
                        { dataField: 'rls', displayText: 'RLS' },
                        { dataField: 'wiv', displayText: 'WIV' }
                    ]
            }
        ]
    };
    $('#vehicleInGarageWeekly').jqxChart(settings);
    /* Week-Wise Vehicles in Garage Ends */
    
    /* Days Utilize Starts */
    var data10 = dashboarddata.vehincomingdata;
    
    var source10 = {
        datatype: "json",
        datafields: [
            { name: 'vehicles' },
            { name: 'days' }
        ],
        localdata: data10
    };
    
    var dataAdapter10 = new $.jqx.dataAdapter(source10, {
        loadError: function (xhr, status, error) {
            alert(error);    
        }
    });
    
    var settings10 = {
        title: "Vehicles Incoming",
        description: "",
        showLegend: true,
        enableAnimations: true,
        padding: { left: 5, top: 5, right: 5, bottom: 5 },
        titlePadding: { left: 0, top: 0, right: 0, bottom: 10 },
        source: dataAdapter10,
        xAxis: {
            description: 'Days', 
            dataField: 'days',
            showGridLines: true
        },
        colorScheme: 'scheme05',
        seriesGroups: [
            {
                type: 'column',
                columnsGapPercent: 15,
                seriesGapPercent: 10,
                columnsMaxWidth: 20,
                columnsMinWidth: 1,
                valueAxis: {
                    displayValueAxis: true,
                    description: 'No of Vehicles'
                },
                series: [
                        { dataField: 'vehicles', displayText: ''}
                    ]
            }
        ]
    };
    $('#daysUtilize').jqxChart(settings10);
    /* Days Utilize Ends */
    
});

function getMessengerCount() {
    var x = new XMLHttpRequest();
    var msgcnt;
    var user;
    
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText;
            items = items.trim().split('####');
            user = items[0];
            msgcnt = items[1];

            if (msgcnt > 0) {
                window.parent.document.getElementById("iconnm").style.display = 'none';
                window.parent.document.getElementById("iconym").style.display = 'inline-block';
            } else {
                window.parent.document.getElementById("iconym").style.display = 'none';
                window.parent.document.getElementById("iconnm").style.display = 'inline-block';
            }
        }
    };
    x.open("GET", "<%=contextPath%>" + "/com/messenger/getMsgCount.jsp", true);
    x.send();
}
</script>
</head>

<body style="background-color: #fff;" onclick="getMessengerCount();">
    <div class="hidden-scrollbar">
        <table width="100%">
            <tr>
                <!-- LEFT COLUMN (30%) -->
                <td width="30%" valign="top">
                    <table width="100%">
                        <tr><td>&nbsp;</td></tr> 
                        <tr><td><div id="floorStatus1" style="width: 100%; height: 190px;"></div></td></tr>
                        <tr><td><div id="vehicleInGarageWeekly" style="width: 100%; height: 170px;"></div></td></tr>
                        <tr><td><div id="daysUtilize" style="width: 100%; height: 170px;"></div></td></tr>
                    </table>
                </td>
                
                <!-- MIDDLE COLUMN (40%) -->
                <td width="40%" valign="top"> 
                    <table width="100%">
                        <tr><td>&nbsp;</td></tr>
                        <tr>
                            <td colspan="2">
                                <center>
                                    <img src="../../icons/ink_new_logo_2025.png" onclick="location.reload();" style="width:50%;height:30px; cursor:pointer;">
                                </center>
                            </td>
                        </tr>  
                        <tr>
                            <td width="50%" valign="top">
                                <div><jsp:include page="dashboardGridMaster.jsp"></jsp:include></div>
                            </td>
                            <td width="50%" valign="top">
                                <div id="dashboardGridDetail1"><jsp:include page="dashboardGridDetails.jsp"></jsp:include></div>
                            </td> 
                        </tr>
                    </table>
                </td>
                
                <!-- RIGHT COLUMN (30%) -->
                <td width="30%" valign="top">
                    <table width="100%">
                        <tr><td>&nbsp;</td></tr>
                        <tr>
                            <td>
                                <div id="floorStatusDiv"><jsp:include page="floorStatusGrid.jsp"></jsp:include></div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <fieldset style="background-color: #FFF8B3;">
                                    <div><jsp:include page="toDoList.jsp"></jsp:include></div>
                                </fieldset>
                            </td>
                        </tr> 
                    </table>
                </td>
            </tr>
        </table> 
    </div> 
</body>
</html>