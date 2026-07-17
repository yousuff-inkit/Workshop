<%@page import="com.operations.vehicleprocurement.vehicleevaluation.ClsVehicleEvaluationDAO" %>
<% ClsVehicleEvaluationDAO cid=new ClsVehicleEvaluationDAO();%>
       <script type="text/javascript">
	    var data='<%=cid.clientDetailsSearch()%>';
	    
		$(document).ready(function () { 	
        	/* var url=""; */
        	
           
           
            var source =
            {
                datatype: "json",
                datafields: [
                            
                            {name : 'refname', type: 'string'  },
                            {name : 'cldocno', type: 'string'  }
     						
                        ],
                		
                		//  url: url1,
                 localdata: data,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#clientgridsearch").jqxGrid(
            {
                width: '100%',
                height: 357,
                source: dataAdapter,
                columnsresize: true,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlerow',
                       
                columns: [
                              { text: 'DOC NO', datafield: 'cldocno', width: '20%',hidden:true},
                              { text: 'Name', datafield: 'refname', width: '100%' },
						]
            });
            
          $('#clientgridsearch').on('rowdoubleclick', function (event) {
           
                var rowindex2 = event.args.rowindex;
                document.getElementById("txtclientname").value=$('#clientgridsearch').jqxGrid('getcellvalue', rowindex2, "refname");
                document.getElementById("txtcldocno").value=$('#clientgridsearch').jqxGrid('getcellvalue', rowindex2, "cldocno");
                
               $('#clientDetailsWindow').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="clientgridsearch"></div>