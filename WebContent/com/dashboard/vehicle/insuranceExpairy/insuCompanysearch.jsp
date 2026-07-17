<%@ page import="com.dashboard.vehicle.ClsvehicleDAO" %>
<% ClsvehicleDAO cvd=new ClsvehicleDAO();%>
<script type="text/javascript">
    var invcom= '<%=cvd.searchinsuCompany() %>';
    
    
   
        $(document).ready(function () { 	
            
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'number' },
     						{name : 'inname', type: 'String'  },
                          	
                          	
                 ],
                 localdata: invcom,
                
                
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
            $("#jqxInsuranceSearch").jqxGrid(
            {
                width: '100%',
                height: 358,
                source: dataAdapter,
                columnsresize: true,
               // pageable: true,
          
                altRows: true,
                sortable: true,
                selectionmode: 'singlerow',
                

                columns: [
					{ text: 'Doc No',datafield: 'doc_no', width: '10%',hidden:true },
					{ text: 'Insurance', datafield: 'inname', width: '100%' },
					
					]
            });
            $('#jqxInsuranceSearch').on('rowdoubleclick', function (event) 
            		{ 
		            	
		            	var rowindex1 =$('#rowindex').val();
		            	// alert(rowindex1);
		                var rowindex2 = event.args.rowindex;
		                $('#insexpgrid').jqxGrid('setcellvalue', rowindex1, "invcomdoc" ,$('#jqxInsuranceSearch').jqxGrid('getcellvalue', rowindex2, "doc_no"));
		                $('#insexpgrid').jqxGrid('setcellvalue', rowindex1, "inname" ,$('#jqxInsuranceSearch').jqxGrid('getcellvalue', rowindex2, "inname"));
		                $('#invcomSearchwindow').jqxWindow('close');
		               
            		 }); 
        
        
        });
    </script>
    <div id="jqxInsuranceSearch"></div>
    
    