<%@page import="com.dashboard.leaseagreement.vehiclereturn.*" %>
<% ClsVehicleReturnDAO returndao=new ClsVehicleReturnDAO(); 
	String fleetno=request.getParameter("fleetno")==null?"":request.getParameter("fleetno");
	String type=request.getParameter("type")==null?"":request.getParameter("type");
	String id=request.getParameter("id")==null?"":request.getParameter("id");
	String agmtno=request.getParameter("agmtno")==null?"":request.getParameter("agmtno");
%>
<script type="text/javascript">
var id='<%=id%>';
var calculatedata;
if(id=="1"){
	calculatedata='<%=returndao.calculateData(fleetno,type,id,agmtno)%>';
}
$(document).ready(function () {
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [   
           
						{name : 'doc_no', type: 'number'},
						{name : 'voc_no',type:'string'},
						{name : 'acno',type:'string'},
						{name : 'description', type: 'string'},
						{name : 'amount',type:'number'},
						{name : 'fleetno',type:'string'}

						],
				    localdata: calculatedata,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };

    $("#vehReturnCalcGrid").on("bindingcomplete", function (event) {
    	$("#overlay, #PleaseWait").hide();
    	var rows=$('#vehReturnCalcGrid').jqxGrid('getrows');
    	var currentdepr=0.0;
    	for(var i=0;i<rows.length;i++){
    		if(i==3){
    			currentdepr=$('#vehReturnCalcGrid').jqxGrid('getcellvalue',i,'amount');
    			$('#curdepr').val(currentdepr);
    		}
    	}
    	
//    	$('#rentalInvoiceGrid').jqxGrid({ sortable: true});
   });
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );

    $("#vehReturnCalcGrid").jqxGrid(
    {
        width: '98%',
        height: 185,
        source: dataAdapter,
        showaggregates:true,
        showstatusbar:true,
        filtermode:'excel',
        filterable: true,
        selectionmode: 'singlerow',
        pagermode: 'default',
       sortable:true,
        columns: [  
                  	
					 { text: 'Sr. No.',datafield: '',columntype:'number', width: '5%', cellsrenderer: function (row, column, value) {
					    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
					 }   },
				     { text: 'Fleet',datafield:'fleetno',width:'10%'},
				     { text: 'Doc No',datafield: 'doc_no', width: '12%',hidden:true},
				     { text: 'Voc No',datafield: 'voc_no', width: '10%'},
				     { text: 'Ac No',datafield: 'acno', width: '10%'},
					 { text: 'Ac Name', datafield: 'description', width: '55%'},
					 { text: 'Amount',datafield: 'amount',width:'10%',align:'right',cellsalign:'right',aggregates: ['sum'],cellsformat:'d'}
					
					]
   
    });

    $('#vehReturnCalcGrid').on('rowdoubleclick', function (event){
    	var rowindex=event.args.rowindex;
    	
    }); 
});
                     
  
</script>
<div id="vehReturnCalcGrid"></div>