<%@ page import="com.dashboard.audit.userblock.ClsuserblockDAO" %>
<%ClsuserblockDAO clad=new ClsuserblockDAO(); %>
       <script type="text/javascript">
  
			 var userdata='<%=clad.userdetails()%>';
		$(document).ready(function () { 	
        	/* var url=""; */
        	
           
           
            var source =
            {
                datatype: "json",
                datafields: [
                            
                            {name : 'doc_no', type: 'string'  },
                            {name : 'user_name', type: 'string'  },
                            {name : 'role_id', type: 'string'  },
                        ],
                		
                		//  url: url1,
                 localdata: userdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#usersearch").jqxGrid(
            {
                width: '100%',
                height: 357,
                source: dataAdapter,
                columnsresize: true,
                altRows: true,
                showfilterrow: true, 
                filterable: true, 
             
                selectionmode: 'singlerow',
            
                
            
                       
                columns: [
							
							 
                          
                              { text: 'Doc No', datafield: 'doc_no', width: '20%'},
                              { text: 'User Name', datafield: 'user_name', width: '65%' },
                              { text: 'Role Id', datafield: 'role_id', width: '15%' },
                           
						
						]
            });
            
          $('#usersearch').on('rowdoubleclick', function (event) {
           
                var rowindex2 = event.args.rowindex;
                document.getElementById("user").value=$('#usersearch').jqxGrid('getcellvalue', rowindex2, "user_name");
                document.getElementById("docno").value=$('#usersearch').jqxGrid('getcellvalue', rowindex2, "doc_no");
           
              $('#userwindow').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="usersearch"></div>