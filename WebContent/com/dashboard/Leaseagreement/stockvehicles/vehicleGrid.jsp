<%@page import="com.dashboard.leaseagreement.stockvehicles.*"%>
<%ClsStockVehiclesDAO vehdao=new ClsStockVehiclesDAO();
String id=request.getParameter("id")==null?"":request.getParameter("id");
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
%>
<script type="text/javascript">
var vehicledata;
var vehicledataexcel;
var id='<%=id%>';
if(id=="1"){
	vehicledata='<%=vehdao.getVehicleData(id,branch)%>';
	vehicledataexcel='<%=vehdao.getVehicleDataExcel(id,branch)%>';
}
else{
	vehicledata=[];
}
$(document).ready(function () {
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [   
           
						{name : 'branchname',type:'string'},
						{name : 'fleet_no', type: 'number'},
						{name : 'reg_no',type:'string'},
						{name : 'flname', type: 'date'},
						{name : 'purcost',type:'number'},
						{name : 'purdate',type:'date'},
						{name : 'engine', type: 'String'},
						{name : 'chassis',type:'string'},
						

						],
				    localdata: vehicledata,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };

    $("#vehicleGrid").on("bindingcomplete", function (event) {
    	$("#overlay, #PleaseWait").hide();
//    	$('#rentalInvoiceGrid').jqxGrid({ sortable: true});
   });
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );

    $("#vehicleGrid").jqxGrid(
    {
        width: '98%',
        height: 500,
        source: dataAdapter,
        showaggregates:true,
        filtermode:'excel',
        filterable: true,
        selectionmode: 'singlerow',
        pagermode: 'default',
       sortable:true,
        columns: [  
					{ text: 'Sr. No.',datafield: '',columntype:'number', width: '5%', cellsrenderer: function (row, column, value) {
					    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
					}   },	
					{ text: 'Branch', datafield:'branchname', width: '14%'}, 
					{ text: 'Fleet No',datafield: 'fleet_no', width: '8%'},
					{ text: 'Reg No',datafield: 'reg_no', width: '8%'},  
					{ text: 'Fleet Name',datafield: 'flname', width: '19%'},
					{ text: 'Purchase Date',datafield: 'purdate', width: '8%',cellsformat:'dd.MM.yyyy'},
					{ text: 'Purchase Cost',datafield: 'purcost', width: '8%',cellsformat:'d2',cellsalign:'right',align:'right'},
					{ text: 'Engine No',datafield: 'engine', width: '15%'},
					{ text: 'Chassis No',datafield: 'chassis', width: '15%'}
					
					]
   
    });

    $('#vehicleGrid').on('rowdoubleclick', function (event){
    	var rowindex=event.args.rowindex;
    	$('#fleetno').val($('#vehicleGrid').jqxGrid('getcellvalue',rowindex,'fleet_no'));
    	
    }); 
});
 
</script>
<div id="vehicleGrid"></div>