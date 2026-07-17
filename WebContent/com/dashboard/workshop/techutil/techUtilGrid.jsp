<%
String month=request.getParameter("month")==null?"":request.getParameter("month");
String year=request.getParameter("year")==null?"":request.getParameter("year");
String mode=request.getParameter("mode")==null?"":request.getParameter("mode");
%>

<style>
	.yellowClass{
		background-color:#FDFF79;
	}
	.greenClass{
		background-color:#79FFA0;
	}
	.blueClass{
		background-color:#79B6FF;
	}
	.redClass{
		background-color:#FF8579;
	}
</style>
<script type="text/javascript">
var rendererstring=function (aggregates){
	var value=aggregates['sum'];
	if(value=="undefined" || typeof(value)=="undefined"){
		value="0.00";
	}
	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + value + '</div>';
}
	$(document).ready(function(){
		var month='<%=month%>';
		var year='<%=year%>';
		var mode='<%=mode%>';
		//var utildata=[{"techname":"ARUN","day1":"0.00","day2":"0.00","day3":"0.00","day4":"0.00","day5":"0.00","day6":"0.00","day7":"0.00","day8":"0.00","day9":"0.00","day10":"0.00","day11":"0.00","day12":"0.00","day13":"0.00","day14":"0.00","day15":"0.00","day16":"0.00","day17":"0.00","day18":"0.00","day19":"0.00","day20":"0.00","day21":"0.00","day22":"0.00","day23":"0.00","day24":"0.00","day25":"0.00","day26":"0.00","day27":"0.00","day28":"0.00","day29":"0.00","day30":"0.03","day31":"0.00"}];
		var utilurl='getGridData.jsp?mode='+mode+'&month='+month+'&year='+year;
		var source =
        {
            datatype: "json",
            datafields: [
            	{name:'techname',type:'string'},
            	{name:'day1',type:'number'},
            	{name:'day2',type:'number'},
            	{name:'day3',type:'number'},
            	{name:'day4',type:'number'},
            	{name:'day5',type:'number'},
            	{name:'day6',type:'number'},
            	{name:'day7',type:'number'},
            	{name:'day8',type:'number'},
            	{name:'day9',type:'number'},
            	{name:'day10',type:'number'},
            	{name:'day11',type:'number'},
            	{name:'day12',type:'number'},
            	{name:'day13',type:'number'},
            	{name:'day14',type:'number'},
            	{name:'day15',type:'number'},
            	{name:'day16',type:'number'},
            	{name:'day17',type:'number'},
            	{name:'day18',type:'number'},
            	{name:'day19',type:'number'},
            	{name:'day20',type:'number'},
            	{name:'day21',type:'number'},
            	{name:'day22',type:'number'},
            	{name:'day23',type:'number'},
            	{name:'day24',type:'number'},
            	{name:'day25',type:'number'},
            	{name:'day26',type:'number'},
            	{name:'day27',type:'number'},
            	{name:'day28',type:'number'},
            	{name:'day29',type:'number'},
            	{name:'day30',type:'number'},
            	{name:'day31',type:'number'},
            	{name:'totalclockin',type:'number'},
            	//{name:'esttotalhrs',type:'number'},
            	{name:'totalavailhrs',type:'number'},
            	{name:'idlehrs',type:'number'},
            	{name:'othrs',type:'number'},
            	{name:'idlehrsperc',type:'number'},
            	{name:'othrsperc',type:'number'},
            	
            ],
            url: utilurl,
            
            
            pager: function (pagenum, pagesize, oldpagenum) {
                // callback called when a page or page size is changed.
            }
        };
		
        var cellclassname = function (row, column, value, data) {
        	/*if(data.z1.includes("P")){
            	return "redClass";
            }*/
        };
        
        var dataAdapter = new $.jqx.dataAdapter(source,
        		 {
            		loadError: function (xhr, status, error) {
                    alert(error);    
                    }
	            }		
        );

        $("#techUtilGrid").jqxGrid(
                {
                	width: '100%',
                    height: 560,
                    source: dataAdapter,
                    showfilterrow: true,
                    filterable: true,
                    selectionmode: 'singlerow',
                  	editable:false,
                    altrows:true,
                    sortable:true,
                    columnsresize: true,
                    showaggregates:true,
                	showstatusbar:true,
                    //Add row method
                    columns: [
                    	{ text: 'Technician',datafield:'techname',width:'12%',pinned:true},
                    	{ text: '1',datafield: 'day1', width: '3%',align:'right',cellsalign:'right',cellsformat:'d2',aggregates:['sum'],aggregatesRenderer:rendererstring},
                    	{ text: '2',datafield: 'day2', width: '3%',align:'right',cellsalign:'right',cellsformat:'d2',aggregates:['sum'],aggregatesRenderer:rendererstring},
                    	{ text: '3',datafield: 'day3', width: '3%',align:'right',cellsalign:'right',cellsformat:'d2',aggregates:['sum'],aggregatesRenderer:rendererstring},
                    	{ text: '4',datafield: 'day4', width: '3%',align:'right',cellsalign:'right',cellsformat:'d2',aggregates:['sum'],aggregatesRenderer:rendererstring},
                    	{ text: '5',datafield: 'day5', width: '3%',align:'right',cellsalign:'right',cellsformat:'d2',aggregates:['sum'],aggregatesRenderer:rendererstring},
                    	{ text: '6',datafield: 'day6', width: '3%',align:'right',cellsalign:'right',cellsformat:'d2',aggregates:['sum'],aggregatesRenderer:rendererstring},
                    	{ text: '7',datafield: 'day7', width: '3%',align:'right',cellsalign:'right',cellsformat:'d2',aggregates:['sum'],aggregatesRenderer:rendererstring},
                    	{ text: '8',datafield: 'day8', width: '3%',align:'right',cellsalign:'right',cellsformat:'d2',aggregates:['sum'],aggregatesRenderer:rendererstring},
                    	{ text: '9',datafield: 'day9', width: '3%',align:'right',cellsalign:'right',cellsformat:'d2',aggregates:['sum'],aggregatesRenderer:rendererstring},
                    	{ text: '10',datafield: 'day10', width: '3%',align:'right',cellsalign:'right',cellsformat:'d2',aggregates:['sum'],aggregatesRenderer:rendererstring},
                    	{ text: '11',datafield: 'day11', width: '3%',align:'right',cellsalign:'right',cellsformat:'d2',aggregates:['sum'],aggregatesRenderer:rendererstring},
                    	{ text: '12',datafield: 'day12', width: '3%',align:'right',cellsalign:'right',cellsformat:'d2',aggregates:['sum'],aggregatesRenderer:rendererstring},
                    	{ text: '13',datafield: 'day13', width: '3%',align:'right',cellsalign:'right',cellsformat:'d2',aggregates:['sum'],aggregatesRenderer:rendererstring},
                    	{ text: '14',datafield: 'day14', width: '3%',align:'right',cellsalign:'right',cellsformat:'d2',aggregates:['sum'],aggregatesRenderer:rendererstring},
                    	{ text: '15',datafield: 'day15', width: '3%',align:'right',cellsalign:'right',cellsformat:'d2',aggregates:['sum'],aggregatesRenderer:rendererstring},
                    	{ text: '16',datafield: 'day16', width: '3%',align:'right',cellsalign:'right',cellsformat:'d2',aggregates:['sum'],aggregatesRenderer:rendererstring},
                    	{ text: '17',datafield: 'day17', width: '3%',align:'right',cellsalign:'right',cellsformat:'d2',aggregates:['sum'],aggregatesRenderer:rendererstring},
                    	{ text: '18',datafield: 'day18', width: '3%',align:'right',cellsalign:'right',cellsformat:'d2',aggregates:['sum'],aggregatesRenderer:rendererstring},
                    	{ text: '19',datafield: 'day19', width: '3%',align:'right',cellsalign:'right',cellsformat:'d2',aggregates:['sum'],aggregatesRenderer:rendererstring},
                    	{ text: '20',datafield: 'day20', width: '3%',align:'right',cellsalign:'right',cellsformat:'d2',aggregates:['sum'],aggregatesRenderer:rendererstring},
                    	{ text: '21',datafield: 'day21', width: '3%',align:'right',cellsalign:'right',cellsformat:'d2',aggregates:['sum'],aggregatesRenderer:rendererstring},
                    	{ text: '22',datafield: 'day22', width: '3%',align:'right',cellsalign:'right',cellsformat:'d2',aggregates:['sum'],aggregatesRenderer:rendererstring},
                    	{ text: '23',datafield: 'day23', width: '3%',align:'right',cellsalign:'right',cellsformat:'d2',aggregates:['sum'],aggregatesRenderer:rendererstring},
                    	{ text: '24',datafield: 'day24', width: '3%',align:'right',cellsalign:'right',cellsformat:'d2',aggregates:['sum'],aggregatesRenderer:rendererstring},
                    	{ text: '25',datafield: 'day25', width: '3%',align:'right',cellsalign:'right',cellsformat:'d2',aggregates:['sum'],aggregatesRenderer:rendererstring},
                    	{ text: '26',datafield: 'day26', width: '3%',align:'right',cellsalign:'right',cellsformat:'d2',aggregates:['sum'],aggregatesRenderer:rendererstring},
                    	{ text: '27',datafield: 'day27', width: '3%',align:'right',cellsalign:'right',cellsformat:'d2',aggregates:['sum'],aggregatesRenderer:rendererstring},
                    	{ text: '28',datafield: 'day28', width: '3%',align:'right',cellsalign:'right',cellsformat:'d2',aggregates:['sum'],aggregatesRenderer:rendererstring},
                    	{ text: '29',datafield: 'day29', width: '3%',align:'right',cellsalign:'right',cellsformat:'d2',aggregates:['sum'],aggregatesRenderer:rendererstring},
                    	{ text: '30',datafield: 'day30', width: '3%',align:'right',cellsalign:'right',cellsformat:'d2',aggregates:['sum'],aggregatesRenderer:rendererstring},
                    	{ text: '31',datafield: 'day31', width: '3%',align:'right',cellsalign:'right',cellsformat:'d2',aggregates:['sum'],aggregatesRenderer:rendererstring},
                    	{ text: 'Total',datafield:'totalclockin',width:'5%',align:'right',cellsalign:'right',cellsformat:'d2',aggregates:['sum'],aggregatesRenderer:rendererstring},
                    	//{ text: 'Est.Total Hrs',datafield:'esttotalhrs',width:'5%',align:'right',cellsalign:'right',cellsformat:'d2',aggregates:['sum'],aggregatesRenderer:rendererstring},
                    	{ text: 'Avail.Total Hrs',datafield:'totalavailhrs',width:'5%',align:'right',cellsalign:'right',cellsformat:'d2',aggregates:['sum'],aggregatesRenderer:rendererstring},
                    	{ text: 'Idle Hrs',datafield:'idlehrs',width:'5%',align:'right',cellsalign:'right',cellsformat:'d2',aggregates:['sum'],aggregatesRenderer:rendererstring},
                    	{ text: 'OT Hrs',datafield:'othrs',width:'5%',align:'right',cellsalign:'right',cellsformat:'d2',aggregates:['sum'],aggregatesRenderer:rendererstring},
                    	{ text: 'Idle Hrs %',datafield:'idlehrsperc',width:'5%',align:'right',cellsalign:'right',cellsformat:'d2',aggregates:['sum'],aggregatesRenderer:rendererstring},
                    	{ text: 'OT Hrs %',datafield:'othrsperc',width:'5%',align:'right',cellsalign:'right',cellsformat:'d2',aggregates:['sum'],aggregatesRenderer:rendererstring},
                    	
                    	
                    ]
                });
	});
	
</script>
<div id="techUtilGrid"></div>
