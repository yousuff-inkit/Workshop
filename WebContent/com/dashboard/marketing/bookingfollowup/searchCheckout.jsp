  <%@page import="com.operations.agreement.rentalagreement.ClsRentalAgreementDAO"%>
     <%ClsRentalAgreementDAO crad= new ClsRentalAgreementDAO(); %>
  <%--  <jsp:include page="../../../../includes.jsp"></jsp:include>   --%>
 <script type="text/javascript">

 var data11= '<%=crad.checkoutSearch()%>';
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
                 localdata: data11,
          
				
                
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
            $("#jqxcheckoutsearch").jqxGrid(
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
    
           
      
            
           $('#jqxcheckoutsearch').on('rowdoubleclick', function (event) 
            		{ 
              
                var rowindex1=event.args.rowindex;
            
            	
                //document.getElementById("doctype").value= $('#jqxfleetsearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
               document.getElementById("ratariff_checkout").value=$('#jqxcheckoutsearch').jqxGrid('getcellvalue', rowindex1, "sal_name");
               document.getElementById("ratariff_checkoutid").value=$('#jqxcheckoutsearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
               
       	
                $('#Checkoutinfowindow').jqxWindow('close');
               
            
            		 }); 
      
        });
    </script>
    <div id="jqxcheckoutsearch"></div>