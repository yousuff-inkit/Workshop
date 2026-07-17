<%@page import="com.operations.vehicleprocurement.vehiclepurchasedirect.ClspurchaseDirectDAO" %>
<%ClspurchaseDirectDAO cpd=new ClspurchaseDirectDAO(); %>
<%--  <jsp:include page="../../../../includes.jsp"></jsp:include>  --%>

<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%
String docnoss = request.getParameter("docnoss")==null?"NA":request.getParameter("docnoss");
String accountss = request.getParameter("accountss")==null?"NA":request.getParameter("accountss");
 String accnamess = request.getParameter("accnamess")==null?"NA":request.getParameter("accnamess");

 String datess = request.getParameter("datess")==null?"0":request.getParameter("datess");
 
 
 String aa = request.getParameter("aa")==null?"NA":request.getParameter("aa"); 
 %>
<script type="text/javascript">

var vahOrdermaster= '<%=cpd.searchmaster(session,docnoss,accountss,accnamess,datess,aa) %>'; 

        $(document).ready(function () { 	
        
 
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                             
                             
                             
				                {name : 'voc_no', voc_no: 'int'},
     						{name : 'doc_no', type: 'int'},
     						{name : 'date', type: 'date'  },
     						 
     						{name : 'account', type: 'string'   },
     						{name : 'description', type: 'string'   },
     						{name : 'headdoc', type: 'string'   },
     					 
     						{name : 'desc1', type: 'string'  },
     					 
     						{name : 'purdate', type: 'date'  },
     						{name : 'purno', type: 'string' },
     						 
     						
     						
     						
 
     					
     											
                 ],
                 localdata: vahOrdermaster,
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
			            
		            }		
            );

            
            
            $("#vehpurchase").jqxGrid(
            {
                width: '100%',
                height: 282,
                source: dataAdapter,
                
                selectionmode: 'singlerow',
             
                
          
          

                       
                columns: [

                           { text: 'masterDoc NO', datafield: 'doc_no', width: '7%',hidden:true },	
							{ text: 'Doc NO', datafield: 'voc_no', width: '7%' },	
							{ text: 'Date', datafield: 'date', width: '13%' ,cellsformat:'dd.MM.yyyy'},
						 
							{ text: 'Account', datafield: 'account', width: '10%' },
							{ text: 'Account Name', datafield: 'description', width: '30%' },
							{ text: 'Description', datafield: 'desc1', width: '40%' },	
						 
							{ text: 'headdoc', datafield: 'headdoc', width: '65%' ,hidden:true },
							 
							
							{ text: 'INV NO', datafield: 'purno', width: '5%' ,hidden:true },
							{ text: 'INV DATE', datafield: 'purdate', width: '5%' ,cellsformat:'dd.MM.yyyy',hidden:true}
			              ]
               
            });
            
            $('#vehpurchase').on('rowdoubleclick', function (event) {
            
                var rowindex2 = event.args.rowindex;
                 
     
         
    			$('#vehpurorderDate').jqxDateTimeInput({disabled: false});
    			$('#vehpurinvDate').jqxDateTimeInput({disabled: false});
                           	
           	
                   document.getElementById("docno").value=$('#vehpurchase').jqxGrid('getcellvalue', rowindex2, "voc_no");
                   
                   document.getElementById("masterdoc_no").value=$('#vehpurchase').jqxGrid('getcellvalue', rowindex2, "doc_no");
                   
                   
                   $('#vehpurorderDate').val ($('#vehpurchase').jqxGrid('getcellvalue', rowindex2, "date"));
              
                   $('#vehpurinvDate').val( $('#vehpurchase').jqxGrid('getcellvalue', rowindex2, "purdate")) ;
                   
           
                   
                   
                  
                   document.getElementById("accid").value =  $('#vehpurchase').jqxGrid('getcellvalue', rowindex2, "account");
                   document.getElementById("vehpuraccname").value =  $('#vehpurchase').jqxGrid('getcellvalue', rowindex2, "description");
                   document.getElementById("headacccode").value =  $('#vehpurchase').jqxGrid('getcellvalue', rowindex2, "headdoc");
                 
                   
                   
                   document.getElementById("invno").value =  $('#vehpurchase').jqxGrid('getcellvalue', rowindex2, "purno");
                  
                   
                  document.getElementById("vehdesc").value  = $('#vehpurchase').jqxGrid('getcellvalue', rowindex2, "desc1");
             
             
              $('#window').jqxWindow('close'); 
         	
        	 $('#vehpurorderDate').jqxDateTimeInput({ disabled: false});
        	 $('#vehpurinvDate').jqxDateTimeInput({disabled: false});
            	
        	
        	
        	 funSetlabel();
            document.getElementById("frmpurchasedir").submit();
            }); 
              	  
   
        });
    </script>
    <div id="vehpurchase"></div>
