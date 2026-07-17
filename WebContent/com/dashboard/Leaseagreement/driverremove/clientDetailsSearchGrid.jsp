<%@page import="com.dashboard.leaseagreement.driverremove.ClsdriverRemoveDAO" %>
       <script type="text/javascript">
       <%
       
       ClsdriverRemoveDAO RemoveDAO=new ClsdriverRemoveDAO();
       %>
	    var data='<%=RemoveDAO.clientDetailsSearch()%>';
		$(document).ready(function () { 	
        	/* var url=""; */
        	
           
           
            var source =
            {
                datatype: "json",
                datafields: [
                            
                            {name : 'refname', type: 'string'  },
                            {name : 'cldocno', type: 'string'  }
     						
                        ],
                		
                		//  url: url1,
                 localdata: data,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#clientsearch").jqxGrid(
            {
                width: '100%',
                height: 357,
                source: dataAdapter,
                columnsresize: true,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlerow',
                       
                columns: [
                              { text: 'DOC NO', datafield: 'cldocno', width: '20%',hidden:true},
                              { text: 'Name', datafield: 'refname', width: '100%' },
						]
            });
            
          $('#clientsearch').on('rowdoubleclick', function (event) {
           
                var rowindex2 = event.args.rowindex;
                document.getElementById("txtclientname").value=$('#clientsearch').jqxGrid('getcellvalue', rowindex2, "refname");
                document.getElementById("txtcldocno").value=$('#clientsearch').jqxGrid('getcellvalue', rowindex2, "cldocno");
                
               $('#clientDetailsWindow').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="clientsearch"></div>