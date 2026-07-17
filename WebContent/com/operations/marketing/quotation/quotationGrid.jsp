<jsp:include page="../../../../includes.jsp"></jsp:include>
<script type="text/javascript">
        $(document).ready(function () {
           /*  var url = "qotationtxt.txt"; */
        	 var num = 1; 
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'srno' , type: 'int' },
     						{name : 'brand', type: 'string'  },
     						{name : 'model', type: 'string'    },
     						{name : 'color', type: 'string'    },
     						{name : 'specification', type: 'string'    },
     						{name : 'unit', type: 'string'    },
     						{name : 'renttype', type: 'number'    },
     						{name : 'discount', type: 'number'    },
     						{name : 'frdate', type: 'string'    },
     						{name : 'todate', type: 'string'    },
     						{name : 'tarif', type: 'number'    },
     						{name : 'total', type: 'number'    }
     						
     						
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

            
            
            $("#jqxgridquote").jqxGrid(
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
                    var cell = $('#jqxgridquote').jqxGrid('getselectedcell');
                    if (cell != undefined && cell.datafield == 'description' && cell.rowindex == num - 1) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 13) {                                                        
                            var commit = $("#jqxgridquote").jqxGrid('addrow', null, {});
                            num++;                           
                        }
                    }
                },
                
                columns: [
							{ text: 'Sr No', datafield: 'srno', width: '3%' },
							{ text: 'Brand', datafield: 'brand', width: '8%' },
							{ text: 'Model', datafield: 'model', width: '11%' },
							{ text: 'Color', datafield: 'color', width: '5%' },
							{ text: 'Specification', datafield: 'specification', width: '16%' },
							{ text: 'Unit', datafield: 'unit', width: '5%' },
							{ text: 'Rent Type', datafield: 'renttype', width: '9%' },
							{ text: 'Discount', datafield: 'discount', width: '6%' },
							{ text: 'From Date', datafield: 'frdate', width: '9%' },
							{ text: 'To Date', datafield: 'todate', width: '9%' },
							{ text: 'Tariff', datafield: 'tarif', width: '8%' },
							{ text: 'Total', datafield: 'total', width: '11%' }
							
	              ]
            });
        });
    </script>
    <div id="jqxgridquote"></div>
 
