<%@page import="com.dashboard.trafficfine.ClsTrafficfineDAO" %>
<%ClsTrafficfineDAO ctd=new ClsTrafficfineDAO(); %>

       <script type="text/javascript">
  
			 var fleetdata='<%=ctd.fleetdetails()%>';
		$(document).ready(function () { 	
        	/* var url=""; */
        	
           
           
            var source =
            {
                datatype: "json",
                datafields: [
                            
                            {name : 'fleet_no', type: 'string' },
                            {name : 'flname', type: 'string'  },
                            {name : 'reg_no', type: 'string'  }
     						
                        ],
                		
                		//  url: url1,
                 localdata: fleetdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#fleetsearch").jqxGrid(
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
							
							 
                          
                              { text: 'Fleet', datafield: 'fleet_no', width: '20%'},
                              { text: 'Name', datafield: 'flname', width: '60%' },
                              { text: 'Reg_no', datafield: 'reg_no', width: '20%' },
						
						]
            });
            
          $('#fleetsearch').on('rowdoubleclick', function (event) {
           
                var rowindex2 = event.args.rowindex;
                document.getElementById("fleet_no").value=$('#fleetsearch').jqxGrid('getcellvalue', rowindex2, "fleet_no");
           
              $('#fleetwindow').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="fleetsearch"></div>