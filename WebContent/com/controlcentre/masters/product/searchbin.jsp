

<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 
<%@page import="com.controlcentre.masters.product.ClsProductDAO"%>

<% String contextPath=request.getContextPath();%>
<%ClsProductDAO DAO= new ClsProductDAO(); %> 
 
 
 
<script type="text/javascript">



            	
        $(document).ready(function () { 	
        	var Reqmaster='<%=DAO.searchbin() %>'; 
    
 
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                                
                             {name : 'name', type: 'string'},  
     		 				 
     				 
     						{name : 'doc_no', type: 'int'   },
     						 
                 ],
                 localdata: Reqmaster,
                
                
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

            
            
            $("#binsearchgrid").jqxGrid(
            {
                width: '100%',
                height: 300,
                source: dataAdapter,
                editable: false,
                selectionmode: 'singlecell',
                pagermode: 'default',
             
                
          
          

                       
                columns: [      
                           
                            
                          
                            { text: 'Bin', datafield: 'name', width: '100%'   },	
						 	
							{ text: 'doc_no', datafield: 'doc_no', width: '10%' , hidden: true},
 
											
							
							
			              ]
               
            });
            
            
            
        
            $("#binsearchgrid").on('celldoubleclick', function (event) 
            		{
            		
           	 var rowindextemp = event.args.rowindex;
         	 var rowno =  document.getElementById("rowindex").value;
         	 
         	 
         	 
 
                 $('#jqxProductGrid').jqxGrid('setcellvalue', rowno, "binname" ,$('#binsearchgrid').jqxGrid('getcellvalue', rowindextemp, "name"));
	                $('#jqxProductGrid').jqxGrid('setcellvalue', rowno, "bin" ,$('#binsearchgrid').jqxGrid('getcellvalue', rowindextemp, "doc_no"));
            	
            	             $('#binWindow').jqxWindow('close'); 
            	
            	 
            		    
            		});  
            
            
            
            
            
      
   
        });
    </script>
    <div id=binsearchgrid></div>
 