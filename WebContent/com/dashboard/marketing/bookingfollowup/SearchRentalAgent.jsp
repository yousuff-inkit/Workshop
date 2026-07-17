  <%@page import="com.operations.agreement.rentalagreement.ClsRentalAgreementDAO"%>
     <%ClsRentalAgreementDAO crad= new ClsRentalAgreementDAO(); %>
  <%--  <jsp:include page="../../../../includes.jsp"></jsp:include>   --%>
 <script type="text/javascript">

 var datara= '<%=crad.RentalgentSearch()%>';
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
                 localdata: datara,
          
				
                
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
            $("#jqxrentagentsearch").jqxGrid(
            {
                width: '100%',
                height: 325,
                source: dataAdapter,
                columnsresize: true,
              
                altRows: true,
               
                selectionmode: 'singlerow',
                pagermode: 'default',
               // sortable: true,
                //Add row method
	
     						
     					
     					
                columns: [
					{ text: 'ID', datafield: 'doc_no', width: '20%',hidden:true },
					{ text: 'NAME', datafield: 'sal_name', width: '100%' }
					
					
					
					]
            });
    
           
      
            
           $('#jqxrentagentsearch').on('rowdoubleclick', function (event) 
            		{ 
              
                var rowindex1=event.args.rowindex;
            
            	
                //document.getElementById("doctype").value= $('#jqxfleetsearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
               document.getElementById("rarenral_Agent").value=$('#jqxrentagentsearch').jqxGrid('getcellvalue', rowindex1, "sal_name");
               document.getElementById("tariffrenral_Agentid").value=$('#jqxrentagentsearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
        
              
                $('#Rentalagentinfowindow').jqxWindow('close');
               
            
            		 }); 
      
        });
    </script>
    <div id="jqxrentagentsearch"></div>