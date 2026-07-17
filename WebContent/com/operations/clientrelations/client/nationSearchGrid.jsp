<%@page import="com.operations.clientrelations.client.ClsClientDAO"%>
<% ClsClientDAO DAO= new ClsClientDAO(); %>
<% String check = request.getParameter("check")==null?"0":request.getParameter("check"); %>
<script type="text/javascript">
        
        var national= '<%= DAO.driverGridSearch(check) %>'; 
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
               
                $('#jqxDriver').jqxGrid('setcellvalue', rowindex1, "nation1" ,$('#jqxNationSearch').jqxGrid('getcellvalue', rowindex2, "nation"));
               
			    var rows = $('#jqxDriver').jqxGrid('getrows');
            	var rowlength= rows.length;
            	var rowindex1 = rowlength - 1;
          	    var name=$("#jqxDriver").jqxGrid('getcellvalue', rowindex1, "name");
          	    if(typeof(name) != "undefined"){
                $("#jqxDriver").jqxGrid('addrow', null, {});
          	    }
				
			    $('#nationalityWindow').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="jqxNationSearch"></div>
 