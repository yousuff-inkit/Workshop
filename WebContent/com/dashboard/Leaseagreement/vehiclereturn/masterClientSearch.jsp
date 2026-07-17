<%@page import="com.dashboard.leaseagreement.vehiclereturn.*" %>
<% ClsVehicleReturnDAO returndao=new ClsVehicleReturnDAO(); 
String id=request.getParameter("id")==null?"":request.getParameter("id");
%>
<script type="text/javascript">
var id='<%=id%>';
var clientdata;
if(id=="1"){
	clientdata='<%=returndao.getClientData(id)%>'; 
}
$(document).ready(function () {
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [   
           
						{name : 'cldocno', type: 'number'},
						{name : 'account',type:'string'},
						{name : 'acno', type: 'number'},
						{name : 'refname',type:'string'},
						{name : 'description', type: 'string'}

						],
				    localdata: clientdata,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };

    $("#clientGrid").on("bindingcomplete", function (event) {
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

    $("#clientGrid").jqxGrid(
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
                  	 { text: 'Client Id', datafield: 'cldocno', width: '12%',hidden:true},
				     { text: 'Client Name', datafield:'refname', width: '10%',hidden:true}, 
				     { text: 'Account',datafield: 'account', width: '20%'},
				     { text: 'Ac No',datafield: 'acno', width: '10%',hidden:true},
				     { text: 'Account Name',datafield: 'description', width: '80%'}
					]
   
    });

    $('#clientGrid').on('rowdoubleclick', function (event){
    	var rowindex=event.args.rowindex;
    	document.getElementById("hidclient").value=$('#clientGrid').jqxGrid('getcellvalue',rowindex,'cldocno');
    	document.getElementById("client").value=$('#clientGrid').jqxGrid('getcellvalue',rowindex,'description');
    	document.getElementById("clientacno").value=$('#clientGrid').jqxGrid('getcellvalue',rowindex,'acno');
    	$('#clientwindow').jqxWindow('close');
    }); 
});
    
</script>
<div id="clientGrid"></div>
