<%@page import="com.operations.commtransactions.otherrequest.ClsOtherRequestDAO" %>
<% ClsOtherRequestDAO cord=new ClsOtherRequestDAO();%>


<script type="text/javascript">
        
        var national= '<%= cord.nationGridSearch() %>'; 
        $(document).ready(function () { 	
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
     						{name : 'nation', type: 'string' }
                        ],
                		 localdata: national, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxNationSearch").jqxGrid(
            {
                width: '100%',
                height: 350,
                source: dataAdapter,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlerow',
                
                columns: [
							{ text: 'Nation', datafield: 'nation', width: '100%' }
						]
            });
            
            $('#jqxNationSearch').on('celldoubleclick', function (event) {
            	var rowindex1 =$('#rowindex').val();
                var rowindex2 = event.args.rowindex;
                //$("#jqxDriver").jqxGrid('addrow', null, {});
                //$('#jqxDriver').jqxGrid('unselectcell', 0, 'nation1');
                //$('#jqxDriver').jqxGrid('clearselection');
                $('#jqxDriver').jqxGrid('setcellvalue', rowindex1, "nation1" ,$('#jqxNationSearch').jqxGrid('getcellvalue', rowindex2, "nation"));
               $('#nationalityWindow').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="jqxNationSearch"></div>
 