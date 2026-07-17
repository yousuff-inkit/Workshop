<%@page import="com.operations.clientrelations.client.ClsClientDAO"%>
<% ClsClientDAO DAO= new ClsClientDAO(); %>
<% String check = request.getParameter("check")==null?"0":request.getParameter("check"); %> 
<script type="text/javascript">
        
        var state= '<%= DAO.stateGridSearch(check) %>'; 
        $(document).ready(function () { 	
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
     						{name : 'state', type: 'string' }
                        ],
                		 localdata: state, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxStateSearch").jqxGrid(
            {
                width: '100%',
                height: 350,
                source: dataAdapter,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlerow',
                
                columns: [
							{ text: 'States', datafield: 'state', width: '100%' }
						]
            });
            
            $('#jqxStateSearch').on('celldoubleclick', function (event) {
            	var rowindex1 =$('#rowindex').val();
                var rowindex2 = event.args.rowindex;
                //$("#jqxDriver").jqxGrid('addrow', null, {});
                //$('#jqxDriver').jqxGrid('unselectcell', 0, 'nation1');
                //$('#jqxDriver').jqxGrid('clearselection');
                $('#jqxDriver').jqxGrid('setcellvalue', rowindex1, "issfrm" ,$('#jqxStateSearch').jqxGrid('getcellvalue', rowindex2, "state"));
               $('#stateWindow').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="jqxStateSearch"></div>
 