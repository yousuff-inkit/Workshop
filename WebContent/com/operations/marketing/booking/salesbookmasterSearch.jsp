<%@page import="com.operations.marketing.booking.ClsbookingDAO" %>
 
  <%         
 
  ClsbookingDAO viewDAO=new ClsbookingDAO();
           	  %>  
 
 <script type="text/javascript">

 var datasal= '<%=viewDAO.salagentseach()%>';
   // alert(data);
        $(document).ready(function () { 	
            
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [
                            {name : 'doc_no', type: 'String'  },    
     						{name : 'sal_code', type: 'String'  },
     						{name : 'sal_name', type: 'String'  }
     						
     					
     					
                          	
                          	],
                 localdata: datasal,
          
				
                
                pager: function (pagenum, pagesize, oldpagenum) {
                   
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            $("#Salagentsearch").jqxGrid(
            {
                width: '100%',
                height: 325,
                source: dataAdapter,
                columnsresize: true,
               
                altRows: true,
               
                selectionmode: 'singlerow',
                pagermode: 'default',
                //sortable: true,
                //Add row method
	
     						
     					
     					
                columns: [
					{ text: 'ID', datafield: 'doc_no', width: '20%',hidden:true},
					{ text: 'NAME', datafield: 'sal_name', width: '100%' }
					
					
					
					]
            });
    
           
      
            
           $('#Salagentsearch').on('rowdoubleclick', function (event) 
            		{ 
              
                var rowindex1=event.args.rowindex;
            
            	
                //document.getElementById("doctype").value= $('#jqxfleetsearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
               document.getElementById("booksalesAgent").value=$('#Salagentsearch').jqxGrid('getcellvalue', rowindex1, "sal_name");
               document.getElementById("booksalesAgentid").value=$('#Salagentsearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
            
                $('#Salesagentinfowindow').jqxWindow('close');
               
            
            		 }); 
      
        });
    </script>
    <div id="Salagentsearch"></div>