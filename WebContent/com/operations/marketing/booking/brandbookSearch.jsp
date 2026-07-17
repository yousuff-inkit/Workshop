<%@page import="com.operations.marketing.booking.ClsbookingDAO" %>

<%
ClsbookingDAO viewDAO=new ClsbookingDAO();
%>

<script type="text/javascript">

			 var bookbarnddata= '<%=viewDAO.searchBrand() %>';
			 
			 
		$(document).ready(function () { 	
        	/* var url=""; */
        	
           
           
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'brand', type: 'string'  },
                            {name : 'brand_name', type: 'string'  },
                            {name : 'doc_no', type: 'string'  }
     						
                        ],
                		
                		//  url: url1,
                 localdata: bookbarnddata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#bookbrandsearch").jqxGrid(
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
							
							 
                          
                              { text: 'DOC NO', datafield: 'doc_no', width: '10%',hidden:true},
                              { text: 'BRAND', datafield: 'brand', width: '25%' },
                              { text: 'BRAND NAME', datafield: 'brand_name', width: '75%' }
						
						
	             
						]
            });
            
          $('#bookbrandsearch').on('rowdoubleclick', function (event) {
          
                var rowindex2 = event.args.rowindex;
                
                document.getElementById("bookbrand").value =$('#bookbrandsearch').jqxGrid('getcellvalue', rowindex2, "brand_name");
                document.getElementById("bookbrandid").value= $('#bookbrandsearch').jqxGrid('getcellvalue', rowindex2, "doc_no");
               
  		       
           
                
              $('#brandsearchwndows').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="bookbrandsearch"></div> 