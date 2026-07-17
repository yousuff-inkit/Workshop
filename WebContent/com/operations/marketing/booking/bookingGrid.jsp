<script type="text/javascript">
        $(document).ready(function () {
            /* var url = "bookingtxt.txt"; */
            
            
             var num = 1; 
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'no' , type: 'int' },
     						{name : 'assetid', type: 'int'  },
     						{name : 'description', type: 'string'    },
     						{name : 'rate', type: 'number'    }
     						
     						
                 ],
                /* url: url, */
                
                
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

            
            
            $("#jqxBookingGrid").jqxGrid(
            {
                width: '100%',
                height: 150,
                source: dataAdapter,
                columnsresize: true,
                pageable: true,
                editable: true,
                sortable: true,
                selectionmode: 'singlerow',
                pagermode: 'default',
               
                
                //Add row method
                handlekeyboardnavigation: function (event) {
                    var cell = $('#jqxBookingGrid').jqxGrid('getselectedcell');
                    if (cell != undefined && cell.datafield == 'description' && cell.rowindex == num - 1) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 13) {                                                        
                            var commit = $("#jqxBookingGrid").jqxGrid('addrow', null, {});
                            num++;                           
                        }
                    }
                },
                
                columns: [
							{ text: 'No', datafield: 'no', width: '6%' },
							{ text: 'Asset ID', datafield: 'assetid', width: '12%', },
							{ text: 'Description', datafield: 'description', width: '65%' },
							{ text: 'Rate', datafield: 'rate', width: '19%' }
													
	              ]
            });
        });
    </script>
    <div id="jqxBookingGrid"></div>
 
