<%@ page import="com.dashboard.serviceandmaintenance.ClsServiceAndMaintenanceDAO" %>
<% ClsServiceAndMaintenanceDAO csmd=new ClsServiceAndMaintenanceDAO(); %>

 <%
 
String rdoc = request.getParameter("rdoc")==null?"0":request.getParameter("rdoc");
 %>
 <script type="text/javascript">
 


 
 var detailss='<%=csmd.maindateDetails(rdoc)%>'; 
         
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
                          	localdata: detailss,
                          	       
          
				
                
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
            $("#duedetailsgrid").jqxGrid(
            { 
            	
            	
            	width: '100%',
                height: 102,
                source: dataAdapter,
                
                selectionmode: 'singlerow',
                filtermode:'excel',
                filterable: true,
                sortable: true,
                editable:false,
                
     					
                columns: [
						
							{ text: 'Date', datafield: 'detdate', width: '10%',cellsformat:'dd.MM.yyyy'},
							
							 { text: 'User', datafield: 'user', width: '18%' },
				
							 { text: 'Follow Up Date', datafield: 'fdate', width: '10%',cellsformat:'dd.MM.yyyy'},	
							 
							 { text: 'Remarks', datafield: 'remk', width: '62%' },
							
					
					]
            });
         
        
           
        });
        
        
				       
                       
    </script>
    <div id="duedetailsgrid"></div>