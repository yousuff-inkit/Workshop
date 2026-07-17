<%@ page import="com.dashboard.rentalagreement.ClsrentalagreementDAO" %>
<%ClsrentalagreementDAO crad=new ClsrentalagreementDAO(); %>

       <script type="text/javascript">
  
			 var ranodata='<%=crad.ranodetails()%>';
		$(document).ready(function () { 	
        	/* var url=""; */
        	
           
           
            var source =
            {
                datatype: "json",
                datafields: [
                            
                           
                            {name : 'newtype', type: 'string'  },
                            {name : 'rvocno', type: 'string'  },
                            {name : 'rano', type: 'string'  },
                        ],
                		
                		//  url: url1,
                 localdata: ranodata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#ranosearch").jqxGrid(
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
							
							 
                          
                              { text: 'RA No.', datafield: 'rvocno', width: '30%'},
                              { text: 'Rent Type', datafield: 'newtype', width: '70%' },
                              { text: 'rano', datafield: 'rano', width: '10%' ,hidden:true },
                           
						
						]
            });
            
          $('#ranosearch').on('rowdoubleclick', function (event) {
           
                var rowindex2 = event.args.rowindex;
                document.getElementById("rano").value=$('#ranosearch').jqxGrid('getcellvalue', rowindex2, "rvocno");
                document.getElementById("hidrano").value=$('#ranosearch').jqxGrid('getcellvalue', rowindex2, "rano");
              $('#ranowindow').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="ranosearch"></div>