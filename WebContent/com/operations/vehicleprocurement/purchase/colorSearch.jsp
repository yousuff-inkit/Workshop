<%@page import="com.operations.vehicleprocurement.purchase.ClsvehpurchaseDAO" %>
<%ClsvehpurchaseDAO cvp=new ClsvehpurchaseDAO(); %>
       <script type="text/javascript">
  
			 var colorddata1= '<%=cvp.searchColor() %>';
		$(document).ready(function () { 	
        	/* var url=""; */
        	
           
           
            var source =
            {
                datatype: "json",
                datafields: [
                            
                            {name : 'color', type: 'string'  },
                            {name : 'doc_no', type: 'string'  }
     						
                        ],
                		
                		//  url: url1,
                 localdata: colorddata1,
                
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
                              { text: 'COLOR', datafield: 'color', width: '100%' },
                           
						
						
	             
						]
            });
            $('#enqcolorSearch').on('rowclick', function (event) 
            		{
            	var rowindex1 =$('#rowindex').val();
            	  $('#vehoredergrid').jqxGrid('setcellvalue', rowindex1, "color" ,"");
            		   
            	                                                                                  
            		});
          $('#enqcolorSearch').on('rowdoubleclick', function (event) {
            	var rowindex1 =$('#rowindex').val();
            	// alert(rowindex1);
                var rowindex2 = event.args.rowindex;
                $('#vehoredergrid').jqxGrid('setcellvalue', rowindex1, "color" ,$('#enqcolorSearch').jqxGrid('getcellvalue', rowindex2, "color"));
                $('#vehoredergrid').jqxGrid('setcellvalue', rowindex1, "clrid" ,$('#enqcolorSearch').jqxGrid('getcellvalue', rowindex2, "doc_no"));
                
                
              $('#colorsearchwndow').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="enqcolorSearch"></div>