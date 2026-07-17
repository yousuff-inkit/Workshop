<%@page import="com.operations.marketing.booking.ClsbookingDAO" %>
 
  <%         
 
  ClsbookingDAO viewDAO=new ClsbookingDAO();
           	  %>  
 
       <script type="text/javascript">
  
			 var booktarifdata= '<%=viewDAO.grouptariffType() %>';
		$(document).ready(function () { 	
        	/* var url=""; */
        	
           
           
            var source =
            {
                datatype: "json",
                datafields: [
                            
                            {name : 'rentaltype', type: 'string' }
                           
     						
                        ],
                		
                 localdata: booktarifdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#bookratiff").jqxGrid(
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
							
							 
                          
                        
                              { text: 'Rental Type', datafield: 'rentaltype', width: '100%' }
                           
						
						
	             
						]
            });
            
          $('#bookratiff').on('rowdoubleclick', function (event) {
      
                var rowindex2 = event.args.rowindex;

                var rentaltype=$('#bookratiff').jqxGrid('getcellvalue', rowindex2, "rentaltype");

             var vehGroup=document.getElementById("bookgroupid").value ;
                document.getElementById("renttype").value =rentaltype;
         
                $("#booktarifDivId").load('booktarifGrid.jsp?vehGroup='+vehGroup+'&rentaltype='+rentaltype);
             
              $('#rentalsearchwndows').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="bookratiff"></div> 