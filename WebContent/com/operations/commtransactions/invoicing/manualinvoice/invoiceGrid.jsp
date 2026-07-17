 <jsp:include page="../../../../../includes.jsp"></jsp:include>
 <script type="text/javascript">
        
        $(document).ready(function () { 	
        	/*  var url = "invoice.txt"; */
             var num = 68; 
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [                          	
     						{name : 'ACCOUNT', type: 'string'  },
     						{name : 'DESCRIPTION', type: 'string'    },
     						{name : 'RATE', type: 'string'    },
     						{name : 'TOTAL', type: 'string'    },
     						{name : 'ID', type: 'string'    }     						
                 ],               
               /*  url: url, */
                
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

            
            
            $("#jqxManualInvoice").jqxGrid(
            {
                width: '90%',
                height: 150,
                source: dataAdapter,
                columnsresize: true,
                pageable: true,
                editable: true,
                altRows: true,
                /* showfilterrow: true, */
                /* filterable: true, */ 
                sortable: true,
                selectionmode: 'singlerow',
                pagermode: 'default',
                
                //Add row method
                handlekeyboardnavigation: function (event) {
                    var cell = $('#jqxManualInvoice').jqxGrid('getselectedcell');
                    if (cell != undefined && cell.datafield == 'ID' && cell.rowindex == num - 1) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 13) {                                                        
                            var commit = $("#jqxManualInvoice").jqxGrid('addrow', null, {});
                            num++;                           
                        }
                    }
                },
                
                //Filter
                /* ready: function () {
                    addfilter();
                }, */
                
                
                columns: [
                            { text: 'Sr. No.', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: '', columntype: 'number', width: '5%' },							
							{ text: 'Account', datafield: 'ACCOUNT', width: '20%' },
							{ text: 'Description', datafield: 'DESCRIPTION', width: '40%' },
							{ text: 'Rate', datafield: 'RATE', width: '15%' },
							{ text: 'Total', datafield: 'TOTAL', width: '10%' },
							{ text: 'ID', datafield: 'ID', width: '10%' },							
	              ]
            });
        });
    </script>
    <div id="jqxManualInvoice"></div>
 
