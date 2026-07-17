<%@ page import="com.dashboard.invoices.damageinvoicelist.ClsDamageInvoiceListDAO"  %>

<% ClsDamageInvoiceListDAO cdl=new ClsDamageInvoiceListDAO();
 %>
<script type="text/javascript">

var	fleet= '<%=cdl.fleetseachmove()%>';

$(document).ready(function () {
   

    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
                    
                    	{name : 'fleet_no', type: 'string'  },
						{name : 'flname', type: 'string'  },
						{name : 'reg_no', type: 'string'  },
						{name: 'vehinfo',type: 'string'},
						{name: 'code_name',type: 'string'}
						],
				    localdata: fleet,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
  
    
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
    $("#fleetsearchGrid").jqxGrid(
    {
        width: '100%',
        height: 400,
        source: dataAdapter,
        filterable: true,
        showfilterrow: true,
        selectionmode: 'singlerow',
        pagermode: 'default',
       
        columns: [

						 { text: 'Fleet', datafield: 'fleet_no', width: '17%' },
						{ text: 'Name', datafield: 'flname', width: '50%'},
						{ text: 'Reg NO', datafield: 'reg_no', width: '17%'},
						
						 {text: 'Plate Code', datafield: 'code_name', width: '16%' },
						{ text: 'vehinfo', datafield: 'vehinfo', width: '25%',hidden:true},
					]
    
    });
    $('#fleetsearchGrid').on('rowdoubleclick', function (event) 
    		{ 
    	
    		    var boundIndex = event.args.rowindex;
    		    document.getElementById("fleetno").value= $('#fleetsearchGrid').jqxGrid('getcellvalue',boundIndex, "fleet_no");
    		  
    	        $('#fleetwindow').jqxWindow('close');
    		});
    
});

	
	
</script>
<div id="fleetsearchGrid"></div>