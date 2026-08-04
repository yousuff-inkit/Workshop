<%@page import="com.dashboard.ClsDashBoardDAO"%>
<%
    ClsDashBoardDAO DAO = new ClsDashBoardDAO();
    String contextPath = request.getContextPath();
    String rawDashData = DAO.getDashboardData("1");
    
    // 1. Prevent JSON Parse Syntax Errors on null or empty responses
    if (rawDashData == null || rawDashData.trim().isEmpty()) {
        rawDashData = "{}"; 
    } else {
        // Escape rogue backslashes and single quotes to protect JS context
        rawDashData = rawDashData.replace("\\", "\\\\").replace("'", "\\'");
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../includes.jsp"></jsp:include>

<style>
.redClass { color: #FF0000; }
.hidden-scrollbar {
  overflow: auto;
  height: 580px;
}
.no-data-msg {
    text-align: center;
    color: #888;
    font-size: 12px;
    padding-top: 20px;
}
</style>

<script type="text/javascript">
    // 2. Safely parse the dashboard JSON
    var dashboarddata = {};
    try {
        var rawJsonString = '<%= rawDashData %>';
        if (rawJsonString && rawJsonString.trim() !== '') {
            dashboarddata = JSON.parse(rawJsonString);
        }
    } catch(e) {
        console.error('Error parsing dashboard JSON:', e);
    }

    $(document).ready(function () {
        $('#db').hide(); $("#btnPrevious").hide(); $("#btnRemove").hide();
           
        // ==========================================
        // Floor Status Chart
        // ==========================================
        var floorData = dashboarddata.floorstatusdata || [];
        var floorstatustotal = 0;
        
        // 3. Fallback logic if array is empty so $.each doesn't crash
        if (floorData.length > 0) {
            $.each(floorData, function (key, val) {
                floorstatustotal += parseFloat(val.per || 0);
            });
        } else {
            floorData = [{ "per": "1", "tran_code": "No Data" }];
            floorstatustotal = 1;
        }
        
        var charts = [
            { title: '', label: 'Stat', dataSource: floorData }
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
                        series: [
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
                                    if (isNaN(value) || floorstatustotal === 0) return value;
                                    var percentage = (value / floorstatustotal) * 100;
                                    return percentage.toFixed(2) + '%';
                                }
                            }
                        ]
                    }
                ]
            };
            
            // 4. Verify library is loaded before calling
            if (typeof $.jqx !== 'undefined' && typeof $.jqx.dataAdapter !== 'undefined') {
                $('#floorStatus' + (i + 1)).jqxChart(chartSettings);
            } else {
                $('#floorStatus' + (i + 1)).html('<div class="no-data-msg">Loading charts...</div>');
            }
        }

        // ==========================================
        // Week-Wise Vehicles in Garage
        // ==========================================
        var data3 = dashboarddata.floorweekwisedata || [];
        if (data3.length === 0) {
             data3 = [{"weeks":"No Data","gip":"0","est":"0","qot":"0","job":"0","jcc":"0","wiv":"0","rls":"0"}];
        }
        
        var sourceWeekly = {
           datatype: "json",
           datafields: [
               { name: 'weeks' }, { name: 'gip' }, { name: 'est' }, { name: 'qot' },
               { name: 'job' }, { name: 'jcc' }, { name: 'wiv' }, { name: 'rls' }
           ],
           localdata: data3
        };
         
        if (typeof $.jqx !== 'undefined') {
            var dataAdapterWeekly = new $.jqx.dataAdapter(sourceWeekly, {
               async: false,
               autoBind: true,
               loadError: function (xhr, status, error) { console.error('Data error: ' + error); }
            });
             
            var settingsWeekly = {
                 title: "Week-Wise Vehicles in Garage",
                 description: "",
                 enableAnimations: true,
                 showLegend: true,
                 padding: { left: 5, top: 5, right: 5, bottom: 5 },
                 titlePadding: { left: 0, top: 0, right: 0, bottom: 10 },
                 source: dataAdapterWeekly,
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
                            description: 'No. of Vehicles'
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
            $('#vehicleInGarageWeekly').jqxChart(settingsWeekly);
        }

        // ==========================================
        // Days Utilize (Vehicles Incoming)
        // ==========================================
        var data10 = dashboarddata.vehincomingdata || [];
        if (data10.length === 0) {
             data10 = [{"days":"No Data","vehicles":"0"}];
        }
        
        var sourceDays = {
            datatype: "json",
            datafields: [
                { name: 'vehicles' }, { name: 'days' }
            ],
            localdata: data10
        };
        
        if (typeof $.jqx !== 'undefined') {
            var dataAdapterDays = new $.jqx.dataAdapter(sourceDays, {
               loadError: function (xhr, status, error) { console.error('Data error: ' + error); }
            });
           
            var settingsDays = {
                title: "Vehicles Incoming",
                description: "",
                showLegend: true,
                enableAnimations: true,
                padding: { left: 5, top: 5, right: 5, bottom: 5 },
                titlePadding: { left: 0, top: 0, right: 0, bottom: 10 },
                source: dataAdapterDays,
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
                            { dataField: 'vehicles', displayText: 'Count'}
                        ]
                    }
                ]
            };
            $('#daysUtilize').jqxChart(settingsDays);
        }
    });
    
    function getMessengerCount() {
        var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {
                try {
                    var items = x.responseText.trim().split('####');
                    var msgcnt = items[1];
        
                    // 5. Ensure parent document access doesn't trigger security/undefined errors
                    if(window.parent && window.parent.document) {
                        var iconNm = window.parent.document.getElementById("iconnm");
                        var iconYm = window.parent.document.getElementById("iconym");
                        
                        if(iconNm && iconYm) {
                            if(msgcnt > 0) {
                                iconNm.style.display = 'none';
                                iconYm.style.display = 'inline-block';
                            } else {
                                iconYm.style.display = 'none';
                                iconNm.style.display = 'inline-block';
                            }
                        }
                    }
                } catch(e) { console.error(e); }
            }
        };
        x.open("GET", "<%=contextPath%>/com/messenger/getMsgCount.jsp", true);
        x.send();
    }
</script>
</head>
<body style="background-color: #fff;" onclick="getMessengerCount();">
    <div class='hidden-scrollbar'>
        <table width="100%">
            <tr>
                <td width="30%" valign="top">
                    <table width="100%">
                        <tr><td>&nbsp;</td></tr> 
                        <tr><td><div id='floorStatus1' style="width: 100%; height: 190px;"></div></td></tr>
                        <tr><td><div id='vehicleInGarageWeekly' style="width: 100%; height: 170px;"></div></td></tr>
                        <tr><td><div id='daysUtilize' style="width: 100%; height: 170px;"></div></td></tr>
                    </table>
                </td>
                <td width="40%" valign="top"> 
                    <table width="100%">
                        <tr><td>&nbsp;</td></tr>
                        <tr>
                            <td colspan="2">
                                <center><img src="../../icons/ink_new_logo_2025.png" onclick="location.reload();" style="width:50%;height:30px; cursor:pointer;" alt="Logo"></center>
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