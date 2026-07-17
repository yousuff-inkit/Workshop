<%@page import="com.operations.vehicleprocurement.purchase.ClsvehpurchaseDAO" %>
<%ClsvehpurchaseDAO cvp=new ClsvehpurchaseDAO(); %>
<%--   <jsp:include page="../../../../includes.jsp"></jsp:include>   --%>

<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>

<%
String headacccode = request.getParameter("headacccode")==null?"0":request.getParameter("headacccode").trim();
%>


<script type="text/javascript">

var vahReqmaster= '<%=cvp.orderSearchMasters(session,headacccode) %>'; 
            	
        $(document).ready(function () { 	
        
 
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                             

                               {name : 'voc_no', type: 'int'}, 
     						{name : 'doc_no', type: 'int'},
     						{name : 'date', type: 'date'  },
     						{name : 'type', type: 'string'   },
     						{name : 'expdeldt', type: 'date'   },
     						{name : 'desc1', type: 'string'  },
     						{name : 'nettotal', type: 'string'  }
     			
     						
     											
                 ],
                 localdata: vahReqmaster,
                
                
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

            
            
            $("#vehreqMastersearch").jqxGrid(
            {
                width: '100%',
                height: 350,
                source: dataAdapter,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlerow',
             
                
          
          

                       
                columns: [

                            { text: 'masterDoc NO', datafield: 'doc_no', width: '10%',hidden:true },	
							{ text: 'Doc NO', datafield: 'voc_no', width: '10%' },	
							{ text: 'Date', datafield: 'date', width: '15%' ,cellsformat:'dd.MM.yyyy'},
							{ text: 'Type', datafield: 'type', width: '10%' },
							{ text: 'nettotal', datafield: 'nettotal', width: '10%' ,hidden:true},
									
							{ text: 'Description', datafield: 'desc1', width: '65%' },	
							{ text: 'expdeldt', datafield:'expdeldt', width: '10%',cellsformat:'dd.MM.yyyy',hidden:true}
							
			              ]
               
            });
            
            $('#vehreqMastersearch').on('rowdoubleclick', function (event) {
            
                var rowindex2 = event.args.rowindex;
                //document.getElementById("nettotal").value=$('#vehreqMastersearch').jqxGrid('getcellvalue', rowindex2, "nettotal");
                var indexval3=$('#vehreqMastersearch').jqxGrid('getcellvalue', rowindex2, "voc_no");
            	 document.getElementById("vehrefno").value=indexval3; 
            	 
            	 document.getElementById("masterrefno").value=$('#vehreqMastersearch').jqxGrid('getcellvalue', rowindex2, "doc_no");
            	
               // $("#vehpuchase").load("vehpurchaseDetails.jsp?orderdoc="+indexval3);
              
                $("#vehoredergrid").jqxGrid({ disabled: false});
                
                $('#refnosearchwindow').jqxWindow('close'); 
            }); 
              	  
   
        });
    </script>
    <div id=vehreqMastersearch></div>
