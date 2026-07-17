<%@page import="com.dashboard.rentalagreement.ClsrentalagreementDAO" %>
<% ClsrentalagreementDAO crad=new ClsrentalagreementDAO();%>

       <script type="text/javascript">
  
       var groupdata='<%=crad.groupdetails()%>';
		$(document).ready(function () { 	
        	/* var url=""; */
        	
           
           
            var source =
            {
                datatype: "json",
                datafields: [
                            
                            {name : 'gname', type: 'string'  },
                            {name : 'doc_no', type: 'string'  }
     						
                        ],
                		
                		//  url: url1,
                 localdata: groupdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#groupsearch").jqxGrid(
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
							
							 
                          
                              { text: 'DOC_NO', datafield: 'doc_no', width: '20%',hidden:true},
                              { text: 'Group', datafield: 'gname', width: '100%' },
                           
						
						]
            });
            
          $('#groupsearch').on('rowdoubleclick', function (event) {
           
                var rowindex2 = event.args.rowindex;
                document.getElementById("group").value=$('#groupsearch').jqxGrid('getcellvalue', rowindex2, "gname");
                document.getElementById("groupdoc").value=$('#groupsearch').jqxGrid('getcellvalue', rowindex2, "doc_no");
           
              $('#groupwindow').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="groupsearch"></div>