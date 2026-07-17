      <%@page import="com.NewSatDownload.SATdownloadDAO" %>
       <% SATdownloadDAO DAO=new SATdownloadDAO(); %> 
  <script type="text/javascript">
    var data= '<%=DAO.sat_fleetsearch()%>';
        $(document).ready(function () { 	
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'fleet_no', type: 'String'  },
							{name : 'reg_no', type: 'String'  },
							{name : 'salik_tag', type: 'String'  }
                 ],
                 localdata: data,
                
                
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
            $("#jqxFleetGrid").jqxGrid(
            {
                width: '100%',
                height: 336,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlerow',
                showfilterrow: true,
                filterable: true,
                //pagermode: 'default',
                sortable: true,
                //Add row method
                columns: [
					{ text: 'Fleet No',columntype: 'textbox', filtertype: 'input', datafield: 'fleet_no', width: '30%' },
					{ text: 'Salik Tag',columntype: 'textbox', filtertype: 'input', datafield: 'salik_tag', width: '30%' },
					{ text: 'Reg No',columntype: 'textbox', filtertype: 'input', datafield: 'reg_no', width: '30%' }
					
	              ]
            });

            $('#jqxFleetGrid').on('rowdoubleclick', function (event) 
            		{ 
		            	var rowindex1=event.args.rowindex;
		                document.getElementById("txtsalikfleetno").value= $('#jqxFleetGrid').jqxGrid('getcellvalue', rowindex1, "fleet_no");
		                document.getElementById("txtsalikregno").value= $('#jqxFleetGrid').jqxGrid('getcellvalue', rowindex1, "reg_no");
		              $('#fleetWindow').jqxWindow('close');
            		 }); 
           
        });
    </script>
    <div id="jqxFleetGrid"></div>
