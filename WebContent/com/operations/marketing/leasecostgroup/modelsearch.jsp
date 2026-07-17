<%@page import="com.operations.marketing.leasecostgroup.ClsleaseCostGroupDAO" %>
<%ClsleaseCostGroupDAO viewDAO= new ClsleaseCostGroupDAO(); %>
       <script type="text/javascript">

			<%
			String  brandval=request.getParameter("brandid")==null?"0":request.getParameter("brandid");
			%>
			
			 
			 var modeldata= '<%=viewDAO.searchModel(brandval) %>'; 
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
                 localdata: modeldata,
                
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
              

                document.getElementById("modelname").value =$('#quotmodelSearch').jqxGrid('getcellvalue', rowindex2, "vtype");
                document.getElementById("modelid").value= $('#quotmodelSearch').jqxGrid('getcellvalue', rowindex2, "doc_no");
                document.getElementById("errormsg").innerText="";
                $('#modelsearchwndows').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="quotmodelSearch"></div>