  <%@ page import="com.operations.vehicletransactions.maintenanceupdate.ClsmaintenanceDAO" %>
<%ClsmaintenanceDAO cmwd=new ClsmaintenanceDAO(); %>

 
  <script type="text/javascript">

			<%
			String  valu=request.getParameter("valu")==null?"0":request.getParameter("valu");
			String  type=request.getParameter("mtypename")==null?"0":request.getParameter("mtypename");
			%>
		
 		var temps='<%=valu%>';
		var serdesc= '<%=cmwd.searchserdesc(type) %>';  
		$(document).ready(function () { 	

        	
      
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'name', type: 'string'  },
                           {name : 'doc_no', type: 'string'  }
     						
                        ],
                		
                		//  url: url1,
                 localdata: serdesc,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#serdescsearch").jqxGrid(
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
                              { text: 'Name', datafield: 'name', width: '100%' }
                             
						
						
	             
						]
            });
            
          $('#serdescsearch').on('rowdoubleclick', function (event) {
        	  
        	  if(temps=="serv")
        	  {
		            	var rowindex3 =$('#rowindex').val();
		                var rowindex2 = event.args.rowindex;
		                $('#maindowngrid').jqxGrid('setcellvalue', rowindex3, "description" ,$('#serdescsearch').jqxGrid('getcellvalue', rowindex2, "name"));
        	  }
             
        	  else if(temps=="apprv")
        		  {
        		  
        		  var rowindex3 =$('#rowindex1').val();
	                var rowindex2 = event.args.rowindex;
	                $('#approvel').jqxGrid('setcellvalue', rowindex3, "description" ,$('#serdescsearch').jqxGrid('getcellvalue', rowindex2, "name"));
        		  
        		  }
        	  
              $('#serdescsearchwndow').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="serdescsearch"></div> 