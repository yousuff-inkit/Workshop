<%@page import="com.operations.marketing.booking.ClsbookingDAO" %>

<%
ClsbookingDAO viewDAO=new ClsbookingDAO();
			String  barnds=request.getParameter("brand")==null?"0":request.getParameter("brand");

	String  models=request.getParameter("model")==null?"0":request.getParameter("model");

	
			%>
			


       <script type="text/javascript">
  
			 var groupdata= '<%=viewDAO.searchGroup(barnds,models) %>';
		$(document).ready(function () { 	
        	/* var url=""; */
        	
           
           
            var source =
            {
                datatype: "json",
                datafields: [
                            
                            {name : 'gname', type: 'string'  },
                            {name : 'doc_no', type: 'string'  }
     						
                        ],
                		
                 localdata: groupdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#quotgroupSearch1").jqxGrid(
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
                              { text: 'GROUP', datafield: 'gname', width: '100%' }
                           
						
						
	             
						]
            });
            
          $('#quotgroupSearch1').on('rowdoubleclick', function (event) {
      
                var rowindex2 = event.args.rowindex;
              
                 
        		var indexVal7 = $('#quotgroupSearch1').jqxGrid('getcellvalue', rowindex2, "doc_no");
                var vehGroup=$('#quotgroupSearch1').jqxGrid('getcellvalue', rowindex2, "gname");

                document.getElementById("bookgroup").value =vehGroup;
                document.getElementById("bookgroupid").value =indexVal7;
         
             //   $("#booktarifDivId").load('booktarifGrid.jsp?vehGroup='+vehGroup);
             
              $('#groupsearchwndows').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="quotgroupSearch1"></div> 