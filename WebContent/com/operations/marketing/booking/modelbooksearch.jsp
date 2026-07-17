<%@page import="com.operations.marketing.booking.ClsbookingDAO" %>
       <script type="text/javascript">

			

          <%
            ClsbookingDAO viewDAO=new ClsbookingDAO();
			String  brandval=request.getParameter("bookbrandid")==null?"0":request.getParameter("bookbrandid");
			%>
			
			 
			 var bookmodeldata= '<%=viewDAO.searchModel(brandval) %>'; 
		$(document).ready(function () { 	
        	/* var url=""; */
        	
          // alert(quotmodeldata);
           
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'vtype', type: 'string'  },
                           {name : 'doc_no', type: 'string'  }
     						
                        ],
                		
                		//  url: url1,
                 localdata: bookmodeldata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#quotmodelSearch").jqxGrid(
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
                              { text: 'MODEL', datafield: 'vtype', width: '100%' }
                             
						
						
	             
						]
            });
            
          $('#quotmodelSearch').on('rowdoubleclick', function (event) {
            
  
                var rowindex2 = event.args.rowindex;
              

                document.getElementById("bookmodel").value =$('#quotmodelSearch').jqxGrid('getcellvalue', rowindex2, "vtype");
                document.getElementById("bookmodelid").value= $('#quotmodelSearch').jqxGrid('getcellvalue', rowindex2, "doc_no");
           
                $('#modelsearchwndows').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="quotmodelSearch"></div>