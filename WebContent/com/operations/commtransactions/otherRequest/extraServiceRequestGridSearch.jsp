<%@page import="com.operations.commtransactions.otherrequest.ClsOtherRequestDAO" %>
<% ClsOtherRequestDAO cord=new ClsOtherRequestDAO();%>
<script type="text/javascript">
        
        var service= '<%= cord.extraServiceGridSearch() %>'; 
        $(document).ready(function () { 	
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'doc_no', type: 'string' },
     						{name : 'description', type: 'string' }
                        ],
                		 localdata: service, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxExtraServiceRequestSearch").jqxGrid(
            {
                width: '100%',
                height: 350,
                source: dataAdapter,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlecell',
                
                columns: [
							{ text: 'Doc No.', datafield: 'doc_no', hidden: true, width: '10%' },
                            { text: 'Service Description', datafield: 'description', width: '100%' },
						]
            });
            
            $('#jqxExtraServiceRequestSearch').on('celldoubleclick', function (event) {
            	var rowindex1 =$('#rowindex1').val();
                var rowindex2 = event.args.rowindex;
                $('#jqxOtherRequest').jqxGrid('setcellvalue', rowindex1, "typeid" ,$('#jqxExtraServiceRequestSearch').jqxGrid('getcellvalue', rowindex2, "doc_no"));
                $('#jqxOtherRequest').jqxGrid('setcellvalue', rowindex1, "type" ,$('#jqxExtraServiceRequestSearch').jqxGrid('getcellvalue', rowindex2, "description"));
           
                var rows = $('#jqxOtherRequest').jqxGrid('getrows');
            	var rowlength= rows.length;
            	var rowindex1 = rowlength - 1;
          	    var typeId=$("#jqxOtherRequest").jqxGrid('getcellvalue', rowindex1, "typeid");
          	    if(typeof(typeId) != "undefined"){
                $("#jqxOtherRequest").jqxGrid('addrow', null, {});
          	    }
          	    
                $('#serviceWindow').jqxWindow('close'); 
            }); 
            
        });
    </script>
    <div id="jqxExtraServiceRequestSearch"></div>
 