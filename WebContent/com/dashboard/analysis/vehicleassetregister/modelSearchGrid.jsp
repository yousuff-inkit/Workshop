<%@page import="com.dashboard.analysis.vehicleassetregister.ClsVehicleAssetRegister" %>
<%ClsVehicleAssetRegister cva=new ClsVehicleAssetRegister(); %>


<script type="text/javascript">
  
       var modeldata='<%=cva.modeldetails()%>';
		$(document).ready(function () { 	
           
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'vtype', type: 'string'  },
                            {name : 'doc_no', type: 'string'  }
                            ],
                       localdata: modeldata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#modelsearch").jqxGrid(
            {
                width: '100%',
                height: 357,
                source: dataAdapter,
                columnsresize: true,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlerow',
                       
                columns: [
                              { text: 'DOC_NO', datafield: 'doc_no', width: '20%',hidden:true},
                              { text: 'Model', datafield: 'vtype', width: '100%' },
						]
            });
            
          $('#modelsearch').on('rowdoubleclick', function (event) {
           
                var rowindex2 = event.args.rowindex;
                document.getElementById("txtmodel").value=$('#modelsearch').jqxGrid('getcellvalue', rowindex2, "vtype");
                document.getElementById("txtmodelid").value=$('#modelsearch').jqxGrid('getcellvalue', rowindex2, "doc_no");
           
              $('#modelDetailsWindow').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="modelsearch"></div>