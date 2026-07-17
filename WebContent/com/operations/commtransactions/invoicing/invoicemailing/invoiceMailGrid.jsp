<jsp:include page="../../../../../includes.jsp"></jsp:include>
<script type="text/javascript">
        
    <%-- var data= '<%=com.operations.marketing.enquiry.ClsEnquiryAction.searchDetails() %>'; --%>
        $(document).ready(function () { 	
             /* var url = "invoiceMailGrid.txt"; */
             var num = 0; 
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
     						{name : 'DOCNO', type: 'int' },
     						{name : 'DOCTYPE', type: 'string'   },
     						{name : 'REFTYPE', type: 'string'  },
     						{name : 'REFNO', type: 'int'   },
     						{name : 'DATE', type: 'string'  },
     						{ name: 'CLIENT', type: 'string' },
     						{name : 'AMOUNT', type: 'int' }
     					     						  											
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
			            
		            } );

            
            
            $("#jqxInvoiceMailing").jqxGrid(
            {
                width: '98%',
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
                    var cell = $('#jqxInvoiceMailing').jqxGrid('getselectedcell');
                    if (cell != undefined && cell.datafield == 'AMOUNT' && cell.rowindex == num - 1) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 13) {                                                        
                            var commit = $("#jqxInvoiceMailing").jqxGrid('addrow', null, {});
                            num++;                           
                        }
                    }
                },
                
                       
                columns: [
							{ text: 'Doc No.', datafield: 'DOCNO', width: '10%' },			
							{ text: 'Doc Type', datafield: 'DOCTYPE', width: '10%' },	
							{ text: 'Ref Type', datafield: 'REFTYPE', width: '15%' },	
							{ text: 'Ref No.', datafield: 'REFNO', width: '15%' },	
							{ text: 'Date', datafield: 'DATE', width: '15%' },	
							{ text: 'Client', datafield: 'CLIENT', width: '25%' },	
							{ text: 'Amount', datafield: 'AMOUNT', width: '10%' },
						 ]
            });
        });
    </script>
    <div id="jqxInvoiceMailing"></div>
 