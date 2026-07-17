<%@page import="com.operations.vehicleprocurement.purchaserequest.ClsvehpurchasereqDAO" %>
<%ClsvehpurchasereqDAO vpd=new ClsvehpurchasereqDAO(); %>
       <script type="text/javascript">
  
			 var colorddata= '<%=vpd.searchColor() %>';
		$(document).ready(function () { 	
        	/* var url=""; */
        	
           
           
            var source =
            {
                datatype: "json",
                datafields: [
                            
                            {name : 'color1', type: 'string'  },
                            {name : 'doc_no', type: 'string'  }
     						
                        ],
                		
                		//  url: url1,
                 localdata: colorddata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#enqcolorSearch").jqxGrid(
            {
                width: '100%',
                height: 330,
                source: dataAdapter,
                columnsresize: true,
                altRows: true,
                showfilterrow: true, 
                filterable: true, 
             
                selectionmode: 'singlerow',
            
                
            
                       
                columns: [
							
							 
                          
                              { text: 'DOC NO', datafield: 'doc_no', width: '20%',hidden:true},
                              { text: 'COLOR', datafield: 'color1', width: '100%' },
                           
						
						
	             
						]
            });
            
          $('#enqcolorSearch').on('rowdoubleclick', function (event) {
            	var rowindex1 =$('#rowindex1').val();
            	// alert(rowindex1);
                var rowindex2 = event.args.rowindex;
                $('#purchasedetails').jqxGrid('setcellvalue', rowindex1, "color" ,$('#enqcolorSearch').jqxGrid('getcellvalue', rowindex2, "color1"));
                $('#purchasedetails').jqxGrid('setcellvalue', rowindex1, "clrid" ,$('#enqcolorSearch').jqxGrid('getcellvalue', rowindex2, "doc_no"));
                
                
              $('#colorsearchwndow').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="enqcolorSearch"></div>