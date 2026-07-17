<jsp:include page="../../../../includes.jsp"></jsp:include>
<script type="text/javascript">
       <%--  var data= '<%=com.operations.clientrelations.client.ClsClientAction.driver()%>'; --%>
        $(document).ready(function () { 	
        	/* var url = "delivery.txt"; */
             var num = 68; 
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [                          	
     						{name : 'FLEETNO', type: 'string'  },
     						{name : 'FLEETNAME', type: 'string'    },
     						{name : 'BROUT', type: 'string'    },
     						{name : 'DATEOUT', type: 'string'    },
     						{name : 'TOUT', type: 'string'    },
     						{name : 'KMOUT', type: 'string'    },
     						{name : 'FOUT', type: 'string'    },
     						{name : 'BRIN', type: 'string'    },
     						{name : 'DIN', type: 'string'    },
     						{name : 'TIN', type: 'string'    },
     						{name : 'FIN', type: 'string'    },   
     						{name : 'KMIN', type: 'string'    },
     						{name : 'STATUS', type: 'string'    },
     						{name : 'TRANCODE', type: 'string'    }				
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

            
            
            $("#jqxDelivery").jqxGrid(
            {
                width: '95%',
                height: 200,
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
                    var cell = $('#jqxDelivery').jqxGrid('getselectedcell');
                    if (cell != undefined && cell.datafield == 'TRANCODE' && cell.rowindex == num - 1) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 13) {                                                        
                            var commit = $("#jqxDelivery").jqxGrid('addrow', null, {});
                            num++;                           
                        }
                    }
                },
                
                //Filter
                /* ready: function () {
                    addfilter();
                }, */
                
                
                columns: [							
						{ text: 'Fleet No', datafield: 'FLEETNO', width: '15%' },			
						{ text: 'Fleet Name', datafield: 'FLEETNAME', width: '15%' },	
						{ text: 'Br Out', datafield: 'BROUT', width: '10%' },	
						{ text: 'Date Out', datafield: 'DATEOUT', width: '15%' },	
						{ text: 'T Out', datafield: 'TOUT', width: '15%' },	
						{ text: 'KM Out', datafield: 'KMOUT', width: '10%' },	
						{ text: 'F Out', datafield: 'FOUT', width: '10%' },
						{ text: 'Br In', datafield: 'BRIN', width: '10%' },
						{ text: 'D In', datafield: 'DIN', width: '15%' },
						{ text: 'T In', datafield: 'TIN', width: '10%' },
						{ text: 'F In', datafield: 'FIN', width: '10%' },
						{ text: 'KM In', datafield: 'KMIN', width: '10%' },
						{ text: 'Status', datafield: 'STATUS', width: '10%' },
						{ text: 'Tran Code', datafield: 'TRANCODE', width: '10%' },							
	              ]
            });
        });
    </script>
    <div id="jqxDelivery"></div>
    