<%@page import="com.operations.commtransactions.invoice.ClsManualInvoiceDAO1"%>
<%
	ClsManualInvoiceDAO1 invdao=new ClsManualInvoiceDAO1();
%>
 <script type="text/javascript">
 var maindata= '<%=invdao.invoiceSearch()%>';
        $(document).ready(function () { 	
        	/*  var url = "invoice.txt"; */
             var num = 1; 
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [                          	
     						{name : 'doc_no', type: 'int'  },
     						{name : 'rano', type: 'int'    },
     						{name : 'date',type:'date'},
     						{name :'agmttype',type:'string'},
     						{name :'refname',type:'string'}
     						
     											
                 ],               
               localdata:maindata,
                
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

            
            
            $("#invoiceSearch").jqxGrid(
            {
                width: '100%',
                height: 280,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
               // editable: true,
                altRows: true,
                 showfilterrow: true, 
                 filterable: true,  
                sortable: true,
                selectionmode: 'singlerow',
               // pagermode: 'default',
                
                //Add row method
                handlekeyboardnavigation: function (event) {
                    var cell = $('#invoiceSearch').jqxGrid('getselectedcell');
                    if (cell != undefined && cell.datafield == 'date' && cell.rowindex == num - 1) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 13) {                                                        
                            var commit = $("#invoiceSearch").jqxGrid('addrow', null, {});
                            num++;                           
                        }
                    }
                },
                
  
                
                columns: [
                           	{ text:'Doc No',filtertype:'number',datafield:'doc_no',width:'10%'},	
							{ text: 'RA No',filtertype:'number', datafield: 'rano', width: '10%' },
							{ text: 'Date', columntype: 'textbox', filtertype: 'input', datafield: 'date', width: '20%',cellsformat:'dd.MM.yyyy' },
							{text:'Client', columntype: 'textbox', filtertype: 'input',datafield:'refname',width:'40%'},
							{text:'Agreement Type', columntype: 'textbox', filtertype: 'input',datafield:'agmttype',width:'20%'}
							
												
	              ]
            });
       $('#invoiceSearch').on('rowdoubleclick', function (event) {
            	var row2=event.args.rowindex;
            	document.getElementById("docno").value=$('#invoiceSearch').jqxGrid('getcellvalue', row2, "doc_no");
            	 $('#date').jqxDateTimeInput({ disabled: false});
            	$("#date").jqxDateTimeInput('val', $("#invoiceSearch").jqxGrid('getcellvalue', row2, "date")); 
            	document.getElementById("agmtno").value=$('#invoiceSearch').jqxGrid('getcellvalue', row2, "rano");
            	 $('#cmbagmttype').val($("#invoiceSearch").jqxGrid('getcellvalue', row2, "agmttype")) ;
            	$('#frmManualInvoice select').attr('disabled', false);
        		$("#fromdate").jqxDateTimeInput({ disabled: false});
                $("#todate").jqxDateTimeInput({ disabled: false}); 
            	document.getElementById("frmManualInvoice").submit();
                $('#window').jqxWindow('close');

                });
            
        });
    </script>
    <div id="invoiceSearch"></div>
 
