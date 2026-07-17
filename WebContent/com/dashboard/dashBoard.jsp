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
.redClass
{
   color: #FF0000;            
}
</style>

<script type="text/javascript">
var dashboarddata=JSON.parse('<%=DAO.getDashboardData("1")%>');
/*function addTab(title, url){
	if ($('../../menu.jsp #tt').tabs('exists', title)){
		alert("exist");
		$('../../menu.jsp #tt').tabs('select', title);
	} else {
		alert("addtab"); 
	 var content = '<iframe scrolling="auto" frameborder="0"  src="'+url+'" style="width:100%;height:100%;"></iframe>';
		$('../../menu.jsp #tt').tabs('add',{
			title:title,
			content:content,
			closable:true
			/* showCloseButtons: true 
		 });
		alert("ens");
	} 
}
*/
        $(document).ready(function () {
        	$('#db').hide();$("#btnPrevious").hide();$("#btnRemove").hide();
           	
           	console.log('RAW: '+dashboarddata);
		   /* Floor Status*/
            
            var data = dashboarddata.floorstatusdata;
            var floorstatustotal=0;
            $.each(data, function (key, val) {
        		floorstatustotal+=parseInt(val.per);
    		});
            	/*[
            	 {"per":"7.18","tran_code":"GIP"},
            	 {"per":"7.06","tran_code":"EST"},
            	 {"per":"4.09","tran_code":"QOT"},
            	 {"per":"25.09","tran_code":"JOB"},
            	 {"per":"21.30","tran_code":"ASG"},
            	 {"per":"10.36","tran_code":"REL"},
            	 {"per":"15.70","tran_code":"INV"},
            	 {"per":"9.21","tran_code":"GOP"}
            	 ];
            */
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
                                            else{
                                            	value=(value/floorstatustotal)*100;
                                            	value=value.toFixed(2);
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
            } // for
            
           /* Floor Status Ends */
            
           /* Week-Wise Vehicles in Garage */
            /* ----------------------------------- */
            $(document).ready(function () {
 	    		  
 	    		var data3=dashboarddata.floorweekwisedata;
 	    		 /*var data3=[
 	    		             {"weeks":"Week 1","gip":"50","est":"0","qot":"10","job":"20","asg":"0","rel":"6","inv":"11","gop":"3"},
 	    		             {"weeks":"Week 2","gip":"40","est":"5","qot":"0","job":"15","asg":"4","rel":"0","inv":"5","gop":"11"},
 	    		             {"weeks":"Week 3","gip":"45","est":"0","qot":"2","job":"3","asg":"10","rel":"0","inv":"5","gop":"25"},
 	    		             {"weeks":"Week 4","gip":"35","est":"10","qot":"10","job":"3","asg":"1","rel":"2","inv":"1","gop":"7"}];
 	    		 */
 	                var source =
 	               {
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
 	                 
 	                var dataAdapter = new $.jqx.dataAdapter(
 	                       source,
 	                       {
 	                           async: false,
 	                           autoBind: true,
 	                           loadError: function (xhr, status, error) {
 	                               alert('Error loading "' + source.url + '" : ' + error);
 	                           }
 	                       }
 	                   );
 	                 
 	             // prepare jqxChart settings
 	             var settings = {
 	                 title: "Week-Wise Vehicles in Garage",
 	                 description: "",
 	                 enableAnimations: true,
 	                 showLegend: true,
 	                 padding: { left: 5, top: 5, right: 5, bottom: 5 },
 	                 titlePadding: { left: 0, top: 0, right: 0, bottom: 10 },
 	                 source: dataAdapter,
 	                 xAxis:
 	                     {
 	                         dataField: 'weeks',
 	                         tickMarks: {
 	                             visible: false,
 	                             color: '#BCBCBC'
 	                         }, 
 	                         gridLines: {
 	                             visible: false,
 	                             color: '#BCBCBC'
 	                         } 
 	                        
 	                     },
 	                 colorScheme: 'scheme04',
 	                 seriesGroups:
 	                     [
 	                         {
 	                             type: 'stackedcolumn',
 	                             columnsGapPercent: 15,
                        		 seriesGapPercent: 10,
                                 columnsMaxWidth: 20,
                                 columnsMinWidth: 1,
                                 valueAxis:
  	                            {
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
 	             // setup the chart
 	             $('#vehicleInGarageWeekly').jqxChart(settings);
 	         });
            /* -------------------------------------- */
            /* Week-Wise Vehicles in Garage Ends */
            
            /* Days Utilize */
            /* ----------------------------------- 
            var data10= [{"days":"10 Jan","vehicles":"1"},
                         {"days":"2","vehicles":"3"},
                         {"days":"3","vehicles":"2"},
                         {"days":"4","vehicles":"5"},
                         {"days":"5","vehicles":"7"},
                         {"days":"6","vehicles":"3"},
                         {"days":"7","vehicles":"2"},
                         {"days":"8","vehicles":"1"},
                         {"days":"9","vehicles":"4"},
                         {"days":"10","vehicles":"6"}];
            */
            var data10=dashboarddata.vehincomingdata;
            console.log(data10);
            var source =
            {
                datatype: "json",
                datafields: [
                    { name: 'vehicles' },
                    { name: 'days' }
                ],
                localdata: data10
            };
            
            // prepare chart data as an array            
            
           var dataAdapter = new $.jqx.dataAdapter(source,
           		 {
               		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
			            
		            } );
           
           // prepare jqxChart settings
            var settings = {
                title: "Vehicles Incoming",
                description: "",
                showLegend: true,
                enableAnimations: true,
                padding: { left: 5, top: 5, right: 5, bottom: 5 },
                titlePadding: { left: 0, top: 0, right: 0, bottom: 10 },
                source: dataAdapter,
                xAxis:
                    {
                		description: 'Days', 
                        dataField: 'days',
                        showGridLines: true
                    },
                colorScheme: 'scheme05',
                seriesGroups:
                    [
                        {
                            type: 'column',
                            columnsGapPercent: 15,
                            seriesGapPercent: 10,
                            columnsMaxWidth: 20,
                            columnsMinWidth: 1,
                            valueAxis:
                            {
                                displayValueAxis: true,
                                description: 'No of Vehicles'
                            },
                            series: [
                                    { dataField: 'vehicles', displayText: ''}
                                ]
                        }
                    ]
            };
            // setup the chart
            $('#daysUtilize').jqxChart(settings);
            /* -------------------------------------- */
            /*  Days Utilize Ends */
            
        });
		
		function getMessengerCount() {
		var x=new XMLHttpRequest();
		var msgcnt;
		var user;
		x.onreadystatechange=function(){
			
			if (x.readyState==4 && x.status==200)
				{
				
					items= x.responseText;
				
					items=items.trim().split('####');
					user=items[0];
					msgcnt=items[1];
		
						if(msgcnt>0){
							window.parent.document.getElementById("iconnm").style.display = 'none';
							window.parent.document.getElementById("iconym").style.display = 'inline-block';
						}
						else{
							window.parent.document.getElementById("iconym").style.display = 'none';
							window.parent.document.getElementById("iconnm").style.display = 'inline-block';
		
						}
					
				    
				}
			else
				{
				}
		}
		x.open("GET",<%=contextPath+"/"%>+"com/messenger/getMsgCount.jsp",true);
		x.send();
	}
        
        
    </script>
    
<style>
.hidden-scrollbar {
  overflow: auto;
  height: 580px;
}
</style>

    
</head>
<body style="background-color: #fff;" onclick="getMessengerCount();">
<div class='hidden-scrollbar'>
<table  width="100%">
<tr><td width="30%">
<table  width="100%">
		    <tr><td>&nbsp;</td></tr> 
			<tr><td><div id='floorStatus1' style="width: 100%; height: 190px;"></div></td></tr>
			<tr><td><div id='vehicleInGarageWeekly' style="width: 100%; height: 170px;"></div></td></tr>
			<tr><td><div id='daysUtilize' style="width: 100%; height: 170px;"></div></td></tr>

</table></td>
<td width="40%"> 
			<table width="100%" >
			<tr><td>&nbsp;</td></tr>
			    <tr><td colspan="2"><center><img src="../../icons/gw.png" onclick="location.reload ();" style="width:50%;height:30px;"></center></td></tr>  
			 	 <tr>
			 	 	<td width="50%"><div><jsp:include page="dashboardGridMaster.jsp"></jsp:include></div></td>
			  		<td width="50%">
			  			<div id="dashboardGridDetail1"><jsp:include page="dashboardGridDetails.jsp"></jsp:include></div>
			  		</td> 
			  	</tr>
			  </table>
</td>
<td width="30%">
		<table  width="100%">
		<tr><td>&nbsp;</td></tr>
		<tr><td><!-- <div id='idleDays' style="width: 97%; height: 190px;"></div> -->
		<div id="floorStatusDiv"><jsp:include page="floorStatusGrid.jsp"></jsp:include></div></td></tr>
		<tr rowspan="2"><td><fieldset style="background-color: #FFF8B3;"><div><jsp:include page="toDoList.jsp"></jsp:include></div></fieldset></td></tr> 
	    <!-- <tr><td><div id="chart1" style="width: 97%; height: 170px;"></div></td></tr>
		<tr><td><div id='stackedChart' style="width: 97%; height: 170px;"></div></td></tr> -->
		</table>
</td>
</tr></table> 
</div> 

</body>
</html>