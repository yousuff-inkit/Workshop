<%@page import="com.dashboard.leaseagreement.vehiclereturn.*" %>
<% ClsVehicleReturnDAO returndao=new ClsVehicleReturnDAO(); 
String id=request.getParameter("id")==null?"":request.getParameter("id");
%>
<script type="text/javascript">
var id='<%=id%>';
var placcountdata;
if(id=="1"){
	placcountdata='<%=returndao.getPLAccountData(id)%>'; 
}
$(document).ready(function () {
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [   
           
						{name : 'account',type:'string'},
						{name : 'acno', type: 'number'},
						{name : 'description', type: 'string'}

						],
				    localdata: placcountdata,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };

    $("#PLAccountGrid").on("bindingcomplete", function (event) {
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

    $("#PLAccountGrid").jqxGrid(
    {
        width: '99%',
        height: 315,
        source: dataAdapter,
        showaggregates:true,
        showfilterrow:true,
        filterable: true,
        selectionmode: 'singlerow',
        pagermode: 'default',
       sortable:true,
        columns: [  
                  	 
				     { text: 'Account',datafield: 'account', width: '20%'},
				     { text: 'Ac No',datafield: 'acno', width: '10%',hidden:true},
				     { text: 'Account Name',datafield: 'description', width: '80%'}
					]
   
    });

    $('#PLAccountGrid').on('rowdoubleclick', function (event){
    	var rowindex=event.args.rowindex;
    	document.getElementById("hidplacno").value=$('#PLAccountGrid').jqxGrid('getcellvalue',rowindex,'acno');
    	document.getElementById("placno").value=$('#PLAccountGrid').jqxGrid('getcellvalue',rowindex,'description');
    	$('#accountwindow').jqxWindow('close');
    }); 
});
    
</script>
<div id="PLAccountGrid"></div>
