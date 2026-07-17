<%@ page import="com.dashboard.rentalagreement.lponumber.ClsmranochangeDAO" %>
<%ClsmranochangeDAO crad=new ClsmranochangeDAO(); %>
       <script type="text/javascript">
			 var clientdata='<%=crad.mranodetails()%>';
		$(document).ready(function () { 	
        	/* var url=""; */
        	
           
           
            var source =
            {
                datatype: "json",
                datafields: [
                            
                            {name : 'mrano', type: 'string'  }
                            
     						
                        ],
                		
                		//  url: url1,
                 localdata: clientdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#mranosearch").jqxGrid(
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
							
                          { text: 'SL#', sortable: false, filterable: false, editable: false,   
							    groupable: false, draggable: false, resizable: false,
							    datafield: 'sl', columntype: 'number', width: '20%',
							    cellsrenderer: function (row, column, value) {
							        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
							    }  
							  },
                          
                              { text: 'MRA NO', datafield: 'mrano', width: '80%',hidden:false}
                              //{ text: ' Sal_Name', datafield: 'sal_name', width: '100%' },
                           
						
						
	            
						]
            });
            
          $('#mranosearch').on('rowdoubleclick', function (event) {
           
                var rowindex2 = event.args.rowindex;
     
                document.getElementById("mrano").value=$('#mranosearch').jqxGrid('getcellvalue', rowindex2, "mrano");
  
                
              $('#mranowindow').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="mranosearch"></div>