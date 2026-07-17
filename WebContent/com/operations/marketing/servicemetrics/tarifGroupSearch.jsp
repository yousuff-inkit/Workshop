<%@page import="com.operations.marketing.servicemetrics.*" %>
<%ClsServiceMetricsDAO srvdao=new ClsServiceMetricsDAO(); %>

<script type="text/javascript">
		var groupdata='<%=srvdao.getTarifGroup()%>';
		$(document).ready(function() { 
                   
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
     						{name : 'doc_no', type: 'number' }, 
     						{name : 'gname', type: 'string'   }     						
                        	],
                         localdata: groupdata,  
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#tarifGroupSearch").jqxGrid(
            {
                width: '99%',
                height: 300,
                source: dataAdapter,
                editable: false,
                showaggregates: true,
                selectionmode: 'singlerow',
                filterable:true,
                showfilterrow:true,
                //Add row method
                handlekeyboardnavigation: function (event) {
                	/* var rows = $('#jqxleasecalculator').jqxGrid('getrows');
                 	var rowlength= rows.length;
                    var cell = $('#jqxleasecalculator').jqxGrid('getselectedcell');
                    if (cell != undefined && cell.datafield == 'fifthyear' && cell.rowindex == rowlength - 1) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 9) {  
                            var commit = $("#jqxleasecalculator").jqxGrid('addrow', null, {});
                            rowlength++;                           
                        }
                    } */ 
                },
                       
                columns: [
							
							{ text: 'Doc No', datafield: 'doc_no',  width: '30%'},	
							{ text: 'Group', datafield: 'gname', width: '70%'}
						]
            });




		 $('#tarifGroupSearch').on('rowdoubleclick', function (event) 
        	{ 
			 	var args = event.args;
			    // row's bound index.
			    var boundIndex = event.args.rowindex;
			    // row's visible index.
			    var visibleIndex = event.args.visibleindex;
			    // right click.
			    var rightclick = event.args.rightclick; 
			    // original event.
			    var ev = event.args.originalEvent;		
			    
			    document.getElementById("tarifgroup").value=$('#tarifGroupSearch').jqxGrid('getcellvalue',boundIndex,'gname');
			    document.getElementById("hidtarifgroup").value=$('#tarifGroupSearch').jqxGrid('getcellvalue',boundIndex,'doc_no');
			    $('#tarifsearchwindow').jqxWindow('close');
        	});

        });
    </script>
    <div id="tarifGroupSearch"></div>
    
