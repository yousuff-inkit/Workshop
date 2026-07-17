<%@ page import="com.dashboard.rentalagreement.lponumber.ClsmranochangeDAO" %>
<%ClsmranochangeDAO crad=new ClsmranochangeDAO(); %>

       <script type="text/javascript">
			 var clientdata='<%=crad.salesmanchangedetails()%>';
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
                 localdata: clientdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#salesmansearch").jqxGrid(
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
							
							 
                          
                              { text: 'DOC NO', datafield: 'doc_no', width: '20%',hidden:false},
                              { text: ' Sal_Name', datafield: 'sal_name', width: '100%' },
                           
						
						
	             
						]
            });
            
          $('#salesmansearch').on('rowdoubleclick', function (event) {
           
                var rowindex2 = event.args.rowindex;
                document.getElementById("salesman").value=$('#salesmansearch').jqxGrid('getcellvalue', rowindex2, "sal_name");
                
  
                document.getElementById("salesmandoc").value=$('#salesmansearch').jqxGrid('getcellvalue', rowindex2, "doc_no");
                
              $('#salesmanwindow').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="salesmansearch"></div>