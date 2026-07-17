<%@ page import="com.dashboard.rentalagreement.ClsrentalagreementDAO" %>
<%ClsrentalagreementDAO crad=new ClsrentalagreementDAO(); %>

       <script type="text/javascript">

        var saldata='<%=crad.getSalesmanData()%>';
		$(document).ready(function () { 	
        	/* var url=""; */
        	
           
           
            var source =
            {
                datatype: "json",
                datafields: [
                            
                            {name : 'sal_name', type: 'string'  },
                            {name : 'doc_no', type: 'string'  }
     						
                        ],
                		
                		//  url: url1,
                 localdata: saldata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#salsearch").jqxGrid(
            {
                width: '100%',
                height: 357,
                source: dataAdapter,
                columnsresize: true,
                altRows: true,
                showfilterrow: true, 
                filterable: true, 
             
                selectionmode: 'singlerow',
                  
                columns: [
		                      { text: 'DOC_NO', datafield: 'doc_no', width: '20%',hidden:true},
                              { text: 'Salesman Name', datafield: 'sal_name', width: '100%' },
                           
						
						]
            });
            
          $('#salsearch').on('rowdoubleclick', function (event) {
           
                var rowindex2 = event.args.rowindex;
                document.getElementById("salesman").value=$('#salsearch').jqxGrid('getcellvalue', rowindex2, "sal_name");
                document.getElementById("hidsalesman").value=$('#salsearch').jqxGrid('getcellvalue', rowindex2, "doc_no");
                
                
                
                
           
              $('#salesmanwindow').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="salsearch"></div>