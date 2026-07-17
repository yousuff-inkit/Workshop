<%@page import="com.operations.commtransactions.invoice.ClsManualInvoiceDAO1"%>
<%
	ClsManualInvoiceDAO1 invdao=new ClsManualInvoiceDAO1();
%>
 <script type="text/javascript">
 var acdata= '<%=invdao.accountSearch()%>';
        $(document).ready(function () { 	
        	/*  var url = "invoice.txt"; */
             var num = 1; 
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [                          	
     						{name : 'acno', type: 'string'  },
     						{name : 'description', type: 'string'    },
     						{name : 'idno',type:'number'}
     											
                 ],               
               localdata:acdata,
                
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

            
            
            $("#invAcSearch").jqxGrid(
            {
                width: '100%',
                height: 350,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
               // editable: true,
                altRows: true,
                /* showfilterrow: true, */
                /* filterable: true, */ 
                sortable: true,
                selectionmode: 'singlerow',
               // pagermode: 'default',
                
                //Add row method
                handlekeyboardnavigation: function (event) {
                    var cell = $('#invAcSearch').jqxGrid('getselectedcell');
                    if (cell != undefined && cell.datafield == 'description' && cell.rowindex == num - 1) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 13) {                                                        
                            var commit = $("#invAcSearch").jqxGrid('addrow', null, {});
                            num++;                           
                        }
                    }
                },
                
  
                
                columns: [
                           	{ text:'ID',datafield:'idno',width:'20%',hidden:true},	
							{ text: 'Ac No', datafield: 'acno', width: '20%' },
							{ text: 'Account', datafield: 'description', width: '80%' },
												
	              ]
            });
       $('#invAcSearch').on('rowdoubleclick', function (event) {
            	var row2=event.args.rowindex;
            	var row5=document.getElementById("invoicerow").value;
            	/* $("#jqxManualInvoice").jqxGrid('setcellvalue', row5, "account", " ");
                $("#jqxManualInvoice").jqxGrid('setcellvalue', row5, "description", " ");
                $("#jqxManualInvoice").jqxGrid('setcellvalue', row5, "idno", 0); */
            	var acno1=$('#invAcSearch').jqxGrid('getcellvalue', row2, "acno");
            	var desc1=$('#invAcSearch').jqxGrid('getcellvalue', row2, "description");
            	var idno1=$('#invAcSearch').jqxGrid('getcellvalue', row2, "idno");
                $("#jqxManualInvoice").jqxGrid('setcellvalue', row5, "account", acno1);
                $("#jqxManualInvoice").jqxGrid('setcellvalue', row5, "description", desc1);
                $("#jqxManualInvoice").jqxGrid('setcellvalue', row5, "idno", idno1);
                $("#jqxManualInvoice").jqxGrid('addrow', null, {});
                $('#accountwindow').jqxWindow('close');
            	
                });
            
        });
    </script>
    <div id="invAcSearch"></div>
 
