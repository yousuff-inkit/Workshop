<%@page import="com.dashboard.vehiclepurchase.purchasereports.ClsPurchaseReportsDAO"%>

<script type="text/javascript">
<% ClsPurchaseReportsDAO prchdao= new ClsPurchaseReportsDAO(); %>
var	fleet= '<%=prchdao.fleetseachmove() %>';

$(document).ready(function() {
   

    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
                    
                    	{name : 'fleet_no', type: 'string'  },
						{name : 'flname', type: 'string'  },
						{name : 'reg_no', type: 'string'  },
						 
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

						{ text: 'Fleet', datafield: 'fleet_no', width: '20%' },
						{ text: 'Name', datafield: 'flname', width: '55%'},
						{ text: 'Reg NO', datafield: 'reg_no', width: '25%'},
						 
					]
    
    });
    $('#fleetsearchGrid').on('rowdoubleclick', function (event) 
    		{ 
    	
    		    var boundIndex = event.args.rowindex;
    		    document.getElementById("fleetno").value= $('#fleetsearchGrid').jqxGrid('getcellvalue',boundIndex, "fleet_no");
    		    $("#detailgeids").jqxGrid('clear');
    		      $("#detailgeids").jqxGrid('addrow', null, {});
    		      
    			   $("#fleeetgrid").jqxGrid('clear');
    		      $("#fleeetgrid").jqxGrid('addrow', null, {});
    		      
    		      $("#vehicleAssetGrid").jqxGrid('clear');
    		      $("#vehicleAssetGrid").jqxGrid('addrow', null, {});
			      
			      
    		    $("#fleetdiv").show();
    			  $("#enqlistdiv").hide(); 
    			  $("#detdivs").hide(); 
    	        $('#fleetwindow').jqxWindow('close');
    		});
    
});

	
	
</script>
<div id="fleetsearchGrid"></div>