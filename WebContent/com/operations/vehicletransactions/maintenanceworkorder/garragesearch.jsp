<%-- 
 <jsp:include page="../../../../includes.jsp"></jsp:include>  --%>
  
 <%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
  <%@ page import="com.operations.vehicletransactions.maintenanceupdate.ClsmaintenanceDAO" %>
<%ClsmaintenanceDAO cmwd=new ClsmaintenanceDAO(); %>
 <script type="text/javascript">

   var mtufleet='<%=cmwd.searchgarrage()%>';
  
        $(document).ready(function () { 	
            
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'number' },
     						{name : 'name', type: 'String'  }
     						
     						
     				                        	
                          	],
             
                          	localdata: mtufleet,
                
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
            $("#garragesearch").jqxGrid(
            {
                width: '99.9%',
                height: 382,
                source: dataAdapter,
            
                
                
                
                filterable: true,
                showfilterrow: true,
                selectionmode: 'singlerow',
                pagermode: 'default',
       
                //Add row method
	
                columns: [
					{ text: 'DOC NO', datafield: 'doc_no', width: '10%',hidden:true},
					
					{ text: 'NAME', datafield: 'name', width: '100%'  },
			
					
					]
            });
            
            $('#garragesearch').on('rowdoubleclick', function (event) 
            		{ 
            
            	  var rowBoundIndex = event.args.rowindex;
            
            	document.getElementById("garrageid").value= $('#garragesearch').jqxGrid('getcelltext', rowBoundIndex, "doc_no");
            	document.getElementById("garagemaster").value= $('#garragesearch').jqxGrid('getcelltext', rowBoundIndex, "name");
               
                $('#garragesearchwindow').jqxWindow('close');
              
            	
            		 }); 
      
        });
    </script>
    <div id="garragesearch"></div>