<%@page import="com.dashboard.marketing.residualvaluemaster.*" %>
<%ClsResidualValueMasterDAO masterdao=new ClsResidualValueMasterDAO();
String id=request.getParameter("id")==null?"":request.getParameter("id");
String brand=request.getParameter("brand")==null?"":request.getParameter("brand");
%>
<script type="text/javascript">
var modeldata;
var id='<%=id%>';
if(id=="1"){
	modeldata='<%=masterdao.getModel(id,brand)%>';
}
else{
	modeldata=[];
}
$(document).ready(function () {
   

    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [

                  		{name : 'doc_no' , type: 'number' },
						{name : 'model', type: 'String'  }
						],
				    localdata: modeldata,
        
        
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
    
    
    $("#modelSearchGrid").jqxGrid(
    {
        width: '100%',
        height: 300,
        source: dataAdapter,
        columnsresize:true,
        selectionmode: 'singlerow',
        filterable:true,
        showfilterrow:true,
	    sortable:false,
        columns: [
               
						{ text: 'Doc No', datafield: 'doc_no', width: '30%'},
						{ text: 'Model',datafield:'model',width:'70%'}
					]

    });

	$('#modelSearchGrid').on('rowdoubleclick', function (event) 
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
		
		$('#model').val($('#modelSearchGrid').jqxGrid('getcellvalue',boundIndex,'model'));
		$('#hidmodel').val($('#modelSearchGrid').jqxGrid('getcellvalue',boundIndex,'doc_no'));
		$('#modelwindow').jqxWindow('close');
	});
	
});
</script>
<div id="modelSearchGrid"></div>