<%@ page import="com.dashboard.vehicle.drivermovement.ClsDriverMovDAO" %>
<%   ClsDriverMovDAO cdmd=new ClsDriverMovDAO();  %>
<script type="text/javascript">

var	driver= '<%=cdmd.driversearchmove()%>';

$(document).ready(function () {
   

    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
                    
                    	{name : 'docno', type: 'string'  },
						{name : 'driver', type: 'string'  },
						{name: 'drvinfo',type: 'string'}
						],
				    localdata: driver,
        
        
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
    
    
    $("#driversearchGrid").jqxGrid(
    {
        width: '100%',
        height: 400,
        source: dataAdapter,
        filterable: true,
        showfilterrow: true,
        selectionmode: 'singlerow',
        pagermode: 'default',
       
        columns: [

						{ text: 'Doc No', datafield: 'docno', width: '20%' },
						{ text: 'Name', datafield: 'driver', width: '80%'},
						{ text: 'Drv Info', datafield: 'drvinfo', width: '25%',hidden:true}
					]
    
    });
    $('#driversearchGrid').on('rowdoubleclick', function (event) 
    		{ 
    		
    		    var boundIndex = event.args.rowindex;
    		    document.getElementById("driver").value= $('#driversearchGrid').jqxGrid('getcellvalue',boundIndex, "driver");
    		    document.getElementById("hiddriver").value= $('#driversearchGrid').jqxGrid('getcellvalue',boundIndex, "docno");
    		   // 
    		    var values= $('#driversearchGrid').jqxGrid('getcellvalue',boundIndex, "drvinfo");
    		
    		    var sum2 = values.toString().replace(/\*/g, '\n');
    		 
    		    document.getElementById("drvinfo").value=sum2;
    		    
    	        $('#driverwindow').jqxWindow('close');
    		});
    
});

	
	
</script>
<div id="driversearchGrid"></div>