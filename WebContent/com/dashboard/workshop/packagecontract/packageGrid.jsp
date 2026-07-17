
<script type="text/javascript">
var packurl='getInitData.jsp?mode=2';
	$(document).ready(function(){
        
        var source =
        {
            datatype: "json",
            datafields: [
                      	{name : 'doc_no' , type: 'number' },
                      	{name : 'voc_no' , type: 'number' },
                      	{name : 'cldocno' , type: 'number' },
 						{name : 'refname', type: 'string'  },
                      	{name : 'packagename', type: 'string'  },
                      	{name : 'fromdate',type:'date'},
                      	{name : 'todate',type:'date'},
                      	{name : 'date',type:'date'},
                      	{name : 'remarks',type:'string'}
             ],
             url: packurl,
            
            
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



        $("#packageGrid").jqxGrid(
                {
                	width: '100%',
                    height: 500,
                    source: dataAdapter,
                    showfilterrow: true,
                    filterable: true,
                    selectionmode: 'singlerow',
                    sortable: true,
                    editable: false,
                    altrows:true,
                    //Add row method
                    columns: [
						{ text: 'Sr. No.',datafield: '',columntype:'number', width: '5%',editable:false, cellsrenderer: function (row, column, value) {
						    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						}   },      
    					{ text: 'Doc No',datafield: 'doc_no', width: '10%',hidden:true,editable:false },
    					{ text: 'Doc No',datafield: 'voc_no', width: '6%',editable:false },
    					{ text: 'Client #',datafield: 'cldocno', width: '6%',editable:false },
    					{ text: 'Date',datafield: 'date', width: '12%',cellsformat:'dd.MM.yyyy',hidden:true,editable:false },
    					{ text: 'Client Name',datafield: 'refname', width: '25%',editable:false },
    					{ text: 'Package Name',datafield: 'packagename', width: '10%' ,editable:false},
    					{ text: 'From Date',datafield: 'fromdate', width: '8%',cellsformat:'dd.MM.yyyy',editable:false },
    					{ text: 'To Date',datafield: 'todate', width: '8%',cellsformat:'dd.MM.yyyy',editable:false },
    					{ text: 'Remarks',datafield:'remarks',width: '32%',editable:false}

    	              ]
                });

    
	});
</script>
<div id="packageGrid"></div>