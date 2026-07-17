<%String contractdocno=request.getParameter("contractdocno")==null?"0":request.getParameter("contractdocno").toString();%>
<style type="text/css">
	.greenClass{
		background-color:#79FFA0;
	}
</style>
<script type="text/javascript">
let contractdocno='<%=contractdocno%>';
let utilurl='getUtilGridData.jsp?contractdocno='+contractdocno+'&mode=2';
	$(document).ready(function(){
        
        var source =
        {
            datatype: "json",
            datafields:customfields,
            url: utilurl,
            
            
            pager: function (pagenum, pagesize, oldpagenum) {
                // callback called when a page or page size is changed.
            }
        };
        
        var dataAdapter = new $.jqx.dataAdapter(source,
        		 {
            		loadError: function (xhr, status, error) {
                    //alert(error);    
                    }
	            }		
        );


		/*var cellclassname = function (row, column, value, data) {
        	if(parseInt(data.srsdocno)>0){
            	return "greenClass";
            }
        };*/
        $("#utilGrid").jqxGrid(
                {
                	width: '100%',
                    height: 300,
                    source: dataAdapter,
                    showfilterrow: true,
                    filterable: true,
                    selectionmode: 'singlerow',
                    sortable: true,
                    editable: false,
                    altrows:true,
                    columns: customcolumns
        });
	});
	
	
</script>
<div id="utilGrid"></div>