  <%@page import="com.dashboard.marketing.leasequotationfollowup.leaseQuotationFollowupDAO"%>
     <%leaseQuotationFollowupDAO cmd= new leaseQuotationFollowupDAO(); %>

 <%
 
String srno = request.getParameter("srno")==null?"0":request.getParameter("srno");
 %>
 <script type="text/javascript">
 


 
 var leaseqotdetails='<%=cmd.qotDetails(srno)%>' ; 
         
        $(document).ready(function () { 
         
        	
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [

                             
                 			{name : 'detdate', type: 'date'  },
                 		
     						{name : 'user', type: 'String'},
     						
     						 {name : 'remk', type: 'String'},
     						{name : 'fdate' , type : 'date'}
     						
                          	],
                          	localdata: leaseqotdetails,
                          	       
          
				
                
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
            $("#leasefollowupgrid").jqxGrid(
            { 
            	
            	
            	width: '99%',
                height: 120,
                source: dataAdapter,
                
                selectionmode: 'singlerow',
                pagermode: 'default',
                editable:false,
                
     					
                columns: [
						
							{ text: 'Date', datafield: 'detdate', width: '10%',cellsformat:'dd.MM.yyyy'},
							
							 { text: 'User', datafield: 'user', width: '18%' },
				
							 { text: 'Follow-Up Date', datafield: 'fdate', width: '10%',cellsformat:'dd.MM.yyyy'},	
							 
							 { text: 'Remarks', datafield: 'remk', width: '62%' },
							
					
					]
            });
         
        
           
        });
        
        
				       
                       
    </script>
    <div id="leasefollowupgrid"></div>