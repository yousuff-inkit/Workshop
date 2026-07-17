<%@page import="com.dashboard.client.clientvehiclemovementlist.*"%>
<%
ClsClientVehicleMovementListDAO listdao=new ClsClientVehicleMovementListDAO();
%>
<script type="text/javascript">
var fleetdata='<%=listdao.getFleet()%>';
$(document).ready(function () {
   

    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
                    
                 	{name : 'fleet_no', type: 'String'  },
					{name : 'reg_no', type: 'String'  },
					{name : 'name', type: 'String'  }
						],
				    localdata: fleetdata,
        
        
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
    
    
    $("#fleetSearchGrid").jqxGrid(
    {
    	width: '99%',
        height: 300,
        source: dataAdapter,
       // rowsheight:20,
       // showaggregates:true,
       //filtermode:'excel',
       filterable: true,
       showfilterrow:true,
       columnsresize:true,
        selectionmode: 'singlerow',
        pagermode: 'default',
       
        columns: [
					{ text: 'Sr. No.',datafield: '',columntype:'number', width: '10%', cellsrenderer: function (row, column, value) {
					    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
					}   },	
					{ text: 'Fleet', datafield: 'fleet_no', width: '20%'},
					{ text: 'Reg No', datafield: 'reg_no', width: '20%' },
					{ text: 'Name', datafield: 'name', width: '50%'}

					]
    
    });
    $('#fleetSearchGrid').on('rowdoubleclick', function (event) 
    		{ 
    			$('#fleetno').val($('#fleetSearchGrid').jqxGrid('getcellvalue',event.args.rowindex,'fleet_no'));
    			$('#fleetwindow').jqxWindow('close');
    		});
});

</script>
<div id="fleetSearchGrid"></div>