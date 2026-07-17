     <%@page import="com.operations.vehicletransactions.maintenanceupdate.ClsmaintenanceDAO" %>
 
 
 <%
 ClsmaintenanceDAO viewDAO=new ClsmaintenanceDAO();  
 
 %>
       <script type="text/javascript">

       var sertype='<%=viewDAO.searchservicetype()%>';
       
			 
			 
		$(document).ready(function () { 	
        	/* var url=""; */
        	
           
           
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'mtype', type: 'string'  }
                         
     						
                        ],
                		
                		//  url: url1,
                 localdata: sertype,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#typesersearch").jqxGrid(
            {
                width: '100%',
                height: 358,
                source: dataAdapter,
                columnsresize: true,
                altRows: true,
                showfilterrow: true, 
                filterable: true, 
             
                selectionmode: 'singlerow',
            
                
            
                       
                columns: [
							
							 
                          
                              
                              { text: 'Type', datafield: 'mtype', width: '100%' }
                            
						
			
	             
						]
            });
            
          $('#typesersearch').on('rowdoubleclick', function (event) {
            	var rowindex1 =$('#rowindex').val();
            	
                var rowindex2 = event.args.rowindex;
                $('#maindowngrid').jqxGrid('setcellvalue', rowindex1, "type" ,$('#typesersearch').jqxGrid('getcellvalue', rowindex2, "mtype"));
          /*       $('#maindowngrid').jqxGrid('setcellvalue', rowindex1, "description" ,$('#typesersearch').jqxGrid('getcellvalue', rowindex2, "name"));; */
         
                document.getElementById("mtypename").value=$('#typesersearch').jqxGrid('getcellvalue', rowindex2, "mtype"); 
                var rows = $('#maindowngrid').jqxGrid('getrows');
                var rowlength= rows.length;
                if (rowindex1 == rowlength - 1) {
              
                $("#maindowngrid").jqxGrid('addrow', null, {});	
                
                }
                           
              $('#typeservsearchwndow').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="typesersearch"></div>