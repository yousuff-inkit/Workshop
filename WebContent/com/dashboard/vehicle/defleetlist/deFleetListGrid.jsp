<%@page import="com.dashboard.vehicle.defleetlist.*" %>
<% ClsDeFleetListDAO defleetdao=new ClsDeFleetListDAO(); 
String id=request.getParameter("id")==null?"":request.getParameter("id");
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
%>
<script type="text/javascript">
var id='<%=id%>';
var defleetdata;
if(id=="1"){
	defleetdata='<%=defleetdao.getDeFleetData(id,fromdate,todate,branch)%>'; 
	defleetexceldata='<%=defleetdao.getDeFleetExcelData(id,fromdate,todate,branch)%>';
}
$(document).ready(function () {
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [   
           
						{name : 'defleetdate', type: 'date'},
						{name : 'fleet_no',type:'number'},
						{name : 'reg_no', type: 'number'},
						{name : 'flname',type:'string'},
						{name : 'purcost', type: 'number'},
						{name : 'residualval',type:'number'},
						{name : 'engineno',type:'string'},
						{name : 'chassisno',type:'string'},
						{name : 'vin',type:'string'},
						{name : 'salesprice',type:'number'},
						{name : 'contractkm',type:'number'},
						{name : 'actualkm',type:'number'},
						{name : 'refname',type:'number'}

						],
				    localdata: defleetdata,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };

    $("#deFleetListGrid").on("bindingcomplete", function (event) {
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

    $("#deFleetListGrid").jqxGrid(
    {
        width: '99%',
        height: 510,
        source: dataAdapter,
        showaggregates:true,
        filtermode:'excel',
        filterable: true,
        selectionmode: 'singlerow',
        pagermode: 'default',
        columnsresize:true,
       sortable:true,
        columns: [  
					 { text: 'Sr. No.',datafield: '',columntype:'number', width: '4%', cellsrenderer: function (row, column, value) {
					    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
					 }   },	
					 { text: 'Client',datafield:'refname',width:'15%'},
                  	 { text: 'Fleet No', datafield: 'fleet_no', width: '6%'},
				     { text: 'Reg No', datafield:'reg_no', width: '6%'},
				     { text: 'DeFleeted Date',datafield:'defleetdate',width:'8%',cellsformat:'dd.MM.yyyy'},
				     { text: 'Fleet Name',datafield:'flname',width:'17%'},
				     { text: 'Purchase Cost',datafield:'purcost',width:'7%',cellsformat:'d2',cellsalign:'right',align:'right'},
				     { text: 'Residual Value',datafield:'residualval',width:'7%',cellsformat:'d2',cellsalign:'right',align:'right'},
				     { text: 'Sales Price',datafield:'salesprice',width:'7%',cellsformat:'d2',cellsalign:'right',align:'right'},
				     { text: 'Engine No',datafield:'engineno',width:'13%'},
				     { text: 'Chassis No',datafield:'chassisno',width:'13%'},
				     { text: 'VIN No',datafield:'vin',width:'12%'},
				     { text: 'Contractual Mileage',datafield:'contractkm',width:'8%'},
				     { text: 'Actual Mileage',datafield:'actualkm',width:'8%'}
					]
   
    });

    $('#deFleetListGrid').on('rowdoubleclick', function (event){
    	var rowindex=event.args.rowindex;
    	$('#fleetno').val($('#deFleetListGrid').jqxGrid('getcellvalue',rowindex,'fleet_no'));
    }); 
});
    
</script>
<div id="deFleetListGrid"></div>
