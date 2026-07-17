 <%@page import="com.operations.agreement.rentalagreement.ClsRentalAgreementDAO" %>
 <%
 ClsRentalAgreementDAO viewDAO= new ClsRentalAgreementDAO();
 %>
 <script type="text/javascript">

 var datachass= '<%=viewDAO.chufferinfo()%>';
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
                 localdata: datachass,
          
				
                
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
            $("#deldrvsearch").jqxGrid(
            {
                width: '100%',
                height: 325,
                source: dataAdapter,
                columnsresize: true,
               // pageable: true,
                altRows: true,
               
                selectionmode: 'singlerow',
                pagermode: 'default',
              
	
     						
     					
     					
                columns: [
					{ text: 'ID', datafield: 'doc_no', width: '20%',hidden:true},
					{ text: 'NAME', datafield: 'sal_name', width: '100%' }
					
					
					
					]
            });
    
           
      
            
           $('#deldrvsearch').on('rowdoubleclick', function (event) 
            		{ 
              
                var rowindex1=event.args.rowindex;
            
            	
              
               document.getElementById("deldrvname").value=$('#deldrvsearch').jqxGrid('getcellvalue', rowindex1, "sal_name");
               document.getElementById("deldrvid").value=$('#deldrvsearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
     
               $('#deldrvwindow').jqxWindow('close');
               
            
            		 }); 
      
        });
    </script>
    <div id="deldrvsearch"></div>