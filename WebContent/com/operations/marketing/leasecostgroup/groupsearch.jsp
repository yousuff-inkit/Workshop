
<%@page import="com.operations.marketing.leasecostgroup.ClsleaseCostGroupDAO" %>
<%ClsleaseCostGroupDAO viewDAO= new ClsleaseCostGroupDAO(); %>


       <script type="text/javascript">
  
			 var groupdata= '<%=viewDAO.searchGroup() %>';
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
            
            $("#groupsearchgrid").jqxGrid(
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
            
          $('#groupsearchgrid').on('rowdoubleclick', function (event) {
      
                var rowindex2 = event.args.rowindex;
              //  groupid groupname
                 
        		var indexVal7 = $('#groupsearchgrid').jqxGrid('getcellvalue', rowindex2, "doc_no");
                var vehGroup=$('#groupsearchgrid').jqxGrid('getcellvalue', rowindex2, "gname");

                document.getElementById("groupname").value =vehGroup;
                document.getElementById("groupid").value =indexVal7;
                document.getElementById("errormsg").innerText="";
             //   $("#booktarifDivId").load('booktarifGrid.jsp?vehGroup='+vehGroup);
             
              $('#groupsearchwndows').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="groupsearchgrid"></div> 