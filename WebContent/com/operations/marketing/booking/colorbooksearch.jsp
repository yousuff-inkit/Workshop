<%@page import="com.operations.marketing.booking.ClsbookingDAO" %>

<%
ClsbookingDAO viewDAO=new ClsbookingDAO();
%>
       <script type="text/javascript">
  
			 var colorddata1= '<%=viewDAO.searchColor() %>';
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
            
            $("#quotcolorSearch1").jqxGrid(
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
            
          $('#quotcolorSearch1').on('rowdoubleclick', function (event) {
            
            
                var rowindex2 = event.args.rowindex;
                document.getElementById("bookcolor").value =$('#quotcolorSearch1').jqxGrid('getcellvalue', rowindex2, "color");
                document.getElementById("bookcolorid").value =$('#quotcolorSearch1').jqxGrid('getcellvalue', rowindex2, "doc_no");
              
                
              $('#colorsearchwndows').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="quotcolorSearch1"></div> 