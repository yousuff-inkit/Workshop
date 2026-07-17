<%@page import="com.dashboard.trafficfine.ClsTrafficfineDAO" %>
<%ClsTrafficfineDAO ctd=new ClsTrafficfineDAO(); %>


       <%
     
       String values = request.getParameter("values")==null?"NA":request.getParameter("values");
       
       %>

       <script type="text/javascript">

        var sss='<%=ctd.searchdretails(values)%>';
		$(document).ready(function () { 	
        	/* var url=""; */
        	
           
           
            var source =
            {
                datatype: "json",
                datafields: [  //doc_no sal_name
                            
                            {name : 'sal_name', type: 'string'  },
                            {name : 'doc_no', type: 'string'  }
     						
                        ],
                		
                		//  url: url1,
                 localdata: sss,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#drsearch").jqxGrid(
            {
                width: '100%',
                height: 357,
                source: dataAdapter,
                columnsresize: true,
                altRows: true,
                showfilterrow: true, 
                filterable: true, 
             
                selectionmode: 'singlerow',
                  
                columns: [
		                      { text: 'DOC_NO', datafield: 'doc_no', width: '20%',hidden:true},
                              { text: 'Name', datafield: 'sal_name', width: '100%' },
                           
						
						]
            });
            
          $('#drsearch').on('rowdoubleclick', function (event) {
           
                var rowindex2 = event.args.rowindex;   
               
   
               if(document.getElementById("trftype").value=="DRV")
            	   {
            	   
            	   document.getElementById("typesearch").value=$('#drsearch').jqxGrid('getcellvalue', rowindex2, "sal_name"); 
            	   document.getElementById("drdoc").value=$('#drsearch').jqxGrid('getcellvalue', rowindex2, "doc_no");
            	   }
               else if(document.getElementById("trftype").value=="STF")
        	   {
        	   
            	   document.getElementById("typesearch").value=$('#drsearch').jqxGrid('getcellvalue', rowindex2, "sal_name"); 
        	   document.getElementById("staffdoc").value=$('#drsearch').jqxGrid('getcellvalue', rowindex2, "doc_no");
        	   } 
            	  
              
                
           
              $('#commenwindow').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="drsearch"></div>