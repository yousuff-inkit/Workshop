<script type="text/javascript">
    
       <%--  var data= '<%=com.operations.agreement.rentalagreement.ClsRentalAgreementAction.driverGrid()%>'; --%>
        
        $(document).ready(function () { 	
        	/* var url = "maintenance.txt"; */
             var num = 68; 
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [                          	
     						{name : 'MAINTENANCE', type: 'string'  },
     						{name : 'RTYPE', type: 'string' }
                 ],               
                /* localdata: data, */
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

            
            
            $("#jqxMaintenance").jqxGrid(
            {
                width: '100%',
                height: 200,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
                editable: true,
                altRows: true,
                /* showfilterrow: true, */
                /* filterable: true, */ 
                sortable: true,
                selectionmode: 'singlerow',
                
                
                //Add row method
                handlekeyboardnavigation: function (event) {
                    var cell = $('#jqxMaintenance').jqxGrid('getselectedcell');
                    if (cell != undefined && cell.datafield == 'RTYPE' && cell.rowindex == num - 1) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 13) {                                                        
                            var commit = $("#jqxMaintenance").jqxGrid('addrow', null, {});
                            num++;                           
                        }
                    }
                },
                
                //Filter
                /* ready: function () {
                    addfilter();
                }, */
                
                
                columns: [
                            { text: 'Sl#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,datafield: '', 
                              columntype: 'number', width: '10%',cellsalign: 'center', align: 'center' },							
							{ text: 'Maintenance Details', datafield: 'MAINTENANCE', width: '60%' },
							{ text: 'Type', datafield: 'RTYPE', width: '30%' },
	              ]
            });
        });
    </script>
    <div id="jqxMaintenance"></div>
 
