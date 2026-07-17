
<script type="text/javascript">
/* $('#frmTariffManagement select').attr('disabled', false);  */
      var datamaintenance;
        $(document).ready(function () { 	
            
        	 var columnsrenderer = function (value) {
        			return '<div style="text-align: center;margin-top: 5px;">' + value + '</div>';
        		}
            //var url="demo.txt"; 
        	var num = 0;
            var source =
            {
                datatype: "json",
                datafields: [
{name : 'srno' , type: 'string', },
	{name : 'details' , type:'number'},
	{name : 'type' , type:'number'}

                 ],
                localdata: datamaintenance,
                //url: url,
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
            $("#maintenancegrid").jqxGrid(
            {
                width: '100%',
                height: 150,
                source: dataAdapter,
                rowsheight:18,
                columnsresize: true,
                pageable: false,
                altRows: true,
                sortable: false,
                selectionmode: 'singlerow',
                //Add row method
                columns: [
{ text: 'Sr No', datafield: 'srno', width: '10%',editable:false},
{ text: 'Maintenance',  datafield: 'details',  width: '70%',editable:true,renderer: columnsrenderer},
{ text: 'Type',  datafield: 'type',  width: '20%'  ,editable:true ,renderer: columnsrenderer},

	              ]
            });
            $("#maintenancegrid").jqxGrid("addrow", null, {});
        });
            </script>
            <div id="maintenancegrid"></div>