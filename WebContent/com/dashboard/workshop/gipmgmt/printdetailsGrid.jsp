<script type="text/javascript">

var printdata=[];  

        $(document).ready(function () { 	
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'pdata', type: 'String'},  
                        ],
                localdata: printdata,   
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#printdataGrid").jqxGrid(
            {
            	width: '100%',
                height: 100,
                columnsheight:23,
                source: dataAdapter,
                filtermode:'excel',
                filterable: true,
                selectionmode: 'singlecell',
                sortable:false,
                editable:true,
                handlekeyboardnavigation: function (event) {
            	    //var rows=$('#printdataGrid').jqxGrid('getrows');
                    var cell = $('#printdataGrid').jqxGrid('getselectedcell');
    				if (cell != undefined && cell.datafield == 'pdata' ) {    
                      var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                      if (key == 13 || key == 9) {
	                      	$("#printdataGrid").jqxGrid('addrow', null, {});	 
	                      	//$("#printdataGrid").jqxGrid('begincelledit', rows.length+1, "name");   
                      	    return true;
                      }     
                  }
              }, 
                columns: [
							{ text: '', datafield: 'pdata', width: '100%' },  
						]
            });   
            $("#printdataGrid").jqxGrid('addrow', null, {});
            $("#printdataGrid").jqxGrid('addrow', null, {});
            $("#printdataGrid").jqxGrid('addrow', null, {});
            $("#printdataGrid").on('cellendedit', function (event) {    
        	    var args = event.args;
        	    var columnDataField = event.args.datafield;
        	    var rowIndex = event.args.rowindex;
        	    var cellValue = event.args.value;
        	    var oldValue = event.args.oldvalue;         
        	    if(columnDataField=="pdata"){            
        	    	$('#printdataGrid').jqxGrid('setcellvalue', rowIndex, "pdata",cellValue);          
        	    }
        	});
        });
    </script>
    <div id="printdataGrid"></div>