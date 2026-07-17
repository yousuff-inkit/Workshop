     <%@page import="com.NewSatDownload.SATdownloadDAO" %>

     <% SATdownloadDAO DAO=new SATdownloadDAO(); %>
  <script type="text/javascript">
    var srcdata= '<%=DAO.sat_plateNo()%>';
    //alert("==================data");
        $(document).ready(function () { 	
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'flname', type: 'String'  },
							{name : 'reg_no', type: 'String'  }
                 ],
                 localdata: srcdata,
                
                
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
            $("#jqxPlateNoGrid").jqxGrid(
            {
                width: '100%',
                height: 300,
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
                          
					{ text: 'Plate No',columntype: 'textbox', filtertype: 'input', datafield: 'reg_no', width: '40%',editable:false },      
					{ text: 'Vehicle Details',columntype: 'textbox', filtertype: 'input', datafield: 'flname', width: '60%',editable:false },
					
					
	              ]
            });

            $('#jqxPlateNoGrid').on('rowdoubleclick', function (event) 
            		{ 
		            	var rowindex1=event.args.rowindex;
		                document.getElementById("txttrafficpno").value= $('#jqxPlateNoGrid').jqxGrid('getcellvalue', rowindex1, "reg_no");
		        
		              $('#platenoWindow').jqxWindow('close');
            		 }); 
           
        });
    </script>
    <div id="jqxPlateNoGrid"></div>
