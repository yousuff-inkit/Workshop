 <%@page import="com.operations.agreement.rentalagreement.ClsRentalAgreementDAO" %>
 <%
 ClsRentalAgreementDAO viewDAO= new ClsRentalAgreementDAO();
 %>
 <script type="text/javascript">

 var datacha= '<%=viewDAO.chufferinfo()%>';
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
                 localdata: datacha,
          
				
                
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
            $("#jqxchuffersearch").jqxGrid(
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
    
           
      
            
           $('#jqxchuffersearch').on('rowdoubleclick', function (event) 
            		{ 
              
                var rowindex1=event.args.rowindex;
            
            	
                //document.getElementById("doctype").value= $('#jqxfleetsearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
               document.getElementById("ladriverlist").value=$('#jqxchuffersearch').jqxGrid('getcellvalue', rowindex1, "sal_name");
               document.getElementById("del_chaufferid").value=$('#jqxchuffersearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
               /* document.getElementById("del_chaufferid2").value=$('#jqxchuffersearch').jqxGrid('getcellvalue', rowindex1, "doc_no"); */
               
      
               /* if (document.getElementById('delivery_chk').checked) {
 	    		
            	   document.getElementById("del_Driver").value=$('#jqxchuffersearch').jqxGrid('getcellvalue', rowindex1, "sal_name"); 
       	}
       	else {
       		    		
       		
       		
       	} 
               if (document.getElementById('radrivercheck').checked) {
    	    		
            	   document.getElementById("del_Driver").value=$('#jqxchuffersearch').jqxGrid('getcellvalue', rowindex1, "sal_name"); 
       	}
       	else {
       		    		
       		
       		
       	} */        /* if(document.getElementById("fordrivervali").value!=2)
          	
 		       { 
			               $("table#tariffsub input").prop("disabled", false);
			               
			               document.getElementById("errormsg").innerText="";	
 		       } */      
               
                $('#chauffeurinfowindow').jqxWindow('close');   
            
            		 }); 
      
        });
    </script>
    <div id="jqxchuffersearch"></div>