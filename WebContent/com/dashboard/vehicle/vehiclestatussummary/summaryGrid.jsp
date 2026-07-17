<%@page import="com.dashboard.vehicle.vehiclestatussummary.*" %>
<%ClsVehStatusSummaryDAO summarydao=new ClsVehStatusSummaryDAO();
String check=request.getParameter("check")==null?"":request.getParameter("check");
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
%>
 <%-- <jsp:include page="../../../../includes.jsp"></jsp:include> --%>
<style type="text/css">
        .redClass
        {
            background-color: #F56161;
        }
        
</style>

 <script type="text/javascript">

 		var check='<%=check%>';
 	   
 	   $(document).ready(function () {
 	    var data;
 	  /*  var rendererstring=function (aggregates){
       	var value=aggregates['sum'];
       	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + value + '</div>';
       } */
 	    if(check=='1'){
 	    	data = '<%=summarydao.getSummaryData(check,fromdate,todate)%>';
 	    }else{
 	     data = '[{"columns":[{"text":"Sr No.","datafield":"id","cellsAlign":"center","align":"center","width":"5%","cellclassname":""},{"text":"Ref No.","datafield":"refno","cellsAlign":"center","align":"center","width":"10%","hidden":"true","cellclassname":""},{"text":"Description","datafield":"description","cellsAlign":"left","align":"left","cellclassname":""},{"text":"Branch","datafield":"branch0","cellsAlign":"right","align":"right","width":"10%","cellsFormat":"d2","cellclassname":""}]},{"rows":[{"id":"1","refno":"","description":"","branch0":""}]}]';

 	    }        
 	    	var obj = $.parseJSON(data);
            var columns = obj[0].columns;
           // var columngroups = obj[1].columngroups; 
            var rows = obj[1].rows;
 			
            var source =
            {
                datatype: "json",
                datafields: [
                    	{name : 'id',type:'number'},
                    	{ name: 'refno',type:'number'},
                    	{ name: 'description',type:'string'},
                    	{ name: 'branch0',type:'number'},
                    	{ name: 'branch1',type:'number'},
                    	{ name: 'branch2',type:'number'},
                    	{ name: 'branch3',type:'number'},
                    	{ name: 'branch4',type:'number'},
                    	{ name: 'branch5',type:'number'},
                    	{ name: 'branch6',type:'number'},
                    	{ name: 'branch7',type:'number'},
                    	{ name: 'branch8',type:'number'},
                    	{ name: 'branch9',type:'number'},
                    	{ name: 'brcount',type:'number' },
                    	{ name: 'horizontotal',type:'number'}
                    	
                ],
                id: 'id',
                localdata: rows
            };
            /*   var rendererstring=function (aggregates){
            	var value=aggregates['sum'];
            	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + "" + '' + value + '</div>';
            }  */ 
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#summaryGrid").jqxGrid(
            {
                width: '99.5%',
                height: 300,
                source: dataAdapter,
                columnsresize: true,
                columns: columns,
                showstatusbar:true,
                showaggregates:true,
                selectionmode:'singlecell',
                //columngroups: columngroups
            });
            
			$("#overlay, #PleaseWait").hide();
           	
			$("#summaryGrid").on("celldoubleclick", function (event)
					{
					    // event arguments.
					    var args = event.args;
					    // row's bound index.
					    var rowBoundIndex = event.args.rowindex;
					    // row's visible index.
					    var rowVisibleIndex = event.args.visibleindex;
					    // right click.
					    var rightClick = event.args.rightclick; 
					    // original event.
					    var ev = event.args.originalEvent;
					    // column index.
					    var columnIndex = event.args.columnindex;
					    // column data field.
					    var dataField = event.args.datafield;
					    // cell value
					    var value = event.args.value;
					    
					    if(dataField=="branch0" || dataField=="branch1" || dataField=="branch2" || dataField=="branch3" || dataField=="branch4" || 
					    	dataField=="branch5" || dataField=="branch6" || dataField=="branch7" || dataField=="branch8" || dataField=="branch9"){
					    	
					    	var description=$('#summaryGrid').jqxGrid('getcellvalue',rowBoundIndex,'description');
					    	var branch=dataField;
					    	var fromdate=$('#fromdate').jqxDateTimeInput('val');
					    	var todate=$('#todate').jqxDateTimeInput('val');
					    	$("#overlay, #PleaseWait").show();
					    	$('#detailsdiv').load('detailsGrid.jsp?description='+description.replace(/ /g, '%20')+'&branch='+branch+'&fromdate='+fromdate+'&todate='+todate+'&id=1');
					    }
					}); 
        });
 		
</script>

<div id="summaryGrid"></div>
